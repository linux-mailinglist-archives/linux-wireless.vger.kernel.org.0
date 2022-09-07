Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7305AFDE0
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 09:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIGHqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Sep 2022 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIGHql (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Sep 2022 03:46:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF623A6C3F
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 00:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76CF661466
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 07:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49532C433B5;
        Wed,  7 Sep 2022 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662536797;
        bh=1wxpRn7SVeWqRKiOmsVj2jVYugQeXRnVC0MdVl2hO2Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gfJza38nhI8pQyNlxhGmRIX9cWeJ664rT6caXpGBwOtWjHM8/cFCKHS5ZhEHVroNG
         QnNIij0Oy34ZfULo6QDT051xDoCOwtaSvRmxlbY3HGOFIS8jBHuBfPp4sbAvGgMx5J
         1M5srbV9L8h7ZFwaKBTSm2WsexQU5zh465Iyn4PMOH4FFh/fqmgOJ7QacZlO9GdCBt
         Oq/Gb8txFdou+QJASN3FsNwhphQBAcmvNULH6WUPjkwKwd8XjGl/ZHh/C8YgLOl8DK
         ya9BjeoydWVpYoThamn+oiTuGnBgGlKHVOIzYsRVDRkf7BNaa7bdDF8/UwWlDraCXa
         7THtOVcPkxSxg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 5/5] wifi: rtw89: support TX diversity for 1T2R chipset
References: <20220902124422.13610-1-pkshih@realtek.com>
        <20220902124422.13610-6-pkshih@realtek.com>
Date:   Wed, 07 Sep 2022 10:46:35 +0300
In-Reply-To: <20220902124422.13610-6-pkshih@realtek.com> (Ping-Ke Shih's
        message of "Fri, 2 Sep 2022 20:44:22 +0800")
Message-ID: <878rmvaap0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

> Check RSSI strength to decide which path is better, and then set TX path
> accordingly.
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

[...]

> +static void rtw89_phy_tx_path_div_sta_iter(void *data, struct ieee80211_sta *sta)
> +{
> +	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
> +	struct rtw89_dev *rtwdev = rtwsta->rtwdev;
> +	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
> +	struct rtw89_hal *hal = &rtwdev->hal;
> +	bool *done = (bool *)data;

data is a void pointer, you don't need the cast here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
