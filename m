Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB560482DC3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jan 2022 05:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiACEWm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 23:22:42 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:10974 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiACEWl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 23:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1641183761; x=1641788561;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q1lQKjbpx/o5wUSpwIQBcEzmCXkuASD94T8v5350IEQ=;
  b=bkpgjpgMf2Ga/FcZO2a3+m4IN7X8chznF1x9WlMBPOGESK1a9SrUVsJG
   rZ0Bcg1sf3M3RVblHdOOvBOAgHpuy36vPKX5kcu/d9LjlPozv8V6F08cu
   XaR16YebmcFSFmSMo6AhqfDyIba32ospnjTJxPY77Bt33Na8Yqdd6Cn3e
   E=;
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 04:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNmb+AN1JPfBOD51wWA/LRzGtZoTxoSjdRzE3xWir3u/h8kCe/NcA2CJaVCVaVGm3UE32PHBlgyT2TLIuf5AHN2OJ2mztcXRejE1ub0ebvXbDc90vC3x6I8tpoIPMr648E4uqP5OX4+E2sF/Z/K1PkNHDc1RTDYhu2CII4siqOt/AzhalpE4Ggv5FdEsesfxwnzxp5c+zYYCu0geCNijDTyjEmBkoC4DYVbdgy9VhrpqYFzXRfrGSOsxWn8AaLWA3LyuCmUs483sPZRtAIswnch0JQDPnhDhCdn2Mkco2p9smNInr6gOM2dNcQ3JaVDPiTe5T70dXt5ARINCatHeNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1lQKjbpx/o5wUSpwIQBcEzmCXkuASD94T8v5350IEQ=;
 b=LUyKMXVQKKzKPzFdZmig3bBXn/n9lgzSd9aI3nQJdOSoNDi3eb5JL63wIWIbE99I4x6PTxEVG+X6I4c6D2Gfl9dTdp/Xzi9EVgaLtGKSHnyZPt4vwpDNcP/KTifmzbxGOAusw+bfLnUJfl4y63bDphLnOBiXJX060IMjAXchH7My+W1UxWnWIXzkMJV+x3gciSguFuiwA/qTAUZKXqqaknpegjaJaF0XHcZpZaCW9g5qj2lV+xvqbQ0H3z7EjcN92jPtXm/8Epdc3nVdS8ff+hoor6xtbWHdQoQrfJm30nrD0KX66qiFrB601rMB/nxMQ7MvpWGMO5EZQPX+KjqcWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 DM6PR02MB5420.namprd02.prod.outlook.com (2603:10b6:5:7b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4844.15; Mon, 3 Jan 2022 04:22:37 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6598:c2a0:f5c8:6677]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6598:c2a0:f5c8:6677%5]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 04:22:37 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Topic: [PATCH v2] mac80211: disable BSS color collision detection in
 case of no free colors
Thread-Index: AQHX70kTzemBvmAx6E+UKwYrE//iBqw7Mq+AgAqgmHCACwFBAA==
Date:   Mon, 3 Jan 2022 04:22:37 +0000
Message-ID: <DM6PR02MB49378C8163C2D61B27B0487BE9499@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1639307483-8055-1-git-send-email-quic_ramess@quicinc.com>
 <59896f7e6382ddb34a63e78b489b2ded7bb1e980.camel@sipsolutions.net>
 <DM6PR02MB4937AB3F20F2CE710DDD925BE9429@DM6PR02MB4937.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB4937AB3F20F2CE710DDD925BE9429@DM6PR02MB4937.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 258fdeaf-f4c3-42bc-bc3f-08d9ce70ac9c
x-ms-traffictypediagnostic: DM6PR02MB5420:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5420C07117760EA93A40D16595499@DM6PR02MB5420.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hk8i+XZKcl7w9FRJvaVyRxQWzkLHWcJurZYE+DEv3g0238torBpWiaRuiXYe9kIyyFCA02xLm7mdEXzRbH3IEAh0ieY2al4v8rv/hBX5k5o1mMA9iThKszydz9JMHUGact203BnMlvn9l6B02OA2nbLG3kKi33+cDDNxBq04YQR4AGda648TJgG2qY0KoM4FOcv3dG1vP5CfSgD68qczxvaY3BgsHr77v1jdVCfk2+dKiAnm6NXfeRzYhOZU8bTAlf+3HEGPpLY2C1vH4Nq+xBO8ONs5GksbAhIgeFVbmg1ve/G8Obq4L5jWb4vsMcmYEBhL4ZBI2Q9PY8SfrW6gSWsdws4dSbdDQ/z8B1T6MmO4wEqoFtOnvIr+F8C6w9Xy4PEdE/2FP5u5+i7doCy0hUwD1UYkozP+J34YLSJNvUJ3SWDf0CbgdEa2xB8Typ8LIAUapzf50MhDMwvsYK1GoLJgXEv/exPAI07RabPy6urWEYcbeRZ8kZ/0yILwbjcNnMRXznBf7e56fiM88cSx85gZlomh5uAPh6NudYoqnjMLkoyFGtC4tCI4yFYo6doa7lL51SltlTrf2M6GYCoTmYKyjSnHrg98QamXoGlhSbtf+SQz0JBSgWfkTAEryHWQc5Rm+mnvTr0Bnbu+LmMUqxFnnuedYUKHZZHkX6+HhrdZ2WbmNHSD6htalebm6pa0eWVis4lBIUBjgz1iTaRrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(8936002)(33656002)(76116006)(26005)(6506007)(66946007)(86362001)(8676002)(110136005)(55016003)(5660300002)(38070700005)(64756008)(66556008)(2906002)(66446008)(4326008)(508600001)(186003)(122000001)(316002)(83380400001)(7696005)(38100700002)(66476007)(71200400001)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEV1WklZNUZWcXZ6TUtOK3N3NlBTZHlaS2lLRzhlSlV4RXVPTVIraHVJN2ty?=
 =?utf-8?B?bTZpbVIxYk1GNTlabkxPVFVZQWhqazNobXZGbCszR3hrbjVMVm5jQmlsdlRG?=
 =?utf-8?B?WittQ0lsVEVJSU52bE5JYkVWMitBa3dUM3BUTXdtT1V5cHYvN3hKSFcvSGZx?=
 =?utf-8?B?eGpFZkZuWStjenNrWnpncVJBOE1hVDE2d0lhTC90YUxFYkFYb2V5S0RUN090?=
 =?utf-8?B?MnJIc2dlMEhJQlZvOVR0QU84eUVndlh3cmVhR2lsUFlaSS9pTUx6QW1GajJT?=
 =?utf-8?B?UkRRKzU5bGtJN0U5U0JQT1dZeDRNcDhQUTNrK2RvWlIzY3hiWXNuNkdTYldN?=
 =?utf-8?B?OHpOL213aG51WFU1RUFrdys0cGt1dnNKUmU1Tk5KcFBNRjZIdXRqMk44ZVJq?=
 =?utf-8?B?d2hmZldhVlhhY0VvQzREVmlGYzNmUzhUdmw1REtHb2hYUlQ1aW83L0NZdm5k?=
 =?utf-8?B?VHBSL3dUbWFxd3BsLy9sakw1TE4wc0U2UTI0NGpQbWNad3loYWJZeTk5aXdY?=
 =?utf-8?B?ZlBBRFowVUhkMGtYYStQWDVaZzFNUnNsQkhDN1VJZjZ3VEw4R2RDTVphMVNP?=
 =?utf-8?B?YzdBbGppOFhGNWEwSVMyRHhscDVyaEVEMVdGNG5DWGtjdlVSUXZHNVFZYng2?=
 =?utf-8?B?L0U0emt4M2lKb3MrWEoyNUdpVWxsb0pJUmg0YmRubWxudWIwS2M3cmRPMEJx?=
 =?utf-8?B?UUM1ZzN3TEpNTEI4ei9aTVFzQ2xsdXRXS0FwK2lBbXBEUlZQbm91aW9LYUpQ?=
 =?utf-8?B?RWFJUWppbjJweUxWMzFUSHI0R0dDVDlNZGtQV0hNWXV4aHdTZytnWEF4cnpV?=
 =?utf-8?B?Zjk5d1B3M0lDeFpSQytuTFFsazNiWEcwTElCRnNJSTl5dnAzcW5oN2wvN0I5?=
 =?utf-8?B?QUt3MTdtN2gxcmdKVitPY0ZsR2JjUFdnbTYyYnBIVmV5RVdpOFhIMkc3TS95?=
 =?utf-8?B?cmZsWFZkeCtQcy9SK3NSNHRjSUVUbDg4dWk0YXp2NXhuWERESTFUakRnMldK?=
 =?utf-8?B?MnluUk56VnV3MU0rSTh4eU45NjV2elFhMWpMcDJsQWVaV0FLTzJ6cUlpN1pS?=
 =?utf-8?B?WDQrR292eXcycEMzSUxXT2xIaXN4aFVycFAvS0gzMmNqdWdSaXhXQlpWbW5D?=
 =?utf-8?B?QUVnUzFYekMrZTlrTUV0cFJ6bG1QL1B3VDhvWjlVN0NyYkw0QnZuWG1YRnFE?=
 =?utf-8?B?elBSdW9CODFtQWg0MXNGQ0wzUVl1OU1ja0F3RnBUZmxMMkI0SGRsS09EWkpW?=
 =?utf-8?B?VmdpOTJXMUw4cDNhMW5rM2JXY2w1eVBSM3VxWThqZTNpV3EvQVJVMnpGeHVC?=
 =?utf-8?B?K1BmMWFqVkhUZWp0MUY0d1F5MDRBOVJPd2VtVG80NDgwbXkvU1V4d1hqdWNa?=
 =?utf-8?B?WXdZK3N1QXdaeG9xR1lJa3QzS3E5K3VVRjlkVVYrNE92TlZrS0ZuY2hEZEdX?=
 =?utf-8?B?aWtMeEFYL09SSmthbm9JYnhUUUNORkpKVTMzMDU3OFpabEpHQ0dGemFqc1RL?=
 =?utf-8?B?UnovR0M2M0xVeWZnWVJ0Q1k3V2ZTQUxvWkx0T29hV0hmT3pwOTkzS2Q5R3Jt?=
 =?utf-8?B?Nm94U3cyRFpPczVIYmtMcWZoNGNCUHBCQkdLZngrYStKeFBaVWo1ZVNnVU5j?=
 =?utf-8?B?UlpBTVJEeUVmZUhCQW9QMEd5TElYRC80T1krWHRlSVFVbTdXemZmeE9DZmJW?=
 =?utf-8?B?Nld1Q2hjNGtseXEwaWJ1NW1ld1VSVThwVlNOWjRlM29sZkgzNm0zQzYxd1Q4?=
 =?utf-8?B?WEx1aEZ5NVhoOVRJNENFVGhNS0I4K3lFZG0reUpwUDlJR1pSU25DQ2dkb0xp?=
 =?utf-8?B?a3B5Q0hER3lBRjRlYUtkWTJRMms4bVBya0JDbzdERGlqcGhOcGFXZGN3YmYv?=
 =?utf-8?B?bllSMDRBMmpqUE9uNW0rcnhaZkpEdWxROERub244RlV0UmlvdUVGVjBwa0x4?=
 =?utf-8?B?VFZlOWZWM0k2YkttSlA5a0JxL242a09xWlRmRkFRV1p6OVZZb0dOWDdFWVVB?=
 =?utf-8?B?VFFuRWt5WVdUY0RPckRHWkxRMFFKa09YVHJuZ0NhMjRCWTYyckNmS1FqcFI1?=
 =?utf-8?B?bVBIL2s0K0NxT3J2bmoySzg2bTJvTDdUY0Z4c2xFQ1ovK24xSStQSGl6cVQ4?=
 =?utf-8?B?QlozbTJLOWw5OHc3R0ZzemZTVFNyRWtxd3g5aU9ZM1hHWGtlQ1N1Nlgxc3M2?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258fdeaf-f4c3-42bc-bc3f-08d9ce70ac9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2022 04:22:37.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Oju4jZFsBO/UKNETyoZcUo3zRBgTLCDfOVV8ESu0o/QmYjqk+XGLnrt8qD6MarwapycO90MTzq1nQ8AQj0/3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5420
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFJhbWVzaGt1bWFyIFN1bmRh
cmFtIChRVUlDKSA8cXVpY19yYW1lc3NAcXVpY2luYy5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRGVj
ZW1iZXIgMjcsIDIwMjEgOTo1MCBBTQ0KPiBUbzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lw
c29sdXRpb25zLm5ldD4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgUmFt
ZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpDQo+IDxxdWljX3JhbWVzc0BxdWljaW5jLmNvbT47IExh
dmFueWEgU3VyZXNoIDxsYXZha3NAY29kZWF1cm9yYS5vcmc+DQo+IFN1YmplY3Q6IFJFOiBbUEFU
Q0ggdjJdIG1hYzgwMjExOiBkaXNhYmxlIEJTUyBjb2xvciBjb2xsaXNpb24gZGV0ZWN0aW9uIGlu
DQo+IGNhc2Ugb2Ygbm8gZnJlZSBjb2xvcnMNCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gRnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25z
Lm5ldD4NCj4gPiBTZW50OiBNb25kYXksIERlY2VtYmVyIDIwLCAyMDIxIDM6MzIgUE0NCj4gPiBU
bzogUmFtZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpIDxxdWljX3JhbWVzc0BxdWljaW5jLmNvbT4N
Cj4gPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBMYXZhbnlhIFN1cmVzaA0K
PiA+IDxsYXZha3NAY29kZWF1cm9yYS5vcmc+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0g
bWFjODAyMTE6IGRpc2FibGUgQlNTIGNvbG9yIGNvbGxpc2lvbg0KPiA+IGRldGVjdGlvbiBpbiBj
YXNlIG9mIG5vIGZyZWUgY29sb3JzDQo+ID4NCj4gPiBIaSwNCj4gPg0KPiA+DQo+ID4gPiAgaW5j
bHVkZS9uZXQvY2ZnODAyMTEuaCB8ICAyOCArKysrKysrLS0tLS0tDQo+ID4gPiAgbmV0L21hYzgw
MjExL2NmZy5jICAgICB8ICAxNiArKysrKystLQ0KPiA+ID4gIG5ldC93aXJlbGVzcy9ubDgwMjEx
LmMgfCAxMDkNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDcxIGRl
bGV0aW9ucygtKQ0KPiA+ID4NCj4gPg0KPiA+IFRoaXMgaXMgbm93IGEgZmFpcmx5IGJpZyBjZmc4
MDIxMSBjaGFuZ2UsIGFuZCBub3QgbXVjaCBtYWM4MDIxMS4gQ2FuDQo+ID4geW91IHBsZWFzZSBz
cGxpdCBpdD8NCj4gPg0KPiA+IEJ1dCB5b3UgZGlkbid0IHJlYWxseSBhZGRyZXNzIHdoeSB3ZSBu
ZWVkIHRvIGRvIHRoaXMgdmlhIGVsZW1lbnQNCj4gPiBjaGFuZ2UgZGV0ZWN0aW9uLCByYXRoZXIg
dGhhbiBsZXR0aW5nIGhvc3RhcGQgZG8gdGhpcyB2aWEgdGhlDQo+ID4gTkw4MDIxMV9BVFRSX0hF
X0JTU19DT0xPUiBhdHRyaWJ1dGUgZXZlbiBpbiBjaGFuZ2VfYmVhY29uPw0KPiA+DQo+IA0KPiBB
aCEgSSB0b3RhbGx5IG1pc3NlZCB0aGlzIGF0dHJpYnV0ZSBwYXJzaW5nIG9wdGlvbiBhbmQgd2Vu
dCB3aXRoIGFwX3BhcmFtcw0KPiBmcm9tIGxhc3QgZGlzY3Vzc2lvbi4NCj4gDQo+IFllcywgaG9z
dGFwZCB3b3VsZCBzZW5kIE5MODAyMTFfQVRUUl9IRV9CU1NfQ09MT1IgZm9yIGNoYW5nZV9iZWFj
b24NCj4gdG9vLCBtYXliZSB3ZSBzaG91bGQgcmVsb2NhdGUgY2ZnODAyMTFfaGVfYnNzX2NvbG9y
IHRvIGJlYWNvbiBkYXRhIGFuZA0KPiBkbyBubDgwMjExX3BhcnNlX2hlX2Jzc19jb2xvcigpIGlu
IG5sODAyMTFfcGFyc2VfYmVhY29uKCkgaW4gdGhhdCBjYXNlIHRvDQo+IGhhdmUgdGhpcyBkYXRh
IGZvciBib3RoIGNvbW1hbmRzLg0KPiANCkJ1dCBjaGFubmVsX3N3aXRjaCBhbmQgY29sb3JfY2hh
bmdlIGNvbW1hbmRzIHdvbid0IGhhdmUgdGhpcyBhdHRyaWJ1dGUgc2V0IGFuZA0KV2UgbWF5IGRp
c2FibGUgY29sb3IgdGhlcmUuDQpXZSB3aWxsIGhhdmUgdG8gaGF2ZSBhIGZsYWcgYW5kIHNldCBp
ZiBOTDgwMjExX0FUVFJfSEVfQlNTX0NPTE9SIGlzIHByZXNlbnQgaW4gdGhlIA0KTkwgY29tbWFu
ZCBhbmQgY2hlY2sgdGhhdCBmbGFnIGluIGFzc2lnbl9iZWFjb24oKSBiZWZvcmUgdXNpbmcgcGFy
YW1zLT5oZV9ic3NfY29sb3INCnN0cnVjdCBkYXRhIHRvIHByZXZlbnQgdGhhdCB0aGVuLg0KDQpT
bywgY2FuIHdlIGdvIHdpdGggdGhpcyBJRSBjaGVja2luZyBpdHNlbGYgb3Igd2UgY2FuIGRvIGFi
b3ZlIGNoYW5nZSwgcGxlYXNlIHN1Z2dlc3QuDQo+ID4gam9oYW5uZXMNCg0K
