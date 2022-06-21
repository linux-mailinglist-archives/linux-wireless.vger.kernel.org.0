Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA86552AE7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jun 2022 08:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345509AbiFUGQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jun 2022 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiFUGQb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jun 2022 02:16:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E119C33
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jun 2022 23:16:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE2C1611D6
        for <linux-wireless@vger.kernel.org>; Tue, 21 Jun 2022 06:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A03C3411D;
        Tue, 21 Jun 2022 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655792190;
        bh=IopbKpDWfYUQvevAJlsEjtPQZV6GVsyrSEzHAzSPtu4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XIUEliUk8Gj+Qd/SR35S1jnn9ghgNufaRdE1rsJQ/t+i4GeHemas77piGuzw9Okl0
         iqVb8qXOhUrL/bfbj6c+/Z4wVcsLuy0uGuHXoEAmfhhQfd0dzXuYi6vjuhj389k5Rv
         mL/+ZCo7yKAI/O76PB7ImKSbdFrM99ktSaOWx1s1l4LL6lJlJzdG8+WaDEgykn4gpH
         92D+AzwAizTlVbc+Qo6DyaBDaMNSYW/72PhZ7Eo7To3Zw/MVvxQZcCzij0q5NbE3g3
         M3PClyEVeoRUIm2X0ovSdJ0aKi7PRjFpGqFkgYc5DO9yM5nG9EXCkp0sq0gAKmzdP2
         slLxCrAQ2ENPA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [01/11] wifi: rtw89: allocate address CAM and MAC ID to TDLS peer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220610072610.27095-2-pkshih@realtek.com>
References: <20220610072610.27095-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <damon.chen@realtek.com>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165579218709.12213.18319918353426636082.kvalo@kernel.org>
Date:   Tue, 21 Jun 2022 06:16:29 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Normally, we only allocate an address CAM and single one MAC ID to AP in
> STA mode. To support TDLS, we handle TDLS peers like AP handles stations.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

11 patches applied to wireless-next.git, thanks.

7312100d4e64 wifi: rtw89: allocate address CAM and MAC ID to TDLS peer
445b6bc362f9 wifi: rtw89: separate BSSID CAM operations
39913cc88540 wifi: rtw89: allocate BSSID CAM per TDLS peer
6a5a783a71cf wifi: rtw89: support TDLS
29363fb666bc wifi: rtw89: fix potential TX stuck
679955d54313 wifi: rtw89: enable VO TX AMPDU
ad663693c1bf wifi: rtw89: add UNEXP debug mask to keep monitor messages unexpected to happen frequently
9a3a593cba9a wifi: rtw89: drop invalid TX rate report of legacy rate
c4756d5de72e wifi: rtw89: fix long RX latency in low power mode
37c6abc374d1 wifi: rtw89: pci: fix PCI doesn't reclaim TX BD properly
47324ab67af7 wifi: rtw89: disable invalid phy reports for all ICs

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220610072610.27095-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

