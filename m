Return-Path: <linux-wireless+bounces-27784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E47FBB438C
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Oct 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BE55173D93
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Oct 2025 14:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36A86342;
	Thu,  2 Oct 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="QNWoBdJP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host1-snip4-9.eps.apple.com [57.103.79.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF23C1F
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416968; cv=none; b=GVCUaxL9DP46duHc8SpCHw6Pdxp0dEeK4CXo0tUI23pSrJBf41U9Gc7RvRW8aLHuBQXrQG4hKSqmyij/rSh5/5rseRUvvOlcK51lSfh8eQ8p0LvdCzPAmHCByAZuOW4s20lRPx192sjbyVHLrheU/9TmLioVnUCtPRRP+iJoE4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416968; c=relaxed/simple;
	bh=ccL40OwwL1lWRUtXPDnFzIcZ+gLzJ5Lnjp0deTTAOVE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WM2RwSEXy1Cdwd+PQllKcKz5J8ijcjKQvPC04n/IvvUjehKitChnM8dm2F14SkPnAyJAyQRXEGfaNX+Gejjft8e8BYoFuC1FiMJxuln/FC9Xuf7SpN9kS2qzJiZ6N4BVZnGjMBOIeDFANmusH60UB294F7f/W28tYqyvir+6wPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=QNWoBdJP; arc=none smtp.client-ip=57.103.79.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id D63311804A98
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 14:56:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; bh=mG4N4TjMfBFdPMK0O2aV2HPZNfFJ3ZUMS1Jq/KlC8tg=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=QNWoBdJPaNpZ6ekSEm5POWjksmLhH/rkbYvdR55y2dGKnv3Oq4b19SRsZ8OiR7MGZ7+r/g5mDh5dDRCnZLOduTmlTjtvkuLGF/YjWj01P5gQ9Zt/J1c7sgu9bT/L+OZvIBdn8m3CJRGTONBI0Q8ROk/un0vFcNTdQZI6oG6iY/RcvK2FBkE/maPTKqFvF7tS8d+bK1m69iGOpDDldAeUdu/MBzftVkv01kgqlIFIZGmEoyiW4XKM/q4iWA243ocvJKpbydJ59f42pOlAy7+EYAGU8SCPk+vFuAaDS4Gnxz/msahDcQrgLMBLXkoiBAZz2hZtscX5Z+USW+pYXeoQNQ==
Received: from [192.168.178.84] (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id 88ED21804326
	for <linux-wireless@vger.kernel.org>; Thu,  2 Oct 2025 14:52:29 +0000 (UTC)
Message-ID: <af5a5fc2-a7eb-4cb5-ae7e-b9513a7c7153@me.com>
Date: Thu, 2 Oct 2025 16:52:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-wireless@vger.kernel.org
From: Yannik Marchand <ymarchand@me.com>
Subject: Receiving broadcast data frames in AP mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDEyNyBTYWx0ZWRfXxoeCimFNXQqI
 BfpV/ewEYPEncb8FN2Qq5YHoIKVmU9pll6KgkfBP2hjiO1ZjkPZO4lbLHzpvdG2V4INvTDztB/5
 xx94kcdlZyKEJrsYK6jK48iT1DLZW1IQ6wsxQof39Edb7AvEc5MkZNxwQEP/DkPEmeg3I7Pkew1
 hFXtgD/tQVYuVV/w2zOigA9F81pQEkwFF2nZO3tGn0ZzYJ+i8myoC5mwCmu6Jc/KpT0YW8m8yfl
 x7273jxjyU7Pcm2MOhJd7BQxl9qWwfZo3Av6b9Yw4V5cyBf2ko9CvU/a5jrsGaoacj0A6HfHA=
X-Proofpoint-GUID: fFmV_qm8MArzevvnoLoS8U2qcsi4u4yw
X-Proofpoint-ORIG-GUID: fFmV_qm8MArzevvnoLoS8U2qcsi4u4yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 clxscore=1011 bulkscore=5 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=617 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510020127
X-JNJ: AAAAAAABHS6eaTbFBVZD7RFfpYL8HHoFhmI/U3Sc9lzo/aH4vXjlvKOVbXp+yayq6yW1WNa0YtyWAPTKGZaS+1x8SRE2Tiy45w7MBFyiQ0zhtFXD1mtJ7gct9i9hnfCyQUBWW3smt7G11xX2YsXBqWQJ/DLmHjj2mov4NtaRbQ+Qctu3/BaXi45WGYy8o2WOEEYYGpiuYZRXG+dPrTUjEMGt2A/eAdoLnyz0QZxJqGBVlkVs/Hw67OyuMQ4ph9KavYqBBAzXcmfVZ2wdefjuBh/b+mha1uydM83u5dKLmpVock9EHWXo1j7/hv2OdMLHyaSp/GfI2Tc1+5Lk11VlwW7/odphycSWH7s6KtSNxA2XFo+8if1RXCeJeEYR0PpeXveUwV5PCvJPLOyKPdf25BsACsOH55phTouevrRNCMaqqClifKPSpIn9VTkH0hnFcclZW1WDpn7oBYDMM440tNmIlRRtswleo/gcsefRbnzd30ow0/kwrEzFS3UgKcncqHGCdRjlhM+B4mW5UIsIXt/Tz8CYFonWz39mVIN8Wn1e7A65jGUOYdNPD52N7H/GQvDmKh07TjG0cqna8re0Tzrv6H+5S6p+nN0=

Hello,

I have been using nl80211 to implement local wireless communication with 
a Nintendo Switch device. The current implementation can be found here: 
https://github.com/kinnay/LDN.

We have run into the issue that we are not receiving any data frames in 
AP mode. In station mode it works fine. Inspecting the traffic with 
Wireshark in monitor mode showed that the data frames are being sent to 
the broadcast address ff:ff:ff:ff:ff:ff. Some research suggested that 
the Linux kernel might drop these packets by design: 
https://github.com/torvalds/linux/blob/7f7072574127c9e971cad83a0274e86f6275c0d5/net/mac80211/rx.c#L4443.

Currently, we are wondering if it is necessary to switch to adhoc mode. 
This would be inconvenient, as not all devices support adhoc mode, and I 
am also not sure how adhoc mode can be used correctly. We do need to 
send beacon frames, and process association requests, but 
NL80211_CMD_START_AP and NL80211_CMD_SET_BEACON seem to be unsupported 
in adhoc mode.

* Is it correct that there is no way to receive broadcast data frames in 
AP mode?
* Is there any documentation or example code on using adhoc mode with 
nl80211?
* Any general advice on moving forward?

Thanks,
Yannik Marchand

