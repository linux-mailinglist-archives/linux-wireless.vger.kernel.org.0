Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEF6F8260
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjEEL7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjEEL7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 07:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BDC1A4AF
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 04:59:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDAD863D86
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 11:59:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682C8C433D2;
        Fri,  5 May 2023 11:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683287952;
        bh=82+Cp8ENlsIsWgVJROy9dNNM9mqd8r/2iB+QYKk/CeU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=vL0NZdHk5tAk9XCX05ELl/gS1ZAwBXuWvGhON2XtWqgXd/48hHSW4Kttd3oW6I/6l
         JFjTLVmfk3zPXoUVcFX1HhExB7Xe9gPWeReFxPebn1Wa/4A1RzjqLivnh7QDfpdB7m
         iVGe5HQMLprG9goScrAIbfknb2OrIdul4tabi7Y0AAt5p4wjB/eyGkG6txIVYnVzF5
         tRYYjt2sdLaN9Z7/AQerv4xXaOJF6hxLDktoVf8VUnbBSanskr47r+3W/WM7VQwwIf
         fLeQUcSPuaXsyAUePtOVaBMqm6/Wi1ff0U0oZiXrS2NzGp8zPjbdwnZVtNdiGdSBFU
         wOxxICg8dOkLg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] wifi: rtw89: use struct rtw89_phy_sts_ie0 instead
 of
 macro to access PHY IE0 status
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230418012820.5139-2-pkshih@realtek.com>
References: <20230418012820.5139-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328794777.30117.12372781040487266908.kvalo@kernel.org>
Date:   Fri,  5 May 2023 11:59:11 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> To be more clear to know where it gets information from PHY IE0 data,
> change to use struct and standard le32_get_bits() to access. This doesn't
> change logic at all.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

9805500606c2 wifi: rtw89: use struct rtw89_phy_sts_ie0 instead of macro to access PHY IE0 status
f48453e058d7 wifi: rtw89: set capability of TX antenna diversity
f6b24241cbec wifi: rtw89: add RSSI statistics for the case of antenna diversity to debugfs
4bb223a19f9b wifi: rtw89: add EVM and SNR statistics to debugfs
a90c613d099f wifi: rtw89: initialize antenna for antenna diversity
e3715859c753 wifi: rtw89: add RSSI based antenna diversity
5feecb40e735 wifi: rtw89: add EVM for antenna diversity

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230418012820.5139-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

