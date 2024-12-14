Return-Path: <linux-wireless+bounces-16392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560CF9F1EC8
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 14:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6615E166F1E
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 13:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA706189B8B;
	Sat, 14 Dec 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLi/1ZKA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CD63C
	for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734183313; cv=none; b=bzszTTiuGApBH5DUfb4fr1b2Lsu4WP9mvA7m1aVEUcnt5XSX3yJ7/uwBBPMDOz3nwSQvGIGc4tK/Zp5OkwzxQztvTnMT4KiKgtrJmm+jRzVMijuLuSjwX1ACXBffA4/Z5WLtbLtyGPGE7YDFLo/SYKO9sSX2RPt44vvnMqExNe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734183313; c=relaxed/simple;
	bh=F5hcTTuUkMbRVxDksab61nwm3G6ErdQqwCxecKwfvvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBVeseAcwRoEj77k5z7ATA8GLDVOTSipfe3Mw/an9xR0KmsIhr3HUe7DPWJ9i67a7xqKDcyBSzM/7XtiI5WIkrJPy2TPlgk+cNWNxX8KXKvPQtBbU513xAnETDvyG16E7HTCLFEthZmjqcuOUSOa73dhNJZL/nTG8G6qzvbt7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLi/1ZKA; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21644aca3a0so31213705ad.3
        for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 05:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734183311; x=1734788111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DYTqXSs3ajwBJRtM6MyvWdAl9XpBx0PjBLF0R7Y52o=;
        b=LLi/1ZKATgsjJG0a3UHyxyW2Hib2fkOTqIKgajFWLxRopyreypVpqRB3Y8Fdau4TpT
         WzZIMx5mJMbhhu9hosVjiB+ty+7gkjY9vUgb4tsgp+39ih+J4u71gSSa9Awte/b3wcfS
         C7sP66HI6xL4lbUKQUTM0LvicVUEK+hu65+kLpjLAtoYU9Lu0/88D/cylVO9HI0qKEns
         GRr1XDIRR6WhF1sHxd8Pn8JcEKUjFsrnoyTCTQm8HF7kj2UYiRrg4tGI+hglVCBIPk/Y
         9eqi45YvbhhAxOY/ZB9Uw2BHIRFW7yA+YEBk/oGvU7lVvhXtOfDmCjKgC561zj8/N1Jd
         A9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734183311; x=1734788111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2DYTqXSs3ajwBJRtM6MyvWdAl9XpBx0PjBLF0R7Y52o=;
        b=tU2MBO+EZF7dE6DvWPB4WLzrEM5qzm/fljfW7K/iSBwL4FGheHzcdPoxNrczuPYS1+
         ap6kSxlVbqjbzQFuEjV9qQ4sGT1qrPz/zwTxWga9cCwmxRLQJA2kn4r2lLltof6W1lzx
         Q1fxgrAbPEevX0wq3FfOkWISbvWSMLSXeY+hMRICCfGlOJqztX4KxPVcl/qIjpBzWs+q
         5j4KEqXtcR6z4WDGC8Qs336EWxIrvb3JXMz4BLyVPIIwzdNsljuQ81urSVoOggT73qyI
         CIOjoSX4ZT3EWTdy5HLl5J5X8vM+hXDZxm0+6fOmmZvxrqYa3Q3Wa5jz8PkZO1hgIdM0
         T6bg==
X-Forwarded-Encrypted: i=1; AJvYcCW/z91yl1L/IPJN1Fi7hHo17CCfzFihV6cS+zJ09qQg3r8Dn2PN03L+dLp6VQXF3k3TTk6gvmxxaFIhDqUzjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpcHEY4AcVwZlGNiUUIEcydVRb+cTZ7G6lo/y09m+khkjRxYId
	q5o6/YgcroYUcFaUZmBPbWer9Nx95TD7YZUg65epWgEHF07Hh+A0mjdhipRXj3p0dO4xqrN1+XW
	ONaBPGvyWYw04erBEiwbwevQK2Is=
X-Gm-Gg: ASbGncti0iSdmxB3iQYB8DO7xaUBglknkE4k9TpTS04kU3dqAfClwCDCqLwmGIR/lP0
	zygwkGT9THkqFCYeRR1hoWlZ1Om5NSCofRs3xkRKkSF9uZh1PnRLCJv/aPbnkYVqOYk2RBSsL
X-Google-Smtp-Source: AGHT+IHXrbxHNLH05M/PtdIjTyVcYlS3LBXyPqp9T3b3F0hT/muFEYjxu5Onak0MXw2tONia2XZFAMcfmMAnKgtLG1E=
X-Received: by 2002:a17:903:94f:b0:215:94b0:9df4 with SMTP id
 d9443c01a7336-21892a566f3mr85962505ad.54.1734183311047; Sat, 14 Dec 2024
 05:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com> <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
In-Reply-To: <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 14 Dec 2024 07:34:59 -0600
Message-ID: <CAG17S_NqbLogvTWyoYobZ6kOpfXHnScfm4-dB1EqsmpB+q+zxA@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Arend,

I looked through the info where I got the latest firmware:
https://community.infineon.com/t5/Wi-Fi-Bluetooth-for-Linux/Wi-Fi-A-class-L=
inux-Driver-release-FMAC-2024-11-21-Documents/td-p/905045
https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Cypress-L=
inux-WiFi-Driver-Release-FMAC-2024-11-21/td-p/902888
and did not find anything, but I really do not know what I am looking for.

Keith

On Fri, Dec 13, 2024 at 6:40=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Fri, Dec 13, 2024 at 11:35=E2=80=AFAM Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On December 13, 2024 4:13:17 PM KeithG <ys3al35l@gmail.com> wrote:
> >
> > > On Thu, Dec 12, 2024 at 2:17=E2=80=AFPM Arend van Spriel
> > > <arend.vanspriel@broadcom.com> wrote:
> > >>
> > >> On 12/12/2024 3:24 PM, KeithG wrote:
> > >>> Based on a hunch that brcmfmac dbug might reveal something, I turne=
d
> > >>> it on to see what turned up. I attempted the same as before: using =
iwd
> > >>> to connect to the WPA3 AP.
> > >>>
> > >>> [iwd]# station wlan0 connect deskSAE
> > >>> Type the network passphrase for deskSAE psk.
> > >>> Passphrase: *********
> > >>> [iwd]# station wlan0 show
> > >>>                            Station: wlan0
> > >>> -------------------------------------------------------------------=
-------------
> > >>> Settable  Property              Value
> > >>> -------------------------------------------------------------------=
-------------
> > >>>       Scanning              no
> > >>>       State                 connecting
> > >>>       Connected network     deskSAE
> > >>>       IPv4 address          169.254.203.147
> > >>>
> > >>> the attached log shows brcmfmac debug
> > >>>
> > >>> it always shows 'State connecting' never connected.
> > >>>
> > >>> Is one of these what is causing it to error out:
> > >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmw=
are
> > >>> error: BCME_UNSUPPORTED (-23)
> > >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> > >>> ifidx=3D0, name=3Dtdls_sta_info, len=3D296, err=3D-52
> > >>> ...
> > >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmw=
are
> > >>> error: BCME_BADADDR (-21)
> > >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> > >>> ifidx=3D0, name=3Dsta_info, len=3D296, err=3D-52
> > >>> ...
> > >>> Dec 09 18:33:32 jackrune kernel: ieee80211 phy0:
> > >>> brcmf_cfg80211_get_station: GET STA INFO failed, -52
> > >>>
> > >>> I do not know what BCME is.
> > >>
> > >> BCME are the error codes produced by the firmware. Without debug pri=
nts
> > >> you will only see a generic error code, ie. -52 (-EBADE). So you alw=
ays
> > >> see the "Firmware error" message following by the "generic" error
> > >> message. It is not truly generic as it mentions the command name. So=
 the
> > >> above says the command "tdls_sta_info" is unsupported and the mac
> > >> address provided in the "sta_info" command is not found in firmware.
> > >>
> > >> Looking at the log I see periodically:
> > >>
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmwa=
re
> > >> error: BCME_NOTASSOCIATED (-17)
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data_get
> > >> ifidx=3D0, cmd=3D23, len=3D6, err=3D-52
> > >>
> > >> According fwil.h the driver sends BRCMF_C_GET_BSSID command. When
> > >> associated is returns the BSSID of your AP. As you are not yet
> > >> associated it fails. Not really related to the external auth procedu=
re I
> > >> think.
> > >>
> > >> The following is more interesting:
> > >>
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_cfg80211_external_a=
uth
> > >> Enter
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_set
> > >> ifidx=3D0, name=3Dauth_status, len=3D44
> > >> Dec 09 18:32:55 jackrune kernel: brcmutil: data
> > >> Dec 09 18:32:55 jackrune kernel: 00000000: 04 00 d8 3a dd 60 a3 0c 0=
7 00
> > >> 00 00 64 65 73 6b  ...:.`......desk
> > >> Dec 09 18:32:55 jackrune kernel: 00000010: 53 41 45 00 00 00 00 00 0=
0 00
> > >> 00 00 00 00 00 00  SAE.............
> > >> Dec 09 18:32:55 jackrune kernel: 00000020: 00 00 00 00 00 00 00 00 0=
0 00
> > >> 00 00              ............
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_txctl Ente=
r
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl Ente=
r
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_isr Enter
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl resu=
med
> > >> on rxctl frame, got 72 expected 72
> > >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmwa=
re
> > >> error: BCME_BADLEN (-24)
> > >> Dec 09 18:32:55 jackrune kernel: ieee80211 phy0:
> > >> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
> > >>
> > >> So the "auth_status" command fails and the firmware error code indic=
ates
> > >> the length is invalid. The length of the "auth_status" command as se=
nt
> > >> by the driver to the device is 44 and apparently the firmware expect=
s
> > >> some other length. Here is what I did in my patch:
> > >>
> > >> +static int
> > >> +brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev=
,
> > >> +                       struct cfg80211_external_auth_params *params=
)
> > >> +{
> > >> +       struct brcmf_if *ifp;
> > >> +       struct brcmf_pub *drvr;
> > >> +       struct brcmf_auth_req_status_le auth_status;
> > >> +       int ret =3D 0;
> > >> +
> > >> +       brcmf_dbg(TRACE, "Enter\n");
> > >> +
> > >> +       ifp =3D netdev_priv(dev);
> > >> +       drvr =3D ifp->drvr;
> > >> +       if (params->status =3D=3D WLAN_STATUS_SUCCESS) {
> > >> +               auth_status.flags =3D cpu_to_le16(BRCMF_EXTAUTH_SUCC=
ESS);
> > >> +       } else {
> > >> +               bphy_err(drvr, "External authentication failed: stat=
us=3D%d\n",
> > >> +                        params->status);
> > >> +               auth_status.flags =3D cpu_to_le16(BRCMF_EXTAUTH_FAIL=
);
> > >> +       }
> > >> +
> > >> +       memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
> > >> +       auth_status.ssid_len =3D cpu_to_le32(min_t(u8, params->ssid.=
ssid_len,
> > >> +                                                IEEE80211_MAX_SSID_=
LEN));
> > >> +       memcpy(auth_status.ssid, params->ssid.ssid, auth_status.ssid=
_len);
> > >> +
> > >> +       ret =3D brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_s=
tatus,
> > >> +                                      sizeof(auth_status));
> > >> +       if (ret < 0)
> > >> +               bphy_err(drvr, "auth_status iovar failed: ret=3D%d\n=
", ret);
> > >> +
> > >> +       return ret;
> > >> +}
> > >>
> > >> So the type struct brcmf_auth_req_status_le is used for external aut=
h
> > >> request and for auth_status. Maybe for the "auth_status" it only nee=
ds a
> > >> subset of fields. Here is the struct declaration:
> > >>
> > >> +/**
> > >> + * struct brcmf_auth_req_status_le - external auth request and stat=
us
> > >> update
> > >> + *
> > >> + * @flags: flags for external auth status
> > >> + * @peer_mac: peer MAC address
> > >> + * @ssid_len: length of ssid
> > >> + * @ssid: ssid characters
> > >> + */
> > >> +struct brcmf_auth_req_status_le {
> > >> +       __le16 flags;
> > >> +       u8 peer_mac[ETH_ALEN];
> > >> +       __le32 ssid_len;
> > >> +       u8 ssid[IEEE80211_MAX_SSID_LEN];
> > >> +};
> > >>
> > >> Maybe flags and peer_mac is sufficient? That would be 8 bytes so can=
 you
> > >> try and change brcmf_cyw_external_auth() such that it does:
> > >>
> > >> +       ret =3D brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_s=
tatus, 8);
> > >>
> > >> Without firmware source code we can only guess.
> > >>
> > >> Regards,
> > >> Arend
> > >>
> > >>> On Mon, Dec 9, 2024 at 8:30=E2=80=AFAM KeithG <ys3al35l@gmail.com> =
wrote:
> > >>>>
> > >>>> I poked at this a while back and decided to try it again over the =
weekend.
> > >>>>
> > >>>> Infineon has released a new firmware:
> > >>>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> > >>>> (be70ab3 CY) FWID 01-95efe7fa
> > >>>> it is not in the RPiOS release, yet, but I installed it on a Pi3B+=
 and
> > >>>> decided to give it a try. I have an AP running WPA3 personal on a
> > >>>> desktop in the home and can connect to it with my phone as proof t=
hat
> > >>>> it 'works'.
> > >>>>
> > >>>> I tried to connect to it once again from the Pi while running this=
 new
> > >>>> firmware. It gets closer than last time I checked, but it does not
> > >>>> actually negotiate a functional connection.
> > >>>> I tried with connman/iwd, NetworkManager/iwd and it gets close, bu=
t
> > >>>> still errors out. I get a number of these in the iwmon log:
> > >>>>
> > >>>>> Response: Get Station (0x11) len 4                               =
   38.439787
> > >>>> Status: Invalid exchange (52)
> > >>>>
> > >>>> Can I probe this further to assist in diagnosing the cause and
> > >>>> potentially help with a solution?
> > >>>> The log is attached.
> > >>>>
> > >>>> Regards,
> > >>>>
> > >>>> Keith
> > > Arend,
> > >
> > > Does this iwmon log help at all.
> >
> > Probably not. The issue seems to be between driver and firmware.
> >
> > If there is anyone out there that successfully used the ext_auth with
> > downstream ifx driver they could create the same log and see what lengt=
h
> > the auth_status command uses.
> >
> > I'll see what I can find.
> >
> > Regards,
> > Arend
>
> Arend,
>
> I took a look anyway.
>
> Don't know exactly what I am looking at, but it seems that this is
> where it goes sideways:
>
> > Event: Frame (0x3b) len 120                                          7.=
530849
>     Wiphy: 0 (0x00000000)
>     Interface Index: 3 (0x00000003)
>     Wireless Device: 1 (0x0000000000000001)
>     Wiphy Frequency: 2412 (0x0000096c)
>     Unknown: 290 len 4
>         00 00 00 00                                      ....
>     Frame: len 64
>         Frame Type: 0x00b0
>             Type: Management (0)
>             Authentication:
>                 Frame Control: protocol: 00 type: 00 subtype: 11 to:
> 00 from: 00 more_frags: 00
>                     retry: 00 power_mgmt: 00 more_data: 00 protected:
> 00 order: 00
>                 Duration: 0
>                 Address 1 (RA): B8:27:EB:A4:6E:0F
>                 Address 2 (TA): D8:3A:DD:60:A3:0C
>                 Address 3: 00:00:00:00:00:00
>                 Fragment Number: 0
>                 Sequence Number: 0
>                 Algorithm: SAE (seq: 2, status: 0)
>                 IEs: len 34
>                     Error decoding Supported rates IE len 0: Invalid
> argument (-22)
>         b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  .....'..n..:.`..
>         00 00 00 00 00 00 00 00 03 00 02 00 00 00 01 00  ................
>         b3 a1 af e2 4c 57 c9 0d 5e 56 0d 70 91 58 e1 53  ....LW..^V.p.X.S
>         5c 1c 6c 20 05 78 9b d9 81 ce b9 b8 f4 8b a8 c7  \.l .x..........
>     RX Management Flags: 2 (0x00000002)
> < Request: External Auth (0x7f) len 40 [ack]                           7.=
531125
>     Interface Index: 3 (0x00000003)
>     Status Code: 0 (0x0000)
>     SSID: len 7
>         64 65 73 6b 53 41 45                             deskSAE
>     BSSID D8:3A:DD:60:A3:0C
> > Response: External Auth (0x7f) len 4                                 7.=
531626
>     Status: Invalid exchange (52)
> < Request: Get Station (0x11) len 20 [ack]                             8.=
410689
>     Interface Index: 3 (0x00000003)
>     MAC Address D8:3A:DD:60:A3:0C
> > Response: Get Station (0x11) len 4                                   8.=
415045
>     Status: Invalid exchange (52)

