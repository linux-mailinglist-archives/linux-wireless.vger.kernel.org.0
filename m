Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16DB25FAD7
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgIGM6P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729318AbgIGM5u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 08:57:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399AEC061756
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 05:57:50 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kFGiP-00HPTA-7K; Mon, 07 Sep 2020 14:57:45 +0200
Message-ID: <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
Subject: Re: alternatives to screenscraping iw?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-wireless@vger.kernel.org, od@zcrc.me
Date:   Mon, 07 Sep 2020 14:57:44 +0200
In-Reply-To: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net>
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> We're trying to move away from ifconfig/iwconfig and switch to use 
> ip/iw on our embedded systems. It works good, but we can't really adapt 
> our current tools (mostly Python wrappers). iw -h specially says not to 
> screenscrape, but we don't really have an alternative, do we?

Yeah, we _have_ changed the output format sometimes ... I suppose the
only reason iwconfig hasn't is that it's not been changed in 15 years or
so ;-)

There is a pynl80211 library, but it's not complete and maintained. If
you only need some bits though it might be worthwhile to just do that
internally. Python has supported netlink sockets for some time, IIRC.

> Would it be possible to split iw into a shared library + binary? Then 
> it'd be at least possible to create wrappers. Another idea would be to 
> have a mode for iw to output json, like 'ip' does.

I actually played with this at some point, but then wanted to sort of
use json internally so it's not maintained separately and we go through
that ... but the message structure and our intermediate printing makes
that actually quite difficult.

johannes

