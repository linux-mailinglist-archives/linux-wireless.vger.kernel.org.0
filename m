Return-Path: <linux-wireless+bounces-18463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B973A27A1F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A00F18849D6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609E217F50;
	Tue,  4 Feb 2025 18:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcndSUMy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6E217707
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694263; cv=none; b=awM1EZh7jKy6lS22PMGNkZYWK3tOX0cMwC8qHRXt/CCBf21IVbuBwjys306hzWK8qbuoe3lwMCM33+7B0OPriDxiyH+iwjbfP0MvRBAtyeb/b8lyu5beA7QD6INlbQ69GQbIJQQvwqGoOkxz323eT8pVdX8VpkwLtD8AemF32EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694263; c=relaxed/simple;
	bh=BSrhwGOmjWtgncnrT3poKLtEHwfaQljxfAYN5aYfiXs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pnMKrawanp4l+b8KsGqR2oqqybzxKO1WyyRJztc8vKce5vazNtsW3bJ7i6ApMKTEfQoKvTPapdBijkiD08i6Kp4gRGXKRY0VBY9Ctyf6/Pcn00gvXFhUpXyjRQ4wf8M/O8YmtBVBmg9wVDGCeMHQBpHjA6OdKJnffhPXe+8F5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcndSUMy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso10494975a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694260; x=1739299060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j7e3klw5/TX1fq9HF+hwiRrL8MCe2E/h6BKFpxhVBwo=;
        b=YcndSUMy7VfBmXfwMJqMi9u9j3ZNR5xrEACj2fwty/qoZY5WiCko2S81SCzKXsdGYr
         nDM5q1hePRX837zWrZp4/O+xNxoi+6FQi8eag8Z63fJRkE3Mw1qRPbshKZqE50pv2VJP
         uXNE4MK4Y1MvKuLZTklFVoVcUMHeVqw+Ouab8GsSaNADPkaK1hE29/HMvNt+hEu94zo/
         pyohTAMDGlAtT2QR9IVs8/kK4q/oOPVxNzI5xYmSBkSDpf74r+KbouWEhKL5xDsmPDbf
         1LJIPjQNo2h5u4iUUbMfFS3PmAJn0qj3KiMwsFuRBzwERAFeIj/zuDZwVuEQfVGi/r0I
         EdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694260; x=1739299060;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j7e3klw5/TX1fq9HF+hwiRrL8MCe2E/h6BKFpxhVBwo=;
        b=wjdoNfajsHIy2v0BuHGM+Q9HAR1ACC+msTUgb8uQrjhSEXlwSBfJBxW7pPFqJTfRJ8
         C4xiZFdshIWPzeiu1Uh0VjhyWZBZz21USmUKGKoCurLcxj0Ka3dZmrCwJBYmA1f5veNi
         O1UH/Hluyk8hkBrU+wppqqsMz2VYtU18r81lqR5oFDQZVmBuPqRnZEJO/uHzWZG2FfOn
         qdqg+3TMjZloQzGaycT9YPJ6ZSuM7I3tKJsDkInjpr2NU1igBo/M4j7ZY288mSrKiKa/
         x3CzCCSQzL/DJ23R3ZpS3/4N8RAxm796LbcaJ+2VLKkwSyZYgbnBqGtKiaUD+pAx0+hs
         Dv5A==
X-Gm-Message-State: AOJu0YxmwxJKNPfsF91681mWswPi9zUYMuH5D1oKrMQy0gdSkyYK3VfD
	KuXsZwgMxoMVvQxrtZegwPE5oG9rcakh8/H2IRnEiPqL04QIHB4UdFNL+g==
X-Gm-Gg: ASbGncsxvVfnl0r0xkSgrpSWgozjAfjon+RD4ru21m66P+NMvEw2Asqaf00EQMe4ThI
	lxWDAkpWxvvpVrYyfRVlf4ixh9zO8NIpoyZvcMOlKQvvn220WXrUb9O+IlZZg2p2jYTVVlWn6j/
	ZNvZjN/qUaBVQPInNRO19aCrZ6lBHKa4Rx4Zleotn3r0531LQaR9FareqkqLVV9SubWwGIScmke
	J+9me3PB0tVCHDTu0f81RV+c2lLQGz1ldiEpTySTh/AhJS+oOIkTqrKbO8BdlOmSey2x4ppTkOU
	uSev8YhLfkQ4uDwjq++Tz3s7
X-Google-Smtp-Source: AGHT+IFLniBwsL/SbTatxv+LF+XZLtLhZEIeN+feUmAaHSp5IlesfT4rz5eGGpxkssDTDMHPp07+Sg==
X-Received: by 2002:a17:907:944e:b0:ab7:5a5f:115 with SMTP id a640c23a62f3a-ab75a5f0b85mr79521666b.49.1738694259958;
        Tue, 04 Feb 2025 10:37:39 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff719sm963081166b.114.2025.02.04.10.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:37:38 -0800 (PST)
Message-ID: <049d2887-22fc-47b7-9e59-62627cb525f8@gmail.com>
Date: Tue, 4 Feb 2025 20:37:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/9] wifi: rtw88: Fix download_firmware_validate() for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After the firmware is uploaded, download_firmware_validate() checks some
bits in REG_MCUFW_CTRL to see if everything went okay. The
RTL8814AU power on sequence sets bits 13 and 12 to 2, which this
function does not expect, so it thinks the firmware upload failed.

Make download_firmware_validate() ignore bits 13 and 12.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/reg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e438405fba56..209b6fc08a73 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -130,6 +130,7 @@
 #define BIT_SHIFT_ROM_PGE	16
 #define BIT_FW_INIT_RDY		BIT(15)
 #define BIT_FW_DW_RDY		BIT(14)
+#define BIT_CPU_CLK_SEL		(BIT(12) | BIT(13))
 #define BIT_RPWM_TOGGLE		BIT(7)
 #define BIT_RAM_DL_SEL		BIT(7)	/* legacy only */
 #define BIT_DMEM_CHKSUM_OK	BIT(6)
@@ -147,7 +148,7 @@
 				 BIT_CHECK_SUM_OK)
 #define FW_READY_LEGACY		(BIT_MCUFWDL_RDY | BIT_FWDL_CHK_RPT |	       \
 				 BIT_WINTINI_RDY | BIT_RAM_DL_SEL)
-#define FW_READY_MASK		0xffff
+#define FW_READY_MASK		(0xffff & ~BIT_CPU_CLK_SEL)
 
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
-- 
2.48.1


