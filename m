Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20A7BA0E6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 16:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjJEOmk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Oct 2023 10:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbjJEOhD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1A947882
        for <linux-wireless@vger.kernel.org>; Thu,  5 Oct 2023 07:02:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF5FC433B7;
        Thu,  5 Oct 2023 06:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696488882;
        bh=JqcnyKcQpUjMnEi/J6oq7twnNQyuKsZWEMo2+vGFKJ8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nTAXWrEK0hTCpXyuaa5ICT8N4iRsW/LdwnhETg7Y3WxylwbcmSrpofcGJzGgho8sg
         1+LJuIhtdXRa9aHfiBuRUjfZb2NlctlwJQnBKHhrKWYwbgyfINwqxEM0BskWPMi2i7
         AFXPhmeksYvL4QwDeQmFoNwD5ehlcnPpGZBdxtpomv/EzYpIWqQ2+npFq9D2jKcgJS
         xHUHZxGtyg1rJMr5GndV5P5uyJu9wtVKtmGNMVha6XJ0z0QkYCjh19NyumPX7yU/Yv
         sm/z8PhhqghDqdbyGXc6A5KSGOh9ZbCCcOuHxpbYyjqIXe7j8O352pXI6OQGWNh7o+
         e046r7c8WUksA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: mac: get TX power control register
 according
 to chip gen
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231003015446.14658-2-pkshih@realtek.com>
References: <20231003015446.14658-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169648887924.613656.14086169480383978465.kvalo@kernel.org>
Date:   Thu,  5 Oct 2023 06:54:41 +0000 (UTC)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> There are two difference between Wi-Fi 6 and Wi-Fi 7 chips.
> 1. Address range of TX power control register
> 2. Checking code to get a TX power control register
> 
> So, separate the implementation of them, access according to
> chip generation, and rename original things with a suffix `_ax`.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

06b26738a7bb wifi: rtw89: mac: get TX power control register according to chip gen
d51366421529 wifi: rtw89: phy: set TX power by rate according to chip gen
3b7dc652cc40 wifi: rtw89: phy: set TX power offset according to chip gen
70aa04f2d58c wifi: rtw89: phy: set TX power limit according to chip gen
932f85c18aef wifi: rtw89: phy: set TX power RU limit according to chip gen
f680fc569566 wifi: rtw89: debug: show txpwr table according to chip gen
036042e15770 wifi: rtw89: debug: txpwr table supports Wi-Fi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231003015446.14658-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

