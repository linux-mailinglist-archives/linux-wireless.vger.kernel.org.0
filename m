Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC5347FA17
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Dec 2021 05:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhL0ETq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Dec 2021 23:19:46 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:1696 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbhL0ETq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Dec 2021 23:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1640578785; x=1641183585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AtvRkh1PITme4zApoidvp+jWFF9S+bIh1r+1cy/LobQ=;
  b=ThacqCKlVInKrc0NBr+Fk+tWqH0r03jZRFijU6UkK02Ui/mCpwAO34St
   uIcqdfmi/0+uTuXxleaT9CzL1AcThi3eih2RDJzuNnKy+jeU6zR98skSK
   SwQRRNwxnO6sZQc1G6p1EXXhP1sm2yu1Igtj/6JsaMPQyoEJkp5XVrCFN
   g=;
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 04:19:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWAjI3WsPtdXleJtT4hNDHhx/7LRbl5mhGp0YWsDUE8OxDPbmHSYATi7QAiFYs+bTcIokh3Vo3X/LRqwN28OwxIox0f/ugMoynaPPWB470JK00eJ/+oOqAvBv+FBF3ASPNJdSnGVDE+T8EDczNXgN1Z5He5TAVPxmINVa0iuGqnvZ/lL5CvwhTDKgg7YhwX0PnNk64OoVOSlF9UDZNCx6edbJTi+n2EDq0F/HVwMaOvPj5GEhL6XHk7yjkmKr8b099vOjd+y9o3WXdT0WuL77DSG8GTjuD+2K+KaVx0Q9wdHrhmwFdXpAvTL8egYbg6aLn8h3YctZ2h5mouUPOHyYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtvRkh1PITme4zApoidvp+jWFF9S+bIh1r+1cy/LobQ=;
 b=HznNxY0AWrYQ/n49qW05jn5TSvH1S5PYRWLbw00StgYiep/ZJufHNFSY8Yq+lH3YcSRcTYUjtnPiD36AaiLqj/nTUWKUUEfZLUmYD1eWrG1RZEw+AzBjuWiI+ckscA/kr9nNebhOk0xCOtwGvpJ2yIIUgZJv8t51cp2HN1dwLD1haK2wtQrU+dbxAv7oX1mUnc92LGL56LDamoSmOkBFce2S7pw2h0S4ZIP1nt5b7b2aAvzg8T/tL0y+csVE1XPceI/Q4RaEm0jhWSdY913ICH6+ppEClqurUStg1I7n2EWVj9mXB+CQCTGwXUKMyB19hevy94khDd0+rELLJhQIoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 DM5PR02MB2586.namprd02.prod.outlook.com (2603:10b6:3:40::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Mon, 27 Dec 2021 04:19:43 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6598:c2a0:f5c8:6677]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6598:c2a0:f5c8:6677%5]) with mapi id 15.20.4823.022; Mon, 27 Dec 2021
 04:19:42 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: RE: [PATCH v2] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Topic: [PATCH v2] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Index: AQHX70kTzemBvmAx6E+UKwYrE//iBqw7Mq+AgAqgmHA=
Date:   Mon, 27 Dec 2021 04:19:42 +0000
Message-ID: <DM6PR02MB4937AB3F20F2CE710DDD925BE9429@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1639307483-8055-1-git-send-email-quic_ramess@quicinc.com>
 <59896f7e6382ddb34a63e78b489b2ded7bb1e980.camel@sipsolutions.net>
In-Reply-To: <59896f7e6382ddb34a63e78b489b2ded7bb1e980.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6550308-28eb-422e-f195-08d9c8f01b8f
x-ms-traffictypediagnostic: DM5PR02MB2586:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR02MB25865309A337A3473CBE303B95429@DM5PR02MB2586.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Px4MzPN7TtofmRNFO2dZ0FhRidUOt0DnoF9grorf1hZ/FrPDKOvEI8FmyF80jHGB2wQILjzYJ/4u9eMyjEwnKgRBIh7LYRzhjJ0i8RSAI2VT8YtkxNZCbK3ieRzBOuJE8XkAy0Ko7pbdobVRwiuWrKfthfMW5ok3JUnrpPh0H9pkGHwMOVi1x9am+/qUU2mJ4NQKJv56rEeuppxh8atqXrU0kiY2Aro5DKqgC3wf2j+YN2mHNR6DNVAEheV2o30ylPZGKYdD3Yf5Zi/+DSzEh+CXgnvHzl5MoMlGTs4tUiyjMRYyhqOH6RYMFbRpyHq2tGOhS5KTGti6OEfRHLQug5VENXeF5trout/5XGvjBaDfKdi432OB3JbwW1sTsdoQIQwCTs0dDNns0u+0Eh6ROJ1BwyuvUxBHu3KgGo68+qgZTFbDHeT1iEwLYX0tRAMLSdHqhXHm7DpRj/ftaUdzvtWUfBG4IFWRihTXtNuFuKsX9MaJrTuMxSbZf+LHVHo+ZinPpkmWwhtEAz2ur1DpUWtNNbHfboylOqeUe1SmvIopiNF7qB+kI3V/IR7tSSTnAGE2lXGiiuutPNQcFXaw4qfOB3C69pUOh3VpVGWfV1TuA4TOwLXnDr888295Vj4aMT0E1liOvmRyzjhDEgetLAeT3LcHgYCmHrS33jO0/3xOTHlpGOgVgcCZUJDZmHGmCmTwYyxPtKS/pmwM6GXAKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66446008)(66556008)(86362001)(8676002)(33656002)(2906002)(508600001)(54906003)(7696005)(6506007)(4326008)(64756008)(83380400001)(53546011)(66476007)(52536014)(122000001)(66946007)(5660300002)(38070700005)(8936002)(38100700002)(316002)(55016003)(76116006)(71200400001)(186003)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3llc1drdC9RWjNkV1czaFR1cUpXNjR1d1RuSXMyMWZxNkF1L0M3cWpyYjY2?=
 =?utf-8?B?NTBOOUJVQW5vS0g4ME12N2owcU05SlJRK0RhV1R4cEFqNkpjRUE3RVZkM2dz?=
 =?utf-8?B?RHBsUWJCMFVxVEw5a3hqVDh4b1dwdDI4c2RKd2ZuVHRxM09ucGkvOEpEOEZU?=
 =?utf-8?B?Tzhpa3RDR1dQSGNvcEVwY3VwdS9tWUlRbytRRE9TcEZtVlp3cUVJZUF4cldN?=
 =?utf-8?B?c2hHcGxTRHozZDZPbEZmYmp4eWJ3bXFSbWMzM2Z3bTkyVnlRdStvd1cyVkwx?=
 =?utf-8?B?bXZXZXoyRUV6bFh5WVVlSEpyeC9CSXpDM0VxVlFZMFVYNVI3SlNPalUzaE1P?=
 =?utf-8?B?eUpnbnp1bExuY090RTdrdm1sZ3RoaG1QbGhMNUlVV0xwK0I2Tm9VQUFhRWhU?=
 =?utf-8?B?cm1WWlZhYVgvbFd2MVFnampjc29WUW1BT3JYVklIQ25TbVBkSGxsa2sxRTJY?=
 =?utf-8?B?bklrMGxzWE1USDdWRmd2RW1SRXhlcnFoM2dSVFN3MnhnSFIxTjJqZ1E5aHQ3?=
 =?utf-8?B?N25IelkwSG11OEZhSFdrejBqdU9ZUnk2MGFYbktlOGRCOW5KZEVZYmNJcVlz?=
 =?utf-8?B?cFNiZHY3Rk9LNUEyZkJNVzYvYklTWjFuQkxFZ1FEZG9aNURwdHFBZFRid2VT?=
 =?utf-8?B?YmNxekxtMEVOZ0M4S2ZlaVRlY21RaE0xNDNSbjBzN09idjNZbGVFWkJtQXZF?=
 =?utf-8?B?YThDU2w1SVRhZG5LaTVQLzRmRjM5YzFaek9MRDBoc1JoeUZPWEt0YlFKajgw?=
 =?utf-8?B?N3J4bzRuNXhDSjRGdzQzS3JrVzBHODV5QVBUUWl4N01lT0JCTHgrWWh0d3VE?=
 =?utf-8?B?VGVMY2t2VDhiRS9FSDlBODJwc0FQeW9nWDVjYzM1dUtlY3E5WEgyZnl4eWRv?=
 =?utf-8?B?a2lPenFBQi92L3RMTldrNnh2NkFoK2pYTGQ3VUpYNVlQYWxMc1dqN2R0SUxr?=
 =?utf-8?B?bDZNWmJjUmx1eEhYeUNseitSUzdBelZwTlY1S0dqK3QyK2hqVCtCaE1qTU96?=
 =?utf-8?B?eHJZUEo0Sk5sYk5uZkJjWmZyUFMxMWJBem9XaVZVa0pmYmFYekp1TU13d3hk?=
 =?utf-8?B?UDJPZzBzRDkvL25sbVdzUWxBV1R3ZGcwVVhHMmFVTk9IN3pyMDRkU2ZYTGxX?=
 =?utf-8?B?RnN3VlV0LzBVakNoMDlxbjdseUE4cW5qNEpJUmk5YzZyN25ZVEJpN0NoMUJn?=
 =?utf-8?B?UmxvejhuVWlKZk16ZW5rdjJxVmtLZlQ4dlBWbnBKeXM5VngvMnl6eXNIQ1BL?=
 =?utf-8?B?UVQ5M0hlL3p0NzFpSFlyZXBxYVZ1Mk5hYVBjNFZoZ0hxdlN2eGJVUjZscTBN?=
 =?utf-8?B?OXRNOE9yeXpERXYzY1pEWUg0WGlhUFZuY1ZhWk5jZWFkTGNmVHYxc2tEY0RL?=
 =?utf-8?B?bUJ0cElYMm5qaG1EWlhwNnFwbFRjanhwT01mN0doUWtCZXJPcVpvbkZLTVVQ?=
 =?utf-8?B?ZSs3eHM4cS9mMmFURDFLeURtdmRiV1dwTkxoRmFUL1U3UUdXRnprUEErcFNp?=
 =?utf-8?B?S0JXekN5NzhZbU5HL0lOUG1EOExiQmd1ZEdoYmJDWlBNdWZlMVZUTlQ4bE5N?=
 =?utf-8?B?Z3lLai9Tb3I5aVllb3dhSU9sa2NKNk9lbDRwNG9nUTM5bEVzZnN1M21jT0xI?=
 =?utf-8?B?TzZlbVVWbGtULzh1QXFKeUxtZDZwRzdkUGhEWXQ1aVcwZ2lpSXFMU205Q2N2?=
 =?utf-8?B?QVowQW1mNVQ5cVJoRnRhYktyQTFZTFR0dHNyem96MldWa3JXUFlMUTdVc2Jv?=
 =?utf-8?B?bk5LTCtPYVZSZ205eFpQVEF0NXI3UU9tc1pwNlpqbm0wR0V2Yy9HT2NXNzV0?=
 =?utf-8?B?SHlkWklNNHJHbmdTMldST3hUUUduRCtzOTlZdEJjNnRxRDhsRlp4TXdaWEJL?=
 =?utf-8?B?enVpUlhpSGdpWFExNnJZazFNdk1QQ0d6dnpOVEdnemdpMFd5eExleWlXQzZV?=
 =?utf-8?B?bkFjVkNUbGVLWFpoSFpWaThWdmxwc2l6c3FxVnJIY2dPeVVPaDVpTWpMamQ0?=
 =?utf-8?B?SnVWL0wvTjRjRUUrYTlXcWFvM0JaQk9saUpQaXFPZVQvdTMyMVVhU3ZWOERl?=
 =?utf-8?B?R0lzeGJyVTFHbFd0MGh3bVB4eEhic2Z4U1ZQNXJaVHJBUTVrVHJMdWJ0VExC?=
 =?utf-8?B?MzRHckF3TDVVY0x6dEp0dDU2UE0yOXkrNnFMeWYwWEVxRGJUSzh3dmxOQTQ0?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6550308-28eb-422e-f195-08d9c8f01b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2021 04:19:42.8510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BMHh/xXrwGKrFx9eVkzUq9922IW6rjpGRCg2qsrk4rKfPn/kwHClCucyF+oVsXmnU01iwbc7W7oOnXFQ2zVpNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2586
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgRGVjZW1iZXIgMjAsIDIw
MjEgMzozMiBQTQ0KPiBUbzogUmFtZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpIDxxdWljX3JhbWVz
c0BxdWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTGF2
YW55YSBTdXJlc2gNCj4gPGxhdmFrc0Bjb2RlYXVyb3JhLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gbWFjODAyMTE6IGRpc2FibGUgQlNTIGNvbG9yIGNvbGxpc2lvbiBkZXRlY3Rpb24g
aW4NCj4gY2FzZSBvZiBubyBmcmVlIGNvbG9ycw0KPiANCj4gSGksDQo+IA0KPiANCj4gPiAgaW5j
bHVkZS9uZXQvY2ZnODAyMTEuaCB8ICAyOCArKysrKysrLS0tLS0tDQo+ID4gIG5ldC9tYWM4MDIx
MS9jZmcuYyAgICAgfCAgMTYgKysrKysrLS0NCj4gPiAgbmV0L3dpcmVsZXNzL25sODAyMTEuYyB8
IDEwOQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCA3MSBkZWxldGlvbnMo
LSkNCj4gPg0KPiANCj4gVGhpcyBpcyBub3cgYSBmYWlybHkgYmlnIGNmZzgwMjExIGNoYW5nZSwg
YW5kIG5vdCBtdWNoIG1hYzgwMjExLiBDYW4geW91DQo+IHBsZWFzZSBzcGxpdCBpdD8NCj4gDQo+
IEJ1dCB5b3UgZGlkbid0IHJlYWxseSBhZGRyZXNzIHdoeSB3ZSBuZWVkIHRvIGRvIHRoaXMgdmlh
IGVsZW1lbnQgY2hhbmdlDQo+IGRldGVjdGlvbiwgcmF0aGVyIHRoYW4gbGV0dGluZyBob3N0YXBk
IGRvIHRoaXMgdmlhIHRoZQ0KPiBOTDgwMjExX0FUVFJfSEVfQlNTX0NPTE9SIGF0dHJpYnV0ZSBl
dmVuIGluIGNoYW5nZV9iZWFjb24/DQo+IA0KDQpBaCEgSSB0b3RhbGx5IG1pc3NlZCB0aGlzIGF0
dHJpYnV0ZSBwYXJzaW5nIG9wdGlvbiBhbmQgd2VudCB3aXRoIGFwX3BhcmFtcyBmcm9tDQpsYXN0
IGRpc2N1c3Npb24uDQoNClllcywgaG9zdGFwZCB3b3VsZCBzZW5kIE5MODAyMTFfQVRUUl9IRV9C
U1NfQ09MT1IgZm9yIGNoYW5nZV9iZWFjb24gdG9vLA0KbWF5YmUgd2Ugc2hvdWxkIHJlbG9jYXRl
IGNmZzgwMjExX2hlX2Jzc19jb2xvciB0byBiZWFjb24gZGF0YSANCmFuZCBkbyBubDgwMjExX3Bh
cnNlX2hlX2Jzc19jb2xvcigpIGluIG5sODAyMTFfcGFyc2VfYmVhY29uKCkgaW4gdGhhdCBjYXNl
IHRvDQpoYXZlIHRoaXMgZGF0YSBmb3IgYm90aCBjb21tYW5kcy4NCg0KPiBqb2hhbm5lcw0K
