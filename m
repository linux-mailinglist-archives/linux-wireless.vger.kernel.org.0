Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C205E8D2A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Sep 2022 15:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiIXNmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Sep 2022 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIXNmo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Sep 2022 09:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372D481E6
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 06:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61841609FB
        for <linux-wireless@vger.kernel.org>; Sat, 24 Sep 2022 13:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BB2C433D6;
        Sat, 24 Sep 2022 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664026962;
        bh=pw21qSEFcSihTyQSxp+ab2bgezDBBRwpASZx4DZ6rkU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=c1zQ/p5wHNuqBvMOWsAuU9h4/ul7HZgX5mSnePN67ZZb659v5UYneDUUQVNqfdgt1
         XqJPZYVxvWKApy1ntBNMZK7+is15YWQ9V+W/zbZEpwaabh9Zojh6h0pFMVA7HAOh4/
         IL6PfJSecUbRm/i2Zn8cvgoXeBqCbxrdIwhAiPN2piBxcWDNvQp9PGO/AEA7ID0DnA
         RMQFN3ACN5TMnLegKegM259lUIm75vFEYNcA/iMOtxLNFdFS32ZX8CkHAAJZN6nlOl
         WRHw+PttAL61Bs4YYUaQ0SCeOu5fyvwMyNlWN6SPO95dk1W46cR/VXmeUiM1MpqGHE
         svIJpgwGHb4QQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band
 migration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220603164559.27769-1-ansuelsmth@gmail.com>
References: <20220603164559.27769-1-ansuelsmth@gmail.com>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166402695696.26031.9505362425137556252.kvalo@kernel.org>
Date:   Sat, 24 Sep 2022 13:42:41 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian 'Ansuel' Marangi <ansuelsmth@gmail.com> wrote:

> This patch try to fix the following error.
> 
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561227] ath11k c000000.wifi: peer already added vdev id 0 req, vdev id 1 present
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561282] ath11k c000000.wifi: Failed to add peer: 28:c2:1f:xx:xx:xx for VDEV: 0
> Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.568053] ath11k c000000.wifi: Failed to add station: 28:c2:1f:xx:xx:xx for VDEV: 0
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: Could not add STA to kernel driver
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: did not acknowledge authentication response
> Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan1: AP-STA-DISCONNECTED 28:c2:1f:xx:xx:xx
> Wed Jun  1 22:19:31 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: disassociated due to inactivity
> Wed Jun  1 22:19:32 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: deauthenticated due to inactivity (timer DEAUTH/REMOVE)
> 
> To repro this:
> - Have 2 Wifi with the same bssid and pass on different band (2.4 and
> 5GHz)
> - Enable 802.11r Fast Transaction with same mobility domain
> - FT Protocol: FT over the Air
> From a openwrt system issue the command (with the correct mac)
> ubus call hostapd.wlan1 wnm_disassoc_imminent '{"addr":"28:C2:1F:xx:xx:xx"}'
> Notice the log printing the errors.
> 
> The cause of this error has been investigated and we found that this is
> related to the WiFi Fast Transaction feature. We observed that this is
> triggered when the router tells the device to change band. In this case
> the device first auth to the other band and then the disconnect path
> from the prev band is triggered.
> This is problematic with the current rhash implementation since the
> addrs is used as key and the logic of "adding first, delete later"
> conflicts with the rhash logic.
> In fact peer addition will fail since the peer is already added and with
> that fixed a peer deletion will cause unitended effect by removing the
> peer just added.
> 
> Current solution to this is to add additional logic to the peer delete,
> make sure we are deleting the correct peer taken from the rhash
> table (and fallback to the peer list) and for the peer add logic delete
> the peer entry for the rhash list before adding the new one (counting as
> an error only when a peer with the same vlan_id is asked to be added).
> 
> With this change, a sta can correctly transition from 2.4GHz and 5GHZ
> with no drop and no error are printed.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Fixes: 7b0c70d92a43 ("ath11k: Add peer rhash table support")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d673cb6fe6c0 wifi: ath11k: fix peer addition/deletion error on sta band migration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220603164559.27769-1-ansuelsmth@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

