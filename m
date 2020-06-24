Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1820A20966A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 00:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgFXWfK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 18:35:10 -0400
Received: from s2.neomailbox.net ([5.148.176.60]:34813 "EHLO s2.neomailbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgFXWfK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 18:35:10 -0400
X-Greylist: delayed 1298 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2020 18:35:10 EDT
From:   Antonio Quartulli <a@unstable.cc>
To:     "Luis R . Rodriguez" <mcgrof@do-not-panic.com>
Cc:     linux-wireless@vger.kernel.org, Antonio Quartulli <a@unstable.cc>,
        Kelvin Chui <kelvin.chui@kaiwoo.ai>
Subject: [PATCH] crda: don't memset ctx before releasing members
Date:   Thu, 25 Jun 2020 00:12:21 +0200
Message-Id: <20200624221221.16419-1-a@unstable.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

reglib_free_regdb_ctx() is currently memsetting the passed context to
all 0s and then attempts to unmap/release its members.

Obviouly this can't work, because after the memset() all ctx's members
will not be useful anymore. Attempting to release them may actually lead
to crashes. Even if no crash should happen, this operation will still
result in memleaks.

Fix this issue by removing the memset() at all, thus leaving the members
intact so that they can be properly released.

Signed-off-by: Kelvin Chui <kelvin.chui@kaiwoo.ai>
Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 reglib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reglib.c b/reglib.c
index 4dee401..9a56a6d 100644
--- a/reglib.c
+++ b/reglib.c
@@ -287,7 +287,6 @@ void reglib_free_regdb_ctx(const struct reglib_regdb_ctx *regdb_ctx)
 
 	ctx = (struct reglib_regdb_ctx *) regdb_ctx;
 
-	memset(ctx, 0, sizeof(struct reglib_regdb_ctx));
 	close(ctx->fd);
 	munmap(ctx->db, ctx->real_dblen);
 	free(ctx);
-- 
2.27.0

