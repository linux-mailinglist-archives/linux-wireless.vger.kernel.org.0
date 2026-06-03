Return-Path: <linux-wireless+bounces-37360-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PbT2OihVIGo81QAAu9opvQ
	(envelope-from <linux-wireless+bounces-37360-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 18:24:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58834639AFF
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 18:24:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=candelatech.com header.s=default header.b="ltKjLR/T";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37360-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37360-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=candelatech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7672F302D956
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039383D1717;
	Wed,  3 Jun 2026 15:43:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723973AE1AD
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 15:43:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501430; cv=none; b=QudYfeZs5izG+ue3b+Ccg34NmMcqcXeF7iZqg7j9ms9n7Nh5Fh0W4FNFVkblNxVrSXS1ir+18aj8jj/PnI/6fsglZjLeRV0HknmtxoetmOKCOVqSiZVvnsxeTLa+pScO1DzR4FF4b1+spMCfgFxMP8AYBJi/+jq46IDAdngopJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501430; c=relaxed/simple;
	bh=hLgshgyS7YOQD8gzLaUT8Q0QxecehSkbR1QldyX3hdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAiRzkJDfpXRGGTcrCRipeBmohgkbMxkbB2jb+0q8k+9rWPMEhEtQdI9mXxTFcA4dsfjEUhjrH2o8RrrexhzJ9JOYhOg//khLKc8dR0ajg39hEEOibFUOgQtWYcMwJfRdji1kU9Vc2XAd/ctKpj5yk3t7SkhJXAz3qJFaRM6b3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=ltKjLR/T; arc=none smtp.client-ip=148.163.129.48
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id ECCE0A80092;
	Wed,  3 Jun 2026 15:43:44 +0000 (UTC)
Received: from [192.168.101.110] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 7C54313C2B0;
	Wed,  3 Jun 2026 08:43:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 7C54313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1780501422;
	bh=hLgshgyS7YOQD8gzLaUT8Q0QxecehSkbR1QldyX3hdE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ltKjLR/TkctAaphEbOismKYxMmiEtTw4a/WbAZf219lvTIoyYzW4KTLg87+C5FSQC
	 hE402zaAXw6i5OLokUqaiQZHw+8EgNmS0z8PMavM7bTK9FKkVxrytr/NLpWNl26Uvv
	 Cx6wqP6W43MdN7oiV2N6egC8MjQ/kpvlRWH0QS88=
Message-ID: <a8a4f908-f8f1-4cbc-9be5-bbf8e109743f@candelatech.com>
Date: Wed, 3 Jun 2026 08:43:42 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7996: Fix possible token leak in
 mt7996_tx_prepare_skb()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20260531-mt7996_tx_prepare_skb-token-leack-v1-1-2b9c9f59ceb1@kernel.org>
 <80ff2108-dce3-4060-a8d0-59740979a99a@candelatech.com>
 <ah_TG4bkzitM4AER@lore-desk>
Content-Language: en-US
From: Dylan Eskew <dylan.eskew@candelatech.com>
In-Reply-To: <ah_TG4bkzitM4AER@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1780501426-zW_PSR9LY7Sa
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1780501426;zW_PSR9LY7Sa;<dylan.eskew@candelatech.com>;40f3b03bb24907b736a33b345f288e14
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nbd.name,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-37360-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dylan.eskew@candelatech.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:nbd@nbd.name,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:linux-wireless@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dylan.eskew@candelatech.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:from_mime,candelatech.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58834639AFF

Hi Lore,

>> Hi Lore,
> Hi Dylan,
>
>> We have been seeing the token memory leak in our custom kernel. After
>> pulling your patch in, we are still getting the leak (validated with
>> kmemleak). How did you figure out where this potential leak was? I want to
>> determine if we are leaking because of our changes or if there's more areas
>> for token leakage.
> Can you please try to run kmemleak on Felix's tree to check if there are any
> leftover leaks not fixed yet?

Ran kmemleak with Felix's tree. I brought up only a few stations, no 
traffic run yet and kmemleak flagged a possible leak, same allocation 
location we've seen flagged in our custom kernel.

kmemleak trace:
```
unreferenced object 0xffff88811e6ca380 (size 128):
   comm "mt76-tx phy0", pid 1164, jiffies 4295044455
   hex dump (first 32 bytes):
     44 00 00 1a 0a a0 4c ae 0d 00 00 00 02 78 00 30 D.....L......x.0
     00 00 00 00 01 00 00 00 14 00 27 12 00 00 00 08 ..........'.....
   backtrace (crc fba2c5a3):
     __kmalloc_noprof+0x38e/0x480
     mt76_dma_tx_queue_skb+0x522/0x890 [mt76]
     __mt76_tx_queue_skb+0x3e/0xa0 [mt76]
     mt76_txq_schedule_pending_wcid+0x12b/0x200 [mt76]
     mt76_txq_schedule_pending+0x122/0x1b0 [mt76]
     mt76_tx_worker_run+0x1b/0xc0 [mt76]
     __mt76_worker_fn+0x49/0x90 [mt76]
     kthread+0xdc/0x110
     ret_from_fork+0x190/0x280
     ret_from_fork_asm+0x11/0x20
```

In dma.c, line 19 is the where the kmemleak trace points:
```
10 static struct mt76_txwi_cache *
11 mt76_alloc_txwi(struct mt76_dev *dev)
12 {
13         struct mt76_txwi_cache *t;
14         dma_addr_t addr;
15         u8 *txwi;
16         int size;
17
18         size = L1_CACHE_ALIGN(dev->drv->txwi_size + sizeof(*t));
19         txwi = kzalloc(size, GFP_ATOMIC);
20         if (!txwi)
21                 return NULL;
22
23         addr = dma_map_single(dev->dma_dev, txwi, dev->drv->txwi_size,
24                               DMA_TO_DEVICE);
25         if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
26                 kfree(txwi);
27                 return NULL;
28         }
29
30         t = (struct mt76_txwi_cache *)(txwi + dev->drv->txwi_size);
31         t->dma_addr = addr;
32
33         return t;
34 }
```

Let me know if you need any other information.

-- Dylan

>
> Regards,
> Lorenzo
>
>> -- Dylan
>>
>> On 5/31/26 2:10 AM, Lorenzo Bianconi wrote:
>>> If link_conf or link_sta lookup fails in mt7996_tx_prepare_skb routine,
>>> mt7996 driver leaks an already allocated tx token. Fix the issue
>>> releasing the token in case of error.
>>>
>>> Fixes: 7ef0c7ad735b0 ("wifi: mt76: mt7996: Implement MLD address translation for EAPOL")
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>    drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 8 ++++++--
>>>    drivers/net/wireless/mediatek/mt76/tx.c         | 2 +-
>>>    2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>>> index c98446057282..8c56344d211b 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
>>> @@ -1067,11 +1067,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>>>    		link_conf = rcu_dereference(vif->link_conf[wcid->link_id]);
>>>    		if (!link_conf)
>>> -			return -EINVAL;
>>> +			goto error_relase_token;
>>>    		link_sta = rcu_dereference(sta->link[wcid->link_id]);
>>>    		if (!link_sta)
>>> -			return -EINVAL;
>>> +			goto error_relase_token;
>>>    		dma_sync_single_for_cpu(mdev->dma_dev, tx_info->buf[1].addr,
>>>    					tx_info->buf[1].len, DMA_TO_DEVICE);
>>> @@ -1176,6 +1176,10 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
>>>    	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
>>>    	return 0;
>>> +
>>> +error_relase_token:
>>> +	mt76_token_release(mdev, id, NULL);
>>> +	return -EINVAL;
>>>    }
>>>    u32 mt7996_wed_init_buf(void *ptr, dma_addr_t phys, int token_id)
>>> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
>>> index 22f9690634c9..f96d9c471853 100644
>>> --- a/drivers/net/wireless/mediatek/mt76/tx.c
>>> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
>>> @@ -933,7 +933,7 @@ mt76_token_release(struct mt76_dev *dev, int token, bool *wake)
>>>    #endif
>>>    	}
>>> -	if (dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
>>> +	if (wake && dev->token_count < dev->token_size - MT76_TOKEN_FREE_THR &&
>>>    	    dev->phy.q_tx[0]->blocked)
>>>    		*wake = true;
>>>
>>> ---
>>> base-commit: 4913f44167cf35a9536e9eec7352e15b2de0c573
>>> change-id: 20260531-mt7996_tx_prepare_skb-token-leack-82e240d8c66f
>>>
>>> Best regards,

