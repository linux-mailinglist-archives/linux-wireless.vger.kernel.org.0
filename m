Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FBD7B654D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Oct 2023 11:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239599AbjJCJTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Oct 2023 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbjJCJTS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Oct 2023 05:19:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16946BD
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 02:19:12 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3938ukoT71796034, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 3938ukoT71796034
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Oct 2023 16:56:48 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 3 Oct 2023 16:56:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 3 Oct 2023 16:56:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 3 Oct 2023 16:56:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Larry Finger <Larry.Finger@lwfinger.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "it+linux-wireless@molgen.mpg.de" <it+linux-wireless@molgen.mpg.de>
Subject: RE: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Thread-Topic: rtlwifi: RTL8188EE: Unable to connect to Wifi network
Thread-Index: AQHY83CXuPZvQJXpY0OWuHZCLRjdK640rmaAgABpvICACq+nAIAATGKAgeHryQCAF8XD8A==
Date:   Tue, 3 Oct 2023 08:56:46 +0000
Message-ID: <644721f28e2f4305b4dba8a60de888ef@realtek.com>
References: <eb1885f2-abd9-1f1f-1c3e-c879372d8db0@molgen.mpg.de>
 <4899c9d3-acad-6cc0-e1ec-ab4b27754ecb@molgen.mpg.de>
 <fd317fc1-70e3-44bd-912a-07ce9aec0b86@lwfinger.net>
 <1f635ca8-28df-8762-4484-2b5daf896bb7@molgen.mpg.de>
 <61c69be4-daa3-95d5-47a7-856a5624fa9a@lwfinger.net>
 <43e41620-c512-4569-bfb1-3dc82bbc0253@molgen.mpg.de>
In-Reply-To: <43e41620-c512-4569-bfb1-3dc82bbc0253@molgen.mpg.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.25]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bCBNZW56ZWwgPHBt
ZW56ZWxAbW9sZ2VuLm1wZy5kZT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMTgsIDIwMjMg
OTo0NiBQTQ0KPiBUbzogTGFycnkgRmluZ2VyIDxMYXJyeS5GaW5nZXJAbHdmaW5nZXIubmV0Pjsg
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2
Z2VyLmtlcm5lbC5vcmc7IGl0K2xpbnV4LXdpcmVsZXNzQG1vbGdlbi5tcGcuZGUNCj4gU3ViamVj
dDogUmU6IHJ0bHdpZmk6IFJUTDgxODhFRTogVW5hYmxlIHRvIGNvbm5lY3QgdG8gV2lmaSBuZXR3
b3JrDQo+IA0KPiBEZWFyIExhcnJ5LCBkZWFyIFBpbmctS2UsDQo+IA0KPiANCj4gQW0gMTUuMTEu
MjIgdW0gMjM6MjEgc2NocmllYiBMYXJyeSBGaW5nZXI6DQo+ID4gT24gMTEvMTUvMjIgMTE6NDcs
IFBhdWwgTWVuemVsIHdyb3RlOg0KPiA+Pg0KPiA+PiBUaGFuayB5b3UgZm9yIGNoZWNraW5nLiBK
dXN0IGEgcXVpY2sgdXBkYXRlLCB0aGUgdXNlciByZXBvcnRlZCBiYWNrLA0KPiA+PiB0aGF0IFdp
ZmkgaXMgd29ya2luZyBmaW5lIGF0IGhlciBob21lLiBTbyBpdCBtdXN0IGJlIHNvbWUNCj4gPj4g
aW5jb21wYXRpYmlsaXR5IHdpdGggb3VyIGluc3RpdHV0ZSBBcnViYSBhY2Nlc3MgcG9pbnRzL1dp
ZmkuDQo+ID4+DQo+ID4+IEhvcGVmdWxseSBJIGhhdmUgbW9yZSB0aW1lIG5leHQgd2VlayB0byBn
YXRoZXIgbW9yZSBsb2dzLg0KPiA+DQo+ID4gT25lIHRoaW5nIHRoYXQgd291bGQgYmUgdXNlZnVs
IHdvdWxkIGJlIHRoZSBpbi10aGUtYWlyIHBhY2tldHMgY2FwdHVyZWQNCj4gPiB3aXRoIFdpcmVT
aGFyay4gVGhhdCB3YXkgd2UgY291bGQgc2VlIHRoZSBhY3R1YWwgcHJvYmUgYW5kIHJlc3BvbnNl
Lg0KPiANCj4gSSBhbSBzb3JyeSBmb3Igbm90IGdldHRpbmcgYmFjayB0byB5b3UgZWFybGllci4g
VGhlIHVzZXIgd29ya2VkIGFyb3VuZA0KPiB0aGUgc2l0dWF0aW9uIGF0IG91ciBpbnN0aXR1dGUg
d2l0aCBBcnViYSBhY2Nlc3MgcG9pbnRzIGJ5IHVzaW5nIGEgd2lyZWQNCj4gY29ubmVjdGlvbiwg
dGhlIGxhcHRvcCBsdWNraWx5IHN0aWxsIGhhcy4NCj4gDQo+IFRoZSBjdXJyZW50IHN0YWNrIGlz
ICpsaW51eC1pbWFnZS02LjQuMC0yLWFtZDY0KiA2LjQuNC0zLA0KPiAqd3Bhc3VwcGxpY2FudCog
MjoyLjEwLTE1LCBhbmQgKm5ldHdvcmstbWFuYWdlciogMS40NC4wLTEuDQo+IA0KPiBSZW1vdGVs
eSwgSSBpbnN0YWxsZWQgKnRzaGFyayogNC4wLjgtMSwgZW5hYmxlZCB0aGUgV2lmaQ0KPiANCj4g
ICAgICAkIHN1ZG8gbm1jbGkgcmFkaW8gd2lmaSBvbg0KPiANCj4gYW5kIHN0YXJ0ZWQgY2FwdHVy
aW5nLg0KPiANCj4gICAgICAkIHRzaGFyayAtaSB3bHA4czAgLXcgL2Rldi9zaG0vMjAyMzA5MTgt
LWxpbnV4LTYuNC40LS10c2hhcmsucGNhcG5nDQo+ICAgICAgQ2FwdHVyaW5nIG9uICd3bHA4czAn
DQo+ICAgICAgICoqICh0c2hhcms6MTA2MjIwKSAxNTozMzoyMi40NjU3NzIgW01haW4gTUVTU0FH
RV0gLS0gQ2FwdHVyZSBzdGFydGVkLg0KPiAgICAgICAqKiAodHNoYXJrOjEwNjIyMCkgMTU6MzM6
MjIuNDY1ODg3IFtNYWluIE1FU1NBR0VdIC0tIEZpbGU6DQo+ICIvZGV2L3NobS8yMDIzMDkxOC0t
bGludXgtNi40LjQtLXRzaGFyay5wY2FwbmciDQo+ICAgICAgNjMgXkMNCj4gICAgICB0c2hhcms6
DQoNCkFzIExhcnJ5IG1lbnRpb25lZCAiaW4tdGhlLWFpciBwYWNrZXRzIiB3b3VsZCBiZSBoZWxw
ZnVsLg0KDQpJbiB5b3VyIGNhcHR1cmVkIHBhY2tldHMsIG9ubHkgNTQ6Mjc6MWU6ZjY6Yjg6ZDMg
YXMgc291cmNlIHRvIHNlbmQgb3V0IERIQ1AgYW5kDQpJQ01QIHY2IHBhY2tldHMsIGJ1dCBJIGRv
bid0IGtub3cgaWYgaXQgcmVhbGx5IHNlbmRzIG91dCwgb3IgcGVlciAoQVApIGRvZXNuJ3QNCnJl
cGx5IHRoZSBwYWNrZXRzLiANCg0KDQo+IA0KPiBgbm1jbGlgIHNob3dlZCB0aGUgc3RhdHVzIGJl
bG93Og0KPiANCj4gICAgICB3bHA4czA6IGNvbm5lY3RpbmcgKGdldHRpbmcgSVAgY29uZmlndXJh
dGlvbikgdG8gTVBJIEd1ZXN0DQo+ICAgICAgICAgICAgICAiUmVhbHRlayBSVEw4MTg4RUUiDQo+
ICAgICAgICAgICAgICB3aWZpIChydGw4MTg4ZWUpLCA1NDoyNzoxRTpGNjpCODpEMywgaHcsIG10
dSAxNTAwDQoNCkFzIHlvdXIgbG9nLCBJIGJlbGlldmUgaXQgY2FuIGNvbm5lY3QgdG8gIk1QSSBH
dWVzdCIgDQoiIHdscDhzMDogQ1RSTC1FVkVOVC1DT05ORUNURUQgLSBDb25uZWN0aW9uIHRvIDZj
OmYzOjdmOjEwOmE0OjEyIGNvbXBsZXRlZCINCg0KQnV0LCBzb21laG93IGl0IGNhbid0IHlpZWxk
IElQIGFuZCB0aGVuIGRpc2Nvbm5lY3QuLi4NCiJkZXZpY2UgKHdscDhzMCk6IHN0YXRlIGNoYW5n
ZTogaXAtY29uZmlnIC0+IGZhaWxlZCAocmVhc29uICdpcC1jb25maWctdW5hdmFpbGFibGUnLCBz
eXMtaWZhY2Utc3RhdGU6ICdtYW5hZ2VkJykiDQoNCkkgc3VnZ2VzdCB0byBzZXQgZml4ZWQgSVAg
YWRkcmVzcyB2aWEgTk0gdG8gc2VlIGlmIGl0IGNhbiB3b3JrLiANCg0KUGluZy1LZQ0KDQo=
