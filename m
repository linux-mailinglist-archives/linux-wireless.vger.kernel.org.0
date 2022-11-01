Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4430661469E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 10:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKAJ1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiKAJ1d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 05:27:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31F18E25
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 02:27:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25EF1B81C53
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 09:27:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB60C433C1;
        Tue,  1 Nov 2022 09:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294849;
        bh=gBa2eeLib7J7toQORdcJMYtL/Ftae+yNjWtOmuuWTZM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kCGAQ0frArTu/LNNwFJInR+vMdMuHDV43TOtNBVamLxMwj/CXsXpCYFoyBgM9YLiA
         AbtEBrMewSKr10P7a6XIf8vQDJNiuCIhSHnh2o00YhM1loSOvcnWm9SJJW/6dYqxvq
         EcWebHrKMkDV0rQsRL2x8v0osR2LWt1y0MNghdB70bW61znShZ45ORxwGS9vvdEUIP
         7koSS1KOmoj8CrlImEVEtFNTwP7/BDlxpemGy1SCQHzpeYJ7kBfJZHQNV3SNwOLI3G
         GT7y/doqisEyTKwbwE2VqAI3amFaNx0xT6G/e/WZXm0UBHSZoThw5T9LG4UP/M1JXG
         A8Ng8seXPpw5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] wifi: rtw89: collect and send RF parameters to
 firmware for WoWLAN
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221027052707.14605-2-pkshih@realtek.com>
References: <20221027052707.14605-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166729484702.21401.10931969945077529002.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 09:27:28 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> For WoWLAN mode, we only collect and send RF parameters to Firmware
> without writing RF registers. So we add one function to practice it.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

d9112042d994 wifi: rtw89: collect and send RF parameters to firmware for WoWLAN
5f05bdb0a770 wifi: rtw89: move enable_cpu/disable_cpu into fw_download
7a68ec3da79e wifi: rtw89: add function to adjust and restore PLE quota
41d567699283 wifi: rtw89: add drop tx packet function
ee88d748f1ac wifi: rtw89: add related H2C for WoWLAN mode
19e28c7fcc74 wifi: rtw89: add WoWLAN function support
d2b68e95b5bc wifi: rtw89: add WoWLAN pattern match support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221027052707.14605-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

