Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964315FBFEF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 06:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJLEfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 00:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiJLEfq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 00:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B2B491E9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 21:35:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CC8761374
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 04:35:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2236C433D6;
        Wed, 12 Oct 2022 04:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665549335;
        bh=Yy5Y59PdSPtMuAOIkaDd5PahLtNrQgkolmUyHz5z4TY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Ty3hHc2A92ed+01yFbIs53K44a+r4bqq89uvsdzhC0EXpShKduMVCco9tx4ypvtQO
         YFTedWGlKTOE7QE5vb8KDIbbTMOmO5+d1h/DYSViqUKpKjk/OofHZfGhqgGyDwKFSW
         8ijAYhLT76/QD9MTWF8QTV/NAbjPUM4WIaiseX8M9ul2u26fRr4fpxf18/c1zqaMae
         r2pi/TM9XjE1QHdAib2+IwErXi1IADPqPaQlROVBA6V9SfFHht8awN+8vbzQAPLdp5
         TJx34kAuMWc/NE/oo2FA7t/Bvozj7bEXEiuf/0zS1RwUe8zNqE3jMQ1XnyAYCpEOeL
         JAdf/2QzsS3Ag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wifi: rtw89: 8852b: add chip_ops::set_channel_help
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221009125403.19662-2-pkshih@realtek.com>
References: <20221009125403.19662-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166554933285.12621.6198710705660541999.kvalo@kernel.org>
Date:   Wed, 12 Oct 2022 04:35:34 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> This chip_ops is to assist set_channel, because we need setup and restore
> hardware before and after set_channel.
> 
> Before set_channel, we stop transmitting, reset PPDU status, disable TSSI,
> and disable ADC. After set_channel, do opposite things in reverse order.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

d0a95ef3ed86 wifi: rtw89: 8852b: add chip_ops::set_channel_help
b23b36efbdac wifi: rtw89: 8852b: add power on/off functions
a804479839e1 wifi: rtw89: 8852b: add basic baseband chip_ops
8f88474ce3ec wifi: rtw89: 8852b: add chip_ops to get thermal
98bf0ddf20fc wifi: rtw89: 8852b: add chip_ops related to BT coexistence
bf958f76cf97 wifi: rtw89: 8852b: add chip_ops to query PPDU
8915a256538d wifi: rtw89: 8852b: add chip_ops to configure TX/RX path
572fd2ab377b wifi: rtw89: 8852b: add functions to control BB to assist RF calibrations
b8fe87b81685 wifi: rtw89: 8852b: add basic attributes of chip_info

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221009125403.19662-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

