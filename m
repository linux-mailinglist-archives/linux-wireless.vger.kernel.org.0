Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD44AB6C2
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 09:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbiBGIYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 03:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245144AbiBGIQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 03:16:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB81C043181
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 00:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3FA3B8100C
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 08:16:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712D0C004E1;
        Mon,  7 Feb 2022 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644221792;
        bh=DZ/TevRXLvlgnq8pTj8RvXZLEkw9dYEGoSpuP91BtvY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=hO+FpKnxNpsO/202oyRtbi2eSuEyugKLQOOd/r8qIUzk4Kz8UqeEmtw3e0TfrcySn
         dSC0L4ChT1G05WTcp9jWph90esxj7y33G4YWxFhPs47KfjG13L5cA2V6Pk+KZwLUiT
         URyhlRyzw5mZf0YuMKAL0RYtinHRz34ax92OL8elFpkGN9RtS/98BvukR0S6XKu0j5
         nRRDVUoM48FLgtfeY1tccmARNwzbhLm1dK5qOSvEAJxuYCOxCSQUzTfFc5+K3ysjsO
         BYmYAsRAgCSh5EVFP/kFtOsSF8xdilfz1JwWr6Kdu5DvZoPACuvhC7b3Zo+QINQ6OG
         1Ha0zB+MMTmDw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     toke@toke.dk, ath9k-devel@qca.qualcomm.com, kuba@kernel.org,
        linville@tuxdriver.com, Sujith.Manoharan@atheros.com,
        syzbot+03110230a11411024147@syzkaller.appspotmail.com,
        syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ath9k: fix use-after-free in ath9k_hif_usb_rx_cb
References: <a8a08675b60b5bfabf4a19a35c590612577c5ec0.1644065933.git.paskripkin@gmail.com>
Date:   Mon, 07 Feb 2022 10:16:26 +0200
In-Reply-To: <a8a08675b60b5bfabf4a19a35c590612577c5ec0.1644065933.git.paskripkin@gmail.com>
        (Pavel Skripkin's message of "Sat, 5 Feb 2022 16:09:15 +0300")
Message-ID: <87sfsvay79.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pavel Skripkin <paskripkin@gmail.com> writes:

> Syzbot reported use-after-free Read in ath9k_hif_usb_rx_cb(). The
> problem was in incorrect htc_handle->drv_priv initialization.
>
> Probable call trace which can trigger use-after-free:
>
> ath9k_htc_probe_device()
>   /* htc_handle->drv_priv = priv; */
>   ath9k_htc_wait_for_target()      <--- Failed
>   ieee80211_free_hw()		   <--- priv pointer is freed
>
> <IRQ>
> ...
> ath9k_hif_usb_rx_cb()
>   ath9k_hif_usb_rx_stream()
>    RX_STAT_INC()		<--- htc_handle->drv_priv access
>
> In order to not add fancy protection for drv_priv we can move
> htc_handle->drv_priv initialization at the end of the
> ath9k_htc_probe_device() and add helper macro to make
> all *_STAT_* macros NULL save.
>
> Fixes: fb9987d0f748 ("ath9k_htc: Support for AR9271 chipset.")
> Reported-and-tested-by: syzbot+03110230a11411024147@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+c6dde1f690b60e0b9fbe@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>
> Changes from v1:
> 	- Removed clean-ups and moved them to 2/2

You forgot to CC linux-wireless so patchwork won't see it. Please submit
v3 and include linux-wireless.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
