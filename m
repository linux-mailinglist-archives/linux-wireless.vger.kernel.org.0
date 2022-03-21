Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E944E23B2
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 10:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346062AbiCUJ5e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346059AbiCUJ5b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 05:57:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB01613700E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 02:56:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C632B81168
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 09:56:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2596FC340E8;
        Mon, 21 Mar 2022 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647856558;
        bh=T3DLppXj5kZ65OViVxUgR02m2i078NFkHdhZT/bt0is=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ttaU4o3bsSTAOIBvXsaAMrJ5FZvO7mdSUJ3jSFp9oVooBMObBbdAIa4OFIfHVxxlc
         f1gR3KBbbSx19t2Jt8hnNFSpYJQAYy2A8/2EtayNNFxtzDk8mNnsUZWLnoVPAvDRCP
         pQ8qPpa0A0c6jMQZVFSUAJ435c9687bh6Rxl9PuM4SzmX9u7Yz4VINJtsFkcFNsepL
         3NEfGM4p/ub0VYIljAOX2TPrWWqh+hBxj5kEd0CLvORwY3kTW7f5NwhBAm+Z2AECdv
         WnZX0RKJWM1XEDXef/aXRh85UG1bibP3idcpeijrcd21tUNT8VtmCbNdpuGCCU8QbI
         LahA6ccKbvovg==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Baochen Qiang \(QUIC\)" <quic_bqiang@quicinc.com>
Cc:     "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: Add support for SAR
In-Reply-To: <BYAPR02MB543076C526E59CB0E98B3DBCE0169@BYAPR02MB5430.namprd02.prod.outlook.com>
        (Baochen Qiang's message of "Mon, 21 Mar 2022 02:24:47 +0000")
References: <20220317012728.18932-1-quic_bqiang@quicinc.com>
        <164761864196.8951.13534371903381562941.kvalo@kernel.org>
        <BYAPR02MB543076C526E59CB0E98B3DBCE0169@BYAPR02MB5430.namprd02.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Mon, 21 Mar 2022 11:55:53 +0200
Message-ID: <87fsnbocie.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Baochen Qiang (QUIC)" <quic_bqiang@quicinc.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Friday, March 18, 2022 11:51 PM
>> To: Baochen Qiang (QUIC) <quic_bqiang@quicinc.com>
>> Cc: ath11k@lists.infradead.org; linux-wireless@vger.kernel.org
>> Subject: Re: [PATCH] ath11k: Add support for SAR
>> 
>> Baochen Qiang <quic_bqiang@quicinc.com> wrote:
>> 
>> > ath11k assigns ath11k_mac_op_set_bios_sar_specs to ath11k_ops, and
>> > this function is called when user space application calls
>> > NL80211_CMD_SET_SAR_SPECS. ath11k also registers SAR type and
>> > frequency ranges to wiphy so user space can query SAR capabilities.
>> >
>> > This feature is currently enabled for WCN6855.
>> >
>> > Tested-on: WCN6855 hw2.0 PCI
>> > WLAN.HSP.1.1-02431-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>> >
>> > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> 
>> What did you use as the baseline? I could not able to find an ath- tag to which
>> this patch would apply. I strongly recommend using --base, that way I don't
>> need to waste time trying to guess what was the baseline.
>> 
>> Patch set to Changes Requested.
>> 
>
> Hi Kalle, I have added the base flag in v2.

Thanks.

> And please note this patch depends on
> https://patchwork.kernel.org/project/linux-wireless/patch/20211224085236.9064-2-quic_wgong@quicinc.com/
> which is now in public review.

If there are any dependencies, please document them clearly after the
"---" line. I don't have time to start guessing what dependencies there
might be for your patches, especially if the dependency is several
months as in this case.

But why are you using that patch as the baseline? It's marked as Changes
Requested and it's unclear then it can be merged. If you need that
patch, you should create a patchset with patch 1 being "ath11k: add
support for extended wmi service bit" and patch 2 being "ath11k: Add
support for SAR".

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
