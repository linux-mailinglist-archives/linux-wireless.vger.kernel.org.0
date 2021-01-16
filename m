Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040B12F8D62
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Jan 2021 13:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhAPMwp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jan 2021 07:52:45 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:36235 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbhAPMwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jan 2021 07:52:45 -0500
Received: from legolas.fritz.box (unknown [84.174.243.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0862F58008C;
        Sat, 16 Jan 2021 13:52:04 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/4] rfkill.py: migrate to python3
Date:   Sat, 16 Jan 2021 13:51:43 +0100
Message-Id: <20210116125146.31932-2-markus.theil@tu-ilmenau.de>
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
 rfkill.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/rfkill.py b/rfkill.py
index 57dcddc..983671f 100755
--- a/rfkill.py
+++ b/rfkill.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 #
 # rfkill control code
 #
@@ -21,12 +21,12 @@ import os
  TYPE_WWAN,
  TYPE_GPS,
  TYPE_FM,
- TYPE_NFC) = range(9)
+ TYPE_NFC) = list(range(9))
 
 (_OP_ADD,
  _OP_DEL,
  _OP_CHANGE,
- _OP_CHANGE_ALL) = range(4)
+ _OP_CHANGE_ALL) = list(range(4))
 
 _type_names = {
     TYPE_ALL: "all",
@@ -84,7 +84,7 @@ class RFKill(object):
     @property
     def soft_blocked(self):
         return self.blocked[0]
-        
+
     @soft_blocked.setter
     def soft_blocked(self, block):
         if block:
@@ -97,28 +97,28 @@ class RFKill(object):
         return self.blocked[1]
 
     def block(self):
-        rfk = open('/dev/rfkill', 'w')
+        rfk = open('/dev/rfkill', 'wb')
         s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 1, 0)
         rfk.write(s)
         rfk.close()
 
     def unblock(self):
-        rfk = open('/dev/rfkill', 'w')
+        rfk = open('/dev/rfkill', 'wb')
         s = struct.pack(_event_struct, self.idx, TYPE_ALL, _OP_CHANGE, 0, 0)
         rfk.write(s)
         rfk.close()
 
     @classmethod
     def block_all(cls, t=TYPE_ALL):
-        rfk = open('/dev/rfkill', 'w')
-        print rfk
+        rfk = open('/dev/rfkill', 'wb')
+        print(rfk)
         s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 1, 0)
         rfk.write(s)
         rfk.close()
 
     @classmethod
     def unblock_all(cls, t=TYPE_ALL):
-        rfk = open('/dev/rfkill', 'w')
+        rfk = open('/dev/rfkill', 'wb')
         s = struct.pack(_event_struct, 0, t, _OP_CHANGE_ALL, 0, 0)
         rfk.write(s)
         rfk.close()
@@ -126,7 +126,7 @@ class RFKill(object):
     @classmethod
     def list(cls):
         res = []
-        rfk = open('/dev/rfkill', 'r')
+        rfk = open('/dev/rfkill', 'rb')
         fd = rfk.fileno()
         flgs = fcntl.fcntl(fd, fcntl.F_GETFL)
         fcntl.fcntl(fd, fcntl.F_SETFL, flgs | os.O_NONBLOCK)
@@ -141,10 +141,12 @@ class RFKill(object):
                 res.append((r, _s, _h))
             except IOError:
                 break
+            except TypeError:
+                break
         return res
 
 if __name__ == "__main__":
     for r, s, h in RFKill.list():
-        print "%d: %s: %s" % (r.idx, r.name, r.type_name)
-        print "\tSoft blocked: %s" % ("yes" if s else "no")
-        print "\tHard blocked: %s" % ("yes" if h else "no")
+        print("%d: %s: %s" % (r.idx, r.name, r.type_name))
+        print("\tSoft blocked: %s" % ("yes" if s else "no"))
+        print("\tHard blocked: %s" % ("yes" if h else "no"))
-- 
2.30.0

