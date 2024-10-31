Return-Path: <linux-wireless+bounces-14792-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151499B7F82
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415261C244AC
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2024 16:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1980013AA5F;
	Thu, 31 Oct 2024 16:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fX6s+lSk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F641B5338;
	Thu, 31 Oct 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390432; cv=none; b=N6eyq97eZnT2q7tT6l9QMmpvY6VcgPlcLNQ7jxiO4m80fHqskXhGTRNz45x2tQXMaIkWqYux8sU2+tNi7OCxHna+K2YmlNoCYpQ9DcF3idgrItvbOJXncZM0LnZPo+xzNsl7MM0TQxPAiZzkW2wEwT6xe/MhlA10NdhHYQuiHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390432; c=relaxed/simple;
	bh=xg053zDj0Ah4JZIrVRBSzRz2mRewoKq0digNZMauhYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1wsy4RMj5fF0zWRZLHaTqF4oId2RQ5H2qdzcFCAAGkH3I388ffsGXdXfo7SIfnPP++/1OtAwWLBvAPG61ripX5N7vvsbHCcQZoeZ6azmm9BYpBXSJojxnkgrCsglB4gMdJLvCpWnsjeq3IWRbCgTMbptMdl4CjamdEiOlWixLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fX6s+lSk; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0zRf1fq4KFIpSta+3YgUbvDwfoh/0Y8tnW+G7EbvCh0=; b=fX6s+lSk9uN69VhHsO6GAMEtYV
	Po0qvVK6AtmOhmu5nWWb9HosE2KQ7wNI3Laj8INzk3ItNzrcqSSLPVasAQ1+1+65DMkj9/B8VfiaV
	sot3am6WwoNKmpYLdvXVuT5w+OCbCQxQB4JAC2c9ynnqzanM/7DPetu1Ik8nYGja+TxiYDTueih/l
	A/5PdaxEp4ztccDORFSvQoA92gGriyN80zFrknKz+Lx5ns/NUDA6tuVbPADtrz9YCOzTCzLXEpU9w
	zZrItdgki+DMC/OQbd0RkBPUAvdFH/6tUda93wh+0qpSXCq1BOVwaJvA6eDL/Ue/fXw+C/Upu6fES
	3rjkzS/A==;
Received: from [189.79.117.125] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6Xaw-00059v-TI; Thu, 31 Oct 2024 17:00:23 +0100
Message-ID: <fcd4858d-244a-d491-7c22-4231a654ca81@igalia.com>
Date: Thu, 31 Oct 2024 13:00:16 -0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse in case of failures
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241030141440.1153887-1-gpiccoli@igalia.com>
 <4d9471f600224d23bb1f49a8ed4943c2@realtek.com>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <4d9471f600224d23bb1f49a8ed4943c2@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/10/2024 23:15, Ping-Ke Shih wrote:
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/efuse.c b/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> index 82cf5fb5175f..f741066c06de 100644
>> --- a/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> +++ b/drivers/net/wireless/realtek/rtlwifi/efuse.c
>> @@ -164,7 +164,17 @@ void read_efuse_byte(struct ieee80211_hw *hw, u16 _offset, u8 *pbuf)
>>         struct rtl_priv *rtlpriv = rtl_priv(hw);
>>         u32 value32;
>>         u8 readbyte;
>> -       u16 retry;
>> +       u16 retry, max_attempts;
>> +
> 
> Declarations should be in reverse X'mas tree order.
> Just add max_attempts to a new line at proper position. 

Thanks, V3 just sent:
https://lore.kernel.org/r/20241031155731.1253259-1-gpiccoli@igalia.com/

