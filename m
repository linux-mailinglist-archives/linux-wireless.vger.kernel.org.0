Return-Path: <linux-wireless+bounces-12091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5C9616B8
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 20:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C711F25A6A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9653C08A;
	Tue, 27 Aug 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="cW22avvq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53D1D3655
	for <linux-wireless@vger.kernel.org>; Tue, 27 Aug 2024 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782644; cv=none; b=sq256h6s0aL5Vq73Oj5vJNm/eMljjUUpmqEj7whAAcfu9hAye+4f2KmnAIdbDKsqAB6ddlm+5utiuWjhivHNesVXbQdrjqlWd0KSG1pLhV9GtY1RO1Ot0EOgTx1Je6iwwRmFc3oaxW68HEWwW6ECvKcUQBOBKE7c+WGeeJOLreA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782644; c=relaxed/simple;
	bh=ff5YF/bxgtB9P+QVmHeYYNv/2Vy+acX/6Wsqv6t9DoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZQjpAU1sWgkRKCEMg4Pg/e+2YjVWAz2O0lffMhkS1qx+8YPg2VwFf2GF1R4mOWSck/LPM5VIy+zLbcXNW2/RsefUclm8kT2bevWlU7T+5yBfwlmRc9dqGqztWW74NmzbZZZT3U+K2Xc0WrW5iYR5vKS8AojQ6LXsTgKJukyyXRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=cW22avvq; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9D253C008E;
	Tue, 27 Aug 2024 18:17:14 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id BD81513C2B0;
	Tue, 27 Aug 2024 11:17:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BD81513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724782630;
	bh=ff5YF/bxgtB9P+QVmHeYYNv/2Vy+acX/6Wsqv6t9DoY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cW22avvqxqlO+gEIkjpuZMEYkF7c1UQ3RETOo97w3pH8/GY5W8kzASjnbLROm5uvm
	 5eURo9HpXEiniWs4s3Vhwo9kxjCbThGO2Iu56ezWxdUgm4W6gOUaJ5+P2VXEz5GCDH
	 jtdzd2oe08toNKBgWIoEH0fdZyMij0xbWaY4xv40=
Message-ID: <dd2c0158-775f-f876-6962-dba30d0bd16c@candelatech.com>
Date: Tue, 27 Aug 2024 11:17:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Per MLO link TX stats
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <c896c0d6-b43f-ba6d-336a-eca15c60529f@candelatech.com>
 <7ccb9c8ccb0dd16539ac064a35d6bf6b31d0bf0d.camel@sipsolutions.net>
 <e5c3265a-3411-39b4-f4c4-40f3937c96fb@candelatech.com>
 <9093726e308d0a26e8afe2323a865d222e48fe61.camel@sipsolutions.net>
 <41008ac0-ca36-b19f-c3a4-61f54ce2d2f7@candelatech.com>
 <b00a52947670f45c0764d33ea093c90b825fcdab.camel@sipsolutions.net>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <b00a52947670f45c0764d33ea093c90b825fcdab.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1724782635-qgIFAsz76pfj
X-MDID-O:
 us5;ut7;1724782635;qgIFAsz76pfj;<greearb@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff

On 8/27/24 09:41, Johannes Berg wrote:
> On Tue, 2024-08-27 at 09:28 -0700, Ben Greear wrote:
>> On 8/27/24 09:20, Johannes Berg wrote:
>>> On Tue, 2024-08-27 at 09:12 -0700, Ben Greear wrote:
>>>>
>>>> When be200 goes into eMLSR mode, both 5 and 6Ghz links are shown as active, so at least
>>>> you cannot use 'active link' to reliably update stats.
>>>
>>> Sure, not active link - but there's an LMAC bit somewhere ... Ah, it's
>>> not documented, it's actually documented *differently*, but it should be
>>> bit 31 in len_n_flags in struct iwl_rx_packet.
>>>
>>> Given the LMAC ID on the TX response notification we should know which
>>> LMAC transmitted it, and then I think it's a simple mapping to the
>>> active link. But I haven't actually really tried it.
>>
>> If you can share a patch that documents this bit (like 0 means 5Ghz and 1 means 6Ghz??)
>> then we can try it out.
> 
> I think yes, 5 GHz should be on LMAC 0 and 6 GHz on LMAC 1, and that's
> the only case where we can have two active links simultaneously.
> 
> There's still a race though, when we change the active links while
> transmitting, not sure how to handle that.
> 
> Oh wait, it's simpler than that - we have the STA pointer in there
> already (see iwl_mvm_rx_tx_cmd_single and iwl_mvm_rx_tx_cmd_agg), but
> since we get that from the FW STA ID, we obviously also know the *link*
> STA since the FW STA IDs are per link, so we can just go from there to
> the link ID directly.
> 
> link_sta = rcu_dereference(mvm->fw_id_to_link_sta[notif->sta_id]);
> 
> link_sta->link_id
> 
>> And maybe your idea for how to report it in tx-status too since that will touch
>> mac80211?
> 
> I hadn't really thought about that ... I guess we could use the
> IEEE80211_TX_CTRL_MLO_LINK space also for status? It's already filled to
> the link ID by mac80211 for TX if the frame must go out on a specific
> link (or 0xF otherwise which is an invalid link ID anyway.)

So, something like this (compile tested only at this point)?

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index e7cb6dcde182..92f7d0d34421 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1963,6 +1963,9 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
         u8 lq_color;
         u16 next_reclaimed, seq_ctl;
         bool is_ndp = false;
+       struct ieee80211_link_sta *link_sta;
+
+       link_sta = rcu_dereference(mvm->fw_id_to_link_sta[sta_id]);

         __skb_queue_head_init(&skbs);

@@ -1989,6 +1992,10 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,

                 memset(&info->status, 0, sizeof(info->status));
                 info->flags &= ~(IEEE80211_TX_STAT_ACK | IEEE80211_TX_STAT_TX_FILTERED);
+               if (link_sta) {
+                       info->control.flags &= ~(u32_encode_bits(0xF, IEEE80211_TX_CTRL_MLO_LINK));
+                       info->control.flags |= u32_encode_bits(link_sta->link_id, IEEE80211_TX_CTRL_MLO_LINK);
+               }

                 /* inform mac80211 about what happened with the frame */
                 switch (status & TX_STATUS_MSK) {

And something similar for the agg path....

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



