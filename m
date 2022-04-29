Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D20515432
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 21:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiD2TJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 15:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbiD2TJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 15:09:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79154A1452
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 12:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFE5DB837B8
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 19:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FA1C385A4;
        Fri, 29 Apr 2022 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651259184;
        bh=50dpnfYzr5JGdkLtQS3FV/qztqB75jWajOlvJ+cr3EY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mXsV7YmuCopz4vFtpkgKT+1juj31UCt+BAwtrWHmMsmaBA78PRMoF/AJBCFdTB7M3
         4/WjeiANWfvso8ujLq7uHOKAA6wIogvvcwmp5yWdK7gaQvMVsZUKfy+NAAxcFTCB/w
         0enRpwr/tmzv64FKPhDSNYvZHsNmksD+B6/wgVNTTZ3d3Dy1TDPzmDDDICM3WD/pQK
         DLRsiyD7cjyFyzHs7prhEGzZI5FW6mCxUXgUCiwvEErSsgZUXY/VlTXs2rhKIBXnsK
         R2qJtNlLAHkiTlhqH68jP4Qm8kGrPUQoDfA3lXFTHXopIJ7/mB6omHuQ+bUAFOZa/B
         p2TkQiyxEYBfw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH wireless-next 2/3] wifi: ath10k: remove a copy of the NAPI_POLL_WEIGHT define
References: <20220429174643.196994-1-kuba@kernel.org>
        <20220429174643.196994-3-kuba@kernel.org>
Date:   Fri, 29 Apr 2022 22:06:20 +0300
In-Reply-To: <20220429174643.196994-3-kuba@kernel.org> (Jakub Kicinski's
        message of "Fri, 29 Apr 2022 10:46:42 -0700")
Message-ID: <87v8urd80j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> Defining local versions of NAPI_POLL_WEIGHT with the same
> values in the drivers just makes refactoring harder.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: kvalo@kernel.org
> CC: ath10k@lists.infradead.org
> CC: linux-wireless@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath10k/core.h | 3 ---
>  drivers/net/wireless/ath/ath10k/pci.c  | 2 +-
>  drivers/net/wireless/ath/ath10k/sdio.c | 2 +-
>  drivers/net/wireless/ath/ath10k/snoc.c | 2 +-
>  4 files changed, 3 insertions(+), 6 deletions(-)

This failed to build as recently usb.c got napi poll as well, I fixed it
in the pending branch:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=89fc2e14d3e50cad605104572228d3740df7ca77

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
