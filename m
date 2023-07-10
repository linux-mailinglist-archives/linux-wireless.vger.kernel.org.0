Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CCA74DB7B
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jul 2023 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjGJQub (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jul 2023 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGJQua (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jul 2023 12:50:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AFE3
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 09:50:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc0609cd6so47910175e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jul 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689007827; x=1691599827;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MY+TyIudZCiZOFG2r90LBXniZOQ3ZD0PRf6V3zd0L3w=;
        b=oegLEW/xnJMUooitotWowEO74EBik6GwF+HLHwDCrnMlR+j5+9jY2gMnvdZKoVdZGF
         8djoLzQiXaBgDRoyHz1Jkb3ZqaAGT/QqmwynW4NLrVHYu2V/YXCX89S3Ir9fNRhcnGQf
         3MvzREBAx1JVaMeEQfRhnEqmg9PnZYbvObUrnJ5Gd5FyYiI6WGDc9PAhKSsphOA0MtCz
         y8TNYqCkC3EouWJyIAZx6ZGv7AyAnEd6SrZWnNAF6CeeulkQfzNS6oJMGeEXnm95s/2e
         vwVJceOx+VFFJYFEC+FeG2ykGcVnxiGhKuEZpU7od3TEkD9aGxX0gWZvVR/Ftw7wv6QC
         jD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007827; x=1691599827;
        h=in-reply-to:references:message-id:to:from:subject:cc:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MY+TyIudZCiZOFG2r90LBXniZOQ3ZD0PRf6V3zd0L3w=;
        b=MolJ0IrUz761TPG1OvZkWqM/CaQMsQEYHGz8XeyZsbnHs3P7p6k8b1LmgR9+OwS60R
         uOOKuMtZhiROQOiaTTSqxjgK1mDkDFswcJgTshPjIDDzc01nsyJW9ovBYzB3s4idhXHE
         J+gYHOzAJzuB8A7IG+wtnSTcxIjCb+KvGQSJOsPHnXFWtF8iQkF2jeJbus8YVX7/fIaz
         pPL1VNKPkcsTIzcDj1NrX3bdyG6L6GEWvPiJhxrVXFebzLK451by0FhiLL8LI7P7kDws
         xAUM6tOgT8ynCfUwHFgGCzyrsCrcwtKKRfutvJwXtGoee+Vu7aZl3OeBAFEnvFvyGoFY
         Lc9Q==
X-Gm-Message-State: ABy/qLa4t4YEHN/RFR8d/L7Wxv/B2zUGsrlOS/cntTzq22U5bdVCsOwE
        CukDi1YejR549t0jhDFmpwY=
X-Google-Smtp-Source: APBJJlFvJ9ZgWVMBwCn8tDFQxqtyaoU25Y933RNpn39LVgvBeuom2J6oL4/Sy+hoLffrelj7Nl0yfw==
X-Received: by 2002:a7b:c389:0:b0:3fc:9e:eead with SMTP id s9-20020a7bc389000000b003fc009eeeadmr8389566wmj.20.1689007827077;
        Mon, 10 Jul 2023 09:50:27 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00314367cf43asm12191950wrm.106.2023.07.10.09.50.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 09:50:26 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 10 Jul 2023 18:50:26 +0200
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>, <nbd@nbd.name>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Johannes Berg" <johannes.berg@intel.com>
Message-Id: <CTYNAK10A6AJ.1I4W9V78VG1NB@syracuse>
X-Mailer: aerc 0.15.1
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
 <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
 <809500b6-4eec-7a5e-5930-00e7eeebcc5e@leemhuis.info>
In-Reply-To: <809500b6-4eec-7a5e-5930-00e7eeebcc5e@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon Jul 10, 2023 at 1:32 PM CEST, Linux regression tracking (Thorsten Le=
emhuis) wrote:
> On 16.06.23 09:45, Nicolas Escande wrote:
> > On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thorste=
n Leemhuis) wrote:
> >> On 10.06.23 08:44, Bagas Sanjaya wrote:
> >>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
> >>>>
> >>>> As user of the mesh part of mac80211 on multiple products at work le=
t me say
> >>>> thank you for all the work you do on wifi, especially on 80211s, and=
 especially
> >>>> the recent improvements you made for mesh fast RX/TX & cross vendor =
AMSDU compat
> >>>>
> >>>> We upgraded our kernel from an older (5.15) to a newer 6.4. The prob=
lem is STP=20
> >>>> doesn't work anymore and alas we use it for now (for the better or w=
orse).
> >>>>
> >>>> What I gathered so far from my setup:
> >>>>  - we use ath9k & ath10k
> >>>>  - in my case STP frames are received as regular packet and not as a=
msdu
> >>>>  - the received packets have a wrong length of 44 in tcpdump
> >>>>    (instead of 38 with our previous kernel)
> >>>>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes pac=
ket
> >>>>    this makes llc_rcv() discard the frames & breaks STP
> >>>>
> >>>> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a844=
e65c8bf9ede7
> >>>> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
> >>>>
> >>>> I guess that your changes to handle both ampdu subframes & normal fr=
ames in the
> >>>> same datapath ends up putting a wrong skb->len for STP (multicast) f=
rames ?
> >>>> Honestly I don't understand enough of the 80211 internals & spec to =
pinpoint the
> >>>> exact problem.
> >>>>
> >>>> It seems this change was already in the 6.3 kernel so I guess someon=
e should
> >>>> have seen it before (but I didn't find anything..) ? Maybe I missed =
something...
> >>>>
> >>>> Anyway I'm happy to provide more info or try anything you throw at m=
e.
> >> [...]
> >> Hmmm, Felix did not reply. But let's ignore that for now.
> >=20
> > I haven't seen mails from felix on the list for a few days, I'm guessin=
g he's
> > unavailable for now but I'll hapilly wait.
>
> Still no progress. Hmmm. Are you still okay with that? I've seen no
> other reports about this, so waiting is somewhat (albeit not completely)
> fine for me if it is for you.
I'm not so surprised no one else reported it, using STP on wifi (and 802.11=
s) is
not a really common thing to do, to be honest (and STP on wifi is unreliabl=
e).
Even though some openwrt guys do it for sure, I'm guessing their kernel ver=
sion
is lagging behind...
>
> But in any case it might be good if you could recheck 6.5-rc1.
Testing on 6.5 as a whole won't be as easy for me as testing a single patch=
 on
top of 6.4. I'll do my best to try but from what I saw nothing got merged t=
hat
would even remotely help me on this issue.=20

I am not loosing hope that Felix or someone that understands this stuff bet=
ter
finds the time to look into this. I'm guessing it's the summer vacation eff=
et.

>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
