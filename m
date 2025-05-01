Return-Path: <linux-wireless+bounces-22314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6DAA65C9
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 23:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80DDD17340D
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218B1EFF81;
	Thu,  1 May 2025 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="SI3TUTNB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A22B18024
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135966; cv=none; b=hgfzjpA3cIZTUsB8GcWONdARNFQp3/VKrMPG4Jf9qNPVI4bVvriy1qho9pHF6KsNfrNaGDIwKmgEI/sJSdIDVwcESiW7NENAEn4NaFhwA41RYslMwXe9FuAdmUe9uQnTiiUU9BeYS2i7p2GYS0I1PtYTuuRvtVdn2OpffFLTJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135966; c=relaxed/simple;
	bh=PSE1LAkDDMjQiwMzNDZWzuYhdejlsgU3BuUUrrubvEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W2G5nxy5Gfg7k8Ac0N34YifIg5uroDoWO+wAigM/fbuD4I5UsSDgLxLDL+qcB/NCHsSiZdQVqZJCydrgJHcWYzbOGO/w0eLlUfD+e8GL2hz5kt7h8KwBWk06sfBgzxbAteosTsjPwChVUKVAfD9O3RtI1fWScsXO2nmj5fhlBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=SI3TUTNB; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A550B307E75
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 21:46:00 +0000 (UTC)
Received: from engine.ppe-hosted.com (unknown [10.110.50.131])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 34ED6600C2;
	Thu,  1 May 2025 21:45:54 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C11FF98009A;
	Thu,  1 May 2025 21:45:52 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BCABB13C2B0;
	Thu,  1 May 2025 14:45:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BCABB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1746135951;
	bh=PSE1LAkDDMjQiwMzNDZWzuYhdejlsgU3BuUUrrubvEI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SI3TUTNBYnmLqK6sf6um7KWrnOUKXeHzzENGYOLUqIL7svyr4uKBZO0V/oIK2XT4k
	 UL9OVU9yBXgMcDBFkYQSH1HBKZkVSv5TNhBLA/rXVmqBzp4CAOf47F+2mHYla1+j5o
	 qUAEoaBzZmpP/x2VS8vX6h0glIjS6BWbR9ypGUeQ=
Message-ID: <7783ae40-8d26-0dad-dd6b-591824cdfcdd@candelatech.com>
Date: Thu, 1 May 2025 14:45:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 23/24] wifi: mt76: mt7996: switch to single multi-radio
 wiphy
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20250102163508.52945-1-nbd@nbd.name>
 <20250102163508.52945-23-nbd@nbd.name>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250102163508.52945-23-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1746135953-lBMyZozZSbZj
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1746135953;lBMyZozZSbZj;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df
X-PPE-TRUSTED: V=1;DIR=OUT;

On 1/2/25 08:35, Felix Fietkau wrote:
> Use generic mt76 chanctx functions and look up phy from vif link.
> The driver now uses only a single phy to handle multiple interfaces on
> different channels. This is preparation for full MLO support.

Hello Felix,

Did you combine all of the antennas on purpose?

iw phy phy0 info
...
	Available Antennas: TX 0xf RX 0xf
	Configured Antennas: TX 0xfff RX 0xfff

I noticed this while trying to set antennas...it was failing because
the orig_chainmask is not always 0xf (it shifts by 4 for each phy it seems).

I guess this *might* let you use un-modified iw to set different radio's
antennas...but seems like a weird API to me.  I was in the middle of passing
in a 'radio-id', based on logic by Roopni in this series when I found this
weirdness.

Roopni's series to allow per-radio config:

wifi: cfg80211/mac80211: Set/get wiphy parameters on per-radio basis


> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   .../wireless/mediatek/mt76/mt7996/eeprom.c    |   1 +
>   .../net/wireless/mediatek/mt76/mt7996/init.c  | 252 ++++---
>   .../net/wireless/mediatek/mt76/mt7996/mac.c   |   6 +-
>   .../net/wireless/mediatek/mt76/mt7996/main.c  | 649 +++++++++++-------
>   .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  15 +-
>   .../net/wireless/mediatek/mt76/mt7996/mmio.c  |   3 +
>   .../wireless/mediatek/mt76/mt7996/mt7996.h    |  52 +-
>   7 files changed, 595 insertions(+), 383 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> index da94751df020..53dfac02f8af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> @@ -305,6 +305,7 @@ int mt7996_eeprom_parse_hw_cap(struct mt7996_dev *dev, struct mt7996_phy *phy)
>   
>   	mphy->antenna_mask = BIT(nss) - 1;
>   	mphy->chainmask = (BIT(path) - 1) << dev->chainshift[band_idx];
> +	phy->orig_chainmask = mphy->chainmask;
>   	dev->chainmask |= mphy->chainmask;
>   	if (band_idx < MT_BAND2)
>   		dev->chainshift[band_idx + 1] = dev->chainshift[band_idx] +
[snip]

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



