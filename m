Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33B46461E
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Dec 2021 05:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbhLAEzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 23:55:42 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:38909 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhLAEzm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 23:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1638334342; x=1638939142;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bQGKcGXiZ0sdV0q4dZfQJl5/uwuEE9TIX0HOHxXqVC0=;
  b=aYVKIaiZtaSFM9Q91cV9v1XEfk6F12aS3Jiq7i3Ft05/fPAoa8ZLKUyj
   UdcbwvrCUCO80+hqZq7Iuw0xmdOi51L8mMVwIKrR9ERIQa70390e7v3vK
   0ua15v/CLmEiDgy769ZQS6Tovz/BtNgW1SWGw+JWdIQ6Q6jhfl09C4fxZ
   E=;
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 04:52:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAgT+mnIyFs8U1AwjUmaBQ2CtzCa2fm6Lj8YTdpPv93qVBXbJF7JJCfeS4+3FYN5Qn2FokQ+RfxFW4TGtvZKXyJSEGtPZcvBTWuzq/9PlmWyt7Y61OqjhI5yuxIpNBsUqR+Im1FfeM4X/bVCIlv8h3oBz1jHdiTJEsrc28MQRAhPcmhmGPQBiUHGxDBNUu3kEAqsmfdPRbpHq87rSPwoR9VDz3liBDpNVeFwaFY115T7mOzKjiYWhChHnacsLH5u9C31FBFbsXjUONMKlUAUoARp0iBaK0WcEZ8pY0bDeYpFbISc+N1h6b7mi4tvt1iJ7A1hK/sgF3qjWS1mIXfiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQGKcGXiZ0sdV0q4dZfQJl5/uwuEE9TIX0HOHxXqVC0=;
 b=VDozuQqaA56fmQHF3cGiWnE2Gux4k+QGF3TSER21EssTlt+ccgptu23OKtmpFNG48+4C/yP5BpPd1cfKnzb7kUBhV3azkg43fY4V4CjZ0698XNpiDllvwc/3QIlHLO6RIhJnS61M0+SAdPFeYf6eR96T1j41r7tnXi+FcTRqgPINbNsuWyj9/gcsXhaNlXSO+MiYeaJP6QzuWy5YAUpqtoQris7f+nCArDJYkh/HRJhqevsbvz0CTWajMaU3SassQBwFjoTK532ZNjTkedqzyXMJ2+fcyFph4ADg1eSrf54AXgFpQhnhe3QuBGDX2tij8MhxTtLz8UUDkRtSoDXLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CO1PR02MB8620.namprd02.prod.outlook.com (2603:10b6:303:15f::8)
 by CO6PR02MB7555.namprd02.prod.outlook.com (2603:10b6:303:b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 04:52:19 +0000
Received: from CO1PR02MB8620.namprd02.prod.outlook.com
 ([fe80::546b:7950:7fa6:5517]) by CO1PR02MB8620.namprd02.prod.outlook.com
 ([fe80::546b:7950:7fa6:5517%9]) with mapi id 15.20.4755.014; Wed, 1 Dec 2021
 04:52:19 +0000
From:   "Praneesh P (QUIC)" <quic_ppranees@quicinc.com>
To:     "kvalo@codeaurora.org" <kvalo@codeaurora.org>
CC:     "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
Subject: RE: [PATCH] ath11k: Add provision to configure rx hashmap
Thread-Topic: [PATCH] ath11k: Add provision to configure rx hashmap
Thread-Index: AQHXyZp297aRVj102kKwkGPq5iGkcqv/wpSAgB2IpHA=
Date:   Wed, 1 Dec 2021 04:52:19 +0000
Message-ID: <CO1PR02MB86205D503BEF9E0CE9D2788BFC689@CO1PR02MB8620.namprd02.prod.outlook.com>
References: <1635164316-27055-1-git-send-email-quic_ppranees@quicinc.com>
 <163671069706.11814.3105845576240199326.kvalo@codeaurora.org>
In-Reply-To: <163671069706.11814.3105845576240199326.kvalo@codeaurora.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a155161d-9a13-4321-57c3-08d9b4865adc
x-ms-traffictypediagnostic: CO6PR02MB7555:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <CO6PR02MB755503982477930349CA62B780689@CO6PR02MB7555.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0bnKqFZtW/WUhCw7vE0rzybJZfA7CNVqQtSecqsZpMhTZ8kpo9jtsIo37GunlC9X0V1+VEgSIFSv23Ic7DIumb+IBbzd1Ytp/iPdaoM2fUbPL6X6O5PMnfwKdPFR7T/LSeBCUxC2md/ZnqFgagjFARBCAJ1Ush6SD0umvhJTuHbqcl2FYwUpicQ3rWxd7j5DtoKOycK38ntPu4F8vWVhXFLLkwjJmLZ28N8qHnsT41ee7+XgIBHqy6EqJdccyDomg4spNZVzPBGzwYKQupZglYHm7PC+jwF6aGAvhbP3iO8LrfxkQRH2I/NwIm8hCmFWe14p3kApc2xmvT4Wnm8wK2gjDJ/MMMfM/RqZSNUoSR1qse8TMHurW4vK86Nq3rc5EraTJLqbAJHRxGCSmg5NxtY+z3YrPiuS4dK3qZL61v7vwSeQQuPrjv6uzR1MbXO8hKER1LmuvgOq/G5HwiO58LjNn8X6th8SdL7vYe5iNQOlv5N3AsfYdyNsk3Atd9yGXFWFTJutX9sOrLw5Xt4/TOWZuX4KKhxDC7qHXITL9DDSFJ2fZY5MBU22zRYAwwMtGvZoEBNuzrxc6fPnaLFVrMExb5VpLxJjO/tnOJkkt54oIqWn3gOBHUjjkA3rmF22NkeSSUS0TrSWCSmkLQo2zpcCRBSRdXVbSVU0I+XloqQkDRffPxcmarMwJ89MEEPy1tveDQhxP28LiGVUlX6WUiD9n6myqHVJHx/GrdX4J1oKrlj+PXj0EDyO5UDTE3REtAUmdNoTH9EelH0OykTmyPNVuPwfrfTCqT8Fc3p5WI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR02MB8620.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7696005)(186003)(38070700005)(107886003)(4326008)(86362001)(508600001)(966005)(55016003)(5660300002)(52536014)(54906003)(122000001)(53546011)(6916009)(6506007)(38100700002)(8936002)(316002)(9686003)(66556008)(33656002)(66476007)(26005)(71200400001)(66946007)(83380400001)(66446008)(64756008)(2906002)(8676002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkMvQWZWekRyVnBYdC9TdG9kWEM1cVdPOHNDWHRuN2UxelFScjkrN1lTWmZM?=
 =?utf-8?B?bXUzS0lHaW5ISmFiSk9INi9zckU1UEhvNXhkdEM3VFBqRVQ3MVpTOWwya1Nq?=
 =?utf-8?B?ZXpFM1M5dU5WODZlMGZuZ21SamJOMFJUdUhHQng0VG1JQk83NmtvWkJYNHhS?=
 =?utf-8?B?NS90VWdmUjVKWFoxYzlZdGVYL2xGN0tOTVlRL3VOWENBdlg4bXhGSnFqZEZG?=
 =?utf-8?B?R3ZlbEtiTVNGRWc4UTQyVzg2aGh2aHpwS3ZKWVd1Y0dMZ2VneW5jYjJXZmNq?=
 =?utf-8?B?Ym9uTmFzQTV3dVhCeTlPazFBSk9mclN5ZkIyZDB4MkRSVDkrOWNzdkVIcWtF?=
 =?utf-8?B?NW1mRUJ1VXIzc1BIeEZqVHFCOW1kU3lOdUROUmRsd1VmclZXSmlzSnFxZ0Ez?=
 =?utf-8?B?WGtJdERBNEVBUkFBaDNYQTJqNFpPeVp5amxSUHZ2dzFLN3dOU3NlQWNtUVRS?=
 =?utf-8?B?a0FpSnFpV1BnN1BTbWx0Vmw4bXpaaVRsWVRhVFlmMnlsWU1kRmZLc0MwVXJV?=
 =?utf-8?B?Qk9Mb05EK3pZUWg0QXlyRitBUjIzSFlFWWdsd0sxWm9GNW9pZFAvdnRSUHoz?=
 =?utf-8?B?Mnl2b2dDbG5HSHZhOUZSTEhaWHVCVXpiSWJaSEI4ZjdJbkowVHFqbTdLOE1C?=
 =?utf-8?B?R1lzb3Q3Z2dwUmNUZGtoMGpPcXVYeTUyNk92NkRNb1pXVXROOGFtaWY3TjBW?=
 =?utf-8?B?LzVFblhpNVBDTGpBeCt6RXpWQ1A2Y2owemtVR0kvL2h2ME9VaTRsdTcyYXdw?=
 =?utf-8?B?NXdGWSt2UHRlS0xtU2Ewc3B6a2crR1M3QnUyTjFsOTQrcEt1ZnVOWVRuOWhl?=
 =?utf-8?B?RDJHM2hncWNuZTFKLy9ITzlXOHdHUDc2alhQUkZGeXZyUVRVYjVFZUJwNitC?=
 =?utf-8?B?MFNiY1RlMUx6TTUyUUtycmozSTkyZVJRQThUanRWOW85NmJGM3JpREdJNGdu?=
 =?utf-8?B?TGxrQ3NhNm02aWxnOTZ2K3FrMC9yazlsaitncnAxQUc5OWVEZy9jL0lzQkc5?=
 =?utf-8?B?OHRvZE1qY2RHQTE5RlZjb1dhTlYzK1YzQ2prS0JtSnZuQXREYWFkNE5tQUlH?=
 =?utf-8?B?TFViKzE3dXVkMkFFMGRnd1J4MVJSWTBKUHpPQ00vbENZSHc5UnRvNFNuMm1r?=
 =?utf-8?B?SGVGaW1uUDBXMktoZ2xqQ3ZhcTB2N1hmUkZWVmF0dktJK3RwT29PU21mM1F5?=
 =?utf-8?B?a090OEgzUWlmVm1zMnNHSjJDWS80OXdVQVBQY2xoR3ZYcXJnbGNDQlBjVjky?=
 =?utf-8?B?aUh2U2FIcTJHL2JKYUdxamV5QjJMRnY5a0w2YmNrcmE1ekkxYlRtS1NXd0th?=
 =?utf-8?B?eWNJdlVUcW85VGtNVm1mK0NXbnFXYlo2K2VybHNodjRnTlppdlFQdHNSbkgv?=
 =?utf-8?B?bTdoSXF3WUErYnhwYnFkdS9FeDVjbjdWS0V3N2V5QldNcFB0SFZNdW50ZTNm?=
 =?utf-8?B?KzQreTFEV1JRZk4weVloOEpHOVJsZXFEQmVyTTF4Ykwvckx1dk03VUFQK0J4?=
 =?utf-8?B?R1V6TTBpNXp1SGZpWVBRYTJ4UTVhYVlGR0NxRmIraW9WSEViZytaOTh6dTlv?=
 =?utf-8?B?cHlBZ1RjejY5N2hsNkdxcFNCRVN4a1Z1ZnpGME1wRTVsOVBYb0pWTVpCMWZl?=
 =?utf-8?B?dlEzZWpQdlF6RHpVK2xTRUJodXFDWngzbDlMOVpBa0pOZlN6QTVDLzJ1anIw?=
 =?utf-8?B?Z2NuMnoxTGNWNFpNSHd5MFdDUkJnNWxwMExqRHYxZUo4L2tJQVRHRjU2ZUUz?=
 =?utf-8?B?UG43MmNNUWdRRXI4Q0F3L1ZaSkFIcUlTOFZWa2lsN1lZRFFPQXBvRGlneWt1?=
 =?utf-8?B?bTJCSVREOFZWdWU3ZXNka0Z6RmZzK1Y3Vm00ZDhuYVdpUWx5c0tXdkk4SWt1?=
 =?utf-8?B?UEVldjFrL29ac2JRaUdkY3ZsVTFueS8wUks2SG5jdVNDeWFsbFUyQ2JLd2Rm?=
 =?utf-8?B?YjZ2SUp3cWw5cmhXN1ZsYUJLYkNnWXk1MWpnbk1mM3JRcFlSemlUMTU1Q1dD?=
 =?utf-8?B?RnhRSUdDaG1VOC9ld2RVUEttMnNIdWRYRjJYY3lyb2FwN0dRcm9HRGVSTFg0?=
 =?utf-8?B?aFRubjREb3hHSjR3ZEo0WnBsMmxWVWR6aGxnYTBjVDQ1OFEwcnFDTFRPRjMx?=
 =?utf-8?B?aU9vTHFRNTBySVpwT29pdEg1QzFsVjB4amRldkNDVm52TnB1RDRkdVcvZkk3?=
 =?utf-8?B?NGcxdzlNNmNIVjMvbTVYdGhEcDd5Z0pyRmJ6KzREQkdxZytQMjZBMjltem56?=
 =?utf-8?B?enRjeXlkQWdlbGtDdGdRSXNiYll3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR02MB8620.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a155161d-9a13-4321-57c3-08d9b4865adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2021 04:52:19.0641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilzLEuuomX8LaSNUtOh58ro1qDHQBsw8pF8KsiOBSsEx58t/03NqfT6kd8Byc1qnXWC12P4BCOiItHN2PSPRIb95aE4yaT5aC6yvKUTkrGE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7555
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBrdmFsbz1jb2RlYXVyb3JhLm9y
Z0BtZy5jb2RlYXVyb3JhLm9yZw0KPiA8a3ZhbG89Y29kZWF1cm9yYS5vcmdAbWcuY29kZWF1cm9y
YS5vcmc+IE9uIEJlaGFsZiBPZiBLYWxsZSBWYWxvDQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIg
MTIsIDIwMjEgMzoyMiBQTQ0KPiBUbzogUHJhbmVlc2ggUCAoUVVJQykgPHF1aWNfcHByYW5lZXNA
cXVpY2luYy5jb20+DQo+IENjOiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnOyBQcmFuZWVzaCBQDQo+IChRVUlDKSA8cXVpY19wcHJhbmVl
c0BxdWljaW5jLmNvbT47IFNyaXJhbSBSIChRVUlDKQ0KPiA8cXVpY19zcmlycmFtYUBxdWljaW5j
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXRoMTFrOiBBZGQgcHJvdmlzaW9uIHRvIGNv
bmZpZ3VyZSByeCBoYXNobWFwDQo+IA0KPiBQIFByYW5lZXNoIDxxdWljX3BwcmFuZWVzQHF1aWNp
bmMuY29tPiB3cm90ZToNCj4gDQo+ID4gQ3VycmVudGx5IHRoZSBoYXNobWFwIGlzIHNldCB0byBk
ZWZhdWx0IGR1cmluZyBSRU8gc2V0dXAgYW5kIGFsbCBSRU8NCj4gPiByaW5ncyBhcmUgZXF1YWxs
eSBkaXN0cmlidXRlZCBhY3Jvc3MgMzIgaGFzaCB2YWx1ZXMuDQo+ID4NCj4gPiBJbiBtdWx0aXBs
ZSByYWRpbyBjYXNlcywgNDBNSHorODBNSHorMTYwTUh6LCBkaXN0cmlidXRpbmcgcmVjZWl2ZWQN
Cj4gPiBwYWNrZXRzIGFjcm9zcyBhbGwgdGhlIENQVSB3aWxsIGNhdXNlIENQVSBvdmVyaGVhZC4g
SW4gdGhpcyBjYXNlLA0KPiA+IGR1cmluZyBydW50aW1lIHdlIGNhbiBzcGFuIDQwTUh6IGFuZCA4
ME1IeiBhbW9uZyAyIGNvcmVzIGFuZCByZW1haW5pbmcNCj4gPiAyIGNvcmVzIGFyZSBlcXVhbGx5
IGRpc3RyaWJ1dGVkIGZvciAxNjBNSHogYnkgdXNpbmcgcmVnaXN0ZXIgbWFwcGluZy4NCj4gPg0K
PiA+IEFkZCBwcm92aXNpb24gdG8gY29uZmlndXJlIHRoZSBoYXNobWFwIGR1cmluZyBydW50aW1l
IHRocm91Z2ggZGVidWdmcw0KPiA+IGZvciBpbXByb3ZpbmcgZmxleGliaWxpdHkgdG8gY29udHJv
bCB0aGUgZGVzdGluYXRpb24gSFcgcngNCj4gPiBxdWV1ZXMvcmluZ3MsIHNvIHRoYXQgYWZmaW5p
dHkgY291bGQgYmUgdXNlZCB0byBhc3NpZ24gdGhvc2UNCj4gPiBpbnRlcnJ1cHRzIHRvIHNwZWNp
ZmljIHJpbmdzLiBTZXR0aW5nIDAgd2lsbCBkaXNhYmxlIGhhc2ggYmFzZWQgc3RlZXJpbmcuDQo+
ID4NCj4gPiBlY2hvICJoYXNobWFwIiA+IC9zeXMva2VybmVsL2RlYnVnL2F0aDExay9pcHE4MDc0
XCBodzIuMC9yeF9oYXNoDQo+ID4NCj4gPiBEZXZlbG9wZXJzIHdobyBhcmUgYXdhcmUgb2YgaGFy
ZHdhcmUgcmVnaXN0ZXIgbWFwcGluZyBjYW4gbGV2ZXJhZ2UNCj4gPiB0aGlzIHJ4X2hhc2ggZGVi
dWdmcy4NCj4gPg0KPiA+IFRlc3RlZC1vbjogUUNOOTA3NCBodzEuMCBQQ0kNCj4gPiBXTEFOLkhL
LjIuNC4wLjEucjItMDAwMTItUUNBSEtTV1BMX1NJTElDT05aLTENCj4gPiBUZXN0ZWQtb246IElQ
UTgwNzQgaHcyLjAgQUhCDQo+ID4gV0xBTi5ISy4yLjQuMC4xLTAxNjk1LVFDQUhLU1dQTF9TSUxJ
Q09OWi0xDQo+ID4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IFNyaXJhbSBSIDxxdWljX3NyaXJyYW1h
QHF1aWNpbmMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNyaXJhbSBSIDxxdWljX3NyaXJyYW1h
QHF1aWNpbmMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFAgUHJhbmVlc2ggPHF1aWNfcHByYW5l
ZXNAcXVpY2luYy5jb20+DQo+IA0KPiBkZWJ1Z2ZzIGlzIGZvciBkZWJ1Z2dpbmcgYW5kIHRlc3Rp
bmcuIFRvIG1lIGl0IGxvb2tzIGxpa2UgdGhpcyBmZWF0dXJlIGlzIGZvcg0KPiBjb25maWd1cmlu
ZyB0aGUgZHJpdmVyLCBub3QgZGVidWdnaW5nLg0KPiANCltwcHJhbmVlc10gIFRoaXMgZGVidWdm
cyBvbmx5IHVzZWQgZm9yIFJYIHBhdGggZGVidWdnaW5nIHB1cnBvc2UgZHVyaW5nIHBlcmZvcm1h
bmNlIHRlc3QsIEJ5IGRlZmF1bHQgd2UgaW50ZW50IHRvIHVzZSBkZWZhdWx0IGhhc2ggbWFwLg0K
PiAtLQ0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtd2lyZWxl
c3MvcGF0Y2gvMTYzNTE2NDMxNi0yNzA1NS0NCj4gMS1naXQtc2VuZC1lbWFpbC1xdWljX3BwcmFu
ZWVzQHF1aWNpbmMuY29tLw0KPiANCj4gaHR0cHM6Ly93aXJlbGVzcy53aWtpLmtlcm5lbC5vcmcv
ZW4vZGV2ZWxvcGVycy9kb2N1bWVudGF0aW9uL3N1Ym1pdHRpbmdwYXRjaA0KPiBlcw0KDQo=
