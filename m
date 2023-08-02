Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2609E76CBC8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Aug 2023 13:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjHBLbB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 07:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjHBLbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 07:31:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5138211B
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 04:30:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9A2E6192E
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 11:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD00C433C8;
        Wed,  2 Aug 2023 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690975858;
        bh=4Vaae40qqGxW8R/6dHIGcwOUOUHcW3fvn7vSPHPAkqg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nZYg6adai1wgb+4OAIrt7bPJG6g09OiiJpZhAebmbpbxF3wlWhatwVdKow3CN7JJn
         W8Oy8/IO/VJnI5Z4mEKJggqcQwAOlRfAaHjt0Ffr4aRuckfQdCUwQUKwIEeJYHwo1H
         2Af95FFJubryYQ9sxFZ2iqXx1oBsaBAnHR7M7DNkCeJePnfQVyRPh6KHQRku3nkVQh
         Wq3nCU/nM/km4pc9R4BQ9ayb8xNqLVc30tNVpT4cB0xzD9w6IW5zusTIqCFKNuYoZG
         DDuvwxp7f2DW/3JFyRWh8goe7VnYkVWHv4Nz1/CKbhMc88Qy6qYU9OUWoWhNdSrY3O
         1Sb9R0FJZpW8w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/5] wifi: ath11k: store cur_regulatory_info for each
 radio
References: <20230607094810.26707-1-quic_wgong@quicinc.com>
        <20230607094810.26707-3-quic_wgong@quicinc.com>
Date:   Wed, 02 Aug 2023 14:30:55 +0300
In-Reply-To: <20230607094810.26707-3-quic_wgong@quicinc.com> (Wen Gong's
        message of "Wed, 7 Jun 2023 05:48:07 -0400")
Message-ID: <878ratwuj4.fsf@kernel.org>
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

> +enum wmi_vdev_type ath11k_mac_get_ar_vdev_type(struct ath11k *ar)
> +{
> +	struct ath11k_vif *arvif;
> +
> +	list_for_each_entry(arvif, &ar->arvifs, list) {
> +		return arvif->vdev_type;
> +	}
> +
> +	return WMI_VDEV_TYPE_UNSPEC;
> +}

This function looks odd to me and there are no comments to clarify.
What's the idea of using list_for_each_entry() and then immediately
return with the first entry? I guess the assumption here is that every
arvif has the same type? Can we really trust that? And at least it
should be documented here.

Also wouldn't list_first_entry_or_null() be more intuitive?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
