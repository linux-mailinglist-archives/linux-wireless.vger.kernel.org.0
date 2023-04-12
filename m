Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5B66DEA33
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 06:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDLEK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 00:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLEK1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 00:10:27 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884641989
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 21:10:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id y187so227516iof.4
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1681272626; x=1683864626;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VZYQZZXSKkY5XF+HRC7BIDu33gku+iW28o7XYPgj2xI=;
        b=QVs/CPhXjNp617XvjBXeFaRN6OFeKqISFKPFD3+WiwALH+0WSX7NxJag6IveNaCIhm
         x4cnszHkVAUuZKAhPwMdL/+o3hWS4enDBC888Xry6NH+468G0xH51pgxg1O8YTxfT1Ro
         ujGxcy+BpIOlTKLzUdz7K3S+pXLnUmD7uzaFA2OV1vjPltgPCwlapwdENyUfLtytyJcq
         SdfIWHiM/z8lXA4JDZpdqu5TS/rlINsTk/gPHiwHjuwE7lPqlWyvxO0S5/PzjDQLJloE
         8z7ZRYBcpam0e4sO4Y5/iXWdihoGAhxrCkZbLLguIbrznkTwXXGsqyJoZCxu0/Gq8rdr
         8s/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681272626; x=1683864626;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZYQZZXSKkY5XF+HRC7BIDu33gku+iW28o7XYPgj2xI=;
        b=gzjpNwdRWGbaNFtA0D/Q40DWao9tZQyfydrbjhNDKNbXGDgGU/r3s0Xtt1whuUz3Kj
         ctjQOa+yaXC7Bk3tu+Qm3ssLLP/XGHbU+CAmmCe9Ml6BriJFWnPJ5o86QzinPbYtWw8B
         rG/U33bsPuS3/vqnDMpwgi7okSjH3vOjVU61tzI2QUuoHVqqKGyV+mf6A3v/4Awwhbbc
         CiauwRpiE7Z1UTIwAQhfekQ7cpSl2MYZ6BczqKOzUvn2biPNxXKMvzb0TJ4RkA/YRqyF
         oE9/AMRXPEhCBghWBl2+k7oYIAGunKyGR4Us6mPsD5+VZJ/5m0kCc/oTHKQo3907CQlc
         P0rw==
X-Gm-Message-State: AAQBX9cniVc98WV5Ii+5/5LHomIA8KvM2/w7OzwDQ46ZStt37veK0VXc
        YCSBxp1BmK+4jDsQThabsh1t
X-Google-Smtp-Source: AKy350bzsXVNdqSp9MaWwwBLAdIRWMMeWi4UskDl4tPC3Nb57FHG4Q1hSbm5LNTvPxq7P5TvvJC3sA==
X-Received: by 2002:a6b:f30d:0:b0:74c:91c7:8794 with SMTP id m13-20020a6bf30d000000b0074c91c78794mr9334603ioh.21.1681272625812;
        Tue, 11 Apr 2023 21:10:25 -0700 (PDT)
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id q20-20020a5ea614000000b0074ca5ac5037sm4037472ioi.26.2023.04.11.21.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 21:10:25 -0700 (PDT)
Message-ID: <6c661903ad35a4619aeb8c642998b9f21883b0c1.camel@egauge.net>
Subject: Re: wilc1000: AP mode issue
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 11 Apr 2023 22:10:20 -0600
In-Reply-To: <bdd4f49a-213a-bf55-1c29-d74e56221795@microchip.com>
References: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
         <bdd4f49a-213a-bf55-1c29-d74e56221795@microchip.com>
Organization: eGauge Systems LLC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2023-04-12 at 00:33 +0000, Ajay.Kathat@microchip.com wrote:
> Hi David,
>=20
> On 4/11/23 14:08, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Ajay,
> >=20
> > I'm just starting to investigate an issue with the wilc1000 driver that=
 occurs
> > when it is operating as an access point.  I came across this thread:
>=20
> What is the issue observed with the AP mode.

I'm still working on simplifying the test case.  Right now, it's rather
complex:

 1) Connect wlan0 in managed mode to an existing access point.
 2) Create a virtual interface wlan0 (iw dev wlan0ap interface add
wlan0ap type __ap)
 3) Set up a captive portal on wlan0ap (iptables rules, web server,
dnsmasq)
 3) Start hostapd on wlan0ap

Once that's done, use a smartphone or any other client device to
connect to the captive portal's SSID.  The captive portal redirects any
HTTP requests to the portal's web server.

Now, when the client starts downloading pages from the web server,
something bad happens in the wilc1000.  The connections to the web
server get stuck and wilc1000 stops broadcasting the hostapd's SSID.
There are no error message (even with debug enabled in wilc1000).

Depending on the client device, the problems appears sooner or later.
For example, with Android 13, the problem happens infrequently but
with iOS or Android 9, it happens rather reliably and early on (within
the first few KiB of data transmission).

> >=20
> >   https://lore.kernel.org/linux-wireless/87pmkmylex.fsf@kernel.org/
> >=20
> > and was wondering if there has been progress towards converting the dri=
ver to
> > use the nl80211-based TX/RX interface.  If so, is this something that's
> > available somewhere or could be shared?
> >=20
>=20
> I haven't started working on this part yet. After completing few pending
> ongoing patches. I will look into this.

Great!

Best regards,

  --david
