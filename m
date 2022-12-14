Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B7264C90C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbiLNM3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbiLNM33 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:29:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8830427CC0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:26:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34510B81888
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A540C433D2;
        Wed, 14 Dec 2022 12:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020792;
        bh=xFFx/nHgu51hBZHLELnsWgVuIX3FAL3BjZKy1Sn/ELE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=DS9+FByjTyYZgjtI1eKAZ1Ed8e/JRN7bn1JuTBc1RxGRVivXPHSZ5AXB30tNZNYDu
         I0JqCHCnme1/gNrqy1Vh437yq+u1q7Bb23hO8EeG4rZ8dddOA4n0YWdo/ZZj9LArHn
         e2NkvabJ3hRDDU/y37qFB45gj45fNCynI8Efq4KW86jqWnuLaNnPGr4/N7cFD4tuR0
         wEWtJFcpIk7vQsSrU6nVEKEDLEIcjmy/H2j4NFV2JsumTM8DbGh6fWbGkH3rONxVlb
         AWtelesCc1tk7n3n/D7UQLatHF0D7JcqrEMb1WhvP485uSE//Zf1C/cG7NGCq+1Gvt
         Tr2j4/MHZIaoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: 8852c: rfk: correct DACK setting
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221209020940.9573-2-pkshih@realtek.com>
References: <20221209020940.9573-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102078667.7997.10585693726676934903.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:26:32 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> After filling calibration parameters, set BIT(0) to enable the hardware
> circuit, but original set incorrect bit that affects a little TX
> performance.
> 
> Fixes: 76599a8d0b7d ("rtw89: 8852c: rfk: add DACK")
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

b2bab7b14098 wifi: rtw89: 8852c: rfk: correct DACK setting
21b5f159a2ee wifi: rtw89: 8852c: rfk: correct DPK settings
9c22d603e255 wifi: rtw89: 8852c: rfk: recover RX DCK failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221209020940.9573-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

