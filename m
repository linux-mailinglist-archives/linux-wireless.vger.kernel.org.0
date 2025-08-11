Return-Path: <linux-wireless+bounces-26269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE5B21049
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 17:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32F5F7A4715
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 15:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3922C21E0;
	Mon, 11 Aug 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx/4GjQG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E853B1A9F81
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754926381; cv=none; b=tfIxq90cg03HeUmn0dZi50/fWDSbiuIYYCGFHh6uwvSIO3MjBVoT46/asJvQj3ccBPoBBYHe8SjrP9560axJDJP8nmHLmHTeA1HRmkYIUjh2Fo7VI5bJ10bTHiop67X4b3SXlxKUjlFM9iZ5onVcqNREPkfTQum/uy2Xo8pQW60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754926381; c=relaxed/simple;
	bh=rHAJr8X08rCnz6/iQ1WWb7DFmOM/JfsQG0TeMepVxnE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UkpcMBAY18bFXIPhHKT1LpNx+0IhDGe35+tLab36dSFN0q3f6aeXtQVIlzXdS/fWj0FTg4PvM/nBHi5pbjhg+uiFzjBLra2IhK1tNYYGz7Js6+6gKAOBl2LQGO3YUQ8+TJg0Lz79IGKa3W0rMwPYH3VaXx1tE/Q4FP2IfTYMONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx/4GjQG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso2748429f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754926378; x=1755531178; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ke7Rp4sxDeXiWdH9/FSY1gnRaE9vgtUb8UpLFYVtwoU=;
        b=Hx/4GjQG4MClxO4SYr6BZVIj4MVj80shPuCvAn4Umt6F18D8CuO4JtZbhXp41ZB+u9
         FwlmSFwL7ONgL6IFyloSatAvLbqdU6CD41y0TqM53n4p2d45mzj1M+PpF+Z0C/hBgpwk
         gnRACHH+0iWgC1DZFm+pbFwyT5tPUQOYq+/ihtfegn0FF7b8UKasjeRjKo12K5uA+gqx
         fxLX+5HGkqLu3olGBXerdfRbrU8KWgzdbOgx4lEpsDyeGlXDhoNu4gt7l+1NKd4FNWSq
         ZiQ7ERJU1tApWrLuWz/roxObzfrqApnjr7dx9Vj795Z/zbRNXSpHI5XMN3FGQSSU2f4U
         HH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754926378; x=1755531178;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ke7Rp4sxDeXiWdH9/FSY1gnRaE9vgtUb8UpLFYVtwoU=;
        b=AoknVoaLbSRpvPV5kAxIVTriYuHiYAbykunpV4iyW20QBg/yNK9zFtsF3dmY/Dg6Hd
         kq5HxMRgwyNehQCTJnQ4E271ovnNkD1CtRIITgvD900Yq2UJXRKDtB8IFPKFRLAVk4Cy
         ylge67eGqpO8ERYDw+7CGFYfUhKuN4FpqdT/Exyxt4fqyt5GpDRHM4ToaFruT0ti7oHd
         pEgw/WQJ6f+/b1pCxRsNAJy2XcyTfDOLVMDJ4SrqSXI7Iix7ozq2BWzQ7Sm8mrZFPaqe
         biCttrjiOQm2L9YwjL2CJYmdHB1cU481lloyXO4R8KieYgoXNnmDtgSHmCgaGtI1toTV
         9o8Q==
X-Gm-Message-State: AOJu0YxUlYOnvUO/yOBmwrSL16mn94zN97aKuEp+wmWIOi30NPGTnY7J
	HQnNHDqqAqS+sZx7hhqkAlx7nL31B4sCtRCWdfcWugK5i9m0kNYG6Gf5UgDH2A==
X-Gm-Gg: ASbGncuk4S0lgUdV4yg3fwAKvDgcMjfJz1uQgREWjXl9RL+jHiksWbX7/06PpDumzbN
	29khnDsyPOGUBBL/JbTBJXzxXJYyQhpysyb9RTv+cmo1Ro6UjYBHHjYV6bBMUmi+R7hinMSb234
	hG1DVpz4PGsKOSp/Bat3wXtJR3Kl+G1JVf3n67zLDfeAqae2zmcoafK38n+zoYUwvquz3kT+cdW
	pDKBhopcnXTxt9vwS/Ny8qwel99tmp8/oYkhacaBKH81iid6FLs1m2Cf2zC6HCXQV3WXYcyNg70
	Xm9FLA3DIfqXrDks+SdVlz5Ih3I1Rslocx7ris/KXUt4LNdzK+MKw9Gz5S/AKOMscqszJkKMmyu
	ZUuYSNb6vWJYEstAkshOsd/3srIuqtQ==
X-Google-Smtp-Source: AGHT+IGJSfuqSU3Ri85ahmRCCWipFqtNV+F/VN5K7brmjJ5vyebjMhTD8xb4iHAC5W4BoQC92/1tTA==
X-Received: by 2002:a05:6000:2c09:b0:3b7:8ae9:f001 with SMTP id ffacd0b85a97d-3b911162172mr28190f8f.10.1754926377535;
        Mon, 11 Aug 2025 08:32:57 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac158sm41789880f8f.4.2025.08.11.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 08:32:57 -0700 (PDT)
Message-ID: <2e5e2348-bdb3-44b2-92b2-0231dbf464b0@gmail.com>
Date: Mon, 11 Aug 2025 18:32:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Helge Deller <deller@gmx.de>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtlwifi: rtl8192cu: Don't claim USB ID
 07b8:8188
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This ID appears to be RTL8188SU, not RTL8188CU. This is the wrong driver
for RTL8188SU. The r8712u driver from staging used to handle this ID.

Closes: https://lore.kernel.org/linux-wireless/ee0acfef-a753-4f90-87df-15f8eaa9c3a8@gmx.de/
Cc: stable@vger.kernel.org
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index 00a6778df704..9480823af838 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -291,7 +291,6 @@ static const struct usb_device_id rtl8192c_usb_ids[] = {
 	{RTL_USB_DEVICE(0x050d, 0x1102, rtl92cu_hal_cfg)}, /*Belkin - Edimax*/
 	{RTL_USB_DEVICE(0x050d, 0x11f2, rtl92cu_hal_cfg)}, /*Belkin - ISY*/
 	{RTL_USB_DEVICE(0x06f8, 0xe033, rtl92cu_hal_cfg)}, /*Hercules - Edimax*/
-	{RTL_USB_DEVICE(0x07b8, 0x8188, rtl92cu_hal_cfg)}, /*Abocom - Abocom*/
 	{RTL_USB_DEVICE(0x07b8, 0x8189, rtl92cu_hal_cfg)}, /*Funai - Abocom*/
 	{RTL_USB_DEVICE(0x0846, 0x9041, rtl92cu_hal_cfg)}, /*NetGear WNA1000M*/
 	{RTL_USB_DEVICE(0x0846, 0x9043, rtl92cu_hal_cfg)}, /*NG WNA1000Mv2*/
-- 
2.50.1


