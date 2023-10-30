Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3660E7DBED9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjJ3R0R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjJ3R0Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:26:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1324AB
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:26:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAA4C433C8;
        Mon, 30 Oct 2023 17:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686774;
        bh=pGbjYj9fq7YZjhzpeUsN3+hJPBYd942gOq3ILUrtahw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ZrlBB0qRz5T63TTt8qOuS7Pj+Xx6Dobg7FOoDuGxO8pfCIFoqPUT2zb0txqNLCh+R
         z8Et3kGYX0pidee+5AQKCLwn5pWUDIhbSC8B7M5RuhBZXvpiKqXuNMQWoCgQIJ3hjb
         7kY6GiUAq8P8ZruHIFth5UEaD4CXcckfyDHrXQxEv2S4O8ofDAj2bKU0aruhhsQlRA
         IoKgLymk9/IMiBu1eRLdd/3ofhWJi2l0rMzJr64VfG+R1iMe9JDVlCGVDA85rHndnI
         ozOCoHddd62wNZ49LBmfYkB6CCeIQg9Ox98cd1qZTO8FGzLDAtXHNGrCql7QmkR7LV
         s8Qk9MvzafnRQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wifi: rtw89: set entry size of address CAM to H2C
 field by chip
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231027015059.10032-2-pkshih@realtek.com>
References: <20231027015059.10032-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868677216.1993746.18349131169051211820.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:26:13 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The new chips change hardware design to shrink entry size of address
> CAM from 0x40 to 0x20, so make this change accordingly.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

0f4aa3af1371 wifi: rtw89: set entry size of address CAM to H2C field by chip
76d45f48e4fc wifi: rtw89: configure PPDU max user by chip
e343face52b0 wifi: rtw89: consider RX info for WiFi 7 chips
944496bada22 wifi: rtw89: extend PHY status parser to support WiFi 7 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231027015059.10032-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

