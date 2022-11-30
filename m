Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7118663E202
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 21:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiK3U36 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiK3U3z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 15:29:55 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02D754446
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 12:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Xb9R3YFhADIzTsS4Kal+Xo+aW7reHKluIUTXeVPOMgw=;
        t=1669840193; x=1671049793; b=Y4X7oDy8yt/Iu1bG8PJ6jYL9IexRj8J7ZEbQO1APiUQIvmO
        5Mb+2CJK4e4tvMD7oOFDhNHRiWAwAoO2dJPTkMgNWR/5SkH85Xfqig9lAcWA0OHxUDKn3FKMnaIoH
        z4k7kczpW4WUTqaMbXHDKip9fU7RNGM9chymxPyz9lQPwHGA7jQiyvYgJAV1wDsxKSRAuLc3wrvKB
        gIYiusoOW02ZNDBcjVAxXhaPOrdOERnxkcuGgaQc4Hs14hpWcE4fXm+j9S5FuSfCnJLiNN2jG9ns1
        EltBPTpITPnTkWtOTLJG2U57zAPwwNlyvWyUOdCkyGrW835O6G5QrjtTzmG6qK7g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1p0TiJ-00DIDK-0K;
        Wed, 30 Nov 2022 21:29:51 +0100
Message-ID: <f694e9d9dbf36b870f278f8eabed14d5dede55aa.camel@sipsolutions.net>
Subject: Re: Bug report: Can connect with 'wext', but not 'nl80211'
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Matthias G." <maps4711@gmx.de>, linux-wireless@vger.kernel.org
Cc:     hostap@lists.infradead.org
Date:   Wed, 30 Nov 2022 21:29:50 +0100
In-Reply-To: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
References: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-30 at 20:44 +0100, Matthias G. wrote:
> Hello,
>=20
> I hope this is the right place to report. I can connect via WiFi to my LT=
E router with the legacy 'wext' driver but not with 'nl80211'.
>=20
> The router is a rebranded version of this one:
> https://forum.openwrt.org/t/alcatel-tlc-hh40-lte-router-based-on-openwrt/=
77580
>=20
> This command fails:
> # wpa_supplicant -c wpa-home-lte.conf -i wlan0
>=20
> wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redac=
ted>' freq=3D2452 MHz)
> wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' fr=
eq=3D2452 MHz)
> wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redac=
ted>' freq=3D2452 MHz)
> wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' fr=
eq=3D2452 MHz)
> wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redac=
ted>' freq=3D2452 MHz)
> wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' fr=
eq=3D2452 MHz)
> wlan0: SME: Trying to authenticate with dc:9b:d6:de:d4:27 (SSID=3D'<redac=
ted>' freq=3D2452 MHz)
> wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' fr=
eq=3D2452 MHz)
> wlan0: CTRL-EVENT-SSID-TEMP-DISABLED id=3D0 ssid=3D"<redacted>" auth_fail=
ures=3D1 duration=3D10 reason=3DCONN_FAILED
>=20
> while this succeeds:
> # wpa_supplicant -Dwext -c wpa-home-lte.conf -i wlan0
>=20
> Successfully initialized wpa_supplicant
> ioctl[SIOCSIWENCODEEXT]: Invalid argument
> ioctl[SIOCSIWENCODEEXT]: Invalid argument
> wlan0: Trying to associate with dc:9b:d6:de:d4:27 (SSID=3D'<redacted>' fr=
eq=3D2452 MHz)
> wlan0: Associated with dc:9b:d6:de:d4:27
> wlan0: WPA: Key negotiation completed with dc:9b:d6:de:d4:27 [PTK=3DCCMP =
GTK=3DCCMP]
> wlan0: CTRL-EVENT-CONNECTED - Connection to dc:9b:d6:de:d4:27 completed [=
id=3D0 id_str=3D]
>=20
> Kernel logs, failure:
> Nov 30 20:24:41 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
> Nov 30 20:24:41 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
> Nov 30 20:24:41 papaya kernel: wlan0: Invalid HE elem, Disable HE
> Nov 30 20:24:41 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
> Nov 30 20:24:42 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try=
 1/3)
> Nov 30 20:24:42 papaya kernel: wlan0: authenticated
> Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 1/3)
> Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 2/3)
> Nov 30 20:24:42 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 3/3)
> Nov 30 20:24:42 papaya kernel: wlan0: association with dc:9b:d6:de:d4:27 =
timed out
> Nov 30 20:24:45 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
> Nov 30 20:24:45 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
> Nov 30 20:24:45 papaya kernel: wlan0: Invalid HE elem, Disable HE
> Nov 30 20:24:45 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
> Nov 30 20:24:45 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try=
 1/3)
> Nov 30 20:24:45 papaya kernel: wlan0: authenticated
> Nov 30 20:24:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 1/3)
> Nov 30 20:24:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 2/3)
> Nov 30 20:24:46 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 3/3)
> Nov 30 20:24:46 papaya kernel: wlan0: association with dc:9b:d6:de:d4:27 =
timed out
>=20

Sounds like the AP is broken and doesn't like some elements wpa_s
includes when nl80211 has certain capabilities ...

Not sure what we can do about that - maybe there's a way to selectively
disable certain capabilities in wpa_s?

johannes
