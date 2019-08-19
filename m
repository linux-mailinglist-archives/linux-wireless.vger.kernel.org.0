Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0492A9228D
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 13:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfHSLhT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 07:37:19 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32786 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfHSLhT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 07:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566214636; bh=ghh9g6A4qrVc+U+j0QqnawRUrG/H0fA3kn3AVWTGdws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=fcGNF4Y1kD8PfoeH9kzL7epkTl/4KimTQLSCNEaByidQizrXIdU5Yf2LYCukBG/l2
         4YocG0IShQWt/RsM7okMQqggKypN0YAcpzIaqFcxbYC1oT6RQeDVkMf+h/CLQ/bnW2
         zlVXYP6uBSP8DM4h63rMuAqazp+klkGc4/LdDKz/zUjzGsymgkeW0ze/okVCaMrfqW
         ynMWApbzGZ1sb7fSp3GxZv3ykQBfnkNkdWdl0NwV2LBngs8O3pOQIwRDogVU84zKLF
         Ivf6FcVKszCmrITsQNgDb4+cmxyyq/UfEDA6m7QOpNbvl++p8tPfAhTjkl+2fHqaUR
         tK87pX/bodg1A==
Date:   Mon, 19 Aug 2019 13:37:07 +0200
From:   Josef Miegl <josef@miegl.cz>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Implementing Mikrotik IE
Message-ID: <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
 <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
 <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
 <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
 <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
 <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
User-Agent: NeoMutt/20180716
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Aug 19, 2019 at 12:12:43PM +0200, Johannes Berg wrote:
> Contrary to what Sebastian states, it certainly is possible today,
> although not through wpa_supplicant's config file, only through the
> wpa_cli interface, using the VENDOR_ELEM_ADD command. There are various
> tests showing how to use this.

Thanks Johannes. I noticed this too and tried adding a config file
option (OpenWRT doesn't compile wpa_supplicant with wpa_cli). I've added
sta_vendor_elements option (exactly like ap_vendor_elements). This is
the code setting vendor_elem:

+++ b/wpa_supplicant/wpa_supplicant.c
@@ -5833,6 +5833,16 @@
        wpas_mbo_update_non_pref_chan(wpa_s, wpa_s->conf->non_pref_chan);
 #endif /* CONFIG_MBO */

+       if (wpa_s->conf->sta_vendor_elements) {
+               if (wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ] == NULL) {
+                       wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ] = wpa_s->conf->sta_vendor_elements;
+               } else {
+                       wpabuf_resize(&wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ], wpabuf_len(wpa_s->conf->sta_vendor_elements));
+                       wpabuf_put_buf(wpa_s->vendor_elem[VENDOR_ELEM_ASSOC_REQ], wpa_s->conf->sta_vendor_elements);
+               }
+       }
+
        wpa_supplicant_set_default_scan_ies(wpa_s);

        return 0;


But when I actually set sta_vendor_elements to something, all it does is
failing the 4-way handshake during association. The IE is perfectly
valid and it works with ap_vendor_elements, no nl80211 malformed IEs
error either. Am I missing something?

Josef

