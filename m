Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BE26C8941
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 00:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCXXat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 19:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCXXas (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 19:30:48 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD99F1705
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 16:30:43 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z10so2008800pgr.8
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679700643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnumvn2tFEq95hnTxvcP/ZZqSRGEwbVLH0m2TRtC+Go=;
        b=cYpNCm0+224Z4Pvsm/yW5KAVnCQiZ9+qhBmOGR8uwzjnofJEEvO516V4bHQmmNQDWw
         dJyqc0OVX0URp4IUnMHZ9jCMfLCy4g3+2Fpm3tU+g1d1VFJhOH5ib2Qz+5bSO6N43xx4
         Ko/pV5NPo6V1RSQVzgClLBQ6iP8MR4lFabAGZU45OdPZ0WGM7sjuWjqW8MM50W06277O
         AAtCmJ/B28wMFX/OE+wLF60OSebMh1k/n7cRc9matFNcsz8I9uBdGNVFjmFxs/1LiMSM
         nOAowawcaxfMWKi80mZLyziZ5gzEhJZ0B/o5QA8TYzgyqMElAr9LJloB+5nYO1lnjrGp
         3V5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679700643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnumvn2tFEq95hnTxvcP/ZZqSRGEwbVLH0m2TRtC+Go=;
        b=X7TAJ5aB216t2xx6GN7/PSTud9iHPyDgfaw3r4MGDSQ+xiW5V3lRj5KSIjMp7OWgws
         nzCE7C01dcvw0q0OemWGX5QgJDz9/MryWLet3PoeWkwwj2zX9PXIzFyTo/RF/9V3uYJk
         lxI+e/Bl0VD9o5gviWOUdEOTialoZI5YK/imfE6vyOudSA8FO5GLDAtRmFUE1iTWRRx2
         VruVOXQ+bsfM+T4/v4PwKqb+ZKDCT71aeyPv72FpW+q5MeHSTcEOVAHP4uTs6O46zNck
         AAyxHbONhjwKrExFqqxvdi/XJ89jRNot4wiVjotDTW1ebhaQiXmVswXRsDi5vIw/+W1I
         EhNw==
X-Gm-Message-State: AAQBX9ct7eYwi/pDnsya+lmBz2hua7IjHKEmSa1PE9f95ku8Vp88ENOU
        5piyLRYQaVPZBqZ2OUgz1nrqtwVyM31+t5kWjTEI+sCMMIj8FA==
X-Google-Smtp-Source: AKy350aulKPbG9657hoJnnorCE5x7KOH30sW90QbCOlZNjrmftQv6Y4nJxTM20ZBh4iZY/4VSfg/MbtsY6fGFvTzAcI=
X-Received: by 2002:a63:a08:0:b0:508:9e77:5bb2 with SMTP id
 8-20020a630a08000000b005089e775bb2mr1063900pgk.9.1679700643148; Fri, 24 Mar
 2023 16:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAMPnHXye6EBTix6125NzPrQSitwKikK6b77g=K5t-ihmU11JHg@mail.gmail.com>
 <CAMPnHXy49dSKdiCzeEZ86q3YEEWW=PrfPYwPevA4A2bFBe_sbg@mail.gmail.com> <ZBnde5f7JuORq1PX@do-x1extreme>
In-Reply-To: <ZBnde5f7JuORq1PX@do-x1extreme>
From:   Keshav <the.ridikulus.rat@gmail.com>
Date:   Fri, 24 Mar 2023 18:30:32 -0500
Message-ID: <CAMPnHXxnDYQ8_TeT_aJ1GU2YvmJw+4QyvBmHhdCvpsmFFROv1w@mail.gmail.com>
Subject: Re: wireless-regdb: Please correct the regulatory rules for India
 (IN) on 2.4 GHz
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Seth,

Thank you for your reply. Please find below my comments.

On Tue, Mar 21, 2023 at 11:38=E2=80=AFAM Seth Forshee <sforshee@kernel.org>=
 wrote:
>
> On Sat, Mar 04, 2023 at 05:13:44PM -0600, Keshav wrote:
> > Hello,
> >
> > I noticed that wireless-regdb db.txt [1] has restricted India's 2.4
> > GHz maximum power to only 20 dBm:
> >
> > country IN:
> >         (2402 - 2482 @ 40), (20)
> >
> > However the Official Gazette of Government of India (PDF [3] linked in
> > URL [2]) mentions that upto 30 dBm is allowed in the 2.4 GHz band.
> >
> > 2.4 GHz Rules for India (IN): Pages 87 to 88 of PDF [3]
> >
> > I would like to mention that I am not an expert in this topic. I am
> > not sure if there's any other reason to restrict 2.4 GHz for India to
> > 20 dBm in the db.txt. I also couldn't find any other official
> > Government of India document that restricts the maximum power to 20
> > dBm (due to some other reason). Please look into this and correct the
> > regulatory rules for India if needed. Thank you.
> >
> > Although not the topic of this email, you can also find the 5 GHz
> > Rules for India in the same PDF [3] (pages 94 to 97) if interested.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-r=
egdb.git/tree/db.txt?id=3D7f7a9f7bc6011b072b5427eced1ff19261764e95#n853
> >
> > [2] https://dot.gov.in/spectrummanagement/gazette-notifications-delicen=
sed-band
> >
> > [3] https://dot.gov.in/sites/default/files/Gazette_Notifications.pdf
>
> Sorry for the slow response. I've been attempting to research this as
> time allows, but I haven't had a lot of time for it, and the information
> is not well organized.
>
> [1] was the most complete summary I found for spectrum use in India. In
> particular Annex 1 has a table of GSR numbers relevant for unlicensed
> spectrum, which for 2.4 GHz is GSR No. 45(E) [2] and for 5 GHz is GSR
> No. 1048(E) [3]. It looks like the document you linked to just bundles
> these and other GSRs together, so as far as I can tell the information
> you provided looks accurate.
>
> The database stores maximum EIRP, not transmitter output power, so I
> think that 36 dBm is the correct value for 2.4 GHz (GSR No. 45(E) shows
> an ERP of 36dBm, but based on the maximum transmitter power of 30 dBm I
> think this is probably meant to be the EIRP).
>
> The 5 GHz rules look mostly right, except that it looks like 5250-5350
> and 5470-5725 MHz both require DFS. They also require TPC, which Linux
> doesn't support, but the PSD limit restricts our max EIRP to below the
> threshold where TPC is required.
>
> So I think these are the correct rules for India:
>
> country IN:
>         (2400 - 2482 @ 40), (36)
>         (5150 - 5250 @ 80), (30)
>         (5250 - 5350 @ 80), (24), DFS
>         (5470 - 5725 @ 160), (24), DFS
>         (5725 - 5875 @ 80), (30)
>
> If this looks right to you, I can send the patch to update the rules.
>
> Thanks,
> Seth
>
> [1] https://dot.gov.in/sites/default/files/NFAP%202018.pdf
> [2] https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-g=
sr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> [3] https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-104=
8e-dated-22102018

Based on your explanation, the numbers look right to me. However, I am
not an RF expert and I do not have enough knowledge to interpret these
rules correctly myself. Therefore I will defer to your judgement here.

There's one thing I forgot to mention in my previous email. I noticed
this discrepancy in db.txt because I came across the embedded regdb
rules defined in an ath11k wifi router running OpenWrt
(https://openwrt.org/toh/hwdata/dynalink/dynalink_dl-wrx36), and
noticed that they are different from wireless-regdb db.txt rules. The
"iw" outputs from the ath11k device are pasted below for your
reference.

# iw reg get
global
country IN: DFS-UNSET
        (2402 - 2482 @ 40), (N/A, 20), (N/A)
        (5150 - 5250 @ 80), (N/A, 30), (N/A)
        (5250 - 5350 @ 80), (N/A, 24), (N/A)
        (5470 - 5725 @ 160), (N/A, 24), (N/A)
        (5725 - 5875 @ 80), (N/A, 30), (N/A)

phy#1 (self-managed)
country IN: DFS-FCC
        (2402 - 2472 @ 40), (N/A, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW

phy#0 (self-managed)
country IN: DFS-FCC
        (2402 - 2472 @ 40), (N/A, 30), (N/A)
        (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
        (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW

# iw list
Wiphy phy1
Frequencies:
                        * 2412 MHz [1] (30.0 dBm)
                        * 2417 MHz [2] (30.0 dBm)
                        * 2422 MHz [3] (30.0 dBm)
                        * 2427 MHz [4] (30.0 dBm)
                        * 2432 MHz [5] (30.0 dBm)
                        * 2437 MHz [6] (30.0 dBm)
                        * 2442 MHz [7] (30.0 dBm)
                        * 2447 MHz [8] (30.0 dBm)
                        * 2452 MHz [9] (30.0 dBm)
                        * 2457 MHz [10] (30.0 dBm)
                        * 2462 MHz [11] (30.0 dBm)
                        * 2467 MHz [12] (disabled)
                        * 2472 MHz [13] (disabled)
                        * 2484 MHz [14] (disabled)

Wiphy phy0
Frequencies:
                        * 5180 MHz [36] (30.0 dBm)
                        * 5200 MHz [40] (30.0 dBm)
                        * 5220 MHz [44] (30.0 dBm)
                        * 5240 MHz [48] (30.0 dBm)
                        * 5260 MHz [52] (24.0 dBm) (radar detection)
                        * 5280 MHz [56] (24.0 dBm) (radar detection)
                        * 5300 MHz [60] (24.0 dBm) (radar detection)
                        * 5320 MHz [64] (24.0 dBm) (radar detection)
                        * 5500 MHz [100] (24.0 dBm) (radar detection)
                        * 5520 MHz [104] (24.0 dBm) (radar detection)
                        * 5540 MHz [108] (24.0 dBm) (radar detection)
                        * 5560 MHz [112] (24.0 dBm) (radar detection)
                        * 5580 MHz [116] (24.0 dBm) (radar detection)
                        * 5600 MHz [120] (24.0 dBm) (radar detection)
                        * 5620 MHz [124] (24.0 dBm) (radar detection)
                        * 5640 MHz [128] (24.0 dBm) (radar detection)
                        * 5660 MHz [132] (24.0 dBm) (radar detection)
                        * 5680 MHz [136] (24.0 dBm) (radar detection)
                        * 5700 MHz [140] (24.0 dBm) (radar detection)
                        * 5720 MHz [144] (24.0 dBm) (radar detection)
                        * 5745 MHz [149] (30.0 dBm)
                        * 5765 MHz [153] (30.0 dBm)
                        * 5785 MHz [157] (30.0 dBm)
                        * 5805 MHz [161] (30.0 dBm)
                        * 5825 MHz [165] (30.0 dBm)
                        * 5845 MHz [169] (disabled)
                        * 5865 MHz [173] (disabled)

Looks like ath11k restricts the maximum EIRP to 30 dBm for 2.4 GHz.
Again I am not an expert so I can't comment on whether 30 dBm vs 36
dBm is the correct maximum EIRP value for 2.4 GHz.

Please let me know if you require any more info. Thank you.

With Best Regards,

Keshav A.
