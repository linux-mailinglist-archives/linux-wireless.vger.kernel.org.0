Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ABAC516D1B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 May 2022 11:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359563AbiEBJQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 May 2022 05:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiEBJQM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 May 2022 05:16:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9245344FE;
        Mon,  2 May 2022 02:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 456C661129;
        Mon,  2 May 2022 09:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5A6C385A4;
        Mon,  2 May 2022 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651482761;
        bh=xp+KaC+MSEbRv63hUTOlIKKRERdSUFG/LI5tuD4UgQo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uIZoj1vAzXEZS1rie5lqt3pySkw8SToFNcEVz7FmOk7lSPddSDXFt/ZXd33ayas67
         BJm+RET/Ifv72bt2rBUrYHEUmxWuU7shfVEv02ZiuPVjaCP0ca2p/G4ogtB/FVxD63
         qeU2OjpwHePZMpOziFGZ2jr6s62FK9S1pV6lSLchX0L5OYM4GK9GQIEfJxK5zaIPM1
         hRu/a1xNVJCwkqDMpj0VuygXHnAyTFfldPyc8qT+hu6g2+Upomvf28tWEXphEGzt1X
         lFPijJNryq63dMLHqq6Lpp8FRJRzRn2XingFJ3qCGDXrzibP0D/jeRdQtWK+Fd59jW
         2ndlrZiOIblAg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>, <mka@chromium.org>
Subject: Re: [PATCH v7 4/9] ath11k: Add register access logic for WCN6750
References: <20220429170502.20080-1-quic_mpubbise@quicinc.com>
        <20220429170502.20080-5-quic_mpubbise@quicinc.com>
Date:   Mon, 02 May 2022 12:12:36 +0300
In-Reply-To: <20220429170502.20080-5-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 29 Apr 2022 22:34:57 +0530")
Message-ID: <87o80gb8mz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> WCN6750 uses static window mapping to access the HW registers.
> Unlike QCN9074 which uses 3rd window for UMAC and 2nd window
> for CE register access, WCN6750 uses 1st window for UMAC
> and 2nd window for CE registers.
>
> Also, refactor the code so that WCN6750 can use the existing
> ath11k_pci_read32/write32() APIs for accessing the registers.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00192-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

>  	{
>  		.name = "wcn6750 hw1.0",
> @@ -527,7 +539,10 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.m3_fw_support = false,
>  		.fixed_bdf_addr = false,
>  		.fixed_mem_region = false,
> +		.static_window_map = true,
>  		.hybrid_bus_type = true,
> +		.dp_window_idx = 1,
> +		.ce_window_idx = 2,
>  	},

In the pending branch I moved setting of static_window_map to patch 3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
