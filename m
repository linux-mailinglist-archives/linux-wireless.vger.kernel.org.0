Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1D5E124101
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 09:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfLRIF1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 03:05:27 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43607 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRIF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 03:05:27 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so1372029oth.10
        for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2019 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=YPlZOW/aPNkuA3+s2dx+BjJOVi8FoqUpaaFUagdrhDE=;
        b=b9859j71qg4oAqwLoIu5G9uNeNhAfd15vyAmPgnOPXwPik+DxSk7IahVCIXBUfl2SD
         4ww6HHU+HzWZLhyk4PfTMwTrRxjDTrHWq05ZKcrmTATJiJWO6q68hNVgmr8XBXrg7NW0
         OTPY+MjtE6jXS5JgWFewd/iiRxpS4FuhQ6gSjdI3xedS8ydiJJRGGPg8OWTT0wEcipne
         g23bvUBk5jzJUTuGxIS/sUiHqokVpCT1Rz/jBeDQOCl6PTcOHscx5W2fJAYQ4eiqIVdB
         b2PQaWMr5ryacAIJlMuB29nVAi9ANETcZP48VOBeN3m0F4wHJ0OvhCz2koEivS4+U7Ow
         RgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=YPlZOW/aPNkuA3+s2dx+BjJOVi8FoqUpaaFUagdrhDE=;
        b=eXWX6LJNFGzQXNulLTXyCOvEyKLaKL4qdUj2RGSFDM+eCKyB1CZMXMJ5+VlKh0TdSF
         ctOAdcKOuQPt16J4VTTImSMW3ALUb12ATr7ybNtdoo/gBoZWhXkv4HMRR/Rua3ED8amA
         AEENMBPBcwIeJTk22egDxxGhSlwE8NnQFyUSAf6Kn7i0t77MNKquFQGK/+ZfA2pRrhQx
         3XG9akxYRk5IBsgWJ9rSroagHh+1HsCX8zIh5h5I7Wa1z4rdaTt36vBifH8dnRh9fnmn
         rulT9iXP9jEpuN1MuvJq/JHIx+pFG3ZCScVxn1vnLFyg31sm0kXPu2HE7PWO98fqC6FU
         41kw==
X-Gm-Message-State: APjAAAXWwk2Mvptry5ygtDtKSKhdGFX/WasGD6vsaf/nzLXnQEWbIRCt
        hKcI6l2QoezT9Z3OuC4zHkRNqh8YESiu94vOt4KUrtuA6xF52g==
X-Received: by 2002:a05:6830:159a:: with SMTP id i26mt1161065otr.3.1576656325920;
 Wed, 18 Dec 2019 00:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20191216220747.887-1-greearb@candelatech.com> <a2af03e9-8b53-b297-467b-d0f07b8a002b@newmedia-net.de>
 <b5d63d96-4ba6-bbab-bf1c-a61c6c437f37@newmedia-net.de> <80700614-679a-336e-bd9a-e88622e75c9a@candelatech.com>
 <4775d91a-9719-46f8-b0f2-979b8d86cf9f@newmedia-net.de> <CAMrEMU-vGB8uR-JZbD2vj4vXgWNHfFqcbsqB=gOqBBDZWGkzQA@mail.gmail.com>
 <11290a30-46e8-638e-4110-86e6b2eb3d3f@candelatech.com> <CAKR_QV+xNbAzzw12x3Ku49bHnERTxYRAK8AfUSwp_uOgNMbY4Q@mail.gmail.com>
 <a95e7f6d-1cb8-3188-aea4-233dce6f9330@candelatech.com> <CAKR_QVL0P4qYidtqLwhhacCOpx2iq+4RRhTXbGhfRnf2PUj5tA@mail.gmail.com>
 <CAKR_QV+KV1dR_QKjANL34DGJuyf3OSN8J6gs3bqcmiRCCzkdXA@mail.gmail.com>
 <5e3f22d1-b8ba-d756-a15c-1e7ae56c1dad@newmedia-net.de> <8eae96cd-a94e-abc1-4750-73f931d657d6@candelatech.com>
 <9431f1a2-a44e-9b81-72b0-9a703e1841ac@newmedia-net.de>
In-Reply-To: <9431f1a2-a44e-9b81-72b0-9a703e1841ac@newmedia-net.de>
From:   Justin Capella <justincapella@gmail.com>
Date:   Wed, 18 Dec 2019 00:05:12 -0800
Message-ID: <CAMrEMU8UrY9F++ut88to0AxKJXHTi9cwUs8uGOmN=k0ymcH0FA@mail.gmail.com>
Subject: Re: [PATCH] ath10k: Per-chain rssi should sum the secondary channels
Cc:     Ben Greear <greearb@candelatech.com>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Tom Psyborg <pozega.tomislav@gmail.com>,
        linux-wireless@vger.kernel.org, ath10k <ath10k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Don't mean to steal your thread here, but since it's being discussed--
is there something that can be done to provide more accurate/precise
data? Use of the default is widespread so not a reason to hold back
the patch imo, but with a proposed pcap-ng capture information block
they would become more accessible and maybe there will be increased
interest in real values.

Anyway to fill out IEEE80211_RADIOTAP_DBM_ANT{SIGNAL,NOISE}?

I recall from another thread that there isn't currently periodic
calibration but the floor could change with environment too.

On Tue, Dec 17, 2019 at 8:05 PM Sebastian Gottschall
<s.gottschall@newmedia-net.de> wrote:
>
>
> Am 18.12.2019 um 03:37 schrieb Ben Greear:
> >
> >
> > On 12/17/2019 06:12 PM, Sebastian Gottschall wrote:
> >> i dont know what you want to compare here.
> >>
> >> 1. you compare 2 different wifi chipsets. both have different
> >> sensititivy and overall output power spec
> >>
> >> 2. both have different amount of antenna chains. which does make a
> >> difference in input sensitivity
> >>
> >> 3. the patch ben made has no effect on qca9880 chipsets. it only
> >> takes effect on 10.4 based chipsets like 9984
> >
> > The part of my patch that sums secondary frequencies should apply to
> > wave-1 as well, but I have
> > not verified that yet.
> yeah. right. sorry i was just looking at total signal sum which uses
> rssi_comb_ht
> >
> >
> >> about noise floors in general. noise floors of -108 are bogus. there
> >> is a physical limit a noise level can be.
> >> since drivers like ath9k are doing a cyclic calibration, the noise
> >> value might indeed change. but this calibration is
> >> not running in realtime. its cyclic. i'm not aware if chipsets like
> >> qca988x are going the same way, but since qca988x
> >> has sime similaries with ath9k chipsets unlike the newer 9984
> >> variants, it could be. the 30 seconds mentioned
> >> in the bug report fits to my expectations of the early noisefloor
> >> calibration which has a short delay and after success
> >> turning to use a long delay. anyway. in this early calibration phase
> >> signals might change and will stabilize after. this isnt a issue
> >> since your connection will work anyway even if it might take a little
> >> bit longer if you have poor signal levels
> >>
> >> @ben. am i wrong or what do think?
> >
> > I don't know enough about how the noise floor calculations are done or
> > how the apply to settings
> > to know the answer.
> >
> > I will be happy in general if ath10k wave-1, wave-2, and ath9k report
> > similar RSSI for similar
> > setups.
> that will not work. you compare different chipsets and depending on the
> implementation by the card vendor
> rf sensitivity can be very diffent. the same goes for output power. some
> vendors are using additional rf amps
> for enhancing output power (ubiquiti is best example here). this these
> amps also may have influence to sensitivity.
> on these cards you set 10 db output power, but in fact it outputs 18 db.
> so there is a bias offset on these cards or devices. (the offset is
> depending on the device model)
>
> what you measure is what the chip receives, but not what was lost on the
> pcb layout. (or was even generated in case of noise)
> and when it comes to calibration data. correct would be if each
> individual card is calibrated before shipment. in reality manufactures
> are doing calibration on a single reference card and clone it on all
> following cards to save time. the result depends on day or week of
> production
> and current position of the moon and sun. errors of +- 2 db are common
> here. (this is not a fact for all card or device vendors)
>
> >
> > If you look at the tx-rate-power table in ath10k, for instance, you
> > can see different MCS are transmitted
> > at different signal levels.  So, some change from initial conditions
> > might be because higher MCS is
> > being transmitted after rate-ctrl scales up?
> yes. this is modulation related. as higher the rate goes as lower the
> power will be. thats princible of QAM.
> and the rate control itself isnt signal but error rate based. so high
> packet loss triggers the rate control to lower the rate which results
> in increased output power and vice versa. but as mentioned. at card
> startup a noise floor calibration starts which may succeed or fail.
> if it succeeds it will turn into a long delay phase. so cyclic
> calibration. the calibration time is exactly 30 seconds (minimum) and if
> it fails it can
> exceed to 60 seconds. after that time it will sleep for 300 seconds and
> will check for recalibration conditions. (there are rules like high
> noise floor changes etc.)
> a recalibration is also triggered at channel changes  and if chipset
> temperature changes at a certain level.
> from what i have seen the procedure in the qca9880 firmware is exactly
> the same as in ath9k.
> anyway. while this calibration is running, the signal and noise floor
> might be unstable or even bogus until this is finished and rate control
> might not be optimal
> under stress conditions like long range links with low signals. with
> standard wifi usage you should not notice it that much since signal to
> noise ratio is high enough anyway
>
>
> >
> > Lots of moving parts...
> >
> > Thanks,
> > Ben
> >
> >>
> >> Sebastian
> >>
> >> Am 18.12.2019 um 00:37 schrieb Tom Psyborg:
> >>> also noticed now that the noise floor changes with signal strength as
> >>> described in this bug report:
> >>> https://www.mail-archive.com/ath10k@lists.infradead.org/msg11553.html
> >>>
> >>> after wifi restart
> >>>
> >>> iwinfo:
> >>>
> >>> signal: -59dBm noise: -108dBm
> >>>
> >>> then goes to
> >>>
> >>> signal: -52dBm noise: -103dBm
> >>>
> >>> and finally drops to
> >>>
> >>> signal: -59dBm noise: -103dBm
> >>>
> >>
> >
