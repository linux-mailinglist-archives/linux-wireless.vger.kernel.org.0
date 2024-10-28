Return-Path: <linux-wireless+bounces-14616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC509B382C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F09C1C222BA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550A1552FC;
	Mon, 28 Oct 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="i+9uqQqD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47E1DF99E
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137700; cv=none; b=TE3DsK/mDa9v7qLyD+SMwMH3bdkg/ZTbjQQMMU/8CD1O65baCRRmkXhYXMii2mdWNjk+CHUbpeS70RTor5sFBKLY5dFI4zDzO2OMQlBqXzNbV7SQPqAEUbM2MDIQbu/5Jl625wGIIuRq61GM4l0vvtNlmTTvdbhI4mcD4R03HUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137700; c=relaxed/simple;
	bh=MKjze7Q16+9SgGwdVELAGxzvv+7lcDuq2TEmJTW//2E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GxRrU5bSk4yywnuWkMDlrnAKgUvhvKBnktyUjVsxKbXRC4Bw325yq/ag+n0jP2X+rPFUSwnXBLLvTeHJLk/NKGeMiiSUmI/i/2rmREkn9EJks2S09vmvYxVj3R+TirBYhnWKvUJDswnoUct9j4zk+5TFMMFCFyx5C2s3U/mFcbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=i+9uqQqD; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 96E1578006D
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 17:48:09 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0ED2A13C2B0
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 10:48:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0ED2A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1730137689;
	bh=MKjze7Q16+9SgGwdVELAGxzvv+7lcDuq2TEmJTW//2E=;
	h=Date:To:From:Subject:From;
	b=i+9uqQqDMQlpeLMsf0FMTv4oflECy4hMDa5L1enkT5sdo0VJ7CInYmgmeexQ90Mks
	 z6fo31CTy5ZoyzXej1JcA3iaq1/AdN+YAJMe3e1LJBO+b21c/5B2lNn+SCGCW29ZWL
	 VAC3qHFUVESN3MXKHv19cO/i118rST6Vf3hBQmao=
Message-ID: <8dce89a1-350c-4885-afcc-0eda162fd76c@candelatech.com>
Date: Mon, 28 Oct 2024 10:48:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-wireless <linux-wireless@vger.kernel.org>
From: Ben Greear <greearb@candelatech.com>
Subject: Question on iwlwifi iwl_mvm_mac_itxq_xmit, possible busy-spin.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1730137690-I5PPaM9KkapL
X-MDID-O:
 us5;ut7;1730137690;I5PPaM9KkapL;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

We see indication that the iwlwifi txpath can busy-spin,
causing soft-lockup (and, only indication at this point, possibly
issue is elsewhere somehow).

While looking through the xmit path for potential busy-spin bugs, I found
this method below.  I'm planning to add this 'sofar' logic to bail out after
1000 loops:  It is not in upstream code.

But, I also wanted to check on expected behaviour.  At the bottom is a double
loop.  The inner will break out if the queues are full and for some other reasons,
but the outside loop is spinning on a different atomic counter.  The question is:
If the inner loop breaks out, at least for queue full reasons, should it then
immediately break out of the outer while loop as well?

And, from what I can tell, it would be possible for other transmitters to hit this
path, repeatedly increasing the tx_request to 2, causing the original transmitter
to run for a very long time.  Especially under high load with a slow kernel
larded up with debugging...  Maybe something like the 'sofar' logic would even
be wanted upstream?

Based on the description of the 3 tx_request states, I am also not sure that
this would not hang the tx path in case where inner loop bails out due to
tx queue full, leaving packets queued.  If no other packets are ever transmitted,
is there anything that would re-kick the xmit path?

void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
{
	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
	struct iwl_mvm_txq *mvmtxq = iwl_mvm_txq_from_mac80211(txq);
	struct sk_buff *skb = NULL;
	u32 sofar = 0;

	/*
	 * No need for threads to be pending here, they can leave the first
	 * taker all the work.
	 *
	 * mvmtxq->tx_request logic:
	 *
	 * If 0, no one is currently TXing, set to 1 to indicate current thread
	 * will now start TX and other threads should quit.
	 *
	 * If 1, another thread is currently TXing, set to 2 to indicate to
	 * that thread that there was another request. Since that request may
	 * have raced with the check whether the queue is empty, the TXing
	 * thread should check the queue's status one more time before leaving.
	 * This check is done in order to not leave any TX hanging in the queue
	 * until the next TX invocation (which may not even happen).
	 *
	 * If 2, another thread is currently TXing, and it will already double
	 * check the queue, so do nothing.
	 */
	if (atomic_fetch_add_unless(&mvmtxq->tx_request, 1, 2))
		return;

	rcu_read_lock();
	do {
		while (likely(!test_bit(IWL_MVM_TXQ_STATE_STOP_FULL,
					&mvmtxq->state) &&
			      !test_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT,
					&mvmtxq->state) &&
			      !test_bit(IWL_MVM_TXQ_STATE_STOP_AP_CSA,
					&mvmtxq->state) &&
			      (sofar <= 1000) &&
			      !test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))) {
			skb = ieee80211_tx_dequeue(hw, txq);

			if (!skb) {
				if (txq->sta)
					IWL_DEBUG_TX(mvm,
						     "TXQ of sta %pM tid %d is now empty\n",
						     txq->sta->addr,
						     txq->tid);
				break;
			}

			iwl_mvm_tx_skb(mvm, skb, txq->sta);
			if (++sofar > 1000)
				pr_info("WARNING: Wrote %d packets in iwl_mvm_mac_itxq_xmit, tx_request: %d returning.\n",
					sofar, atomic_read(&mvmtxq->tx_request));
		}
	} while (atomic_dec_return(&mvmtxq->tx_request));
	rcu_read_unlock();
}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


