Return-Path: <linux-wireless+bounces-17935-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC87A1C464
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 17:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66347188923C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D70745C18;
	Sat, 25 Jan 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXzlMQCe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A46DCE1
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737823056; cv=none; b=ki0AsNu5iGdPtEuRcMkIYtg7Euf6ZeplYnGrXhZMNnTdH9EyJzxCQxlL9I3NfjKZHmWkequThZmPS4kisvFv4W8CQgW2K9AEvr4L80bas5DHvd+xlKVkNT0xgB+uc/x57emwpP5PcedKB6sX/FSdNj8QFclMynC/tHL0Jx98fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737823056; c=relaxed/simple;
	bh=6SxZugzzscbzEMV5AKMPnavSj59o7cYhOvMccvByDaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BrqzybYAoTbpdeWq3Cpa7yCqx/bufl2Gg/CQUpjCAPUYj37oIHzlrMBrU1Ka3fn04DDrAQYlYJ1y0k5ymVpU3G/8raFapEe4gKJ+N5MN92Hu0+cfAQLmtii5H2xYkzdv4ZFFnei1tNVi7irA75t1eo8NvSFGMHNgsQHHaE8CTgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iXzlMQCe; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so5371278a91.3
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 08:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737823050; x=1738427850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zzOXTXjr/f6SE4PpODCIWv8SpDcKFCQvHkdpYsoTx8k=;
        b=iXzlMQCeHMfrjni+ne063ZFHhCpaAnOtDMSgK6W7L3ErWRJHyxnBBw4jpSnIzAwLkf
         BOS6kXHrgEuTrqHxOxD9BiUXNHRy6bvdq+ZdLoxBwuEf6JxRvs6Ojo4sN9q3pHk5gfVy
         6Q2tJS4yaYhZVpAzN5sCCtRCVvDXwe+N5YTJTE6e09C0pRLHGR/DgLHdvacEelH/T7xZ
         ORjM4uuIy/JpSk6Xxhc6JyuIeTDAIdQ0sZtSsg6f1tLuBwwKTGR2kve1ZB3tT/pc6Mq8
         sLhtDgZgBSp0SN0J9biOfT6iW91NlB9NsQlRQ7WRKQUHkgmVE8/8dCOkPIKpOROdCsKN
         grnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737823050; x=1738427850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzOXTXjr/f6SE4PpODCIWv8SpDcKFCQvHkdpYsoTx8k=;
        b=xOu36SrvavjXXbpWxrr4HG89gpMkOrgtgau0rTx0gUCOVqE1Cg+pHEGDnnCyWkK/6g
         usgwqMOOtWwwRuVvveUyMs4IcaHmEI+buWQGl5GDpVkrzaB3F5VdRKgGafXCTG6iDWCr
         nl8/owe6rrJWK361ptd4Hv6q/zdlS0aKC2tg05ztGGwTLjOD3ESlqdkxOU/jkG+UFi+A
         WjyG4g4MU/wVqFAFKSa1+0/x1anxJGwN2jVDerJ1tAEZ9q/rK6IfiC4CJe3gbO6MLVQH
         x+EdZZNJbge/XUL+f4Pp9YxLAuQViyHKDzeSw1UOUL/QDBJYM59ttRn4E5ex9XDKlblN
         ZmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhrTPW+QZUppDCNn2i77mtBbh1l5HMutjniWjuaY92RwTZ+MDMxwyKf+IdHoqn1v7W2+N7IEAusEwnATf0YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdGoRyqkFYpulBQLe1Q1eY7HgrugAYKNmDndoFxzLVtQBUGcY0
	lvVR9hG44UWlr/rWMTH0Qf+yvg3U4KW68OcSHQ6vUkZhhgFYXTs+JAN8wVw2DMJxXzfrimCIZ5J
	Mr8OUsoJT4V8nVf6FPuKLn5nPl0A=
X-Gm-Gg: ASbGnctp2U99YgoMCj2XmtZ/0w6FBdgWTJnChtzYlHkVMkZ0vaKgjUSxNMqeuk4sW33
	Dbap17Apdk0TUlngxVA0/7xOxBrnsJ7KDGAG7jvh3+Du1YOjnfiyuXYDgEs36tw==
X-Google-Smtp-Source: AGHT+IFbLwidVCqXcpmVQWJLpSPQIfeZZDX7YIhpdmpjau936hkF4k+a0HvUU1gqW1S/rVZDM2RuZjJ0kkgdX8c7nfY=
X-Received: by 2002:a17:90b:548e:b0:2ea:8d1e:a85f with SMTP id
 98e67ed59e1d1-2f782c997afmr56455081a91.17.1737823050203; Sat, 25 Jan 2025
 08:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG17S_OwtNxetb7XzsxkZcygH_CWkZx15evQZkThb3WjqpiKTQ@mail.gmail.com>
 <CAG17S_NVmXZsAShc1VFh6iTgtT30CdHSBNxhmT=xs4q41--tcw@mail.gmail.com>
 <fc4c196b-1f55-43a0-90ac-ca282aa6eb7d@gmail.com> <CAG17S_O7rJLXiLv8OcRaoxQWu4jk=L_ut3HpY7BbwkSbRfMWjA@mail.gmail.com>
 <c586f9fe-e1f8-44dd-a867-ec21c78c7de9@gmail.com> <CAG17S_N6Gw1G8e5dh_1cm3P2DNt_gSbQSAKWd27hvpMZui4yxg@mail.gmail.com>
 <CAG17S_NgkTQ5wT5nb=6FZZ9gnVMTqOWfWJve47JmfOoVAHZy8A@mail.gmail.com>
 <CAG17S_Oq+RGOZpE+xa-CV8=VtmJu7G8GWxfVYqg1edEG9wC+yA@mail.gmail.com>
 <CAG17S_NdA9LdwmA_XfvPOVrhCdqp+BOtAssH0=RE-VSjg=WFnA@mail.gmail.com>
 <CAG17S_O6Bpc+JhhUuDvE70a+ef9wt9D7jG1gMJDNo1qZCUOg8w@mail.gmail.com>
 <194115affe0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAG17S_O7HbPFB0gubWWP9P-Oecps8K_LG0Y7YDo5DbNGKSLjpA@mail.gmail.com>
 <CAG17S_MwJC+h7O-htyUxEgB4zHKeGf+9B4QaQ6ZLiVStU_Egkw@mail.gmail.com>
 <CAG17S_NfqFjjaWj6vGS1HXux6JDy0QKcg8aQAR=aOzNGhO0a3w@mail.gmail.com>
 <eace9233-1b65-4793-8abe-abd3c640dba8@gmail.com> <CAG17S_MfQ+FjWQJoiNs30rt4u1O9Z_FXFB7BiS6RAQsG9ReNkA@mail.gmail.com>
 <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
In-Reply-To: <CAG17S_OigLj3j=tS2BKYpoKOWKVs=XOBS-YFn26SzF9r+ZpLzA@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Sat, 25 Jan 2025 10:37:17 -0600
X-Gm-Features: AWEUYZnPQ46SfkplEJh4tiOxQ54Y98ACtj94bhsA5q6l3GoAZwfhUKaFdtPVHpg
Message-ID: <CAG17S_Pj6UaA-yaGDUCwr8+M+L760PU0NvB1sAzGGNCp4xKatg@mail.gmail.com>
Subject: Re: brcmfmac SAE/WPA3 negotiation - Part 2
To: Denis Kenzior <denkenz@gmail.com>
Cc: Arend Van Spriel <arend.vanspriel@broadcom.com>, James Prestwood <prestwoj@gmail.com>, 
	connman@lists.linux.dev, brcm80211@lists.linux.dev, 
	linux-wireless@vger.kernel.org, iwd@lists.linux.dev
Content-Type: multipart/mixed; boundary="000000000000971ec5062c8a751d"

--000000000000971ec5062c8a751d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Still trying to pinpoint what is happening when it works versus when
it does not.

Using iwd 3.3 (built from git at gbf82aff0) with connman (1.41-1.43)
will negotiate a successful WPA3/SAE AP connection some times. When it
fails, it generally (maybe always?) gets an APIPA address and does not
negotiate getting a DHCP address.

When I compare the logs side by side, I see that when it sets the
APIPA address it shows:
 Jan 22 19:44:36 Pi4 iwd[2259036]: event: connect-info, FullMAC
driver: brcmfmac using SAE.  Expect EXTERNAL_AUTH
Jan 22 19:44:36 Pi4 iwd[2259036]: src/pmksa.c:pmksa_cache_get()
Returning entry with PMKID: dc1225e288927453b9879a01d47d7af5
Jan 22 19:44:36 Pi4 iwd[2259036]: src/netdev.c:netdev_connect_common()
Skipping SAE by using PMKSA cache
Jan 22 19:44:36 Pi4 iwd[2259036]: src/netdev.c:netdev_cqm_rssi_update()
Jan 22 19:44:36 Pi4 iwd[2259036]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 15
Jan 22 19:44:36 Pi4 iwd[2259036]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 15
Jan 22 19:44:36 Pi4 iwd[2259036]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -59, load: 0/255
Jan 22 19:44:36 Pi4 iwd[2259036]: event: state, old: disconnected,
new: connecting
then later, it has this:
Jan 22 19:44:36 Pi4 kernel: ieee80211 phy0:
brcmf_cfg80211_external_auth: External authentication failed: status=3D1
this line is always there when it does not negotiate DHCP.

whereas when it sets up correctly with a DHCP address, it does this:
Jan 22 19:57:56 Pi4 iwd[2259036]: event: connect-info, FullMAC driver:
brcmfmac using SAE.  Expect EXTERNAL_AUTH
Jan 22 19:57:56 Pi4 iwd[2259036]: src/netdev.c:netdev_cqm_rssi_update()
Jan 22 19:57:56 Pi4 iwd[2259036]:
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 17
Jan 22 19:57:56 Pi4 iwd[2259036]: src/wiphy.c:wiphy_radio_work_next()
Starting work item 17
Jan 22 19:57:56 Pi4 iwd[2259036]: event: connect-info, ssid: deskSAE,
bss: d8:3a:dd:60:a3:0c, signal: -59, load: 0/255
Jan 22 19:57:56 Pi4 iwd[2259036]: event: state, old: disconnected,
new: connecting

what I am doing to repeatedly test this is to remove the config for
the WPA3 AP via connmanctl and re-initiate the connection
The attached logs are of iwmon and the journal showing a successful
DHCP connection and an unsuccessful APIPA connection.

Is this still a problem with the driver/firmware, or of iwd? When I
use wpa_supplicant 2.10-12+deb12u2 with connman, it connects properly
every time. If needed, I also have logs of a successful wpa_supplicant
connection. It looks a lot like the successful iwd connection.

The only difference in the iwmon logs between a successful iwd
connection and a wpa_supplicant connection (to my untrained eyes) is
that it has different IFLA flags
iwd:
> RTNL: New Link (0x10) len 128                                        9.03=
8969
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x1043) [up,broadcast,running,multicast]

wpa_supplicant
> RTNL: New Link (0x10) len 136                                       48.12=
6129
    Flags: 0 (0x000)
    Sequence number: 0 (0x00000000)
    Port ID: 0
    IFLA Family: Unknown
    IFLA Type: 1
    IFLA Index: 3
    IFLA ChangeMask: 0
    IFLA Flags: (0x9003) [up,broadcast,multicast,dynamic]

These logs have been trimmed and I hope I have the relevant bits.

Keith

On Thu, Jan 9, 2025 at 8:19=E2=80=AFPM KeithG <ys3al35l@gmail.com> wrote:
>
> On Mon, Jan 6, 2025 at 11:13=E2=80=AFAM KeithG <ys3al35l@gmail.com> wrote=
:
> >
> > On Mon, Jan 6, 2025 at 9:26=E2=80=AFAM Denis Kenzior <denkenz@gmail.com=
> wrote:
> > >
> > > Hi Keith,
> > >
> > > On 1/5/25 6:41 PM, KeithG wrote:
> > > > I am looking at the iwmon logs for a successful wpa_supplicant
> > > > connection versus one from IWD. Both connect and both pass data and
> > > > both grab a DHCP address. I do note one difference in the connectio=
n,
> > > > though.
> > > >
> > > > Request : Connect
> > > > through the responses RTNL
> > > > wpa_supplicant knows it is dynamic
> > >
> > > wpa_supplicant doesn't manage network interfaces.  I assume you're us=
ing ConnMan
> > > for this? If so, ConnMan sets the IFF_DYNAMIC flag.  See
> > > https://git.kernel.org/pub/scm/network/connman/connman.git/tree/src/i=
net.c#n372
> > >
> > > >
> > > > Whereas the iwd log does not:
> > >
> > > iwd doesn't use IFF_DYNAMIC in its DHCP implementation at the moment.
> > >
> > > According to 'man netdevice':
> > >
> > >                IFF_DYNAMIC       The addresses are lost when the inte=
rface
> > >                                  goes down.
> > >
> > > I doubt this is the cause of your DHCP / connection problems.
> > >
> > > Regards,
> > > -Denis
> >
> > Denis,
> >
> > I am using connman to manage the connections. The connman config is
> > the same. The one iwmon snippet was with iwd masked and stopped but
> > wpa_supplicant installed and the connect performed in connmanctl. The
> > other is with wpa_supplicant removed and purged and iwd started,
> > running then restarted connman then initiated a connect form
> > connmanctl.
> >
> > I pored over these logs yesterday and saw a few differences, but this
> > was one that stood out. I can look closer again tonight and see if I
> > notice anything else that I can summarize.
> >
> > Keith
>
> Still looking at these iwmon logs. The attached log is the log of
> using wpa_supplicant under connman to make a valid connection but w/o
> all the AP scanning...
>
> using wpa_supplicant with connman works every time. It is with iwd
> that I get varying behavior. Looking through the iwmon logs to see
> what is sent and what is received, it looks like there are some
> differences. I am guessing that the first '< Request: Connect' is what
> is sent to the AP to request a connection.
> wpa_supplicant sends more info:
> Under < Request: Connect'
> 'RSN capabilities: bit  6: Management Frame Protection Required
> ...
>                 BIP (00:0f:ac) suite  06
>             01 00 00 0f ac 04 01 00 00 0f ac 04 01 00 00 0f  ............=
....
>             ac 08 c0 00 00 00 00 0f ac 06
> ...
> Extended Capabilities: len 11
>             Capability: bit 17: WNM-Sleep mode
>             ...
>             Capability: bit 25: SSID list
>             Capability: bit 46: WNM- Notification
>             Capability: bit 54: SCS
> ...
> Then the < Request: Frame (0x3b), iwd never increments its Sequence
> number. It always stays at 0 whereas wpa_supplicant starts its
> sequence at 1
> Also, wpa_supplincant has this flag set:
> < Request: Frame (0x3b) len 80 [ack]                                  14.=
502956
> ...
>     Don't Wait for Ack: true
> ...
>                     Error decoding Supported rates IE len 0: Invalid
> argument (-22)
>                     Tag 92: len 7
>                         56 16 6f 94 3f 4d d9
>   V.o.?M.
>
> With wpa_supplincant, before the AP sends the 'PAE:', we get this
> which is not in any of the iwmon logs with iwd:
> < Request: Set PMKSA (0x34) len 92 [ack]                              14.=
561627
>     Interface Index: 3 (0x00000003)
>     PMKID: len 16
>         05 cb 9d 0d 9a c6 7c 42 77 b5 d2 23 f0 62 f7 4d  ......|Bw..#.b.M
>     MAC Address D8:3A:DD:60:A3:0C
>     Unknown: 287 len 4
>         c0 a8 00 00                                      ....
>     Unknown: 288 len 1
>         46                                               F
>     PMK: 254 len 32
>         35 28 07 cb 94 de 82 e7 0a 5c 73 d3 e4 1f 88 ae  5(.......\s.....
>         74 84 82 66 86 8d b5 aa 79 cb 75 d9 75 8d da 3a  t..f....y.u.u..:
> > Response: Set PMKSA (0x34) len 4 [0x100]                            14.=
562171
>     Status: Success (0)
>
> Is there any more info or help I can provide?

--000000000000971ec5062c8a751d
Content-Type: text/plain; charset="US-ASCII"; name="iwd_dhcp_iwmon.txt"
Content-Disposition: attachment; filename="iwd_dhcp_iwmon.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m6cdn2u82>
X-Attachment-Id: f_m6cdn2u82

PCBSZXF1ZXN0OiBTZXQgQ1FNICgweDNmKSBsZW4gMjggW2Fja10gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA4Ljk1MDM3MwogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAz
KQogICAgQ1FNOiBsZW4gMTYKICAgICAgICBSU1NJIHRocmVzaG9sZHM6CiAgICAgICAgICAgIFRo
cmVzaG9sZDogLTcwCiAgICAgICAgUlNTSSBoeXN0ZXJlc2lzOiA1ICgweDAwMDAwMDA1KQo+IFJl
c3BvbnNlOiBTZXQgQ1FNICgweDNmKSBsZW4gNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDguOTUwNDA1CiAgICBTdGF0dXM6IE9wZXJhdGlvbiBub3Qgc3VwcG9ydGVkICg5
NSkKPCBSZXF1ZXN0OiBDb25uZWN0ICgweDJlKSBsZW4gMTQ4IFthY2tdICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA4Ljk1MDQ2MQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAw
MDAzKQogICAgV2lwaHkgRnJlcXVlbmN5OiAyNDEyICgweDAwMDAwOTZjKQogICAgTUFDIEFkZHJl
c3MgRDg6M0E6REQ6NjA6QTM6MEMKICAgIFNTSUQ6IGxlbiA3CiAgICAgICAgNjQgNjUgNzMgNmIg
NTMgNDEgNDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2tTQUUgICAgICAgICAKICAg
IEF1dGggVHlwZTogNCAoMHgwMDAwMDAwNCkKICAgIEV4dGVybmFsIEF1dGggU3VwcG9ydDogMjYx
IGxlbiAwCiAgICBQcml2YWN5OiB0cnVlCiAgICBTb2NrZXQgT3ducyBJbnRlcmZhY2UvQ29ubmVj
dGlvbjogdHJ1ZQogICAgQ2lwaGVyIFN1aXRlcyBQYWlyd2lzZToKICAgICAgICBDQ01QICgwMDow
ZjphYykgc3VpdGUgIDA0CiAgICBDaXBoZXIgU3VpdGUgR3JvdXA6IENDTVAgKDAwOjBmOmFjKSBz
dWl0ZSAgMDQKICAgIFVzZSBNRlA6IDEgKDB4MDAwMDAwMDEpCiAgICBBS00gU3VpdGVzOgogICAg
ICAgIFNBRS9QTUtTQSBjYWNoaW5nIFNIQTI1NjsgUlNOQSBQTUtTQSBjYWNoaW5nIFNIQTI1Ni9t
ZXNoIHBlZXJpbmcgZXhjaGFuZ2UgKDAwOjBmOmFjKSBzdWl0ZSAgMDgKICAgIFdQQSBWZXJzaW9u
czogNCAoMHgwMDAwMDAwNCkKICAgIENvbnRyb2wgUG9ydDogdHJ1ZQogICAgSW5mb3JtYXRpb24g
RWxlbWVudHM6IGxlbiAzOAogICAgICAgIFJTTjoKICAgICAgICAgICAgR3JvdXAgRGF0YSBDaXBo
ZXIgU3VpdGU6IGxlbiA0CiAgICAgICAgICAgICAgICBDQ01QICgwMDowZjphYykgc3VpdGUgIDA0
CiAgICAgICAgICAgIFBhaXJ3aXNlIENpcGhlciBTdWl0ZTogbGVuIDQKICAgICAgICAgICAgICAg
IENDTVAgKDAwOjBmOmFjKSBzdWl0ZSAgMDQKICAgICAgICAgICAgQUtNIFN1aXRlOiBsZW4gNAog
ICAgICAgICAgICAgICAgU0FFL1BNS1NBIGNhY2hpbmcgU0hBMjU2OyBSU05BIFBNS1NBIGNhY2hp
bmcgU0hBMjU2L21lc2ggcGVlcmluZyBleGNoYW5nZSAoMDA6MGY6YWMpIHN1aXRlICAwOAogICAg
ICAgICAgICBSU04gY2FwYWJpbGl0aWVzOiBiaXRzICAyIC0gMzogMSByZXBsYXkgY291bnRlciBw
ZXIgUFRLU0EKICAgICAgICAgICAgUlNOIGNhcGFiaWxpdGllczogYml0cyAgNCAtIDU6IDEgcmVw
bGF5IGNvdW50ZXIgcGVyIEdUS1NBCiAgICAgICAgICAgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdCAg
NzogTWFuYWdlbWVudCBGcmFtZSBQcm90ZWN0aW9uIENhcGFibGUKICAgICAgICAgICAgMDEgMDAg
MDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgIC4uLi4uLi4uLi4uLi4u
Li4KICAgICAgICAgICAgYWMgMDggODAgMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIC4uLi4gICAgICAgICAgICAKICAgICAgICBFeHRlbmRlZCBDYXBhYmlsaXRpZXM6IGxl
biAxMAogICAgICAgICAgICBDYXBhYmlsaXR5OiBiaXQgMTk6IEJTUyB0cmFuc2l0aW9uCiAgICAg
ICAgICAgIDAwIDAwIDA4IDAwIDAwIDAwIDAwIDAwIDAwIDAxICAgICAgICAgICAgICAgICAgICAu
Li4uLi4uLi4uICAgICAgCiAgICAgICAgVGFnIDI2MjogbGVuIDEKICAgICAgICAgICAgMWEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4gICAgICAgICAgICAg
ICAKPiBSZXNwb25zZTogQ29ubmVjdCAoMHgyZSkgbGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA4Ljk1NzY2NQogICAgU3RhdHVzOiBTdWNjZXNzICgwKQo+IEV2ZW50
OiBFeHRlcm5hbCBBdXRoICgweDdmKSBsZW4gNTYgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDguOTgxNzA1CiAgICBXaXBoeTogMCAoMHgwMDAwMDAwMCkKICAgIEludGVyZmFjZSBJ
bmRleDogMyAoMHgwMDAwMDAwMykKICAgIEFLTSBTdWl0ZXM6CiAgICAgICAgdW5rbm93biAoMDg6
YWM6MGYpIHN1aXRlIDAwICh1bmtub3duKQogICAgRXh0ZXJuYWwgQXV0aCBBY3Rpb246IDI2MCBs
ZW4gNAogICAgICAgIDAwIDAwIDAwIDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAuLi4uICAgICAgICAgICAgCiAgICBCU1NJRCBEODozQTpERDo2MDpBMzowQwogICAgU1NJ
RDogbGVuIDcKICAgICAgICA2NCA2NSA3MyA2YiA1MyA0MSA0NSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGVza1NBRSAgICAgICAgIAo8IFJlcXVlc3Q6IEZyYW1lICgweDNiKSBsZW4gMTQw
IFthY2tdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDguOTkyNDg1CiAgICBJbnRl
cmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBGcmFtZTogbGVuIDEyOAogICAgICAgIEZy
YW1lIFR5cGU6IDB4MDBiMAogICAgICAgICAgICBUeXBlOiBNYW5hZ2VtZW50ICgwKQogICAgICAg
ICAgICBBdXRoZW50aWNhdGlvbjoKICAgICAgICAgICAgICAgIEZyYW1lIENvbnRyb2w6IHByb3Rv
Y29sOiAwMCB0eXBlOiAwMCBzdWJ0eXBlOiAxMSB0bzogMDAgZnJvbTogMDAgbW9yZV9mcmFnczog
MDAKICAgICAgICAgICAgICAgICAgICByZXRyeTogMDAgcG93ZXJfbWdtdDogMDAgbW9yZV9kYXRh
OiAwMCBwcm90ZWN0ZWQ6IDAwIG9yZGVyOiAwMAogICAgICAgICAgICAgICAgRHVyYXRpb246IDAK
ICAgICAgICAgICAgICAgIEFkZHJlc3MgMSAoUkEpOiBEODozQTpERDo2MDpBMzowQwogICAgICAg
ICAgICAgICAgQWRkcmVzcyAyIChUQSk6IERDOkE2OjMyOkI0OjUwOkNGCiAgICAgICAgICAgICAg
ICBBZGRyZXNzIDM6IEQ4OjNBOkREOjYwOkEzOjBDCiAgICAgICAgICAgICAgICBGcmFnbWVudCBO
dW1iZXI6IDAKICAgICAgICAgICAgICAgIFNlcXVlbmNlIE51bWJlcjogMAogICAgICAgICAgICAg
ICAgQWxnb3JpdGhtOiBTQUUgKHNlcTogMSwgc3RhdHVzOiAwKQogICAgICAgIGIwIDAwIDAwIDAw
IGQ4IDNhIGRkIDYwIGEzIDBjIGRjIGE2IDMyIGI0IDUwIGNmICAuLi4uLjouYC4uLi4yLlAuCiAg
ICAgICAgZDggM2EgZGQgNjAgYTMgMGMgMDAgMDAgMDMgMDAgMDEgMDAgMDAgMDAgMTMgMDAgIC46
LmAuLi4uLi4uLi4uLi4KICAgICAgICA5MCA2YSBiNSBjNSBhMiAxNCAyYyBkMCA1ZiA3ZCA0NiBh
NiA5NyA3YyAyZCA1ZCAgLmouLi4uLC5ffUYuLnwtXQogICAgICAgIDFlIDE3IDJhIDk5IDA0IGQw
IGM4IDZiIGEwIDllIDIyIDdlIDBjIDBkIGE0IDAyICAuLiouLi4uay4uIn4uLi4uCiAgICAgICAg
MjMgZTcgODggNWQgNzMgMGYgMTEgYjcgYzYgYzggZTAgZmUgNGMgNTggY2UgZmUgICMuLl1zLi4u
Li4uLkxYLi4KICAgICAgICAxZSAyNSBiYSA2NyA1MSBmZSAzYSA3ZSA4OCAyNCA0ZiA2ZiA2YyBh
NiA2NyAxNyAgLiUuZ1EuOn4uJE9vbC5nLgogICAgICAgIDFhIGM3IDFkIDJkIDBmIGRlIDU3IGUz
IGEyIDA5IDZhIGQyIDk5IDYyIDZmIDYxICAuLi4tLi5XLi4uai4uYm9hCiAgICAgICAgMWYgOTkg
NzEgZjkgYmYgZjUgYmMgMGIgNGQgMjAgMWEgOTQgZTIgMzcgZDAgMjUgIC4ucS4uLi4uTSAuLi43
LiUKPiBFdmVudDogRnJhbWUgVFggU3RhdHVzICgweDNjKSBsZW4gMTc2ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA4Ljk5NDgxOAogICAgV2lwaHk6IDAgKDB4MDAwMDAwMDApCiAgICBJ
bnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBXaXJlbGVzcyBEZXZpY2U6IDEgKDB4
MDAwMDAwMDAwMDAwMDAwMSkKICAgIEZyYW1lOiBsZW4gMTI4CiAgICAgICAgRnJhbWUgVHlwZTog
MHgwMGIwCiAgICAgICAgICAgIFR5cGU6IE1hbmFnZW1lbnQgKDApCiAgICAgICAgICAgIEF1dGhl
bnRpY2F0aW9uOgogICAgICAgICAgICAgICAgRnJhbWUgQ29udHJvbDogcHJvdG9jb2w6IDAwIHR5
cGU6IDAwIHN1YnR5cGU6IDExIHRvOiAwMCBmcm9tOiAwMCBtb3JlX2ZyYWdzOiAwMAogICAgICAg
ICAgICAgICAgICAgIHJldHJ5OiAwMCBwb3dlcl9tZ210OiAwMCBtb3JlX2RhdGE6IDAwIHByb3Rl
Y3RlZDogMDAgb3JkZXI6IDAwCiAgICAgICAgICAgICAgICBEdXJhdGlvbjogMAogICAgICAgICAg
ICAgICAgQWRkcmVzcyAxIChSQSk6IEQ4OjNBOkREOjYwOkEzOjBDCiAgICAgICAgICAgICAgICBB
ZGRyZXNzIDIgKFRBKTogREM6QTY6MzI6QjQ6NTA6Q0YKICAgICAgICAgICAgICAgIEFkZHJlc3Mg
MzogRDg6M0E6REQ6NjA6QTM6MEMKICAgICAgICAgICAgICAgIEZyYWdtZW50IE51bWJlcjogMAog
ICAgICAgICAgICAgICAgU2VxdWVuY2UgTnVtYmVyOiAwCiAgICAgICAgICAgICAgICBBbGdvcml0
aG06IFNBRSAoc2VxOiAxLCBzdGF0dXM6IDApCiAgICAgICAgYjAgMDAgMDAgMDAgZDggM2EgZGQg
NjAgYTMgMGMgZGMgYTYgMzIgYjQgNTAgY2YgIC4uLi4uOi5gLi4uLjIuUC4KICAgICAgICBkOCAz
YSBkZCA2MCBhMyAwYyAwMCAwMCAwMyAwMCAwMSAwMCAwMCAwMCAxMyAwMCAgLjouYC4uLi4uLi4u
Li4uLgogICAgICAgIDkwIDZhIGI1IGM1IGEyIDE0IDJjIGQwIDVmIDdkIDQ2IGE2IDk3IDdjIDJk
IDVkICAuai4uLi4sLl99Ri4ufC1dCiAgICAgICAgMWUgMTcgMmEgOTkgMDQgZDAgYzggNmIgYTAg
OWUgMjIgN2UgMGMgMGQgYTQgMDIgIC4uKi4uLi5rLi4ifi4uLi4KICAgICAgICAyMyBlNyA4OCA1
ZCA3MyAwZiAxMSBiNyBjNiBjOCBlMCBmZSA0YyA1OCBjZSBmZSAgIy4uXXMuLi4uLi4uTFguLgog
ICAgICAgIDFlIDI1IGJhIDY3IDUxIGZlIDNhIDdlIDg4IDI0IDRmIDZmIDZjIGE2IDY3IDE3ICAu
JS5nUS46fi4kT29sLmcuCiAgICAgICAgMWEgYzcgMWQgMmQgMGYgZGUgNTcgZTMgYTIgMDkgNmEg
ZDIgOTkgNjIgNmYgNjEgIC4uLi0uLlcuLi5qLi5ib2EKICAgICAgICAxZiA5OSA3MSBmOSBiZiBm
NSBiYyAwYiA0ZCAyMCAxYSA5NCBlMiAzNyBkMCAyNSAgLi5xLi4uLi5NIC4uLjcuJQogICAgQ29v
a2llOiAwICgweDAwMDAwMDAwMDAwMDAwMDApCiAgICBBQ0s6IHRydWUKPiBSZXN1bHQ6IEZyYW1l
ICgweDNiKSBsZW4gMTIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4
Ljk5NDgzMgogICAgQ29va2llOiAwICgweDAwMDAwMDAwMDAwMDAwMDApCj4gUmVzcG9uc2U6IEZy
YW1lICgweDNiKSBsZW4gNCBbMHgxMDBdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
OC45OTQ4MzgKICAgIFN0YXR1czogU3VjY2VzcyAoMCkKPiBFdmVudDogRnJhbWUgKDB4M2IpIGxl
biAxODQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA4Ljk5ODMyMwog
ICAgV2lwaHk6IDAgKDB4MDAwMDAwMDApCiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAw
MDMpCiAgICBXaXJlbGVzcyBEZXZpY2U6IDEgKDB4MDAwMDAwMDAwMDAwMDAwMSkKICAgIFdpcGh5
IEZyZXF1ZW5jeTogMjQxMiAoMHgwMDAwMDk2YykKICAgIFVua25vd246IDI5MCBsZW4gNAogICAg
ICAgIDAwIDAwIDAwIDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4u
ICAgICAgICAgICAgCiAgICBGcmFtZTogbGVuIDEyOAogICAgICAgIEZyYW1lIFR5cGU6IDB4MDBi
MAogICAgICAgICAgICBUeXBlOiBNYW5hZ2VtZW50ICgwKQogICAgICAgICAgICBBdXRoZW50aWNh
dGlvbjoKICAgICAgICAgICAgICAgIEZyYW1lIENvbnRyb2w6IHByb3RvY29sOiAwMCB0eXBlOiAw
MCBzdWJ0eXBlOiAxMSB0bzogMDAgZnJvbTogMDAgbW9yZV9mcmFnczogMDAKICAgICAgICAgICAg
ICAgICAgICByZXRyeTogMDAgcG93ZXJfbWdtdDogMDAgbW9yZV9kYXRhOiAwMCBwcm90ZWN0ZWQ6
IDAwIG9yZGVyOiAwMAogICAgICAgICAgICAgICAgRHVyYXRpb246IDAKICAgICAgICAgICAgICAg
IEFkZHJlc3MgMSAoUkEpOiBEQzpBNjozMjpCNDo1MDpDRgogICAgICAgICAgICAgICAgQWRkcmVz
cyAyIChUQSk6IEQ4OjNBOkREOjYwOkEzOjBDCiAgICAgICAgICAgICAgICBBZGRyZXNzIDM6IDAw
OjAwOjAwOjAwOjAwOjAwCiAgICAgICAgICAgICAgICBGcmFnbWVudCBOdW1iZXI6IDAKICAgICAg
ICAgICAgICAgIFNlcXVlbmNlIE51bWJlcjogMAogICAgICAgICAgICAgICAgQWxnb3JpdGhtOiBT
QUUgKHNlcTogMSwgc3RhdHVzOiAwKQogICAgICAgIGIwIDAwIDAwIDAwIGRjIGE2IDMyIGI0IDUw
IGNmIGQ4IDNhIGRkIDYwIGEzIDBjICAuLi4uLi4yLlAuLjouYC4uCiAgICAgICAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgMDMgMDAgMDEgMDAgMDAgMDAgMTMgMDAgIC4uLi4uLi4uLi4uLi4uLi4K
ICAgICAgICBmNSA5OCA0ZCA1OCA0YSBhYiAwNyBiMCA5NCA0MiAxNyBmMiBiMSA0ZCA2MSAzMiAg
Li5NWEouLi4uQi4uLk1hMgogICAgICAgIDYyIDc3IDM3IDI1IDAzIDFhIGZhIDYwIDRmIDQyIGJh
IDdjIDVmIDAzIDhlIDQ3ICBidzclLi4uYE9CLnxfLi5HCiAgICAgICAgNmUgNzAgYzUgZjUgNTMg
ZDIgNDggMWUgM2UgY2YgYTggNmEgNTcgNjEgNGYgMTUgIG5wLi5TLkguPi4ualdhTy4KICAgICAg
ICBhMiA4YSA5NSBiNCBhYSA5MSA3OSAzYyA0MyBlYyBkNyBiMiBmNyBkYiAxZiA0YSAgLi4uLi4u
eTxDLi4uLi4uSgogICAgICAgIDAwIDczIDkyIDIwIDEzIDY1IGEyIDgyIGZkIDgwIGJmIDNmIGQy
IDlkIGEyIDZlICAucy4gLmUuLi4uLj8uLi5uCiAgICAgICAgYWUgMjAgZDUgZmEgM2UgM2MgNzkg
ZjkgNjEgY2IgMjQgMjggYzEgYWYgZjkgNmQgIC4gLi4+PHkuYS4kKC4uLm0KICAgIFJYIE1hbmFn
ZW1lbnQgRmxhZ3M6IDIgKDB4MDAwMDAwMDIpCjwgUmVxdWVzdDogRnJhbWUgKDB4M2IpIGxlbiA3
NiBbYWNrXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOS4wMDE2NTgKICAgIElu
dGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAgIEZyYW1lOiBsZW4gNjQKICAgICAgICBG
cmFtZSBUeXBlOiAweDAwYjAKICAgICAgICAgICAgVHlwZTogTWFuYWdlbWVudCAoMCkKICAgICAg
ICAgICAgQXV0aGVudGljYXRpb246CiAgICAgICAgICAgICAgICBGcmFtZSBDb250cm9sOiBwcm90
b2NvbDogMDAgdHlwZTogMDAgc3VidHlwZTogMTEgdG86IDAwIGZyb206IDAwIG1vcmVfZnJhZ3M6
IDAwCiAgICAgICAgICAgICAgICAgICAgcmV0cnk6IDAwIHBvd2VyX21nbXQ6IDAwIG1vcmVfZGF0
YTogMDAgcHJvdGVjdGVkOiAwMCBvcmRlcjogMDAKICAgICAgICAgICAgICAgIER1cmF0aW9uOiAw
CiAgICAgICAgICAgICAgICBBZGRyZXNzIDEgKFJBKTogRDg6M0E6REQ6NjA6QTM6MEMKICAgICAg
ICAgICAgICAgIEFkZHJlc3MgMiAoVEEpOiBEQzpBNjozMjpCNDo1MDpDRgogICAgICAgICAgICAg
ICAgQWRkcmVzcyAzOiBEODozQTpERDo2MDpBMzowQwogICAgICAgICAgICAgICAgRnJhZ21lbnQg
TnVtYmVyOiAwCiAgICAgICAgICAgICAgICBTZXF1ZW5jZSBOdW1iZXI6IDAKICAgICAgICAgICAg
ICAgIEFsZ29yaXRobTogU0FFIChzZXE6IDIsIHN0YXR1czogMCkKICAgICAgICAgICAgICAgIElF
czogbGVuIDM0CiAgICAgICAgICAgICAgICAgICAgRXJyb3IgZGVjb2RpbmcgU3VwcG9ydGVkIHJh
dGVzIElFIGxlbiAwOiBJbnZhbGlkIGFyZ3VtZW50ICgtMjIpCiAgICAgICAgYjAgMDAgMDAgMDAg
ZDggM2EgZGQgNjAgYTMgMGMgZGMgYTYgMzIgYjQgNTAgY2YgIC4uLi4uOi5gLi4uLjIuUC4KICAg
ICAgICBkOCAzYSBkZCA2MCBhMyAwYyAwMCAwMCAwMyAwMCAwMiAwMCAwMCAwMCAwMSAwMCAgLjou
YC4uLi4uLi4uLi4uLgogICAgICAgIDg4IGVmIGViIDU1IDczIDQyIDExIDBhIDAzIDNiIDZhIDU4
IGZiIDZmIDY2IDE1ICAuLi5Vc0IuLi47algub2YuCiAgICAgICAgODIgZjYgYTcgYjUgMTEgNWEg
MGUgOWUgNzIgZmYgNDYgYjggYmMgNDAgMWIgMzkgIC4uLi4uWi4uci5GLi5ALjkKPiBFdmVudDog
RnJhbWUgVFggU3RhdHVzICgweDNjKSBsZW4gMTEyICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA5LjAwNDk0NAogICAgV2lwaHk6IDAgKDB4MDAwMDAwMDApCiAgICBJbnRlcmZhY2UgSW5k
ZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBXaXJlbGVzcyBEZXZpY2U6IDEgKDB4MDAwMDAwMDAwMDAw
MDAwMSkKICAgIEZyYW1lOiBsZW4gNjQKICAgICAgICBGcmFtZSBUeXBlOiAweDAwYjAKICAgICAg
ICAgICAgVHlwZTogTWFuYWdlbWVudCAoMCkKICAgICAgICAgICAgQXV0aGVudGljYXRpb246CiAg
ICAgICAgICAgICAgICBGcmFtZSBDb250cm9sOiBwcm90b2NvbDogMDAgdHlwZTogMDAgc3VidHlw
ZTogMTEgdG86IDAwIGZyb206IDAwIG1vcmVfZnJhZ3M6IDAwCiAgICAgICAgICAgICAgICAgICAg
cmV0cnk6IDAwIHBvd2VyX21nbXQ6IDAwIG1vcmVfZGF0YTogMDAgcHJvdGVjdGVkOiAwMCBvcmRl
cjogMDAKICAgICAgICAgICAgICAgIER1cmF0aW9uOiAwCiAgICAgICAgICAgICAgICBBZGRyZXNz
IDEgKFJBKTogRDg6M0E6REQ6NjA6QTM6MEMKICAgICAgICAgICAgICAgIEFkZHJlc3MgMiAoVEEp
OiBEQzpBNjozMjpCNDo1MDpDRgogICAgICAgICAgICAgICAgQWRkcmVzcyAzOiBEODozQTpERDo2
MDpBMzowQwogICAgICAgICAgICAgICAgRnJhZ21lbnQgTnVtYmVyOiAwCiAgICAgICAgICAgICAg
ICBTZXF1ZW5jZSBOdW1iZXI6IDAKICAgICAgICAgICAgICAgIEFsZ29yaXRobTogU0FFIChzZXE6
IDIsIHN0YXR1czogMCkKICAgICAgICAgICAgICAgIElFczogbGVuIDM0CiAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgZGVjb2RpbmcgU3VwcG9ydGVkIHJhdGVzIElFIGxlbiAwOiBJbnZhbGlkIGFy
Z3VtZW50ICgtMjIpCiAgICAgICAgYjAgMDAgMDAgMDAgZDggM2EgZGQgNjAgYTMgMGMgZGMgYTYg
MzIgYjQgNTAgY2YgIC4uLi4uOi5gLi4uLjIuUC4KICAgICAgICBkOCAzYSBkZCA2MCBhMyAwYyAw
MCAwMCAwMyAwMCAwMiAwMCAwMCAwMCAwMSAwMCAgLjouYC4uLi4uLi4uLi4uLgogICAgICAgIDg4
IGVmIGViIDU1IDczIDQyIDExIDBhIDAzIDNiIDZhIDU4IGZiIDZmIDY2IDE1ICAuLi5Vc0IuLi47
algub2YuCiAgICAgICAgODIgZjYgYTcgYjUgMTEgNWEgMGUgOWUgNzIgZmYgNDYgYjggYmMgNDAg
MWIgMzkgIC4uLi4uWi4uci5GLi5ALjkKICAgIENvb2tpZTogMCAoMHgwMDAwMDAwMDAwMDAwMDAw
KQogICAgQUNLOiB0cnVlCj4gUmVzdWx0OiBGcmFtZSAoMHgzYikgbGVuIDEyICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOS4wMDQ5NTUKICAgIENvb2tpZTogMCAoMHgw
MDAwMDAwMDAwMDAwMDAwKQo+IFJlc3BvbnNlOiBGcmFtZSAoMHgzYikgbGVuIDQgWzB4MTAwXSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDA0OTYwCiAgICBTdGF0dXM6IFN1Y2Nl
c3MgKDApCj4gRXZlbnQ6IEZyYW1lICgweDNiKSBsZW4gMTIwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgOS4wMDYwOTcKICAgIFdpcGh5OiAwICgweDAwMDAwMDAwKQog
ICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgV2lyZWxlc3MgRGV2aWNlOiAx
ICgweDAwMDAwMDAwMDAwMDAwMDEpCiAgICBXaXBoeSBGcmVxdWVuY3k6IDI0MTIgKDB4MDAwMDA5
NmMpCiAgICBVbmtub3duOiAyOTAgbGVuIDQKICAgICAgICAwMCAwMCAwMCAwMCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLiAgICAgICAgICAgIAogICAgRnJhbWU6IGxl
biA2NAogICAgICAgIEZyYW1lIFR5cGU6IDB4MDBiMAogICAgICAgICAgICBUeXBlOiBNYW5hZ2Vt
ZW50ICgwKQogICAgICAgICAgICBBdXRoZW50aWNhdGlvbjoKICAgICAgICAgICAgICAgIEZyYW1l
IENvbnRyb2w6IHByb3RvY29sOiAwMCB0eXBlOiAwMCBzdWJ0eXBlOiAxMSB0bzogMDAgZnJvbTog
MDAgbW9yZV9mcmFnczogMDAKICAgICAgICAgICAgICAgICAgICByZXRyeTogMDAgcG93ZXJfbWdt
dDogMDAgbW9yZV9kYXRhOiAwMCBwcm90ZWN0ZWQ6IDAwIG9yZGVyOiAwMAogICAgICAgICAgICAg
ICAgRHVyYXRpb246IDAKICAgICAgICAgICAgICAgIEFkZHJlc3MgMSAoUkEpOiBEQzpBNjozMjpC
NDo1MDpDRgogICAgICAgICAgICAgICAgQWRkcmVzcyAyIChUQSk6IEQ4OjNBOkREOjYwOkEzOjBD
CiAgICAgICAgICAgICAgICBBZGRyZXNzIDM6IDAwOjAwOjAwOjAwOjAwOjAwCiAgICAgICAgICAg
ICAgICBGcmFnbWVudCBOdW1iZXI6IDAKICAgICAgICAgICAgICAgIFNlcXVlbmNlIE51bWJlcjog
MAogICAgICAgICAgICAgICAgQWxnb3JpdGhtOiBTQUUgKHNlcTogMiwgc3RhdHVzOiAwKQogICAg
ICAgICAgICAgICAgSUVzOiBsZW4gMzQKICAgICAgICAgICAgICAgICAgICBFcnJvciBkZWNvZGlu
ZyBTdXBwb3J0ZWQgcmF0ZXMgSUUgbGVuIDA6IEludmFsaWQgYXJndW1lbnQgKC0yMikKICAgICAg
ICBiMCAwMCAwMCAwMCBkYyBhNiAzMiBiNCA1MCBjZiBkOCAzYSBkZCA2MCBhMyAwYyAgLi4uLi4u
Mi5QLi46LmAuLgogICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAzIDAwIDAyIDAwIDAw
IDAwIDAxIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgYjEgNTIgZTcgNTcgZjAgMGYgMzUg
MzcgYzkgZGIgZWYgOTYgZjIgZDYgMzMgZTQgIC5SLlcuLjU3Li4uLi4uMy4KICAgICAgICBiMiA5
NCBhYyBlYSA3MSBhOCBhZiAyNyA4NSA1ZCA5YiBkNiBmYiBjYiBhNyAwNCAgLi4uLnEuLicuXS4u
Li4uLgogICAgUlggTWFuYWdlbWVudCBGbGFnczogMiAoMHgwMDAwMDAwMikKPCBSZXF1ZXN0OiBF
eHRlcm5hbCBBdXRoICgweDdmKSBsZW4gNDAgW2Fja10gICAgICAgICAgICAgICAgICAgICAgICAg
ICA5LjAwNjMxOQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgU3RhdHVz
IENvZGU6IDAgKDB4MDAwMCkKICAgIFNTSUQ6IGxlbiA3CiAgICAgICAgNjQgNjUgNzMgNmIgNTMg
NDEgNDUgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlc2tTQUUgICAgICAgICAKICAgIEJT
U0lEIEQ4OjNBOkREOjYwOkEzOjBDCj4gUmVzcG9uc2U6IEV4dGVybmFsIEF1dGggKDB4N2YpIGxl
biA0IFsweDEwMF0gICAgICAgICAgICAgICAgICAgICAgICAgOS4wMDY5MzQKICAgIFN0YXR1czog
U3VjY2VzcyAoMCkKPiBQQUU6IGxlbiAxMjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAxMTQxMAogICAgSW50ZXJmYWNlIEluZGV4OiAz
CiAgICBFQVBvTDogbGVuIDEyMQogICAgICAgIFByb3RvY29sIFZlcnNpb246IDIgKDgwMi4xWC0y
MDA0KQogICAgICAgIFR5cGU6IDMgKEtleSkKICAgICAgICBMZW5ndGg6IDExNwogICAgICAgIERl
c2NyaXB0b3IgVHlwZTogMgogICAgICAgIEtleSBNSUM6IGZhbHNlCiAgICAgICAgU2VjdXJlOiBm
YWxzZQogICAgICAgIEVycm9yOiBmYWxzZQogICAgICAgIFJlcXVlc3Q6IGZhbHNlCiAgICAgICAg
RW5jcnlwdGVkIEtleSBEYXRhOiBmYWxzZQogICAgICAgIFNNSyBNZXNzYWdlOiBmYWxzZQogICAg
ICAgIEtleSBEZXNjcmlwdG9yIFZlcnNpb246IDAgKDAwKQogICAgICAgIEtleSBUeXBlOiB0cnVl
CiAgICAgICAgSW5zdGFsbDogZmFsc2UKICAgICAgICBLZXkgQUNLOiB0cnVlCiAgICAgICAgS2V5
IExlbmd0aDogMTYKICAgICAgICBLZXkgUmVwbGF5IENvdW50ZXI6IDEKICAgICAgICBLZXkgTk9O
Q0UKICAgICAgICAgICAgNjkgZTMgNDYgMjcgNDAgODYgMTUgYzEgYzQgYWMgZjIgMTAgZTcgNmUg
N2YgNDAgIGkuRidALi4uLi4uLi5uLkAKICAgICAgICAgICAgOTEgNzIgOTMgZjYgYTMgMjUgYzcg
NGMgYTUgNjMgMmQgOWYgMDYgMjYgOTIgMzAgIC5yLi4uJS5MLmMtLi4mLjAKICAgICAgICBLZXkg
SVYKICAgICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICBLZXkgUlNDIAogICAgICAgICAgICAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLi4uLi4gICAg
ICAgIAogICAgICAgIEtleSBNSUMgRGF0YQogICAgICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogICAgICAgIEtl
eSBEYXRhOiBsZW4gMjIKICAgICAgICAgICAgVmVuZG9yIHNwZWNpZmljOiBsZW4gMjAKICAgICAg
ICAgICAgICAgIElFRUUgODAyLjExICgwMDowZjphYykgdHlwZTogMDQKICAgICAgICAgICAgICAg
IFBNS0lEIEtERQogICAgICAgICAgICAgICAgMDAgMGYgYWMgMDQgODYgMDMgMDMgMWUgZWMgYmYg
MzQgN2YgZjMgYmYgNWUgOTkgIC4uLi4uLi4uLi40Li4uXi4KICAgICAgICAgICAgICAgIDQ4IGM5
IDhlIDhmICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBILi4uICAgICAgICAg
ICAgCiAgICAgICAgMDIgMDMgMDAgNzUgMDIgMDAgODggMDAgMTAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgIC4uLnUuLi4uLi4uLi4uLi4KICAgICAgICAwMSA2OSBlMyA0NiAyNyA0MCA4NiAxNSBjMSBj
NCBhYyBmMiAxMCBlNyA2ZSA3ZiAgLmkuRidALi4uLi4uLi5uLgogICAgICAgIDQwIDkxIDcyIDkz
IGY2IGEzIDI1IGM3IDRjIGE1IDYzIDJkIDlmIDA2IDI2IDkyICBALnIuLi4lLkwuYy0uLiYuCiAg
ICAgICAgMzAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIDAu
Li4uLi4uLi4uLi4uLi4KICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogICAgICAgIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAg
MDAgMDAgMTYgZGQgMTQgMDAgMGYgYWMgMDQgODYgMDMgMDMgMWUgZWMgYmYgMzQgIC4uLi4uLi4u
Li4uLi4uLjQKICAgICAgICA3ZiBmMyBiZiA1ZSA5OSA0OCBjOSA4ZSA4ZiAgICAgICAgICAgICAg
ICAgICAgICAgLi4uXi5ILi4uICAgICAgIAo+IEV2ZW50OiBDb25uZWN0ICgweDJlKSBsZW4gMTU2
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDM4OTQxCiAgICBXaXBo
eTogMCAoMHgwMDAwMDAwMCkKICAgIEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAg
IE1BQyBBZGRyZXNzIEQ4OjNBOkREOjYwOkEzOjBDCiAgICBTdGF0dXMgQ29kZTogMCAoMHgwMDAw
KQogICAgUmVxdWVzdCBJRTogbGVuIDgwCiAgICAgICAgU1NJRDogZGVza1NBRQogICAgICAgICAg
ICA2NCA2NSA3MyA2YiA1MyA0MSA0NSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVza1NB
RSAgICAgICAgIAogICAgICAgIFN1cHBvcnRlZCByYXRlczoKICAgICAgICAgICAgMS4wKEIpIDIu
MChCKSA1LjUoQikgMTEuMChCKSAxOC4wIDI0LjAgMzYuMCA1NC4wIE1iaXQvcwogICAgICAgICAg
ICA4MiA4NCA4YiA5NiAyNCAzMCA0OCA2YyAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLiQw
SGwgICAgICAgIAogICAgICAgIEV4dGVuZGVkIHN1cHBvcnRlZCByYXRlczoKICAgICAgICAgICAg
Ni4wIDkuMCAxMi4wIDQ4LjAgTWJpdC9zCiAgICAgICAgICAgIDBjIDEyIDE4IDYwICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi5gICAgICAgICAgICAgCiAgICAgICAgVGFn
IDMzOiBsZW4gMgogICAgICAgICAgICAwMyAxNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLi4gICAgICAgICAgICAgIAogICAgICAgIFRhZyAzNjogbGVuIDIKICAg
ICAgICAgICAgMDEgMGIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC4uICAgICAgICAgICAgICAKICAgICAgICBSU046CiAgICAgICAgICAgIEdyb3VwIERhdGEgQ2lw
aGVyIFN1aXRlOiBsZW4gNAogICAgICAgICAgICAgICAgQ0NNUCAoMDA6MGY6YWMpIHN1aXRlICAw
NAogICAgICAgICAgICBQYWlyd2lzZSBDaXBoZXIgU3VpdGU6IGxlbiA0CiAgICAgICAgICAgICAg
ICBDQ01QICgwMDowZjphYykgc3VpdGUgIDA0CiAgICAgICAgICAgIEFLTSBTdWl0ZTogbGVuIDQK
ICAgICAgICAgICAgICAgIFNBRS9QTUtTQSBjYWNoaW5nIFNIQTI1NjsgUlNOQSBQTUtTQSBjYWNo
aW5nIFNIQTI1Ni9tZXNoIHBlZXJpbmcgZXhjaGFuZ2UgKDAwOjBmOmFjKSBzdWl0ZSAgMDgKICAg
ICAgICAgICAgUlNOIGNhcGFiaWxpdGllczogYml0cyAgMiAtIDM6IDEgcmVwbGF5IGNvdW50ZXIg
cGVyIFBUS1NBCiAgICAgICAgICAgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdHMgIDQgLSA1OiAxIHJl
cGxheSBjb3VudGVyIHBlciBHVEtTQQogICAgICAgICAgICBSU04gY2FwYWJpbGl0aWVzOiBiaXQg
IDc6IE1hbmFnZW1lbnQgRnJhbWUgUHJvdGVjdGlvbiBDYXBhYmxlCiAgICAgICAgICAgIDAxIDAw
IDAwIDBmIGFjIDA0IDAxIDAwIDAwIDBmIGFjIDA0IDAxIDAwIDAwIDBmICAuLi4uLi4uLi4uLi4u
Li4uCiAgICAgICAgICAgIGFjIDA4IDgwIDAwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAuLi4uICAgICAgICAgICAgCiAgICAgICAgRXh0ZW5kZWQgQ2FwYWJpbGl0aWVzOiBs
ZW4gOAogICAgICAgICAgICBDYXBhYmlsaXR5OiBiaXQgNjI6IE9wbW9kZSBOb3RpZmljYXRpb24K
ICAgICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgNDAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC4uLi4uLi5AICAgICAgICAKICAgICAgICBWZW5kb3Igc3BlY2lmaWM6IGxlbiA5CiAgICAg
ICAgICAgIEJyb2FkY29tICgwMDoxMDoxOCkgdHlwZTogMDIKICAgICAgICAgICAgMDAgMTAgMTgg
MDIgMDAgMDAgMTAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uLi4uLiAgICAgICAK
ICAgICAgICBTU0lEOiAKICAgICAgICBTU0lEOiAKICAgIFJlc3BvbnNlIElFOiBsZW4gMzIKICAg
ICAgICBTdXBwb3J0ZWQgcmF0ZXM6CiAgICAgICAgICAgIDEuMChCKSAyLjAoQikgNS41KEIpIDEx
LjAoQikgNi4wIDkuMCAxMi4wIDE4LjAgTWJpdC9zCiAgICAgICAgICAgIDgyIDg0IDhiIDk2IDBj
IDEyIDE4IDI0ICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4uLi4uJCAgICAgICAgCiAgICAg
ICAgRXh0ZW5kZWQgc3VwcG9ydGVkIHJhdGVzOgogICAgICAgICAgICAyNC4wIDM2LjAgNDguMCA1
NC4wIE1iaXQvcwogICAgICAgICAgICAzMCA0OCA2MCA2YyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMEhgbCAgICAgICAgICAgIAogICAgICAgIEV4dGVuZGVkIENhcGFiaWxp
dGllczogbGVuIDgKICAgICAgICAgICAgQ2FwYWJpbGl0eTogYml0ICAyOiBFeHRlbmRlZCBjaGFu
bmVsIHN3aXRjaGluZwogICAgICAgICAgICBDYXBhYmlsaXR5OiBiaXQgNjI6IE9wbW9kZSBOb3Rp
ZmljYXRpb24KICAgICAgICAgICAgMDQgMDAgMDAgMDAgMDAgMDAgMDAgNDAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC4uLi4uLi5AICAgICAgICAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVu
IDEyOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzODk2OQogICAg
RmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAg
UG9ydCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAg
SUZMQSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgx
MDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVu
OjYpOiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gOTYKICAgICAgICAgICAgNjAgMDAgMDcg
OGMgMDAgMDAgMDAgMDAgNTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIGAuLi4uLi4uUC4uLi4uLi4K
ICAgICAgICAgICAgMDAgMDcgNjQgNjUgNzMgNmIgNTMgNDEgNDUgMDEgMDggODIgODQgOGIgOTYg
MjQgIC4uZGVza1NBRS4uLi4uLiQKICAgICAgICAgICAgMzAgNDggNmMgMzIgMDQgMGMgMTIgMTgg
NjAgMjEgMDIgMDMgMTQgMjQgMDIgMDEgIDBIbDIuLi4uYCEuLi4kLi4KICAgICAgICAgICAgMGIg
MzAgMTQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgIC4wLi4uLi4uLi4u
Li4uLi4KICAgICAgICAgICAgMDAgMDAgMGYgYWMgMDggODAgMDAgN2YgMDggMDAgMDAgMDAgMDAg
MDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAgNDAgZGQgMDkgMDAgMTAgMTgg
MDIgMDAgMDAgMTAgMDAgMDAgMDAgMDAgMDAgMDAgIEAuLi4uLi4uLi4uLi4uLi4KPiBSVE5MOiBO
ZXcgTGluayAoMHgxMCkgbGVuIDEyOCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA5LjAzODk3NQogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAw
ICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAg
IElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAg
ICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQog
ICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gOTYKICAg
ICAgICAgICAgNjAgMDAgMDcgOGMgMDAgMDAgMDAgMDAgNTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
IGAuLi4uLi4uUC4uLi4uLi4KICAgICAgICAgICAgMDAgMDcgNjQgNjUgNzMgNmIgNTMgNDEgNDUg
MDEgMDggODIgODQgOGIgOTYgMjQgIC4uZGVza1NBRS4uLi4uLiQKICAgICAgICAgICAgMzAgNDgg
NmMgMzIgMDQgMGMgMTIgMTggNjAgMjEgMDIgMDMgMTQgMjQgMDIgMDEgIDBIbDIuLi4uYCEuLi4k
Li4KICAgICAgICAgICAgMGIgMzAgMTQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMg
MDQgMDEgIC4wLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAgMDAgMDAgMGYgYWMgMDggODAgMDAg
N2YgMDggMDAgMDAgMDAgMDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAg
NDAgZGQgMDkgMDAgMTAgMTggMDIgMDAgMDAgMTAgMDAgMDAgMDAgMDAgMDAgMDAgIEAuLi4uLi4u
Li4uLi4uLi4KPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDEyOCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA5LjAzODk4MQogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAg
U2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZMQSBG
YW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAgSUZM
QSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1
bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdp
cmVsZXNzOiBsZW4gOTYKICAgICAgICAgICAgNjAgMDAgMDcgOGMgMDAgMDAgMDAgMDAgNTAgMDAg
MDAgMDAgMDAgMDAgMDAgMDAgIGAuLi4uLi4uUC4uLi4uLi4KICAgICAgICAgICAgMDAgMDcgNjQg
NjUgNzMgNmIgNTMgNDEgNDUgMDEgMDggODIgODQgOGIgOTYgMjQgIC4uZGVza1NBRS4uLi4uLiQK
ICAgICAgICAgICAgMzAgNDggNmMgMzIgMDQgMGMgMTIgMTggNjAgMjEgMDIgMDMgMTQgMjQgMDIg
MDEgIDBIbDIuLi4uYCEuLi4kLi4KICAgICAgICAgICAgMGIgMzAgMTQgMDEgMDAgMDAgMGYgYWMg
MDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgIC4wLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAgMDAg
MDAgMGYgYWMgMDggODAgMDAgN2YgMDggMDAgMDAgMDAgMDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4u
Li4uLi4KICAgICAgICAgICAgNDAgZGQgMDkgMDAgMTAgMTggMDIgMDAgMDAgMTAgMDAgMDAgMDAg
MDAgMDAgMDAgIEAuLi4uLi4uLi4uLi4uLi4KPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDEy
OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzODk4NwogICAgRmxh
Z3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9y
dCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZM
QSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQz
KSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYp
OiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gOTYKICAgICAgICAgICAgNjAgMDAgMDcgOGMg
MDAgMDAgMDAgMDAgNTAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIGAuLi4uLi4uUC4uLi4uLi4KICAg
ICAgICAgICAgMDAgMDcgNjQgNjUgNzMgNmIgNTMgNDEgNDUgMDEgMDggODIgODQgOGIgOTYgMjQg
IC4uZGVza1NBRS4uLi4uLiQKICAgICAgICAgICAgMzAgNDggNmMgMzIgMDQgMGMgMTIgMTggNjAg
MjEgMDIgMDMgMTQgMjQgMDIgMDEgIDBIbDIuLi4uYCEuLi4kLi4KICAgICAgICAgICAgMGIgMzAg
MTQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgIC4wLi4uLi4uLi4uLi4u
Li4KICAgICAgICAgICAgMDAgMDAgMGYgYWMgMDggODAgMDAgN2YgMDggMDAgMDAgMDAgMDAgMDAg
MDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAgICAgNDAgZGQgMDkgMDAgMTAgMTggMDIg
MDAgMDAgMTAgMDAgMDAgMDAgMDAgMDAgMDAgIEAuLi4uLi4uLi4uLi4uLi4KPiBSVE5MOiBOZXcg
TGluayAoMHgxMCkgbGVuIDgwICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICA5LjAzOTAxNAogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgw
eDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElG
TEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJ
RkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAg
ICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gNDgKICAgICAg
ICAgICAgMzAgMDAgMDggOGMgMDAgMDAgMDAgMDAgMjAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIDAu
Li4uLi4uIC4uLi4uLi4KICAgICAgICAgICAgMDEgMDggODIgODQgOGIgOTYgMGMgMTIgMTggMjQg
MzIgMDQgMzAgNDggNjAgNmMgIC4uLi4uLi4uLiQyLjBIYGwKICAgICAgICAgICAgN2YgMDggMDQg
MDAgMDAgMDAgMDAgMDAgMDAgNDAgODIgODQgOGIgOTYgMjQgMzAgIC4uLi4uLi4uLkAuLi4uJDAK
PiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDgwICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA5LjAzOTAxOQogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2Ug
bnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVu
a25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VN
YXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVs
dGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBs
ZW4gNDgKICAgICAgICAgICAgMzAgMDAgMDggOGMgMDAgMDAgMDAgMDAgMjAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgIDAuLi4uLi4uIC4uLi4uLi4KICAgICAgICAgICAgMDEgMDggODIgODQgOGIgOTYg
MGMgMTIgMTggMjQgMzIgMDQgMzAgNDggNjAgNmMgIC4uLi4uLi4uLiQyLjBIYGwKICAgICAgICAg
ICAgN2YgMDggMDQgMDAgMDAgMDAgMDAgMDAgMDAgNDAgODIgODQgOGIgOTYgMjQgMzAgIC4uLi4u
Li4uLkAuLi4uJDAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDgwICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAyMgogICAgRmxhZ3M6IDAgKDB4MDAwKQog
ICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZM
QSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAg
SUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0
LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAg
IFdpcmVsZXNzOiBsZW4gNDgKICAgICAgICAgICAgMzAgMDAgMDggOGMgMDAgMDAgMDAgMDAgMjAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgIDAuLi4uLi4uIC4uLi4uLi4KICAgICAgICAgICAgMDEgMDgg
ODIgODQgOGIgOTYgMGMgMTIgMTggMjQgMzIgMDQgMzAgNDggNjAgNmMgIC4uLi4uLi4uLiQyLjBI
YGwKICAgICAgICAgICAgN2YgMDggMDQgMDAgMDAgMDAgMDAgMDAgMDAgNDAgODIgODQgOGIgOTYg
MjQgMzAgIC4uLi4uLi4uLkAuLi4uJDAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDgwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAyNAogICAgRmxhZ3M6
IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJ
RDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJ
bmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBb
dXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3
bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gNDgKICAgICAgICAgICAgMzAgMDAgMDggOGMgMDAg
MDAgMDAgMDAgMjAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgIDAuLi4uLi4uIC4uLi4uLi4KICAgICAg
ICAgICAgMDEgMDggODIgODQgOGIgOTYgMGMgMTIgMTggMjQgMzIgMDQgMzAgNDggNjAgNmMgIC4u
Li4uLi4uLiQyLjBIYGwKICAgICAgICAgICAgN2YgMDggMDQgMDAgMDAgMDAgMDAgMDAgMDAgNDAg
ODIgODQgOGIgOTYgMjQgMzAgIC4uLi4uLi4uLkAuLi4uJDAKPiBSVE5MOiBOZXcgTGluayAoMHgx
MCkgbGVuIDU2ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAy
OAogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAw
KQogICAgUG9ydCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTog
MQogICAgSUZMQSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdz
OiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFt
ZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gMjQKICAgICAgICAgICAgMTgg
MDAgMTUgOGIgMDAgMDAgMDAgMDAgMDEgMDAgZDggM2EgZGQgNjAgYTMgMGMgIC4uLi4uLi4uLi4u
Oi5gLi4KICAgICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC4uLi4uLi4uICAgICAgICAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDU2
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAzMQogICAgRmxh
Z3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9y
dCBJRDogMAogICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZM
QSBJbmRleDogMwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQz
KSBbdXAsYnJvYWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYp
OiB3bGFuMAogICAgICAgIFdpcmVsZXNzOiBsZW4gMjQKICAgICAgICAgICAgMTggMDAgMTUgOGIg
MDAgMDAgMDAgMDAgMDEgMDAgZDggM2EgZGQgNjAgYTMgMGMgIC4uLi4uLi4uLi4uOi5gLi4KICAg
ICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgICAg
IC4uLi4uLi4uICAgICAgICAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDU2ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAzMwogICAgRmxhZ3M6IDAgKDB4
MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAog
ICAgSUZMQSBGYW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDog
MwogICAgSUZMQSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJv
YWRjYXN0LHJ1bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAog
ICAgICAgIFdpcmVsZXNzOiBsZW4gMjQKICAgICAgICAgICAgMTggMDAgMTUgOGIgMDAgMDAgMDAg
MDAgMDEgMDAgZDggM2EgZGQgNjAgYTMgMGMgIC4uLi4uLi4uLi4uOi5gLi4KICAgICAgICAgICAg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uLi4u
ICAgICAgICAKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDU2ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA5LjAzOTAzNgogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAg
U2VxdWVuY2UgbnVtYmVyOiAwICgweDAwMDAwMDAwKQogICAgUG9ydCBJRDogMAogICAgSUZMQSBG
YW1pbHk6IFVua25vd24KICAgIElGTEEgVHlwZTogMQogICAgSUZMQSBJbmRleDogMwogICAgSUZM
QSBDaGFuZ2VNYXNrOiAwCiAgICBJRkxBIEZsYWdzOiAoMHgxMDQzKSBbdXAsYnJvYWRjYXN0LHJ1
bm5pbmcsbXVsdGljYXN0XQogICAgICAgIElmTmFtZSAobGVuOjYpOiB3bGFuMAogICAgICAgIFdp
cmVsZXNzOiBsZW4gMjQKICAgICAgICAgICAgMTggMDAgMTUgOGIgMDAgMDAgMDAgMDAgMDEgMDAg
ZDggM2EgZGQgNjAgYTMgMGMgIC4uLi4uLi4uLi4uOi5gLi4KICAgICAgICAgICAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uLi4uICAgICAgICAK
PCBSZXF1ZXN0OiBHZXQgSW50ZXJmYWNlICgweDA1KSBsZW4gOCBbYWNrXSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA5LjAzOTA0OQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAz
KQo+IFJlc3VsdDogTmV3IEludGVyZmFjZSAoMHgwNykgbGVuIDEzNiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDkuMDQwNTQ0CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAw
MDMpCiAgICBJbnRlcmZhY2UgTmFtZTogd2xhbjAKICAgIFdpcGh5OiAwICgweDAwMDAwMDAwKQog
ICAgSW50ZXJmYWNlIFR5cGU6IDIgKDB4MDAwMDAwMDIpCiAgICBXaXJlbGVzcyBEZXZpY2U6IDEg
KDB4MDAwMDAwMDAwMDAwMDAwMSkKICAgIE1BQyBBZGRyZXNzIERDOkE2OjMyOkI0OjUwOkNGCiAg
ICBHZW5lcmF0aW9uOiA1ICgweDAwMDAwMDA1KQogICAgNC1BZGRyZXNzOiAwICgweDAwKQogICAg
V2lwaHkgRnJlcXVlbmN5OiAyNDEyICgweDAwMDAwOTZjKQogICAgVW5rbm93bjogMjkwIGxlbiA0
CiAgICAgICAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC4uLi4gICAgICAgICAgICAKICAgIFdpcGh5IENoYW5uZWwgVHlwZTogMSAoMHgwMDAwMDAwMSkK
ICAgIENoYW5uZWwgV2lkdGg6IDEgKDB4MDAwMDAwMDEpCiAgICBDZW50ZXIgRnJlcXVlbmN5IDE6
IDI0MTIgKDB4MDAwMDA5NmMpCiAgICBXaXBoeSBUWCBQb3dlciBMZXZlbDogMzEwMCAoMHgwMDAw
MGMxYykKICAgIFNTSUQ6IGxlbiA3CiAgICAgICAgNjQgNjUgNzMgNmIgNTMgNDEgNDUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRlc2tTQUUgICAgICAgICAKPCBQQUU6IGxlbiAxMjEgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjA0
MDg0MwogICAgSW50ZXJmYWNlIEluZGV4OiAzCiAgICBFQVBvTDogbGVuIDEyMQogICAgICAgIFBy
b3RvY29sIFZlcnNpb246IDIgKDgwMi4xWC0yMDA0KQogICAgICAgIFR5cGU6IDMgKEtleSkKICAg
ICAgICBMZW5ndGg6IDExNwogICAgICAgIERlc2NyaXB0b3IgVHlwZTogMgogICAgICAgIEtleSBN
SUM6IHRydWUKICAgICAgICBTZWN1cmU6IGZhbHNlCiAgICAgICAgRXJyb3I6IGZhbHNlCiAgICAg
ICAgUmVxdWVzdDogZmFsc2UKICAgICAgICBFbmNyeXB0ZWQgS2V5IERhdGE6IGZhbHNlCiAgICAg
ICAgU01LIE1lc3NhZ2U6IGZhbHNlCiAgICAgICAgS2V5IERlc2NyaXB0b3IgVmVyc2lvbjogMCAo
MDApCiAgICAgICAgS2V5IFR5cGU6IHRydWUKICAgICAgICBJbnN0YWxsOiBmYWxzZQogICAgICAg
IEtleSBBQ0s6IGZhbHNlCiAgICAgICAgS2V5IExlbmd0aDogMAogICAgICAgIEtleSBSZXBsYXkg
Q291bnRlcjogMQogICAgICAgIEtleSBOT05DRQogICAgICAgICAgICA4NiBiYiAyMiAzYyA2MyAw
NSAwZSA0MSAyMSBlYyA0OSAyMSA1ZCBmOSA5NCAwNiAgLi4iPGMuLkEhLkkhXS4uLgogICAgICAg
ICAgICAyYSBhNyAxZSA1NSBmNyAxNCBmYyBlYSAwNyBlNCAyYyA0ZSAzOSA4MSAwMyAyYSAgKi4u
VS4uLi4uLixOOS4uKgogICAgICAgIEtleSBJVgogICAgICAgICAgICAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogICAgICAg
IEtleSBSU0MgCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAgICAgICAgICAg
ICAgICAgICAgICAgICAuLi4uLi4uLiAgICAgICAgCiAgICAgICAgS2V5IE1JQyBEYXRhCiAgICAg
ICAgICAgIDIyIDhlIDg0IGYyIGY5IDkxIDRkIDI3IDdiIGU2IDk2IGE5IDkxIGRmIDBmIDhhICAi
Li4uLi5NJ3suLi4uLi4uCiAgICAgICAgS2V5IERhdGE6IGxlbiAyMgogICAgICAgICAgICBSU046
CiAgICAgICAgICAgICAgICBHcm91cCBEYXRhIENpcGhlciBTdWl0ZTogbGVuIDQKICAgICAgICAg
ICAgICAgICAgICBDQ01QICgwMDowZjphYykgc3VpdGUgIDA0CiAgICAgICAgICAgICAgICBQYWly
d2lzZSBDaXBoZXIgU3VpdGU6IGxlbiA0CiAgICAgICAgICAgICAgICAgICAgQ0NNUCAoMDA6MGY6
YWMpIHN1aXRlICAwNAogICAgICAgICAgICAgICAgQUtNIFN1aXRlOiBsZW4gNAogICAgICAgICAg
ICAgICAgICAgIFNBRS9QTUtTQSBjYWNoaW5nIFNIQTI1NjsgUlNOQSBQTUtTQSBjYWNoaW5nIFNI
QTI1Ni9tZXNoIHBlZXJpbmcgZXhjaGFuZ2UgKDAwOjBmOmFjKSBzdWl0ZSAgMDgKICAgICAgICAg
ICAgICAgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdHMgIDIgLSAzOiAxIHJlcGxheSBjb3VudGVyIHBl
ciBQVEtTQQogICAgICAgICAgICAgICAgUlNOIGNhcGFiaWxpdGllczogYml0cyAgNCAtIDU6IDEg
cmVwbGF5IGNvdW50ZXIgcGVyIEdUS1NBCiAgICAgICAgICAgICAgICBSU04gY2FwYWJpbGl0aWVz
OiBiaXQgIDc6IE1hbmFnZW1lbnQgRnJhbWUgUHJvdGVjdGlvbiBDYXBhYmxlCiAgICAgICAgICAg
ICAgICAwMSAwMCAwMCAwZiBhYyAwNCAwMSAwMCAwMCAwZiBhYyAwNCAwMSAwMCAwMCAwZiAgLi4u
Li4uLi4uLi4uLi4uLgogICAgICAgICAgICAgICAgYWMgMDggODAgMDAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC4uLi4gICAgICAgICAgICAKICAgICAgICAwMiAwMyAwMCA3
NSAwMiAwMSAwOCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4udS4uLi4uLi4uLi4uLgog
ICAgICAgIDAxIDg2IGJiIDIyIDNjIDYzIDA1IDBlIDQxIDIxIGVjIDQ5IDIxIDVkIGY5IDk0ICAu
Li4iPGMuLkEhLkkhXS4uCiAgICAgICAgMDYgMmEgYTcgMWUgNTUgZjcgMTQgZmMgZWEgMDcgZTQg
MmMgNGUgMzkgODEgMDMgIC4qLi5VLi4uLi4uLE45Li4KICAgICAgICAyYSAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgKi4uLi4uLi4uLi4uLi4uLgogICAgICAg
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4u
Li4uLi4uLi4uCiAgICAgICAgMDAgMjIgOGUgODQgZjIgZjkgOTEgNGQgMjcgN2IgZTYgOTYgYTkg
OTEgZGYgMGYgIC4iLi4uLi5NJ3suLi4uLi4KICAgICAgICA4YSAwMCAxNiAzMCAxNCAwMSAwMCAw
MCAwZiBhYyAwNCAwMSAwMCAwMCAwZiBhYyAgLi4uMC4uLi4uLi4uLi4uLgogICAgICAgIDA0IDAx
IDAwIDAwIDBmIGFjIDA4IDgwIDAwICAgICAgICAgICAgICAgICAgICAgICAuLi4uLi4uLi4gICAg
ICAgCj4gUmVzcG9uc2U6IEdldCBJbnRlcmZhY2UgKDB4MDUpIGxlbiA0IFsweDEwMF0gICAgICAg
ICAgICAgICAgICAgICAgICAgOS4wNDA1NjAKICAgIFN0YXR1czogU3VjY2VzcyAoMCkKPiBQQUU6
IGxlbiAxODcgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA5LjA0NTMxMgogICAgSW50ZXJmYWNlIEluZGV4OiAzCiAgICBFQVBvTDogbGVuIDE4
NwogICAgICAgIFByb3RvY29sIFZlcnNpb246IDIgKDgwMi4xWC0yMDA0KQogICAgICAgIFR5cGU6
IDMgKEtleSkKICAgICAgICBMZW5ndGg6IDE4MwogICAgICAgIERlc2NyaXB0b3IgVHlwZTogMgog
ICAgICAgIEtleSBNSUM6IHRydWUKICAgICAgICBTZWN1cmU6IHRydWUKICAgICAgICBFcnJvcjog
ZmFsc2UKICAgICAgICBSZXF1ZXN0OiBmYWxzZQogICAgICAgIEVuY3J5cHRlZCBLZXkgRGF0YTog
dHJ1ZQogICAgICAgIFNNSyBNZXNzYWdlOiBmYWxzZQogICAgICAgIEtleSBEZXNjcmlwdG9yIFZl
cnNpb246IDAgKDAwKQogICAgICAgIEtleSBUeXBlOiB0cnVlCiAgICAgICAgSW5zdGFsbDogdHJ1
ZQogICAgICAgIEtleSBBQ0s6IHRydWUKICAgICAgICBLZXkgTGVuZ3RoOiAxNgogICAgICAgIEtl
eSBSZXBsYXkgQ291bnRlcjogMgogICAgICAgIEtleSBOT05DRQogICAgICAgICAgICA2OSBlMyA0
NiAyNyA0MCA4NiAxNSBjMSBjNCBhYyBmMiAxMCBlNyA2ZSA3ZiA0MCAgaS5GJ0AuLi4uLi4uLm4u
QAogICAgICAgICAgICA5MSA3MiA5MyBmNiBhMyAyNSBjNyA0YyBhNSA2MyAyZCA5ZiAwNiAyNiA5
MiAzMCAgLnIuLi4lLkwuYy0uLiYuMAogICAgICAgIEtleSBJVgogICAgICAgICAgICAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4u
LgogICAgICAgIEtleSBSU0MgCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAg
ICAgICAgICAgICAgICAgICAgICAgICAuLi4uLi4uLiAgICAgICAgCiAgICAgICAgS2V5IE1JQyBE
YXRhCiAgICAgICAgICAgIGJmIDhhIDc2IDVhIDBmIDQ2IDNhIDY4IDlmIDY0IDExIGFlIDJhIDFk
IDhmIGZjICAuLnZaLkY6aC5kLi4qLi4uCiAgICAgICAgS2V5IERhdGE6IGxlbiA4OAogICAgICAg
ICAgICBlNCBkNiBjMyA2MSA3YiBhMSA2NSA1ZCA5OSBmOSBkYiBmMiBkMSA2OSBmYSBlMiAgLi4u
YXsuZV0uLi4uLmkuLgogICAgICAgICAgICAyNiBmMyBiMiA2ZiAzNSAwYSBlZiAxNiA1YiA4MCAz
NSAwYSBlNiAzOSAyNCAwNiAgJi4ubzUuLi5bLjUuLjkkLgogICAgICAgICAgICA1NiBmNyA5OCA4
NCA3YiBjNSBkOCAzZCBkMiAyMiA5NiA1OCAzOCAxMCBmZiBiMiAgVi4uLnsuLj0uIi5YOC4uLgog
ICAgICAgICAgICA4NyA1NCAyYiA2MiBkYSA2NCAzYiAyYSA2MSBhMCA3MSAyMiBjNCA5NyAwMSBi
MiAgLlQrYi5kOyphLnEiLi4uLgogICAgICAgICAgICBjNCA1NCA5MiA2MCBhMyBiZCAxMiAwYiA5
NiBkOCA3YSAyMCBmMCA3OCA2OSA5MCAgLlQuYC4uLi4uLnogLnhpLgogICAgICAgICAgICBhMyBi
NCAxOSBkNSAyMSBmNSAzYSA1NiAgICAgICAgICAgICAgICAgICAgICAgICAgLi4uLiEuOlYgICAg
ICAgIAogICAgICAgIDAyIDAzIDAwIGI3IDAyIDEzIGM4IDAwIDEwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgMDIgNjkgZTMgNDYgMjcgNDAgODYgMTUgYzEg
YzQgYWMgZjIgMTAgZTcgNmUgN2YgIC5pLkYnQC4uLi4uLi4ubi4KICAgICAgICA0MCA5MSA3MiA5
MyBmNiBhMyAyNSBjNyA0YyBhNSA2MyAyZCA5ZiAwNiAyNiA5MiAgQC5yLi4uJS5MLmMtLi4mLgog
ICAgICAgIDMwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAw
Li4uLi4uLi4uLi4uLi4uCiAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAwMCBiZiA4YSA3NiA1YSAw
ZiA0NiAzYSA2OCA5ZiA2NCAxMSBhZSAyYSAxZCA4ZiAgLi4udlouRjpoLmQuLiouLgogICAgICAg
IGZjIDAwIDU4IGU0IGQ2IGMzIDYxIDdiIGExIDY1IDVkIDk5IGY5IGRiIGYyIGQxICAuLlguLi5h
ey5lXS4uLi4uCiAgICAgICAgNjkgZmEgZTIgMjYgZjMgYjIgNmYgMzUgMGEgZWYgMTYgNWIgODAg
MzUgMGEgZTYgIGkuLiYuLm81Li4uWy41Li4KICAgICAgICAzOSAyNCAwNiA1NiBmNyA5OCA4NCA3
YiBjNSBkOCAzZCBkMiAyMiA5NiA1OCAzOCAgOSQuVi4uLnsuLj0uIi5YOAogICAgICAgIDEwIGZm
IGIyIDg3IDU0IDJiIDYyIGRhIDY0IDNiIDJhIDYxIGEwIDcxIDIyIGM0ICAuLi4uVCtiLmQ7KmEu
cSIuCiAgICAgICAgOTcgMDEgYjIgYzQgNTQgOTIgNjAgYTMgYmQgMTIgMGIgOTYgZDggN2EgMjAg
ZjAgIC4uLi5ULmAuLi4uLi56IC4KICAgICAgICA3OCA2OSA5MCBhMyBiNCAxOSBkNSAyMSBmNSAz
YSA1NiAgICAgICAgICAgICAgICAgeGkuLi4uLiEuOlYgICAgIAo8IFBBRTogbGVuIDk5ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDQ2
MDYzCiAgICBJbnRlcmZhY2UgSW5kZXg6IDMKICAgIEVBUG9MOiBsZW4gOTkKICAgICAgICBQcm90
b2NvbCBWZXJzaW9uOiAyICg4MDIuMVgtMjAwNCkKICAgICAgICBUeXBlOiAzIChLZXkpCiAgICAg
ICAgTGVuZ3RoOiA5NQogICAgICAgIERlc2NyaXB0b3IgVHlwZTogMgogICAgICAgIEtleSBNSUM6
IHRydWUKICAgICAgICBTZWN1cmU6IHRydWUKICAgICAgICBFcnJvcjogZmFsc2UKICAgICAgICBS
ZXF1ZXN0OiBmYWxzZQogICAgICAgIEVuY3J5cHRlZCBLZXkgRGF0YTogZmFsc2UKICAgICAgICBT
TUsgTWVzc2FnZTogZmFsc2UKICAgICAgICBLZXkgRGVzY3JpcHRvciBWZXJzaW9uOiAwICgwMCkK
ICAgICAgICBLZXkgVHlwZTogdHJ1ZQogICAgICAgIEluc3RhbGw6IGZhbHNlCiAgICAgICAgS2V5
IEFDSzogZmFsc2UKICAgICAgICBLZXkgTGVuZ3RoOiAwCiAgICAgICAgS2V5IFJlcGxheSBDb3Vu
dGVyOiAyCiAgICAgICAgS2V5IE5PTkNFCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgICAg
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4u
Li4uLi4uLi4uCiAgICAgICAgS2V5IElWCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgS2V5
IFJTQyAKICAgICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC4uLi4uLi4uICAgICAgICAKICAgICAgICBLZXkgTUlDIERhdGEKICAgICAgICAg
ICAgZjEgODkgMDIgODUgZGQgMDEgMTUgYmIgMWQgYjMgMTQgYzMgMWUgZWMgNjkgYTUgIC4uLi4u
Li4uLi4uLi4uaS4KICAgICAgICBLZXkgRGF0YTogbGVuIDAKICAgICAgICAwMiAwMyAwMCA1ZiAw
MiAwMyAwOCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uXy4uLi4uLi4uLi4uLgogICAg
ICAgIDAyIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4u
Li4uLi4uLi4uLi4uCiAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAg
MDAgMDAgMDAgMDAgIC4uLi4uLi4uLi4uLi4uLi4KICAgICAgICAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAwMCAgLi4uLi4uLi4uLi4uLi4uLgogICAgICAgIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4u
Li4uLi4uCiAgICAgICAgMDAgZjEgODkgMDIgODUgZGQgMDEgMTUgYmIgMWQgYjMgMTQgYzMgMWUg
ZWMgNjkgIC4uLi4uLi4uLi4uLi4uLmkKICAgICAgICBhNSAwMCAwMCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLi4uICAgICAgICAgICAgIAo8IFJlcXVlc3Q6IE5ldyBL
ZXkgKDB4MGIpIGxlbiA3NiBbYWNrXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDku
MDQ2NDExCiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBLZXk6IGxlbiA2
NAogICAgICAgIEtleSBEYXRhOiBsZW4gMTYKICAgICAgICAgICAgNzkgNWEgOWYgOGIgZmYgYjUg
Y2EgN2YgYmQgMGMgODMgYTAgYmQgNWQgNmEgZDkgIHlaLi4uLi4uLi4uLi5dai4KICAgICAgICBL
ZXkgQ2lwaGVyOiBDQ01QICgwMDowZjphYykgc3VpdGUgIDA0CiAgICAgICAgS2V5IEluZGV4OiAx
ICgweDAxKQogICAgICAgIEtleSBTZXF1ZW5jZTogbGVuIDYKICAgICAgICAgICAgMDAgMDAgMDAg
MDAgMDAgMDAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLi4uLiAgICAgICAgICAK
ICAgICAgICBLZXkgVHlwZTogR3JvdXAKICAgICAgICBEZWZhdWx0IEtleSBUeXBlczogbGVuIDQK
ICAgICAgICAgICAgTXVsdGljYXN0OiB0cnVlCj4gUmVzcG9uc2U6IE5ldyBLZXkgKDB4MGIpIGxl
biA0IFsweDEwMF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOS4wNDk2NzIKICAgIFN0
YXR1czogU3VjY2VzcyAoMCkKPCBSZXF1ZXN0OiBOZXcgS2V5ICgweDBiKSBsZW4gNzYgW2Fja10g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjA1MDQ0NQogICAgSW50ZXJmYWNlIElu
ZGV4OiAzICgweDAwMDAwMDAzKQogICAgS2V5OiBsZW4gNjQKICAgICAgICBLZXkgRGF0YTogbGVu
IDE2CiAgICAgICAgICAgIDc4IDFiIGVhIDRiIGM2IDhiIDZhIGQyIDk2IGRmIDZhIDg3IGIwIDBi
IDA1IDBkICB4Li5LLi5qLi4uai4uLi4uCiAgICAgICAgS2V5IENpcGhlcjogQklQICgwMDowZjph
Yykgc3VpdGUgIDA2CiAgICAgICAgS2V5IEluZGV4OiA0ICgweDA0KQogICAgICAgIEtleSBTZXF1
ZW5jZTogbGVuIDYKICAgICAgICAgICAgMDAgMDAgMDAgMDAgMDAgMDAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIC4uLi4uLiAgICAgICAgICAKICAgICAgICBLZXkgVHlwZTogR3JvdXAK
ICAgICAgICBEZWZhdWx0IEtleSBUeXBlczogbGVuIDQKICAgICAgICAgICAgTXVsdGljYXN0OiB0
cnVlCj4gUmVzcG9uc2U6IE5ldyBLZXkgKDB4MGIpIGxlbiA0IFsweDEwMF0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgOS4wNTM0MzIKICAgIFN0YXR1czogU3VjY2VzcyAoMCkKPCBSZXF1
ZXN0OiBOZXcgS2V5ICgweDBiKSBsZW4gNTYgW2Fja10gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA5LjA1MzU1NwogICAgS2V5IERhdGE6IGxlbiAxNgogICAgICAgIDQ2IDRiIDFlIDcw
IDZiIDM0IGU1IGY1IGY4IDNhIDhjIGFiIDQ1IDNmIDBjIGE1ICBGSy5wazQuLi46Li5FPy4uCiAg
ICBLZXkgQ2lwaGVyOiBDQ01QICgwMDowZjphYykgc3VpdGUgIDA0CiAgICBNQUMgQWRkcmVzcyBE
ODozQTpERDo2MDpBMzowQwogICAgS2V5IEluZGV4OiAwICgweDAwKQogICAgSW50ZXJmYWNlIElu
ZGV4OiAzICgweDAwMDAwMDAzKQo+IFJlc3BvbnNlOiBOZXcgS2V5ICgweDBiKSBsZW4gNCBbMHgx
MDBdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDU0MTExCiAgICBTdGF0dXM6IFN1
Y2Nlc3MgKDApCjwgUmVxdWVzdDogU2V0IFN0YXRpb24gKDB4MTIpIGxlbiAzMiBbYWNrXSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgOS4wNTQxNTYKICAgIEludGVyZmFjZSBJbmRleDogMyAo
MHgwMDAwMDAwMykKICAgIE1BQyBBZGRyZXNzIEQ4OjNBOkREOjYwOkEzOjBDCiAgICBTdGF0aW9u
IEZsYWdzIDI6IGxlbiA4CiAgICAgICAgTWFzazogMHgwMDAwMDAwMgogICAgICAgICAgICBBdXRo
b3JpemVkCiAgICAgICAgU2V0OiAweDAwMDAwMDAyCiAgICAgICAgICAgIEF1dGhvcml6ZWQKPiBS
ZXNwb25zZTogU2V0IFN0YXRpb24gKDB4MTIpIGxlbiA0IFtyb290XSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICA5LjA1NDQxOQogICAgU3RhdHVzOiBTdWNjZXNzICgwKQo8IFJUTkw6IFNldCBM
aW5rICgweDEzKSBsZW4gMzIgW3JlcXVlc3QsYWNrXSAgICAgICAgICAgICAgICAgICAgICAgICAg
IDkuMDc3NzA1CiAgICBGbGFnczogNSAoMHgwMDUpCiAgICBTZXF1ZW5jZSBudW1iZXI6IDYgKDB4
MDAwMDAwMDYpCiAgICBQb3J0IElEOiAyMjU5MDM2CiAgICBJRkxBIEZhbWlseTogVW5rbm93bgog
ICAgSUZMQSBUeXBlOiAwCiAgICBJRkxBIEluZGV4OiAzCiAgICBJRkxBIENoYW5nZU1hc2s6IDAK
ICAgIElGTEEgRmxhZ3M6ICgweDAwKQogICAgICAgIExpbmtNb2RlOiB1c2Vyc3BhY2UgY29udHJv
bGxlZCAoMSkKICAgICAgICBPcGVyU3RhdGU6IHVwICg2KQo+IFJUTkw6IEVycm9yICgweDAyKSBs
ZW4gMjAgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDc3NzI3
CiAgICBGbGFnczogMjU2ICgweDEwMCkKICAgIFNlcXVlbmNlIG51bWJlcjogNiAoMHgwMDAwMDAw
NikKICAgIFBvcnQgSUQ6IDIyNTkwMzYKICAgIEFDSzogMAo+IFJUTkw6IE5ldyBBZGRyZXNzICgw
eDE0KSBsZW4gNjQgW211bHRpXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMDc3ODEy
CiAgICBGbGFnczogMiAoMHgwMDIpCiAgICBTZXF1ZW5jZSBudW1iZXI6IDEwICgweDAwMDAwMDBh
KQogICAgUG9ydCBJRDogMjkzMzMwNzA4MgogICAgSUZBIEZhbWlseTogQUZfSU5FVDYKICAgIElG
QSBQcmVmaXhsZW46IDY0CiAgICBJRkEgSW5kZXg6IDMKICAgIElGQSBTY29wZTogbGluawogICAg
SUZBIEZsYWdzOiAoMHg4MCkgW3Blcm1hbmVudF0KICAgICAgICBJbnRlcmZhY2UgQWRkcmVzczog
ZmU4MDo6ZGVhNjozMmZmOmZlYjQ6NTBjZgogICAgICAgIENhY2hlSW5mbzoKICAgICAgICAgICAg
aWZhX3ByZWZlcmVkOiBpbmZpbml0ZQogICAgICAgICAgICBpZmFfdmFsaWQ6IGluZmluaXRlCiAg
ICAgICAgICAgIHRzdGFtcDogMTg2ODcyMzUsIGNzdGFtcDogMTg2ODcyMzUKICAgICAgICBGbGFn
czogKDB4ODApIFtwZXJtYW5lbnRdCiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiAxCj4gUlROTDogRG9u
ZSAoMHgwMykgbGVuIDQgW211bHRpXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgOS4wNzc4NzkKICAgIEZsYWdzOiAyICgweDAwMikKICAgIFNlcXVlbmNlIG51bWJlcjogMTAg
KDB4MDAwMDAwMGEpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBTdGF0dXM6IDAKPCBSZXF1
ZXN0OiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDIwIFthY2tdICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICA5Ljk1MDQ4NgogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAg
TUFDIEFkZHJlc3MgRDg6M0E6REQ6NjA6QTM6MEMKPiBSZXN1bHQ6IE5ldyBTdGF0aW9uICgweDEz
KSBsZW4gMTcyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5Ljk1NTI3OAogICAg
SW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgTUFDIEFkZHJlc3MgRDg6M0E6REQ6
NjA6QTM6MEMKICAgIEdlbmVyYXRpb246IDAgKDB4MDAwMDAwMDApCiAgICBTdGF0aW9uIEluZm86
IGxlbiAxNDAKICAgICAgICBDb25uZWN0ZWQgdGltZTogMCAoMHgwMDAwMDAwMCkKICAgICAgICBJ
bmFjdGl2aXR5IHRpbWU6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVG90YWwgUlggYnl0ZXM6IDQ5
OCAoMHgwMDAwMDFmMikKICAgICAgICBUb3RhbCBUWCBieXRlczogMTE0NCAoMHgwMDAwMDQ3OCkK
ICAgICAgICBTaWduYWwgc3RyZW5ndGg6IC02MgogICAgICAgIFRYIGJpdHJhdGU6IGxlbiAxNgog
ICAgICAgICAgICBCaXQgUmF0ZTogNTQwICgweDAwMDAwMjFjKQogICAgICAgICAgICBCaXQgUmF0
ZSAoTGVnYWN5KTogNTQwICgweDAyMWMpCiAgICAgICAgUlggYml0cmF0ZTogbGVuIDE2CiAgICAg
ICAgICAgIEJpdCBSYXRlOiAxODAgKDB4MDAwMDAwYjQpCiAgICAgICAgICAgIEJpdCBSYXRlIChM
ZWdhY3kpOiAxODAgKDB4MDBiNCkKICAgICAgICBSWCBwYWNrZXRzOiAzICgweDAwMDAwMDAzKQog
ICAgICAgIFRYIHBhY2tldHM6IDYgKDB4MDAwMDAwMDYpCiAgICAgICAgVFggZmFpbGVkOiAwICgw
eDAwMDAwMDAwKQogICAgICAgIEJTUyBwYXJhbWV0ZXJzOiBsZW4gMjAKICAgICAgICAgICAgU2hv
cnQgU2xvdCBUaW1lOiB0cnVlCiAgICAgICAgICAgIERUSU0gUGVyaW9kOiAyICgweDAyKQogICAg
ICAgICAgICBCZWFjb24gSW50ZXJ2YWw6IDEwMCAoMHgwMDY0KQogICAgICAgIFN0YXRpb24gZmxh
Z3M6IGxlbiA4CiAgICAgICAgICAgIE1hc2s6IDB4MDAwMDAwZWEKICAgICAgICAgICAgICAgIEF1
dGhvcml6ZWQKICAgICAgICAgICAgICAgIFdNRQogICAgICAgICAgICAgICAgQXV0aGVudGljYXRl
ZAogICAgICAgICAgICAgICAgVERMUy1QZWVyCiAgICAgICAgICAgICAgICBBc3NvY2lhdGVkCiAg
ICAgICAgICAgIFNldDogMHgwMDAwMDBhMgogICAgICAgICAgICAgICAgQXV0aG9yaXplZAogICAg
ICAgICAgICAgICAgQXV0aGVudGljYXRlZAogICAgICAgICAgICAgICAgQXNzb2NpYXRlZAo+IFJl
c3BvbnNlOiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDkuOTU1Mjg4CiAgICBTdGF0dXM6IFN1Y2Nlc3MgKDApCjwgUlROTDogTmV3IEFk
ZHJlc3MgKDB4MTQpIGxlbiA1MiBbcmVxdWVzdCxyZXBsYWNlLGNyZWF0ZV0gICAgICAgICAgICAx
Mi4wODQ0MjcKICAgIEZsYWdzOiAxMjgxICgweDUwMSkKICAgIFNlcXVlbmNlIG51bWJlcjogMTEg
KDB4MDAwMDAwMGIpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBJRkEgRmFtaWx5OiBBRl9J
TkVUCiAgICBJRkEgUHJlZml4bGVuOiAyNAogICAgSUZBIEluZGV4OiAzCiAgICBJRkEgU2NvcGU6
IGdsb2JhbAogICAgSUZBIEZsYWdzOiAoMHg4MCkgW3Blcm1hbmVudF0KICAgICAgICBMb2NhbCBB
ZGRyZXNzOiAxOTIuMTY4LjUuMjI1CiAgICAgICAgQnJvYWRjYXN0IEFkZHJlc3M6IDE5Mi4xNjgu
NS4yNTUKICAgICAgICBGbGFnczogKDB4MjAwKSBbbm9wcmVmaXhyb3V0ZV0KICAgICAgICBDYWNo
ZUluZm86CiAgICAgICAgICAgIGlmYV9wcmVmZXJlZDogODYzOTkKICAgICAgICAgICAgaWZhX3Zh
bGlkOiA4NjM5OQogICAgICAgICAgICB0c3RhbXA6IDAsIGNzdGFtcDogMAo+IFJUTkw6IE5ldyBB
ZGRyZXNzICgweDE0KSBsZW4gNzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MTIuMDg0NDU4CiAgICBGbGFnczogMCAoMHgwMDApCiAgICBTZXF1ZW5jZSBudW1iZXI6IDExICgw
eDAwMDAwMDBiKQogICAgUG9ydCBJRDogMjkzMzMwNzA4MgogICAgSUZBIEZhbWlseTogQUZfSU5F
VAogICAgSUZBIFByZWZpeGxlbjogMjQKICAgIElGQSBJbmRleDogMwogICAgSUZBIFNjb3BlOiBn
bG9iYWwKICAgIElGQSBGbGFnczogKDB4MDApCiAgICAgICAgSW50ZXJmYWNlIEFkZHJlc3M6IDE5
Mi4xNjguNS4yMjUKICAgICAgICBMb2NhbCBBZGRyZXNzOiAxOTIuMTY4LjUuMjI1CiAgICAgICAg
QnJvYWRjYXN0IEFkZHJlc3M6IDE5Mi4xNjguNS4yNTUKICAgICAgICBMYWJlbCAobGVuOjYpOiB3
bGFuMAogICAgICAgIEZsYWdzOiAoMHgyMDApIFtub3ByZWZpeHJvdXRlXQogICAgICAgIENhY2hl
SW5mbzoKICAgICAgICAgICAgaWZhX3ByZWZlcmVkOiA4NjM5OQogICAgICAgICAgICBpZmFfdmFs
aWQ6IDg2Mzk5CiAgICAgICAgICAgIHRzdGFtcDogMTg3MzE3MDQsIGNzdGFtcDogMTg3MzE3MDQK
PiBSVE5MOiBOZXcgQWRkcmVzcyAoMHgxNCkgbGVuIDcyICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDEyLjA4NDQ2MwogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2Ug
bnVtYmVyOiAxMSAoMHgwMDAwMDAwYikKICAgIFBvcnQgSUQ6IDI5MzMzMDcwODIKICAgIElGQSBG
YW1pbHk6IEFGX0lORVQKICAgIElGQSBQcmVmaXhsZW46IDI0CiAgICBJRkEgSW5kZXg6IDMKICAg
IElGQSBTY29wZTogZ2xvYmFsCiAgICBJRkEgRmxhZ3M6ICgweDAwKQogICAgICAgIEludGVyZmFj
ZSBBZGRyZXNzOiAxOTIuMTY4LjUuMjI1CiAgICAgICAgTG9jYWwgQWRkcmVzczogMTkyLjE2OC41
LjIyNQogICAgICAgIEJyb2FkY2FzdCBBZGRyZXNzOiAxOTIuMTY4LjUuMjU1CiAgICAgICAgTGFi
ZWwgKGxlbjo2KTogd2xhbjAKICAgICAgICBGbGFnczogKDB4MjAwKSBbbm9wcmVmaXhyb3V0ZV0K
ICAgICAgICBDYWNoZUluZm86CiAgICAgICAgICAgIGlmYV9wcmVmZXJlZDogODYzOTkKICAgICAg
ICAgICAgaWZhX3ZhbGlkOiA4NjM5OQogICAgICAgICAgICB0c3RhbXA6IDE4NzMxNzA0LCBjc3Rh
bXA6IDE4NzMxNzA0Cj4gUlROTDogTmV3IEFkZHJlc3MgKDB4MTQpIGxlbiA3MiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAxMi4wODQ0NzAKICAgIEZsYWdzOiAwICgweDAwMCkK
ICAgIFNlcXVlbmNlIG51bWJlcjogMTEgKDB4MDAwMDAwMGIpCiAgICBQb3J0IElEOiAyOTMzMzA3
MDgyCiAgICBJRkEgRmFtaWx5OiBBRl9JTkVUCiAgICBJRkEgUHJlZml4bGVuOiAyNAogICAgSUZB
IEluZGV4OiAzCiAgICBJRkEgU2NvcGU6IGdsb2JhbAogICAgSUZBIEZsYWdzOiAoMHgwMCkKICAg
ICAgICBJbnRlcmZhY2UgQWRkcmVzczogMTkyLjE2OC41LjIyNQogICAgICAgIExvY2FsIEFkZHJl
c3M6IDE5Mi4xNjguNS4yMjUKICAgICAgICBCcm9hZGNhc3QgQWRkcmVzczogMTkyLjE2OC41LjI1
NQogICAgICAgIExhYmVsIChsZW46Nik6IHdsYW4wCiAgICAgICAgRmxhZ3M6ICgweDIwMCkgW25v
cHJlZml4cm91dGVdCiAgICAgICAgQ2FjaGVJbmZvOgogICAgICAgICAgICBpZmFfcHJlZmVyZWQ6
IDg2Mzk5CiAgICAgICAgICAgIGlmYV92YWxpZDogODYzOTkKICAgICAgICAgICAgdHN0YW1wOiAx
ODczMTcwNCwgY3N0YW1wOiAxODczMTcwNAo+IFJUTkw6IE5ldyBBZGRyZXNzICgweDE0KSBsZW4g
NzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTIuMDg0NDc2CiAgICBGbGFn
czogMCAoMHgwMDApCiAgICBTZXF1ZW5jZSBudW1iZXI6IDExICgweDAwMDAwMDBiKQogICAgUG9y
dCBJRDogMjkzMzMwNzA4MgogICAgSUZBIEZhbWlseTogQUZfSU5FVAogICAgSUZBIFByZWZpeGxl
bjogMjQKICAgIElGQSBJbmRleDogMwogICAgSUZBIFNjb3BlOiBnbG9iYWwKICAgIElGQSBGbGFn
czogKDB4MDApCiAgICAgICAgSW50ZXJmYWNlIEFkZHJlc3M6IDE5Mi4xNjguNS4yMjUKICAgICAg
ICBMb2NhbCBBZGRyZXNzOiAxOTIuMTY4LjUuMjI1CiAgICAgICAgQnJvYWRjYXN0IEFkZHJlc3M6
IDE5Mi4xNjguNS4yNTUKICAgICAgICBMYWJlbCAobGVuOjYpOiB3bGFuMAogICAgICAgIEZsYWdz
OiAoMHgyMDApIFtub3ByZWZpeHJvdXRlXQogICAgICAgIENhY2hlSW5mbzoKICAgICAgICAgICAg
aWZhX3ByZWZlcmVkOiA4NjM5OQogICAgICAgICAgICBpZmFfdmFsaWQ6IDg2Mzk5CiAgICAgICAg
ICAgIHRzdGFtcDogMTg3MzE3MDQsIGNzdGFtcDogMTg3MzE3MDQKPiBSVE5MOiBOZXcgQWRkcmVz
cyAoMHgxNCkgbGVuIDcyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDEyLjA4
NDQ4MAogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxMSAoMHgwMDAw
MDAwYikKICAgIFBvcnQgSUQ6IDI5MzMzMDcwODIKICAgIElGQSBGYW1pbHk6IEFGX0lORVQKICAg
IElGQSBQcmVmaXhsZW46IDI0CiAgICBJRkEgSW5kZXg6IDMKICAgIElGQSBTY29wZTogZ2xvYmFs
CiAgICBJRkEgRmxhZ3M6ICgweDAwKQogICAgICAgIEludGVyZmFjZSBBZGRyZXNzOiAxOTIuMTY4
LjUuMjI1CiAgICAgICAgTG9jYWwgQWRkcmVzczogMTkyLjE2OC41LjIyNQogICAgICAgIEJyb2Fk
Y2FzdCBBZGRyZXNzOiAxOTIuMTY4LjUuMjU1CiAgICAgICAgTGFiZWwgKGxlbjo2KTogd2xhbjAK
ICAgICAgICBGbGFnczogKDB4MjAwKSBbbm9wcmVmaXhyb3V0ZV0KICAgICAgICBDYWNoZUluZm86
CiAgICAgICAgICAgIGlmYV9wcmVmZXJlZDogODYzOTkKICAgICAgICAgICAgaWZhX3ZhbGlkOiA4
NjM5OQogICAgICAgICAgICB0c3RhbXA6IDE4NzMxNzA0LCBjc3RhbXA6IDE4NzMxNzA0CjwgUlRO
TDogTmV3IFJvdXRlICgweDE4KSBsZW4gNDQgW3JlcXVlc3QscmVwbGFjZSxjcmVhdGVdICAgICAg
ICAgICAgICAxMi4wODY0NDUKICAgIEZsYWdzOiAxMjgxICgweDUwMSkKICAgIFNlcXVlbmNlIG51
bWJlcjogMTIgKDB4MDAwMDAwMGMpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBSVE0gRmFt
aWx5OiBBRl9JTkVUCiAgICBSVE0gRGVzdGluYXRpb24gTGVuOiAyNAogICAgUlRNIFNvdXJjZSBM
ZW46IDAKICAgIFJUTSBUT1MgRmllbGQ6IDAKICAgIFJUTSBUYWJsZTogMjU0CiAgICBSVE0gUHJv
dG9jb2w6IGRoY3AKICAgIFJUTSBTY29wZTogbGluawogICAgUlRNIFR5cGU6IDEKICAgIFJUTSBG
bGFnczogKDB4MDApCiAgICAgICAgT3V0cHV0IEludGVyZmFjZSBJbmRleDogMwogICAgICAgIFBy
aW9yaXR5IG9mIHRoZSByb3V0ZTogMzAzCiAgICAgICAgRGVzdGluYXRpb24gQWRkcmVzczogMTky
LjE2OC41LjAKICAgICAgICBSb3V0ZSBsaWZldGltZTogODYzOTkgKDB4MDAwMTUxN2YpCj4gUlRO
TDogTmV3IFJvdXRlICgweDE4KSBsZW4gNDQgW2V4Y2wsY3JlYXRlXSAgICAgICAgICAgICAgICAg
ICAgICAgICAxMi4wODY3NzEKICAgIEZsYWdzOiAxNTM2ICgweDYwMCkKICAgIFNlcXVlbmNlIG51
bWJlcjogMTIgKDB4MDAwMDAwMGMpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBSVE0gRmFt
aWx5OiBBRl9JTkVUCiAgICBSVE0gRGVzdGluYXRpb24gTGVuOiAyNAogICAgUlRNIFNvdXJjZSBM
ZW46IDAKICAgIFJUTSBUT1MgRmllbGQ6IDAKICAgIFJUTSBUYWJsZTogMjU0CiAgICBSVE0gUHJv
dG9jb2w6IGRoY3AKICAgIFJUTSBTY29wZTogbGluawogICAgUlRNIFR5cGU6IDEKICAgIFJUTSBG
bGFnczogKDB4MDApCiAgICAgICAgUm91dGluZyBUYWJsZTogMjU0ICgweDAwMDAwMGZlKQogICAg
ICAgIERlc3RpbmF0aW9uIEFkZHJlc3M6IDE5Mi4xNjguNS4wCiAgICAgICAgUHJpb3JpdHkgb2Yg
dGhlIHJvdXRlOiAzMDMKICAgICAgICBPdXRwdXQgSW50ZXJmYWNlIEluZGV4OiAzCjwgUlROTDog
TmV3IFJvdXRlICgweDE4KSBsZW4gNTIgW3JlcXVlc3QscmVwbGFjZSxjcmVhdGVdICAgICAgICAg
ICAgICAxMi4wODY4MjkKICAgIEZsYWdzOiAxMjgxICgweDUwMSkKICAgIFNlcXVlbmNlIG51bWJl
cjogMTMgKDB4MDAwMDAwMGQpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBSVE0gRmFtaWx5
OiBBRl9JTkVUCiAgICBSVE0gRGVzdGluYXRpb24gTGVuOiAwCiAgICBSVE0gU291cmNlIExlbjog
MAogICAgUlRNIFRPUyBGaWVsZDogMAogICAgUlRNIFRhYmxlOiAyNTQKICAgIFJUTSBQcm90b2Nv
bDogZGhjcAogICAgUlRNIFNjb3BlOiBnbG9iYWwKICAgIFJUTSBUeXBlOiAxCiAgICBSVE0gRmxh
Z3M6ICgweDAwKQogICAgICAgIE91dHB1dCBJbnRlcmZhY2UgSW5kZXg6IDMKICAgICAgICBQcmlv
cml0eSBvZiB0aGUgcm91dGU6IDMwMwogICAgICAgIEdhdGV3YXk6IDE5Mi4xNjguNS4xCiAgICAg
ICAgUHJlZmVycmVkIFNvdXJjZTogMTkyLjE2OC41LjIyNQogICAgICAgIFJvdXRlIGxpZmV0aW1l
OiA4NjM5OSAoMHgwMDAxNTE3ZikKPiBSVE5MOiBOZXcgUm91dGUgKDB4MTgpIGxlbiA1MiBbZXhj
bCxjcmVhdGVdICAgICAgICAgICAgICAgICAgICAgICAgIDEyLjA4Njg0OQogICAgRmxhZ3M6IDE1
MzYgKDB4NjAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxMyAoMHgwMDAwMDAwZCkKICAgIFBvcnQg
SUQ6IDI5MzMzMDcwODIKICAgIFJUTSBGYW1pbHk6IEFGX0lORVQKICAgIFJUTSBEZXN0aW5hdGlv
biBMZW46IDAKICAgIFJUTSBTb3VyY2UgTGVuOiAwCiAgICBSVE0gVE9TIEZpZWxkOiAwCiAgICBS
VE0gVGFibGU6IDI1NAogICAgUlRNIFByb3RvY29sOiBkaGNwCiAgICBSVE0gU2NvcGU6IGdsb2Jh
bAogICAgUlRNIFR5cGU6IDEKICAgIFJUTSBGbGFnczogKDB4MDApCiAgICAgICAgUm91dGluZyBU
YWJsZTogMjU0ICgweDAwMDAwMGZlKQogICAgICAgIFByaW9yaXR5IG9mIHRoZSByb3V0ZTogMzAz
CiAgICAgICAgUHJlZmVycmVkIFNvdXJjZTogMTkyLjE2OC41LjIyNQogICAgICAgIEdhdGV3YXk6
IDE5Mi4xNjguNS4xCiAgICAgICAgT3V0cHV0IEludGVyZmFjZSBJbmRleDogMwo+IFJUTkw6IEVy
cm9yICgweDAyKSBsZW4gMjAgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgMTIuMDg2ODk0CiAgICBGbGFnczogMjU2ICgweDEwMCkKICAgIFNlcXVlbmNlIG51bWJlcjog
MTQgKDB4MDAwMDAwMGUpCiAgICBQb3J0IElEOiAyOTMzMzA3MDgyCiAgICBBQ0s6IDAKPiBSVE5M
OiBFcnJvciAoMHgwMikgbGVuIDIwIFsweDEwMF0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDEyLjA4NjkxNgogICAgRmxhZ3M6IDI1NiAoMHgxMDApCiAgICBTZXF1ZW5jZSBudW1i
ZXI6IDE1ICgweDAwMDAwMDBmKQogICAgUG9ydCBJRDogMjkzMzMwNzA4MgogICAgQUNLOiAwCg==
--000000000000971ec5062c8a751d
Content-Type: text/plain; charset="US-ASCII"; name="iwd_dhcp_journal.txt"
Content-Disposition: attachment; filename="iwd_dhcp_journal.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m6cdn2ub3>
X-Attachment-Id: f_m6cdn2ub3

SmFuIDIyIDE5OjU3OjU2IFBpNCBjb25ubWFuZFs1MzEwN106IEludGVyZmFjZSB3bGFuMCBbIHdp
ZmkgXSBzdGF0ZSBpcyBhc3NvY2lhdGlvbgpKYW4gMjIgMTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2
XTogc3JjL25ldHdvcmsuYzpuZXR3b3JrX2Nvbm5lY3QoKQpKYW4gMjIgMTk6NTc6NTYgUGk0IGl3
ZFsyMjU5MDM2XTogc3JjL3dpcGh5LmM6d2lwaHlfc2VsZWN0X2FrbSgpIE5ldHdvcmsgaXMgV1BB
My1QZXJzb25hbC4uLgpKYW4gMjIgMTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogZXZlbnQ6IGNv
bm5lY3QtaW5mbywgRnVsbE1BQyBkcml2ZXI6IGJyY21mbWFjIHVzaW5nIFNBRS4gIEV4cGVjdCBF
WFRFUk5BTF9BVVRICkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0d29y
ay5jOm5ldHdvcmtfY29ubmVjdF9wc2soKSBhc2tfcGFzc3BocmFzZTogdHJ1ZQpKYW4gMjIgMTk6
NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL2FnZW50LmM6YWdlbnRfcmVxdWVzdF9wYXNzcGhy
YXNlKCkgYWdlbnQgMHg1NTk2ZGY1ZjkwIG93bmVyIDoxLjE5NjkgcGF0aCAvbmV0L2Nvbm5tYW4v
aXdkX2FnZW50CkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvYWdlbnQuYzph
Z2VudF9zZW5kX25leHRfcmVxdWVzdCgpIHNlbmQgcmVxdWVzdCB0byA6MS4xOTY5IC9uZXQvY29u
bm1hbi9pd2RfYWdlbnQKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9hZ2Vu
dC5jOmFnZW50X3JlY2VpdmVfcmVwbHkoKSBhZ2VudCAweDU1OTZkZjVmOTAgcmVxdWVzdCBpZCAy
OTcKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXR3b3JrLmM6cGFzc3Bo
cmFzZV9jYWxsYmFjaygpIHJlc3VsdCAwCkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdkWzIyNTkwMzZd
OiBzcmMvd2lwaHkuYzp3aXBoeV9zZWxlY3RfYWttKCkgTmV0d29yayBpcyBXUEEzLVBlcnNvbmFs
Li4uCkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29ubmVjdC1pbmZv
LCBGdWxsTUFDIGRyaXZlcjogYnJjbWZtYWMgdXNpbmcgU0FFLiAgRXhwZWN0IEVYVEVSTkFMX0FV
VEgKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXR3b3JrLmM6bmV0d29y
a19nZW5lcmF0ZV9zYWVfcHQoKSBHZW5lcmF0aW5nIFBUIGZvciBHcm91cCAxOQpKYW4gMjIgMTk6
NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldHdvcmsuYzpuZXR3b3JrX2dlbmVyYXRlX3Nh
ZV9wdCgpIEdlbmVyYXRpbmcgUFQgZm9yIEdyb3VwIDIwCkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdk
WzIyNTkwMzZdOiBzcmMvd2lwaHkuYzp3aXBoeV9zZWxlY3RfYWttKCkgTmV0d29yayBpcyBXUEEz
LVBlcnNvbmFsLi4uCkphbiAyMiAxOTo1Nzo1NiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29u
bmVjdC1pbmZvLCBGdWxsTUFDIGRyaXZlcjogYnJjbWZtYWMgdXNpbmcgU0FFLiAgRXhwZWN0IEVY
VEVSTkFMX0FVVEgKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYu
YzpuZXRkZXZfY3FtX3Jzc2lfdXBkYXRlKCkKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAz
Nl06IHNyYy93aXBoeS5jOndpcGh5X3JhZGlvX3dvcmtfaW5zZXJ0KCkgSW5zZXJ0aW5nIHdvcmsg
aXRlbSAxNwpKYW4gMjIgMTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL3dpcGh5LmM6d2lw
aHlfcmFkaW9fd29ya19uZXh0KCkgU3RhcnRpbmcgd29yayBpdGVtIDE3CkphbiAyMiAxOTo1Nzo1
NiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29ubmVjdC1pbmZvLCBzc2lkOiBkZXNrU0FFLCBi
c3M6IGQ4OjNhOmRkOjYwOmEzOjBjLCBzaWduYWw6IC01OSwgbG9hZDogMC8yNTUKSmFuIDIyIDE5
OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IGV2ZW50OiBzdGF0ZSwgb2xkOiBkaXNjb25uZWN0ZWQs
IG5ldzogY29ubmVjdGluZwpKYW4gMjIgMTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25l
dGRldi5jOm5ldGRldl9jbWRfc2V0X2NxbV9jYigpIENNRF9TRVRfQ1FNIG5vdCBzdXBwb3J0ZWQs
IGZhbGxpbmcgYmFjayB0byBwb2xsaW5nCkphbiAyMiAxOTo1Nzo1NiBQaTQgY29ubm1hbmRbNTMx
MDddOiBJbnRlcmZhY2Ugd2xhbjAgWyB3aWZpIF0gc3RhdGUgaXMgY29uZmlndXJhdGlvbgpKYW4g
MjIgMTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl91bmljYXN0
X25vdGlmeSgpIFVuaWNhc3Qgbm90aWZpY2F0aW9uIEV4dGVybmFsIEF1dGgoMTI3KQpKYW4gMjIg
MTk6NTc6NTYgUGk0IGl3ZFsyMjU5MDM2XTogZXZlbnQ6IGNvbm5lY3QtaW5mbywgRXh0ZXJuYWwg
QXV0aCB0byBTU0lEOiBkZXNrU0FFLCBic3NpZDogZDg6M2E6ZGQ6NjA6YTM6MGMKSmFuIDIyIDE5
OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYuYzpuZXRkZXZfZXh0ZXJuYWxfYXV0
aF9zYWVfdHhfYXV0aGVudGljYXRlKCkKSmFuIDIyIDE5OjU3OjU2IFBpNCBpd2RbMjI1OTAzNl06
IHNyYy9uZXRkZXYuYzpuZXRkZXZfbWxtZV9ub3RpZnkoKSBNTE1FIG5vdGlmaWNhdGlvbiBGcmFt
ZSBUWCBTdGF0dXMoNjApCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0
ZGV2LmM6bmV0ZGV2X2V4dGVybmFsX2F1dGhfc2FlX3R4X2F1dGhlbnRpY2F0ZSgpCkphbiAyMiAx
OTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X3VuaWNhc3Rfbm90
aWZ5KCkgVW5pY2FzdCBub3RpZmljYXRpb24gRnJhbWUoNTkpCkphbiAyMiAxOTo1Nzo1NyBQaTQg
aXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X21sbWVfbm90aWZ5KCkgTUxNRSBub3Rp
ZmljYXRpb24gRnJhbWUgVFggU3RhdHVzKDYwKQpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5
MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl9leHRlcm5hbF9hdXRoX3NhZV90eF9hc3NvY2lhdGUo
KQpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl91
bmljYXN0X25vdGlmeSgpIFVuaWNhc3Qgbm90aWZpY2F0aW9uIEZyYW1lKDU5KQpKYW4gMjIgMTk6
NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgp
IE1MTUUgbm90aWZpY2F0aW9uIENvbm5lY3QoNDYpCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIy
NTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X2Nvbm5lY3RfZXZlbnQoKQpKYW4gMjIgMTk6NTc6
NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl9jb25uZWN0X2V2ZW50KCkg
YWJvcnRpbmcgYW5kIGlnbm9yZV9jb25uZWN0X2V2ZW50IG5vdCBzZXQsIHByb2NlZWQKSmFuIDIy
IDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYuYzpuZXRkZXZfY29ubmVjdF9l
dmVudCgpIGV4cGVjdF9jb25uZWN0X2ZhaWx1cmUgbm90IHNldCwgcHJvY2VlZApKYW4gMjIgMTk6
NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOnBhcnNlX3JlcXVlc3RfaWVzKCkK
SmFuIDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYuYzpuZXRkZXZfY29u
bmVjdF9ldmVudCgpIFJlcXVlc3QgLyBSZXNwb25zZSBJRXMgcGFyc2VkCkphbiAyMiAxOTo1Nzo1
NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X2dldF9vY2koKQpKYW4gMjIg
MTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlm
eSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggMwpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2
XTogc3JjL25ldGRldi5jOm5ldGRldl9nZXRfb2NpX2NiKCkgT2J0YWluZWQgT0NJOiBmcmVxOiAy
NDEyLCB3aWR0aDogMSwgY2VudGVyMTogMjQxMiwgY2VudGVyMjogMApKYW4gMjIgMTk6NTc6NTcg
UGk0IGl3ZFsyMjU5MDM2XTogc3JjL2VhcG9sLmM6ZWFwb2xfc3RhcnQoKQpKYW4gMjIgMTk6NTc6
NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL3N0YXRpb24uYzpzdGF0aW9uX2hhbmRzaGFrZV9ldmVu
dCgpIEhhbmRzaGFraW5nCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvZWFw
b2wuYzplYXBvbF9oYW5kbGVfcHRrXzFfb2ZfNCgpIGlmaW5kZXg9MwpKYW4gMjIgMTk6NTc6NTcg
UGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50
IDE2IG9uIGlmaW5kZXggMwpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25l
dGRldi5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggMwpKYW4gMjIg
MTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL2VhcG9sLmM6ZWFwb2xfaGFuZGxlX3B0a18z
X29mXzQoKSBpZmluZGV4PTMKSmFuIDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9u
ZXRkZXYuYzpuZXRkZXZfc2V0X2d0aygpIGlmaW5kZXg9MyBrZXlfaWR4PTEKSmFuIDIyIDE5OjU3
OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYuYzpuZXRkZXZfc2V0X2lndGsoKSBpZmlu
ZGV4PTMga2V5X2lkeD00CkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvaGFu
ZHNoYWtlLmM6aGFuZHNoYWtlX3N0YXRlX2luc3RhbGxfcHRrKCkgQWRkaW5nIFBNS1NBIGV4cGly
YXRpb24KSmFuIDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9zdGF0aW9uLmM6c3Rh
dGlvbl9oYW5kc2hha2VfZXZlbnQoKSBTZXR0aW5nIGtleXMKSmFuIDIyIDE5OjU3OjU3IFBpNCBp
d2RbMjI1OTAzNl06IHNyYy9uZXR3b3JrLmM6bmV0d29ya19zeW5jX3NldHRpbmdzKCkKSmFuIDIy
IDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYuYzpuZXRkZXZfc2V0X3RrKCkg
aWZpbmRleD0zIGtleV9pZHg9MApKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3Jj
L25ldGRldi5jOm5ldGRldl9uZXdfZ3JvdXBfa2V5X2NiKCkgaWZpbmRleDogMywgZXJyOiAwCkph
biAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6dHJ5X2hhbmRzaGFr
ZV9jb21wbGV0ZSgpIHB0a19pbnN0YWxsZWQ6IDAsIGd0a19pbnN0YWxsZWQ6IDEsIGlndGtfaW5z
dGFsbGVkOiAwCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6
bmV0ZGV2X25ld19ncm91cF9tYW5hZ2VtZW50X2tleV9jYigpIGlmaW5kZXg6IDMsIGVycjogMApK
YW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5jOnRyeV9oYW5kc2hh
a2VfY29tcGxldGUoKSBwdGtfaW5zdGFsbGVkOiAwLCBndGtfaW5zdGFsbGVkOiAxLCBpZ3RrX2lu
c3RhbGxlZDogMQpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRldi5j
Om5ldGRldl9zZXRfc3RhdGlvbl9jYigpCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZd
OiBzcmMvbmV0ZGV2LmM6dHJ5X2hhbmRzaGFrZV9jb21wbGV0ZSgpIHB0a19pbnN0YWxsZWQ6IDEs
IGd0a19pbnN0YWxsZWQ6IDEsIGlndGtfaW5zdGFsbGVkOiAxCkphbiAyMiAxOTo1Nzo1NyBQaTQg
aXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6dHJ5X2hhbmRzaGFrZV9jb21wbGV0ZSgpIG5ocy0+
Y29tcGxldGU6IDAKSmFuIDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRkZXYu
Yzp0cnlfaGFuZHNoYWtlX2NvbXBsZXRlKCkgSW52b2tpbmcgaGFuZHNoYWtlX2V2ZW50KCkKSmFu
IDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9oYW5kc2hha2UuYzpoYW5kc2hha2Vf
c3RhdGVfY2FjaGVfcG1rc2EoKSBDYWNoaW5nIFBNS1NBIGZvciBkODozYTpkZDo2MDphMzowYwpK
YW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL3Bta3NhLmM6cG1rc2FfY2FjaGVf
cHV0KCkgQWRkaW5nIGVudHJ5IHdpdGggUE1LSUQ6IDg2MDMwMzFlZWNiZjM0N2ZmM2JmNWU5OTQ4
Yzk4ZThmCkphbiAyMiAxOTo1Nzo1NyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0
ZGV2X2Nvbm5lY3Rfb2soKQpKYW4gMjIgMTk6NTc6NTcgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL3N0
YXRpb24uYzpzdGF0aW9uX2Nvbm5lY3RfY2IoKSAzLCByZXN1bHQ6IDAKSmFuIDIyIDE5OjU3OjU3
IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9jb25uZWN0X29rKCkKSmFu
IDIyIDE5OjU3OjU3IFBpNCBpd2RbMjI1OTAzNl06IGV2ZW50OiBzdGF0ZSwgb2xkOiBjb25uZWN0
aW5nLCBuZXc6IGNvbm5lY3RpbmcgKG5ldGNvbmZpZykKSmFuIDIyIDE5OjU3OjU3IFBpNCBpd2Rb
MjI1OTAzNl06IHNyYy93aXBoeS5jOndpcGh5X3JhZGlvX3dvcmtfZG9uZSgpIFdvcmsgaXRlbSAx
NyBkb25lCkphbiAyMiAxOTo1ODowMCBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0Y29uZmlnLmM6
bmV0Y29uZmlnX2V2ZW50X2hhbmRsZXIoKSBsX25ldGNvbmZpZyBldmVudCAwCkphbiAyMiAxOTo1
ODowMCBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0Y29uZmlnLWNvbW1pdC5jOm5ldGNvbmZpZ19j
b21taXRfcHJpbnRfYWRkcnMoKSBpbnN0YWxsaW5nIGFkZHJlc3M6IDE5Mi4xNjguNS4yMjUKSmFu
IDIyIDE5OjU4OjAwIFBpNCBpd2RbMjI1OTAzNl06IHNyYy9yZXNvbHZlLmM6cmVzb2x2ZV9zeXN0
ZW1kX3NldF9kbnMoKSBpZmluZGV4OiAzCkphbiAyMiAxOTo1ODowMCBQaTQgaXdkWzIyNTkwMzZd
OiBzcmMvcmVzb2x2ZS5jOnN5c3RlbWRfYnVpbGRlcl9hZGRfZG5zKCkgaW5zdGFsbGluZyBETlM6
IDE5Mi4xNjguNS4xCkphbiAyMiAxOTo1ODowMCBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogc3Rh
dGUsIG9sZDogY29ubmVjdGluZyAobmV0Y29uZmlnKSwgbmV3OiBjb25uZWN0ZWQKSmFuIDIyIDE5
OjU4OjAwIFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXRjb25maWctY29tbWl0LmM6bmV0Y29uZmln
X2RoY3BfZ2F0ZXdheV90b19hcnAoKSBHYXRld2F5IE1BQyBpcyBrbm93biwgc2V0dGluZyBpbnRv
IEFSUCBjYWNoZQpKYW4gMjIgMTk6NTg6MDAgUGk0IGNvbm5tYW5kWzUzMTA3XTogd2xhbjAge2Fk
ZH0gYWRkcmVzcyAxOTIuMTY4LjUuMjI1LzI0IGxhYmVsIHdsYW4wIGZhbWlseSAyCkphbiAyMiAx
OTo1ODowMCBQaTQgc3lzdGVtZC1yZXNvbHZlZFszNDZdOiB3bGFuMDogQnVzIGNsaWVudCBzZXQg
RE5TIHNlcnZlciBsaXN0IHRvOiAxOTIuMTY4LjUuMQpKYW4gMjIgMTk6NTg6MDcgUGk0IGNvbm5t
YW5kWzUzMTA3XTogSW50ZXJmYWNlIHdsYW4wIFsgd2lmaSBdIHN0YXRlIGlzIHJlYWR5CkphbiAy
MiAxOTo1ODowNyBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0Y29uZmlnLmM6bmV0Y29uZmlnX2V2
ZW50X2hhbmRsZXIoKSBsX25ldGNvbmZpZyBldmVudCAzCg==
--000000000000971ec5062c8a751d
Content-Type: text/plain; charset="US-ASCII"; name="iwd_apipa_iwmon.txt"
Content-Disposition: attachment; filename="iwd_apipa_iwmon.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m6cdn2t00>
X-Attachment-Id: f_m6cdn2t00

V2lyZWxlc3MgbW9uaXRvciB2ZXIgMy4zCkNyZWF0ZWQgaW50ZXJmYWNlIG5sbW9uCj4gUmVzcG9u
c2U6IFNldCBDUU0gKDB4M2YpIGxlbiA0ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgOS4xOTIyMTMKICAgIFN0YXR1czogT3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQgKDk1KQo8
IFJlcXVlc3Q6IENvbm5lY3QgKDB4MmUpIGxlbiAxNjQgW2Fja10gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIDkuMTkyMjgwCiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMp
CiAgICBXaXBoeSBGcmVxdWVuY3k6IDI0MTIgKDB4MDAwMDA5NmMpCiAgICBNQUMgQWRkcmVzcyBE
ODozQTpERDo2MDpBMzowQwogICAgU1NJRDogbGVuIDcKICAgICAgICA2NCA2NSA3MyA2YiA1MyA0
MSA0NSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVza1NBRSAgICAgICAgIAogICAgQXV0
aCBUeXBlOiAwICgweDAwMDAwMDAwKQogICAgRXh0ZXJuYWwgQXV0aCBTdXBwb3J0OiAyNjEgbGVu
IDAKICAgIFByaXZhY3k6IHRydWUKICAgIFNvY2tldCBPd25zIEludGVyZmFjZS9Db25uZWN0aW9u
OiB0cnVlCiAgICBDaXBoZXIgU3VpdGVzIFBhaXJ3aXNlOgogICAgICAgIENDTVAgKDAwOjBmOmFj
KSBzdWl0ZSAgMDQKICAgIENpcGhlciBTdWl0ZSBHcm91cDogQ0NNUCAoMDA6MGY6YWMpIHN1aXRl
ICAwNAogICAgVXNlIE1GUDogMSAoMHgwMDAwMDAwMSkKICAgIEFLTSBTdWl0ZXM6CiAgICAgICAg
U0FFL1BNS1NBIGNhY2hpbmcgU0hBMjU2OyBSU05BIFBNS1NBIGNhY2hpbmcgU0hBMjU2L21lc2gg
cGVlcmluZyBleGNoYW5nZSAoMDA6MGY6YWMpIHN1aXRlICAwOAogICAgV1BBIFZlcnNpb25zOiA0
ICgweDAwMDAwMDA0KQogICAgQ29udHJvbCBQb3J0OiB0cnVlCiAgICBJbmZvcm1hdGlvbiBFbGVt
ZW50czogbGVuIDU2CiAgICAgICAgUlNOOgogICAgICAgICAgICBHcm91cCBEYXRhIENpcGhlciBT
dWl0ZTogbGVuIDQKICAgICAgICAgICAgICAgIENDTVAgKDAwOjBmOmFjKSBzdWl0ZSAgMDQKICAg
ICAgICAgICAgUGFpcndpc2UgQ2lwaGVyIFN1aXRlOiBsZW4gNAogICAgICAgICAgICAgICAgQ0NN
UCAoMDA6MGY6YWMpIHN1aXRlICAwNAogICAgICAgICAgICBBS00gU3VpdGU6IGxlbiA0CiAgICAg
ICAgICAgICAgICBTQUUvUE1LU0EgY2FjaGluZyBTSEEyNTY7IFJTTkEgUE1LU0EgY2FjaGluZyBT
SEEyNTYvbWVzaCBwZWVyaW5nIGV4Y2hhbmdlICgwMDowZjphYykgc3VpdGUgIDA4CiAgICAgICAg
ICAgIFJTTiBjYXBhYmlsaXRpZXM6IGJpdHMgIDIgLSAzOiAxIHJlcGxheSBjb3VudGVyIHBlciBQ
VEtTQQogICAgICAgICAgICBSU04gY2FwYWJpbGl0aWVzOiBiaXRzICA0IC0gNTogMSByZXBsYXkg
Y291bnRlciBwZXIgR1RLU0EKICAgICAgICAgICAgUlNOIGNhcGFiaWxpdGllczogYml0ICA3OiBN
YW5hZ2VtZW50IEZyYW1lIFByb3RlY3Rpb24gQ2FwYWJsZQogICAgICAgICAgICBQTUtJRDogZGM6
MTI6MjU6ZTI6ODg6OTI6NzQ6NTM6Yjk6ODc6OWE6MDE6ZDQ6N2Q6N2E6ZjUKICAgICAgICAgICAg
MDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgYWMgMDQgMDEgMDAgMDAgMGYgIC4uLi4uLi4u
Li4uLi4uLi4KICAgICAgICAgICAgYWMgMDggODAgMDAgMDEgMDAgZGMgMTIgMjUgZTIgODggOTIg
NzQgNTMgYjkgODcgIC4uLi4uLi4uJS4uLnRTLi4KICAgICAgICAgICAgOWEgMDEgZDQgN2QgN2Eg
ZjUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC4uLn16LiAgICAgICAgICAKICAgICAg
ICBFeHRlbmRlZCBDYXBhYmlsaXRpZXM6IGxlbiAxMAogICAgICAgICAgICBDYXBhYmlsaXR5OiBi
aXQgMTk6IEJTUyB0cmFuc2l0aW9uCiAgICAgICAgICAgIDAwIDAwIDA4IDAwIDAwIDAwIDAwIDAw
IDAwIDAxICAgICAgICAgICAgICAgICAgICAuLi4uLi4uLi4uICAgICAgCiAgICAgICAgVGFnIDI2
MjogbGVuIDEKICAgICAgICAgICAgMWEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC4gICAgICAgICAgICAgICAKPiBSZXNwb25zZTogQ29ubmVjdCAoMHgyZSkg
bGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA5LjIxNjg2NQogICAg
U3RhdHVzOiBTdWNjZXNzICgwKQo+IEV2ZW50OiBFeHRlcm5hbCBBdXRoICgweDdmKSBsZW4gNTYg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDkuMzA5ODMzCiAgICBXaXBoeTogMCAo
MHgwMDAwMDAwMCkKICAgIEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAgIEFLTSBT
dWl0ZXM6CiAgICAgICAgdW5rbm93biAoMDg6YWM6MGYpIHN1aXRlIDAwICh1bmtub3duKQogICAg
RXh0ZXJuYWwgQXV0aCBBY3Rpb246IDI2MCBsZW4gNAogICAgICAgIDAwIDAwIDAwIDAwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAuLi4uICAgICAgICAgICAgCiAgICBCU1NJ
RCBEODozQTpERDo2MDpBMzowQwogICAgU1NJRDogbGVuIDcKICAgICAgICA2NCA2NSA3MyA2YiA1
MyA0MSA0NSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVza1NBRSAgICAgICAgIAo8IFJl
cXVlc3Q6IEV4dGVybmFsIEF1dGggKDB4N2YpIGxlbiA0MCBbYWNrXSAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDkuMzA5OTg4CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAg
ICBTdGF0dXMgQ29kZTogMSAoMHgwMDAxKQogICAgU1NJRDogbGVuIDcKICAgICAgICA2NCA2NSA3
MyA2YiA1MyA0MSA0NSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVza1NBRSAgICAgICAg
IAogICAgQlNTSUQgRDg6M0E6REQ6NjA6QTM6MEMKPiBSZXNwb25zZTogRXh0ZXJuYWwgQXV0aCAo
MHg3ZikgbGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICA5LjMxMDM5OQogICAg
U3RhdHVzOiBTdWNjZXNzICgwKQo8IFJlcXVlc3Q6IEdldCBTdGF0aW9uICgweDExKSBsZW4gMjAg
W2Fja10gICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAuMTkyMzE5CiAgICBJbnRlcmZhY2Ug
SW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVzcyBEODozQTpERDo2MDpBMzowQwo+
IFJlc3VsdDogTmV3IFN0YXRpb24gKDB4MTMpIGxlbiA5MiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMTAuMTk2NDkwCiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMp
CiAgICBNQUMgQWRkcmVzcyBEODozQTpERDo2MDpBMzowQwogICAgR2VuZXJhdGlvbjogMCAoMHgw
MDAwMDAwMCkKICAgIFN0YXRpb24gSW5mbzogbGVuIDYwCiAgICAgICAgSW5hY3Rpdml0eSB0aW1l
OiAwICgweDAwMDAwMDAwKQogICAgICAgIFRvdGFsIFJYIGJ5dGVzOiAwICgweDAwMDAwMDAwKQog
ICAgICAgIFRvdGFsIFRYIGJ5dGVzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFJYIHBhY2tldHM6
IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVFggcGFja2V0czogMCAoMHgwMDAwMDAwMCkKICAgICAg
ICBUWCBmYWlsZWQ6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgU3RhdGlvbiBmbGFnczogbGVuIDgK
ICAgICAgICAgICAgTWFzazogMHgwMDAwMDBlYQogICAgICAgICAgICAgICAgQXV0aG9yaXplZAog
ICAgICAgICAgICAgICAgV01FCiAgICAgICAgICAgICAgICBBdXRoZW50aWNhdGVkCiAgICAgICAg
ICAgICAgICBURExTLVBlZXIKICAgICAgICAgICAgICAgIEFzc29jaWF0ZWQKICAgICAgICAgICAg
U2V0OiAweDAwMDAwMDAwCj4gUmVzcG9uc2U6IEdldCBTdGF0aW9uICgweDExKSBsZW4gNCBbMHgx
MDBdICAgICAgICAgICAgICAgICAgICAgICAgICAxMC4xOTY1MDAKICAgIFN0YXR1czogU3VjY2Vz
cyAoMCkKPCBSZXF1ZXN0OiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDIwIFthY2tdICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDE2LjE5NjU4MAogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAw
MDAwMDAzKQogICAgTUFDIEFkZHJlc3MgRDg6M0E6REQ6NjA6QTM6MEMKPiBSZXN1bHQ6IE5ldyBT
dGF0aW9uICgweDEzKSBsZW4gOTIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDE2
LjIwMDc1MQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgTUFDIEFkZHJl
c3MgRDg6M0E6REQ6NjA6QTM6MEMKICAgIEdlbmVyYXRpb246IDAgKDB4MDAwMDAwMDApCiAgICBT
dGF0aW9uIEluZm86IGxlbiA2MAogICAgICAgIEluYWN0aXZpdHkgdGltZTogNjAwMCAoMHgwMDAw
MTc3MCkKICAgICAgICBUb3RhbCBSWCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAgICAgICBUb3Rh
bCBUWCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAgICAgICBSWCBwYWNrZXRzOiAwICgweDAwMDAw
MDAwKQogICAgICAgIFRYIHBhY2tldHM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVFggZmFpbGVk
OiAwICgweDAwMDAwMDAwKQogICAgICAgIFN0YXRpb24gZmxhZ3M6IGxlbiA4CiAgICAgICAgICAg
IE1hc2s6IDB4MDAwMDAwZWEKICAgICAgICAgICAgICAgIEF1dGhvcml6ZWQKICAgICAgICAgICAg
ICAgIFdNRQogICAgICAgICAgICAgICAgQXV0aGVudGljYXRlZAogICAgICAgICAgICAgICAgVERM
Uy1QZWVyCiAgICAgICAgICAgICAgICBBc3NvY2lhdGVkCiAgICAgICAgICAgIFNldDogMHgwMDAw
MDAwMAo+IFJlc3BvbnNlOiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDQgWzB4MTAwXSAgICAgICAg
ICAgICAgICAgICAgICAgICAgMTYuMjAwNzYxCiAgICBTdGF0dXM6IFN1Y2Nlc3MgKDApCjwgUmVx
dWVzdDogR2V0IFN0YXRpb24gKDB4MTEpIGxlbiAyMCBbYWNrXSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAyMi4yMDA4MzgKICAgIEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAg
IE1BQyBBZGRyZXNzIEQ4OjNBOkREOjYwOkEzOjBDCj4gUmVzdWx0OiBOZXcgU3RhdGlvbiAoMHgx
MykgbGVuIDkyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyMi4yMDQ5NTgKICAg
IEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAgIE1BQyBBZGRyZXNzIEQ4OjNBOkRE
OjYwOkEzOjBDCiAgICBHZW5lcmF0aW9uOiAwICgweDAwMDAwMDAwKQogICAgU3RhdGlvbiBJbmZv
OiBsZW4gNjAKICAgICAgICBJbmFjdGl2aXR5IHRpbWU6IDEyMDAwICgweDAwMDAyZWUwKQogICAg
ICAgIFRvdGFsIFJYIGJ5dGVzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFRvdGFsIFRYIGJ5dGVz
OiAwICgweDAwMDAwMDAwKQogICAgICAgIFJYIHBhY2tldHM6IDAgKDB4MDAwMDAwMDApCiAgICAg
ICAgVFggcGFja2V0czogMCAoMHgwMDAwMDAwMCkKICAgICAgICBUWCBmYWlsZWQ6IDAgKDB4MDAw
MDAwMDApCiAgICAgICAgU3RhdGlvbiBmbGFnczogbGVuIDgKICAgICAgICAgICAgTWFzazogMHgw
MDAwMDBlYQogICAgICAgICAgICAgICAgQXV0aG9yaXplZAogICAgICAgICAgICAgICAgV01FCiAg
ICAgICAgICAgICAgICBBdXRoZW50aWNhdGVkCiAgICAgICAgICAgICAgICBURExTLVBlZXIKICAg
ICAgICAgICAgICAgIEFzc29jaWF0ZWQKICAgICAgICAgICAgU2V0OiAweDAwMDAwMDAwCj4gUmVz
cG9uc2U6IEdldCBTdGF0aW9uICgweDExKSBsZW4gNCBbMHgxMDBdICAgICAgICAgICAgICAgICAg
ICAgICAgICAyMi4yMDQ5NjgKICAgIFN0YXR1czogU3VjY2VzcyAoMCkKPCBSZXF1ZXN0OiBHZXQg
U3RhdGlvbiAoMHgxMSkgbGVuIDIwIFthY2tdICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI4
LjIwNTA0OQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgTUFDIEFkZHJl
c3MgRDg6M0E6REQ6NjA6QTM6MEMKPiBSZXN1bHQ6IE5ldyBTdGF0aW9uICgweDEzKSBsZW4gOTIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDI4LjIwOTE2NQogICAgSW50ZXJmYWNl
IEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgTUFDIEFkZHJlc3MgRDg6M0E6REQ6NjA6QTM6MEMK
ICAgIEdlbmVyYXRpb246IDAgKDB4MDAwMDAwMDApCiAgICBTdGF0aW9uIEluZm86IGxlbiA2MAog
ICAgICAgIEluYWN0aXZpdHkgdGltZTogMTgwMDAgKDB4MDAwMDQ2NTApCiAgICAgICAgVG90YWwg
UlggYnl0ZXM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVG90YWwgVFggYnl0ZXM6IDAgKDB4MDAw
MDAwMDApCiAgICAgICAgUlggcGFja2V0czogMCAoMHgwMDAwMDAwMCkKICAgICAgICBUWCBwYWNr
ZXRzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFRYIGZhaWxlZDogMCAoMHgwMDAwMDAwMCkKICAg
ICAgICBTdGF0aW9uIGZsYWdzOiBsZW4gOAogICAgICAgICAgICBNYXNrOiAweDAwMDAwMGVhCiAg
ICAgICAgICAgICAgICBBdXRob3JpemVkCiAgICAgICAgICAgICAgICBXTUUKICAgICAgICAgICAg
ICAgIEF1dGhlbnRpY2F0ZWQKICAgICAgICAgICAgICAgIFRETFMtUGVlcgogICAgICAgICAgICAg
ICAgQXNzb2NpYXRlZAogICAgICAgICAgICBTZXQ6IDB4MDAwMDAwMDAKPiBSZXNwb25zZTogR2V0
IFN0YXRpb24gKDB4MTEpIGxlbiA0IFsweDEwMF0gICAgICAgICAgICAgICAgICAgICAgICAgIDI4
LjIwOTE3NAogICAgU3RhdHVzOiBTdWNjZXNzICgwKQo8IFJlcXVlc3Q6IEdldCBTdGF0aW9uICgw
eDExKSBsZW4gMjAgW2Fja10gICAgICAgICAgICAgICAgICAgICAgICAgICAgMzQuMjA5MjYxCiAg
ICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVzcyBEODozQTpE
RDo2MDpBMzowQwo+IFJlc3VsdDogTmV3IFN0YXRpb24gKDB4MTMpIGxlbiA5MiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgMzQuMjEzMzY3CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMg
KDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVzcyBEODozQTpERDo2MDpBMzowQwogICAgR2VuZXJh
dGlvbjogMCAoMHgwMDAwMDAwMCkKICAgIFN0YXRpb24gSW5mbzogbGVuIDYwCiAgICAgICAgSW5h
Y3Rpdml0eSB0aW1lOiAyNDAwMCAoMHgwMDAwNWRjMCkKICAgICAgICBUb3RhbCBSWCBieXRlczog
MCAoMHgwMDAwMDAwMCkKICAgICAgICBUb3RhbCBUWCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAg
ICAgICBSWCBwYWNrZXRzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFRYIHBhY2tldHM6IDAgKDB4
MDAwMDAwMDApCiAgICAgICAgVFggZmFpbGVkOiAwICgweDAwMDAwMDAwKQogICAgICAgIFN0YXRp
b24gZmxhZ3M6IGxlbiA4CiAgICAgICAgICAgIE1hc2s6IDB4MDAwMDAwZWEKICAgICAgICAgICAg
ICAgIEF1dGhvcml6ZWQKICAgICAgICAgICAgICAgIFdNRQogICAgICAgICAgICAgICAgQXV0aGVu
dGljYXRlZAogICAgICAgICAgICAgICAgVERMUy1QZWVyCiAgICAgICAgICAgICAgICBBc3NvY2lh
dGVkCiAgICAgICAgICAgIFNldDogMHgwMDAwMDAwMAo+IFJlc3BvbnNlOiBHZXQgU3RhdGlvbiAo
MHgxMSkgbGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgMzQuMjEzMzc4CiAg
ICBTdGF0dXM6IFN1Y2Nlc3MgKDApCjwgUmVxdWVzdDogR2V0IFN0YXRpb24gKDB4MTEpIGxlbiAy
MCBbYWNrXSAgICAgICAgICAgICAgICAgICAgICAgICAgICA0MC4yMTM0NTgKICAgIEludGVyZmFj
ZSBJbmRleDogMyAoMHgwMDAwMDAwMykKICAgIE1BQyBBZGRyZXNzIEQ4OjNBOkREOjYwOkEzOjBD
Cj4gUmVzdWx0OiBOZXcgU3RhdGlvbiAoMHgxMykgbGVuIDkyICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICA0MC4yMTc1OTUKICAgIEludGVyZmFjZSBJbmRleDogMyAoMHgwMDAwMDAw
MykKICAgIE1BQyBBZGRyZXNzIEQ4OjNBOkREOjYwOkEzOjBDCiAgICBHZW5lcmF0aW9uOiAwICgw
eDAwMDAwMDAwKQogICAgU3RhdGlvbiBJbmZvOiBsZW4gNjAKICAgICAgICBJbmFjdGl2aXR5IHRp
bWU6IDMwMDAwICgweDAwMDA3NTMwKQogICAgICAgIFRvdGFsIFJYIGJ5dGVzOiAwICgweDAwMDAw
MDAwKQogICAgICAgIFRvdGFsIFRYIGJ5dGVzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFJYIHBh
Y2tldHM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVFggcGFja2V0czogMCAoMHgwMDAwMDAwMCkK
ICAgICAgICBUWCBmYWlsZWQ6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgU3RhdGlvbiBmbGFnczog
bGVuIDgKICAgICAgICAgICAgTWFzazogMHgwMDAwMDBlYQogICAgICAgICAgICAgICAgQXV0aG9y
aXplZAogICAgICAgICAgICAgICAgV01FCiAgICAgICAgICAgICAgICBBdXRoZW50aWNhdGVkCiAg
ICAgICAgICAgICAgICBURExTLVBlZXIKICAgICAgICAgICAgICAgIEFzc29jaWF0ZWQKICAgICAg
ICAgICAgU2V0OiAweDAwMDAwMDAwCj4gUmVzcG9uc2U6IEdldCBTdGF0aW9uICgweDExKSBsZW4g
NCBbMHgxMDBdICAgICAgICAgICAgICAgICAgICAgICAgICA0MC4yMTc2MDQKICAgIFN0YXR1czog
U3VjY2VzcyAoMCkKPCBSZXF1ZXN0OiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDIwIFthY2tdICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDQ2LjIxNzY4MgogICAgSW50ZXJmYWNlIEluZGV4OiAz
ICgweDAwMDAwMDAzKQogICAgTUFDIEFkZHJlc3MgRDg6M0E6REQ6NjA6QTM6MEMKPiBSZXN1bHQ6
IE5ldyBTdGF0aW9uICgweDEzKSBsZW4gOTIgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDQ2LjIyMTc5NQogICAgSW50ZXJmYWNlIEluZGV4OiAzICgweDAwMDAwMDAzKQogICAgTUFD
IEFkZHJlc3MgRDg6M0E6REQ6NjA6QTM6MEMKICAgIEdlbmVyYXRpb246IDAgKDB4MDAwMDAwMDAp
CiAgICBTdGF0aW9uIEluZm86IGxlbiA2MAogICAgICAgIEluYWN0aXZpdHkgdGltZTogMzYwMDAg
KDB4MDAwMDhjYTApCiAgICAgICAgVG90YWwgUlggYnl0ZXM6IDAgKDB4MDAwMDAwMDApCiAgICAg
ICAgVG90YWwgVFggYnl0ZXM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgUlggcGFja2V0czogMCAo
MHgwMDAwMDAwMCkKICAgICAgICBUWCBwYWNrZXRzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFRY
IGZhaWxlZDogMCAoMHgwMDAwMDAwMCkKICAgICAgICBTdGF0aW9uIGZsYWdzOiBsZW4gOAogICAg
ICAgICAgICBNYXNrOiAweDAwMDAwMGVhCiAgICAgICAgICAgICAgICBBdXRob3JpemVkCiAgICAg
ICAgICAgICAgICBXTUUKICAgICAgICAgICAgICAgIEF1dGhlbnRpY2F0ZWQKICAgICAgICAgICAg
ICAgIFRETFMtUGVlcgogICAgICAgICAgICAgICAgQXNzb2NpYXRlZAogICAgICAgICAgICBTZXQ6
IDB4MDAwMDAwMDAKPiBSZXNwb25zZTogR2V0IFN0YXRpb24gKDB4MTEpIGxlbiA0IFsweDEwMF0g
ICAgICAgICAgICAgICAgICAgICAgICAgIDQ2LjIyMTgwNQogICAgU3RhdHVzOiBTdWNjZXNzICgw
KQo8IFJlcXVlc3Q6IEdldCBTdGF0aW9uICgweDExKSBsZW4gMjAgW2Fja10gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgNTIuMjIxODg2CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAw
MDMpCiAgICBNQUMgQWRkcmVzcyBEODozQTpERDo2MDpBMzowQwo+IFJlc3VsdDogTmV3IFN0YXRp
b24gKDB4MTMpIGxlbiA5MiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTIuMjI1
MTA1CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVzcyBE
ODozQTpERDo2MDpBMzowQwogICAgR2VuZXJhdGlvbjogMCAoMHgwMDAwMDAwMCkKICAgIFN0YXRp
b24gSW5mbzogbGVuIDYwCiAgICAgICAgSW5hY3Rpdml0eSB0aW1lOiA0MjAwMCAoMHgwMDAwYTQx
MCkKICAgICAgICBUb3RhbCBSWCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAgICAgICBUb3RhbCBU
WCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAgICAgICBSWCBwYWNrZXRzOiAwICgweDAwMDAwMDAw
KQogICAgICAgIFRYIHBhY2tldHM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVFggZmFpbGVkOiAw
ICgweDAwMDAwMDAwKQogICAgICAgIFN0YXRpb24gZmxhZ3M6IGxlbiA4CiAgICAgICAgICAgIE1h
c2s6IDB4MDAwMDAwZWEKICAgICAgICAgICAgICAgIEF1dGhvcml6ZWQKICAgICAgICAgICAgICAg
IFdNRQogICAgICAgICAgICAgICAgQXV0aGVudGljYXRlZAogICAgICAgICAgICAgICAgVERMUy1Q
ZWVyCiAgICAgICAgICAgICAgICBBc3NvY2lhdGVkCiAgICAgICAgICAgIFNldDogMHgwMDAwMDAw
MAo+IFJlc3BvbnNlOiBHZXQgU3RhdGlvbiAoMHgxMSkgbGVuIDQgWzB4MTAwXSAgICAgICAgICAg
ICAgICAgICAgICAgICAgNTIuMjI1MTE1CiAgICBTdGF0dXM6IFN1Y2Nlc3MgKDApCjwgUlROTDog
TmV3IEFkZHJlc3MgKDB4MTQpIGxlbiAyNCBbcmVxdWVzdCxhY2sscmVwbGFjZV0gICAgICAgICAg
ICAgICA1NS4wMzkzNzUKICAgIEZsYWdzOiAyNjEgKDB4MTA1KQogICAgU2VxdWVuY2UgbnVtYmVy
OiAxICgweDAwMDAwMDAxKQogICAgUG9ydCBJRDogMAogICAgSUZBIEZhbWlseTogQUZfSU5FVAog
ICAgSUZBIFByZWZpeGxlbjogMTYKICAgIElGQSBJbmRleDogMwogICAgSUZBIFNjb3BlOiBnbG9i
YWwKICAgIElGQSBGbGFnczogKDB4ODApIFtwZXJtYW5lbnRdCiAgICAgICAgTG9jYWwgQWRkcmVz
czogMTY5LjI1NC42Ny4xNDIKICAgICAgICBCcm9hZGNhc3QgQWRkcmVzczogMTY5LjI1NC4yNTUu
MjU1Cj4gUlROTDogTmV3IEFkZHJlc3MgKDB4MTQpIGxlbiA3MiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA1NS4wMzk0MTQKICAgIEZsYWdzOiAwICgweDAwMCkKICAgIFNlcXVl
bmNlIG51bWJlcjogMSAoMHgwMDAwMDAwMSkKICAgIFBvcnQgSUQ6IDI3NTU5OTc5MDkKICAgIElG
QSBGYW1pbHk6IEFGX0lORVQKICAgIElGQSBQcmVmaXhsZW46IDE2CiAgICBJRkEgSW5kZXg6IDMK
ICAgIElGQSBTY29wZTogZ2xvYmFsCiAgICBJRkEgRmxhZ3M6ICgweDgwKSBbcGVybWFuZW50XQog
ICAgICAgIEludGVyZmFjZSBBZGRyZXNzOiAxNjkuMjU0LjY3LjE0MgogICAgICAgIExvY2FsIEFk
ZHJlc3M6IDE2OS4yNTQuNjcuMTQyCiAgICAgICAgQnJvYWRjYXN0IEFkZHJlc3M6IDE2OS4yNTQu
MjU1LjI1NQogICAgICAgIExhYmVsIChsZW46Nik6IHdsYW4wCiAgICAgICAgRmxhZ3M6ICgweDgw
KSBbcGVybWFuZW50XQogICAgICAgIENhY2hlSW5mbzoKICAgICAgICAgICAgaWZhX3ByZWZlcmVk
OiBpbmZpbml0ZQogICAgICAgICAgICBpZmFfdmFsaWQ6IGluZmluaXRlCiAgICAgICAgICAgIHRz
dGFtcDogMTg2NTU5MDAsIGNzdGFtcDogMTg2NTU5MDAKPiBSVE5MOiBOZXcgQWRkcmVzcyAoMHgx
NCkgbGVuIDcyICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjAzOTQyMgog
ICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxICgweDAwMDAwMDAxKQog
ICAgUG9ydCBJRDogMjc1NTk5NzkwOQogICAgSUZBIEZhbWlseTogQUZfSU5FVAogICAgSUZBIFBy
ZWZpeGxlbjogMTYKICAgIElGQSBJbmRleDogMwogICAgSUZBIFNjb3BlOiBnbG9iYWwKICAgIElG
QSBGbGFnczogKDB4ODApIFtwZXJtYW5lbnRdCiAgICAgICAgSW50ZXJmYWNlIEFkZHJlc3M6IDE2
OS4yNTQuNjcuMTQyCiAgICAgICAgTG9jYWwgQWRkcmVzczogMTY5LjI1NC42Ny4xNDIKICAgICAg
ICBCcm9hZGNhc3QgQWRkcmVzczogMTY5LjI1NC4yNTUuMjU1CiAgICAgICAgTGFiZWwgKGxlbjo2
KTogd2xhbjAKICAgICAgICBGbGFnczogKDB4ODApIFtwZXJtYW5lbnRdCiAgICAgICAgQ2FjaGVJ
bmZvOgogICAgICAgICAgICBpZmFfcHJlZmVyZWQ6IGluZmluaXRlCiAgICAgICAgICAgIGlmYV92
YWxpZDogaW5maW5pdGUKICAgICAgICAgICAgdHN0YW1wOiAxODY1NTkwMCwgY3N0YW1wOiAxODY1
NTkwMAo+IFJUTkw6IE5ldyBBZGRyZXNzICgweDE0KSBsZW4gNzIgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgNTUuMDM5NDI4CiAgICBGbGFnczogMCAoMHgwMDApCiAgICBTZXF1
ZW5jZSBudW1iZXI6IDEgKDB4MDAwMDAwMDEpCiAgICBQb3J0IElEOiAyNzU1OTk3OTA5CiAgICBJ
RkEgRmFtaWx5OiBBRl9JTkVUCiAgICBJRkEgUHJlZml4bGVuOiAxNgogICAgSUZBIEluZGV4OiAz
CiAgICBJRkEgU2NvcGU6IGdsb2JhbAogICAgSUZBIEZsYWdzOiAoMHg4MCkgW3Blcm1hbmVudF0K
ICAgICAgICBJbnRlcmZhY2UgQWRkcmVzczogMTY5LjI1NC42Ny4xNDIKICAgICAgICBMb2NhbCBB
ZGRyZXNzOiAxNjkuMjU0LjY3LjE0MgogICAgICAgIEJyb2FkY2FzdCBBZGRyZXNzOiAxNjkuMjU0
LjI1NS4yNTUKICAgICAgICBMYWJlbCAobGVuOjYpOiB3bGFuMAogICAgICAgIEZsYWdzOiAoMHg4
MCkgW3Blcm1hbmVudF0KICAgICAgICBDYWNoZUluZm86CiAgICAgICAgICAgIGlmYV9wcmVmZXJl
ZDogaW5maW5pdGUKICAgICAgICAgICAgaWZhX3ZhbGlkOiBpbmZpbml0ZQogICAgICAgICAgICB0
c3RhbXA6IDE4NjU1OTAwLCBjc3RhbXA6IDE4NjU1OTAwCj4gUlROTDogTmV3IEFkZHJlc3MgKDB4
MTQpIGxlbiA3MiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NS4wMzk0MzIK
ICAgIEZsYWdzOiAwICgweDAwMCkKICAgIFNlcXVlbmNlIG51bWJlcjogMSAoMHgwMDAwMDAwMSkK
ICAgIFBvcnQgSUQ6IDI3NTU5OTc5MDkKICAgIElGQSBGYW1pbHk6IEFGX0lORVQKICAgIElGQSBQ
cmVmaXhsZW46IDE2CiAgICBJRkEgSW5kZXg6IDMKICAgIElGQSBTY29wZTogZ2xvYmFsCiAgICBJ
RkEgRmxhZ3M6ICgweDgwKSBbcGVybWFuZW50XQogICAgICAgIEludGVyZmFjZSBBZGRyZXNzOiAx
NjkuMjU0LjY3LjE0MgogICAgICAgIExvY2FsIEFkZHJlc3M6IDE2OS4yNTQuNjcuMTQyCiAgICAg
ICAgQnJvYWRjYXN0IEFkZHJlc3M6IDE2OS4yNTQuMjU1LjI1NQogICAgICAgIExhYmVsIChsZW46
Nik6IHdsYW4wCiAgICAgICAgRmxhZ3M6ICgweDgwKSBbcGVybWFuZW50XQogICAgICAgIENhY2hl
SW5mbzoKICAgICAgICAgICAgaWZhX3ByZWZlcmVkOiBpbmZpbml0ZQogICAgICAgICAgICBpZmFf
dmFsaWQ6IGluZmluaXRlCiAgICAgICAgICAgIHRzdGFtcDogMTg2NTU5MDAsIGNzdGFtcDogMTg2
NTU5MDAKPiBSVE5MOiBOZXcgQWRkcmVzcyAoMHgxNCkgbGVuIDcyICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDU1LjAzOTQzNgogICAgRmxhZ3M6IDAgKDB4MDAwKQogICAgU2Vx
dWVuY2UgbnVtYmVyOiAxICgweDAwMDAwMDAxKQogICAgUG9ydCBJRDogMjc1NTk5NzkwOQogICAg
SUZBIEZhbWlseTogQUZfSU5FVAogICAgSUZBIFByZWZpeGxlbjogMTYKICAgIElGQSBJbmRleDog
MwogICAgSUZBIFNjb3BlOiBnbG9iYWwKICAgIElGQSBGbGFnczogKDB4ODApIFtwZXJtYW5lbnRd
CiAgICAgICAgSW50ZXJmYWNlIEFkZHJlc3M6IDE2OS4yNTQuNjcuMTQyCiAgICAgICAgTG9jYWwg
QWRkcmVzczogMTY5LjI1NC42Ny4xNDIKICAgICAgICBCcm9hZGNhc3QgQWRkcmVzczogMTY5LjI1
NC4yNTUuMjU1CiAgICAgICAgTGFiZWwgKGxlbjo2KTogd2xhbjAKICAgICAgICBGbGFnczogKDB4
ODApIFtwZXJtYW5lbnRdCiAgICAgICAgQ2FjaGVJbmZvOgogICAgICAgICAgICBpZmFfcHJlZmVy
ZWQ6IGluZmluaXRlCiAgICAgICAgICAgIGlmYV92YWxpZDogaW5maW5pdGUKICAgICAgICAgICAg
dHN0YW1wOiAxODY1NTkwMCwgY3N0YW1wOiAxODY1NTkwMAo+IFJUTkw6IE5ldyBSb3V0ZSAoMHgx
OCkgbGVuIDQ0IFtleGNsLGNyZWF0ZV0gICAgICAgICAgICAgICAgICAgICAgICAgNTUuMDM5NDk5
CiAgICBGbGFnczogMTUzNiAoMHg2MDApCiAgICBTZXF1ZW5jZSBudW1iZXI6IDAgKDB4MDAwMDAw
MDApCiAgICBQb3J0IElEOiAwCiAgICBSVE0gRmFtaWx5OiBBRl9JTkVUCiAgICBSVE0gRGVzdGlu
YXRpb24gTGVuOiAxNgogICAgUlRNIFNvdXJjZSBMZW46IDAKICAgIFJUTSBUT1MgRmllbGQ6IDAK
ICAgIFJUTSBUYWJsZTogMjU0CiAgICBSVE0gUHJvdG9jb2w6IGtlcm5lbAogICAgUlRNIFNjb3Bl
OiBsaW5rCiAgICBSVE0gVHlwZTogMQogICAgUlRNIEZsYWdzOiAoMHgwMCkKICAgICAgICBSb3V0
aW5nIFRhYmxlOiAyNTQgKDB4MDAwMDAwZmUpCiAgICAgICAgRGVzdGluYXRpb24gQWRkcmVzczog
MTY5LjI1NC4wLjAKICAgICAgICBQcmVmZXJyZWQgU291cmNlOiAxNjkuMjU0LjY3LjE0MgogICAg
ICAgIE91dHB1dCBJbnRlcmZhY2UgSW5kZXg6IDMKPiBSVE5MOiBFcnJvciAoMHgwMikgbGVuIDIw
IFsweDEwMF0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjA0NDAzOQogICAg
RmxhZ3M6IDI1NiAoMHgxMDApCiAgICBTZXF1ZW5jZSBudW1iZXI6IDEgKDB4MDAwMDAwMDEpCiAg
ICBQb3J0IElEOiAyNzU1OTk3OTA5CiAgICBBQ0s6IDAKPCBSVE5MOiBHZXQgTGluayAoMHgxMikg
bGVuIDQgW3JlcXVlc3QsZHVtcF0gICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjA0NDE4OAog
ICAgRmxhZ3M6IDc2OSAoMHgzMDEpCiAgICBTZXF1ZW5jZSBudW1iZXI6IDE3Mzc1OTY3MjIgKDB4
Njc5MTlmMzIpCiAgICBQb3J0IElEOiAwCj4gUlROTDogTmV3IExpbmsgKDB4MTApIGxlbiAxNDEy
IFttdWx0aV0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NS4wNDQyMzMKICAgIEZsYWdz
OiAyICgweDAwMikKICAgIFNlcXVlbmNlIG51bWJlcjogMTczNzU5NjcyMiAoMHg2NzkxOWYzMikK
ICAgIFBvcnQgSUQ6IDI5NjU2MTc2NzIKPiBSVE5MOiBOZXcgTGluayAoMHgxMCkgbGVuIDE0NjQg
W211bHRpXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjA0NDIzMwogICAgRmxhZ3M6
IDIgKDB4MDAyKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxNzM3NTk2NzIyICgweDY3OTE5ZjMyKQog
ICAgUG9ydCBJRDogMjk2NTYxNzY3Mgo+IFJUTkw6IE5ldyBMaW5rICgweDEwKSBsZW4gMTQ2MCBb
bXVsdGldICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTUuMDQ0MjU5CiAgICBGbGFnczog
MiAoMHgwMDIpCiAgICBTZXF1ZW5jZSBudW1iZXI6IDE3Mzc1OTY3MjIgKDB4Njc5MTlmMzIpCiAg
ICBQb3J0IElEOiAyOTY1NjE3NjcyCiAgICBJRkxBIEZhbWlseTogVW5rbm93bgogICAgSUZMQSBU
eXBlOiAxCiAgICBJRkxBIEluZGV4OiAzCiAgICBJRkxBIENoYW5nZU1hc2s6IDAKICAgIElGTEEg
RmxhZ3M6ICgweDEwNDMpIFt1cCxicm9hZGNhc3QscnVubmluZyxtdWx0aWNhc3RdCiAgICAgICAg
SWZOYW1lIChsZW46Nik6IHdsYW4wCiAgICAgICAgVHhxbGVuOiA0MDAwICgweDAwMDAwZmEwKQog
ICAgICAgIE9wZXJTdGF0ZTogdXAgKDYpCiAgICAgICAgTGlua01vZGU6IHVzZXJzcGFjZSBjb250
cm9sbGVkICgxKQogICAgICAgIE1UVTogMTUwMCAoMHgwMDAwMDVkYykKICAgICAgICBSZXNlcnZl
ZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQK
ICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBS
ZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDog
bGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAg
ICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNl
cnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVuIDQKICAgICAgICBSZXNlcnZlZDogbGVu
IDEKICAgICAgICBRZGlzYyAobGVuOjExKTogcGZpZm9fZmFzdAogICAgICAgIFJlc2VydmVkOiBs
ZW4gNAogICAgICAgIFJlc2VydmVkOiBsZW4gNAogICAgICAgIFJlc2VydmVkOiBsZW4gNAogICAg
ICAgIFJlc2VydmVkOiBsZW4gMQogICAgICAgIE1hcDogbGVuIDMyCiAgICAgICAgICAgIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4u
Li4uCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgSW50ZXJmYWNlIEFkZHJlc3M6IGRjOmE2
OjMyOmI0OjUwOmNmCiAgICAgICAgQnJvYWRjYXN0IEFkZHJlc3M6IGZmOmZmOmZmOmZmOmZmOmZm
CiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiAyMDAKICAgICAgICBTdGF0czogbGVuIDk2CiAgICAgICAg
ICAgIGY1IDAxIDAwIDAwIDE4IDE3IDAwIDAwIDJiIGY4IDAwIDAwIDQ2IDM1IDI5IDAwICAuLi4u
Li4uLisuLi5GNSkuCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgICAgIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAg
ICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
ICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgICAgIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4uLi4uCiAgICAgICAgICAgIDAwIDAw
IDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAwICAuLi4uLi4uLi4uLi4u
Li4uCiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiA4CiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiA2CiAgICAg
ICAgUmVzZXJ2ZWQ6IGxlbiA4MDgKICAgICAgICBSZXNlcnZlZDogbGVuIDEyCiAgICAgICAgUmVz
ZXJ2ZWQ6IGxlbiA1CiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiAwCj4gUlROTDogTmV3IExpbmsgKDB4
MTApIGxlbiAxNDA4IFttdWx0aV0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NS4wNDQy
NTkKICAgIEZsYWdzOiAyICgweDAwMikKICAgIFNlcXVlbmNlIG51bWJlcjogMTczNzU5NjcyMiAo
MHg2NzkxOWYzMikKICAgIFBvcnQgSUQ6IDI5NjU2MTc2NzIKPiBSVE5MOiBEb25lICgweDAzKSBs
ZW4gNCBbbXVsdGldICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjA0NDI3
MwogICAgRmxhZ3M6IDIgKDB4MDAyKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxNzM3NTk2NzIyICgw
eDY3OTE5ZjMyKQogICAgUG9ydCBJRDogMjk2NTYxNzY3MgogICAgU3RhdHVzOiAwCj4gUlROTDog
TmV3IEFkZHJlc3MgKDB4MTQpIGxlbiA3MiBbbXVsdGldICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA1NS4wNDQyOTYKICAgIEZsYWdzOiAyICgweDAwMikKICAgIFNlcXVlbmNlIG51bWJlcjog
MTczNzU5NjcyMyAoMHg2NzkxOWYzMykKICAgIFBvcnQgSUQ6IDI5NjU2MTc2NzIKICAgIElGQSBG
YW1pbHk6IEFGX0lORVQKICAgIElGQSBQcmVmaXhsZW46IDE2CiAgICBJRkEgSW5kZXg6IDMKICAg
IElGQSBTY29wZTogZ2xvYmFsCiAgICBJRkEgRmxhZ3M6ICgweDgwKSBbcGVybWFuZW50XQogICAg
ICAgIEludGVyZmFjZSBBZGRyZXNzOiAxNjkuMjU0LjY3LjE0MgogICAgICAgIExvY2FsIEFkZHJl
c3M6IDE2OS4yNTQuNjcuMTQyCiAgICAgICAgQnJvYWRjYXN0IEFkZHJlc3M6IDE2OS4yNTQuMjU1
LjI1NQogICAgICAgIExhYmVsIChsZW46Nik6IHdsYW4wCiAgICAgICAgRmxhZ3M6ICgweDgwKSBb
cGVybWFuZW50XQogICAgICAgIENhY2hlSW5mbzoKICAgICAgICAgICAgaWZhX3ByZWZlcmVkOiBp
bmZpbml0ZQogICAgICAgICAgICBpZmFfdmFsaWQ6IGluZmluaXRlCiAgICAgICAgICAgIHRzdGFt
cDogMTg2NTU5MDAsIGNzdGFtcDogMTg2NTU5MDAKPiBSVE5MOiBOZXcgQWRkcmVzcyAoMHgxNCkg
bGVuIDY0IFttdWx0aV0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU1LjA0NDMxOAogICAg
RmxhZ3M6IDIgKDB4MDAyKQogICAgU2VxdWVuY2UgbnVtYmVyOiAxNzM3NTk2NzIzICgweDY3OTE5
ZjMzKQogICAgUG9ydCBJRDogMjk2NTYxNzY3MgogICAgSUZBIEZhbWlseTogQUZfSU5FVDYKICAg
IElGQSBQcmVmaXhsZW46IDY0CiAgICBJRkEgSW5kZXg6IDMKICAgIElGQSBTY29wZTogbGluawog
ICAgSUZBIEZsYWdzOiAoMHg4MCkgW3Blcm1hbmVudF0KICAgICAgICBJbnRlcmZhY2UgQWRkcmVz
czogZmU4MDo6ZGVhNjozMmZmOmZlYjQ6NTBjZgogICAgICAgIENhY2hlSW5mbzoKICAgICAgICAg
ICAgaWZhX3ByZWZlcmVkOiBpbmZpbml0ZQogICAgICAgICAgICBpZmFfdmFsaWQ6IGluZmluaXRl
CiAgICAgICAgICAgIHRzdGFtcDogMTg2NDUxODgsIGNzdGFtcDogMTg2NDUxODgKICAgICAgICBG
bGFnczogKDB4ODApIFtwZXJtYW5lbnRdCiAgICAgICAgUmVzZXJ2ZWQ6IGxlbiAxCj4gUlROTDog
RG9uZSAoMHgwMykgbGVuIDQgW211bHRpXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICA1NS4wNDQzMjcKICAgIEZsYWdzOiAyICgweDAwMikKICAgIFNlcXVlbmNlIG51bWJlcjog
MTczNzU5NjcyMyAoMHg2NzkxOWYzMykKICAgIFBvcnQgSUQ6IDI5NjU2MTc2NzIKICAgIFN0YXR1
czogMAo8IFJUTkw6IE5ldyBSb3V0ZSAoMHgxOCkgbGVuIDM2IFtyZXF1ZXN0LGFjayxleGNsLGNy
ZWF0ZV0gICAgICAgICAgICAgNTUuMDQ0NDQ3CiAgICBGbGFnczogMTU0MSAoMHg2MDUpCiAgICBT
ZXF1ZW5jZSBudW1iZXI6IDE3Mzc1OTY3MjMgKDB4Njc5MTlmMzMpCiAgICBQb3J0IElEOiAwCiAg
ICBSVE0gRmFtaWx5OiBBRl9JTkVUCiAgICBSVE0gRGVzdGluYXRpb24gTGVuOiAwCiAgICBSVE0g
U291cmNlIExlbjogMAogICAgUlRNIFRPUyBGaWVsZDogMAogICAgUlRNIFRhYmxlOiAyNTQKICAg
IFJUTSBQcm90b2NvbDogYm9vdAogICAgUlRNIFNjb3BlOiBnbG9iYWwKICAgIFJUTSBUeXBlOiAx
CiAgICBSVE0gRmxhZ3M6ICgweDAwKQogICAgICAgIEdhdGV3YXk6IDAuMC4wLjAKICAgICAgICBP
dXRwdXQgSW50ZXJmYWNlIEluZGV4OiAzCiAgICAgICAgUHJpb3JpdHkgb2YgdGhlIHJvdXRlOiAt
MzA3Mwo+IFJUTkw6IE5ldyBSb3V0ZSAoMHgxOCkgbGVuIDM2IFtleGNsLGNyZWF0ZV0gICAgICAg
ICAgICAgICAgICAgICAgICAgNTUuMDQ0NDgwCiAgICBGbGFnczogMTUzNiAoMHg2MDApCiAgICBT
ZXF1ZW5jZSBudW1iZXI6IDE3Mzc1OTY3MjMgKDB4Njc5MTlmMzMpCiAgICBQb3J0IElEOiAyOTMy
MjM3NTU3CiAgICBSVE0gRmFtaWx5OiBBRl9JTkVUCiAgICBSVE0gRGVzdGluYXRpb24gTGVuOiAw
CiAgICBSVE0gU291cmNlIExlbjogMAogICAgUlRNIFRPUyBGaWVsZDogMAogICAgUlRNIFRhYmxl
OiAyNTQKICAgIFJUTSBQcm90b2NvbDogYm9vdAogICAgUlRNIFNjb3BlOiBnbG9iYWwKICAgIFJU
TSBUeXBlOiAxCiAgICBSVE0gRmxhZ3M6ICgweDAwKQogICAgICAgIFJvdXRpbmcgVGFibGU6IDI1
NCAoMHgwMDAwMDBmZSkKICAgICAgICBQcmlvcml0eSBvZiB0aGUgcm91dGU6IC0zMDczCiAgICAg
ICAgT3V0cHV0IEludGVyZmFjZSBJbmRleDogMwo+IFJUTkw6IEVycm9yICgweDAyKSBsZW4gMjAg
WzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTUuMDQ0NDg2CiAgICBG
bGFnczogMjU2ICgweDEwMCkKICAgIFNlcXVlbmNlIG51bWJlcjogMTczNzU5NjcyMyAoMHg2Nzkx
OWYzMykKICAgIFBvcnQgSUQ6IDI5MzIyMzc1NTcKICAgIEFDSzogMAo8IFJlcXVlc3Q6IEdldCBT
dGF0aW9uICgweDExKSBsZW4gMjAgW2Fja10gICAgICAgICAgICAgICAgICAgICAgICAgICAgNTgu
MjI1MTk2CiAgICBJbnRlcmZhY2UgSW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVz
cyBEODozQTpERDo2MDpBMzowQwo+IFJlc3VsdDogTmV3IFN0YXRpb24gKDB4MTMpIGxlbiA5MiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTguMjI5MzE3CiAgICBJbnRlcmZhY2Ug
SW5kZXg6IDMgKDB4MDAwMDAwMDMpCiAgICBNQUMgQWRkcmVzcyBEODozQTpERDo2MDpBMzowQwog
ICAgR2VuZXJhdGlvbjogMCAoMHgwMDAwMDAwMCkKICAgIFN0YXRpb24gSW5mbzogbGVuIDYwCiAg
ICAgICAgSW5hY3Rpdml0eSB0aW1lOiA0ODAwMCAoMHgwMDAwYmI4MCkKICAgICAgICBUb3RhbCBS
WCBieXRlczogMCAoMHgwMDAwMDAwMCkKICAgICAgICBUb3RhbCBUWCBieXRlczogMCAoMHgwMDAw
MDAwMCkKICAgICAgICBSWCBwYWNrZXRzOiAwICgweDAwMDAwMDAwKQogICAgICAgIFRYIHBhY2tl
dHM6IDAgKDB4MDAwMDAwMDApCiAgICAgICAgVFggZmFpbGVkOiAwICgweDAwMDAwMDAwKQogICAg
ICAgIFN0YXRpb24gZmxhZ3M6IGxlbiA4CiAgICAgICAgICAgIE1hc2s6IDB4MDAwMDAwZWEKICAg
ICAgICAgICAgICAgIEF1dGhvcml6ZWQKICAgICAgICAgICAgICAgIFdNRQogICAgICAgICAgICAg
ICAgQXV0aGVudGljYXRlZAogICAgICAgICAgICAgICAgVERMUy1QZWVyCiAgICAgICAgICAgICAg
ICBBc3NvY2lhdGVkCiAgICAgICAgICAgIFNldDogMHgwMDAwMDAwMAo+IFJlc3BvbnNlOiBHZXQg
U3RhdGlvbiAoMHgxMSkgbGVuIDQgWzB4MTAwXSAgICAgICAgICAgICAgICAgICAgICAgICAgNTgu
MjI5MzI3CiAgICBTdGF0dXM6IFN1Y2Nlc3MgKDApCg==
--000000000000971ec5062c8a751d
Content-Type: text/plain; charset="US-ASCII"; name="iwd_apipa_journal.txt"
Content-Disposition: attachment; filename="iwd_apipa_journal.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m6cdn2u51>
X-Attachment-Id: f_m6cdn2u51

SmFuIDIyIDE5OjQ0OjM2IFBpNCBjb25ubWFuZFs1MzEwN106IEludGVyZmFjZSB3bGFuMCBbIHdp
ZmkgXSBzdGF0ZSBpcyBhc3NvY2lhdGlvbgpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2
XTogc3JjL25ldHdvcmsuYzpuZXR3b3JrX2Nvbm5lY3QoKQpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3
ZFsyMjU5MDM2XTogc3JjL3dpcGh5LmM6d2lwaHlfc2VsZWN0X2FrbSgpIE5ldHdvcmsgaXMgV1BB
My1QZXJzb25hbC4uLgpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTogZXZlbnQ6IGNv
bm5lY3QtaW5mbywgRnVsbE1BQyBkcml2ZXI6IGJyY21mbWFjIHVzaW5nIFNBRS4gIEV4cGVjdCBF
WFRFUk5BTF9BVVRICkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0d29y
ay5jOm5ldHdvcmtfY29ubmVjdF9wc2soKSBhc2tfcGFzc3BocmFzZTogdHJ1ZQpKYW4gMjIgMTk6
NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL2FnZW50LmM6YWdlbnRfcmVxdWVzdF9wYXNzcGhy
YXNlKCkgYWdlbnQgMHg1NTk2ZGY1ZjkwIG93bmVyIDoxLjE5NjkgcGF0aCAvbmV0L2Nvbm5tYW4v
aXdkX2FnZW50CkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvYWdlbnQuYzph
Z2VudF9zZW5kX25leHRfcmVxdWVzdCgpIHNlbmQgcmVxdWVzdCB0byA6MS4xOTY5IC9uZXQvY29u
bm1hbi9pd2RfYWdlbnQKSmFuIDIyIDE5OjQ0OjM2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9hZ2Vu
dC5jOmFnZW50X3JlY2VpdmVfcmVwbHkoKSBhZ2VudCAweDU1OTZkZjVmOTAgcmVxdWVzdCBpZCAy
NzkKSmFuIDIyIDE5OjQ0OjM2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXR3b3JrLmM6cGFzc3Bo
cmFzZV9jYWxsYmFjaygpIHJlc3VsdCAwCkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZd
OiBzcmMvd2lwaHkuYzp3aXBoeV9zZWxlY3RfYWttKCkgTmV0d29yayBpcyBXUEEzLVBlcnNvbmFs
Li4uCkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29ubmVjdC1pbmZv
LCBGdWxsTUFDIGRyaXZlcjogYnJjbWZtYWMgdXNpbmcgU0FFLiAgRXhwZWN0IEVYVEVSTkFMX0FV
VEgKSmFuIDIyIDE5OjQ0OjM2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9uZXR3b3JrLmM6bmV0d29y
a19nZW5lcmF0ZV9zYWVfcHQoKSBHZW5lcmF0aW5nIFBUIGZvciBHcm91cCAxOQpKYW4gMjIgMTk6
NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldHdvcmsuYzpuZXR3b3JrX2dlbmVyYXRlX3Nh
ZV9wdCgpIEdlbmVyYXRpbmcgUFQgZm9yIEdyb3VwIDIwCkphbiAyMiAxOTo0NDozNiBQaTQgaXdk
WzIyNTkwMzZdOiBzcmMvd2lwaHkuYzp3aXBoeV9zZWxlY3RfYWttKCkgTmV0d29yayBpcyBXUEEz
LVBlcnNvbmFsLi4uCkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29u
bmVjdC1pbmZvLCBGdWxsTUFDIGRyaXZlcjogYnJjbWZtYWMgdXNpbmcgU0FFLiAgRXhwZWN0IEVY
VEVSTkFMX0FVVEgKSmFuIDIyIDE5OjQ0OjM2IFBpNCBpd2RbMjI1OTAzNl06IHNyYy9wbWtzYS5j
OnBta3NhX2NhY2hlX2dldCgpIFJldHVybmluZyBlbnRyeSB3aXRoIFBNS0lEOiBkYzEyMjVlMjg4
OTI3NDUzYjk4NzlhMDFkNDdkN2FmNQpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTog
c3JjL25ldGRldi5jOm5ldGRldl9jb25uZWN0X2NvbW1vbigpIFNraXBwaW5nIFNBRSBieSB1c2lu
ZyBQTUtTQSBjYWNoZQpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTogc3JjL25ldGRl
di5jOm5ldGRldl9jcW1fcnNzaV91cGRhdGUoKQpKYW4gMjIgMTk6NDQ6MzYgUGk0IGl3ZFsyMjU5
MDM2XTogc3JjL3dpcGh5LmM6d2lwaHlfcmFkaW9fd29ya19pbnNlcnQoKSBJbnNlcnRpbmcgd29y
ayBpdGVtIDE1CkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvd2lwaHkuYzp3
aXBoeV9yYWRpb193b3JrX25leHQoKSBTdGFydGluZyB3b3JrIGl0ZW0gMTUKSmFuIDIyIDE5OjQ0
OjM2IFBpNCBpd2RbMjI1OTAzNl06IGV2ZW50OiBjb25uZWN0LWluZm8sIHNzaWQ6IGRlc2tTQUUs
IGJzczogZDg6M2E6ZGQ6NjA6YTM6MGMsIHNpZ25hbDogLTU5LCBsb2FkOiAwLzI1NQpKYW4gMjIg
MTk6NDQ6MzYgUGk0IGl3ZFsyMjU5MDM2XTogZXZlbnQ6IHN0YXRlLCBvbGQ6IGRpc2Nvbm5lY3Rl
ZCwgbmV3OiBjb25uZWN0aW5nCkphbiAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMv
bmV0ZGV2LmM6bmV0ZGV2X2NtZF9zZXRfY3FtX2NiKCkgQ01EX1NFVF9DUU0gbm90IHN1cHBvcnRl
ZCwgZmFsbGluZyBiYWNrIHRvIHBvbGxpbmcKSmFuIDIyIDE5OjQ0OjM2IFBpNCBjb25ubWFuZFs1
MzEwN106IEludGVyZmFjZSB3bGFuMCBbIHdpZmkgXSBzdGF0ZSBpcyBjb25maWd1cmF0aW9uCkph
biAyMiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBzcmMvbmV0ZGV2LmM6bmV0ZGV2X3VuaWNh
c3Rfbm90aWZ5KCkgVW5pY2FzdCBub3RpZmljYXRpb24gRXh0ZXJuYWwgQXV0aCgxMjcpCkphbiAy
MiAxOTo0NDozNiBQaTQgaXdkWzIyNTkwMzZdOiBldmVudDogY29ubmVjdC1pbmZvLCBFeHRlcm5h
bCBBdXRoIHRvIFNTSUQ6IGRlc2tTQUUsIGJzc2lkOiBkODozYTpkZDo2MDphMzowYwpKYW4gMjIg
MTk6NDQ6MzYgUGk0IGtlcm5lbDogaWVlZTgwMjExIHBoeTA6IGJyY21mX2NmZzgwMjExX2V4dGVy
bmFsX2F1dGg6IEV4dGVybmFsIGF1dGhlbnRpY2F0aW9uIGZhaWxlZDogc3RhdHVzPTEKSmFuIDIy
IDE5OjQ1OjIyIFBpNCBjb25ubWFuZFs1MzEwN106IEludGVyZmFjZSB3bGFuMCBbIHdpZmkgXSBz
dGF0ZSBpcyByZWFkeQpKYW4gMjIgMTk6NDU6MjIgUGk0IGNvbm5tYW5kWzUzMTA3XTogd2xhbjAg
e2FkZH0gYWRkcmVzcyAxNjkuMjU0LjY3LjE0Mi8xNiBsYWJlbCB3bGFuMCBmYW1pbHkgMgo=
--000000000000971ec5062c8a751d--

