Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F4676CBDB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjHBLhI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjHBLhC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AED211E
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:37:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB7676191C
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F44C433CC;
        Wed,  2 Aug 2023 11:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690976220;
        bh=bQYnWsfeRljqk1mmtmVRAyq5XZ7VtvuLqFh9lbdjcrM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fE/iYIAjau3g+EFehzi2StLIisw1EDqMKbk6mimm41dNcrrqCtwOV7OSgt7qSEFxq
         H8l95ylXJuimSKNrr5+/QajPHCtbOKVZMazfhmodgNiCG9azn4VN6o++BmcYo7IU53
         jOf5Mv0LjMyptEcgjept68R9YB4XocdyTgyxCn3jROG1JtHFFdHHERtJ72N2MgUcyz
         YSZN1AMyo2ySmkwyb3iaodOFW21nc8vtw76fD1gDGSeEqToGafWYhBe7x2AewwWmFs
         j4Obv/vgdvFem8neYo9RxfFDbNdxeVL+Ft9wkh1DD8o+c40agICoDfkeaSg81ipPK9
         r/bX6BuUDHJ/A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] wifi: ath11k: store cur_regulatory_info for each
 radio
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
        <20230607094810.26707-3-quic_wgong@quicinc.com>
Date:   Wed, 02 Aug 2023 14:36:57 +0300
In-Reply-To: <20230607094810.26707-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 7 Jun 2023 05:48:07 -0400")
Message-ID: <874jlhwu92.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> writes:

> The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
> in ath11k now, the info should be saved in ath11k. Save the info for
> each radio and support switch regulatory rules dynamically.
>
> Tested-on: WCN6855 hw2.0 PCI
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>

[...]

> +	ret = ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
> +	if (ret) {
> +		ath11k_dbg(ab, ATH11K_DBG_WMI,
> +			   "failed to process regulatory info from received event\n");
> +		goto mem_free;
>  	}

Why the warning message is using ath11k_dbg()? I think it should be
ath11k_warn() and also print ret value.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
