Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F924E52BF
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 14:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243896AbiCWNHU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 09:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbiCWNHS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 09:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F376E369
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 06:05:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B78EC615CF
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 13:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52772C340F2;
        Wed, 23 Mar 2022 13:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648040748;
        bh=tHsyjwpNSbihQ+nfFKQQGpXUDzivyStE32WHuyKcSTY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KTfdSqDPJw314OiqtKVL4wQdxrmMsTF+8b/qF2Letd0fMr7ii9sdZI5yErd9YTuz1
         DV72OeLZFWonHZwscLFH0gb/I9ZrdNsy1Y+FShMfcbjlPikOxch9FULiYeL/GXl5d9
         Mwx6vHqorzWDVskSX8Zqh7k1tcV+YeB84Bi5OSRUYhAQwUVYLZFhzWm/ZV51VtzczD
         O1yMEVPRX/YQJbFZ0Q3vOMJCv3gJRETyhurx3bis5AzIgecyvLgUPo0YdUoeXh+c0R
         fEWT/nxgW81aOLTupNYHQvp8aFpSxBfygfpcsAxe3g95/WzXinYRnj0T3ADNsHLczE
         Qt6Kr9DzPQZsQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] ath11k: add read variant from SMBIOS for download board data
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
        <20220315104721.26649-3-quic_wgong@quicinc.com>
        <87r16tkqbx.fsf@kernel.org>
        <1c4230e0-f01e-0db1-af95-65aa2d3ac508@quicinc.com>
Date:   Wed, 23 Mar 2022 15:05:42 +0200
In-Reply-To: <1c4230e0-f01e-0db1-af95-65aa2d3ac508@quicinc.com> (Wen Gong's
        message of "Wed, 23 Mar 2022 16:52:43 +0800")
Message-ID: <87h77okee1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> On 3/23/2022 4:47 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>> This is to read variant from SMBIOS such as read from DT, the variant
>>> string will be used to one part of string which used to search board
>>> data from board-2.bin.
>>>
>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>
>>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> [...]
>>
>>> +struct ath11k_smbios_bdf {
>>> +	struct dmi_header hdr;
>>> +	u32 padding;
>>> +	u8 bdf_enabled;
>>> +	u8 bdf_ext[1];
>>> +};
>> I was about to commit this but noticed bdf_ext[1], is there a reason for
>> that? Use of [1] in arrays is deprecated nowadays:
>
> Kalle,
>
> no reason for it, please change bdf_ext[1] to bdf_ext[0] or bdf_ext[].
> It will also work well.

[0] is deprecated as well so I changed it to [].

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
