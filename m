Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD7C30AB96
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBAPif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 10:38:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhBAPi2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 10:38:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83A7A64DAE;
        Mon,  1 Feb 2021 15:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612193868;
        bh=7B6Y/oTraOd+LXWxm/xEQcNmH/vDFm/JNNWxhZ3zBQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2K6k0D7Rn2QRHJoNqKUO7xZKZyHRb54YEBPd5IEiubLvHhJ4Ayq8oWWrXYWa7nhB
         8RT+a3wszelF6x5bSD7OGb9zSljnGoEjOy2FiSyzp6iiqRl6bcA42Jh30LvQvlLqJV
         QFD83nSjsPlLE+bvoZaVjFcrUTttJy1YbK1RjodU=
Date:   Mon, 1 Feb 2021 16:37:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after
 reading the regulatory settings from the chip
Message-ID: <YBggSQVXlmEhs1v2@kroah.com>
References: <20210201152956.370186-1-hdegoede@redhat.com>
 <20210201152956.370186-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201152956.370186-2-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Feb 01, 2021 at 04:29:56PM +0100, Hans de Goede wrote:
> Commit 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API
> misuse") moved the wiphy_apply_custom_regulatory() call to earlier in the
> driver's init-sequence, so that it gets called before wiphy_register().
> 
> But at this point in time the eFuses which code the regulatory-settings
> for the chip have not been read by the driver yet, causing
> _rtw_reg_apply_flags() to set the IEEE80211_CHAN_DISABLED flag on *all*
> channels.
> 
> On the device where I initially tested the fix, a Jumper EZpad 7 tablet,
> this does not cause any problems because shortly after init the
> rtw_reg_notifier() gets called fixing things up. I guess this happens
> into response to receiving a (broadcast) packet with regulatory info
> from the access-point ?
> 
> But on another device with a RTL8723BS wifi chip, an Acer Switch 10E
> (SW3-016), the rtw_reg_notifier() never gets called. I assume that some
> fuse has been set on this device to ignore regulatory info received from
> access-points.
> 
> This means that on the Acer the driver is stuck in a state with all
> channels disabled, leading to non working Wifi.
> 
> We cannot move the wiphy_apply_custom_regulatory() call back, because
> that call must be made before the wiphy_register() call.
> 
> Instead move the entire rtw_wdev_alloc() call to after the Efuses have
> been read, fixing all channels being disabled in the initial channel-map.
> 
> Fixes: 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API misuse")
> Cc: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

As the problem-fix came from Johannes's tree, I have no problem with
this fix going in through that as well:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
