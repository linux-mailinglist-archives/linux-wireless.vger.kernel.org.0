Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C674F1A6C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Apr 2022 23:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378905AbiDDVSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379478AbiDDROT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 13:14:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618B913D16
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 10:12:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB71B81809
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 17:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14BFC2BBE4;
        Mon,  4 Apr 2022 17:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649092340;
        bh=VArUYLLgUbosde1+81GiVTwWc2kxPtVmhn7384CbKIY=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VIzpKoFY/i/nbeXs9YhlVf117iFOTzYgc6Q73hIvYRBT6KSMrtjrPr+R37PBKL9s5
         9qRGGReabDxOr+4IVbkBAfqafSlHD3Nczo1HIqW/y6dulu1boIzsbi14IbH7ZxIzDH
         ZqVKlkJF3MY7mDne3SkmDTaJEh/Vs3Z/bCNn1s3CLfbkZgnfO4CQQisrCRnsiTRm8r
         yxNnQqMzAR8V54mvXvGRqNeYe0fp69XKdrAQpWr85m196Qr6KPIegj11NRBFPJNtU1
         n60n68Slj/ZLTXWO6Zv6X+pC+hb8GOqO7WMuVpKrrPm1Qm1iFWN36tils7xKMiPOjA
         B1BLrmyOt5vYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5.18] Revert "ath11k: mesh: add support for 256 bitmap in
 blockack frames in 11ax"
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1648701477-16367-1-git-send-email-quic_akolli@quicinc.com>
References: <1648701477-16367-1-git-send-email-quic_akolli@quicinc.com>
To:     Anilkumar Kolli <quic_akolli@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164909233481.29714.6659230438745116028.kvalo@kernel.org>
Date:   Mon,  4 Apr 2022 17:12:19 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <quic_akolli@quicinc.com> wrote:

> This reverts commit 743b9065fe6348a5f8f5ce04869ce2d701e5e1bc.
> 
> The original commit breaks the 256 bitmap in blockack frames in AP
> mode. After reverting the commit the feature works again in both AP and
> mesh modes
> 
> Tested-on: IPQ8074 hw2.0 PCI WLAN.HK.2.6.0.1-00786-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 743b9065fe63 ("ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax")
> Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>

Patch applied to wireless.git, thanks.

10cb21f4ff3f Revert "ath11k: mesh: add support for 256 bitmap in blockack frames in 11ax"

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1648701477-16367-1-git-send-email-quic_akolli@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

