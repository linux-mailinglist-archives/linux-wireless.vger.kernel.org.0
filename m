Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244D97244EE
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 15:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbjFFNwf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 09:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237466AbjFFNwe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 09:52:34 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61BEE7E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:52:32 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 9A2E4900085
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 13:52:30 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.35.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id E218413C2B0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 06:52:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E218413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1686059550;
        bh=tsdfktztIh21HJogh6GNLJlXZBm5zR2+XTTgORyJ1CQ=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=D6Qxq++7WGvgUnHJ6WOxggfxZossMLrM7cDj6aEx1RvEienFcKlfHVQ9qeFWDHTjh
         s5nlFQGSW7nanTBkhsBOUcV1/gm5vAcMR6/lGMwQbPPsOutkPZ6crVLw6FcutpoFiV
         IUmjbe5Y4ShOHDEuVaJyh79UqTINEdMB2afY4IM8=
Subject: Re: iwlwifi: tx-fail reported with zero retry count.
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6b920700-e9a2-bbeb-98ce-7a2d09e76975@candelatech.com>
Organization: Candela Technologies
Message-ID: <2fbaa2cb-9193-32cd-66ef-ffd6b48c049d@candelatech.com>
Date:   Tue, 6 Jun 2023 06:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <6b920700-e9a2-bbeb-98ce-7a2d09e76975@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
X-MDID: 1686059551-m2TpKQkt-BIs
X-MDID-O: us5;at1;1686059551;m2TpKQkt-BIs;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/6/23 6:36 AM, Ben Greear wrote:
> It seems that when tx fails (due to TX_STATUS_FAIL_LONG_LIMIT in this case), the
> retry-count is sometimes reported as zero.  I would expect that it actually must have retried
> many times (15 it seems?).  At least for fail-long-limit failures, is there a known constant amount of
> times the firmware retransmits the frame before giving up?  If so, I can just hack that
> value into the retry counter in this case.
> 
> Debug patch:
> 
> [greearb@ben-dt5 iwlwifi]$ git diff
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> index 1cddc65dd51e..6544dabb092b 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
> @@ -1929,8 +1929,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
>                  mvm->ethtool_stats.tx_mpdu_attempts += info->status.rates[0].count;
>                  mvm->ethtool_stats.tx_mpdu_retry += tx_resp->failure_frame;
>                  if (cb.flags & IWL_TX_CB_TXO_USED) {
> +                       u32 idx = status & TX_STATUS_MSK;
> +
>                          mvm->ethtool_stats.txo_tx_mpdu_attempts += info->status.rates[0].count;
>                          mvm->ethtool_stats.txo_tx_mpdu_retry += tx_resp->failure_frame;
> +                       if (idx != TX_STATUS_SUCCESS) {
> +                               pr_info("txo tx status failed: %d  tx_resp->failure_frame: %d\n",
> +                                       idx, tx_resp->failure_frame);
> +                       }
>                  }
> 
>                  iwl_mvm_hwrate_to_tx_status(mvm, mvm->fw,
> 
> 
>  From dmesg:
> 
> Jun 06 06:29:40 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:29:43 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:29:48 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:29:49 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:29:52 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:29:57 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
> Jun 06 06:29:57 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
> Jun 06 06:29:58 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 0
> Jun 06 06:30:01 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:30:02 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15
> Jun 06 06:30:03 ct523c-0b29 kernel: txo tx status failed: 131  tx_resp->failure_frame: 15

I think it has some other weirdness too.  I added printout to show any non-zero failure_frame:

+                       if (idx != TX_STATUS_SUCCESS || tx_resp->failure_frame) {
+                               pr_info("txo tx status: %d  tx_resp->failure_frame: %d\n",
+                                       idx, tx_resp->failure_frame);
+                       }


For a while, it showed the status 131 and failure_frame of 0, then it started reporting lots
of smaller numbers of retries (more like what I would expect to see).
And then it seemed to stick in a case where it was reporting
lots of successes with 15 retries:

Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15
Jun 06 06:44:50 ct523c-0b29 kernel: txo tx status: 1  tx_resp->failure_frame: 15


I think it is quite unlikely that it reliably succeeded on the very last retry
so many times in a row.  Maybe the FW has some issues in reporting the failure_frame
count properly?

Thanks,
Ben
