Return-Path: <linux-wireless+bounces-34114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HuqhFPZIyGkrjgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:32:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB5350002
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3234D300A613
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 21:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969B52FFF9D;
	Sat, 28 Mar 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faSikN96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DA24B28
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774733555; cv=pass; b=ZmHHmg34pHUDYIfZrtvB/NpcBqR231yamtOX/iJHv89UopMvYupIWjEIyJLy0ayTIyRBU+xFLRwb7ULaLamUAnpKxYdp9b6d79aEfOb+rKtXX2BgaDt/pQZ1GESCm2G5B15K/7mO76/1TbELkc16ztNZ/rfZob+dey0QZdd1Z1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774733555; c=relaxed/simple;
	bh=rKgnYdjzapKYUtsIHl/qS2UmulAJctVszwvkkFPz1+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG6sUIOYRSJCtQgA6+s5OJ7ehdprj/NFStqupXFDQ5nwfTF/ikAdKOYxfqTKnEvJ4UNQ3bNbpRhvp9L9AuAhm2rF/9EKUw/YbiufXvw8XVL6oCGtkjCdqvj5kIwuare3xJlCo6FMOeFaeEpF1/xM69P/H5HvuVAjU+EMYiIMYfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faSikN96; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d7e565c877so1669538a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 14:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774733553; cv=none;
        d=google.com; s=arc-20240605;
        b=bpmwMDaYjXm5reWri55uZaBo9gaPcwq0I7CSg5PrWNGpmdXu7WIo6LXP01ElTQ0AlR
         qgOkDF3VQhr4TBp9cW38L8Zjm2pz3BjKbEbLBJoKwnpvfNdIP7CTaHWBga9/cpjy/Zjg
         dLsDwDwVOCgQbXJ5YL1evxlrItENmEEn4WAsLwWGjiSPpMC/MJOjQaRGt0pbEyVxqJST
         uAcgFNsk2dtH1lDpwViEkaYHYzl9861dXQ0ta5EUOYTQ0nKX0OnJ+G+iizaLfanKBGKF
         1I8oWJ/tTeZdf+YHZcVrMqBmX2A4wGLdgchixK8fKNA9m59TNsOBR6/W9LhCLDMVr0cX
         Kzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9E3k6mAWw+rQpjEj7ftshAWAEa0ac5Hij5BzYF/+FYc=;
        fh=fJodyBTryugGq7GWe0dR8kyE376BY8PeJdGlJ86tajA=;
        b=R/iKulggV4RGhim0cs1HLuQUSkzzLEppJSHEqb6oUk64ZXHsMT2W3Y66L/XSABa69/
         vhd7YU0ckeDeafDCyZWJ1+qZpLRNadhtZI9eA3c5BqBbjozItKprM1LxjGt0fNJFI3EC
         m27BsQkKWXPN/hmcNgIkh9DmBKeQXSlmU2YCXnePxWV5/1rBEEiPaZhtJgksExDLOQP4
         jXkHBjy9FqZfTO9IHFVFs53oGix/6cqco2zsFDsrTQnGofJZyBk3Dp+ufJ+fFR1W4VbU
         dDOfTw7FpvOpcgc1h8s4Dv56lXdVLh7MEkVl0hOwvR3Dx81lVL+Ge+cYRwkjFZLcqXxT
         rqtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774733553; x=1775338353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E3k6mAWw+rQpjEj7ftshAWAEa0ac5Hij5BzYF/+FYc=;
        b=faSikN961QBaIJF0rWMPKjveamX/fUHB05JUXYiLJBt/dHzZdRv6pmCvx8l2O7DKdz
         IdV5TzKncnnGW35qz94q8uCtW6jcWJImt3MSXaIJPI8b+XEgDP7FDRPqsrlT4PLEHoff
         Kvze44BgFhv44W29RUaF/kpfSnuzGXOU/slsE+KfKPk+f2uv1FDN3FUxjOT9PXEc71H3
         PLG+ArTogpywynFFUJQ+GvqZAHgKPaf13wlXkQXkGRW2YDUBqhcn7unYiqlsFUeOy5u6
         Z3USDlPTMvbar3mthnb5S1mDs6/3hu0CxlifbVhpIeGE+KpivkGRpDFdo0IlOmoUpBKe
         i2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774733553; x=1775338353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9E3k6mAWw+rQpjEj7ftshAWAEa0ac5Hij5BzYF/+FYc=;
        b=gt4Z+64/prb95n815xPH6AhzhF8jElSgARBnL+OvSMIjo+k2EA2s4vqtL+8lI41b/m
         oPHFlNZ4IdYr/H25SrTfXQGAIv096hgKIq7DClGO2jthDPw6OvziQVgBmvlEgSZSPgux
         8/cb2iY0Uuj+pKH+fJcTIO/kJj53/2FBnxX60iaQBwxtGeZkp9ADhyL5Y2V/scJzK5oK
         oWnRTNBp9Cf2l1UewK0eFTIBd7D4zQ131MdllTP2Fo3hRzVGUFCh3yqoriRv5qzrfU+F
         U2NusjaCBNW93B0OqN4fS14jz9bHlQhbyjMkgjQjanSoE4m45MwZZy2Fw7th3iuUejFe
         B/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCV7GP1+a8tmFjwv2+dBFN2So3AH5neMsAlnvPRN0HmKUMf6r/Apg+e+le/IcJHPsF/HGir1mabYHpnVRJXq0g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hlffsNSddSMhubxb/ItdKaRGqPCRPhOdJxeR/52kkQzdjKjc
	HBoUsRwdGpruVRJAxa8SiNMuYhUC/nNhUoNwWc0m6yHRx8pxS9zoFXL/77UXz5bOItgP4AigRom
	ak21hfko8YPLKDzPwnw9f90dXYut4Sng=
X-Gm-Gg: ATEYQzy0p5zMyrlNbFwdU4w5m7EYMvzw1vehumcIsLpzIvFCESoHu3mhf1grfxheMpX
	3LsQRHPn/1fpuR/SfHTKU5unGjmiTgvtbZ1pDC45TcUposEan6qkySN4UhRCqevBXF+7KsJoKe0
	9DTeOQtpbffzvuMiFPWoBZ3lMmerjdQqGgayAdikaN/pzLaMDLHX+0vvB3iDLGDIqGDU+WH/eRF
	xtvgruUQacz//7sgq1ejHarzdM1NGrpsycG3Qik1aHkHL329pRbHb+7+1+UsNGOoC7u4x9iEpcK
	ALN8QG1a
X-Received: by 2002:a05:6808:50a1:b0:455:bebf:af41 with SMTP id
 5614622812f47-46a8a5e01d9mr3819667b6e.52.1774733553064; Sat, 28 Mar 2026
 14:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALdGYqSQ1Ko2TTBhUizMu_FvLMUAuQfFrVwS10n_C-LSQJQQkQ@mail.gmail.com>
 <CALdGYqQ3tS_aQpmf7xLkaCG9W55ATQXP=tnRNdjBAG8waqg8yA@mail.gmail.com>
 <dbe78a09fafe4a0ab16cd691049896a8@realtek.com> <CALdGYqQ3JQgFvvjiqh-ck8UqUQpAoJ0zeUzEL4i4Un8qPmqxJA@mail.gmail.com>
 <CALdGYqQuS5EOWCaeimr6PY758feF-DPo5i3XFwoQ8ewf4xnm7A@mail.gmail.com>
 <b231d63665334ac786e808610fe4a1e9@realtek.com> <CALdGYqSd61wxNrPDui+m-S+Na_is-RM18-=L6xm-Jf4QQ+-DOg@mail.gmail.com>
 <a8e187e1b40e4a35bbeb3bc3a3d21821@realtek.com> <CALdGYqRPcDRctCpNSJFatXvqMKLFiiRGXZoQa3KJwfwutHJEwA@mail.gmail.com>
 <ba9790526e4e42c386642a05fcbc2f34@realtek.com> <CALdGYqQ5U2USCqVEixoDda1Xd2ugBakh1K1QkaKAU7HPSTTNWg@mail.gmail.com>
 <CALdGYqQ_RCOwa2J-GsEyCxCQ4bztyxSzbc+6eYNesBSaY3Nt-w@mail.gmail.com>
 <da30a61b-dad0-48ff-a283-3dd8e9bdf91d@gmail.com> <CALdGYqS53=MmG4yCLwgV+RJAZ=U8Aqi8QQZFZ5oFMernhSyxTg@mail.gmail.com>
 <5eb90d6d-e590-4c9e-91c8-1ba315f45304@gmail.com> <CALdGYqRkX8=XMOePeauxvSTDZFLEYyJZKCtoxCzqaNwdO6BNnw@mail.gmail.com>
 <a5ea6373-8c07-4fcd-95fc-d87ce6aef6d5@gmail.com> <CALdGYqTjSpAjPR7akMowhkQKVJsZmr4G47g6s+y4guFRMpYS2Q@mail.gmail.com>
In-Reply-To: <CALdGYqTjSpAjPR7akMowhkQKVJsZmr4G47g6s+y4guFRMpYS2Q@mail.gmail.com>
From: LB F <goainwo@gmail.com>
Date: Sat, 28 Mar 2026 23:31:56 +0200
X-Gm-Features: AQROBzBS2CB7Z3raa_AbgKprYArKFZPzTiX-rJ9QoVa0ThXCOQ_iBGqdBNUt7nI
Message-ID: <CALdGYqSC3WXLCKGSmRh4g9SJkegZN4qGvpiVMBK_U+qRqpE8og@mail.gmail.com>
Subject: Re: [BUG] wifi: rtw88: Hard system freeze on RTL8821CE when
 power_save is enabled (LPS/ASPM conflict)
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34114-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[goainwo@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CCB5350002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following up on the corrected patch =E2=80=94 I tried to trace the RX path
myself to understand the full picture. I am not a developer
and may be misreading the code, so please take this with a grain
of salt. But I thought some of these observations might be useful.

---

Tracing the RX path from DMA to crash
--------------------------------------

In rtw_pci_rx_napi() (pci.c), each frame from the DMA ring is
processed like this:

  1. rtw_pci_dma_check()           =E2=80=94 compares rx_tag, but only
                                     warns on mismatch, does not
                                     skip the frame (pci.c:696)

  2. dma_sync_single_for_cpu()     =E2=80=94 syncs 11478 bytes
                                     (RTK_PCI_RX_BUF_SIZE) from
                                     device to CPU

  3. rtw_rx_query_rx_desc()        =E2=80=94 parses all RX descriptor
                                     fields from W0..W5 with no
                                     validation (rx.c:305-325):

       pkt_len      =3D W0[13:0]     range 0..16383
       drv_info_sz  =3D W0[19:16]    range 0..15, then *8 =3D 0..120
       shift        =3D W0[25:24]    range 0..3
       physt        =3D W0[26]       0 or 1
       is_c2h       =3D W2[28]       0 or 1

     None of these fields are checked against expected values.

  4. pkt_offset =3D 24 + drv_info_sz + shift
     With garbage, this can be up to 24 + 120 + 3 =3D 147.

  5. new_len =3D pkt_len + pkt_offset      (pci.c:1088)
     With garbage, this can be up to 16383 + 147 =3D 16530,
     which exceeds RTK_PCI_RX_BUF_SIZE (11478).
     skb_put_data() then copies new_len bytes from the DMA
     buffer =E2=80=94 potentially reading past the end.

  6. If is_c2h =3D=3D 1 (from garbage W2 bit 28), the frame goes
     to rtw_fw_c2h_cmd_rx_irqsafe() (pci.c:1096-1097).

In rtw_fw_c2h_cmd_rx_irqsafe() (fw.c:351):

  7. c2h =3D skb->data + pkt_offset
     c2h->id is simply read from that offset =E2=80=94 a random byte
     from garbage data. No validation against known C2H IDs.

  8. If c2h->id is not C2H_BT_MP_INFO, C2H_WLAN_RFON, or
     C2H_SCAN_RESULT, the skb goes to c2h_queue for deferred
     processing via the default case (fw.c:377-381).

In rtw_c2h_work() -> rtw_fw_c2h_cmd_handle() (fw.c:302):

  9. mutex_lock(&rtwdev->mutex)
     c2h->id is matched against the switch cases.
     If it happens to be 0x37 (C2H_ADAPTIVITY):
       rtw_fw_adaptivity_result() dereferences
       rtwdev->chip->edcca_th, which is NULL for RTL8821C.
       Kernel oops. Mutex never unlocked.

So the crash is probabilistic =E2=80=94 it requires a garbage frame
where W2 bit 28 is 1 (is_c2h) AND the byte at pkt_offset
happens to be 0x37. This explains why not every burst of
corrupted frames results in a crash.

---

Concrete example with a captured dump
--------------------------------------

Taking the "page 2" dump with MAC addresses:

  00000000: 88 55 51 95 d1 66 ad 50 2f 25 3f 89 ae 35 ef 77

  W0 (bytes 0-3, little-endian) =3D 0x95515588
    pkt_len      =3D 0x588      =3D 1416
    drv_info_sz  =3D 0x5        -> *8 =3D 40
    shift        =3D 1
    physt        =3D 1

  W2 (bytes 8-11, little-endian) =3D 0x893f252f
    is_c2h =3D bit 28 =3D (0x893f252f >> 28) =3D 0x8 -> bit 0 =3D 0
    (In this particular frame is_c2h =3D 0, so no C2H path.)

  But drv_info_sz =3D 5 (should be 0 or 4 per your observation),
  confirming the frame is corrupted.

---

pci bus timeout
---------------

I checked all our saved logs across 29 boots and 41 resume
cycles: zero "pci bus timeout" messages anywhere. This means
rtw_pci_dma_check() never detects a rx_tag mismatch =E2=80=94 the
buffer descriptor passes validation, but the buffer content
is corrupted. So the corruption seems to happen at a level
that rx_tag does not catch.

---

I also noticed that new_len is not bounds-checked against
RTK_PCI_RX_BUF_SIZE before the skb_put_data() copy
(pci.c:1088-1094), which might be worth looking at
independently of this bug.

Again, I'm sure you will see things I've missed. Happy to
test anything.

Best regards,
Oleksandr Havrylov

