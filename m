Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2170264C900
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 13:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbiLNM0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 07:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiLNM0R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 07:26:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EFB29838
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 04:23:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F064B81691
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 12:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6984EC433EF;
        Wed, 14 Dec 2022 12:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671020586;
        bh=wdrWSBgLmp8b9fhbi6+8vra4Sk3Juob9ScdXHZLQYqU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=f3sg1W9M8w1dz9ZdBAzrx+6fWdIUoUmsyxxUsTI9vRVNYqYYTVIX+N5l49NGpLI71
         WUw5GPIy+2fFdYDAeGvQsSTE1ge0jgmPlz6onNHgvq+iGOjXmqKaplpvfFhZO1KECQ
         +wmnSm/+02yfWjjqnZ4jLE/va1AY6crSxc4ut8U18BcfBbvv/Tieo+pcKMehyIWcik
         A5CDwy2rBJ4Iqlvd082+i06ckv8HN1Z0SFCjXqZ6pvapn7z2pUf0NtO7wU1icEC4XL
         qFembyZD+1y29LL7JT8qaoNvlNa06o7T+7Ig1qg6MFV4sADLwO/iQj58bQoV7CZ9mQ
         MFJJqinoRQMcw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtl8xxxu: Fix assignment to bit field
 priv->pi_enabled
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
References: <4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167102058278.7997.4051866904687241289.kvalo@kernel.org>
Date:   Wed, 14 Dec 2022 12:23:05 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Just because priv->pi_enabled is only one bit doesn't mean it works
> like a bool. The value assigned to it loses all bits except bit 0,
> so only assign 0 or 1 to it.
> 
> This affects the RTL8188FU, but fixing the assignment didn't make
> a difference for my device.
> 
> Fixes: c888183b21f3 ("wifi: rtl8xxxu: Support new chip RTL8188FU")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

9e32b4a709f0 wifi: rtl8xxxu: Fix assignment to bit field priv->pi_enabled
639c26faf9b1 wifi: rtl8xxxu: Fix assignment to bit field priv->cck_agc_report_type

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/4368d585-11ec-d3c7-ec12-7f0afdcedfda@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

