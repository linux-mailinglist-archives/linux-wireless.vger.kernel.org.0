Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF976F65F1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjEDHkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 03:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEDHkb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 03:40:31 -0400
Received: from m1361.mail.163.com (m1361.mail.163.com [220.181.13.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E55AEE54;
        Thu,  4 May 2023 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=248WNmxyF/AdgK1vivOcxPmd7PonxYhhyDMKKQWcj7I=; b=J
        89G2z0ODOkjTnQYRAdPop5PFcQiRiYJagFavizeNajVko597eICe39rhEbnIo4ub
        FwYdu/tzYh8K3U60Vcdh5CyIPt1ULJnpNKSE7ustPJvddE8nM0CtDCbNsUDLaFjU
        FvvY8jAwnJr0s2SfGA7kf/5R54+yf8br7uaopjPIo8=
Received: from luyun_611$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr61 (Coremail) ; Thu, 4 May 2023 15:39:57 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Thu, 4 May 2023 15:39:57 +0800 (CST)
From:   "Yun Lu" <luyun_611@163.com>
To:     "Bitterblue Smith" <rtl8821cerfe2@gmail.com>
Cc:     "Larry Finger" <Larry.Finger@lwfinger.net>, Jes.Sorensen@gmail.com,
        kvalo@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: rtl8xxxu: fix authentication timeout due to
 incorrect RCR value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <794ab671-43a3-7548-13f0-4b289f07425f@gmail.com>
References: <20230427020512.1221062-1-luyun_611@163.com>
 <866570c9-38d8-1006-4721-77e2945170b9@lwfinger.net>
 <76a784b2.2cb3.187c60f0f68.Coremail.luyun_611@163.com>
 <d3743b66-23b1-011c-9dcd-c408b1963fca@lwfinger.net>
 <62d9fe90.63b.187cb1481f8.Coremail.luyun_611@163.com>
 <794ab671-43a3-7548-13f0-4b289f07425f@gmail.com>
X-NTES-SC: AL_QuyTAf2TukEi4SiebekXnE4XhO8+Wsqzv/Ui24VTOZ00vSrR4RImQFNlBVXQyv2UEQujnDS7YhRz7sBlbYxeXq5zLQpT7PJvMmMLoUWmXqVA
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <75c2fe43.3e15.187e5b4182f.Coremail.luyun_611@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: PcGowACH7lhNYVNk+EgNAA--.12682W
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiMg1lzlWB3nTB0gAAs5
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CuWcqCAyMDIzLTA0LTMwIDE4OjM2OjUw77yMIkJpdHRlcmJsdWUgU21pdGgiIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4g5YaZ6YGT77yaCj5PbiAyOS8wNC8yMDIzIDA2OjM1LCBZdW4gTHUgd3Jv
dGU6Cj4+IEF0IDIwMjMtMDQtMjkgMDE6MDY6MDMsICJMYXJyeSBGaW5nZXIiIDxMYXJyeS5GaW5n
ZXJAbHdmaW5nZXIubmV0PiB3cm90ZToKPj4+IE9uIDQvMjcvMjMgMjM6MTEsIHdvIHdyb3RlOgo+
Pj4+IFvCoCAxNDkuNTk1NjQyXSBbcGlkOjcsY3B1Nixrd29ya2VyL3UxNjowLDBdQkVGT1JFOiBS
RUdfUkNSIGRpZmZlcnMgZnJvbSByZWdyY3I6IAo+Pj4+IDB4MTgzMDYxMyBpbnN0ZWQgb2YgMHg3
MDAwNjA0ZQo+Pj4+IFvCoCAxNjAuNjc2NDIyXSBbcGlkOjIzNyxjcHU2LGt3b3JrZXIvdTE2OjUs
M11CRUZPUkU6IFJFR19SQ1IgZGlmZmVycyBmcm9tIAo+Pj4+IHJlZ3JjcjogMHg3MDAwNjAwOSBp
bnN0ZWQgb2YgMHg3MDAwNjBjZQo+Pj4+IFsgIDMyNy4yMzQ1ODhdIFtwaWQ6NyxjcHU3LGt3b3Jr
ZXIvdTE2OjAsNV1CRUZPUkU6IFJFR19SQ1IgZGlmZmVycyBmcm9tIAo+Pj4gcmVncmNyOiAweDE4
MzBkMzMgaW5zdGVkIG9mIDB4NzAwMDYwNGUKPj4+Cj4+Pgo+Pj4gTXkgcGF0Y2ggd2FzIG1lc3Nl
ZCB1cCwgYnV0IGl0IGdvdCB0aGUgaW5mb3JtYXRpb24gdGhhdCBJIHdhbnRlZCwgd2hpY2ggaXMg
c2hvd24gCj4+PiBpbiB0aGUgcXVvdGVkIGxpbmVzIGFib3ZlLiBPbmUgb2YgdGhlc2UgZGlmZmVy
cyBvbmx5IGluIHRoZSBsb3ctb3JkZXIgYnl0ZSwgCj4+PiB3aGlsZSB0aGUgb3RoZXIgMiBhcmUg
Y29tcGxldGVseSBkaWZmZXJlbnQuIFN0cmFuZ2UhCj4+Pgo+Pj4gSXQgaXMgcG9zc2libGUgdGhh
dCB0aGVyZSBpcyBhIGZpcm13YXJlIGVycm9yLiBNeSBzeXN0ZW0sIHdoaWNoIGRvZXMgbm90IHNo
b3cgCj4+PiB0aGUgcHJvYmxlbSwgcmVwb3J0cyB0aGUgZm9sbG93aW5nOgo+Pj4KPj4+IFs1NDEz
MC43NDExNDhdIHVzYiAzLTY6IFJUTDgxOTJDVSByZXYgQSAoVFNNQykgcm9tdmVyIDAsIDJUMlIs
IFRYIHF1ZXVlcyAyLCAKPj4+IFdpRmk9MSwgQlQ9MCwgR1BTPTAsIEhJIFBBPTAKPj4+IFs1NDEz
MC43NDExNTNdIHVzYiAzLTY6IFJUTDgxOTJDVSBNQUM6IHh4Onh4Onh4Onh4Onh4Onh4Cj4+PiBb
NTQxMzAuNzQxMTU1XSB1c2IgMy02OiBydGw4eHh4dTogTG9hZGluZyBmaXJtd2FyZSBydGx3aWZp
L3J0bDgxOTJjdWZ3X1RNU0MuYmluCj4+PiBbNTQxMzAuNzQyMzAxXSB1c2IgMy02OiBGaXJtd2Fy
ZSByZXZpc2lvbiA4OC4yIChzaWduYXR1cmUgMHg4OGMxKQo+Pj4KPj4+IFdoaWNoIGZpcm13YXJl
IGRvZXMgeW91ciB1bml0IHVzZT8KPj4gCj4+IFRoZSBmaXJtd2FyZSB2ZXJpb24gd2UgdXNlZCBp
cyA4MC4wIChzaWduYXR1cmUgMHg4OGMxKQo+PiAgWyAgOTAzLjg3MzEwN10gW3BpZDoxNCxjcHUw
LGt3b3JrZXIvMDoxLDJddXNiIDEtMS4yOiBSVEw4MTkyQ1UgcmV2IEEgKFRTTUMpIDJUMlIsIFRY
IHF1ZXVlcyAyLCBXaUZpPTEsIEJUPTAsIEdQUz0wLCBISSBQQT0wCj4+IFsgIDkwMy44NzMxMzhd
IFtwaWQ6MTQsY3B1MCxrd29ya2VyLzA6MSwzXXVzYiAxLTEuMjogUlRMODE5MkNVIE1BQzogMDg6
YmU6eHg6eHg6eHg6eHgKPj4gWyAgOTAzLjg3MzEzOF0gW3BpZDoxNCxjcHUwLGt3b3JrZXIvMDox
LDRddXNiIDEtMS4yOiBydGw4eHh4dTogTG9hZGluZyBmaXJtd2FyZSBydGx3aWZpL3J0bDgxOTJj
dWZ3X1RNU0MuYmluCj4+IFsgIDkwMy44NzM0NzRdIFtwaWQ6MTQsY3B1MCxrd29ya2VyLzA6MSw1
XXVzYiAxLTEuMjogRmlybXdhcmUgcmV2aXNpb24gODAuMCAoc2lnbmF0dXJlIDB4ODhjMSkKPj4g
Cj4+Pgo+Pj4gQXR0YWNoZWQgaXMgYSBuZXcgdGVzdCBwYXRjaC4gV2hlbiBpdCBsb2dzIGEgQ09S
UlVQVEVEIHZhbHVlLCBJIHdvdWxkIGxpa2UgdG8gCj4+PiBrbm93IHdoYXQgdGFzayBpcyBhdHRh
Y2hlZCB0byB0aGUgcGlkIGxpc3RlZCBpbiB0aGUgbWVzc2FnZS4gTm90ZSB0aGF0IHRoZSB0d28g
Cj4+PiBpbnN0YW5jZXMgd2hlcmUgdGhlIGVudGlyZSB3b3JkIHdhcyB3cm9uZyBjYW1lIGZyb20g
cGlkOjcuCj4+Pgo+Pj4gQ291bGQgaW1wcm9wZXIgbG9ja2luZyBjb3VsZCBwcm9kdWNlIHRoZXNl
IHJlc3VsdHM/Cj4+Pgo+Pj4gTGFycnkKPj4gCj4+IEFwcGx5IHlvdXIgbmV3IHBhdGNoLCB0aGVu
IHR1cm4gb24vb2ZmIHRoZSB3aXJlbGVzcyBuZXR3b3JrIHN3aXRjaCBvbiB0aGUgbmV0d29yayBj
b250cm9sIHBhbmVsIHNlcnZlcmwgbG9vcHMuCj4+IFRoZSBsb2cgc2hvd3M6Cj4+IFsgICA4NS4z
ODQ0MjldIFtwaWQ6MjIxLGNwdTYsa3dvcmtlci91MTY6Niw1XVJFR19SQ1IgY29ycnVwdGVkIGlu
IHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4NzAwMDYwMDkgaW5zdGVkIG9mIDB4NzAwMDYw
Y2UKPj4gWyAgMTIxLjY4MTk3Nl0gW3BpZDoyMTYsY3B1Nixrd29ya2VyL3UxNjozLDBdUkVHX1JD
UiBjb3JydXB0ZWQgaW4gcnRsOHh4eHVfY29uZmlndXJlX2ZpbHRlcjogMHg3MDAwNjAwOSBpbnN0
ZWQgb2YgMHg3MDAwNjBjZQo+PiBbICAxNDQuNDE2OTkyXSBbcGlkOjIxNyxjcHU2LGt3b3JrZXIv
dTE2OjQsMV1SRUdfUkNSIGNvcnJ1cHRlZCBpbiBydGw4eHh4dV9jb25maWd1cmVfZmlsdGVyOiAw
eDcwMDA2MDA5IGluc3RlZCBvZiAweDcwMDA2MGNlCj4+IAo+PiBBbmQgaWYgd2UgdXAvZG93biB0
aGUgaW50ZXJmYWNlIHNlcnZlcmwgbG9vcHMgYXMgZm9sbG93czoKPj4gaWZjb25maWcgd2x4MDhi
ZXh4eHh4eCBkb3duCj4+IHNsZWVwIDEKPj4gaWZjb25maWcgd2x4MDhiZXh4eHh4eCB1cAo+PiBz
bGVlcCAxMAo+PiBUaGUgbG9nIHNob3dzOgo+PiBbICAyODIuMTEyMzM1XSBbMjAyMzowNDoyOSAx
MDozMDozNF1bcGlkOjk1LGNwdTYsa3dvcmtlci91MTY6MSwzXVJFR19SQ1IgY29ycnVwdGVkIGlu
IHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4MTgzMmUxMyBpbnN0ZWQgb2YgMHg3MDAwNjA0
ZQo+PiBbICAyOTMuMzExNDYyXSBbMjAyMzowNDoyOSAxMDozMDo0NV1bcGlkOjIxNyxjcHU3LGt3
b3JrZXIvdTE2OjQsOV1SRUdfUkNSIGNvcnJ1cHRlZCBpbiBydGw4eHh4dV9jb25maWd1cmVfZmls
dGVyOiAweDE4MzBlNzIgaW5zdGVkIG9mIDB4NzAwMDYwNGUKPj4gWyAgMzA0LjQzNTA4OV0gWzIw
MjM6MDQ6MjkgMTA6MzA6NTZdW3BpZDoyMTcsY3B1Nixrd29ya2VyL3UxNjo0LDldUkVHX1JDUiBj
b3JydXB0ZWQgaW4gcnRsOHh4eHVfY29uZmlndXJlX2ZpbHRlcjogMHgxODMwZWQzIGluc3RlZCBv
ZiAweDcwMDA2MDRlCj4+IFsgIDMxNS41MzIyNTddIFsyMDIzOjA0OjI5IDEwOjMxOjA3XVtwaWQ6
OTUsY3B1Nyxrd29ya2VyL3UxNjoxLDhdUkVHX1JDUiBjb3JydXB0ZWQgaW4gcnRsOHh4eHVfY29u
ZmlndXJlX2ZpbHRlcjogMHg3MDAwNjA0ZSBpbnN0ZWQgb2YgMHg3MDAwNjA0ZQo+PiBbICAzMjQu
MTE0Mzc5XSBbMjAyMzowNDoyOSAxMDozMToxNl1bcGlkOjIyMSxjcHU2LGt3b3JrZXIvdTE2OjYs
N11SRUdfUkNSIGNvcnJ1cHRlZCBpbiBydGw4eHh4dV9jb25maWd1cmVfZmlsdGVyOiAweDE4MzJl
MTQgaW5zdGVkIG9mIDB4NzAwMDYwNGUKPj4gCj4+IFdlIGFsc28gdXBkYXRlIHRoZSAgZmlybXdh
cmUgdmVyaW9uIHRvIDg4LjIsIGFuZCB0aGUgdGVzdCByZXN1bHRzIGFyZSB0aGUgc2FtZSBhcyBh
Ym92ZS4KPj4gCj4+IFRoYW5rIHlvdSBmb3IgaGVscGluZyBkZWJ1ZyB0aGlzIGlzc3VlLCB3aGlj
aCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHNwZWNpZmljIGRldmljZXMuCj4+IAo+PiBZdW4gTHUK
Pj4gCj4+IAo+PiAKPj4gCj5UaGVyZSB3YXMgdGhpcyBidWcgcmVwb3J0IGFib3V0IHBoYW50b20g
TUFDIGFkZHJlc3NlcyB3aXRoCj50aGUgUlRMODE4OENVUzoKPmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpbnV4LXdpcmVsZXNzL2EzMWQ5NTAwLTczYTMtZjg5MC1iZWJkLWQwYTQwMTRmODdkYUBy
ZXRvLXNjaG5laWRlci5jaC8KPgo+U2VlIHRoZSBwY2FwIGZpbGUuIEkgd29uZGVyIGlmIGl0J3Mg
cmVsYXRlZD8KClRoZSBidWcgaW4gdGhlIGxpbmsgaXMgYSBoaWdoIHJldHJhbnNtaXNzaW9uIHJh
dGUgZHVyaW5nIG1lc3NhZ2UgdHJhbnNtaXNzaW9uLCBidXQgdGhlIHByb2JsZW0gd2UgZW5jb3Vu
dGVyZWQgaXMgdGhhdAp0aGUgbmljIGNhbm5vdCByZWNlaXZlIGF1dGhlbnRpY2F0aW9uIGZyYW1l
cywgcmVzdWx0aW5nIGluIGF1dGhlbnRpY2F0aW9uIHRpbWVvdXQgYW5kIGluYWJpbGl0eSB0byBj
b25uZWN0IHRvIFdpRmkuIEl0IHNlZW1zCnRoYXQgdGhlc2UgdHdvIGlzc3VlcyBhcmUgbm90IHJl
bGF0ZWQuCgpXZSBhbHNvIGVuYWJsZWQgbW9uaXRvciBtb2RlIGFuZCBmb3VuZCB0aGF0IHRoZSBB
UCBoYXMgcmVwbGllZCB0byB0aGUgYXV0aGVudGljYXRpb24gbWVzc2FnZSwgYnV0IHRoZSBuaWMg
Y2Fubm90IHJlY2VpdmUKdGhpcyByZXBseSBtZXNzYWdlIGR1ZSB0byB0aGUgaW5jb3JyZWN0IFJD
UiByZWdpc3RlciB2YWx1ZS4gT25jZSB0aGUgUkNSIHJlZ2lzdGVyIGlzIG1vZGlmaWVkIHRvIHRo
ZSBjb3JyZWN0IHZhbHVlLAp0aGUgYXV0aGVudGljYXRpb24gbWVzc2FnZSBjYW4gYmUgcmVjZWl2
ZWQgbm9ybWFsbHkgYW5kIHRoZSBjb25uZWN0aW9uIHRvIFdJRkkgY2FuIGJlIG5vcm1hbC4KClRo
YW5rcy4KCgoK
