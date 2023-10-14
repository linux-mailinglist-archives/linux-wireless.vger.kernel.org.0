Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612A17C930C
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Oct 2023 08:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjJNGoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Oct 2023 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNGoG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Oct 2023 02:44:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7DCC2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Oct 2023 23:44:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255A3C433C8;
        Sat, 14 Oct 2023 06:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697265844;
        bh=fdAQhoVPW7MSZI8H4CrzyMBLTUXY6tsRdC1cNXgZOyM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=c385owirX2UYWNnzg5Y+Ns+vZ/dB7IoCJwOnMy4kNTfMjDbAfEr/afWqTDU4HrPOh
         +GA9H6+uRfJHwrN/5vmRjwfa/74x8Ph30JZZEakoRtaeIBP2c/Zg4aeEjutfrTiMZK
         QXmcPceriYNdyNqrwtSWPmM92tCta2TpR87qh/jvhglqBgqS9XQyqDCvq5iTiIYIT+
         EWNUWJCR596/j26mNGlYvbEiZoKuPRUZxVflf4jxNjVNgxM1oExu7d2dxBdPggPpK+
         fOojhB5XOgi6/BrsxOU+YmSwrZwfbiOYcLy7chqKPLTUIh16giRdwMpsjPigGZLt67
         s6QyCR0rHdTew==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: mac: update RTS threshold according
 to
 chip gen
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231012021455.19816-2-pkshih@realtek.com>
References: <20231012021455.19816-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169726584243.3637479.11367556435802862618.kvalo@kernel.org>
Date:   Sat, 14 Oct 2023 06:44:03 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> When TX size or time of packet over RTS threshold set by this register,
> hardware will use RTS protection automatically. Since WiFi 6 and 7 chips
> have different register address for this, separate the address according
> to chip gen.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

fbd1829d2960 wifi: rtw89: mac: update RTS threshold according to chip gen
7f69cd4253c3 wifi: rtw89: mac: generalize register of MU-EDCA switch according to chip gen
79c55327cf24 wifi: rtw89: mac: add registers of MU-EDCA parameters for WiFi 7 chips
5fa1c5d416d5 wifi: rtw89: mac: set bfee_ctrl() according to chip gen
31b7cd195af7 wifi: rtw89: mac: set bf_assoc capabilities according to chip gen
b650981501bf wifi: rtw89: mac: do bf_monitor only if WiFi 6 chips

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231012021455.19816-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

