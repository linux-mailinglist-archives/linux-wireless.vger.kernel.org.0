Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EFB4EEC88
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 13:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbiDALs4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239071AbiDALsz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 07:48:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67321C05B
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 04:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D0A6B823FB
        for <linux-wireless@vger.kernel.org>; Fri,  1 Apr 2022 11:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F8C340F2;
        Fri,  1 Apr 2022 11:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648813622;
        bh=/KTUnEim6qiPvokXTY1tZy6chpDJLR1TQ8pWRBWMM9Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=IsqvONJGXNjP3lE8l5/PnDNhsrBQbgT6MJg9oKwGlNb1yq+/pg5t7cwXHocpLiiZK
         vB15ehPqG8NFyvhYz8CMLcE5WMLj4ighC0zaUOypTtOPAy5PDdIvzK3jZj5S5/B0dc
         mnhra5MehRryxTGpRdTyRVZVXExr6aaR+TeJGlsawCwHPXxhZ57/uu1mBrhnLQO5gt
         PP8Ovv29f1dTmANg/X/D4IjAxjzLTFHsUzhCFTTlfx4a6425jHGZyvjhjdvRaltsLU
         pYGKYINrUsN9VvGgUdQUBxr+5gdI2kZWLtf75JZKuUh+z72gscHGa5vJ21FB19yKL0
         255YG7CuETq3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] ath10k: add support for MSDU IDs for USB devices
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220327171340.7893-1-erik.stromdahl@gmail.com>
References: <20220327171340.7893-1-erik.stromdahl@gmail.com>
To:     Erik Stromdahl <erik.stromdahl@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        davem@davemloft.net, kuba@kernel.org,
        Erik Stromdahl <erik.stromdahl@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164881361956.6665.6628829771701180891.kvalo@kernel.org>
Date:   Fri,  1 Apr 2022 11:47:01 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Erik Stromdahl <erik.stromdahl@gmail.com> wrote:

> commit 93bbdec6683e1c8ba2cc4e6 ("ath10k: htt: support MSDU ids with
> SDIO") introduced MSDU ID allocation in the htt TX path for high latency
> devices. This feature needs to be enabled for USB as well in order to
> have a functional TX path.
> 
> Tested-on: QCA9377 hw1.0 USB 1.0.0.299
> 
> Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

2c977be2cc5c ath10k: add support for MSDU IDs for USB devices
d930e2560ebe ath10k: enable napi on RX path for usb

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220327171340.7893-1-erik.stromdahl@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

