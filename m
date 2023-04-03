Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF86D52CC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 22:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDCUp3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbjDCUp2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 16:45:28 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4825144A6
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 13:45:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id bt19so20087656pfb.3
        for <linux-wireless@vger.kernel.org>; Mon, 03 Apr 2023 13:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680554721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0gwdx/qI90Iih62gFITI5xcbfUZd1OMQlPB0MLeEbM=;
        b=puL71Hojfo4wnrmBc5xi8RCZRFBgdmUmCD47rDYK90zl01SqiVxVth7DRh50HT3rD1
         kDe8zcUOhPiGA3zmfeCD1kvn79itdzV9XBW5M10xUUhMx+ot9VpDvuBN5zH+jT4c96F+
         rqxuLIY3f/3Js4zxeW663G6TiMaBrsYrobelOMUpy9umT3IwiWHI0fYEpgXnqeNe4wif
         sGXCUQv0V7d2luWPAja7tlF4kSJlukZnNOLahLPevBZ01tubVp1OhcR54Zuix/Wo34WR
         BlwmnazUqhmzyK3oc1U7WNmJjtrQbEHczGLUJBjmOIiYGFubiVqOoo6Bor4jSyPp8APq
         6oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0gwdx/qI90Iih62gFITI5xcbfUZd1OMQlPB0MLeEbM=;
        b=KX6fCi84/Vd5Sy3r46d2TZb9+3UIv9cjnjpxgMuNfUObJzDRWT0JMIz1mDEDbmlq9L
         qxVjkDaZibepLLq/g9q/OZ4uGrPIvGs1YTfVi54UEW1WdYOO+GBNFVEu3uV2wkyKh1eu
         COqYONZ6RwddOaXEatrF9ePCW20/BCb91Vw/waHsu/NFXEDaB7azhMhxNG8E6VpYO+8S
         20lIZjMWOeLZAUg1rRhzPbRWO6uTNAzdT5KiwgftQ7nSVg90Fw/P7PHgsdubleVXt5Re
         PqFvDfgyHu0I7ZMNQrXmjA8NZQe4hrzQhPaFhHR9O1VBbUPicpUoDxKRrDei8+j10k1g
         bECQ==
X-Gm-Message-State: AAQBX9d/MYroYSTEisg57HCbrWkK/ka/ICcd+sFA1+NVG0K4ZexYVZaR
        8tR8SGxzJMVJSfS2rfMVkOeO8Avb4JPDVGSwIR6w1a1wahg=
X-Google-Smtp-Source: AKy350YC5w6US4zr9+7EE4t04G0cSKYUhoq5Z9DE2olYM8/1KPVJw8yOigFm5AdUpYkGzxsdcilXp6YcAaDxbYU45U8=
X-Received: by 2002:a05:6a00:22d5:b0:625:a545:3292 with SMTP id
 f21-20020a056a0022d500b00625a5453292mr27798pfj.0.1680554720637; Mon, 03 Apr
 2023 13:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMPnHXye6EBTix6125NzPrQSitwKikK6b77g=K5t-ihmU11JHg@mail.gmail.com>
 <CAMPnHXy49dSKdiCzeEZ86q3YEEWW=PrfPYwPevA4A2bFBe_sbg@mail.gmail.com>
 <ZBnde5f7JuORq1PX@do-x1extreme> <CAMPnHXxnDYQ8_TeT_aJ1GU2YvmJw+4QyvBmHhdCvpsmFFROv1w@mail.gmail.com>
 <ZCHxMx+aMqq3K6Cb@do-x1extreme>
In-Reply-To: <ZCHxMx+aMqq3K6Cb@do-x1extreme>
From:   Keshav <the.ridikulus.rat@gmail.com>
Date:   Mon, 3 Apr 2023 15:45:09 -0500
Message-ID: <CAMPnHXyeQiRG8OhDBqAQjato0j-8aMwUkXfgaWvFzGMHuwzwOQ@mail.gmail.com>
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

I apologize for the late reply from my end. Please see my comments below.

On Mon, Mar 27, 2023 at 2:40=E2=80=AFPM Seth Forshee <sforshee@kernel.org> =
wrote:
>
> On Fri, Mar 24, 2023 at 06:30:32PM -0500, Keshav wrote:
> > Hello Seth,
> >
> > Thank you for your reply. Please find below my comments.
> >
> > On Tue, Mar 21, 2023 at 11:38=E2=80=AFAM Seth Forshee <sforshee@kernel.=
org> wrote:
> > >
> > > On Sat, Mar 04, 2023 at 05:13:44PM -0600, Keshav wrote:
> > > > Hello,
> > > >
> > > > I noticed that wireless-regdb db.txt [1] has restricted India's 2.4
> > > > GHz maximum power to only 20 dBm:
> > > >
> > > > country IN:
> > > >         (2402 - 2482 @ 40), (20)
> > > >
> > > > However the Official Gazette of Government of India (PDF [3] linked=
 in
> > > > URL [2]) mentions that upto 30 dBm is allowed in the 2.4 GHz band.
> > > >
> > > > 2.4 GHz Rules for India (IN): Pages 87 to 88 of PDF [3]
> > > >
> > > > I would like to mention that I am not an expert in this topic. I am
> > > > not sure if there's any other reason to restrict 2.4 GHz for India =
to
> > > > 20 dBm in the db.txt. I also couldn't find any other official
> > > > Government of India document that restricts the maximum power to 20
> > > > dBm (due to some other reason). Please look into this and correct t=
he
> > > > regulatory rules for India if needed. Thank you.
> > > >
> > > > Although not the topic of this email, you can also find the 5 GHz
> > > > Rules for India in the same PDF [3] (pages 94 to 97) if interested.
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wirele=
ss-regdb.git/tree/db.txt?id=3D7f7a9f7bc6011b072b5427eced1ff19261764e95#n853
> > > >
> > > > [2] https://dot.gov.in/spectrummanagement/gazette-notifications-del=
icensed-band
> > > >
> > > > [3] https://dot.gov.in/sites/default/files/Gazette_Notifications.pd=
f
> > >
> > > Sorry for the slow response. I've been attempting to research this as
> > > time allows, but I haven't had a lot of time for it, and the informat=
ion
> > > is not well organized.
> > >
> > > [1] was the most complete summary I found for spectrum use in India. =
In
> > > particular Annex 1 has a table of GSR numbers relevant for unlicensed
> > > spectrum, which for 2.4 GHz is GSR No. 45(E) [2] and for 5 GHz is GSR
> > > No. 1048(E) [3]. It looks like the document you linked to just bundle=
s
> > > these and other GSRs together, so as far as I can tell the informatio=
n
> > > you provided looks accurate.
> > >
> > > The database stores maximum EIRP, not transmitter output power, so I
> > > think that 36 dBm is the correct value for 2.4 GHz (GSR No. 45(E) sho=
ws
> > > an ERP of 36dBm, but based on the maximum transmitter power of 30 dBm=
 I
> > > think this is probably meant to be the EIRP).
> > >
> > > The 5 GHz rules look mostly right, except that it looks like 5250-535=
0
> > > and 5470-5725 MHz both require DFS. They also require TPC, which Linu=
x
> > > doesn't support, but the PSD limit restricts our max EIRP to below th=
e
> > > threshold where TPC is required.
> > >
> > > So I think these are the correct rules for India:
> > >
> > > country IN:
> > >         (2400 - 2482 @ 40), (36)
> > >         (5150 - 5250 @ 80), (30)
> > >         (5250 - 5350 @ 80), (24), DFS
> > >         (5470 - 5725 @ 160), (24), DFS
> > >         (5725 - 5875 @ 80), (30)
> > >
> > > If this looks right to you, I can send the patch to update the rules.
> > >
> > > Thanks,
> > > Seth
> > >
> > > [1] https://dot.gov.in/sites/default/files/NFAP%202018.pdf
> > > [2] https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-ba=
nd-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> > > [3] https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr=
-1048e-dated-22102018
> >
> > Based on your explanation, the numbers look right to me. However, I am
> > not an RF expert and I do not have enough knowledge to interpret these
> > rules correctly myself. Therefore I will defer to your judgement here.
>
> I am not an RF expert either.
>
> > There's one thing I forgot to mention in my previous email. I noticed
> > this discrepancy in db.txt because I came across the embedded regdb
> > rules defined in an ath11k wifi router running OpenWrt
> > (https://openwrt.org/toh/hwdata/dynalink/dynalink_dl-wrx36), and
> > noticed that they are different from wireless-regdb db.txt rules. The
> > "iw" outputs from the ath11k device are pasted below for your
> > reference.
> >
> > # iw reg get
> > global
> > country IN: DFS-UNSET
> >         (2402 - 2482 @ 40), (N/A, 20), (N/A)
> >         (5150 - 5250 @ 80), (N/A, 30), (N/A)
> >         (5250 - 5350 @ 80), (N/A, 24), (N/A)
> >         (5470 - 5725 @ 160), (N/A, 24), (N/A)
> >         (5725 - 5875 @ 80), (N/A, 30), (N/A)
> >
> > phy#1 (self-managed)
> > country IN: DFS-FCC
> >         (2402 - 2472 @ 40), (N/A, 30), (N/A)
> >         (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
> >         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
> >         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
> >         (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW
> >
> > phy#0 (self-managed)
> > country IN: DFS-FCC
> >         (2402 - 2472 @ 40), (N/A, 30), (N/A)
> >         (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
> >         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
> >         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
> >         (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW
> >
> > # iw list
> > Wiphy phy1
> > Frequencies:
> >                         * 2412 MHz [1] (30.0 dBm)
> >                         * 2417 MHz [2] (30.0 dBm)
> >                         * 2422 MHz [3] (30.0 dBm)
> >                         * 2427 MHz [4] (30.0 dBm)
> >                         * 2432 MHz [5] (30.0 dBm)
> >                         * 2437 MHz [6] (30.0 dBm)
> >                         * 2442 MHz [7] (30.0 dBm)
> >                         * 2447 MHz [8] (30.0 dBm)
> >                         * 2452 MHz [9] (30.0 dBm)
> >                         * 2457 MHz [10] (30.0 dBm)
> >                         * 2462 MHz [11] (30.0 dBm)
> >                         * 2467 MHz [12] (disabled)
> >                         * 2472 MHz [13] (disabled)
> >                         * 2484 MHz [14] (disabled)
> >
> > Wiphy phy0
> > Frequencies:
> >                         * 5180 MHz [36] (30.0 dBm)
> >                         * 5200 MHz [40] (30.0 dBm)
> >                         * 5220 MHz [44] (30.0 dBm)
> >                         * 5240 MHz [48] (30.0 dBm)
> >                         * 5260 MHz [52] (24.0 dBm) (radar detection)
> >                         * 5280 MHz [56] (24.0 dBm) (radar detection)
> >                         * 5300 MHz [60] (24.0 dBm) (radar detection)
> >                         * 5320 MHz [64] (24.0 dBm) (radar detection)
> >                         * 5500 MHz [100] (24.0 dBm) (radar detection)
> >                         * 5520 MHz [104] (24.0 dBm) (radar detection)
> >                         * 5540 MHz [108] (24.0 dBm) (radar detection)
> >                         * 5560 MHz [112] (24.0 dBm) (radar detection)
> >                         * 5580 MHz [116] (24.0 dBm) (radar detection)
> >                         * 5600 MHz [120] (24.0 dBm) (radar detection)
> >                         * 5620 MHz [124] (24.0 dBm) (radar detection)
> >                         * 5640 MHz [128] (24.0 dBm) (radar detection)
> >                         * 5660 MHz [132] (24.0 dBm) (radar detection)
> >                         * 5680 MHz [136] (24.0 dBm) (radar detection)
> >                         * 5700 MHz [140] (24.0 dBm) (radar detection)
> >                         * 5720 MHz [144] (24.0 dBm) (radar detection)
> >                         * 5745 MHz [149] (30.0 dBm)
> >                         * 5765 MHz [153] (30.0 dBm)
> >                         * 5785 MHz [157] (30.0 dBm)
> >                         * 5805 MHz [161] (30.0 dBm)
> >                         * 5825 MHz [165] (30.0 dBm)
> >                         * 5845 MHz [169] (disabled)
> >                         * 5865 MHz [173] (disabled)
> >
> > Looks like ath11k restricts the maximum EIRP to 30 dBm for 2.4 GHz.
> > Again I am not an expert so I can't comment on whether 30 dBm vs 36
> > dBm is the correct maximum EIRP value for 2.4 GHz.
>
> I find the rules in GSR No. 45(E) unclear and a little confusing.
> Broadly you can think of EIRP(dBm) =3D tx_output_power(dBm) +
> antenna_gain(dBi). If you look at the US rules [1] you can see that it
> specifies EIRP assuming an antenna gain of 6 dBi or less, with
> adjusments for antennas with larger gains.
>
> GSR No. 45(E) does not define things as clearly, but when I see a
> transmitter output power of 30 dBm and a maximum effective radiated
> power of 36 dBm it leads me to think that it has a similar model of
> assuming an antenna gain <=3D 6 dBi. I could be wrong, but from what I se=
e
> this interpretation makes the most sense to me.
>

Yes, the GSR 45 (E) text is confusing for me as well. Not sure if
"Effective Radiated Power" =3D=3D "EIRP" in GSR 45 (E).

> 30 dBm is certainly a safe value though, as the max EIRP should be at
> least that much under any interpretation.
>

I would prefer going with the safer value of 30 dBm in the regdb for
now. However it is up to you if you want to change it to 30 dBm or 36
dBm.

> [1] https://www.ecfr.gov/current/title-47/chapter-I/subchapter-A/part-15/=
subpart-C/subject-group-ECFR2f2e5828339709e/section-15.247
>

Thank you for the link. I haven't had time to go through it, but I
don't think we can assume that the "Antenna Gain" specification in the
US FCC regulatory rules also applies to India.

> Thanks,
> Seth

With Best Regards,

Keshav A.
