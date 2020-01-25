Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBA4814941C
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2020 10:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgAYJ2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jan 2020 04:28:46 -0500
Received: from grunblatt.org ([5.196.68.213]:35588 "EHLO grunblatt.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYJ2q (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jan 2020 04:28:46 -0500
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Jan 2020 04:28:45 EST
Received: from grunblatt.org (localhost [127.0.0.1])
        by grunblatt.org (OpenSMTPD) with ESMTP id c0a81147
        for <linux-wireless@vger.kernel.org>;
        Sat, 25 Jan 2020 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=grunblatt.org; h=to:from
        :subject:message-id:date:mime-version:content-type; s=mail; bh=g
        u22ltnYs/y8vkAsm14040eJwKA=; b=KvkLuehfXkLSGSEVvQHpzDecp/vGEFMC2
        v5XRAE+4QlVSGx6HwqfFB1pOH0JSCPRokTqpsxvnYG4PSPkOcZFQycliNky5Jftg
        p8uje3dq1gzwI15Srjc+9/B/G4/vtTcaNRvQucGe/lohqMRyTyQoG82+ULUn3J6y
        JDG/H4xvGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=grunblatt.org; h=to:from
        :subject:message-id:date:mime-version:content-type; q=dns; s=
        mail; b=b57+LhjyTkfgW0rWeEr0QUrw7dtkbvz0h31g2MLbRXfJSenRSiANIsoX
        dN9S0Wa5sF1HTa4T93nzVUImNnYAhTUKhPig7r3D9GyTit7EdmYEsnt4RblnmrSE
        HuEbgLvGTID5OV8kZWBmHVc3M2rw58cyQiJoqHEf4a6wJ2TLrVI=
Received: by grunblatt.org (OpenSMTPD) with ESMTPSA id 7fca5b83 (TLSv1.2:ECDHE-RSA-CHACHA20-POLY1305:256:NO)
        for <linux-wireless@vger.kernel.org>;
        Sat, 25 Jan 2020 09:22:02 +0000 (UTC)
To:     linux-wireless@vger.kernel.org
From:   =?UTF-8?Q?R=c3=a9my_Gr=c3=bcnblatt?= <remy@grunblatt.org>
Subject: BUG: Microcode SW error detected on AX200 when trying to do Fine
 Timing Measurements (FTM)
X-Pep-Version: 2.0
Message-ID: <a42f4862-2d5f-5ce0-5214-c4b673547d31@grunblatt.org>
Date:   Sat, 25 Jan 2020 10:22:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------DBD87A3E560DE727CF1E2CBC"
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------DBD87A3E560DE727CF1E2CBC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

i'm trying to do fine timing measurements with an Intel Wi-Fi 6 AX200 (
iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=3D0x340=

). I'm having a crash (see attached dmesg) when trying to launch the
measurement using iw (5.4):

remy@jetson-nano:~$ sudo ./iw dev wlan0 measurement ftm_request ./conf_tm=
p
[sudo] password for remy:
command failed: Input/output error (-5)
remy@jetson-nano:~$ cat conf_tmp
e4:e7:49:73:a0:d2 bw=3D20 cf=3D2412 asap
remy@jetson-nano:~$

I'm using the core45 release (core47 fails to compile), up-to-date
firmware ( iwlwifi-fw-2019-08-23 ), and the default "jetson nano" ubuntu
image (it's an armv64 machine) with kernel "4.9.140-tegra".

Am I doing something wrong?

Thanks,

R=C3=A9my


--------------DBD87A3E560DE727CF1E2CBC
Content-Type: text/plain; charset=UTF-8;
 name="dmesg.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.txt"

WyAzNjAyLjk4Nzc3NF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IE1pY3JvY29kZSBTVyBlcnJv
ciBkZXRlY3RlZC4gUmVzdGFydGluZyAweDAuClsgMzYwMi45ODk4ODVdIC0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpbIDM2MDIuOTg5OTc2XSBXQVJOSU5HOiBDUFU6
IDIgUElEOiA4NzIwIGF0IC9ob21lL3JlbXkvYmFja3BvcnQtaXdsd2lmaS9kcml2ZXJzL25l
dC93aXJlbGVzcy9pbnRlbC9pd2x3aWZpL212bS91dGlscy5jOjE3MCBpd2xfbXZtX3NlbmRf
Y21kX3N0YXR1cysweDExMC8weDEyOCBbaXdsbXZtXQpbIDM2MDIuOTg5OTk3XSBNb2R1bGVz
IGxpbmtlZCBpbjogaXdsbXZtKE8pIG1hYzgwMjExKE8pIGZ1c2UgenJhbSBpd2x3aWZpKE8p
IGJ0dXNiIGJ0cnRsIGJ0YmNtIGJ0aW50ZWwgb3ZlcmxheSBjZmc4MDIxMShPKSBjb21wYXQo
Tykgc3BpZGV2IG52Z3B1IGJsdWVkcm9pZF9wbSBpcF90YWJsZXMgeF90YWJsZXMKClsgMzYw
Mi45OTAwMDNdIENQVTogMiBQSUQ6IDg3MjAgQ29tbTogaXcgVGFpbnRlZDogRyAgICAgICAg
ICAgTyAgICA0LjkuMTQwLXRlZ3JhICMxClsgMzYwMi45OTAwMDVdIEhhcmR3YXJlIG5hbWU6
IE5WSURJQSBKZXRzb24gTmFubyBEZXZlbG9wZXIgS2l0IChEVCkKWyAzNjAyLjk5MDAwN10g
dGFzazogZmZmZmZmYzBiZTM4NzAwMCB0YXNrLnN0YWNrOiBmZmZmZmZjMGM1YzE0MDAwClsg
MzYwMi45OTAwOTBdIFBDIGlzIGF0IGl3bF9tdm1fc2VuZF9jbWRfc3RhdHVzKzB4MTEwLzB4
MTI4IFtpd2xtdm1dClsgMzYwMi45OTAxNjFdIExSIGlzIGF0IGl3bF9tdm1fc2VuZF9jbWRf
c3RhdHVzKzB4NTAvMHgxMjggW2l3bG12bV0KWyAzNjAyLjk5MDE2NF0gcGMgOiBbPGZmZmZm
ZjgwMDEzYzJlNzg+XSBsciA6IFs8ZmZmZmZmODAwMTNjMmRiOD5dIHBzdGF0ZTogODA0MDAw
NDUKWyAzNjAyLjk5MDE2NV0gc3AgOiBmZmZmZmZjMGM1YzE3NzAwClsgMzYwMi45OTAxNjld
IHgyOTogZmZmZmZmYzBjNWMxNzcwMCB4Mjg6IGZmZmZmZmMwYzU3NzFmMDggClsgMzYwMi45
OTAxNzJdIHgyNzogMDAwMDAwMDAwMDAwMDAwMCB4MjY6IGZmZmZmZmMwZGVkY2IzMDAgClsg
MzYwMi45OTAxNzVdIHgyNTogMDAwMDAwMDAwMDAwMDAwMSB4MjQ6IGZmZmZmZmMwYzU3NzAz
MjAgClsgMzYwMi45OTAxNzhdIHgyMzogZmZmZmZmYzBjNWMxNzhiMCB4MjI6IGZmZmZmZmMw
Y2QzOWFjMDAgClsgMzYwMi45OTAxODFdIHgyMTogZmZmZmZmYzBjNWMxNzc5NCB4MjA6IDAw
MDAwMDAwZmZmZmZmZmIgClsgMzYwMi45OTAxODRdIHgxOTogZmZmZmZmYzBjNWMxNzc5OCB4
MTg6IDAwMDAwMDAwMDAwMDAzZWEgClsgMzYwMi45OTAxODddIHgxNzogMDAwMDAwMDAwMDAw
MGJmYiB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgClsgMzYwMi45OTAxODldIHgxNTogMDAwMDAw
MDAwMDAwMDAwYyB4MTQ6IDAwMDAwMDAwMDA1ZTEzOGEgClsgMzYwMi45OTAxOTJdIHgxMzog
MDAwMDAwMDAwMTY2NmJmYiB4MTI6IDAwMDAwMDAwMDAwMDAzZWEgClsgMzYwMi45OTAxOTVd
IHgxMTogMDAwMDAwMDAwMDAwMDQwMCB4MTA6IDAwMDAwMDAwMDAwMDBhMjAgClsgMzYwMi45
OTAxOThdIHg5IDogZmZmZmZmYzBjNWMxNzRlMCB4OCA6IGZmZmZmZmMwYmUzODdhODAgClsg
MzYwMi45OTAyMDBdIHg3IDogMDAwMDAwMDAwMDAwMzAwMCB4NiA6IDAwMDAwMDAwMGM4NGM2
Y2MgClsgMzYwMi45OTAyMDNdIHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6IDAwMDAwMDAw
MDAwMTAyM2IgClsgMzYwMi45OTAyMDZdIHgzIDogZmZmZmZmYzBmMDIwOTUyOCB4MiA6IGZm
ZmZmZmMwZjAyMDk1MjggClsgMzYwMi45OTAyMDhdIHgxIDogMDAwMDAwMDAwMDAwMDAwMSB4
MCA6IGZmZmZmZjgwMDE0MTA3Y2UgCgpbIDM2MDIuOTkwMjExXSAtLS1bIGVuZCB0cmFjZSBi
NjhiNzUxMGM0YTgwZWUxIF0tLS0KWyAzNjAyLjk5MDIxMl0gQ2FsbCB0cmFjZToKWyAzNjAy
Ljk5MDI5NV0gWzxmZmZmZmY4MDAxM2MyZTc4Pl0gaXdsX212bV9zZW5kX2NtZF9zdGF0dXMr
MHgxMTAvMHgxMjggW2l3bG12bV0KWyAzNjAyLjk5MDM2NV0gWzxmZmZmZmY4MDAxM2U1OTUw
Pl0gaXdsX212bV9mdG1fc3RhcnQrMHgzNTAvMHg1NDAgW2l3bG12bV0KWyAzNjAyLjk5MDQz
NF0gWzxmZmZmZmY4MDAxM2IzN2E4Pl0gaXdsX212bV9zdGFydF9wbXNyKzB4NDgvMHg2OCBb
aXdsbXZtXQpbIDM2MDIuOTkwNTU3XSBbPGZmZmZmZjgwMDEyZjNmYjg+XSBpZWVlODAyMTFf
c3RhcnRfcG1zcisweDYwLzB4MjAwIFttYWM4MDIxMV0KWyAzNjAyLjk5MDY1M10gWzxmZmZm
ZmY4MDAxMWI2ZDk4Pl0gbmw4MDIxMV9wbXNyX3N0YXJ0KzB4NDY4LzB4NzcwIFtjZmc4MDIx
MV0KWyAzNjAyLjk5MDY3NV0gWzxmZmZmZmY4MDAxMTAyOWU0Pl0gZXh0YWNrX2RvaXQrMHgz
NC8weDkwIFtjb21wYXRdClsgMzYwMi45OTA2ODFdIFs8ZmZmZmZmODAwOGRlOTM1ND5dIGdl
bmxfZmFtaWx5X3Jjdl9tc2crMHgyZTQvMHgzZDAKWyAzNjAyLjk5MDY4NF0gWzxmZmZmZmY4
MDA4ZGU5NGMwPl0gZ2VubF9yY3ZfbXNnKzB4ODAvMHhkOApbIDM2MDIuOTkwNjg4XSBbPGZm
ZmZmZjgwMDhkZTgyYzg+XSBuZXRsaW5rX3Jjdl9za2IrMHhhOC8weGYwClsgMzYwMi45OTA2
OTFdIFs8ZmZmZmZmODAwOGRlOTA1Yz5dIGdlbmxfcmN2KzB4M2MvMHg1MApbIDM2MDIuOTkw
Njk0XSBbPGZmZmZmZjgwMDhkZTdiZTg+XSBuZXRsaW5rX3VuaWNhc3QrMHgxODgvMHgyMTgK
WyAzNjAyLjk5MDY5Nl0gWzxmZmZmZmY4MDA4ZGU4MDc4Pl0gbmV0bGlua19zZW5kbXNnKzB4
MmUwLzB4MzQwClsgMzYwMi45OTA3MDBdIFs8ZmZmZmZmODAwOGQ4MzFlND5dIHNvY2tfc2Vu
ZG1zZysweDRjLzB4NjgKWyAzNjAyLjk5MDcwM10gWzxmZmZmZmY4MDA4ZDgzZmEwPl0gX19f
c3lzX3NlbmRtc2crMHgyYTgvMHgyYzAKWyAzNjAyLjk5MDcwNl0gWzxmZmZmZmY4MDA4ZDg1
NDc0Pl0gX19zeXNfc2VuZG1zZysweDU0LzB4OTgKWyAzNjAyLjk5MDcwOV0gWzxmZmZmZmY4
MDA4ZDg1NGYwPl0gU3lTX3NlbmRtc2crMHgzOC8weDUwClsgMzYwMi45OTA3MTNdIFs8ZmZm
ZmZmODAwODA4MzhjMD5dIGVsMF9zdmNfbmFrZWQrMHgzNC8weDM4ClsgMzYwMy4wMTkxMzJd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiBTdGFydCBJV0wgRXJyb3IgTG9nIER1bXA6ClsgMzYw
My4wMjQ3NDldIGl3bHdpZmkgMDAwMDowMTowMC4wOiBTdGF0dXM6IDB4MDAwMDAwODAsIGNv
dW50OiA2ClsgMzYwMy4wMzA2MDddIGl3bHdpZmkgMDAwMDowMTowMC4wOiBMb2FkZWQgZmly
bXdhcmUgdmVyc2lvbjogNDguNGZhMDA0MWYuMApbIDM2MDMuMDM3MzI1XSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHgwMDAwMDA3MSB8IE5NSV9JTlRFUlJVUFRfVU1BQ19GQVRBTCAgICAK
WyAzNjAzLjA0NDMzM10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDIyRjAgfCB0cm1f
aHdfc3RhdHVzMApbIDM2MDMuMDUwMTAyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAw
MDAwMCB8IHRybV9od19zdGF0dXMxClsgMzYwMy4wNTU4ODZdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDAwNEY4RTNDIHwgYnJhbmNobGluazIKWyAzNjAzLjA2MTM4NV0gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDA0RTRGRjQgfCBpbnRlcnJ1cHRsaW5rMQpbIDM2MDMuMDY3MTYz
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDRFNEZGNCB8IGludGVycnVwdGxpbmsyClsg
MzYwMy4wNzI5MjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwNEY0QUQyIHwgZGF0YTEK
WyAzNjAzLjA3NzkwNF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDEwMDAgfCBkYXRh
MgpbIDM2MDMuMDgyODgzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg3MDAwMDAwOCB8IGRh
dGEzClsgMzYwMy4wODc4OTBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwg
YmVhY29uIHRpbWUKWyAzNjAzLjA5MzM5MV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4RDJC
QUYwRjYgfCB0c2YgbG93ClsgMzYwMy4wOTg1NDddIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDAwMDAwIHwgdHNmIGhpClsgMzYwMy4xMDM2MjNdIGl3bHdpZmkgMDAwMDowMTowMC4w
OiAweDAwMDAwMDAwIHwgdGltZSBncDEKWyAzNjAzLjEwODg3N10gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4RDJCQjU4ODggfCB0aW1lIGdwMgpbIDM2MDMuMTE0MTQwXSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHgwMDAwMDAwMSB8IHVDb2RlIHJldmlzaW9uIHR5cGUKWyAzNjAzLjEy
MDM2MV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMzAgfCB1Q29kZSB2ZXJzaW9u
IG1ham9yClsgMzYwMy4xMjY1NTRdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDRGQTAwNDFG
IHwgdUNvZGUgdmVyc2lvbiBtaW5vcgpbIDM2MDMuMTMyNzU3XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHgwMDAwMDM0MCB8IGh3IHZlcnNpb24KWyAzNjAzLjEzODE2N10gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDBDODkwMDAgfCBib2FyZCB2ZXJzaW9uClsgMzYwMy4xNDM4NDdd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwRkYwMTlDIHwgaGNtZApbIDM2MDMuMTQ4NzQ5
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAyMDAwMCB8IGlzcjAKWyAzNjAzLjE1MzY0
Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3IxClsgMzYwMy4xNTg1
MzJdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDE4RjA0ODAyIHwgaXNyMgpbIDM2MDMuMTYz
NDI3XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwNEMxRkZDQyB8IGlzcjMKWyAzNjAzLjE2
ODMxMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBpc3I0ClsgMzYwMy4x
NzMyMTBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwRkYwMTlDIHwgbGFzdCBjbWQgSWQK
WyAzNjAzLjE3ODcwOF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDA0RjRBRDIgfCB3YWl0
X2V2ZW50ClsgMzYwMy4xODQxMjZdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwODUw
IHwgbDJwX2NvbnRyb2wKWyAzNjAzLjE4OTYzOF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDAwMDAwMDAgfCBsMnBfZHVyYXRpb24KWyAzNjAzLjE5NTIzMl0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4MDAwMDAwM0YgfCBsMnBfbWh2YWxpZApbIDM2MDMuMjAwNzQ1XSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGwycF9hZGRyX21hdGNoClsgMzYwMy4yMDY1
MDFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDA4IHwgbG1wbV9wbWdfc2VsClsg
MzYwMy4yMTIwOTNdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdGltZXN0
YW1wClsgMzYwMy4yMTc0MTFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDBDMDA4IHwg
Zmxvd19oYW5kbGVyClsgMzYwMy4yMjMxMjddIGl3bHdpZmkgMDAwMDowMTowMC4wOiBTdGFy
dCBJV0wgRXJyb3IgTG9nIER1bXA6ClsgMzYwMy4yMjg3MDhdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiBTdGF0dXM6IDB4MDAwMDAwODAsIGNvdW50OiA3ClsgMzYwMy4yMzQ1NTNdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweDIwMTAxMDRDIHwgQURWQU5DRURfU1lTQVNTRVJUClsgMzYw
My4yNDA2NThdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdW1hYyBicmFu
Y2hsaW5rMQpbIDM2MDMuMjQ2NTkwXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHhDMDA4Q0Mz
QyB8IHVtYWMgYnJhbmNobGluazIKWyAzNjAzLjI1MjUyMl0gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IDB4QzAwODc2OTggfCB1bWFjIGludGVycnVwdGxpbmsxClsgMzYwMy4yNTg3MTddIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdW1hYyBpbnRlcnJ1cHRsaW5rMgpb
IDM2MDMuMjY0OTI5XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHhGRkZGMDEwMSB8IHVtYWMg
ZGF0YTEKWyAzNjAzLjI3MDM0NF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAxMDAwODAg
fCB1bWFjIGRhdGEyClsgMzYwMy4yNzU3NzFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweERF
QURCRUVGIHwgdW1hYyBkYXRhMwpbIDM2MDMuMjgxMjAyXSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDAwMDAzMCB8IHVtYWMgbWFqb3IKWyAzNjAzLjI4NjYyNV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4NEZBMDA0MUYgfCB1bWFjIG1pbm9yClsgMzYwMy4yOTIwNTVdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweEQyQkI1ODdBIHwgZnJhbWUgcG9pbnRlcgpbIDM2MDMuMjk3
NzMzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHhDMDg4N0YzQyB8IHN0YWNrIHBvaW50ZXIK
WyAzNjAzLjMwMzQxNV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4RkZGRjAxMDEgfCBsYXN0
IGhvc3QgY21kClsgMzYwMy4zMDkwOThdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDIw
MDQwIHwgaXNyIHN0YXR1cyByZWcKWyAzNjAzLjMxNDk2NV0gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IEZzZXEgUmVnaXN0ZXJzOgpbIDM2MDMuMzE5NzY1XSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHhFMDAwMDAwMCB8IEZTRVFfRVJST1JfQ09ERQpbIDM2MDMuMzI1NjkwXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHg4MDI5MDAwMSB8IEZTRVFfVE9QX0lOSVRfVkVSU0lPTgpbIDM2
MDMuMzMyMTM1XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg4MDA1MDAwOCB8IEZTRVFfQ05W
SU9fSU5JVF9WRVJTSU9OClsgMzYwMy4zMzg3NTVdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDBBNTAzIHwgRlNFUV9PVFBfVkVSU0lPTgpbIDM2MDMuMzQ0NzY2XSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHg4MDAwMDAwMyB8IEZTRVFfVE9QX0NPTlRFTlRfVkVSU0lPTgpbIDM2
MDMuMzUxNDcxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg0NTUyNDE0RSB8IEZTRVFfQUxJ
VkVfVE9LRU4KWyAzNjAzLjM1NzQ4M10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAxMDA1
MzAgfCBGU0VRX0NOVklfSUQKWyAzNjAzLjM2MzE0N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IDB4MDAwMDA1MzIgfCBGU0VRX0NOVlJfSUQKWyAzNjAzLjM2ODgxM10gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4MDAxMDA1MzAgfCBDTlZJX0FVWF9NSVNDX0NISVAKWyAzNjAzLjM3NTAw
MF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDA1MzIgfCBDTlZSX0FVWF9NSVNDX0NI
SVAKWyAzNjAzLjM4MTE4N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDVCMDkwNUIgfCBD
TlZSX1NDVV9TRF9SRUdTX1NEX1JFR19ESUdfRENEQ19WVFJJTQpbIDM2MDMuMzg5MTA4XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDI1QiB8IENOVlJfU0NVX1NEX1JFR1NfU0Rf
UkVHX0FDVElWRV9WRElHX01JUlJPUgpbIDM2MDMuMzk3NjQ5XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogQ29sbGVjdGluZyBkYXRhOiB0cmlnZ2VyIDIgZmlyZWQuClsgMzYwMy40MDM5Mjdd
IGllZWU4MDIxMSBwaHkwOiBIYXJkd2FyZSByZXN0YXJ0IHdhcyByZXF1ZXN0ZWQKWyAzNjA0
LjI3MTg0Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IEFwcGx5aW5nIGRlYnVnIGRlc3RpbmF0
aW9uIEVYVEVSTkFMX0RSQU0KWyAzNjA0LjQzODA4MF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IEZXIGFscmVhZHkgY29uZmlndXJlZCAoMCkgLSByZS1jb25maWd1cmluZwpbIDM2MTYuNTU3
MDY0XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogTWljcm9jb2RlIFNXIGVycm9yIGRldGVjdGVk
LiBSZXN0YXJ0aW5nIDB4MC4KWyAzNjE2LjU2NDUzMV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IFN0YXJ0IElXTCBFcnJvciBMb2cgRHVtcDoKWyAzNjE2LjU3MDE1MF0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IFN0YXR1czogMHgwMDAwMDA4MCwgY291bnQ6IDYKWyAzNjE2LjU3NjAzNF0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IExvYWRlZCBmaXJtd2FyZSB2ZXJzaW9uOiA0OC40ZmEw
MDQxZi4wClsgMzYxNi41ODI3ODddIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDcx
IHwgTk1JX0lOVEVSUlVQVF9VTUFDX0ZBVEFMICAgIApbIDM2MTYuNTkwMjI0XSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDAwMjJGMCB8IHRybV9od19zdGF0dXMwClsgMzYxNi41OTYw
ODldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgdHJtX2h3X3N0YXR1czEK
WyAzNjE2LjYwMTkxMF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDA0RjhFM0MgfCBicmFu
Y2hsaW5rMgpbIDM2MTYuNjA3NDkwXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDRFNEZG
NCB8IGludGVycnVwdGxpbmsxClsgMzYxNi42MTMzMjRdIGl3bHdpZmkgMDAwMDowMTowMC4w
OiAweDAwNEU0RkY0IHwgaW50ZXJydXB0bGluazIKWyAzNjE2LjYxOTIzOF0gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDA0RjRBRDIgfCBkYXRhMQpbIDM2MTYuNjI0MzMwXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDAwMTAwMCB8IGRhdGEyClsgMzYxNi42MjkzOTVdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweEYwMDAwMDA4IHwgZGF0YTMKWyAzNjE2LjYzNDUwMF0gaXds
d2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAzRDc2MTQgfCBiZWFjb24gdGltZQpbIDM2MTYuNjQw
MTMyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMEJCMEQyNSB8IHRzZiBsb3cKWyAzNjE2
LjY0NTM3Ml0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB0c2YgaGkKWyAz
NjE2LjY1MDU4Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB0aW1lIGdw
MQpbIDM2MTYuNjU1ODkzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMEJCNzRCNCB8IHRp
bWUgZ3AyClsgMzYxNi42NjEyMDFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAx
IHwgdUNvZGUgcmV2aXNpb24gdHlwZQpbIDM2MTYuNjY3NDUwXSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHgwMDAwMDAzMCB8IHVDb2RlIHZlcnNpb24gbWFqb3IKWyAzNjE2LjY3Mzc4MF0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4NEZBMDA0MUYgfCB1Q29kZSB2ZXJzaW9uIG1pbm9y
ClsgMzYxNi42ODAwNzZdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMzQwIHwgaHcg
dmVyc2lvbgpbIDM2MTYuNjg1Njc5XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMEM4OTAw
MCB8IGJvYXJkIHZlcnNpb24KWyAzNjE2LjY5MTQ4M10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IDB4ODAzN0ZGMDIgfCBoY21kClsgMzYxNi42OTY0NjldIGl3bHdpZmkgMDAwMDowMTowMC4w
OiAweDAwMDIwMDAwIHwgaXNyMApbIDM2MTYuNzAxNTA1XSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDAwMDAwMCB8IGlzcjEKWyAzNjE2LjcwNjUwNF0gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IDB4MThGODQ4MDIgfCBpc3IyClsgMzYxNi43MTE0NzhdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDA0QzFGRkNDIHwgaXNyMwpbIDM2MTYuNzE2NDM1XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHgwMDAwMDAwMCB8IGlzcjQKWyAzNjE2LjcyMTQwNV0gaXdsd2lmaSAwMDAwOjAx
OjAwLjA6IDB4MDAxRDAxRDIgfCBsYXN0IGNtZCBJZApbIDM2MTYuNzI3MDAxXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDRGNEFEMiB8IHdhaXRfZXZlbnQKWyAzNjE2LjczMjQ5Nl0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBsMnBfY29udHJvbApbIDM2MTYu
NzM4MDg4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGwycF9kdXJhdGlv
bgpbIDM2MTYuNzQzNzU4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IGwy
cF9taHZhbGlkClsgMzYxNi43NDkzNDldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAw
MDAwIHwgbDJwX2FkZHJfbWF0Y2gKWyAzNjE2Ljc1NTE5M10gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IDB4MDAwMDAwMDggfCBsbXBtX3BtZ19zZWwKWyAzNjE2Ljc2MDg2M10gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB0aW1lc3RhbXAKWyAzNjE2Ljc2NjMyM10gaXds
d2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDI4NjggfCBmbG93X2hhbmRsZXIKWyAzNjE2Ljc3
MjE2MF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFN0YXJ0IElXTCBFcnJvciBMb2cgRHVtcDoK
WyAzNjE2Ljc3NzgwN10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IFN0YXR1czogMHgwMDAwMDA4
MCwgY291bnQ6IDcKWyAzNjE2Ljc4Mzc0OF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MjAx
MDEwNEMgfCBBRFZBTkNFRF9TWVNBU1NFUlQKWyAzNjE2Ljc4OTkyNV0gaXdsd2lmaSAwMDAw
OjAxOjAwLjA6IDB4MDAwMDAwMDAgfCB1bWFjIGJyYW5jaGxpbmsxClsgMzYxNi43OTU5NTdd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweEMwMDhDQzNDIHwgdW1hYyBicmFuY2hsaW5rMgpb
IDM2MTYuODAyMDE3XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHhDMDA4NzY5OCB8IHVtYWMg
aW50ZXJydXB0bGluazEKWyAzNjE2LjgwODI1N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4
MDAwMDAwMDAgfCB1bWFjIGludGVycnVwdGxpbmsyClsgMzYxNi44MTQ1NDRdIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweEZGRkYwMTAyIHwgdW1hYyBkYXRhMQpbIDM2MTYuODIwMDU0XSBp
d2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDEwMDA4MCB8IHVtYWMgZGF0YTIKWyAzNjE2Ljgy
NTU0N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4REVBREJFRUYgfCB1bWFjIGRhdGEzClsg
MzYxNi44MzEwMTRdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDMwIHwgdW1hYyBt
YWpvcgpbIDM2MTYuODM2NTA4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg0RkEwMDQxRiB8
IHVtYWMgbWlub3IKWyAzNjE2Ljg0MjAxM10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDBC
Qjc0QTggfCBmcmFtZSBwb2ludGVyClsgMzYxNi44NDc3NTZdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweEMwODg3RjNDIHwgc3RhY2sgcG9pbnRlcgpbIDM2MTYuODUzNTExXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHhGRkZGMDEwMiB8IGxhc3QgaG9zdCBjbWQKWyAzNjE2Ljg1OTI1
MF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMjAwNDAgfCBpc3Igc3RhdHVzIHJlZwpb
IDM2MTYuODY1MjEyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogRnNlcSBSZWdpc3RlcnM6Clsg
MzYxNi44NzAwMzldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweEUwMDAwMDAwIHwgRlNFUV9F
UlJPUl9DT0RFClsgMzYxNi44NzYwMzJdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDgwMjkw
MDAxIHwgRlNFUV9UT1BfSU5JVF9WRVJTSU9OClsgMzYxNi44ODI1NjRdIGl3bHdpZmkgMDAw
MDowMTowMC4wOiAweDgwMDUwMDA4IHwgRlNFUV9DTlZJT19JTklUX1ZFUlNJT04KWyAzNjE2
Ljg4OTI0NV0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMEE1MDMgfCBGU0VRX09UUF9W
RVJTSU9OClsgMzYxNi44OTUyOTldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDgwMDAwMDAz
IHwgRlNFUV9UT1BfQ09OVEVOVF9WRVJTSU9OClsgMzYxNi45MDIwNzVdIGl3bHdpZmkgMDAw
MDowMTowMC4wOiAweDQ1NTI0MTRFIHwgRlNFUV9BTElWRV9UT0tFTgpbIDM2MTYuOTA4MTUz
XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDEwMDUzMCB8IEZTRVFfQ05WSV9JRApbIDM2
MTYuOTEzODkxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDUzMiB8IEZTRVFfQ05W
Ul9JRApbIDM2MTYuOTE5NjUxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDEwMDUzMCB8
IENOVklfQVVYX01JU0NfQ0hJUApbIDM2MTYuOTI1OTMzXSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDAwMDUzMiB8IENOVlJfQVVYX01JU0NfQ0hJUApbIDM2MTYuOTMyMjEzXSBpd2x3
aWZpIDAwMDA6MDE6MDAuMDogMHgwNUIwOTA1QiB8IENOVlJfU0NVX1NEX1JFR1NfU0RfUkVH
X0RJR19EQ0RDX1ZUUklNClsgMzYxNi45NDAyMjhdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMDAwMjVCIHwgQ05WUl9TQ1VfU0RfUkVHU19TRF9SRUdfQUNUSVZFX1ZESUdfTUlSUk9S
ClsgMzYxNi45NDk0MTBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBDb2xsZWN0aW5nIGRhdGE6
IHRyaWdnZXIgMiBmaXJlZC4KWyAzNjE2Ljk1NTc0Nl0gaWVlZTgwMjExIHBoeTA6IEhhcmR3
YXJlIHJlc3RhcnQgd2FzIHJlcXVlc3RlZApbIDM2MTcuODYzMzIzXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogQXBwbHlpbmcgZGVidWcgZGVzdGluYXRpb24gRVhURVJOQUxfRFJBTQpbIDM2
MTguMDI4MjQwXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogRlcgYWxyZWFkeSBjb25maWd1cmVk
ICgwKSAtIHJlLWNvbmZpZ3VyaW5nClsgMzYzMS44MzU3OTNdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiBNaWNyb2NvZGUgU1cgZXJyb3IgZGV0ZWN0ZWQuIFJlc3RhcnRpbmcgMHgwLgpbIDM2
MzEuODQzMzc0XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogU3RhcnQgSVdMIEVycm9yIExvZyBE
dW1wOgpbIDM2MzEuODQ5MDI3XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogU3RhdHVzOiAweDAw
MDAwMDgwLCBjb3VudDogNgpbIDM2MzEuODU0OTIzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
TG9hZGVkIGZpcm13YXJlIHZlcnNpb246IDQ4LjRmYTAwNDFmLjAKWyAzNjMxLjg2MTY5MV0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwNzEgfCBOTUlfSU5URVJSVVBUX1VNQUNf
RkFUQUwgICAgClsgMzYzMS44Njg3MDldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAy
MkYwIHwgdHJtX2h3X3N0YXR1czAKWyAzNjMxLjg3NDUyNF0gaXdsd2lmaSAwMDAwOjAxOjAw
LjA6IDB4MDAwMDAwMDAgfCB0cm1faHdfc3RhdHVzMQpbIDM2MzEuODgwMzE0XSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogMHgwMDRGOEUzQyB8IGJyYW5jaGxpbmsyClsgMzYzMS44ODU4NDRd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwNEU0RkY0IHwgaW50ZXJydXB0bGluazEKWyAz
NjMxLjg5MTYzM10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDA0RTRGRjQgfCBpbnRlcnJ1
cHRsaW5rMgpbIDM2MzEuODk3NDIyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDRGNEFE
MiB8IGRhdGExClsgMzYzMS45MDI0MzddIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAx
MDAwIHwgZGF0YTIKWyAzNjMxLjkwNzQ0N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4NzAw
MDAwMDggfCBkYXRhMwpbIDM2MzEuOTEyNDU0XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgw
MDBDMTlFRiB8IGJlYWNvbiB0aW1lClsgMzYzMS45MTgyMzhdIGl3bHdpZmkgMDAwMDowMTow
MC4wOiAweDAwRDRDQkVCIHwgdHNmIGxvdwpbIDM2MzEuOTIzNDYyXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogMHgwMDAwMDAwMCB8IHRzZiBoaQpbIDM2MzEuOTI4NTU3XSBpd2x3aWZpIDAw
MDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHRpbWUgZ3AxClsgMzYzMS45MzM4NTNdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweDAwRDUzMzc1IHwgdGltZSBncDIKWyAzNjMxLjkzOTEyM10g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDEgfCB1Q29kZSByZXZpc2lvbiB0eXBl
ClsgMzYzMS45NDUzNDRdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDMwIHwgdUNv
ZGUgdmVyc2lvbiBtYWpvcgpbIDM2MzEuOTUxNTYyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHg0RkEwMDQxRiB8IHVDb2RlIHZlcnNpb24gbWlub3IKWyAzNjMxLjk1Nzc4Ml0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAzNDAgfCBodyB2ZXJzaW9uClsgMzYzMS45NjMyMjVd
IGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwQzg5MDAwIHwgYm9hcmQgdmVyc2lvbgpbIDM2
MzEuOTY4OTMzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHg4MEM4RkQwNCB8IGhjbWQKWyAz
NjMxLjk3Mzg4N10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMjAwMDAgfCBpc3IwClsg
MzYzMS45Nzg4MDldIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaXNyMQpb
IDM2MzEuOTgzNzE1XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgxOEY4NDgwMiB8IGlzcjIK
WyAzNjMxLjk4ODYyNl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDRDMUZGQ0MgfCBpc3Iz
ClsgMzYzMS45OTM1MzZdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDAwIHwgaXNy
NApbIDM2MzEuOTk4NDQ4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDJEMDE5QyB8IGxh
c3QgY21kIElkClsgMzYzMi4wMDM5NjFdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwNEY0
QUQyIHwgd2FpdF9ldmVudApbIDM2MzIuMDA5MzkyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDog
MHgwMDAwMDA4MCB8IGwycF9jb250cm9sClsgMzYzMi4wMTUwMTZdIGl3bHdpZmkgMDAwMDow
MTowMC4wOiAweDAwMDAwMDAwIHwgbDJwX2R1cmF0aW9uClsgMzYzMi4wMjA2NDNdIGl3bHdp
ZmkgMDAwMDowMTowMC4wOiAweDAwMDAwMDNGIHwgbDJwX21odmFsaWQKWyAzNjMyLjAyNjE2
Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAwMDAgfCBsMnBfYWRkcl9tYXRjaApb
IDM2MzIuMDMxOTk4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwOCB8IGxtcG1f
cG1nX3NlbApbIDM2MzIuMDM3NjUyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAw
MCB8IHRpbWVzdGFtcApbIDM2MzIuMDQzMDUzXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgw
MDAwNTg5OCB8IGZsb3dfaGFuZGxlcgpbIDM2MzIuMDQ4ODc0XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogU3RhcnQgSVdMIEVycm9yIExvZyBEdW1wOgpbIDM2MzIuMDU0NTQyXSBpd2x3aWZp
IDAwMDA6MDE6MDAuMDogU3RhdHVzOiAweDAwMDAwMDgwLCBjb3VudDogNwpbIDM2MzIuMDYw
NDQ2XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgyMDEwMTA0QyB8IEFEVkFOQ0VEX1NZU0FT
U0VSVApbIDM2MzIuMDY2NjMxXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8
IHVtYWMgYnJhbmNobGluazEKWyAzNjMyLjA3MjYyNl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6
IDB4QzAwOENDM0MgfCB1bWFjIGJyYW5jaGxpbmsyClsgMzYzMi4wNzg2MzddIGl3bHdpZmkg
MDAwMDowMTowMC4wOiAweEMwMDg3Njk4IHwgdW1hYyBpbnRlcnJ1cHRsaW5rMQpbIDM2MzIu
MDg0ODg4XSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMDAwMDAwMCB8IHVtYWMgaW50ZXJy
dXB0bGluazIKWyAzNjMyLjA5MTE2M10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4RkZGRjAx
MDMgfCB1bWFjIGRhdGExClsgMzYzMi4wOTY2NDJdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAw
eDAwMTAwMDgwIHwgdW1hYyBkYXRhMgpbIDM2MzIuMTAyMTM1XSBpd2x3aWZpIDAwMDA6MDE6
MDAuMDogMHhERUFEQkVFRiB8IHVtYWMgZGF0YTMKWyAzNjMyLjEwNzYwM10gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4MDAwMDAwMzAgfCB1bWFjIG1ham9yClsgMzYzMi4xMTMwOTJdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDRGQTAwNDFGIHwgdW1hYyBtaW5vcgpbIDM2MzIuMTE4
NTcyXSBpd2x3aWZpIDAwMDA6MDE6MDAuMDogMHgwMEQ1MzM2OSB8IGZyYW1lIHBvaW50ZXIK
WyAzNjMyLjEyNDMyNF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4QzA4ODdGM0MgfCBzdGFj
ayBwb2ludGVyClsgMzYzMi4xMzAwNTBdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweEZGRkYw
MTAzIHwgbGFzdCBob3N0IGNtZApbIDM2MzIuMTM1Nzc5XSBpd2x3aWZpIDAwMDA6MDE6MDAu
MDogMHgwMDAyMDA0MCB8IGlzciBzdGF0dXMgcmVnClsgMzYzMi4xNDE3NDddIGl3bHdpZmkg
MDAwMDowMTowMC4wOiBGc2VxIFJlZ2lzdGVyczoKWyAzNjMyLjE0NjU3N10gaXdsd2lmaSAw
MDAwOjAxOjAwLjA6IDB4RTAwMDAwMDAgfCBGU0VRX0VSUk9SX0NPREUKWyAzNjMyLjE1MjU2
Nl0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4ODAyOTAwMDEgfCBGU0VRX1RPUF9JTklUX1ZF
UlNJT04KWyAzNjMyLjE1OTEwN10gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4ODAwNTAwMDgg
fCBGU0VRX0NOVklPX0lOSVRfVkVSU0lPTgpbIDM2MzIuMTY1ODIwXSBpd2x3aWZpIDAwMDA6
MDE6MDAuMDogMHgwMDAwQTUwMyB8IEZTRVFfT1RQX1ZFUlNJT04KWyAzNjMyLjE3MTkzMl0g
aXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4ODAwMDAwMDMgfCBGU0VRX1RPUF9DT05URU5UX1ZF
UlNJT04KWyAzNjMyLjE3ODcyOF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4NDU1MjQxNEUg
fCBGU0VRX0FMSVZFX1RPS0VOClsgMzYzMi4xODQ4MjhdIGl3bHdpZmkgMDAwMDowMTowMC4w
OiAweDAwMTAwNTMwIHwgRlNFUV9DTlZJX0lEClsgMzYzMi4xOTA1ODNdIGl3bHdpZmkgMDAw
MDowMTowMC4wOiAweDAwMDAwNTMyIHwgRlNFUV9DTlZSX0lEClsgMzYzMi4xOTYzMzZdIGl3
bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMTAwNTMwIHwgQ05WSV9BVVhfTUlTQ19DSElQClsg
MzYzMi4yMDI2MTRdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDAwMDAwNTMyIHwgQ05WUl9B
VVhfTUlTQ19DSElQClsgMzYzMi4yMDg4OTNdIGl3bHdpZmkgMDAwMDowMTowMC4wOiAweDA1
QjA5MDVCIHwgQ05WUl9TQ1VfU0RfUkVHU19TRF9SRUdfRElHX0RDRENfVlRSSU0KWyAzNjMy
LjIxNjkxMF0gaXdsd2lmaSAwMDAwOjAxOjAwLjA6IDB4MDAwMDAyNUIgfCBDTlZSX1NDVV9T
RF9SRUdTX1NEX1JFR19BQ1RJVkVfVkRJR19NSVJST1IKWyAzNjMyLjIyNjE0Ml0gaXdsd2lm
aSAwMDAwOjAxOjAwLjA6IENvbGxlY3RpbmcgZGF0YTogdHJpZ2dlciAyIGZpcmVkLgpbIDM2
MzIuMjMyNTI5XSBpZWVlODAyMTEgcGh5MDogSGFyZHdhcmUgcmVzdGFydCB3YXMgcmVxdWVz
dGVkClsgMzYzMy4wMDI4MjhdIGl3bHdpZmkgMDAwMDowMTowMC4wOiBBcHBseWluZyBkZWJ1
ZyBkZXN0aW5hdGlvbiBFWFRFUk5BTF9EUkFNClsgMzYzMy4xNjcxMTFdIGl3bHdpZmkgMDAw
MDowMTowMC4wOiBGVyBhbHJlYWR5IGNvbmZpZ3VyZWQgKDApIC0gcmUtY29uZmlndXJpbmcK

--------------DBD87A3E560DE727CF1E2CBC
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
CRRHmF65qWi8umh5YtZBLQ=3D=3D
=3DWfPg
-----END PGP PUBLIC KEY BLOCK-----

--------------DBD87A3E560DE727CF1E2CBC--
