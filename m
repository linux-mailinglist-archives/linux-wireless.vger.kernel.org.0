Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C79ADAF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 12:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfHWKyt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 06:54:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57186 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfHWKyt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 06:54:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i17DQ-00023m-8j; Fri, 23 Aug 2019 12:54:44 +0200
Message-ID: <a8f0fcfcc9d810aee1df461f051a757703cde2e5.camel@sipsolutions.net>
Subject: Re: Implementing Mikrotik IE
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Josef Miegl <josef@miegl.cz>
Cc:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 23 Aug 2019 12:54:42 +0200
In-Reply-To: <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain>
         <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de>
         <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain>
         <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de>
         <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain>
         <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net>
         <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain>
         <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net>
         <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz>
         <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
         <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
         <5ee160209eb1f9e70f6224c393389266280d7d80.camel@sipsolutions.net>
         (sfid-20190822_090033_537095_4B41631C) <0452a0cbb36bcffa8371a58dfd931864c1f79eef.camel@sipsolutions.net>
         <68A3B9AF-8864-4C0F-A50B-71CCB76AE81D@miegl.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> Works great. Is there a possibility that a toggle for this could be
> accepted upstream? After all, WDS isn't really standardized.

I general, I'd say yes. However!

There's ongoing to work to make EAPOL frames go over nl80211 instead,
see e.g. ieee80211_tx_control_port() in mac80211, and this patch for
hostapd:

https://patchwork.ozlabs.org/patch/1108185/

I'd prefer to have it in this path, by having a flag like the "bool
unencrypted" passed to ieee80211_tx_control_port(), (and replace "bool
unencrypted" by "unsigned int flags"). That way, we don't have to
actually keep any state.

In mac80211, we can pass this down to __ieee80211_subif_start_xmit() and
ieee80211_build_hdr() in the ctrl_flags or something like that. It
doesn't actually need to be a control or info flag, so we could add yet
another argument to save the space, but dunno if that's worth it now.

johannes

