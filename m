Return-Path: <linux-wireless+bounces-31219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G+uKoaaeGk9rQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:59:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5293446
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80353300B102
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C814344D98;
	Tue, 27 Jan 2026 10:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="BAkHs3kW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3443345CA2;
	Tue, 27 Jan 2026 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511555; cv=none; b=Cx+lBO+SGYepZUV8WLjfADdbW5Srr3fe+FovsFv3J8Bcw31qu3gHRjNT7+QJ/FlMIPpCmycF8HM6su28hgOTcjRsB3toaP+5chOKK3aDHjgXFt138RCyiczNfA8TmErf/j87GUfBf2FveavdmD0H7BvlUAg+l9lfFfktbQ6cOQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511555; c=relaxed/simple;
	bh=qZkTdx2Qt1odHBohN8Wn+d6UUfW74odeVPUEwY8rbd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jV04EdvyBMTeQGVStVv71xlgfxNuMpNqSMncIRGbp9Yz1ggwQd1cth1pY6915lI6DjeyZVNFakP/lpqOKnMH3W/uNDkeGD2WfCxhSVdCmX80TKtTFCjh5PCqvKEd7Zpnxp3NriONEscxVTyr/cHhyOygFnnl0UhFoh5nAwWltE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=BAkHs3kW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pBcKfGEm0HX448WXDFbLuVJe8IgT3W1pTsRj6aILCN4=; b=BAkHs3kWnd8woq3FttRZV9IrVs
	cH2I0cTUOEf4X1fAugTiE/BA4SdtUTsy3O9B4TVL21eh9LMTyUHhmi7UY3Q0asvnR18VBTyDbLVzF
	rBE1oZz5cYlU3YIP8KVJ9J/ExJ7iFZyBKq5CP5ZwBSiuHtUndSYLFYdivD79Ycc6I3sc=;
Received: from p54a43f8f.dip0.t-ipconnect.de ([84.164.63.143] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1vkgmr-00BWf9-0L;
	Tue, 27 Jan 2026 11:59:09 +0100
Message-ID: <a1113ede-9575-433f-a9d4-f8e9c1c6f8ab@nbd.name>
Date: Tue, 27 Jan 2026 11:59:08 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] wifi: mt76: mt7921: add mutex protection in
 critical paths
To: Zac <zac@zacbowling.com>, sean.wang@kernel.org
Cc: deren.wu@mediatek.com, kvalo@kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux@frame.work, lorenzo@kernel.org, ryder.lee@mediatek.com,
 sean.wang@mediatek.com, zbowling@gmail.com
References: <CAGp9LzrcvW18xKFL-oF3wxRmb73G6PN59Y2NSA2E5idva1wtKg@mail.gmail.com>
 <20260120201043.38225-1-zac@zacbowling.com>
 <20260120201043.38225-5-zac@zacbowling.com>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20260120201043.38225-5-zac@zacbowling.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31219-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[mediatek.com,kernel.org,vger.kernel.org,lists.infradead.org,frame.work,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.816];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:mid,zacbowling.com:email]
X-Rspamd-Queue-Id: 14A5293446
X-Rspamd-Action: no action

On 20.01.26 21:10, Zac wrote:
> From: Zac Bowling <zac@zacbowling.com>
> 
> Add proper mutex protection for mt7921 driver operations that access
> hardware state without proper synchronization. This fixes multiple race
> conditions that can cause system instability.
> 
> Fixes added:
> 
> 1. mac.c: mt7921_mac_reset_work()
>     - Wrap ieee80211_iterate_active_interfaces() with mt792x_mutex
>     - The vif_connect_iter callback accesses hw_encap state
> 
> 2. main.c: mt7921_remain_on_channel()
>     - Remove mt792x_mutex_acquire/release around mt7925_set_channel_state()
>     - The function is already called with mutex held from mac80211
>     - This was causing double-lock deadlock
> 
> 3. main.c: mt7921_cancel_remain_on_channel()
>     - Remove mt792x_mutex_acquire/release
>     - Function is called from mac80211 with mutex already held
> 
> 4. pci.c: mt7921_pci_pm_complete()
>     - Remove mt792x_mutex_acquire/release around ieee80211_iterate_active_interfaces
>     - This was causing deadlock as the vif connect iteration tries
>       to acquire the mutex again
> 
> 5. usb.c: mt7921_usb_pm_complete()
>     - Same fix as pci.c for USB driver path
Changelog should be below "---" after the commit description, so it 
doesn't get picked up.

> These changes prevent both missing mutex protection and mutex deadlocks
> in the mt7921 driver.
> 
> Fixes: 5c14a5f944b9 ("wifi: mt76: mt7921: introduce remain_on_channel support")
> Signed-off-by: Zac Bowling <zac@zacbowling.com>

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 5fae9a6e273c..196fcb1e2e94 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -373,6 +373,11 @@ void mt7921_roc_abort_sync(struct mt792x_dev *dev)
>   
>   	timer_delete_sync(&phy->roc_timer);
>   	cancel_work_sync(&phy->roc_work);
> +	/* Note: caller must hold mutex if ieee80211_iterate_interfaces is
> +	 * needed for ROC cleanup. Some call sites (like mt7921_mac_sta_remove)
> +	 * already hold the mutex via mt76_sta_remove(). For suspend paths,
> +	 * the mutex should be acquired before calling this function.
> +	 */
>   	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
>   		ieee80211_iterate_interfaces(mt76_hw(dev),
>   					     IEEE80211_IFACE_ITER_RESUME_ALL,
> @@ -619,6 +624,7 @@ void mt7921_set_runtime_pm(struct mt792x_dev *dev)
>   	bool monitor = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
>   
>   	pm->enable = pm->enable_user && !monitor;
> +	/* Note: caller (debugfs) must hold mutex before calling this function */
>   	ieee80211_iterate_active_interfaces(hw,
>   					    IEEE80211_IFACE_ITER_RESUME_ALL,
>   					    mt7921_pm_interface_iter, dev);
> @@ -765,6 +771,9 @@ mt7921_regd_set_6ghz_power_type(struct ieee80211_vif *vif, bool is_add)
>   	struct mt792x_dev *dev = phy->dev;
>   	u32 valid_vif_num = 0;
>   
> +	/* Note: caller (mt7921_mac_sta_add/remove via mt76_sta_add/remove)
> +	 * already holds dev->mt76.mutex, so we must not acquire it here.
> +	 */
>   	ieee80211_iterate_active_interfaces(mt76_hw(dev),
>   					    IEEE80211_IFACE_ITER_RESUME_ALL,
>   					    mt7921_calc_vif_num, &valid_vif_num);

It looks like these comments should be replaced with 
lockdep_assert_held, so that these assumptions can be verified 
automatically instead of doing so by hand.


> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> index ec9686183251..9f76b334b93d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -426,7 +426,9 @@ static int mt7921_pci_suspend(struct device *device)
>   	cancel_delayed_work_sync(&pm->ps_work);
>   	cancel_work_sync(&pm->wake_work);
>   
> +	mt792x_mutex_acquire(dev);
>   	mt7921_roc_abort_sync(dev);
> +	mt792x_mutex_release(dev);
The next patch is removing those...

- Felix

