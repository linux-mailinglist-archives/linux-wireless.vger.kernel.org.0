Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BD732C82
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 11:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbjFPJyl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 05:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjFPJyk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 05:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F41297E
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 02:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C44666282E
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 09:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC977C433C0;
        Fri, 16 Jun 2023 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686909277;
        bh=EwOzb3591TyjfY11CPXo3m0xo9syW6Ii23jTvxqh7rM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M42tifX7uXlHi73avvIopEVy4NRmXCH6WckRAL/yafJI3u2X0Mew45GKzYGoRO2s9
         lhFZG0af+/AP+q6RIMI6Kyh6wBSsaDvMPC+zVn/hZBNLGHMnBEZrCUnHyoHdxQ9EH4
         /jHKPKS33p0yw1NVoWmBPGlSwDBq9TDWYgRnvxGNy+5M+eN7Tu+5WM6GJ1RYGIS0ZB
         v/yQlhHAeerONtCMAsui/Yr0dL21T9rtUQmiFM09g3XZie1D6/Lc+csB+pqZUVrfqL
         Vf7bj5Y3Umju1Bq2OPXC0ji3S2qdXKSsMZlxj9IffULDycjUi9c+9S9bNBWOuZlIKC
         dTifGrNEHM9EA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] [v2] wifi: rtlwifi: simplify LED management
References: <20230608095051.116702-4-dmantipov@yandex.ru>
        <168664510862.24637.10587241603155144086.kvalo@kernel.org>
        <e030e496-b667-b1de-492b-8b0cc04ffe14@yandex.ru>
        <87h6rad3fp.fsf@kernel.org>
        <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru>
Date:   Fri, 16 Jun 2023 12:54:31 +0300
In-Reply-To: <bccf723a-9f57-73a7-37af-badc6c156daa@yandex.ru> (Dmitry
        Antipov's message of "Thu, 15 Jun 2023 11:49:07 +0300")
Message-ID: <87cz1vbulk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> writes:

> On 6/14/23 08:21, Kalle Valo wrote:
>
>> rtlw8xxxu, rtw88 and rtw89 are the active Realtek drivers
>
> What about rtl818x?

rtl818x is not active. You can actually check that yourself:

git log drivers/net/wireless/realtek/rtl818x/

If you see from the past few years only kernel wide API changes or
similar it's a clear sign that the driver is not in active development
anymore. 

I want to also mention that the maintainers are not really enthusiastic
about random cleanups to random drivers from new contributors, they
increase our workload and there's always a risk of regressions. I try to
be nice and take few cleanups now and then, but if there's too much such
patches I'll start to back off.

Instead random cleanups I would be very happy to see these issues fixed
in wireless drivers:

o removal of strlcpy()

o fixing sparse warnings (my goal is to have wireless drivers sparse
  warning free)

o removal of BUG_ON() (no wireless driver should use BUG_ON() which
  crashes the whole system)

Here's a list of sparse warnings:

drivers/net/wireless/legacy/wl3501_cs.c: note: in included file:
drivers/net/wireless/legacy/wl3501.h:608:48: warning: array of flexible structures
drivers/net/wireless/atmel/atmel.c:3645:30: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3646:31: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3647:30: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3648:32: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3649:30: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3650:31: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3651:30: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3652:32: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3653:32: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3654:30: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3655:32: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3656:32: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3657:28: warning: cast to restricted __le16
drivers/net/wireless/atmel/atmel.c:3658:29: warning: cast to restricted __le16
drivers/net/wireless/cisco/airo.c:2055:24: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:2055:24:    expected restricted __le16 [usertype] status
drivers/net/wireless/cisco/airo.c:2055:24:    got unsigned short [usertype] status
drivers/net/wireless/cisco/airo.c:3262:18: warning: cast to restricted __le16
drivers/net/wireless/cisco/airo.c:3854:27: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:3854:27:    expected int auth_type
drivers/net/wireless/cisco/airo.c:3854:27:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:4927:51: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:4927:51:    expected int auth_type
drivers/net/wireless/cisco/airo.c:4927:51:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:4930:51: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:4930:51:    expected int auth_type
drivers/net/wireless/cisco/airo.c:4930:51:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:4933:51: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:4933:51:    expected int auth_type
drivers/net/wireless/cisco/airo.c:4933:51:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6429:46: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6429:46:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6429:46:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6449:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6449:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6449:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6451:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6451:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6451:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6453:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6453:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6453:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6610:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6610:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6610:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6612:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6612:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6612:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6614:38: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6614:38:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6614:38:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6719:54: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6719:54:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6719:54:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6721:46: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6721:46:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6721:46:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:6731:54: warning: incorrect type in argument 2 (different base types)
drivers/net/wireless/cisco/airo.c:6731:54:    expected int auth_type
drivers/net/wireless/cisco/airo.c:6731:54:    got restricted __le16 [usertype]
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3812:32: warning: incorrect type in assignment (different base types)
drivers/net/wireless/cisco/airo.c:3812:32:    expected restricted __le16 [usertype] authType
drivers/net/wireless/cisco/airo.c:3812:32:    got int auth_type
drivers/net/wireless/cisco/airo.c:3816:26: warning: restricted __le16 degrades to integer
drivers/net/wireless/cisco/airo.c:3816:52: warning: restricted __le16 degrades to integer
drivers/net/wireless/microchip/wilc1000/cfg80211.c:362:42: warning: incorrect type in assignment (different base types)
drivers/net/wireless/microchip/wilc1000/cfg80211.c:362:42:    expected unsigned int key_mgmt_suite
drivers/net/wireless/microchip/wilc1000/cfg80211.c:362:42:    got restricted __be32 [usertype]
drivers/net/wireless/intersil/hostap/hostap_ap.c:353:13: warning: context imbalance in 'ap_control_proc_start' - wrong count at exit
drivers/net/wireless/intersil/hostap/hostap_ap.c:366:13: warning: context imbalance in 'ap_control_proc_stop' - unexpected unlock
drivers/net/wireless/intersil/hostap/hostap_ap.c:555:13: warning: context imbalance in 'prism2_ap_proc_start' - wrong count at exit
drivers/net/wireless/intersil/hostap/hostap_ap.c:568:13: warning: context imbalance in 'prism2_ap_proc_stop' - unexpected unlock
drivers/net/wireless/zydas/zd1211rw/zd_usb.c:383:24: warning: implicit cast from nocast type
drivers/net/wireless/zydas/zd1211rw/zd_usb.c:419:24: warning: implicit cast from nocast type
drivers/net/wireless/mediatek/mt7601u/mac.c:361:16: warning: dubious: x & !y
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:3302:46: warning: cast truncates bits from constant value (ffff7fff becomes 7fff)
drivers/net/wireless/broadcom/b43/phy_n.c:6249:35: warning: cast truncates bits from constant value (ffff3fff becomes 3fff)
drivers/net/wireless/broadcom/b43/phy_n.c:6380:55: warning: cast truncates bits from constant value (ffff7fff becomes 7fff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:17590:47: warning: cast truncates bits from constant value (ffff7fff becomes 7fff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:18089:53: warning: cast truncates bits from constant value (ffff3fff becomes 3fff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:21056:36: warning: cast truncates bits from constant value (ffff3fff becomes 3fff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:21290:68: warning: cast truncates bits from constant value (ffff03ff becomes 3ff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:23200:35: warning: cast truncates bits from constant value (ffff7fff becomes 7fff)
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c:28205:44: warning: cast truncates bits from constant value (ffff1fff becomes 1fff)
drivers/net/wireless/intersil/hostap/hostap_proc.c:98:13: warning: context imbalance in 'prism2_wds_proc_start' - wrong count at exit
drivers/net/wireless/intersil/hostap/hostap_proc.c:111:13: warning: context imbalance in 'prism2_wds_proc_stop' - unexpected unlock
drivers/net/wireless/intersil/hostap/hostap_proc.c:323:13: warning: context imbalance in 'prism2_scan_results_proc_start' - wrong count at exit
drivers/net/wireless/intersil/hostap/hostap_proc.c:344:13: warning: context imbalance in 'prism2_scan_results_proc_stop' - unexpected unlock
drivers/net/wireless/broadcom/b43/phy_ht.c:325:35: warning: cast truncates bits from constant value (ffff3fff becomes 3fff)
drivers/net/wireless/broadcom/b43/phy_ht.c:554:61: warning: cast truncates bits from constant value (ffff1fff becomes 1fff)
drivers/net/wireless/st/cw1200/cw1200_spi.c:83:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/st/cw1200/cw1200_spi.c:83:17:    expected unsigned short [addressable] [assigned] [usertype] regaddr
drivers/net/wireless/st/cw1200/cw1200_spi.c:83:17:    got restricted __le16 [usertype]
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17:    expected unsigned short [addressable] [assigned] [usertype] regaddr
drivers/net/wireless/st/cw1200/cw1200_spi.c:148:17:    got restricted __le16 [usertype]
drivers/net/wireless/rsi/rsi_91x_usb.c:235:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:236:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:237:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:238:27: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:244:36: warning: restricted __le32 degrades to integer
drivers/net/wireless/rsi/rsi_91x_usb.c:245:35: warning: restricted __le32 degrades to integer
drivers/net/wireless/ath/wil6210/cfg80211.c: note: in included file (through drivers/net/wireless/ath/wil6210/wil6210.h):
drivers/net/wireless/ath/wil6210/fw.h:96:47: warning: array of flexible structures
drivers/net/wireless/ath/ath9k/init.c:79:5: warning: symbol 'ath9k_use_msi' was not declared. Should it be static?
drivers/net/wireless/ath/wcn36xx/main.c:759:58: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/main.c:759:58:    expected unsigned short [usertype] vht_rx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:759:58:    got restricted __le16 [usertype] rx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:761:58: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/main.c:761:58:    expected unsigned short [usertype] vht_tx_mcs_map
drivers/net/wireless/ath/wcn36xx/main.c:761:58:    got restricted __le16 [usertype] tx_mcs_map
drivers/net/wireless/ath/ath9k/xmit.c:1676:20: warning: incorrect type in initializer (different base types)
drivers/net/wireless/ath/ath9k/xmit.c:1676:20:    expected unsigned short [usertype] mask
drivers/net/wireless/ath/ath9k/xmit.c:1676:20:    got restricted __le16 [usertype]
drivers/net/wireless/ath/ath9k/xmit.c:1680:17: warning: restricted __le16 degrades to integer
drivers/net/wireless/ath/ath9k/xmit.c:1681:42: warning: restricted __le16 degrades to integer
drivers/net/wireless/ath/ath9k/xmit.c:1681:36: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath9k/xmit.c:1681:36:    expected restricted __le16 [usertype] frame_control
drivers/net/wireless/ath/ath9k/xmit.c:1681:36:    got int
drivers/net/wireless/ath/wcn36xx/txrx.c: note: in included file (through drivers/net/wireless/ath/wcn36xx/txrx.h):
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    expected unsigned int [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    got restricted __be32 [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    expected unsigned int [usertype]
drivers/net/wireless/ath/wcn36xx/wcn36xx.h:107:24:    got restricted __be32 [usertype]
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    expected restricted __le16 x
drivers/net/wireless/ath/ath6kl/htc_mbox.c:368:9:    got unsigned short [usertype]
drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    expected restricted __le16 x
drivers/net/wireless/ath/ath6kl/htc_pipe.c:241:17:    got unsigned short [usertype]
drivers/net/wireless/ath/wil6210/fw.c: note: in included file (through drivers/net/wireless/ath/wil6210/wil6210.h):
drivers/net/wireless/ath/wil6210/fw.h:96:47: warning: array of flexible structures
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10796:39: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10796:39:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10796:39:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10798:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10798:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10798:43:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10800:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10800:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10800:43:    got restricted __le32 [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10802:43: warning: incorrect type in assignment (different base types)
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10802:43:    expected unsigned int [usertype]
drivers/net/wireless/ralink/rt2x00/rt2800lib.c:10802:43:    got restricted __le32 [usertype]
drivers/net/wireless/ath/ath11k/hal_rx.c:112:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:114:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:116:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:118:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:120:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:122:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:124:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:126:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:128:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:130:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:132:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:134:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:136:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:138:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:140:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:142:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:144:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:146:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:148:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:150:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:152:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:154:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:160:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:164:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:166:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:170:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:172:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:174:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:176:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:178:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:180:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:182:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:184:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:186:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:206:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:210:17: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/hal_rx.c:212:17: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:123:17: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt76x02_mac.c:155:16: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/dp_tx.c:930:23: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/dp_tx.c:932:23: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/dp_tx.c:935:23: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/dp_tx.c:1108:23: warning: dubious: x & !y
drivers/net/wireless/ath/ath11k/dp_tx.c:1110:23: warning: dubious: x & !y
drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:138:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:139:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_def.c:140:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_4k.c:79:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_9287.c:82:9: warning: cast from restricted __le32
drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast to restricted __le16
drivers/net/wireless/ath/ath9k/eeprom_9287.c:83:9: warning: cast from restricted __le32
drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c:521:9: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:901:9: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt7603/mac.c:961:15: warning: dubious: x & !y
drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:534:9: warning: dubious: x | !y

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
