Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E747363EEB4
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiLALDh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 06:03:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLALDK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 06:03:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4BC2C13A
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 03:03:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA66461F92
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 11:03:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1694C433D7;
        Thu,  1 Dec 2022 11:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669892589;
        bh=S8pFdlcSzQUtNdd5CyEdz3sJNF4bJZ544cHrtbiZ0uo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LEVFlpH3/mCOvkS8LaL9LYuA85u8RqLl+DcZIEbPtBCq/g55MLsKSDrXjjz+a/P5P
         AcfQRW7eTcvqTIi4OkjnYdjLRsow71W6FAuOCTsJOR3OLJpGM76yVXmpr2r+kYNgV+
         J6NfIeIJBf7YfO6+TFP7f39Os92vkTNubaBGlggxiesCfnxAaEwj1r6S+8SAl+xaXb
         YDS9yB8Cf8AMwDS3pd/Wh4YkBb+ZiV8GBsY4OUkbAvo7QiuKCfMBWm4gy0uwnA/OaU
         C8nMZ/fVGlA2HDRpIEzEtUc9IyxuGmz0VfEcZlAm1gRCzCcS9HeQTtxxx05n9acT4X
         P4HDaWDZlTFJA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: enable mac80211 virtual monitor
 interface
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221125072416.94752-2-pkshih@realtek.com>
References: <20221125072416.94752-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166989258650.31196.10046867458429272650.kvalo@kernel.org>
Date:   Thu,  1 Dec 2022 11:03:08 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> For running with mac80211 channel context ops and using only as monitor,
> we need to enable WANT_MONITOR_VIF to let mac80211 process virtual monitor
> interface. Then, we are able to set channel on the monitor from user space.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

cd9b6b3baf52 wifi: rtw89: enable mac80211 virtual monitor interface
51e8ed4e44b5 wifi: rtw89: add HE radiotap for monitor mode
a215b2b7055f wifi: rtw89: 8852b: turn off PoP function in monitor mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221125072416.94752-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

