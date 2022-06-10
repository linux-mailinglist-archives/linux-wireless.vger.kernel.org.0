Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE515466FA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343711AbiFJM7o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 08:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343724AbiFJM7m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 08:59:42 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18D33B63A9
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 05:59:41 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:59:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1654865977; x=1655125177;
        bh=sVj2GM456lr6QjLv3M21v1IPozj2Wc3ez3BTMa3ltFA=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=q0E2g+Rrfut0CO8xR7+FO+lbOleJ1TEhug6TX9mginhLPk3h2IjMyaryBRzjfHSWn
         r3F82KRDPEcBQYpl1loRkGD4mKRC5iv1moetuKZ0szeDlgpRyx8FDFJBZoaX2cKhpp
         EHDtRvZtOwOyBQvLTcM9aoWmDl0Lo2ZyTQ+OKOUTSC78pbZlgLJhruHRe3bxCLYwYb
         O/Ng8DMyY2N5PBW+b2+WcvMV7/RYVxQCff522VdUtHA7G6YAIcQ9iNq58KWZRjM4o5
         rB0qH0YbnecucEh3sqWfQnj09EoQHIr5u4WqMay1MdR1xCKbZiaR8/BKzYhWjDCJQ0
         MAB1oyw4h4dhQ==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Reply-To: rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>
Subject: rtw88_8821ce makes system freeze again since 5.18
Message-ID: <Te_PJvJjKCi-lK28Zu0d8VQG0AGdwTl6cJydYEETLbc3gN0l8liXH1DSOZnKxUHYGxavLBCs1sqos2e6jeiRzzO0RLRSISdWvTiiPp0v9kM=@protonmail.com>
Feedback-ID: 34463299:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

Since I updated the kernel to 5.18, the system has been freezing again, alm=
ost like in my previous report [0]. The only difference is that sometimes (=
rarely) I get some potentially useful messages right before the freeze. The=
se two appeared together:

rtw_8821ce 0000:02:00.0: failed to dequeue 221 skb TX queue 1, BD=3D0x00000=
001, rp 33 -> 0
rtw_8821ce 0000:02:00.0: failed to dequeue 33 skb TX queue 1, BD=3D0x002300=
23, rp 0 -> 35

And this one appeared on a different occasion before a freeze:

rtw_8821ce 0000:02:00.0: failed to dequeue 3905 skb TX queue 1, BD <cut off=
 by browser window on top of terminal>

Before I saw those messages, I thought maybe this change was at fault:

  /* Disable PCIe ASPM L1 while doing NAPI poll for 8821CE */
- if (pdev->device =3D=3D 0xc821 && bridge->vendor =3D=3D PCI_VENDOR_ID_INT=
EL)
+ if (rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8821C && bridge->vendor =3D=3D =
PCI_VENDOR_ID_INTEL)
=09rtwpci->rx_no_aspm =3D true;

but it's not. I verified that the chip type is still detected correctly and=
 rx_no_aspm is set to true. And yet the system freezes.

My laptop's wifi card is RTL8821CE, type RFE 2. My laptop is HP 250 G7, mod=
el 6MQ29EA.

It happens within a few minutes after booting if I don't do anything out of=
 the ordinary. If I do a speed test at speedtest.net, the system usually fr=
eezes during the test. I have to hold the power button to shut it down.

disable_aspm=3D1 seems to help.

The freeze happens with the rtw88 driver from the 5.18-arch1-1 kernel from =
Arch Linux, and also with the rtw88 driver from lwfinger/rtw88, commit ce97=
958 ("rtw88: Bring code up to May 1 version of wireless-testing") [1].

I used the driver from the 5.17.1-arch1-1 kernel for a long time without pr=
oblems.

The firmware version is 24.11.0. I downgraded it to 24.8.0, which is what I=
 had before, but the system still froze.

I also tried kernel 5.17.1 with firmware 24.11.0 and the system did not fre=
eze.

[0] https://lore.kernel.org/linux-wireless/vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm=
1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=
=3D@protonmail.com/T/#u
[1] https://github.com/lwfinger/rtw88/commit/ce979583dff5fc2f6cbce354c3e2dc=
eafee454ca
