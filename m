Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AFF72DD69
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbjFMJPe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbjFMJPG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 05:15:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38B1B0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 02:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A32706326D
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 09:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99B1C4339B;
        Tue, 13 Jun 2023 09:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686647704;
        bh=JKBkTIwWYa/gnKOWIS3YMlHF+x0MovPcQPCPXxXUptY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Igv3dXfHmRtoB0Ey7FvNp43NFTWMUSh2iBLNuhjCqyZ9JLb9fUHxddVQ2kx2KVV6G
         BzCI2UVSKOjxrTtub8QZE+WQWUvVjHQJrq0C2K2DWmocO7EaNYtzCicSKNaT4WVC77
         FFx/KYxlIxJj1dbwFTChkqeR8XniiPOiNQ21SM0TlypVSvYUKMeQVOwa/sY+wCvibs
         uExqGRKKLg2NHbM12AfBqozfz4nTpiIildoy7xLJld8pJYurBr/81/vLo6mp7IM4Go
         PbZsZ1rwZeO15TiRkmuAeeSOb1y9Bie8QFyFsBch7C8gDL8t+SHssmdthltrYzopuS
         TgiO6JnykxE9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix memory leak in WMI firmware stats
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230606091128.14202-1-quic_adisi@quicinc.com>
References: <20230606091128.14202-1-quic_adisi@quicinc.com>
To:     Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168664770075.2274.7742799592706415506.kvalo@kernel.org>
Date:   Tue, 13 Jun 2023 09:15:02 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aditya Kumar Singh <quic_adisi@quicinc.com> wrote:

> Memory allocated for firmware pdev, vdev and beacon statistics
> are not released during rmmod.
> 
> Fix it by calling ath11k_fw_stats_free() function before hardware
> unregister.
> 
> While at it, avoid calling ath11k_fw_stats_free() while processing
> the firmware stats received in the WMI event because the local list
> is getting spliced and reinitialised and hence there are no elements
> in the list after splicing.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

6aafa1c2d3e3 wifi: ath11k: fix memory leak in WMI firmware stats

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230606091128.14202-1-quic_adisi@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

