Return-Path: <linux-wireless+bounces-37609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bNEwGvznKGopNAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:28:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6117C665BEF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 06:28:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S9CGjpkp;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37609-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37609-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1CD93004CA2
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 04:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF03624DB;
	Wed, 10 Jun 2026 04:28:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4793451C1
	for <linux-wireless@vger.kernel.org>; Wed, 10 Jun 2026 04:28:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781065692; cv=pass; b=AI7x37zvEm1Y5bZHc3DhUDkMMqmNXBGbbviUM1PgS+Z/TMVsDb4Ebr4jWB5lW76p6xgyWkmdzQ41WesXuU5EgqLa+SwFvOz1OmzWrNl6zfTftKVgGBsYChauffGdYvKX2eVZX4ayMdbgxp6yDOtLJEEe2ANcJUZnvihyPl9TrP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781065692; c=relaxed/simple;
	bh=tJbmcUPUsx5xRUlpHdF8CZNZSVq6lEeJS0de9SKGu/U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JmEuXPgmnXlhspn7GC7vgrcyL1Un1XycuV+nqwtUvMoh7Wy3qr55n81D6wCaqYAx+xUgA2lENRHjgEVRox9xPZLINElhTlOB8X3v2hG6k4Pvod7fhnx+scKDaJqCPD/s6inTqoH1HtYikRFqJcicbS1LhhZmPs0KAERVjlrsPrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9CGjpkp; arc=pass smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso53312245e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 21:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781065689; cv=none;
        d=google.com; s=arc-20240605;
        b=F2E0v0rYmoUrqnOLFh2gdxxmWi0/F+sSNZ4MKNQ619Wp1/dY9jv09QcMBn8WYk++uk
         /JFBHlsI3o07NSBbv/j6ozXq361lDuFkJYUDD2y/9deajFfODe0sjbJZDkxBst+Mron7
         x8foiDRlUKSfUo+illvTwc3dLdXGRFgozUKeUnN6gdJlCK4fvJ/dR03DaFHS+FrRbxF1
         czldlteKCNaOvHCJPWPkhEAhdPkMSs9tItplLHlH2D1dBGlXVj0zAf8DqzsdeJ6p6Fp5
         3w9pZY7twD+9NWMFc6wX7lIX7LXri+5nTJUE0hv8UPbQ+zkS5N55q2PM77Yw24mB842S
         016g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tJbmcUPUsx5xRUlpHdF8CZNZSVq6lEeJS0de9SKGu/U=;
        fh=qW0phhq3fb3oiohK/Mu9j1KY1zyRNiiioKFc5anvatM=;
        b=fT1oxDBLvpKedacTF+7LalDoMoMC/d2MTvsaFTIJZ8FU+e1xD6Kz5f7/RWsO0uNrIW
         B5KvDSNRHy2ngiV3qSCSvqAsa235UuWcNVqCYhKWYdR6Qu2Tsir8nYnG5ayo229lG1te
         mVksRrdXDnHox7SgZyXxDCnkZppvGW0awyJgRKv0NAIW/2QyDgwbcgkke5ZqZGewS2fI
         Wcem3HMyw8mreL5PGgn2BcJ6dX8Rl/g8x1rl7w3gFBOoJEIQT7qyjGTMAP30kqbqvTaT
         nIpvtXfL/ySHxhICUFEd9ltgB9l5HRrMvT/bi7RWXlhUJKztafDRxJd9XBF6c5ex/5Jl
         UANw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781065689; x=1781670489; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tJbmcUPUsx5xRUlpHdF8CZNZSVq6lEeJS0de9SKGu/U=;
        b=S9CGjpkpZMoVKPb1G/oQDJGf2jRPDHMz5KMKYgU/uYkSW/FeAUbK3NA14SPJi9oleU
         zd1JgXftJ4ue5H00OiRgKnOyWcxaivGayLJQrbmLM0ZZbR5byfE/RvkaqvL1X7P62xgX
         j4EabITTpYz2bm3HQrheGCGdFiA+xlSRVQoAPFci3/J5+akBZftjWp0yGyU5Z7j0VwlP
         /1AOn05110RZ0AZykOo1YHdRYphYCiR3Ir8VibImlkH2D7pFb5WKtr5/AuLS7Y+dF+8m
         dwRIi0XAZCZr6ePQLnqvdG+1j9Hx7txlFqzcjE3xZSqfsB8f3/U9ACHGAKoHP4w+4SFl
         g8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781065689; x=1781670489;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJbmcUPUsx5xRUlpHdF8CZNZSVq6lEeJS0de9SKGu/U=;
        b=sYysWCFZx8JDA3cqPqp0ExWSGkHqvqgyVirmy+hVRfuugF03kKqdXs47HzIP/s7CNA
         VJigW0fnXO6DErdY3f75KwZeTB9KvZ9opgXmUnSOqN54VhYdE6N1afoAcU72d/PGS2cn
         9EAMBu8umMAhfXECY3aPhfl7vFjmMBZBPsR7z3IIBR5SbHL8E4XSXGIcz9GHVcME1rql
         +22PToTLcaU1o7OdYxTIuYMo0Kv4lV5sO9PhtNRRNeJmAipYwXn0/pdlG773OXVVnPaa
         O067JpXkkf8ccyLYpz2dMYyq+LcCJOr3hZfTK7J4Sk3UDNbJ0jge9DxUe7Tag8ftCzFb
         fmQw==
X-Gm-Message-State: AOJu0YwDB4GrS5/qihhGkj14wTD3VO/tzPRZbmF4CMVAC3fFSEg5K0t6
	hRAs/7gC+RAB0Ah3xAuDM32nM5quodiiN1hip1dA+ZihX+waMPyPdpzKzoT2z3cjF9D9lHbCjoP
	E9YBJKAqE/IrmceHlz2eJXjx6t3vy6HClaHHLz1A=
X-Gm-Gg: Acq92OEv2iYyTuO9TFP0inVVUk7nzPXyL4QCNaJ1Usqo+R5Mej+ykHbHjidif3pg7Ek
	oB9U8xP87nFCfycacvkdVvNxUldl49Gu0iJ4OxOwkD/UkOq1ssFsHT6ioRBY7e5aybYjTcUwBjw
	Si5lEFMtIYsRV1hCSKeKz9Cmp9Uub6jQtB88M2yDJWSZr67leknh75i8IEtzWY8KpkvcYq5Ica5
	ZqZ3LCdiPu45/ltCqsmjujezoyrS4776yZedbTwLjMSn4QbG63Fw/D9gqgUB4A127LgI5naE7zr
	SqjXnvi82Gj2FIdKZA==
X-Received: by 2002:a05:600c:354a:b0:490:ba0a:1178 with SMTP id
 5b1f17b1804b1-490c2616e16mr377432375e9.28.1781065689112; Tue, 09 Jun 2026
 21:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?0JLQu9Cw0LTQuNC80LjRgCDQn9Cw0L3RgtC10LvQtdC10LI=?= <vovik181083@gmail.com>
Date: Wed, 10 Jun 2026 09:27:57 +0500
X-Gm-Features: AVVi8CeA7jqGbUxMdnkfZIEpmNO_oULxweuvUR-IcXVTI0admyEVc-jLiOY5b70
Message-ID: <CAN6W26sm-xsy3tQ+RGcjYxpfe8+HcD7E8Q36MeT9m0u=2KGn2A@mail.gmail.com>
Subject: iwlwifi: Aggressive LAR forces country 00 and disables 6GHz band on
 Intel chips
To: linux-wireless@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000b8befa0653deabdc"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37609-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6117C665BEF

--000000000000b8befa0653deabdc
Content-Type: multipart/alternative; boundary="000000000000b8bef90653deabda"

--000000000000b8bef90653deabda
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

--000000000000b8bef90653deabda
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

--000000000000b8bef90653deabda--
--000000000000b8befa0653deabdc
Content-Type: text/plain; charset="US-ASCII"; name="network_bug_report.txt"
Content-Disposition: attachment; filename="network_bug_report.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mq7khcic0>
X-Attachment-Id: f_mq7khcic0

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
--000000000000b8befa0653deabdc--

