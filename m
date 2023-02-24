Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152266A1DCC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 15:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjBXOuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Feb 2023 09:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBXOuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Feb 2023 09:50:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE9B83E4
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 06:50:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CBC9618EA
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 14:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2255BC4339E;
        Fri, 24 Feb 2023 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677250221;
        bh=3KYModGEa1fFUiOUb3e6wEc1y8k/P7sxe/QwXRZ0OKc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=qGHibDBPCsXXluVYelKbKM01+ZB6GWzXSZLPFqoFEn96mLloJ0DDUvEagcn2loaNO
         fXKo/MPLbexwy+d/kInrZ58pU9ZMKMoEbBNNJynMhu32iFpy5t7bZyOn9C9ylGXWPP
         IhUmembG7wbhL7QVhyBD1GRlsei1nVSm/JIKjlWcZQ01r0VyhWNuRk8XFn5HvhAGbN
         5kHayr1gWZKPwUtIWTdrSrYsUgs4L5CSdNGsphj4Ka0VVm1L1hOKBHgWP2zN+OVvj6
         0a+Vbs/om6JCWsDvpNUHMuzYtCjwaz3zavUnaWCH4MnrVyBKv5M9tvsbgXgPk32u1Q
         /fWcr2cvXyHrQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] ath11k: Enable low power mode when WLAN is not active
References: <20230203060128.19625-1-quic_mpubbise@quicinc.com>
        <20230203060128.19625-4-quic_mpubbise@quicinc.com>
Date:   Fri, 24 Feb 2023 16:50:17 +0200
In-Reply-To: <20230203060128.19625-4-quic_mpubbise@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 3 Feb 2023 11:31:28 +0530")
Message-ID: <87cz5zruc6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable for a battery operated device. Same is the case with non-WoW
> suspend, chip will never be put into low power mode when the system is
> suspended resulting in higher battery drain.
>
> As per the recommendation, sending a PDEV suspend WMI command followed
> by a QMI MODE OFF command will cease all WLAN activity and put the device
> in low power mode. When WLAN interfaces are brought up, sending a QMI
> MISSION MODE command would be sufficient to bring the chip out of low
> power. This is a better approach than doing hif_power_down()/hif_power_up()
> for every WiFi ON/OFF sequence since the turnaround time for entry/exit of
> low power mode is much less. Overhead is just the time taken for sending
> QMI MODE OFF & QMI MISSION MODE commands instead of going through the
> entire chip boot & QMI init sequence.
>
> Currently the changes are applicable only for WCN6750. This can be
> extended to other targets with a future patch.
>
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.16
>
> Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>

[...]

> +static int ath11k_ahb_core_start_ipq8074(struct ath11k_base *ab)
> +{
> +	/* TODO: Currently initializing the hardware/firmware only
> +	 * during hardware recovery. Support to shutdown/turn-on
> +	 * the hardware during Wi-Fi OFF/ON will be added later.
> +	 */
> +	if (!test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags))
> +		return 0;
> +
> +	return ath11k_core_start_device(ab);
> +}
> +
> +static void ath11k_ahb_core_stop_ipq8074(struct ath11k_base *ab)
> +{
> +	/* TODO: Currently stopping the hardware/firmware only
> +	 * during driver unload. Support to shutdown/turn-on
> +	 * the hardware during Wi-Fi OFF/ON will be added later.
> +	 */
> +	if (!test_bit(ATH11K_FLAG_UNREGISTERING, &ab->dev_flags))
> +		return;
> +
> +	return ath11k_core_stop_device(ab);
> +}

Please clarify what Wi-Fi OFF/ON exactly means on these two comments,
it's not clear for me.

Also I want to mention that I suspect eventually we have to always power
off the firmware during suspend to get hibernation working:

https://bugzilla.kernel.org/show_bug.cgi?id=214649

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
