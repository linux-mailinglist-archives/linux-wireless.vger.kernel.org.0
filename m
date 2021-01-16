Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90CB2F8D64
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbhAPMx2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 07:53:28 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36247 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbhAPMx2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 07:53:28 -0500
Received: from legolas.fritz.box (unknown [84.174.243.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 46AD258008E;
        Sat, 16 Jan 2021 13:52:04 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 3/4] rfkill: support hard block reason in python code
Date:   Sat, 16 Jan 2021 13:51:45 +0100
Message-Id: <20210116125146.31932-4-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
References: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 rfkill.py | 60 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/rfkill.py b/rfkill.py
index 983671f..57d21b0 100755
--- a/rfkill.py
+++ b/rfkill.py
@@ -28,6 +28,9 @@ import os
  _OP_CHANGE,
  _OP_CHANGE_ALL) = list(range(4))
 
+HARD_BLOCK_SIGNAL = 1 << 0
+HARD_BLOCK_NOT_OWNER = 1 << 1
+
 _type_names = {
     TYPE_ALL: "all",
     TYPE_WLAN: "Wireless LAN",
@@ -40,10 +43,14 @@ _type_names = {
     TYPE_NFC: "NFC",
 }
 
-# idx, type, op, soft, hard
-_event_struct = '@IBBBB'
+# idx, type, op, soft, hard, hard_block_reasons
+_event_struct = '@IBBBBB'
 _event_sz = struct.calcsize(_event_struct)
 
+# idx, type, op, soft, hard
+_event_struct_old = '@IBBBB'
+_event_old_sz = struct.calcsize(_event_struct_old)
+
 class RFKillException(Exception):
     pass
 
@@ -63,7 +70,7 @@ class RFKill(object):
     @property
     def type(self):
         if not self._type:
-            for r, s, h in RFKill.list():
+            for r, s, h, hbr in RFKill.list():
                 if r.idx == self.idx:
                     self._type = r._type
                     break
@@ -76,7 +83,7 @@ class RFKill(object):
     @property
     def blocked(self):
         l = RFKill.list()
-        for r, s, h in l:
+        for r, s, h, hbr in l:
             if r.idx == self.idx:
                 return (s, h)
         raise RFKillException("RFKill instance no longer exists")
@@ -97,48 +104,60 @@ class RFKill(object):
         return self.blocked[1]
 
     def block(self):
-        rfk = open('/dev/rfkill', 'wb')
-        s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 1, 0)
+        rfk = open('/dev/rfkill', 'wb', 0)
+        s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 1, 0, 0)
         rfk.write(s)
         rfk.close()
 
     def unblock(self):
-        rfk = open('/dev/rfkill', 'wb')
-        s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 0, 0)
+        rfk = open('/dev/rfkill', 'wb', 0)
+        s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 0, 0, 0)
         rfk.write(s)
         rfk.close()
 
     @classmethod
     def block_all(cls, t=TYPE_ALL):
-        rfk = open('/dev/rfkill', 'wb')
+        rfk = open('/dev/rfkill', 'wb', 0)
         print(rfk)
-        s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 1, 0)
+        s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 1, 0, 0)
         rfk.write(s)
         rfk.close()
 
     @classmethod
     def unblock_all(cls, t=TYPE_ALL):
-        rfk = open('/dev/rfkill', 'wb')
-        s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 0, 0)
+        rfk = open('/dev/rfkill', 'wb', 0)
+        s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 0, 0, 0)
         rfk.write(s)
         rfk.close()
 
     @classmethod
     def list(cls):
         res = []
-        rfk = open('/dev/rfkill', 'rb')
+        rfk = open('/dev/rfkill', 'rb', 0)
+
         fd = rfk.fileno()
         flgs = fcntl.fcntl(fd, fcntl.F_GETFL)
         fcntl.fcntl(fd, fcntl.F_SETFL, flgs | os.O_NONBLOCK)
         while True:
             try:
                 d = rfk.read(_event_sz)
-                _idx, _t, _op, _s, _h = struct.unpack(_event_struct, d)
+                read_len = len(d)
+                assert read_len in [_event_sz, _event_old_sz]
+
+                # init additional fields of newer formats to 'None' here
+                _hbr = None
+
+                # hard block reason included ?
+                if read_len >= _event_sz:
+                    _idx, _t, _op, _s, _h, _hbr = struct.unpack(_event_struct, d)
+                else:
+                    _idx, _t, _op, _s, _h = struct.unpack(_event_struct_old, d)
+
                 if _op != _OP_ADD:
                     continue
                 r = RFKill(_idx)
                 r._type = _t
-                res.append((r, _s, _h))
+                res.append((r, _s, _h, _hbr))
             except IOError:
                 break
             except TypeError:
@@ -146,7 +165,16 @@ class RFKill(object):
         return res
 
 if __name__ == "__main__":
-    for r, s, h in RFKill.list():
+    for r, s, h, hbr in RFKill.list():
         print("%d: %s: %s" % (r.idx, r.name, r.type_name))
         print("\tSoft blocked: %s" % ("yes" if s else "no"))
         print("\tHard blocked: %s" % ("yes" if h else "no"))
+        if hbr != None:
+            print("\tHard block reasons: ", end="")
+            if hbr == 0:
+                print("[NONE]", end="")
+            if hbr & HARD_BLOCK_NOT_OWNER:
+                print("[NOT_OWNER]", end="")
+            if hbr & HARD_BLOCK_SIGNAL:
+                print("[SIGNAL]", end="")
+            print()
-- 
2.30.0

