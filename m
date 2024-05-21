Return-Path: <linux-wireless+bounces-7890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCB98CAB31
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA9C1C21170
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241AD768EE;
	Tue, 21 May 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lu3JTEfa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B2C7603F
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284738; cv=none; b=NNnnsmRabu1jed7iuiAX6GdUxTAa7njIs2a2cYloMto3oj0zOKaiaNT4nbY2Hq3XpgmzvESffp9FTHcPSQ6ZoG2D1saiXpJqIXfrGPAP6jBAr3r+oUiFajkpNGyfHaqaWX4NqCBmAmWBld03+KkQ0ctVFL3wTk8bNqzb9F9FzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284738; c=relaxed/simple;
	bh=lOURPTyf/MozPD5HW7XYKU/orijtd9gkaS/jV+RA0uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fV2tSNBT4mreu3vymdyvC8ics8kEk87oNLmgPr4cFmi0EdJkp1JVFejZ7O31ZhhnCnrHlkV9Nyykuk2iDhdJS2fquZ3l1Wu06e/vqvPBXpAIR5JkaMXQ/ZHvMf24AnbKv/KzfF4aCmx1AsZ+5lR9UKgIVDlCSyoK9t2weoTwaxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lu3JTEfa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b900so13277861fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284733; x=1716889533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw7OrzfdTgB4KC/AhplUeUEfJhFyKT0ay66VXG+9Ap4=;
        b=lu3JTEfaoZMk2UrZXbGstpdm8WjFBesZ8GOXMH0gGSli0Vbxkn9Ygxn0iMaJrmmPPc
         azZX+QbWxrLJMUuX1u5isOgjrb28feVZxq00tkNwHyGNL1lmWhLx+kNU4W5zTbcuIBOq
         kYdtdcxLXBo8LVFugpXCa/tszxsbAYDfZAKhPk8igcHL43oMskAV8bFUb7WGHYCs9P37
         V/HIO3ZEomUy13DvWNgAvQPvKwbrG9FfJq73e1bvy5WD8BDw2D9ecucoHnh/llDm+GiG
         3ZgIDz1SCBuYLLZSZiwwZA3hEErBAiP1mqLsi9LvRhUNATYw49YM3G3wUSbcm5nTQGpa
         rzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284733; x=1716889533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw7OrzfdTgB4KC/AhplUeUEfJhFyKT0ay66VXG+9Ap4=;
        b=YYulvMobAgKz/NMckhG2inZXMJ87qTeoe9PHqIQwR0uMBg7NcshdDL9ZPjd9DOsLxU
         na/OzKBDFwqtw6hfQ71Jixy/VWIdEIdjnGxsbaiVt7Nb5Nsk0qBb17S0wF//E4yX/Gva
         IJ/za3W0FhuUeE8OT1j9ZDW+WVkQ9dx2Vi6Ed3I5IbKNOSszubzqpZOdQ1j4GA0yet58
         tZHJyLHlGQ8ZXzw84frSgP0n4mrdWgLchmnEovwivrVN3t3ejrbejWV+q8I19MQX4u/P
         eo+OiREByqEehikO7UdnqzvCp3+Jq05hUM+yupkDDAlocm1eRxVGvU/0lPzVccK+Foij
         kzoA==
X-Forwarded-Encrypted: i=1; AJvYcCWh/BmLgRpN1Kr0phRLgj4kmRToxlV21bTs7K+XLcjLaBab+ufvaVf6Bz64Fzxv9M0UCxaryUjkQKX27YRxS0NXYR2GoINfqalz9Ucw8l8=
X-Gm-Message-State: AOJu0Yx+d7xVQ1fYxMlBj1PKRImNtfnHvL6ydTKxjhuxZVZk5LMyvV0U
	KZgE1lpj2XuxVHAeqwpvnYZWZhioXhQTJa6g6MtxK/RrC/U7gf9017rhe9FtggM=
X-Google-Smtp-Source: AGHT+IGX1Q176IzT5QXdTwJ4xeLLRxar3B9GcFke5IAQRDPGkKTD4QJYxG6uph4uMX4AvCo7vIqoIw==
X-Received: by 2002:a05:651c:14f:b0:2e4:e02c:a0bc with SMTP id 38308e7fff4ca-2e51ff65d1amr221714241fa.31.1716284733338;
        Tue, 21 May 2024 02:45:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:31 +0300
Subject: [PATCH 11/12] arm64: dts: qcom: apq8016-sbc: drop firmware-name
 properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-11-99a6d32b1e5e@linaro.org>
References: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
In-Reply-To: <20240521-qcom-firmware-name-v1-0-99a6d32b1e5e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Loic Poulain <loic.poulain@linaro.org>, Kalle Valo <kvalo@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=lOURPTyf/MozPD5HW7XYKU/orijtd9gkaS/jV+RA0uo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG004RzknfFr2xUTYDfig7qbAJdCOKGDfe99k
 9euDeWDqcCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtNAAKCRCLPIo+Aiko
 1feYB/9kr5Vq0IGkYGlqoyLUubukycE69t/Ty8gnlJ3JC5immim+H5tkJHAjolUChQrwcLzpChb
 QyH01xEy28Z34X99QnGbZn9THweOucUS83xmb3RFt0qpYUXmqIc7bxQdiglfTjJm918Z4WKH/J3
 6UrEaVSu99ghVgwEOwXSka2rAIkiJxlQu74fIymcuD0qYyHsHbeWWnqjr47ngNnQ2wDrFDRPwF/
 JgRxhptkMB3tCOteUbsbhF8s9DCzU6/5MMv1/C4CVsqJWY1SvtEzvwtU0BWxTvp8C8v1AA4txXW
 WXRDEWkyvxigO3lJ8uadhOc25kg0ZP2tqEuUdt/TbRwKFONB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As the drivers default to loading the firmware from the board-specific
location, drop the firmware-name properties. In case of the WCNSS
calibration data drop the path to the file, retaining just the file
name.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index aba08424aa38..24779238cc18 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -260,8 +260,6 @@ &mdss_dsi0_out {
 
 &mpss {
 	status = "okay";
-
-	firmware-name = "qcom/apq8016/mba.mbn", "qcom/apq8016/modem.mbn";
 };
 
 &mpss_mem {
@@ -388,11 +386,10 @@ &venus_mem {
 
 &wcnss {
 	status = "okay";
-	firmware-name = "qcom/apq8016/wcnss.mbn";
 };
 
 &wcnss_ctrl {
-	firmware-name = "qcom/apq8016/WCNSS_qcom_wlan_nv_sbc.bin";
+	firmware-name = "WCNSS_qcom_wlan_nv_sbc.bin";
 };
 
 &wcnss_iris {

-- 
2.39.2


