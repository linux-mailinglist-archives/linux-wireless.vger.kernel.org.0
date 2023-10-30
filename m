Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F137DBEB6
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjJ3RV4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJ3RVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:21:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6A93
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:21:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDE7C433C8;
        Mon, 30 Oct 2023 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686511;
        bh=rANL6psiG5ulAXPSIn2MnjE22OYsPykwhcAwasBKuSk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XyXqIMgj9u4RNNf/AAu7B2QVan7oElvBSCdwlIdAibRBlOtm8QuhMzldbF4Cg9/iY
         k0T37b8POR38a0xWxicfOhRU40iqjRU+AMuJDlb/jBf4z+Ejp7fuqY64PwTOcNDVgV
         ZeetXJdQm9Ine7k0Q1uH+IcSboVfV4a4wlXZ6WQu6ycUKOo+cSJC0kZq+MojguT/AU
         A+bQVgXkQCEQHGJ1x0nr2fpwGvsVHECl7QIWLpKHENKA71L/D3dOIa3A2kTJuSLXaP
         z6FgtzMKefrcXqdzIgxw1ALmGF67bDhN2J73KUXpKBElwovT4vVMfzmdCfiAc0O2Nc
         nRR5wfUVMDA7g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] [v2] wifi: rtlwifi: cleanup struct rtl_hal
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231023091722.52509-1-dmantipov@yandex.ru>
References: <20231023091722.52509-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868650882.1993746.2479350711464936750.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:21:50 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Remove unused and set but otherwise unused 'bbrf_ready', 'external_pa',
> 'pa_mode', 'rx_tag', 'rts_en', 'wow_enable' and 'wow_enabled' fields
> of 'struct rtl_hal', adjust related code. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

d1e6b020c32d wifi: rtlwifi: cleanup struct rtl_hal
d1337ccb4477 wifi: rtlwifi: cleanup struct rtl_phy
7419d8ab3508 wifi: rtlwifi: rtl92ee_dm_dynamic_primary_cca_check(): fix typo in function name

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231023091722.52509-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

