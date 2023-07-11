Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABE74EDDC
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jul 2023 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbjGKMP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jul 2023 08:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKMP1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jul 2023 08:15:27 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FF1E55
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 05:15:25 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf107so28586035e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Jul 2023 05:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689077724; x=1691669724;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmfhD0bL2a3VTTfFjo8AmouR1aIrAVqJrRswxaSovFE=;
        b=ny/gD12/xVNygR/wRKnt7q0ZNOPb5a8t/vNELSa1+8xdnQD06ifVMpF8FQr4OwYTMn
         Etl68Eaoa7UDycIAepzLepiytyh0Q9Kp8QwpOLZY5of45eXf9D7LWLSarzQrPeAmfuyq
         CAOGr+AWiLjH3808iBvTKPHOvo7pEW8q9pHSl4VHerxG9rAvZjaoaHq0A6yzvai70hsv
         rPJBobdPSZjwIh16Ky0QTq4AaXhVucLtv7u6EGYJoIgqIdKJ1QNRdQjgE3lan2uPEbPt
         fMAcf0rzAxhblLK805XIk+W3gFtC+Y1FGsqtu5thIUbLZrAkKEWTyRvLEu8hVIvDoYFD
         G61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689077724; x=1691669724;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kmfhD0bL2a3VTTfFjo8AmouR1aIrAVqJrRswxaSovFE=;
        b=FIKeaiL6PX9WjRsQlvPwdF8n9HCMoIlKF3x8KUIM+A2tmz9smkmyvt/oSzYYxnAfrD
         Y6WTjXAMKg3K0aCXfZ9s20uQQY4FhKllUyzBBtsyJrqriax4498K4jkUTiMtGriABBal
         RzPcMDZPgVp8bUz9CX9a9Aa3zpftoXKfpDWwGAzpKRIE2pc7Zn0C2oDB6TdckZLS9bcL
         nJnNFwCoMcG5jCB6j6pVTrlnSQPeQ+tMLzm11kFLfFGhsRivMRkpTKxTQpSPGfBV50Sv
         gTKfmTzYCSUp1+Z8YAbDzxlhL3j1/XGYIXKCW67mvUq/iSf3JbNCymxPu9xZFfjvUQ/+
         LVeg==
X-Gm-Message-State: ABy/qLa/TQ+mF+02q/wknn/IouTR3cMsOQOy49oEs81Z2wDC7FriGih4
        X/avqRHBPdR6yARkiiAp8UE=
X-Google-Smtp-Source: APBJJlEJ0xZiLKTgaMcBvbZfZN270CRivCCPpRWL9yPZui2z5r5TRt7LThL4TiW3mZT8WUrHlinUzQ==
X-Received: by 2002:adf:f8c3:0:b0:314:30ed:9b55 with SMTP id f3-20020adff8c3000000b0031430ed9b55mr10371811wrq.15.1689077723715;
        Tue, 11 Jul 2023 05:15:23 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id h2-20020adffa82000000b003140f47224csm2122505wrr.15.2023.07.11.05.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 05:15:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Jul 2023 14:15:22 +0200
Message-Id: <CTZC2XSCQF47.3QPNI1G4AXJLX@syracuse>
Cc:     <linux-wireless@vger.kernel.org>
Subject: Re: [regression] STP on 80211s is broken in 6.4-rc4
From:   "Nicolas Escande" <nico.escande@gmail.com>
To:     "Felix Fietkau" <nbd@nbd.name>,
        "Linux regressions mailing list" <regressions@lists.linux.dev>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Kalle Valo" <kvalo@kernel.org>,
        "Johannes Berg" <johannes.berg@intel.com>
X-Mailer: aerc 0.15.1
References: <CT5GNZSK28AI.2K6M69OXM9RW5@syracuse>
 <ZIQbs0wqdRh7c0Kx@debian.me>
 <a9d02800-2cd6-a27b-7998-4c97cf2eb692@leemhuis.info>
 <CTDWJJDKSYYD.XBG1CAZB3A5W@syracuse>
 <809500b6-4eec-7a5e-5930-00e7eeebcc5e@leemhuis.info>
 <CTYNAK10A6AJ.1I4W9V78VG1NB@syracuse>
 <4bb71d8a-daf1-5f60-daf0-44aa8afcfdc3@nbd.name>
In-Reply-To: <4bb71d8a-daf1-5f60-daf0-44aa8afcfdc3@nbd.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue Jul 11, 2023 at 1:12 PM CEST, Felix Fietkau wrote:
> On 10.07.23 18:50, Nicolas Escande wrote:
> > On Mon Jul 10, 2023 at 1:32 PM CEST, Linux regression tracking (Thorste=
n Leemhuis) wrote:
> >> On 16.06.23 09:45, Nicolas Escande wrote:
> >> > On Thu Jun 15, 2023 at 2:54 PM CEST, Linux regression tracking (Thor=
sten Leemhuis) wrote:
> >> >> On 10.06.23 08:44, Bagas Sanjaya wrote:
> >> >>> On Tue, Jun 06, 2023 at 12:55:57PM +0200, Nicolas Escande wrote:
> >> >>>>
> >> >>>> As user of the mesh part of mac80211 on multiple products at work=
 let me say
> >> >>>> thank you for all the work you do on wifi, especially on 80211s, =
and especially
> >> >>>> the recent improvements you made for mesh fast RX/TX & cross vend=
or AMSDU compat
> >> >>>>
> >> >>>> We upgraded our kernel from an older (5.15) to a newer 6.4. The p=
roblem is STP=20
> >> >>>> doesn't work anymore and alas we use it for now (for the better o=
r worse).
> >> >>>>
> >> >>>> What I gathered so far from my setup:
> >> >>>>  - we use ath9k & ath10k
> >> >>>>  - in my case STP frames are received as regular packet and not a=
s amsdu
> >> >>>>  - the received packets have a wrong length of 44 in tcpdump
> >> >>>>    (instead of 38 with our previous kernel)
> >> >>>>  - llc_fixup_skb() tries to pull some 41 bytes out of a 35 bytes =
packet
> >> >>>>    this makes llc_rcv() discard the frames & breaks STP
> >> >>>>
> >> >>>> >From bisecting the culprit seems to be 986e43b19ae9176093da35e0a=
844e65c8bf9ede7
> >> >>>> (wifi: mac80211: fix receiving A-MSDU frames on mesh interfaces)
> >> >>>>
> >> >>>> I guess that your changes to handle both ampdu subframes & normal=
 frames in the
> >> >>>> same datapath ends up putting a wrong skb->len for STP (multicast=
) frames ?
> >> >>>> Honestly I don't understand enough of the 80211 internals & spec =
to pinpoint the
> >> >>>> exact problem.
> >> >>>>
> >> >>>> It seems this change was already in the 6.3 kernel so I guess som=
eone should
> >> >>>> have seen it before (but I didn't find anything..) ? Maybe I miss=
ed something...
> >> >>>>
> >> >>>> Anyway I'm happy to provide more info or try anything you throw a=
t me.
> >> >> [...]
> >> >> Hmmm, Felix did not reply. But let's ignore that for now.
> >> >=20
> >> > I haven't seen mails from felix on the list for a few days, I'm gues=
sing he's
> >> > unavailable for now but I'll hapilly wait.
> >>
> >> Still no progress. Hmmm. Are you still okay with that? I've seen no
> >> other reports about this, so waiting is somewhat (albeit not completel=
y)
> >> fine for me if it is for you.
> > I'm not so surprised no one else reported it, using STP on wifi (and 80=
2.11s) is
> > not a really common thing to do, to be honest (and STP on wifi is unrel=
iable).
> > Even though some openwrt guys do it for sure, I'm guessing their kernel=
 version
> > is lagging behind...
> >>
> >> But in any case it might be good if you could recheck 6.5-rc1.
> > Testing on 6.5 as a whole won't be as easy for me as testing a single p=
atch on
> > top of 6.4. I'll do my best to try but from what I saw nothing got merg=
ed that
> > would even remotely help me on this issue.
> >=20
> > I am not loosing hope that Felix or someone that understands this stuff=
 better
> > finds the time to look into this. I'm guessing it's the summer vacation=
 effet.
>
> Sorry for the delay. This should fix the regression, please test.
> I will submit it for 6.5 soon.
> ---
> --- a/net/wireless/util.c
> +++ b/net/wireless/util.c
> @@ -580,6 +580,8 @@ int ieee80211_strip_8023_mesh_hdr(struct
>   		hdrlen +=3D ETH_ALEN + 2;
>   	else if (!pskb_may_pull(skb, hdrlen))
>   		return -EINVAL;
> +	else
> +		payload.eth.h_proto =3D htons(skb->len - hdrlen);
>
>   	mesh_addr =3D skb->data + sizeof(payload.eth) + ETH_ALEN;
>   	switch (payload.flags & MESH_FLAGS_AE) {

Great, that does the trick for me
Thanks Felix
