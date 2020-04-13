Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF95F1A66D0
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2020 15:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgDMNSw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Apr 2020 09:18:52 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:16218 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729268AbgDMNSv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Apr 2020 09:18:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586783931; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EI+LjzYwqsFnaHRMOyqXDgFmG5KseBnWqvVLWQvrpJw=;
 b=GqKBCuN9XayngKegt0x/YMccsH50iwIl6c8n6dJTAEjXzzEzvg71v0Xyj0gBWsr8xACT+wxx
 Jc95mqJ23SHNMcP7eUxmVyLXOdh3j3i5CVPAHOnFWbTTiTMmSBrbsb38vRsna9kDjJ5k+VSL
 DhuaxjzBxVoErudln0fWscMs3nU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e9466a3.7f51f5149a40-smtp-out-n02;
 Mon, 13 Apr 2020 13:18:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3B9FDC432C2; Mon, 13 Apr 2020 13:18:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: srirrama)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB2C5C433CB;
        Mon, 13 Apr 2020 13:18:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Apr 2020 18:48:25 +0530
From:   Sriram R <srirrama@codeaurora.org>
To:     dan.carpenter@oracle.com, mpubbise@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [bug report] ath11k: handle RX fragments
In-Reply-To: <BY5PR02MB6820A065D360B48F7251CADAF7DD0@BY5PR02MB6820.namprd02.prod.outlook.com>
References: <20200407134115.GA108129@mwanda>
 <BY5PR02MB6820A065D360B48F7251CADAF7DD0@BY5PR02MB6820.namprd02.prod.outlook.com>
Message-ID: <304723517988acc2b595b0b4131546c5@codeaurora.org>
X-Sender: srirrama@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

> -----Original Message-----
> From: linux-wireless-owner@vger.kernel.org
> <linux-wireless-owner@vger.kernel.org> On Behalf Of Dan Carpenter
> Sent: Tuesday, April 7, 2020 7:11 PM
> To: mpubbise@codeaurora.org
> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
> Subject: [EXT] [bug report] ath11k: handle RX fragments
> 
> Hello Manikanta Pubbisetty,
> 
> The patch 243874c64c81: "ath11k: handle RX fragments" from Mar 16,
> 2020, leads to the following static checker warning:
> 
> drivers/net/wireless/ath/ath11k/dp_rx.c:3365 ath11k_dp_rx_frag_h_mpdu()
> warn: missing error code here? 'ath11k_dp_rx_h_defrag()' failed. 'ret' 
> = '0'
> 
> drivers/net/wireless/ath/ath11k/dp_rx.c
>   3343
> HAL_WBM_REL_BM_ACT_PUT_IN_IDLE);
>   3344          }
>   3345
>   3346          if (!rx_tid->last_frag_no ||
>   3347              rx_tid->rx_frag_bitmap !=
> GENMASK(rx_tid->last_frag_no, 0)) {
>   3348                  mod_timer(&rx_tid->frag_timer, jiffies +
>   3349
> ATH11K_DP_RX_FRAGMENT_TIMEOUT_MS);
>   3350                  goto out_unlock;
>                         ^^^^^^^^^^^^^^^
> 
> All these gotos should probably set error codes instead of returning 
> success.

Thanks for pointing out. But, this function was written in this way on 
purpose.
The error retval to caller and error goto's in this function perform 
different cleanups and moving them to caller will only make the caller 
function complex which is better to avoid.

Thanks,
Sriram.R
