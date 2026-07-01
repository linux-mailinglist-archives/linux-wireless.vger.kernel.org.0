Return-Path: <linux-wireless+bounces-38434-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id veUPNxeyRGp4zAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38434-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 08:22:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5AD6EA2B4
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 08:22:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=g4zUQNpf;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38434-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38434-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2429F3004DA9
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2781399015;
	Wed,  1 Jul 2026 06:22:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCD1CAA7D;
	Wed,  1 Jul 2026 06:22:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886929; cv=none; b=JjKcjMgF4IZCmKd5dp+uJPj/Ti/BQ/Kt3U5LqpYpLd5zALS53V/kVbVQWqg8ulw/yp5lrB4kk6yxhClLscvezLwBxn7GDwfzHa2+Xx6lHG0Q9DSEdsUEI8xUn1Hx85eYlNRk9XjV3rdog1t7thvcLx5HJ08sTdJq2nUD2NycbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886929; c=relaxed/simple;
	bh=rp90KJFs22SyjGf2Hk3J7Q7l91PBQxjIILxn6RvvY+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fy1rFibPZ/NMxNvVNuUlcqbajX7LTTIH/esyzd1lgX7IG+4dVPlUR9TotTVjAbUbwaE0Xtbaeve+k9fiY21vtSfgRL0uRBUvO5ryTsBlbsoLg3J7nr5lBP5B4Ht3ik2xNv1rOxBs3CYi9ukdcD1E2iY7eLzbSyVle9a+4Xug8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g4zUQNpf; arc=none smtp.client-ip=188.68.61.103
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gqqXC5GYNz8F0Z;
	Wed,  1 Jul 2026 08:16:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1782886571;
	bh=rp90KJFs22SyjGf2Hk3J7Q7l91PBQxjIILxn6RvvY+M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g4zUQNpfJa61aEi2tVmdwfjBlUEOaHTBD6TeHnpae3Gauuf3u499YLSwlxzx607z5
	 fxczv1T92tXpFjMgoZtRFJ/ik7KovZRl69bmFf0VQjxI+PV9EBEWruVWkc8N39LkwM
	 YA+G4JVW8J9reLpC8yKaWc9D0ZrLMwmOybv8i+mpqz+hvFGFz/H4oIIKqvnWogy4Lc
	 LCmwFml4B2ny64ZREkUfyKU3SYMFCytAdHYuFEQW9evW4cBMRBT6eFHZ9jV1LeXFq2
	 slmwUl9P2YWY4PbcSqGwYsLJCKFqEnE35SNCr1YgSOoM9QnXIKxAx7VhEUB9K9tAVT
	 7PL3R6rd9+fNQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4gqqXC4Y7Pz8F0W;
	Wed,  1 Jul 2026 08:16:11 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gqqXB0S2bz8sb0;
	Wed,  1 Jul 2026 08:16:10 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 79E145F961;
	Wed,  1 Jul 2026 08:16:08 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <dc7657b2-e3d5-4777-af52-1169fe743761@leemhuis.info>
Date: Wed, 1 Jul 2026 08:16:07 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: mt76: add wcid publish check in mt76_sta_add
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Jiajia Liu <liujiajia@kylinos.cn>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Leon Yen
 <leon.yen@mediatek.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20260528033814.46418-1-liujiajia@kylinos.cn>
 <b143b62e-ca11-4f00-ad60-f71ae55213b9@leemhuis.info>
 <akSoHk-BozrpWPmZ@nature>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <akSoHk-BozrpWPmZ@nature>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: 
 <178288656922.3967521.14789663261680188235@mxe9fb.netcup.net>
X-NC-CID: l2BgsPYJ/4KD2mWJhuqWjAbXGGXHzUV2LTla55HtmwPtd8pnV9s=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38434-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:nbd@nbd.name,m:lorenzo@kernel.org,m:liujiajia@kylinos.cn,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:mingyen.hsieh@mediatek.com,m:leon.yen@mediatek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:regressions@lists.linux.dev,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email];
	DMARC_NA(0.00)[leemhuis.info];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,kylinos.cn,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA5AD6EA2B4

On 7/1/26 07:39, Jiajia Liu wrote:
> On Tue, Jun 30, 2026 at 01:29:51PM +0200, Thorsten Leemhuis wrote:
>> On 5/28/26 05:38, Jiajia Liu wrote:
>>> Since mt7925_mac_sta_add publishes wcid, add publish check in mt76_sta_add
>>> to avoid reinitializing the wcid->poll_list.
>>>
>>> Found dev->sta_poll_list corruption when using mt7925 and 7.1-rc4.
>>
>> Jiajia Liu, Felox:

BTW: @Felix, sorry for the typo!

>> given that the problem seems to be in 7.1, should we
>> ask the stable team to pick this regression fix up, as this change was
>> mainlined (as 20b126920a259d ("wifi: mt76: add wcid publish check in
>> mt76_sta_add") [v7.2-rc1]), but lacks both a Fixes and a Stable tag?
> 
> Yes. It seems to be related to cbf5e61da660 ("wifi: mt76: initialize
> more wcid fields mt76_wcid_init") [v6.14-rc1]. But I didn't reproduce
> when I checked it out and tested. So Fixes was not added.

In that case:

@Stable team, you you please pick up 20b126920a259d ("wifi: mt76: add
wcid publish check in mt76_sta_add") [v7.2-rc1] for 7.1? It lacks a
fixes tag and the problem might be older, but I saw two reports about
this with 7.1-rc -- so it seems some recent change made that problem
more likely to occur, so it might be good to fix it at least in 7.1.y.

Ciao, Thorsten

>>> According to the corruption information, prev->next was changed to itself.
>>>
>>> wlan0: disconnect from AP 90:fb:5d:94:8b:e3 for new auth to 90:fb:5d:94:8b:e2
>>> wlan0: authenticate with 90:fb:5d:94:8b:e2 (local address=84:9e:56:9c:7e:6b)
>>> wlan0: send auth to 90:fb:5d:94:8b:e2 (try 1/3)
>>>  slab kmalloc-8k start ffff8c80958a6000 pointer offset 4160 size 8192
>>> list_add corruption. prev->next should be next (ffff8c808a7488f8), but was ffff8c80958a7040. (prev=ffff8c80958a7040).
>>>
>>>  mt76_wcid_add_poll+0x95/0xd0 [mt76]
>>>  mt7925_mac_add_txs.part.0+0xa5/0xe0 [mt7925_common]
>>>  mt7925_rx_check+0xa7/0xc0 [mt7925_common]
>>>  mt76_dma_rx_poll+0x50d/0x790 [mt76]
>>>  mt792x_poll_rx+0x52/0xe0 [mt792x_lib]
>>>
>>> Signed-off-by: Jiajia Liu <liujiajia@kylinos.cn>
>>> ---
>>>
>>> Changes in v2:
>>>   - use dev->wcid table instead of adding MT_WCID_FLAG_DRV_PUBLSH for
>>>     wcid publish check suggested by Sean
>>>   - subject and commit message update
>>>
>>> ---
>>>  drivers/net/wireless/mediatek/mt76/mac80211.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
>>> index 4ae5e4715a9c..b78b4cd206e0 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
>>> @@ -1576,6 +1576,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
>>>  {
>>>  	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
>>>  	struct mt76_dev *dev = phy->dev;
>>> +	struct mt76_wcid *published;
>>>  	int ret;
>>>  	int i;
>>>  
>>> @@ -1595,11 +1596,19 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
>>>  		mtxq->wcid = wcid->idx;
>>>  	}
>>>  
>>> -	ewma_signal_init(&wcid->rssi);
>>> -	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
>>> +	published = rcu_dereference_protected(dev->wcid[wcid->idx],
>>> +					      lockdep_is_held(&dev->mutex));
>>> +	if (published != wcid) {
>>> +		WARN_ON_ONCE(published);
>>> +		ewma_signal_init(&wcid->rssi);
>>> +		rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
>>> +		mt76_wcid_init(wcid, phy->band_idx);
>>> +	} else {
>>> +		wcid->phy_idx = phy->band_idx;
>>> +	}
>>> +
>>>  	phy->num_sta++;
>>>  
>>> -	mt76_wcid_init(wcid, phy->band_idx);
>>>  out:
>>>  	mutex_unlock(&dev->mutex);
>>>


