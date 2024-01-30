Return-Path: <linux-wireless+bounces-2833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1084299D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E529928CC63
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 16:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135F012BF1F;
	Tue, 30 Jan 2024 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zy5IPdhR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6B1272C2
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632725; cv=none; b=QQrA7bWWuvPSZKMN4064bNw7yiWy8OpZZdi3cib/t2JfdCbMxMyXRZ3TM/LPtIlVbDewYDGbOfGRSjjiGdFCvgVzOIS5xKut9NeCAmjSFWEf/lNVtyOGqSto4mKqvAa5/majm0Nol8xXSM526LKr37yp/Be8Qjr6/1IhK8dzkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632725; c=relaxed/simple;
	bh=rdxq3kzQEhLOfWHhqAgfGJbUetMIKn7+i69RkVlVAY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qkw4VUHKaB7HrU7K9fQkgJb/xzpkaTNZuBxTpffR7n2su5EesddhpK9E9uuxlE9il+rxMq4Q6bAxpUYj3N0XZx6MYiBLDy3qsW/+8dwncPqyB8Jxmr2Bj4CXDEgZAhCF3o431oCLOrCJMpNyciDzVK81lL0TYV9V9D7oDL9htXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zy5IPdhR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf2adac1ccso47726011fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706632721; x=1707237521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/RbgXIH7jZgIzaMTsE8Y3pn5TFM6nzfZC6329MmCVQ=;
        b=Zy5IPdhRDZICm9YJXR4roeBULMaWPEsrjfHhuyWj8lymemQ2KMscu0E7eSLdQ0tepL
         CmKB4Ruef6MCOkEQECRLTONyxOu2A6reD1g641OPIOr7eWRbn20ETu85IMtLZzi+r4DE
         S6kjZQcAuwGo+qz1uoiqsWGZvErwMfSYf4/b7mDPttAHgO+wVAP/ix/S0EKDOPVvjvuJ
         jY99qW0aOc5HSJE5UBiECRvtU7DsuSraokEahG3wH0/AODs4UUV4k8Dw7UBCTSR/kxG4
         ARSNqjHCfKctswcKprVVcUnhGjTJ025HmIicO27VPUvnks0J1JG9lP75pjVuZKJl3vt7
         eAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632721; x=1707237521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/RbgXIH7jZgIzaMTsE8Y3pn5TFM6nzfZC6329MmCVQ=;
        b=i5rDAkH2HWghc/bNt2HaLewFdW7p1hTwBEy+RL0t1BKyWSOyPiNv4cezjnuWKOT2En
         ERJAE6mHSBQUaRQ35CLQcWNPWrBNEEQXTSKN3+a5OYH/eRd54xtQE3Pwc8Y0GkNGJKQb
         6lOzMiimVGo41l5IA/1Owjrc66BK2XoDJb7bLRAxOAb2FH4ufrtix+uHxONXf3mimVy9
         Ivx8UXSSoYoPFVcE+dwpTUqXNsNhMhaCL+Ea3EMIkbuUFPwK/UNOaPbtHgqpFSk+D0eG
         bjKT4M96dZIf2wOZAZbvrtB75ToImu+nDnIw3WYyn3EkbFUBJDXY4sIyyHqneTL0vHO6
         AXVw==
X-Gm-Message-State: AOJu0Yz2pa39AeIMPFYJUStzFyMaFt8xNapWjP2PTeoHbQKNpHms1lsy
	mwtIfEdO8ZUmeiSyAQp8t0GzwKubA/mtxxKD4uKnZJK5KditYXMsUwCvbHZcpp4=
X-Google-Smtp-Source: AGHT+IG261dJ+YIiSXDFgXe9ipFZDbCmvk5RZgUbf1p2N4AKA8i3wYhY6tloelwh/2nKIlNlabQNdA==
X-Received: by 2002:a2e:a408:0:b0:2cf:15be:4627 with SMTP id p8-20020a2ea408000000b002cf15be4627mr6384945ljn.31.1706632721589;
        Tue, 30 Jan 2024 08:38:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWqQrqBe9fFrCO1vsRri3T+qGGLPYwbL24U/95Pz2MTwMg3Pk5aXL/gNfEsSWD8jaoP4C0kV+H+YOfImvUVpEXXpG9B/1KHYHgVqs5YCLdGY7sDGGapQZyEIidoPsXZSJ7/hUSPQcCflGmjH2pjZJeVuyEFSm4QzvldawhrEieVE1BvSXkri9pjXGgE2Xgw0sqt9T+/tqIM4k/vQYQtMufMy6Co++YLglJSLgMhQ0eAfjPhcGrImohkJcwvUdx0gkmE+qIbK/1JUXveQnF07SjV8WeErX+TIFhm/YD8liK96tyuzkCO6FZH+MuBVS+VhWQgDzqm2qKY8x4KVRI8qSj9fZOiDeXENQLRGvKk25eqKI2PLpfxKNXdZq1XEoPCOdjINdBuMUOd/D9Z7+r2sw12X5LWWIfUoQEimSl5Wd1NhjrkVSnLFtaDTLgKO5oM7nCAX+Ht5XKowkx/gJRaSHeRq0Vft+nhYDVzMtvY10f+QL1iInw9RMzgjgKM2U5wn5SYg9061RI=
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id y8-20020a2e9788000000b002d05e8bd84fsm219639lji.31.2024.01.30.08.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 08:38:41 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jan 2024 18:38:38 +0200
Subject: [PATCH RFC 2/4] wifi: ath10k: support board-specific firmware
 overrides
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-wcn3990-firmware-path-v1-2-826b93202964@linaro.org>
References: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
In-Reply-To: <20240130-wcn3990-firmware-path-v1-0-826b93202964@linaro.org>
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2717;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=rdxq3kzQEhLOfWHhqAgfGJbUetMIKn7+i69RkVlVAY4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluSYO+AhHsWAY9CBHp4h8pfrlmKQrGQDoTWgzO
 QB1J6V5cbKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZbkmDgAKCRCLPIo+Aiko
 1SAKCACXFs4ArwGJ7NsvblRePaE8Zh9zsKGSckmQEyhwo9D2fctcaKPBJ/kncYSQcSn3zxDqwv7
 oTGFJBAERwNbVCrmLxPjCjKhgXJImyf6F7ltH95KpvNIq80qL4eu5F4MBQITmBHnhmYWMQ9qXfA
 fH7BaL0QXuzCbXIKZGv+zEpt0ZYEd76FLxQFJgIaQe7m8RUGsmE6UqaXtbK/Bn99ANd9/UfzqFk
 YKjsci4FENLlKPyheqgK5OSvyLTDdi++NG+llGtL6hW7k6dgEId36n5JxYet+IfbSGr0Q5iSOK1
 lCFTbvbpHKTdJdmTxbFFR9HybaryJp9UtERAW6yz/p2cN7Ib
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Different Qualcomm platforms using WCN3990 WiFI chip use SoC-specific
firmware versions with different features. For example firmware for
SDM845 doesn't use single-chan-info-per-channel feature, while firmware
for QRB2210 / QRB4210 requires that feature. Allow board DT files to
override the subdir of the fw dir used to lookup the firmware-N.bin file
decribing corresponding WiFi firmware.

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
index a1db5a973780..747de30e06ca 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1337,6 +1337,9 @@ static void ath10k_snoc_quirks_init(struct ath10k *ar)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct device *dev = &ar_snoc->dev->dev;
 
+	/* ignore errors, default to empty string */
+	of_property_read_string(dev->of_node, "firmware-name", &ar->board_name);
+
 	if (of_property_read_bool(dev->of_node, "qcom,snoc-host-cap-8bit-quirk"))
 		set_bit(ATH10K_SNOC_FLAG_8BIT_HOST_CAP_QUIRK, &ar_snoc->flags);
 }

-- 
2.39.2


