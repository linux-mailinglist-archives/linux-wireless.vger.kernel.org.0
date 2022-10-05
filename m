Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5D5F506C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 09:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJEHnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 03:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJEHnf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 03:43:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC37E5E653
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 00:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79C2BB81C3D
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 07:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966A2C433C1;
        Wed,  5 Oct 2022 07:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664955812;
        bh=e9rExPIwcG50Tp7KhOmxNXVPWrtqc98DC1Dth9TROSY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WSvunizYlIAvMAcsHtvdKxiPTaSST6sm6pLN6JdXKnO/y+KsQqBgUxylzsk0WjsrJ
         eM3Bi0rT/cbxGoPEsyL6Pc4K3o/WmGKMRYlYEIlZXc5rVbQIVVwzKamkrHwv/ic9OH
         9MZpQn4FmkE9lQ33eso/VG19Xp5OT6oVdssmAxkFKIf2mDP+eb6KDh51dktRQwmaqZ
         j9u7qXvN2qkGL9V2i5pLKUfEt+x1Oa0XXoSU4U4GLpFGIcnqAExe+G/J6c2cHJYnOo
         GMkURGvVjOqVrskae+gl/ELrIQEVR/flzRhAd5fBgWdO3IsuEcmgRY8xuDk+XBP1bL
         yl+RZ2/70HeAQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852c: set pin MUX to enable BT firmware
 log
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220930134417.10282-1-pkshih@realtek.com>
References: <20220930134417.10282-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166495580937.5945.3967690838425250487.kvalo@kernel.org>
Date:   Wed,  5 Oct 2022 07:43:31 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852CE is a combo chip, and WiFi driver controls pin MUX. To output BT
> firmware log to specific hardware pin, set pin MUX to achieve.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

d187691ab63f wifi: rtw89: 8852c: set pin MUX to enable BT firmware log
732dd91db3d3 wifi: rtw89: add to dump TX FIFO 0/1 for 8852C

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220930134417.10282-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

