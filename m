Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102336C46EC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Mar 2023 10:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCVJtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Mar 2023 05:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCVJsc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Mar 2023 05:48:32 -0400
X-Greylist: delayed 86984 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 22 Mar 2023 02:48:05 PDT
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F640C4
        for <linux-wireless@vger.kernel.org>; Wed, 22 Mar 2023 02:48:05 -0700 (PDT)
Date:   Wed, 22 Mar 2023 09:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1679478471; x=1679737671;
        bh=Vu9sXw345MJzGZsnQJMa4pu7NVZO/y39aO8PDkRBTdQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=xd0y++MoorxY3nWPr1jPnMs2TzqjqQHeylVFUZIZ7UuU6LQw2CEeqocShDbwSITJ2
         72kwVshS7eY9b1BI/adA4aIwz8zdN1AvrUnbZ6dYC7lHYDf50KdR2lj81bT2zNJwx9
         RKK9pSnIPGJkD1Qh9bFY9UtzvZNodAFOr97SkQ51+5SvFayEIX5a561fJ/T70T7ik0
         BCC1KiZEecnxLM1eumPRVLXdt6+UN7n0m+5Yf6ihCIXXsDQjqjYa+a9qE7H+7UnKw7
         4sw6264QIi6MJg32ValhcN/6ItwocSI8OYuscv+2K+DPNWeEsmKaw+Z/IRCj+TeTyA
         rGsRLT/Q7m/ow==
To:     Julian Calaby <julian.calaby@gmail.com>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Re: [UPDATE 1] My TP-Link EX510 AX3000 Dual-Band Gigabit Wi-Fi 6 Router has a paper notice on GNU General Public License
Message-ID: <0rmO1_ZrtfwYcTQab-Pb42wke0KdsJO4FB-CnzMMrDcPCpn_dOmY8aChAdHNPnYohBRv8GZzeKu_jBXMsxyia7EqgZSJ0YmkL5aQq0pb6uU=@protonmail.com>
In-Reply-To: <CAGRGNgUh0uWbrGBB2twvxDFdxxfVWURak7eoyF6GOhOr1oyerg@mail.gmail.com>
References: <mOgCviHEICGnhcs-E4-bjujNqa-zCiAgIi5y0m52zJVaibD44ThQI3p4Minav8Tn1ENtVQt18DONTovuxdUJk6O68q0QRNIUwD582gRwxns=@protonmail.com> <CAGRGNgUh0uWbrGBB2twvxDFdxxfVWURak7eoyF6GOhOr1oyerg@mail.gmail.com>
Feedback-ID: 39510961:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

------- Original Message -------
On Tuesday, March 21st, 2023 at 7:02 PM, Julian Calaby <julian.calaby@gmail=
.com> wrote:


> Hi,
>=20
> On Tue, Mar 21, 2023 at 8:43=E2=80=AFPM Turritopsis Dohrnii Teo En Ming
> teo.en.ming@protonmail.com wrote:
>=20
> > Subject: [UPDATE 1] My TP-Link EX510 AX3000 Dual-Band Gigabit Wi-Fi 6 R=
outer has a paper notice on GNU General Public License
>=20
>=20
> [personal information removed]
>=20
> > My [snip] ISP has also given me a FREE TP-Link EX510 AX3000 Dual-Band G=
igabit Wi-Fi 6 Router [snip] Inside the packaging box there is a paper noti=
ce on GNU General Public License.
> >=20
> > I believe my tp-link Wi-Fi 6 wireless router is most likely running on =
an open source Linux operating system.
>=20
>=20
> Most likely, almost all of them do these days.
>=20
> > How can I find out what version of the Linux Kernel it is running on? I=
 think only Linux kernel 6.x support Wi-Fi 6. Am I right?
>=20
>=20
> Your device will be running a vendor kernel and drivers so it could be
> running just about any version of the kernel. The companies that
> develop the chipsets and SoCs in WiFi routers generally provide their
> own version of the Linux kernel with custom or proprietary drivers for
> the hardware in the device. These kernels are frequently outdated so
> there's no guarantee that it's a 6.x kernel.
>=20
> What are your goals for this device? Are you planning to just use it
> as-is or do you want to modify or replace the software in some way?
>=20
> If you're interested in what software is running on it, contact
> TP-Link: they should have a way for you to get the source code of the
> GPL licensed parts of the software on the device.
>=20
> If you're interested in installing a different operating system on it,
> I'd recommend taking this question to the OpenWRT forums.
>=20
> Finally, this isn't really the right forum for this discussion: this
> mailing list is specifically about the development of open source
> Linux drivers for WiFi hardware, e.g. PCI or USB devices and it's
> unlikely that your device is running those drivers. This is a question
> that is much better answered by forums which specifically discuss WiFi
> routers and embedded devices, for example the OpenWRT forums.
>=20
> Thanks,
>=20
> --
> Julian Calaby
>=20
> Email: julian.calaby@gmail.com
> Profile: http://www.google.com/profiles/julian.calaby/

Dear Julian Calaby,

I have already converted my TP-Link EX510 Wi-Fi 6 wireless router to access=
 point mode.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
GIMP also stands for Government-Induced Medical Problems
