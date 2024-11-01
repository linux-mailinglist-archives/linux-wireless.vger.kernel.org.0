Return-Path: <linux-wireless+bounces-14839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7745B9B98C9
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 20:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C85D2832E1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BE61D0483;
	Fri,  1 Nov 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HIC5DfG/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C113B792;
	Fri,  1 Nov 2024 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489927; cv=none; b=ujZO4AxztSwurRVUTAGurdW0uY0tT1m2v/LDYe9dy9hAKn3ADu8LITm0IY1LiZGI5ntvsEfrosK0BqQCD642Ty4uz+yvjMUYZh1QaC6hpKWVCx4BdEvmg8AZuYIwcz3LHUnXAG0qzq5gSBQRssVOIlbQEESSO8ZOEIVmk8A2r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489927; c=relaxed/simple;
	bh=Rjjbs7ZhvWGIe2Ue6JNakMSpAbaSXtz4hUWX780SHFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnD0kFWrn5AYgp0tkNAHdTyqDjpF8wjzzm6nArieFrn7QGDpqwVECT+/dNALFo8iGLjzypsN/FwPxjQBeQKmBoeuDauaG09x4ntsbW/I86uNGB3RmGC40tC/LB0+90cL+ljhH1JpWtlA5NK2CkN6OMCiawQ17zGLEJTLI7Bze2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HIC5DfG/; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tjSFLxIAy9bkZ84NGGD1v+rV+6y6+8JQ+k+FRkhNNKY=; b=HIC5DfG/TbEZE8DnX/ysiM3/nt
	xx9A5eMSRdEa8/GZZR1jw2uHC2jCTkG22Z7pfApCMSKoXl0rmnHaFRoQQd1SCOfrUrG0/KNdSPcqS
	xuEAJJi4ahSRM5vgVhzg9QDuRdLglwGf/3SO3TTIzy9fIyiD/cUPHXq0dTNBlVNXvTkwme+Ps1cqe
	lwqupwKTl9PDe4xA74oJ+4BKJkOuVBnpFuVJLv3sML9yBo6hJZk3IukblyUZw46ZscLy6n+LhhciL
	bUy/TmSbxDGGVQmrzWeahke4RtzlaX948NX8VXQfR/RdsCFVfOA3qizmeF3pTzm9rKaxYZZn1iKWA
	cd5CCb9A==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6xTh-000YdB-Sd; Fri, 01 Nov 2024 20:38:38 +0100
Message-ID: <a7d85678-c242-6a92-55d3-bb593e508f28@igalia.com>
Date: Fri, 1 Nov 2024 16:38:32 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse in case of failures
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20241031155731.1253259-1-gpiccoli@igalia.com>
 <8363b94ee45c49c0996b12010c18b9f0@realtek.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <8363b94ee45c49c0996b12010c18b9f0@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> [...]
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       u16 retry, max_attempts;
>>         u32 value32;
>>         u8 readbyte;
>> -       u16 retry;
>> +
>> +       /*
>> +        * In case of USB devices, transfer speeds are limited, hence
>> +        * efuse I/O reads could be (way) slower. So, decrease (a lot)
>> +        * the read attempts in case of failures.
>> +        */
>> +       if (rtlpriv->rtlhal.interface == INTF_PCI)
>> +               max_attempts = 10000;
>> +       else
>> +               max_attempts = 10;
> 
> As your comment, setting max_atttempts to 10 under condition of INTF_USB would
> be more reasonable, like
> 
>     u16 max_attempts = 10000;
> 
>     if (rtlpriv->rtlhal.interface == INTF_USB)
>         max_attempts = 10;
> 

OK, thanks.

V4 just sent:
https://lore.kernel.org/r/20241101193412.1390391-1-gpiccoli@igalia.com





