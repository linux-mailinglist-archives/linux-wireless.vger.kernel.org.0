Return-Path: <linux-wireless+bounces-4116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320186A2BF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E1CB21A87
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 22:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4222EE0;
	Tue, 27 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9kOTFCb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBA61D556
	for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709073973; cv=none; b=EyYDww0B0pcbr3GgIATtiEGG+G0Cavws/R3xRIGrlCqIE+BdpQLA4GdDKWvmSIqntITj5Y8lHO4V/SRIxWz7glZ2oCHKRN5FHOlmZF9L5wAHwizDdzKvD8n/1DwsxhNcIOczR0FAQ7Cl5Jn6Z3OAWgSV1TYttLIOBbZM9uMn0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709073973; c=relaxed/simple;
	bh=7MIZ6Wsk/XNmF1rgoY6wCb70PiRV9hKNRxg+dia7kqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9TorVXZNQE1pHtPpUqS1swMAswtbIMXiF3+gF0lH+OTXxiZ+r/MoNkJ5XL8I5LVy8psdWZcivA6ampOXsAFCqbmhjzP38iQhWDInjsPhXS4g2s8cNbJG2NqqBw7b4iuSHOWNsUeeaEKfmEX1kiNXSFlGVMJQjCtf/D724sOA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9kOTFCb; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21fdf31a154so1985021fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 27 Feb 2024 14:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709073970; x=1709678770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K4QAHJXo3G+xhtpglNBhTtz0hvn74L2K6wSHxshAxVE=;
        b=a9kOTFCbgoP7JWHg9sAvNGvb7FGkYp2sEZfiR8Zq4gK0mCG5JJ+IIt0wHSSyCq5eMc
         YwT/otTCXkudBI4xq9RXdVNnmnSHie9l9vqKPrWLbU6bG38sRIlg9UIVYc1CxgQ09zVS
         g0cIn5q3+df0s68zpE9RQ3JUaBGAtUOin1S+MnL+d+R4r3E2NxpwqeeQCiRs3SKEjcF4
         c0ouFBkLH2YLEjVJ04MZGswWhTfBBsPmCxqf2OFUWhlRjnrAQuAO+BGPVxwFW2dIexFZ
         AaOhpRdD5Ue1Wzl1r5nPfFeBRd3iD0GUm8dgVQu6t1+Bt8ilKnqwbDCSuU9Tns49iXH6
         Ib8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709073970; x=1709678770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K4QAHJXo3G+xhtpglNBhTtz0hvn74L2K6wSHxshAxVE=;
        b=LrtCka98zgqCwUfnHjKbVJuXvvI5K5cicML+iAVo1RRFGhwAI5gxM3C6+B+fmv329K
         SSyXohzquTBzyMB8DUE6OPdn2mQ4S/viyRBDDd/lQvm7jXmbvtpx+Vb345lSLxobHI6L
         aXYG8IiL2wWBUtVBSSpT1u5H2CSD3VY0YCCPhLYSDlovi746kg6n72VH8NLLMTZwfYEi
         aB2PtgXhgr5QL1y81GYkHeeJ4luCAQbXZsM7hHjBuIJ3p0IFhwQYTadCsb+G2PaSD4fe
         ICbB+Vy+r56fEmS5kt2F28z7vdG4gdAXQUJl3MaiTaJfKzOF05X9J10WaHRv5GmScjG1
         qnag==
X-Forwarded-Encrypted: i=1; AJvYcCXWGon1DIqyrGZVOG1TR6g0Nn8z0BQgbfAvscmm+p7iDMlWstkoIly3EmpLRf2Pq1hrxAhSL3a3XC759TbOIvd51TDrU5oxOL0IHa2Wt90=
X-Gm-Message-State: AOJu0Yw4KBFhcGYCVnmNtuXgcj+EpSeyL0BA+yJyepZNCFzJ2kmteRj1
	x0kZN1puJwfrvqQD5wfoFS384XY9+GW9eN6asIQbkNV18pyUUDsuKMduICiS
X-Google-Smtp-Source: AGHT+IEhYhwdYa+0fd5YYuVmuomn60Fj7jtkr3Xm1xCsSKwB4HpqpSXgxhw9xvMrjb/HiXAYzFBJ2Q==
X-Received: by 2002:a05:6870:f143:b0:21e:d808:5a2a with SMTP id l3-20020a056870f14300b0021ed8085a2amr13799013oac.7.1709073969530;
        Tue, 27 Feb 2024 14:46:09 -0800 (PST)
Received: from [192.168.0.188] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id g9-20020a056830160900b006e4adeaa920sm325790otr.46.2024.02.27.14.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 14:46:09 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <b908b9a7-e1fd-47ba-b573-ac11b334101b@lwfinger.net>
Date: Tue, 27 Feb 2024 16:46:07 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 06:20, Bitterblue Smith wrote:
> Make dm_info->total_fa_cnt the sum of cck_fa_cnt and ofdm_fa_cnt,
> not just ofdm_fa_cnt.
> 
> Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
>   drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> index 429bb420b056..fe5d8e188350 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
>   
>   	dm_info->cck_fa_cnt = cck_fa_cnt;
>   	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
> +	dm_info->total_fa_cnt = ofdm_fa_cnt;
>   	if (cck_enable)
>   		dm_info->total_fa_cnt += cck_fa_cnt;
> -	dm_info->total_fa_cnt = ofdm_fa_cnt;
>   
>   	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
>   	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);

I applied these 4 patches to my rtw88 GitHub repo, and loaded rtw_core with the 
disable_lps_deep=y option. The option reduced the number of "firmware failed to 
leave lps state" messages, but did not eliminate all of them. The messages I 
received are as follows:

[ 2063.847153] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 2450.120216] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2450.260201] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2450.732302] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2450.876190] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2451.032184] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2451.172250] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2761.250269] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 2761.394131] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2761.746045] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2761.886039] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2762.026075] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2762.166072] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2762.638067] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2762.782031] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2762.922058] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2763.062037] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2763.546006] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2763.690060] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2763.830114] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2763.970031] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2764.462012] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2764.606051] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2764.750051] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2764.898056] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2765.374015] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2765.518056] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2765.658013] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2765.798044] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2766.278031] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2766.425991] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2766.569983] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2766.710038] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2767.118036] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2767.258004] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2767.398031] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2767.538005] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2767.990000] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2768.137991] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2768.277993] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2768.417978] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2768.881990] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2769.021983] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2769.170022] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2769.314019] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2769.770019] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2769.910022] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2770.050068] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2770.190023] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2770.677981] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2770.818013] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2770.961981] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2771.102006] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2771.585977] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2771.733996] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2771.885961] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2772.025998] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2772.493946] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2772.634003] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2772.773946] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2772.913996] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2773.373987] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2773.521989] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2773.661930] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2773.801954] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2774.261921] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2774.401913] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2774.541917] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2774.681913] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2775.141945] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2775.281929] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2775.421948] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2775.573943] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2776.049903] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2776.189937] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2776.333937] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2776.473910] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2776.957931] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2777.101908] rtw_8821cu 3-6:1.0: failed to get tx report from firmware
[ 2777.105937] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2777.253930] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2777.401931] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2777.869887] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2778.021909] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2778.173921] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2778.313893] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2778.769918] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2778.917883] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2779.069880] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2779.209898] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2779.673918] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2779.830113] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2779.969878] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2780.117875] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2780.581879] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2780.729880] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2780.881890] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2781.033915] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2781.509871] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2781.653894] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2781.793903] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2781.933866] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2782.397885] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2782.549862] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2782.697871] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2782.845881] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2783.301880] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2783.453859] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2783.601855] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2783.741888] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2784.205873] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2784.349847] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2784.489850] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2784.633852] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2785.093862] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2785.249887] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2785.393874] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2785.541861] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2786.009875] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2786.153841] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2786.293867] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2786.433865] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2786.893824] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2787.037830] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2787.177862] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2787.329859] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2787.813856] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2787.957844] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2788.097854] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2788.237835] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2788.653823] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2788.797856] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2788.941835] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 2789.085831] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 2789.741804] rtw_8821cu 3-6:1.0: failed to get tx report from firmware
[ 3090.791769] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 3090.935840] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 3091.075815] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 3091.215833] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 3235.830985] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 3491.833226] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 3785.811436] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4022.341835] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4022.481494] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4022.833492] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4022.973563] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4023.453532] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4023.597554] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4024.069501] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4024.213553] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4024.689549] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4024.829513] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4024.973477] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4025.121509] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4025.597496] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4025.737488] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4025.881539] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4026.025538] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4026.505547] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4026.649535] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4026.789538] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4026.929580] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4027.349506] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4027.489530] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4027.634007] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4027.773527] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4028.217496] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4028.361486] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4028.509490] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4028.649459] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4029.109520] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4029.249517] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4029.389451] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4029.529484] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4029.989474] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4030.133512] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4030.273510] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4030.425480] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4030.913485] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4031.053503] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4031.205437] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4031.349448] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4031.833471] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4031.981473] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4032.121453] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4032.265451] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4032.729499] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4032.873429] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4033.021489] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4033.173421] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4033.645425] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4033.793453] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4033.941448] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4034.081432] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4034.545482] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4034.689413] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4034.829413] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4034.969446] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4035.425414] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4035.569441] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4035.713473] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4035.853475] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4036.313473] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4036.453403] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4036.597469] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4036.745429] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4037.205441] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4037.345435] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4037.489409] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4037.629435] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4038.089418] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4038.229394] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4038.373412] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4038.517390] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4038.973419] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4039.117402] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4039.257423] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4039.409405] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4039.869419] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4040.009412] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4040.157397] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4040.313374] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4040.781399] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4040.921408] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4041.069405] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4041.217409] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4041.677402] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4041.817376] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4041.861392] rtw_8821cu 3-6:1.0: failed to get tx report from firmware
[ 4041.961431] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4042.101398] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4042.561368] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4042.717368] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4042.869377] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4043.009397] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4043.481354] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4043.637348] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4043.785386] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4043.941374] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4044.413371] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4044.557372] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4044.701351] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4044.845343] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4045.305389] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4045.457341] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4045.597377] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4045.741373] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4046.213370] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4046.357360] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4046.513373] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4046.657352] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4047.117350] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4047.261340] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4047.409353] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4047.557370] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4048.033365] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4048.177358] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4048.329341] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4048.477320] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4048.885326] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4049.033351] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4049.177351] rtw_8821cu 3-6:1.0: timed out to flush queue 1
[ 4049.321329] rtw_8821cu 3-6:1.0: timed out to flush queue 2
[ 4148.849033] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4166.832775] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4323.823755] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4453.846759] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
[ 4455.822861] rtw_8821cu 3-6:1.0: firmware failed to leave lps state

My system has now been up for about 4470 sec. Obviously these messages come in a 
burst.

Larry



