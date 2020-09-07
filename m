Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F31F25FEC3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 18:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbgIGQXW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 12:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730446AbgIGQW6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 12:22:58 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DA4C061573
        for <linux-wireless@vger.kernel.org>; Mon,  7 Sep 2020 09:22:58 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id p81so3715853ybc.12
        for <linux-wireless@vger.kernel.org>; Mon, 07 Sep 2020 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ti7EnvlTzPxqMThJm4XSezRrmKCpe+L78pN2RtnBhWo=;
        b=LFRkSb4P3w1e7+xaYMtIKbsm08M/JCG/r9IPPUcn6FQXrSXsqkOaxJYlGQ7vg9IiI1
         uONUQntI4RJBTgwQT/798z4mRM51X4bpHcFyXzl1NfDRZARMPv/bU7vBdLTRnzD0Y/Gc
         LcYYlh7QXiSSPZ4iC6G/yT+Kt0/OCjMV+MnINbMnXt/aZbYtCJbPFTMsWK60QmUyCKPC
         L/Hf0P15MxEH+V6YjHzxd5Y4RkCEFP+/zDbwVWW9Ab0CP5xhrgc/rXT9RESF6B7lpoQ1
         3pOJliCY7Mctcq87HcP+4frplrzKX+f65TGxBu0jddJEmBmFfaMYYU3BxpeWdzQLqSRD
         6Gxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ti7EnvlTzPxqMThJm4XSezRrmKCpe+L78pN2RtnBhWo=;
        b=OxBeu0dsUxDWGaDGsr/ABpLJfWRR6bqyulQ5swgQLx2/cw3iESWkBGM6JT7hHuu0Ca
         AVqXeddhzzPoD88GQgZIGe2uq4F/Sv+QPVnS7E+BTxn7yJe4EVp0//XV72oVEA9oAcKE
         nNpI2BKGRTJMzG6HOTunZCOJLrs6JLaEDymBKZnuXB89FaZ2HQ3orOJtPsvdS2GmzWe2
         VRUrcKvu4P+OI4eykuxfQzr7eOn76JVCSMxjIK4hELO+iMueMZjqF1mcqUr+d5yi/NEs
         d4rOz8PC3NHVfXYtl39ggys6iJLYi7SUCrijqFJiarCzFQ/SnlQrccBqKALDcwclIoYL
         V0/A==
X-Gm-Message-State: AOAM531VaF3ZlW46D+8sKusJNNYGAsA9+bSvy8/cbzisbKV+4a0GMKrs
        kvjR/tXldMj/q602T0Ke60F/+UQP+vBoF7BT3f0=
X-Google-Smtp-Source: ABdhPJxfprQsPNTIOjr/kQiPLRAiqAW4+fSJF+w+0cWKo0U4oO7Av8UMgZEXPJ4PTqYOG5P4G7W8pYudgDoGzD/Hp5U=
X-Received: by 2002:a25:6a41:: with SMTP id f62mr29717596ybc.498.1599495777733;
 Mon, 07 Sep 2020 09:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <04HAGQ.ASDIWY4TQH8H3@crapouillou.net> <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
In-Reply-To: <55e3de67208c2120857102d13a896553fbf223b4.camel@sipsolutions.net>
From:   Krishna Chaitanya <chaitanya.mgit@gmail.com>
Date:   Mon, 7 Sep 2020 21:52:46 +0530
Message-ID: <CABPxzYLAYaXDfEewA5XR+y2Z0N1yLbEQwQM4FNytamHeZt3ySg@mail.gmail.com>
Subject: Re: alternatives to screenscraping iw?
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        linux-wireless <linux-wireless@vger.kernel.org>, od@zcrc.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Sep 7, 2020 at 6:29 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> Hi,
>
> > We're trying to move away from ifconfig/iwconfig and switch to use
> > ip/iw on our embedded systems. It works good, but we can't really adapt
> > our current tools (mostly Python wrappers). iw -h specially says not to
> > screenscrape, but we don't really have an alternative, do we?
>
> Yeah, we _have_ changed the output format sometimes ... I suppose the
> only reason iwconfig hasn't is that it's not been changed in 15 years or
> so ;-)
>
> There is a pynl80211 library, but it's not complete and maintained. If
> you only need some bits though it might be worthwhile to just do that
> internally. Python has supported netlink sockets for some time, IIRC.

FYI, We have open-sourced our internal library which takes care of abstracting
Netlink attributes, just need to define commands and event messages in JSON,
https://github.com/bluwireless/py-genl. The initial port of all
messages might be an
effort but extending it would be easy.
>
> > Would it be possible to split iw into a shared library + binary? Then
> > it'd be at least possible to create wrappers. Another idea would be to
> > have a mode for iw to output json, like 'ip' does.
>
> I actually played with this at some point, but then wanted to sort of
> use json internally so it's not maintained separately and we go through
> that ... but the message structure and our intermediate printing makes
> that actually quite difficult.
>
> johannes
