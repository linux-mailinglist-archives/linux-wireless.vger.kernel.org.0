Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC611923D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2019 21:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfLJUjE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Dec 2019 15:39:04 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:59909 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfLJUjE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Dec 2019 15:39:04 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id cad8d18c
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=SfgSCbRxN4LIaEzKE3UhrMxc7Sc=; b=IbekMZ
        1TyLpKdP8WWNjJdNJVJt4pLI5evxJaV13Y8WVVkM2H+giBi3U2ZlvplktCEa8D2E
        zLx1/XlYVBQ4mXAgFPW4aPwvWu5bqVLx6SiqKjSkMt5bG+mwOkyI50DjKnTK92gp
        5MfElVjdEvpk+v0uW8c45GyzCgBdKdfrWX93v5GqZlniVh/ohFinvWGr9y0TjSm0
        d7O8KMlHCzi7kApqnCg+lzQkC7ejgm4IRu/IVM/EVmL+TLzrIuKWsGsKbaS2ZBP3
        kB7dM/FOk9o7db8IPeGwrE5pHLj3s2JhV3aKvZvE/MgLZcBXbGz5zbAEUK1GuLD+
        ajJ2MOIQYAM5eoBQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9578157 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO)
        for <linux-wireless@vger.kernel.org>;
        Tue, 10 Dec 2019 19:43:26 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id g18so16702520otj.13
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2019 12:39:01 -0800 (PST)
X-Gm-Message-State: APjAAAWnQWPGlhcrGs215GFTSkBq42WEcy+BbEon4ofKi7GI9ebCU15X
        v5leyoIADQqGaitbDg068M2YYUB3SPkWcaVUXpM=
X-Google-Smtp-Source: APXvYqwAKZZhdxVVXgm+2J6s2YlpIsRHUwJjSKQe4u+i6oluCsQaWlmvHG6X48fYyYJWHhHstZKiMEaOnXjBd4BOO0o=
X-Received: by 2002:a9d:1e88:: with SMTP id n8mr28499290otn.369.1576010340451;
 Tue, 10 Dec 2019 12:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9oykQsOXVeKdhToFjaHfPV6Ms6C450FYjUGh4nrOFBbtw@mail.gmail.com>
 <9e544414b0d0a2fad00628a757460ae2c9535dbe.camel@sipsolutions.net>
In-Reply-To: <9e544414b0d0a2fad00628a757460ae2c9535dbe.camel@sipsolutions.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 10 Dec 2019 21:38:49 +0100
X-Gmail-Original-Message-ID: <CAHmME9otmx-5L=AcgJgbyEtvSs0fw_g4urWpYsZJeE2qinXh+w@mail.gmail.com>
Message-ID: <CAHmME9otmx-5L=AcgJgbyEtvSs0fw_g4urWpYsZJeE2qinXh+w@mail.gmail.com>
Subject: Re: intel ax200 not properly reinitialized on reboot
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Tue, Dec 10, 2019 at 9:34 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> How frequent is this for you? We had a bug report like this on some
> other platform where it happens like ... 2-3% of the time?

It happens 100% of the time that I reboot instead of poweroff+poweron.
> Can you stick this info into a bug at bugzilla.kernel.org and add
> linuxwifi@intel.com to it? Or even add me personally since I've dealt
> with the other report before.

Sure, but I'm unable to change the owner. I filed it as
https://bugzilla.kernel.org/show_bug.cgi?id=205829 if you'd like to
tweak the fields.

Jason
