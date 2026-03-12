Return-Path: <linux-wireless+bounces-33151-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDJVB5PysmmLRAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33151-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:06:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E242765AE
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 18:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CE3330022E9
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 17:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CD83AA504;
	Thu, 12 Mar 2026 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhOJ3SMI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98F3FBED9
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 17:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335182; cv=none; b=u+ox7/nGYGWKStq5Z56vVhtZ8AF/tyuXv1QAC1SjrK/Mp5SEw7bxU82KH0oX5O4WcvJnq20a8n6EDYLPPdfi38fq+HtyuBVryfWzqXN5yjRTOYfzFXVrOoeX1giRLS8BDekLwGCqUHPpi3cb0hG3dsmLTpz1+gmTJ5RiCsR/IOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335182; c=relaxed/simple;
	bh=uY6gst47tFqN8YZ0l+9ZTPBv5nCDABKlGzvlClzI+xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlFxdoBBjny/ihS57UJW4BASPD6YPSurDRXMISU0YeeR2rs06mMIB0UZk1ZYvOpl6PcnRaRwMH+j3YwTkss2Br/Mzq4LDQ8ibrMcyY11Ab56IzK5qhM6e0Uer7eLQ4MPKjK7yfXhqnVd00z6k4wDATadKwH793y8K9WReAxNpns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhOJ3SMI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-660be63279bso3442602a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773335174; x=1773939974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zc0/XO1VtWeZp5Kp4LH4+ZSPoiQRfk4MoxjN2FBNgu8=;
        b=XhOJ3SMIQwLyPka+DYEhQxQBKu6qb4XhpdqJbNJdCCXVPejdHNv3aS5ai4mFISCYEO
         3TCXmchQq7i+PJ/TBkBMQqs1serhHVf0qF9c9/ywAJelz/1nrjTQhgDaaKhGNKfODcG5
         TgIVEISFtnSAqbSgbqCxa8NNDoAMk9zsiea+ihzsLSaG77/StCTf6O+LHP9Ow1ztqcW7
         NwymMv0QeoFTqKamrs8jGBMiuhuFMMrV6Z3snM1Mrp6td2eEz0Bx/3Mul5MVgqg+7LSe
         p4bpKHWt3F3Inhx/lWC2ZHjG2al/q+WeLPBd8EVe2toIcXGDWESwbvU/kL6mQ6vIt1D+
         FAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773335174; x=1773939974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zc0/XO1VtWeZp5Kp4LH4+ZSPoiQRfk4MoxjN2FBNgu8=;
        b=nNi6lZkmz3JcyBIkVj3Qb4GuXcNRyVKwV4jSSdNtJ3klfWJv8xocig3gm9yklWlS7z
         4fbRuweTVUvSOki7d6+hQGjCtu1qh3ESc/lHK9RJF9p8IICqoFb+j2pWz5MeZAv7judN
         xiwgnN4+3SnCa8feVF3JJO88bOHtwa9TVqdLzK88tf50eepFclrh3WPYQDpajjcPMmKD
         deIRVhHhoJWSTEqire+e5l5GrJbh9ReIxMDwe311GsdSheQzYu9qH0bkpFMMSTvb079P
         /UfUeOc3OH+sN93TRn0xlC43WxEc4pFKLX+UtmwW/ocN/Etnt9lPbix2VNL7049OiWNu
         pIBw==
X-Gm-Message-State: AOJu0Yzh3uTDDOcbyivrxXNbOfVR76y4jYH1Rpl4A4AY+bq8VFgRDH3t
	fo2UMNqloRP2ktIsN1uLQrgZj91LXNxtyPKvrPN4kIcadHrRm8JfonyK
X-Gm-Gg: ATEYQzxAhWsm7SrFxyEA0Rb1tT3oNFhXNPF2KkMiCor+SbrJ123NncJQSd+Iv9t7twO
	c7UYEktzRlnhpcSoj8ocgt0td+wZ2DPhl0rXG+q+MInKobZdFhucHnh0gL69Bnb4/J1+mmcRxqg
	ljSQ/c1+oXeaD7s9U5v3E2DREyNuc5GgBzHlEACxBwfQWgZCSZgz3m4UAd/D2kKCQ1FZmdXxqIJ
	1vmm3a1GQVeCBGHFsL5OsWdJ/0HoXjL29n2LUj5F/TU3o2I6qYz7XHG6syXcxz6UH25qiLjDS6A
	8kZGrdztTGdBK+v7/DiC/sx0joLj+JYbyPNQRnE6fk/oCoMZjckyi8T13GJlNDVF+LbesENUPtt
	TtguyKXnHU7RskBhyhE7KIGdf4hczbXJ9PRMZWSB61i7JAjNYR4MoL/roF8Fofi6HwoHvV9f01a
	3otSf5Bcv1+udoy4o/i/QRxcD2RYtZCw==
X-Received: by 2002:a17:907:7285:b0:b8e:fc90:7119 with SMTP id a640c23a62f3a-b974029896amr233987066b.30.1773335173945;
        Thu, 12 Mar 2026 10:06:13 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de092dcsm146613266b.4.2026.03.12.10.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 10:06:13 -0700 (PDT)
Message-ID: <d622184a-36b2-4df6-bea2-7f5c6ba9b22a@gmail.com>
Date: Thu, 12 Mar 2026 19:06:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Enable AP mode for RTL8188EU
To: =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Jes.Sorensen@gmail.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312142155.2642993-1-georgmueller@gmx.net>
 <093ad0f2-8265-4560-a51f-397eb34f7f1c@gmail.com>
 <98711825-cbf3-46ad-a26c-9f1d284480ac@gmx.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <98711825-cbf3-46ad-a26c-9f1d284480ac@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33151-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rtl8821cerfe2@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1E242765AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 18:08, Georg Müller wrote:
> 
> Am 12.03.26 um 16:58 schrieb Bitterblue Smith:
>> On 12/03/2026 16:21, Georg Müller wrote:
>>> Allow devices with this driver to be used as a wireless access point.
>>>
>>> I successfully tested this with a TP-Link TP-Link TL-WN725N adapter.
>>>
>>> Experiments two years ago failed, but some other improvements to the
>>> driver seemed to have resolved theses issues.
>>>
>>
>> The rate control code still doesn't handle more than one station.
>> It's not going to work right.
>>
>> It shouldn't be too complicated. The ra_info member of rtl8xxxu_priv
>> needs to become an array.
> 
> Ok, I have only tested it with one client in my setup.
> 
> So the ra_info array needs to of size max_macid_num?
> Dynamically allocated or hard-coded in struct rtl8xxxu_priv (8188e seems
> to be the only user of struct rtl8xxxu_ra_info)?
> 

Yes. :)

Also, if I remember correctly, there was a member of rtl8xxxu_ra_info
that needs to be moved to rtl8xxxu_priv, because it's a global thing,
not per macid.

> Best regards,
> Georg
> 


