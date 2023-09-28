Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5FA7B2217
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjI1QSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 12:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjI1QSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 12:18:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D001A4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 09:18:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB0AC433C7;
        Thu, 28 Sep 2023 16:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695917917;
        bh=/5JhqD/wO+wsTkpPLNjBCek6BbRFN8lhmXp1icpMp7w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rzQrtb6HElbp/mgji+G5jUc/GofKaINx7p3Dl+O1HbRSsr5y7I4IzEUKJ1c/kPN3+
         H3cMjPQOaPMvXHZpNenWfrCEfLfrh4UTB//YovvmznQtBhUI9fBYOlcrwkM2NMNJVk
         iGUwHGK7piEn3HNmPvheMQNigL7tDxNyGhLGb90aFMattVJSg5qaFR4EWAOF9fAS31
         qxQPhI8+7BWheongO6jq1emNdc+HzgxNij8u6UnFhN5QcbX2sLgxTe2JSCOJsL20N1
         NlL2ZdoEoVT8me0IyYZD0iyMrXh26Ugc6L4sqQtnCanyYeyk65cUO+nVU6ykiX16gJ
         BWV7Jat4ZMHmg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: fix MT7620 low RSSI issue
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591791433.3187104.10405094082972103919.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 16:18:36 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> On Mediatek vendor driver[1], MT7620 (RT6352) uses different RSSI
> base value '-2' compared to the other RT2x00 chips. This patch
> introduces the SoC specific base value to fix the low RSSI value
> reports on MT7620.
> 
> [1] Found on MT76x2E_MT7620_LinuxAP_V3.0.4.0_P3 ConvertToRssi().
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>

Can someone review this, please?

Patch set to Deferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB031571CDB146C414A908A66DBCFEA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

