Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449C67BD3E8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 08:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbjJIG4r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 02:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJIG4p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 02:56:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C85CF
        for <linux-wireless@vger.kernel.org>; Sun,  8 Oct 2023 23:56:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F93AC433C7;
        Mon,  9 Oct 2023 06:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696834604;
        bh=B517UI6IWrpSO/pRCE7sDQamUbGLk9AEWJFHB6YmzCM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IQd79H5Jm/y42uBNiIBVPWUrcTxaFlUb2wuDNrQa76KYr0xE2a9Sdt3ev2XunMWgA
         LLrK0xeTccQ2RI0GuckxN2CqvEWgDqC/ON1HXuRfmTZtPT8mzCjF1ztnxDkdhvDBNQ
         27mVxQDr4iL3QYXPYwd1K3WoUTx08jS8GHGa+fSs1y/k3J6QoqSvwdrlPtgL9BhuXc
         grXdJrDchzN2IIfPs2mVH5sPPgfNYI9Rr14RdzwAWUG1OF/YGHZ+c0E8p2ayR1F5i8
         6WK0t7c0Cvy8OVc0aLbaIq2YYVYMD+Dhr+VioIG9JDvpXPKjlVRUzzW4qw/bVkgkIk
         ATzvbLH5sCIDQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtlwifi: use unsigned long for bt_coexist_8723
 timestamp
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231004092418.73337-1-dmantipov@yandex.ru>
References: <20231004092418.73337-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169683460090.2071896.12037221209810440149.kvalo@kernel.org>
Date:   Mon,  9 Oct 2023 06:56:42 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'bt_inq_page_start_time' of 'struct bt_coexist_8723' is
> in jiffies, prefer 'unsigned long' over 'u32' to avoid possible
> truncation in 'rtl8723e_dm_bt_inq_page_monitor()' and adjust
> related code. Found with clang's -Wshorten-64-to-32, compile
> tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

71ffa1bcd7a0 wifi: rtlwifi: use unsigned long for bt_coexist_8723 timestamp

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231004092418.73337-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

