Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3D694DCF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBMRS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMRSx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:18:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2B11A65B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:18:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49449611F4
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEA8CC433D2;
        Mon, 13 Feb 2023 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308731;
        bh=OlDskTA6loInr6LKQH5M8d+VN5enFlP+85pJM3zp5tU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ayJtd3QhW/953HMhMMq0Nz7mu7dxRY48l27+G9ENTUCc7zIjTVKZdz4a6541/CgKi
         tEsURH8Fbl6Ujfds+vXGy0SODYtHSuO8XU0d+N5B6wD9waZxc45GEjV0Wmy8kMKjY7
         RgyKKJSlHBB/QWP87MeOXl8y4H5M+8Wav+3p874RVVSxcLxq+gSWD7tBZkhzpJxqwT
         YmIYaLhXSaVY/QjPIzP5QHyLOQlgiq4p0JDu53Gov5S9lCc6fNB8edRFGRWcqqemlJ
         2um95ddIUEDoJlHgy81gziICW83vHI7zBiOkAww/0dsszMretZO5/iiwqSCqsAJKft
         qGBL8w3ytgLOw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: use passed channel in set_tx_shape_dfir()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230201032057.7349-1-pkshih@realtek.com>
References: <20230201032057.7349-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630872906.12830.17166929413600795728.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:18:50 +0000 (UTC)
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
> In path of setting channel and setting TX power, the rtw89_chan instance
> to be used is controlled by top and passed down. The set_tx_shape_dfir()
> is in path of setting TX power, so it should use the passed rtw89_chan
> instead of querying it itself. Otherwise, it might encounter mismatch
> between parameters if multi-channel.
> 
> For example,
> rtw89_8852ce 0000:04:00.0: set tx shape dfir by unknown ch: 155 on 2GHz
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

764f07f4565d wifi: rtw89: use passed channel in set_tx_shape_dfir()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230201032057.7349-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

