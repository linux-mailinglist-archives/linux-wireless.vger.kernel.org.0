Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0A047D64
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFQInp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 04:43:45 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45436 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfFQInp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 04:43:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so8907836wre.12
        for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2019 01:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tm9I8joZj3DtpZNyzaSmkPCuBjAPR7mVgbFSLszXQG8=;
        b=rqrStsbcjK2wqBpOn/nGjuvXvPeAKlZN0/DIkQbGa5UxSQWMhbXz81feez9XCSXiIQ
         tMpsLU5T6108426E4Cz+7fpoRMOZuU0wM9MKNrZ+15+gFUxUoPUG0YLxT+94MczDknUN
         mX/aY4mp8Iz8N7+zCg8JsGQKh7wdEUksx5y9dDP73Etlink+kcljZGgKutYSmFFnGsyb
         ADfbl6C10DLmcrEwagBiKYZkHXtSWF509TERbDpN/LFUtt74TkESx9ihaiCFX4sizY8R
         2LbUqVT0IvtWkYkB8KqDVw5cGR7LqCbcK7WSYZ50eWlRYcR0uBHVHDlL5MuLYIcQYLHA
         jQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tm9I8joZj3DtpZNyzaSmkPCuBjAPR7mVgbFSLszXQG8=;
        b=Lovz66nZrU0HGxk3jElid5mz6R48LK6PEUSL59hKJTVZgc/HEp1ishh7aeOo25Lgfz
         Txxv8mp72wcSBQsDM1TSexwu63a3ZuTVW6ihfFkV+sajP1TAmcY2041Eco39xFr6RROH
         O8sYNrZeyU71089d3eeh1okG2xyDeHi+bG5pvQKxVh+HEtI3Ct274IZCJXApCK+kPLmp
         jz/tWtm76OoYU7bhFESqUKgFzJb5MT1khsHcGOfI6DApDm4hZMV5FglkxdxxpXfyEris
         Q+7zvTs1bryCDeAxL7M3en1y8wZQ1PU80n546fbO61pFoD5Bk5Rvjv7Q4tjXVlxtcOkY
         oS1g==
X-Gm-Message-State: APjAAAXLSQMfCmxXdTTdiY0GfSKKvRaAjKMR/WnvNgnthl3ZFagWY6X1
        HCVhjuGdcIfUGvm++vqFvUOwl1/MCPc=
X-Google-Smtp-Source: APXvYqyngCRmqcgSvbfQi4rIY/h59IXGVgjQcg94VcOd36K6HH40rdQmn9W5kzjTU8vLH1Sbb+J0AA==
X-Received: by 2002:a5d:5745:: with SMTP id q5mr20142892wrw.75.1560761022223;
        Mon, 17 Jun 2019 01:43:42 -0700 (PDT)
Received: from localhost.localdomain (91-167-84-221.subs.proxad.net. [91.167.84.221])
        by smtp.gmail.com with ESMTPSA id u13sm7922348wrq.62.2019.06.17.01.43.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 01:43:41 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-wireless@vger.kernel.org
Cc:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        ebiggers@kernel.org, kvalo@codeaurora.org,
        johannes@sipsolutions.net, linux@rainbow-software.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2] wireless: airo: switch to skcipher interface
Date:   Mon, 17 Jun 2019 10:43:38 +0200
Message-Id: <20190617084338.24918-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The AIRO driver applies a ctr(aes) on a buffer of considerable size
(2400 bytes), and instead of invoking the crypto API to handle this
in its entirety, it open codes the counter manipulation and invokes
the AES block cipher directly.

Let's fix this, by switching to the sync skcipher API instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
v2: - fix Kconfig dependencies
    - zero the output buffer and use it as input instead of the zero page

 drivers/net/wireless/cisco/Kconfig |  2 +
 drivers/net/wireless/cisco/airo.c  | 57 ++++++++++----------
 2 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/cisco/Kconfig b/drivers/net/wireless/cisco/Kconfig
index 7329830ed7cc..01e173ede894 100644
--- a/drivers/net/wireless/cisco/Kconfig
+++ b/drivers/net/wireless/cisco/Kconfig
@@ -17,6 +17,7 @@ config AIRO
 	depends on CFG80211 && ISA_DMA_API && (PCI || BROKEN)
 	select WIRELESS_EXT
 	select CRYPTO
+	select CRYPTO_BLKCIPHER
 	select WEXT_SPY
 	select WEXT_PRIV
 	---help---
@@ -40,6 +41,7 @@ config AIRO_CS
 	select WEXT_PRIV
 	select CRYPTO
 	select CRYPTO_AES
+	select CRYPTO_CTR
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet PCMCIA
 	  802.11 wireless cards.  This driver is the same as the Aironet
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 3f5a14112c6b..9342ffbe1e81 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -49,6 +49,9 @@
 #include <linux/kthread.h>
 #include <linux/freezer.h>
 
+#include <crypto/aes.h>
+#include <crypto/skcipher.h>
+
 #include <net/cfg80211.h>
 #include <net/iw_handler.h>
 
@@ -951,7 +954,7 @@ typedef struct {
 } mic_statistics;
 
 typedef struct {
-	u32 coeff[((EMMH32_MSGLEN_MAX)+3)>>2];
+	__be32 coeff[((EMMH32_MSGLEN_MAX)+3)>>2];
 	u64 accum;	// accumulated mic, reduced to u32 in final()
 	int position;	// current position (byte offset) in message
 	union {
@@ -1216,7 +1219,7 @@ struct airo_info {
 	struct iw_spy_data	spy_data;
 	struct iw_public_data	wireless_data;
 	/* MIC stuff */
-	struct crypto_cipher	*tfm;
+	struct crypto_sync_skcipher	*tfm;
 	mic_module		mod[2];
 	mic_statistics		micstats;
 	HostRxDesc rxfids[MPI_MAX_FIDS]; // rx/tx/config MPI350 descriptors
@@ -1291,14 +1294,14 @@ static int flashrestart(struct airo_info *ai,struct net_device *dev);
 static int RxSeqValid (struct airo_info *ai,miccntx *context,int mcast,u32 micSeq);
 static void MoveWindow(miccntx *context, u32 micSeq);
 static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen,
-			   struct crypto_cipher *tfm);
+			   struct crypto_sync_skcipher *tfm);
 static void emmh32_init(emmh32_context *context);
 static void emmh32_update(emmh32_context *context, u8 *pOctets, int len);
 static void emmh32_final(emmh32_context *context, u8 digest[4]);
 static int flashpchar(struct airo_info *ai,int byte,int dwelltime);
 
 static void age_mic_context(miccntx *cur, miccntx *old, u8 *key, int key_len,
-			    struct crypto_cipher *tfm)
+			    struct crypto_sync_skcipher *tfm)
 {
 	/* If the current MIC context is valid and its key is the same as
 	 * the MIC register, there's nothing to do.
@@ -1359,7 +1362,7 @@ static int micsetup(struct airo_info *ai) {
 	int i;
 
 	if (ai->tfm == NULL)
-		ai->tfm = crypto_alloc_cipher("aes", 0, 0);
+		ai->tfm = crypto_alloc_sync_skcipher("ctr(aes)", 0, 0);
 
         if (IS_ERR(ai->tfm)) {
                 airo_print_err(ai->dev->name, "failed to load transform for AES");
@@ -1624,37 +1627,31 @@ static void MoveWindow(miccntx *context, u32 micSeq)
 
 /* mic accumulate */
 #define MIC_ACCUM(val)	\
-	context->accum += (u64)(val) * context->coeff[coeff_position++];
-
-static unsigned char aes_counter[16];
+	context->accum += (u64)(val) * be32_to_cpu(context->coeff[coeff_position++]);
 
 /* expand the key to fill the MMH coefficient array */
 static void emmh32_setseed(emmh32_context *context, u8 *pkey, int keylen,
-			   struct crypto_cipher *tfm)
+			   struct crypto_sync_skcipher *tfm)
 {
   /* take the keying material, expand if necessary, truncate at 16-bytes */
   /* run through AES counter mode to generate context->coeff[] */
   
-	int i,j;
-	u32 counter;
-	u8 *cipher, plain[16];
-
-	crypto_cipher_setkey(tfm, pkey, 16);
-	counter = 0;
-	for (i = 0; i < ARRAY_SIZE(context->coeff); ) {
-		aes_counter[15] = (u8)(counter >> 0);
-		aes_counter[14] = (u8)(counter >> 8);
-		aes_counter[13] = (u8)(counter >> 16);
-		aes_counter[12] = (u8)(counter >> 24);
-		counter++;
-		memcpy (plain, aes_counter, 16);
-		crypto_cipher_encrypt_one(tfm, plain, plain);
-		cipher = plain;
-		for (j = 0; (j < 16) && (i < ARRAY_SIZE(context->coeff)); ) {
-			context->coeff[i++] = ntohl(*(__be32 *)&cipher[j]);
-			j += 4;
-		}
-	}
+	SYNC_SKCIPHER_REQUEST_ON_STACK(req, tfm);
+	struct scatterlist sg;
+	u8 iv[AES_BLOCK_SIZE] = {};
+	int ret;
+
+	crypto_sync_skcipher_setkey(tfm, pkey, 16);
+
+	memset(context->coeff, 0, sizeof(context->coeff));
+	sg_init_one(&sg, context->coeff, sizeof(context->coeff));
+
+	skcipher_request_set_sync_tfm(req, tfm);
+	skcipher_request_set_callback(req, 0, NULL, NULL);
+	skcipher_request_set_crypt(req, &sg, &sg, sizeof(context->coeff), iv);
+
+	ret = crypto_skcipher_encrypt(req);
+	WARN_ON_ONCE(ret);
 }
 
 /* prepare for calculation of a new mic */
@@ -2415,7 +2412,7 @@ void stop_airo_card( struct net_device *dev, int freeres )
 				ai->shared, ai->shared_dma);
 		}
         }
-	crypto_free_cipher(ai->tfm);
+	crypto_free_sync_skcipher(ai->tfm);
 	del_airo_dev(ai);
 	free_netdev( dev );
 }
-- 
2.20.1

