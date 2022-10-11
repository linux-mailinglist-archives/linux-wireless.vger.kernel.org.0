Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61E5FB874
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 18:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKQpq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 12:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJKQpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 12:45:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA2AA4BA9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 09:45:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5FAEB81637
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 16:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFE9C433B5;
        Tue, 11 Oct 2022 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665506742;
        bh=qusXk171oI0FbmNE9XtEDq3cfUOmV8UqID4PSxKJ+sk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dawx2R9l4kntaYTSA4WzGuvMHdjNkDxSaUkpB57kBeSvufjTTzNv3pLW5/+0JwcST
         XEIybMmyD9XlaWjejr7YAcGdK+e1T1DB/CDUarsJjIedS/G7fTAwU8qv2TPivRXPjj
         U4gbaYWy7UcPRtD2cQkmSpiaADuyurfG+OGPi+MKg/fbc9ssKH1ZkBPhK1fZw+gjB6
         N+hAACAuPz2Qr+I/FvSonvQJKqRdxiRvXA0z1VVjUKdxz7KhhprZOEXxIT1jIMNYQF
         f3uX+CGZBNwEDsciyrr/pBKkTsHSjNb8Lv5TWJqIn6cYdSvM1hrnTUtS/yNeDT/crz
         Zl6snK4TupSWg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: coex: move chip_ops::btc_bt_aci_imp to a
 generic code
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221005083212.45683-2-pkshih@realtek.com>
References: <20221005083212.45683-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <echuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166550673760.12241.7867852994571114320.kvalo@kernel.org>
Date:   Tue, 11 Oct 2022 16:45:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> This chunk is to set fixed BT LNA2 at level5 when WiFi/BT shared BTG RFC
> to improve BT anti-interference ability from adjacent channel. Since all
> chips use the same setting, remove chip_ops::btc_bt_aci_imp.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

127da1aa6185 wifi: rtw89: coex: move chip_ops::btc_bt_aci_imp to a generic code
0935bb1527d7 wifi: rtw89: parse PHY status only when PPDU is to_self
d0c820cc5bcf wifi: rtw89: 8852b: set proper configuration before loading NCTL
3e870b481733 wifi: rtw89: 8852b: add HFC quota arrays
6e5125bcbaf8 wifi: rtw89: make generic functions to convert subband gain index
6b0698984eb0 wifi: rtw89: 8852b: add chip_ops::set_channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221005083212.45683-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

