Return-Path: <linux-wireless+bounces-33905-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLIhA85pxGlEzAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33905-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 00:03:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AA732D394
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 00:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E16F3301074F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844031E83A;
	Wed, 25 Mar 2026 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAqgQdWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A19830EF84
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774479816; cv=none; b=OClDxOrcCD0IMOdJvpADMssc6e3jDvf/vxPDuq4zeDpHwSVpKk1KgRSXlfDEuMeVmlpJ1tsxaC4MKsQfC/FbzHavWdkamduUiDEIyWylKTMAns92ALMg86EMabrpBWj57gctN6rAXokip0vWl7Qu6oEtdJ+HwYc70mjeKhxxiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774479816; c=relaxed/simple;
	bh=VQukXwg6EYO72nPn+Um2fGaNYot55a9IeWi3iHYXwBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oqMEz7LRBRObE/ij0ozkUEcxk+hQMwhyl9iAlwadRqWlfmOumMWYH6t2dzcfsoiVRtNRY1hrTfbKozPED7SMnDKfYdbjns1gkjTwkNojeDw2Ed+4c8gCXybZr7gktzO/ufZZoPpPNIqtYKoWDm9QG/MzbgjktsQfq/41PQwIDgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAqgQdWd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439cd6b0aedso192298f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 16:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774479814; x=1775084614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63+3PfcNOwCMhYYmSyE/Kc6Wq8ltsWRqhM0PC1ssWBI=;
        b=QAqgQdWd+HTGpCobeV52IEI7smbWblZjfhC8uHHjOQK4Co3NPLeTxJOSSeTMJlNw3T
         7SPkHR/LJfOxv8I4M5zmIAQJtp6hRHvUm5f9rB4C3cM9wyNdktCcw2F+rUsMXuVBzzku
         eRtwOP98HTWYLv0tCZ42Irf2dpknge15o6ff3gfSQLT7yPYInHnFXho77tIRPvZQIn+F
         TSvKniXQrBbhvUY0gY92j44lmYMkRFo06sl4VaJmsA1NTn+O767p4JkS/QKZd+01AP22
         ar7dbDhzmhsttvQgt8hXRzPDDmvaX+7KoyNcU0OHZXQE1kzEAdFwgfYkFgEm+AS3Q1UC
         kyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774479814; x=1775084614;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63+3PfcNOwCMhYYmSyE/Kc6Wq8ltsWRqhM0PC1ssWBI=;
        b=VCrqo1yT2mAhYC72RpHObkJzTkvIuoGgQGBppxyrMBs6DipfSWzye+aJPvF+ygB7bq
         OliWgiQvnrutEZpXcFpAjl2+NmjZP+ZRJ8n5GhkIFRNa9NHuExs6WuWg4k70zUdeU5In
         X+ujBWa3sVZIT6LscvhuaK5JGAUU1whREgpk2KW16GRuFxM+V5CMP18i6ZP8qmik0q5y
         Hi6td4lYyT4Q/98GuqspfE2lDEMUdS8/I5D0kohOskblcKXDuuUGkKdTe44WD0//vfBv
         MIwwlNs0cpyTuuUTO1xBVqw+tabEHyvmx86ZHOF1b0FGkcD0Z72WH2S4D/X8jhGmLhP+
         /QNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuueAUNUfuMGym1GB8/A3j4UGFlRV9L2IIFEDJ4HJeH/Gyk6iZnt23GC1kKL97HrbQY7mnmRJ/vUOVJKfD4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVImsd9lWoo/e87QvVVq6RxoDnwJollVXwSf07Tiz00cEg4PK
	+qb0HRN/o2Pim3AULXmbE8CglQDIXFJQRyWfreYxrkTjc+uR9288xypA
X-Gm-Gg: ATEYQzzpwADZznjmlDlCsJpQrkhPHC3Tp15cx7CJ0B/cphhn7nzuPBykDlhfr7cogUw
	Bv1PomqgwC0DO0IG3QjqIAsqb2QxAkAGbTJPShwikbvL1eVzFNjvwtpBksN2siRBVyLBUH4GRkh
	GEejfS7dHSNAmespKB32tbZJBPAMrQ/14hdWJELH2uRImt9KypArR00bEMdnshnZLhncE1KZv5a
	OreivWmcRqujheCJk8Keoop9c9KQNAK4kQyBVTteLyXZaYJ8EYItXOOJMx1bGiRDfExlS5OCYxF
	JgSa6SSwxl15WKZlLdelvn50SzVEfyvcDVGiH+FamUdWdDtJlmD5FywQFjct16uxmyBGh93qhPu
	+KtDqFtrNqi76Uz0Wg276T4uLCK6RneVYV5y0GeAHER2TEvPltTwFkKpvnxCS32QxIZiF/pyWyg
	GHcPCDegu5G8f7J9AAR635oV/Va92+dg==
X-Received: by 2002:a05:6000:2301:b0:43b:460a:b13 with SMTP id ffacd0b85a97d-43b88a0cf0emr7663501f8f.44.1774479813497;
        Wed, 25 Mar 2026 16:03:33 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df7dcsm3709197f8f.27.2026.03.25.16.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 16:03:33 -0700 (PDT)
Message-ID: <491d5140-f16d-44a6-bf01-8f35e43e2fdf@gmail.com>
Date: Thu, 26 Mar 2026 01:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next] wifi: rtw88: WARN only once in
 rtw_phy_get_tx_power_limit()
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <98129317-7e88-4654-910b-630aa992bfa3@gmail.com>
 <946684847bb0463aa794828d3e1a3e83@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <946684847bb0463aa794828d3e1a3e83@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33905-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wikipedia.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0AA732D394
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09/02/2026 10:01, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> This function WARNs when the wifi band, channel number, channel width,
>> rate, or RF path are invalid. Two or three people have reported that it
>> floods the kernel log with warnings because they try to switch to
>> invalid channel numbers, like 130.
>>
>> One warning is probably enough, so turn WARN into WARN_ONCE.
>>
>> Closes: https://github.com/lwfinger/rtw88/issues/428
> 
> As the issue says "invalid arguments, band=1, bw=2, path=1, rate=83, ch=130",
> I think it operates on bandwidth 80MHz and primary channel 130. 
> But I don't see 20MHz primary channel, for example [1]. 
> 
> Can we stop using this channel at set_channel() ahead to avoid this error?
> 
> [1] https://en.wikipedia.org/wiki/List_of_WLAN_channels
> 

Is there a standard which says what channels are allowed?

Six weeks ago I asked people to test another patch which adds a check
in rtw_set_channel() like you said, but no one replied. I guess I will
send it as v2.

By the way, there is another patch related to this problem:

https://lore.kernel.org/linux-wireless/20260306-rtw88_channel130-v1-1-ff25a5bc930a@igalia.com/

> 
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/phy.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
>> index e2ac5c6fd500..2a3929561664 100644
>> --- a/drivers/net/wireless/realtek/rtw88/phy.c
>> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
>> @@ -2210,8 +2210,8 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
>>         return power_limit;
>>
>>  err:
>> -       WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
>> -            band, bw, rf_path, rate, channel);
>> +       WARN_ONCE(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
>> +                 band, bw, rf_path, rate, channel);
>>         return (s8)rtwdev->chip->max_power_index;
> 
> I feel this will be a problem if max_power_index is adopted.
> The power is too high. 
> 

I agree, it's a strange default. But I didn't touch that. :)

>>  }
>>
>> --
>> 2.52.0
> 


