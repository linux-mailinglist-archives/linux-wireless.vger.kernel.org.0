Return-Path: <linux-wireless+bounces-409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6F180437F
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 01:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A6B20B16
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Dec 2023 00:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99A812;
	Tue,  5 Dec 2023 00:40:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC2AC
	for <linux-wireless@vger.kernel.org>; Mon,  4 Dec 2023 16:39:56 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B50dpjiF2419579, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B50dpjiF2419579
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Dec 2023 08:39:51 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 5 Dec 2023 08:39:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 5 Dec 2023 08:39:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 5 Dec 2023 08:39:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ali Ghandour <gandour.ali@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Lenovo LOQ rtw_8852be
Thread-Topic: Lenovo LOQ rtw_8852be
Thread-Index: AQHaH+dudVZVMpW7Qk6t1f3PxKDyKLCNY6tQ///EsACAAAT0AIAAh+ZQgAeHaQCABKhgsA==
Date: Tue, 5 Dec 2023 00:39:51 +0000
Message-ID: <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com>
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com>
 <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
 <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
In-Reply-To: <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxpIEdoYW5kb3VyIDxn
YW5kb3VyLmFsaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciAyLCAyMDIz
IDU6MjQgUE0NCj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBMZW5vdm8gTE9R
IHJ0d184ODUyYmUNCj4gDQo+ID4gPiA+ICQgbHNwY2kgLXR2DQo+ID4gPiA+IC1bMDAwMDowMF0t
Ky0wMC4wICBJbnRlbCBDb3Jwb3JhdGlvbiBEZXZpY2UgYTcxNQ0KPiA+PiBDYW4gSSBrbm93IHRo
ZSB0eXBlIG9mIHlvdXIgcGxhdG9mb3JtIExlbm92byBMT1E/IElzIGl0IGEgcmVndWxhciBub3Rl
Ym9vayBjb21wdXRlcj8NCj4gDQo+IExPUSAxNUlSSDggLSBUeXBlIDgyWFYNCj4gSSBhbSB1c2lu
ZyBhIGR1YWwgYm9vdCB3aXRoIFdpbmRvd3MgYW5kIFVidW50dSAyMi4wNA0KDQpJIHN0aWxsIGNh
bid0IGZpbmQgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGRldmljZSBhNzE1IHRoYXQgSSBhbHNvIGNh
bid0IGZpbmQNCnRoaXMgSUQgaW4ga2VybmVsIHNvdXJjZSBjb2RlLiBJIHdpbGwgZGlnIGtlcm5l
bCBmdXJ0aGVyIHdoZW4gSSBoYXZlIGZyZWUgdGltZS4gDQoNCj4gDQo+ID4+IFRoZSBQQ0kgRVhU
IGNhcGFiaWxpdGllcyBsb2NhdGUgZnJvbSAxMDBoLiBOb3Qgc3VyZSBpZiBob3N0IGNvbnRyb2xs
ZXIgZHJpdmVyIGxpbWl0cyB0byBkaXNwbGF5IHRoZW0/DQo+IEkgZGlkIG5vdCBnZXQgeW91ciBx
dWVzdGlvbi4gQ2FuIHlvdSBzYXkgaXQgYWdhaW4gcGxlYXNlPw0KDQpJIG1lYW50IG9mZnNldCAx
MDBoIG9mIFBDSSBjb25maWd1cmF0aW9uIHNwYWNlIGlzIGEgc3RhbmRhcmQgYXJlYSBbMV0uIA0K
DQoiUENJIEV4cHJlc3MgZXh0ZW5kcyB0aGUgQ29uZmlndXJhdGlvbiBTcGFjZSB0byA0MDk2IGJ5
dGVzIHBlciBGdW5jdGlvbiBhcyBjb21wYXJlZCB0byAyNTYgYnl0ZXMNCmFsbG93ZWQgYnkgUENJ
IExvY2FsIEJ1cyBTcGVjaWZpY2F0aW9uLiBQQ0kgRXhwcmVzcyBDb25maWd1cmF0aW9uIFNwYWNl
IGlzIGRpdmlkZWQgaW50byBhIFBDSSAzLjANCmNvbXBhdGlibGUgcmVnaW9uLCB3aGljaCBjb25z
aXN0cyBvZiB0aGUgZmlyc3QgMjU2IGJ5dGVzIG9mIGEgRnVuY3Rpb27igJlzIENvbmZpZ3VyYXRp
b24gU3BhY2UsIGFuZCBhDQpQQ0kgRXhwcmVzcyBFeHRlbmRlZCBDb25maWd1cmF0aW9uIFNwYWNl
IHdoaWNoIGNvbnNpc3RzIG9mIHRoZSByZW1haW5pbmcgQ29uZmlndXJhdGlvbiBTcGFjZQ0KNSAo
c2VlIEZpZ3VyZSA3LTMpLiINCg0KSSBkb24ndCBrbm93IHdoeSB0aGUgUENJIGNvbnRyb2xsZXIg
aW4geW91ciBwbGF0Zm9ybSBkb2Vzbid0IHJlY29nbml6ZSB0aGUgcmVnaW9uLA0KYW5kIHRoZW4g
X3Bvc3NpYmx5XyBjYXVzZSBkcml2ZXIgZmFpbGVkIHRvIGFjY2VzcyA3MTloLg0KDQoNClsxXSBo
dHRwczovL2Jsb2cuY3Nkbi5uZXQvaHVhbmdrYW5neWluZy9hcnRpY2xlL2RldGFpbHMvNTA1NzA2
MTINCg0KDQo=

