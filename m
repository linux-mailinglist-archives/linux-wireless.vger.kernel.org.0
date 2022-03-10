Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061B44D4F92
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiCJQqp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 11:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiCJQqo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 11:46:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6DD15B9A8
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 08:45:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 140A7B826C7
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 16:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F35C340E8;
        Thu, 10 Mar 2022 16:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646930740;
        bh=BFx+Ue74aaw1ZxlrLqj846LfZ4pQPVGp6tQvIYLUdd0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fEnWzzTKsa7+6KC8MDTSUK78KxT2RqK1cQOPkgUgwhvrvVEL7IoxX/EVnNZK3JLeA
         UBUxSdqOp+V72DJ9OCx97M6y9vuJJBvF7prNWOuiblSgcG4HAJCNW02d7nQRQKzq3U
         qKQfUNlLXov24KPK13vWAEBMWHb5V8qExFUz9NQidZufhlx6hhKJodx/WAi/8D9qJW
         7kPZXSmRhKe2o6tgtRUQgHqQ8raSNvQ7Ffi4QrMJ/RlD3pF9Ff9En4BIU3cIuiydRI
         ExBsn+O+ofAa9f+1iIh+qEQ26qsYqwMtnuttbzyE0g1CZ3LOcFkdypqKKRSM2ImHDa
         c8HF7wrHSbA5A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/13] rtw89: 8852c: add 8852c empty files
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220307060457.56789-2-pkshih@realtek.com>
References: <20220307060457.56789-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164693073590.6056.14063999570473758672.kvalo@kernel.org>
Date:   Thu, 10 Mar 2022 16:45:40 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add these files, and then I can add specific chip::ops or chip::info along
> with the existing chip.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

13 patches applied to wireless-next.git, thanks.

0ac80e05ea32 rtw89: 8852c: add 8852c empty files
4a9e48accf2d rtw89: pci: add struct rtw89_pci_info
97d61bf94026 rtw89: pci: add V1 of PCI channel address
e4133f269eb7 rtw89: pci: use a struct to describe all registers address related to DMA channel
a8bdac120484 rtw89: read chip version depends on chip ID
2a7e54db40f0 rtw89: add power_{on/off}_func
2af64b4af48e rtw89: add hci_func_en_addr to support variant generation
e8955811c658 rtw89: add chip_info::{h2c,c2h}_reg to support more chips
ab8a56716b11 rtw89: add page_regs to handle v1 chips
79d099e022ae rtw89: 8852c: add chip::dle_mem
bdfbf06c2c28 rtw89: support DAV efuse reading operation
a82174c6a175 rtw89: 8852c: process efuse of phycap
ea37206459ac rtw89: 8852c: process logic efuse map

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220307060457.56789-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

