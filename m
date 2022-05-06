Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FCB51D0E4
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 07:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379449AbiEFFwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 01:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389259AbiEFFwD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 01:52:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD142CE2B
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 22:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 619ACB831B9
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596E9C385AA;
        Fri,  6 May 2022 05:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651816098;
        bh=pNR7vxwxqIU3qzHpVIN93kpvHqFklVszOyK/02NpMBE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=q1Jp8r4ldrCmVUMKHHZrDfGWoxpZk9vcKqeju8sGbzA/7ZOHhmVRENYRU5fWZGCcu
         sWvlBhPuRXcv/1IZQgsgpS1rGOci+iT6FpU1KFK6pA0/sOInLJgT0eV6VqFYHalkOr
         3G/5XCJqRvIfBQT/lA7bgAfOwT1z9nFVllh/IczSr9W0tbjdICl24/vHFgXJhztC/I
         ss47KdnoxzGDsSXkV0e1P0+G0uP1ersTc/o7iQv/QlFtofCg+3qFAPsVTVdShocpFL
         qlJUN2dTbBFhZiSZLDC7kmXnGXuF2822kpRb/xm2iDFvv4f8w79r1gvq+8JPXx12S2
         DnonCG/tPVGgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless-next,1/3] wil6210: switch to netif_napi_add_tx()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220504163316.549648-2-kuba@kernel.org>
References: <20220504163316.549648-2-kuba@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165181608088.835.3544129814895801581.kvalo@kernel.org>
Date:   Fri,  6 May 2022 05:48:17 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> wrote:

> Switch to the new API not requiring passing in NAPI_POLL_WEIGHT.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

3 patches applied to wireless-next.git, thanks.

f1c5d4ded782 wil6210: switch to netif_napi_add_tx()
3ed27b602cc3 mt76: switch to netif_napi_add_tx()
193eb523d27c qtnfmac: switch to netif_napi_add_weight()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220504163316.549648-2-kuba@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

