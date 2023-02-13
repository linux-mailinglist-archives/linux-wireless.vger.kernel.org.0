Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC933694DCD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBMRSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBMRSB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:18:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DC71C7F9
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:18:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87EA3B81617
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725B4C433EF;
        Mon, 13 Feb 2023 17:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308678;
        bh=L1OcsLIIv9AeK12yaKY5G2M9IEdwtcP6q72p9IiX9Ig=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=SR8DTfaOXt7MOqG2SQ6x90UiRxrel2kf94TBVuUVsEj7aa9eaDBkgASJ7339q3qce
         XTBZnJ7hh90+8t8OS3dZxwQdH0i0Po/CIRhnggVkTE/EqRip01cZjkI2jiYQ42kCTx
         3gJSM6TfQdypQHeR9hl1DQCVic7mjixl/Kiovw5DGKgae7CE4iWnAsmyatrTq1GOVz
         0AHOCCiEH9nsMM/7NS1/Y/JywcQQjuBOn9f2J4rRZPbQgsxM4hi6UUd/9A9F9Eggfc
         3aZCXfyE0zVGT3KT5XaL46NnHLRqmskHJX3EDEVTQHTvGZjW6tq35NRJ7m1BworSJi
         9SRUU82iAG4oA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: fix potential wrong mapping for
 pkt-offload
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230123065401.14174-2-pkshih@realtek.com>
References: <20230123065401.14174-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630867570.12830.6517841349276360254.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:17:57 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> When driver fails to send H2C to firmware for pkt-offload, we should not
> update the pkt_list of driver, and need to release allocated pkt index to
> avoid wrong mapping between driver and firmware.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

b8e8ff842b1b wifi: rtw89: fix potential wrong mapping for pkt-offload
5c12bb66b79d wifi: rtw89: refine packet offload flow
5da5ba7e6ec4 wifi: rtw89: add use of pkt_list offload to debug entry
2e5a65f5952f wifi: rtw89: 8852b: reset IDMEM mode to default value
e5624482ba3e wifi: rtw89: 8852b: don't support LPS-PG mode after firmware 0.29.26.0
7410bd727584 wifi: rtw89: 8852b: try to use NORMAL_CE type firmware first

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230123065401.14174-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

