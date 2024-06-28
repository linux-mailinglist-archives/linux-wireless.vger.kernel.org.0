Return-Path: <linux-wireless+bounces-9679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA3091B59C
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 05:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EAA283551
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 03:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857520319;
	Fri, 28 Jun 2024 03:56:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F92914;
	Fri, 28 Jun 2024 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546964; cv=none; b=s3TDcyUwlHUxIvUqkosdvH4Ftlov5am3mpX5Y4dUCN1kctrXJjR7Q2mbB5LdBz+lbtFE0RfOOHAfjDwzzdMBjQKefFqEsAIe0P1F5/HJ2KdPYMx4PstUEprjTh/0AYe2EF4wFWrTE1xPE0Ggb7GoWdxL91EuPvdqtb1Wnzv/G7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546964; c=relaxed/simple;
	bh=Wkmvw8dbQPrJwiozcOR16C2Hm+Vhj/iMIRBYaAco/Gc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kuMH32RuRIOZVvoskZeZBa06J6ME5g9FuAwE6Mpio/Csv4CtGfsiSvh3HOU4EePPzKYP2iB0wnEhwaSJs8LD0vFyNka0yBzaApuivpctvatJJwnAjBAM5Kj+vfQ9bsrDjG84p1tD7C7qCdtqE8JRY+7agMSF5aQS1M/lGOt4kxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45S3thwrF4028403, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45S3thwrF4028403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 11:55:43 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 11:55:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 28 Jun 2024 11:55:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 28 Jun 2024 11:55:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Forty Five <mathewegeorge@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bernie Huang
	<phhuang@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Topic: [REGRESSION] Freeze on resume from S3 (bisected)
Thread-Index: AQHawgusbA+C/SyMRES67Y/3y6K7kbHOmQDAgAALtgCAAakyAP//jZeAgABJegCADGz2EA==
Date: Fri, 28 Jun 2024 03:55:43 +0000
Message-ID: <8583c53fa42848c9855b2b425ac18ca4@realtek.com>
References: <87tthpwkqf.fsf@gmail.com>
 <2ce41d4129234ba9a91d5b4dcd8a40ee@realtek.com> <87sex93s63.fsf@gmail.com>
 <6970398610c546b1b62e599902c67572@realtek.com>
 <E3FF7BC1-725B-40E2-AAF0-CA41A44B9DF9@gmail.com> <87jzij7mrk.fsf@gmail.com>
In-Reply-To: <87jzij7mrk.fsf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: multipart/mixed;
	boundary="_002_8583c53fa42848c9855b2b425ac18ca4realtekcom_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

--_002_8583c53fa42848c9855b2b425ac18ca4realtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mathew,

Forty Five <mathewegeorge@gmail.com> wrote:
>=20
> Mathew George <mathewegeorge@gmail.com> writes:
>=20
> > When I am back at my system, I will reproduce the issue a few more time=
s with
> > this kernel, and attach the logs. In the meantime, you could have a loo=
k at the logs
> > linked in my first mail. There are logs for most of the bad commits enc=
ountered in the
> > bisection.
>=20
> I've attached more logs.

Thanks for the logs, which you met two kinds of problems. One is firmware g=
ets
wrong during system resumes, and the other is to close a disappear netdev.=
=20
However I still can't dig why it gets wrong. I will focus on latter one fir=
st.

The behavior between no commit [1] and the latest tree + [2] is the time wa=
iting
for ACK from scan abort firmware command. The former one is longer, and lat=
ter
one is shorter.=20

I also enable kernel debug KASAN suggested by Johannes to dig problem, but =
in
my side I can't see any kernel warning and the crash.=20

Since I saw 'NetworkManager' and 'hostapd' in code trace, I would like to k=
now
if you have two virtual interfaces, which for STA and AP modes? (Please che=
ck
this by 'iw dev') If so, is it possible to remove hostapd (AP mode) to see =
if
this is a factor causing crash.

Attachment is a debug patch that add more messages and code trace, please h=
elp
to reproduce problem with patches of [2] and attachment. If your kernel ena=
bles
dynamic debug, need additional commands to have debug message:
   sudo bash -c 'echo -n "module rtw89_core +p" > /sys/kernel/debug/dynamic=
_debug/control'
   sudo bash -c 'echo -n "module rtw89_pci +p" > /sys/kernel/debug/dynamic_=
debug/control'
Since there are more than one symptoms causing system freeze, please collec=
t
four logs as before. Also please give me two logs that system can normally
suspend/resume, so I can compare their difference.


[1] bcbefbd032 wifi: rtw89: add wait/completion for abort scan
[2] https://lore.kernel.org/linux-wireless/20240517013350.11278-1-pkshih@re=
altek.com/

Thanks
Ping-ke


--_002_8583c53fa42848c9855b2b425ac18ca4realtekcom_
Content-Type: application/octet-stream; name="0001-debug-scan-abort.patch"
Content-Description: 0001-debug-scan-abort.patch
Content-Disposition: attachment; filename="0001-debug-scan-abort.patch";
	size=7181; creation-date="Fri, 28 Jun 2024 03:18:32 GMT";
	modification-date="Fri, 28 Jun 2024 03:18:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZGVjNzAyMDdhYjYyYzg3ZTJmOWIzYTIzMjE2NmUwN2MzMjYwZjM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KRGF0
ZTogRnJpLCAyOCBKdW4gMjAyNCAxMToxNzo1OSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGRlYnVn
IHNjYW4gYWJvcnQKClNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPgotLS0KIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZGVidWcuYyAgICB8
ICAyICstCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMgICAgICAgfCAg
NSArKysKIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgICAgICB8ICA0
ICsrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYzgwMjExLmMgfCA0MiAr
KysrKysrKysrKysrKysrLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3Bj
aS5jICAgICAgfCAgNCArKwogNSBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCA3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvZGVidWcuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZGVidWcuYwpp
bmRleCA0OWJiYmQwNDkzMTYuLjQ3MDlkNTBiOGZhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9kZWJ1Zy5jCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvZGVidWcuYwpAQCAtMTQsNyArMTQsNyBAQAogI2luY2x1ZGUgInNhci5o
IgogCiAjaWZkZWYgQ09ORklHX1JUVzg5X0RFQlVHTVNHCi11bnNpZ25lZCBpbnQgcnR3ODlfZGVi
dWdfbWFzazsKK3Vuc2lnbmVkIGludCBydHc4OV9kZWJ1Z19tYXNrID0gMHg4MDAyMTAwMDsKIEVY
UE9SVF9TWU1CT0wocnR3ODlfZGVidWdfbWFzayk7CiBtb2R1bGVfcGFyYW1fbmFtZWQoZGVidWdf
bWFzaywgcnR3ODlfZGVidWdfbWFzaywgdWludCwgMDY0NCk7CiBNT0RVTEVfUEFSTV9ERVNDKGRl
YnVnX21hc2ssICJEZWJ1Z2dpbmcgbWFzayIpOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9mdy5jCmluZGV4IGZiZTA4YzE2MmI5My4uZWVjYjQzYWQ2NzM1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMKKysrIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jCkBAIC00ODU1LDYgKzQ4NTUsOSBAQCBpbnQgcnR3
ODlfZndfaDJjX3NjYW5fb2ZmbG9hZChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsCiAJZWxzZQog
CQljb25kID0gUlRXODlfU0NBTk9GTERfV0FJVF9DT05EX1NUT1A7CiAKKwlwcmludGsoInBrPiAl
czolZCBzdGFydCBzY2FuIG9mZmxvYWQgYWJvcnQ9JWRcbiIsIF9fZnVuY19fLCBfX0xJTkVfXywK
KwkJIW9wdGlvbi0+ZW5hYmxlKTsKKwogCXJldCA9IHJ0dzg5X2gyY190eF9hbmRfd2FpdChydHdk
ZXYsIHNrYiwgd2FpdCwgY29uZCk7CiAJaWYgKHJldCkgewogCQlydHc4OV9kZWJ1ZyhydHdkZXYs
IFJUVzg5X0RCR19GVywgImZhaWxlZCB0byBzY2FuIG9mbGRcbiIpOwpAQCAtNjI2Nyw2ICs2Mjcw
LDggQEAgdm9pZCBydHc4OV9od19zY2FuX2NvbXBsZXRlKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
diwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAlpZiAoIXZpZikKIAkJcmV0dXJuOwogCisJ
cHJpbnRrKCJwaz4gJXM6JWQgYWJvcnQ9JWRcbiIsIF9fZnVuY19fLCBfX0xJTkVfXywgc2Nhbl9p
bmZvLT5hYm9ydCk7CisKIAlydHc4OV93cml0ZTMyX21hc2socnR3ZGV2LAogCQkJICAgcnR3ODlf
bWFjX3JlZ19ieV9pZHgocnR3ZGV2LCBtYWMtPnJ4X2ZsdHIsIFJUVzg5X01BQ18wKSwKIAkJCSAg
IEJfQVhfUlhfRkxUUl9DRkdfTUFTSywKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L21hYy5jCmluZGV4IDczNDYyZjMzNDNlMy4uNDhlZjUyMTYxOGUyIDEwMDY0NAotLS0gYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jCisrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMKQEAgLTQ3NTcsNiArNDc1Nyw4IEBAIHJ0dzg5X21h
Y19jMmhfc2Nhbm9mbGRfcnNwKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0IHNrX2J1
ZmYgKnNrYiwKIAkJfQogCQlyZXR1cm47CiAJY2FzZSBSVFc4OV9TQ0FOX0VORF9TQ0FOX05PVElG
WToKKwkJcHJpbnRrKCJwaz4gJXM6JWQgc2NhbiBlbmQgaGFuZGxlciBhYm9ydD0lZFxuIiwgX19m
dW5jX18sIF9fTElORV9fLAorCQkJcnR3ZGV2LT5zY2FuX2luZm8uYWJvcnQpOwogCQlpZiAocnR3
ZGV2LT5zY2FuX2luZm8uYWJvcnQpCiAJCQlyZXR1cm47CiAKQEAgLTQ4OTUsNiArNDg5Nyw3IEBA
IHJ0dzg5X21hY19jMmhfZG9uZV9hY2soc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiX2MyaCwgdTMyIGxlCiAJCQlicmVhazsKIAkJY2FzZSBIMkNfRlVOQ19TQ0FO
T0ZMRDoKIAkJCWNvbmQgPSBSVFc4OV9TQ0FOT0ZMRF9XQUlUX0NPTkRfU1RBUlQ7CisJCQlwcmlu
dGsoInBrPiAlczolZCBEQUNLIGZvciBzY2FuIG9mZmxvYWRcbiIsIF9fZnVuY19fLCBfX0xJTkVf
Xyk7CiAJCQlicmVhazsKIAkJY2FzZSBIMkNfRlVOQ19TQ0FOT0ZMRF9CRToKIAkJCWNvbmQgPSBS
VFc4OV9TQ0FOT0ZMRF9CRV9XQUlUX0NPTkRfU1RBUlQ7CkBAIC01MjgzLDYgKzUyODYsNyBAQCBz
dGF0aWMgdm9pZCBydHc4OV9tYWNfYzJoX3NjYW5vZmxkX3JzcF9hdG9taWMoc3RydWN0IHJ0dzg5
X2RldiAqcnR3ZGV2LAogCQllbHNlCiAJCQljb25kID0gUlRXODlfU0NBTk9GTERfV0FJVF9DT05E
X1NUT1A7CiAKKwkJcHJpbnRrKCJwaz4gJXM6JWQgc2NhbiBlbmQgSVNSXG4iLCBfX2Z1bmNfXywg
X19MSU5FX18pOwogCQlydHc4OV9jb21wbGV0ZV9jb25kKGZ3X29mbGRfd2FpdCwgY29uZCwgJmRh
dGEpOwogCX0KIH0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjODAy
MTEuYwppbmRleCA0MWIyODZkYTNkNTkuLjlmMmQ0MjU1MmVkMiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWM4MDIxMS5jCisrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjODAyMTEuYwpAQCAtNjAsNiArNjAsMTQgQEAgc3Rh
dGljIGludCBydHc4OV9vcHNfc3RhcnQoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpCiAJaW50IHJl
dDsKIAogCW11dGV4X2xvY2soJnJ0d2Rldi0+bXV0ZXgpOworCisJeworCWV4dGVybiB2b2lkIGR1
bXBfc3RhY2sodm9pZCk7CisKKwlwcmludGsoInBrPiAlczolZFxuIiwgX19mdW5jX18sIF9fTElO
RV9fKTsKKwlkdW1wX3N0YWNrKCk7CisJfQorCiAJcmV0ID0gcnR3ODlfY29yZV9zdGFydChydHdk
ZXYpOwogCW11dGV4X3VubG9jaygmcnR3ZGV2LT5tdXRleCk7CiAKQEAgLTcxLDYgKzc5LDE0IEBA
IHN0YXRpYyB2b2lkIHJ0dzg5X29wc19zdG9wKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQogCXN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldiA9IGh3LT5wcml2OwogCiAJbXV0ZXhfbG9jaygmcnR3ZGV2
LT5tdXRleCk7CisKKwl7CisJZXh0ZXJuIHZvaWQgZHVtcF9zdGFjayh2b2lkKTsKKworCXByaW50
aygicGs+ICVzOiVkXG4iLCBfX2Z1bmNfXywgX19MSU5FX18pOworCWR1bXBfc3RhY2soKTsKKwl9
CisKIAlydHc4OV9jb3JlX3N0b3AocnR3ZGV2KTsKIAltdXRleF91bmxvY2soJnJ0d2Rldi0+bXV0
ZXgpOwogfQpAQCAtMTEyLDggKzEyOCw4IEBAIHN0YXRpYyBpbnQgcnR3ODlfb3BzX2FkZF9pbnRl
cmZhY2Uoc3RydWN0IGllZWU4MDIxMV9odyAqaHcsCiAJc3RydWN0IHJ0dzg5X3ZpZiAqcnR3dmlm
ID0gKHN0cnVjdCBydHc4OV92aWYgKil2aWYtPmRydl9wcml2OwogCWludCByZXQgPSAwOwogCi0J
cnR3ODlfZGVidWcocnR3ZGV2LCBSVFc4OV9EQkdfU1RBVEUsICJhZGQgdmlmICVwTSB0eXBlICVk
LCBwMnAgJWRcbiIsCi0JCSAgICB2aWYtPmFkZHIsIHZpZi0+dHlwZSwgdmlmLT5wMnApOworCXJ0
dzg5X2RlYnVnKHJ0d2RldiwgUlRXODlfREJHX1NUQVRFLCAiYWRkIHZpZiAlcCAlcE0gdHlwZSAl
ZCwgcDJwICVkXG4iLAorCQkgICAgdmlmLCB2aWYtPmFkZHIsIHZpZi0+dHlwZSwgdmlmLT5wMnAp
OwogCiAJbXV0ZXhfbG9jaygmcnR3ZGV2LT5tdXRleCk7CiAKQEAgLTE3NSw4ICsxOTEsOCBAQCBz
dGF0aWMgdm9pZCBydHc4OV9vcHNfcmVtb3ZlX2ludGVyZmFjZShzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodywKIAlzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYgPSBody0+cHJpdjsKIAlzdHJ1Y3QgcnR3
ODlfdmlmICpydHd2aWYgPSAoc3RydWN0IHJ0dzg5X3ZpZiAqKXZpZi0+ZHJ2X3ByaXY7CiAKLQly
dHc4OV9kZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19TVEFURSwgInJlbW92ZSB2aWYgJXBNIHR5cGUg
JWQgcDJwICVkXG4iLAotCQkgICAgdmlmLT5hZGRyLCB2aWYtPnR5cGUsIHZpZi0+cDJwKTsKKwly
dHc4OV9kZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19TVEFURSwgInJlbW92ZSB2aWYgJXAgJXBNIHR5
cGUgJWQgcDJwICVkXG4iLAorCQkgICAgdmlmLCB2aWYtPmFkZHIsIHZpZi0+dHlwZSwgdmlmLT5w
MnApOwogCiAJY2FuY2VsX3dvcmtfc3luYygmcnR3dmlmLT51cGRhdGVfYmVhY29uX3dvcmspOwog
CWNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmcnR3dmlmLT5yb2Mucm9jX3dvcmspOwpAQCAtMjAy
LDggKzIxOCw4IEBAIHN0YXRpYyBpbnQgcnR3ODlfb3BzX2NoYW5nZV9pbnRlcmZhY2Uoc3RydWN0
IGllZWU4MDIxMV9odyAqaHcsCiAKIAlzZXRfYml0KFJUVzg5X0ZMQUdfQ0hBTkdJTkdfSU5URVJG
QUNFLCBydHdkZXYtPmZsYWdzKTsKIAotCXJ0dzg5X2RlYnVnKHJ0d2RldiwgUlRXODlfREJHX1NU
QVRFLCAiY2hhbmdlIHZpZiAlcE0gKCVkKS0+KCVkKSwgcDJwICglZCktPiglZClcbiIsCi0JCSAg
ICB2aWYtPmFkZHIsIHZpZi0+dHlwZSwgdHlwZSwgdmlmLT5wMnAsIHAycCk7CisJcnR3ODlfZGVi
dWcocnR3ZGV2LCBSVFc4OV9EQkdfU1RBVEUsICJjaGFuZ2UgdmlmICVwICVwTSAoJWQpLT4oJWQp
LCBwMnAgKCVkKS0+KCVkKVxuIiwKKwkJICAgIHZpZiwgdmlmLT5hZGRyLCB2aWYtPnR5cGUsIHR5
cGUsIHZpZi0+cDJwLCBwMnApOwogCiAJcnR3ODlfb3BzX3JlbW92ZV9pbnRlcmZhY2UoaHcsIHZp
Zik7CiAKQEAgLTg4Miw2ICs4OTgsMTMgQEAgc3RhdGljIGludCBydHc4OV9vcHNfaHdfc2Nhbihz
dHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAlzdHJ1
Y3QgcnR3ODlfdmlmICpydHd2aWYgPSB2aWZfdG9fcnR3dmlmX3NhZmUodmlmKTsKIAlpbnQgcmV0
ID0gMDsKIAorCXsKKwlleHRlcm4gdm9pZCBkdW1wX3N0YWNrKHZvaWQpOworCisJcHJpbnRrKCJw
az4gJXM6JWQgdmlmPSVwXG4iLCBfX2Z1bmNfXywgX19MSU5FX18sIHZpZik7CisJZHVtcF9zdGFj
aygpOworCX0KKwogCWlmICghUlRXODlfQ0hLX0ZXX0ZFQVRVUkUoU0NBTl9PRkZMT0FELCAmcnR3
ZGV2LT5mdykpCiAJCXJldHVybiAxOwogCkBAIC05MDUsNiArOTI4LDEzIEBAIHN0YXRpYyB2b2lk
IHJ0dzg5X29wc19jYW5jZWxfaHdfc2NhbihzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywKIHsKIAlz
dHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYgPSBody0+cHJpdjsKIAorCXsKKwlleHRlcm4gdm9pZCBk
dW1wX3N0YWNrKHZvaWQpOworCisJcHJpbnRrKCJwaz4gJXM6JWQgdmlmPSVwXG4iLCBfX2Z1bmNf
XywgX19MSU5FX18sIHZpZik7CisJZHVtcF9zdGFjaygpOworCX0KKwogCWlmICghUlRXODlfQ0hL
X0ZXX0ZFQVRVUkUoU0NBTl9PRkZMT0FELCAmcnR3ZGV2LT5mdykpCiAJCXJldHVybjsKIApkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcGNpLmMKaW5kZXggMDJhZmViM2FjY2U0Li5j
OTVmYTllNjZjYzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvcGNpLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYwpA
QCAtNDE2MCw2ICs0MTYwLDggQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZCBydHc4OV9wY2lf
c3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2ID0g
aHctPnByaXY7CiAJZW51bSBydHc4OV9jb3JlX2NoaXBfaWQgY2hpcF9pZCA9IHJ0d2Rldi0+Y2hp
cC0+Y2hpcF9pZDsKIAorCXByaW50aygicGs+ICVzOiVkXG4iLCBfX2Z1bmNfXywgX19MSU5FX18p
OworCiAJcnR3ODlfd3JpdGUzMl9zZXQocnR3ZGV2LCBSX0FYX1JTVl9DVFJMLCBCX0FYX1dMT0NL
XzFDX0JJVDYpOwogCXJ0dzg5X3dyaXRlMzJfc2V0KHJ0d2RldiwgUl9BWF9SU1ZfQ1RSTCwgQl9B
WF9SX0RJU19QUlNUKTsKIAlydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhfUlNWX0NUUkws
IEJfQVhfV0xPQ0tfMUNfQklUNik7CkBAIC00MTk0LDYgKzQxOTYsOCBAQCBzdGF0aWMgaW50IF9f
bWF5YmVfdW51c2VkIHJ0dzg5X3BjaV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVj
dCBydHc4OV9kZXYgKnJ0d2RldiA9IGh3LT5wcml2OwogCWVudW0gcnR3ODlfY29yZV9jaGlwX2lk
IGNoaXBfaWQgPSBydHdkZXYtPmNoaXAtPmNoaXBfaWQ7CiAKKwlwcmludGsoInBrPiAlczolZFxu
IiwgX19mdW5jX18sIF9fTElORV9fKTsKKwogCXJ0dzg5X3dyaXRlMzJfc2V0KHJ0d2RldiwgUl9B
WF9SU1ZfQ1RSTCwgQl9BWF9XTE9DS18xQ19CSVQ2KTsKIAlydHc4OV93cml0ZTMyX2NscihydHdk
ZXYsIFJfQVhfUlNWX0NUUkwsIEJfQVhfUl9ESVNfUFJTVCk7CiAJcnR3ODlfd3JpdGUzMl9jbHIo
cnR3ZGV2LCBSX0FYX1JTVl9DVFJMLCBCX0FYX1dMT0NLXzFDX0JJVDYpOwotLSAKMi4yNS4xCgo=

--_002_8583c53fa42848c9855b2b425ac18ca4realtekcom_--

