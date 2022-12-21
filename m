Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C51653119
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbiLUMxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 07:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiLUMxO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 07:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118552332D
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 04:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8C25B81B83
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 12:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AA7C433D2;
        Wed, 21 Dec 2022 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671627187;
        bh=DLAQ9QL+nNCF/Z8bHJa4ZoD6buy9oY888cXR+gjhCJs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qhPOTxpxJMSNmb16xZPAS65bsoywT5etzEM6EhDcqz4rEAr7GruxD6CL/hbr+wffZ
         3kc+iimhQUA70H/JtIwlYsKGJDBDbQEMGBjgg0ZQnCM6bckw3VDKfz4yk0Skg54T3/
         +CaVRQe3pi9DmtzwGRiGEZUkY7OO4MLxuFMdAyPv8/QjugYUDygbLV98uHyE+iMlo/
         TsrnnyBDO/gn0MO10PnafLNn7zp2g7Qs/oi+rhEXMQM4tYPyjOe8DnNp65kbD2X58d
         tDbtoYA3p32xf0yj2pz8G6Z9h1+AddqK5EsgaRvzEdOGWfmPwWvI8lOKxHwfTcwPka
         GasYjwOnbhG+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] wifi: ath11k: add debug prints in regulatory WMI
 event
 processing
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221214164639.31542-4-quic_adisi@quicinc.com>
References: <20221214164639.31542-4-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167162718423.23347.17706545802283934057.kvalo@kernel.org>
Date:   Wed, 21 Dec 2022 12:53:06 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Add some more debug prints in processing regulatory WMI event in order to
> increase more debuggability.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

I see new warnings also here:

drivers/net/wireless/ath/ath11k/wmi.c:5494: line length of 111 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5495: line length of 110 exceeds 90 columns
drivers/net/wireless/ath/ath11k/wmi.c:5496: line length of 112 exceeds 90 columns

Please run ath11k-check.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221214164639.31542-4-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

