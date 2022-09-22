Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E215E6ABE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiIVSXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiIVSXQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 14:23:16 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552A310C78E
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 11:22:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so10846647wrm.7
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date;
        bh=dd5iqfUUMeDNG/DpeL/hvwwpZU7YKbDQxVhz8reuZUY=;
        b=g4/i4b46qNhFmnhpHh+N2eO3Byqo7UjvmCSRxjMiFlYN+kxVxL5hv+DhKCyhcwzCAQ
         IE+ikCZQHojmazj+DmSj0ilhZdLIkjj0peIMCAqG13Gwa0tPMAYzk3zNxvkw1IiW/aTR
         fi4HaUBRklwrbTFjixqMwM4IFb9bc8iJ/kovP0CT6c2YYQ57QfVP4phxyHNLU0Ttpy3o
         709AC3GPm1FMcz4Ruy+l5Ue3+jlh9QXny1mUBUSaR4iqnUzM4JF0ggbiHlaIHLW84+ad
         9SyWR6Dl+nL6OiUpUZSjSSzp/UujaY0qYrteCo8fDexV76pkAvXROcbv1/OZfyx7VPny
         ofuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=dd5iqfUUMeDNG/DpeL/hvwwpZU7YKbDQxVhz8reuZUY=;
        b=L/rMI2O4Y/1Q0M/Xjpb41rDBcDS6y5XvUTjlqHCMAzuT5p2dNpKSyOc/5j+zx9g6e8
         NA3Vs0kQXCT93r+CkxhDdhZqgItJMm6m/W///qqfDsTK0F3+IIxuFI/fUWSAWMIEn5Qi
         B1Rux9q1rulHHQQXdDgOaM3hBVyW3JVCni96UXThbKul+dNuiYBiO3wiGXGqTqEZERZN
         68SnL7Skj9cSajwVWndfde8Y2ZN2SuJIql0G6hG72UchRJ0Vsvt5aVPd3qcvfQn6jcBQ
         aKd02+DoFcogVi4jttaA10/LiclWhxKLbuZXLP0ou60gYgmwDWS+rIH1Yb4QsBipyQyq
         YddA==
X-Gm-Message-State: ACrzQf1NpLspT0Jpc3wdYNkVKb0ttnT0YO5+UdED9UGEE5soouakZ7sD
        QxzLuDpJxgFxWXyirppAa4AoR7U+L84=
X-Google-Smtp-Source: AMsMyM7RsDR3g/7vP9U9IDgqiMpPaRV3JX3vPlINzt3fEE1O5QXFJtKcOjEgXmnQNSaD2bkFEqQ4FQ==
X-Received: by 2002:a05:6000:681:b0:22a:3007:df45 with SMTP id bo1-20020a056000068100b0022a3007df45mr2785136wrb.149.1663870919453;
        Thu, 22 Sep 2022 11:21:59 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-134.ip85.fastwebnet.it. [93.42.70.134])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c1d8800b003a342933727sm328172wms.3.2022.09.22.11.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:21:58 -0700 (PDT)
Message-ID: <632ca7c6.050a0220.86f56.12f2@mx.google.com>
X-Google-Original-Message-ID: <YyynxVJF0TixUOt2@Ansuel-xps.>
Date:   Thu, 22 Sep 2022 20:21:57 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [RFC PATCH] ath11k: fix peer addition/deletion error on sta band
 migration
References: <20220603164559.27769-1-ansuelsmth@gmail.com>
 <87pmfn4xpp.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmfn4xpp.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Sep 22, 2022 at 11:31:14AM +0300, Kalle Valo wrote:
> Christian 'Ansuel' Marangi <ansuelsmth@gmail.com> writes:
> 
> > This patch try to fix the following error.
> >
> > Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561227] ath11k c000000.wifi: peer already added vdev id 0 req, vdev id 1 present
> > Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.561282] ath11k c000000.wifi: Failed to add peer: 28:c2:1f:xx:xx:xx for VDEV: 0
> > Wed Jun  1 22:19:30 2022 kern.warn kernel: [  119.568053] ath11k c000000.wifi: Failed to add station: 28:c2:1f:xx:xx:xx for VDEV: 0
> > Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: Could not add STA to kernel driver
> > Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan2: STA 28:c2:1f:xx:xx:xx IEEE 802.11: did not acknowledge authentication response
> > Wed Jun  1 22:19:31 2022 daemon.notice hostapd: wlan1: AP-STA-DISCONNECTED 28:c2:1f:xx:xx:xx
> > Wed Jun  1 22:19:31 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: disassociated due to inactivity
> > Wed Jun  1 22:19:32 2022 daemon.info hostapd: wlan1: STA 28:c2:1f:xx:xx:xx IEEE 802.11: deauthenticated due to inactivity (timer DEAUTH/REMOVE)
> >
> > To repro this:
> > - Have 2 Wifi with the same bssid and pass on different band (2.4 and
> > 5GHz)
> > - Enable 802.11r Fast Transaction with same mobility domain
> > - FT Protocol: FT over the Air
> >>From a openwrt system issue the command (with the correct mac)
> > ubus call hostapd.wlan1 wnm_disassoc_imminent '{"addr":"28:C2:1F:xx:xx:xx"}'
> > Notice the log printing the errors.
> >
> > The cause of this error has been investigated and we found that this is
> > related to the WiFi Fast Transaction feature. We observed that this is
> > triggered when the router tells the device to change band. In this case
> > the device first auth to the other band and then the disconnect path
> > from the prev band is triggered.
> > This is problematic with the current rhash implementation since the
> > addrs is used as key and the logic of "adding first, delete later"
> > conflicts with the rhash logic.
> > In fact peer addition will fail since the peer is already added and with
> > that fixed a peer deletion will cause unitended effect by removing the
> > peer just added.
> >
> > Current solution to this is to add additional logic to the peer delete,
> > make sure we are deleting the correct peer taken from the rhash
> > table (and fallback to the peer list) and for the peer add logic delete
> > the peer entry for the rhash list before adding the new one (counting as
> > an error only when a peer with the same vlan_id is asked to be added).
> >
> > With this change, a sta can correctly transition from 2.4GHz and 5GHZ
> > with no drop and no error are printed.
> >
> > Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> >
> > Fixes: 7b0c70d92a43 ("ath11k: Add peer rhash table support")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >
> > Some additional comments external to this patch.
> > I tried to find different way to fix this...
> > One of them would be mod the logic of the rhash and using as a key both
> > the vlan_id and the addr but this is problematic for the function
> > where ath11k_peer_find_by_addr is used as vlan_id is not always available.
> >
> > I honestly think a correct solution would be have a rhash list per vdev_id
> > or per mac_id but again this is problematic for some function that just handles
> > data and have only the addr as a way to identify the peer.
> >
> > So unless some change are done to the firmware to provide the vlan_id in the
> > msdu data this to me seems to be the only solution to correctly handle this case.
> >
> > Another solution I tried was to add to the peer some additional info and put
> > the rhash addition in the peer delete logic by passing the "to-be-added peer" to
> > the peer to delete but I notice that it's unreliable since it can happent that
> > the new peer hasn't been mapped at the time the peer delete is called.
> >
> > So this is really how to handle the rhash table in this corner case.
> > Considering how peer are handled in theory it should never happen to have
> > dangling peer that are not deleted.
> >
> > Hoping this is not too much of an hack and we find a good solution for this
> > problem.
> 
> First of all, sorry for the delay. I have my usual excuse, too many
> patches :)
> 
> I admit that I didn't investigate the patch in detail, but I'm happy to
> take this. It seems to pass my simple regression tests without issues.
> 
> Any objections? If I don't hear anything I will apply this in the next
> few days. Full patch here:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20220603164559.27769-1-ansuelsmth@gmail.com/
>

Hi,
thanks for checking this. We are using this on ipq807x router from month
on OpenWRT and seems to work very good, as a side result, it seems this
also fixed a strange memory leak. (probably related to peer not getting
deleted after some time)


(also since it seems you are full of patch I wonder if you can help with
a very bad problem we are having. With new firmware version, the
firmware crash and this is related 99% to a regression in new firmware
related to missing data in the BDF. Some OEM won't ever update the BDF
so without an help from the firmware these devices are stuck to an
acient and malfunctioning firmware. Sorry for OT but we notice you put
2.7.0.1 on stable and wonder if you could help) (I'm opening a bugzilla
about the problem with the firmware dump)

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

-- 
	Ansuel
