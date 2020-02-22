Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EADF8168F1B
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2020 14:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgBVN1h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Feb 2020 08:27:37 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:36803 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbgBVN1h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Feb 2020 08:27:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582378056; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=nb9/8W2YjFYWjNwCsyVWAjad0xesyLCLtCKuitI24/0=; b=cKUV5zVwzyhnZt+htzvZMTb0bYLekO1xoLHZL384F9vbe+oF//W+E/iZNzqiXeKTJbNqzScx
 zH3XV/QvY2n5c60lg24lddLqnVis17ypY+xkHzUA3wQjeBOP5iq26AUCou/hWsTNh/0bqwKz
 QPhMiMbOkjyZuOnrusTZRlZQgcw=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e512c34.7ffa0e204e30-smtp-out-n02;
 Sat, 22 Feb 2020 13:27:16 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1088AC4479D; Sat, 22 Feb 2020 13:27:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (176-93-35-56.bb.dnainternet.fi [176.93.35.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EC5DC433A2;
        Sat, 22 Feb 2020 13:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EC5DC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 4/7] mac80211: Update BIP to support Beacon frames
Date:   Sat, 22 Feb 2020 15:25:45 +0200
Message-Id: <20200222132548.20835-4-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222132548.20835-1-jouni@codeaurora.org>
References: <20200222132548.20835-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When BIP is used to protect Beacon frames, the Timestamp field is masked
to zero. Otherwise, the BIP processing is identical to the way it was
already used with group-addressed Robust Management frames.

Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 net/mac80211/aes_cmac.c | 21 +++++++++++++++++++--
 net/mac80211/aes_gmac.c | 24 ++++++++++++++++++------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/aes_cmac.c b/net/mac80211/aes_cmac.c
index 57748cab0e28..b31f1021ad9c 100644
--- a/net/mac80211/aes_cmac.c
+++ b/net/mac80211/aes_cmac.c
@@ -26,12 +26,20 @@ void ieee80211_aes_cmac(struct crypto_shash *tfm, const u8 *aad,
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
 	u8 out[AES_BLOCK_SIZE];
+	const __le16 *fc;
 
 	desc->tfm = tfm;
 
 	crypto_shash_init(desc);
 	crypto_shash_update(desc, aad, AAD_LEN);
-	crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+	fc = (const __le16 *)aad;
+	if (ieee80211_is_beacon(*fc)) {
+		/* mask Timestamp field to zero */
+		crypto_shash_update(desc, zero, 8);
+		crypto_shash_update(desc, data + 8, data_len - 8 - CMAC_TLEN);
+	} else {
+		crypto_shash_update(desc, data, data_len - CMAC_TLEN);
+	}
 	crypto_shash_finup(desc, zero, CMAC_TLEN, out);
 
 	memcpy(mic, out, CMAC_TLEN);
@@ -41,12 +49,21 @@ void ieee80211_aes_cmac_256(struct crypto_shash *tfm, const u8 *aad,
 			    const u8 *data, size_t data_len, u8 *mic)
 {
 	SHASH_DESC_ON_STACK(desc, tfm);
+	const __le16 *fc;
 
 	desc->tfm = tfm;
 
 	crypto_shash_init(desc);
 	crypto_shash_update(desc, aad, AAD_LEN);
-	crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+	fc = (const __le16 *)aad;
+	if (ieee80211_is_beacon(*fc)) {
+		/* mask Timestamp field to zero */
+		crypto_shash_update(desc, zero, 8);
+		crypto_shash_update(desc, data + 8,
+				    data_len - 8 - CMAC_TLEN_256);
+	} else {
+		crypto_shash_update(desc, data, data_len - CMAC_TLEN_256);
+	}
 	crypto_shash_finup(desc, zero, CMAC_TLEN_256, mic);
 }
 
diff --git a/net/mac80211/aes_gmac.c b/net/mac80211/aes_gmac.c
index 363ad1c1dc0c..16ba09cb5def 100644
--- a/net/mac80211/aes_gmac.c
+++ b/net/mac80211/aes_gmac.c
@@ -17,10 +17,11 @@
 int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
 		       const u8 *data, size_t data_len, u8 *mic)
 {
-	struct scatterlist sg[4];
+	struct scatterlist sg[5];
 	u8 *zero, *__aad, iv[AES_BLOCK_SIZE];
 	struct aead_request *aead_req;
 	int reqsize = sizeof(*aead_req) + crypto_aead_reqsize(tfm);
+	const __le16 *fc;
 
 	if (data_len < GMAC_MIC_LEN)
 		return -EINVAL;
@@ -33,11 +34,22 @@ int ieee80211_aes_gmac(struct crypto_aead *tfm, const u8 *aad, u8 *nonce,
 	__aad = zero + GMAC_MIC_LEN;
 	memcpy(__aad, aad, GMAC_AAD_LEN);
 
-	sg_init_table(sg, 4);
-	sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
-	sg_set_buf(&sg[1], data, data_len - GMAC_MIC_LEN);
-	sg_set_buf(&sg[2], zero, GMAC_MIC_LEN);
-	sg_set_buf(&sg[3], mic, GMAC_MIC_LEN);
+	fc = (const __le16 *)aad;
+	if (ieee80211_is_beacon(*fc)) {
+		/* mask Timestamp field to zero */
+		sg_init_table(sg, 5);
+		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
+		sg_set_buf(&sg[1], zero, 8);
+		sg_set_buf(&sg[2], data + 8, data_len - 8 - GMAC_MIC_LEN);
+		sg_set_buf(&sg[3], zero, GMAC_MIC_LEN);
+		sg_set_buf(&sg[4], mic, GMAC_MIC_LEN);
+	} else {
+		sg_init_table(sg, 4);
+		sg_set_buf(&sg[0], __aad, GMAC_AAD_LEN);
+		sg_set_buf(&sg[1], data, data_len - GMAC_MIC_LEN);
+		sg_set_buf(&sg[2], zero, GMAC_MIC_LEN);
+		sg_set_buf(&sg[3], mic, GMAC_MIC_LEN);
+	}
 
 	memcpy(iv, nonce, GMAC_NONCE_LEN);
 	memset(iv + GMAC_NONCE_LEN, 0, sizeof(iv) - GMAC_NONCE_LEN);
-- 
2.20.1
