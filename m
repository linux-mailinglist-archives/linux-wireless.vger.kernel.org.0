Return-Path: <linux-wireless+bounces-37076-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD6MHN6gGGqblggAu9opvQ
	(envelope-from <linux-wireless+bounces-37076-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:09:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 026215F7E9E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 22:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F97D31E2E8F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0D32ABC0;
	Thu, 28 May 2026 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b="keGKdXab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7B26B973
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998578; cv=none; b=q9H27RJiTm3z3ghl9zjSnIfhd1tV15Nu4zEZFQSS1pDgVErzVpwikQ++0mbQVztbMn7+ANjongpthW8YeY3T5f3oFpwPsfhHmKawRGvV/4Ofyt7FUqPr7/uQ8Sg+rbgFEyv9JanNes5gin0FMwbusXV6AsnDsLLaWyh7g0PWJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998578; c=relaxed/simple;
	bh=bkOO8dK9FModpVDPstluKF/k6niX4VlQtSSGk9nVeVo=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=RrLaM8Fxr41a0TCCTyGnk9yqyagQ98Ol/fGv0QNaOWn4SSG7ns+vwSH2srLV6PnZmcLpl/7BT7X3Lrd4LQLyiozzv1U0H+jTu4o8GzGDeL8v66Tr37EA7jcXieJQhbcQh6Y3rjeA//IH4FvjDba2NBzGiC8WBM9QqlFKN9qaJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com; spf=pass smtp.mailfrom=tuta.com; dkim=pass (2048-bit key) header.d=tuta.com header.i=@tuta.com header.b=keGKdXab; arc=none smtp.client-ip=185.205.69.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuta.com
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w14.tutanota.de (Postfix) with ESMTP id C6689146CBC19
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 22:02:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779998575;
	s=s1; d=tuta.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=v4eQcVkvhKe/jFgt+8d+WXy/FAN6JPuPwLyhKhNgabU=;
	b=keGKdXabSzdKXU9xNFBtgIQbAtSJZVTGEyKsZC9QGmF5s3rhdiF8gwEOGhjO6pUs
	T7RnpMvDa83YgbI3t/zzZxLe9lwqHpx72/7VxAp7glndltJ6ADMxTgg26+rf57BmFBG
	QM76wv0B9RLikYTj9DCG2+ru2r70HY3lvZWulF03a4gNuljnlB+AMt3WtKmcU5xTYEd
	NQ1TYv4DvZAwLJKrRVAhMny7mUBYgPI5GdxKAFJAoxENwsfkX24RlWjL66UowvBEisM
	DtNcRXYrvMRNr1wqz1jTiaU8tQ4SqPnaCx+YM4mHUgTgK/F2+JJ/Bdt96ujRqQBU5DK
	0Y3QB9ts5g==
Date: Thu, 28 May 2026 22:02:55 +0200 (CEST)
From: VolcomIlluminated <volcomilluminated@tuta.com>
To: Pkshih <pkshih@realtek.com>
Cc: Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <Otk9l6D--F-9@tuta.com>
Subject: [PATCH] rtw88: usb: retry control message on -EPROTO error
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_451627_1218432542.1779998575807"
Feedback-ID: 01c4e8c013a2562e865d8b77e5b3f9fcabf876cc11e122ee288eb6e126f2764b3bcd8be2e44ea7adb908e52f58339be100204e013477eb10895d54267c0038bec6:TurnOnPrivacy!:tutamail
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tuta.com,quarantine];
	R_DKIM_ALLOW(-0.20)[tuta.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37076-lists,linux-wireless=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[tuta.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[volcomilluminated@tuta.com,linux-wireless@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 026215F7E9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------=_Part_451627_1218432542.1779998575807
Content-Type: multipart/alternative; 
	boundary="----=_Part_451628_290176836.1779998575807"

------=_Part_451628_290176836.1779998575807
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Patch Attached!
-- 
 Secured with Tuta Mail: 
 https://tuta.com/free-email

------=_Part_451628_290176836.1779998575807
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
<div dir="auto">Patch Attached!</div><div dir="auto"><br></div><div dir="auto">-- <br></div><div dir="auto"> Secured with Tuta Mail: <br></div><div dir="auto"> <a href="https://tuta.com/free-email" rel="noopener noreferrer" target="_blank">https://tuta.com/free-email</a><br></div>  </body>
</html>

------=_Part_451628_290176836.1779998575807--

------=_Part_451627_1218432542.1779998575807
Content-Type: application/octet-stream; 
	name=0002-rtw88-usb-retry-on-EPROTO-error.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; 
	filename=0002-rtw88-usb-retry-on-EPROTO-error.patch

RnJvbTogVm9sY29tSWxsdW1pbmF0ZWQgPHZvbGNvbWlsbHVtaW5hdGVkQHR1dGEuY29tPgpEYXRl
OiBXZWQsIDI4IE1heSAyMDI2IDAwOjAwOjAwICswMDAwClN1YmplY3Q6IFtQQVRDSF0gcnR3ODg6
IHVzYjogcmV0cnkgY29udHJvbCBtZXNzYWdlIG9uIC1FUFJPVE8gZXJyb3IKClVTQiBjb250cm9s
IG1lc3NhZ2VzIGNhbiB0cmFuc2llbnRseSBmYWlsIHdpdGggLUVQUk9UTyAoLTcxKSBkdXJpbmcK
ZGV2aWNlIHByb2JlIG9uIHNvbWUgVVNCIGhvc3QgY29udHJvbGxlcnMuIFRoaXMgbWFuaWZlc3Rz
IGFzIHJlcGVhdGVkCiJ3cml0ZSByZWdpc3RlciBmYWlsZWQgd2l0aCAtNzEiIGVycm9ycyBkdXJp
bmcgZHJpdmVyIGluaXRpYWxpemF0aW9uLgoKQWRkIGEgcmV0cnkgbG9vcCBvZiB1cCB0byAzIGF0
dGVtcHRzIHdpdGggMTBtcyBkZWxheSB3aGVuIC1FUFJPVE8gaXMKcmV0dXJuZWQgZnJvbSB1c2Jf
Y29udHJvbF9tc2cuIFRoaXMgcmVjb3ZlcnMgdGhlIHRyYW5zaWVudCBlcnJvciBhbmQKYWxsb3dz
IHRoZSBkcml2ZXIgdG8gaW5pdGlhbGl6ZSBjbGVhbmx5LgoKVGVzdGVkIG9uIFJUTDg4MjJCVSAo
RWRpbWF4IEVXLTc4MjJVTEMpIHdpdGggY2xlYW4gYm9vdCBhbmQgemVybwpwcm9iZSBlcnJvcnMu
CgpTaWduZWQtb2ZmLWJ5OiBWb2xjb21JbGx1bWluYXRlZCA8dm9sY29taWxsdW1pbmF0ZWRAdHV0
YS5jb20+Ci0tLQotLS0gL3RtcC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODgvdXNiLmMJMjAyNS0xMS0zMCAxNzo0MjoxMC4wMDAwMDAwMDAgLTA1MDAKKysrIC9o
b21lL3B0cHg4Nm1tMS9rZXJuZWxidWlsZC9saW51eC02LjE4L2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvdXNiLmMJMjAyNi0wNS0yNCAyMDowNjoyNy43OTgzMzcyMzcgLTA0MDAK
QEAgLTE0MCw2ICsxNDAsMTYgQEAKIAlyZXQgPSB1c2JfY29udHJvbF9tc2codWRldiwgdXNiX3Nu
ZGN0cmxwaXBlKHVkZXYsIDApLAogCQkJICAgICAgUlRXX1VTQl9DTURfUkVRLCBSVFdfVVNCX0NN
RF9XUklURSwKIAkJCSAgICAgIGFkZHIsIDAsIGRhdGEsIGxlbiwgNTAwKTsKKwlpZiAocmV0ID09
IC1FUFJPVE8pIHsKKwkJaW50IHJldHJ5OworCisJCWZvciAocmV0cnkgPSAwOyByZXRyeSA8IDMg
JiYgcmV0ID09IC1FUFJPVE87IHJldHJ5KyspIHsKKwkJCW1zbGVlcCgxMCk7CisJCQlyZXQgPSB1
c2JfY29udHJvbF9tc2codWRldiwgdXNiX3NuZGN0cmxwaXBlKHVkZXYsIDApLAorCQkJCQkgICAg
ICBSVFdfVVNCX0NNRF9SRVEsIFJUV19VU0JfQ01EX1dSSVRFLAorCQkJCQkgICAgICBhZGRyLCAw
LCBkYXRhLCBsZW4sIDUwMCk7CisJCX0KKwl9CiAJaWYgKHJldCA8IDAgJiYgcmV0ICE9IC1FTk9E
RVYgJiYgY291bnQrKyA8IDQpCiAJCXJ0d19lcnIocnR3ZGV2LCAid3JpdGUgcmVnaXN0ZXIgMHgl
eCBmYWlsZWQgd2l0aCAlZFxuIiwKIAkJCWFkZHIsIHJldCk7Cg==
------=_Part_451627_1218432542.1779998575807--

