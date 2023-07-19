Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EE75905D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jul 2023 10:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjGSIeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jul 2023 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbjGSIeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jul 2023 04:34:13 -0400
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912201724
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jul 2023 01:34:10 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
        by forward100a.mail.yandex.net (Yandex) with ESMTP id D1DFC46CD6;
        Wed, 19 Jul 2023 11:34:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 6YcNkx9sH8c0-UwppAyBM;
        Wed, 19 Jul 2023 11:34:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1689755647;
        bh=S2FTAdXoYXIJm4NAhpkrPeM7VvWHe4QL8spKCmWETeM=;
        h=Message-ID:Date:Cc:Subject:To:From;
        b=X9hC2aYD/kuccmj48WWg75mZpntgadkv3EuZ/ceOOUi+hvmIH9+N4cm3nzmac7uLc
         HHcqYEUwq0WzO1GB13uhRA+AnbzTEwD75x8npHOZ9lOlZX46/PhfGUtaX7hxbf5i4L
         g9ajRm8x9mTKse7w+bPvIWlHJ+oxWmtoO3A+doFg=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: brcmsmac: remove unused data type
Date:   Wed, 19 Jul 2023 11:31:55 +0300
Message-ID: <20230719083232.158177-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused 'struct gpioh_item'. It seems it was so since
commit 5b435de0d786 ("net: wireless: add brcm80211 drivers").

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 .../net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h    | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
index 2d08c155c23b..90b6e3982d2c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/aiutils.h
@@ -145,14 +145,6 @@ struct si_pub {
 
 struct pci_dev;
 
-struct gpioh_item {
-	void *arg;
-	bool level;
-	void (*handler) (u32 stat, void *arg);
-	u32 event;
-	struct gpioh_item *next;
-};
-
 /* misc si info needed by some of the routines */
 struct si_info {
 	struct si_pub pub;	/* back plane public state (must be first) */
-- 
2.41.0

