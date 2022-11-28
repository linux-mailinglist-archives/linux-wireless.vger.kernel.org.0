Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA2963ABA8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 15:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiK1O4X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 09:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiK1O4W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 09:56:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD80D1F9C7
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 06:56:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 591BE611E8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 14:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31415C433C1;
        Mon, 28 Nov 2022 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669647380;
        bh=aat0ISTc8H75TcGqw7ZrDDhs3u11WJYKdL8R2eM6hvc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SUhiHQvPemU/u1sPz11mDd+CDVOLH8UkBSK0YUmQsmjUiV/+zlJCwAqI32gDNONDI
         GLHSr8htMhpDLxb/Aoxmewjl9bESRP/KC4/w4Ol1Am5TPZjXBMqn0IAJ9d2hajSnhO
         I3fJFcabsmssTA+HTCBil2LUM2GznDyfx0uV3zjGKgNqYuhJh4sr49HEwP4Rv3fk7j
         8iYO57gvfdh7wC0EwSYB43FossKG+evWHq3PwVSsErt7jAZ2cfG00MicIVJVHAjUYv
         ZTWT/sNdhddIGoTWyuNXndRXfeyFbtAIvUUnv5Zuwh6QIuT7WWw/IFEcDdelA+RRW7
         Zc0pTrMzNZhCw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: Re: [PATCH v2 00/50] wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
References: <20221116163902.24996-1-kvalo@kernel.org>
Date:   Mon, 28 Nov 2022 16:56:16 +0200
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org> (Kalle Valo's message
        of "Wed, 16 Nov 2022 18:38:12 +0200")
Message-ID: <878rjv5drj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> ath12k is a new mac80211 driver for Qualcomm Wi-Fi 7 devices, first
> supporting QCN9274 and WCN7850 PCI devices.  QCN9274 supports both AP
> and station; WCN7850 supports only station mode. Monitor mode is not
> (yet) supported. Only PCI bus devices are supported.
>
> ath12k is forked from an earlier version of ath11k. It was simpler to
> have a "clean start" for the new generation and not try to share the
> code with ath11k. This makes maintenance easier and avoids major
> changes in ath11k, which would have significantly increased the risk
> of regressions in existing setups.
>
> ath12k uses le32 and cpu_to_le32() macros to handle endian
> conversions, instead of using the firmware byte swap feature utilized
> by ath11k. There is only one kernel module, named ath12k.ko.
>
> Currently ath12k only supports HE mode (IEEE 802.11ax) or older, but
> work is ongoing to add EHT mode (IEEE 802.11be) support.
>
> The size of the driver is ~41 kLOC and 45 files. To make the review
> easier, this initial version of ath12k does not support Device Tree,
> debugfs or any other extra features. Those will be added later, after
> ath12k is accepted to upstream.
>
> The driver is build tested by Intel's kernel test robot with both GCC
> and Clang. Sparse reports no warnings. The driver is mostly free of
> checkpatch warnings, albeit few of the warnings are omitted on
> purpose, list of them here:
>
> https://github.com/qca/qca-swiss-army-knife/blob/master/tools/scripts/ath12k/ath12k-check#L52
>
> The driver has had multiple authors who are listed in alphabetical
> order below.
>
> Co-developed-by: Balamurugan S <quic_bselvara@quicinc.com>
> Signed-off-by: Balamurugan S <quic_bselvara@quicinc.com>
> Co-developed-by: Balamurugan Selvarajan <quic_bselvara@quicinc.com>
> Signed-off-by: Balamurugan Selvarajan <quic_bselvara@quicinc.com>

I noticed that Balamurugan is twice here, fixed in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=b644733d58cb65d2e319bad0e0f89a852021c5c2

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
