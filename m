Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61EC66CAEFF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Mar 2023 21:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjC0Tk6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Mar 2023 15:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjC0Tkx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Mar 2023 15:40:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B3D2D66
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 12:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 909EAB818D4
        for <linux-wireless@vger.kernel.org>; Mon, 27 Mar 2023 19:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A810C433D2;
        Mon, 27 Mar 2023 19:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679946037;
        bh=MQnBsfRgGLguwB7G3tDhVc9Zra1cOt7vvgRhqy68SjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmxDseK8Ywb9C2bFIvpILJgNe9cbFXoNCSwy56+j3B+DvMwUdTh3ZpjTd+R7Ov5z+
         TuIZ/uT5O2ojBqR4g0hIiiKZ+RGzHIdSBJJZp1OS+GQkcfcrskK0uMjGGSg6agFRt+
         K8/DpdTCXGudBomPuZPIzyW4fpWofrPmUOKrPNF1KoJ7Csttx4X/M3a/Xof6n6sUYE
         o19A6ecFTsZAhHg+qsAMYkJDlUd09iJ2dwhP55DumO6P5prWQ5Q5ejJGFgHOrbZoO4
         23aKN8ax5l3Rz36gYK85OJQL60BHmsJK2WIqbWaqjOKKgy+XWMtW0xoS+TjN3Bj13N
         5z+vsrKivc2Sg==
Date:   Mon, 27 Mar 2023 14:40:35 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Keshav <the.ridikulus.rat@gmail.com>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: wireless-regdb: Please correct the regulatory rules for India
 (IN) on 2.4 GHz
Message-ID: <ZCHxMx+aMqq3K6Cb@do-x1extreme>
References: <CAMPnHXye6EBTix6125NzPrQSitwKikK6b77g=K5t-ihmU11JHg@mail.gmail.com>
 <CAMPnHXy49dSKdiCzeEZ86q3YEEWW=PrfPYwPevA4A2bFBe_sbg@mail.gmail.com>
 <ZBnde5f7JuORq1PX@do-x1extreme>
 <CAMPnHXxnDYQ8_TeT_aJ1GU2YvmJw+4QyvBmHhdCvpsmFFROv1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMPnHXxnDYQ8_TeT_aJ1GU2YvmJw+4QyvBmHhdCvpsmFFROv1w@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, Mar 24, 2023 at 06:30:32PM -0500, Keshav wrote:
> Hello Seth,
> 
> Thank you for your reply. Please find below my comments.
> 
> On Tue, Mar 21, 2023 at 11:38 AM Seth Forshee <sforshee@kernel.org> wrote:
> >
> > On Sat, Mar 04, 2023 at 05:13:44PM -0600, Keshav wrote:
> > > Hello,
> > >
> > > I noticed that wireless-regdb db.txt [1] has restricted India's 2.4
> > > GHz maximum power to only 20 dBm:
> > >
> > > country IN:
> > >         (2402 - 2482 @ 40), (20)
> > >
> > > However the Official Gazette of Government of India (PDF [3] linked in
> > > URL [2]) mentions that upto 30 dBm is allowed in the 2.4 GHz band.
> > >
> > > 2.4 GHz Rules for India (IN): Pages 87 to 88 of PDF [3]
> > >
> > > I would like to mention that I am not an expert in this topic. I am
> > > not sure if there's any other reason to restrict 2.4 GHz for India to
> > > 20 dBm in the db.txt. I also couldn't find any other official
> > > Government of India document that restricts the maximum power to 20
> > > dBm (due to some other reason). Please look into this and correct the
> > > regulatory rules for India if needed. Thank you.
> > >
> > > Although not the topic of this email, you can also find the 5 GHz
> > > Rules for India in the same PDF [3] (pages 94 to 97) if interested.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt?id=7f7a9f7bc6011b072b5427eced1ff19261764e95#n853
> > >
> > > [2] https://dot.gov.in/spectrummanagement/gazette-notifications-delicensed-band
> > >
> > > [3] https://dot.gov.in/sites/default/files/Gazette_Notifications.pdf
> >
> > Sorry for the slow response. I've been attempting to research this as
> > time allows, but I haven't had a lot of time for it, and the information
> > is not well organized.
> >
> > [1] was the most complete summary I found for spectrum use in India. In
> > particular Annex 1 has a table of GSR numbers relevant for unlicensed
> > spectrum, which for 2.4 GHz is GSR No. 45(E) [2] and for 5 GHz is GSR
> > No. 1048(E) [3]. It looks like the document you linked to just bundles
> > these and other GSRs together, so as far as I can tell the information
> > you provided looks accurate.
> >
> > The database stores maximum EIRP, not transmitter output power, so I
> > think that 36 dBm is the correct value for 2.4 GHz (GSR No. 45(E) shows
> > an ERP of 36dBm, but based on the maximum transmitter power of 30 dBm I
> > think this is probably meant to be the EIRP).
> >
> > The 5 GHz rules look mostly right, except that it looks like 5250-5350
> > and 5470-5725 MHz both require DFS. They also require TPC, which Linux
> > doesn't support, but the PSD limit restricts our max EIRP to below the
> > threshold where TPC is required.
> >
> > So I think these are the correct rules for India:
> >
> > country IN:
> >         (2400 - 2482 @ 40), (36)
> >         (5150 - 5250 @ 80), (30)
> >         (5250 - 5350 @ 80), (24), DFS
> >         (5470 - 5725 @ 160), (24), DFS
> >         (5725 - 5875 @ 80), (30)
> >
> > If this looks right to you, I can send the patch to update the rules.
> >
> > Thanks,
> > Seth
> >
> > [1] https://dot.gov.in/sites/default/files/NFAP%202018.pdf
> > [2] https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> > [3] https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e-dated-22102018
> 
> Based on your explanation, the numbers look right to me. However, I am
> not an RF expert and I do not have enough knowledge to interpret these
> rules correctly myself. Therefore I will defer to your judgement here.

I am not an RF expert either.

> There's one thing I forgot to mention in my previous email. I noticed
> this discrepancy in db.txt because I came across the embedded regdb
> rules defined in an ath11k wifi router running OpenWrt
> (https://openwrt.org/toh/hwdata/dynalink/dynalink_dl-wrx36), and
> noticed that they are different from wireless-regdb db.txt rules. The
> "iw" outputs from the ath11k device are pasted below for your
> reference.
> 
> # iw reg get
> global
> country IN: DFS-UNSET
>         (2402 - 2482 @ 40), (N/A, 20), (N/A)
>         (5150 - 5250 @ 80), (N/A, 30), (N/A)
>         (5250 - 5350 @ 80), (N/A, 24), (N/A)
>         (5470 - 5725 @ 160), (N/A, 24), (N/A)
>         (5725 - 5875 @ 80), (N/A, 30), (N/A)
> 
> phy#1 (self-managed)
> country IN: DFS-FCC
>         (2402 - 2472 @ 40), (N/A, 30), (N/A)
>         (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
>         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW
> 
> phy#0 (self-managed)
> country IN: DFS-FCC
>         (2402 - 2472 @ 40), (N/A, 30), (N/A)
>         (5170 - 5250 @ 80), (N/A, 30), (N/A), AUTO-BW
>         (5250 - 5330 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (N/A, 24), (0 ms), DFS, AUTO-BW
>         (5735 - 5835 @ 80), (N/A, 30), (N/A), AUTO-BW
> 
> # iw list
> Wiphy phy1
> Frequencies:
>                         * 2412 MHz [1] (30.0 dBm)
>                         * 2417 MHz [2] (30.0 dBm)
>                         * 2422 MHz [3] (30.0 dBm)
>                         * 2427 MHz [4] (30.0 dBm)
>                         * 2432 MHz [5] (30.0 dBm)
>                         * 2437 MHz [6] (30.0 dBm)
>                         * 2442 MHz [7] (30.0 dBm)
>                         * 2447 MHz [8] (30.0 dBm)
>                         * 2452 MHz [9] (30.0 dBm)
>                         * 2457 MHz [10] (30.0 dBm)
>                         * 2462 MHz [11] (30.0 dBm)
>                         * 2467 MHz [12] (disabled)
>                         * 2472 MHz [13] (disabled)
>                         * 2484 MHz [14] (disabled)
> 
> Wiphy phy0
> Frequencies:
>                         * 5180 MHz [36] (30.0 dBm)
>                         * 5200 MHz [40] (30.0 dBm)
>                         * 5220 MHz [44] (30.0 dBm)
>                         * 5240 MHz [48] (30.0 dBm)
>                         * 5260 MHz [52] (24.0 dBm) (radar detection)
>                         * 5280 MHz [56] (24.0 dBm) (radar detection)
>                         * 5300 MHz [60] (24.0 dBm) (radar detection)
>                         * 5320 MHz [64] (24.0 dBm) (radar detection)
>                         * 5500 MHz [100] (24.0 dBm) (radar detection)
>                         * 5520 MHz [104] (24.0 dBm) (radar detection)
>                         * 5540 MHz [108] (24.0 dBm) (radar detection)
>                         * 5560 MHz [112] (24.0 dBm) (radar detection)
>                         * 5580 MHz [116] (24.0 dBm) (radar detection)
>                         * 5600 MHz [120] (24.0 dBm) (radar detection)
>                         * 5620 MHz [124] (24.0 dBm) (radar detection)
>                         * 5640 MHz [128] (24.0 dBm) (radar detection)
>                         * 5660 MHz [132] (24.0 dBm) (radar detection)
>                         * 5680 MHz [136] (24.0 dBm) (radar detection)
>                         * 5700 MHz [140] (24.0 dBm) (radar detection)
>                         * 5720 MHz [144] (24.0 dBm) (radar detection)
>                         * 5745 MHz [149] (30.0 dBm)
>                         * 5765 MHz [153] (30.0 dBm)
>                         * 5785 MHz [157] (30.0 dBm)
>                         * 5805 MHz [161] (30.0 dBm)
>                         * 5825 MHz [165] (30.0 dBm)
>                         * 5845 MHz [169] (disabled)
>                         * 5865 MHz [173] (disabled)
> 
> Looks like ath11k restricts the maximum EIRP to 30 dBm for 2.4 GHz.
> Again I am not an expert so I can't comment on whether 30 dBm vs 36
> dBm is the correct maximum EIRP value for 2.4 GHz.

I find the rules in GSR No. 45(E) unclear and a little confusing.
Broadly you can think of EIRP(dBm) = tx_output_power(dBm) +
antenna_gain(dBi). If you look at the US rules [1] you can see that it
specifies EIRP assuming an antenna gain of 6 dBi or less, with
adjusments for antennas with larger gains.

GSR No. 45(E) does not define things as clearly, but when I see a
transmitter output power of 30 dBm and a maximum effective radiated
power of 36 dBm it leads me to think that it has a similar model of
assuming an antenna gain <= 6 dBi. I could be wrong, but from what I see
this interpretation makes the most sense to me.

30 dBm is certainly a safe value though, as the max EIRP should be at
least that much under any interpretation.

[1] https://www.ecfr.gov/current/title-47/chapter-I/subchapter-A/part-15/subpart-C/subject-group-ECFR2f2e5828339709e/section-15.247

Thanks,
Seth
