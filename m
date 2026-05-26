Return-Path: <linux-wireless+bounces-36896-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHRGGu8VFWpoSgcAu9opvQ
	(envelope-from <linux-wireless+bounces-36896-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 05:39:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3345D0667
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 05:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66C0F300915C
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2026 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7716D391513;
	Tue, 26 May 2026 03:39:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89398397AFF
	for <linux-wireless@vger.kernel.org>; Tue, 26 May 2026 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779766765; cv=none; b=H2q94ABbMdm8tu8nVVEg7AcjztbKhopuxmMX2TGBqGpYE8YXDZMavu/RdA8Munkt2dJeWQBDEVTP1lBkQ2twjuqTjBQ1q5e5LVOZoRnxOc2H256RLjH7B7LcMZLQNeqe4FNLkl1JrmwacqBP7d89BIM7zRTQRQYWm7n427bGfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779766765; c=relaxed/simple;
	bh=XtiSO8QaIwpKLd8e8eYcVI0ifUfloh2ZhDUKh7Lmg4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jt69F0odubM1IURpHhFdHXGQ1WTOwKGljUNtDQWVtTNM8WqW0lV74+r+6uNI4iaUn6Oqgylz3b23f5Z4//bmWPeA24xzigUyGOVbDUTYJdHSxug8rp1xg6NEzuImuGJTEBH0pvuIFKKT4TIGiycZp/NgNoCAJ3qykFcmLOeEEeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from [IPV6:fdfe:dcba:9876::1] (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAA3zwbgFRVqb9QOAA--.14932S2;
	Tue, 26 May 2026 11:39:12 +0800 (CST)
Message-ID: <84aa4118-6120-49bf-bcc3-9f2d1219e799@lzu.edu.cn>
Date: Tue, 26 May 2026 11:39:12 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] wifi: mac80211: validate minstrel HT tx status rates
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "nbd@openwrt.org" <nbd@openwrt.org>,
 "linville@tuxdriver.com" <linville@tuxdriver.com>,
 "yuantan098@gmail.com" <yuantan098@gmail.com>,
 "zcliangcn@gmail.com" <zcliangcn@gmail.com>,
 "bird@lzu.edu.cn" <bird@lzu.edu.cn>,
 "xuyuqiabc@gmail.com" <xuyuqiabc@gmail.com>
References: <cover.1779619788.git.xuyq21@lenovo.com>
 <0e3f97ca5cfbeb67a8e60ca5c266f4335950816b.1779619788.git.xuyq21@lenovo.com>
 <710745062b5f4323a233db0cd4288ced@realtek.com>
Content-Language: en-US
From: Ren Wei <n05ec@lzu.edu.cn>
In-Reply-To: <710745062b5f4323a233db0cd4288ced@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQmowAA3zwbgFRVqb9QOAA--.14932S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw4UZrWkXF17CFyrAw47Arb_yoW8Xw1fpa
	y8GFyjvr95JrW8tFsrXF4rAF1fAr48J34fG34rtw1SvF9xtr43Grn2qr90vr4fWFsxuw1F
	va10krW3u3WayFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Cr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IY
	c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07j1rWrUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQETCWoUBk4M-AABsd
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36896-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,openwrt.org,tuxdriver.com,gmail.com,lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0E3345D0667
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/26/26 10:43, Ping-Ke Shih wrote:
> Ren Wei <n05ec@lzu.edu.cn> wrote:
>> @@ -1205,8 +1242,9 @@ minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
>>         if (!rate->count)
>>                 return false;
>>
>> -       if (rate->flags & IEEE80211_TX_RC_MCS ||
>> -           rate->flags & IEEE80211_TX_RC_VHT_MCS)
> 
> Miss a line?
> - 		return true;
> 
> 
>> +       if (rate->flags & IEEE80211_TX_RC_MCS ||
>> +           rate->flags & IEEE80211_TX_RC_VHT_MCS)
>> +               return minstrel_ht_txstat_valid_rate(rate);
>>
>>         for (i = 0; i < ARRAY_SIZE(mp->cck_rates); i++)
>> @@ -1235,8 +1273,9 @@ minstrel_ht_ri_txstat_valid(struct minstrel_priv *mp,
>>         if (!rate_status->try_count)
>>                 return false;
>>
>> -       if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
>> -           rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
> 
> Miss a line?
> 
> -		return true;
> 
>> +       if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
>> +           rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
>> +               return minstrel_ht_ri_txstat_valid_rate(&rate_status->rate_idx);
>>
>>         for (i = 0; i < ARRAY_SIZE(mp->cck_rates); i++) {
>> --
>> 2.54.0
>>

Yes, you're right, and I'm very sorry about this.

After generating the patch, we adjusted this part after finding
an issue, but I made a mistake in that follow-up change and ended
up changing it incorrectly here.

What should have been replaced in both places was the old
return true; line with the helper-based return.

I'll fix it in the next revision. Thank you for catching this,
and sorry for the trouble.


