Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991465BC5F7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiISKED (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiISKEB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:04:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0421B10D
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0BFCB818CF
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F3C433C1;
        Mon, 19 Sep 2022 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581836;
        bh=0/2X9AnrPN0TEvXyfqx59u/H3LIjkHC4v+KOFbnvnkA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Pzvb5jN2hPO+udCycXKZTcf7c9ZBPW4tUDt3Hq5YgYrTNvL+laIGpZiT6A7WBeqQW
         yriioW1G1U4DM36cbk6Z1exMtowdVDQf/wTYSUl2lMFNZxZTG74MtGbe7B6ukCOtcB
         ZcO2lm3H8A4sVSfLq6dFKT5ZWFsSKg7znSVdLC4c/tT/Pyo5rK47tNYoiL2T5AbV12
         C4C2gghsfZ7WumgSzC1ZWS5zTyv6OoXeNHBHl1EiWxmxN7jC5PvtqzIkT8+d8da8E5
         3no6FzH5ySGK5ibBVPS3eqJPwJGbASMFYAczDHBOtn8Wy/tF8ke5Rv2oZvpZT1/ILa
         mJAm7v2+XajNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: unify use of rtw89_h2c_tx()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220914035034.14521-2-pkshih@realtek.com>
References: <20220914035034.14521-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358183095.24821.14812866317306858007.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:03:55 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Seaprate calling of rtw89_h2c_tx() out of if-expression, and bypass the
> return value to upper caller.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

8b0f4b5d8bb0 wifi: rtw89: unify use of rtw89_h2c_tx()
9a785583f001 wifi: rtw89: introudce functions to drop packets
e77d3f8b1b9e wifi: rtw89: 8852c: support fw crash simulation
8a1f6c884621 wifi: rtw89: support SER L1 simulation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220914035034.14521-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

