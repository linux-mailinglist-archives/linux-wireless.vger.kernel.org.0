Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524C78842E
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Aug 2023 12:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHYJ7f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Aug 2023 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242816AbjHYJ7V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Aug 2023 05:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DFC2106
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 02:59:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E73C766595
        for <linux-wireless@vger.kernel.org>; Fri, 25 Aug 2023 09:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980EFC433C7;
        Fri, 25 Aug 2023 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692957557;
        bh=EErJ9D1pYOhASQEhOP1cs/OpfIUyuNuyMYomT4PBeZk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XhC1VvcXghfdTHGZ+X90IgApQszA9V5G25pJ7hPTIoI9LtI/2U9CnL8Putb5XAqrQ
         LFbPiySx1NJ+gvJU0F89tTpHmC3MaEZ3UtWCdivy89sa3j5jqvvNWIWDe8Zxh1iAF1
         LToM0Xd0u28bMXq7HPwBsTWea9ZCbrFWsM+KXcDLcvn9PhSGOw1UpRyOfPYz43zV0c
         LlhOdQHJRKYlsQOVlLapGB0qcMXHtg6UjUWQzjo3LiBoU3NUSTPqNgUyIVivDkEghl
         YE2qZV+p1YNRUdhAUXcvEd5oXStLmV0663aztlALLhEEjfftIun3s+K9euf/a4jYc5
         8evtLWNH5StCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: add function prototype for coex request
 duration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230816082133.57474-2-pkshih@realtek.com>
References: <20230816082133.57474-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169295755460.1850672.8162436423992016846.kvalo@kernel.org>
Date:   Fri, 25 Aug 2023 09:59:16 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> The request duration comes from coex mechanism, indicating the
> length of time that should be reserved for BT in each time division.
> It is required to handle update notification when channel concurrency
> processes. Since it will involve in both coex and wifi code flow, this
> commit ahead adds the prototype for required function interfaces to
> split the implementation of coex and wifi in the following.
> 
> The follow-up are expected be add afterwards.
> 1. coex mechanism call rtw89_core_ntfy_btc_event() once bt req len changes
> 2. channel concurrency flow updates related stuffs when notified
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

64a24cb63a4b wifi: rtw89: add function prototype for coex request duration
b05fdc46c5a6 wifi: rtw89: refine rtw89_correct_cck_chan() by rtw89_hw_to_nl80211_band()
bfbadacf37a2 wifi: rtw89: sar: let caller decide the center frequency to query
ad3dc7220220 wifi: rtw89: call rtw89_chan_get() by vif chanctx if aware of vif
51383fd77791 wifi: rtw89: provide functions to configure NoA for beacon update
4843aa3768e2 wifi: rtw89: initialize multi-channel handling

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230816082133.57474-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

