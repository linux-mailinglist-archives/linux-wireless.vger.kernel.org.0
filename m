Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389C66FE9D8
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 04:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjEKCaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 May 2023 22:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEKCaL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 May 2023 22:30:11 -0400
Received: from m13123.mail.163.com (m13123.mail.163.com [220.181.13.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46BF24208;
        Wed, 10 May 2023 19:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=XeQX4qNKpmGN85OgTYDbym/0iMRh4hvIFXvfevrPSlA=; b=m
        d1QZiJH5v5dNFXiReUVykWaXr5jD7LS6E2EgN6H/LXjH8d76g767d+64k22YnQa0
        Grflj8Q5KxH9w94OlX93eWmdOKd21Wcg2BQvt/CaIyLQITgiXPviQ03nAcMDIwUd
        eAksKrMfa28Hnpur7lOPuXPy2RuEAuv3KkdNndx5Do=
Received: from luyun_611$163.com ( [116.128.244.169] ) by
 ajax-webmail-wmsvr123 (Coremail) ; Thu, 11 May 2023 10:29:32 +0800 (CST)
X-Originating-IP: [116.128.244.169]
Date:   Thu, 11 May 2023 10:29:32 +0800 (CST)
From:   "Yun Lu" <luyun_611@163.com>
To:     "Bitterblue Smith" <rtl8821cerfe2@gmail.com>,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Cc:     Jes.Sorensen@gmail.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] wifi: rtl8xxxu: fix authentication timeout due to
 incorrect RCR value
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <75c2fe43.3e15.187e5b4182f.Coremail.luyun_611@163.com>
References: <20230427020512.1221062-1-luyun_611@163.com>
 <866570c9-38d8-1006-4721-77e2945170b9@lwfinger.net>
 <76a784b2.2cb3.187c60f0f68.Coremail.luyun_611@163.com>
 <d3743b66-23b1-011c-9dcd-c408b1963fca@lwfinger.net>
 <62d9fe90.63b.187cb1481f8.Coremail.luyun_611@163.com>
 <794ab671-43a3-7548-13f0-4b289f07425f@gmail.com>
 <75c2fe43.3e15.187e5b4182f.Coremail.luyun_611@163.com>
X-NTES-SC: AL_QuyTAfucvUks5CmfbekXnE4XhO8+Wsqzv/Ui24VTOZ00nivB/yMFU3J4P3Hm0vODGgSPvRWQaTpy6NlQR4hKRaOrNDPIgtNop3V6Wy86Ht8R
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <4856a7f8.1909.18808a46ab6.Coremail.luyun_611@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: e8GowAAXRz4NU1xk2uATAA--.11119W
X-CM-SenderInfo: pox130jbwriqqrwthudrp/1tbiMh9szlWB3tIfMAABs5
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

TGFycnkgIGFuZCAgQml0dGVyYmx1ZToKClRoYW5rIHlvdSBmb3IgeW91ciByZXBseSwgIGFyZSB0
aGVyZSBhbnkgZnVydGhlciBxdWVzdGlvbnMgb3Igc3VnZ2VzdGlvbnMgb24gdGhpcyBpc3N1ZT8K
Q291bGQgdGhpcyBwYXRjaCBiZSBtZXJnZWQ/IFRoZXJlIHNlZW1zIHRvIGJlIG5vIG90aGVyIHNp
ZGUgZWZmZWN0cy4KCgoK5ZyoIDIwMjMtMDUtMDQgMTU6Mzk6NTfvvIwiWXVuIEx1IiA8bHV5dW5f
NjExQDE2My5jb20+IOWGmemBk++8mgo+Cj7lnKggMjAyMy0wNC0zMCAxODozNjo1MO+8jCJCaXR0
ZXJibHVlIFNtaXRoIiA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IOWGmemBk++8mgo+Pk9uIDI5
LzA0LzIwMjMgMDY6MzUsIFl1biBMdSB3cm90ZToKPj4+IEF0IDIwMjMtMDQtMjkgMDE6MDY6MDMs
ICJMYXJyeSBGaW5nZXIiIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0PiB3cm90ZToKPj4+PiBP
biA0LzI3LzIzIDIzOjExLCB3byB3cm90ZToKPj4+Pj4gW8KgIDE0OS41OTU2NDJdIFtwaWQ6Nyxj
cHU2LGt3b3JrZXIvdTE2OjAsMF1CRUZPUkU6IFJFR19SQ1IgZGlmZmVycyBmcm9tIHJlZ3Jjcjog
Cj4+Pj4+IDB4MTgzMDYxMyBpbnN0ZWQgb2YgMHg3MDAwNjA0ZQo+Pj4+PiBbwqAgMTYwLjY3NjQy
Ml0gW3BpZDoyMzcsY3B1Nixrd29ya2VyL3UxNjo1LDNdQkVGT1JFOiBSRUdfUkNSIGRpZmZlcnMg
ZnJvbSAKPj4+Pj4gcmVncmNyOiAweDcwMDA2MDA5IGluc3RlZCBvZiAweDcwMDA2MGNlCj4+Pj4+
IFsgIDMyNy4yMzQ1ODhdIFtwaWQ6NyxjcHU3LGt3b3JrZXIvdTE2OjAsNV1CRUZPUkU6IFJFR19S
Q1IgZGlmZmVycyBmcm9tIAo+Pj4+IHJlZ3JjcjogMHgxODMwZDMzIGluc3RlZCBvZiAweDcwMDA2
MDRlCj4+Pj4KPj4+Pgo+Pj4+IE15IHBhdGNoIHdhcyBtZXNzZWQgdXAsIGJ1dCBpdCBnb3QgdGhl
IGluZm9ybWF0aW9uIHRoYXQgSSB3YW50ZWQsIHdoaWNoIGlzIHNob3duIAo+Pj4+IGluIHRoZSBx
dW90ZWQgbGluZXMgYWJvdmUuIE9uZSBvZiB0aGVzZSBkaWZmZXJzIG9ubHkgaW4gdGhlIGxvdy1v
cmRlciBieXRlLCAKPj4+PiB3aGlsZSB0aGUgb3RoZXIgMiBhcmUgY29tcGxldGVseSBkaWZmZXJl
bnQuIFN0cmFuZ2UhCj4+Pj4KPj4+PiBJdCBpcyBwb3NzaWJsZSB0aGF0IHRoZXJlIGlzIGEgZmly
bXdhcmUgZXJyb3IuIE15IHN5c3RlbSwgd2hpY2ggZG9lcyBub3Qgc2hvdyAKPj4+PiB0aGUgcHJv
YmxlbSwgcmVwb3J0cyB0aGUgZm9sbG93aW5nOgo+Pj4+Cj4+Pj4gWzU0MTMwLjc0MTE0OF0gdXNi
IDMtNjogUlRMODE5MkNVIHJldiBBIChUU01DKSByb212ZXIgMCwgMlQyUiwgVFggcXVldWVzIDIs
IAo+Pj4+IFdpRmk9MSwgQlQ9MCwgR1BTPTAsIEhJIFBBPTAKPj4+PiBbNTQxMzAuNzQxMTUzXSB1
c2IgMy02OiBSVEw4MTkyQ1UgTUFDOiB4eDp4eDp4eDp4eDp4eDp4eAo+Pj4+IFs1NDEzMC43NDEx
NTVdIHVzYiAzLTY6IHJ0bDh4eHh1OiBMb2FkaW5nIGZpcm13YXJlIHJ0bHdpZmkvcnRsODE5MmN1
ZndfVE1TQy5iaW4KPj4+PiBbNTQxMzAuNzQyMzAxXSB1c2IgMy02OiBGaXJtd2FyZSByZXZpc2lv
biA4OC4yIChzaWduYXR1cmUgMHg4OGMxKQo+Pj4+Cj4+Pj4gV2hpY2ggZmlybXdhcmUgZG9lcyB5
b3VyIHVuaXQgdXNlPwo+Pj4gCj4+PiBUaGUgZmlybXdhcmUgdmVyaW9uIHdlIHVzZWQgaXMgODAu
MCAoc2lnbmF0dXJlIDB4ODhjMSkKPj4+ICBbICA5MDMuODczMTA3XSBbcGlkOjE0LGNwdTAsa3dv
cmtlci8wOjEsMl11c2IgMS0xLjI6IFJUTDgxOTJDVSByZXYgQSAoVFNNQykgMlQyUiwgVFggcXVl
dWVzIDIsIFdpRmk9MSwgQlQ9MCwgR1BTPTAsIEhJIFBBPTAKPj4+IFsgIDkwMy44NzMxMzhdIFtw
aWQ6MTQsY3B1MCxrd29ya2VyLzA6MSwzXXVzYiAxLTEuMjogUlRMODE5MkNVIE1BQzogMDg6YmU6
eHg6eHg6eHg6eHgKPj4+IFsgIDkwMy44NzMxMzhdIFtwaWQ6MTQsY3B1MCxrd29ya2VyLzA6MSw0
XXVzYiAxLTEuMjogcnRsOHh4eHU6IExvYWRpbmcgZmlybXdhcmUgcnRsd2lmaS9ydGw4MTkyY3Vm
d19UTVNDLmJpbgo+Pj4gWyAgOTAzLjg3MzQ3NF0gW3BpZDoxNCxjcHUwLGt3b3JrZXIvMDoxLDVd
dXNiIDEtMS4yOiBGaXJtd2FyZSByZXZpc2lvbiA4MC4wIChzaWduYXR1cmUgMHg4OGMxKQo+Pj4g
Cj4+Pj4KPj4+PiBBdHRhY2hlZCBpcyBhIG5ldyB0ZXN0IHBhdGNoLiBXaGVuIGl0IGxvZ3MgYSBD
T1JSVVBURUQgdmFsdWUsIEkgd291bGQgbGlrZSB0byAKPj4+PiBrbm93IHdoYXQgdGFzayBpcyBh
dHRhY2hlZCB0byB0aGUgcGlkIGxpc3RlZCBpbiB0aGUgbWVzc2FnZS4gTm90ZSB0aGF0IHRoZSB0
d28gCj4+Pj4gaW5zdGFuY2VzIHdoZXJlIHRoZSBlbnRpcmUgd29yZCB3YXMgd3JvbmcgY2FtZSBm
cm9tIHBpZDo3Lgo+Pj4+Cj4+Pj4gQ291bGQgaW1wcm9wZXIgbG9ja2luZyBjb3VsZCBwcm9kdWNl
IHRoZXNlIHJlc3VsdHM/Cj4+Pj4KPj4+PiBMYXJyeQo+Pj4gCj4+PiBBcHBseSB5b3VyIG5ldyBw
YXRjaCwgdGhlbiB0dXJuIG9uL29mZiB0aGUgd2lyZWxlc3MgbmV0d29yayBzd2l0Y2ggb24gdGhl
IG5ldHdvcmsgY29udHJvbCBwYW5lbCBzZXJ2ZXJsIGxvb3BzLgo+Pj4gVGhlIGxvZyBzaG93czoK
Pj4+IFsgICA4NS4zODQ0MjldIFtwaWQ6MjIxLGNwdTYsa3dvcmtlci91MTY6Niw1XVJFR19SQ1Ig
Y29ycnVwdGVkIGluIHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4NzAwMDYwMDkgaW5zdGVk
IG9mIDB4NzAwMDYwY2UKPj4+IFsgIDEyMS42ODE5NzZdIFtwaWQ6MjE2LGNwdTYsa3dvcmtlci91
MTY6MywwXVJFR19SQ1IgY29ycnVwdGVkIGluIHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4
NzAwMDYwMDkgaW5zdGVkIG9mIDB4NzAwMDYwY2UKPj4+IFsgIDE0NC40MTY5OTJdIFtwaWQ6MjE3
LGNwdTYsa3dvcmtlci91MTY6NCwxXVJFR19SQ1IgY29ycnVwdGVkIGluIHJ0bDh4eHh1X2NvbmZp
Z3VyZV9maWx0ZXI6IDB4NzAwMDYwMDkgaW5zdGVkIG9mIDB4NzAwMDYwY2UKPj4+IAo+Pj4gQW5k
IGlmIHdlIHVwL2Rvd24gdGhlIGludGVyZmFjZSBzZXJ2ZXJsIGxvb3BzIGFzIGZvbGxvd3M6Cj4+
PiBpZmNvbmZpZyB3bHgwOGJleHh4eHh4IGRvd24KPj4+IHNsZWVwIDEKPj4+IGlmY29uZmlnIHds
eDA4YmV4eHh4eHggdXAKPj4+IHNsZWVwIDEwCj4+PiBUaGUgbG9nIHNob3dzOgo+Pj4gWyAgMjgy
LjExMjMzNV0gWzIwMjM6MDQ6MjkgMTA6MzA6MzRdW3BpZDo5NSxjcHU2LGt3b3JrZXIvdTE2OjEs
M11SRUdfUkNSIGNvcnJ1cHRlZCBpbiBydGw4eHh4dV9jb25maWd1cmVfZmlsdGVyOiAweDE4MzJl
MTMgaW5zdGVkIG9mIDB4NzAwMDYwNGUKPj4+IFsgIDI5My4zMTE0NjJdIFsyMDIzOjA0OjI5IDEw
OjMwOjQ1XVtwaWQ6MjE3LGNwdTcsa3dvcmtlci91MTY6NCw5XVJFR19SQ1IgY29ycnVwdGVkIGlu
IHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4MTgzMGU3MiBpbnN0ZWQgb2YgMHg3MDAwNjA0
ZQo+Pj4gWyAgMzA0LjQzNTA4OV0gWzIwMjM6MDQ6MjkgMTA6MzA6NTZdW3BpZDoyMTcsY3B1Nixr
d29ya2VyL3UxNjo0LDldUkVHX1JDUiBjb3JydXB0ZWQgaW4gcnRsOHh4eHVfY29uZmlndXJlX2Zp
bHRlcjogMHgxODMwZWQzIGluc3RlZCBvZiAweDcwMDA2MDRlCj4+PiBbICAzMTUuNTMyMjU3XSBb
MjAyMzowNDoyOSAxMDozMTowN11bcGlkOjk1LGNwdTcsa3dvcmtlci91MTY6MSw4XVJFR19SQ1Ig
Y29ycnVwdGVkIGluIHJ0bDh4eHh1X2NvbmZpZ3VyZV9maWx0ZXI6IDB4NzAwMDYwNGUgaW5zdGVk
IG9mIDB4NzAwMDYwNGUKPj4+IFsgIDMyNC4xMTQzNzldIFsyMDIzOjA0OjI5IDEwOjMxOjE2XVtw
aWQ6MjIxLGNwdTYsa3dvcmtlci91MTY6Niw3XVJFR19SQ1IgY29ycnVwdGVkIGluIHJ0bDh4eHh1
X2NvbmZpZ3VyZV9maWx0ZXI6IDB4MTgzMmUxNCBpbnN0ZWQgb2YgMHg3MDAwNjA0ZQo+Pj4gCj4+
PiBXZSBhbHNvIHVwZGF0ZSB0aGUgIGZpcm13YXJlIHZlcmlvbiB0byA4OC4yLCBhbmQgdGhlIHRl
c3QgcmVzdWx0cyBhcmUgdGhlIHNhbWUgYXMgYWJvdmUuCj4+PiAKPj4+IFRoYW5rIHlvdSBmb3Ig
aGVscGluZyBkZWJ1ZyB0aGlzIGlzc3VlLCB3aGljaCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHNw
ZWNpZmljIGRldmljZXMuCj4+PiAKPj4+IFl1biBMdQo+Pj4gCj4+PiAKPj4+IAo+Pj4gCj4+VGhl
cmUgd2FzIHRoaXMgYnVnIHJlcG9ydCBhYm91dCBwaGFudG9tIE1BQyBhZGRyZXNzZXMgd2l0aAo+
PnRoZSBSVEw4MTg4Q1VTOgo+Pmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNz
L2EzMWQ5NTAwLTczYTMtZjg5MC1iZWJkLWQwYTQwMTRmODdkYUByZXRvLXNjaG5laWRlci5jaC8K
Pj4KPj5TZWUgdGhlIHBjYXAgZmlsZS4gSSB3b25kZXIgaWYgaXQncyByZWxhdGVkPwo+Cj5UaGUg
YnVnIGluIHRoZSBsaW5rIGlzIGEgaGlnaCByZXRyYW5zbWlzc2lvbiByYXRlIGR1cmluZyBtZXNz
YWdlIHRyYW5zbWlzc2lvbiwgYnV0IHRoZSBwcm9ibGVtIHdlIGVuY291bnRlcmVkIGlzIHRoYXQK
PnRoZSBuaWMgY2Fubm90IHJlY2VpdmUgYXV0aGVudGljYXRpb24gZnJhbWVzLCByZXN1bHRpbmcg
aW4gYXV0aGVudGljYXRpb24gdGltZW91dCBhbmQgaW5hYmlsaXR5IHRvIGNvbm5lY3QgdG8gV2lG
aS4gSXQgc2VlbXMKPnRoYXQgdGhlc2UgdHdvIGlzc3VlcyBhcmUgbm90IHJlbGF0ZWQuCj4KPldl
IGFsc28gZW5hYmxlZCBtb25pdG9yIG1vZGUgYW5kIGZvdW5kIHRoYXQgdGhlIEFQIGhhcyByZXBs
aWVkIHRvIHRoZSBhdXRoZW50aWNhdGlvbiBtZXNzYWdlLCBidXQgdGhlIG5pYyBjYW5ub3QgcmVj
ZWl2ZQo+dGhpcyByZXBseSBtZXNzYWdlIGR1ZSB0byB0aGUgaW5jb3JyZWN0IFJDUiByZWdpc3Rl
ciB2YWx1ZS4gT25jZSB0aGUgUkNSIHJlZ2lzdGVyIGlzIG1vZGlmaWVkIHRvIHRoZSBjb3JyZWN0
IHZhbHVlLAo+dGhlIGF1dGhlbnRpY2F0aW9uIG1lc3NhZ2UgY2FuIGJlIHJlY2VpdmVkIG5vcm1h
bGx5IGFuZCB0aGUgY29ubmVjdGlvbiB0byBXSUZJIGNhbiBiZSBub3JtYWwuCj4KPlRoYW5rcy4K
Pgo+Cj4K
