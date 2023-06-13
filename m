Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532572DC2B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbjFMISb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 04:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjFMISa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 04:18:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A2EA
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 01:18:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE336109A
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 08:18:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EC6C433D2;
        Tue, 13 Jun 2023 08:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686644309;
        bh=2CT0RsKHdy9H78RC79+0zcuBYFt+2jfocKa7673XWVs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=l6kSonhl+du/a9J/VsYEER8jwFuZDaZDwm3Y2JJ4YAvPGTrDrmrI83k3C/UlcIoqi
         mOJZMtgVQeeD+a6Xwntb5knTOyqLpunKBVtJZpgrS5onld1h4wWnRQYwZs/WL7ViXt
         cNZlG3b9RQ3CEePaZmmGKg2WkAi5Z9+ERDW31eqjGn5sSs3GvBpzak3dxaZfzFRv+U
         KM6e/lyfTdO2L+9g+DF6FdPQ/cGzKAsRmZkrgUAxkRlo2rciVWFbhRigF+XuRRDaFI
         uWbBH70hK6SNP3Azq3KktMoxJRfiPXC2SzaT/k5Ula6i8vLta4Uf78qbQPLyobWyXB
         cnNRM4KeOQ4Zg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] rtlwifi: rtl8188ee: mark RTX_POWER_{BEFORE,AFTER}_IQK_A reads as unused
References: <b2198915-0e92-de99-d950-be46c2bd8e91@yandex.ru>
        <20230601105215.27013-1-dmantipov@yandex.ru>
Date:   Tue, 13 Jun 2023 11:18:25 +0300
In-Reply-To: <20230601105215.27013-1-dmantipov@yandex.ru> (Dmitry Antipov's
        message of "Thu, 1 Jun 2023 13:52:15 +0300")
Message-ID: <87edmfepwu.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> According to Ping-Ke Shih, it may be unsafe to remove BB register reads
> even if we don't interested in their values. OTOH such a reads may confuse
> compilers (when the most strictness warning options are enabled) and/or
> static analysis tools. So it may be helpful to convert related calls of
> 'rtl_get_bbreg()' to 'void' and mark such a cases with special comment
> just to make them easier to find and maybe even fix in the future.
>
> This is generally inspired by 6c75eab0417b9e5b05a18dbfc373e27a8ef876d8.
>
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

"wifi:" missing from the title, see the wiki link below for more info.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
