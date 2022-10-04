Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373D85F3E16
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJDISz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiJDISU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 04:18:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29E6149
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 01:18:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F7561290
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 08:18:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22587C433D6;
        Tue,  4 Oct 2022 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664871498;
        bh=ATpIqvbT+eZEBC5fPb02OC2jEVWqFdvYpwX8o0ciNtY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=esilWYNW/fKWy23r1WBLhq6ub334yR/vDgQ8xMD+vYL8eNnV2Z4HFUEapGokVqwtA
         j/2oc2SNLmqYrRKOI3uabeZkSgpqY2nRmKykEK07QFEG197d5qgE83ifbasSfcxgb9
         60WwV/hfAaMbFFyQ4sFauuRUioIUO0wla7Tiwki/O55uSHAH/7jxSgBvsWp1ajEN+h
         hVyPsuwBDEz++ow4RB8IRAp/knWARJKfmKDz50zr5pnto0XcssoAInN/FtXt40b/1w
         cz0EcUTW4noHJN7yp6gZeW/0h/aqgM0k22BUKV4F2YiB5MkHxfkOTP58xQeSr0K3kp
         m2H0BHe2wNQog==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] wifi: rtl8xxxu: gen2: Turn on the rate control
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
References: <43200afc-0c65-ee72-48f8-231edd1df493@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        Jes Sorensen <Jes.Sorensen@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166487149459.9318.3375191834985088151.kvalo@kernel.org>
Date:   Tue,  4 Oct 2022 08:18:17 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Re-enable the function rtl8xxxu_gen2_report_connect.
> 
> It informs the firmware when connecting to a network. This makes the
> firmware enable the rate control, which makes the upload faster.
> 
> It also informs the firmware when disconnecting from a network. In the
> past this made reconnecting impossible because it was sending the
> auth on queue 0x7 (TXDESC_QUEUE_VO) instead of queue 0x12
> (TXDESC_QUEUE_MGNT):
> 
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 1/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 2/3)
> wlp0s20f0u3: send auth to 90:55:de:__:__:__ (try 3/3)
> wlp0s20f0u3: authentication with 90:55:de:__:__:__ timed out
> 
> Probably the firmware disables the unnecessary TX queues when it
> knows it's disconnected.
> 
> However, this was fixed in commit edd5747aa12e ("wifi: rtl8xxxu: Fix
> skb misuse in TX queue selection").
> 
> Fixes: c59f13bbead4 ("rtl8xxxu: Work around issue with 8192eu and 8723bu devices not reconn…")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

c5ef1cee5745 wifi: rtl8xxxu: gen2: Turn on the rate control

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/43200afc-0c65-ee72-48f8-231edd1df493@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

