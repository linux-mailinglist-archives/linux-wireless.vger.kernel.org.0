Return-Path: <linux-wireless+bounces-15810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE299DF68C
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF25162353
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Dec 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9F1D61AC;
	Sun,  1 Dec 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yX+sWY3U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35B33086;
	Sun,  1 Dec 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733073010; cv=none; b=e4R7zvaEAP3ASbMlXyw4Q+UG0VHHNpV9tX2uhoL+GmVeDji16hJmwOSYLa6YRrY7keUm5sgY7z7V44V54T42zgY4a2hpONFWsf3phZdxEm+PfplgI70qJ0vbP4si/rBUcB1H//3lduPc2y83aMnSrSw4J/gdgdobhjOX/e1Olpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733073010; c=relaxed/simple;
	bh=AHh6wZo9hURws++aV/42XxavFaokSvbg6imNNWwMBD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DiF6+bhz1olrC54E46qT7PVsjQVF+H8uMCGnh3wiiCjHW83GjKU1fjHgLjNwQFQmB4fj4PJKdyiwAqR3QhcB/9rOVK/gRCKKc0TQglBNKf3Lw3v+EqSeuTiOdB8RrNGlMpjXTttSm4X+ZVdtxcR1Ravud3hjiCCgZ1Ig/sfRysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yX+sWY3U; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B1H9gVu1591953
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 1 Dec 2024 11:09:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733072982;
	bh=oN/TNhxxv2ynjLBjJ9OZ5gYYDHMlfWmbssUcpigYGIQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yX+sWY3Uf57X38xrsL5qyWcxCiAuJIQ4SxT+dMZ47UNVMJA2eSF3+HbNQZZFZO45U
	 xHgDghmAbKwAkkiIW9NyBGnKKxbhsCIfxYsyRL0uWQ+Nkh+6KHU3fBC/FvrCtG9vPS
	 MY1vbgjwd69rNpCZEZeGF2ehHvq4Rs68kgoQm3YY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4B1H9gSL000899
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 1 Dec 2024 11:09:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 1
 Dec 2024 11:09:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 1 Dec 2024 11:09:42 -0600
Received: from [137.167.1.99] (lt5cg1094w5k.dhcp.ti.com [137.167.1.99])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B1H9cI6080016;
	Sun, 1 Dec 2024 11:09:39 -0600
Message-ID: <39af5076-7e96-4968-943d-bb33359f0573@ti.com>
Date: Sun, 1 Dec 2024 19:09:38 +0200
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
>> +static void cc33xx_rc_update_work(struct work_struct *work)
>> +{
>> +	struct cc33xx_vif *wlvif = container_of(work, struct cc33xx_vif,
>> +						rc_update_work);
>> +	struct cc33xx *cc = wlvif->cc;
>> +	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
>> +
>> +	mutex_lock(&cc->mutex);
> 
> Given the way the wiphy mutex now works, I'd strongly recommend not
> having your own mutex any more - it's a huge simplification in a lot of
> places, and there's very little downside since everything coming from
> higher layers holds the wiphy mutex already (and almost certainly needs
> to acquire your own mutex.)

Yeah I see how it simplifies things. I'll get rid of cc->mutex and use 
wiphy_lock() for whatever code that is not called exclusively from 
ieee80211_ops.

>> +static void cc33xx_recovery_work(struct work_struct *work)
>> +{
>> +	struct cc33xx *cc = container_of(work, struct cc33xx, recovery_work);
>> +	struct cc33xx_vif *wlvif;
>> +	struct ieee80211_vif *vif;
>> +
>> +	cc33xx_notice("CC33xx driver attempting recovery");
>> +
>> +	if (cc->conf.core.no_recovery) {
>> +		cc33xx_info("Recovery disabled by configuration, driver will not restart.");
>> +		return;
>> +	}
>> +
>> +	if (test_bit(CC33XX_FLAG_DRIVER_REMOVED, &cc->flags)) {
>> +		cc33xx_info("Driver being removed, recovery disabled");
>> +		return;
>> +	}
>> +
>> +	cc->state = CC33XX_STATE_RESTARTING;
>> +	set_bit(CC33XX_FLAG_RECOVERY_IN_PROGRESS, &cc->flags);
>> +
>> +	mutex_lock(&cc->mutex);
>> +	while (!list_empty(&cc->wlvif_list)) {
>> +		wlvif = list_first_entry(&cc->wlvif_list,
>> +					 struct cc33xx_vif, list);
>> +		vif = cc33xx_wlvif_to_vif(wlvif);
>> +
>> +		if (test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags))
>> +			ieee80211_connection_loss(vif);
>> +
>> +		__cc33xx_op_remove_interface(cc, vif, false);
>> +	}
>> +	mutex_unlock(&cc->mutex);
>> +
>> +	cc33xx_turn_off(cc);
>> +	msleep(500);
>> +
>> +	mutex_lock(&cc->mutex);
>> +	cc33xx_init_fw(cc);
>> +	mutex_unlock(&cc->mutex);
>> +
>> +	ieee80211_restart_hw(cc->hw);
>> +
>> +	mutex_lock(&cc->mutex);
>> +	clear_bit(CC33XX_FLAG_RECOVERY_IN_PROGRESS, &cc->flags);
>> +	mutex_unlock(&cc->mutex);
> 
> even more so with the awful locking/unlocking/... here (also no need to
> unlock to call restart_hw, I think?)
> 
> and using both a mutex and atomic ops seems ... odd?

cc33xx_turn_off() is called in the driver remove path so it expects the 
mutex to be unlocked while cc33xx_init_fw() touches many driver members 
and requires the lock.
OK if i keep it?

Mutex protection for the flags is indeed redundant and will be removed.

>> +unlock:
>> +	mutex_unlock(&cc->mutex);
>> +
>> +	cancel_work_sync(&wlvif->rc_update_work);
>> +	cancel_delayed_work_sync(&wlvif->connection_loss_work);
>> +	cancel_delayed_work_sync(&wlvif->channel_switch_work);
>> +	cancel_delayed_work_sync(&wlvif->pending_auth_complete_work);
>> +	cancel_delayed_work_sync(&wlvif->roc_timeout_work);
>> +
>> +	mutex_lock(&cc->mutex);
> 
> also this kind of thing ... just use wiphy mutex/work
>
Yeah all this work use cc->mutex so it seems safe, will do.

Thanks and regards,
Michael.

