Return-Path: <linux-wireless+bounces-25269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A4FB01C59
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 14:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 963171C26521
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3A32C159F;
	Fri, 11 Jul 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndO7elPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C212C1596
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238071; cv=none; b=OCX7mHkcm1LXl/XPQMUy/kc1tOYuPgV1Cq+8ITwbo5IkaIMzsciyUXXHl97XXXDO/IPSNCYD02vcxvCgO46N4IXyZ87sR9YkdmXw/sxNGchDN/5cnVL+iL7Nmeb7DxgwqwMDGsVnSmAkCo7LdrzQX5kvunbi9AOPyY2jWTjMqAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238071; c=relaxed/simple;
	bh=2iINR3PSJhcBuPvUn9UdkIt961nyx4Mw2eDrprZDWKQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hYGX89OWHBCnd6eDaEDahQ/1PAtzP5j9we1u3ZN10v8o/wVkzqBO2lcWaE5F0hm/ZdLKRJYff5MVeFdYuHid992+gOIx10IKI8iSrYiALBXNBlLkwnpr1y0oVpDp6nCTxZriywauCwfjUIIg61exSIkPkEcPk+yarNiOvCnqEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndO7elPI; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso3878560a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752238068; x=1752842868; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+XFIeNiiRZ4AUfxaRNL52bzqBZn035TSmeFgxnWkBQ=;
        b=ndO7elPI1vc4VupSJuPdsKvFuqIMDEtZaaLSJM56gPF5RiJuYNeb+Yi8P+4W9KZMFw
         qNOSYWnO/MCVFAOGNBKeyVEDtq+KoIyDurIM2D6ml5jt2D+0EG2uaJYFTUgP0Yne808A
         vtJhXliQxqWPfzsPZj79SRp5FrhL6DCP9Id4Crhyj95Def8qsb4jjRtEGRWJ7uXmWNPp
         zR124p2qUzVR9UEbD2+h7h5+NQbXvoPEeB/UeEfIJXun0UEewNLInvlpTgqOPj/Wkzpy
         b+ViE+FDPdQnTEB7bIY314faL7sZ1iFDcIjIV/fNWrSUOpzD4/ijCfNxuHcLs1INHdnx
         Tpjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238068; x=1752842868;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m+XFIeNiiRZ4AUfxaRNL52bzqBZn035TSmeFgxnWkBQ=;
        b=tMK1dZH0DqY02PmrHVR6l2uIhRULKJCba49CXBMYoaKjlnVJ6gNvfFUoFZAlQMyNU6
         V8zqv/bVOUidubCd4lfITrZVpuXFL9a7gwTQ/B3JHYJgHWmAhBP4i+1jPeX5mDsuYYDY
         1zuK6D97gDVcEpgGpszwICM0953TGphVffexlvT6tsl5D3Zqise6k1/EvSAEpcqzWtvG
         mTqjhe5HrHoAiUqrFyo7p2UPT0GI0AlWImdf+Y2rNh7TKj18uOIm9OEDndEWR79fxuw7
         8WyWb7xvo7swWprTuuojV9MOVuT04A6yfU6/IdCykTsl0b3wJLoQx8NZDe6tm/Cq09sn
         nosA==
X-Gm-Message-State: AOJu0Yy5bMOBGNPaK7bUtXWLu4iiEHlBFqe8+/y4JO+dw7GHr/1016w1
	jGsQ8WTf9jMkJyM6LJ5HBzG2/on3RRK9TUYNpc7TZA46u2NQFpdXib6e3BLXLA==
X-Gm-Gg: ASbGncuPdmkNOABdcTjMjY7pxh+pN3mLAmOPICnhEAZ1NWONPlyI8n5myJuvNtRYalg
	lzOmsc8C/gzsvuVnCV7z8Nv6Jk16tKIBNomR9YTIkPX7TdiukcGvfi3wSzgQv4keRCifaOKrWPD
	vKYLGLPA4YCPgJTJP/W25sRD1yysyhE0GzqtuF5cLrrJVMDu6d1t3E7+wO1xDtO9l90CYbEJjAH
	bBmTQyAxTGADLlk080Da7XhJkp6FmsNcq/H6nA2gPqlgPKSk/SP1Cye6aqNEcQQ87xdPGx6xCGX
	3CfPwV5uD1JcKhkKbJJ+2dS1TmX6TUY12y73G1hfDB7vIwlqvEdILLMCMLMgu1zmpoweWdmDV0Y
	fPwYXcq6m7J8J5Panazhak1oUQb1VCg==
X-Google-Smtp-Source: AGHT+IFtzrSi01nKP4rC0kXme9jIIYUUyejw8n1mEZU7/ZF9ms2zu1/XeDH9H59n31aa2OL1uu75Tg==
X-Received: by 2002:a05:6402:3139:b0:5fd:1c90:e5cd with SMTP id 4fb4d7f45d1cf-611e84ac5b2mr2045248a12.20.1752238067692;
        Fri, 11 Jul 2025 05:47:47 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9528ae0sm2154478a12.29.2025.07.11.05.47.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 05:47:47 -0700 (PDT)
Message-ID: <73f8bdbf-ff7f-4741-a6ea-b1d9026833c3@gmail.com>
Date: Fri, 11 Jul 2025 15:47:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw89: Increase polling delay in
 rtw89_fw_read_c2h_reg() for USB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This read_poll_timeout_atomic() with a delay of 1 µs and a timeout of
1000000 µs can take ~250 seconds in the worst case because sending a
USB control message takes ~250 µs.

Increase the delay to 250 µs in order to reduce the maximum polling
time to ~2 seconds.

This problem was observed with RTL8851BU while suspending to RAM with
WOWLAN enabled. The computer sat for 4 minutes with a black screen
before suspending.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c613431e754f..27d84464347b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6665,7 +6665,7 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 
 	info->id = RTW89_FWCMD_C2HREG_FUNC_NULL;
 
-	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
+	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 250,
 				       RTW89_C2H_TIMEOUT, false, rtwdev,
 				       chip->c2h_ctrl_reg);
 	if (ret) {
-- 
2.50.0


