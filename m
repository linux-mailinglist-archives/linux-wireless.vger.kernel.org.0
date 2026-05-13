Return-Path: <linux-wireless+bounces-36380-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iI3wIQNVBGqMHAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36380-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 12:40:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037C3531722
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 12:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D73DB3055D48
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 10:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC143DB964;
	Wed, 13 May 2026 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ofz.sk header.i=@ofz.sk header.b="D1cjJ7u3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ofz.onice.io (ofz.onice.io [185.119.216.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7338F38B7B1
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.119.216.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778668658; cv=pass; b=Yr3BOOpdWLc4ClyvYRy2iAoWStgM0kS+t/jSYAO8c8s8IBv5Y4AEtlAdGMiFeI7wWQsGs+RKOlBs/rSly8Cc1Ym4GHvNWgnv5bfmBsi8OoPs/gqhcKI4SdYbR1n24PhiHw4qOEwAtNQC5d4sb9EWA2JbY/UkKG3pxS613jVVzSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778668658; c=relaxed/simple;
	bh=yz+Pqf8/4vSf3AyMPjzDAyOK/woi8cLhJaSwF4zOK2E=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=B8ATLaolbXxTcr3/YNvIaM6Sy4ZFXPUODdKi24Af3gmqf6Tj/A4UZiiMDgjlXLdqCwp6oBsM2pFb6puxoziatJ66gxDdVn0knRQanzSnTW/xZzs0dBwXn1WAG7PHgZaJbwyTY9NPTmeA2y/IliEFOqYwen6mouALjgOSaSVkZak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ofz.sk; spf=pass smtp.mailfrom=ofz.sk; dkim=pass (2048-bit key) header.d=ofz.sk header.i=@ofz.sk header.b=D1cjJ7u3; arc=pass smtp.client-ip=185.119.216.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ofz.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ofz.sk
ARC-Seal: i=1; a=rsa-sha256; t=1778668515; cv=none; d=ofz.sk; s=onice-selector1;
   b=3Gkcj5HydrveKpLVEzFW3UrPiBq/H1ACimjm9dSVYZBgu1g5z7VMyT9pkmV0/Rwd/Bd9aOzYi4nXryLq3kIhjD0BNU61w43ypqD9ilno6RLGeAM5J+YqCMgW+K7iE/g6Z9NZ115a/3R9yI3vFHuPnBf/cNi7oDGf1j/Y4Z+V5LWjsW84K+cyeCvOk25oSv7Szga2eXvhPQ4sPJ0pyM3LDTs6bzSbTD9cnlHpVe285iwcP6onUFMPcljoLrleKy+OFLC08D6ySAIxSKm+MKVexUM3mhb/GURZjFJ6k1QlX5IPf0kjx/5/UxwcxmJrzX2a72q1ZQU8D8p61jhixciKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; s=onice-selector1; d=ofz.sk; c=relaxed/relaxed; bh=BgdnXOB3ZNnf+WJpDCcETHjkzPuTkqbJcuPHNxk+z6E=; h=to:from:subject:message-id:date:mime-version:dkim-signature;
   b=bJt0PHSOZ2+4kxvOC5e4NdyDfn3jDqUyWOlUyucYulC5UcsezVigFUDP3VJEw2d4/aIM0IR56VC4+MIpqa6JrN8E1Om/XkoDq1njDY61IzeuHc453LJuPPjHg2bfsqP7FslAa8/ASJ6mhVWH0HF/fVnPn6geZUl0pFJn4VmH3KASQ3Ma12PsIPDCiBOVZuSUCu71LvBBc/rjH8TKOWYbqt5ucKPi5lhtGWRtVKDY5mwO0Huf4B1YbuUQEFC3MrmgEI/cgymlbL+l4+4JWjIIiUfW7/aCeGJceKKvOPcg/nhX5FYvgcEe2yJkYDoY+nnfVVS9RoKW5UVOfSHXFzA4hA==
ARC-Authentication-Results: i=1; ofz.onice.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; t=1778668515; x=1779273315; s=onice-selector1; d=ofz.sk; c=relaxed/relaxed; bh=BgdnXOB3ZNnf+WJpDCcETHjkzPuTkqbJcuPHNxk+z6E=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type;
   b=D1cjJ7u3HUdFC6ZSGM6t+if+BQyFGaHz+7l1J1F6/mkFjVWhyBU8BY13xEkORZuXVQctzryAnV07WuHgISTB1IMs9aVzU2Nkg68S7cgITm95gdy1HpIY5R86qoZjY3H0DoC4McY9IsOJ6SXP3LCPiO4cr/8Fywzm1Cw7ChCRpuVAmWX1E/lwhxgJATtFRe9zFFKd1/8wO9qDwfSyZhABxnka9evD3idGRs8YjONk+blWf7iuhnv2bIyKj8S0MNQsLNr2dYKBSb5G+5+29NdDwyViPOAx3Vj02iR2UbrNRYIZe9u7fbnpBMDuQa8ubCYgqF5v2ocd1yCF73grKUJHbA==
Received: from [10.27.16.136] ([80.87.210.74])
        by ofz.onice.io (14.3.0 build 3 ) with ASMTP (SSL) id 202605131235141064;
        Wed, 13 May 2026 12:35:14 +0200
Message-ID: <d2ffd82d-01cb-470e-bb02-70c163c61216@ofz.sk>
Date: Wed, 13 May 2026 12:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org
Subject: [REGRESSION] iwlwifi 8265 firmware ADVANCED_SYSASSERT in
 PHY_CONTEXT_CMD on roam (v7.0.3..v7.0.5)
Content-Language: en-US, sk-SK
From: Branislav Klocok <branislav.klocok@ofz.sk>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000208080401060609030503"
X-Rspamd-Queue-Id: 037C3531722
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ofz.sk,quarantine];
	R_DKIM_ALLOW(-0.20)[ofz.sk:s=onice-selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain,multipart/related];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~,6:~];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-36380-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ofz.sk:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[branislav.klocok@ofz.sk,linux-wireless@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:url,ofz.sk:email,ofz.sk:mid,ofz.sk:dkim,ofz.company:url]
X-Rspamd-Action: no action

This is a cryptographically signed message in MIME format.

--------------ms000208080401060609030503
Content-Type: multipart/alternative;
 boundary="------------BgIJzuS1kJ5Cdo5ir3nBsjXp"

--------------BgIJzuS1kJ5Cdo5ir3nBsjXp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkkgd291bGQgbGlrZSB0byByZXBvcnQgYSByZWdyZXNzaW9uIGluIHN0YWJsZSBr
ZXJuZWwgNy4wLnggYWZmZWN0aW5nDQppd2x3aWZpIG9uIEludGVsIFdpcmVsZXNzLUFDIDgy
NjUuIEJ1ZyBmaWxlZCBhdA0KaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMjE1MTIgKG5ldHdvcmstd2lyZWxlc3MtaW50ZWwpDQphbmQgb3BlblNVU0Ug
QnVnemlsbGEgaHR0cHM6Ly9idWd6aWxsYS5zdXNlLmNvbS9zaG93X2J1Zy5jZ2k/aWQ9MTI2
NDgwNC4NCg0KI3JlZ3pib3QgaW50cm9kdWNlZDogdjcuMC4zLi52Ny4wLjUNCiNyZWd6Ym90
IGxpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjIx
NTEyDQojcmVnemJvdCBsaW5rOiBodHRwczovL2J1Z3ppbGxhLnN1c2UuY29tL3Nob3dfYnVn
LmNnaT9pZD0xMjY0ODA0DQoNClN1bW1hcnk6IGV2ZXJ5IGNvbnRyb2xsZXItaW5pdGlhdGVk
IHJvYW0gYmV0d2VlbiBCU1NJRHMgb2YgdGhlIHNhbWUNCmVudGVycHJpc2UgRVNTSUQgdHJp
Z2dlcnMgYSBmaXJtd2FyZSBtaWNyb2NvZGUgYXNzZXJ0aW9uDQooYEFEVkFOQ0VEX1NZU0FT
U0VSVGAgLyBgTk1JX0lOVEVSUlVQVF9MTUFDX0ZBVEFMYCAvIGBGVyBlcnJvciBpbiBTWU5D
DQpDTUQgUEhZX0NPTlRFWFRfQ01EYCkuIERyaXZlciBTVy1yZXNldHMgYW5kIHJlLWFzc29j
aWF0ZXMgaW4gYWJvdXQNCjQgcywgYnV0IHNvbWUgdHJpZ2dlcnMgc2VuZCB0aGUgZHJpdmVy
IGludG8gYSBjYXNjYWRpbmcgcmVzdGFydCBsb29wDQoob2JzZXJ2ZWQgNiBmaXJtd2FyZSBl
cnJvcnMgaW4gMjMgcywgdHdpY2UgaW4gYSBzaW5nbGUgc2Vzc2lvbikuDQpJZGVudGljYWwg
aGFyZHdhcmUsIGZpcm13YXJlIGJsb2IgKGA4MjY1LTM2LnVjb2RlYCB2MzYuYzhlOGUxNDQu
MCksDQpuZXR3b3JrIGFuZCB1c2Vyc3BhY2Ugd29ya2VkIGNvcnJlY3RseSBvbiA3LjAuMy4N
Cg0KSSBwZXJzb25hbGx5IGJvb3RlZCBvbmx5IDcuMC4zIChnb29kKSBhbmQgNy4wLjUgKGJh
ZCk7IDcuMC40IHdhcw0KaW5zdGFsbGVkIGJ1dCBub3QgcnVuLiBUaGUgNy4wLjUgc3RhYmxl
IGNoYW5nZWxvZyBjb250YWlucyBubw0KaXdsd2lmaS9tYWM4MDIxMS9jZmc4MDIxMSBjb21t
aXRzLCBzbyB0aGUgcmVncmVzc2lvbiBtb3N0IGxpa2VseSBzaXRzDQppbiB0aGUgNy4wLjQg
YmF0Y2guDQoNCkNyYXNoIGJhY2t0cmFjZSBmcmFnbWVudDoNCg0KaXdsd2lmaSAwMDAwOjAy
OjAwLjA6IDB4MDAwMDE0RkQgfCBBRFZBTkNFRF9TWVNBU1NFUlQNCml3bHdpZmkgMDAwMDow
MjowMC4wOiAweDAwMDAwMDcwIHwgTk1JX0lOVEVSUlVQVF9MTUFDX0ZBVEFMDQppd2x3aWZp
IDAwMDA6MDI6MDAuMDogRlcgZXJyb3IgaW4gU1lOQyBDTUQgUEhZX0NPTlRFWFRfQ01EDQpD
UFU6IDIgVUlEOiAwIFBJRDogMTUyNyBDb21tOiB3cGFfc3VwcGxpY2FudA0KaXdsX3RyYW5z
X3BjaWVfc2VuZF9oY21kKzB4NDAyLzB4NDEwIFtpd2x3aWZpXQ0KaXdsX3RyYW5zX3NlbmRf
Y21kKzB4M2UvMHhhMCBbaXdsd2lmaV0NCj8gbmw4MDIxMV9hdXRoZW50aWNhdGUrMHgzNzMv
MHg0MDAgW2NmZzgwMjExXQ0Kbmw4MDIxMV9hdXRoZW50aWNhdGUrMHgzOGQvMHg0MDAgW2Nm
ZzgwMjExXQ0KaXdsd2lmaSAwMDAwOjAyOjAwLjA6IFBIWSBjdHh0IGNtZCBlcnJvci4gcmV0
PS01DQoNCldvcmthcm91bmRzIHRlc3RlZCBhbmQgcmVqZWN0ZWQ6DQotIGA4MDItMTEtd2ly
ZWxlc3MucG93ZXJzYXZlPTJgIChDQU0pIOKAlCBkb2VzIG5vdCBwcmV2ZW50IHRoZSBjcmFz
aDsNCmNsaWVudCBzdGlsbCByZWNlaXZlcyBzdGVlcmluZyBhbmQgZmlybXdhcmUgc3RpbGwg
YXNzZXJ0cyBvbg0KYFBIWV9DT05URVhUX0NNRGAuDQotIGBtb2Rwcm9iZSAtciBpd2xtdm0g
aXdsd2lmaSAmJiBtb2Rwcm9iZSBpd2x3aWZpYCDigJQgdGVtcG9yYXJ5DQpyZWNvdmVyeSBv
bmx5OyBuZXh0IHJvYW0gcmVwcm9kdWNlcyB0aGUgY3Jhc2guDQoNClRoZSBvbmx5IGtub3du
IG1pdGlnYXRpb24gaXMgc3RheWluZyBvbiA3LjAuMyBvciBhdm9pZGluZyBuZXR3b3Jrcw0K
d2l0aCBjb250cm9sbGVyLWRyaXZlbiBiYW5kL2xvYWQgc3RlZXJpbmcuDQoNCkkgYW0gaGFw
cHkgdG8gdGVzdCBwYXRjaGVzIGFnYWluc3QgdGhlIGFmZmVjdGVkIGhhcmR3YXJlIGFuZCBu
ZXR3b3JrLg0KRnVsbCBmaWx0ZXJlZCBrZXJuZWwgbG9nICgzMzI5IGxpbmVzLCBib3RoIGNh
c2NhZGluZyByZXN0YXJ0IGxvb3BzKQ0KaXMgYXR0YWNoZWQgdG8gdGhlIGJ1Z3ppbGxhLmtl
cm5lbC5vcmcgYnVnLg0KDQpIYXJkd2FyZToNCi0gSW50ZWwgV2lyZWxlc3MtQUMgODI2NSBb
ODA4NjoyNGZkXSByZXYgNzgsIHN1YnN5cyBbODA4NjowMDEwXQ0KLSBUaGlua1BhZCwgb3Bl
blNVU0UgVHVtYmxld2VlZCAocm9sbGluZykgc25hcHNob3QgMjAyNjA1MDkNCi0ga2VybmVs
LWZpcm13YXJlLWl3bHdpZmkgMjAyNjAzMzEtMS4xDQotIE5ldHdvcmtNYW5hZ2VyIDEuNTQu
My0zLjQsIHdwYV9zdXBwbGljYW50IDIuMTEtNi4zDQoNClRoYW5rcywNCkJyYW5pc2xhdiBL
bG9jb2sNCiotLSAqDQpTIHBvemRyYXZvbSAvIEJlc3QgcmVnYXJkcw0KKkJyYW5pc2xhdiBL
bG9jb2sgKg0KKmdlbmVyw6FsbnkgcmlhZGl0ZcS+IC8gZ2VuZXJhbCBkaXJlY3RvciAqDQoN
Cg0KKsKgT0ZaLCBhLnMuKg0KTW9iaWw6IAkqKzQyMSA5MDggNzAzIDM2NioNClRlbDogCSor
NDIxIDQzIDU4MDQgNDg4ICoNCmUtbWFpbDogCSoqYnJhbmlzbGF2Lmtsb2Nva0BvZnouc2sq
IDxtYWlsdG86YnJhbmlzbGF2Lmtsb2Nva0BvZnouc2s+ICoNCndlYjogCSoqd3d3Lm9mei5j
b21wYW55KiA8aHR0cDovL3d3dy5vZnouY29tcGFueT4gKg0KDQoNCm9meiBsb2dvDQoNCg==

--------------BgIJzuS1kJ5Cdo5ir3nBsjXp
Content-Type: multipart/related;
 boundary="------------NOzstjsUEGqSBeXE9E4pP2W3"

--------------NOzstjsUEGqSBeXE9E4pP2W3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html data-lt-installed=3D"true">
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF=
-8">
    <meta charset=3D"UTF-8">
  </head>
  <body style=3D"padding-bottom: 1px;">
    Hi,<br>
    <br>
    I would like to report a regression in stable kernel 7.0.x affecting<=
br>
    iwlwifi on Intel Wireless-AC 8265. Bug filed at<br>
    <a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.kernel.or=
g/show_bug.cgi?id=3D221512">https://bugzilla.kernel.org/show_bug.cgi?id=3D=
221512</a>
    (network-wireless-intel)<br>
    and openSUSE Bugzilla
    <a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.suse.com/=
show_bug.cgi?id=3D1264804">https://bugzilla.suse.com/show_bug.cgi?id=3D12=
64804</a>.<br>
    <br>
    #regzbot introduced: v7.0.3..v7.0.5<br>
    #regzbot link: <a class=3D"moz-txt-link-freetext" href=3D"https://bug=
zilla.kernel.org/show_bug.cgi?id=3D221512">https://bugzilla.kernel.org/sh=
ow_bug.cgi?id=3D221512</a><br>
    #regzbot link: <a class=3D"moz-txt-link-freetext" href=3D"https://bug=
zilla.suse.com/show_bug.cgi?id=3D1264804">https://bugzilla.suse.com/show_=
bug.cgi?id=3D1264804</a><br>
    <br>
    Summary: every controller-initiated roam between BSSIDs of the same<b=
r>
    enterprise ESSID triggers a firmware microcode assertion<br>
    (`ADVANCED_SYSASSERT` / `NMI_INTERRUPT_LMAC_FATAL` / `FW error in
    SYNC<br>
    CMD PHY_CONTEXT_CMD`). Driver SW-resets and re-associates in about<br=
>
    4 s, but some triggers send the driver into a cascading restart loop<=
br>
    (observed 6 firmware errors in 23 s, twice in a single session).<br>
    Identical hardware, firmware blob (`8265-36.ucode` v36.c8e8e144.0),<b=
r>
    network and userspace worked correctly on 7.0.3.<br>
    <br>
    I personally booted only 7.0.3 (good) and 7.0.5 (bad); 7.0.4 was<br>
    installed but not run. The 7.0.5 stable changelog contains no<br>
    iwlwifi/mac80211/cfg80211 commits, so the regression most likely
    sits<br>
    in the 7.0.4 batch.<br>
    <br>
    Crash backtrace fragment:<br>
    <br>
    iwlwifi 0000:02:00.0: 0x000014FD | ADVANCED_SYSASSERT<br>
    iwlwifi 0000:02:00.0: 0x00000070 | NMI_INTERRUPT_LMAC_FATAL<br>
    iwlwifi 0000:02:00.0: FW error in SYNC CMD PHY_CONTEXT_CMD<br>
    CPU: 2 UID: 0 PID: 1527 Comm: wpa_supplicant<br>
    iwl_trans_pcie_send_hcmd+0x402/0x410 [iwlwifi]<br>
    iwl_trans_send_cmd+0x3e/0xa0 [iwlwifi]<br>
    ? nl80211_authenticate+0x373/0x400 [cfg80211]<br>
    nl80211_authenticate+0x38d/0x400 [cfg80211]<br>
    iwlwifi 0000:02:00.0: PHY ctxt cmd error. ret=3D-5<br>
    <br>
    Workarounds tested and rejected:<br>
    - `802-11-wireless.powersave=3D2` (CAM) =E2=80=94 does not prevent th=
e crash;<br>
    client still receives steering and firmware still asserts on<br>
    `PHY_CONTEXT_CMD`.<br>
    - `modprobe -r iwlmvm iwlwifi &amp;&amp; modprobe iwlwifi` =E2=80=94
    temporary<br>
    recovery only; next roam reproduces the crash.<br>
    <br>
    The only known mitigation is staying on 7.0.3 or avoiding networks<br=
>
    with controller-driven band/load steering.<br>
    <br>
    I am happy to test patches against the affected hardware and
    network.<br>
    Full filtered kernel log (3329 lines, both cascading restart loops)<b=
r>
    is attached to the bugzilla.kernel.org bug.<br>
    <br>
    Hardware:<br>
    - Intel Wireless-AC 8265 [8086:24fd] rev 78, subsys [8086:0010]<br>
    - ThinkPad, openSUSE Tumbleweed (rolling) snapshot 20260509<br>
    - kernel-firmware-iwlwifi 20260331-1.1<br>
    - NetworkManager 1.54.3-3.4, wpa_supplicant 2.11-6.3<br>
    <br>
    Thanks,<br>
    Branislav Klocok<br>
    <div class=3D"moz-signature">
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <title></title>
      <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DU=
TF-8">
      <title></title>
      <div
        style=3D"font-family: calibri; padding-top: 5px; font-size: 14px"=
>
        <div>
          <table style=3D"font-size: 14px; border: none">
            <tbody>
              <tr>
                <td style=3D"color: #3d3439; font-size: 16px"> <b>-- </b>=

                </td>
              </tr>
              <tr>
                <td style=3D"color: grey">S pozdravom / Best regards</td>=

              </tr>
              <tr>
                <td style=3D"color: #3d3439; font-size: 16px"> <b>
                    Branislav Klocok </b> </td>
              </tr>
              <tr>
                <td style=3D"color: #3d3439"> <b> gener=C3=A1lny riadite=C4=
=BE /
                    general director </b> </td>
              </tr>
            </tbody>
          </table>
        </div>
        <br>
        <strong style=3D"color: #68af2d"> =C2=A0OFZ, a.s.</strong><br>
        <table style=3D"font-size: 14px; border: none">
          <tbody>
            <tr>
              <td style=3D"color: grey">Mobil:</td>
              <td style=3D"color: #3d3439"><b> +421 908 703 366</b></td>
            </tr>
            <tr>
              <td style=3D"color: grey">Tel:</td>
              <td style=3D"color: #3d3439"><b> +421 43 5804 488 </b></td>=

            </tr>
            <tr>
              <td style=3D"color: grey">e-mail:</td>
              <td style=3D"color: #3d3439"> <b> <a
                    href=3D"mailto:branislav.klocok@ofz.sk"
                    style=3D"text-decoration: none; font-size: 14px"><fon=
t
                      color=3D"#3d3439"><b>branislav.klocok@ofz.sk</b></f=
ont></a>
                </b> </td>
            </tr>
            <tr>
              <td style=3D"color: grey">web:</td>
              <td style=3D"color: #3d3439"> <b> <a
                    href=3D"http://www.ofz.company"
                    style=3D"text-decoration: none; font-size: 14px"><fon=
t
                      color=3D"#3d3439"><b>www.ofz.company</b></font></a>=

                </b> </td>
            </tr>
          </tbody>
        </table>
        <br>
        <img src=3D"cid:part1.B6T0X8n3.UB1i5Acw@ofz.sk"
          moz-do-not-send=3D"false" alt=3D"ofz logo" width=3D"56" height=3D=
"55"><br>
      </div>
    </div>
    <br>
  </body>
  <lt-container></lt-container>
</html>
--------------NOzstjsUEGqSBeXE9E4pP2W3
Content-Type: image/png; name="WdtYKUGW07EU0N07.png"
Content-Disposition: inline; filename="WdtYKUGW07EU0N07.png"
Content-Id: <part1.B6T0X8n3.UB1i5Acw@ofz.sk>
Content-Transfer-Encoding: base64

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

--------------NOzstjsUEGqSBeXE9E4pP2W3--


--------------BgIJzuS1kJ5Cdo5ir3nBsjXp--

--------------ms000208080401060609030503
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: Kryptografický podpis S/MIME

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DXQwggaWMIIEfqADAgECAhEUClHBUAcBb8MAAAAAAAAFWDANBgkqhkiG9w0BAQsFADBlMQsw
CQYDVQQGEwJTSzETMBEGA1UEBwwKQnJhdGlzbGF2YTETMBEGA1UECgwKRGlzaWcgYS5zLjEs
MCoGA1UEAwwjQ0EgRGlzaWcgUjJJNSBDZXJ0aWZpY2F0aW9uIFNlcnZpY2UwHhcNMjUwNzA5
MTQ1MTE1WhcNMjcwNzA5MTQ1MTE1WjCB6zEZMBcGA1UEAwwQQnJhbmlzbGF2IEtsb2NvazES
MBAGA1UEKgwJQnJhbmlzbGF2MQ8wDQYDVQQEDAZLbG9jb2sxETAPBgNVBAoMCE9GWiBhLnMu
MRcwFQYDVQRhDA5OVFJTSy0zNjM4OTAzMDEbMBkGA1UEBwwST3JhdnNrw70gUG9kesOhbW9r
MQswCQYDVQQGEwJTSzEmMCQGCSqGSIb3DQEJARYXYnJhbmlzbGF2Lmtsb2Nva0BvZnouc2sx
KzApBgNVBAUTIjE0MEE1MUMxNTAwNzAxNkZDMzAwMDAwMDAwMDAwMDA1NTgwggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDVwVkJC/znhqd7KPC0Qb/yxpHIUHXlq3UNh4fOIl7O
KweXhBoJCjMv+nNfA8h4YRm51n5SAZH9G87w78yU7sYBUZry0XSaXKCmCYLQ43dUw2XKec3x
n21ANOmXUCi+1P2pObWiIbn+TG0MQ5XqU4SC9g5b8909FY4gbsZqdQukmsop8DCv9BLJDAfu
Ailbi0dwHBR2b7QN628DIfRrWM4o/CabBKMxBmhS4S+d+m4I5qZhH0LhxlqL+hdZzGJPwFia
Nj5CWUve7zRcLiV8/GoZ0iCqD3NQtTgEWmeuYeOhBfMpfXg8XucaxNPtH7DK00phhO9mOLpB
LNREKEcW9+wrAgMBAAGjggG4MIIBtDAdBgNVHQ4EFgQUhDVDs3DX93zwSU7+ckeZXnkz3h8w
HwYDVR0jBBgwFoAU3Ew+R86SonfIbehl30teKvpnLY0wDgYDVR0PAQH/BAQDAgWgMHkGA1Ud
HwRyMHAwNqA0oDKGMGh0dHA6Ly9jZHAxLmRpc2lnLnNrL3N1YmNhcjJpNS9jcmwvc3ViY2Fy
Mmk1LmNybDA2oDSgMoYwaHR0cDovL2NkcDIuZGlzaWcuc2svc3ViY2FyMmk1L2NybC9zdWJj
YXIyaTUuY3JsMBMGA1UdJQQMMAoGCCsGAQUFBwMEMCQGA1UdIAQdMBswDgYMK4EekZPmCgAA
AAELMAkGB2eBDAEFAwMwgYcGCCsGAQUFBwEBBHsweTA5BggrBgEFBQcwAYYtaHR0cDovL3N1
YmNhcjJpNS1vY3NwLmRpc2lnLnNrL29jc3Avc3ViY2FyMmk1MDwGCCsGAQUFBzAChjBodHRw
Oi8vY2RuLmRpc2lnLnNrL3N1YmNhcjJpNS9jZXJ0L3N1YmNhcjJpNS5kZXIwIgYDVR0RBBsw
GYEXYnJhbmlzbGF2Lmtsb2Nva0BvZnouc2swDQYJKoZIhvcNAQELBQADggIBAKLKiBDcouOw
9idZAmpIb5CDMTbAvGuCrzNxGBKmIV0ftAKJDC+AjFmRIwqXtWZ3jvNgxYFGpnQBgQhgUhc/
v0eAc/4rZq5sZVSMUAqGLQeo+mR7Dd0z2S/ile0fvIYtb1Ig4MLTrO2R6VQj3cDVJk1a38yE
edRR48hbp7yAuKgP+Tp6gUt5FAbVrYHHz9kzhPf0wdQGpwa2d02SeVT7dHwZblYcn0ngmyhI
uVfGjPQfDC6mQVibwX3SUlgYYOZg5ykLUjzsgxN2bPweMHnPm7P2/49rHKCa2gFNbYJw5Y5u
3OsaVZXCOwRGWfJ6v7fs6r5D4s6foa/9ufSZJ6yrYgEN/+/qW6sXLKdhGx/2VnJhWR7h5RI7
EfehKp4/Q/Atyv7o60VZ5yDfUt6H7UTVhmfQETO61zXbmpDCI7Dm9naAVy0/BH3l9FYncAUM
d/bY2zZh6BcluzZX82LbSqTEot05xJrC6WaTLNDADxCH/qmq+FYcDSgYCaL8TcoqTobPzblC
e1eFcCl1M08bAoT25twgMcTG3Wqvt16g76cqNxzCUqWZ/bEx4jTxGg0DmT3O0BUH/YPhG2vq
bTKtEVnlTFEo/CtlYHl7CjFcgL5QTLmPM5y/q22L+2HtOdfKJ4hRgnbF/MDjGLtDzDPDrSez
BYjJfy7SclsN0Z8wp1ROgdVoMIIG1jCCBL6gAwIBAgIRCBsG30x5ZVCdAAAAAAAAAA4wDQYJ
KoZIhvcNAQELBQAwUjELMAkGA1UEBhMCU0sxEzARBgNVBAcTCkJyYXRpc2xhdmExEzARBgNV
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
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMzEwMzUxM1owLwYJKoZIhvcNAQkEMSIE
IPA1VzMR0lNC+i4vwsGVXxJH1DbiwnM5rTOMNlwGnseIMIGJBgkrBgEEAYI3EAQxfDB6MGUx
CzAJBgNVBAYTAlNLMRMwEQYDVQQHDApCcmF0aXNsYXZhMRMwEQYDVQQKDApEaXNpZyBhLnMu
MSwwKgYDVQQDDCNDQSBEaXNpZyBSMkk1IENlcnRpZmljYXRpb24gU2VydmljZQIRFApRwVAH
AW/DAAAAAAAABVgwgYsGCyqGSIb3DQEJEAILMXygejBlMQswCQYDVQQGEwJTSzETMBEGA1UE
BwwKQnJhdGlzbGF2YTETMBEGA1UECgwKRGlzaWcgYS5zLjEsMCoGA1UEAwwjQ0EgRGlzaWcg
UjJJNSBDZXJ0aWZpY2F0aW9uIFNlcnZpY2UCERQKUcFQBwFvwwAAAAAAAAVYMIIBVwYJKoZI
hvcNAQkPMYIBSDCCAUQwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAN
BggqhkiG9w0DAgIBBTANBggqhkiG9w0DAgIBBTAHBgUrDgMCBzANBggqhkiG9w0DAgIBBTAH
BgUrDgMCGjALBglghkgBZQMEAgEwCwYJYIZIAWUDBAICMAsGCWCGSAFlAwQCAzALBglghkgB
ZQMEAgQwCwYJYIZIAWUDBAIHMAsGCWCGSAFlAwQCCDALBglghkgBZQMEAgkwCwYJYIZIAWUD
BAIKMAsGCSqGSIb3DQEBATALBgkrgQUQhkg/AAIwCAYGK4EEAQsAMAgGBiuBBAELATAIBgYr
gQQBCwIwCAYGK4EEAQsDMAsGCSuBBRCGSD8AAzAIBgYrgQQBDgAwCAYGK4EEAQ4BMAgGBiuB
BAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAzS5gGChnxFDx6kzQaYBT/NZA8eA2
VhIbIpv2CPliJwhXdiIjI5DLXQ4uXdBcOsIOKXSSu1cPpOgwdWUHAdTR1fftAXh2BibPgYmk
s9eOEL4Wu+BT/UYn2FDcEWRllJ3JbZMp7dP16wdGCV3GVTJoEaQ2OkLDtoxskQdC9ImnQmTN
1TaFirT/KPcqn55hA+/4cEIz+O71hi5iTx/lZWBaZM3IvQUARHaaVI7vUIrVLXtwpOvbHiUS
YsGee7RiKVQSBLG+sa2HmxHh9nmyOGHSl3IfkaBip+RCVWamQ8aNKM6sBKaXS/i5u5+kJUoD
3qbLFnez497OvDB6oz0/+2rszgAAAAAAAA==
--------------ms000208080401060609030503--

