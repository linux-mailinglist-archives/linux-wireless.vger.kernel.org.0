Return-Path: <linux-wireless+bounces-24745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B444AF04A0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 22:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49EF7A1FE0
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jul 2025 20:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE85F2641FB;
	Tue,  1 Jul 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="CBGlmTAS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261821660D;
	Tue,  1 Jul 2025 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751401079; cv=none; b=OgF/j+v0cdmWAehWWa7YwS8zpYVpF5KUf3IIimp3DZrirZ+/hSem6MxmgEk8cMgKO0VMXyygGxu8UcUuoKQw+4v7FiSpfoBtYcEB12lfpkbPFzSgKYgnKzWp3Z01StOfm9aQ9nxPcfs4vudlxa7oP35AwA+mKsoFDfimz5xlgVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751401079; c=relaxed/simple;
	bh=XlitTrfvHOqrCzioarncmPUvFSxf/3wpOSSQGRNsKMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLRPsJ6U2mh4x8CgwVRBLuxodhUmoBjpJEDHEpGsUW5L+YtRts6RrYDIYnqYvDMMndg8OECCsTFkbH+J1iKhlOP7m7/WJMgaOYLjxCalaxQ0aB4W/f7VeAP90AoEP80gRDPzRDNInPBH2aysh4x01QUG+DVdgERitT7itLbGOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=CBGlmTAS; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 3839D8000A5;
	Tue,  1 Jul 2025 20:17:50 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0664D13C2B0;
	Tue,  1 Jul 2025 13:17:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0664D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1751401066;
	bh=XlitTrfvHOqrCzioarncmPUvFSxf/3wpOSSQGRNsKMw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CBGlmTASTOuty4t+WUurGRVcJBMiOcvoyMnOKA9uHSeNB8/wqBR8qlzk26f3EhEr4
	 SMTnHL17kLA8wwr5I8cx3GrIpUcRDdQNfi2AIDi1YAeYwa6Jn1b5h1LKh74FPyNUqG
	 e7x0sxk+eoQ+D75S4eTiyC14iAnuH7YQK1LtWu4I=
Message-ID: <65a4f2fe-7336-0116-6f32-4fcd2a8c4c72@candelatech.com>
Date: Tue, 1 Jul 2025 13:17:45 -0700
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
 <0bc6c957-a0c4-c0f7-ed37-c8b44852c26c@candelatech.com>
 <4d87c56e-f198-4abf-a414-4b226178d164@quicinc.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4d87c56e-f198-4abf-a414-4b226178d164@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1751401071-p7muVIt97cYT
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1751401071;p7muVIt97cYT;<greearb@candelatech.com>;42e86d0922d5c97226149d09277a2a40
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/1/25 12:38, Ramanathan Choodamani wrote:
> 
> 
> On 6/24/2025 3:31 PM, Ben Greear wrote:
>> On 6/24/25 13:57, Ramanathan Choodamani wrote:
>>> ===================================
>>> Robust AV streaming protocols - QoS
>>> ===================================
>>>
>>> The Robust AV stream protocols are mobile centric protocols - meaning they
>>> are initiated by a non-AP STA to the AP. These protocols are implemented
>>> at the Access Point (AP) to classify packets sent to the non-AP STA which requests
>>> classification using action frames. The non-AP STA initiates Robust AV streaming
>>> action frames requesting for specific classification for the IP packets
>>> destined to the non-AP STA from the AP. These parameters can be negotiated by both
>>> AP and non-AP STA.
>>>
>>> Upon successful handshake, The AP classifies incoming individually addressed MSDUs
>>> (Mac Service Data Unit) based upon parameters provided by the non-AP STA or
>>> notifies the non-AP STA to transmit MSDUs with preferred parameters based upon
>>> what was exchanged.
>>>
>>> Robust AV streaming improves AV (Audio and Video) streaming performance when
>>> using IEEE Std 802.11 for consumer and enterprise applications.
>>>
>>> Let's look at the Robust AV streaming protocols which are implemented as a
>>> part of this design.
>>
>> Thank you for posting this and for the beautiful ascii diagrams!
>>
>> Since this will be poking netfilter rules into the kernel,
>> is there a good way to clean up all rules created by a previous
>> hostapd process in case hostapd crashes or is killed hard and
>> cannot do its own cleanup?  Maybe the rules could have some
>> special marking that is configurable per hostapd (or per AP or BSS or something)
>> so that a (re)started hostapd could clean up any leftovers from a
>> previous instance?
>>
> hostapd does its own cleanup (cleanup of stations and interfaces)
> when it receives SIGTERM.

hostapd could crash without being able to clean up, though.
So I think you need a way to query the kernel's state and
clean it up in this case.

> An nft chain is created for each AP netdev/interface.
> 
> The nft rule handle (stored in internal hostapd data structure) and
> nft chain metadata can be used to cleanup/flush the nft rules as part of the
> interface cleanup.
> 
>> And, is there a mechanism to clean up flows that a buggy non-AP STA
>> has requested but then forgot to terminate (like phone starts a video call,
>> requests some QoS, then forgets to tell AP that it is done with the call
>> and packets no longer need to be classified?)
>>
>> Thanks,
>> Ben
>>
> The scs objects of the stations will be cleaned up during the station
> disconnect (by the AP which is maintaining them).
> As part of this deletion, the nft rules are also deleted, using the
> stored nft rule handle.

A station may be long lived, and it may be bad at cleaning up
its sessions, so the AP may end up with a large amount of classification rules
that are not actually needed, possibly slowing down performance
and/or limiting other stations from being able to add their own
flows.

Can you add time duration and/or detect idle flows and clean them
up automatically on the AP?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



