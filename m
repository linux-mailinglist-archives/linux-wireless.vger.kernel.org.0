Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BC4BE16C
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 18:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbiBUKqT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 05:46:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355258AbiBUKph (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 05:45:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0EC25E8B
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:06:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C529960C07
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B10C340E9;
        Mon, 21 Feb 2022 10:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645437981;
        bh=FT0e8Ht5k2q94glinU6HbAj1Aa95MsDKe6+mdPkdouE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H3wq1wfdA8lQLYul6bP8asnyX6BA9V58maliPHvk7yE5KEenCk8pREM+gcYRt1nJd
         AzAzyHdJfsj8kHpoPr1FCPo6IWdRIqte5M8McY0LzjA0xtuYCNCT7fnaG6bXLZjYx4
         2ntHbjGUYkZyEE7hdGHeX/sXkXEzPk1i5YWqE/kL4ASigHdhoHeJzi+OYjhOFnz+Mx
         Stv2bxZbYqWtK2Omv3GRpDyT+OSm/F3FdtmE8fSZtybD74xFnjaYW/Y10oaEI14PJL
         nGLy3aOyGXMxaKTAxsaMz2a15NW46yrtmVDdKW/lZM25m2NfbOEgLIekSd+3iU9lZq
         zLHIQEMiGS7XA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 1/6] ath11k: add ath11k_qmi_free_resource() for
 recovery
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220209060012.32478-2-quic_wgong@quicinc.com>
References: <20220209060012.32478-2-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543797644.26423.1127777778096359819.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 10:06:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> ath11k_qmi_free_target_mem_chunk() and ath11k_qmi_m3_free() is static
> in qmi.c, they are needed for recovery, export them in a new function.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

5f71968e3c76 ath11k: add ath11k_qmi_free_resource() for recovery
e52b6a02bfc0 ath11k: fix invalid m3 buffer address
03e0add74212 ath11k: configure RDDM size to mhi for recovery by firmware

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220209060012.32478-2-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

