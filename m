Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F201701999
	for <lists+linux-wireless@lfdr.de>; Sat, 13 May 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjEMUNp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 May 2023 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjEMUNo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 May 2023 16:13:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDF269F
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 13:13:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50db91640d3so9163310a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 13 May 2023 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684008821; x=1686600821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEErDdrJn25oBFjvI56TXsq/CzMc14Vwk/YUKzC7yzQ=;
        b=hH01tPLj7haED0K36mpb4S++wo2dR2eE2fV8xCzaerRG0yC8dX7sP1rkvQn+A97Zxg
         7Cq2rERjjqDOYjNtREzyFAQr+V/U418crKnbPlEHSOMDb53r5Zju4tAaSIy9JyFtzx06
         udVmzCPIRVke9why8CIYp1NJz2mmZSyYGMPKDG8by4QeIXN/p4PJtSkxOAgAYYmCEBwh
         bz5ktajDMy5JkDXsKCukBqrgMkZkxLOiUT+d1uW8Z2bHVo7HJ0HeVaHKYy+/+yJzoljx
         dwyVlomCdRTpcXBX6+KUmL6O3WvRlOnb/8BsAdOL/GBq4qvMbi1Pk8Pp3eBoqH7F9Ixu
         q5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684008821; x=1686600821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kEErDdrJn25oBFjvI56TXsq/CzMc14Vwk/YUKzC7yzQ=;
        b=esyRLjYvm0KcMBUz/7S/xwNwJka42zhpO4pIewL7kEGIqidhEwj2F6B7uUBa+PIclX
         tgzWt+yhLJYvMxMMixQHlGqXKjxwFdWX5P8EDN+RJrK+RRNLdw69Zqpw49yInA6ygWRG
         dPnFsMxvgiCekuTu6PyUSwVO2W+5A68RGdk8toLMv3+SdPbwOu7Sp+z+qMksmbsSus7a
         wqfioKq+zapWXItvCHmaDfedoG8Kc85wM+dyQBDg3xyZutdwdWtRE/ubWYThqWDsysNB
         E32Ge3hD4meGMvLdXqSgJh6yGiB4B9/PGtWdjgBOaw1equCR0wcrakOnpSJ2gyCQEyn6
         ihrg==
X-Gm-Message-State: AC+VfDz0h8y8dYFvDQ/+bbbLOazFxXiOSzNqXhYLBId4zH2clUntsOwu
        Nq4TvBXSC+1vfLv5/JDGo+tLNNyyuzSerA==
X-Google-Smtp-Source: ACHHUZ758z0Qh8lrIbbxucqIrrI+8OptlO6Bt3H2urkRuRQ8J7iPUUzMHELwg2jhq2ejW2ZljiHhjA==
X-Received: by 2002:a05:6402:1a5b:b0:50b:c475:4f8b with SMTP id bf27-20020a0564021a5b00b0050bc4754f8bmr20628182edb.15.1684008821137;
        Sat, 13 May 2023 13:13:41 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id u24-20020a056402111800b0050bc4eb9846sm5206600edv.1.2023.05.13.13.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 13:13:40 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: Driver for rtw8723ds
Date:   Sat, 13 May 2023 22:13:39 +0200
Message-ID: <21872829.EfDdHjke4D@jernej-laptop>
In-Reply-To: <f3368bf9-c6e6-f418-41da-b9de185acd34@lwfinger.net>
References: <72a8eeb1-c91c-80a7-5a09-1b7963e0996b@lwfinger.net>
 <13262218.uLZWGnKmhe@jernej-laptop>
 <f3368bf9-c6e6-f418-41da-b9de185acd34@lwfinger.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart7520481.EvYhyI6sBW"
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

--nextPart7520481.EvYhyI6sBW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dne sobota, 13. maj 2023 ob 21:55:51 CEST je Larry Finger napisal(a):
> On 5/13/23 05:23, Jernej =C5=A0krabec wrote:
> > Larry,
> >=20
> > Dne sreda, 10. maj 2023 ob 23:47:24 CEST je Larry Finger napisal(a):
> >> On 5/10/23 16:07, Martin Blumenstingl wrote:
> >>> On Wed, May 10, 2023 at 12:02=E2=80=AFAM Larry Finger <Larry.Finger@l=
wfinger.net> wrote:
> >>> [...]
> >>>> I added that patch to the driver. The user reports that he was able =
to do a ping
> >>>> and an nslookup before it crashed with the following in the log:
> >>> That's some positive news alongside the crash log: it seems that a
> >>> part of the driver works! :-)
> >>>
> >>>> [    8.700626] skbuff: skb_over_panic: text:ffff8000011924ac len:334=
1 put:3341
> >>>> head:ffff000003b3c000 data:ffff000003b3c040 tail:0xd4d end:0x2c0 dev=
:<NULL>
> >>> [...]
> >>>> Somehow skb->tail was greater than skb->end. Unfortunately I do not =
have access
> >>>> to gdb to tell you what line corresponds to rtw_sdio_rx_skb+0x50 on =
the MangoPi
> >>>> MQ Quad.
> >>> I need to have a closer look at the pkg_offset and struct
> >>> rtw_rx_pkt_stat which we receive.
> >>> Recently my own MangoPI MQ-Quad arrived but I did not have the time to
> >>> set it up yet. I'll try to do so during the weekend so I can debug
> >>> this on my own.
> >>>
> >>> Please ping me next week in case I haven't provided any update until =
then.
> >>
> >> I have some test prints in to check for skb overrun. My initial indica=
tion is
> >> that the problem was in the c2h branch of rtw_sdio_rx_skb(), but my ne=
xt run
> >> should verify that. My changes will do a pr_warn_once() when the probl=
em
> >> happens, and then drop the skb.
> >>
> >> My contact reported that he had one run of 3 minutes before the problem
> >> happened, which is good news for most of the driver.
> >=20
> > I may have discovered something interesting. rtl8723ds vendor driver has
> > following checks in RX data parsing code:
> > https://github.com/lwfinger/rtl8723ds/blob/master/hal/rtl8723d/sdio/rtl=
8723ds_recv.c#L83-L99
> >=20
> > Those checks are absent in rtl8822bs vendor driver, which was my origin=
al
> > development platform for SDIO. This may indicate some kind of bug in FW
> > and/or HW.
> >=20
> > I think that at least second check, which checks for exactly the case y=
our
> > client experience, can be easily added and tested.
>=20
> Thanks for this update. I added the following to the start of rtw_sdio_rx=
_skb():
>         /* fix Hardware RX data error, drop whole recv_buffer */
>         if (!(rtwdev->hal.rcr & BIT_ACRC32) && pkt_stat->crc_err) {
>                 kfree_skb(skb);
>                 return;
>         }
> I think that duplicates the code in the vendor driver.
>=20
> I have not heard from my user as to whether it helps. My communications w=
ith him=20
> are at https://github.com/lwfinger/rtl8723ds/issues/37.

I had second part in mind (see attachment), but this is IMO only sanity che=
ck
and it will mask the issue. At this point I'm not sure if this is something=
 that
can happen occasionally or is there additional bug in rtw88 code. I'll check
rtl8723ds c2h code in greater detail.

In any case, I would argue that all 3 patches in this thread are valid and
should be submitted upstream.

Best regards,
Jernej


--nextPart7520481.EvYhyI6sBW
Content-Disposition: attachment; filename="sdio-size-check.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="utf-8"; name="sdio-size-check.patch"

diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
index af0459a79899..d69ce76ad0f4 100644
--- a/drivers/net/wireless/realtek/rtw88/sdio.c
+++ b/drivers/net/wireless/realtek/rtw88/sdio.c
@@ -975,7 +975,13 @@ static void rtw_sdio_rxfifo_recv(struct rtw_dev *rtwdev, u32 rx_len)
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

--nextPart7520481.EvYhyI6sBW--



