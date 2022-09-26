Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0EC5E9E18
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Sep 2022 11:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiIZJnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Sep 2022 05:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiIZJnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Sep 2022 05:43:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13006491D4
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 02:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D18B8077E
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 09:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED64AC433D7;
        Mon, 26 Sep 2022 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664185222;
        bh=YuJrJQvn7eAFlcWAnDADbd79XWhQ9EoxPA3mdG1pQSQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Xtr0H0ALERc1vQZE8oLjvT6RdvFNkzwIJcRt7SAHhCEkOAdUuQ8HRjaCSjNxyDaeR
         AQu6g4AnMe2OOAVxHcXfRJFmAIQO9Ms9V2VREdy/2A1kUvN9EGQMcSKivpV1ffh9vQ
         ASOAVlEYvOkGOTw21R5V9KuMhG/DY9WAKDP0P2vPeA95mhqb31Kyhbc4t4grnmXs1i
         7mF7T44UeCbqBLYcmX0nD7Gqoypc6wT1Z0IfbirPY9aqRm3SjlXW2Se3CKaOkN/JXa
         n+G5HvH4V/zjegFiVY21phYy46XrMf59HsRntaV7uQB8mRthTvZtDFQN+zoJQs3rZY
         qyXPodXQ2vR0g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2] ath11k: Add spectral scan support for 160 MHz
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220725055001.15194-1-quic_tamizhr@quicinc.com>
References: <20220725055001.15194-1-quic_tamizhr@quicinc.com>
To:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166418521856.13691.10782071280432195867.kvalo@kernel.org>
Date:   Mon, 26 Sep 2022 09:40:21 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> wrote:

> There are two types of 160 MHz spectral scan support mentioned below
> 
> 1. Fragmented approach
> 2. Single event approach
> 
> In this fragmented approach, single 160 MHz will be split as two
> 80 MHz buffer. First fft sample buffer will contain spectral scan
> result of primary 80 MHz and the second fft sample buffer will contain
> secondary 80 MHz and here cfreq1 and cfreq2 will be mentioned.
> In case of 160 MHz on 36th channel will contain cfreq1 as 5210 and
> cfreq2 as 5290. Chipsets which support this approach are IPQ8074/IPQ6018.
> 
> Replacing freq1 with freq2 in every secondary sepctral scan event to
> distinguish between two different 80 MHz spectral event data.
> 
> In the 2nd approach each fft sample buffer will contain spectral scan
> result for whole 160 MHz by mentioning cfreq1 as 5250 which is center
> frequency of whole 160 MHz. Chipset which support this approach is QCN9074.
> 
> Host will receive spectral event from target for every 5 fft samples.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01120-QCAHKSWPL-1
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01120-QCAHKSWP
> 
> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c92f774a95c6 wifi: ath11k: Add spectral scan support for 160 MHz

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725055001.15194-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

