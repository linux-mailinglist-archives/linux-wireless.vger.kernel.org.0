Return-Path: <linux-wireless+bounces-26462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3DB2CAB5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 19:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED483AB259
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Aug 2025 17:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E02E22BC;
	Tue, 19 Aug 2025 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="pmPTEtxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAB304989
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624987; cv=none; b=pLUhEGBz3b60iBJ6fncHfyZYJm5V598O40FiBJTTX/UH9gW1nCvG9jihDA5RD6LW3Nu4Eu81WHRxtmC8YBDXZzGLfHvfNxzxcTG/JGmGg4TXzdB6NH2AsN6OPuwGFLfUgOCY+omIfUKTbbUVYoZUg2dKZRvLzciyRdGBdKonwD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624987; c=relaxed/simple;
	bh=TP/uoNmKlWXTjZyXBaYgURRMp+6Qq/d+fBBO3uHTfEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pkiUzCsSUwMuwrprUgw+SjJP17CZUj/49gfl7RtpPTpfOGOCadcQPec7sKPN/bsi1dsrIr+/NnSNa9Y+fV32TOqJAhfrovMDwfgrFuQCvXmYSwqVuT5ohEkNUIDtt+88Y478sqGwSh59D1zQIUpdctxDkASBC9Lx9i4ZugSq+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=pmPTEtxL; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A268D30868B
	for <linux-wireless@vger.kernel.org>; Tue, 19 Aug 2025 17:27:39 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 635B32400C1;
	Tue, 19 Aug 2025 17:27:31 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 97CD013C2B0;
	Tue, 19 Aug 2025 10:27:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 97CD013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1755624450;
	bh=TP/uoNmKlWXTjZyXBaYgURRMp+6Qq/d+fBBO3uHTfEk=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=pmPTEtxLAgpImCQwciH4htnj5pvscaXALlgsPER3it4G369V+16VZzvxPBkxSmKu6
	 PqIenOVv6/45PlMMXPCW7dSU2HWpgBqLU/vJTARyEctyzvt8iT004J84JaBEbIHhMn
	 hHCqDkC8MmPw4APcm0CQ601SDtihbuaI5cQSYgQc=
Message-ID: <08f86ed0-32d8-5a8f-2beb-d885dba40232@candelatech.com>
Date: Tue, 19 Aug 2025 10:27:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] wifi: mt76: mt7996: disable beacons when going
 offchannel
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
References: <20250813121106.81559-1-nbd@nbd.name>
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20250813121106.81559-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1755624452-4jiqhcHHD6zE
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1755624452;4jiqhcHHD6zE;<greearb@candelatech.com>;340f598122f25443170ac9d27e6a82df
X-PPE-TRUSTED: V=1;DIR=OUT;

On 8/13/25 05:11, Felix Fietkau wrote:
> Avoid leaking beacons on unrelated channels during scanning/roc
> 
> Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
> Reported-by: Chad Monroe <chad.monroe@adtran.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   .../net/wireless/mediatek/mt76/mt7996/mac.c   | 46 +++++++++++--------
>   .../net/wireless/mediatek/mt76/mt7996/main.c  |  5 ++
>   .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 11 +++--
>   .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
>   4 files changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> index 6333a064c4f7..d3d3b96f7dd2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1698,17 +1698,37 @@ mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
>   static void
>   mt7996_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
>   {
> -	struct ieee80211_hw *hw = priv;
> +	struct ieee80211_bss_conf *link_conf;
> +	struct mt7996_phy *phy = priv;
> +	struct mt7996_dev *dev = phy->dev;
> +	unsigned int link_id;
> +
>   
>   	switch (vif->type) {
>   	case NL80211_IFTYPE_MESH_POINT:
>   	case NL80211_IFTYPE_ADHOC:
>   	case NL80211_IFTYPE_AP:
> -		mt7996_mcu_add_beacon(hw, vif, &vif->bss_conf);
>   		break;
>   	default:
> -		break;
> +		return;
>   	}
> +
> +	for_each_vif_active_link(vif, link_conf, link_id) {
> +		struct mt7996_vif_link *link;
> +
> +		link = mt7996_vif_link(dev, vif, link_id);
> +		if (link->phy != phy)
> +			continue;
> +
> +		mt7996_mcu_add_beacon(dev->mt76.hw, vif, link_conf);
> +	}

Hello Felix,

We attempted to backport this into our tree, and we found that 'link'
in the code above is NULL sometimes and we were seeing crashes.  Adding
a check for null seems to have fixed it.

Possibly this does not happen in upstream code, so just FYI.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



