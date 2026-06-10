Return-Path: <linux-wireless+bounces-37612-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qFXDNv3yKGpgOAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37612-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 07:15:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC6665E64
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 07:15:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HaoovKiQ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37612-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37612-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6CD9301CA5A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 05:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194A9370D5C;
	Wed, 10 Jun 2026 05:13:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE2430B51D
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 05:13:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068425; cv=pass; b=XMDbkDmKXX9mSM70x2D+3XZD6uMZksDsxQ7BQZyiLC0HynUv/ZvOz/AWSZOwH5qR8wc0i5KcmpcNs09abYfAwPvxx5KDNEgR0xq4cuXrj0S7NQ1xaY9BHS5ntkjvoF3wBVOFQ5toLHMCDBNNLojPsg8UX/FuZHfD43TQjqbjRd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068425; c=relaxed/simple;
	bh=Odu9JugjOjKNbz8s+BpBeIpnBJoj8yi8+/FD8YsX2Zk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SF8m8khzu2G216Bu9h0DKiyIg2o89tHrsZMpOH3x0ln2Y7kq18er47cnkL8h0qFAyFASQ6q6uJBh6qi/t+pJ2J+DuNmGWdSvt+7jcymZg0ievv8hjaziHdWy+OeC1R+Z5f7XAIYmzUV06Ir2IwA35Cg/fqwpXpM7ulOoQ3zo7qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HaoovKiQ; arc=pass smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee6d32402so3544979f8f.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 22:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781068422; cv=none;
        d=google.com; s=arc-20240605;
        b=hBOGF99yzpWMEwsDQVzLaPE2YIuL2SIqSi0vrx0noZhZE9Qu959Iqty6D7CRxo+PE7
         F9v1BKvV0QpoRLe4sT8aRU2JWcgdrJKF3EhAIoUWD2Qjoh3iyjwvhIiUO7nO7TNCxVR8
         SWFwLNqCfHEEEHT1JlsB8rBZgA9/1W1C1YUIHyRL//WdvS6HMh9WQywX6ihr4zQgECPQ
         uNvwuyhk7PgQs3OrBDgmiVJpJ/02rnSRC9ixycd/1zGrVe98FBNiyERZjC2Bo6p0JVV2
         ZsWBnWb30xCcy6S+C0fqPB/UCe6riDpm131FMLWpetrVBc9Ve9bsnNd+HELrVwGj4tJ6
         eqkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Odu9JugjOjKNbz8s+BpBeIpnBJoj8yi8+/FD8YsX2Zk=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=EQYcubfEkBxi7G0yB6/lyFXZeN1Jg9mPQjhkb4jOoYXxgmndKmUxAgRrXcLsDsh2LY
         r5KPx3BcxzwSO7Poc2CaEv30AkF2DAX45F8pWjuj22Q6dsBNlt04oTSk8b47THbB/RcR
         aaDezDk5hAw6TV9feWmjbDOfpyWibBFD7Fz2/mpLeZRW7g3GBAyATA5kzzE69ZXKIxJk
         f7YpWUtT69oDvyuMDWI/wpBV3OmH21fH4kgL2ninjkpyPbuEhtPR3x9or7An5QY4JqCE
         76T3dby8E+j3fqhjWbkEVCLwryDRpmSf0DCzXJnckV2V5pIPhDGMNkHFlgaJpfu7QB0w
         s0lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781068422; x=1781673222; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Odu9JugjOjKNbz8s+BpBeIpnBJoj8yi8+/FD8YsX2Zk=;
        b=HaoovKiQhQGjxQP7XSerl+1KKAmUOFvdqCCKKnRBmSORg9hv8YhumPQBn/ihshMqGC
         2w23mAqWbpEUi4G5AAyb9AyAPDtaoAlddscM5oChK+KNkchlYyZY/RnZyqzcKDLJpkBp
         64XuDemyvP2CWFQejT6V0sPIlKgaGgZbZXuB+2VLUGBGJUNf3+bo0IjXscq24OzYBwxf
         I16JI3f5W8d4bl5jmfd6++0O7ZB+ckTEk3RiEaeeuV5tS1fRn9f+KcVbcqRG3QN2mAvp
         owBf/HI0kOkh+nr9mWQYsBIXl4FkdwrDYjMUxSBUA+DqIxlbSofz3i9+0x5mCejqZeAU
         M52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781068422; x=1781673222;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Odu9JugjOjKNbz8s+BpBeIpnBJoj8yi8+/FD8YsX2Zk=;
        b=EVjufoAy2akdwfi9EfGm4+9VEFXYKVpN5pJjR4No1fdq351eyg5qsDdXrakVixJlw+
         ZIMmTL5OnOoEQbHbNvgmw23dwgX287jBFTvCC3cy8wQEpZTqxEDnEUC4PTmPsq7qJIQV
         sNtlE0QNKBo5YyyBzzQJKtHLzV6onEQ8ymKMxmmn8OYcSORJ0OHVOesSCsy+HGoyb1b6
         NrH3xA389ISaPrC6lWYnxtBiArNX16FvfwUriQ2QB5KZ1mRLkiFu099TmgUO1VNl+/qP
         A1RHDneJfB7bVUQG82K9FIidwP8dyJJP0NgLjqg+cd/SIgAPf57kZ0fg7DtdYDbhvs9L
         lD5g==
X-Gm-Message-State: AOJu0Yx6PrcT+k2VYBQsrybxbGtHzPz0e3dR5XVsxiHjCyDjj/UrH9v5
	SmAwvYpq+nsLhejJCek45h5wjfAEmO1wgQtBaN1ky0n6DbQ6Wn7hxtAkVUO8YuwPzcFcuEy5smg
	RyVfanvS9r0ctxebylZApZYk6mDgOWnvbYezPtPk=
X-Gm-Gg: Acq92OEXENonIHvSL7WSE6vfANfHgTyQDUbiE+fucJVlkgokoFbKebjicT9rz4ou+hl
	JZndDC5foko2fAGmv6hzJ/FLogFERYNgr9mIAN9GsyXOlXxjB4E6/m/vw+1I6+9ceptDFOCywKY
	3rC0cghtpBuKXabYLXQKg6FusJcKCbDTO0mWhaOKkkiu9woKNIpCK2lkLko4akvC6EpV1UCVtL9
	jrTBwj1eQ2pqOg0BxdH/aYjrIO94PMS+xTVqTn/m1PvOK/TSegBoU29sPC8OWyGICKddmPA19xq
	71Eaou7P8Fm8eUr5iQ==
X-Received: by 2002:adf:ec02:0:b0:45e:b99d:dad with SMTP id
 ffacd0b85a97d-46030766f1amr25128188f8f.38.1781068421516; Tue, 09 Jun 2026
 22:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JLQu9Cw0LTQuNC80LjRgCDQn9Cw0L3RgtC10LvQtdC10LI=?= <vovik181083@gmail.com>
Date: Wed, 10 Jun 2026 10:13:30 +0500
X-Gm-Features: AVVi8CdRTZSH2fTzIyiCsiN4j8uml9lzroG3TjzY3_dCgRvQadi5UbfDMUp9v3I
Message-ID: <CAN6W26t_nEmWCyk-Mzp-1iHZ0P7HdV4VtSB51Bkn-JKFQkeuWw@mail.gmail.com>
Subject: wlwifi: Aggressive LAR forces country 00 and disables 6GHz band on
 Intel chips
To: linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000095f3a60653df4e9f"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37612-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+];
	FORGED_SENDER(0.00)[vovik181083@gmail.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vovik181083@gmail.com,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34DC6665E64

--00000000000095f3a60653df4e9f
Content-Type: multipart/alternative; boundary="00000000000095f3a40653df4e9d"

--00000000000095f3a40653df4e9d
Content-Type: text/plain; charset="UTF-8"

Bug Report: Intel iwlwifi 6GHz (Wi-Fi 6E/7) regression under Linux (LAR &
Aggressive Powersave issue)

Environment:
- OS: Arch Linux (Kernel 6.x / rolling)
- Wireless Card: Intel Wi-Fi 6E/7 (iwlwifi driver)
- Wireless Backend: NetworkManager with default wpa_supplicant / iwd
- Router Setup: ASUS ROG GT-AX6000 (Main) + TP-Link Archer BE800 (AP Mode,
Wi-Fi 7 MLO enabled on 6GHz)

Description of the Issue:
There is a severe performance and functionality regression when using Intel
Wi-Fi cards on the 6GHz band under Linux, which does not occur on the exact
same hardware under Windows 11. The problem consists of two distinct bugs:

Bug 1: Aggressive LAR (Location Aware Regulatory) drops 6GHz band entirely
By default, the iwlwifi driver locks the regulatory domain to country 00:
DFS-UNSET, even in jurisdictions where the 6GHz band is officially
permitted (e.g., Kazakhstan, KZ). The driver self-manages and forces the
global 00 domain based on passive scans of legacy ambient access points.
This completely filters out and blinds the system to any 6GHz (Wi-Fi 6E)
and Multi-Link Operation (Wi-Fi 7 MLO) beacons, throwing Connection refused
or hidden SSIDs. Switching the NM backend to iwd and manually forcing
Country=KZ in /etc/iwd/main.conf partially restores the visibility, but it
shouldn't require manual hacks.

Bug 2: NetworkManager wifi.powersave chokes throughput over 6GHz HTTP
streams
When a connection to a 6GHz / MLO network is finally established, local
network benchmarks over HTTP/WebSockets suffer from extreme performance
degradation. Download speeds drop to an abysmal 15-21 Mbps, while Link
Speed explicitly reports 1.729 Gbps. At the same time, Upload speed remains
relatively high (~338 Mbps). The default NetworkManager power-saving
mechanism (wifi.powersave = 3) fails to recognize high-throughput incoming
aggregate traffic over 6GHz bands when initiated via browser engines.
Forcing wifi.powersave = 2 inside NetworkManager config immediately fixes
the issue, boosting the throughput back to a stable 600+ Mbps.

Expected Behavior:
The iwlwifi driver should natively honor local regulatory frameworks
without falling back to a restrictive 00 profile that truncates 6GHz
frequencies. NetworkManager's default power management must be optimized
for the higher-frequency aggregation states of Wi-Fi 6E and Wi-Fi 7 to
prevent false-positive low-power state transitions during active downloads.

Attached is the full system debug log (network_bug_report.txt).

--00000000000095f3a40653df4e9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bug Report: Intel iwlwifi 6GHz (Wi-Fi 6E/7) regression und=
er Linux (LAR &amp; Aggressive Powersave issue)<br><br>Environment:<br>- OS=
: Arch Linux (Kernel 6.x / rolling)<br>- Wireless Card: Intel Wi-Fi 6E/7 (i=
wlwifi driver)<br>- Wireless Backend: NetworkManager with default wpa_suppl=
icant / iwd<br>- Router Setup: ASUS ROG GT-AX6000 (Main) + TP-Link Archer B=
E800 (AP Mode, Wi-Fi 7 MLO enabled on 6GHz)<br><br>Description of the Issue=
:<br>There is a severe performance and functionality regression when using =
Intel Wi-Fi cards on the 6GHz band under Linux, which does not occur on the=
 exact same hardware under Windows 11. The problem consists of two distinct=
 bugs:<br><br>Bug 1: Aggressive LAR (Location Aware Regulatory) drops 6GHz =
band entirely<br>By default, the iwlwifi driver locks the regulatory domain=
 to country 00: DFS-UNSET, even in jurisdictions where the 6GHz band is off=
icially permitted (e.g., Kazakhstan, KZ). The driver self-manages and force=
s the global 00 domain based on passive scans of legacy ambient access poin=
ts. This completely filters out and blinds the system to any 6GHz (Wi-Fi 6E=
) and Multi-Link Operation (Wi-Fi 7 MLO) beacons, throwing Connection refus=
ed or hidden SSIDs. Switching the NM backend to iwd and manually forcing Co=
untry=3DKZ in /etc/iwd/main.conf partially restores the visibility, but it =
shouldn&#39;t require manual hacks.<br><br>Bug 2: NetworkManager wifi.power=
save chokes throughput over 6GHz HTTP streams<br>When a connection to a 6GH=
z / MLO network is finally established, local network benchmarks over HTTP/=
WebSockets suffer from extreme performance degradation. Download speeds dro=
p to an abysmal 15-21 Mbps, while Link Speed explicitly reports 1.729 Gbps.=
 At the same time, Upload speed remains relatively high (~338 Mbps). The de=
fault NetworkManager power-saving mechanism (wifi.powersave =3D 3) fails to=
 recognize high-throughput incoming aggregate traffic over 6GHz bands when =
initiated via browser engines. Forcing wifi.powersave =3D 2 inside NetworkM=
anager config immediately fixes the issue, boosting the throughput back to =
a stable 600+ Mbps.<br><br>Expected Behavior:<br>The iwlwifi driver should =
natively honor local regulatory frameworks without falling back to a restri=
ctive 00 profile that truncates 6GHz frequencies. NetworkManager&#39;s defa=
ult power management must be optimized for the higher-frequency aggregation=
 states of Wi-Fi 6E and Wi-Fi 7 to prevent false-positive low-power state t=
ransitions during active downloads.<br><br>Attached is the full system debu=
g log (network_bug_report.txt).<br></div>

--00000000000095f3a40653df4e9d--
--00000000000095f3a60653df4e9f
Content-Type: text/plain; charset="US-ASCII"; name="network_bug_report.txt"
Content-Disposition: attachment; filename="network_bug_report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq7m55nh0>
X-Attachment-Id: f_mq7m55nh0

PT09IElXIFJFRyBHRVQgPT09Cmdsb2JhbApjb3VudHJ5IEtaOiBERlMtRVRTSQoJKDI0MDAgLSAy
NDgzIEAgNDApLCAoTi9BLCAyMCksIChOL0EpCgkoNTE1MCAtIDUyNTAgQCA4MCksIChOL0EsIDIz
KSwgKE4vQSksIE5PLU9VVERPT1IsIEFVVE8tQlcKCSg1MjUwIC0gNTM1MCBAIDgwKSwgKE4vQSwg
MjApLCAoMCBtcyksIE5PLU9VVERPT1IsIERGUywgQVVUTy1CVwoJKDU0NzAgLSA1NzI1IEAgMTYw
KSwgKE4vQSwgMjApLCAoMCBtcyksIE5PLU9VVERPT1IsIERGUwoJKDU3MjUgLSA1ODUwIEAgODAp
LCAoTi9BLCAyMCksIChOL0EpLCBOTy1PVVRET09SCgkoNTkyNSAtIDY0MjUgQCAzMjApLCAoTi9B
LCAyMyksIChOL0EpLCBOTy1PVVRET09SCgkoNTcwMDAgLSA2NjAwMCBAIDIxNjApLCAoTi9BLCA0
MCksIChOL0EpCgpwaHkjMCAoc2VsZi1tYW5hZ2VkKQpjb3VudHJ5IEdCOiBERlMtVU5TRVQKCSgy
NDAyIC0gMjQzNyBAIDQwKSwgKDYsIDIyKSwgKE4vQSksIEFVVE8tQlcsIE5PLUhUNDBNSU5VUywg
Tk8tODBNSFosIE5PLTE2ME1IWgoJKDI0MjIgLSAyNDYyIEAgNDApLCAoNiwgMjIpLCAoTi9BKSwg
QVVUTy1CVywgTk8tODBNSFosIE5PLTE2ME1IWgoJKDI0NDcgLSAyNDgyIEAgNDApLCAoNiwgMjIp
LCAoTi9BKSwgQVVUTy1CVywgTk8tSFQ0MFBMVVMsIE5PLTgwTUhaLCBOTy0xNjBNSFoKCSg1MTcw
IC0gNTE5MCBAIDE2MCksICg2LCAyMiksIChOL0EpLCBOTy1PVVRET09SLCBBVVRPLUJXLCBJUi1D
T05DVVJSRU5ULCBOTy1IVDQwTUlOVVMsIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgkoNTE5MCAt
IDUyMTAgQCAxNjApLCAoNiwgMjIpLCAoTi9BKSwgTk8tT1VURE9PUiwgQVVUTy1CVywgSVItQ09O
Q1VSUkVOVCwgTk8tSFQ0MFBMVVMsIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgkoNTIxMCAtIDUy
MzAgQCAxNjApLCAoNiwgMjIpLCAoTi9BKSwgTk8tT1VURE9PUiwgQVVUTy1CVywgSVItQ09OQ1VS
UkVOVCwgTk8tSFQ0ME1JTlVTLCBOTy0zMjBNSFosIFBBU1NJVkUtU0NBTgoJKDUyMzAgLSA1MjUw
IEAgMTYwKSwgKDYsIDIyKSwgKE4vQSksIE5PLU9VVERPT1IsIEFVVE8tQlcsIElSLUNPTkNVUlJF
TlQsIE5PLUhUNDBQTFVTLCBOTy0zMjBNSFosIFBBU1NJVkUtU0NBTgoJKDUyNTAgLSA1MjcwIEAg
MTYwKSwgKDYsIDIyKSwgKDAgbXMpLCBERlMsIEFVVE8tQlcsIE5PLUhUNDBNSU5VUywgTk8tMzIw
TUhaLCBQQVNTSVZFLVNDQU4KCSg1MjcwIC0gNTI5MCBAIDE2MCksICg2LCAyMiksICgwIG1zKSwg
REZTLCBBVVRPLUJXLCBOTy1IVDQwUExVUywgTk8tMzIwTUhaLCBQQVNTSVZFLVNDQU4KCSg1Mjkw
IC0gNTMxMCBAIDE2MCksICg2LCAyMiksICgwIG1zKSwgREZTLCBBVVRPLUJXLCBOTy1IVDQwTUlO
VVMsIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgkoNTMxMCAtIDUzMzAgQCAxNjApLCAoNiwgMjIp
LCAoMCBtcyksIERGUywgQVVUTy1CVywgTk8tSFQ0MFBMVVMsIE5PLTMyME1IWiwgUEFTU0lWRS1T
Q0FOCgkoNTQ5MCAtIDU1MTAgQCAxNjApLCAoNiwgMjIpLCAoMCBtcyksIERGUywgQVVUTy1CVywg
Tk8tSFQ0ME1JTlVTLCBOTy0zMjBNSFosIFBBU1NJVkUtU0NBTgoJKDU1MTAgLSA1NTMwIEAgMTYw
KSwgKDYsIDIyKSwgKDAgbXMpLCBERlMsIEFVVE8tQlcsIE5PLUhUNDBQTFVTLCBOTy0zMjBNSFos
IFBBU1NJVkUtU0NBTgoJKDU1MzAgLSA1NTUwIEAgMTYwKSwgKDYsIDIyKSwgKDAgbXMpLCBERlMs
IEFVVE8tQlcsIE5PLUhUNDBNSU5VUywgTk8tMzIwTUhaLCBQQVNTSVZFLVNDQU4KCSg1NTUwIC0g
NTU3MCBAIDE2MCksICg2LCAyMiksICgwIG1zKSwgREZTLCBBVVRPLUJXLCBOTy1IVDQwUExVUywg
Tk8tMzIwTUhaLCBQQVNTSVZFLVNDQU4KCSg1NTcwIC0gNTU5MCBAIDE2MCksICg2LCAyMiksICgw
IG1zKSwgREZTLCBBVVRPLUJXLCBOTy1IVDQwTUlOVVMsIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FO
CgkoNTU5MCAtIDU2MTAgQCAxNjApLCAoNiwgMjIpLCAoMCBtcyksIERGUywgQVVUTy1CVywgTk8t
SFQ0MFBMVVMsIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgkoNTYxMCAtIDU2MzAgQCAxNjApLCAo
NiwgMjIpLCAoMCBtcyksIERGUywgQVVUTy1CVywgTk8tSFQ0ME1JTlVTLCBOTy0zMjBNSFosIFBB
U1NJVkUtU0NBTgoJKDU2MzAgLSA1NjUwIEAgMTYwKSwgKDYsIDIyKSwgKDAgbXMpLCBERlMsIEFV
VE8tQlcsIE5PLUhUNDBQTFVTLCBOTy0zMjBNSFosIFBBU1NJVkUtU0NBTgoJKDU2NTAgLSA1Njcw
IEAgODApLCAoNiwgMjIpLCAoMCBtcyksIERGUywgQVVUTy1CVywgTk8tSFQ0ME1JTlVTLCBOTy0x
NjBNSFosIE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgkoNTY3MCAtIDU2OTAgQCA4MCksICg2LCAy
MiksICgwIG1zKSwgREZTLCBBVVRPLUJXLCBOTy1IVDQwUExVUywgTk8tMTYwTUhaLCBOTy0zMjBN
SFosIFBBU1NJVkUtU0NBTgoJKDU2OTAgLSA1NzEwIEAgODApLCAoNiwgMjIpLCAoMCBtcyksIERG
UywgQVVUTy1CVywgTk8tSFQ0ME1JTlVTLCBOTy0xNjBNSFosIE5PLTMyME1IWiwgUEFTU0lWRS1T
Q0FOCgkoNTczNSAtIDU3NTUgQCA4MCksICg2LCAyMiksIChOL0EpLCBBVVRPLUJXLCBOTy1IVDQw
TUlOVVMsIE5PLTE2ME1IWiwgTk8tMzIwTUhaCgkoNTc1NSAtIDU3NzUgQCA4MCksICg2LCAyMiks
IChOL0EpLCBBVVRPLUJXLCBOTy1IVDQwUExVUywgTk8tMTYwTUhaLCBOTy0zMjBNSFoKCSg1Nzc1
IC0gNTc5NSBAIDgwKSwgKDYsIDIyKSwgKE4vQSksIEFVVE8tQlcsIE5PLUhUNDBNSU5VUywgTk8t
MTYwTUhaLCBOTy0zMjBNSFoKCSg1Nzk1IC0gNTgxNSBAIDgwKSwgKDYsIDIyKSwgKE4vQSksIEFV
VE8tQlcsIE5PLUhUNDBQTFVTLCBOTy0xNjBNSFosIE5PLTMyME1IWgoJKDU4MTUgLSA1ODM1IEAg
NDApLCAoNiwgMjIpLCAoTi9BKSwgQVVUTy1CVywgTk8tSFQ0ME1JTlVTLCBOTy04ME1IWiwgTk8t
MTYwTUhaLCBOTy0zMjBNSFoKCSg1ODM1IC0gNTg1NSBAIDQwKSwgKDYsIDIyKSwgKE4vQSksIEFV
VE8tQlcsIE5PLUhUNDBQTFVTLCBOTy04ME1IWiwgTk8tMTYwTUhaLCBOTy0zMjBNSFoKCSg1ODU1
IC0gNTg3NSBAIDIwKSwgKDYsIDIyKSwgKE4vQSksIEFVVE8tQlcsIE5PLUhUNDBNSU5VUywgTk8t
SFQ0MFBMVVMsIE5PLTgwTUhaLCBOTy0xNjBNSFosIE5PLTMyME1IWgoJKDU5NDUgLSA2NDI1IEAg
MTYwKSwgKDYsIDIyKSwgKE4vQSksIE5PLU9VVERPT1IsIEFVVE8tQlcsIElSLUNPTkNVUlJFTlQs
IE5PLTMyME1IWiwgUEFTU0lWRS1TQ0FOCgoKPT09IERNRVNHIElXTFdJRkkgPT09ClsgICAgMy4z
MzI4NjZdIGl3bHdpZmkgMDAwMDowOTowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAw
MikKWyAgICAzLjMzNDQ1OV0gaXdsd2lmaSAwMDAwOjA5OjAwLjA6IERldGVjdGVkIGNyZi1pZCAw
eDQwMDQxMCwgY252LWlkIDB4NDAwNDEwIHdmcG0gaWQgMHg4MDAwMDAwMApbICAgIDMuMzM0NDY2
XSBpd2x3aWZpIDAwMDA6MDk6MDAuMDogUENJIGRldiAyNzI1LzAwMjQsIHJldj0weDQyMCwgcmZp
ZD0weDEwZDAwMApbICAgIDMuMzM0NDcwXSBpd2x3aWZpIDAwMDA6MDk6MDAuMDogRGV0ZWN0ZWQg
SW50ZWwoUikgV2ktRmkgNkUgQVgyMTAgMTYwTUh6ClsgICAgMy4zNTg5NDJdIGl3bHdpZmkgMDAw
MDowOTowMC4wOiBsb2FkZWQgZmlybXdhcmUgdmVyc2lvbiA4OS43MzViNzVhNC4wIHR5LWEwLWdm
LWEwLTg5LnVjb2RlIG9wX21vZGUgaXdsbXZtClsgICAgMy42NzMwMTBdIGl3bHdpZmkgMDAwMDow
OTowMC4wOiBXRlBNX1VNQUNfUERfTk9USUZJQ0FUSU9OOiAweDIwClsgICAgMy42NzMwMjNdIGl3
bHdpZmkgMDAwMDowOTowMC4wOiBXRlBNX0xNQUMyX1BEX05PVElGSUNBVElPTjogMHgxZgpbICAg
IDMuNjczMDM5XSBpd2x3aWZpIDAwMDA6MDk6MDAuMDogV0ZQTV9BVVRIX0tFWV8wOiAweDkwClsg
ICAgMy42NzMwNTJdIGl3bHdpZmkgMDAwMDowOTowMC4wOiBDTlZJX1NDVV9TRVFfREFUQV9EVzk6
IDB4MApbICAgIDMuNjczMDYwXSBpd2x3aWZpIDAwMDA6MDk6MDAuMDogRGV0ZWN0ZWQgUkYgR0Ys
IHJmaWQ9MHgxMGQwMDAKWyAgICAzLjc1NzA2NF0gaXdsd2lmaSAwMDAwOjA5OjAwLjA6IGJhc2Ug
SFcgYWRkcmVzczogODQ6NWM6ZjM6ZjY6NmQ6YWEKWyAgICA1LjcyOTAyMl0gaXdsd2lmaSAwMDAw
OjA5OjAwLjA6IFdGUE1fVU1BQ19QRF9OT1RJRklDQVRJT046IDB4MjAKWyAgICA1LjcyOTAzNl0g
aXdsd2lmaSAwMDAwOjA5OjAwLjA6IFdGUE1fTE1BQzJfUERfTk9USUZJQ0FUSU9OOiAweDFmClsg
ICAgNS43MjkwNTJdIGl3bHdpZmkgMDAwMDowOTowMC4wOiBXRlBNX0FVVEhfS0VZXzA6IDB4OTAK
WyAgICA1LjcyOTA2M10gaXdsd2lmaSAwMDAwOjA5OjAwLjA6IENOVklfU0NVX1NFUV9EQVRBX0RX
OTogMHgwCgo9PT0gTkVUV09SS01BTkFHRVIgQ09ORklHID09PQojIENvbmZpZ3VyYXRpb24gZmls
ZSBmb3IgTmV0d29ya01hbmFnZXIuCiMgU2VlICJtYW4gNSBOZXR3b3JrTWFuYWdlci5jb25mIiBm
b3IgZGV0YWlscy4KW2RldmljZV0Kd2lmaS5iYWNrZW5kPWl3ZAo=
--00000000000095f3a60653df4e9f--

