Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDEB7DBEC5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Oct 2023 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjJ3RXa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Oct 2023 13:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjJ3RX3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Oct 2023 13:23:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9280F99
        for <linux-wireless@vger.kernel.org>; Mon, 30 Oct 2023 10:23:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F004C433C8;
        Mon, 30 Oct 2023 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698686607;
        bh=qgqW7OnsfcY/8MCHhrwgSs35CVVWWLPyigCnAQ1bFCQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=OJkY1uiTiaLBrP1d87PjBMW5+vqc516DHxl6rVyXKVbvuL/LdUT36h91gLUuljqcp
         FX55yziLzUp85wKU1pzmfKUjXwNgYRy9njyM9+05gPdFacmcLPVL6oFI9FfvXh7tqG
         7Z4Y/A9FSQbETD8zXJNM34CSm/LixQ2WZNcHNHjWB21yetLjPPCF/+Lio/WPNly+Kf
         oliJWaEpO2jX8KMGjh9gfNnzphuXHuoikXyf28Wr9MCiKs2iBn71b2EVTtYYDYSZwT
         vcdjYkHJprFhvJRC4XhyVY3hinF48BSDtQ+9j0rpImZ4Iz8iJNmF0QfuJmH8XEf67M
         tL9+zZzGqSGAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtw89: 8922ae: add 8922AE PCI entry and basic
 info
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231026120049.9187-2-pkshih@realtek.com>
References: <20231026120049.9187-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169868660437.1993746.6938980872012815271.kvalo@kernel.org>
Date:   Mon, 30 Oct 2023 17:23:26 +0000 (UTC)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8922AE is a PCIE 802.11be wireless adapter with PID 0x8922. We add basic
> configurations including PCI DMA mode, PCI parameters, register address to
> control TX/RX rings and etc.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

73b479fe5f4a wifi: rtw89: 8922ae: add 8922AE PCI entry and basic info
0b79c540b135 wifi: rtw89: pci: define PCI ring address for WiFi 7 chips
0dc9324206d3 wifi: rtw89: pci: add new RX ring design to determine full RX ring efficiently
58534b3be0ca wifi: rtw89: pci: generalize code of PCI control DMA IO for WiFi 7

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231026120049.9187-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

