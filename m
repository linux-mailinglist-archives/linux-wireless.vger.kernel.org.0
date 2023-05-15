Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C64170273D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjEOIcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 04:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238168AbjEOIbR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 04:31:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DC7E65;
        Mon, 15 May 2023 01:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684139458; x=1715675458;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lYFSk1dFMmKm8c07EwIleuUAwq4eykVhYnpc5t3qlNw=;
  b=ksPwFMBh4hMWcs8y5lLRPA5kY9zR6m7q1AdOLqR/9ZLWlzDQQnHTAVWV
   XBAOW0qSFezJZONq+ZSRKgsmKRE6T4VGJnaUnae2PI1TW+BtAOpVWlaRU
   L0V5L+z9kcsYSdqEA0+hU0vDLNktfpMYgQLziVdtBwwXqP2PTLQtFeBRo
   H2GHlzIPpzFV1TvYGu6EqLbujUi0hN0VHIt+wgW9Ya8noCywFql5wIPVY
   z812RiiebVXGeWiMgyMFuinkCj1vGifeJqtaDbRweX3zoTADrT0L0M8yE
   QjusCEInJFNIPmPrwvYmjw7+Ao8mkYcxGoExhfaky18PuzQf90XYz2RPU
   g==;
X-IronPort-AV: E=Sophos;i="5.99,276,1677567600"; 
   d="scan'208";a="225316052"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2023 01:30:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 15 May 2023 01:30:55 -0700
Received: from den-dk-m31857.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 15 May 2023 01:30:53 -0700
Message-ID: <c727aa9936c597d8297ab5659eba4e934f59349f.camel@microchip.com>
Subject: Re: [PATCH net-next] mac80211_hwsim: fix memory leak in
 hwsim_new_radio_nl
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Zhengchao Shao <shaozhengchao@huawei.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <johannes@sipsolutions.net>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <syzbot+904ce6fbb38532d9795c@syzkaller.appspotmail.com>
Date:   Mon, 15 May 2023 10:30:52 +0200
In-Reply-To: <20230515034712.2425489-1-shaozhengchao@huawei.com>
References: <20230515034712.2425489-1-shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgU2hhbywKCk9uIE1vbiwgMjAyMy0wNS0xNSBhdCAxMTo0NyArMDgwMCwgWmhlbmdjaGFvIFNo
YW8gd3JvdGU6Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBzaGFvemhlbmdjaGFv
QGh1YXdlaS5jb20uIExlYXJuIHdoeSB0aGlzIGlzCj4gaW1wb3J0YW50IGF0IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbsKgXQo+IAo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlCj4gY29udGVudCBpcyBzYWZlCj4gCj4gV2hlbiBwYXJzZV9wbXNyX2NhcGEgZmFpbGVkIGlu
IGh3c2ltX25ld19yYWRpb19ubCwgdGhlIG1lbW9yeSByZXNvdXJjZXMKPiBhcHBsaWVkIGZvciBi
eSBwbXNyX2NhcGEgYXJlIG5vdCByZWxlYXNlZC4gQWRkIHJlbGVhc2UgcHJvY2Vzc2luZyB0byB0
aGUKPiBpbmNvcnJlY3QgcGF0aC4KPiAKPiBGaXhlczogOTJkMTMzODZlYzU1ICgibWFjODAyMTFf
aHdzaW06IGFkZCBQTVNSIGNhcGFiaWxpdHkgc3VwcG9ydCIpCj4gUmVwb3J0ZWQtYnk6IHN5emJv
dCs5MDRjZTZmYmIzODUzMmQ5Nzk1Y0BzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCj4gU2lnbmVk
LW9mZi1ieTogWmhlbmdjaGFvIFNoYW8gPHNoYW96aGVuZ2NoYW9AaHVhd2VpLmNvbT4KPiAtLS0K
PiDCoGRyaXZlcnMvbmV0L3dpcmVsZXNzL3ZpcnR1YWwvbWFjODAyMTFfaHdzaW0uYyB8IDQgKysr
LQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy92aXJ0dWFsL21hYzgwMjExX2h3c2lt
LmMKPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3ZpcnR1YWwvbWFjODAyMTFfaHdzaW0uYwo+IGlu
ZGV4IDlhOGZhYWY0YzZiNi4uNmE1MDg1OGE1NjQ1IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3ZpcnR1YWwvbWFjODAyMTFfaHdzaW0uYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3ZpcnR1YWwvbWFjODAyMTFfaHdzaW0uYwo+IEBAIC01OTY1LDggKzU5NjUsMTAgQEAg
c3RhdGljIGludCBod3NpbV9uZXdfcmFkaW9fbmwoc3RydWN0IHNrX2J1ZmYgKm1zZywKPiBzdHJ1
Y3QgZ2VubF9pbmZvICppbmZvKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZ290byBvdXRfZnJlZTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBwYXJzZV9wbXNyX2Nh
cGEoaW5mby0+YXR0cnNbSFdTSU1fQVRUUl9QTVNSX1NVUFBPUlRdLAo+IHBtc3JfY2FwYSwgaW5m
byk7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtmcmVlKHBtc3JfY2FwYSk7CgpUaGlzIHNob3VsZCBub3Qg
YmUgbmVlZGVkLCBzZWUgYmVsb3cuCgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZ290byBvdXRfZnJlZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFtLnBtc3JfY2FwYSA9
IHBtc3JfY2FwYTsKCgpXaHkgZG9uJ3QgeW91IGp1c3QgbW92ZSB0aGlzIGxpbmUgdXAgYmVmb3Jl
IHRoZSBwYXJzZV9wbXNyX2NhcGEgYXMgdGhlcmUgaXMKYWxyZWFkeSBhIGtmcmVlKHBhcmFtLnBt
c3JfY2FwYSkgdW5kZXIgdGhlIG91dF9mcmVlIGxhYmVsPwoKPiDCoMKgwqDCoMKgwqDCoCB9Cj4g
Cj4gLS0KPiAyLjM0LjEKPiAKPiAKCkJSClN0ZWVuCg==

