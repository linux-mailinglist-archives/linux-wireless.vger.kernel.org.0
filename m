Return-Path: <linux-wireless+bounces-12472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4280B96B791
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 11:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30A82811E3
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2031CEE91;
	Wed,  4 Sep 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuNI7zCo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C98A1CCEE4
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443933; cv=none; b=FdFoMchgqphTT+U4hSj+GuAwqHe6HVbi4jY2FMPIr8ihkY7yMjpen4XCHTZZnip5pxF0KzOpPQ41OCrGBruOOp4Dkb3duoPLgZL1UwsZopb7wV9YrHw/Ql9QqW1oA7vL0fZbu1QMXz/zLAYu4+tMaRmcpkCJYxF5OFZRXBPeyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443933; c=relaxed/simple;
	bh=EMDoobwsPaa3IPRKFEtLexd0apW8zHwtICnY0Msbmdg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3IyGcdPNN4GqqxrCKrsYc2iTWJIpUJhs6+mXAC74bPcTBrAaBUCDHRaVBblNAS5DdJWvKOxSawjBS9beRVuXvfAZNknUzV/8CF2LHhnJaqs5dOafdyyedqqcIrOZ+tlEF9pf49C1QitwnKvdsVN8Fo8OBcsLjYunFEDa0byoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FuNI7zCo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3c34e3c39so505376a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 04 Sep 2024 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725443930; x=1726048730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u49hiZ4JFDTsCsznJsWvuznonlfqBLResqj2DwZmV/k=;
        b=FuNI7zCoJfXp4Eh/hgopLVyXGCJuyRUzU+9zmcrroDk0PDC/e32DihE6Z8GnyYYisB
         PHNxQ/4teq2nKpEB8tkuwigzFuwYGpUDCl9+ied/kwHUQ++b3zRdXGOxww20KjqeTckj
         U2laTG9rbOdFMc5vnD6oZenxjyD+mBNShLR92CfUD2/kdWN4gIgOWHhCSaka5mzODZ8U
         A29flla9FAP57/sZZZAohyvbpBdGQzp7y+3qNfuBCQc/SFYM6O2hNjLgTjWKzjsF3J7D
         Eid+yPb/xxfwVej1HBBPfrd/qp6dN9BK3IgXw65mXTf8ztnfCmeqXU501AqfjNt3e+Us
         1SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725443930; x=1726048730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u49hiZ4JFDTsCsznJsWvuznonlfqBLResqj2DwZmV/k=;
        b=X8ohKJejR5owl6bpJlX7KSk+ESRatURxlVI5zzSP2t0uS5RNdmrg2Ota6ncNTxqn9g
         PmdBKp7QysGJiVT8Ogs1dbBWFmdd6ZbvF4XzbAULvOYK61bRrnAva/Q9Z7/Pp2NJlNUl
         fG1uTeYqBF7PBiCBcqp3UTNxNnkw48IZY5Ini5RH0v7/jDdKeJeaLHyqp42UjSZReytJ
         oWny+i8/hoJmf9LEaj8a39PZMbLbrUbiJr3wIMEv/X4sc0gDSaYk28LoAsFww0xTA/bV
         ZD86n2KCLSi+aCvGMVWPoSm8iUefBvDkQc/9gJXIlVaOPnEbgK7fuaR4lpJkdQ/tJfXm
         6Urw==
X-Forwarded-Encrypted: i=1; AJvYcCVM+RfWkVk+9KcSy+RhBbEf3NTOtczYsFT2Zacs9xoxCCWdTd8NZDYtO6qQfBOvT5iZDpdZLD00b25O/K7Oqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrFGLoU63x5u6KgzSuidIBEFfvhA033sbG6gDyMsSR/YYSb3Nq
	PCcpg+ce0ePaFfHO6suYGd+y/Upj4k2teVCRadp0mhtGLFTARj/6at7dgP5UXik=
X-Google-Smtp-Source: AGHT+IFT+NniqAPvFhaZv5wvnEdU/zPZtYur5crrxcjBp71lAN2FPFXmfpieiwjHhyHvSVmRM9p8hQ==
X-Received: by 2002:a17:907:8687:b0:a86:ac91:a571 with SMTP id a640c23a62f3a-a89a38221cbmr1169012566b.56.1725443929635;
        Wed, 04 Sep 2024 02:58:49 -0700 (PDT)
Received: from lion.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::a253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d5d03sm803171666b.143.2024.09.04.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:58:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Jeff Johnson <jjohnson@kernel.org>,
	Kalle Valo <kvalo@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: allow missing memory-regions
Date: Wed,  4 Sep 2024 11:57:41 +0200
Message-ID: <20240904095815.1572186-2-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SC7280 platforms which are running with TrustZone, it is not
necessary to manually map the memory regions used by the wifi hardware.
However, ath11k will currently fail to load unless both memory regions
are specified.

This breaks wifi on the rb3gen2 which only specifies the firmware memory
region and does not use the CE region.

Adjust the order of operations in ath11k_ahb_fw_resources_init() to
check for the wifi-firmware subnode before attempting to parse the
memory regions.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 634d385fd9ad..e24f8da565db 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -999,20 +999,20 @@ static int ath11k_ahb_fw_resources_init(struct ath11k_base *ab)
 	 */
 	if (!ab->hw_params.fixed_fw_mem)
 		return 0;
 
-	ret = ath11k_ahb_setup_msa_resources(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to setup msa resources\n");
-		return ret;
-	}
-
 	node = of_get_child_by_name(host_dev->of_node, "wifi-firmware");
 	if (!node) {
 		ab_ahb->fw.use_tz = true;
 		return 0;
 	}
 
+	ret = ath11k_ahb_setup_msa_resources(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to setup msa resources\n");
+		return ret;
+	}
+
 	info.fwnode = &node->fwnode;
 	info.parent = host_dev;
 	info.name = node->name;
 	info.dma_mask = DMA_BIT_MASK(32);
-- 
2.46.0


