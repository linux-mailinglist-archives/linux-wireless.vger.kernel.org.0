Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327532AE1EF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 22:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgKJVks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 16:40:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55323 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgKJVkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 16:40:24 -0500
Received: from mail-oo1-f72.google.com ([209.85.161.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kcbNF-0003NL-OT
        for linux-wireless@vger.kernel.org; Tue, 10 Nov 2020 21:40:21 +0000
Received: by mail-oo1-f72.google.com with SMTP id q80so3407642ooq.18
        for <linux-wireless@vger.kernel.org>; Tue, 10 Nov 2020 13:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fBR9Iz98wiZC0dhRBOUcz6Cdnxtcs7lLwsZxeb9MiCQ=;
        b=R8VZUofJK53VYlDbHMOYhqtowXtB/y625ge7ymubh8sixnapNZjHddERTv/Fe3aQXJ
         a8HsqM4Nz4fhJrNozsrFw1EobejDf5/vqI0Csm5oq2pIiskN85Knt/P1L8SuULkOTv+x
         H8nfabeFcspwJ3SfG90Vq6DTYV3b/UT+6Jl8lOqyH/ZZUzJAtTbynNhhUcRkgr+4Su71
         EjczuWfpo42bPRKwFdfkILnHV7n329Zu4wXcTZULDPYnCrrExwY1hrYT84/DN5PxDfjD
         x1AnRAUwalTG0vjqtTldZIqc2PM6MgtnQ2yG5oEn/WfHZhFsRSmNI8F+7FsdhogLGTHD
         MxAw==
X-Gm-Message-State: AOAM5334U2qczfr+Gwz3dWXI/NiNGFTZmihg5CeRIUjY6ziebiyIBh+s
        996sxM8kVmnQ3ox6xMIyAiPtYc6tUDh1kAm5T8lRPUmbURkDuOpM2kdXTvtg1IB72pNLWZF84ri
        PYWeONjbkDeoRViAktX8BXOPXDs8F+HWoG3cjCOYqyVEG
X-Received: by 2002:a9d:323:: with SMTP id 32mr15047294otv.352.1605044420356;
        Tue, 10 Nov 2020 13:40:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnJ6ZR5R2fUSpee5KJAMxbqXSttQ/6eSscckBLsyF5iiPaqhMWf2kgZJpbA2siQGnMjQcUAA==
X-Received: by 2002:a9d:323:: with SMTP id 32mr15047279otv.352.1605044420082;
        Tue, 10 Nov 2020 13:40:20 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:59ea:bfb1:548d:1c70])
        by smtp.gmail.com with ESMTPSA id v8sm57539ooh.6.2020.11.10.13.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 13:40:18 -0800 (PST)
Date:   Tue, 10 Nov 2020 15:40:18 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Pavel Starosek <starosekpd@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Update regulatory rules for Kazakhstan (KZ)
Message-ID: <20201110214018.GM6125@ubuntu-x1>
References: <CAPgWZqzskMUOnmdBwh6TEh5yfrbdzg+4bZOUMQPkJffWizZweg@mail.gmail.com>
 <CAPgWZqx-bHc5iEn-fWbzarrUNB5kbMnay_Pr5BKROznOAO0nWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPgWZqx-bHc5iEn-fWbzarrUNB5kbMnay_Pr5BKROznOAO0nWQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Nov 09, 2020 at 03:19:01AM +0600, Pavel Starosek wrote:
> Updates, based on [1] (search for word "RLAN" to jump to the desired
> part on the page):

Thanks for the updates. I think there are some questions though be
answered in the documents you linked to. I find that tables like these
often have incomplete information. Sometimes they refer to other
documents, but I'm not seeing any such references here. I've tried to
find more complete documents, but I haven't had any luck.

Overall these look okay, but if you are able to find any additional
information to clarify some of these points it would be helpful.

> * Extended range 2400-2483.5
> * 5150–5250 MHz range may be up to 200 mW
> * The same is about 5250 - 5350 MHz according to our local
> regulations, but looks like this is incorrect because of TPC?
> Therefore, I didn't change this value

It would be nice to know for sure, but without any additional
information keeping it at 20 dBm is the safe bet. Many countries do
require TPC in this range.

> * Add 5725-5850 MHz range for indoor usage

Here it would be nice to know if there are any additional restrictions
on use, e.g. TPC or DFS. That appears to be rare though, so it seems
unlikely.

> * Add 57-66 GHz range. It must be outdoors only, so we don't specify
> NO-OUTDOOR at all, right?

That is generally the case for this range. What you suggest looks fine.

> * In 5470-5725 changed the bandwidth from 80 to 160 (typo?)

Probably not a typo, if 160 MHz channels are allowed the entry probably
just hasn't been updated. But those documents don't really state whether
or not they are allowed.

> As I understand it, there is no DFS requirement for the 5725-5850
> range anywhere in the [2] document.

I don't it documenting any DFS requirement at all though, and severaly
entries in the db have a DFS requirement, so I'm not sure that really
clears up the question. I'm reading a translation of the document
though, so maybe I'm just not finding them.

Let me know if you're able to find any more information to clear up
these questions. Are you able to send the changes as a patch? If you
don't know how, that's fine, I can create a patch.

Thanks,
Seth

> 
> I can suggest this change. Please check if everything is correct?
> ---
> # [1] http://adilet.zan.kz/rus/docs/V1500010730
> # [2] http://adilet.zan.kz/rus/docs/V1500010375
> country KZ: DFS-ETSI
>     (2400 - 2483.5 @ 40), (20)
>     (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
>     (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
>     (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
>     (5725 - 5850 @ 80), (20), NO-OUTDOOR
>     (57000 - 66000 @ 2160), (40)
> 
> ---
> Thanks,
> Pavel
> 
> 
> On Mon, Nov 9, 2020 at 3:16 AM Pavel Starosek <starosekpd@gmail.com> wrote:
> >
> > Updates, based on [1] (search for word "RLAN" to jump to the desired part on the page):
> >
> > * Extended range 2400-2483.5
> > * 5150–5250 MHz range may be up to 200 mW
> > * The same is about 5250 - 5350 MHz according to our local regulations, but looks like this is incorrect because of TPC? Therefore, I didn't change this value
> > * Add 5725-5850 MHz range for indoor usage
> > * Add 57-66 GHz range. It must be outdoors only, so we don't specify NO-OUTDOOR at all, right?
> > * In 5470-5725 changed the bandwidth from 80 to 160 (typo?)
> > As I understand it, there is no DFS requirement for the 5725-5850 range anywhere in the [2] document.
> >
> > I can suggest this change. Please check if everything is correct?
> > ---
> > # [1] http://adilet.zan.kz/rus/docs/V1500010730
> > # [2] http://adilet.zan.kz/rus/docs/V1500010375
> > country KZ: DFS-ETSI
> >     (2400 - 2483.5 @ 40), (20)
> >     (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> >     (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
> >     (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
> >     (5725 - 5850 @ 80), (20), NO-OUTDOOR
> >     (57000 - 66000 @ 2160), (40)
> >
> > ---
> > Thanks,
> > Pavel
> >
