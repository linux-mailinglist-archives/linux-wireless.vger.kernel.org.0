Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E2F1813A8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 09:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgCKIrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 04:47:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:55898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbgCKIrV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 04:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 486ECAF68;
        Wed, 11 Mar 2020 08:47:19 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        b43-dev@lists.infradead.org
Subject: [PATCH 5/7] b43legacy: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 09:47:11 +0100
Message-Id: <20200311084713.18220-6-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200311084713.18220-1-tiwai@suse.de>
References: <20200311084713.18220-1-tiwai@suse.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: b43-dev@lists.infradead.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/net/wireless/broadcom/b43legacy/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 082aab8353b8..fa133dfb2ecb 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -54,7 +54,7 @@ struct b43legacy_dfs_file * fops_to_dfs_file(struct b43legacy_wldev *dev,
 #define fappend(fmt, x...)	\
 	do {							\
 		if (bufsize - count)				\
-			count += snprintf(buf + count,		\
+			count += scnprintf(buf + count,		\
 					  bufsize - count,	\
 					  fmt , ##x);		\
 		else						\
-- 
2.16.4

