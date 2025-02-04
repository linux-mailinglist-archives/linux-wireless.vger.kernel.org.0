Return-Path: <linux-wireless+bounces-18465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C807A27A27
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815EC3A2ACC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF792216E35;
	Tue,  4 Feb 2025 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5bDCnwD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41CB217707
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694329; cv=none; b=SZlwTZYkGpZd2pMLX2r+k0u5jFadAyFHs6mbq0d4aYOqjGQrx5/1rUpLS9est23tdvKXMc+4ZKo7cCR1hv+IYZJ9mP39l76biWbjuTB06xqkrKkScwij2YaOJUD6LwknsaRh2LJ6UJA2ZSgxG9e9eZG5rNWqy36z3xvM86F7Z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694329; c=relaxed/simple;
	bh=bV3uiyEgw8EyN8v00JYZYJwspWeSWZnQkEiZzgobk5c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jr34tJPnja1tl/cKR7X03RVF5kQqFauvb00X2pSU42p/lu0daxRS+zoFekkeDkcyAB+N3kk36Lt5RoPVneGm9Bfj+OOamFcaWGmtye4+jK21+m+XpQCkUX4WS0X6FuV683+2TIkVfb0dKLbAQJzUh+esCcqS2t7+cejQWMTh5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5bDCnwD; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d96944401dso9785210a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694326; x=1739299126; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1sq3uKwD1L8bvoGUiSz7+RcF40cxN5tzlwbdt0iRXmc=;
        b=R5bDCnwDCghe9JmCY6EA5RkJtIbORZm3UMT4CqrFoLHwe3r7ZaJRwxDrupgqAPLyMg
         4OUo0rUuILC2b2LHB47Da9uuVq6Zt3Eoi3oSd/P+4N8fyDEG4W3giqulK26x8HUOHwiC
         wB6vxZlSmzXUYFjhHbeIwQXOZuUvnyecktGEKFEPsOvA1r64cb1ED2T9DpxCCB3JRIdE
         axlC42sqB+3+4NJLC4v+ot9ih3e1ry/HVm1CL37uPqK4CEDBiIuZ9jb7wDZeje4FDau/
         MvBdWALS2EFWD2ZfwUNDwSyNU6XHASbsFMlJWJW3L8MOqPCBzHp2BtKm9AFZtI7Z/YgS
         BjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694326; x=1739299126;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1sq3uKwD1L8bvoGUiSz7+RcF40cxN5tzlwbdt0iRXmc=;
        b=AhoWcRmCESNqcthUkaBn26spN4qlz7vyWYmew9/jwwsha1b2GCbNxSywuQiHv7fviA
         14tOqlm36FLpkjklphyVUOwaxmYOPF1WfhRDXSJsKIfGEtQc98dZiANhRUzS05yinCXo
         Vh0ukH8LrL6qEcpWZAXOvYTvEgJDKnvWD01jfL05W16tI6/u4Fb9kWtQdkxqddMuQ7lF
         Y/Ak7+Q9pcMO2QPPY3VK7n5Axalwnmr+GW7pg00QcdCPcNeMA1/jqWReuhDgxvAdj8Xm
         qL77pzGn8+pS0b6AmKbtGQ2CglSrTCNQtk6vBB9HCldKlRWyRDOAeVJ8DGvhvfVqz8d4
         9WEw==
X-Gm-Message-State: AOJu0YzqSE/4StMnGSpZLMD22R9czG8fToUgEGJdNh9uv2cgg4dwyoNm
	IHDH3d+29EaIPo1WqafN1dvz6EeyapYjYai8GhBy68jUV3pqQhbAtZd8OQ==
X-Gm-Gg: ASbGncvSWSJOIsrw5cUDAF26EoWinHgRz+2laJAo4YijdfE29FW0Ix0xB4RHNDrMJeU
	udqr9b5c6l/Ej3xJ3qigHsX4OzG+ANqdLGbmog+//YWDcqdHQ3f0xigDgtq5n9ttw1AIF0LxBZM
	PUKvwwseObNr8owyaVh21L4FoRMlq5GKsDJrhMHRYRy7bZKzgTVl24UQBPfHV3equmeMELAmZho
	mSPUmvL2+ZrsEC8pwEMc54MP7h8IoFdxF8ri3NWC3+Qc81g4rx87e62I4RKbp1MxbAVWD/T9C8m
	mIsLpTTEm6aLNctOlETcn9uw
X-Google-Smtp-Source: AGHT+IE2DB63UwlxaERmoXPoAcL4ipOCbTnK46pq8vEgQSwogam3V6y3LndxP+YzDIiEMeCT/IVY5Q==
X-Received: by 2002:a17:906:f598:b0:ab7:4641:a72d with SMTP id a640c23a62f3a-ab74641a76cmr662988966b.51.1738694325924;
        Tue, 04 Feb 2025 10:38:45 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a567d3sm957167966b.169.2025.02.04.10.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:38:45 -0800 (PST)
Message-ID: <7a4d8209-b8af-4943-b5de-f53d6edf591a@gmail.com>
Date: Tue, 4 Feb 2025 20:38:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 4/9] wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These members of struct rtw_chip_info each have a size of 2. Increase
their size to 4, which is the number of RF paths the RTL8814AU has.

This is required to read and write the RF registers of the RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e40e62302984..ba64d269521a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1239,8 +1239,8 @@ struct rtw_chip_info {
 
 	const struct rtw_hw_reg *dig;
 	const struct rtw_hw_reg *dig_cck;
-	u32 rf_base_addr[2];
-	u32 rf_sipi_addr[2];
+	u32 rf_base_addr[RTW_RF_PATH_MAX];
+	u32 rf_sipi_addr[RTW_RF_PATH_MAX];
 	const struct rtw_rf_sipi_addr *rf_sipi_read_addr;
 	u8 fix_rf_phy_num;
 	const struct rtw_ltecoex_addr *ltecoex_addr;
-- 
2.48.1


