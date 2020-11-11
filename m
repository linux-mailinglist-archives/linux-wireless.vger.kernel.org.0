Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E162AF83B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgKKSgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Nov 2020 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbgKKSgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:43 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8895EC0613D1
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:36:42 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y17so2895129ilg.4
        for <linux-wireless@vger.kernel.org>; Wed, 11 Nov 2020 10:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+wpPDp5C2mfXksiXANn3tDBw7lLbI2GLzRbA1oMqfYo=;
        b=bmEmSdmAAdKnBl86h3cAbNTLBlzgzY+P5DwUeAYhlrqMyW1oaMgKtavjFxuCdsUrbN
         vEiDwcQxMm1UvQqIFcam+O1qSPs7/ekeQBRXO8QWyQAI13+8YDEOARLbpPfP+SIlAwnv
         29DjRUYiY+8vVCXJi6aFDv4ksiMHP6/apnpCaj1jzUaaig+h5MfJPgpSu9p/pYjBG/JB
         yWQDH9a3uIYWH2i/B1QJ61gJ2WmSHvp6w7nCFh3gQM48UTzI0qVcWG7pY1BAUH6DzL9y
         IOVSYUg86CeZlIcwRA86HgUj2kUf4pUNhzDfgJTgBNT1hh+dGFZRrjB4ScnTrRrPCIMi
         0m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+wpPDp5C2mfXksiXANn3tDBw7lLbI2GLzRbA1oMqfYo=;
        b=gECIODGN+5/jrOBnWAC+o2vr7WmyaYaFCOzshOKWWRGvqJlRyIo9NN/4jlrOvqizo1
         /cuDNLrlocd6HutApu9rRQFpJ4VEpysZuYu2ut0JWDKH7/z+BOIltScM13BtqZvK3EaI
         xDjSFHvaTF7+c/I5VRu/h0NGotLP7OWVS+wY5ZjjmOYovR0hXEM+Pv7XOAVpCcdcga9y
         HVDmUsR6yminGyz8oCwm+w1Q1Nk4hFEo5QMJzrCEIDrvZ70rAtRTWsVbIsupaMOYBgbc
         2yLZakmIRVf0GahvbamSE5EIfS1kL6lg81H5uyNHbFTvhK51PyomW+qQjTesNWKamVA+
         RzLg==
X-Gm-Message-State: AOAM530zMS94EFfahXfs1ICxWD9AuLCmESAhJiPEKzvz/qUWJS5hf9aX
        bLP4lq9QS58foKPXxDBY6TNCnrHQ/AC8pYYpf10=
X-Google-Smtp-Source: ABdhPJwWz1XAuIJHDrP/LeYwyzS+bBQD5kAVVtZv/MmUsgWIWLl9B4ygbdOTGg8+nQ4Ym0XDs+auvK9kfXlbRW2vSuc=
X-Received: by 2002:a92:cb8d:: with SMTP id z13mr18727096ilo.182.1605119801449;
 Wed, 11 Nov 2020 10:36:41 -0800 (PST)
MIME-Version: 1.0
References: <CAPgWZqzskMUOnmdBwh6TEh5yfrbdzg+4bZOUMQPkJffWizZweg@mail.gmail.com>
 <CAPgWZqx-bHc5iEn-fWbzarrUNB5kbMnay_Pr5BKROznOAO0nWQ@mail.gmail.com> <20201110214018.GM6125@ubuntu-x1>
In-Reply-To: <20201110214018.GM6125@ubuntu-x1>
From:   Pavel Starosek <starosekpd@gmail.com>
Date:   Thu, 12 Nov 2020 00:36:29 +0600
Message-ID: <CAPgWZqwycT=84krWfyb9HPTEqznnzfqQtUB6JpHW_D66hOBvAQ@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Kazakhstan (KZ)
To:     Seth Forshee <seth.forshee@canonical.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Nov 11, 2020 at 3:40 AM Seth Forshee <seth.forshee@canonical.com> w=
rote:
>
> On Mon, Nov 09, 2020 at 03:19:01AM +0600, Pavel Starosek wrote:
> > Updates, based on [1] (search for word "RLAN" to jump to the desired
> > part on the page):
>
> Thanks for the updates. I think there are some questions though be
> answered in the documents you linked to. I find that tables like these
> often have incomplete information. Sometimes they refer to other
> documents, but I'm not seeing any such references here. I've tried to
> find more complete documents, but I haven't had any luck.
>
> Overall these look okay, but if you are able to find any additional
> information to clarify some of these points it would be helpful.
>
> > * Extended range 2400-2483.5
> > * 5150=E2=80=935250 MHz range may be up to 200 mW
> > * The same is about 5250 - 5350 MHz according to our local
> > regulations, but looks like this is incorrect because of TPC?
> > Therefore, I didn't change this value
>
> It would be nice to know for sure, but without any additional
> information keeping it at 20 dBm is the safe bet. Many countries do
> require TPC in this range.

Probably DFS is required in 5470-5650 MHz range because of 5.450=D0=92 rule
in [2].
> > * Add 5725-5850 MHz range for indoor usage
>
> Here it would be nice to know if there are any additional restrictions
> on use, e.g. TPC or DFS. That appears to be rare though, so it seems
> unlikely.

I didn't find any TPC or DFS requirements about this 5725-5850 range.
> > * Add 57-66 GHz range. It must be outdoors only, so we don't specify
> > NO-OUTDOOR at all, right?
>
> That is generally the case for this range. What you suggest looks fine.
>
> > * In 5470-5725 changed the bandwidth from 80 to 160 (typo?)
>
> Probably not a typo, if 160 MHz channels are allowed the entry probably
> just hasn't been updated. But those documents don't really state whether
> or not they are allowed.
>
> > As I understand it, there is no DFS requirement for the 5725-5850
> > range anywhere in the [2] document.
>
> I don't it documenting any DFS requirement at all though, and severaly
> entries in the db have a DFS requirement, so I'm not sure that really
> clears up the question. I'm reading a translation of the document
> though, so maybe I'm just not finding them.
>
> Let me know if you're able to find any more information to clear up
> these questions. Are you able to send the changes as a patch? If you
> don't know how, that's fine, I can create a patch.

In fact, I'm not sure at all if document [2] applies to our case. Since the
rules in it regulate the actions for transportable radio navigation service=
s
(used in sea, air, space). So these are additional regulations.

The main rules are described in document [1]. And according to them,
these rules do not apply to Wi-Fi devices, according to
chapter 1, paragraph 1, subparagraph 1. Please read from this paragraph:
http://adilet.zan.kz/rus/docs/V1500010730#z34
Since Wi-Fi devices refer to the table in Appendix 1, I think they are
priority.

I'll send a patch soon.
>
> Thanks,
> Seth
>
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
