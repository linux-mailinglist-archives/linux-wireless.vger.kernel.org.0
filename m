Return-Path: <linux-wireless+bounces-23107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9814BABA6A4
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 01:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08674A1566
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 23:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1208B15A864;
	Fri, 16 May 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="DDR8ThXT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C65280CFF
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438752; cv=none; b=KPF4JzVJOdQDPGbWcybVTN+bmcD6JvcuNN/wSBdnKveSJI7KZz1sMw7OlC3XzIl5XuUKx43CJ+1z6LTakFF/xcul/BBgwT44Wy56+oLeSPk5Cu/GSJsNQQNRjOV4uYIA+I3zbS8z0dJtpx/iYVA0D0rGjOVd4P1a9FWny0t/hmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438752; c=relaxed/simple;
	bh=LTYe/ZSDHU4DZt7ofKqilAyTNLchDCTwLUVspwR2fok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANMJKooJ9qMr4b93qbEDmRLwaFfm3r/N7Tb5DwOwgktel65dLSEGBoQunhIHFMctclzIK8+iqIz3b/OjiLF/uzNUAxFtXhD4lGhizRDjrjjgdVwuTmZwfMbZoCZ4XnCJnZSThPNPXw/vHo3tvpGNSmi+hssvBBnvZLsI1QRiMRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=DDR8ThXT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e732386e4b7so2853021276.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1747438747; x=1748043547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE1RmF3if0Pd7/kv7JLiWl66kE/AlzxMQi62GGhnu80=;
        b=DDR8ThXTKBBI4/oXzzr3HdZGb5+PTcL0IIJnsipFoMDSkOO0oI4doZJMNOuZJkoDkB
         MfIIcnGxQOmKlv26pqidcchPLrUVpqd2DS+YB34kBYPGBF+egmIrEYDY/3fFGrOvl50t
         ka67s0jfLoKpFqDj82WVhRxx5AgOD3D7ebqrlYYJ4zyDvpLRK0DqToS0z8xKYBKatpP0
         FOzLZiTwARKr/2lLzqs5b/bZ4RUIl8xy82gKW0I1ULgmYd07bd4qvcDWVe2vqCoUjze3
         0FqspYYRqc8RVHwGbSfA6sLtCq+WlrHXcpwbcKUZJNKMUeBQCbPEzvR6AxrU7ghb4Vfs
         7B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747438747; x=1748043547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE1RmF3if0Pd7/kv7JLiWl66kE/AlzxMQi62GGhnu80=;
        b=huWCGqMnFGWWvZQvA9BNUimLq4UHbg/Aj79TQbMB+rAf2BrCFVNPPnzJ1PRJdmJb9x
         0WxKDaO2GuZOERMBEvQsFr5nQtFculkDCEgMye3+Wi3YUrW3/h5SeC0LW0X67QyrjdMI
         TKXGMxBdaxRwjgG2vztA8uJ5ZY6uo4sgYeNu9noLPiYjlPnH87dxLCI2tlOOM3+BcTik
         k/Wt0srfVxm5trpUHyOHt5tv5kGdRv3Zq3N4HpqDiYrrqi5HoIsgPxWUjqDW5/Mo+1jv
         brQUegzCRYGqVaHnYUmupRmaCdGuD+JHr0JEo0k/WBO42ve3Ka9NAnwpDlRzMrv5G/zH
         4rew==
X-Forwarded-Encrypted: i=1; AJvYcCWrnkiCNbZ7mhvhOJotqChVEXidMAybBqpgAwWBhsM1IJffL2cVp3iFcMYtqzrYrbZulYcpK7h9tcEFbSVXmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAueZm+QzHlbFeOCfjQY6nBkKhyGmgwOGsy+uZMFt+pQV+bcAt
	eACO53t/0I+n67f/mvDujqfLoE0ZQLBEM/W3E5/FLYZz+GzouDvXEzVdZvmwai2Z9f3VSxmC1V6
	WdE/F5E8rvQGUfF1cJNOJvojwpSXbYe8p0co8WzAQHIqQoSLfzxxE7Ac=
X-Gm-Gg: ASbGncvXS7X0gmJvQhi6T3LkLJuK62HCeZux16uvmKvvPg6OskZe3bJhlwdV8pH2Bt/
	JPUmni4K9Ld87Q5hwQSk04fKz0dbB7dA3Edgldbf++YZnj3LgbttBsTZ6JUwjHQ37Z+UGfe0ZMQ
	qEKsyB9lnI+B9hBkTPYOiYznUHu65fy6e0
X-Google-Smtp-Source: AGHT+IE2X/KGTaPxX0kVt6eTeS/I4ofSnG5RLL1NQJEru7TN9NXQV/INj33JuM3DvFZDkHqXpGL8XmXd4VHsQNx+QeY=
X-Received: by 2002:a05:6902:704:b0:e6d:f287:bf9 with SMTP id
 3f1490d57ef6-e7b6d42c564mr6066153276.22.1747438747386; Fri, 16 May 2025
 16:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ+vNU2pLJd696Fc_98arrzs8QK70HfstPrZv6zVJm3G13REHQ@mail.gmail.com>
 <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <196d7901068.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 16 May 2025 16:38:56 -0700
X-Gm-Features: AX0GCFtwI7-G2zWQEk86l0HuzrZyI5ATg81jB89fmxDwM0riVEM6dPN3e5XrR00
Message-ID: <CAJ+vNU009QSwYopCFzZtwDNXDBppx7L4v_ZKtmNZ=5ep7trOSA@mail.gmail.com>
Subject: Re: [PATCH wireless-next v3 0/4] wifi: brcmfmac: external auth
 support for Infineon devices
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless <linux-wireless@vger.kernel.org>, hostap@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:27=E2=80=AFPM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On May 16, 2025 2:38:51 AM Tim Harvey <tharvey@gateworks.com> wrote:
>
> > Hi Arend,
> >
> > Thanks for this series! This allows WPA3 Personal in STA mode on a
> > CYW4373E based module we use on our boards however AP mode with WPA3
> > Personal does not appear to work. Do you know what is needed to allow
> > WPA3 Personal in a CYW4373E AP?
>
> Hi Tim,
>
> I did not look into AP mode (yet). Are you using hostapd as authenticator=
.
> Can you provide the conf file?
>

Hi Arend,

Yes, I'm using hostapd for AP and wpa_supplicant for STA and now I'm
thinking this is likely an issue with one of them and not the brcmfmac
driver although there are always relationships between hostap and the
drivers so it's hard to say. With more testing I've found that the
issue does not occur all the time... in fact it was difficult to make
it occur again.

Here is some more context:
- board: imx8mm-venice-gw73xx
- device: Ezurio Sterling LWB5+ (SDIO single-antenna using CYW4373E)

- testing using latest linux-wireless:
# uname -r
6.15.0-rc5-01256-g68b44b05f4c8
# ls -l /sys/class/net/wlan*
lrwxrwxrwx 1 root root 0 May 16 19:54 /sys/class/net/wlan0 ->
../../devices/platform/soc@0/30800000.bus/30b40000.mm
c/mmc_host/mmc0/mmc0:0001/mmc0:0001:1/net/wlan0
# dmesg | grep brcmfmac
[    1.345277] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac4373-sdio for chip BCM4373/0
[    3.976263] brcmfmac mmc0:0001:1: Direct firmware load for
brcm/brcmfmac4373-sdio.gw,imx8mm-gw73xx-0x.bin failed
 with error -2
[    4.146166] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
available (err=3D-2)
[    4.146642] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4373/0
wl0: Apr 18 2024 00:20:43 version 13.10.246.343
 (72478a2 CY) FWID 01-bd87f673
# iw phy | grep SAE
        Device supports SAE with AUTHENTICATE command

- on STA:
# iw reg set US
# wpa_supplicant -v
wpa_supplicant v2.11
Copyright (c) 2003-2024, Jouni Malinen <j@w1.fi> and contributors
# cat wpa_supplicant.conf
network=3D{
        ssid=3D"wpa3test"
        key_mgmt=3DSAE
        sae_password=3D"012345678"
        ieee80211w=3D2
}
# wpa_supplicant -t -i wlan0 -c wpa_supplicant.conf
1747433610.388391: Successfully initialized wpa_supplicant
1747433621.394128: wlan0: Trying to associate with SSID 'wpa3test'
1747433626.465446: wlan0: PMKSA-CACHE-ADDED c0:ee:40:da:39:d6 0
1747433626.481277: wlan0: Associated with c0:ee:40:da:39:d6
1747433626.481786: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
1747433626.487603: wlan0: WPA: RSNXE mismatch between Beacon/ProbeResp
and EAPOL-Key msg 3/4
1747433626.487627: RSNXE in Beacon/ProbeResp - hexdump(len=3D3): f4 01 20
1747433626.487647: RSNXE in EAPOL-Key msg 3/4 - hexdump(len=3D0): [NULL]
1747433626.488175: nl80211: send_event_marker failed: Source based
routing not supported
1747433626.488215: wlan0: CTRL-EVENT-DISCONNECTED
bssid=3Dc0:ee:40:da:39:d6 reason=3D17 locally_generated=3D1
1747433626.488261: wlan0: Added BSSID c0:ee:40:da:39:d6 into ignore
list, ignoring for 10 seconds
1747433626.488349: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
1747433626.488397: wlan0: CTRL-EVENT-DSCP-POLICY clear_all
1747433626.490356: wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
^^^ this is the point where I will see the 'associated' message from
hostapd, but then with a couple of seconds hostapd prints a series of
'disassociated' messaged in quick succession
1747433629.491254: wlan0: Removed BSSID c0:ee:40:da:39:d6 from ignore
list (clear)
1747433629.491551: wlan0: Trying to associate with SSID 'wpa3test'
1747433629.656365: wlan0: Associated with c0:ee:40:da:39:d6
1747433629.656455: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=3D0
1747433631.711703: wlan0: CTRL-EVENT-DISCONNECTED
bssid=3Dc0:ee:40:da:39:d6 reason=3D6
1747433631.711812: wlan0: Added BSSID c0:ee:40:da:39:d6 into ignore
list, ignoring for 10 seconds
1747433631.713066: wlan0: CTRL-EVENT-REGDOM-CHANGE init=3DCORE type=3DWORLD
1747433634.715053: wlan0: Removed BSSID c0:ee:40:da:39:d6 from ignore
list (clear)
...
at this point I need to restart wpa_supplicant in order to see any
hostapd messages

- on AP:
# iw reg set US
# hostapd -v
hostapd v2.11
User space daemon for IEEE 802.11 AP management,
IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
Copyright (c) 2002-2024, Jouni Malinen <j@w1.fi> and contributors
# cat hostapd.conf
interface=3Dwlan0
driver=3Dnl80211
ssid=3Dwpa3test
hw_mode=3Dg
channel=3D6
country_code=3DUS
ieee80211n=3D1
wmm_enabled=3D1
auth_algs=3D1
wpa=3D2
wpa_key_mgmt=3DSAE
wpa_pairwise=3DCCMP
rsn_pairwise=3DCCMP
sae_password=3D012345678
ieee80211w=3D2
# -t hostapd -i wlan0 hostapd.conf &
1747433608.079907: wlan0: interface state UNINITIALIZED->COUNTRY_UPDATE
1747433613.321142: wlan0: interface state COUNTRY_UPDATE->ENABLED
1747433613.321229: wlan0: AP-ENABLED
1747433627.270790: 1747433627.270796: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: associated
1747433631.306003: 1747433631.306008: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433631.307505: 1747433631.307509: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433631.508982: 1747433631.508985: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433631.708937: 1747433631.708939: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433631.908929: 1747433631.908931: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433632.108885: 1747433632.108887: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433632.308912: 1747433632.308914: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433632.508999: 1747433632.509001: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated
1747433634.488061: 1747433634.488066: wlan0: STA c0:ee:40:83:06:2a
IEEE 802.11: disassociated

you can see from the hostapd timestamps that the disassociated
messages are in quick succession which is odd. When this occurs
wpa_supplicant appears to keep trying yet I no longer see any messages
from hostapd unless I restart wpa_supplicant. Additionally when this
occurs it will never stay associated unless I restart hostapd.

I've found the same behavior using hostapd/wpa_supplicant v2.10 as
well as 2.11. Any ideas what's going on here? The
'CTRL-EVENT-DISCONNECTED' with reason=3D6 I'm finding is usually due to
a client sending data before authentication is complete and is usually
chalked up to a driver bug.

Incidentally, while looking at this I noticed if you enable
CONFIG_FORTIFY_SOURCE you'll get a splat from the memcpy in function
you added in your patch:
[  161.608607] ------------[ cut here ]------------
[  161.608646] memcpy: detected field-spanning write (size 104) of
single field "&mgmt_frame->u" at drivers/net/wir
eless/broadcom/brcm80211/brcmfmac/cyw/core.c:307 (size 26)
[  161.608712] WARNING: CPU: 1 PID: 64 at
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:307
brcmf_not
ify_auth_frame_rx+0x1f4/0x210
[  161.647854] CPU: 1 UID: 0 PID: 64 Comm: kworker/1:2 Not tainted
6.15.0-rc5-01256-g68b44b05f4c8 #153 PREEMPT
[  161.657699] Hardware name: Gateworks Venice GW73xx-0x i.MX8MM
Development Kit (DT)
[  161.665279] Workqueue: events brcmf_fweh_event_worker
[  161.670348] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  161.677322] pc : brcmf_notify_auth_frame_rx+0x1f4/0x210
[  161.682557] lr : brcmf_notify_auth_frame_rx+0x1f4/0x210
[  161.687789] sp : ffff80008065bc30
[  161.691107] x29: ffff80008065bc30 x28: ffffabb0a8e7d270 x27: ffff1f01c0b=
0c8c0
[  161.698269] x26: dead000000000100 x25: dead000000000122 x24: ffff8000806=
5bd58
[  161.705426] x23: ffff1f01c03bc008 x22: ffff1f01c114b750 x21: 00000000000=
00080
[  161.712587] x20: 0000000000000068 x19: ffff1f01c02c7f80 x18: 00000000000=
00030
[  161.719744] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000fff=
fffff
[  161.726903] x14: 000000000000000d x13: 7720676e696e6e61 x12: 00000000fff=
fffea
[  161.734062] x11: ffff80008065b9f8 x10: ffffabb0a93242c0 x9 : 00000000000=
00001
[  161.741220] x8 : 0000000000000001 x7 : c0000000ffffefff x6 : 00000000000=
17fe8
[  161.748376] x5 : ffff1f01ff775808 x4 : 0000000000000000 x3 : 00000000000=
00027
[  161.755536] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff1f01c02=
8a080
[  161.762696] Call trace:
[  161.765151]  brcmf_notify_auth_frame_rx+0x1f4/0x210 (P)
[  161.770391]  brcmf_fweh_call_event_handler+0x40/0xc0
[  161.775368]  brcmf_fweh_event_worker+0x158/0x3b8
[  161.779999]  process_one_work+0x16c/0x2bc
[  161.784024]  worker_thread+0x2dc/0x3dc
[  161.787784]  kthread+0x130/0x200
[  161.791028]  ret_from_fork+0x10/0x20
[  161.794618] ---[ end trace 0000000000000000 ]---

Maybe you can submit a patch for that.

Best regards,

Tim

