Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4721D5EBA62
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiI0GKc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiI0GK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:10:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907E89817
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A791615D2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 06:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED88C433D6;
        Tue, 27 Sep 2022 06:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664259025;
        bh=p+tciQcNn1OBJeqx8zukaAf1oTB0/gjbtLf7IvZt8wE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Hw3LW+V0Iga4lJLlv5lAo9VtzVCTMrabkXZfjhxzMkSCYPj8Xu7e+HY1oOd1cvSaq
         bD4VmLF3AmvME7hWegqPxZQzuc2AeGHgsh0isiei97QmI+fgY7pSLatniMWkgJLqLX
         F6b/u+cJNNhJnW6iUauKl0d7qeeNZ7JiL02IuarXe9yuxhQh2mgRqSpvw2ZsMWukV4
         FccONr5jfxO264N7hiLjg/WiKdYk83rgfmDvz78Ntb9rFmWstlOx746U1lH4J8/LU6
         liFX8bqDeKuL8wZ5Ue/RllXYTpGYVhiJkMYUKGB5ESjg4tdMIXLPLpjpCqDh3J5VGA
         UoVFUZD/LGhBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wifi: rtw89: pci: mask out unsupported TX channels
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220923065311.123356-2-pkshih@realtek.com>
References: <20220923065311.123356-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166425902202.10854.17474411201005765804.kvalo@kernel.org>
Date:   Tue, 27 Sep 2022 06:10:25 +0000 (UTC)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852BE doesn't support some TX channels, so mask them out, or it access
> undefined registers.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Failed to apply, please rebase.

error: sha1 information is lacking or useless (drivers/net/wireless/realtek/rtw89/core.h).
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf
Patch failed at 0001 wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf

9 patches set to Changes Requested.

12986219 [1/9] wifi: rtw89: pci: mask out unsupported TX channels
12986221 [2/9] wifi: rtw89: mac: define DMA channel mask to avoid unsupported channels
12986224 [3/9] wifi: rtw89: add DMA busy checking bits to chip info
12986225 [4/9] wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf
12986216 [5/9] wifi: rtw89: pci: add to do PCI auto calibration
12986217 [6/9] wifi: rtw89: pci: set power cut closed for 8852be
12986218 [7/9] wifi: rtw89: mac: correct register of report IMR
12986222 [8/9] wifi: rtw89: check DLE FIFO size with reserved size
12986223 [9/9] wifi: rtw89: 8852b: configure DLE mem

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220923065311.123356-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

