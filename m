Return-Path: <linux-wireless+bounces-37125-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEhxN8aZGWrVxggAu9opvQ
	(envelope-from <linux-wireless+bounces-37125-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 15:51:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC76031B9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17F933008E08
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 13:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7474342510;
	Fri, 29 May 2026 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOSFiqEZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D933F5B3
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062357; cv=none; b=cligRkE1OeGgqpzEK7o2gbIS5s7HyinNtYq8LyXECCoubQAxDv35QM4A2F1W2emJr4Ly97lulEoWSbKz48sQaXxtKYFXqM1qUWqF0527lfHwLYuFbM5sTsVygXf34dO5zedriBPPnug9IiQEDmr+KJaZECIW3/T7oETLorgc5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062357; c=relaxed/simple;
	bh=7mfVA8366x+r5q5VqaheTajG/HCr4Dam/HxL8Elkz/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VeYYKCpCV6na/O9HHjbjML2qWF+lIOPMx8iuHKm+9FNyFEEh/YKmIrhX7SYvsAFwKtQRxJ+tLSH20sbtj5+n4n6/+WHPInMJbs/rVfe7c4Qr8Eow8OOpyzNbT8VN38VJRmXDwOwYhrlQtOfNHgHIedD/u2RlXZ5Zc8ecVxFgL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOSFiqEZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so89104165e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780062354; x=1780667154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WI4JNNwTYXy5l2RpWx9tW3vfysaC7FsaBfx7HKpPLfs=;
        b=bOSFiqEZoiCxxGrUl+eSsJEmv/4LMIQU4DwTlmhxB9bc1xmh+PWmMxOKW0E8koVpai
         EgsU50vhWCFz0sMkermf+aMiezRLc6YI4UwUTRnc07Rt8X75MjcqzJydTTYFstwzvwmc
         di4PZbi6K1ud+zyyW2TsebOm7H52OHs10mLKY/bdpxGIdkrdlgUQEjHJRwtyos5ZM7vq
         Zg9stMlylKAEfLKMrulCpHSbuDQrc8l/1g/yrQVEaDTx2cpB25mkrrgd6XSFkR6OVBPQ
         JnTYZNmNovFzZCumXZ/22Edyg3t7KLMEsW9GKXhhWafA6r12GsI73VywPUAHTkaW9S5W
         pf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780062354; x=1780667154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WI4JNNwTYXy5l2RpWx9tW3vfysaC7FsaBfx7HKpPLfs=;
        b=rAhSjva2JCn/ehrtJ1XLaLPQTHUVTBV9opUk3quoW0YxYpsdjFxLg9S0T03RiZHeTO
         z5OO1qf6+NlruZAjE52fYuJMjqnNAN91TLc6K0YnO2uZblzQGM/qI0a1wnle+zQG9ZXL
         lj83nyvRqzQQtAHalUx2aYRVtAN+M7yxaP4Z6KULwCYfLAFOJwbn86M9ABJv38kUcb7b
         V8DEDre+jDcsqrBaMlUY+Iw6b0QXXRX9cCqCTOphGQxgcVQ7YYuvn+bJ6/+C74IJ1VqX
         43XXLKGvTpATqEG/0HIuuy1MN0mXuzra+rwE9ERfgCMm62N4y3MM9MB6xhlMpGQafXSQ
         B+WQ==
X-Gm-Message-State: AOJu0Yx0MwdivnjzG7KnkPzBbA7/RNvFLg+q4pBZXB1RwTvNg+aWLTIQ
	KhK6idYDqLJzE1x6El/TvjJs7OQ7NGPOmNhDfMaV6fr8Hgx2sxzu8BRv
X-Gm-Gg: Acq92OE548TKEbn22Y7GMhQRruv0vMDRTHFR/ggz/UoZ4KbEOw61++dW2cnYW5wAdKq
	pbb2LcF4mK1LN8/xTijmsZWxQ1CV6CnLclcL/0i2UFiVCGO0VeHkwwdYpdFA6eLLok462K1PTDQ
	tNrduELfHoogkMDf1UDPL0c2R5pmqzE6MGi+vO8CoAv2kzg5S6rLx+dglrqwHHW4eg9WT8/pjLr
	+xxYTlcv6ilYbT8ySq3uBEawR9rrjCBzlYf2BS6Q5RvkW6Q99dwHeOyhnAhGfEUStePoXrOqoBL
	3ivNqKt6XUq7QME0qmwifxd16tBH+bM4l8B7BpvPNrmhObtFmEdv71a/uPhyx8hVuTFMeSMaPju
	4qIzjQXl9RMzEa+tZElPoy9oQKlu9XZCij1nbyhhe2Oe/g7tE7QM1Jb5pdOFdc5feRFuyvn7Xa8
	42fBxkGrpwRuRy8Hha/MceLZfylfd7udUA7wK8D9BssA==
X-Received: by 2002:a05:600c:3e87:b0:490:8a00:d250 with SMTP id 5b1f17b1804b1-4909d6e6922mr43960395e9.27.1780062354166;
        Fri, 29 May 2026 06:45:54 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6f3612sm41825215e9.12.2026.05.29.06.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 06:45:53 -0700 (PDT)
Message-ID: <b434e6cb-fe51-49a7-ae66-d6ec833d5b8b@gmail.com>
Date: Fri, 29 May 2026 16:45:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtw88: usb: retry control message on -EPROTO error
To: Ping-Ke Shih <pkshih@realtek.com>,
 VolcomIlluminated <volcomilluminated@tuta.com>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
References: <Otk9l6D--F-9@tuta.com>
 <c3e40e8b0a3f4b1e96ca76072700175f@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c3e40e8b0a3f4b1e96ca76072700175f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37125-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CCC76031B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 29/05/2026 04:09, Ping-Ke Shih wrote:
> 
> VolcomIlluminated <volcomilluminated@tuta.com> wrote:
>> --- /tmp/linux-6.18/drivers/net/wireless/realtek/rtw88/usb.c	2025-11-30 17:42:10.000000000 -0500
>> +++ /home/ptpx86mm1/kernelbuild/linux-6.18/drivers/net/wireless/realtek/rtw88/usb.c	2026-05-24 20:06:27.798337237 -0400
> 
> Your git repository looks weird.
> 
> Please clone https://github.com/pkshih/rtw.git and switch to rtw-next branch.
> 
> By the way, the subject prefix should be "[PATCH rtw-next] wifi: rtw88: ...".
> 
>> @@ -140,6 +140,16 @@
>>  	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
>>  			      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
>>  			      addr, 0, data, len, 500);
>> +	if (ret == -EPROTO) {
>> +		int retry;
>> +
>> +		for (retry = 0; retry < 3 && ret == -EPROTO; retry++) {
>> +			msleep(10);
>> +			ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
>> +					      RTW_USB_CMD_REQ, RTW_USB_CMD_WRITE,
>> +					      addr, 0, data, len, 500);
> 
> Don't duplicate the code of identical usb_control_msg(...).
> 
> Just 
> 
> for (retry = 0; retry < 3; retry++) {
> 	ret = usb_control_msg(...);
>     if (ret != -EPROTO)
> 		break;
> 
> 	msleep(10); /* delay before retrying */
> }
> 
> Bitterblue, could you have some inputs about this retry, since I don't have
> much knowledge about USB?
> 

I think it's a good idea to retry in case of errors. The vendor drivers
try the control messages up to 10 times, both reads and writes, and not
just in case of -EPROTO.

Except when writing the firmware for the 8051 chips (address range
0x1000..0x1fff). Those writes are not retried, instead the entire
firmware download process is retried if it fails.

Also, they don't sleep between attempts.

But I would like to know more about the problem fixed by this patch.
What register writes fail with -EPROTO? How often does it happen?
How many times was this patch tested?

I wonder if the problem is simply the write to register 0xc4
(REG_PAD_CTRL2) which triggers the switch to USB 3? Like with the
wifi 6 and 7 chips, that call to usb_control_msg() always returns
-EPROTO. I assume it's because it makes the USB device disappear.

>> +		}
>> +	}
>>  	if (ret < 0 && ret != -ENODEV && count++ < 4)
>>  		rtw_err(rtwdev, "write register 0x%x failed with %d\n",
>>  			addr, ret);
> 


