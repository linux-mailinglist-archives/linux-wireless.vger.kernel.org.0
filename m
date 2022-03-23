Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937D54E4E82
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Mar 2022 09:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbiCWItX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Mar 2022 04:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiCWItW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Mar 2022 04:49:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01426A042
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 01:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB75B81E29
        for <linux-wireless@vger.kernel.org>; Wed, 23 Mar 2022 08:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40822C340E8;
        Wed, 23 Mar 2022 08:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648025271;
        bh=OtboGfQ4nln/SD/C9db5T8Det9nN39lKrrfx+rNmNiw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NbOOo/RTSmGtqNlh/1grhsnQ3nXB5UxpSF0P3pyQ2jUt2JjmJs/SsXQbZhLSME/ZK
         3nbUZBWk6Qlhz/CdNbyGfYgVw9PN81xSNJLnfeYH8QnRiyfFS9opIgmgrxE93ldf6w
         jJBBEGGVpod6AGs7iXK+9h0lrP08TkGLB3bRMFlkGnKxlXkt9fctbtBWkUT8/ImnjJ
         YoKaazr1FIOvclckDXAv78kG3Cd0pHneL1unYvE2mybW8BDSYQb1VVqHcv6B9RA5r8
         bgiDZSy0EZpVVbJNH4qr4IGz72YgGTJmToKP+PstTHP8drlKtD5SvlwJcrNEgVjpUv
         7M5moA9GO9ZRg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 2/2] ath11k: add read variant from SMBIOS for download board data
References: <20220315104721.26649-1-quic_wgong@quicinc.com>
        <20220315104721.26649-3-quic_wgong@quicinc.com>
Date:   Wed, 23 Mar 2022 10:47:46 +0200
In-Reply-To: <20220315104721.26649-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Tue, 15 Mar 2022 06:47:21 -0400")
Message-ID: <87r16tkqbx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> This is to read variant from SMBIOS such as read from DT, the variant
> string will be used to one part of string which used to search board
> data from board-2.bin.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +struct ath11k_smbios_bdf {
> +	struct dmi_header hdr;
> +	u32 padding;
> +	u8 bdf_enabled;
> +	u8 bdf_ext[1];
> +};

I was about to commit this but noticed bdf_ext[1], is there a reason for
that? Use of [1] in arrays is deprecated nowadays:

https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
