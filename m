Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE95386F4
	for <lists+linux-wireless@lfdr.de>; Mon, 30 May 2022 19:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiE3R70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 May 2022 13:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiE3R7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 May 2022 13:59:24 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520A6BFF3
        for <linux-wireless@vger.kernel.org>; Mon, 30 May 2022 10:59:22 -0700 (PDT)
Date:   Mon, 30 May 2022 17:59:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dannyvanheumen.nl;
        s=protonmail2; t=1653933559; x=1654192759;
        bh=cgil9J9KYt0OcxQhFeJf2/oiGLZ9fARDe05fn3z4MYw=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=Mlyh6A+UJnj/a/bUQdVGE5xePu29B/mGE2mRzf4hYXL5J3dzk2i2N7GDaP8Xd8Mc1
         +fdCYCIFH0rN+Pzb4HgzOUx1FIobbN2DzoIRk+iwn4r1BcnLU0YEkbu4/YCQECtzl7
         75W0H4RywLak6YPKGmVXdiT89B+NAFPMoAN3HqLmAK8FJtLPIkJ+m+KFlUOz+I2Ve/
         CC0VzEMs8vRLMPnpqeSLT/XsNm1YsEMI32jXQXCo77klp/LfncGa6+zqy9zNnEMohC
         LLE9PN4rfij2K6DDA649HWnHVR6wdDGSrUJ3NgxAv28v6tCDZ95Tm9zPqWfF3685oH
         x4N4Qi4fHtMFw==
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>
From:   Danny van Heumen <danny@dannyvanheumen.nl>
Reply-To: Danny van Heumen <danny@dannyvanheumen.nl>
Subject: Re: [PATCH] work-in-progress: double-free after hardware reset due to firmware-crash
Message-ID: <Uba0mwWYafMZd4JdEJVxMd-Uh8M6T4dHoTse71YdCikdJLYLxunwtrxxbasffgMuXtPVi_JmJrtAnqviM6x-99_SyysHZm-Yvz933mPXr74=@dannyvanheumen.nl>
In-Reply-To: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
References: <UXibAXk2GByhvw88A6LIDXHSlkP79-ML7FrtyfnHuiC34qUd-zx03BAJAtzluyEvfwPBR0tac4hC72zKI1qT3CtgmvvVohr1v8a49TqYVSw=@dannyvanheumen.nl>
Feedback-ID: 15073070:user:proton
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_hCQWlXGSLFMeV6nJ6semzEOn3vhZwitP932sYQTgqo"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.

--b1_hCQWlXGSLFMeV6nJ6semzEOn3vhZwitP932sYQTgqo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

I'd like to follow up with an updated patch. I had another look at the code=
. I think the
following proposal may correct the control flow to prevent the double-free =
from happening
in the first place.

Again, I would appreciate any feedback you might have, as I have little exp=
erience in this
area. A stacktrace is present in the commit message, in case you are lookin=
g for extra data
that demonstrates the issue.

Kind regards,
Danny


------- Original Message -------
On Tuesday, May 24th, 2022 at 18:51, Danny van Heumen <danny@dannyvanheumen=
.nl> wrote:


>
>
> Dear all,
>
> I am not a regular C developer nor kernel developer. I don't regularly re=
port issues, so I will probably do things wrong.
>
> I investigated a crash that IIUC occurs with hardened memory allocation e=
nabled and a firmware-crash followed by an early failure during hardware re=
initialization/probing. The hardened allocator detects double-free issue.
>
> I have created the patch (see attachment) against linux-5.18. Though, ple=
ase check carefully, because I have not been able to confirm that it actual=
ly works. I am hoping someone familiar with the code-base can either test t=
his easily, or confirm from review/analysis.
>
> The commit message describes it in more detail. In summary:
> 'brcmf_sdio_bus_reset' cleans up and reinitializes the hardware. It frees=
 memory used by (struct brcmf_sdio_dev)->freezer (struct brcmf_sdiod_freeze=
r). However, it then goes to probe the hardware, and an early failure to pr=
obe results in the same freeing, both called through function 'brcmf_sdiod_=
freezer_detach' called inside 'brcmf_sdiod_remove'. Which results in double=
 freeing.
>
>
> As mentioned before, I was not able to test this and I do not regularly d=
evelop in C. I am not confident that this is the proper way to fix it, but =
it seemed obvious enough. I hope you can support in fixing this bug.
>
> Kind regards,
> Danny
>
> PS: Please let me know if I am doing things wrong. I have included both m=
aintainers and mailing lists from https://docs.kernel.org/process/maintaine=
rs.html#broadcom-brcm80211-ieee802-11n-wireless-driver I hope I this is alr=
ight.
--b1_hCQWlXGSLFMeV6nJ6semzEOn3vhZwitP932sYQTgqo
Content-Type: text/x-patch; name=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-brcmfmac-prevent-double-free-on-hardware-reset.patch

RnJvbSA5NTZkOGU3NWY4Y2ZlOWQ4ZmQ5YzZiODA2NThhMzBmMWY3ZmEyOGVhIE1vbiBTZXAgMTcg
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
CgpTaWduZWQtb2ZmLWJ5OiBEYW5ueSB2YW4gSGV1bWVuIDxkYW5ueUBkYW5ueXZhbmhldW1lbi5u
bD4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMv
YmNtc2RoLmMgfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJj
bTgwMjExL2JyY21mbWFjL2JjbXNkaC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20v
YnJjbTgwMjExL2JyY21mbWFjL2JjbXNkaC5jCmluZGV4IGFjMDIyNDRhNmZkZi4uMjQwMzNlZjA4
ZTA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEv
YnJjbWZtYWMvYmNtc2RoLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYnJvYWRjb20vYnJj
bTgwMjExL2JyY21mbWFjL2JjbXNkaC5jCkBAIC05MTEsNyArOTExLDcgQEAgaW50IGJyY21mX3Nk
aW9kX3Byb2JlKHN0cnVjdCBicmNtZl9zZGlvX2RldiAqc2Rpb2RldikKIAlpZiAocmV0KSB7CiAJ
CWJyY21mX2VycigiRmFpbGVkIHRvIHNldCBGMSBibG9ja3NpemVcbiIpOwogCQlzZGlvX3JlbGVh
c2VfaG9zdChzZGlvZGV2LT5mdW5jMSk7Ci0JCWdvdG8gb3V0OworCQlyZXR1cm4gcmV0OwogCX0K
IAlzd2l0Y2ggKHNkaW9kZXYtPmZ1bmMyLT5kZXZpY2UpIHsKIAljYXNlIFNESU9fREVWSUNFX0lE
X0JST0FEQ09NX0NZUFJFU1NfNDM3MzoKQEAgLTkzMyw3ICs5MzMsNyBAQCBpbnQgYnJjbWZfc2Rp
b2RfcHJvYmUoc3RydWN0IGJyY21mX3NkaW9fZGV2ICpzZGlvZGV2KQogCWlmIChyZXQpIHsKIAkJ
YnJjbWZfZXJyKCJGYWlsZWQgdG8gc2V0IEYyIGJsb2Nrc2l6ZVxuIik7CiAJCXNkaW9fcmVsZWFz
ZV9ob3N0KHNkaW9kZXYtPmZ1bmMxKTsKLQkJZ290byBvdXQ7CisJCXJldHVybiByZXQ7CiAJfSBl
bHNlIHsKIAkJYnJjbWZfZGJnKFNESU8sICJzZXQgRjIgYmxvY2tzaXplIHRvICVkXG4iLCBmMl9i
bGtzeik7CiAJfQotLSAKMi4zNC4xCgo=

--b1_hCQWlXGSLFMeV6nJ6semzEOn3vhZwitP932sYQTgqo--

