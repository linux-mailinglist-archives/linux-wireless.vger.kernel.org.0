Return-Path: <linux-wireless+bounces-9897-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BD49254CA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 09:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B01CB230D6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96113213B;
	Wed,  3 Jul 2024 07:39:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92206136E37;
	Wed,  3 Jul 2024 07:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719992368; cv=none; b=s8Wuhg7m+A3KIWqZhcpAXDxt5LK6gEkxz9BKdO1M6PCXCkfMeTHUz8n5oFDdTpN1Oq411KcK9dICHQzXgVmuqmWreqGgFR1FUMiXJ6CaOwPFxBIuY8h8HgJOpQ/OYPk92Pu7190EvNrPyTOi6Ab6MaYrJKISQJxXmK3och2E8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719992368; c=relaxed/simple;
	bh=a2evVl/Drqj0cUOAQUU6wEoa9PX4CeAmbK4LR6KG8fE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LlOVsVwP8n4QqvKPOUXkZQYnz5OGwdsbQ7geWldsih7UtelIP5Y9hIHWAHuLL2waPXuy7Vig6rJnLRwO+rPzK8sS16g2muH9iUrxSsCHLedpM5OJYyhPbsUq2ltYwbXvDC9YZ33s2VH2ba0JQQ4aQ2uXvnEEVIe7lGiAtQArvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4637dH9I11921736, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4637dH9I11921736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jul 2024 15:39:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 15:39:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jul 2024 15:39:16 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 3 Jul 2024 15:39:16 +0800
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
Thread-Index: AQHayyFKbA+C/SyMRES67Y/3y6K7kbHkjzsw
Date: Wed, 3 Jul 2024 07:39:16 +0000
Message-ID: <d6b9e886e3dd4d5e9c1f718448c455db@realtek.com>
References: <87ikxqs0tj.fsf@gmail.com>
In-Reply-To: <87ikxqs0tj.fsf@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: yes
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: multipart/mixed;
	boundary="_002_d6b9e886e3dd4d5e9c1f718448c455dbrealtekcom_"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

--_002_d6b9e886e3dd4d5e9c1f718448c455dbrealtekcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Mathew,

Forty Five <mathewegeorge@gmail.com> wrote:
>=20
> Ping-Ke Shih <pkshih@realtek.com> writes:
>=20
> > Since I saw 'NetworkManager' and 'hostapd' in code trace, I would like =
to know
> > if you have two virtual interfaces, which for STA and AP modes? (Please=
 check
> > this by 'iw dev') If so, is it possible to remove hostapd (AP mode) to =
see if
> > this is a factor causing crash.
>=20
> I use hostapd as part of a Wi-Fi hotspot setup for this laptop. I REALLY
> wish I'd connected the dots earlier and realised that it could be
> related to this issue. While running gbcbefbd032 (first bad commit), I
> disabled all the components of my setup and the issue went away; then I
> enabled them one by one until the issue emerged. I'll walk you through
> the relevant details, and my observations during this process.
>=20
> I create a virtual interface for hostapd using this systemd unit:
>=20
> ```
> [Unit]
> Requires=3Dsys-subsystem-net-devices-wlo1.device
> After=3Dnetwork.target
> After=3Dsys-subsystem-net-devices-wlo1.device
> [Service]
> Type=3Doneshot
> ExecStart=3D/usr/bin/iw dev wlo1 interface add wlo1_ap type __ap addr "xx=
:xx:xx:xx:xx:xx"
> ExecStart=3D/usr/bin/ip addr add 192.168.30.1/24 dev wlo1_ap
> [Install]
> WantedBy=3Dmulti-user.target
> ```
>=20
> I need the '__ap' type because my card doesn't support two interfaces in
> managed mode; see [1] for details.
>=20
> [1] https://wiki.archlinux.org/title/Talk:Software_access_point#Two_inter=
faces_on_same_card
>=20
> Then I configure NetworkManager to ignore this interface.
>=20
> ```
> ;; in /etc/NetworkManager/conf.d/unmanaged.conf
> [keyfile]
> unmanaged-devices=3Dinterface-name:wlo1_ap
> ```
>=20
> Coming to hostapd - this is where it gets rather complicated. First off,
> let me mention that when I enabled hostapd.service again, I started
> seeing the 'phy0: resume with hardware scan still in progress' warnings,
> which had gone away upto this point.
>=20
> Next - once I enabled hostapd.service, I was able to reproduce the
> crashes. However, the dmesg in the crash log was different from what I
> see when I have the rest of my setup enabled (I hadn't applied either
> patch when this crash happened, and it's on b54846da4 because that's the
> earliest bad commit in which I'm able to produce crash logs at all, as I
> described in my original message):

Your setup is very complicated, so I can't setup in my side easily, and
haven't time to dig deeper. I feel there are more than one problems, so ple=
ase
help to do some experiments to narrow down scope.=20

First problem is the culprit commit [1] that makes system frozen, and I sti=
ll
feel the patch [2] you have taken can fix it. Please use [1] as code base a=
nd
apply patch [2] to see the result (#exp 1). The difference between without =
[1] and
with [1] + [2] is the timing driver report scan abort completion to mac8021=
1.
And the last few logs you collected show that crash after long time from
scanning abort.

Second problem is WiFi firmware get abnormal during doing resume. The log
looks like (partially):
	 [    T562] rtw89_8852be 0000:02:00.0: R_AX_RPQ_RXBD_IDX =3D0x00000000
	 [    T562] rtw89_8852be 0000:02:00.0: R_AX_DBG_ERR_FLAG=3D0x00000000
	 [    T562] rtw89_8852be 0000:02:00.0: R_AX_LBC_WATCHDOG=3D0x00000081
	 [    T562] rtw89_8852be 0000:02:00.0: <---
	 [    T562] rtw89_8852be 0000:02:00.0: SER catches error: 0x5000
In my side, this is rare, and your last few logs seem not happen. Not sure =
if
this is because of timing result from adding many logs. I would defer this
problem for now.

Third (unsure) problem could be introduced by commits between [1] and [3].
If first problem can be addressed by #exp 1, it could be possible to bisect
the problem between [1] and [3]. Even if [1] is the only problem, revert
the commit to see if it becomes good (#exp 2).

Summary:=20

     o 5bbd9b249880 [3] (v6.10-rc5)
     |              #exp 2: 5bbd9b249880 + [4] (revert [1]; I feel this wou=
ld be bad).
     :
     :
     :
     o bcbefbd032df [1] ("wifi: rtw89: add wait/completion for abort scan")
     |              #exp 1: bcbefbd032df + [2] (I think this will be good.)
     o 7e11a2966f51 (this commit is good)



[1] bcbefbd032df ("wifi: rtw89: add wait/completion for abort scan")
[2] fix scan abort https://lore.kernel.org/linux-wireless/20240517013350.11=
278-1-pkshih@realtek.com/
[3] 5bbd9b249880 (v6.10-rc5; the top of tree you are tring)
[4] attached revert patch of [1]

Ping-Ke


--_002_d6b9e886e3dd4d5e9c1f718448c455dbrealtekcom_
Content-Type: application/octet-stream;
	name="0001-Revert-wifi-rtw89-add-wait-completion-for-abort-scan.patch"
Content-Description: 0001-Revert-wifi-rtw89-add-wait-completion-for-abort-scan.patch
Content-Disposition: attachment;
	filename="0001-Revert-wifi-rtw89-add-wait-completion-for-abort-scan.patch";
	size=8312; creation-date="Wed, 03 Jul 2024 07:13:12 GMT";
	modification-date="Wed, 03 Jul 2024 07:13:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlMDM1YzhiYzc5YzA1Y2IwYTIwODU2NmY5MTQ1NTkwZTEwNGY2NTcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4KRGF0
ZTogV2VkLCAzIEp1bCAyMDI0IDE1OjA5OjA1ICswODAwClN1YmplY3Q6IFtQQVRDSF0gUmV2ZXJ0
ICJ3aWZpOiBydHc4OTogYWRkIHdhaXQvY29tcGxldGlvbiBmb3IgYWJvcnQgc2NhbiIKClRoaXMg
cmV2ZXJ0cyBjb21taXQgYmNiZWZiZDAzMmRmNmJmZTkyNWU2YWZlY2E4MmViOWQyY2MwY2IyMy4K
ClNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPgotLS0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5oIHwgIDEgLQogZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jICAgfCAyMyArKysrLS0tLS0tLS0tLS0KIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuaCAgIHwgMTAgLS0tLS0tLQogZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyAgfCAzNiArKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuaCAgfCAg
MyArLQogNSBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaCBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5oCmluZGV4IDExMmJkZDk1
ZmM2ZS4uNDZkNTM1Zjk4MDgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L2NvcmUuaAorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L2NvcmUuaApAQCAtNTA3OCw3ICs1MDc4LDYgQEAgc3RydWN0IHJ0dzg5X2h3X3NjYW5faW5mbyB7
CiAJc3RydWN0IGllZWU4MDIxMV92aWYgKnNjYW5uaW5nX3ZpZjsKIAlzdHJ1Y3QgbGlzdF9oZWFk
IHBrdF9saXN0W05VTV9OTDgwMjExX0JBTkRTXTsKIAlzdHJ1Y3QgcnR3ODlfY2hhbiBvcF9jaGFu
OwotCWJvb2wgYWJvcnQ7CiAJdTMyIGxhc3RfY2hhbl9pZHg7CiB9OwogCmRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMgYi9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMKaW5kZXggMDQ0YTViOTBjN2Y0Li5kYzc2YWY5MjQ1ODAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYworKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMKQEAgLTQ2NTMsNyArNDY1
Myw3IEBAIGludCBydHc4OV9md19oMmNfc2Nhbl9saXN0X29mZmxvYWQoc3RydWN0IHJ0dzg5X2Rl
diAqcnR3ZGV2LCBpbnQgY2hfbnVtLAogCQkJICAgICAgSDJDX0NBVF9NQUMsIEgyQ19DTF9NQUNf
RldfT0ZMRCwKIAkJCSAgICAgIEgyQ19GVU5DX0FERF9TQ0FOT0ZMRF9DSCwgMSwgMSwgc2tiX2xl
bik7CiAKLQljb25kID0gUlRXODlfU0NBTk9GTERfV0FJVF9DT05EX0FERF9DSDsKKwljb25kID0g
UlRXODlfRldfT0ZMRF9XQUlUX0NPTkQoMCwgSDJDX0ZVTkNfQUREX1NDQU5PRkxEX0NIKTsKIAog
CXJldCA9IHJ0dzg5X2gyY190eF9hbmRfd2FpdChydHdkZXYsIHNrYiwgd2FpdCwgY29uZCk7CiAJ
aWYgKHJldCkgewpAQCAtNDc0OSw3ICs0NzQ5LDcgQEAgaW50IHJ0dzg5X2Z3X2gyY19zY2FuX2xp
c3Rfb2ZmbG9hZF9iZShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIGludCBjaF9udW0sCiAJCQkg
ICAgICBIMkNfQ0FUX01BQywgSDJDX0NMX01BQ19GV19PRkxELAogCQkJICAgICAgSDJDX0ZVTkNf
QUREX1NDQU5PRkxEX0NILCAxLCAxLCBza2JfbGVuKTsKIAotCWNvbmQgPSBSVFc4OV9TQ0FOT0ZM
RF9XQUlUX0NPTkRfQUREX0NIOworCWNvbmQgPSBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgwLCBI
MkNfRlVOQ19BRERfU0NBTk9GTERfQ0gpOwogCiAJcmV0ID0gcnR3ODlfaDJjX3R4X2FuZF93YWl0
KHJ0d2Rldiwgc2tiLCB3YWl0LCBjb25kKTsKIAlpZiAocmV0KSB7CkBAIC00ODA4LDEwICs0ODA4
LDcgQEAgaW50IHJ0dzg5X2Z3X2gyY19zY2FuX29mZmxvYWQoc3RydWN0IHJ0dzg5X2RldiAqcnR3
ZGV2LAogCQkJICAgICAgSDJDX0ZVTkNfU0NBTk9GTEQsIDEsIDEsCiAJCQkgICAgICBsZW4pOwog
Ci0JaWYgKG9wdGlvbi0+ZW5hYmxlKQotCQljb25kID0gUlRXODlfU0NBTk9GTERfV0FJVF9DT05E
X1NUQVJUOwotCWVsc2UKLQkJY29uZCA9IFJUVzg5X1NDQU5PRkxEX1dBSVRfQ09ORF9TVE9QOwor
CWNvbmQgPSBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgwLCBIMkNfRlVOQ19TQ0FOT0ZMRCk7CiAK
IAlyZXQgPSBydHc4OV9oMmNfdHhfYW5kX3dhaXQocnR3ZGV2LCBza2IsIHdhaXQsIGNvbmQpOwog
CWlmIChyZXQpIHsKQEAgLTU1MDEsNyArNTQ5OCw3IEBAIHN0YXRpYyBib29sIHJ0dzg5X2Z3X2My
aF9jaGtfYXRvbWljKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwKIAlkZWZhdWx0OgogCQlyZXR1
cm4gZmFsc2U7CiAJY2FzZSBSVFc4OV9DMkhfQ0FUX01BQzoKLQkJcmV0dXJuIHJ0dzg5X21hY19j
MmhfY2hrX2F0b21pYyhydHdkZXYsIGMyaCwgY2xhc3MsIGZ1bmMpOworCQlyZXR1cm4gcnR3ODlf
bWFjX2MyaF9jaGtfYXRvbWljKHJ0d2RldiwgY2xhc3MsIGZ1bmMpOwogCWNhc2UgUlRXODlfQzJI
X0NBVF9PVVRTUkM6CiAJCXJldHVybiBydHc4OV9waHlfYzJoX2Noa19hdG9taWMocnR3ZGV2LCBj
bGFzcywgZnVuYyk7CiAJfQpAQCAtNjE3OCw3ICs2MTc1LDYgQEAgdm9pZCBydHc4OV9od19zY2Fu
X3N0YXJ0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZp
ZiwKIAlydHc4OV9nZXRfY2hhbm5lbChydHdkZXYsIHJ0d3ZpZiwgJnJ0d2Rldi0+c2Nhbl9pbmZv
Lm9wX2NoYW4pOwogCXJ0d2Rldi0+c2Nhbl9pbmZvLnNjYW5uaW5nX3ZpZiA9IHZpZjsKIAlydHdk
ZXYtPnNjYW5faW5mby5sYXN0X2NoYW5faWR4ID0gMDsKLQlydHdkZXYtPnNjYW5faW5mby5hYm9y
dCA9IGZhbHNlOwogCXJ0d3ZpZi0+c2Nhbl9pZXMgPSAmc2Nhbl9yZXEtPmllczsKIAlydHd2aWYt
PnNjYW5fcmVxID0gcmVxOwogCWllZWU4MDIxMV9zdG9wX3F1ZXVlcyhydHdkZXYtPmh3KTsKQEAg
LTYyMzEsMjEgKzYyMjcsMTQgQEAgdm9pZCBydHc4OV9od19zY2FuX2NvbXBsZXRlKHN0cnVjdCBy
dHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZiwKIAlydHd2aWYtPnNj
YW5faWVzID0gTlVMTDsKIAlzY2FuX2luZm8tPmxhc3RfY2hhbl9pZHggPSAwOwogCXNjYW5faW5m
by0+c2Nhbm5pbmdfdmlmID0gTlVMTDsKLQlzY2FuX2luZm8tPmFib3J0ID0gZmFsc2U7CiAKIAly
dHc4OV9jaGFuY3R4X3Byb2NlZWQocnR3ZGV2KTsKIH0KIAogdm9pZCBydHc4OV9od19zY2FuX2Fi
b3J0KHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0IGllZWU4MDIxMV92aWYgKnZpZikK
IHsKLQlzdHJ1Y3QgcnR3ODlfaHdfc2Nhbl9pbmZvICpzY2FuX2luZm8gPSAmcnR3ZGV2LT5zY2Fu
X2luZm87Ci0JaW50IHJldDsKLQotCXNjYW5faW5mby0+YWJvcnQgPSB0cnVlOwotCi0JcmV0ID0g
cnR3ODlfaHdfc2Nhbl9vZmZsb2FkKHJ0d2RldiwgdmlmLCBmYWxzZSk7Ci0JaWYgKHJldCkKLQkJ
cnR3ODlfaHdfc2Nhbl9jb21wbGV0ZShydHdkZXYsIHZpZiwgdHJ1ZSk7CisJcnR3ODlfaHdfc2Nh
bl9vZmZsb2FkKHJ0d2RldiwgdmlmLCBmYWxzZSk7CisJcnR3ODlfaHdfc2Nhbl9jb21wbGV0ZShy
dHdkZXYsIHZpZiwgdHJ1ZSk7CiB9CiAKIHN0YXRpYyBib29sIHJ0dzg5X2lzX2FueV92aWZfY29u
bmVjdGVkX29yX2Nvbm5lY3Rpbmcoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2KQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oIGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oCmluZGV4IDQxNTFjOWQ1NjZiZC4uOTlkYTY0Y2Yx
YjAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmgK
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oCkBAIC0yMTAsMTIg
KzIxMCw2IEBAIGVudW0gcnR3ODlfc2Nhbm9mbGRfbm90aWZ5X3JlYXNvbiB7CiAJUlRXODlfU0NB
Tl9MRUFWRV9PUF9OT1RJRlksCiB9OwogCi1lbnVtIHJ0dzg5X3NjYW5vZmxkX3N0YXR1cyB7Ci0J
UlRXODlfU0NBTl9TVEFUVVNfTk9USUZZLAotCVJUVzg5X1NDQU5fU1RBVFVTX1NVQ0NFU1MsCi0J
UlRXODlfU0NBTl9TVEFUVVNfRkFJTCwKLX07Ci0KIGVudW0gcnR3ODlfY2hhbl90eXBlIHsKIAlS
VFc4OV9DSEFOX09QRVJBVEUgPSAwLAogCVJUVzg5X0NIQU5fQUNUSVZFLApAQCAtMzk5NywxMCAr
Mzk5MSw2IEBAIGVudW0gcnR3ODlfZndfb2ZsZF9oMmNfZnVuYyB7CiAJUlRXODlfRldfT0ZMRF9X
QUlUX0NPTkQoUlRXODlfUEtUX09GTERfV0FJVF9UQUcocGt0X2lkLCBwa3Rfb3ApLCBcCiAJCQkJ
SDJDX0ZVTkNfUEFDS0VUX09GTEQpCiAKLSNkZWZpbmUgUlRXODlfU0NBTk9GTERfV0FJVF9DT05E
X0FERF9DSCBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgwLCBIMkNfRlVOQ19BRERfU0NBTk9GTERf
Q0gpCi0KLSNkZWZpbmUgUlRXODlfU0NBTk9GTERfV0FJVF9DT05EX1NUQVJUIFJUVzg5X0ZXX09G
TERfV0FJVF9DT05EKDAsIEgyQ19GVU5DX1NDQU5PRkxEKQotI2RlZmluZSBSVFc4OV9TQ0FOT0ZM
RF9XQUlUX0NPTkRfU1RPUCBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgxLCBIMkNfRlVOQ19TQ0FO
T0ZMRCkKICNkZWZpbmUgUlRXODlfU0NBTk9GTERfQkVfV0FJVF9DT05EX1NUQVJUIFJUVzg5X0ZX
X09GTERfV0FJVF9DT05EKDAsIEgyQ19GVU5DX1NDQU5PRkxEX0JFKQogI2RlZmluZSBSVFc4OV9T
Q0FOT0ZMRF9CRV9XQUlUX0NPTkRfU1RPUCBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgxLCBIMkNf
RlVOQ19TQ0FOT0ZMRF9CRSkKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS9tYWMuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFj
LmMKaW5kZXggM2ZlMDA0NmY2ZWFhLi44MzNjNjQ4NDQwYWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9tYWMuYwpAQCAtNDc2NSw3ICs0NzY1LDcgQEAgcnR3ODlfbWFjX2My
aF9zY2Fub2ZsZF9yc3Aoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLAogCQkJCXJ0dzg5X3dhcm4ocnR3ZGV2LCAiSFcgc2NhbiBmYWlsZWQ6ICVkXG4iLCByZXQp
OwogCQkJfQogCQl9IGVsc2UgewotCQkJcnR3ODlfaHdfc2Nhbl9jb21wbGV0ZShydHdkZXYsIHZp
ZiwgcnR3ZGV2LT5zY2FuX2luZm8uYWJvcnQpOworCQkJcnR3ODlfaHdfc2Nhbl9jb21wbGV0ZShy
dHdkZXYsIHZpZiwgZmFsc2UpOwogCQl9CiAJCWJyZWFrOwogCWNhc2UgUlRXODlfU0NBTl9FTlRF
Ul9PUF9OT1RJRlk6CkBAIC00ODg4LDEwICs0ODg4LDggQEAgcnR3ODlfbWFjX2MyaF9kb25lX2Fj
ayhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpza2JfYzJoLCB1MzIg
bGUKIAkJZGVmYXVsdDoKIAkJCXJldHVybjsKIAkJY2FzZSBIMkNfRlVOQ19BRERfU0NBTk9GTERf
Q0g6Ci0JCQljb25kID0gUlRXODlfU0NBTk9GTERfV0FJVF9DT05EX0FERF9DSDsKLQkJCWJyZWFr
OwogCQljYXNlIEgyQ19GVU5DX1NDQU5PRkxEOgotCQkJY29uZCA9IFJUVzg5X1NDQU5PRkxEX1dB
SVRfQ09ORF9TVEFSVDsKKwkJCWNvbmQgPSBSVFc4OV9GV19PRkxEX1dBSVRfQ09ORCgwLCBoMmNf
ZnVuYyk7CiAJCQlicmVhazsKIAkJY2FzZSBIMkNfRlVOQ19TQ0FOT0ZMRF9CRToKIAkJCWNvbmQg
PSBSVFc4OV9TQ0FOT0ZMRF9CRV9XQUlUX0NPTkRfU1RBUlQ7CkBAIC01MjYwLDMyICs1MjU4LDcg
QEAgdm9pZCAoKiBjb25zdCBydHc4OV9tYWNfYzJoX3dvd19oYW5kbGVyW10pKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2RldiwKIAlbUlRXODlfTUFDX0MySF9GVU5DX0FPQUNfUkVQT1JUXSA9IHJ0dzg5
X21hY19jMmhfd293X2FvYWNfcnB0LAogfTsKIAotc3RhdGljIHZvaWQgcnR3ODlfbWFjX2MyaF9z
Y2Fub2ZsZF9yc3BfYXRvbWljKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwKLQkJCQkJICAgICAg
c3RydWN0IHNrX2J1ZmYgKnNrYikKLXsKLQljb25zdCBzdHJ1Y3QgcnR3ODlfYzJoX3NjYW5vZmxk
ICpjMmggPQotCQkoY29uc3Qgc3RydWN0IHJ0dzg5X2MyaF9zY2Fub2ZsZCAqKXNrYi0+ZGF0YTsK
LQlzdHJ1Y3QgcnR3ODlfd2FpdF9pbmZvICpmd19vZmxkX3dhaXQgPSAmcnR3ZGV2LT5tYWMuZndf
b2ZsZF93YWl0OwotCXN0cnVjdCBydHc4OV9jb21wbGV0aW9uX2RhdGEgZGF0YSA9IHt9OwotCXVu
c2lnbmVkIGludCBjb25kOwotCXU4IHN0YXR1cywgcmVhc29uOwotCi0Jc3RhdHVzID0gbGUzMl9n
ZXRfYml0cyhjMmgtPncyLCBSVFc4OV9DMkhfU0NBTk9GTERfVzJfU1RBVFVTKTsKLQlyZWFzb24g
PSBsZTMyX2dldF9iaXRzKGMyaC0+dzIsIFJUVzg5X0MySF9TQ0FOT0ZMRF9XMl9SU04pOwotCWRh
dGEuZXJyID0gc3RhdHVzICE9IFJUVzg5X1NDQU5fU1RBVFVTX1NVQ0NFU1M7Ci0KLQlpZiAocmVh
c29uID09IFJUVzg5X1NDQU5fRU5EX1NDQU5fTk9USUZZKSB7Ci0JCWlmIChydHdkZXYtPmNoaXAt
PmNoaXBfZ2VuID09IFJUVzg5X0NISVBfQkUpCi0JCQljb25kID0gUlRXODlfU0NBTk9GTERfQkVf
V0FJVF9DT05EX1NUT1A7Ci0JCWVsc2UKLQkJCWNvbmQgPSBSVFc4OV9TQ0FOT0ZMRF9XQUlUX0NP
TkRfU1RPUDsKLQotCQlydHc4OV9jb21wbGV0ZV9jb25kKGZ3X29mbGRfd2FpdCwgY29uZCwgJmRh
dGEpOwotCX0KLX0KLQotYm9vbCBydHc4OV9tYWNfYzJoX2Noa19hdG9taWMoc3RydWN0IHJ0dzg5
X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqYzJoLAotCQkJICAgICAgdTggY2xhc3MsIHU4
IGZ1bmMpCitib29sIHJ0dzg5X21hY19jMmhfY2hrX2F0b21pYyhzdHJ1Y3QgcnR3ODlfZGV2ICpy
dHdkZXYsIHU4IGNsYXNzLCB1OCBmdW5jKQogewogCXN3aXRjaCAoY2xhc3MpIHsKIAlkZWZhdWx0
OgpAQCAtNTMwMiw5ICs1Mjc1LDYgQEAgYm9vbCBydHc4OV9tYWNfYzJoX2Noa19hdG9taWMoc3Ry
dWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqYzJoLAogCQlzd2l0Y2ggKGZ1
bmMpIHsKIAkJZGVmYXVsdDoKIAkJCXJldHVybiBmYWxzZTsKLQkJY2FzZSBSVFc4OV9NQUNfQzJI
X0ZVTkNfU0NBTk9GTERfUlNQOgotCQkJcnR3ODlfbWFjX2MyaF9zY2Fub2ZsZF9yc3BfYXRvbWlj
KHJ0d2RldiwgYzJoKTsKLQkJCXJldHVybiBmYWxzZTsKIAkJY2FzZSBSVFc4OV9NQUNfQzJIX0ZV
TkNfUEtUX09GTERfUlNQOgogCQkJcmV0dXJuIHRydWU7CiAJCX0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmggYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L21hYy5oCmluZGV4IGE1ODBjYjcxOTIzMy4uNWE5NzY2YTM2ZmU0IDEw
MDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5oCisrKyBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmgKQEAgLTExNzIsOCArMTE3
Miw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHJ0dzg5X2NoaXBfcmVzZXRfYmJfcmYoc3RydWN0IHJ0
dzg5X2RldiAqcnR3ZGV2KQogCiB1MzIgcnR3ODlfbWFjX2dldF9lcnJfc3RhdHVzKHN0cnVjdCBy
dHc4OV9kZXYgKnJ0d2Rldik7CiBpbnQgcnR3ODlfbWFjX3NldF9lcnJfc3RhdHVzKHN0cnVjdCBy
dHc4OV9kZXYgKnJ0d2RldiwgdTMyIGVycik7Ci1ib29sIHJ0dzg5X21hY19jMmhfY2hrX2F0b21p
YyhzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpjMmgsCi0JCQkgICAg
ICB1OCBjbGFzcywgdTggZnVuYyk7Citib29sIHJ0dzg5X21hY19jMmhfY2hrX2F0b21pYyhzdHJ1
Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHU4IGNsYXNzLCB1OCBmdW5jKTsKIHZvaWQgcnR3ODlfbWFj
X2MyaF9oYW5kbGUoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LAogCQkJICB1MzIgbGVuLCB1OCBjbGFzcywgdTggZnVuYyk7CiBpbnQgcnR3ODlfbWFjX3NldHVw
X3BoeWNhcChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYpOwotLSAKMi4yNS4xCgo=

--_002_d6b9e886e3dd4d5e9c1f718448c455dbrealtekcom_--

