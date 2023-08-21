Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C2782E01
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbjHUQNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjHUQNr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F01139
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:13:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4022763D01
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 16:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876B9C433C8;
        Mon, 21 Aug 2023 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634414;
        bh=4/qO/TEi1NguyE1qeNmK9kfnEyD5ihAYB8KJyJOepfw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pjRtpJ3ePdUzPUlLcCskJTsEBLa61D4EbHe1q7pK2aKkZRgsmWBMUQBACAEsj7AmR
         VHg4nF2LEb0SDCuO0mjT0L1Y+2Z674+1pMxUDFdBjtpk3Mr/1xqj3qZSQN/17F0YPF
         OxJNPfKufhsQn9ddRx6KykVurPGM8ALMo97u2Cu2SycvIG5wDfMTMqz3lLzBD6NZYl
         m0+uuTZRvhps8pG6AJuw5vwHlbKV8saR/nU6FCxD9c3u039te1lySmJC9kSRIm8PLG
         sX0oofc1+wIHlthfwLiDDEVQMFFe2kO0+k/sZ/3lHIxj/vfIfr8kkSGQLuS2sxiFY5
         ZGF0Usis7nBag==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in
 R-Calibration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
References: <TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        Shiji Yang <yangshiji66@outlook.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263441168.572263.4982611970598835646.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:13:33 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> wrote:

> For MAC_SYS_CTRL register, Bit[2] controls MAC_TX_EN and Bit[3]
> controls MAC_RX_EN (Bit index starts from 0). Therefore, 0x08 is
> the correct mask for RX.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-next.git, thanks.

186f2432741f wifi: rt2x00: correct MAC_SYS_CTRL register RX mask in R-Calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/TYAP286MB03150B571B67B896A504AC34BC0EA@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

