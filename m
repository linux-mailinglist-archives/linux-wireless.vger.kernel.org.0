Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32983260642
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgIGV2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgIGV2Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 17:28:25 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088B9C061755
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 14:28:24 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kFOgW-000IVo-Ak; Mon, 07 Sep 2020 23:28:20 +0200
Message-ID: <c14f8dcbff531588afba09d775491dcbf0d88097.camel@sipsolutions.net>
Subject: Re: alternatives to screenscraping iw?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, od@zcrc.me
Date:   Mon, 07 Sep 2020 23:28:19 +0200
In-Reply-To: <CABPxzYKKayOzCt8VwOuV4uysoMVCZ9Ka01yqJnVZ=nyFHhYjqA@mail.gmail.com> (sfid-20200907_192534_842288_580BA171)
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net>
         <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
         <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com>
         <b7aaab23072e4c06c3cb245a3ea83f11e9ca9e7f.camel@sipsolutions.net>
         <CABPxzYKKayOzCt8VwOuV4uysoMVCZ9Ka01yqJnVZ=nyFHhYjqA@mail.gmail.com>
         (sfid-20200907_192534_842288_580BA171)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-09-07 at 22:55 +0530, Krishna Chaitanya wrote:
> 
> > I wonder if the netlink policy export I wrote for the kernel could be
> > used to generate attribute descriptions? Even if it means just running a
> > tool in a latest kernel VM to do it.
> Can you please point me to it? But yes, auto-generating those should be handy.
> Probably can pick up the header file from sources in kernel.org
> instead of booting
> into a VM (depending on how your tools work)?

No no, I meant at runtime from the *policy* export, not the header file.

See net/netlink/policy.c and this patch in the userland code:

https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=cc889b82412450dec762551ac867bd2896656ddc

johannes

