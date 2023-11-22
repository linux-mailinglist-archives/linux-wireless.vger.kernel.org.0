Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEA57F4BA4
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjKVPvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 10:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbjKVPvo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 10:51:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044AF11F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Nov 2023 07:51:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FD1C433C8;
        Wed, 22 Nov 2023 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700668300;
        bh=VHpHsSuYxoqGSmKcNw2RI+WTJEwxIdkwXDjN7V06PI0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=te4Iu7he7ExkQfZ0YwfnQmFkCJluW1RIDR8hBX0hqSU8ajuXigpsDQcRA1Drt8aUN
         BmKULwYOdvVCpiyGhCIHwIUtELW4JlHz1C55QcsN1Q6plbOxHz23uGM6TbBke4/ehS
         OLethZvtDyrfM1Jui6E/MaRz+I2rIKqYailatoa0m74jxTBFmHHw76KszjulwEiXzk
         FuUDFkCiMMNUntGnIMqrFRk/BG/O+XuXyp/N7GUOV+78aT1QKOpLVyXYj38GCDPn1m
         gTO5gDxGI9WCDitQr73z/e683idwdRaf0Rm+Ll+4vvskcod5j6lplFa2z+ALv6LlY9
         +Jd1a+pHYhmjQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: 8922a: add 8922A basic chip info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231117024029.113845-2-pkshih@realtek.com>
References: <20231117024029.113845-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170066829802.4178710.6528521298542037631.kvalo@kernel.org>
Date:   Wed, 22 Nov 2023 15:51:39 +0000 (UTC)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8922A is a 802.11be chip that can support 2/5/6 GHz bands 160MHz bandwidth.
> Introduce the basic info such as firmware file name, some hardware address
> and size, supported spatial stream, TX descriptor and so on, and then
> we can add more attributes by later patches.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

c0a04552e36e wifi: rtw89: 8922a: add 8922A basic chip info
88e6a923bbfb wifi: rtw89: mac: use mac_gen pointer to access about efuse
f28eab6ae4ff wifi: rtw89: mac: add to access efuse for WiFi 7 chips
e102ff4b3579 wifi: rtw89: 8852c: read RX gain offset from efuse for 6GHz channels
c7ccb2402ebb wifi: rtw89: 8922a: read efuse content via efuse map struct from logic map
52471877a2e7 wifi: rtw89: 8922a: read efuse content from physical map

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231117024029.113845-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

