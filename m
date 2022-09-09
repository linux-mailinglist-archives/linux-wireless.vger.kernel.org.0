Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544D35B3567
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 12:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIIKmw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 06:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiIIKmu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 06:42:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A71377B9
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 03:42:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E10C61F98
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 10:42:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE5FC433D6;
        Fri,  9 Sep 2022 10:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662720168;
        bh=zbx7riJv2O0vvgZWYPqfC9CvkWPpl/kRd6ZjbdCWGpM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=D0Azh37H1745UDN41+qRHwE/XaomXOKnxtM4fKbu1Sh/EcE99cPyan0h55R1VbV19
         G9p0761sNTFxMcMmOtjHh/DAubG2WjDVJoQLp9BhcJ6jPF+OW8/xIiR0h/u+zVbCZX
         8Sj29FDUXIcf1byRbHOI0Ii3wgos4EIVzJ10ZyizFtLaju204rc6RW6PWSG3RW1dEu
         J9DptGakKG/EKwv+Tr1yRtgrrwMpOfMGcEKq7bocs7SkAaFH9C8Yg+n9OIW06T6ibv
         nuSJHyvk5Vu72arStcx19yacy/D3E3oiU2FDIehVwDlLWHSDgUmIRvZirk+UWPp/Ff
         QlTyK7bPl8QdA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] wifi: ath11k: Split PCI write/read functions
References: <20220802075533.1744-1-quic_bqiang@quicinc.com>
        <20220802075533.1744-2-quic_bqiang@quicinc.com>
Date:   Fri, 09 Sep 2022 13:42:45 +0300
In-Reply-To: <20220802075533.1744-2-quic_bqiang@quicinc.com> (Baochen Qiang's
        message of "Tue, 2 Aug 2022 15:55:32 +0800")
Message-ID: <87k06c96ca.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> ath11k_pcic_write32/read32 tries to do wake up before doing actual
> write/read work, which means each time a u32 is written/read, wake
> up is performed. This is not necessary in case where we do a
> large amount of write/read, because only one time of wake up is needed.
> So split each one into two parts, the first part does wake up and
> release, and the second one does actual write/read work.
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
> v2:
>   1: rebased on latest ath.git
>
>  drivers/net/wireless/ath/ath11k/pcic.c | 50 ++++++++++++++++----------
>  1 file changed, 32 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/pcic.c b/drivers/net/wireless/ath/ath11k/pcic.c
> index 1adf20ebef27..15ca069e501f 100644
> --- a/drivers/net/wireless/ath/ath11k/pcic.c
> +++ b/drivers/net/wireless/ath/ath11k/pcic.c
> @@ -140,49 +140,63 @@ int ath11k_pcic_init_msi_config(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_pcic_init_msi_config);
>  
> +static void ath11k_pcic_do_write32(struct ath11k_base *ab, u32 offset, u32 value)

In the pending branch I renamed this __ath11k_pcic_write32(). I find
that more readable than using the word "do" in the middle.

> +static u32 ath11k_pcic_do_read32(struct ath11k_base *ab, u32 offset)

And this to __ath11k_pcic_do_read32().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
