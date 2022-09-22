Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFEF5E5D89
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiIVIbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 04:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiIVIbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 04:31:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367A11C18
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 01:31:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7C8FB82149
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 08:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BACEC433D6;
        Thu, 22 Sep 2022 08:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663835479;
        bh=7f0uijtVO/3PaOi38urNDyGwnXguCdFGSSVcACXtUIA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WHDRZTh3tiscB//H3sYNSd7PSqIFQN7zCbJnO4sUDwZ+G6zDmalKwzNA954/KTXTM
         XbDXLJjBgbmyqhaOIr5tm8rvFT2HnI//5apg23kw1HAwyLr8b48HSL1QtKB4NUbtGE
         7HF6nfH6BLsvWhGDQgF3oIUVc9mfmKv+sN1Vr0URnO84gu15fhM5eJz1IoA1NRQhIa
         IKE5gj2afYELUA02lYTUXEd8WIWwnh5htnLOK7F7IlIfbyH2pEe/yhDsr7xMHoKJfG
         fTy4nBCy3PENJCDWwhChcePCAthfexKe6FcnRLjhMw4JmQTIV7BGcrk0yInxdsasu0
         wWfviqFxLNsDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band migration
References: <20220603164559.27769-1-ansuelsmth@gmail.com>
Date:   Thu, 22 Sep 2022 11:31:14 +0300
In-Reply-To: <20220603164559.27769-1-ansuelsmth@gmail.com> (Christian
        Marangi's message of "Fri, 3 Jun 2022 18:45:59 +0200")
Message-ID: <87pmfn4xpp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian 'Ansuel' Marangi <ansuelsmth@gmail.com> writes:

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
>>From a openwrt system issue the command (with the correct mac)
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
> ---
>
> Some additional comments external to this patch.
> I tried to find different way to fix this...
> One of them would be mod the logic of the rhash and using as a key both
> the vlan_id and the addr but this is problematic for the function
> where ath11k_peer_find_by_addr is used as vlan_id is not always available.
>
> I honestly think a correct solution would be have a rhash list per vdev_id
> or per mac_id but again this is problematic for some function that just handles
> data and have only the addr as a way to identify the peer.
>
> So unless some change are done to the firmware to provide the vlan_id in the
> msdu data this to me seems to be the only solution to correctly handle this case.
>
> Another solution I tried was to add to the peer some additional info and put
> the rhash addition in the peer delete logic by passing the "to-be-added peer" to
> the peer to delete but I notice that it's unreliable since it can happent that
> the new peer hasn't been mapped at the time the peer delete is called.
>
> So this is really how to handle the rhash table in this corner case.
> Considering how peer are handled in theory it should never happen to have
> dangling peer that are not deleted.
>
> Hoping this is not too much of an hack and we find a good solution for this
> problem.

First of all, sorry for the delay. I have my usual excuse, too many
patches :)

I admit that I didn't investigate the patch in detail, but I'm happy to
take this. It seems to pass my simple regression tests without issues.

Any objections? If I don't hear anything I will apply this in the next
few days. Full patch here:

https://patchwork.kernel.org/project/linux-wireless/patch/20220603164559.27769-1-ansuelsmth@gmail.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
