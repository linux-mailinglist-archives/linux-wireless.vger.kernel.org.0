Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077743AA573
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jun 2021 22:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbhFPUmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Jun 2021 16:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233607AbhFPUmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Jun 2021 16:42:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1DC06175F
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jun 2021 13:39:55 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o10-20020a17090aac0ab029016e92770073so2488800pjq.5
        for <linux-wireless@vger.kernel.org>; Wed, 16 Jun 2021 13:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmhdhmsA0X75weRybbZNoVh+EvQd+Iz0Fl+AidPXRmE=;
        b=Vh7QJ+xnoo0RqR0VyML2hyVWCrhNzuAsvU1JJgd7G8QEQltjCNvn+cChGunibWPm6J
         6owMLGuymcCRj8MsFtQn+PgGer4z3Er9UtFUsuNBe7FqlMxDIMoSJiMwACAOEg1ufilL
         8IcOd3EzsrnBef974H6rlM6Iq1UcxiBBF0x8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SmhdhmsA0X75weRybbZNoVh+EvQd+Iz0Fl+AidPXRmE=;
        b=LVDGNwmpjY2u66ZZt+XPl4IHVTHIKE5Qdcu21Ll6lDtpl76/ojXufSnpePTwKzIvM/
         i+CCM+w7Hl1EMgGb7jG0sFdknCsWN48pjQfqMEaaIOeM6CZSK52GdTyLtYWQgtWXbjH4
         J6INZB7sg+0UCdZuVtThiQ+haE4pTjSGUZermfaJqexlqJmRtiiUqqTQUGr3XnscvCre
         OzkTQ6b6X/51bZneciO2Ty+yrnvwHiS/EyTdc+g6IQOla1mSkFnWjDzzf8j7lKtwEWDo
         GjXd+zE58oYLwCB6NI1hzeFeMIiN4ND5y7koLlWLMUQC/K+SvAMeCI3eRWoF+z6OT1ka
         ZdvA==
X-Gm-Message-State: AOAM530WMEKY85kZxTJ9mKIesY78oj9DP7aQR+3EAw/z9iWodnSLZhHP
        SgukTnKaN5Jc2ESJsk5tPlTeBA==
X-Google-Smtp-Source: ABdhPJzrVDeH8lypdMacFxkxdycYjzThxIc72HqgLirIbDGhLTUlwbwroCrVf81eN8/yxl8nHgx/eg==
X-Received: by 2002:a17:90a:b284:: with SMTP id c4mr1722095pjr.213.1623875994939;
        Wed, 16 Jun 2021 13:39:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm7866009pjf.0.2021.06.16.13.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 13:39:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] orinoco: Avoid field-overflowing memcpy()
Date:   Wed, 16 Jun 2021 13:39:51 -0700
Message-Id: <20210616203952.1248910-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=89de090dea0239b1bd78c9c46e85fd796dd40c70; i=pw9pIO5cSvehAPXOYHpT36oPIsjxZgLBBPkjzgwo04A=; m=ULgPUYgopMLRjuXTD0/UgUsfNvLp6QV22Z7i5a71D2c=; p=8N134GX410DnBkaZCpurE9BNvmX2qXrE1f/VxCDCm1I=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmDKYZcACgkQiXL039xtwCYpqBAAhNs iU92ddJ1SHdKbx0as+XPYDkLjrDbdPDcjvyPC2KeBTMXSHBRa0hLjgR3gmd4oJrA9ekBvvmsM5yVE NfQmh9veoO7YKYRDSQ7xMZa380xYT52+y0DrJIy45ibUIpPU8Z4+17QxyTDZ4oqtTNLs63FuRJch+ DsFzi9E1qVcRrGKk/R3UbNn+K4ejXMOdMQrfoAFPKXG6NkESileQv7IV/eo4UUmYjpPhDH9kEqJW8 8bNmZ6lTUao3iWvnFvqE6UwDdojEIOnFiYtVRwnvqB0gb/m5wDjAndT/BvBROmmXMm75SdcvTeWDy tzsUtRMKsX72qOebrUwNOY+eiFUwXnjxrKjTNeOnLyV8GmoSevoHdcSIFgKTjRuv0qdZq2iZL683z /VhWjP9OZKSGq/P8hAsKd8hetXzYdHMGmCOv6stE6eGdSlHUHQNYmfgdwH+fDKmzFjtquuXvfjCix F6kGTxgdjd5lLKRuKFbiHU5Uf0lj5HMbTaiyX1E4oOj0amSlbenbYfyb72TqMj5dJa17INcVNLTGR /XKWMdZJ/hRZ9rtJjA5ShkBN9YUSP3XQx5MC4JZxIKZ+/2eIUashdw10+xek7Y4dlCACP7Xq7vo9l ENwkwBPSuoYm48jBkGTeII20I/hZ5ogLPIu/chTReK7tDmipf7NGjfh/7XWNA7c8=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring array fields.

Validate the expected key size and introduce a wrapping structure
to use as the multi-field memcpy() destination so that overflows
can be correctly detected.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/intersil/orinoco/hw.c   | 18 +++++++++++-------
 drivers/net/wireless/intersil/orinoco/hw.h   |  5 +++--
 drivers/net/wireless/intersil/orinoco/wext.c |  2 +-
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/hw.c b/drivers/net/wireless/intersil/orinoco/hw.c
index 2c7adb4be100..0aea35c9c11c 100644
--- a/drivers/net/wireless/intersil/orinoco/hw.c
+++ b/drivers/net/wireless/intersil/orinoco/hw.c
@@ -988,15 +988,18 @@ int __orinoco_hw_setup_enc(struct orinoco_private *priv)
  * tsc must be NULL or up to 8 bytes
  */
 int __orinoco_hw_set_tkip_key(struct orinoco_private *priv, int key_idx,
-			      int set_tx, const u8 *key, const u8 *rsc,
-			      size_t rsc_len, const u8 *tsc, size_t tsc_len)
+			      int set_tx, const u8 *key, size_t key_len,
+			      const u8 *rsc, size_t rsc_len,
+			      const u8 *tsc, size_t tsc_len)
 {
 	struct {
 		__le16 idx;
 		u8 rsc[ORINOCO_SEQ_LEN];
-		u8 key[TKIP_KEYLEN];
-		u8 tx_mic[MIC_KEYLEN];
-		u8 rx_mic[MIC_KEYLEN];
+		struct {
+			u8 key[TKIP_KEYLEN];
+			u8 tx_mic[MIC_KEYLEN];
+			u8 rx_mic[MIC_KEYLEN];
+		} tkip;
 		u8 tsc[ORINOCO_SEQ_LEN];
 	} __packed buf;
 	struct hermes *hw = &priv->hw;
@@ -1011,8 +1014,9 @@ int __orinoco_hw_set_tkip_key(struct orinoco_private *priv, int key_idx,
 		key_idx |= 0x8000;
 
 	buf.idx = cpu_to_le16(key_idx);
-	memcpy(buf.key, key,
-	       sizeof(buf.key) + sizeof(buf.tx_mic) + sizeof(buf.rx_mic));
+	if (key_len != sizeof(buf.tkip))
+		return -EINVAL;
+	memcpy(&buf.tkip, key, sizeof(buf.tkip));
 
 	if (rsc_len > sizeof(buf.rsc))
 		rsc_len = sizeof(buf.rsc);
diff --git a/drivers/net/wireless/intersil/orinoco/hw.h b/drivers/net/wireless/intersil/orinoco/hw.h
index 466d1ede76f1..da5804dbdf34 100644
--- a/drivers/net/wireless/intersil/orinoco/hw.h
+++ b/drivers/net/wireless/intersil/orinoco/hw.h
@@ -38,8 +38,9 @@ int __orinoco_hw_set_wap(struct orinoco_private *priv);
 int __orinoco_hw_setup_wepkeys(struct orinoco_private *priv);
 int __orinoco_hw_setup_enc(struct orinoco_private *priv);
 int __orinoco_hw_set_tkip_key(struct orinoco_private *priv, int key_idx,
-			      int set_tx, const u8 *key, const u8 *rsc,
-			      size_t rsc_len, const u8 *tsc, size_t tsc_len);
+			      int set_tx, const u8 *key, size_t key_len,
+			      const u8 *rsc, size_t rsc_len,
+			      const u8 *tsc, size_t tsc_len);
 int orinoco_clear_tkip_key(struct orinoco_private *priv, int key_idx);
 int __orinoco_hw_set_multicast_list(struct orinoco_private *priv,
 				    struct net_device *dev,
diff --git a/drivers/net/wireless/intersil/orinoco/wext.c b/drivers/net/wireless/intersil/orinoco/wext.c
index 7b6c4ae8ddb3..4a01260027bc 100644
--- a/drivers/net/wireless/intersil/orinoco/wext.c
+++ b/drivers/net/wireless/intersil/orinoco/wext.c
@@ -791,7 +791,7 @@ static int orinoco_ioctl_set_encodeext(struct net_device *dev,
 
 			err = __orinoco_hw_set_tkip_key(priv, idx,
 				 ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY,
-				 priv->keys[idx].key,
+				 priv->keys[idx].key, priv->keys[idx].key_len,
 				 tkip_iv, ORINOCO_SEQ_LEN, NULL, 0);
 			if (err)
 				printk(KERN_ERR "%s: Error %d setting TKIP key"
-- 
2.25.1

