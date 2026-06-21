Return-Path: <linux-wireless+bounces-37943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bmx3IBeeN2pqPQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:17:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A76AA660
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 10:17:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=IGIPkLRA;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37943-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37943-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB4C030054DC
	for <lists+linux-wireless@lfdr.de>; Sun, 21 Jun 2026 08:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86407280309;
	Sun, 21 Jun 2026 08:17:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCBC275870
	for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 08:17:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029832; cv=none; b=Rk439yESaXVxdl9DwpA3hfOZaJ/zTXl6kzQryeqj23FtTAqyAP4ffYCqvRGvw7QrLvLVW7kykoOfnm5RAUfUjkUmquz2z6Xrbe355h+PS+5RsRdtw0NAl0UwmxvPqW4d2CAhAY0tRCAgn0JOTbzwO4xoV6Hz/HvtcQnPwi/hhQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029832; c=relaxed/simple;
	bh=gmAnStZ8FyZx2TvUXcP7lf5VWLG1jbjrk1AXQ6cghxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RipBf1KAWvgnw4mg83zcaOuLTB0IRFfs5+ocaMuQXZzX5UGUh9blHxnuNAxydv/JhvYvlWOOTSKBC36/JtIp8wwtAatBCU9ieCslvT0JOxDGTEbqm0h4n7UWK5Vyv6AzRFjCGCXsiwa5IXB51oDo0GY0H9+VuMrFtFcXmw/6anM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGIPkLRA; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-462ebd5d37dso3434496f8f.1
        for <linux-wireless@vger.kernel.org>; Sun, 21 Jun 2026 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029828; x=1782634628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xv8167L13PZ/JQZMUsJG/gGl8WHuMlNvKPvQHLdring=;
        b=IGIPkLRAKULhs6PPvfp54vjEI13GYwoqM7T6hUu9c0YfkBdgXqV693kxtcBpzMOeVs
         bTekNvAF2IBMV9XKtLoR3vaC+/z9rtRv0dpmmxKW/zb6eDtNH/oJcvCuyQgaBhVVJqbZ
         B22I/IMTgIocYy5xpss9U4Uq+j2D0iNk2opMm1kfM4A4wpmFZWOVIl4Zfp4QR3e62yxl
         At+XCDFbvoG/ZXs+VlJo2Ytqq+J0P1kwKm7brhY1JgFcBRi/4CZ2sb/TeIbOZ7ZJl7jN
         ZPrdqMcakXTSXomAF0FBoxsFpUdk/zkmJUDFZBHh4jdSrG2RbvVDDoxhIzyXA9DmSEed
         uCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029828; x=1782634628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xv8167L13PZ/JQZMUsJG/gGl8WHuMlNvKPvQHLdring=;
        b=l7+cpGnlZ7s7mPJAV7rarHLDR7QSMirCV1PN83eykkFmYfad3zdoymqlu29DS32fi7
         9WNc3LRInDzmFZ24/4/eAUQri0MQJPcYbYVmIwBG9f7ji1kAIUkF2zfca5rRt0qNbhPl
         ObOuyNfWn0/nutJ8rrp8HbLKaWcnUCE7XBeR5tfiyo9fQC8c92rOk0VMDAUCk0Xzb2q+
         8iaT3+ugCO98Kllxrq03EzvTw85WeU4YOq7g1ypWXyD9oysH7NeTJov2JH3QOBF8zDaQ
         gs7BuHy/kZjkhFN8RnrM4uRND+8FiSwC/ZLyz79KU7QaO3z56YIP8GXB/kwxcSLAJ3Ok
         zxbA==
X-Gm-Message-State: AOJu0YyzjStcA1V4vIoOwjnO1rPc+YTX23htm5POulqsDHcEAlP9yZ7G
	dio7oScrHH3Wm+8lMwygKrbM2wae5P8RjuAk7TvdZ9m2JRWml0tmXZiA
X-Gm-Gg: AfdE7clS2JL585d96/oiH2dwui1M0Ap5XhyaPouocxuVNmNgh5OCJPkD1fgmLzMgrtN
	FYVTsVYeYCr5zYkU0jLPnj5EgpX6dcWh675eQefJBMQiVlEuZnaF6RVM6eVIr7QVNkXN6UIOPqb
	5UzMdrbJz5OxcMhCh7CcpeZXMoOeRMWUFLJFdLhRXBL2pFBAeloeoRGxrcrSUlHJzNgVrw2yVNN
	KChYHLPwTqSPTHuC58Kgfh0X/eU8c2DJDNhnvfiZGjg+R+aMzl9b4OuIz5rtvXL5QBwaP0Ywm6H
	+YaPuvH/BG4N6J2O+SJu0gsfc8YAKCtmbVcg8PA/hUHKNPN6+Qna11NrmUQ8Eji2w5EjPfHQHgb
	CugKU5hg5XzpQ5XYh1XkyCL1stQrKymBQfJ3//jp1ck+oLe1pQtsD4tZYXjAo5w/at8UuMBfHUb
	F1hlRx9JZnY5TUH49RHF71Zj+NeR4K/FJ4wSEkCx7IuWOt6T/ZLwMLX1DyF+pp08lLs76EDeRA5
	o6Ryt74NWM=
X-Received: by 2002:adf:fc8c:0:b0:43f:e934:50ac with SMTP id ffacd0b85a97d-464fff62e1emr13858379f8f.7.1782029828081;
        Sun, 21 Jun 2026 01:17:08 -0700 (PDT)
Received: from shift (p200300d5ff229f0050f496fffe46beef.dip0.t-ipconnect.de. [2003:d5:ff22:9f00:50f4:96ff:fe46:beef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5ddbsm15917211f8f.12.2026.06.21.01.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:17:07 -0700 (PDT)
Received: from localhost ([127.0.0.1])
	by shift.daheim with esmtp (Exim 4.99.4)
	(envelope-from <chunkeey@gmail.com>)
	id 1wbDH4-000000002RS-40So;
	Sun, 21 Jun 2026 10:17:06 +0200
Message-ID: <a2bc98ef-fae5-4309-9066-452ee780fe04@gmail.com>
Date: Sun, 21 Jun 2026 10:17:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: carl9170: clamp command response copy to the read
 buffer size
To: Doruk Tan Ozturk <doruk@0sec.ai>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, kartikey406@gmail.com,
 Tristan Madani <tristmd@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260619224818.90751-1-doruk@0sec.ai>
Content-Language: de-DE, en-US
From: Christian Lamparter <chunkeey@gmail.com>
In-Reply-To: <20260619224818.90751-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37943-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[0sec.ai,googlemail.com,sipsolutions.net,oss.qualcomm.com,gmail.com];
	FORGED_SENDER(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:chunkeey@googlemail.com,m:johannes@sipsolutions.net,m:jeff.johnson@oss.qualcomm.com,m:kartikey406@gmail.com,m:tristmd@gmail.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:chunkeey@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chunkeey@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,appspotmail.com:email,0sec.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 263A76AA660

Hi,

On 6/20/26 12:48 AM, Doruk Tan Ozturk wrote:
> carl9170_cmd_callback() copies len - 4 bytes from the device command
> response into ar->readbuf, which was allocated by the caller with
> ar->readlen bytes. When the firmware/device returns a response whose
> payload is larger than the requested ar->readlen, the mismatch is only
> logged (and the device is restarted via carl9170_restart()); the code
> then still performs the full-length memcpy(), writing past the end of
> ar->readbuf -- an out-of-bounds write driven by an attacker-controlled
> (malicious/compromised) carl9170 USB device.
> 
> Clamp the copy to ar->readlen so an over-sized response can never write
> past the caller's buffer. A response that fails the length check is
> already discarded by the restart, so copying only the buffer-sized
> prefix changes nothing for the valid path.

This is contested territory.
<https://lore.kernel.org/linux-wireless/26e33fea-c81e-48f4-a058-4b3bf0dc95c5@gmail.com/>

Original patch (as part of a series is from Tristan Madani)
<https://lore.kernel.org/linux-wireless/20260421134929.325662-2-tristmd@gmail.com/>

Yes, I do think each came up with the patch individually. But I have no idea how
this works with three authors / tools? Does anyone? I don't think this will get
any better though.

> Reported-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Tested-by: syzbot+5c1ca6ccaa1215781cac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=5c1ca6ccaa1215781cac
> Fixes: a84fab3cbfdc ("carl9170: 802.11 rx/tx processing and usb backend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> Verified with syzbot via "#syz test" against the public C reproducer
> (Tested-by above); I do not have carl9170 hardware locally.
> 
>   drivers/net/wireless/ath/carl9170/rx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
> index 908c4c8..897e682 100644
> --- a/drivers/net/wireless/ath/carl9170/rx.c
> +++ b/drivers/net/wireless/ath/carl9170/rx.c
> @@ -150,7 +150,8 @@ static void carl9170_cmd_callback(struct ar9170 *ar, u32 len, void *buffer)
>   	spin_lock(&ar->cmd_lock);
>   	if (ar->readbuf) {
>   		if (len >= 4)
> -			memcpy(ar->readbuf, buffer + 4, len - 4);
> +			memcpy(ar->readbuf, buffer + 4,
> +			       min_t(unsigned int, len - 4, ar->readlen));
>   
>   		ar->readbuf = NULL;
>   	}

Regards,
Christian

