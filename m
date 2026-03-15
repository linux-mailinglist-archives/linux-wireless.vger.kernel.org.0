Return-Path: <linux-wireless+bounces-33255-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCzUIAPttmlRKQEAu9opvQ
	(envelope-from <linux-wireless+bounces-33255-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:31:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E322D291C5E
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 18:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D559308C611
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Mar 2026 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C537756B;
	Sun, 15 Mar 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaftvYRw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A658377EC5
	for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595684; cv=none; b=kgD35TdkFWLP8L2SSMDRe8FfhBiM3eZOiXsfHQjR95GWbBS31E5il/VEDBrxbY0uR5dOkOhI1UZLTUT0wJ+quKgFhfU0DwE/lOaHCRI8jynVxWDkr/SI5mzluhBLOUqwtFLEfEeXLXr2LQ2EqX8Sgshes2UiWzA0iRfHDOsiDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595684; c=relaxed/simple;
	bh=QyIuFOJZx926p9XhEzOqnlY0Tjj4EaWSbZ1NmZeyRpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJuR2CyBOj4SADhXsdBsie67GDgu0+S+1GM3NurCbQYN9HNYI7H3Ej0QYLgaVO45oNFLK/IS2/gZdr5C/vcvEVMUPpTVUPdFxYPV8Iiri1EaiYGGViTNpwZqrRc/ywJYnBUp/zs5edp09WauRDKOlC/V+8p1tpHXvcfYHOeARBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaftvYRw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so34430445e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 15 Mar 2026 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595681; x=1774200481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIEg7cppvNlK1uJeRyCMqJFg9lbXRMhPBqnGtbbFM64=;
        b=KaftvYRwTkpwOyTOTR15hx72rP9U1+qsLRZwEpP0661vgIcqr3lg7EBVrhFxsnDwAW
         Ft3pAkQ+cP+XZtoiuCfViQGC+f/xf+2KTA2ggxz5v58oydL3P7jTYsWtexLlQIABT61c
         +p5UefG2DSeCjHyaUBPTYrFFFWrTXfWlct6SnQ3KuaemwET/LzDtFMb0ppqS5oxjCSmo
         LrMikbM9yaN+4a8pBiuoJda4Anh/iYvhBtUjFlKJmXk6hZiSGZ6nCOf7rZg0dTSv7H9e
         zm4zmFnWaJ6yHQcjovyZ8OTAGLBPYHXB89ydhmt6rdNd0tBkYjoIWYYI86Pv3sCq5YoN
         Ru+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595681; x=1774200481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YIEg7cppvNlK1uJeRyCMqJFg9lbXRMhPBqnGtbbFM64=;
        b=cGDTq/iv5+k6KDxofVk7nx9enxC8+Z51o9XhHVi3CoBIgvP/P5w/N05UeeXyezlVmB
         kvV87ZSHs3HeS43nevGEILFSSztYNkAo3qXnO1i2UxlyNOvzM6T/OEk/bIvSVt9nBokb
         oC+5hzWioWChuIyEIWshjOnQcptQzynKjDI8+veQJTjknxtLDpF/bwSXLKdPZ55LUjWH
         ss6/1WMArrX0jgLYmhOEDv1XbUFxHjmBUDeoJlV7JQf1uYKCEfaWZ6LbapPDeCGS8q0x
         8RhS/ZXUklISpJsfCSULa6u3CKNGvrHbaInb70C4ilFTJjQGbUtAB3awkY/wC+Elw0/H
         lRpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSt3dJYbWcT8vI4QMXdGi56M8xjiZiL4VVUaPZaoAh2ke24HPlFjx/vKVvnLlLTDZr2FGYGFbaPq0KyD1R1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqZPcyGsYtayqmiWeFhLigtlnLoipnSpTbVmU4tfWzH2DFxsZv
	LcuwUtnXsZtZ3G9iW0tHNOXgagGgtx0eFM6ZiH3S4K2cREmoMP9/sB2X
X-Gm-Gg: ATEYQzzClzetsO81EDuq8Fb1U3ONM2T+HA4mWUDzB0lnW6jlp+H1BmnzNzwmL13uFOO
	1igaqQotXcJmDmn/MPzFs0UfLndC3bqXtJa/AegsT4vTY8kUrGnDGoIhP3ILxRdGY9jF+uY8bix
	Qjo+hcFWlcfCTGqgoxHGeUeUy5oEPMWy7JPgs6kGqPyzAlS5oeQvQhZ4LipDFwMhb5B0YleJ9if
	I87cr2CRgDoCEH6xWWaKTSK10sPp1aBiU68h1EO5dTsKZNim40AsmPkzZCO8z1PVRmoiA911Fm2
	7ZH0PJJKGhptAIlhJaPQ8Rd4ucxOIvuD4xGyDxqyxscuBLEQ/mxdGzMQ2o47sMiiYptzxUoaqPH
	PZbUMVVP02W2sen1XoIzg2rtONQOxyG+UZJPmwlDcQqfctnhF4wGV/OQ4LVYBhLjihbuCADpSfh
	tP1MhOJaXgtO/YjBCsKhcsQiXptQ36jRW+Gqc=
X-Received: by 2002:a05:600c:64cf:b0:477:561f:6fc8 with SMTP id 5b1f17b1804b1-485566cf81fmr167182995e9.5.1773595681386;
        Sun, 15 Mar 2026 10:28:01 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:28:00 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 3/3] mmc: sdhci-esdhc-imx: consolidate imx25/35 data and add Kingston CID
Date: Sun, 15 Mar 2026 18:26:40 +0100
Message-ID: <20260315172746.270734-4-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,pengutronix.de,kernel.org,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-33255-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adriangarciacasado42@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E322D291C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Consolidate esdhc_imx25 and esdhc_imx35 soc data into a single shared
struct since they share the same flags. This reduces redundancy. Also
add the CID_MANFID_KINGSTON definition to quirks.h for centralized
management.

Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
---
 drivers/mmc/core/quirks.h          |  4 ++++
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index c417ed34c..d736bb4be 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -15,6 +15,10 @@
 
 #include "card.h"
 
+#ifndef CID_MANFID_KINGSTON
+#define CID_MANFID_KINGSTON	0x70
+#endif
+
 static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
 	/*
 	 * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a7a5df673..9cfa26722 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -256,11 +256,7 @@ struct esdhc_soc_data {
 	u32 quirks;
 };
 
-static const struct esdhc_soc_data esdhc_imx25_data = {
-	.flags = ESDHC_FLAG_ERR004536,
-};
-
-static const struct esdhc_soc_data esdhc_imx35_data = {
+static const struct esdhc_soc_data esdhc_imx25_35_data = {
 	.flags = ESDHC_FLAG_ERR004536,
 };
 
@@ -391,8 +387,8 @@ struct pltfm_imx_data {
 };
 
 static const struct of_device_id imx_esdhc_dt_ids[] = {
-	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_data, },
-	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx35_data, },
+	{ .compatible = "fsl,imx25-esdhc", .data = &esdhc_imx25_35_data, },
+	{ .compatible = "fsl,imx35-esdhc", .data = &esdhc_imx25_35_data, },
 	{ .compatible = "fsl,imx51-esdhc", .data = &esdhc_imx51_data, },
 	{ .compatible = "fsl,imx53-esdhc", .data = &esdhc_imx53_data, },
 	{ .compatible = "fsl,imx6sx-usdhc", .data = &usdhc_imx6sx_data, },
@@ -414,7 +410,7 @@ MODULE_DEVICE_TABLE(of, imx_esdhc_dt_ids);
 
 static inline int is_imx25_esdhc(struct pltfm_imx_data *data)
 {
-	return data->socdata == &esdhc_imx25_data;
+	return data->socdata == &esdhc_imx25_35_data;
 }
 
 static inline int is_imx53_esdhc(struct pltfm_imx_data *data)
-- 
2.47.3


