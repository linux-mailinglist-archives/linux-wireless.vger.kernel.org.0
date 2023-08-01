Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5ED76B7E9
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjHAOqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjHAOqM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:46:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5F122
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:46:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00E83615CC
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E15C433C7;
        Tue,  1 Aug 2023 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901170;
        bh=Xn1dJTBkJRTAyygNhF4Het0NwchTQ+2ConYlA6ok6W4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=otnYvxAf9cXzyD7QexQLOuw7yVx/F57T9clGp3S1OlUXjqb89g78hMivbvWAb9EMp
         E7kiRSw1AqPFiZnbjNWm4Ape94R+DBzj6GjxUArRAPaUSHgl3wC914XYjQvVeURQ74
         prpp+ZQ3m/GhPSg1MK7AkvE9Jks60ggw8OOxCMQcMVJYY1tVg3iZFM/yvH5Ep6ku+R
         ynRI8C1h1HMUR8kLsoxNJJsErVTduEknrMb2Sqk5v6sNkZZ1uDV1I0AgdwjxfGIxQZ
         FELRC/e2kxCRz5Y99NmqNMOJIjpJQbHsCEPYR3rdpRM2sZwrvRFXdNK3ZDiATJeQOX
         /45PQ8dDh+LXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/10] wifi: rtw89: add chip_info::chip_gen to determine
 chip
 generation
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230728070252.66525-2-pkshih@realtek.com>
References: <20230728070252.66525-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169090116792.212423.963123318603680084.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:46:09 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The coming WiFi 7 chip is 8922AE which uses different hardware rate and
> register naming rule. Adding a chip_info::chip_gen field can help to
> do things by generations accordingly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

10 patches applied to wireless-next.git, thanks.

f698afa7ce37 wifi: rtw89: add chip_info::chip_gen to determine chip generation
9e5c6c0df94e wifi: rtw89: define hardware rate v1 for WiFi 7 chips
2ef14155c29b wifi: rtw89: phy: rate pattern handles HW rate by chip gen
401b0c161b09 wifi: rtw89: use struct to set RA H2C command
c97683ff01a4 wifi: rtw89: add H2C RA command V1 to support WiFi 7 chips
c342ac219516 wifi: rtw89: use struct to access firmware C2H event header
57cafeb18f06 wifi: rtw89: use struct to access RA report
5c152231c341 wifi: rtw89: add C2H RA event V1 to support WiFi 7 chips
ae775faa8750 wifi: rtw89: add to display hardware rates v1 histogram in debugfs
023d2f14abf8 wifi: rtw89: get data rate mode/NSS/MCS v1 from RX descriptor

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230728070252.66525-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

