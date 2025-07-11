Return-Path: <linux-wireless+bounces-25266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF10AB019A0
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 12:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F331C47A53
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 10:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FA5280334;
	Fri, 11 Jul 2025 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="S5otd6wn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF3279DC3;
	Fri, 11 Jul 2025 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752229437; cv=pass; b=cQuolIsnIpG/y8OVKgG64jyAo37LDutN/dljESuknjleloNpd/RZyGQCigRsdLMq/urgLZTJ6JIigJbsBTPLVdXXPkm4z6F79UP1KL7mE9nT8I1HJUzh5wzpz0lZa4vnPRBNUYDOvSi2hjdEzInnCC/w2quxwNjur8kgRxaxQss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752229437; c=relaxed/simple;
	bh=MaEHn4ZS+h4G0j0j/6sd8YL5XQ2qzJu1xIExkKd7hVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVt9jCm/kOpfkupqOy1qEdiugLv5815MF+gpK1NM1eqoFllaHlJ+wE9CImsLzlGMPDPwq6nR3JzEsOoLJMMlE5dHf8jvvXp6z2IOM6RNnGO/h95aS5rTFPXuNrX4ZBFWzDY7tzmqxnJ1B3Y/Whrqj9aaPwUndWITRLXtZYho7k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=S5otd6wn; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752229378; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M7MELwueo+pDvVX1BjPaUfNriLHYgEQiMPepAnEhGU8lnduTAkfVrh/Vbnyf5xn7jsl2eXVe1PLEXgxiVBVvenWsWlaES+nnPqYctBKn8RKu223PiN24g/eQsZshjelzFHq7irYMupDhnyx4w0Y4j4yA2WiyfQGlUhlasygtQPE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752229378; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jAKGNXRPSsQBS9PBfAgefKJ5F4HqERQrv2t3b/FvnM0=; 
	b=fQNgCMpZV+WrLdqSaE+K3Fx5QhaHOwt7S32G83/chYcXjHiiXpziqGIkHMUFn9TCaWRZvN83YFjh/C9L6cmgBACurr3RRfwzShcvlZPqLE3M0mHMyTznrFn3PZuBHkB9Y/JhbkdmaHthZCQBC+CMqMgRT9NN2kqPCo84Mhx1N8I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752229378;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jAKGNXRPSsQBS9PBfAgefKJ5F4HqERQrv2t3b/FvnM0=;
	b=S5otd6wn2juCVczBgAExMIDV3wP7LJnDTvGHOKi/8sZ6c/dMTVUmPIMi6eLaFYWM
	z69UAVQXvtR/C6ZNPlFGlgrm+Bii5fKVtP88blQwfuqb3pm5+QG7pQob2IoQSFODF3+
	u+6geucgt+ZSB963G/1jMF/1rJ8ue/VedZ/UeNyY=
Received: by mx.zohomail.com with SMTPS id 1752229375150633.1041346131241;
	Fri, 11 Jul 2025 03:22:55 -0700 (PDT)
Message-ID: <378575f3-a0be-44ec-99b0-2579bcc7f644@collabora.com>
Date: Fri, 11 Jul 2025 15:22:48 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
 <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
 <c40f13e8-7420-4046-880d-7c72620fc021@collabora.com>
 <304d71ca-5773-4fa6-aece-50f92b70c77f@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <304d71ca-5773-4fa6-aece-50f92b70c77f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

...
>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>> index 2e0f18c939e68..8f56e73fdc42e 100644
>>>> --- a/drivers/bus/mhi/host/init.c
>>>> +++ b/drivers/bus/mhi/host/init.c
>>>> @@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>>>>          mutex_lock(&mhi_cntrl->pm_mutex);
>>>>    -    ret = mhi_init_dev_ctxt(mhi_cntrl);
>>> mhi init dev ctxt also initializes the ring pointers to base value,
>>> I think we should take care of them also ?
>> Are you referring to mhi_rings? They are getting initialized inside
>> mhi_init_dev_ctxt() and de-initialized in __mhi_deinit_dev_ctxt(). That's
>> why I've not handled them separately.
>>
> Maybe I was not clear in my previous comment/not a correct place to do
> the comment.
> 
> My point you are not freeing __mhi_deinit_dev_ctxt as part of suspend,
> that means we are expecting device will continue to use the rp and wr pointers of ring as the previous i.e before suspend pointers.
> 
> What if PCIe keeps link in D3cold as part of system suspend, will the
> device able to handle the previous rp & wp of ring. I don't think
> device can handle this.
I don't have much internals logic of the driver. I've checked on my device and
the read/write pointers have 2 entries for mhi_event and 1 entry for mhi_cmd. But still
without resetting these, I've not got any problem. Any idea why?

I'll reset rings' read/write pointers in v2.



