Return-Path: <linux-wireless+bounces-37835-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x9TPOYItMWphdQUAu9opvQ
	(envelope-from <linux-wireless+bounces-37835-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 13:03:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D068E9A7
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 13:03:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=neat.no header.s=google header.b=gJaQfn4I;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37835-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37835-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=neat.no;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9130D300EDBC
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2026 11:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770893B14B4;
	Tue, 16 Jun 2026 11:02:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACB357CEB
	for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 11:02:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607775; cv=pass; b=Mib9bMYl+73h03HAqGoJAh6aA4nS70KRb6V0ukN9NfTwwLTfr0lBaZFs3nLmE82g0UYiAtqdxFzVnR7g9Lu0Uj8gAKCxodYs27UxtY6ofRLGbB//wwOeQRB2H++JFMDNdpHVPS8gbO5V5FC/an4a3m2XAgQ3QO9BySEX8gWnndU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607775; c=relaxed/simple;
	bh=OrLvHHXHMVdNxZGeEHx1bcMK7vE+UK7oKUg6tIlklAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYZbDlDOQuzi+eoOpjqS8eesOPT9ory6Kg0iGjh6ThxaciFQB+LaBuqb7R0+klzx1Z9/3gyWU9PNhK3zSXriMoIUZGkoHtMqIvn3yDMM5uBvbVF9EOH5DeJBJDupcR0MJfdQCkbkDDAFdZ3+kFwjURFkLpux+OrKzyJ7f1vOHwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=neat.no; spf=pass smtp.mailfrom=neat.no; dkim=pass (2048-bit key) header.d=neat.no header.i=@neat.no header.b=gJaQfn4I; arc=pass smtp.client-ip=209.85.128.180
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e86d46b02dso47422887b3.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2026 04:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781607773; cv=none;
        d=google.com; s=arc-20240605;
        b=RgNcV9sM1E+5eHN8pWXqtpP6rlzmbWV24LW9QiYhUXXiv6qkxO3LWLIMoWWQw4zYp+
         e37dlootOAB/Y7ksNlSMIPRgnPGfZXzNYsZI/PIW19ODnJ87Re6neLlcUevvVQw/C5Ms
         WhgTzv13Noqul8QwJECwpGRTKEYske3gupR4SinlKQ7pVoBIzq0auaxXFUnfDFz/gCZZ
         twStBDEkugnj8F4jtIyz+TSGlcES81g88ApzW+T0QVP6nSndXZMjzsXZV+gHkVxyXCMC
         dKmuz/257tjWuXii6r6O729BtukVwFg17H0a9nLWnMSqdWxhsr8PrdZJLmpFeiErIRV7
         Wy6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xNmo2gR8wG31s1P40S7YqYNXBJAQZzkv61qmrOFWI3Q=;
        fh=m8UTrwGn2am0aW40GdmnuK6YV1PhKEyqkxy5M1gKAdo=;
        b=TetVWsyAWLZMOg4Zq4/mhRvSmJ8HBitcSKuoVoS+2x50R6mA09vZ1Ew1a3mof8TNrz
         /TziVNdQpquVgQPflOmcBXDFPnj19GI8lxOP83jbtkVtdXJXPL0bxDBy6UtmGEcZFkEp
         Jrjl8oT8PDi28D0ep9uNDc9xCrdTXWEqcQesPJgRbpKnM4GyCJMI4TX13jymELUzdy3/
         0iTOJb00Z/LlHNMTtwGM9dGdSCGjPD07v6iT0nJ93Fjvr61ZPRbnKQVW40NIrZOecOfx
         nnmOLRtHtXbK1caVZSXBJ2XtsJ2FQrEvaBoxbrAnvRVzqVUYdpb2RadJCeFUNndi7xjw
         mj1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neat.no; s=google; t=1781607773; x=1782212573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNmo2gR8wG31s1P40S7YqYNXBJAQZzkv61qmrOFWI3Q=;
        b=gJaQfn4IU7lpk/xlN8atreiHbdkfQeNWKZuIMDKVmm9v8KdNQZ3PIt15GhEZkwf1GL
         fe3ayhmvd8AzxqyFlZ1BMy972V52uV1vFJn+urCnlhiUiHKF0yNY7C9a9TpyQFsuC/vm
         AtgFSrt+IljOeaOqK072/uBd0opc6o7MhdRuVrdAcJ++XyyfDzABnn1fAd4sWUyEayTk
         bMkbMnFP5A95cph8uyjBQqLk/JFNUYlQe1HmLN6ElQTeF3AiKaDxbyoIoXV1641zUWXT
         DB0fFYwZzCYwtdwM6nMcv+yN61SjR8Q5RBd67pccn8Kjo4LC5ieqDkwyHYARf+HH7+IN
         QyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781607773; x=1782212573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xNmo2gR8wG31s1P40S7YqYNXBJAQZzkv61qmrOFWI3Q=;
        b=qJJxMBrvD9BSHNxE6LlHXmzvO4A8pZtFKSj90QXukqHB8Ml1qW+IAi7paOrTNdPuqT
         kJcuDO7NkDNH0ZVGcH/axny6HGw5I+QM6fxaeyOFPoyI7F0rIJztC6UZyJcF+kY++uz1
         0WQF3biCNEGEMnRRvBxu4OvxzWUJceq8kV9fekr0QxLueUPeSEmQyJM11Lo/Zn2IXCKK
         VIYWH6C5kMvwvIwIOSc5bUEoLJYBuXZxR3XwL+8jaAYDk5ynzgcF3grDd4pWqhhkxfde
         YiD3jCFEHOJxCc1mWdkK3sT0JvSukn3DvEpkMnWEAp9luUFV/XvuF1zywnbB9yhWuJhR
         lwlg==
X-Gm-Message-State: AOJu0YxtM3exUe/6wXC1z5/uHRHWr5/1bg/OJDYOFBpwL+CKgTh8/ft1
	MDr+WNbR9BOd3HoCkbOTuiSeivB28UNY4aJo8nLkcN5+ngMKOH4kOD9Sd5/0l8KY7I8umsC0lq0
	IXw7P8ZPlOyEgMAPNjVvxB2z58mcBN0v/RdfwkTYK0Q==
X-Gm-Gg: Acq92OFRzy/ZHV4Zqixxk34dtei8G8m69veBY4Kxez5Z1Tcbys21F/rYP0/fAuNaPzt
	JGCmdWvyPhQicmkquImI+u63L4S9DAnUHMYXA/z4DmwQfT3H9Ow/+tqDyWMSGdkBQ+U+hJUJo4B
	WPPCXf0EQo+HDOY6RP/4oeCvweeLqmugd2LF8VPgLK8mEqvBKvyy4zOPpKpxT/xxW8qigFIhG6N
	v4Vt5WLNwbqBDz9T4cxigexUmo8fufppkAtzPmrRyqux38dL5GjibQG4EMWlRoHdofexv5bnPp/
	oYWxnQ==
X-Received: by 2002:a05:690c:9685:b0:7d1:dd7b:b734 with SMTP id
 00721157ae682-7f8c24026ccmr148706137b3.23.1781607772673; Tue, 16 Jun 2026
 04:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALt7t=EDVdn7eGbXgXWU8rgbek52+frbbeYMHwzbH7J0xGXWzg@mail.gmail.com>
 <049000e56f004b4b9d58b74eaed17aef@realtek.com>
In-Reply-To: <049000e56f004b4b9d58b74eaed17aef@realtek.com>
From: Lucas Tanure <lucas.tanure@neat.no>
Date: Tue, 16 Jun 2026 12:02:41 +0100
X-Gm-Features: AVVi8CdT4hm3iJdDbzmHOPrjCyhixE2aQ2lA_SpnNhBSN_4GFULiYudetG8Ts_k
Message-ID: <CALt7t=G_ssGBb1i+knq1_tbcpwi_TcrK+7GBMH3vNLQ3+rcetA@mail.gmail.com>
Subject: Re: wifi: rtw88: 8822cs/bs: Issues migrating RTL8822CS/BS from
 downstream to upstream driver
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Krzysztof Opasiak <krzysztof.opasiak@neat.no>, =?UTF-8?Q?Anders_R=C3=B8nningen?= <anders@neat.no>, 
	Hilda Wu <hildawu@realtek.com>, Max Chou <max.chou@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[neat.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[neat.no:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pkshih@realtek.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzysztof.opasiak@neat.no,m:anders@neat.no,m:hildawu@realtek.com,m:max.chou@realtek.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[lucas.tanure@neat.no,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37835-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucas.tanure@neat.no,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[neat.no:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,realtek.com:email,neat.no:dkim,neat.no:email,neat.no:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 751D068E9A7

Hi Ping-Ke,

On Tue, Jun 16, 2026 at 4:30=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Lucas Tanure <lucas.tanure@neat.no> wrote:
> > Hi Ping-Ke,
> >
> > We are bringing up an RTL8822BS / RTL8822CS combo on a Rockchip PX30
> > board (kernel 6.1.118), Wi-Fi over SDIO, BT on the same die over UART
> > via btrtl + hci_h5.
> >
> > We're deliberately migrating off Realtek's out-of-tree SDIO vendor
> > driver to mainline rtw88: the vendor driver hits memory-corruption
> > bugs we've been unable to get support on, and mainline is the better
> > long-term path.
> > That migration leaves us two gaps I'd appreciate your guidance on:
> >
> > 1) Power-parameter tables. Mainline carries the TX-power data as genera=
ted
> >    C arrays in rtw88xxc_table.c, while the vendor driver ships the same
> >    data as text files.
> >
> >    The TX-power limits look like this (TXPWR_LMT.txt):
> >
> >        ##  2.4G, 20M, 1T, CCK, //(1M;2M;5.5M;11M)
> >        ##  START
> >        ##  #3#  FCC  ETSI  MKK
> >        CH01  16  15  15
> >        CH02  16  15  15
> >        ##  END
>
> The tool from .txt to C arrays for vendor driver is not maintained by my =
team,
> but I think it isn't too hard to use AI tool to convert the format.

If Realtek has an internal .txt -> C conversion tool, could you share it?
Otherwise, could you put us in contact with the team that can verify
our converted tables?

>
> The C array from vendor driver to rtw88 struct is also a simple conversio=
n
> you can use AI to assist this.
>
> If you have traced rtw88, the struct for TX power limit is:
>
> struct rtw_txpwr_lmt_cfg_pair {
>         u8 regd;
>         u8 band;
>         u8 bw;
>         u8 rs;
>         u8 ch;
>         s8 txpwr_lmt;
> };
>
> >
> >    and the power-by-rate like this (PHY_REG_PG.txt):
> >
> >        #[2.4G][A]#
> >        [1Tx] 0xc20  0xffffffff  18 19 19 19  // {11M 5.5M 2M 1M}
> >        [1Tx] 0xc24  0xffffffff  18 18 18 18  // {18M 12M 9M 6M}
>
> TX power by rate is:
>
> struct rtw_phy_pg_cfg_pair {
>         u32 band;
>         u32 rf_path;
>         u32 tx_num;
>         u32 addr;
>         u32 bitmask;
>         u32 data;
> };
>
> >
> >    Is there any way to convert these .TXT files into the C tables? It
> > seems the vendor driver and the mainline driver power configuration
> > don't have anything in common.
>
> The purpose is different. The .TXT is from human point of view to be easi=
er
> to fill calibration data one by one. The design of C arrays is to look up=
 table
> quickly (it isn't so quickly though).

I used Claude, and it converted our vendor TXPWR_LMT.txt /
PHY_REG_PG.txt into the rtw88 C arrays.
Here is exactly how Claude did it - please tell us if any step is wrong.

Row mapping (one TXPWR_LMT.txt line -> rtw_txpwr_lmt_cfg_pair rows):
  header "## 2.4G, 20M, 1T, CCK"  +  "CH01  16  15  15"   (columns FCC ETSI=
 MKK)
    ->  { 0, 0, 0, 0, 1, 64 }    FCC  (regd 0)
        { 2, 0, 0, 0, 1, 60 }    ETSI (regd 2)
        { 1, 0, 0, 0, 1, 60 }    MKK  (regd 1)
  One line -> 3 rows (one per regulatory column). Fields {regd, band,
bw, rs, ch,
  value}: regd FCC/MKK/ETSI =3D 0/1/2; band/bw/rs come from the header;
value =3D dBm*U.

Unit (value =3D real_dBm * U):
  8822c, U=3D4 (max_power_index 0x7f):
      bb_pg 0xc20 =3D 0x484c5054 =3D {18,19,20,21}      (0x48=3D72=3D18*4)
      txpwr_lmt ETSI/CCK/ch1 =3D 60 =3D 15 dBm
  8822b, U=3D2 (max_power_index 0x3f):
      txpwr_lmt FCC/CCK/ch1 =3D 32 =3D 16 dBm
  Both equal our vendor .txt (real dBm), so txpwr_lmt =3D dBm * U and
  bb_pg byte =3D codeword * U (packed high->low).

Is this correct?

>
> >
> > 2) Is there an upstream (linux-firmware) RTL8822BS firmware that
> > supports the UART transport (rtl_bt/rtl8822bs_fw.bin + config), or
> > does the 8822BS firmware still have to come from the vendor BSP?
>
> Currently, no.
>
> >    Is there a problem using vendor firmware (not released at
> > linux-firmware) with the mainline driver?
>
> For BT part, I think it can work. But to work with WiFi, it needs
> BT-coexistence implemented in WiFi driver to support UART BT. Unfortunate=
ly
> current is only partially support UART BT.
>
> Ping-Ke
>
Thanks,
Lucas

