Return-Path: <linux-wireless+bounces-34350-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D4heODIb0WkvFQcAu9opvQ
	(envelope-from <linux-wireless+bounces-34350-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 16:07:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB8F39B4E3
	for <lists+linux-wireless@lfdr.de>; Sat, 04 Apr 2026 16:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 623F63005316
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Apr 2026 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C132580F3;
	Sat,  4 Apr 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je1eAqgO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF421B9F5
	for <linux-wireless@vger.kernel.org>; Sat,  4 Apr 2026 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311659; cv=none; b=lTlRiSD4dtq5oHTcZI8zpHP93Rry04YNtDO+UiljXzolE5Prw224n/+v01d+rOFYYcrvWv7xYAjr55rYLqxerPPSZFENWGEQOzSCd3teaK5aCI+/yBZ737tk7dqe9G2Mhfxm/D5DQtywwUarP1iO0nEf6pXXdQkyVAIaXlSKhQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311659; c=relaxed/simple;
	bh=jknqINkRPUFpesQtH/4MgsVC/EU05LdVrrSPJsWq/Zk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MpLXBZvftlkk/iRD3kXqeCeUufBn6EmROOyT4Wn4Kr2dfZMwaRJAj/Y7OP7JQQsQK2TZhHxTK/bI21EY4jOnKIUX/K1hGB3EUIyxuooiplH/qLOW7ka/aALMsnCcrFnZ0zSmHnf8MjAAPpLC2yfO32kZoQkAaWkAFak3tvyQ/PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=je1eAqgO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso24184475e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 04 Apr 2026 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311656; x=1775916456; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VM4lYzot5gNIomL078Tcz8FVeq+iPj10V+2mQYXz0Qc=;
        b=je1eAqgOF5ZoWu0x5ShixSQNpW16Is0zyPZWsQsnnL7As6+2zom0GjDtS8sUJpG2LY
         /cpXagyuIiLev9/bBFABcKdt5n1ACozZvV0/H/UmSeEMmVe54eT+YYybfolq107KuEaC
         aWjCz5hmoNYUrtEhsBo4/AtOMK1QlUeC7lBL8iYkB0oL80prs8H6HvnvUVayTsmWTApB
         4Ti+3eGgvSDEDrZMvFGgklowsZM0V0Im+GTqEbff6HnEroacwViuV4B1XB4FJ6mctgaS
         yDLw4beLCm29c4CQPbUDWGBsEpltatxWa6yFIfrvl2biFfY1AldwBdyr9t1o4Cw16M/H
         WDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311656; x=1775916456;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM4lYzot5gNIomL078Tcz8FVeq+iPj10V+2mQYXz0Qc=;
        b=cD49tREqPK0G86QmSxGa5RdPS71oKJ5UWii6MZPmbL9wSRHobick1qEQ2HOqLlSvqi
         veQgjKCxysX4rYfo/2656GiWTrsM0OErDc1BeJ2nQAFl6B7Alm/5URrlZQt+rBgtbpV4
         zuJLAwgY1lA89V/uzfFesX371ALJu9AwGOitsa0Jc2arqEo0mTFiRcPFMz6OqW2AgZu4
         j1waGD8Xpv6hzzwGdMSh9T05FMpl4SjAWdGsQ43U4mytKR49fcW70SJqxY9fIkGI5rio
         AYC5FIHGAbA6M2R1iQUmtZpCD9eEiu7QeaRMhSO5VYQFnqB0oto9PcyL/AC90nufi/AI
         FCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfCu8uirt3fXauknvZtf8Rt5ieka8IuGifmMbHmazSj/KXTKXlSAuXumvx3tBOLq9+HD1cyZiSWw49PCw0BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNXE78M52s6yshqbcxCVvU+iCE19cpNmVZorMj1FcG9JGeQ9Lt
	b3ZIs4JZ3p2CWjZ59rvVDj80VCsh017Tnw86Cut+KwAjdGN6jvESHKT4
X-Gm-Gg: AeBDiestXdPv37O6o6FLjsRqqtyL6MhnLzBOrR/xfNKueH2D8Lml3eGWl4y05EX1uAR
	uharb4b/R5lT4LMCesztqTHaee8rR8cpiTthPLJLRfCnZVXZclpZogpZCpAXx/XmddUCqR16AAJ
	ukGCzvrMLGTqBxGi5nsr18ONbCtsNTSD2dsd5QJyAZxSroJHcxF8IFFKc59SyHJcMbFne0/H8yS
	ghg1tPSKFkg9qGtcXu7GaRfS77AMUuJ8ObVrApLnHlEDgdy/oBJPk1vR9m3wkdG3fS7NC6KVX1n
	je6r9AkRNBWyc6hQae/uDqK7t6Nluesk4Lc3IVGhySF2U1vylxIhXW1rzlNmACyrqvD+NMtTt0r
	Bt0Ikmhqvk9HG62xsLSobB9bQGiNdxt8vRctwj8yunanxOVsfVW2xIC3NsV8XiVn/lxD8dGd/6K
	GksiQv5uwLgHyxdyL1eXNZ0DQ9ny4Sqg==
X-Received: by 2002:a05:600c:c0c8:b0:47d:8479:78d5 with SMTP id 5b1f17b1804b1-488996d9c52mr74941785e9.7.1775311655958;
        Sat, 04 Apr 2026 07:07:35 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899ea0091sm43937605e9.28.2026.04.04.07.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Apr 2026 07:07:34 -0700 (PDT)
Message-ID: <f8a5d2ae-4129-4396-8261-5fffc8a72338@gmail.com>
Date: Sat, 4 Apr 2026 17:07:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 01/12] wifi: rtw89: usb: Disable MLO for now
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <8549233f-dd83-4e77-be88-5e22ecd4f5f1@gmail.com>
 <eb447efe-466d-4494-86c2-2e4d2b882fce@gmail.com>
 <dbd41cc160504b8daeb93b7967101c7f@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <dbd41cc160504b8daeb93b7967101c7f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34350-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9FB8F39B4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 30/03/2026 05:59, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> It's not yet clear how the TX queue/channel selection is supposed to
>> work for RTL8922AU with MLO, and I can't test MLO anyway.
> 
> Currently, rtw89 work in MLSR mode by default, which means it works like
> legacy mode, so it's probably fine to enable MLO.
> 

Someone tested MLO now (5 GHz + 6 GHz) so I will drop this patch from v2.

> The debugfs can switch eMLSR mode, but it doesn't work very well for now.
> 
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw89/usb.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c
>> b/drivers/net/wireless/realtek/rtw89/usb.c
>> index 581b8c05f930..7a46ace34c25 100644
>> --- a/drivers/net/wireless/realtek/rtw89/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
>> @@ -1029,6 +1029,10 @@ int rtw89_usb_probe(struct usb_interface *intf,
>>                 return -ENOMEM;
>>         }
>>
>> +       rtw89_debug(rtwdev, RTW89_DBG_CHAN,
>> +                   "%s: disable MLO for now\n", __func__);
>> +       rtwdev->support_mlo = false;
>> +
>>         rtwusb = rtw89_usb_priv(rtwdev);
>>         rtwusb->rtwdev = rtwdev;
>>         rtwusb->info = info->bus.usb;
>> --
>> 2.53.0
> 


