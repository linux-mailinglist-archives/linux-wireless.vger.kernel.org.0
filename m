Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776D894ED4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbfHSUV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 16:21:59 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47548 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbfHSUV7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 16:21:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hzoA8-00042J-L6; Mon, 19 Aug 2019 22:21:56 +0200
Message-ID: <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Josef Miegl <josef@miegl.cz>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Mon, 19 Aug 2019 22:21:55 +0200
In-Reply-To: <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-08-19 at 13:37 +0200, Josef Miegl wrote:
> On Mon, Aug 19, 2019 at 12:12:43PM +0200, Johannes Berg wrote:
> > Contrary to what Sebastian states, it certainly is possible today,
> > although not through wpa_supplicant's config file, only through the
> > wpa_cli interface, using the VENDOR_ELEM_ADD command. There are various
> > tests showing how to use this.
> 
> Thanks Johannes. I noticed this too and tried adding a config file
> option (OpenWRT doesn't compile wpa_supplicant with wpa_cli). I've added
> sta_vendor_elements option (exactly like ap_vendor_elements). This is
> the code setting vendor_elem:
> 
> +++ b/wpa_supplicant/wpa_supplicant.c
> @@ -5833,6 +5833,16 @@
>         wpas_mbo_update_non_pref_chan(wpa_s, wpa_s->conf->non_pref_chan);
>  #endif /* CONFIG_MBO */
> 
> +       if (wpa_s->conf->sta_vendor_elements) {
> +               if (wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ] == NULL) {
> +                       wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ] = wpa_s->conf->sta_vendor_elements;
> +               } else {
> +                       wpabuf_resize(&wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ], wpabuf_len(wpa_s->conf->sta_vendor_elements));
> +                       wpabuf_put_buf(wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ], wpa_s->conf->sta_vendor_elements);
> +               }
> +       }
> +
>         wpa_supplicant_set_default_scan_ies(wpa_s);
> 
>         return 0;
> 
> 
> But when I actually set sta_vendor_elements to something, all it does is
> failing the 4-way handshake during association. The IE is perfectly
> valid and it works with ap_vendor_elements, no nl80211 malformed IEs
> error either. Am I missing something?

I don't know, try capturing over the air?

Perhaps the vendor IEs added this way are added *first* before all the
RSN IEs, and that's tripping up your AP, and you'd have to add them
*after* the normal elements? Not really sure where/how they're added?

johannes

