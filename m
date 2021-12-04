Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9B14683A9
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 10:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384495AbhLDJmG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 04:42:06 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:41300 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384512AbhLDJmE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 04:42:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1638610718; x=1639215518;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MkAWNljRaoXtny6XppxD4i72QswB8DO0xDCQzuv492I=;
  b=EHVgVHDg6xiCZSnsVL6sf5tUUi5niVCVwnEsus5vKKigOdWdO99v5Yel
   DynAwC8yPrQz6C6duLY+AAd9KDsvsGNhP8NEizRD3/cH82jAgWNi6rVwY
   UiMO7ZFbdvYDPTNzZcSMc2EiHa+N2ijqz1Y6goqS4dzeLnf+TKlU6B5Ze
   A=;
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 09:38:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8dBmblh28nX8fZU76ylyKS0AJty+zDOA7kq5cUt8I3Jj6SOVUXOkYg792dwmhLlfCMruwYY4ekclEj4I0rL/uM8Ml31AoNEMOkheywStqNwYg2eygPP7KlnJlSd754WXqyhE7uoDWCYXYEV7VIEQCBA4UinlYLa3o1Hj4H4/XMFfkyySxdqOZEq60oTVIkae8MOoXqthZFgBWl2RdjyZiqtWG8pIi8KlYIgU6XGJjrUyluCzhimIqoY9TLk/rb3lgqKjOz9CiFeS2spPPPxTgjQRqWdyXvfOyLf5jMRPOxpfZiDpGAQ7lgQu66FtBxumZgAXN78bi9t/IBjWADPOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkAWNljRaoXtny6XppxD4i72QswB8DO0xDCQzuv492I=;
 b=YdnrPN01m7Qz0+caUD8Zy0v97JVUkLHcVNReVwRDNOjyg9EPMeR8bj0Cldw/Lew75L0ul/92S/3dv6jTS1Hl8URZF0NSpahf/EcBq+E3V0o0PG1z388Fi1KAXadKUJAkemVOIvWdHpM+GnwIkMYsFoq/ABs+I9eThHqmR3dHBFovPPxJo6+501+p14F6XdKRKbPDjE3g2wkYdL8Jdh76iHchHr6I9burk2NLJNAAPjnluoxB5YC4Lqz1n2eoYeL0d8CBdtwZgxq3czQi/0AP6WH9yKyl6rJYpScni3N18CHJ9nxTxVGf2QjjaVv7JriGXlPZ7GOyP7EvxufxsWS2uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by SN6PR02MB5423.namprd02.prod.outlook.com (2603:10b6:805:e1::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 09:38:36 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::dd75:ddf1:eaf7:9830]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::dd75:ddf1:eaf7:9830%7]) with mapi id 15.20.4755.019; Sat, 4 Dec 2021
 09:38:36 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [RFC] mac80211: Mesh Fast xmit support
Thread-Topic: [RFC] mac80211: Mesh Fast xmit support
Thread-Index: AQHX6LNjXSzo0Uj9pkOODobZjQnvZawh/4+AgAALALCAAAPngIAABJnQ
Date:   Sat, 4 Dec 2021 09:38:36 +0000
Message-ID: <SN6PR02MB433405734C561C1EB2E2848FF76B9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
 <accc06d7-8472-77d4-6d90-1d40565989aa@nbd.name>
 <SN6PR02MB4334A1D49795C50D341BB1D6F76B9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <35940119-ae70-b040-5645-9a90cb8f9046@nbd.name>
In-Reply-To: <35940119-ae70-b040-5645-9a90cb8f9046@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84a6034d-3211-4921-07b0-08d9b709d868
x-ms-traffictypediagnostic: SN6PR02MB5423:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR02MB5423E93D1E0AD31C22E959118B6B9@SN6PR02MB5423.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1YrEN+7x8lkKh/mNhKgavSaMbAMValrYSBDtKqsxb8sSsyR/qqm4T11e4UUbr7740OKa8i9Tczzn5PwVezjt5LbSCaOyNL9UYw1bsTc/TZ8MgOwX5GWy6X9RKy4+u70NVytkSMGULsaHdlhBfMT8Jtn1wVKrY21ux09G26fvIflrpMCK0/Pg6DUU82UXjURwJcX3erYHDcmUbOB7W2zhKvnwUCaJCmqIxFCs27l9ExC8o/eg24Pz02xhwUWOBko/GbxsTDHmoMEGXtPkPO94nyMPL6Q7OP838XPJUNb0LTWGx7l12GKsk3z9T9TNS36xi4aMMmfe949kdnPxe1ot5XwfOw3m047c5EvVTCbBpiqkwIQiM2kNp775vwOH9KdzAn5uvqlmzUXmLn5pzlAJ9vByqMO6k/mr2aUU/biRddwoncnzEQF+zZ79WBXRpx7cmOHBqRG9KQ6iw3ymsg7GKWmVyh2SWtOytSz9sJvkYUJNnEwrxbrmpfATZ59xFSCYq+I4yIwk7y1vxtoaz5TRajpje7/Ss8ToXOqDWjflrSyBwoC9yFXrWbpyk6knxrQCP0VOz1sqbT0WImWnIQIxofVCmgKKTagzHXKR/b1iHGtuVzLiYtlamGv9fbtjiVjHOz86yBWcS3wnygkWciGtNdI2auKMdifhH/3XFYKehv7KudAGwo7MV5O831RMKHFVD/GefXuazWjZAbKsJIKRCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(186003)(8676002)(9686003)(38070700005)(53546011)(86362001)(5660300002)(2906002)(6506007)(316002)(76116006)(83380400001)(122000001)(7696005)(4326008)(508600001)(66556008)(8936002)(26005)(66476007)(66946007)(33656002)(38100700002)(64756008)(110136005)(66446008)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC9ZZm1XNzB1bDV0dXdUczNZSm05UVVFOG1EbDBTVk9sMHBYZEIvZ2haUVZo?=
 =?utf-8?B?QTVIdGdXS1FtYW5Mb1AwckYyc0ZoV3FwK3dVOGFiVmNGYkY5YWlFWWRkOG1T?=
 =?utf-8?B?RnpTa2FEdXNUOVhWOVlsRVlJZEplaWRKK2tVMnRzVEFqd0JqRmFZeU1Ud2I3?=
 =?utf-8?B?ZUNNTkdsc3ZHREZOQWwrOWNGQUtzR3doS2N4RVd2VVFVbjVpOVVNNklHdmNP?=
 =?utf-8?B?ZUl0NUZnVEI4OTNKb3ZxVUpKSFRXaHIwczBqSTJIS2xsL0c2bi9yMHR2dXBn?=
 =?utf-8?B?Mm5BVGp4aDJENEpyMlBmN2dCM2FGcmdodmRJRi9tTjJ2ekZxZzhXT056WEYy?=
 =?utf-8?B?ZEhyMDlzeE8wZzhiN0JyaU5oWVdFNlAvdW5BRS9OWkRVcUNIaFZOVDRrVjlE?=
 =?utf-8?B?d0w2eERWdy9NY0hDZXU3VlVSeWU3OXQ4b2tKUUdHN2hUZ0NiQ1ZYRUdFc3Fq?=
 =?utf-8?B?c3J0ek5kTE5oMlBkRktXVGFvNHFyajF2RlFlTlJ4S1NiaUludWNoT3c3eEJR?=
 =?utf-8?B?eTAveThUMkRxSkZ0aGxTb29jNFRadmpvM3MrT1F5WkNURHArdGx3WE5zQTNk?=
 =?utf-8?B?UVRVRmJ1TFlSTjl2RXMzRHVjNk9JRVBLdUdEUFhiZkF4YjdMVENFaURmdHMz?=
 =?utf-8?B?cjRUR1orUklLbndES0pwSmRLcFU2OFB1bTF4czhaR3Y1anZsUC9VTFg2dTlM?=
 =?utf-8?B?TDFaQW1iREZtMmlMS05ZcnJwMU0xcEFWTWcrTDF3d1FmQjU2N0xGdWFVK3Za?=
 =?utf-8?B?Z0xmbHB1TndVUitNZEplMjNWTkd1eW5ib2pOeFZ5Wjh6R1hZRXlBQVZuQW1Y?=
 =?utf-8?B?OWN1dWJXU2tVUElMV0F2eGxUNEV2OHR3aFpPT3VIekJmeHVDNlhXOUJhUytW?=
 =?utf-8?B?MFQ0U01PZFMvS1JHZlREUTRGRXlEU0xydG5CRjhpNEx0SjlnRTVHNVExa2hQ?=
 =?utf-8?B?NHUvQzJTSEtLUHZCTmRLaVlMRUpOY3BzZ296NjVELzVFUW1YcWJhKy9ZeURG?=
 =?utf-8?B?UW5NNGZoQ0hSQll5NkhFN0J2ZVhJUEVNTHVxUVBWaVkzTGVpUWJNREowdFpr?=
 =?utf-8?B?N2F3cGNHUTQvV3hqNWVhL2pSenhLT1d4U29ldm5WQUtTa01PeTVtd3pUYkx3?=
 =?utf-8?B?cldxT3NEWUdKQ1FLd0NzRjlPWWlGdmVYbTRjNUlPdDZJRTRSajc2aVBZZHl2?=
 =?utf-8?B?bFVqVytZZFZKaGppOFJsbVNMa3ArVXJITXJCUWRhZS9zWmJJUUFRc1BQdnZw?=
 =?utf-8?B?aVdoZk1DdWd0TUNQdzY4TEtGMlJoUmhYb0ZoRFdzRjFZR0ZVMkxmWjA4WkJO?=
 =?utf-8?B?cks3YzczVVcwN3FNZnhuL25TUjBzUlY0anlJVlV5bE9RMFB2VmdFYmVLOFZD?=
 =?utf-8?B?TTJld294clh0TXhSYm1rQnBlSjVoOHA4TzJKMm1LVGk4VitkVk0rbkpwd01D?=
 =?utf-8?B?ejY5TlJZUHhOTHZpVmliMmdRdWs3ZGM0d3dGRnZEMHJFa0dkSEFhb0lEajky?=
 =?utf-8?B?ajVtcVJNYmpUYkVHcmcreTVtdGxmVXkzcG9OR0NUNUpvMWEvdUN1UVd0aXJs?=
 =?utf-8?B?Y1BEaEdCWVVXcWJZOE5KSWllaTl2MVZPcGZMK2xjbjFnZjFPd3VEaVI2OGNn?=
 =?utf-8?B?a25tdXNSV2NEbU1WdlJXcmYyVkhJdktZOS9QM3R4bnN5THNxTWhNYkNRYjV0?=
 =?utf-8?B?RDZWWDlDNVhqd1h3M3V3MDZ6c0xXQ2xwZ3gvQUdVTFZNZkpuQlU2QTRxLy9i?=
 =?utf-8?B?aUZGeGgwZ2NwZ2xFUDJqUWp3WVB2aFBpZGZGaEhTQVZURHZMOERaQ1Bob0Ew?=
 =?utf-8?B?OFAzUFkzWGFNeG9CMXBUKzd3elVZelVTVHh4TUwrNDRhTFFidkl4UHAweVZ3?=
 =?utf-8?B?Y00wMG5IN0MzeXFxampuOUJ3dnJIZE5Cei8yTFN6aHh1NTdOd3BXZGVlOE8r?=
 =?utf-8?B?ZWJGMzNiMGFXaUkzSDFZandLckhwS3lVb25Hb3o0RmM3Nkh1WlZoQW5TZzBX?=
 =?utf-8?B?S0lBaE1pWTZMLzVxWjgxWm12dHMrYTdaS1JzOVRNRHhXL29vOS9vdUgvVlhn?=
 =?utf-8?B?TGE3akJtc1lHRUM2Q0U2cVBFL0FtdVN1c3A3c2ExcmhiTGlZVnpwbWxFUHZT?=
 =?utf-8?B?M1dDSWRla2lZQlRDSmdlTkQxbndFS2tnQUg1bmkwUitPMmFZNlFtNFRGU3RF?=
 =?utf-8?B?eWgwdlJWYkdMRjZyNm9wREtTemtZc0xZMzZWQkxreGRUa2FrQ2Z2Wmo3QUk4?=
 =?utf-8?B?ZDZrUEVpTkhXWk81clZjbTA4NTJRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a6034d-3211-4921-07b0-08d9b709d868
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 09:38:36.1423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jTV3vIse8voiRV1oiwaTE2Ay2AxUyBVEQgVU8xe7vJdJkBIWDniwI2ilRG1Fbs+zch5lLDH7fMqh5IVY6uqd/+4OeSweRC0py/9uZbjU9Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5423
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGZWxpeCBGaWV0a2F1IDxuYmRA
bmJkLm5hbWU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciA0LCAyMDIxIDI6NDkgUE0NCj4g
VG86IFNyaXJhbSBSIDxzcmlycmFtYUBxdGkucXVhbGNvbW0uY29tPjsgU3JpcmFtIFIgKFFVSUMp
DQo+IDxxdWljX3NyaXJyYW1hQHF1aWNpbmMuY29tPjsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJu
ZWwub3JnDQo+IENjOiBqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0DQo+IFN1YmplY3Q6IFJlOiBb
UkZDXSBtYWM4MDIxMTogTWVzaCBGYXN0IHhtaXQgc3VwcG9ydA0KPiANCj4gV0FSTklORzogVGhp
cyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4gUGxlYXNlIGJlIHdh
cnkNCj4gb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNy
b3MuDQo+IA0KPiBPbiAyMDIxLTEyLTA0IDEwOjE0LCBTcmlyYW0gUiB3cm90ZToNCj4gPj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogRmVsaXggRmlldGthdSA8bmJkQG5i
ZC5uYW1lPg0KPiA+PiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgNCwgMjAyMSAxOjU1IFBNDQo+
ID4+IFRvOiBTcmlyYW0gUiAoUVVJQykgPHF1aWNfc3JpcnJhbWFAcXVpY2luYy5jb20+OyBsaW51
eC0NCj4gPj4gd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+ID4+IENjOiBqb2hhbm5lc0BzaXBz
b2x1dGlvbnMubmV0DQo+ID4+IFN1YmplY3Q6IFJlOiBbUkZDXSBtYWM4MDIxMTogTWVzaCBGYXN0
IHhtaXQgc3VwcG9ydA0KPiA+Pg0KPiA+PiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQg
ZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUNCj4gPj4gd2FyeSBvZiBhbnkgbGlu
a3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gPj4NCj4gPj4g
T24gMjAyMS0xMi0wNCAwMzowNCwgU3JpcmFtIFIgd3JvdGU6DQo+ID4+ID4gU3VwcG9ydCBGYXN0
IHhtaXQgZm9yIG1lc2ggZGV2aWNlIHR5cGVzIGJ5IGNhY2hpbmcgdGhlIGhlYWRlcg0KPiA+PiA+
IGNvcnJlc3BvbmRpbmcgdG8gdGhlIGV0aGVybmV0IERBIGFuZCByZXVzaW5nIHRoZSBjYWNoZWQg
aGVhZGVyDQo+ID4+ID4gKG1hYywgbWVzaCwgbGxjKSBldmVyeXRpbWUgdGhlIHBhY2tldCBpcyBp
bnRlbmRlZCBmb3IgdGhhdCBEQS4NCj4gPj4gPg0KPiA+PiA+IFRoaXMgd2lsbCBhdm9pZCBtdWx0
aXBsZSBwYXRoIHRhYmxlIGxvb2t1cHMgZHVyaW5nIGhlYWRlcg0KPiA+PiA+IGdlbmVyYXRpb24g
Zm9yIGEgbWVzaCBwYWNrZXQgdHguDQo+ID4+ID4NCj4gPj4gPiBGcmVzaG5lc3Mgb2YgdGhlIGhl
YWRlciBpcyB2ZXJpZmllZCBieSBpZGVudGlmeWluZyBjaGFuZ2UgaW4gbWVzaA0KPiA+PiA+IHBh
dGhzIGJlZm9yZSB1c2luZyB0aGUgaGVhZGVyIGFuZCBjb3JyZXNwb25kaW5nIGNoYW5nZXMgdG8g
dGhlDQo+ID4+ID4gaGVhZGVyIGFuZCBjYWNoZSBlbnRyeSBpcyBkb25lIG9uIHRoZSBmbHkuDQo+
ID4+ID4NCj4gPj4gPiBNdXRhYmxlIGZpZWxkcyBvZiB0aGUgaGVhZGVyIHN1Y2ggYXMgZXRoIFNB
LCB0aWQsIG1lc2ggU04sIFBOIGFyZQ0KPiA+PiA+IHVwZGF0ZWQgZm9yIGVhY2ggeG1pdC4NCj4g
Pj4gPg0KPiA+PiA+IEVhY2ggY2FjaGUgZW50cnkgaXMgYWJvdXQgMTAwQnl0ZXMsIGxlYXN0IHVz
ZWQvZXhwaXJlZCBlbnRyaWVzIGFyZQ0KPiA+PiA+IHBlcmlvZGljYWxseSByZW1vdmVkIHdoZW4g
Y2FjaGUgZ2V0cyBhbG1vc3QgZnVsbC4NCj4gPj4gPiBDdXJyZW50bHkgdGhlIHNpemUgaXMgc2V0
IHRvIDUwIGVudHJpZXMuDQo+ID4+ID4NCj4gPj4gPiBEcml2ZXIgbmVlZHMgdG8gYWR2ZXJ0aXNl
IE5MODAyMTFfRVhUX0ZFQVRVUkVfTUVTSF9GQVNUX1hNSVQNCj4gPj4gPiB0byBlbmFibGUgdGhp
cyBzdXBwb3J0IGFuZCBzZXR1cCB0aGlzIGNhY2hlLg0KPiA+PiBUaGFua3MgZm9yIHdvcmtpbmcg
b24gdGhpcyEgSSB3aWxsIGxpa2VseSB0YWtlIGEgY2xvc2VyIGxvb2sgYXQgaXQgc29vbi4NCj4g
Pj4gT25lIHF1aWNrIHF1ZXN0aW9uOiBkb2VzIHRoaXMgaW1wb3NlIGFueSBleHRyYSByZXF1aXJl
bWVudHMgb24gdGhlDQo+ID4+IGRyaXZlciwgb3Igd2h5IGRvZXMgdGhlIGRyaXZlciBuZWVkIHRv
IGFkdmVydGlzZSBzdXBwb3J0IGZvciB0aGlzPw0KPiA+IEhpIEZlbGl4LA0KPiA+DQo+ID4gICBU
aGVyZSBpcyBubyByZXF1aXJlbWVudCBmcm9tIGRyaXZlci9odyBhcyBzdWNoIGFuZCB0aGlzIGhh
cyBzaW1pbGFyDQo+ID4gcmVxdWlyZW1lbnQgYXMgSUVFRTgwMjExX0hXX1NVUFBPUlRfRkFTVF9Y
TUlUIGJlaW5nIGVuYWJsZWQgZnJvbQ0KPiBkcml2ZXIuDQo+ID4gQnV0IEkgd2FzIG5vdCBzdXJl
IGlmIGFkZGluZyB+NUtCICg1MCBlbnRyaWVzIHggfjEwMEJ5dGVzKSBieSBkZWZhdWx0DQo+ID4g
d2FzIGFjY2VwdGFibGUgZm9yIHRob3NlIGRyaXZlcnMgd2hpY2ggYWxyZWFkeSBlbmFibGVkIEZB
U1RfWE1JVC4NCj4gPiBIZW5jZSBhZGRlZCB0aGlzIGV4dHJhIGNvbnRyb2wgZnJvbSBkcml2ZXIg
dG8gZW5hYmxlIHRoaXMgZmVhdHVyZSBmb3IgdGhpcw0KPiBSRkMuDQo+ID4gS2luZGx5IHN1Z2dl
c3QgaWYgb3RoZXIgYWx0ZXJuYXRpdmVzIGNvdWxkIGJlIHRha2VuIHVwLg0KPiBJIHRoaW5rIDUg
S0IgbWVtb3J5IHVzZSBpcyB2ZXJ5IHNtYWxsIGNvbXBhcmVkIHRvIHRoZSBtZW1vcnkgdXNlZCBm
b3INCj4gcGFja2V0cyBhbmQgb3RoZXIgZGF0YS4gSWYgdGhpcyBpcyBvbmx5IGFib3V0IG1lbW9y
eSB1c2UsIGl0IGFsc28gZG9lc24ndCBtYWtlDQo+IG11Y2ggc2Vuc2UgdG8gbWUgZm9yIHRoZSBk
cml2ZXIgdG8gZGVjaWRlIGlmIHRoaXMgaXMgZ29pbmcgdG8gYmUgdXNlZC4NCj4gTXkgc3VnZ2Vz
dGlvbiB3b3VsZCBiZSB0byBub3QgaW50cm9kdWNlIGFuIGV4dHJhIGNhcGFiaWxpdHkgYW5kIHNp
bXBseQ0KPiBlbmFibGUgaXQgaWYgZmFzdC14bWl0IGlzIHN1cHBvcnRlZC4NClN1cmUsIEFncmVl
ZA0KDQo+IE1heWJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWxsb3cgdGhlIHVzZXIgdG8gY29u
ZmlndXJlIHRoaXMsIGJlY2F1c2UNCj4gc29tZSBuZXR3b3JrcyBtaWdodCBiZW5lZml0IGZyb20g
YSBsYXJnZXIgY2FjaGUuDQpSaWdodCwgSSdsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4N
Cg0KVGhhbmtzLA0KU3JpcmFtLlINCj4gDQo+IC0gRmVsaXgNCg==
