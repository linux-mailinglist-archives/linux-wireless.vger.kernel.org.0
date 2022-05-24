Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A43B532F3A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbiEXQwD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 12:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiEXQv7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 12:51:59 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467033B54E
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 09:51:57 -0700 (PDT)
Date:   Tue, 24 May 2022 16:51:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1653411112; x=1653670312;
        bh=eub/et+mHH8VEHCirBk8CEjJyfwhvFaMCP9BnHpivR4=;
        h=Date:To:From:Reply-To:Subject:Message-ID:Feedback-ID:From:To:Cc:
         Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=f1qHqhS4rH/7CTLRQqhKUdNnGFDc+FfoylppBrQCBZqGNjN1haXmUtCfkF+0QrMEP
         rMYxwgUYDLUW+KriohCNPE2MO8ZD+LUJDzKC8bO9RIf0F1upHWKCaLIr67tZTkYGjA
         KtN/3Aiq1Dy79VmPq7ijTbZmKAFOb70CD2JiIrA5EAHFZH8qhX6drOJ2q7eWfC5gNF
         uD7GEu8MZb1KMJegSL294XB+Zp9s6/lf9OsnR8adJdIrreALigyWMf6jz8coAOf7wh
         gUM2nuP4cUpeqn9hapUdebnxY0idA9bkzWgm68tWXKBvujEiI47ygI3DPhpQVozlLa
         K5LF0r1WYy0MA==
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_RPhNPD9Bya3UKZFdwHbHQzdDkAkL7WNqxfiTeZTk"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--b1_RPhNPD9Bya3UKZFdwHbHQzdDkAkL7WNqxfiTeZTk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear all,

I am not a regular C developer nor kernel developer. I don't regularly repo=
rt issues, so I will probably do things wrong.

I investigated a crash that IIUC occurs with hardened memory allocation ena=
bled and a firmware-crash followed by an early failure during hardware rein=
itialization/probing. The hardened allocator detects double-free issue.

I have created the patch (see attachment) against linux-5.18. Though, pleas=
e check carefully, because I have not been able to confirm that it actually=
 works. I am hoping someone familiar with the code-base can either test thi=
s easily, or confirm from review/analysis.

The commit message describes it in more detail. In summary:
'brcmf_sdio_bus_reset' cleans up and reinitializes the hardware. It frees m=
emory used by (struct brcmf_sdio_dev)->freezer (struct brcmf_sdiod_freezer)=
. However, it then goes to probe the hardware, and an early failure to prob=
e results in the same freeing, both called through function 'brcmf_sdiod_fr=
eezer_detach' called inside 'brcmf_sdiod_remove'. Which results in double f=
reeing.

As mentioned before, I was not able to test this and I do not regularly dev=
elop in C. I am not confident that this is the proper way to fix it, but it=
 seemed obvious enough. I hope you can support in fixing this bug.

Kind regards,
Danny

PS: Please let me know if I am doing things wrong. I have included both mai=
ntainers and mailing lists from https://docs.kernel.org/process/maintainers=
.html#broadcom-brcm80211-ieee802-11n-wireless-driver I hope I this is alrig=
ht.
--b1_RPhNPD9Bya3UKZFdwHbHQzdDkAkL7WNqxfiTeZTk
Content-Type: text/x-patch; name=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch

RnJvbSBkZGIyODFlMmViZjdlNmJkODlmMDkxNDAzNjE2YTlkNzdkNzNiZTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5ueSB2YW4gSGV1bWVuIDxkYW5ueUBkYW5ueXZhbmhldW1l
bi5ubD4KRGF0ZTogVHVlLCAyNCBNYXkgMjAyMiAxODozMDo1MCArMDIwMApTdWJqZWN0OiBbUEFU
Q0hdIGJyY21mbWFjOiBwcmV2ZW50IGRvdWJsZS1mcmVlIG9uIGhhcmR3YXJlLXJlc2V0LgoKSW4g
Y2FzZSBvZiBidWdneSBmaXJtd2FyZSwgYnJjbWZtYWMgbWF5IHBlcmZvcm0gYSBoYXJkd2FyZSBy
ZXNldC4gSWYgZHVyaW5nCnJlc2V0IGFuZCBzdWJzZXF1ZW50IHByb2JpbmcgYW4gZWFybHkgZmFp
bHVyZSBvY2N1cnMsIGEgbWVtb3J5IHJlZ2lvbiBpcwphY2NpZGVudGFsbHkgZG91YmxlLWZyZWVk
LiBXaXRoIGhhcmRlbmVkIG1lbW9yeSBhbGxvY2F0aW9uIGVuYWJsZWQsIHRoaXMgZXJyb3IKd2ls
bCBiZSBkZXRlY3RlZC4KCkdpdmVuIGEgZmlybXdhcmUgY3Jhc2gsIGZ1bmN0aW9uICdicmNtZl9z
ZGlvX2J1c19yZXNldCcgaXMgY2FsbGVkLiBJdCBjYWxscwonYnJjbWZfc2Rpb2RfcmVtb3ZlJywg
dGhlbiBmb2xsb3dzIHVwIHdpdGggJ2JyY21mX3NkaW9kX3Byb2JlJyB0byByZWluaXRpYWxpemUK
dGhlIGhhcmR3YXJlLiBJZiAnYnJjbWZfc2Rpb2RfcHJvYmUnIGZhaWxzIHRvICJzZXQgRjEgYmxv
Y2tzaXplIiwgaXQgZXhpdHMKZWFybHksIHdoaWNoIGluY2x1ZGVzIGNhbGxpbmcgJ2JyY21mX3Nk
aW9kX3JlbW92ZScuIEluIGJvdGggY2FzZXMKJ2JyY21mX3NkaW9kX2ZyZWV6ZXJfZGV0YWNoJyBp
cyBjYWxsZWQgdG8gZnJlZSBhbGxvY2F0ZWQgJy5mcmVlemVyJywgd2hpY2gKaGFzIG5vdCB5ZXQg
YmVlbiByZS1hbGxvY2F0ZWQgdGhlIHNlY29uZCB0aW1lLgoKU3RhY2t0cmFjZSBvZiAoZmFpbGlu
ZykgaGFyZHdhcmUgcmVzZXQgYWZ0ZXIgZmlybXdhcmUtY3Jhc2g6CgpDb2RlOiBiOTQwMmI4MiA4
YjAyMDJjMCBlYjFhMDJkZiA1NDAwMDA0MSAoZDQyMTAwMDApCiByZXRfZnJvbV9mb3JrKzB4MTAv
MHgyMAoga3RocmVhZCsweDE1NC8weDE2MAogd29ya2VyX3RocmVhZCsweDE4OC8weDUwNAogcHJv
Y2Vzc19vbmVfd29yaysweDFmNC8weDQ5MAogYnJjbWZfY29yZV9idXNfcmVzZXQrMHgzNC8weDQ0
IFticmNtZm1hY10KIGJyY21mX3NkaW9fYnVzX3Jlc2V0KzB4NjgvMHhjMCBbYnJjbWZtYWNdCiBi
cmNtZl9zZGlvZF9wcm9iZSsweDE3MC8weDIxYyBbYnJjbWZtYWNdCiBicmNtZl9zZGlvZF9yZW1v
dmUrMHg0OC8weGMwIFticmNtZm1hY10KIGtmcmVlKzB4MjEwLzB4MjIwCiBfX3NsYWJfZnJlZSsw
eDU4LzB4NDBjCkNhbGwgdHJhY2U6CngyIDogMDAwMDAwMDAwMDAwMDA0MCB4MSA6IGZmZmZmYzAw
MDAyZDJiODAgeDAgOiBmZmZmMDAwMDBiNGFlZTQwCng1IDogZmZmZjgwMDAwMTNmYTcyOCB4NCA6
IDAwMDAwMDAwMDAwMDAwMDEgeDMgOiBmZmZmMDAwMDBiNGFlZTAwCng4IDogZmZmZjgwMDAwOTk2
N2NlMCB4NyA6IGZmZmY4MDAwMDk5YmZjZTAgeDYgOiAwMDAwMDAwNmY4MDA1ZDAxCngxMTogZmZm
ZjgwMDAwOTliZmNlMCB4MTA6IDAwMDAwMDAwZmZmZmYwMDAgeDkgOiBmZmZmODAwMDA4MzQwMWQw
CngxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDY1N2E2OTczNmI2MzZmNmMgeDEyOiA2MjIwMzE0
NjIwNzQ2NTczCngxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAwMDAgeDE1
OiAwMDAwMDAwMDAwMDAwMDMwCngyMDogZmZmZmZjMDAwMDJkMmJhMCB4MTk6IGZmZmZmYzAwMDAy
ZDJiODAgeDE4OiAwMDAwMDAwMDAwMDAwMDAwCngyMzogZmZmZjAwMDAwYjRhZWUwMCB4MjI6IGZm
ZmYwMDAwMGI0YWVlMDAgeDIxOiAwMDAwMDAwMDAwMDAwMDAxCngyNjogZmZmZjAwMDAwYjRhZWUw
MCB4MjU6IGZmZmYwMDAwZjc3NTM3MDUgeDI0OiAwMDAwMDAwMDAwMDEyODhhCngyOTogZmZmZjgw
MDAwYTIyYmJmMCB4Mjg6IGZmZmYwMDAwMDA0MDEyMDAgeDI3OiAwMDAwMDAwMDgwMjAwMDFhCnNw
IDogZmZmZjgwMDAwYTIyYmJmMApsciA6IGtmcmVlKzB4MjEwLzB4MjIwCnBjIDogX19zbGFiX2Zy
ZWUrMHg1OC8weDQwYwpwc3RhdGU6IDYwMDAwMDA1IChuWkN2IGRhaWYgLVBBTiAtVUFPIC1UQ08g
LURJVCAtU1NCUyBCVFlQRT0tLSkKV29ya3F1ZXVlOiBldmVudHMgYnJjbWZfY29yZV9idXNfcmVz
ZXQgW2JyY21mbWFjXQpIYXJkd2FyZSBuYW1lOiBQaW5lNjQgUGluZWJvb2sgUHJvIChEVCkKQ1BV
OiAyIFBJRDogNjM5IENvbW06IGt3b3JrZXIvMjoyIFRhaW50ZWQ6IEcgICAgICAgICBDICAgICAg
ICA1LjE2LjAtMC5icG8uNC1hcm02NCAjMSAgRGViaWFuIDUuMTYuMTItMX5icG8xMSsxCiBudm1l
bV9yb2NrY2hpcF9lZnVzZSBpbmR1c3RyaWFsaW9fdHJpZ2dlcmVkX2J1ZmZlciB2aWRlb2RldiBz
bmRfc29jX2NvcmUgc25kX3BjbV9kbWFlbmdpbmUga2ZpZm9fYnVmIHNuZF9wY20gaW9fZG9tYWlu
IG1jIGluZHVzdHJpYWxpbyBtdD4KTW9kdWxlcyBsaW5rZWQgaW46IHNuZF9zZXFfZHVtbXkgc25k
X2hydGltZXIgc25kX3NlcSBzbmRfc2VxX2RldmljZSBuZnRfZmliX2luZXQgbmZ0X2ZpYl9pcHY0
IG5mdF9maWJfaXB2NiBuZnRfZmliIG5mdF9yZWplY3RfaW5ldCBuZl9yZWplPgpJbnRlcm5hbCBl
cnJvcjogT29wcyAtIEJVRzogMCBbIzFdIFNNUAprZXJuZWwgQlVHIGF0IG1tL3NsdWIuYzozNzkh
Ci0tLQogZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJjbTgwMjExL2JyY21mbWFjL2Jj
bXNkaC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvYmNtc2Ro
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvYmNt
c2RoLmMKaW5kZXggYWMwMjI0NGE2ZmRmLi43MGE2NjRmMmE2OTcgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy9iY21zZGguYworKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvYmNtc2Ro
LmMKQEAgLTgwMiw2ICs4MDIsNyBAQCBzdGF0aWMgdm9pZCBicmNtZl9zZGlvZF9mcmVlemVyX2Rl
dGFjaChzdHJ1Y3QgYnJjbWZfc2Rpb19kZXYgKnNkaW9kZXYpCiAJaWYgKHNkaW9kZXYtPmZyZWV6
ZXIpIHsKIAkJV0FSTl9PTihhdG9taWNfcmVhZCgmc2Rpb2Rldi0+ZnJlZXplci0+ZnJlZXppbmcp
KTsKIAkJa2ZyZWUoc2Rpb2Rldi0+ZnJlZXplcik7CisJCXNkaW9kZXYtPmZyZWV6ZXIgPSBOVUxM
OwogCX0KIH0KIAotLSAKMi4zNC4xCgo=

--b1_RPhNPD9Bya3UKZFdwHbHQzdDkAkL7WNqxfiTeZTk--

