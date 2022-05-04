Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F575196EC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 07:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244716AbiEDFgi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 01:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238209AbiEDFgh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 01:36:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C0B24959
        for <linux-wireless@vger.kernel.org>; Tue,  3 May 2022 22:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18817B82353
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 05:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B627C385A5;
        Wed,  4 May 2022 05:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651642378;
        bh=lPDb0FcfugjIGOlWiNp7HUcz92JxPNdL+1xBYh7sYLA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ixEKci21KbZej5GX7bAfy8lxnAH3lYd+nHpS5M0rsgip6qG8F2L3WtQSKkM40zvvx
         14G/+73hSE/k8iP9RiXHwmB26kTrUh5r76a4fDEeo9cQqqnkx+QtQrGBhDpWcGyfqh
         udxJEoFOnHIe66EWuVsnOsWWH1x4ZsoTGdKn44YDCjPsEtPd+TWKUXaEeCuvHagHYk
         JETTbZKZ2/XapXdr2I40DuCulzcNeaX1+LyXitKaaMkm9DW0bjW6nzmzm8fff8NKgP
         ejZA79+EzaSp5DdDbZQo2aOoyd/rONs0fph2nEw0BHRyIEbL1+aj0YxBXx4aIawZuZ
         tN++8CsWprqtg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] rtw89: 8852c: rfk: get calibrated channels to notify
 firmware
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220503120001.79272-2-pkshih@realtek.com>
References: <20220503120001.79272-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165164237586.17573.8883356420625535507.kvalo@kernel.org>
Date:   Wed,  4 May 2022 05:32:57 +0000 (UTC)
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

> The commit 16b44ed0ffd3 ("rtw89: add RF H2C to notify firmware") is to
> add firmware command, and this commit is to prepare the channels. Then,
> firmware can get proper channels.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

5309cd5ec9b4 rtw89: 8852c: rfk: get calibrated channels to notify firmware
e212d5d48d85 rtw89: 8852c: add chip_ops::bb_ctrl_btc_preagc
78af3cc67356 rtw89: 8852c: add basic and remaining chip_info
39a7652103ff rtw89: ps: fine tune polling interval while changing low power mode
62440fbefad1 rtw89: correct AID settings of beamformee
55cf5b7e2d97 rtw89: 8852c: correct register definitions used by 8852c
68bf56e3b020 rtw89: 8852c: fix warning of FIELD_PREP() mask type
7ba49f4c6896 rtw89: 8852c: add 8852ce to Makefile and Kconfig

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220503120001.79272-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

