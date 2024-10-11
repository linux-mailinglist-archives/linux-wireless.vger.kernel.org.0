Return-Path: <linux-wireless+bounces-13898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F122C99AB9D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3B41C22359
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 18:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40046198E8C;
	Fri, 11 Oct 2024 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="QVw59QY8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD371CC174
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672716; cv=none; b=c8H4V2LxKHYbo5sS6nnfwtq9SHklcXV5SJb6IR/65TwOOl80lb7KHpSV5MbeHizRB6OvSQK84OGfYFeCH0RxIZt5PmYMTJdoJkxCg6GtSOqONyBg/vKdvLLe/ok8a3gbYcUy/0O/ZVXYR3S2lOvoF5tDDF4lEP/S9jozZMEWlEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672716; c=relaxed/simple;
	bh=U8Vw5PL79uvOZScVoKm2mc9igO8AsE2+/v/SCRT/w/w=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=e6KuSwzTW/MvJ7MOhUQi9fYKuOzmCqiEaWCqNLnHT79kH82/PwDr8j8KeRlEcv63NBXweNQ8uTkj+jhH10qWPWS/1r5fCQMAQKLgr2lUN+vNypB4ekOsGYgKiZEmCkyuZ2kkYmIiQUUsZZLxeNo0KI8zmuSp5lVBbuOjHus1AOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=QVw59QY8; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 1873C440072
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 18:51:45 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A987513C2B1
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 11:51:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A987513C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728672704;
	bh=U8Vw5PL79uvOZScVoKm2mc9igO8AsE2+/v/SCRT/w/w=;
	h=Date:To:From:Subject:From;
	b=QVw59QY8PjEm5IduRyvwMtzWD1llgWCC45XD4syF4LnGg9QgRb4UhFE3tmCXMJ1sd
	 w+lv83EvrgHwYZninMDiI+JGnquUY65N2msJ/FH9g5vA6FXsTmGouyGZj6metXSKzj
	 0FsWYeyI+JZTmozttEoA4Zybs1s4C13Lwa3EUVjo=
Message-ID: <3b5a8290-19ea-3a50-5afd-b0031590ee83@candelatech.com>
Date: Fri, 11 Oct 2024 11:51:44 -0700
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
Subject: iwlwifi: question on failure path in iwl_txq_gen2
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728672706-ndQcr-x0lEqg
X-MDID-O:
 us5;at1;1728672706;ndQcr-x0lEqg;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

We've been trying to track down what may be a double-free or similar issue
in iwlwifi.

While looking through the transmit path, I believe that an skb reference
might can be use-after-freed if tfd cannot be allocated.

I am guessing we should NULL out the pointers in that case.  Should we also
decrement the cmd_index?


int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
		    struct iwl_device_tx_cmd *dev_cmd, int txq_id)
{
	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
	struct iwl_cmd_meta *out_meta;
	struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
	u16 cmd_len;
	int idx;
	void *tfd;

	if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
		      "queue %d out of range", txq_id))
		return -EINVAL;

	if (WARN_ONCE(!test_bit(txq_id, trans_pcie->txqs.queue_used),
		      "TX on unused queue %d\n", txq_id))
		return -EINVAL;

	if (skb_is_nonlinear(skb) &&
	    skb_shinfo(skb)->nr_frags > IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie) &&
	    __skb_linearize(skb))
		return -ENOMEM;

	spin_lock(&txq->lock);

	if (iwl_txq_space(trans, txq) < txq->high_mark) {
		iwl_txq_stop(trans, txq);

		/* don't put the packet on the ring, if there is no room */
		if (unlikely(iwl_txq_space(trans, txq) < 3)) {
			struct iwl_device_tx_cmd **dev_cmd_ptr;

			dev_cmd_ptr = (void *)((u8 *)skb->cb +
					       trans_pcie->txqs.dev_cmd_offs);

			*dev_cmd_ptr = dev_cmd;
			__skb_queue_tail(&txq->overflow_q, skb);
			spin_unlock(&txq->lock);
			return 0;
		}
	}

	idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);

	/* Set up driver data for this TFD */
	txq->entries[idx].skb = skb;
	txq->entries[idx].cmd = dev_cmd;

	dev_cmd->hdr.sequence =
		cpu_to_le16((u16)(QUEUE_TO_SEQ(txq_id) |
			    INDEX_TO_SEQ(idx)));

	/* Set up first empty entry in queue's array of Tx/cmd buffers */
	out_meta = &txq->entries[idx].meta;
	memset(out_meta, 0, sizeof(*out_meta));

	tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
	if (!tfd) {
		txq->entries[idx].skb = NULL;
		txq->entries[idx].cmd = NULL;
   ####  Upstream code does not have these two lines above ####
		spin_unlock(&txq->lock);
		return -1;
	}

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


