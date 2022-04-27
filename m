Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92941511263
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Apr 2022 09:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358765AbiD0Hbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiD0Hbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 03:31:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70406E572
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 00:28:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 874F961A56
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 07:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12800C385A7;
        Wed, 27 Apr 2022 07:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651044506;
        bh=kXHzBg/iTHGXGr9gIb2+0tGXBw6gYM+j0fsfvgN8s5c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=BWS633cDSAVUo42/bMEyN+8q60+Wd1SvjlexMfEA0+CMQgwqpu1Wna/YSlSJp81rM
         nCYFVhvd6D7PuJW6QDtChaW4+qnyd883zF9A3BTdsUvbZOuveTz4j2F1loBOQpjZL9
         d5T6fOWGEtlU+X6Dm6cDXFblqAroNwrAqDmOKqZpjPdFkMGUUsAEeooeFWhNQyeE6K
         l+hzOQFal0Hp8Ic1ZhHnWdV0iPtPmx2rHT1zkl25saZvp5gfofsozPvBnYMn9PCGUu
         Gs2q7go+gWhtDWtQDdZH5gjhiZ3FOOTkk3+QDQsCLdHFkYhhxqaqGLJ0gWkMdi8BUe
         0817nYZqG6SxA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: add read country code from SMBIOS for
 WCN6855/QCA6390
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220421023501.32167-1-quic_wgong@quicinc.com>
References: <20220421023501.32167-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165104450322.30072.25044330550359945.kvalo@kernel.org>
Date:   Wed, 27 Apr 2022 07:28:24 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> This read the country code from SMBIOS and send the country code
> to firmware, firmware will indicate the regulatory domain info of the
> country code and then ath11k will use the info.
> 
> dmesg:
> [ 1242.637173] ath11k_pci 0000:02:00.0: chip_id 0x2 chip_family 0xb board_id 0xff soc_id 0x400c0200
> [ 1242.637176] ath11k_pci 0000:02:00.0: fw_version 0x110b09e5 fw_build_timestamp 2021-06-22 09:32 fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HSP.1.1-02533-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> [ 1242.637253] ath11k_pci 0000:02:00.0: worldwide regdomain setting from SMBIOS
> [ 1242.637259] ath11k_pci 0000:02:00.0: bdf variant name not found.
> [ 1242.637261] ath11k_pci 0000:02:00.0: SMBIOS bdf variant name not set.
> [ 1242.637263] ath11k_pci 0000:02:00.0: DT bdf variant name not set.
> [ 1242.927543] ath11k_pci 0000:02:00.0: set current country pdev id 0 alpha2 00
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

66721bb4bbf2 ath11k: read country code from SMBIOS for WCN6855/QCA6390

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220421023501.32167-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

