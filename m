Return-Path: <linux-wireless+bounces-37313-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l20qI9YpH2pBiQAAu9opvQ
	(envelope-from <linux-wireless+bounces-37313-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 21:07:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A56314BB
	for <lists+linux-wireless@lfdr.de>; Tue, 02 Jun 2026 21:07:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=candelatech.com header.s=default header.b=FuTMALJR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37313-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37313-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=candelatech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07BF73021D30
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jun 2026 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56249351C09;
	Tue,  2 Jun 2026 19:07:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB72222C5
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 19:06:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427220; cv=none; b=Ucr/yrr1RubrwoCCDCtr0uJjeVRbfXdABIQs/Tted2gGPpmavUitzXi/mBdWiKS67z5uI9J/RsaTqrfMXyjDPQGWScoCMwC/WuquwMcOpail0LiHaPyfZSYLxgig+Rnlltqn3OD2FLf7dqtcG/nlc9IVrzWncil4lusXVFupWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427220; c=relaxed/simple;
	bh=4klqaW+qlOcvDydYV4JdaHYFzR0FqwPoLlkr0xdbJXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnZXo9VjxwRvLXo+OFBiF9FqwX22E3aM+P2xYgtvQ2tKGgpWSV0UQWapD1+ZE5PcYkS2CKpDrajzTmncve0hRs5UYe5tRWFuP71HJM4F68Sg4HcSgbVHrTJOst3Cx9ALN+Sp5esl/VW1dwAX5BiBH1mFErMSSSK0nTkPn6A3s/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FuTMALJR; arc=none smtp.client-ip=148.163.129.49
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CF6C32A461F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jun 2026 18:58:45 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 09C8DC008E;
	Tue,  2 Jun 2026 18:58:35 +0000 (UTC)
Received: from [192.168.101.118] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id E226313C2B0;
	Tue,  2 Jun 2026 11:58:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E226313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1780426713;
	bh=4klqaW+qlOcvDydYV4JdaHYFzR0FqwPoLlkr0xdbJXo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FuTMALJRvJrpeRqxwCThZVjQY1vWP0JxucKYuEVEbpTXjryKew/mrGPmokove/Nm1
	 OYWL2YcJxzwgKE5C319iRtRTubqsSYqCWyinBlUYNqJxyYqSul1p2qTE8HK0sr5sUM
	 MknIRjOF6wncVnkz05QoEHNSHhr6XwU8ke+sMuWY=
Message-ID: <80ff2108-dce3-4060-a8d0-59740979a99a@candelatech.com>
Date: Tue, 2 Jun 2026 11:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7996: Fix possible token leak in
 mt7996_tx_prepare_skb()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260531-mt7996_tx_prepare_skb-token-leack-v1-1-2b9c9f59ceb1@kernel.org>
Content-Language: en-US
From: Dylan Eskew <dylan.eskew@candelatech.com>
In-Reply-To: <20260531-mt7996_tx_prepare_skb-token-leack-v1-1-2b9c9f59ceb1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1780426717-WQhNphcM8TUz
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1780426717;WQhNphcM8TUz;<dylan.eskew@candelatech.com>;40f3b03bb24907b736a33b345f288e14
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37313-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dylan.eskew@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dylan.eskew@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 071A56314BB

Hi Lore,

We have been seeing the token memory leak in our custom kernel. After 
pulling your patch in, we are still getting the leak (validated with 
kmemleak). How did you figure out where this potential leak was? I want 
to determine if we are leaking because of our changes or if there's more 
areas for token leakage.

-- Dylan

On 5/31/26 2:10 AM, Lorenzo Bianconi wrote:
> If link_conf or link_sta lookup fails in mt7996_tx_prepare_skb routine,
> mt7996 driver leaks an already allocated tx token. Fix the issue
> releasing the token in case of error.
>
> Fixes: 7ef0c7ad735b0 ("wifi: mt76: mt7996: Implement MLD address translation for EAPOL")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>   drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
>   drivers/net/wireless/mediatek/mt76/tx.c         | 2 +-
>   2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> index c98446057282..8c56344d211b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1067,11 +1067,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>   
>   		link_conf = rcu_dereference(vif->link_conf[wcid->link_id]);
>   		if (!link_conf)
> -			return -EINVAL;
> +			goto error_relase_token;
>   
>   		link_sta = rcu_dereference(sta->link[wcid->link_id]);
>   		if (!link_sta)
> -			return -EINVAL;
> +			goto error_relase_token;
>   
>   		dma_sync_single_for_cpu(mdev->dma_dev, tx_info->buf[1].addr,
>   					tx_info->buf[1].len, DMA_TO_DEVICE);
> @@ -1176,6 +1176,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>   	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
>   
>   	return 0;
> +
> +error_relase_token:
> +	mt76_token_release(mdev, id, NULL);
> +	return -EINVAL;
>   }
>   
>   u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
> index 22f9690634c9..f96d9c471853 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -933,7 +933,7 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
>   #endif
>   	}
>   
> -	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
> +	if (wake && dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
>   	    dev->phy.q_tx[0]->blocked)
>   		*wake = true;
>   
>
> ---
> base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
> change-id: 20260531-mt7996_tx_prepare_skb-token-leack-82e240d8c66f
>
> Best regards,

