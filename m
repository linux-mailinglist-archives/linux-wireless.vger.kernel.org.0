Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A04911924A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 21:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfLJUl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 15:41:57 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53880 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfLJUl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 15:41:57 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iemKR-0021rE-85; Tue, 10 Dec 2019 21:41:55 +0100
Message-ID: <6669cf5dbc4e3d95bc265b82b69e7a4450a616b3.camel@sipsolutions.net>
Subject: Re: intel ax200 not properly reinitialized on reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 10 Dec 2019 21:41:54 +0100
In-Reply-To: <CAHmME9otmx-5L=AcgJgbyEtvSs0fw_g4urWpYsZJeE2qinXh+w@mail.gmail.com>
References: <CAHmME9oykQsOXVeKdhToFjaHfPV6Ms6C450FYjUGh4nrOFBbtw@mail.gmail.com>
         <9e544414b0d0a2fad00628a757460ae2c9535dbe.camel@sipsolutions.net>
         <CAHmME9otmx-5L=AcgJgbyEtvSs0fw_g4urWpYsZJeE2qinXh+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jason,

> > How frequent is this for you? We had a bug report like this on some
> > other platform where it happens like ... 2-3% of the time?
> 
> It happens 100% of the time that I reboot instead of poweroff+poweron.

Oh, wow.

> > Can you stick this info into a bug at bugzilla.kernel.org and add
> > linuxwifi@intel.com to it? Or even add me personally since I've dealt
> > with the other report before.
> 
> Sure, but I'm unable to change the owner. I filed it as
> https://bugzilla.kernel.org/show_bug.cgi?id=205829 if you'd like to
> tweak the fields.

Yep, done, thanks.

I'll check the other bug tomorrow.

johannes

