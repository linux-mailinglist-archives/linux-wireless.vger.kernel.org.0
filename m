Return-Path: <linux-wireless+bounces-18464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F96A27A26
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA871882ED2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19607218ADF;
	Tue,  4 Feb 2025 18:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9XHETtz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0BD21884A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694303; cv=none; b=GBgqZHoHlA7MpgwYZ/k/WOs14eCp8EQkSaqxNk3YDVJejUHgTMGJE4iDnE1JwBfaQNWgk5O6Lv2SyRvNuh1sPWL11UJwFDy+fXYwhmNjSo1BBjqLMe0EZXru/OlOyhxOT8Zuk7dCEyiJ+IUyivgp8zP8tq9eP/eVDqViRKCIvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694303; c=relaxed/simple;
	bh=WaUoJ7nAxfMGMkoq7OlRIrphgSmbqgUh+p0083ImoUw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kEXIrGvVRSBrM1/LJO51E9C4L260uDO/RwRP8MMv6lMDpyd61u/XDHemS2tkKl7ScNk6OUCFKyovFC60eqHQczrFTB8+hMhCBpk42oARE5k0/kIG9E1Sb7RGET2yBMHXNOcXoWuTacDEVCARbwfmK+IJNqZG59c7WsTQGWHOfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9XHETtz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3cf094768so10769457a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694299; x=1739299099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yv92xnSMtNnA1M6tJ/JX7RQB+vjsOFOK5K4t3ha3PCw=;
        b=b9XHETtznCs8iE4PDDLnaNFZlQn70yK6pPC+9WJZLsyFH4mYVhti8IUTkuXptNWG2O
         2Wh72aE35U4bmbzxNUkapoQntx2tLqpYQwuAet1Ad3wl0khGbyNpHIBz4rFum76eQa4Y
         p7Ku0FUq1lrdelHY/XxGYyNZ8hh0zs00o3HVhRrgqi+BBqbyHcpqZ3k0UEcZUu+bs9BK
         ObiCyNrJ/RMJ1H0WhcB7hiwGgresy+s7GQz4c5r7d00UTH8qz2x9lmgqJVzHC7pmiviE
         O9nL7SP6nI4UXXr4/ss6l+PVTYRh1zD3ExviQe58L8XRgccT2T/Ps32H3vE3hubxhA93
         AULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694299; x=1739299099;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yv92xnSMtNnA1M6tJ/JX7RQB+vjsOFOK5K4t3ha3PCw=;
        b=P9NjlcNUh/6Pmrv/7TMS4X6Gd65BkdhAwRt/SQjSiPlGHaKoE8Di4bg6SH9ZnLMfq1
         LZDzZdWQScKNbhkmFegauPeeNwdltSMRsS/YepXMq5VK+nyjxpXbpvvqIuJhj4ISnAJq
         LHUgpFlGo0RmJXaWROFLUg7sxVZzRr1yuk3BZDzk5u1LPycGTN+DvT415SmwkxTRJ/uO
         gW1aush7ymq22DtscAULzSlQ7biHV6dPHEHGV32Xt3f7qlqyWhmPLENcG/JmoE5B4ow3
         nG83PPJefzkqNSG0bWUeWfzTHOoV6lCHdvI7v2YOHYfc+Nj4mai8+5VZrDOo9y2EM0JD
         z9FQ==
X-Gm-Message-State: AOJu0Ywz5urvdHRCxNmPhVGlwqEhkVt2booa1QYoWAI6JZqSfsnbph/a
	FzoQD280NKSzu/aLoVgkPU81ByNFM8Mtjr+nT4U3ck3CchaFCczh7cSEAA==
X-Gm-Gg: ASbGncs/55PjanlNapEsC3jcJTb0DTNWsR5bq7ukAmJ59HMe6jQIqdg4j+DYvg+12/5
	Klinz6ljKyLJIf2tkrmrhrcQoHm7thDBIcuafxyGbMFXNzh9RJdAITYosaJ1BtPESk4Bis050uv
	NC+rtQEavudEm4mIMRxs6dcDS/eqlnxWKsWKjq+W1XsujVuFIZWFgmsDAknrOxp5gXfkhW7JBh+
	3+GUgtUk0DY4npXQCUEX9zFZa5qf5Oz96JF3ftF1TcWLaWu9waLn4riW7GeoUcEVG+rsbZblFbe
	A1NwVWdA4GUQBo4dIpZjkKvW
X-Google-Smtp-Source: AGHT+IEnhmVXyAnTG7IKe8ANVwsOaf46JjmhDGg1iD3AoTDHdWIAJmsc4p821Zow2YtOwKxUuEYoZA==
X-Received: by 2002:a05:6402:5d0:b0:5dc:da2f:9cd1 with SMTP id 4fb4d7f45d1cf-5dcdb733704mr94768a12.14.1738694299264;
        Tue, 04 Feb 2025 10:38:19 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723e4ceasm9710496a12.21.2025.02.04.10.38.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:38:18 -0800 (PST)
Message-ID: <be5a73f4-a0fe-43d6-9457-930cde199284@gmail.com>
Date: Tue, 4 Feb 2025 20:38:17 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 3/9] wifi: rtw88: Extend struct rtw_pwr_track_tbl for
 RTL8814AU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Currently this struct has the members required for chips with 2 RF
paths. Add more members to support chips with 4 RF paths, like the
RTL8814AU.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 62cd4c526301..e40e62302984 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1130,14 +1130,26 @@ struct rtw_rfe_def {
  * For 2G there are cck rate and ofdm rate with different settings.
  */
 struct rtw_pwr_track_tbl {
+	const u8 *pwrtrk_5gd_n[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gd_p[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gc_n[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_5gc_p[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5gb_n[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5gb_p[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5ga_n[RTW_PWR_TRK_5G_NUM];
 	const u8 *pwrtrk_5ga_p[RTW_PWR_TRK_5G_NUM];
+	const u8 *pwrtrk_2gd_n;
+	const u8 *pwrtrk_2gd_p;
+	const u8 *pwrtrk_2gc_n;
+	const u8 *pwrtrk_2gc_p;
 	const u8 *pwrtrk_2gb_n;
 	const u8 *pwrtrk_2gb_p;
 	const u8 *pwrtrk_2ga_n;
 	const u8 *pwrtrk_2ga_p;
+	const u8 *pwrtrk_2g_cckd_n;
+	const u8 *pwrtrk_2g_cckd_p;
+	const u8 *pwrtrk_2g_cckc_n;
+	const u8 *pwrtrk_2g_cckc_p;
 	const u8 *pwrtrk_2g_cckb_n;
 	const u8 *pwrtrk_2g_cckb_p;
 	const u8 *pwrtrk_2g_ccka_n;
-- 
2.48.1


