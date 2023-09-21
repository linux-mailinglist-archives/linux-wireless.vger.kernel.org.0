Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060037AA0AC
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 22:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjIUUqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 16:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjIUUqO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 16:46:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C08780FA2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:36:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C98C116A9;
        Thu, 21 Sep 2023 08:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283376;
        bh=IOdNZNubT9aIKkrAuzJC/mLMct1EI8QHVI/pL/hli6Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Yrfq946hPwnkGTVSaqo00WtrSsQR6WYrjwOYpxTcuW55WmhTsfyf2usR/CG1c2g8z
         g5u55R+5BWMI33pC1C3rRf4lIb/h+RWUSotdn+Ac9L20pMNEEujkXFLHaA/3IldEMS
         AXet4R2lDMMejOt6LrAK6LU1jyT7QbryeFri3UsnOObWMUwl0YCgAPMrNLqaZFuy6q
         To1gNw0nn5VXYqCXVemoLwIiUDZoxKbHCeQOEbnzhN60IVRz/45zhqSaTlBsZc525Y
         fn+1YfBXtHSRFIYIoAtSkfRKhX/eMWBxSLI5EnevQHBFYPeKNf7R5olAr5BhAvAvw7
         3p8fdfccf40PA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix DMA unmap warning on NULL DMA address
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830021131.5610-1-quic_bqiang@quicinc.com>
References: <20230830021131.5610-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169528337320.1539628.12793449694122971146.kvalo@kernel.org>
Date:   Thu, 21 Sep 2023 08:02:55 +0000 (UTC)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> In ath12k_dp_tx(), if we reach fail_dma_unmap due to some errors,
> current code does DMA unmap unconditionally on skb_cb->paddr_ext_desc.
> However, skb_cb->paddr_ext_desc may be NULL and thus we get below
> warning:
> 
> kernel: [ 8887.076212] WARNING: CPU: 3 PID: 0 at drivers/iommu/dma-iommu.c:1077 iommu_dma_unmap_page+0x79/0x90
> 
> Fix it by checking skb_cb->paddr_ext_desc before unmap it.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

9ae8c496d211 wifi: ath12k: fix DMA unmap warning on NULL DMA address

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830021131.5610-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

