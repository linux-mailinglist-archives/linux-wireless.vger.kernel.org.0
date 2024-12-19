Return-Path: <linux-wireless+bounces-16635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD689F840C
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9221892250
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0EA1A0B12;
	Thu, 19 Dec 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="risBs+t5";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="YHTcjjO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2D19E985
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 19:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636135; cv=none; b=LS+oU8TYh2/Uj3bscTtACdm5O/TVXYUScJ5x7Sbz4zaVup42CgclI51b9/2khh8F0H7D+0Bfr2To1PAakMx3MBNHj5GOfzPo7CYiSJZCq6SMsoI90xqG41kM3M/YmZ36zCfXw9VUPPHNNHSLWqOhDdsfeJQJ7gJO3XQkVV7qVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636135; c=relaxed/simple;
	bh=rPVuhGFF70YApJ6RbVNqMuV3maX8zXBHSxE+vW/jsEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlgto0nGoJqJxrxQ6qjroRtlQT9e9LWPnsKjUyUDMhqbp5Y16uxoVAC6WCAdrXbXhs50OX+7uZWdC+7Nytpjfz1C2tiUhiCFjYHvlMu4X/setc6irAH2GPW4r5X8NstlPP19YFL7qkTn+iFk+2G66uENHN861TUTUapAabTsB0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=risBs+t5 reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=YHTcjjO9; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1734637031; h=Feedback-ID:
	X-Smtpcorp-Track:Message-ID:Subject:To:From:Date:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=Wp2L3uEUm7hSWsN+mutJbLRfBO2anB2NNVaERm/wx2w=; b=risBs+t5Vpil4ATPv2/25J4tgF
	M8l8dT6koRft8CGCZDu53nkBzm4GwzCCw+1K6f2pqEjlmcui6SIojsM9flwbr6KbhT3WI5W3F/g4S
	+Ta730y7OpSwlpEJ0sxCxS2k9KIGDIwYLMTC/sNdFGCb7IPYz/ww4itMBYl15Dfqym/fj8RycuND3
	tLyygNyFJZWYozgqcakZGkFG3pFl83g72Dtv6ZldWrfdpf8AhzA3nT1Yvyn94RfriJ98htsHdl36A
	mbIPdl3ha7cMNtGuuyzXVwYPLE2AW6d7D5TjpcWt9fdxwZ0GbRwF/HNrjt+cHYXOMyGmzpeAzpXrk
	tVYSYtJw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1734636131; h=from : subject
 : to : message-id : date;
 bh=Wp2L3uEUm7hSWsN+mutJbLRfBO2anB2NNVaERm/wx2w=;
 b=YHTcjjO97xZHVS+Ts/k1WzuA+5y9Z1ATx+cR6FzLdDTg8IkP+IozXdYhoVdQuCIV+8JP+
 z9hr4whh6NrWK5tKq2pztyfiHRmSjftCzEcXKn0UpBOX8I1pxDLlJ82fsHxv4vLInX76HxV
 2OQDhK8EBHTkDU+BBmTGCuaUHOP9ZJYiU2P0yDyUYP0NYHf6CKAFUgO6Gkb4bGppNSq+B1Q
 DKHbafmVWC5ZKDllUtjYS8jXDLLB+dsMsGfu2o3FCXTdzh2eOF4h+9cr79OtWSuHeBOHSKj
 nYWJ2dJFlNFsEjxvAtn0TLHqrq5/K/+8VJfGcFA6FO/bREp5v8qyqC6V+l1A==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tOIam-TRjxRX-Ql; Thu, 19 Dec 2024 15:37:36 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tOIam-AIkwcC8wN5I-J9DO; Thu, 19 Dec 2024 15:37:36 +0000
Date: Thu, 19 Dec 2024 16:35:24 +0100
From: Remi Pommarel <repk@triplefau.lt>
To: Steffen Moser <lists@steffen-moser.de>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: Potential Broadcast Issues After GTK Key Exchange on ath11k with
 IPQ8072A (QCN5024/QCN5054)
Message-ID: <Z2Q9POuV-6MIdzRf@pilgrim>
References: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6366409-9928-4dd7-bf7b-ba7fcf20eabf@steffen-moser.de>
X-Smtpcorp-Track: 36s7Ddms4J9w.xSO2PNeERdxD.0j4k2QTvcNf
Feedback-ID: 510616m:510616apGKSTK:510616sa-rS1axUN
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Hi Steffen.

On Thu, Dec 19, 2024 at 04:02:30PM +0100, Steffen Moser wrote:
> Hello everyone,
> 
> I've encountered a possible issue in a DD-WRT [1] setup where broadcast
> packets stop being delivered after a GTK (Group Temporal Key) exchange. This
> issue occurs on a system with the following hardware:
> 
>     Access Point Hardware: DynaLink DL-WRX36
>     Router Software: DD-WRT v3.0-r58819 std (12/13/24)
>     CPU: Qualcomm IPQ8072A
>     WiFi Chips: Qualcomm QCN5024 and Qualcomm QCN5054
>     WiFi Driver: ath11k
>     Firmware: WLAN.HK.2.12-01460-QCAHKSWPL_SILICONZ-1
>     NSS FW version: NSS.FW.12.5-210-HK.R
>     Kernel: Linux WL-AP-EG 6.6.64-rt29 #1791 SMP Thu Dec 12 16:41:51 +07
> 2024 aarch64 DD-WRT
> 
> The behavior is such that after a GTK exchange, the AP can get into a "weird
> state". When being there, broadcast frames like ARP or mDNS are no longer
> reliably delivered to connected clients while unicasts come still through.
> In this "weird state", the channel quality (active time vs. busy time) goes
> down and latencies to the still reachable WIFI clients rise.

This looks a lot like an issue we hit a while back. There is this patch
[0] from Qualcomm's wlan-open repository. It is a revert of [1]. Using
that the issue was never reproduced. Maybe this can help.

Also adding ath11k list.

Regards.

-- 
Remi

[0]: https://git.codelinaro.org/clo/qsdk/oss/system/feeds/wlan-open/-/blob/win.wlan_host_opensource.3.0.r24/patches/ath11k/350-ath11k-Revert-clear-the-keys-properly-when-DISABLE_K.patch
[1]: commit 436a4e886598 ("ath11k: clear the keys properly via DISABLE_KEY")

> 
> I've come across a related bug report on GitHub that describes a similar
> issue:
> https://github.com/openwrt/openwrt/issues/9555#issuecomment-2433857175
> 
> Unfortunately, the GitHub discussion drifted towards various other possible
> bugs.
> 
> In the meantime, I have a done a lot of additional debugging, but I am
> coming to a dead end due to limited knowledge of the ath11k driver and
> firmware internals. Interestingly, the AP can get back from "weird state" to
> "normal state" after another GTK rekey event. I've seen this behavior only
> in the 5 GHz band, yet (using non-DFS-channels).
> 
> My questions to the Linux wireless experts and developers in this community:
> 
>  · Is such a behavior known with ath11k on IPQ8072A or on the mentioned WiFi
> chips (QCN5024/QCN5054)?
> 
>  · Could this be a driver or firmware issue that specifically arises after a
> GTK or even GMK exchange?
> 
>  · What can I do to debug it further? I've switched on debugging in
> "hostapd" in order to see the keying events. Are there more lower-level logs
> I can get from the WiFi chip and match to the latency and key exchange
> observations?
> 
>  · Are there any additional information I can/should deliver to give the
> devs more insight about this issue?
> 
> When exchanging the DynaLink DL-WRX36 AP by a Netgear R7800 AP (CPU: QCA
> IPQ8065), its predecessor, the problem is gone without touching any of the
> clients.
> 
> Thank you in advance for any insights or experiences regarding this issue.
> 
> Best regards,
> Steffen
> 
> [1] https://dd-wrt.com/
> 
> 
> -- 
> ✂-----------------------------------------------------------------------
> Dipl.-Inf. Steffen Moser                  Tel (Office): +49.731.50.32407
> School of Advanced Professional Studies       Ulm University, Room: 1013
> https://wissenschaftliche-weiterbildung.org/    Oberberghof 7, 89081 Ulm
> https://saps.uni-ulm.de/                                         Germany
> 

