Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91CE5E8C9E
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 14:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiIXMhY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 08:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIXMhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 08:37:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9057F193D
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 05:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97EDEB8095B
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 12:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E74BC433D6;
        Sat, 24 Sep 2022 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664023036;
        bh=USy9n1jm8zN5Z5Wc6B/Gw5m/THtTywFM3u5Jn3OA/U4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=crAQbutJwDiwYb6hwRDPjtrYh70Kpl5t/u76hjzs3oj4kz5/os/SxEjRjMy7PHSCE
         SZfIRu3Y4E7LHYMbqeuvM5F2SyE6TXD5/NVqSWvY5+2EZEkgy8HYDQe1djWLXC/U1R
         lIOi4TV9elNrnBnCkhdyiqtAOTddSM2PodC1/8uGzSdG0BkaVDgA0brB/ae/OYi3kU
         hQ8JsBF6aAFk3aBuDrpGl1KRFAXH5P8Zpyd7QcRSsIT0ErOz6+XRUNjOyVSWm9D2rh
         Yx1AQW+HvnKh8HwIlv8Ri6ZOTwKwuvvx8h5S7C8+nNYvftwK81AvY6aMXXi5ecaRD+
         3YcN/2diS7K6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: disable 26-tone RU HE TB PPDU transmissions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220922012719.15037-1-pkshih@realtek.com>
References: <20220922012719.15037-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166402303377.7040.11567040490814948308.kvalo@kernel.org>
Date:   Sat, 24 Sep 2022 12:37:15 +0000 (UTC)
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
> Align with the spec of 802.11ax, follow the conditions for not responding
> with an HE TB PPDU. When there are OBSS that cannot interpret 26-tone RU
> transmissions, we should disable such transmissions.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

8d540f9d2916 wifi: rtw89: disable 26-tone RU HE TB PPDU transmissions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220922012719.15037-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

