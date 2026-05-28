Return-Path: <linux-wireless+bounces-37077-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eE4XMQSkGGrClggAu9opvQ
	(envelope-from <linux-wireless+bounces-37077-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:22:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EB75F87C8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5422E321B8DB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 20:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36333D4E2;
	Thu, 28 May 2026 20:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b="JaitQBXd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A23451AB
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 20:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999308; cv=none; b=hf4BzwgY9pAPKlc6FTVGwJa/UCSNgFBXPFj7snRfmv/PZ9iamuYNeDBCpGOXzXt7xrutLgMBPc56we88MJeVdEp6pgb4qeN0WJLYuT+NVfWtinJmr15Z+1eL07jW7H/IIo3rdbFv8WQj+gftWJinV43jRQZiLFOeWu/hyuc+BNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999308; c=relaxed/simple;
	bh=WHyw+JVtQUlJyz63qHEUu9Wcw1mUMrPgrHpK+Du3asE=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=g28Kr9U8ihuebBLHmHo47VDaiGeDl08vUCJEolEl/wNIdTun+bG/tXR9YmY+tlXVhrqFEZCvSWbqGgsGw9xdKHZ8XwLggw43ERw5y3oH4phZ9BaovbLozGhD36IdRSem6FR0r5h5KmX1FHxVjDrT3/viN2UDyPhTmD7IKwMVUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com; spf=pass smtp.mailfrom=tuta.com; dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b=JaitQBXd; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id D5795146CD412
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 22:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779999305;
	s=s1; d=tuta.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=xNpuUUMUvuKzi53YKiPub5upFtJEl1El4823NJEA7qQ=;
	b=JaitQBXd2EtkOVCuovr4/zOqikdV+BuJCSxQUBpXcEBe1GZEUZOpER8qbEFxtc7a
	48b9VzQf2ahbBCvftsPPlj/wcgN6yTvXf7XT5s3aDDsEvqbdyZU4n6QBbL4VXJCwY8F
	RI2vXhdP6Qj73YijMpW0BBWQdd+I3sl4f+gUN1dTxmoKUTZZw/Qd2HnDmd2LQhTHg1L
	EnD6+cGDJQCcvy7aVitBMxeom/dLJt+d7+iiQ4hwe5eJfKkz0SSvBORg5towaHWAMvG
	bT/ademMhv5aGnmY7SE1u+OQn/pOfwxJqInj4sW66SwB3tcH88qgBJDAQ5ArUmKs5q0
	n8h7TdUUGQ==
Date: Thu, 28 May 2026 22:15:05 +0200 (CEST)
From: VolcomIlluminated <volcomilluminated@tuta.com>
To: Nbd <nbd@nbd.name>
Cc: Lorenzo <lorenzo@kernel.org>,
	Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <OtkCFL4--F-9@tutanota.com>
Subject: [PATCH] mt76: mt76x02: fix SKB memory leak on error path in USB MCU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_452607_1050536059.1779999305869"
Feedback-ID: 01c4e8c013a2562e865d8b77e5b3f9fcabf876cc11e122ee288eb6e126f2764b3bcd8be2e44ea7adb908e52f58339be100204e013477eb10895d54267c0038bec6:TurnOnPrivacy!:tutamail
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tuta.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tuta.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37077-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[volcomilluminated@tuta.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[tuta.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tutanota.com:mid]
X-Rspamd-Queue-Id: 25EB75F87C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------=_Part_452607_1050536059.1779999305869
Content-Type: multipart/alternative; 
	boundary="----=_Part_452608_1144420732.1779999305869"

------=_Part_452608_1144420732.1779999305869
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patch Attached!
-- 
 Secured with Tuta Mail: 
 https://tuta.com/free-email

------=_Part_452608_1144420732.1779999305869
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
<div dir="auto">Patch Attached!</div><div dir="auto"><br></div><div dir="auto">-- <br></div><div dir="auto"> Secured with Tuta Mail: <br></div><div dir="auto"> <a href="https://tuta.com/free-email" rel="noopener noreferrer" target="_blank">https://tuta.com/free-email</a><br></div>  </body>
</html>

------=_Part_452608_1144420732.1779999305869--

------=_Part_452607_1050536059.1779999305869
Content-Type: application/octet-stream; 
	name=0005-mt76-mt76x02-fix-SKB-memory-leak-on-error-path.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; 
	filename=0005-mt76-mt76x02-fix-SKB-memory-leak-on-error-path.patch

RnJvbTogVm9sY29tSWxsdW1pbmF0ZWQgPHZvbGNvbWlsbHVtaW5hdGVkQHR1dGEuY29tPgpEYXRl
OiBXZWQsIDI4IE1heSAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbXQ3Njog
bXQ3NngwMjogZml4IFNLQiBtZW1vcnkgbGVhayBvbiBlcnJvciBwYXRoIGluIFVTQiBNQ1UKCldo
ZW4gbXQ3NngwMnVfc2tiX2RtYV9pbmZvKCkgZmFpbHMsIHRoZSBmdW5jdGlvbiByZXR1cm5zIGlt
bWVkaWF0ZWx5CndpdGhvdXQgY2FsbGluZyBjb25zdW1lX3NrYigpLCBsZWFraW5nIHRoZSBTS0Ig
YWxsb2NhdGlvbi4KClJlcGxhY2UgdGhlIGVhcmx5IHJldHVybiB3aXRoIGEgZ290byB0byB0aGUg
ZXhpc3Rpbmcgb3V0IGxhYmVsIHdoaWNoCmNhbGxzIGNvbnN1bWVfc2tiKCkgdW5jb25kaXRpb25h
bGx5LgoKVGhpcyBhZGRyZXNzZXMgQ1ZFLTIwMjItNTAxNzIuCgpUZXN0ZWQgb24gTmV0Z2VhciBB
NjIxMCAoTVQ3NngyVSkgd2l0aCAxLDY0MCBwYWNrZXRzIGFuZCB6ZXJvIGRyb3BzCm92ZXIgMisg
aG91cnMgb2YgY29udGludW91cyBvcGVyYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBWb2xjb21JbGx1
bWluYXRlZCA8dm9sY29taWxsdW1pbmF0ZWRAdHV0YS5jb20+Ci0tLQotLS0gL3RtcC9saW51eC02
LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYvbXQ3NngwMl91c2JfbWN1LmMJ
MjAyNS0xMS0zMCAxNzo0MjoxMC4wMDAwMDAwMDAgLTA1MDAKKysrIC9ob21lL3B0cHg4Nm1tMS9r
ZXJuZWxidWlsZC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL21lZGlhdGVrL210NzYv
bXQ3NngwMl91c2JfbWN1LmMJMjAyNi0wNS0yNSAyMToyMjoxNS4yMDA2MTA0MDEgLTA0MDAKQEAg
LTkwLDcgKzkwLDcgQEAKIAkgICAgICAgTVRfTUNVX01TR19UWVBFX0NNRDsKIAlyZXQgPSBtdDc2
eDAydV9za2JfZG1hX2luZm8oc2tiLCBDUFVfVFhfUE9SVCwgaW5mbyk7CiAJaWYgKHJldCkKLQkJ
cmV0dXJuIHJldDsKKwkJZ290byBvdXQ7CiAKIAlyZXQgPSBtdDc2dV9idWxrX21zZyhkZXYsIHNr
Yi0+ZGF0YSwgc2tiLT5sZW4sIE5VTEwsIDUwMCwKIAkJCSAgICAgTVRfRVBfT1VUX0lOQkFORF9D
TUQpOwo=
------=_Part_452607_1050536059.1779999305869--

