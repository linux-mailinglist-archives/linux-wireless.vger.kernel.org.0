Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2300266BFF6
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 14:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjAPNim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 08:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjAPNia (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 08:38:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2559114E82
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 05:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF38660F95
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 13:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06949C433D2;
        Mon, 16 Jan 2023 13:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673876309;
        bh=9z7SUx0eKwfrrVQ/Wodtw5rDocMtdO/hrLuB44vXrjk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=do2YfjpDrIgEKomZ2SkhkCtmwlfrATV446Np8He4d1D/BIIhdRXV+zpfyUFZZkV5A
         RdoZBsdOmcCbH2IQGL77Xp3TdKVEEAwk4Gjc6ilTQMpobE2L7bul3fmYhuQq5iyVb6
         iegjHpzWZYyTiIPR7WDQIIrMtcJgXJj2s9qD8bmL1+tzk839nlbaQUkgeAvYfQha9D
         vgl4Iujb+IrzUOxjzoSb2A9cZJ1Wdtzg4y3uEE1Y/KLp8FBSbyX0HSitNKIi/NjXVZ
         hIoDHC0KSqj92m8LDJ8Wlv5pgkIH4W21rA5SFwzmn5UDSty2PTkrNnB4qpiI53cjPt
         eZoTidWYFnhVg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: correct register definitions of digital
 CFO
 and spur elimination
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230113090632.60957-2-pkshih@realtek.com>
References: <20230113090632.60957-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <echuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167387630578.32134.12540856871059698480.kvalo@kernel.org>
Date:   Mon, 16 Jan 2023 13:38:27 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Eric Huang <echuang@realtek.com>
> 
> This change fixes the precision of CFO and TX EVM, and it could imporve
> performance in some cases. Also, use the correctted definition for 8852A.
> 
> Signed-off-by: Eric Huang <echuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

15423743ae84 wifi: rtw89: correct register definitions of digital CFO and spur elimination
3aa83062c3ec wifi: rtw89: 8852c: rfk: correct ADC clock settings
7f495de6ae7d wifi: rtw89: fix assignation of TX BD RAM table
a3edb20146f0 wifi: rtw89: 8852b: fill the missing configuration about queue empty checking

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230113090632.60957-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

