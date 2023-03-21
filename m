Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9176C31BC
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 13:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCUMcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 08:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCUMcE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 08:32:04 -0400
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 05:32:00 PDT
Received: from m204-238.eu.mailgun.net (m204-238.eu.mailgun.net [161.38.204.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071561715
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 05:31:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=hewittfamily.org.uk;
 q=dns/txt; s=s1; t=1679401917; x=1679409117; h=To: To: References:
 Message-Id: Content-Transfer-Encoding: Cc: Date: In-Reply-To: From: From:
 Subject: Subject: Mime-Version: Content-Type: Sender: Sender;
 bh=Q0oU83KV+dMxg0xhWNFs/sIjQr7woKc+7NDfK7Itp1o=;
 b=PqkwFUKNwxZGwY6+Sva1yLe5zVTNiqjpYxhfAZOIMom0f3OTCVcGAfsR1s8KWTJW2GjpYXW4MDbtS7kADGA6zuutmpPBVt/CrKxX1XzR0+MRrxo02FTtTqDP78zwUSqGmp0ppZdle5Lyrmfq24zqc12NwndNkrPAZszkRpUlQEd68HWhizspOhkoB61MNFoV707bYvk+GX0f729Q0Cc2DboLr4twxr/kBXbT/VOuuFWj1u/HWlTahtsoAM+S2yryeZrdZYkWLKr2fl/vby19PCGiZgnDb5AuhelLaWVVlOCm+up20/XKfsZQ0FyyG1yjTCNi0GiWMEdkORVJUmEi3g==
X-Mailgun-Sending-Ip: 161.38.204.238
X-Mailgun-Sid: WyJkZGUwZCIsImxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZyIsImUzNzIwIl0=
Received: from mail.hewittfamily.org.uk (<unknown> [87.200.95.144]) by 65d6cd48f507 with
 SMTP id 6419a2847874da44904fb5e6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Mar 2023 12:26:44 GMT
Sender: christian@hewittfamily.org.uk
Received: from smtpclient.apple (unknown [167.99.200.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.hewittfamily.org.uk (Postfix) with ESMTPSA id CDE507FA44E;
        Tue, 21 Mar 2023 16:26:35 +0400 (+04)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.2\))
Subject: Re: [Performance regression] BCM4359/9 on S905X2
From:   Christian Hewitt <christian@hewittfamily.org.uk>
In-Reply-To: <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
Date:   Tue, 21 Mar 2023 16:26:25 +0400
Cc:     Linux Wireless <linux-wireless@vger.kernel.org>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Alexander Prutskov <alep@cypress.com>,
        Joseph chuang <jiac@cypress.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Pierre-Hugues Husson <phh@phh.me>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EEE9FD80-C106-4A9B-AA8D-5C151E540CFD@hewittfamily.org.uk>
References: <b9bd16cb-f1fa-34b7-d599-8637cbe5032b@free.fr>
 <1jh6ue74x9.fsf@starbuckisacylon.baylibre.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: Apple Mail (2.3696.120.41.1.2)
X-Synology-Spam-Status: score=2.909, required 5, MV_CASE 0.5, __THREADED 0, TO_DN_ALL 0, FREEMAIL_TO 0, RCVD_COUNT_ZERO 0, FROM_EQ_ENVFROM 0, MIME_TRACE 0, __NOT_SPOOFED 0, __BODY_URI_ONLY 0, MID_RHS_MATCH_FROM 0, NO_RECEIVED -0.001, FROM_HAS_DN 0, FREEMAIL_ENVRCPT 0, TO_MATCH_ENVRCPT_ALL 0, TAGGED_RCPT 0, MIME_GOOD -0.1, RCPT_COUNT_TWELVE 0, __HDRS_LCASE_KNOWN 0, SUSPICIOUS_RECIPS 2.51
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 21 Mar 2023, at 2:46 pm, Jerome Brunet <jbrunet@baylibre.com> =
wrote:
>=20
>=20
> On Tue 21 Mar 2023 at 11:40, Marc Gonzalez <marc.w.gonzalez@free.fr> =
wrote:
>=20
>> Hello everyone,
>>=20
>> I've been benchmarking an Amlogic S905X2 board.
>> It provides a BCM4359/9 WiFi chip connected through SDIO.
>>=20
>> There's a large performance gap between vendor kernel and mainline.
>> (Downloading a 1GB file to /dev/null from a device inches away)
>=20
> The title is misleading. You are comparing different sources. This is
> not a regression. This is merely a difference.
>=20
> If we are talking about mainline, then which board is it ? What is the
> corresponding DT ? What is the MMC configuration in both case ? Have
> you checked you are running with the same clock configuration to begin
> with ?

[snip]

=
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/amlogic/=
meson-g12a-sei510.dts#L428

^ this device-tree (based on other chat with Marc)

To Jer=C3=B4me=E2=80=99s point; unless you=E2=80=99ve tweaked it =
upstream will be running
at 100MHz and the vendor kernel will be 200MHz, and maybe with other
high-speed modes activated. Most upstream device-trees are running a
conservative/safe configuration at 50MHz to avoid past speed-related
issues. As stability has improved over time most boards could be run
at faster speeds, but =E2=80=98performance=E2=80=99 is such subjective =
topic that it
would probably need a large amount of testing to convince people to
change the current defaults. That said (FWIW) I=E2=80=99ve bumped all =
boards
in my tree that consume the gx-p2xx-q2xx dtsi to 100MHz without any
attributable issues being flagged by users.

Christian

