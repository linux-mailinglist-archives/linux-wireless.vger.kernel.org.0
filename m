Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A005ED552
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 08:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiI1Gs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 02:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiI1GsD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 02:48:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106CDBC2
        for <linux-wireless@vger.kernel.org>; Tue, 27 Sep 2022 23:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B65E5B81F0C
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 06:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9EE2C433B5;
        Wed, 28 Sep 2022 06:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664347591;
        bh=D08lfMOGGM5yMPx8Sy/8T/0IlB/rM8YmR3IEbT8Cgu4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ugoGIL5RU3DtZuxYKVzmGsNPsOjTYl4QDnqSLnWMSiYmio/xmGRjD6ixMrnb0EyEs
         wDsvn+6xNwwFqVtDWk1eO1lesb2yseG1CKzJOnzFTlSh77NqlBx2Kr4cmHzKArdH2w
         8I2Srf4fOyICaA2Kbv4GGptiBAwZU6bwjpY+og5N70hEfhMver5zvo4UUqJQhiaa3Z
         wdxsszjvXG7oQoTdYu0KdokU2dHjVKkrIU8jQnTaMzhlQkckrmgHDT85w3poMtCEog
         xO3ilfsE9yXjSzZPPSKNAJjtoxZMJyYaIoBJqcOMleGRtfWc381vCzS7fzYYKFdJi/
         y/b0wJWXdkoaA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/9] wifi: rtw89: pci: mask out unsupported TX channels
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220927062611.30484-2-pkshih@realtek.com>
References: <20220927062611.30484-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166434758888.25202.15477186160255300396.kvalo@kernel.org>
Date:   Wed, 28 Sep 2022 06:46:30 +0000 (UTC)
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

9 patches applied to wireless-next.git, thanks.

1bebcf08a305 wifi: rtw89: pci: mask out unsupported TX channels
a1b7163aab4c wifi: rtw89: mac: define DMA channel mask to avoid unsupported channels
61bdf7aacdc3 wifi: rtw89: add DMA busy checking bits to chip info
14b6e9f4b019 wifi: rtw89: 8852b: implement chip_ops::{enable,disable}_bb_rf
9e6e66ffba18 wifi: rtw89: pci: add to do PCI auto calibration
3d7475897a95 wifi: rtw89: pci: set power cut closed for 8852be
75f1ed29e431 wifi: rtw89: mac: correct register of report IMR
5f8c35b9323a wifi: rtw89: check DLE FIFO size with reserved size
a1cb097168fa wifi: rtw89: 8852b: configure DLE mem

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220927062611.30484-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

