Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2378D2C9
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 06:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjH3EeZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 00:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbjH3EeQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 00:34:16 -0400
Received: from forward102c.mail.yandex.net (forward102c.mail.yandex.net [178.154.239.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C812CC5
        for <linux-wireless@vger.kernel.org>; Tue, 29 Aug 2023 21:34:12 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:150a:0:640:1aa5:0])
        by forward102c.mail.yandex.net (Yandex) with ESMTP id D66266000E;
        Wed, 30 Aug 2023 07:34:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8YI2M8JWr4Y0-u5qs6Dzv;
        Wed, 30 Aug 2023 07:34:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1693370049;
        bh=eBXAzidueqrcJZBPkwFMYseK86j5GrQncGbLP/Nh4IA=;
        h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=jiVmtG1niRtOp2tq8UHCoZBPCfKTdOwB1mj+2FqxGxcfX5OJLKrzHTJpzuwubt8HQ
         k4KYTQoR0kzR4koKajaTcp272Kjs4jEdBj2V2DxPha8W1gtD3/Y6Imc53bE2USGxbb
         ctH6H0An2xTjCD9UMPVTljuExKJfUoIC+Hf3DTB0=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From:   Dmitry Antipov <dmantipov@yandex.ru>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/2] wifi: cfg80211: avoid strlen() in cfg80211_michael_mic_failure()
Date:   Wed, 30 Aug 2023 07:33:18 +0300
Message-ID: <20230830043346.28303-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830043346.28303-1-dmantipov@yandex.ru>
References: <20230830043346.28303-1-dmantipov@yandex.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 'sprintf()' returns the number of characters emitted, an extra
call to 'strlen()' in 'cfg80211_michael_mic_failure()' may be dropped.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/wireless/mlme.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index 775cac4d6100..c6adaf835abd 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -239,12 +239,11 @@ void cfg80211_michael_mic_failure(struct net_device *dev, const u8 *addr,
 	char *buf = kmalloc(128, gfp);
 
 	if (buf) {
-		sprintf(buf, "MLME-MICHAELMICFAILURE.indication("
-			"keyid=%d %scast addr=%pM)", key_id,
+		memset(&wrqu, 0, sizeof(wrqu));
+		wrqu.data.length = sprintf(buf, "MLME-MICHAELMICFAILURE."
+			"indication(keyid=%d %scast addr=%pM)", key_id,
 			key_type == NL80211_KEYTYPE_GROUP ? "broad" : "uni",
 			addr);
-		memset(&wrqu, 0, sizeof(wrqu));
-		wrqu.data.length = strlen(buf);
 		wireless_send_event(dev, IWEVCUSTOM, &wrqu, buf);
 		kfree(buf);
 	}
-- 
2.41.0

