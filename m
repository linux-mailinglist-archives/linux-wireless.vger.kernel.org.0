Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0217B682B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 13:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjJCLnf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 07:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjJCLnf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 07:43:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823B9E
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 04:43:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF8BFC433C8;
        Tue,  3 Oct 2023 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696333411;
        bh=If9HVbuazEn6sAFnxE1hhqlt0QODRA68PURiXdO1W2c=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lojKNxoj1nL+yEU/tOVXSHWasEk4GMmp7XpoO3VIqEes6hWnmSqWvxeA/AINvtUGo
         uF6C4rGldM6V6KpJrgTlyJbtSdXjqMWw4pVIzTpInSzK3r/kbze1XJ9cU4X29jotIL
         zy8UMZB6uWDEwbUG5UMwC7qfua1cUo22wlaaota25+N+VUkveZ/zr8btMtsRhVRF90
         ku6memtM0mKMeNgcCbqlZHyqXCT7RR/CktzhkD6Eydtt9etOP/da5yBt9OfCDr369M
         qJKuMIMhmNFi2eCYVBMUOcUThW5ggVU9gk6/Q5UL8FRP7PQgF9fpYvaU8JYsNjODdi
         H0mDnqwOGdZTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] [v2] wifi: rtlwifi: fix EDCA limit set by BT coexistence
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230928052327.120178-1-dmantipov@yandex.ru>
References: <20230928052327.120178-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169633340846.28914.7192576233008842750.kvalo@kernel.org>
Date:   Tue,  3 Oct 2023 11:43:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'rtl92c_dm_check_edca_turbo()', 'rtl88e_dm_check_edca_turbo()',
> and 'rtl8723e_dm_check_edca_turbo()', the DL limit should be set
> from the corresponding field of 'rtlpriv->btcoexist' rather than
> UL. Compile tested only.
> 
> Fixes: 0529c6b81761 ("rtlwifi: rtl8723ae: Update driver to match 06/28/14 Realtek version")
> Fixes: c151aed6aa14 ("rtlwifi: rtl8188ee: Update driver to match Realtek release of 06282014")
> Fixes: beb5bc402043 ("rtlwifi: rtl8192c-common: Convert common dynamic management routines for addition of rtl8192se and rtl8192de")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

3391ee7f9ea5 wifi: rtlwifi: fix EDCA limit set by BT coexistence

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230928052327.120178-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

