Return-Path: <linux-wireless+bounces-4418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C238873072
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 09:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8501F22E95
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 08:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4B5D905;
	Wed,  6 Mar 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aIoizNsY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB95E5D72D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709713014; cv=none; b=SMWEU+2Qv8IP/XZKruoFrpWoSsmTSl/oe+MTrSKA3ukivb6ssp6QNY6qrk2ZuugDrwE0NsU1m80JUiUGN6wG5UxNC/Yd8NzpAA3EukDbrBfsAImtD8OS6csI+7ZWCYNF3M49zMUdvMJagehX04qP6RaTNL0zGqIMQdq4olYFNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709713014; c=relaxed/simple;
	bh=TGLpVD8klKJhc/Vps+sIORuT4Ns7ke6Nt//MUKnxoZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bSSdZl/dexFWpzL/CD0ND8gTKxbiwN9gHPRxZFYXjCq4y4KzEP0KOqTTIVY0s2UaEUvUPtrvb/ff1VXB1vCYzr5GFB7wb/orm8tIHsgJ5bQWj7gyYzGP8EuXQBF1sQzdfvkQAa9fuD6cWex9mH+z+RzZRu+Hg2wxc1BY08hpcIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aIoizNsY; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512b3b04995so5027607e87.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 Mar 2024 00:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709713011; x=1710317811; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egzIXxC/26zl7qojV0TXJfRYkPw4VuHflVYupD8Ab2w=;
        b=aIoizNsYYc/0PnkXULmqxy2tlxUgHSM2wzTbebH3PYWk5myEu2aVOd6Fo2BUYAD/vy
         52vJr0h6ArHKzi6atH/sUCKvdc7qsOUhuVlavV90xKWx/aty5S6BzGo6fDzYm7tMZIEo
         wTKjg5jXDcmXJmGUGBLygwYRGlORSxrRty/YSI8xgH99XPaLo0T3EjlI+k0OxG2VVsN6
         cAypKyfFLCSFEs7EttFbbORek6zYsjwrpmWSfrYhYYi39avBNG4aya+kM3WxMRWQ/bH9
         KgUjtdWgvBDF1mi/O4SItNmJpvYyA5l5bK/2e1ucqN2bJUstkH4hGlMQNBpQFMwuv9GB
         SqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709713011; x=1710317811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egzIXxC/26zl7qojV0TXJfRYkPw4VuHflVYupD8Ab2w=;
        b=d92SbkX8NM17fn/FCB9pg39fLjVsIKmb3Pw2PNRpFY1LGdw5R8LSmVLDokhSPbuJZ4
         3jEbg9afx0r3iww8oN+X662WfoYDVRnLeudVxcqrXF7cJ+OxXmWqxK4KdSWsNDx4K1YP
         ZFV6GdtTRSkzXJJMTScPc0R+HEj//yAmoDI3yMllx8UhMhTd7Dnw6qOMoc8J0gTSqXhT
         h/lw3HpE9fIb2sjovvbSslB5sd8xIL8A/PnTiDlhtSIhCz0APzYl/Z+LA8dGHd9QDvU8
         WpWKgI5w5Mkgjlb8XCDM2LJBXT0+Q+OyKf8S0RwLtDx6YqSkjuA9JF9bL3xCUNCDV8wS
         /0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWnMfC0OAr4/SyYIlHK5dxMSk5gzlQbjZoddZ9p3vFOhaXl8xuVKZHspIoEFscPxb1xEIfcBxNsJTsV1AqqPpseMd6FgYg3TSWO5o//e9k=
X-Gm-Message-State: AOJu0YzV6bFtyO3lyRCWaC+pO6BwSh6LocuB7LFOSWQqZPtDeWm/uMPd
	BJXcOBXEAea22T5D/Gib8sj4nTon/6pswL/OlU7OcwrI1ZObyGGc2NCnY5mhzac=
X-Google-Smtp-Source: AGHT+IF/WbHLHZJizYA01jmedg3v9I2+sBS9jfqgfa5vyHmKgE6kFxq47DTI/D3oMrE9VDJ/HD3gYA==
X-Received: by 2002:a19:f519:0:b0:512:9e78:998c with SMTP id j25-20020a19f519000000b005129e78998cmr2649685lfb.9.1709713011058;
        Wed, 06 Mar 2024 00:16:51 -0800 (PST)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b00512dc23bedcsm2162366lfo.99.2024.03.06.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 00:16:50 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 06 Mar 2024 10:16:46 +0200
Subject: [PATCH RFC v2 2/4] wifi: ath10k: support board-specific firmware
 overrides
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-wcn3990-firmware-path-v2-2-f89e98e71a57@linaro.org>
References: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
In-Reply-To: <20240306-wcn3990-firmware-path-v2-0-f89e98e71a57@linaro.org>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3302;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=TGLpVD8klKJhc/Vps+sIORuT4Ns7ke6Nt//MUKnxoZ4=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+oLtXyfrbvX3FPn+byzee7LOc0PTeOWvbT8dT9dTP1T3
 NruF6wGnYzGLAyMXAyyYoosPgUtU2M2JYd92DG1HmYQKxPIFAYuTgGYSOd29v9J0RrRScG+rg/s
 g37UhO46EnfCZc2OKqnwoE+dMo+uF/rf9/2SErFUS2ix8P1OKzfG9RPvHCn/87KJMS2/xCrOutr
 w+7LL/xeXih/S1mR78++b7yq31G9dZ/l9ziuWFCZbbXv55+L2nIOln41PWYVmvLrdI6ry3jh9Hb
 d4l+vSK85ep6S5/XeFrrvMUlvS9vfd5l+5mww++7Yq9v0/sV+5odPSSmH/Z6bT6RFvrAT1HwmGR
 p48kPXTu9DYpeLSRacouaACufMbM9Qa2FlUPWUvt0tr57B4MHBNV7K68flcqrVluWShS01S//c9
 jzfVNkr85pr6JsHNJp53csiuRJOMPydLk2NqvyltufwXAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Different Qualcomm platforms using WCN3990 WiFI chip use SoC-specific
firmware versions with different features. For example firmware for
SDM845 doesn't use single-chan-info-per-channel feature, while firmware
for QRB2210 / QRB4210 requires that feature. Allow board DT files to
override the subdir of the fw dir used to lookup the firmware-N.bin file
decribing corresponding WiFi firmware.

For example:

- ath10k/WCN3990/hw1.0/wlanmdsp.mbn,
  ath10k/WCN3990/hw1.0/firmware-5.bin: main firmware files, used by default

- ath10k/WCN3990/hw1.0/qcm2290/wlanmdsp.mbn,
  ath10k/WCN3990/hw1.0/qcm2290/firmware-5.bin: SoC specific firmware
    with different signature and feature bits

Note, while board files lookup uses the same function and thus it is
possible to provide board-specific board-2.bin files, this is not
required in 99% of cases as board-2.bin already contains a way to
provide board-specific data with finer granularity than DT overrides.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 11 ++++++++++-
 drivers/net/wireless/ath/ath10k/core.h |  2 ++
 drivers/net/wireless/ath/ath10k/snoc.c |  3 +++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 0032f8aa892f..ef7ce8b3f8fb 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -942,11 +942,20 @@ static const struct firmware *ath10k_fetch_fw_file(struct ath10k *ar,
 	if (dir == NULL)
 		dir = ".";
 
+	if (ar->board_name) {
+		snprintf(filename, sizeof(filename), "%s/%s/%s",
+			 dir, ar->board_name, file);
+		ret = firmware_request_nowarn(&fw, filename, ar->dev);
+		ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
+			   filename, ret);
+		if (!ret)
+			return fw;
+	}
+
 	snprintf(filename, sizeof(filename), "%s/%s", dir, file);
 	ret = firmware_request_nowarn(&fw, filename, ar->dev);
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot fw request '%s': %d\n",
 		   filename, ret);
-
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index c110d15528bd..3595c8abce02 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -1081,6 +1081,8 @@ struct ath10k {
 	 */
 	const struct ath10k_fw_components *running_fw;
 
+	const char *board_name;
+
 	const struct firmware *pre_cal_file;
 	const struct firmware *cal_file;
 
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index a1db5a973780..5de911d0255e 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1337,6 +1337,9 @@ static void ath10k_snoc_quirks_init(struct ath10k *ar)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct device *dev = &ar_snoc->dev->dev;
 
+	/* ignore errors, keep NULL if there is no property */
+	of_property_read_string(dev->of_node, "firmware-name", &ar->board_name);
+
 	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-8bit-quirk"))
 		set_bit(ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK, &ar_snoc->flags);
 }

-- 
2.39.2


