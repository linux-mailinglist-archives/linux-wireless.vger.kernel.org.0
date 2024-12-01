Return-Path: <linux-wireless+bounces-15809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C679DF524
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6012811A0
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377D77E575;
	Sun,  1 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="poc+1Opg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CE70834;
	Sun,  1 Dec 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733046452; cv=none; b=jr/MfL8Hfu4AdooU7SBkFEY2/HRPPnikItkKFNMyQDTsX+JTfKR7wyE84xCcKm8F1MQpkpv2ltc6lEUYqoihceN9L0p2Vmr0R5xWTmDEn27yZzwwfyyKveDjfA8ylxeb0c6TT8G00jAjYX0rCRsdf1YPYIw5qu4LFncidfHuaM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733046452; c=relaxed/simple;
	bh=as5tR6OwsTVcSX5GRX3q+z9vBr6Wgj7yFmegZs8oYs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CmvVL4VvwGQxzgeEesUqb3iDiy35SH4mhKt7dWLZ8GoAMe2nWmiBDCQBzBI7j4NBZymDWjJOjtLf/5xP+mDTn7pUq/D6eIf3YcF9HW+kQQlicOrH+jL0efQsxhKReeNbb8DBYCWXM80N1U4qkw3XcqEVDQJg4TxU0cPn/JlB4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=poc+1Opg; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4B19l6HS036337;
	Sun, 1 Dec 2024 03:47:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733046426;
	bh=mX/4YXm19qrr2j4Z5gLyYBNF+BgxM8nmBWvl0k/FUHs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=poc+1OpgGHeGn2N7HxoqgWr0xsrc6KrrKmsrXQEgfK2VJinjszwQJ6syPntApacgO
	 Q3T6n7UmDisVeE/jsgtIjn45DCzIOSohPm26bP/SR9cy/YEiA1sC7VHR9vOC3bSp32
	 2Br4VMTFn9RhydIPC5f9DWHbjt4+2xmnqAM5D9BI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B19l6j2003143
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Dec 2024 03:47:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Dec 2024 03:47:05 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Dec 2024 03:47:05 -0600
Received: from [10.250.214.214] ([10.250.214.214])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B19l2q2015175;
	Sun, 1 Dec 2024 03:47:02 -0600
Message-ID: <b3446a0d-43e5-47ea-b3b0-f3e81d9c41c0@ti.com>
Date: Sun, 1 Dec 2024 11:47:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] wifi: cc33xx: Add main.c
To: Johannes Berg <johannes@sipsolutions.net>, Kalle Valo <kvalo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
 <20241107125209.1736277-10-michael.nemanov@ti.com>
 <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Language: en-US
From: "Nemanov, Michael" <michael.nemanov@ti.com>
In-Reply-To: <685d782d68bfc664c4fcc594dff96546ffc30e5f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/8/2024 1:42 PM, Johannes Berg wrote:
>> +static void cc33xx_op_tx(struct ieee80211_hw *hw,
>> +			 struct ieee80211_tx_control *control,
>> +			 struct sk_buff *skb)
>> +{
>> +	struct cc33xx *cc = hw->priv;
>> +	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
>> +	struct ieee80211_vif *vif = info->control.vif;
>> +	struct cc33xx_vif *wlvif = NULL;
>> +	enum cc33xx_queue_stop_reason stop_reason = CC33XX_QUEUE_STOP_REASON_WATERMARK;
>> +	unsigned long flags;
>> +	int q, mapping;
>> +	u8 hlid;
>> +
>> +	if (!vif) {
>> +		ieee80211_free_txskb(hw, skb);
>> +		return;
>> +	}
>> +
>> +	wlvif = cc33xx_vif_to_data(vif);
>> +	mapping = skb_get_queue_mapping(skb);
>> +	q = cc33xx_tx_get_queue(mapping);
>> +
>> +	hlid = cc33xx_tx_get_hlid(cc, wlvif, skb, control->sta);
>> +
>> +	spin_lock_irqsave(&cc->cc_lock, flags);
>> +
>> +	/* drop the packet if the link is invalid or the queue is stopped
>> +	 * for any reason but watermark. Watermark is a "soft"-stop so we
>> +	 * allow these packets through.
>> +	 */
>> +
>> +	if (hlid == CC33XX_INVALID_LINK_ID ||
>> +	    (!test_bit(hlid, wlvif->links_map)) ||
>> +	    (cc33xx_is_queue_stopped_locked(cc, wlvif, q) &&
>> +	    !cc33xx_is_queue_stopped_by_reason_locked(cc, wlvif, q,
>> +						      stop_reason))) {
>> +		cc33xx_debug(DEBUG_TX, "DROP skb hlid %d q %d ", hlid, q);
>> +		ieee80211_free_txskb(hw, skb);
>> +		goto out;
>> +	}
> 
> I'd consider converting to itxq APIs, you already use them anyway via
> ieee80211_handle_wake_tx_queue so you don't gain anything from not doing
> it, but you gain a lot of flexibility from doing it and don't have to do
> things like this?
> 
> It's not _that_ hard.

OK, so just to make sure I understand - mac80211 now has Tx queues per 
AC (struct ieee80211_txq) and it makes more sense to do something like 
ath10k ([1])?

Frames pushed via original Tx op are non-QoS traffic, right? (i.e, no 
need to worry about frame order between the two handlers)

Thank and regards,
Michael.

[1] 
https://elixir.bootlin.com/linux/v6.12/source/drivers/net/wireless/ath/ath10k/mac.c#L4728


