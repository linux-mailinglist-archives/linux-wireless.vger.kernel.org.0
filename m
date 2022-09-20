Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192B35BEA6B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Sep 2022 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiITPmA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Sep 2022 11:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITPl7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Sep 2022 11:41:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F38B66A7B
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 08:41:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC238B82ACF
        for <linux-wireless@vger.kernel.org>; Tue, 20 Sep 2022 15:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8556AC433D6;
        Tue, 20 Sep 2022 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663688513;
        bh=xwaNLR3zy/gM+Md7cONa8Nz3ctOtzfq3h9C4O32E7Zw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=d8xJ0LkfKQ5bIsvzen9/PCAaYl0rd2p2r/TmDk6kPtcA8WtQyxpD2Q90E+KhYB75B
         2jS96JU72nP+M0FUSBm/nTco9+fchntnK+RvIwAFF7WiCqUSphvDny5hahe3vo+eyz
         0USzUlRRQ8o7WlJ7JN41D2GG+M1XXGu+Hxh8/ximvguUC9zUCAF3aE3tzPfKXkksan
         5urpxFSIeIceLUJvIigDG243cHjiE0ujYY9+mLuFbdAfAPCJnq7wnqw8Tiqlmh6ICv
         4CSUZpDy93lafJ1t1LNyqHQ98eVLrSl4O0d77IZp5obB+rsE6UiWrbeItMjG3VuLZJ
         8Lc/jlMr87d+g==
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
Message-ID: <166368850044.9716.11466525208875594011.kvalo@kernel.org>
Date:   Tue, 20 Sep 2022 15:41:52 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This added a new sparse warning:

drivers/net/wireless/ath/ath11k/spectral.c:682:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/spectral.c:682:43:    expected restricted __be16 [usertype] freq1
drivers/net/wireless/ath/ath11k/spectral.c:682:43:    got unsigned short [assigned] [usertype] freq

I fixed that in the pending branch. Please remember to use ath11k-check to check your patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725055001.15194-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

