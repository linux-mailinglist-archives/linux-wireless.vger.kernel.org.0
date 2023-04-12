Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7956E0230
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 00:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDLWyH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 18:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDLWyF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 18:54:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C482D109
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 15:54:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id x7so2108102ill.13
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 15:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egauge.net; s=google; t=1681340042; x=1683932042;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/FYJf/PoTUaGPEcG2nCig+6F91gf8C1q5/h0lDZxFg=;
        b=DmkTZjPKFZSp/k3bCp5A1RZSc4AQKLadQoVvPsgJIzNMLSN05fkaU2S4itDl59YgsO
         rGz1VYKqaEm2ebXyW/Rjao59UTES8l9EiVMFok8mhVBBbYoAL2Q8SukEqmCWrabaX1JM
         DWKeFrnNmTLG2WaFNvYV7gyR7Smcmc2BntAlh09yqp4vZNtHKgwx9k2WeW4Fc6BmznEF
         4f4dGBASlp7OZgda1AVcJi0Z/+xp3ZnQMnPYE05D8qdwyqgAWn1n+45vrU1IZwNnefbq
         IbZq9YdfHNEEvPW78q+ESXVMY/835iUkq2QzuPLoRZczfm/TfvQg3UoTGv6gDTSJ1L+j
         uQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681340042; x=1683932042;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/FYJf/PoTUaGPEcG2nCig+6F91gf8C1q5/h0lDZxFg=;
        b=ZBnaNZXW7YP0cU1xDbhP2CLsqyZ19Y4/QSdZa6BHoWbVmJuzZwADh63hChAQtXaeJp
         PXrwc1EFjCaHysIhH+NHHrVuvgWS7cn5dOOQfR3HLvTMPXl5MymsUPhp0s3E0hJuJfLL
         2eidT5tV+WSvc7W/iofUjM9dss/jFH+47P0SrFyw2tsBCF2c0w1gxT9SXzd98diu/9ks
         KD0sb1AlAatBz5DvFti1fgxWE2g9u5YM2laWSt3bsCy/jOGPMVJOLRU5QHsY1c4EzSp1
         I0xMG/HlrZRLB8FPHBny5MKbHjl3yHdXkFyoV/3MvjU50LSMbzGqyClVf393IIn2+X0t
         P9YA==
X-Gm-Message-State: AAQBX9e9joSF4hnCVyLvsG/6iUA1x3SuGVkru2N1e5KTjUsm1iEWQjVS
        8zjhOrgaa77UZQcShE73YsSURFrx1FRz/LBo+Q==
X-Google-Smtp-Source: AKy350YTu/4tO3j/kwE6oEvEIOvgDPxj1N1xolzjCssji4GWmWwcitSLQhd8Ural7VfwQDr6ANiMgg==
X-Received: by 2002:a92:ce06:0:b0:329:4a80:5a8d with SMTP id b6-20020a92ce06000000b003294a805a8dmr1874935ilo.16.1681340042130;
        Wed, 12 Apr 2023 15:54:02 -0700 (PDT)
Received: from ?IPv6:2601:281:8300:a1:5d8a:622a:58d5:54e0? ([2601:281:8300:a1:5d8a:622a:58d5:54e0])
        by smtp.gmail.com with ESMTPSA id g14-20020a056e020d0e00b003261422fdbcsm30676ilj.80.2023.04.12.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 15:54:01 -0700 (PDT)
Message-ID: <7de3bc2d85a51c255d2c4911bb9f2c365b6b7325.camel@egauge.net>
Subject: Re: wilc1000: AP mode issue
From:   David Mosberger-Tang <davidm@egauge.net>
To:     Ajay.Kathat@microchip.com
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 12 Apr 2023 16:53:58 -0600
In-Reply-To: <ae3f0a16-0285-018f-9a71-7017fd705617@microchip.com>
References: <e4cece9076cc9a5a4e4dbfa258a828eaec97e1af.camel@egauge.net>
         <bdd4f49a-213a-bf55-1c29-d74e56221795@microchip.com>
         <5fb4291c1d97f42e0d4904cd2f316326efd6003a.camel@egauge.net>
         <ae3f0a16-0285-018f-9a71-7017fd705617@microchip.com>
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

On Wed, 2023-04-12 at 21:10 +0000, Ajay.Kathat@microchip.com wrote:
> Hi David,
>=20
> On 4/12/23 12:47, David Mosberger-Tang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > Ajay,
> >=20
> > OK, here is a simpler test case:
> >=20
> > - Setup wlan0 to connect to an existing access point.
> >   In my case, wlan0 ends up with IP address 172.17.2.230.
> >=20
> > - Start hostapd on wlan0tst with these commands:
> >=20
> > ---
> > cat > hostapd-wlan0tst.conf <<EOF
> > interface=3Dwlan0tst
> > hw_mode=3Dg
> > channel=3D6
> > ieee80211n=3D1
> > wmm_enabled=3D1
> > ssid=3DWLAN0TST
> > wpa=3D2
> > wpa_passphrase=3DSOME_PASSWORD
> > EOF
> > iw dev wlan0 interface add wlan0tst type __ap
> > ip link set dev wlan0tst address 12:34:56:78:9a:bc
> > ip addr add 10.234.193.42/24 dev wlan0tst
> > hostapd hostapd-wlan0tst.conf
> > ---
> >=20
> > - Connect another computer to WLAN0TST
> >=20
> > When I try the above, usually WLAN0TST works fine but as soon as it sta=
rts up,
> > pings to 172.17.2.230 stop.  Sometimes, WLAN0TST starts up fine, but af=
ter a few
> > seconds, the client's connection gets shut down and WLAN0TST stops
> > working (or even being advertised).  When that happens, pings to 172.17=
.2.230
> > start working again.
> >=20
> > I don't think the issue is really AP-mode specific though.  I also see =
issues
> > when trying to create a virtual interface that connects to another acce=
ss point:
>=20
> In wilc1000, the concurrent mode is only supported on a single channel.

Ahh, now that makes sense.  I take it that's a physical limitation?

> I suspect the STA and AP are started on different channels. Because of
> that, the existing interface is getting affected when other interface is
> started.

Yep.  I wasn't really paying too much attention to the channels as I
was assuming they could be separate for distinct virtual interfaces
and, at first blush, it did look like it was working fine.

> Once the station is connected to AP on wlan0 interface, try using the
> same channel number to run hostapd on wlan0tst interface.

Confirmed.  I just tried that and was able to successfully connect with
Android 13, Android 9, and iOS devices without problem!

I guess I'll have to use hostapd_cli chan_switch to ensure the AP
channel stays in sync with the station's channel and hope that any
clients connected to the AP will update seamlessly if and when the
channel switches.

Would it be difficult to output an error when two virtual interfaces
are configured for different channel numbers?

In any case, thanks for your help - much appreciated!

  --david

>=20
