Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CB1441568
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 09:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbhKAIkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 04:40:11 -0400
Received: from m13127.mail.163.com ([220.181.13.127]:9920 "EHLO
        m13127.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAIkK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 04:40:10 -0400
X-Greylist: delayed 909 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Nov 2021 04:40:10 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=/GtoK
        OGaSHMVZFe3fp5+kNeG3yN5QXdy1es4zAdHlUE=; b=XmcrosB2dZQLwoFNQSGbd
        jcgo/QVc9CxSDvwu1wTZll6rTttA1SCySHrSn5iYUCbjo/pMB6T2F1VuX5rEmL4v
        eKQEZQIElWZEXkuXIgGCP6W80zl/O2n6Ze+QA2WLUFFqRoGBRTD0On62sbvOAnIR
        Rru7CYqikoJ2FYoP5Lciss=
Received: from yxj790222$163.com ( [124.126.178.33] ) by
 ajax-webmail-wmsvr127 (Coremail) ; Mon, 1 Nov 2021 16:21:50 +0800 (CST)
X-Originating-IP: [124.126.178.33]
Date:   Mon, 1 Nov 2021 16:21:50 +0800 (CST)
From:   =?UTF-8?B?5bCk5pmT5p2w?= <yxj790222@163.com>
To:     linux-wireless@vger.kernel.org
Subject: qca9984 fails to work
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20210622(1d4788a8)
 Copyright (c) 2002-2021 www.mailtech.cn 163com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7fc1368d.53c6.17cda9721bb.Coremail.yxj790222@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: f8GowABnbi6eo39hBnZLAQ--.3699W
X-CM-SenderInfo: 510mlmaqssjqqrwthudrp/xtbBOQ8+vF-PJ0c2MAACsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CgpiZWZvcmUgdXBkYXRlLCBldmVydGhpbmcgaXMgb2ssIGFmdGVyIHVwZGF0ZSBrZXJuZWwsIHFj
YTk5ODQgZmFpbHMgdG8gd29yay4KZG1lc2d8Z3JlcCBhdGgxMGs6CgpbIMKgwqDCoDQuNzY0MjEw
XSBhdGgxMGtfcGNpIDAwMDA6MDc6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMDAwIC0+IDAwMDIp
CgpbIMKgwqDCoDQuNzY1NTI3XSBhdGgxMGtfcGNpIDAwMDA6MDc6MDAuMDogcGNpIGlycSBtc2kg
b3Blcl9pcnFfbW9kZSAyIGlycV9tb2RlIDAgcmVzZXRfbW9kZSAwCgpbIMKgwqDCoDQuODg2ODI4
XSBhdGgxMGtfcGNpIDAwMDA6MDc6MDAuMDogZmlybXdhcmU6IGRpcmVjdC1sb2FkaW5nIGZpcm13
YXJlIGF0aDEway9wcmUtY2FsLXBjaS0wMDAwOjA3OjAwLjAuYmluCgpbIMKgwqDCoDQuODg2ODQ0
XSBhdGgxMGtfcGNpIDAwMDA6MDc6MDAuMDogZmlybXdhcmU6IGZhaWxlZCB0byBsb2FkIGF0aDEw
ay9RQ0E5OTg0L2h3MS4wL2Zpcm13YXJlLTYuYmluICgtMikKClsgwqDCoMKgNC44ODg3NjldIGF0
aDEwa19wY2kgMDAwMDowNzowMC4wOiBmaXJtd2FyZTogZGlyZWN0LWxvYWRpbmcgZmlybXdhcmUg
YXRoMTBrL1FDQTk5ODQvaHcxLjAvZmlybXdhcmUtNS5iaW4KClsgwqDCoMKgNC44ODg3NzRdIGF0
aDEwa19wY2kgMDAwMDowNzowMC4wOiBxY2E5OTg0L3FjYTk5OTQgaHcxLjAgdGFyZ2V0IDB4MDEw
MDAwMDAgY2hpcF9pZCAweDAwMDAwMDAwIHN1YiAxNjhjOmNhZmUKClsgwqDCoMKgNC44ODg3Nzdd
IGF0aDEwa19wY2kgMDAwMDowNzowMC4wOiBrY29uZmlnIGRlYnVnIDAgZGVidWdmcyAwIHRyYWNp
bmcgMCBkZnMgMCB0ZXN0bW9kZSAwCgpbIMKgwqDCoDQuODg5MTI0XSBhdGgxMGtfcGNpIDAwMDA6
MDc6MDAuMDogZmlybXdhcmUgdmVyIDEwLjQtMy45LjAuMi0wMDEzMSBhcGkgNSBmZWF0dXJlcyBu
by1wMnAsbWZwLHBlZXItZmxvdy1jdHJsLGJ0Y29leC1wYXJhbSxhbGxvd3MtbWVzaC1iY2FzdCxu
by1wcyxwZWVyLWZpeGVkLXJhdGUsCmlyYW0tcmVjb3ZlcnkgY3JjMzIgMjNiZDllNDMKClsgwqDC
oMKgNy4xNzA0ODJdIGF0aDEwa19wY2kgMDAwMDowNzowMC4wOiBmaXJtd2FyZTogZGlyZWN0LWxv
YWRpbmcgZmlybXdhcmUgYXRoMTBrL1FDQTk5ODQvaHcxLjAvYm9hcmQtMi5iaW4KClsgwqDCoMKg
Ny4xNzA2MDBdIGF0aDEwa19wY2kgMDAwMDowNzowMC4wOiBib2FyZF9maWxlIGFwaSAyIGJtaV9p
ZCAwOjEgY3JjMzIgODU0OTg3MzQKClsgwqDCoDEwLjgxMDAxNl0gYXRoMTBrX3BjaSAwMDAwOjA3
OjAwLjA6IGZhaWxlZCB0byBjb3B5IHRhcmdldCBpcmFtIGNvbnRlbnRzOiAtMTIKClsgwqDCoDEw
Ljg2NTI5NV0gYXRoMTBrX3BjaSAwMDAwOjA3OjAwLjA6IGNvdWxkIG5vdCBpbml0IGNvcmUgKC0x
MikKClsgwqDCoDEwLjg2NTMzMl0gYXRoMTBrX3BjaSAwMDAwOjA3OjAwLjA6IGNvdWxkIG5vdCBw
cm9iZSBmdyAoLTEyKQoKa2VybmVsOgpbICAgIDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDUuMTQu
MC0zLWFtZDY0IChkZWJpYW4ta2VybmVsQGxpc3RzLmRlYmlhbi5vcmcpIChnY2MtMTAgKERlYmlh
biAxMC4zLjAtMTEpIDEwLjMuMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi4z
NykgIzEgU01QIERlYmlhbiA1LjE0LjEyLTEgKDIwMjEtMTAtMTQpClsgICAgMC4wMDAwMDBdIENv
bW1hbmQgbGluZTogQk9PVF9JTUFHRT0vYm9vdC92bWxpbnV6LTUuMTQuMC0zLWFtZDY0IHJvb3Q9
VVVJRD02YWQxYmRhNC05ZmViLTQ4NDktYjFkOS00MzExYzc2ZTM1MjIgcm8gcXVpZXQKWyAgICAw
LjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDAxOiAneDg3IGZs
b2F0aW5nIHBvaW50IHJlZ2lzdGVycycKWyAgICAwLjAwMDAwMF0geDg2L2ZwdTogU3VwcG9ydGlu
ZyBYU0FWRSBmZWF0dXJlIDB4MDAyOiAnU1NFIHJlZ2lzdGVycycKWyAgICAwLjAwMDAwMF0geDg2
L2ZwdTogU3VwcG9ydGluZyBYU0FWRSBmZWF0dXJlIDB4MDA0OiAnQVZYIHJlZ2lzdGVycycKWyAg
ICAwLjAwMDAwMF0geDg2L2ZwdTogeHN0YXRlX29mZnNldFsyXTogIDU3NiwgeHN0YXRlX3NpemVz
WzJdOiAgMjU2CgoK
