Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB4F20C9BE
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 21:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgF1TAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 15:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgF1TAD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 15:00:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A2EC03E979
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2020 12:00:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jpcWz-00Dpfo-4x; Sun, 28 Jun 2020 20:59:57 +0200
Message-ID: <a814fe75135815e85a1968cf6a985c604246bcc8.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: keep non-zero sequence counter of injected
 frames
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>,
        linux-wireless@vger.kernel.org
Cc:     mathy.vanhoef@nyu.edu
Date:   Sun, 28 Jun 2020 20:59:56 +0200
In-Reply-To: <20200628220512.28535ebc@mathy-work.localhost>
References: <20200628220512.28535ebc@mathy-work.localhost>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2020-06-28 at 22:05 +0400, Mathy Vanhoef wrote:
> The sequence number of injected frames is being overwritten by the
> function ieee80211_tx_h_sequence when the following two conditions
> are met:
> 
> 1. The frame is injected on a virtual interface, and a second virtual
>    interface on this device is operating in managed/AP/.. mode.
> 
> 2. The sender MAC address of the injected frame matches the MAC
>    address of the second interface operating in managed/AP/.. mode.
> 
> In some cases this may be desired, for instance when hostap is
> configured to send certain frames using a monitor interface, in which
> case the user-space will not assign a sequence number and instead
> injects frames with a sequence number of zero.

Yeah, this is where that used to be used. I'm thinking we should "break"
this stuff eventually, tell people to use modern hostapd versions, and
see who cares ... because all this "cooked monitor" etc. is all quite
ugly.

> However, in case the user-space does assign a non-zero sequence
> number, this number should not be overwritten by the kernel. This
> patch adds a check to see if injected frames have already been assigned
> a non-zero sequence number, and if so, this sequence number will not
> be overwritten by the kernel.

Seems reasonable, but I have to wonder what you're up to now ;-)

Anyway, I'll apply this unless I find some tests fail or something, but
I'll be going on vacation soon, so it'll be a while (since it's for the
-next tree as a feature).

johannes

