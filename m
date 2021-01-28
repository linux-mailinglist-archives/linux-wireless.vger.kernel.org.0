Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E2F306F08
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 08:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhA1HWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 02:22:34 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:43802 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhA1HUr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 02:20:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611818428; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=JuLPSAdeilKNwqBLkl73niz+lwfFEnxP7Hjg4m3No88=;
 b=dCdohXrtWFXB/f5q6RtXFCFRa6bB3B58DwdGRt4DzWFAuaZHorXQN+B+l4HfEMGivaE1tF3+
 4g1Aa4QcBrzPw1UL4PVSY/i/3iFXD5Nllg3h7j0zZMTidTPUCSrUBs1NG0CSWfmCYbvazKVf
 WlnwiY5AuABkq5xlwSinH2oWTsI=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 6012659de3256006425d20f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 07:19:57
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04FA8C433C6; Thu, 28 Jan 2021 07:19:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CC21C433CA;
        Thu, 28 Jan 2021 07:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CC21C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race
 condition
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1608618887-8857-1-git-send-email-miaoqing@codeaurora.org>
References: <1608618887-8857-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        briannorris@chromium.org, Miaoqing Pan <miaoqing@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210128071957.04FA8C433C6@smtp.codeaurora.org>
Date:   Thu, 28 Jan 2021 07:19:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> Failed to transmit wmi management frames:
> 
> [84977.840894] ath10k_snoc a000000.wifi: wmi mgmt tx queue is full
> [84977.840913] ath10k_snoc a000000.wifi: failed to transmit packet, dropping: -28
> [84977.840924] ath10k_snoc a000000.wifi: failed to submit frame: -28
> [84977.840932] ath10k_snoc a000000.wifi: failed to transmit frame: -28
> 
> This issue is caused by race condition between skb_dequeue and
> __skb_queue_tail. The queue of ‘wmi_mgmt_tx_queue’ is protected by a
> different lock: ar->data_lock vs list->lock, the result is no protection.
> So when ath10k_mgmt_over_wmi_tx_work() and ath10k_mac_tx_wmi_mgmt()
> running concurrently on different CPUs, there appear to be a rare corner
> cases when the queue length is 1,
> 
>   CPUx (skb_deuque)			CPUy (__skb_queue_tail)
> 					next=list
> 					prev=list
>   struct sk_buff *skb = skb_peek(list);	WRITE_ONCE(newsk->next, next);
>   WRITE_ONCE(list->qlen, list->qlen - 1);WRITE_ONCE(newsk->prev, prev);
>   next       = skb->next;		WRITE_ONCE(next->prev, newsk);
>   prev       = skb->prev;		WRITE_ONCE(prev->next, newsk);
>   skb->next  = skb->prev = NULL;	list->qlen++;
>   WRITE_ONCE(next->prev, prev);
>   WRITE_ONCE(prev->next, next);
> 
> If the instruction ‘next = skb->next’ is executed before
> ‘WRITE_ONCE(prev->next, newsk)’, newsk will be lost, as CPUx get the
> old ‘next’ pointer, but the length is still added by one. The final
> result is the length of the queue will reach the maximum value but
> the queue is empty.
> 
> So remove ar->data_lock, and use 'skb_queue_tail' instead of
> '__skb_queue_tail' to prevent the potential race condition. Also switch
> to use skb_queue_len_lockless, in case we queue a few SKBs simultaneously.
> 
> Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1.c2-00033-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b55379e343a3 ath10k: fix wmi mgmt tx queue full due to race condition

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1608618887-8857-1-git-send-email-miaoqing@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

