Return-Path: <linux-wireless+bounces-25085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722C8AFE425
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3CB77A710D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B872857C2;
	Wed,  9 Jul 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtTYfJSm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619191D5150;
	Wed,  9 Jul 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053696; cv=none; b=YPUm4Fy180Mduh+rPDiKCJMyQlF33y5J5tiaqBovvhud1aGmZE9OyYoLrKtubFf1IJQycu14J2IVVM+I+CK7u8A4M/hqJfHiRV5wlA9q6KV59ljT+MUtY+kaxEmHYIvYAnDu0LW5gGcseYLf99S65qTDinklmiGg4gTCLXV3DAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053696; c=relaxed/simple;
	bh=r3uGUCdL6VdjxNHNtjRfySw9ECmoX3D9N3rOm6BkdHs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NEyCZSIhpkeHcRCS3InnY8CWwIGWpUHkMbRVA9OpBb2Ke/azzzdc/y0GFjsfxRbThznS+ga7gbrRHhROc+q96MjAjAcLz8o7rdNxnh9odqiquRt+2WiYxi89y2eJzboEZ3wPIVClqt3+4QRc/jbXbNbuhZHOZ3BwIq/1spEQF+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtTYfJSm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453749aef9eso19414645e9.3;
        Wed, 09 Jul 2025 02:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752053693; x=1752658493; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3uGUCdL6VdjxNHNtjRfySw9ECmoX3D9N3rOm6BkdHs=;
        b=UtTYfJSmyMrC7SkcO8TpZ4IEL42G/JSbmiLV/mGJ7OgvYjSE8S0Tb4PuMVfz8H7d9z
         ZQEKd9EJufREqIHwtp356jyL+zUnyCU4n1CcWTOIx1rUmLSt19oRlMgvRwYPyiIPog7j
         sOj52LmuyVA64ypRMAbgDIuBNy4MQtJp5L8kikZHDtaZ+sxI2FxuJtWDVGATwiwmKLHg
         FCydDhM/FJqJUajPfutpenmvpelEPpHJP0uPXuI8qsE5c6xlNwO2p+gJn11by1a6TXy+
         2c/cOkOjpTqclVt5NCJ525qsZeReuyIQzRqnduOZ74AJJAvedO0ubRLqwgjSFFeQ8WSb
         gGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053693; x=1752658493;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3uGUCdL6VdjxNHNtjRfySw9ECmoX3D9N3rOm6BkdHs=;
        b=JU3MQRbY+ie0LHMRNQp7eewdj8hK7GIuyQ7xa/OPwKlctu4aTDA8FC0LXE5+iZstt3
         4brGhlcVVeAaQ2+YwobwDMOZoDySSA7/iB0ysg+Ymv7YYgJvB8bZWsofYFq/cqbBWZcL
         OQs+Cbgy01ptFoDGHIHw9I6uUjhPXE5weVPEVLrqMZJ8K2pDPmupogfu5TwllUEOPa5n
         HY/UUvLUc/urYcaMRLEhciK8vCyveVUvxheDeoe1HtqJnhqQxy0SXWI3X82qEKS52pCd
         r2PxBFY1fuqgfYARQAqO/3HcVIFAfIX48BmvF/IYk1BVYWN4jtwzvR8gZRlUZG7wdN54
         m8lA==
X-Forwarded-Encrypted: i=1; AJvYcCXAYpV3MgBrHhlwv0eUCWpSfBNdFW/fMiX+SHEB4JEewlX6Zws5Sy/mik9ZjfITnrUg9JYGtpQ2tJDWfLU=@vger.kernel.org, AJvYcCXJhm71HTHLh1FiEzIVe5AjGc2G9jaZ2cmol79ZKi63OUHjwMgEoNaZ0PWHSh2aiQZ1D4mJlD7I@vger.kernel.org, AJvYcCXxjmX+GWnAuOSLm4jq5M0SOrJrxR7T42USw/B7OLRGNjq5p1L4YpJxLZ0ZZKvCR2+DnRp3zwfmKDuf4k41BxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLINVy7Nu0RtUrhbNo0HwMheG4NgA+fhl5zcqZCoVDf+6vAyZF
	bAvvUpPQCSL4xLHndKjZDwuXtzRJV5YCOlOz1z7VfymbcMdFmpZlN1Bj
X-Gm-Gg: ASbGncu5VtRBm9J2mJULu8vsvyRuIOrv7ilguzUvZqREX0pt5YRmgTCe4lb6SJXtwtb
	mZ/iEab7a+sKSLYAbDS13d4FNKcU8LL+qAzj+OEMS18h0b891Nad+9JP8YvRUvcVfpscujt1kTn
	FC1pO78ShzbIL/fGHAesEe+66+9dLWsFie3CVHqvF88kkoKCfQnL2SVXTAkUIdnT/LocCpliViy
	RdYd1Ow6cuS9kyXwD94T/WncNf7mtX0yOpKPMTKpIADaWpYDiiiUFZjxYfY4J1b4WNtUTxjJjy1
	vmuQK6wbXnC/CTsm8/fT4+yo09cHfpFYgOVPRPNz4xvdfXbfGQ9btlWBIush7YdInMBo5QM3DcK
	af5cZjks=
X-Google-Smtp-Source: AGHT+IHFE/4lz+pXT1J2vuAB2sISwkp+K6S5gulkD0S/u+uitE+iDpKG56hey3SX5ivqJSrzP0P1RA==
X-Received: by 2002:a05:600c:4f11:b0:43d:9d5:474d with SMTP id 5b1f17b1804b1-454d522d0d0mr17241865e9.0.1752053692156;
        Wed, 09 Jul 2025 02:34:52 -0700 (PDT)
Received: from vitor-nb.Home (bl21-87-120.dsl.telepac.pt. [2.82.87.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d508e9d7sm16621975e9.36.2025.07.09.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 02:34:51 -0700 (PDT)
Message-ID: <d6fc989334064cf9fe50185e7ecd20a5f614c312.camel@gmail.com>
Subject: Re: [PATCH wireless v1] wifi: mwifiex: discard erroneous disassoc
 frames on STA interface
From: Vitor Soares <ivitro@gmail.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Vitor Soares
	 <vitor.soares@toradex.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
	stable@vger.kernel.org
Date: Wed, 09 Jul 2025 10:34:50 +0100
In-Reply-To: <aG1lbC4LJDKzMuco@google.com>
References: <20250701142643.658990-1-ivitro@gmail.com>
	 <aG1lbC4LJDKzMuco@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 11:37 -0700, Brian Norris wrote:
> Hi Vitor,
>=20
> On Tue, Jul 01, 2025 at 03:26:43PM +0100, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When operating in concurrent STA/AP mode with host MLME enabled,
> > the firmware incorrectly sends disassociation frames to the STA
> > interface when clients disconnect from the AP interface.
> > This causes kernel warnings as the STA interface processes
> > disconnect events that don't apply to it:
> >=20
> > [ 1303.240540] WARNING: CPU: 0 PID: 513 at net/wireless/mlme.c:141
> > cfg80211_process_disassoc+0x78/0xec [cfg80211]
> > [ 1303.250861] Modules linked in: 8021q garp stp mrp llc rfcomm bnep
> > btnxpuart nls_iso8859_1 nls_cp437 onboard_us
> > [ 1303.327651] CPU: 0 UID: 0 PID: 513 Comm: kworker/u9:2 Not tainted 6.=
16.0-
> > rc1+ #3 PREEMPT
> > [ 1303.335937] Hardware name: Toradex Verdin AM62 WB on Verdin Developm=
ent
> > Board (DT)
> > [ 1303.343588] Workqueue: MWIFIEX_RX_WORK_QUEUE mwifiex_rx_work_queue
> > [mwifiex]
> > [ 1303.350856] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D-
> > -)
> > [ 1303.357904] pc : cfg80211_process_disassoc+0x78/0xec [cfg80211]
> > [ 1303.364065] lr : cfg80211_process_disassoc+0x70/0xec [cfg80211]
> > [ 1303.370221] sp : ffff800083053be0
> > [ 1303.373590] x29: ffff800083053be0 x28: 0000000000000000 x27:
> > 0000000000000000
> > [ 1303.380855] x26: 0000000000000000 x25: 00000000ffffffff x24:
> > ffff000002c5b8ae
> > [ 1303.388120] x23: ffff000002c5b884 x22: 0000000000000001 x21:
> > 0000000000000008
> > [ 1303.395382] x20: ffff000002c5b8ae x19: ffff0000064dd408 x18:
> > 0000000000000006
> > [ 1303.402646] x17: 3a36333a61623a30 x16: 32206d6f72662063 x15:
> > ffff800080bfe048
> > [ 1303.409910] x14: ffff000003625300 x13: 0000000000000001 x12:
> > 0000000000000000
> > [ 1303.417173] x11: 0000000000000002 x10: ffff000003958600 x9 :
> > ffff000003625300
> > [ 1303.424434] x8 : ffff00003fd9ef40 x7 : ffff0000039fc280 x6 :
> > 0000000000000002
> > [ 1303.431695] x5 : ffff0000038976d4 x4 : 0000000000000000 x3 :
> > 0000000000003186
> > [ 1303.438956] x2 : 000000004836ba20 x1 : 0000000000006986 x0 :
> > 00000000d00479de
> > [ 1303.446221] Call trace:
> > [ 1303.448722]=C2=A0 cfg80211_process_disassoc+0x78/0xec [cfg80211] (P)
> > [ 1303.454894]=C2=A0 cfg80211_rx_mlme_mgmt+0x64/0xf8 [cfg80211]
> > [ 1303.460362]=C2=A0 mwifiex_process_mgmt_packet+0x1ec/0x460 [mwifiex]
> > [ 1303.466380]=C2=A0 mwifiex_process_sta_rx_packet+0x1bc/0x2a0 [mwifiex=
]
> > [ 1303.472573]=C2=A0 mwifiex_handle_rx_packet+0xb4/0x13c [mwifiex]
> > [ 1303.478243]=C2=A0 mwifiex_rx_work_queue+0x158/0x198 [mwifiex]
> > [ 1303.483734]=C2=A0 process_one_work+0x14c/0x28c
> > [ 1303.487845]=C2=A0 worker_thread+0x2cc/0x3d4
> > [ 1303.491680]=C2=A0 kthread+0x12c/0x208
> > [ 1303.495014]=C2=A0 ret_from_fork+0x10/0x20
> >=20
> > Add validation in the STA receive path to verify that disassoc/deauth
> > frames originate from the connected AP. Frames that fail this check
> > are discarded early, preventing them from reaching the MLME layer and
> > triggering WARN_ON().
> >=20
> > This filtering logic is similar with that used in the
> > ieee80211_rx_mgmt_disassoc() function in mac80211, which drops
> > disassoc frames that don't match the current BSSID
> > (!ether_addr_equal(mgmt->bssid, sdata->vif.cfg.ap_addr)), ensuring
> > only relevant frames are processed.
> >=20
> > Tested on:
> > - 8997 with FW 16.68.1.p197
> >=20
> > Fixes: 36995892c271 ("wifi: mwifiex: add host mlme for client mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > =C2=A0drivers/net/wireless/marvell/mwifiex/util.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/wireless/marvell/mwifiex/util.c
> > b/drivers/net/wireless/marvell/mwifiex/util.c
> > index 4c5b1de0e936..6882e90e90b2 100644
> > --- a/drivers/net/wireless/marvell/mwifiex/util.c
> > +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> > @@ -459,7 +459,9 @@ mwifiex_process_mgmt_packet(struct mwifiex_private
> > *priv,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "auth: r=
eceive authentication from
> > %pM\n",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ieee_hdr=
->addr3);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
>=20
> How about the other leg of this 'else' (ieee80211_is_auth())? Is it
> possible for these spurious frames to accidentally look like our AUTH
> frames?

I haven't seen spurious frames matching the AUTH path so far. Also, if ther=
e's
no pending authentication on the STA, those frames should be already ignore=
d.

>=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!p=
riv->wdev.connected)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!p=
riv->wdev.connected ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 !ether_addr_equal(ieee_hdr->addr3,
>=20
> "addr3" doesn't make it totally obvious to me what this actually means,
> nor that it's correct. Would ieee80211_get_SA(ieee_hdr) be equivalent?
> That seems a bit more descriptive. Or else maybe a short comment (e.g.,
> "ignore spurious management frames from other BSSIDs").

In this case, ieee80211_get_SA() wouldn't be equivalent and as far as I kno=
w,
there isn't a helper like ieee80211_get_SA() available.
This is an IBSS/Ad-hoc frame (To DS =3D 0, From DS =3D 0), so addr3 contain=
s the
BSSID, which is what we need to match against (same as
ieee80211_rx_mgmt_disassoc()).

Since the patch was already merged, if you think a clarifying comment would
still be valuable, I can send a follow-up patch to add it.

>=20
> It seems like it's correct, because this block already filters for
> specific frame types (auth, deauth, disassoc), but in isolation, it's
> not the most readable.
>=20

Yes, I agree with you.

thanks,
Vitor

> Brian
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv-
> > >curr_bss_params.bss_descriptor.mac_address))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
> > --=20
> > 2.34.1
> >=20


