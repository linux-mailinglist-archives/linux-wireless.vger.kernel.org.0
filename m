Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB6583B3E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiG1Jbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiG1Jba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:31:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258EF54CBC
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:31:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDB7DB8237F
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42FDC433C1;
        Thu, 28 Jul 2022 09:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659000686;
        bh=TrCHxnM69uRRwgBH2fmg9CyksUE35VTBbCCaviWPdC8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ZBRM8udOt7Uc4OdXy/ixliiBNaM1YXxk2ZrAlLdUi9JZbHwf/aE9UKBRDf2r1E+sC
         CkAKU24AtUdrPs8dEEEebm904vpK/p3ZInBkOHQ0P3bFYlViU3QmnyMjqc99M8K/y/
         k3DKvjMhA9cEpiZtvxyIoja6thwscDj61vGQ2EN7E3YZMumCFEWTUbJtfiCBNHR0qG
         tluEJioTqIGwPYn8Ge6OTPDbtokMVZlp1kY648Qk2celU3/n+kF2BPFJGn+0Neg1Yl
         PZKtqW+aIcWaWgRKCulQjO9DnmNCYy2ytDxSEUVG6LPIrIYJoNsHB2kAScNcCZ+Vi8
         N8+nxwxtMmwZQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     aspriel@gmail.com
Cc:     arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/7] brcmfmac: add firmware vendor info in driver data
References: <20220613091915.18884-1-arend.vanspriel@broadcom.com>
        <CAJ65rDwH9SYhsTKM_4c6e0EN6qfp16kGVsVtSs0d+TNou=DF5g@mail.gmail.com>
Date:   Thu, 28 Jul 2022 12:31:23 +0300
In-Reply-To: <CAJ65rDwH9SYhsTKM_4c6e0EN6qfp16kGVsVtSs0d+TNou=DF5g@mail.gmail.com>
        (aspriel's message of "Mon, 13 Jun 2022 05:19:24 -0400")
Message-ID: <871qu5por8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

aspriel@gmail.com writes:

> In order to determine the vendor that released a firmware image for
> a specific device, the device table now sets the vendor identifier
> and it is stored in struct brcmf_bus::fwvid during probe.
>
> Reviewed-by: Hante Meuleman <hante.meuleman@broadcom.com>
> Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
> Reviewed-by: Franky Lin <franky.lin@broadcom.com>
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>

The patchwork page for this patch looks odd, but didn't investigate in
detail. Never seen that kind of parsing problems before:

https://patchwork.kernel.org/project/linux-wireless/patch/CAJ65rDwH9SYhsTKM_4c6e0EN6qfp16kGVsVtSs0d+TNou=DF5g@mail.gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
