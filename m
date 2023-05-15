Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C870703EB3
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbjEOUiE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 16:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOUiC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 16:38:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296F04C3A
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:37:56 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9659e9bbff5so2456968366b.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 13:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684183074; x=1686775074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXhaE8eVILO+tR4ij/Ws5fxM97MmGmKmEwxnE5sIbw4=;
        b=mMnpxwaPnkTJCFI67d4Fkez1MjTiYsm2iorf4pdvoX31o7Q0Uv+us49onRU+141Bgt
         nzxN3paMovI9BDd7C28GCzj1GG4KCk3kRo5FWCQ+LRNJ6PtDn02CksHUtpJgm8hbLFYy
         e+zMGMTP9oUb8OjLK6z5ngwuqapObGA9KQWFsS8UJPnIl+VpV6gQ/iSiCVR/2zccwTBb
         y5E0ooTv0K7TFO+OLB1/84HeHXlt39Se6Rqt/fGHNmd/R2ZeIqzkI/DBZt9GToV89EoN
         gDIVN87SnWA0ucVKSEluOOmI93JGxAT0nB+WolzaqK89CYr9otxm7X4Slts/BLJSj/aM
         zcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684183074; x=1686775074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fXhaE8eVILO+tR4ij/Ws5fxM97MmGmKmEwxnE5sIbw4=;
        b=cHuybsecQeTgbO5DGxUcoGaDQrElEQwMmPV8Nmp6lck+UQPkjvZa7wnZ16QTIPAzsn
         yTbGLF7noNy6b2AyQmxspnuxP0aPusle/QCy8QgyHVhHOzMELo99THUbJCMWHPCTc5Ts
         SGIBvty2hZW7T6vVMSvRDMo6KjFekzCUEehRbrfZWMi7OME5hvNSwHRxC6K2IdJb9ub0
         acMI+fHzp4XCe4knLbydKk6KCA/9F19hz2IKyoi9LtDj+is2tpXdUW0zzMts7fJQtz2S
         69IaGVrkJva/NBVvFoLBXcO2nfPMuuPCrriAGbO4pb2IbrLYjtSSZagaslaM3+2VqrEI
         1XGw==
X-Gm-Message-State: AC+VfDxapGWbsFetbHHhepfV343x/ND8eeldX1aLGY7DB5evu3x1aa3g
        oKIEGuRdJjdd3yCVdM84KIfug6kgTZG2cA==
X-Google-Smtp-Source: ACHHUZ5ei7lPZWHY4rn//+FRTDjr4r9QcCEh4fgSvncsdHbGB5tGeKxcRP31fB/D8x9wZfZ03obKhA==
X-Received: by 2002:a17:907:c10:b0:95e:e0fa:f724 with SMTP id ga16-20020a1709070c1000b0095ee0faf724mr32540700ejc.39.1684183074378;
        Mon, 15 May 2023 13:37:54 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id z25-20020a17090674d900b0096ac3e01a35sm4683960ejl.130.2023.05.15.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 13:37:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Driver for rtw8723ds
Date:   Mon, 15 May 2023 22:37:52 +0200
Message-ID: <1855371.CQOukoFCf9@jernej-laptop>
In-Reply-To: <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <3162376.5fSG56mABF@jernej-laptop>
 <cee4e4f8-78e9-1bf7-c1a9-8ae5c662c785@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart23073585.6Emhk5qWAg"
Content-Transfer-Encoding: 7Bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--nextPart23073585.6Emhk5qWAg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne ponedeljek, 15. maj 2023 ob 22:23:39 CEST je Larry Finger napisal(a):
> On 5/15/23 11:43, Jernej =C5=A0krabec wrote:
> > Dne sobota, 13. maj 2023 ob 23:21:47 CEST je Larry Finger napisal(a):
> >> On 5/13/23 15:13, Jernej =C5=A0krabec wrote:
> >>> Dne sobota, 13. maj 2023 ob 21:55:51 CEST je Larry Finger napisal(a):
> >>>> On 5/13/23 05:23, Jernej =C5=A0krabec wrote:
> >>>>> Larry,
> >>>>>
> >>>>> Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
> >>>>>> On 5/10/23 16:07, Martin Blumenstingl wrote:
> >>>>>>> On Wed, May 10, 2023 at 12:02=E2=80=AFAM Larry Finger <Larry.Fing=
er@lwfinger.net> wrote:
> >>>>>>> [...]
> >>>>>>>> I added that patch to the driver. The user reports that he was a=
ble to do a ping
> >>>>>>>> and an nslookup before it crashed with the following in the log:
> >>>>>>> That's some positive news alongside the crash log: it seems that a
> >>>>>>> part of the driver works! :-)
> >>>>>>>
> >>>>>>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len=
:3341 put:3341
> >>>>>>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0=
 dev:<NULL>
> >>>>>>> [...]
> >>>>>>>> Somehow skb->tail was greater than skb->end. Unfortunately I do =
not have access
> >>>>>>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50=
 on the MangoPi
> >>>>>>>> MQ Quad.
> >>>>>>> I need to have a closer look at the pkg_offset and struct
> >>>>>>> rtw_rx_pkt_stat which we receive.
> >>>>>>> Recently my own MangoPI MQ-Quad arrived but I did not have the ti=
me to
> >>>>>>> set it up yet. I'll try to do so during the weekend so I can debug
> >>>>>>> this on my own.
> >>>>>>>
> >>>>>>> Please ping me next week in case I haven't provided any update un=
til then.
> >>>>>>
> >>>>>> I have some test prints in to check for skb overrun. My initial in=
dication is
> >>>>>> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but m=
y next run
> >>>>>> should verify that. My changes will do a pr_warn_once() when the p=
roblem
> >>>>>> happens, and then drop the skb.
> >>>>>>
> >>>>>> My contact reported that he had one run of 3 minutes before the pr=
oblem
> >>>>>> happened, which is good news for most of the driver.
> >>>>>
> >>>>> I may have discovered something interesting. rtl8723ds vendor drive=
r has
> >>>>> following checks in RX data parsing code:
> >>>>> https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio=
/rtl8723ds_recv.c#L83-L99
> >>>>>
> >>>>> Those checks are absent in rtl8822bs vendor driver, which was my or=
iginal
> >>>>> development platform for SDIO. This may indicate some kind of bug i=
n FW
> >>>>> and/or HW.
> >>>>>
> >>>>> I think that at least second check, which checks for exactly the ca=
se your
> >>>>> client experience, can be easily added and tested.
> >>>>
> >>>> Thanks for this update. I added the following to the start of rtw_sd=
io_rx_skb():
> >>>>           /* fix Hardware RX data error, drop whole recv_buffer */
> >>>>           if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
> >>>>                   kfree_skb(skb);
> >>>>                   return;
> >>>>           }
> >>>> I think that duplicates the code in the vendor driver.
> >>>>
> >>>> I have not heard from my user as to whether it helps. My communicati=
ons with him
> >>>> are at https://github.com/lwfinger/rtl8723ds/issues/37.
> >>>
> >>> I had second part in mind (see attachment), but this is IMO only sani=
ty check
> >>> and it will mask the issue. At this point I'm not sure if this is som=
ething that
> >>> can happen occasionally or is there additional bug in rtw88 code. I'l=
l check
> >>> rtl8723ds c2h code in greater detail.
> >>>
> >>> In any case, I would argue that all 3 patches in this thread are vali=
d and
> >>> should be submitted upstream.
> >>
> >> That patch looks good. I ill apply it to my rtw88 repo.
> >=20
> > I see that issue is still there. Next idea would be to check if RX aggr=
egation
> > is the problem. Just commenting out call to rtw_sdio_enable_rx_aggregat=
ion()
> > is enough to disable it.
>=20
> Jernej,
>=20
> With aggregation disabled, we still get "Invalid RX packet size!" message=
s. I am=20
> changing the statement to log (curr_pkt_len + pkt_desc_sz) > rx_len. I wi=
ll let=20
> you know when the OP responds.

Yeah, I saw. I just find another possible reason, which fits nicely in curr=
ent
situation. Vendor driver parses drv_info_sz and shift fields only if packet
is normal, e.g. not c2h type. However, rtw88 always parses those fields. It=
's
possible that they have some value which should be ignored on 8723ds. I
appended another patch to test.

If this doesn't work, I'm out of ideas.

Best regards,
Jernej


--nextPart23073585.6Emhk5qWAg
Content-Disposition: attachment; filename="sdio-size.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="sdio-size.patch"

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index af0459a79899..6f9fda758eb7 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -969,13 +969,20 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
 		rx_desc = skb->data;
 		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
 					 &rx_status);
-		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
-			     pkt_stat.shift;
+		pkt_offset = pkt_desc_sz;
+		if (!pkt_stat->is_c2h)
+			pkt_offset += pkt_stat.drv_info_sz + pkt_stat.shift;
 
 		curr_pkt_len = ALIGN(pkt_offset + pkt_stat.pkt_len,
 				     RTW_SDIO_DATA_PTR_ALIGN);
 
-		if ((curr_pkt_len + pkt_desc_sz) >= rx_len) {
+		if ((curr_pkt_len + pkt_desc_sz) > rx_len) {
+			dev_warn(rtwdev->dev, "Invalid RX packet size!");
+			dev_kfree_skb_any(skb);
+			return;
+		}
+
+		if ((curr_pkt_len + pkt_desc_sz) == rx_len) {
 			/* Use the original skb (with it's adjusted offset)
 			 * when processing the last (or even the only) entry to
 			 * have it's memory freed automatically.

--nextPart23073585.6Emhk5qWAg--



