Return-Path: <linux-wireless+bounces-7885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A58CAB14
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A69D4B20BED
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FA875816;
	Tue, 21 May 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+EHt4L3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFC171B32
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284734; cv=none; b=H6+nbzeyziDgSI5Kd6HhSeOl4De6TVkxVZctz/liOA+etM8XI10xEQiNex+TxmNSougMuTquA9iXH9VdvSppxBOkJ7NLvxBbcPnT7pGLprqm9C+0jRj5mYnpWi1nkrslHmZvbLy1C5JCCK7Q8Wajl8VGrUdIB+srGIuJD077ldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284734; c=relaxed/simple;
	bh=3GMSFXyN5ilu4SqpHge+aFL3zkwzk7yL0BcyJB6jSAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JMtmaZJ14c+jtfjvo3CBdpKpTygdVuY4oZBZGF0nXd62J6QIC4bwTEFos2rCKAH5E1jXuN2BYZdhWVXeu7dSutWVMJtV9zR+aQPMdq459Ir5WfqSxqNJdt7h4OtjYFXIaK/ErNj01ClKvgWKAKVxXG4Yw3wNebDm4DEVnYwQqA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S+EHt4L3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso15562601fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284729; x=1716889529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIq/k/IeC60qZbvt7sKK/1GOc3t+5RIB9rwIXTiRrZ8=;
        b=S+EHt4L34umNNqJHGRPfejgWBFW6X733iAtImHkC+W82Zhev78I7Ha1LJ8QTjh83l+
         5uCvb2RbHbTuMd40P/72RlqgzO55nwnE4auxW2c7K/9vlmbkBK/b5h0otEOcCMQil1QC
         haTU8mmxlQOYMYTduv1hzyHSigucoXdC+gs9duKyeLnk3CVpOcei5v9IF5FLeL8yU2LX
         taMcHFUFi1AXdfre5ujEKg1ZayPWyuQ8L9qgdNcdOuEeTY8u7Hp0sbl9DiVdlKLJRfgr
         dlUPfpRM1dhsI0NczwRRaD0BlPX+J+/vdMURcjDiO6/JAGHXUG9hx52Xu+RwzwNNFg7z
         FzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284729; x=1716889529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIq/k/IeC60qZbvt7sKK/1GOc3t+5RIB9rwIXTiRrZ8=;
        b=hBHpNq/BDbxsCX2VnvBkx8KsEZq4CH30goO0Et1i5pcj4uTaGXhfkSnc9+Srnv9Ogq
         rugbQGBcQU1J2rXlQlEcDbjz3L8vPWN8RR69ybAr8DFKeOOPSpVHEuOoG1kfGl6+0Jfj
         DY0VdkCcnrM7B0J7jxjm6v2aHIwZqxl24lkZ/PutV/lCvRJpgAJp1XrRzebvjqmzfomB
         klm7kmHmoxVTAqdfytD3JfsZcHND1OfCKfbkXEQza1GdMOSK+tspHxVqcBBmpC1hLbhU
         oStcKjMD7vSW3ix35c/9UIQmQWo/YXYTGNo0LjNxuKN0rScv3wPajuus6XWRiLjiEoWC
         XzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8fKoojXe9kDRriEpcYovSQTi7SG8GjSzsHVqJPf9vog0E9/jOc6GiriMR9MFy9Mtiy7G6m8wupMoXaOR8Lh0sr5cVUVvyOc0La+PVNP8=
X-Gm-Message-State: AOJu0YyiarcMWPC76QdOx4ia9v6SqMORjp97qWK0OWCyaxosUy57sbZQ
	ywIfN5n3M6yeuBNrLehY+4rDBjSSSKbjW3P3p9jxS0pgWhDHpFSstCkfxylzgDQ=
X-Google-Smtp-Source: AGHT+IEKa17r23iQKv2XCAX0BvXMw/CFrDizcCAluTCl+f1X45ThXZiwZbDwMMNPQaw/SpE9aBJK5A==
X-Received: by 2002:a2e:a98d:0:b0:2dd:cb34:ddbc with SMTP id 38308e7fff4ca-2e5205c8fc4mr346995051fa.48.1716284729715;
        Tue, 21 May 2024 02:45:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:26 +0300
Subject: [PATCH 06/12] remoteproc: qcom_q6v5_pas: switch to mbn files by
 default
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-6-99a6d32b1e5e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10421;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=3GMSFXyN5ilu4SqpHge+aFL3zkwzk7yL0BcyJB6jSAk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG0zpMk5r9LDAbiXaAl3+dyLkGHHAYS+fYqa4
 8Y/ZWNFgpGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtMwAKCRCLPIo+Aiko
 1crYCACvwdcoc2mokea78aIQPXX1+SXGckOyXSENXcp1uX+WshgqbPy5srU10vhEu2s3Sc2E81T
 j+3C5Bib57Z1xdUNrEumkpy9BpTieY4WaECHo7fF5R3eF96TuaahK7VQM8gEWaFh5RFdiQeO4w9
 gV6ZpGSfdzW5Acs+oJGmPBCgb7vu/GltAV/bVo84tl+bP9ZwIj+D8f7Ts1p21Vwsx+v9EIRzSJM
 w2Q38ct0DR2QpCRD+z0j1Pebx6lnPFwrsMDhT+BKLaxoWFJ92/TxgFq6RrbEp6ajqIExf0loCzI
 v7fqVN2B+G3ijH4tC2DrDNfXm3OkEGgOtmH13dlNKw479pFw
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

We have been pushing userspace to use mbn files by default for ages.
As a preparation for making the firmware-name optional, make the driver
use .mbn instead of .mdt files by default.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 76 +++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 54d8005d40a3..4694ec4f038d 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -812,7 +812,7 @@ static void adsp_remove(struct platform_device *pdev)
 
 static const struct adsp_data adsp_resource_init = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.ssr_name = "lpass",
@@ -822,7 +822,7 @@ static const struct adsp_data adsp_resource_init = {
 
 static const struct adsp_data sdm845_adsp_resource_init = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.load_state = "adsp",
@@ -833,7 +833,7 @@ static const struct adsp_data sdm845_adsp_resource_init = {
 
 static const struct adsp_data sm6350_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -849,7 +849,7 @@ static const struct adsp_data sm6350_adsp_resource = {
 
 static const struct adsp_data sm6375_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
+	.firmware_name = "modem.mbn",
 	.pas_id = 4,
 	.minidump_id = 3,
 	.auto_boot = false,
@@ -864,7 +864,7 @@ static const struct adsp_data sm6375_mpss_resource = {
 
 static const struct adsp_data sm8150_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -879,7 +879,7 @@ static const struct adsp_data sm8150_adsp_resource = {
 
 static const struct adsp_data sm8250_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -895,7 +895,7 @@ static const struct adsp_data sm8250_adsp_resource = {
 
 static const struct adsp_data sm8350_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -911,7 +911,7 @@ static const struct adsp_data sm8350_adsp_resource = {
 
 static const struct adsp_data msm8996_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
+	.firmware_name = "adsp.mbn",
 	.pas_id = 1,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -925,7 +925,7 @@ static const struct adsp_data msm8996_adsp_resource = {
 
 static const struct adsp_data cdsp_resource_init = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.ssr_name = "cdsp",
@@ -935,7 +935,7 @@ static const struct adsp_data cdsp_resource_init = {
 
 static const struct adsp_data sdm845_cdsp_resource_init = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.load_state = "cdsp",
@@ -946,7 +946,7 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
 
 static const struct adsp_data sm6350_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -962,7 +962,7 @@ static const struct adsp_data sm6350_cdsp_resource = {
 
 static const struct adsp_data sm8150_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -977,7 +977,7 @@ static const struct adsp_data sm8150_cdsp_resource = {
 
 static const struct adsp_data sm8250_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -992,7 +992,7 @@ static const struct adsp_data sm8250_cdsp_resource = {
 
 static const struct adsp_data sc8280xp_nsp0_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1006,7 +1006,7 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
 
 static const struct adsp_data sc8280xp_nsp1_resource = {
 	.crash_reason_smem = 633,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 30,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1020,8 +1020,8 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
 
 static const struct adsp_data x1e80100_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
-	.dtb_firmware_name = "adsp_dtb.mdt",
+	.firmware_name = "adsp.mbn",
+	.dtb_firmware_name = "adsp_dtb.mbn",
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
 	.lite_pas_id = 0x1f,
@@ -1040,8 +1040,8 @@ static const struct adsp_data x1e80100_adsp_resource = {
 
 static const struct adsp_data x1e80100_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
-	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.firmware_name = "cdsp.mbn",
+	.dtb_firmware_name = "cdsp_dtb.mbn",
 	.pas_id = 18,
 	.dtb_pas_id = 0x25,
 	.minidump_id = 7,
@@ -1060,7 +1060,7 @@ static const struct adsp_data x1e80100_cdsp_resource = {
 
 static const struct adsp_data sm8350_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
+	.firmware_name = "cdsp.mbn",
 	.pas_id = 18,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1076,7 +1076,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
 
 static const struct adsp_data mpss_resource_init = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
+	.firmware_name = "modem.mbn",
 	.pas_id = 4,
 	.minidump_id = 3,
 	.auto_boot = false,
@@ -1093,7 +1093,7 @@ static const struct adsp_data mpss_resource_init = {
 
 static const struct adsp_data sc8180x_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
+	.firmware_name = "modem.mbn",
 	.pas_id = 4,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
@@ -1108,7 +1108,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
 
 static const struct adsp_data msm8996_slpi_resource_init = {
 	.crash_reason_smem = 424,
-	.firmware_name = "slpi.mdt",
+	.firmware_name = "slpi.mbn",
 	.pas_id = 12,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1122,7 +1122,7 @@ static const struct adsp_data msm8996_slpi_resource_init = {
 
 static const struct adsp_data sdm845_slpi_resource_init = {
 	.crash_reason_smem = 424,
-	.firmware_name = "slpi.mdt",
+	.firmware_name = "slpi.mbn",
 	.pas_id = 12,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1138,7 +1138,7 @@ static const struct adsp_data sdm845_slpi_resource_init = {
 
 static const struct adsp_data wcss_resource_init = {
 	.crash_reason_smem = 421,
-	.firmware_name = "wcnss.mdt",
+	.firmware_name = "wcnss.mbn",
 	.pas_id = 6,
 	.auto_boot = true,
 	.ssr_name = "mpss",
@@ -1148,7 +1148,7 @@ static const struct adsp_data wcss_resource_init = {
 
 static const struct adsp_data sdx55_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
+	.firmware_name = "modem.mbn",
 	.pas_id = 4,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1163,7 +1163,7 @@ static const struct adsp_data sdx55_mpss_resource = {
 
 static const struct adsp_data sm8450_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
+	.firmware_name = "modem.mbn",
 	.pas_id = 4,
 	.minidump_id = 3,
 	.auto_boot = false,
@@ -1181,8 +1181,8 @@ static const struct adsp_data sm8450_mpss_resource = {
 
 static const struct adsp_data sm8550_adsp_resource = {
 	.crash_reason_smem = 423,
-	.firmware_name = "adsp.mdt",
-	.dtb_firmware_name = "adsp_dtb.mdt",
+	.firmware_name = "adsp.mbn",
+	.dtb_firmware_name = "adsp_dtb.mbn",
 	.pas_id = 1,
 	.dtb_pas_id = 0x24,
 	.minidump_id = 5,
@@ -1200,8 +1200,8 @@ static const struct adsp_data sm8550_adsp_resource = {
 
 static const struct adsp_data sm8550_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
-	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.firmware_name = "cdsp.mbn",
+	.dtb_firmware_name = "cdsp_dtb.mbn",
 	.pas_id = 18,
 	.dtb_pas_id = 0x25,
 	.minidump_id = 7,
@@ -1220,8 +1220,8 @@ static const struct adsp_data sm8550_cdsp_resource = {
 
 static const struct adsp_data sm8550_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
-	.dtb_firmware_name = "modem_dtb.mdt",
+	.firmware_name = "modem.mbn",
+	.dtb_firmware_name = "modem_dtb.mbn",
 	.pas_id = 4,
 	.dtb_pas_id = 0x26,
 	.minidump_id = 3,
@@ -1243,7 +1243,7 @@ static const struct adsp_data sm8550_mpss_resource = {
 
 static const struct adsp_data sc7280_wpss_resource = {
 	.crash_reason_smem = 626,
-	.firmware_name = "wpss.mdt",
+	.firmware_name = "wpss.mbn",
 	.pas_id = 6,
 	.auto_boot = true,
 	.proxy_pd_names = (char*[]){
@@ -1259,8 +1259,8 @@ static const struct adsp_data sc7280_wpss_resource = {
 
 static const struct adsp_data sm8650_cdsp_resource = {
 	.crash_reason_smem = 601,
-	.firmware_name = "cdsp.mdt",
-	.dtb_firmware_name = "cdsp_dtb.mdt",
+	.firmware_name = "cdsp.mbn",
+	.dtb_firmware_name = "cdsp_dtb.mbn",
 	.pas_id = 18,
 	.dtb_pas_id = 0x25,
 	.minidump_id = 7,
@@ -1283,8 +1283,8 @@ static const struct adsp_data sm8650_cdsp_resource = {
 
 static const struct adsp_data sm8650_mpss_resource = {
 	.crash_reason_smem = 421,
-	.firmware_name = "modem.mdt",
-	.dtb_firmware_name = "modem_dtb.mdt",
+	.firmware_name = "modem.mbn",
+	.dtb_firmware_name = "modem_dtb.mbn",
 	.pas_id = 4,
 	.dtb_pas_id = 0x26,
 	.minidump_id = 3,

-- 
2.39.2


