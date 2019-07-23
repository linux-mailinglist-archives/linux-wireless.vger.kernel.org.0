Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C697471104
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 07:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfGWFL5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 01:11:57 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47000 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfGWFL5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 01:11:57 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hpn5e-0006Pe-23; Tue, 23 Jul 2019 07:11:54 +0200
Message-ID: <eddd4cdb148e0dc64326c1c9f2b257413b6131ae.camel@sipsolutions.net>
Subject: Re: TI wlcore wifi not loading w/ v5.3-rc1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Stultz <john.stultz@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 23 Jul 2019 07:11:53 +0200
In-Reply-To: <CALAqxLXrB0YvdK=MgbbF94QcQwqPV-FvHtm=uOVURuphFx=OfA@mail.gmail.com>
References: <CALAqxLXrB0YvdK=MgbbF94QcQwqPV-FvHtm=uOVURuphFx=OfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-07-22 at 22:20 +0000, John Stultz wrote:
> Hey folks,
> 
> Testing on my HiKey960, I'm seeing:
> [    8.894909] wlcore: wl18xx HW: 183x or 180x, PG 2.2 (ROM 0x11)
> [    8.902017] ------------[ cut here ]------------
> [    8.906832] WARNING: CPU: 0 PID: 5 at net/wireless/core.c:868
> wiphy_register+0x8b4/0xc08
[...]
> It seems like from the commit message, the wlcore driver isn't
> providing the policy values the network core expects? I'm not sure
> what the right fix would be, but wanted to raise the issue.

There's a fix on the way, unfortunately I forgot to send the pull
request before the merge window. I sent it out a couple of days ago and
narrowly missed -rc1, but it'll be in rc2:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=91046d6364afde646734c7ead1f649d253c386e9
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1667e4f9bcfb6785362a300ac4486df0854a72aa

johannes

