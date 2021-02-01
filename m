Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF3530AF3C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 19:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBAS2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 13:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhBAS1i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 13:27:38 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38469C06174A
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 10:26:58 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l6duY-00EWve-Dv; Mon, 01 Feb 2021 19:26:54 +0100
Message-ID: <3b081883581161ba3c3dc91956790799e0694c1e.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after
 reading the regulatory settings from the chip
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-wireless@vger.kernel.org
Date:   Mon, 01 Feb 2021 19:26:39 +0100
In-Reply-To: <YBggSQVXlmEhs1v2@kroah.com> (sfid-20210201_164004_722660_B860788A)
References: <20210201152956.370186-1-hdegoede@redhat.com>
         <20210201152956.370186-2-hdegoede@redhat.com> <YBggSQVXlmEhs1v2@kroah.com>
         (sfid-20210201_164004_722660_B860788A)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2021-02-01 at 16:37 +0100, Greg Kroah-Hartman wrote:
> On Mon, Feb 01, 2021 at 04:29:56PM +0100, Hans de Goede wrote:
> > Commit 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API
> > misuse") moved the wiphy_apply_custom_regulatory() call to earlier in the
> > driver's init-sequence, so that it gets called before wiphy_register().
> > 
> > But at this point in time the eFuses which code the regulatory-settings
> > for the chip have not been read by the driver yet, causing
> > _rtw_reg_apply_flags() to set the IEEE80211_CHAN_DISABLED flag on *all*
> > channels.
> > 
> > On the device where I initially tested the fix, a Jumper EZpad 7 tablet,
> > this does not cause any problems because shortly after init the
> > rtw_reg_notifier() gets called fixing things up. I guess this happens
> > into response to receiving a (broadcast) packet with regulatory info
> > from the access-point ?
> > 
> > But on another device with a RTL8723BS wifi chip, an Acer Switch 10E
> > (SW3-016), the rtw_reg_notifier() never gets called. I assume that some
> > fuse has been set on this device to ignore regulatory info received from
> > access-points.
> > 
> > This means that on the Acer the driver is stuck in a state with all
> > channels disabled, leading to non working Wifi.
> > 
> > We cannot move the wiphy_apply_custom_regulatory() call back, because
> > that call must be made before the wiphy_register() call.
> > 
> > Instead move the entire rtw_wdev_alloc() call to after the Efuses have
> > been read, fixing all channels being disabled in the initial channel-map.
> > 
> > Fixes: 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API misuse")
> > Cc: Johannes Berg <johannes.berg@intel.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> As the problem-fix came from Johannes's tree, I have no problem with
> this fix going in through that as well:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So we'll have problem-fix-fix ;-)

Sounds good to me, I'll pick it up.

Thanks!

johannes

