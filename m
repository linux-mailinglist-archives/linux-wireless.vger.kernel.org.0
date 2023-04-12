Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAFF6DFEF6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 21:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjDLTrj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 15:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLTri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 15:47:38 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5D25FF3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 12:47:14 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id v126so5766887ioe.8
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1681328833; x=1683920833;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GRTF79gjc7lMfH+ujP6xeZNt7aimjgNl/rQJsSEnDx4=;
        b=k+GXVVPKdusm70RCX3MOm3SqFgQGwjYK7KdOKNAYrbsL+swiYFxgEXM5e4uzA+Li8Y
         2O1dYzUh7OnsrBsz8KxBwFyQ9WU0e4SMi2GgMo9ZT5byl7yM6CmWByKuP1OD2MXjvYwV
         MD2kT6EY7bUEB75q5oOU/NLuwRbpbv7CXB4Y42rqokheLPZFcqpJP3KeCEzhcKe/9yrO
         Yug31vC3SG8gV/ntQgLlUouihUrjfoUDCyZXMuwCN+cxY7tn/h3BoxZH/BgIkr8VSJLp
         iyAfuMJfTVqBbaAuSvKCnU58F4XnoU2cgRLphgVXtD8fRTzIjWa8gIyCP+0P1dbkHiUV
         x5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328833; x=1683920833;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GRTF79gjc7lMfH+ujP6xeZNt7aimjgNl/rQJsSEnDx4=;
        b=fLNLzkUMiv24o+xuePU1WexUiQIowSZCZtMKskxbLoUz9BdfmCABEammFhYA+mKspf
         5p9+bgjwMNSatyADDPcFvz1eTicTHN1mw2tXnUqVMjI/3M4cUDbXKhDvE21uWWi7A4ro
         gsb+JRFnKnHgZ3+U9qbduSz8XO5CIFASjwD39ipoa3p5PSFsDUZZ/X4/wmt2LgLGe0WV
         lppwlVGDI6HI1beZKnRckFR8iAFfmXCwjaC7DioEvTnlBSwPi5LF5hbflRonXpNIyUAD
         Y4xIJBPD6W0tPsPSjdp7yD7NVXyUpngoXjB9U3VPQMOg8USgkBvKa7Cbl1jNnmNC4M6m
         zL1A==
X-Gm-Message-State: AAQBX9fFVtMyr48/iEAsQnjwqExkeD4UMozycevpwEkRaBaOwGjFYeEs
        gC2l5hdXBOTyU6vJ5Vf4XOw0K/Nbco4qyAD7zg==
X-Google-Smtp-Source: AKy350YY8ojQ3YJhTfscBLWZ3bKgoWNH0FEnpHa7829dSIZvqyyyzEb0Au1aEiNRUQHbJy2VxO8B7Q==
X-Received: by 2002:a6b:610d:0:b0:753:876:5bf9 with SMTP id v13-20020a6b610d000000b0075308765bf9mr11619256iob.6.1681328833567;
        Wed, 12 Apr 2023 12:47:13 -0700 (PDT)
Received: from [10.1.100.16] ([76.130.90.80])
        by smtp.gmail.com with ESMTPSA id bv14-20020a056638448e00b003c2b67fac92sm5003854jab.81.2023.04.12.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:47:13 -0700 (PDT)
Message-ID: <5fb4291c1d97f42e0d4904cd2f316326efd6003a.camel@egauge.net>
Subject: Re: wilc1000: AP mode issue
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 12 Apr 2023 13:47:12 -0600
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

Ajay,

OK, here is a simpler test case:

- Setup wlan0 to connect to an existing access point.
  In my case, wlan0 ends up with IP address 172.17.2.230.

- Start hostapd on wlan0tst with these commands:

---
cat > hostapd-wlan0tst.conf <<EOF
interface=3Dwlan0tst
hw_mode=3Dg
channel=3D6
ieee80211n=3D1
wmm_enabled=3D1
ssid=3DWLAN0TST
wpa=3D2
wpa_passphrase=3DSOME_PASSWORD
EOF
iw dev wlan0 interface add wlan0tst type __ap
ip link set dev wlan0tst address 12:34:56:78:9a:bc
ip addr add 10.234.193.42/24 dev wlan0tst
hostapd hostapd-wlan0tst.conf
---

- Connect another computer to WLAN0TST

When I try the above, usually WLAN0TST works fine but as soon as it starts =
up,
pings to 172.17.2.230 stop.  Sometimes, WLAN0TST starts up fine, but after =
a few
seconds, the client's connection gets shut down and WLAN0TST stops
working (or even being advertised).  When that happens, pings to 172.17.2.2=
30
start working again.

I don't think the issue is really AP-mode specific though.  I also see issu=
es
when trying to create a virtual interface that connects to another access p=
oint:

- Setup wlan0 to connect to an existing access point.
- Start a second connection to another access point:

---
iw dev wlan0 interface add wlan0tst type managed
ip link set dev wlan0tst address 12:34:56:78:9a:bc
ip addr add 10.0.0.88/24 dev wlan0tst
wpa_supplicant -s -B -Dnl80211 -i wlan0tst -c /home/eguser/wlan0tst.conf
---

In this case, too, traffic on wlan0 and WLAN0TST seem to affect each other.

Interestingly, in this case, I can bring back the non-working connection by
issuing a "wpa_cli reassociate" command.  This will bring back the non-work=
ing
connection, but break the one that had been working fine before (to bring b=
ack
the WLAN0TST connection, you'd have to use "wpa_cli -p /var/run/wpa_supplic=
ant-
wlan0tst reassociate").

  --david

