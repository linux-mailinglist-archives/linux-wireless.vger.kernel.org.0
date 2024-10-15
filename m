Return-Path: <linux-wireless+bounces-13980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 739DB99F3F7
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E96F1F21575
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C609C1F9413;
	Tue, 15 Oct 2024 17:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="AjDzuZGY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4C1D514C
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729013029; cv=none; b=PmZ9T1cPwVGFWDlRK+lmsCa/+qmDJnq8vCD35/fRAEf/pvACTXyRcrCdYg7t1KkG6rlpMvwmfr1dmDRNeCUUiXXfqT6MFQ4Es0frf6Yre2JJ6vcUBedtOAOQBFSY6Yq5bOAxc2Xd8CYaeeE0N8hnoQuV2Syq3O4Jd5MLYT7Yqg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729013029; c=relaxed/simple;
	bh=V5H8/gqDmtFa57WA2Q+ER9EykchTUC4Pw+62/blIWNk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=uB3Z8GtsBh6/umt+a9wx/Jggju52ZJsqRABGHPUqkHhQoUT2g20Vc5m/BTlwyVCj5IGs0KaEJRxwkpRV1gyCWe+EJNBU6mZ2lYhS1R9bJkxtAkbMoIiMdbaI7C9fDy+XgqDDPMwChEMY2Vl2/xnrfPacfhck3l2vfjuV58pSCP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=AjDzuZGY; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 325A1980066
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 17:23:45 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id A7FAC13C2B0
	for <linux-wireless@vger.kernel.org>; Tue, 15 Oct 2024 10:23:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A7FAC13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1729013023;
	bh=V5H8/gqDmtFa57WA2Q+ER9EykchTUC4Pw+62/blIWNk=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=AjDzuZGYyUzz6FQdijylwnWEOozK7SVLpa3K9VIrR1UkV/Ogm5L/JDot55nt8fCfs
	 tELY5Hb5c+Pxun3JG+LFOnU3C8cF+aaFaUyskeYrz+lIMGpUhjdIVQH630SRz7CNYT
	 xX0wEemkQJqLdDoE5HnZ7OxHDiYz/vkvwhqoKaAk=
Message-ID: <e79f3282-b229-cab9-dc82-afcb8d4fe636@candelatech.com>
Date: Tue, 15 Oct 2024 10:23:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi: question on failure path in iwl_txq_gen2
Content-Language: en-US
From: Ben Greear <greearb@candelatech.com>
To: linux-wireless <linux-wireless@vger.kernel.org>
References: <3b5a8290-19ea-3a50-5afd-b0031590ee83@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <3b5a8290-19ea-3a50-5afd-b0031590ee83@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1729013026-4v-yijQMwzLp
X-MDID-O:
 us5;at1;1729013026;4v-yijQMwzLp;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/11/24 11:51, Ben Greear wrote:
> Hello,
> 
> We've been trying to track down what may be a double-free or similar issue
> in iwlwifi.
> 
> While looking through the transmit path, I believe that an skb reference
> might can be use-after-freed if tfd cannot be allocated.

Nulling out the skb doesn't fix the use-after-free, or at least not all of it.

And I realize now that the cmd-index doesn't need to be messed with in
the error branch.

I'll post a patch to null out the pointers when I get a chance, as I think
it at least makes things a bit cleaner.

Thanks,
Ben

> 
> I am guessing we should NULL out the pointers in that case.  Should we also
> decrement the cmd_index?
> 
> 
> int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
>              struct iwl_device_tx_cmd *dev_cmd, int txq_id)
> {
>      struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
>      struct iwl_cmd_meta *out_meta;
>      struct iwl_txq *txq = trans_pcie->txqs.txq[txq_id];
>      u16 cmd_len;
>      int idx;
>      void *tfd;
> 
>      if (WARN_ONCE(txq_id >= IWL_MAX_TVQM_QUEUES,
>                "queue %d out of range", txq_id))
>          return -EINVAL;
> 
>      if (WARN_ONCE(!test_bit(txq_id, trans_pcie->txqs.queue_used),
>                "TX on unused queue %d\n", txq_id))
>          return -EINVAL;
> 
>      if (skb_is_nonlinear(skb) &&
>          skb_shinfo(skb)->nr_frags > IWL_TRANS_PCIE_MAX_FRAGS(trans_pcie) &&
>          __skb_linearize(skb))
>          return -ENOMEM;
> 
>      spin_lock(&txq->lock);
> 
>      if (iwl_txq_space(trans, txq) < txq->high_mark) {
>          iwl_txq_stop(trans, txq);
> 
>          /* don't put the packet on the ring, if there is no room */
>          if (unlikely(iwl_txq_space(trans, txq) < 3)) {
>              struct iwl_device_tx_cmd **dev_cmd_ptr;
> 
>              dev_cmd_ptr = (void *)((u8 *)skb->cb +
>                             trans_pcie->txqs.dev_cmd_offs);
> 
>              *dev_cmd_ptr = dev_cmd;
>              __skb_queue_tail(&txq->overflow_q, skb);
>              spin_unlock(&txq->lock);
>              return 0;
>          }
>      }
> 
>      idx = iwl_txq_get_cmd_index(txq, txq->write_ptr);
> 
>      /* Set up driver data for this TFD */
>      txq->entries[idx].skb = skb;
>      txq->entries[idx].cmd = dev_cmd;
> 
>      dev_cmd->hdr.sequence =
>          cpu_to_le16((u16)(QUEUE_TO_SEQ(txq_id) |
>                  INDEX_TO_SEQ(idx)));
> 
>      /* Set up first empty entry in queue's array of Tx/cmd buffers */
>      out_meta = &txq->entries[idx].meta;
>      memset(out_meta, 0, sizeof(*out_meta));
> 
>      tfd = iwl_txq_gen2_build_tfd(trans, txq, dev_cmd, skb, out_meta);
>      if (!tfd) {
>          txq->entries[idx].skb = NULL;
>          txq->entries[idx].cmd = NULL;
>    ####  Upstream code does not have these two lines above ####
>          spin_unlock(&txq->lock);
>          return -1;
>      }
> 
> Thanks,
> Ben
> 


