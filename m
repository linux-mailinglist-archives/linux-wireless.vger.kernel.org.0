Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB7057FE5A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 13:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiGYL07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 07:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiGYL06 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 07:26:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC31117E29
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 04:26:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B296B80E4B
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 11:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595B9C341C6;
        Mon, 25 Jul 2022 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658748415;
        bh=ByzNrFzGDisnp6Rd1c9XlWdax0TrZxDkLwMrmCNll9g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=uFKAUIBK4FHMWe6SnIoPT4S3BYt9mzZ8XCzEVtbTTiM7PhdQVVEGcN1yRCLup6ri0
         rfPFEeECRv6FDXp8wSiKqiz8rlAnPpBOQyPy4fhNGzdPGkocKcnNsUhXKokNjZDhhH
         XQaW5ne9M8gZXMJKxBfGu1O5j3D06Y+dFWor8kdk2V8BIZ8WpWCGS9SSq7yzgFy38g
         yPxNNwNPpOklCdb47XRDhYxGXknhnZvN/Te8KDYNhHLQvjekRNpgSwAGXjxkDkNNkR
         /tYfrznx5qhzg1YfcUoDKDYfIhP9hJMTbH4o6gbKiLSwJfrwX/lZ2+kPb7VnMXt7wy
         VhF7zs30Qjnug==
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
Message-ID: <165874840987.809.11956403256946513470.kvalo@kernel.org>
Date:   Mon, 25 Jul 2022 11:26:54 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This added a new warning:

drivers/net/wireless/ath/ath11k/spectral.c:682:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath11k/spectral.c:682:43:    expected restricted __be16 [usertype] freq1
drivers/net/wireless/ath/ath11k/spectral.c:682:43:    got unsigned short [assigned] [usertype] freq

Remember to use ath11k-check to check your code. I fixed this in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220725055001.15194-1-quic_tamizhr@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

