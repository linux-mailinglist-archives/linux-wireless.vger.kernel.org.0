Return-Path: <linux-wireless+bounces-31969-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INYNAZT4lWlMXgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31969-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 18:36:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F87D158589
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 18:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FEDF3002910
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Feb 2026 17:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11A334C09;
	Wed, 18 Feb 2026 17:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AY6jVCM5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC185334370
	for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436173; cv=none; b=uNGvzPAE7K0EFormUJnBwOiwhXV3bYpQpQZ+EGSlZ0lPpFlpxuN2jarfFulF+wLu9acNcugj+VhZuT0w2G6Mw9SGqm//NoEAQhWcYfegqAJnzbClLFxt/XW+q1uBl7PZ5fn6G9QmJxZilDJdn+XCuR8RFwCJ1ib1g4NtCR+jXJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436173; c=relaxed/simple;
	bh=leTGW6jZYsDeehjU+nTktkUORXmzublKWdkSSfGLNmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7E4ZK4/aYLTqU9Ru+IxbetYNKf7iMb987lVl2KX+W1/isVXd4VGSrvsrtG/qLbXJY+sPcqZvFwh3BvhaXgKaeqQcVWtv8GZCbI0dnK73Yn8Gwe3W05aIJTPFr5LC6YT0pAFwUinF5XTKoiAcZkRpQWgg4hdQPmAsW2ue+nPzSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AY6jVCM5; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4DDA734008E;
	Wed, 18 Feb 2026 17:35:53 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 015BD13C2B0;
	Wed, 18 Feb 2026 09:35:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 015BD13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1771436151;
	bh=leTGW6jZYsDeehjU+nTktkUORXmzublKWdkSSfGLNmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AY6jVCM5w6rUmuvB9EZl77NLDAUwAXdg+2m/MOuF61yGgm08VttQjnhXuRIrZu8bS
	 TmarWTU+Ntr0cl+haGBt/BlQp0UFoRGEv65RCUWJ/sKGiwW75O0LBjuQVQibCAUYQ0
	 itGt2IUZj+wf1zaWZzCs2EG00KaFagJ1tcleJ3AY=
Message-ID: <bd61ddcb-6b0e-f7c5-ba9b-e46124714dde@candelatech.com>
Date: Wed, 18 Feb 2026 09:35:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] wifi: iwlwifi: prevent NAPI processing after firmware
 error
Content-Language: en-US
To: Cole Leavitt <cole@unwrap.rs>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>
References: <c6f886d4-b9ed-48a6-9723-a738af055b64@candelatech.com>
 <20260214181018.6091-1-cole@unwrap.rs>
 <5be8a502-d53a-4cce-821f-202368c44f6d@candelatech.com>
 <20260214183306.10188-1-cole@unwrap.rs>
 <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <9edde56d-bfdc-40f6-862c-b69950cc2f25@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1771436154-v0z8jVeV3NIP
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1771436154;v0z8jVeV3NIP;<greearb@candelatech.com>;9db8dd06de60c557760218eb2301c105
X-PPE-TRUSTED: V=1;DIR=OUT;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[candelatech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[candelatech.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31969-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[candelatech.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greearb@candelatech.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,candelatech.com:mid,candelatech.com:dkim,candelatech.com:url,candelatech.com:email]
X-Rspamd-Queue-Id: 2F87D158589
X-Rspamd-Action: no action

On 2/18/26 09:17, Cole Leavitt wrote:
> Ben,
> 
> I've been digging into the use-after-free crash you reported on your
> BE200 running the MLD driver (tcp_shifted_skb refcount underflow,
> followed by NULL deref in tcp_rack_detect_loss). I think I found the
> root cause -- it's a missing guard in the MLD TSO segmentation path
> that lets num_subframes=0 reach skb_gso_segment(), producing the 32k+
> segment explosion you're seeing

Hello Cole,

Thanks for this, I'll take a closer look and test this out.

But also, I first saw this back in 2024, and that was before mld split from
mvm driver.  Possibly mvm added protection after I saw the problem and
that didn't make it into mld for some reason, or maybe there are other problems
as well.

Thanks,
Ben


> 
> Here's the full chain:
> 
> 1) mld/tlc.c:790 -- when firmware's TLC notification disables AMSDU for
>     a TID (bit not set in amsdu_enabled), the MLD driver sets:
> 
>       link_sta->agg.max_tid_amsdu_len[i] = 1;
> 
>     This sentinel value 1 means "AMSDU disabled on this TID".
> 
> 2) mld/tx.c:836-837 -- the TSO path checks:
> 
>       max_tid_amsdu_len = sta->cur->max_tid_amsdu_len[tid];
>       if (!max_tid_amsdu_len)   // <-- only catches zero, not 1
>           return iwl_tx_tso_segment(skb, 1, ...);
> 
>     Value 1 passes this check.
> 
> 3) mld/tx.c:847 -- the division produces zero:
> 
>       num_subframes = (1 + 2) / (1534 + 2) = 0
> 
>     Any max_tid_amsdu_len below ~1534 (one subframe) produces 0 here.
> 
> 4) iwl-utils.c:27 -- gso_size is set to zero:
> 
>       skb_shinfo(skb)->gso_size = num_subframes * mss = 0 * 1460 = 0
> 
> 5) iwl-utils.c:30 -- skb_gso_segment() with gso_size=0 creates 32001+
>     tiny segments, which is the error you're seeing:
> 
>       "skbuff: ERROR: Found more than 32000 packets in skb_segment"
>       "iwl-mvm-tx-tso-segment, list gso-segment list is huge: 32001"
> 
> 6) mld/tx.c:912-936 -- the loop queues ~1024 of those segments to the
>     TX ring before it fills up, then purges the rest. This creates a
>     massive burst of tiny frames that stress the BA completion path.
> 
> The MVM driver is immune because it checks mvmsta->amsdu_enabled (a
> separate bitmap) at tx.c:912 and tx.c:936 BEFORE ever reaching the
> num_subframes calculation. MLD has no equivalent -- it relies solely on
> max_tid_amsdu_len, and the sentinel value 1 slips through.
> 
> This explains all your observations:
> - 6.18 regression: BE200 moved from MVM (has guard) to MLD (no guard)
> - AP-specific: the problem AP causes firmware to disable AMSDU for the
>    active TID (other APs enable it, so max_tid_amsdu_len gets a proper
>    value from iwl_mld_get_amsdu_size_of_tid())
> - 28min gap between TSO explosion and UAF: the ~1024 micro-frame burst
>    creates massive alloc/free churn in the skb slab, which can corrupt
>    TCP retransmit queue entries allocated from the same cache
> - No firmware error: firmware is fine, the bug is purely in MLD's TSO
>    parameter calculation
> 
> Fix below. It adds a guard after the num_subframes calculation -- if
> it's zero, fall back to single-subframe TSO (num_subframes=1), which
> correctly sets gso_size=mss. This matches what MVM effectively does via
> its amsdu_enabled checks.
> 
> Could you test this against the problem AP? Two things that would help
> confirm the theory:
> 
> 1) Before applying the fix, add this debug print to see the actual
>     max_tid_amsdu_len value with the problem AP:
> 
>       // In iwl_mld_tx_tso_segment(), after line 847
>       if (!num_subframes)
>           pr_warn_once("iwlmld: num_subframes=0, max_tid_amsdu_len=%u "
>                        "subf_len=%u mss=%u\n",
>                        max_tid_amsdu_len, subf_len, mss);
> 
> 2) After applying the fix, run against the problem AP for 1+ day and
>     check if both the TSO explosion AND the UAF are gone.
> 
> I also noticed a few secondary defense-in-depth regressions in MLD's
> TX completion path vs MVM:
> 
> - MLD's iwl_mld_tx_reclaim_txq() has no per-TID reclaim tracking
>    (MVM has tid_data->next_reclaimed and validates tid_data->txq_id)
> - The transport-level reclaim_lock prevents direct double-free, but
>    MLD is missing MVM's extra safety checks
> 
> These are probably not directly causing your crash, but worth noting.
> 
> ---
>   drivers/net/wireless/intel/iwlwifi/mld/tx.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tx.c b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> index fbb672f4d8c7..1d47254a4148 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mld/tx.c
> @@ -846,6 +846,17 @@ static int iwl_mld_tx_tso_segment(struct iwl_mld *mld, struct sk_buff *skb,
>   	 */
>   	num_subframes = (max_tid_amsdu_len + pad) / (subf_len + pad);
>   
> +	/* If the AMSDU length limit is too small to fit even a single
> +	 * subframe (e.g. max_tid_amsdu_len is the sentinel value 1 set by
> +	 * the TLC notification when AMSDU is disabled for this TID), fall
> +	 * back to non-AMSDU TSO segmentation. Without this guard,
> +	 * num_subframes=0 causes gso_size=0 in iwl_tx_tso_segment(),
> +	 * which makes skb_gso_segment() produce tens of thousands of
> +	 * 1-byte segments, overloading the TX ring and completion path.
> +	 */
> +	if (!num_subframes)
> +		return iwl_tx_tso_segment(skb, 1, netdev_flags, mpdus_skbs);
> +
>   	if (sta->max_amsdu_subframes &&
>   	    num_subframes > sta->max_amsdu_subframes)
>   		num_subframes = sta->max_amsdu_subframes;

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



