Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB2468380
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384432AbhLDJSA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 04:18:00 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:10024 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384430AbhLDJR7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 04:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1638609274; x=1639214074;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vSM0xuPZwqoHvwaCG/YBduN35epws0ULVAH71AFWZz0=;
  b=WnkHrwk82vzTPvZlCDCGWeVcmTOJWnb7aTcwGpZgcHZLL7aoIqQwGrAT
   FE+nsH6jJeATryKYFPRuuyUPaoQxreoqsj7vgsIoFBEBvAksQfvSkPfT6
   51/L/AS5Q9nW0gqXwnIeMTSBlLidXZaplcSw+n2wlW8yIM8DsVvuR1YBE
   4=;
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 09:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9ehn41LlZ20Y86eLKoTAfWf5a4ia+zHwAUzuT8TGyIm4yOwV7EAkJFR4uLtdh4QdTVrH7OC3+P3V69ruhSfuJZrnh04sV7yfXhBesWASebC+Sd/CDaryZ1uhwvcYOGJnXUn5+paXkb48MGK6BP2GhxGJYdSZJXIeCngQ0cIUomC081+rCGjg6ejGQGtIE7Tdoy21cfm5FoJMD9e28HWXNInw8yDYMoyu+WDOdl17GfOerEX/d8ekmGvWAnrLAnafdgE4bGyC5w5k1O1SzhRJwS1hRZBXXddsDA9GnDaA86bLfVfyP45I1yLK4o8gmsrZo8IUi86NFBEkcDlwfirkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSM0xuPZwqoHvwaCG/YBduN35epws0ULVAH71AFWZz0=;
 b=Qk7TI9yJ4Ez4SWxf8+o1cgL1i05dx4vonldZmB9mp6SYYhoKBLuAYmHqEulQ7LV1XmWpuyldiecYHFZLoe8p5E9XoAHHcr0reTklsiiHJBTf+ZAwc/+68dHakzb6/ky3JtSj/Rhwvtof46xH0Ft/TGjXrXPg864mRSN8Q3FzbGe4eYObrxhTTmYv/GhjDWXm/geMrFlSWd6CbeB82mEU1IbQyZWbeYNJyVFKLKV370LA27VI/X6997zdoqDpnHxFOQIju+Ifdv4gDKyVxGX9ZC9X6MDhu9PQh4kMsIK4FNRI3jCPBK54zsx2ZwPA/WB3vdQH77kHeKWI5xxgtdX6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by SA2PR02MB7737.namprd02.prod.outlook.com (2603:10b6:806:143::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 09:14:31 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::dd75:ddf1:eaf7:9830]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::dd75:ddf1:eaf7:9830%7]) with mapi id 15.20.4755.019; Sat, 4 Dec 2021
 09:14:31 +0000
From:   Sriram R <srirrama@qti.qualcomm.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Subject: RE: [RFC] mac80211: Mesh Fast xmit support
Thread-Topic: [RFC] mac80211: Mesh Fast xmit support
Thread-Index: AQHX6LNjXSzo0Uj9pkOODobZjQnvZawh/4+AgAALALA=
Date:   Sat, 4 Dec 2021 09:14:31 +0000
Message-ID: <SN6PR02MB4334A1D49795C50D341BB1D6F76B9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
 <accc06d7-8472-77d4-6d90-1d40565989aa@nbd.name>
In-Reply-To: <accc06d7-8472-77d4-6d90-1d40565989aa@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbb56530-f22b-47b1-7f6d-08d9b7067b4c
x-ms-traffictypediagnostic: SA2PR02MB7737:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <SA2PR02MB7737AFF6B761092207A7CFCAF76B9@SA2PR02MB7737.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dnwj5kwU7hBKvPE0rres+t8ixuBOPoHnJN5vOYgk2Kl6irK5XOFV8WR+m3wVTwzspHoV3sqRJtOqnkI1i64XZEeOcLM0eIYm0RbKGDbkq+7YZqiBzuKTbJi6mQlRNuPqrvztI3tTYrB1AeqDlCEYhWqOdWtGMgERTx1Au5dxEsFUtNVvTUb4X2nxkU0lXzU//0iK+o51ge6TEH2fobPVfcu4t07plA0UlFFO7vJk6hbCjD22zSxTfCjlIm/tjeQbLRAVu7KWmCaH9vs6fIy7wSfLwA7iVOwA0fxAq+WEe/kp/oeyO9JwO4qz/4F5uNiBiK/ae6aoDHou9SjEvjs0ra5/zIIZSHggznHnBZ4ado9+ZGTkp1jo0UNN5oVHR/l1CeyL2RGSSHA4eI0wq/Lb01sITly3e7DfGF3+XutIGu3bI0rBEGlRhp7nP1A7cEr45CZDGw3EutPlYOro7PZ49cA78nz8zt1+AZDPgkMerSRMmBy9R4ei5L6RLbj4TxAySctFnwHisp9UODn2Ddspll1nzTtZxfwRR8M+AnjkDOo9SkVdZloIw7CeCLMwVIBCrohJCA8DmhPLxuut3VRc+yz9eR3RmFJiRHakI3kimCKKZUz+Nd7X1bNJKOjhfjLTY/R7sUgWYxMYlAAsOtxJiAHXzH1xONtXqJQDwwaKP5YsT4UAxpDHZlZu/EaWKRuom9uKzT6ZLemAYmYvkFgSIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(8676002)(122000001)(508600001)(38100700002)(71200400001)(26005)(9686003)(5660300002)(55016003)(6506007)(33656002)(2906002)(8936002)(4326008)(110136005)(66556008)(38070700005)(76116006)(316002)(186003)(83380400001)(66946007)(86362001)(66476007)(64756008)(66446008)(7696005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dENTWHJLOWFrWHBEcWFBUy9KMlFRNFlPNk42N2xiTXZxY1VTelA1SEdmTVJq?=
 =?utf-8?B?Z0FzVmk4SW16S01DRE9lUUNUSExyeStaaVBoQVlQeUVxeFFWZVI1eWZxNTE1?=
 =?utf-8?B?YmlJRHlNVlRRdVhRRXlLRUdIODU2bVFXWEplVDM2a0hpNzBhSk1YaVpQZTAz?=
 =?utf-8?B?SG5DcDBiZVduNndQUms4MFllRENwcU5uTzROUFBXb1o0WVdtSjFKYTBuKzR6?=
 =?utf-8?B?SytQS3VrMGR5YTBzV3lyUFQ4R0JFRmlGczZFbkN1eGxJR0pCOWZjTlpzaWE0?=
 =?utf-8?B?Zm0yaUI5M2xWRGZFTmlyaVI3bHd1RHQ3NTJZdWIzRWhzczVJMDdrY3ptODhY?=
 =?utf-8?B?cXpYeDlBRk5tQ3BNdnliVUltR0xqbnEvaWI3NUpucDNnYis5SnA2dkhyNnVG?=
 =?utf-8?B?QzdTbkZrRWJoMWJqNE41T2lUZUx0WldjUXpsajFnQWFvZ1F0elM5aWZET0xN?=
 =?utf-8?B?b2JQQVVEL1Q5MTV6NWFwb3plOWlWT1BvcEZDelcrck9MdVZ6dkZjMWtOM2FO?=
 =?utf-8?B?VHNiL1VaRjFLdzVhVnRTZWw5NXR3MXh6L3JURFpHckpWTjJIbTdzQWJickdY?=
 =?utf-8?B?NmwrVEtsS2RIMW5FN3FaYkpYQU1sc1d3V1lyWTJobGRsVzNub3ZNbitOY00z?=
 =?utf-8?B?ZW5QaGY3K0VEeTl6RVZVTkg0eTVobVJNQ3RxdXkwRmpUZEVFK09hU3FMVVBW?=
 =?utf-8?B?c0J0NDZKbmRXS0tFQWxES3RCS0FyU0tlc1A2YnM1MEFKaUFnK01VNW9VRTBU?=
 =?utf-8?B?ckdxSjBJNzNQOU5mR1Y5R1FIY3pSQTVzN2JtcFlZdWc0NThnd3NXbTNaaE4z?=
 =?utf-8?B?dHhXN2x0N2g4WWs5cHhXWUt1amtKaEFnQitNcVN5aDQ0RHcxUTluc25rUjAr?=
 =?utf-8?B?VXFWYmp4dUlsN0JhcXNhZCtlTlFaM2x2ak90b041NmRXcUhwdDNONjVxVFJQ?=
 =?utf-8?B?V1lPN0hpekxnb1ErYVQxZi9tR1ZVemFXOWVoSnI5emVLM2lCWDFiUVREWjZv?=
 =?utf-8?B?Snk5NDlrWVhmZy9NNDkrL25RT3FyaWRjWW5lMVNGbUxUSnh5dEEvNnVPaUpm?=
 =?utf-8?B?UytSQmlIaGZHejZKUndhWm1TZllCQ1d0WGRJN0RoSHRXdG5BZ3l5bVZETGVS?=
 =?utf-8?B?bEFIUGtRWWw2QzFwTHlZNkV3WFd5TWJONVhNWVRtTWdGVnFGMTd2eGx5QXlP?=
 =?utf-8?B?YndqYVc3WnNUaEdXNlVwYkVibXN6RllUd1oxYkg1d3hhNFNkdExBZ05IWkZY?=
 =?utf-8?B?R21aeTdjMFVLWWdxc0FRZFBiUnB5VTQ0OGNic0lvUm5uR2FLcm9hbzVYOHhR?=
 =?utf-8?B?OFVKV1BQYWNxZVlaVm0wUlZSbnl1Z3N5RWpOcXRQYUlOOC93RTZoMUFiTmVx?=
 =?utf-8?B?OS9sNVo4V1JwaXZobnB3ZTZicm5CSTR3ZUVVQUZGb0drcEJISVBCNVhRZDFx?=
 =?utf-8?B?LzlTdmFnQ1RNRnlRUDhZVUxFWDZWeFN5aE1hb2hrZ0ZCWTRZamdIYVQxMFI3?=
 =?utf-8?B?WDBQN1JiSncySW90ZVB2bFJIUE9nT2JjbGwzZTBqeWtFY2xnR1M1TEs3MkNF?=
 =?utf-8?B?U016N1JZUEJpVlpadVliQUloQ0FtY1NUMVNiMVFmYWZ5T0wwRkJqZ0lRRitx?=
 =?utf-8?B?TG5UL05GditXNVl3OS9PUG11ZlpvbnJ1blBxUE1QSkZ1UWpXeDZxbkd1Nk96?=
 =?utf-8?B?Q3hsRHlTa0JMUnRjcE1CYy9hZ1l5UjFFRlVxdDdDdkZEblhSSEV4Z09JaVhq?=
 =?utf-8?B?dmhtMGQ0K3FEeE51U1VBaFhLOVRHN1BhdUNLMTA0cUhpT3lIT3NKTmIrMm1w?=
 =?utf-8?B?N2tmQlRnd012Y1J5L0pQZlg4cmNrdmdFUVNmekhlTW9UcDROOS9xRlVTejZo?=
 =?utf-8?B?OS8zOFRVdG5ZNnlSaHFZOHc2Qk4xYVh4SDlOczNseFFzUGR2Yi80Wi81VytF?=
 =?utf-8?B?SnpJaTBGby9SSTIxVmlPSThkekZONEZCMkVJcTB1RjRtMUZYd2FxaWkybFEx?=
 =?utf-8?B?amNOWEdhM0gvbmpaMlV3QXNON1QrK29YcW5ZRlE0VGxtWTljUnNRWFl2bGRB?=
 =?utf-8?B?VnZwdWxRNmZ5cklmZkdiQ2RKYkY1TkNXZHo4NXY5WGFHTHlKM3RNREYySGtW?=
 =?utf-8?B?VnUzMjJCclJXVW5UbFplTzNsekdXSmZLbjF2OTcrTWpCYTdlUkRJUVdOWkhE?=
 =?utf-8?B?a1kxRWpLdCtESk9kcjV5VGFRbU4xTUh6dFM4WlA0V3hjTThoMDdpaVhJOWNN?=
 =?utf-8?B?b3FWckpLNTBYbTl5Qmt6NGNmVWFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbb56530-f22b-47b1-7f6d-08d9b7067b4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2021 09:14:31.4416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ggtKABfVnI//IJo5EeXANUX3a2WM+kGl2C5rJRYjqFTt+Ho4hck2VHBF/NgRoGguTrdx5dkTsUy4t4DA2tu34Tv6MVMZXW9WzB23MYL/6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7737
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGZWxpeCBGaWV0a2F1IDxuYmRA
bmJkLm5hbWU+DQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJlciA0LCAyMDIxIDE6NTUgUE0NCj4g
VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT47IGxpbnV4LQ0K
PiB3aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGpvaGFubmVzQHNpcHNvbHV0aW9ucy5u
ZXQNCj4gU3ViamVjdDogUmU6IFtSRkNdIG1hYzgwMjExOiBNZXNoIEZhc3QgeG1pdCBzdXBwb3J0
DQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1
YWxjb21tLiBQbGVhc2UgYmUgd2FyeQ0KPiBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFu
ZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IE9uIDIwMjEtMTItMDQgMDM6MDQsIFNyaXJh
bSBSIHdyb3RlOg0KPiA+IFN1cHBvcnQgRmFzdCB4bWl0IGZvciBtZXNoIGRldmljZSB0eXBlcyBi
eSBjYWNoaW5nIHRoZSBoZWFkZXINCj4gPiBjb3JyZXNwb25kaW5nIHRvIHRoZSBldGhlcm5ldCBE
QSBhbmQgcmV1c2luZyB0aGUgY2FjaGVkIGhlYWRlciAobWFjLA0KPiA+IG1lc2gsIGxsYykgZXZl
cnl0aW1lIHRoZSBwYWNrZXQgaXMgaW50ZW5kZWQgZm9yIHRoYXQgREEuDQo+ID4NCj4gPiBUaGlz
IHdpbGwgYXZvaWQgbXVsdGlwbGUgcGF0aCB0YWJsZSBsb29rdXBzIGR1cmluZyBoZWFkZXIgZ2Vu
ZXJhdGlvbg0KPiA+IGZvciBhIG1lc2ggcGFja2V0IHR4Lg0KPiA+DQo+ID4gRnJlc2huZXNzIG9m
IHRoZSBoZWFkZXIgaXMgdmVyaWZpZWQgYnkgaWRlbnRpZnlpbmcgY2hhbmdlIGluIG1lc2gNCj4g
PiBwYXRocyBiZWZvcmUgdXNpbmcgdGhlIGhlYWRlciBhbmQgY29ycmVzcG9uZGluZyBjaGFuZ2Vz
IHRvIHRoZSBoZWFkZXINCj4gPiBhbmQgY2FjaGUgZW50cnkgaXMgZG9uZSBvbiB0aGUgZmx5Lg0K
PiA+DQo+ID4gTXV0YWJsZSBmaWVsZHMgb2YgdGhlIGhlYWRlciBzdWNoIGFzIGV0aCBTQSwgdGlk
LCBtZXNoIFNOLCBQTiBhcmUNCj4gPiB1cGRhdGVkIGZvciBlYWNoIHhtaXQuDQo+ID4NCj4gPiBF
YWNoIGNhY2hlIGVudHJ5IGlzIGFib3V0IDEwMEJ5dGVzLCBsZWFzdCB1c2VkL2V4cGlyZWQgZW50
cmllcyBhcmUNCj4gPiBwZXJpb2RpY2FsbHkgcmVtb3ZlZCB3aGVuIGNhY2hlIGdldHMgYWxtb3N0
IGZ1bGwuDQo+ID4gQ3VycmVudGx5IHRoZSBzaXplIGlzIHNldCB0byA1MCBlbnRyaWVzLg0KPiA+
DQo+ID4gRHJpdmVyIG5lZWRzIHRvIGFkdmVydGlzZSBOTDgwMjExX0VYVF9GRUFUVVJFX01FU0hf
RkFTVF9YTUlUDQo+ID4gdG8gZW5hYmxlIHRoaXMgc3VwcG9ydCBhbmQgc2V0dXAgdGhpcyBjYWNo
ZS4NCj4gVGhhbmtzIGZvciB3b3JraW5nIG9uIHRoaXMhIEkgd2lsbCBsaWtlbHkgdGFrZSBhIGNs
b3NlciBsb29rIGF0IGl0IHNvb24uDQo+IE9uZSBxdWljayBxdWVzdGlvbjogZG9lcyB0aGlzIGlt
cG9zZSBhbnkgZXh0cmEgcmVxdWlyZW1lbnRzIG9uIHRoZSBkcml2ZXIsDQo+IG9yIHdoeSBkb2Vz
IHRoZSBkcml2ZXIgbmVlZCB0byBhZHZlcnRpc2Ugc3VwcG9ydCBmb3IgdGhpcz8NCkhpIEZlbGl4
LA0KDQogVGhlcmUgaXMgbm8gcmVxdWlyZW1lbnQgZnJvbSBkcml2ZXIvaHcgYXMgc3VjaCBhbmQg
dGhpcyBoYXMgc2ltaWxhcg0KcmVxdWlyZW1lbnQgYXMgSUVFRTgwMjExX0hXX1NVUFBPUlRfRkFT
VF9YTUlUIGJlaW5nIGVuYWJsZWQgZnJvbSBkcml2ZXIuDQpCdXQgSSB3YXMgbm90IHN1cmUgaWYg
YWRkaW5nIH41S0IgKDUwIGVudHJpZXMgeCB+MTAwQnl0ZXMpIGJ5IGRlZmF1bHQNCndhcyBhY2Nl
cHRhYmxlIGZvciB0aG9zZSBkcml2ZXJzIHdoaWNoIGFscmVhZHkgZW5hYmxlZCBGQVNUX1hNSVQu
DQpIZW5jZSBhZGRlZCB0aGlzIGV4dHJhIGNvbnRyb2wgZnJvbSBkcml2ZXIgdG8gZW5hYmxlIHRo
aXMgZmVhdHVyZSBmb3IgdGhpcyBSRkMuDQpLaW5kbHkgc3VnZ2VzdCBpZiBvdGhlciBhbHRlcm5h
dGl2ZXMgY291bGQgYmUgdGFrZW4gdXAuDQoNClJlZ2FyZHMsDQpTcmlyYW0uUg0KPiANCj4gLSBG
ZWxpeA0K
