Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444337CF141
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344829AbjJSHaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSHaN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:30:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1D89F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:30:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF7C433C8;
        Thu, 19 Oct 2023 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700611;
        bh=Q6ljW3apHy3A+ic7lg/JrRHklhVp0Gl6lRNCyWGIAF8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OTUII57P8xo4sNMZA9SOyd75drmKpftt5eAoHmJ0vq57eh4LSpUGm5H0pEbOHVkdZ
         UJ+6kJFv4nmWMZp+pQxw7AOdEoPU9R9n3RaWjXa11U6IYCLjU6/LPJCDO40got0ucH
         ncFK61DjqM8wA2CG94qc9DrvJCF5rQPM+WUzLgw+awsSHTxe71q4rKwKOeMqkX2MRk
         91s1Hh5A8JnczR4KS0LHiFeN2FiqBRngEJ8XfVN716XlQfjQmtdFxVDHupUfxQIUNH
         GKFCMjAxMq3vYtNOV+rCrB+HI7MNthn6Cq/aiTeRhL85ue3pMvesWlBUGZcelHrF6H
         qtnZg9LrIppNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtlwifi: drop pre_fill_tx_bd_desc() from HAL
 interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231016135925.129223-1-dmantipov@yandex.ru>
References: <20231016135925.129223-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770060845.117236.6582869818092142659.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:30:10 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'pre_fill_tx_bd_desc()' is actually used for rtl8192ee only,
> there is no need to maintain function pointer in 'struct rtl_hal_ops',
> and 'rtl92ee_pre_fill_tx_bd_desc()' may be converted to static.
> Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

fc83ee9d587f wifi: rtlwifi: drop pre_fill_tx_bd_desc() from HAL interface
9e58030622d0 wifi: rtlwifi: drop fill_fake_txdesc() from HAL interface
2f4ae0feab8b wifi: rtlwifi: drop chk_switch_dmdp() from HAL interface

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231016135925.129223-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

