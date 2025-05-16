Return-Path: <linux-wireless+bounces-23091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F236ABA30E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FB1BC6557
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A627814F;
	Fri, 16 May 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBY2wHpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A631A0BF1;
	Fri, 16 May 2025 18:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420872; cv=none; b=a3lbl2LUXIMqWStRus2TiwevYwUqHSqKBkUa/UiyY/DeciGfBUt8EAnc3xM3a4hZbbVzzdFXpcEbtC9jcbl8EsEJkWA3XBLWGCOhPX8IXefnTgc1TE67lLW9BcM/2m7AaWoOxqlVuRq4DpkBncdFY9O0LSrdQmewATQfxFafl4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420872; c=relaxed/simple;
	bh=j/psQkdzMVMF/cO2seHId0bpPEQPneH5fdBDVA9IMM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MX1JCfCc7skhzRU+rJMbUUiDE/vK6XqpKrTLgEMQcUZxsNBGmCXpNUD5SclAFfYmcmS5gSBnoHOHqbiMdXOJVWS27JYclj26nR0kRcmnVOJafwP+zkcLCHpJ9b51JGTRvdowisvumvoxhOblTGM4j8K5PEEmLMT3ECz2oqORTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBY2wHpK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43d0618746bso19596035e9.2;
        Fri, 16 May 2025 11:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747420868; x=1748025668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2s3pifaOo54XXjlPvrpcaeSY+7yLzjRWQvRopUWszpY=;
        b=gBY2wHpKEwo7DA5qVE3w9HjDrmMrmLSRMP16fT7D/eDTspWs0rmedzRzk+l71TVwui
         tmayQBoiceEAUexZgrU2JsC6v1SJgojQeEd4RUUobfxS1PNljziMbkkE9dlPQJ29ImXT
         NqxzREdtjhufoE+p+ZHJinNADvY3PSbBGGM/eY1HbJrThPV2kMEmz831WYdXcPaImTyJ
         amQNWvtUaQURH8C7Pz1GyodLfjv/igtbux4O7r2GVVvIESqIi6W2om+BcNwqkRMnT5LT
         CFpCfXdvHfkXhNKR1IRDrn/kfs1TbyUEDp8ldwnh5gTX7MTG4yn5Dqx+Jd/Z3Yz3aCVz
         G9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420868; x=1748025668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2s3pifaOo54XXjlPvrpcaeSY+7yLzjRWQvRopUWszpY=;
        b=VbMTboxQ0x3NH5EMQTIlBOGN1Dj+Bppv4dBU4jlrPDwEHzSfPnxkCsDZ3/UTsdXCtZ
         tZeL/H3V9c50LBCgdJnmOBXIFksJqnVKz3JuVOaaIKppYpdLMuEXQOjKKV4kCdxJ6qvO
         Ok3HinWzmTAcD7/3K0j4+N5c7AZEpskdmi1TED7xYbTwE39U4fygFp1D/wfxDvVcroq5
         vgeFQlplfM5HdpW3FSAhG1rQhcBuD8QEjIdruu73S9OanTOJnXIvsQTYfiZOavCJThQn
         dDYZD5LVZr3RMN3bdpiapVHBUwE4Z6I5BDQxbJXIj9SS1rk2K9npq1vShSwQFGlSjDwG
         CqDg==
X-Forwarded-Encrypted: i=1; AJvYcCU1LBqwUo2O2qGCCYHAVeq806IA3c666pE+PEr89MyqPmze/3EhqMzm7yHtx7fTH9LuVQh3+YylDnzR3KA=@vger.kernel.org, AJvYcCWS5vdrmILLtlPvoNx3SOKEs1/XIfHB9rtmgVZfpVIngNta1cy5PIly1kMlGGI0ISzeFEIAo+hz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Nv5uMFoE/BOu9OOhD3oJOakGa7PJLziVnJmP5hdO0xTpEMDi
	YG/HDzVaT2Se9L8f3ifwF5JJryJQYDnUjjhg+/I1sXPb+IOzudPMNfeju31VFw==
X-Gm-Gg: ASbGncuZtb262WANFtxDPyc1n/My5zxpdACVVKnUk1owFIoSrRHoKuu4Cnu8wkSBr+p
	Oy+WcravI1ur0gtprwd0VyU4FpgOgJf5T5bRdSdXarX0Bh8RNIjuw+c+0zktnKDIzJdgIFgQy6b
	68T/19d3TmYOTVHqu20MylznOChYPfzw7LBnjMzYFPmDoUKlckVuVMlN+L+CxUbWOhV3ZgK5NAb
	xhBQyMI4Zn1qhQP+X3p/VdHrPj+Fm7/OGYaP3RsurHRRHF2Sf3P0ti2BvH+JMTDCjpQse+MVT5T
	3v4/7GU4SyassNqn6FbjvyhEA0KW7lWv3ELdDDa4FQ5E4LaPUz/2CN92qCmirMsCXE9NkHy8L76
	NQo0t9hbGqf/gxHJQJ7D+NEuY6/Wq60e6UtHdJRRNlTnBWdoO8X5MWTI=
X-Google-Smtp-Source: AGHT+IE7CbxsQRDRTjq+jdXKJjuEnw8oymFGz6wOWQjIpQ0orwEOHaYfnrlH8jcpnWI/RbTSz5dmVw==
X-Received: by 2002:a05:600c:698c:b0:43c:eeee:b70a with SMTP id 5b1f17b1804b1-442ff029b68mr28706455e9.22.1747420868246;
        Fri, 16 May 2025 11:41:08 -0700 (PDT)
Received: from shift.daheim (p200300d5ff34db0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff34:db00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-443000ee99csm28950405e9.31.2025.05.16.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:41:07 -0700 (PDT)
Received: from chuck by shift.daheim with local (Exim 4.98.2)
	(envelope-from <chuck@shift.daheim>)
	id 1uFzzX-00000000CR3-0Zip;
	Fri, 16 May 2025 20:41:07 +0200
From: Christian Lamparter <chunkeey@gmail.com>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Morris <rtm@csail.mit.edu>
Cc: Kalle Valo <kvalo@kernel.org>,
	"John W . Linville" <linville@tuxdriver.com>,
	stable@kernel.org,
	Robert Morris <rtm@mit.edu>
Subject: [PATCH net v1] wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()
Date: Fri, 16 May 2025 20:41:06 +0200
Message-ID: <20250516184107.47794-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <28782.1747258414@localhost>
References: <28782.1747258414@localhost>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Robert Morris reported:

|If a malicious USB device pretends to be an Intersil p54 wifi
|interface and generates an eeprom_readback message with a large
|eeprom->v1.len, p54_rx_eeprom_readback() will copy data from the
|message beyond the end of priv->eeprom.
|
|static void p54_rx_eeprom_readback(struct p54_common *priv,
|                                   struct sk_buff *skb)
|{
|        struct p54_hdr *hdr = (struct p54_hdr *) skb->data;
|        struct p54_eeprom_lm86 *eeprom = (struct p54_eeprom_lm86 *) hdr->data;
|
|        if (priv->fw_var >= 0x509) {
|                memcpy(priv->eeprom, eeprom->v2.data,
|                       le16_to_cpu(eeprom->v2.len));
|        } else {
|                memcpy(priv->eeprom, eeprom->v1.data,
|                       le16_to_cpu(eeprom->v1.len));
|        }
| [...]

The eeprom->v{1,2}.len is set by the driver in p54_download_eeprom().
The device is supposed to provide the same length back to the driver.
But yes, it's possible (like shown in the report) to alter the value
to something that causes a crash/panic due to overrun.

This patch addresses the issue by adding the size to the common device
context, so p54_rx_eeprom_readback no longer relies on possibly tampered
values... That said, it also checks if the "firmware" altered the value
and no longer copies them.

The one, small saving grace is: Before the driver tries to read the eeprom,
it needs to upload >a< firmware. the vendor firmware has a proprietary
license and as a reason, it is not present on most distributions by
default.

Cc: <stable@kernel.org>
Reported-by: Robert Morris <rtm@mit.edu>
Closes: https://lore.kernel.org/linux-wireless/28782.1747258414@localhost/
Fixes: 7cb770729ba8 ("p54: move eeprom code into common library")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

---

First of all: Congratulation and Thank you! This is a great report.
the reprod. is the icing on the cake...
I guess you found more issues with p54, right?

From what I see, the first patch that introduced the "unchecked" buffer
overrun has a date of "Sep 1 22:48:51 2008 +0200"

I don't know who currently handles these patches, maybe netdev?
---
 drivers/net/wireless/intersil/p54/fwio.c |  2 ++
 drivers/net/wireless/intersil/p54/p54.h  |  1 +
 drivers/net/wireless/intersil/p54/txrx.c | 13 +++++++++----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index 772084a9bd8d..3baf8ab01e22 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -231,6 +231,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 
 	mutex_lock(&priv->eeprom_mutex);
 	priv->eeprom = buf;
+	priv->eeprom_slice_size = len;
 	eeprom_hdr = skb_put(skb, eeprom_hdr_size + len);
 
 	if (priv->fw_var < 0x509) {
@@ -253,6 +254,7 @@ int p54_download_eeprom(struct p54_common *priv, void *buf,
 		ret = -EBUSY;
 	}
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	mutex_unlock(&priv->eeprom_mutex);
 	return ret;
 }
diff --git a/drivers/net/wireless/intersil/p54/p54.h b/drivers/net/wireless/intersil/p54/p54.h
index 522656de4159..aeb5e40cc5ef 100644
--- a/drivers/net/wireless/intersil/p54/p54.h
+++ b/drivers/net/wireless/intersil/p54/p54.h
@@ -258,6 +258,7 @@ struct p54_common {
 
 	/* eeprom handling */
 	void *eeprom;
+	size_t eeprom_slice_size;
 	struct completion eeprom_comp;
 	struct mutex eeprom_mutex;
 };
diff --git a/drivers/net/wireless/intersil/p54/txrx.c b/drivers/net/wireless/intersil/p54/txrx.c
index 8414aa208655..2deb1bb54f24 100644
--- a/drivers/net/wireless/intersil/p54/txrx.c
+++ b/drivers/net/wireless/intersil/p54/txrx.c
@@ -496,14 +496,19 @@ static void p54_rx_eeprom_readback(struct p54_common *priv,
 		return ;
 
 	if (priv->fw_var >= 0x509) {
-		memcpy(priv->eeprom, eeprom->v2.data,
-		       le16_to_cpu(eeprom->v2.len));
+		if (le16_to_cpu(eeprom->v2.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v2.data, priv->eeprom_slice_size);
 	} else {
-		memcpy(priv->eeprom, eeprom->v1.data,
-		       le16_to_cpu(eeprom->v1.len));
+		if (le16_to_cpu(eeprom->v1.len) != priv->eeprom_slice_size)
+			return;
+
+		memcpy(priv->eeprom, eeprom->v1.data, priv->eeprom_slice_size);
 	}
 
 	priv->eeprom = NULL;
+	priv->eeprom_slice_size = 0;
 	tmp = p54_find_and_unlink_skb(priv, hdr->req_id);
 	dev_kfree_skb_any(tmp);
 	complete(&priv->eeprom_comp);
-- 
2.49.0


