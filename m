Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1966694DCB
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjBMRQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBMRQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:16:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CC1EFFB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:16:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90E12B81625
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:16:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81407C433D2;
        Mon, 13 Feb 2023 17:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308588;
        bh=d6yciiJyRtWE+zsbpj1y0RzytKYasKruIKfLaPYALXw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GA5qS36LCUBXDn87TuKdHibrT/FS61cn/ZZiaj0lxP1NJ9RNXSTnrI1mTOqdhKE2j
         7TiUId+jRcoilUXV+hqdtqHLFLbjRzniwfuI9MIshdM2+FoaWHwmzeNzX7otCGA+hL
         /XcKTwpyFcviNlner8PrmSO9vnMwjaSbEE+Ahu1UbdsHheVwRw+mVIGjfZzdyto+FH
         wHU0WRPdxE5pEXuTp70VSeos66a9emxGOsOdWU3+vWiRvEinExR0a29PxHXQhyM0HF
         N6cS/AUsneuOcgirthcIBvn9CUFy2bpicH8qn0c0bROrosKow+7vxdRc90WRa0lux0
         wsCkSpY+6aohw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: disallow enter PS mode after create TDLS
 link
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230119064631.66971-1-pkshih@realtek.com>
References: <20230119064631.66971-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630858349.12830.3379394900207378957.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:16:27 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Buffer STA on TDLS links are not currently supported. Therefore, it
> is not allowed to enter the PS mode after TDLS link is established.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

d881d0a13c38 wifi: rtw89: disallow enter PS mode after create TDLS link

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230119064631.66971-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

