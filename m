Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64C6694DA6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjBMRFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjBMRFT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:05:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F91C336
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:05:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC41AB810D6
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A2FC433D2;
        Mon, 13 Feb 2023 17:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676307912;
        bh=7imS5ez7TV6OVUwLhA9z2x0TNO3wV+1J9AiTiJVl5iw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rkVZ1DVFlSV3nPn3d5ILG5GlzSvy3Td58lnOk58yA0b0U32UkMYEWNpRRSlke5jVC
         Lcp7rK9+gaDH3E4GDObBuo04DEep1XE1KZKq+wjDBDcTSwFC35ftiWYDfnTacMZ6gQ
         r1KN8XfpsxinkqahCBU/PHafrHqMkmRxYtOEpTJTcLEAV+/2iHuWlJxtdBKcQ6Er/0
         +bNvKX67KEoB6PiSVHQKuaFauU0/Tm+u21OeNtCmFrQB43cwFWRypm6EIVDw4TnIEt
         XGwVDR9TeluwwUmV0S6M4wrKH15c4lP8KI6nzBqfD3CHPkEL3pCiIAg7cZodNDfChH
         87/jvvHANeekQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: correct unit for port offset and refine
 macro
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230119062453.58341-2-pkshih@realtek.com>
References: <20230119062453.58341-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630791005.12830.1634557676527624111.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:05:11 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Strictly speaking, the unit of the offset should be TU instead of ms.
> So, correct it and the macro for calculation. Then, to make the macro
> generic, the factor n is moved outside.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

1120e6a6c5cd wifi: rtw89: correct unit for port offset and refine macro
42db7edd5c05 wifi: rtw89: split out generic part of rtw89_mac_port_tsf_sync()
76f478a34daf wifi: rtw89: mac: add function to get TSF

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230119062453.58341-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

