Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC18E4B108C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 15:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiBJOhL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 09:37:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237546AbiBJOhL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 09:37:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B51233
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 06:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0535060F1F
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 14:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB55EC004E1;
        Thu, 10 Feb 2022 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644503831;
        bh=Wc8nfEDH+UA3Qnl5h7qM8KmrEpJfwEZDHX3tpe26uHg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=rD938mSYN+jawGJ9kcIC/mOkZ/aOHojV0dbsiHEJNUKYxU9qTo94L5+Q9GtfC20II
         mP8a62cZudbaY80X9StjNnK4uQqn0HCFAx0z/Ld3w14gMW647NmNfRDtRJarasZw6L
         rUtHR0Y4xdeyGaG0JpEihWmM19ebvTtzjFoeFjfCFMuxYZsxQrG1+i5Jfbfmz4FT6K
         GGNEbx/XT5Y6tHW7evYvpPF4XpKsmg1gTodPyaSxTYrtUuh6g9708ubS+kDHM56Hy5
         dB4/+vUVpcxX2M/eEvI8qHbYLyj6R62UKH9M0a0sWBE72KZyu/lnuU3tRpvIsk308H
         hA/c4g23EIUxw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2022-02-04
References: <9dc9c187-c86d-1a43-655f-00d1c4d10205@nbd.name>
Date:   Thu, 10 Feb 2022 16:37:04 +0200
In-Reply-To: <9dc9c187-c86d-1a43-655f-00d1c4d10205@nbd.name> (Felix Fietkau's
        message of "Fri, 4 Feb 2022 13:57:16 +0100")
Message-ID: <87iltm3i0f.fsf@kernel.org>
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

Felix Fietkau <nbd@nbd.name> writes:

> Hi Kalle,
>
> here's my first pull request for 5.18
>
> - Felix
>
> The following changes since commit b4bb8469e90ec75c0ce81fcf6a9c3abd2f18e005:
>
>   brcmfmac: pcie: Read the console on init and shutdown (2022-02-01 14:27:08 +0200)
>
> are available in the Git repository at:
>
>   https://github.com/nbd168/wireless tags/mt76-for-kvalo-2022-02-04
>
> for you to fetch changes up to b3ad9d6a1d66712fb08cd59ae3e03cbdb9f80e7b:
>
>   mt76: redefine mt76_for_each_q_rx to adapt mt7986 changes (2022-02-04 11:28:36 +0100)
>
> ----------------------------------------------------------------
> mt76 patches for 5.18
>
> - mt7915 mcu code cleanup
> - mt7916 support
> - fixes for SDIO support
> - fixes for DFS
> - power management fixes
> - stability improvements
> - background radar detection support
>
> ----------------------------------------------------------------

Pulled, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
