BREWPATH = $(shell brew --prefix)

CC = g++
CFLAGS = -g -std=c++11 -Wno-deprecated-register -Wno-deprecated-declarations -DGL_DO_NOT_WARN_IF_MULTI_GL_VERSION_HEADERS_INCLUDED
INCFLAGS = -I./include -I$(BREWPATH)/include
LDFLAGS = -framework GLUT -framework OpenGL -L$(BREWPATH)/lib -lfreeimage

RM = /bin/rm -f
all: SceneViewer
SceneViewer: main.o Shader.o Camera.o Obj.o RTObj.o Scene.o RTScene.o Ray.o Image.o shaders/lighting.frag shaders/projective.vert
	$(CC) -o SceneViewer main.o Shader.o Camera.o Obj.o Scene.o Image.o RTObj.o RTScene.o Ray.o $(LDFLAGS)
main.o: main.cpp
	$(CC) $(CFLAGS) $(INCFLAGS) -c main.cpp 
Shader.o: src/Shader.cpp
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Shader.cpp
Camera.o: src/Camera.cpp include/Camera.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Camera.cpp
Obj.o: src/Obj.cpp include/Obj.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Obj.cpp
RTObj.o: src/RTObj.cpp include/RTObj.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/RTObj.cpp
Scene.o: src/Scene.cpp src/Scene.inl include/Scene.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Scene.cpp
RTScene.o: src/RTScene.cpp src/RTScene.inl include/RTScene.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/RTScene.cpp
Ray.o: src/Ray.cpp include/Ray.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Ray.cpp
Image.o: src/Image.cpp include/Image.h
	$(CC) $(CFLAGS) $(INCFLAGS) -c src/Image.cpp
clean: 
	$(RM) *.o SceneViewer

 
