Return-Path: <linux-wireless+bounces-36384-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE1UKkhjBGq6HgIAu9opvQ
	(envelope-from <linux-wireless+bounces-36384-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 13:40:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E00085326C6
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 13:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A60DA3025D02
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362CA3F9F49;
	Wed, 13 May 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ofz.sk header.i=@ofz.sk header.b="S/wLSr4y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ofz.onice.io (ofz.onice.io [185.119.216.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5CF3FA5D8
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.119.216.231
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672453; cv=pass; b=pHMROp4FCNo87Ej1HIkqh5S6xKy4w157z0VnD5ijfIkSZ2h/1oIb81CEHURnmek7t+aMdM6QdchQFAvF5yHdd7ws8fT2Ngs6JJC97T/+5s1cHcWXZSZt06umXwLwgNTV9dqRyFbHJs73CR5YCmzm9qlPfHWWICPBZXpQYDqSY8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672453; c=relaxed/simple;
	bh=SkEVKmGj0j6SESWCEqhwnClr+BhK4+4o1A3Hzm4olng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDw+lRZh4pXWD7RnznhIM8M1961o8EFet48Beg8dSngHzT5KvUo6+IDrdZdZ8d6L0f0kpP3bWWn07I2zY5DCb1AMCRRp8n0g4zPYn2lknmBxipN3iEmCWvVAjumHE6UtwNxPiJZ+y5kAlo3XShnzHeR1FJRPWW7XD0f+JobKKAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ofz.sk; spf=pass smtp.mailfrom=ofz.sk; dkim=pass (2048-bit key) header.d=ofz.sk header.i=@ofz.sk header.b=S/wLSr4y; arc=pass smtp.client-ip=185.119.216.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ofz.sk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ofz.sk
ARC-Seal: i=1; a=rsa-sha256; t=1778672448; cv=none; d=ofz.sk; s=onice-selector1;
   b=UPmtWJ0VcNZ0QqzdepfOwMigxfbwAT96wi6po/uNunhJ/dr+3R18b9hyn7XBfsFKDXtDQTe+adj0ZC0HslYrU/IZhXKKLvVaDqMRqk4QRqkEERIJnw6ctrONRdn+Ydp3KSpgiW4BP3mLbA75Z24pbClHPc1NgslCCal0dP9gmqlGL//RBdiUvjClqrNx1sowQkg/uNFxI65cOyqySzHn1bYze0JJMNqYUVUPi+TSk4W7+ym6xQu33L6ImeG8nRV9yA9ClRUW8WmuoWKjdj6UK1jzr5oMv8TzCNrSSKHHPrg8aYYJJxJyM+5yAiF3aXtGVTNW6QBio1CD94UYmP7/kw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=onice-selector1; d=ofz.sk; c=relaxed/relaxed; bh=LS3+kf2qBu6e/Bz1eWUA4ytxL1b80/KO//gLR1TEKss=; h=to:from:subject:message-id:date:mime-version:dkim-signature;
   b=Rkm54ezCPdvE88N+pmaKUfJyhSSDrAKUFDqZC7lUyI8HVg8OONNEBrqDQA9CVn7YyiEZdp/qUhwfzWXuhYW0vGpkxoYs7Q7qTlUMA+VlY40nXFoX85YeyFy9Jwy1lxZpHdTetlY/T2YqW//QbUSVFaw6KGngDkSQh0kmFMi8RwWi0rzzQoV92cnUEs12xxV+S6nZ8ibfF5UtkoKQQ1LG9ID5F5xd05Sc6Sc1g5sFW804vvbXlsEYUN6otZ2F+/agiMHSuTKprSXwBrXw+lhyAsvQx8+MukJr6stxGkyOpS9o5dAp8fSKbaF4oZIV3cZE5UzExAuvovCrmr7t8jaLvQ==
ARC-Authentication-Results: i=1; ofz.onice.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; t=1778672448; x=1779277248; s=onice-selector1; d=ofz.sk; c=relaxed/relaxed; bh=LS3+kf2qBu6e/Bz1eWUA4ytxL1b80/KO//gLR1TEKss=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:In-Reply-To:References;
   b=S/wLSr4yZLU5Rs2RvmP6YiWAE+MCGS16HjriIu+8GtEA8Zq1K/YCp4xOFAscfuOb1dcTGDgAUi0owYVBXbwWLwUGqbp2JCVj9eopbdhXAiQkLqPGHZ4MtMplPxxEP2bhBVtOR/Jlf5Ijskj1slUCWYHmrlCat8ignL7UzxSH6Htd624v0v216/lQiJFVR6R59hQJHDzNG0MpA+BoxS11r46BntJbc3QQoUGvH+qbUHBmmwV+1XF9GcuWkQiDAsBPkRDhv1rP7dMVD0xM4Ag25hjFkvcq25RHo6kJiJ/5+4D3QReHroKcnA1mFMqfyKx+CqJIUluqu5jc/bWXqb8fbw==
Received: from [192.168.20.135] ([80.87.210.74])
        by ofz.onice.io (14.3.0 build 3 ) with ASMTP (SSL) id 202605131340474143;
        Wed, 13 May 2026 13:40:47 +0200
Message-ID: <c867401c-bfc5-4e9f-b78e-be5348b2a776@ofz.sk>
Date: Wed, 13 May 2026 13:40:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] iwlwifi 8265 firmware ADVANCED_SYSASSERT in
 PHY_CONTEXT_CMD on roam (v7.0.3..v7.0.5)
Content-Language: en-US, sk-SK
To: Johannes Berg <johannes@sipsolutions.net>, regressions@lists.linux.dev
Cc: linux-wireless@vger.kernel.org
References: <d2ffd82d-01cb-470e-bb02-70c163c61216@ofz.sk>
 <34084815328ea9ea00893e9aa46962d369d213e3.camel@sipsolutions.net>
From: Branislav Klocok <branislav.klocok@ofz.sk>
In-Reply-To: <34084815328ea9ea00893e9aa46962d369d213e3.camel@sipsolutions.net>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050404080608070500090702"
X-Rspamd-Queue-Id: E00085326C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ofz.sk,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/alternative,text/plain,multipart/related];
	R_DKIM_ALLOW(-0.20)[ofz.sk:s=onice-selector1];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36384-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~,6:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ofz.sk:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[branislav.klocok@ofz.sk,linux-wireless@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is a cryptographically signed message in MIME format.

--------------ms050404080608070500090702
Content-Type: multipart/alternative;
 boundary="------------zLore7Fb0VSPF7s4wzVGA1la"

--------------zLore7Fb0VSPF7s4wzVGA1la
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSm9oYW5uZXMsDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIGNoZWNrLiBJIGR1ZyBhIGJp
dCBmdXJ0aGVyOyB0aGUgdjcuMC4zLi52Ny4wLjUgDQp3aW5kb3cgaXMgd2hhdCBJIGVtcGly
aWNhbGx5IHNlZSAoY2xlYW4gLT4gY3Jhc2hpbmcgb24gZXZlcnkgDQpjb250cm9sbGVyLWRy
aXZlbiByb2FtKSwgYnV0IHRoZSBjYXVzZSBsaWtlbHkgc2l0cyBvdXRzaWRlIGl3bHdpZmkg
YXMgDQp5b3Ugc3VnZ2VzdGVkLg0KDQpXaGF0IEkgY2FuIGNvbmZpcm0gZnJvbSB0aGUgb3Bl
blNVU0UgVHVtYmxld2VlZCBwYWNrYWdpbmcgc2lkZToNCg0KLSBCZXR3ZWVuIGtlcm5lbC1k
ZWZhdWx0LTcuMC4zLTEuMSAoaW5zdGFsbGVkIDIwMjYtMDUtMDggMjE6NDUpIGFuZCANCjcu
MC41LTEuMSAoMjAyNi0wNS0xMCAyMToyNSksIG9ubHkgdGhlIGtlcm5lbCBwYWNrYWdlIGNo
YW5nZWQuIA0Ka2VybmVsLWZpcm13YXJlLWludGVsIHdhcyBidW1wZWQgdG8gMjAyNjA1MDUt
MS4xIGluIHRoZSBzYW1lIHRyYW5zYWN0aW9uIA0KYXMgNy4wLjMgb24gMjAyNi0wNS0wOCBh
bmQgc3RheWVkIHVuY2hhbmdlZCBhY3Jvc3MgdGhlIDcuMC41IGluc3RhbGwgDQooODI2NSB1
Y29kZSAzNi5jOGU4ZTE0NC4wIGlzIGlkZW50aWNhbCBpbiBib3RoIGRtZXNnIGJhbm5lcnMp
LiANCk5ldHdvcmtNYW5hZ2VyIDEuNTQuMy0zLjQgYW5kIHdwYV9zdXBwbGljYW50IDIuMTEt
Ni4zIHdlcmUgbGFzdCB0b3VjaGVkIA0Kb24gMjAyNi0wNS0wNCwgYWxzbyB1bmNoYW5nZWQg
YWNyb3NzIHRoaXMgd2luZG93LiBVc2Vyc3BhY2UgYW5kIGZpcm13YXJlIA0KYmxvYiBjYW4g
YmUgcnVsZWQgb3V0IGFzIHRoZSB0cmlnZ2VyLg0KDQotIFRoZSBvbmx5IGl3bHdpZmktdG91
Y2hpbmcgU1VTRSBwYXRjaCBhZGRlZCBiZXR3ZWVuIHRoZSA3LjAuMyBhbmQgNy4wLjUgDQpz
b3VyY2UgcGFja2FnZXMgaXMgaXdsd2lmaS1kZWNsYXJlLW1pc3NpbmctZmlybXdhcmUtZmls
ZXMucGF0Y2ggaW4gDQo3LjAuNCwgd2hpY2ggaXMgbWV0YWRhdGEtb25seSAoaXQganVzdCBh
ZGRzIE1PRFVMRV9GSVJNV0FSRSgpIGVudHJpZXMpLiANClRoZSByZXN0IG9mIHRoZSBkaWZm
IGlzIHBsYWluIHN0YWJsZSB2Ny4wLjMuLnY3LjAuNS4NCg0KLSBDYXZlYXQgb24gbXkgIjcu
MC4zIHdvcmtlZCIgY2xhaW06IGl0IGlzIGJhc2VkIG9uIGEgc2hvcnQgYm9vdCBpbnRvIA0K
Ny4wLjMgb24gMjAyNi0wNS0xMSBiZWZvcmUgYm9vdGluZyA3LjAuNTsgSSB3aWxsIHJlLXRl
c3QgNy4wLjMgb3ZlciBhIA0KbG9uZ2VyIHdpbmRvdyB3aXRoIGZvcmNlZCByb2FtcyB0byBi
ZSBzdXJlLg0KDQpDcmFzaCBpdHNlbGY6IEFEVkFOQ0VEX1NZU0FTU0VSVCAoMHgwMDAwMTRG
RCkgKyBOTUlfSU5URVJSVVBUX0xNQUNfRkFUQUwgDQooMHg3MCkgb24gUEhZX0NPTlRFWFRf
Q01EIGR1cmluZyBubDgwMjExX2F1dGhlbnRpY2F0ZS4gfjg3ICUgb2YgDQpjb250cm9sbGVy
LWRyaXZlbiByb2FtcyB0cmlnZ2VyIGl0ICgxNC8xNiBvYnNlcnZlZCk7IGNhc2NhZGluZyBy
ZXN0YXJ0IA0KbG9vcHMgKDZ4IGluIDIzIHMpIG9uIGJhZCBkYXlzLiBOTSBwb3dlcnNhdmU9
MiAoQ0FNKSBkb2VzIG5vdCBzdXBwcmVzcyANCml0LiBGdWxsIGpvdXJuYWwgYXQgaHR0cHM6
Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjE1MTIgDQooYXR0YWNo
bWVudCAzMTAxMDYpLg0KDQpBIGNvdXBsZSBvZiBxdWVzdGlvbnMsIGlmIHlvdSBoYXZlIGEg
bW9tZW50Og0KDQoxLiBJcyB0aGVyZSBhbiBpd2xtdm0gZGVidWcga25vYiB5b3UnZCBsaWtl
IGVuYWJsZWQgb24gdGhlIG5leHQgDQpyZXByb2R1Y3Rpb24gKGl3bHdpZmkuZGVidWc9LCBk
ZXZjb3JlZHVtcCwgZndfZGJnX2NvbGxlY3QpIHRvIGNhcHR1cmUgDQptb3JlIG9uIHdoYXQg
UEhZX0NPTlRFWFRfQ01EIGlzIGhpdHRpbmc/DQoNCjIuIEdpdmVuIGl3bHdpZmkvbWFjODAy
MTEgaXMgdW5jaGFuZ2VkLCB3b3VsZCB5b3UgcG9pbnQgYXQgYSB0aWdodGVyIA0KY2FuZGlk
YXRlIGFyZWEgaW4gdjcuMC4zLi52Ny4wLjUgKFBDSSBQTSwgZmlybXdhcmUgbG9hZGVyLCBz
Y2hlZHVsZXIpIA0KYmVmb3JlIEkgYXR0ZW1wdCBhIGJpc2VjdCBhY3Jvc3MgdGhlIGZ1bGwg
dHJlZT8NCg0KKi0tICoNClMgcG96ZHJhdm9tIC8gQmVzdCByZWdhcmRzDQoqQnJhbmlzbGF2
IEtsb2NvayAqDQoqZ2VuZXLDoWxueSByaWFkaXRlxL4gLyBnZW5lcmFsIGRpcmVjdG9yICoN
Cg0KDQoqwqBPRlosIGEucy4qDQpNb2JpbDogCSorNDIxIDkwOCA3MDMgMzY2Kg0KVGVsOiAJ
Kis0MjEgNDMgNTgwNCA0ODggKg0KZS1tYWlsOiAJKipicmFuaXNsYXYua2xvY29rQG9mei5z
ayogPG1haWx0bzpicmFuaXNsYXYua2xvY29rQG9mei5zaz4gKg0Kd2ViOiAJKip3d3cub2Z6
LmNvbXBhbnkqIDxodHRwOi8vd3d3Lm9mei5jb21wYW55PiAqDQoNCg0Kb2Z6IGxvZ28NCg0K
RMWIYSAxMy4gNS4gMjAyNiBvIDEyOjQxIEpvaGFubmVzIEJlcmcgbmFww61zYWwoYSk6DQo+
IE9uIFdlZCwgMjAyNi0wNS0xMyBhdCAxMjozNSArMDIwMCwgQnJhbmlzbGF2IEtsb2NvayB3
cm90ZToNCj4+ICDCoCNyZWd6Ym90IGludHJvZHVjZWQ6IHY3LjAuMy4udjcuMC41DQo+IFRo
YXQgY2Fubm90IGJlIHJpZ2h0LCB0aGVyZSBhcmUgbm8gcGF0Y2hlcyBmb3Igd2lmaSBiZXR3
ZWVuIHRob3NlIGV4Y2VwdA0KPiBhIGhhbmRmdWwgaW4gZHJpdmVycyB5b3UncmUgbm90IHJ1
bm5pbmcuDQo+DQo+IGpvaGFubmVzDQoNCg==
--------------zLore7Fb0VSPF7s4wzVGA1la
Content-Type: multipart/related;
 boundary="------------brC4LOEyKqWe5li5xWyMVOrp"

--------------brC4LOEyKqWe5li5xWyMVOrp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html data-lt-installed=3D"true">
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body style=3D"padding-bottom: 1px;">
    Hi Johannes,<br>
    <br>
    Thanks for the quick check. I dug a bit further; the v7.0.3..v7.0.5
    window is what I empirically see (clean -&gt; crashing on every
    controller-driven roam), but the cause likely sits outside iwlwifi
    as you suggested.<br>
    <br>
    What I can confirm from the openSUSE Tumbleweed packaging side:<br>
    <br>
    - Between kernel-default-7.0.3-1.1 (installed 2026-05-08 21:45) and
    7.0.5-1.1 (2026-05-10 21:25), only the kernel package changed.
    kernel-firmware-intel was bumped to 20260505-1.1 in the same
    transaction as 7.0.3 on 2026-05-08 and stayed unchanged across the
    7.0.5 install (8265 ucode 36.c8e8e144.0 is identical in both dmesg
    banners). NetworkManager 1.54.3-3.4 and wpa_supplicant 2.11-6.3 were
    last touched on 2026-05-04, also unchanged across this window.
    Userspace and firmware blob can be ruled out as the trigger.<br>
    <br>
    - The only iwlwifi-touching SUSE patch added between the 7.0.3 and
    7.0.5 source packages is
    iwlwifi-declare-missing-firmware-files.patch in 7.0.4, which is
    metadata-only (it just adds MODULE_FIRMWARE() entries). The rest of
    the diff is plain stable v7.0.3..v7.0.5.<br>
    <br>
    - Caveat on my "7.0.3 worked" claim: it is based on a short boot
    into 7.0.3 on 2026-05-11 before booting 7.0.5; I will re-test 7.0.3
    over a longer window with forced roams to be sure.<br>
    <br>
    Crash itself: ADVANCED_SYSASSERT (0x000014FD) +
    NMI_INTERRUPT_LMAC_FATAL (0x70) on PHY_CONTEXT_CMD during
    nl80211_authenticate. ~87 % of controller-driven roams trigger it
    (14/16 observed); cascading restart loops (6x in 23 s) on bad days.
    NM powersave=3D2 (CAM) does not suppress it. Full journal at
    <a class=3D"moz-txt-link-freetext" href=3D"https://bugzilla.kernel.or=
g/show_bug.cgi?id=3D221512">https://bugzilla.kernel.org/show_bug.cgi?id=3D=
221512</a> (attachment
    310106).<br>
    <br>
    A couple of questions, if you have a moment:<br>
    <br>
    1. Is there an iwlmvm debug knob you'd like enabled on the next
    reproduction (iwlwifi.debug=3D, devcoredump, fw_dbg_collect) to
    capture more on what PHY_CONTEXT_CMD is hitting?<br>
    <br>
    2. Given iwlwifi/mac80211 is unchanged, would you point at a tighter
    candidate area in v7.0.3..v7.0.5 (PCI PM, firmware loader,
    scheduler) before I attempt a bisect across the full tree?<br>
    <br>
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
        <img src=3D"cid:part1.22iAci5J.YSAEd5jp@ofz.sk"
          moz-do-not-send=3D"false" alt=3D"ofz logo" width=3D"56" height=3D=
"55"><br>
      </div>
    </div>
    <br>
    <div class=3D"moz-cite-prefix">D=C5=88a 13. 5. 2026 o 12:41 Johannes =
Berg
      nap=C3=ADsal(a):<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:34084815328ea9ea00893e9aa46962d369d213e3.camel@sipsolutions.n=
et">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Wed, 2026-05-13 at 12:35 =
+0200, Branislav Klocok wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">=C2=A0#regzbot introduced:=
 v7.0.3..v7.0.5
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
That cannot be right, there are no patches for wifi between those except
a handful in drivers you're not running.

johannes
</pre>
    </blockquote>
    <br>
  </body>
  <lt-container></lt-container>
</html>
--------------brC4LOEyKqWe5li5xWyMVOrp
Content-Type: image/png; name="FWbyySErjYKwOByv.png"
Content-Disposition: inline; filename="FWbyySErjYKwOByv.png"
Content-Id: <part1.22iAci5J.YSAEd5jp@ofz.sk>
Content-Transfer-Encoding: base64

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

--------------brC4LOEyKqWe5li5xWyMVOrp--


--------------zLore7Fb0VSPF7s4wzVGA1la--

--------------ms050404080608070500090702
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
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDUxMzExNDA0NVowLwYJKoZIhvcNAQkEMSIE
IIXZ+cDfFtL993BMEjlxr23D9M5JLHCHOeiktHd/4fFZMIGJBgkrBgEEAYI3EAQxfDB6MGUx
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
BAEOAjAIBgYrgQQBDgMwDQYJKoZIhvcNAQEBBQAEggEAO7d3C7Fu9EfRcQ/eO8nfc6mlfnIT
DnsRgIcpV9iyiNmp+dz8lViGSw+9oD+0RNM1iVJ2rmJXmF3y1ZhlYZBRRo5Tm5WktA4y+kTP
dPdjosVa1x5Dq8A6zc6fZLkjcKpEpeeL/jUaUbj6KA+wWc1Q/6adQPo7idMPkrSORJLYjRBr
8EVzJFd4uhxqc1l41duf/BTpsHwqt+GvYevIY3oGwvUVtY+RG07GtUXH7F2w03S0nI5qGQWf
CuNmUJT3fhDzOW6i4qM22os0LEycrmTuLiOsYkIJgSyiVUgzrvJP2712nS0eAksWyT2MVOFM
amrsfpMNMGqZGUV+6elc5zkyoAAAAAAAAA==
--------------ms050404080608070500090702--

