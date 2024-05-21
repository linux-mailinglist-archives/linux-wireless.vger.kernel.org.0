Return-Path: <linux-wireless+bounces-7891-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4238CAB32
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413821C215E6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 09:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3011B7B3E5;
	Tue, 21 May 2024 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vedFmH6u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D5576F1B
	for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716284738; cv=none; b=pMHPbPkBEfgcJL/Jf7yim42U2RzS1TuGwMtv0E0epqhBRALUG2ouo3ibcqJ23iRlirTByGX4/T1jrRggx7S7eF5mNJe3u/F0eIxcsASHt/gHxjsVl1K1+wxs/VA2dYvj7B/lAF1TcZZmSK7e4kh3U/iBJlMfJfEMal23gsVIEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716284738; c=relaxed/simple;
	bh=hNIcpe1sOvV0/2oq2E+Wm6ZeAwz5DUtQCi+I+XlGNEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pX/C7xrNx3oUMUzRxFbDqaJQTjIz/dyrqQe+9Db5dO4OOqgbx4WiFM8+G52Cq0221+9seR8PNV+JbpbnCk6d18nICB9kSmTPUzcyYTGjIk1WotA66+Cmgn0b9aLVuZx6bVF+KrxX66cBgO0azx4/DFq6K0b8De4vNb3mdzupa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vedFmH6u; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso15563671fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 21 May 2024 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716284734; x=1716889534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76RXMDJdIf87Lj/v6tqI1Ofql4asvJ4Gr33M+iMz2pU=;
        b=vedFmH6uMnaY+QyRY8kx0Vo9hwWJdGbzVK4qhTHM9qRMGF2cuZFGYXdd4P21TUhQeB
         9WuPOjhZ5lHNk/TzXG6JDVd0F6NbevPJ+TcdFxH7yoOs0byedvPaZuC8D5eaUSPIlWdq
         Ton8I38Llz3dn90vZcIKUdj0GYu4zPwTfaNYS4CJgjVlR1b/QmVzg94ssdCTJFh/udNW
         RfHpfLvCqtJTifmWicsQAk6SwCCrTNAmEIvTxhxkEbELiTEQZn9IcacKd/UdZucaBX+V
         LA78k51Rzr/vDNK9nKm/taAYokPXKJ9QkgXttDsuLZvaVab8mhgpcP2V/5Y2jmM36ihm
         uHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716284734; x=1716889534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76RXMDJdIf87Lj/v6tqI1Ofql4asvJ4Gr33M+iMz2pU=;
        b=a8jGYKSs76ALj5YIEiDL9UmZQeqrf/1gmB+VptQeN6jWv9H+JkPuXmOyZ/9h2y/5fI
         rYHY2QVRd9OfNmVRK+VLWndAmkLyl7cn3CtATUSWft+KscdH1Cb1vCfvyj6QdBBWgzy7
         BH2Rhgp5iJn6MN1/O1Japr3npAL1DMQgeScRGeok4mepdiSrDuVhkGdufrR2pREFZS1L
         yRo8ZyczlFyKmpToMaWcoBHT9CaIZw3tziNnjE/CSpblSwOKZK14UHNh9ZiP9SlNyatJ
         mx6dsrY8ggZEyRJQhA8du7HweYj89HQ7fDedz0x7wNhjXfc4iyCspQ1byymKzoBTVfD6
         Lbbw==
X-Forwarded-Encrypted: i=1; AJvYcCUCcyAcIXIzfBOHYD9N6FkhhMpbdjS/1Zn2W91nqDxpRtyH4+pccWymm2sdxDAm5Dv9BZLeVeDd1BRXZNd9SeeQVvcEhgxeqUU3ufWoXtE=
X-Gm-Message-State: AOJu0YyzORETkruVDfoRclTfRWnIIb7PlmYZ1pDg77RwbuQEnuzcwjyw
	Igmvv3LU/NT84/oqZR/qoo1i3g9904B5E6IPZi5z7C5gxpuUb/23G5ue7SAaWEI=
X-Google-Smtp-Source: AGHT+IEqAy4DTdCoeAv2Vdxu6aMYdVExJ0VTzJA4oaoyPSmsMWau+PJh35LHB+sTJu87BfIxRz3YVQ==
X-Received: by 2002:a2e:98cf:0:b0:2dc:e3da:8025 with SMTP id 38308e7fff4ca-2e5203b41dfmr336605301fa.36.1716284733986;
        Tue, 21 May 2024 02:45:33 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e706ee0a65sm13906261fa.112.2024.05.21.02.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:45:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 21 May 2024 12:45:32 +0300
Subject: [PATCH 12/12] arm64: dts: qcom: apq8096-db820c: drop firmware-name
 properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-qcom-firmware-name-v1-12-99a6d32b1e5e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=867;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hNIcpe1sOvV0/2oq2E+Wm6ZeAwz5DUtQCi+I+XlGNEg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTG00XZHHmjrQ3qkPBy9bf5pX47eUXttvZKwjl
 K3ZuOLJ9+uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZkxtNAAKCRCLPIo+Aiko
 1SULCACrryMAqbZ1Va3cYrmE/JyS2h5P2T1NgaXOI8XFucKAREQa56inkv1aVjV+lM4Q/los5rx
 Hse4D3WZur17W5buWRif/FSoXkFlBFHq11Bum/3KV8490wuSElXP6Z+w0LfGe+920BdLspNtHzb
 nD1kWhyBQI0WRxmgp252Fxj4/bkX5UhX7R1cXsSA/r9pViUggXL5LhL2XUwfvqxG9ZGj0kggVUF
 O4qhJCSZIfLe8VNu9T4ZxR3YBBBP252aQidYgJ72qXoFsM8ccXKuodksJHJaVh+P6B/TcyO7l6R
 efJMaqM8Cg/9a3N0h1leWK3V/ArWR5g2a/tzOhxLJQ5i3WaB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

As the drivers default to loading the firmware from the board-specific
location, drop the firmware-name properties.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
index e8148b3d6c50..2c8a77401aa3 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
@@ -161,7 +161,6 @@ bluetooth {
 
 &adsp_pil {
 	status = "okay";
-	firmware-name = "qcom/apq8096/adsp.mbn";
 };
 
 &blsp2_i2c1 {
@@ -253,7 +252,6 @@ &mmcc {
 &mss_pil {
 	status = "okay";
 	pll-supply = <&vreg_l12a_1p8>;
-	firmware-name = "qcom/apq8096/mba.mbn", "qcom/apq8096/modem.mbn";
 };
 
 &pm8994_resin {

-- 
2.39.2


