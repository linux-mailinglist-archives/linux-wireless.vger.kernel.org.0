Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5D5BC616
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiISKJj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiISKJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:09:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1626FFF;
        Mon, 19 Sep 2022 03:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 797DE60F3E;
        Mon, 19 Sep 2022 10:09:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B31C433C1;
        Mon, 19 Sep 2022 10:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663582171;
        bh=oShRlj3BcmnMf17jIzrU1DTdHQXfx+U/kgfjApFm9ng=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=crPM3goFvrbX8KYzbT1gULNL7KELGPPCkkUoEl6xZHB4AIMUiV9S9q2QJdnBKGfzg
         DkP0vgtGkyL0vFag0K9UiwBwwWaDeCiFKNGw9tGt5kKaHBsr0tBlEGqsf6Vfjk590t
         E9FXFV+Pcgo3edpF9Gb59QfcFQ6a8JmpmNC4FqwyWF+WDVJLHgeLPyjMiuH5h9RZ4K
         3kCr3HKksjA1vOuaT7DhYFdG5PWbAQnCvcPHSqCxzhDYHUSCveVQ+/t3Mh0+p02Nx2
         ozT7lI6tp8X7SbaKnGXU4xkwp5YpLAtBPewGJy8cu582z6DMwVDTtj1Wzlg93xNxSB
         /kiSr3XLnxkkQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: uninitialized variable on error in
 rtw89_early_fw_feature_recognize()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <YyMzDtX/3fUBnonC@kili>
References: <YyMzDtX/3fUBnonC@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        Zong-Zhe Yang <kevin_yang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358216888.24821.8170558068675716786.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:09:30 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If request_partial_firmware_into_buf() fails then "firmware" is not
> initialized and the release_firmware(firmware) will crash.
> 
> Fixes: deebea35d699 ("wifi: rtw89: early recognize FW feature to decide if chanctx")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

4c3140f4cea6 wifi: rtw89: uninitialized variable on error in rtw89_early_fw_feature_recognize()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YyMzDtX/3fUBnonC@kili/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

