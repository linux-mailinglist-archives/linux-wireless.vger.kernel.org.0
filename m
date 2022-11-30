Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8DF63E24A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 21:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiK3UrI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 15:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiK3UrF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 15:47:05 -0500
X-Greylist: delayed 401 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Nov 2022 12:47:04 PST
Received: from titan.fastwww.net (titan.fastwww.net [15.235.10.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133181D90
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 12:47:03 -0800 (PST)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=xkwXrRGnuiLZAKo/O4a5TlKottSbs2qwaoVT/eab6rqNpEJ42U41lAco6BYfM56BSaUOkYvOaMtQgMOnPB70RRANCxxpnBTk/KVCiJvUJYdALEjqie7qEJ/E8pzUqPnA/wdRuXR7OqCGf+rzSX6f2SWJ6YBDMlUOpPyVPT9KSobOuqt6SUIdtOIskqhJqmVg+EZLPFKf0n3+NarKlTrnc+aeLTmBFiEp+e9JNZXMuRCnXkrdvOmjnM9rFgGgcUfY5NoSzfc6Gw9/q7prWLV+rpnFLkA0uP68UOtR0sMUOdyTKTGzaLQoj4o0CAM8OJ+2K/MunrBPsbO6I1lPacxBqQ==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=date:from:to
        :cc:message-id:in-reply-to:references:subject:mime-version
        :content-type:content-transfer-encoding; s=default; bh=dzz/WNNl3
        m8MeD0WxH/PBA2dheg=; b=rIxwPF+352MLR8JikY0n6lvl3GeLj36Jy+tAVAOg1
        FHdpbx78C8p6ZABwfMoAQpjEYqg/Yvrr7/zM/J0UyHfSBY6eH8XKTsq1Z47f0XBV
        vH1ybP8hgA7fpIdqC3raHD9akZN8SxY9FHxDbbPxEq2n1BFFUgeGknn8W7QEFc0B
        O58Ebn58x1IM0yJjqVL9ag3+rTZy1RSyrK6N3XohJpW6u6NZFcT+wd+ehBVNR/RA
        ENftmW/RDJ73CxT9Y+U+ioFgE9vGFsFJmhL3+Zw5mfdHQ190CRI+zEgTZwl0V+V9
        jimHTHsgVJxdiLB0LRKnGwtl8/iL7qYNwh0Bzm5TcB9cw==
Received: (qmail 9855 invoked by uid 108); 30 Nov 2022 20:40:21 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 30 Nov 2022 20:40:21 +0000
Received: from dummy.faircode.eu ([199.7.157.93])
        by titan.fastwww.net with ESMTPSA
        id zmAvN7S/h2NxJgAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Wed, 30 Nov 2022 20:40:20 +0000
Date:   Wed, 30 Nov 2022 15:40:19 -0500 (EST)
From:   James <bjlockie@lockie.ca>
To:     "Matthias G." <maps4711@gmx.de>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <016bcf51-c365-4173-92b9-aa718e0be4e2@lockie.ca>
In-Reply-To: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
References: <1235df2ba1757a5917dc21455fa8c1d0a48bb2c4.camel@gmx.de>
Subject: Re: Bug report: Can connect with 'wext', but not 'nl80211'
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <016bcf51-c365-4173-92b9-aa718e0be4e2@lockie.ca>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The AP is linux 6 with a mediatek 7921k, right?

Nov. 30, 2022 14:45:51 Matthias G. <maps4711@gmx.de>:

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
> Kernel logs, success:
> Nov 30 20:30:45 papaya kernel: wlan0: authenticate with dc:9b:d6:de:d4:27
> Nov 30 20:30:45 papaya kernel: wlan0: bad VHT capabilities, disabling VHT
> Nov 30 20:30:45 papaya kernel: wlan0: Invalid HE elem, Disable HE
> Nov 30 20:30:45 papaya kernel: wlan0: 80 MHz not supported, disabling VHT
> Nov 30 20:30:45 papaya kernel: wlan0: send auth to dc:9b:d6:de:d4:27 (try=
 1/3)
> Nov 30 20:30:45 papaya kernel: wlan0: authenticated
> Nov 30 20:30:45 papaya kernel: wlan0: associate with dc:9b:d6:de:d4:27 (t=
ry 1/3)
> Nov 30 20:30:45 papaya kernel: wlan0: RX AssocResp from dc:9b:d6:de:d4:27=
 (capab=3D0x431 status=3D0 aid=3D1)
> Nov 30 20:30:45 papaya kernel: wlan0: associated
> Nov 30 20:30:45 papaya kernel: IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link=
 becomes ready
>=20
> System information:
> Artix dist, Linux papaya 6.0.7-artix1-1 #1 SMP PREEMPT_DYNAMIC Thu, 03 No=
v 2022 21:10:08 +0000 x86_64 GNU/Linux
>=20
> wpa_supplicant v2.10
>=20
> 05:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wi=
reless Network Adapter
>=20
> mt7921e=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 32768=C2=A0 0
> mt7921_common=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 94208=
=C2=A0 1 mt7921e
> mt76_connac_lib=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 69632=C2=A0 2 m=
t7921e,mt7921_common
> mt76=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 102400=C2=A0 3 mt7921e,mt7921_common,mt76=
_connac_lib
> mac80211=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1298432=C2=A0 3 mt76,mt7921_common,mt76_connac_lib
> libarc4=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 16384=C2=A0 1 mac80211
> cfg80211=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 1118208=C2=A0 4 mt76,mac80211,mt7921_common,mt76_connac_lib
> rfkill=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 32768=C2=A0 5 asus_wmi,bluetooth,cfg80211
>=20
> I can compile a custom linux kernel and wpa_supplicant for e.g. debugging=
 purposes. Let me know if you need more information. I didn't
> subscribe to this mailing list, so please answer directly.
>=20
> Regards,
> Matthias
