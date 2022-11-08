Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B844621CD3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Nov 2022 20:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiKHTQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 14:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKHTQM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 14:16:12 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B651661B85
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 11:16:06 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id A486F1A0095;
        Tue,  8 Nov 2022 19:16:04 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D11D2840079;
        Tue,  8 Nov 2022 19:15:51 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8A91713C2B0;
        Tue,  8 Nov 2022 11:15:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8A91713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1667934945;
        bh=zLjzH4wetrmd0Mxz9u5DRnW5WpQ6qi3vC3rpLt43BNw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qKiZaVnRTaLis2cGip9XE2LWUh4Xw5e2L1ptfcAwsy6OL4zObz0bm/aZQ/V79iWoa
         EBEMv8JqnxWOJ2kpXmBcI3j0M2sggdnYCHzbfRL/pSQjbL+vDS8KkbBjEe3bppnQUW
         cbSEcpUr982NRzDjBy99iezJoD/IRFnOG4Y4z0r8=
Subject: Re: [PATCH 3/4] wifi: mt76: mt7915: add full system reset into
 debugfs
To:     Ryder Lee <ryder.lee@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
        linux-wireless@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
References: <26aefa69d1002616412c4b00bf2e779f71ca3289.1667929344.git.ryder.lee@mediatek.com>
 <de5e0b76c246926d21c13625310e810584b742c7.1667929344.git.ryder.lee@mediatek.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <33fcc913-549e-e350-4d2b-1932f2474241@candelatech.com>
Date:   Tue, 8 Nov 2022 11:15:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <de5e0b76c246926d21c13625310e810584b742c7.1667929344.git.ryder.lee@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1667934965-bKtYdJrTLc5l
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/8/22 11:02 AM, Ryder Lee wrote:
> Trigger firmware crash and enable full system recovery through debugfs.
> This also renames knob "fw_ser" to a clear-cut name "sys_recovery".
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>   .../wireless/mediatek/mt76/mt7915/debugfs.c   | 51 +++++++++++++++----
>   .../net/wireless/mediatek/mt76/mt7915/mac.c   |  5 ++
>   .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +
>   .../wireless/mediatek/mt76/mt7915/mt7915.h    |  2 +
>   .../net/wireless/mediatek/mt76/mt7915/regs.h  |  4 ++
>   5 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index e1d15394a621..56320c5da499 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -46,8 +46,8 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_implicit_txbf, mt7915_implicit_txbf_get,
>   
>   /* test knob of system error recovery */
>   static ssize_t
> -mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
> -		  size_t count, loff_t *ppos)
> +mt7915_sys_recovery_set(struct file *file, const char __user *user_buf,
> +			size_t count, loff_t *ppos)
>   {
>   	struct mt7915_phy *phy = file->private_data;
>   	struct mt7915_dev *dev = phy->dev;
> @@ -71,8 +71,18 @@ mt7915_fw_ser_set(struct file *file, const char __user *user_buf,
>   		return -EINVAL;
>   
>   	switch (val) {
> +	/*
> +	 * 0: grab firmware current SER state.
> +	 * 1: trigger & enable system error L1 recovery.
> +	 * 2: trigger & enable system error L2 recovery.
> +	 * 3: trigger & enable system error L3 rx abort.
> +	 * 4: trigger & enable system error L3 tx abort
> +	 * 5: trigger & enable system error L3 tx disable.
> +	 * 6: trigger & enable system error L3 bf recovery.
> +	 * 7: trigger & enable system error full recovery.
> +	 * 8: trigger firmware crash.
> +	 */

[snip]

> +	/* dump firmware SER statistics */
>   	desc += scnprintf(buff + desc, bufsz - desc,
>   			  "::E  R , SER_STATUS        = 0x%08x\n",
>   			  mt76_rr(dev, MT_SWDEF_SER_STATS));
> @@ -139,15 +167,19 @@ mt7915_fw_ser_get(struct file *file, char __user *user_buf,
>   	desc += scnprintf(buff + desc, bufsz - desc,
>   			  "::E  R , SER_LMAC_WISR7_B1 = 0x%08x\n",
>   			  mt76_rr(dev, MT_SWDEF_LAMC_WISR7_BN1_STATS));
> +	desc += scnprintf(buff + desc, bufsz - desc,
> +			  "\nSYS_RESET_COUNT: WM %d, WA %d\n",
> +			  dev->recovery.wm_reset_count,
> +			  dev->recovery.wa_reset_count);

Consider printing out the text for what the various values that can be written to this
debugfs file do (ie, like the comments earlier in this patch)?

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

