Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABA8191F7A
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 03:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCYCzl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 22:55:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51212 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbgCYCzl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 22:55:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02P2tJ10010864, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02P2tJ10010864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Mar 2020 10:55:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 10:55:19 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 25 Mar 2020 10:55:18 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Wed, 25 Mar 2020 10:55:18 +0800
From:   Tony Chuang <yhchuang@realtek.com>
To:     Brian Norris <briannorris@chromium.org>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     Ben Greear <greearb@candelatech.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Topic: [PATCH] rtw88: add debugfs to fix tx rate
Thread-Index: AQHV+QPS9h9ZLy9E5U2M/GVMmM07xahGU7JUgAQrRBCAAeVFp4AANj0wgABYekb//3w6gIABoSZAgALoHICABwEiAIAAsS3g
Date:   Wed, 25 Mar 2020 02:55:18 +0000
Message-ID: <3894907ca6bf4566b8716731492a869b@realtek.com>
References: <20200313065114.23433-1-yhchuang@realtek.com>
 <87eetwo87q.fsf@kamboji.qca.qualcomm.com>
 <2e492e530d744713871f885e324106ef@realtek.com>
 <87eetrlanb.fsf@kamboji.qca.qualcomm.com>
 <ce990869ebf0478d98cd7e8416b36289@realtek.com>
 <875zf3kn05.fsf@kamboji.qca.qualcomm.com>
 <f4e7401c-c86b-8b2f-9e93-865322f71945@candelatech.com>
 <fbab3328d183406c923b30381389841f@realtek.com>
 <d45e2002e97c28acc1f9c7b9c41b5a3ba1d69452.camel@sipsolutions.net>
 <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
In-Reply-To: <CA+ASDXM5tSmeE72+fn5K2vgR6kPE3OUbHJ_T_DVV63rFrPzv2w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.68.175]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QnJpYW4gTm9ycmlzIDxicmlhbm5vcnJpc0BjaHJvbWl1bS5vcmc+IHdyaXRlczoNCg0KPiBbIFRv
IGJlIGNsZWFyLCBJIGhhdmVuJ3QgYXNrZWQgZm9yIHRoaXMgZGVidWdmcyBrbm9iLCBhbmQgYXMg
b2Ygbm93LA0KPiB0aGVyZSBpcyBubyBwbGFuIGZvciBDaHJvbWUgT1MgdG8gdXNlICRzdWJqZWN0
IGZlYXR1cmUuIFBlciBzb21lIG9mDQo+IFRvbnkncyBkZXNjcmlwdGlvbnMsIEkgc3VwcG9zZSBt
YXliZSB0aGlzIHdvdWxkIGJlIHVzZWZ1bCBmb3IgY2VydGFpbg0KPiBkZWJ1Z2dpbmcgc2NlbmFy
aW9zLCBidXQgb25seSB0aGF0IC0tIG5vIGludGVudGlvbiBvZiB3aXJpbmcgdGhpcyB1cA0KPiAi
aW4gcHJvZHVjdGlvbi4iIElJVUMsIGhlIENDJ2QgbWUgb25seSBiZWNhdXNlIG9mIHRoZSAibWVh
c3VyaW5nIHRoZQ0KPiBUWCBwb3dlciIgcG9ydGlvbiBvZiB0aGUgY29tbWl0IG1lc3NhZ2UuIF0N
Cj4gDQo+IE9uIEZyaSwgTWFyIDIwLCAyMDIwIGF0IDY6MDYgQU0gSm9oYW5uZXMgQmVyZyA8am9o
YW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gd3JvdGU6DQo+ID4gQnJpYW4gY2FuIHByb2JhYmx5
IGNvbW1lbnQgb24gdGhpcyAtIEkgdGhpbmsgQ2hyb21lT1MgKHVzZWQgdG8pIHVzZShzKQ0KPiA+
IHNvbWUga2luZCBvZiBmaXhlZCByYXRlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGNvbm5lY3Rp
b24gdG8gZm9yY2UgbG93DQo+ID4gcmF0ZXM/IEJ1dCBJIGFsc28gcmVtZW1iZXIgdGhpcyBpbnRl
cmFjdGluZyBiYWRseSB3aXRoIHNvbWUgQVBzIHRoYXQNCj4gPiBqdXN0IGRvbid0IHdhbnQgdG8g
ZW5hYmxlIGxvdyByYXRlcyBhdCBhbGwuLi4NCj4gDQoNClsuLi5dDQoNCj4gDQo+IEFzIEpvaGFu
bmVzIG5vdGVkLCBtYXNraW5nIG9mZiB0aGVzZSByYXRlcyBjYXVzZWQgcHJvYmxlbXMgb2YgaXRz
IG93biwNCj4gZXNwZWNpYWxseSB3aGVuIEFQcyAoZXNwLiwgZ3VpZGVkIGJ5IChtaXM/KWd1aWRl
ZCBJLlQuIGFkbWlucyB3aG8NCj4gdGhpbmsgdGhhdCBsb3cgYml0cmF0ZXMgYXJlIGV2aWwpIHJl
bW92ZWQgdGhlc2UgbG93IGJpdHJhdGVzIGZyb20NCj4gdGhlaXIgU3VwcG9ydGVkUmF0ZXMgZmll
bGQuIEFwcGFyZW50bHkgdGhlc2UgQVBzIG1heSBzdGFydCB0byByZWplY3QNCj4gY2xpZW50cyBp
ZiB0aGV5IGRvbid0IG9iZXkuDQo+IA0KPiBBZGRpdGlvbmFsbHksIHdlIGZvdW5kIG5vIGV2aWRl
bmNlIHRoYXQgZm9yY2luZyBsb3cgYml0cmF0ZXMgbGlrZSB0aGlzDQo+IHdhcyBzdWJzdGFudGlh
bGx5IGhlbHBmdWwgZm9yIGFueXRoaW5nIG90aGVyIHRoYW4gb2xkZXIgYXRoOWsgc3lzdGVtcy4N
Cj4gU28gbG9uZ2VyIHN0b3J5IHNob3J0ZXIsIENocm9tZSBPUyBkb2VzIG5vdCB1c2UNCj4gTkw4
MDIxMV9DTURfU0VUX1RYX0JJVFJBVEVfTUFTSyBhbnkgbW9yZS4NCj4gDQoNCldlIHdhbnQgdG8g
bWVhc3VyZSB0aGUgVFggcG93ZXIsIGFuZCB0aGUgZXF1aXBtZW50IGp1c3QgY2Fubm90DQpkZXRl
Y3QgdGhlIHNpZ25hbCBvbiBzb21lIHJhdGVzLCB1bmxlc3Mgd2UgImZpeCIgdGhlIHJhdGUgZXhh
Y3RseS4NClNvIE5MODAyMTFfQ01EX1NFVF9UWF9CSVRSQVRFX01BU0sgaXMgbm90IHNvIHVzZWZ1
bCBmb3IgdXMNCnNvbWV0aW1lcy4gQWxzbyB3ZSB3YW50ZWQgdG8gc2VlIG5vdCBvbmx5IHRoZSBU
WCBwb3dlciwgYnV0IHRoZQ0Kc2lnbmFsIHF1YWxpdHkgb2YgY2VydGFpbiBtb2R1bGF0aW9ucy9j
b2RpbmcgcmF0ZXMsIGFuZCB0aGUgZXF1aXBtZW50DQpzdGlsbCB0ZW5kcyB0byByZWNlaXZlIGZp
eGVkIHJhdGVzLg0KDQpbLi4uXQ0KDQo+IA0KPiBPbmUgY291bGQgYWxzbyBhcmd1ZSB0aGF0LCBp
ZiBpd2x3aWZpIGFscmVhZHkgaGFzIGEgZGVidWdmcyBrbm9iDQo+IChsb29rcyBsaWtlIHJzX3N0
YV9kYmdmc19zY2FsZV90YWJsZV93cml0ZSgpPyksIHJ0dzg4IHNob3VsZCBiZSBhYmxlDQo+IHRv
IGhhdmUgb25lIHRvbyA7KQ0KPiANCj4gUmVnYXJkcywNCj4gQnJpYW4NCj4gDQoNClllbi1Ic3Vh
bg0K
