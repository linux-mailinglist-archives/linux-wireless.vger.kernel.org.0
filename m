Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D411D653112
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 13:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiLUMvV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 07:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbiLUMvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 07:51:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE5223324
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 04:50:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D2E6B81B84
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 12:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F189CC433EF;
        Wed, 21 Dec 2022 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671627050;
        bh=w+bo5wdpOHW/2setB3OgJQMiL7ZmgUaSvGy1sczlENE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o6VyS4vmhWELQt7vRJowldL221EnYDOQNjgwY+/715tL89woKITSWRa+tP+2Y5Uva
         hu0+Vww65jROMY04gSkH+5s2DsR3+jbGjIrh55ilUqlmIFxIJjxeGAl551VRswlqQe
         5z/8Gv2zk8wqS+/00YqHjCgpSdCd6Od+zu6r/nWqU5XNCUG0G/JpECXTec+3eiQxoB
         S9hm4UzB60yTjMuxRNLiLWEWh35Lnp8viuvVzDdZcxnAosqUUbTP7JLvudvVlO6yuJ
         p/n+I8otzRM/Xbdm/exaikYRbO33iqy7NsRbTutPDS284LAqdS3pWz5I/3P8AoSJLK
         mC2i3uoGQWzcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] wifi: ath11k: add support to parse new WMI event
 for 6
 GHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221214164639.31542-3-quic_adisi@quicinc.com>
References: <20221214164639.31542-3-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Lavanya Suresh <quic_lavaks@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167162704604.23347.8011938867680129068.kvalo@kernel.org>
Date:   Wed, 21 Dec 2022 12:50:48 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> In order to support different power levels of 6 GHz AP and client,
> new WMI event for regulatory - WMI_REG_CHAN_LIST_CC_EXT_EVENTID is
> added in firmware. This event provides new parameters required for
> 6 GHz regulatory rules.
> 
> Add support for parsing 2.4 GHz, 5 GHz and 6 GHz reg rules and other
> parameters from WMI_REG_CHAN_LIST_CC_EXT_EVENTID.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Reported-by: kernel test robot <lkp@intel.com>

I don't think using Reported-by is correct here. You are
adding a new feature, not fixing a bug reported the bot.

> Signed-off-by: Lavanya Suresh <quic_lavaks@quicinc.com>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

This patch added new checkpatch warnings, they were too complex for me to fix them:

drivers/net/wireless/ath/ath11k/reg.c:678: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.h:4090: Please don't use multiple blank lines
drivers/net/wireless/ath/ath11k/wmi.h:4212: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5002: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5102: line length of 94 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5208: line length of 91 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5209: line length of 92 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5235: line length of 95 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5298: line length of 91 exceeds 90 columns

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221214164639.31542-3-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

