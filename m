Return-Path: <linux-wireless+bounces-24448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3A5AE724D
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 00:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3E7916B52A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA52571B4;
	Tue, 24 Jun 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="HK6HrE7B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005386348;
	Tue, 24 Jun 2025 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804330; cv=none; b=P0AqUbey0QfpQrfeT3Ep+o7On6CZp4GxT5wxxEKAlHfkHMrp7N0/Hg0qvqlafgLj3SF4ynhV6V5fczZCXsOD9jqoVGkyZYd7VXIPNmLankZXyN0DofDjEzy7Sn37CkHtzWvPm2HV446fyjCiiGJ/FpORaCm0I+Gg+tVLqYSbx10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804330; c=relaxed/simple;
	bh=FXMPg63dVVmVrNKoRyj1dD2TlUtmMdIxd5+dbkGWnrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppjem92tppmC88u2TcxeVN19CxU0onbyH6U4MhurzWvl1b+Wnx3BiHLMx4ZwG1g/hCcA3jYnGxiuaptMDsj85FKqemB8vmnmOU60LDZaD2DoGCZbLFjkJlQY4D5MmsVxWg9m6fW9bQr1udpZi6lHuDNtmlqle7TOOQmK1Gy2h5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=HK6HrE7B; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BF224305A42;
	Tue, 24 Jun 2025 22:32:02 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E1C6D1800A0;
	Tue, 24 Jun 2025 22:31:54 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BD22D13C2B1;
	Tue, 24 Jun 2025 15:31:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BD22D13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1750804286;
	bh=FXMPg63dVVmVrNKoRyj1dD2TlUtmMdIxd5+dbkGWnrs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HK6HrE7B12KO2ZM8W73X7EyjXB73BpiuuneJO9iE5Qpu8Ws2Qf7dF3Nfq2XLgI7o4
	 sR0pdUdjSn1ZFWiqwc5kQXP6E+IqLJLvaYMbUhoLiLMCA98Gm7qIgLNckFRJTUuQMe
	 OxPVOfV8FNTGEX/Rsha/xcN7fZgIKZfML6WV9VkA=
Message-ID: <0bc6c957-a0c4-c0f7-ed37-c8b44852c26c@candelatech.com>
Date: Tue, 24 Jun 2025 15:31:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [DESIGN RFC] wifi: Robust AV streaming Design Proposal for AP
Content-Language: en-US
To: Ramanathan Choodamani <quic_rchoodam@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org, ath12k@lists.infradead.org
References: <20250624205716.1052329-1-quic_rchoodam@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250624205716.1052329-1-quic_rchoodam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1750804315-Wt0-nTYIyVjG
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1750804315;Wt0-nTYIyVjG;<greearb@candelatech.com>;42e86d0922d5c97226149d09277a2a40
X-PPE-TRUSTED: V=1;DIR=OUT;

On 6/24/25 13:57, Ramanathan Choodamani wrote:
> ===================================
> Robust AV streaming protocols - QoS
> ===================================
> 
> The Robust AV stream protocols are mobile centric protocols - meaning they
> are initiated by a non-AP STA to the AP. These protocols are implemented
> at the Access Point (AP) to classify packets sent to the non-AP STA which requests
> classification using action frames. The non-AP STA initiates Robust AV streaming
> action frames requesting for specific classification for the IP packets
> destined to the non-AP STA from the AP. These parameters can be negotiated by both
> AP and non-AP STA.
> 
> Upon successful handshake, The AP classifies incoming individually addressed MSDUs
> (Mac Service Data Unit) based upon parameters provided by the non-AP STA or
> notifies the non-AP STA to transmit MSDUs with preferred parameters based upon
> what was exchanged.
> 
> Robust AV streaming improves AV (Audio and Video) streaming performance when
> using IEEE Std 802.11 for consumer and enterprise applications.
> 
> Let's look at the Robust AV streaming protocols which are implemented as a
> part of this design.

Thank you for posting this and for the beautiful ascii diagrams!

Since this will be poking netfilter rules into the kernel,
is there a good way to clean up all rules created by a previous
hostapd process in case hostapd crashes or is killed hard and
cannot do its own cleanup?  Maybe the rules could have some
special marking that is configurable per hostapd (or per AP or BSS or something)
so that a (re)started hostapd could clean up any leftovers from a
previous instance?

And, is there a mechanism to clean up flows that a buggy non-AP STA
has requested but then forgot to terminate (like phone starts a video call,
requests some QoS, then forgets to tell AP that it is done with the call
and packets no longer need to be classified?)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



