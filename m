Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925796F7DF1
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 09:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjEEHcl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjEEHck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 03:32:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E6B17FFB
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 00:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A88C963BF0
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 07:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7648C433EF;
        Fri,  5 May 2023 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683271948;
        bh=v5/trn1VgF1br5n+yuYUzrBePNXjtDAgMbWmfRdeT3Q=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rQnYY/+udoJ6rGPXvgA1KSSLzZS6w/4fMYPJn64XGIPWLZkbvCyV8kypIbkedi/pY
         znwXpvpj/YMM9pJ+jxifrGdnoGJWrxOhnYPFRv38CzvfRoY/9H7aPxwyq0g/+ptiT1
         Q6+ermhr2TvKZQwzOl/9pWcW5ni/dP9HFpTooxt2LbHTFATXfEJDe4sjOl5W4HrMeh
         2SzkMsdmW/L4Vuu50/8AtN4Tip798kqQvaCjaPhmBr7l1q7oqypOdVQMXyGmRduN+z
         zbanOj5FLhHcchnPrCawafrJyh54fi19O8QsRqLtv9Dla5ZHmEIkQXUdd76iN6jmL3
         SNiape1kKYqvg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 01/18] wifi: rtl8xxxu: Add start_ap() callback
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230428150833.218605-2-martin.kaistra@linutronix.de>
References: <20230428150833.218605-2-martin.kaistra@linutronix.de>
To:     Martin Kaistra <martin.kaistra@linutronix.de>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168327193798.10202.15539315563221699626.kvalo@kernel.org>
Date:   Fri,  5 May 2023 07:32:26 +0000 (UTC)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Martin Kaistra <martin.kaistra@linutronix.de> wrote:

> This gets called at the start of AP mode operation. Set bssid, beacon
> interval and send a connect report to the HW.
> 
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

18 patches applied to wireless-next.git, thanks.

ac48499e2bf5 wifi: rtl8xxxu: Add start_ap() callback
25ed009cc0aa wifi: rtl8xxxu: Select correct queue for beacon frames
cde8848cad0b wifi: rtl8xxxu: Add beacon functions
f5db4d11fda1 wifi: rtl8xxxu: Add set_tim() callback
20d595154894 wifi: rtl8xxxu: Allow setting rts threshold to -1
fd5440f9311f wifi: rtl8xxxu: Allow creating interface in AP mode
d59a105acc03 wifi: rtl8xxxu: Actually use macid in rtl8xxxu_gen2_report_connect
2be2eed4c39b wifi: rtl8xxxu: Add parameter role to report_connect
40d02ff2b186 wifi: rtl8xxxu: Add parameter force to rtl8xxxu_refresh_rate_mask
726e478ce1b3 wifi: rtl8xxxu: Add sta_add() and sta_remove() callbacks
9aa45598d054 wifi: rtl8xxxu: Put the macid in txdesc
769f326322e7 wifi: rtl8xxxu: Add parameter macid to update_rate_mask
89819a651144 wifi: rtl8xxxu: Enable hw seq for mgmt/non-QoS data frames
66dcb574418e wifi: rtl8xxxu: Clean up filter configuration
07342528f7c8 wifi: rtl8xxxu: Remove usage of ieee80211_get_tx_rate()
19b396c241cf wifi: rtl8xxxu: Remove usage of tx_info->control.rates[0].flags
b468481c9ad3 wifi: rtl8xxxu: Declare AP mode support for 8188f
b9a07c443a82 wifi: rtl8xxxu: Set maximum number of supported stations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230428150833.218605-2-martin.kaistra@linutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

