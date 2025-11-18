Return-Path: <linux-wireless+bounces-29103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 840BDC69AB3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 14:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0D0094E545A
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 13:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECBD314B71;
	Tue, 18 Nov 2025 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="EaWuoPPM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD6272E63
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473629; cv=none; b=ck1K1PvbUxQ/5cQtJBBqE7AsmW/F6128jbzY8RxjUrJ5hVeipqhQUJBqk9wQEoFY9XMrdh+e+S1rVL+bCP9Wdz79v9ShtMZRFcH/YnzOsf2/pJBt6KiB6y0QquVvpK8xTWe87osoYcRbjfUd7ggqumr1PvRKiYvsiHhOMwU2McY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473629; c=relaxed/simple;
	bh=sbTMMRcluFhxnvXBtCbQbnIdE2VFQoxWHQEReREpyEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SUtfUFmCQCRl6PG9iueAAsLuTDz2e5bZEUEZjD53oGTzHozo8fIfhYwS13fiyeI0h8OqsW9SjQwlOPLB2fEeTxLlRdaVKHgmKWODFZ0v5ZhkK5YRGmUc85nF8og/xRDWhxFzrogHDVG9flZAse+m1T0uKRKQZUXuFQKxwHTdUZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=EaWuoPPM; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 934BB24008B;
	Tue, 18 Nov 2025 13:46:58 +0000 (UTC)
Received: from [172.18.0.200] (unknown [64.190.177.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0841013C2B0;
	Tue, 18 Nov 2025 05:46:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0841013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1763473616;
	bh=sbTMMRcluFhxnvXBtCbQbnIdE2VFQoxWHQEReREpyEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EaWuoPPMVxbgBAiYYHXg+Ytro7O/aYYaBYHxoqKhI6tQpj4kigTpSlFzbr7pf3pz8
	 3HyGmrkXK42qJlDVPReBr10PXFfMkUWQ6Sj3HBGNJRAu5rliNi/c2Kjwbm/uXsCMtx
	 rgTWqQ6FnnJZJiyawYAErF+6jYF0k5SxzcCEFMMw=
Message-ID: <c1557aad-e2ea-4a31-960b-16694569b4de@candelatech.com>
Date: Tue, 18 Nov 2025 05:46:48 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mt76: fix multi-radio on-channel scanning
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: Chad Monroe <chad@monroe.io>
References: <20251118102723.47997-1-nbd@nbd.name>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20251118102723.47997-1-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1763473619-RsI231lUZknR
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1763473619;RsI231lUZknR;<greearb@candelatech.com>;f011ffe4f9d64eb14099b4b464132aed
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/18/25 2:27 AM, Felix Fietkau wrote:
> From: Chad Monroe <chad@monroe.io>
> 
> avoid unnecessary channel switch when performing an on-channel scan
> using a multi-radio device.
> 
> Fixes: c56d6edebc1f ("wifi: mt76: mt7996: use emulated hardware scan support")
> Signed-off-by: Chad Monroe <chad@monroe.io>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   drivers/net/wireless/mediatek/mt76/scan.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
> index ff9176cdee3d..0b1922f7792e 100644
> --- a/drivers/net/wireless/mediatek/mt76/scan.c
> +++ b/drivers/net/wireless/mediatek/mt76/scan.c
> @@ -16,7 +16,7 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
>   
>   	clear_bit(MT76_SCANNING, &phy->state);
>   
> -	if (dev->scan.chan && phy->main_chandef.chan &&
> +	if (dev->scan.chan && phy->main_chandef.chan && phy->offchannel &&
>   	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
>   		mt76_set_channel(phy, &phy->main_chandef, false);
>   	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
> @@ -94,7 +94,7 @@ void mt76_scan_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	if (dev->scan.chan && phy->num_sta) {
> +	if (dev->scan.chan && phy->num_sta && phy->offchannel) {
>   		dev->scan.chan = NULL;
>   		mt76_set_channel(phy, &phy->main_chandef, false);
>   		goto out;
> @@ -102,20 +102,22 @@ void mt76_scan_work(struct work_struct *work)
>   
>   	dev->scan.chan = req->channels[dev->scan.chan_idx++];
>   	cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
> -	mt76_set_channel(phy, &chandef, true);
> +	if (dev->scan.chan != phy->main_chandef.chan)
> +		mt76_set_channel(phy, &chandef, true);

Do you still need to call the cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
method above if scan.chan == main_chandef.chan?

Thanks,
Ben

>   
>   	if (!req->n_ssids ||
>   	    chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR))
>   		goto out;
>   
> -	duration = HZ / 16; /* ~60 ms */
> +	if (phy->offchannel)
> +		duration = HZ / 16; /* ~60 ms */
>   	local_bh_disable();
>   	for (i = 0; i < req->n_ssids; i++)
>   		mt76_scan_send_probe(dev, &req->ssids[i]);
>   	local_bh_enable();
>   
>   out:
> -	if (dev->scan.chan)
> +	if (dev->scan.chan && phy->offchannel)
>   		duration = max_t(int, duration,
>   			         msecs_to_jiffies(req->duration +
>   						  (req->duration >> 5)));


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

