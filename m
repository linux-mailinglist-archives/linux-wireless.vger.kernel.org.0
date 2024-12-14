Return-Path: <linux-wireless+bounces-16391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 193679F1B5D
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 01:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE2D167221
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 00:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB9C7489;
	Sat, 14 Dec 2024 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBaMPl/z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E926AA7
	for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 00:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734136857; cv=none; b=rJw/14afo4F8DiL/+Vv17coP2RjL9vomxpI5wONsrMGL9HY21n5I3JDwfLnQVbeTSgRn2q1yvEwwzzQ5B80apdVg5LEYrdX8aNUoIeBpTFmG+HfPCu/FTbkF+vLc/eEtrVdRhgQgikN4WkwHi2Aa/za3Vf9/GzBduZbgup/0ngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734136857; c=relaxed/simple;
	bh=JfuxXYBuwfUAATKf9s6inX4UzdIVBbgo1F48bxHhIfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X3P0jjFDzEalbqc7AWCAdQdeNYXI5+6yie5bhbgEE8JcAQw5Z/kjVJKIeezsU+qtxC7HN5IlmvdiIgBgd+vpodGNbSXIS7VX5pEiyxVRz9LFZS9XDuvuoWcjcJUFjMQFxD27OXhQ/9lN+eA4ONplwcRegAmtPILjgMVXt5p9QPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBaMPl/z; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728f1e66418so2058643b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 16:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734136855; x=1734741655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AoYLMjyITYVzFC0pbwI0AfwRfXnUnSE1OGd5NIV400=;
        b=jBaMPl/zm1sa4FBLU+xOO/4PJRKNUN04KYDsBRYjMDN3S34Jnrw8FKtcLbitcobN7f
         Sd0OwhraV2LTtT9B/DiSBcwP7OcPiZOKM4jKaqRTLVMdtH+3lmW6N4oiMW2Oqmb4e6Fw
         CJAF0XOBnOQr+ICwBpKj5RTy63dBiGPQ+tkwMt+UzfmHGb7v6zPtyZkT5aIx6Kq44h9C
         OQboXFm/t7ttYKI4qlTzE4bzt6qr7jJVOqt3qbuby/OMHGkrdlTkNx0tJ283BiG6G6Dn
         yfSHD6IHpfLtdgE6SzxwiPjk5rNKwHzVG2LxNPCgNWYGtCyeAHLOvkynCPZCwOv3QfHc
         9IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734136855; x=1734741655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AoYLMjyITYVzFC0pbwI0AfwRfXnUnSE1OGd5NIV400=;
        b=OWL7EtGJ2AS9PJAUuC1MvlY7Dt+HB5+k7B8G/2dfsfgZ8Ida8IvECL3DjSMrPl+nBH
         7vMmb3e1MOcqD+xp6ylZHdOO8Gouxm2FY3iYTG7koR1q2GmzSoCJ5H/HiaYZTFZHimHG
         jKzmvQMaNamPC0WBdZ0VHxplM/aZrXu1kuCC+JCDATjmCcDiLc+OeoflMOM3Sc9IOL63
         fTNJpWxO7m8rvxasRVKF337E8yb+UVKUX6Kg2tzcsGGjHW+LIODKUXNzkhNuEXFS6p0X
         MZIyUU22uKcWGai6EYj0GRK07/wNAcK+TzsPV9jrQN1YA63mU67wV2kdSDtuKWYxPOju
         M/yA==
X-Forwarded-Encrypted: i=1; AJvYcCWxQXGMrMRr+052b1h60m4bzTvRQh1ECO1+HL34y0OUB0qGvoCJoC2mfv60RSzyBPagEzkCk6mGDq+pxSOIdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJyOZ2m1/9pd6pyVE8b6zNNerW8DSrgSLGAkx8WTQ1kuWu/2y
	qK5Qgw7t9dxwInoVeTc0AqkGOpzgrLA9WwzyR9/bMCS0599fjyVwu8p01tI4oFXd4AAO1ebkW6v
	A0nojh0aef5ypud79aoW93ZSukJA0+5ltzoI=
X-Gm-Gg: ASbGncty5xv19eTS7sT8q9BjKYnYE/1+PnP4yf+HcAX69l4mIIMyRl2YzNl7NgBF0Bp
	T24fLLIgAKmy0tRP3B64rVRj/LADrP879oHLo/8MLzbYcF3HDZsO1Fzwt7ohABvErEAkyNzfr
X-Google-Smtp-Source: AGHT+IHQK8AAKmTngFXE5yC2zdTC3Pj0gjadpTVkeqQNb0qz69wBH6yhKz+09M4ZLdshprOYE5PeeyLZL1rsx/LuJAs=
X-Received: by 2002:a17:90b:1b10:b0:2ee:e158:125b with SMTP id
 98e67ed59e1d1-2f2900a6e40mr6386530a91.26.1734136854583; Fri, 13 Dec 2024
 16:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_M9wxMsSNyqAQv2oxaCQZ9CAe=GHNjZCbw__2bsAg1hdg@mail.gmail.com>
 <ff9c1192-42b5-4a28-a8c9-31af9765cbff@broadcom.com> <CAG17S_PrigpkFP=5wcTL9UETwc6aHqXnuTEyeRrZ7Ey1cb-ZLw@mail.gmail.com>
 <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <193c1173968.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: KeithG <ys3al35l@gmail.com>
Date: Fri, 13 Dec 2024 18:40:43 -0600
Message-ID: <CAG17S_NwSKEJzbk7RNiOKqU_25f6muydbh0DN+ec1Ke6QrR1Qw@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: brcm80211@lists.linux.dev, linux-wireless@vger.kernel.org, 
	Denis Kenzior <denkenz@gmail.com>, James Prestwood <prestwoj@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 11:35=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 13, 2024 4:13:17 PM KeithG <ys3al35l@gmail.com> wrote:
>
> > On Thu, Dec 12, 2024 at 2:17=E2=80=AFPM Arend van Spriel
> > <arend.vanspriel@broadcom.com> wrote:
> >>
> >> On 12/12/2024 3:24 PM, KeithG wrote:
> >>> Based on a hunch that brcmfmac dbug might reveal something, I turned
> >>> it on to see what turned up. I attempted the same as before: using iw=
d
> >>> to connect to the WPA3 AP.
> >>>
> >>> [iwd]# station wlan0 connect deskSAE
> >>> Type the network passphrase for deskSAE psk.
> >>> Passphrase: *********
> >>> [iwd]# station wlan0 show
> >>>                            Station: wlan0
> >>> ---------------------------------------------------------------------=
-----------
> >>> Settable  Property              Value
> >>> ---------------------------------------------------------------------=
-----------
> >>>       Scanning              no
> >>>       State                 connecting
> >>>       Connected network     deskSAE
> >>>       IPv4 address          169.254.203.147
> >>>
> >>> the attached log shows brcmfmac debug
> >>>
> >>> it always shows 'State connecting' never connected.
> >>>
> >>> Is one of these what is causing it to error out:
> >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmwar=
e
> >>> error: BCME_UNSUPPORTED (-23)
> >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> >>> ifidx=3D0, name=3Dtdls_sta_info, len=3D296, err=3D-52
> >>> ...
> >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmwar=
e
> >>> error: BCME_BADADDR (-21)
> >>> Dec 09 18:11:06 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_get
> >>> ifidx=3D0, name=3Dsta_info, len=3D296, err=3D-52
> >>> ...
> >>> Dec 09 18:33:32 jackrune kernel: ieee80211 phy0:
> >>> brcmf_cfg80211_get_station: GET STA INFO failed, -52
> >>>
> >>> I do not know what BCME is.
> >>
> >> BCME are the error codes produced by the firmware. Without debug print=
s
> >> you will only see a generic error code, ie. -52 (-EBADE). So you alway=
s
> >> see the "Firmware error" message following by the "generic" error
> >> message. It is not truly generic as it mentions the command name. So t=
he
> >> above says the command "tdls_sta_info" is unsupported and the mac
> >> address provided in the "sta_info" command is not found in firmware.
> >>
> >> Looking at the log I see periodically:
> >>
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> >> error: BCME_NOTASSOCIATED (-17)
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data_get
> >> ifidx=3D0, cmd=3D23, len=3D6, err=3D-52
> >>
> >> According fwil.h the driver sends BRCMF_C_GET_BSSID command. When
> >> associated is returns the BSSID of your AP. As you are not yet
> >> associated it fails. Not really related to the external auth procedure=
 I
> >> think.
> >>
> >> The following is more interesting:
> >>
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_cfg80211_external_aut=
h
> >> Enter
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_iovar_data_set
> >> ifidx=3D0, name=3Dauth_status, len=3D44
> >> Dec 09 18:32:55 jackrune kernel: brcmutil: data
> >> Dec 09 18:32:55 jackrune kernel: 00000000: 04 00 d8 3a dd 60 a3 0c 07 =
00
> >> 00 00 64 65 73 6b  ...:.`......desk
> >> Dec 09 18:32:55 jackrune kernel: 00000010: 53 41 45 00 00 00 00 00 00 =
00
> >> 00 00 00 00 00 00  SAE.............
> >> Dec 09 18:32:55 jackrune kernel: 00000020: 00 00 00 00 00 00 00 00 00 =
00
> >> 00 00              ............
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_txctl Enter
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl Enter
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_isr Enter
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_sdio_bus_rxctl resume=
d
> >> on rxctl frame, got 72 expected 72
> >> Dec 09 18:32:55 jackrune kernel: brcmfmac: brcmf_fil_cmd_data Firmware
> >> error: BCME_BADLEN (-24)
> >> Dec 09 18:32:55 jackrune kernel: ieee80211 phy0:
> >> brcmf_cfg80211_external_auth: auth_status iovar failed: ret=3D-52
> >>
> >> So the "auth_status" command fails and the firmware error code indicat=
es
> >> the length is invalid. The length of the "auth_status" command as sent
> >> by the driver to the device is 44 and apparently the firmware expects
> >> some other length. Here is what I did in my patch:
> >>
> >> +static int
> >> +brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
> >> +                       struct cfg80211_external_auth_params *params)
> >> +{
> >> +       struct brcmf_if *ifp;
> >> +       struct brcmf_pub *drvr;
> >> +       struct brcmf_auth_req_status_le auth_status;
> >> +       int ret =3D 0;
> >> +
> >> +       brcmf_dbg(TRACE, "Enter\n");
> >> +
> >> +       ifp =3D netdev_priv(dev);
> >> +       drvr =3D ifp->drvr;
> >> +       if (params->status =3D=3D WLAN_STATUS_SUCCESS) {
> >> +               auth_status.flags =3D cpu_to_le16(BRCMF_EXTAUTH_SUCCES=
S);
> >> +       } else {
> >> +               bphy_err(drvr, "External authentication failed: status=
=3D%d\n",
> >> +                        params->status);
> >> +               auth_status.flags =3D cpu_to_le16(BRCMF_EXTAUTH_FAIL);
> >> +       }
> >> +
> >> +       memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
> >> +       auth_status.ssid_len =3D cpu_to_le32(min_t(u8, params->ssid.ss=
id_len,
> >> +                                                IEEE80211_MAX_SSID_LE=
N));
> >> +       memcpy(auth_status.ssid, params->ssid.ssid, auth_status.ssid_l=
en);
> >> +
> >> +       ret =3D brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_sta=
tus,
> >> +                                      sizeof(auth_status));
> >> +       if (ret < 0)
> >> +               bphy_err(drvr, "auth_status iovar failed: ret=3D%d\n",=
 ret);
> >> +
> >> +       return ret;
> >> +}
> >>
> >> So the type struct brcmf_auth_req_status_le is used for external auth
> >> request and for auth_status. Maybe for the "auth_status" it only needs=
 a
> >> subset of fields. Here is the struct declaration:
> >>
> >> +/**
> >> + * struct brcmf_auth_req_status_le - external auth request and status
> >> update
> >> + *
> >> + * @flags: flags for external auth status
> >> + * @peer_mac: peer MAC address
> >> + * @ssid_len: length of ssid
> >> + * @ssid: ssid characters
> >> + */
> >> +struct brcmf_auth_req_status_le {
> >> +       __le16 flags;
> >> +       u8 peer_mac[ETH_ALEN];
> >> +       __le32 ssid_len;
> >> +       u8 ssid[IEEE80211_MAX_SSID_LEN];
> >> +};
> >>
> >> Maybe flags and peer_mac is sufficient? That would be 8 bytes so can y=
ou
> >> try and change brcmf_cyw_external_auth() such that it does:
> >>
> >> +       ret =3D brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_sta=
tus, 8);
> >>
> >> Without firmware source code we can only guess.
> >>
> >> Regards,
> >> Arend
> >>
> >>> On Mon, Dec 9, 2024 at 8:30=E2=80=AFAM KeithG <ys3al35l@gmail.com> wr=
ote:
> >>>>
> >>>> I poked at this a while back and decided to try it again over the we=
ekend.
> >>>>
> >>>> Infineon has released a new firmware:
> >>>> Firmware: BCM4345/6 wl0: Oct 28 2024 23:27:00 version 7.45.286
> >>>> (be70ab3 CY) FWID 01-95efe7fa
> >>>> it is not in the RPiOS release, yet, but I installed it on a Pi3B+ a=
nd
> >>>> decided to give it a try. I have an AP running WPA3 personal on a
> >>>> desktop in the home and can connect to it with my phone as proof tha=
t
> >>>> it 'works'.
> >>>>
> >>>> I tried to connect to it once again from the Pi while running this n=
ew
> >>>> firmware. It gets closer than last time I checked, but it does not
> >>>> actually negotiate a functional connection.
> >>>> I tried with connman/iwd, NetworkManager/iwd and it gets close, but
> >>>> still errors out. I get a number of these in the iwmon log:
> >>>>
> >>>>> Response: Get Station (0x11) len 4                                 =
 38.439787
> >>>> Status: Invalid exchange (52)
> >>>>
> >>>> Can I probe this further to assist in diagnosing the cause and
> >>>> potentially help with a solution?
> >>>> The log is attached.
> >>>>
> >>>> Regards,
> >>>>
> >>>> Keith
> > Arend,
> >
> > Does this iwmon log help at all.
>
> Probably not. The issue seems to be between driver and firmware.
>
> If there is anyone out there that successfully used the ext_auth with
> downstream ifx driver they could create the same log and see what length
> the auth_status command uses.
>
> I'll see what I can find.
>
> Regards,
> Arend

Arend,

I took a look anyway.

Don't know exactly what I am looking at, but it seems that this is
where it goes sideways:

> Event: Frame (0x3b) len 120                                          7.53=
0849
    Wiphy: 0 (0x00000000)
    Interface Index: 3 (0x00000003)
    Wireless Device: 1 (0x0000000000000001)
    Wiphy Frequency: 2412 (0x0000096c)
    Unknown: 290 len 4
        00 00 00 00                                      ....
    Frame: len 64
        Frame Type: 0x00b0
            Type: Management (0)
            Authentication:
                Frame Control: protocol: 00 type: 00 subtype: 11 to:
00 from: 00 more_frags: 00
                    retry: 00 power_mgmt: 00 more_data: 00 protected:
00 order: 00
                Duration: 0
                Address 1 (RA): B8:27:EB:A4:6E:0F
                Address 2 (TA): D8:3A:DD:60:A3:0C
                Address 3: 00:00:00:00:00:00
                Fragment Number: 0
                Sequence Number: 0
                Algorithm: SAE (seq: 2, status: 0)
                IEs: len 34
                    Error decoding Supported rates IE len 0: Invalid
argument (-22)
        b0 00 00 00 b8 27 eb a4 6e 0f d8 3a dd 60 a3 0c  .....'..n..:.`..
        00 00 00 00 00 00 00 00 03 00 02 00 00 00 01 00  ................
        b3 a1 af e2 4c 57 c9 0d 5e 56 0d 70 91 58 e1 53  ....LW..^V.p.X.S
        5c 1c 6c 20 05 78 9b d9 81 ce b9 b8 f4 8b a8 c7  \.l .x..........
    RX Management Flags: 2 (0x00000002)
< Request: External Auth (0x7f) len 40 [ack]                           7.53=
1125
    Interface Index: 3 (0x00000003)
    Status Code: 0 (0x0000)
    SSID: len 7
        64 65 73 6b 53 41 45                             deskSAE
    BSSID D8:3A:DD:60:A3:0C
> Response: External Auth (0x7f) len 4                                 7.53=
1626
    Status: Invalid exchange (52)
< Request: Get Station (0x11) len 20 [ack]                             8.41=
0689
    Interface Index: 3 (0x00000003)
    MAC Address D8:3A:DD:60:A3:0C
> Response: Get Station (0x11) len 4                                   8.41=
5045
    Status: Invalid exchange (52)

