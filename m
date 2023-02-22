Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0B769F24F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 10:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjBVJ51 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 04:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232350AbjBVJ5N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 04:57:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959D086AA;
        Wed, 22 Feb 2023 01:56:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 385F3B8114D;
        Wed, 22 Feb 2023 09:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B74C433EF;
        Wed, 22 Feb 2023 09:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677059800;
        bh=IPZkAOw+o/JhWR6mJKvLyqZbTc//4Kugo2WLuBB2ejA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=c0zFJqZfSpAp5Dmvtrgrt1D6hmXn5TvJWQunpcF5cFuQFVgBWjGF44M3ON4B8KJZF
         rsS5EmaagZ1cQgpBTVkggu5/Nw618hCms848ao975aEg15yUuw/DqVORjXsjHult/x
         XRaeqWRbPBYfckAtpVdwFlxmN3y6ISPHo+JkZTCc+CqrIN7lVabyBrfQh81/B4mZSC
         6MGEX35OLUHjR0mwcru0xmbv3crzeY5L7MZuyC+c+njpH17/RlP9sWBTq7WFnLNl1j
         ILO8BDffmS/4L3ryNBCtPKDfRzbLvUrvLVT3IdRGE6yQ5rTjkDaaHdQ95rAU43j0qE
         fdMnxkqB/od6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath5k: fix an off by one check in
 ath5k_eeprom_read_freq_list()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <Y+D9hPQrHfWBJhXz@kili>
References: <Y+D9hPQrHfWBJhXz@kili>
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Felix Fietkau <nbd@openwrt.org>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167705979601.5928.4317173646213018716.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 09:56:38 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <error27@gmail.com> wrote:

> This loop checks that i < max at the start of loop but then it does
> i++ which could put it past the end of the array.  It's harmless to
> check again and prevent a potential out of bounds.
> 
> Fixes: 1048643ea94d ("ath5k: Clean up eeprom parsing and add missing calibration data")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

4c856ee12df8 wifi: ath5k: fix an off by one check in ath5k_eeprom_read_freq_list()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/Y+D9hPQrHfWBJhXz@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

