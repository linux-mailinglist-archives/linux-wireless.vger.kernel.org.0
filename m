Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8325178524
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2020 22:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCCV74 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Mar 2020 16:59:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40992 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCV74 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Mar 2020 16:59:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id l21so4115835qtr.8
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2020 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t123XzMsEm+0b7H8wFNzgxP91M0oLGzXg7iOl7TF8VQ=;
        b=gn2mIFxU+oImrccEh1wL+jfn1Qr2NUwNvPyigce9pzAJKRfZwIeDmy0dr364f3WgCY
         EPajGEzBu1P2a/7PWvzzF3vL2HgzEMyaN0azhIKtkDuUw3nakln1P4nxzFRHPLWrm8R2
         VgsyV2GozidcfM7awlGoorN1X5bwKuxflitaS+vT8tizPdcoff3QttJ/TloTWEzjHOSw
         Q/EsE26qE8nLsno3FuugaoMJLM310QITUt1oyXhCAnoS99/EDJPIVL2F1LldZs/QH5Zj
         woaq8o+qpDj5m/9QgvgkYdfK0Kp+/3PbLTC0Q89Dzh7UmZmTLjuRcmfPzddKvd3aFIbo
         +23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t123XzMsEm+0b7H8wFNzgxP91M0oLGzXg7iOl7TF8VQ=;
        b=Oh2Svcmll1mZ4kkpE3JUR7q8wlQilqGB02k7IDOZJLFYVGnKXSXZFIAqZxlyLB908D
         xtNa9g4Ks6TgpbX3xNFDvtSn4XBfbF4ffovKHQgUUEpGHS6E32E25tRU0UDjYlNiukaA
         T4xYUDzzU/YXykJDgsu2bIIs+JF9Ta4geXWMgqRrHmva6VZiEGukl1F0oGo4PFi1Nxbq
         /ggxZAQTP1O6I7SyehXfJiCVaqdwv7D78TxgKWWokh/Ea9pvgWogg1XTZYEoSv020KB6
         GMnXDI+LOsbxWZ5biIWAeOdsQktTXNMgTZZy5DQcXgzdp+A1vp8HL7Fb99zSalkCHRtK
         yBBA==
X-Gm-Message-State: ANhLgQ1qJPdTTbQjtv9Hogs7Ifur5Kq+LhU071mH2n6nKqmpKG2ha1Qp
        BBXFUSeqTaauxb1QTywy6b6LdAmYKjs5jrqwWM0=
X-Google-Smtp-Source: ADFU+vumUkVmmE5Wdow1pUqWh/T0kMOaDB/9HWtwU/iYVjMwOVc2cq9XyASHB5fBxWTi0orcQjDMabZ7almNicEzTE0=
X-Received: by 2002:ac8:3719:: with SMTP id o25mr6512728qtb.7.1583272793643;
 Tue, 03 Mar 2020 13:59:53 -0800 (PST)
MIME-Version: 1.0
References: <20200303115017.9845-1-markus.theil@tu-ilmenau.de> <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
In-Reply-To: <8445336f5d71533acf17b6c53fcc88e7faeab3bf.camel@sipsolutions.net>
From:   Steve deRosier <derosier@gmail.com>
Date:   Tue, 3 Mar 2020 13:59:11 -0800
Message-ID: <CALLGbRKPCSZW8PFQXat+_=+iD_ED81j16vNtTbF=KW-B-tTWPQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] nl80211: add monitor mode scan feature
To:     Johannes Berg <johannes@sipsolutions.net>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>, nbd@nbd.name,
        lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Mar 3, 2020 at 1:28 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-03-03 at 12:50 +0100, Markus Theil wrote:
> > Back in 2007 "mac80211: don't allow scanning in monitor mode"
> > (f27b62d3e7ec) disabled scanning in monitor mode, because hw
> > controlled by the zd1211rw driver got confused during this operation.
> >
> > Nevertheless, it can be useful to scan in monitor mode, e.g.
> > when building a tool which processes scans, channel surveys and
> > monitors the channel passively in monitor mode.
>
> Hmm. I'm not really sure that this makes sense.
>
> You're in monitor mode, so you won't get any scan processing as such
> (you will not be able to use nl80211 to retrieve the results!), and
> there will be a lot of confusion over sending probe requests (the code
> now looks like it would in fact attempt to do so ... but how?).
>

Additionally, I don't see what this solves for sure.  At least on an
ath10k device I've been using, I can have two interfaces on one phy
(phy0), wlan0 and mon0, and I can issue a `iw wlan0 scan` and it works
famously and then capture fine on mon0. Granted, I haven't tried doing
a scan while at the same time am actively capturing, but I wonder of
the meaning of that anyway as the capturing radio would have to then
go off channel and issue probe requests etc., sort of screwing up my
capture for that time period.  But anyway, can you not do this on your
radio?

- Steve
