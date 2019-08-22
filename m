Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF4259A06E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfHVTqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 15:46:45 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40534 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728782AbfHVTqp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 15:46:45 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0t2h-0007Wo-3h; Thu, 22 Aug 2019 21:46:43 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] regdb: fix compatibility with python2
Date:   Thu, 22 Aug 2019 21:46:27 +0200
Message-Id: <20190822194628.4910-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Various changes in the commit mentioned below broke
compatibility with python2. Restore it in a way that
makes it worth with both versions.

Fixes: f3c4969c2485 ("wireless-regdb: make scripts compatible with Python 3")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 db2bin.py  | 2 +-
 db2fw.py   | 2 +-
 dbparse.py | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/db2bin.py b/db2bin.py
index 28cd7d2ed373..29ae3136d5cb 100755
--- a/db2bin.py
+++ b/db2bin.py
@@ -118,7 +118,7 @@ reg_country_ptr.set()
 for alpha2 in countrynames:
     coll = countries[alpha2]
     # struct regdb_file_reg_country
-    output.write(struct.pack('>BBxBI', alpha2[0], alpha2[1], coll.dfs_region, reg_rules_collections[coll.permissions]))
+    output.write(struct.pack('>2sxBI', alpha2, coll.dfs_region, reg_rules_collections[coll.permissions]))
 
 
 if len(sys.argv) > 3:
diff --git a/db2fw.py b/db2fw.py
index 0c0f030c0c63..3affd5a8e0fa 100755
--- a/db2fw.py
+++ b/db2fw.py
@@ -85,7 +85,7 @@ countrynames = list(countries)
 countrynames.sort()
 for alpha2 in countrynames:
     coll = countries[alpha2]
-    output.write(struct.pack('>BB', alpha2[0], alpha2[1]))
+    output.write(struct.pack('>2s', alpha2))
     country_ptrs[alpha2] = PTR(output)
 output.write(b'\x00' * 4)
 
diff --git a/dbparse.py b/dbparse.py
index 993f757b2cb1..5f7e08200fa0 100755
--- a/dbparse.py
+++ b/dbparse.py
@@ -1,6 +1,5 @@
 #!/usr/bin/env python
 
-from builtins import bytes
 from functools import total_ordering
 import sys, math
 from math import ceil, log
@@ -359,7 +358,7 @@ class DBParser(object):
         for cname in cnames:
             if len(cname) != 2:
                 self._warn("country '%s' not alpha2" % cname)
-            cname = bytes(cname, 'ascii')
+            cname = cname.encode('ascii')
             if not cname in self._countries:
                 self._countries[cname] = Country(dfs_region, comments=self._comments)
             self._current_countries[cname] = self._countries[cname]
-- 
2.20.1

