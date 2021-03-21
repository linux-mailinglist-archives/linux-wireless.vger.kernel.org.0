Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0833432FA
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Mar 2021 15:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCUOYM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 21 Mar 2021 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbhCUOXo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 21 Mar 2021 10:23:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1BC061574
        for <linux-wireless@vger.kernel.org>; Sun, 21 Mar 2021 07:23:44 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lNyzT-001N7J-9W; Sun, 21 Mar 2021 15:23:39 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, bup-list@googlegroups.com
Subject: [PATCH] bup: cat-file: fix error print
Date:   Sun, 21 Mar 2021 15:23:33 +0100
Message-Id: <20210321142333.16326-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some variable renaming and bytes issues, if a target cannot
be found in cat-file.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 lib/cmd/cat-file-cmd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/cmd/cat-file-cmd.py b/lib/cmd/cat-file-cmd.py
index 388ca03abcbe..ebe27ce43a0a 100755
--- a/lib/cmd/cat-file-cmd.py
+++ b/lib/cmd/cat-file-cmd.py
@@ -56,7 +56,7 @@ resolved = vfs.resolve(repo, target, follow=False)
 leaf_name, leaf_item = resolved[-1]
 if not leaf_item:
     log('error: cannot access %r in %r\n'
-        % ('/'.join(name for name, item in resolved), path))
+        % (b'/'.join(name for name, item in resolved), target))
     sys.exit(1)
 
 mode = vfs.item_mode(leaf_item)
-- 
2.30.2

