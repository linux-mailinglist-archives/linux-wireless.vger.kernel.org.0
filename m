Return-Path: <linux-wireless+bounces-18247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01448A2425B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 19:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67DB57A1BE8
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20111482E7;
	Fri, 31 Jan 2025 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="NShJDffD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041E64315A
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738346691; cv=none; b=NbtChxoTSTxbSu3NagQaQbg1awHJ5eMTJGUuQ2VwOs8Odrv4GRi4n+pDqLzMdbPR6gvAkTLN8hMWHQAVqmRb/OyLvs8ITnMOh/5Srdcto/44UJlygVgp0IYxIbYpUF9Q1ebeMyAXr/4HW8wWe+epd9GK4ttAShmtnrz1equIAWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738346691; c=relaxed/simple;
	bh=kzi2clRgaP/mqJLo/UQVtFWNYmzcm2g51uE3CyeOGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BZY8nfDkCCpaXTvVQe29NacYU/q1PbDQTN9Sgu4wXOequw1TZlepQJnd6ob847QY3tyWQF0Z9f9fFlCb1f/yRIJWptVtJeapvKNJlJLUG0nsRacphaLwWTB2dOKN1lO63e3+9Zrs94Ap/9H30fv4AA/p4K3d4kt8mIVmDX8pr9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=NShJDffD; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <7771dd96-b388-4331-b7f0-2d8257f4b3fe@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738346678;
	bh=kzi2clRgaP/mqJLo/UQVtFWNYmzcm2g51uE3CyeOGi4=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=NShJDffD+GapNE19+1FDh8zM4Vm5MAecGxrWp9RhyWQCvFr7F4+Fc9VHsOoPCR6ap
	 pEPFmkQSKICYdr9q71IKMw22bln2qXH3620RE51RB67zOXtM/PAzQbC9An6PdCaIky
	 x3Bavpumw9+F65bB+MCypqRg2ewfTlniyhB8HMCs=
Date: Fri, 31 Jan 2025 19:04:37 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/13] wifi: mac80211: Add new TX queues to replace
 legacy TX
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
 <20250127162625.20747-7-Alexander@wetzel-home.de>
 <03d0cf2612d6bb5e4a6d5e50650be12c81702ffb.camel@sipsolutions.net>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <03d0cf2612d6bb5e4a6d5e50650be12c81702ffb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.01.25 08:55, Johannes Berg wrote:
...
>> +static void ieee80211_vif_txq_init(struct ieee80211_sub_if_data *sdata,
>> +				   int txq_offset, int txq_size, int num_queues)
>> +{
>> +	void *buffer = (char *)sdata + txq_offset;
> 
> That seems ... awkward at best, my first instinct would be to say this
> must be wrong.
> 
> Do we really need to do this dynamically just to save two a bit of
> memory for VLAN and (virtual) monitor interfaces?
> 
> Would probably be better to use pointers to a TXQ array instead of
> embedding them then, or otherwise just embed enough for all kinds of
> interfaces and just not use them.
> 

Allocating all TXQs always should be trivial. I just must find all the 
parts which care about that. __ieee80211_wake_txqs() e.q would try to 
wake the useless queues otherwise anyhow.

But I don't see a obvious simple way to avoid the awkward 
initialization. Just a complicated one...

Problem is, that the txqi's are allocated with the netdev priv area, 
behind sdata.

With the existing code that's just one offset:
	int size = ALIGN(sizeof(*sdata) + local>hw.vif_data_size,
			 sizeof(void *));
...
		sdata = netdev_priv(ndev);
...
  		if (txq_size) {
			txqi = netdev_priv(ndev) + size;
			ieee80211_txq_init(sdata, NULL, txqi, 0);

The patch "repeats" that for the new TXQs.

Since txqi size depends on local->hw.txq_data_size (for driver private 
data) I don't see how that can be squeezed in a static struct or type.

So the only way I can think of to avoid something like
	void *buffer = (char *)sdata + txq_offset;
would require to allocate each txqi independently with kzalloc() outside 
of netdev private.

Is there maybe a simpler solution I'm missing here or is that what we 
should do here?

...

>> +static void __ieee80211_wake_txq(struct ieee80211_local *local,
>> +				 struct ieee80211_txq *txq)
>> +{
>> +	struct txq_info *txqi = to_txq_info(txq);
>> +	struct fq *fq = &local->fq;
>> +
>> +	if (WARN_ON(!txq))
>> +		return;
>> +	if (test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags)) {
>> +		spin_unlock(&fq->lock);
>> +		drv_wake_tx_queue(local, txqi);
>> +		spin_lock(&fq->lock);
>> +	}
>> +}
> 
> I really don't like dropping locks in the middle - if that's *really*
> needed there better be a very good reason and a good comment indicating
> why it's safe, including a comment in the caller that says this happens.
> 

Sure, I'll add some comments here.
But that's nothing new, just restructuring the existing 
__ieee80211_wake_txqs():
			if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY,
						&txqi->flags))
				continue;

			spin_unlock(&fq->lock);
			drv_wake_tx_queue(local, txqi);
			spin_lock(&fq->lock);
	
We can't hold fq->lock when calling drv_wake_tx_queue since since 
ieee80211_tx_dequeue() takes it, too.
And I assume the spinlock in  __ieee80211_wake_txqs() is required to 
make sure nobody will mark a queue as dirty while we are starting it and 
thus end up with a stuck queue.


>> +	/* %IEEE80211_VIF_TXQ_NOQUEUE must be ignored here */
> 
> No need for % outside kernel-doc.
> 
>> +
>> +	if (ac == IEEE80211_AC_VO) {
>> +		__ieee80211_wake_txq(local,
>> +				     vif->txq[IEEE80211_VIF_TXQ_FALLBACK]);
>> +	}
> 
> nit: no need for braces
> 
> Why is VO special, not sure I understand the logic of checking the AC?
> 
Guess that needs a comment, too:-)
This is not about that VO is somehow special. This is my decision to 
handle frames in the VIF fallback queue with VO priority.

The patch added fallback TXQs per-vif and per-sta. While we can ignore 
the new "noqueue" TXQs here - which is always directly TX a packet or 
drop it - the fallback queue can get dirty and must be started after 
that again.

The existing code is already something similar for the Multicast TXQ, 
just BE for that.

>> +	if (ac == IEEE80211_AC_BE && vif->txq[IEEE80211_VIF_TXQ_MULTICAST] &&
>> +	    (!ps || !atomic_read(&ps->num_sta_ps)))
>> +		__ieee80211_wake_txq(local,
>> +				     vif->txq[IEEE80211_VIF_TXQ_MULTICAST]);
> 
> Also here, why BE?
> 

And here is the "existing" code mentioned above. It basically was moved 
up from the end of __ieee80211_wake_txqs() and changed to work here.
(I moved it since once PS starts using this TXQ we better send out the 
queued frames here directly after the beacon and don't serve individual 
stations first.)

The old code was:

	if (!test_and_clear_bit(IEEE80211_TXQ_DIRTY, &txqi->flags) ||
	    (ps && atomic_read(&ps->num_sta_ps)) || ac != vif->txq->ac)
		goto out;

	spin_unlock(&fq->lock);

	drv_wake_tx_queue(local, txqi);
	local_bh_enable();
	return;

The old code was just using "ac != vif->txq->ac" to make sure we are 
working on BE. (The Multicast queue is set to IEEE80211_AC_BE in 
ieee80211_txq_init()).
I could always check the Fallback and Multicast TXQs if as matches to 
the current run. Just seems to be wasteful when these are fixed. Of 
course when someone decides to change the ac in ieee80211_txq_init() and 
not here they still run based on the old settings.

I'll keep the code but add some comments here, too.



>>   	list_for_each_entry_rcu(sta, &local->sta_list, list) {
>>   		if (sdata != sta->sdata)
>>   			continue;
>>   
>> -		for (i = 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
>> +		/* IEEE80211_TXQ_NOQUEUE must be ignored here. */
> 
> some of these comments should probably say _why_ too
> 

I'll update the comments to make it clear that these "noqueue" queues 
can't become dirty and thus don't need a wake.

Alexander

