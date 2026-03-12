Return-Path: <linux-wireless+bounces-33169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO9AFCk8s2nRTQAAu9opvQ
	(envelope-from <linux-wireless+bounces-33169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 23:20:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E04BD27AE53
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 23:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 727833064CF2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010F3B19B2;
	Thu, 12 Mar 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNvg4d54"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7A390229
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354021; cv=none; b=gh7Lx4YQ6Ag8+U1Zbg5pGD6crHIbwLFWB6Jyk0EzV5xtZCATbm5Kr+vCVmpTgKfwsoJdmgFztyh8Ka/EzP1SCgppky3DOsZtinDod1sqQ5F/1NoGiZ19zhUGknODTX8ozLUkYerpKbnWM9QnbwvC7+ARIv7vf08M0IiVUahbMRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354021; c=relaxed/simple;
	bh=T1XHhRL2R/hpbtwyNfm7iKRRsYOYICrgH4FOV8qeDY0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ifn5kT45RTpyYf8j9xbBYZYw6qSv0NANsD9n9OCv07JZGxxgVhpz8Cph0PSLcyQEFOtKjyaFenDtM6YTfzs49zgW1L8jUW7b5Kqm7gDWZFA8hhOR6E4AQ1hVPE0Z/phjst14AJP5Ygt+IC/gdysBfaqX081BlKpTAElQeHqz6k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNvg4d54; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so1279088f8f.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773354019; x=1773958819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MNc86vS2tVL/ewKuHsiNbTMgiVsR9VP1s0O6WWE49UE=;
        b=aNvg4d54PCvaPnOD8JEgybaO4zpFFg2IhL79o+0yNRc/JnffPLyH1TUJzMULIU93fS
         BcZAFyz/9mYzrmo1gleQMjDX7/cO9WMsDuwr+O7Idd6UTp0j3V8EfJM5L85mXKhAEMTd
         kRc4KaiHfdI2sBUbltHsyd2mKQv/9G0PJqfjljjhZoiZNcbEqBPrxF9xF05ifqz/koij
         l2ZVWvro7pXgLz0WvCgbo0MA23KOr9hPOQN5IWYRPuPQh0/Xpi3pCcqblv7VFmyYkBhF
         omjQEM4jRCgXrN+3N1yQpS6yubFUIYBgA04SpC9I7e8wq/8CR3cbxRLkn6TYgDK91/Y1
         msFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354019; x=1773958819;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNc86vS2tVL/ewKuHsiNbTMgiVsR9VP1s0O6WWE49UE=;
        b=TPce/7ky2UdeUKJg73jB0xow+Ncx0RMee75d7YXH/dpf8m3LUCaCsnXYhHXWjsHVwt
         4Tj1flTGJF7p0QONo15YrPLsfdgoGuES9rvTYEFvGrIHTxENdCp+IqemI+0e/HH3GN2e
         lX87zQrRQPeM0oOC9xaZ9eWC5HpB1f6McZJpbM/Q4VYlPAI7lGWdNbo2cGd0CeKgoyc7
         WmSDxp4D0Wu5dSKPh4LmCXN8uwVlU3K/oc1RcSoMyWQXIMNayRzMq53g/mlvzlddFVvH
         OptqCR1C2ohL2rcC/TzulZM/YDNHRpa7HyiG1u4XcSv/DJEm3H+/oyEi98o//CZXGfNF
         P3fQ==
X-Gm-Message-State: AOJu0YxContiX3dtOoVLrjDUfe2sTxNGGV42d8FKhofsTkkg33s1TaQk
	h9VaAcMZAAGdO1zsx8+k0WcxVeiGU1PXT0s1YordVOW5RMHv4npcM4iI
X-Gm-Gg: ATEYQzweC5zf0iLiGeJVZDN3Ju/ip9g52AMRgyc9e69Sli6YxitqlRgma/A1refMSWf
	xhDb+v+u+BHMTdG6OD/C3pe8UBtf7RgTasWILPEbXEZ6hjj4VNEcSUP301TnNwpE4+xks/2HwOi
	jpUZo7waFEyQ+bNHK2yOYqJGvxKibwydMxKLW/vLWvaTj5n6Y5FeatoxPy1OFAYXIeYfdwL8Gna
	BT80cw04EMXOI8fGw+k8s1xFVwr/vokgAIMZSIEk44uFETINZE7LUImZNjd2dzf2z1Dmkl/xIAx
	smlXWcSyWRvyvjWjl3JWGVluI+vgW3gnlck2gFpUnC92DFQWX85aekOxUBkTsDYU0KlGGXhnltt
	LY8Ln6wv76ZRDJ6wd76ucPZj3U2BzUknRZr2l1KMSEkdvdU5XNiTbrsd67MzR61yzJ+nR2SgD5x
	11yeToWD8IWI2yuURDs2MHRakAKUOj9w==
X-Received: by 2002:a05:6000:178b:b0:439:b9b0:6c3d with SMTP id ffacd0b85a97d-43a04dc4bf4mr2301975f8f.51.1773354018642;
        Thu, 12 Mar 2026 15:20:18 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe23afc5sm13104241f8f.39.2026.03.12.15.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 15:20:17 -0700 (PDT)
Message-ID: <95d34233-e5d4-43fc-9478-b9b46510b01a@gmail.com>
Date: Fri, 13 Mar 2026 00:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312142155.2642993-1-georgmueller@gmx.net>
 <093ad0f2-8265-4560-a51f-397eb34f7f1c@gmail.com>
 <98711825-cbf3-46ad-a26c-9f1d284480ac@gmx.net>
 <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
Content-Language: en-US
In-Reply-To: <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33169-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E04BD27AE53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 19:06, Bitterblue Smith wrote:
> On 12/03/2026 18:08, Georg Müller wrote:
>>
>> Am 12.03.26 um 16:58 schrieb Bitterblue Smith:
>>> On 12/03/2026 16:21, Georg Müller wrote:
>>>> Allow devices with this driver to be used as a wireless access point.
>>>>
>>>> I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.
>>>>
>>>> Experiments two years ago failed, but some other improvements to the
>>>> driver seemed to have resolved theses issues.
>>>>
>>>
>>> The rate control code still doesn't handle more than one station.
>>> It's not going to work right.
>>>
>>> It shouldn't be too complicated. The ra_info member of rtl8xxxu_priv
>>> needs to become an array.
>>
>> Ok, I have only tested it with one client in my setup.
>>
>> So the ra_info array needs to of size max_macid_num?
>> Dynamically allocated or hard-coded in struct rtl8xxxu_priv (8188e seems
>> to be the only user of struct rtl8xxxu_ra_info)?
>>
> 
> Yes. :)
> 
> Also, if I remember correctly, there was a member of rtl8xxxu_ra_info
> that needs to be moved to rtl8xxxu_priv, because it's a global thing,
> not per macid.
> 

Ah, we talked about it before:
https://lore.kernel.org/linux-wireless/938ae608-a865-4056-06de-c230d74e1847@gmail.com/

>> Best regards,
>> Georg
>>
> 


