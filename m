Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41A2F7EAE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 15:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbhAOO6l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 09:58:41 -0500
Received: from mail-eopbgr20099.outbound.protection.outlook.com ([40.107.2.99]:60899
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728330AbhAOO6k (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 09:58:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vvu4KvUxwCuEpLWeYQbJY7ewSJQ/n1+NhoADznfQ4VTT0WE+PxYRfWZCjkWs+d9s9ovddAPFrUZKBQqPJntEaqIHq0e/2lYAvl0UdJxlWHfgm1PlanRLLnTd7HCTgW8thO9fNxeT2lvHPVpV292Pls+h40FWCFNTwbjFzEfk/c7nEiIEiq9txuU0RoEYqT8eIdOuvFryhonFLALmoVR5ycUeTnKPRNzy6iBB8pQ60cZj6DjhAnKQaIuG3bXZ0kjNeSjiYh+hrqwRuR5Ua8MhtvV5FLmHnkF73ICAQuXSVOaP8IYCAcS+ZlDawgUUe46mb/Oi4/ZPJDasV8GsDjgWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2mh36IoMRqIQrqmZWUXLQs2HnN0yY+KvxIMAEQpacg=;
 b=adAzdbqg6CUroyUWfI3LPZZTVFATLAnEVsHtpjzv05w51dthkuikn0K+Twi29wK247AIdpl4458Ea17mFerBmbiuDhTdJoiFNAffPK+54GrunV8jvR9zs6BosWIOgkb/H9/sPEBkbtnB6a0b1SoVoI6oiqBxOFrfRF6FSgwEYZ57X4rvjm4XiVQR10JVVTi3hM71mVy/1w9HHLGdJPRa8R6Uf6jtdlgHD1wOxVhq+isddiUyWarcg7WjGJP4KW7GBYjlWB+COV2yt1pUoRb4oycR7Qw65hlOH2QQdQKilQRF0Ysz22JEFrK2+Fdoaf8nY2/PDEy3d5A0vgX0UTZ7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2mh36IoMRqIQrqmZWUXLQs2HnN0yY+KvxIMAEQpacg=;
 b=SqY2MJZC4YVnhjT3E8TSee+3Lz7AgDtnph85rx56cYO/WxiVNSJWNrChCIIRWBIlb0OCCm4zoNk2b3czb+FXoAEXtk2LzubmmpaQbTmmIDNQ1K15q4w1UYPkci8zw8ZURTTvPFrsWy/vvt/2xvleaJ8+tktxrtoAuMAFYFbF3ns=
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR0302MB2816.eurprd03.prod.outlook.com (2603:10a6:800:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Fri, 15 Jan
 2021 14:57:50 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::41f1:9e49:1cd0:55c8%6]) with mapi id 15.20.3763.009; Fri, 15 Jan 2021
 14:57:50 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
Thread-Topic: [PATCH v2] brcmfmac: add support for CQM RSSI notifications
Thread-Index: AQHW6pNzTQg04I/KVkmfDUZ99gM7aqoou1WAgAANGIA=
Date:   Fri, 15 Jan 2021 14:57:50 +0000
Message-ID: <3a7de182-b0c7-352c-323b-3e3cebb9ffa3@bang-olufsen.dk>
References: <20210114163641.2427591-1-alsi@bang-olufsen.dk>
 <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
In-Reply-To: <2adec5d6-fbc9-680c-01d6-25f83327bf21@broadcom.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none
 header.from=bang-olufsen.dk;
x-originating-ip: [193.89.194.27]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66ccdcdf-0634-490d-05e7-08d8b965eddb
x-ms-traffictypediagnostic: VI1PR0302MB2816:
x-microsoft-antispam-prvs: <VI1PR0302MB28160C21FA57F0A6AB7158BC83A70@VI1PR0302MB2816.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pAeV8vtCc+97FsqGbTVZegiFmnYE0M0xw0An5ccuEh7Xx2RPk89GPRp8kll4YfxHTkVV2O9iBchMWB7Yu7Ek/NKih/shy3yn+iJKU1ea+tyNfW/5UB34KFHVFLpYObhPxfBrymqCKymt592IrzBnG9vaTPqKrA6073KiquoUe5T8BYlB+SO/mAA2qJo3mRnA5AYgLz4e0lvFRZkMOO3Y/pphaubY/b5H8aPt8dCRR8djdzYUpVFcgM3StcLFDRwqaZXTiYEm2I3wjdUEJW8lOzbzhatzuXqReWvHaxoDbNlfubfi2ZRoYDevtgUaDJRceB06EwnBofGd3xRdqmZSrBp0H5Kkbp2aaoW101xha8mX7NYqK8XR6UjTw5y1m8fDL+4eLvw88AjY69ImD5sb9f3raoQXUVAu65nTTrR4PKKYhiK+yWw5z7LcFblw6YjnmaDrc3D0P4ZpWjquOnK3Rm6NBHsuo7o9Al1JjbBexDSA+CnkXjgPl0tIkbY9GdJgOH9U9054XwD9Dry38jHgPzs9dYZbS3L5V+SGnX7kuwV+ixy5kGETFl0zUwsPDITr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(39850400004)(396003)(346002)(91956017)(66556008)(66946007)(66476007)(83380400001)(110136005)(64756008)(316002)(66446008)(54906003)(76116006)(31686004)(966005)(2616005)(85202003)(186003)(6512007)(66574015)(71200400001)(86362001)(15650500001)(6506007)(5660300002)(7416002)(36756003)(31696002)(8936002)(478600001)(53546011)(4326008)(85182001)(8976002)(26005)(8676002)(6486002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RDA4aG01TlFGQ2NXRnpOQzI0RUdTVVNPMTN1aVpZU0pxVXVFakJ3eUZjSlJF?=
 =?utf-8?B?M25kUnM0V0swUVhIS3I5aUorbkIrUHhONFFSZ1N3QmZwUXdMOThPYXYvMkZt?=
 =?utf-8?B?alk0cFZjaVcxNjM0dndORldGSHBRMmNFVklZNkZ3SjdMNDBWV2k0cFY5Qitx?=
 =?utf-8?B?c1JIL0hyMEhEcDlIS2lIMzlVTnMvTkNUMXREOWtBYlp6ekh3NmRTRFQxOEpK?=
 =?utf-8?B?T0NIOWt6WStFZ1Q2WllSOGJOQTYvdkVaQlAzZm9NWDVPT3hsYTlLWFFjVndF?=
 =?utf-8?B?Wmt0SC9HVSsyMzlwM1FXcjN3VDRnNVRhRW5sMFVkc2dWcU1YaU0ydlp5eitP?=
 =?utf-8?B?czJiY0taek51Ymx1VFY0SVNUbFdqYUE5S0RscEpEOGhTcUgzdW9ORExxL1dO?=
 =?utf-8?B?Um1VM1U0cVNoVm1vQkJoQWZtakNnOHNlak5XQU5aUW9GTnRHbmVLNFlkWHlH?=
 =?utf-8?B?RXBvRHpiTWdUTmVMVUFhNCtYSmk1VU9iTm53L2N6cDB5MzFHdzBjVVp5VGJQ?=
 =?utf-8?B?Vy9YSkxoOEdMTkRkMkRJNXRxNGtDYm9mZlhzRGpLMTVObko1LzBreERZeWRI?=
 =?utf-8?B?dkJnTnR6bFAwUnRDZkJTQXc5T3NpRHRCQkxuenI2NjFYbUgveHlvME16NHZz?=
 =?utf-8?B?UUVEMzdvTy9iMGg5YmVzK21oM2FYSUhEQkgzZnpDS21sYnhrSUFzUDA4Tndn?=
 =?utf-8?B?WWZmblZUL1N4dDI2ZCtnZmQ0NDlxcDlYYjlUSXI0RXUzS0tDdTVxaHYyMmpD?=
 =?utf-8?B?bVN4WFRxR1VidzRldWJkMlNOSXpreERiY3RjeGtrSHlyWW01UWI4c1B0ZXJv?=
 =?utf-8?B?Z1pqbWlPL0RqYVhKZDZ3NmpHN0NEcUpOZ0ZpTFk2MGpZbHZpY1p2cFcrbk9a?=
 =?utf-8?B?ZzNZMWZFbnlZblhFOGoxMlArb2FXRWd1K1Jpa0lqMk5HZ1pFV0l0cXY1WmtL?=
 =?utf-8?B?NDV4OCsycTJOUnpCc2pjYUJHMjdCNytaaUFCOHp5aEo3ZTVlNnBNSFAyeWFO?=
 =?utf-8?B?RENQcTN2Nk9hTS9iemF1VStxdCtkVUdvQXJmUWtVRXRyQ012bU0vdGxVVDds?=
 =?utf-8?B?T25YY0MyK1V6VHdRSVVKZEtCaWZSeUVSNXJUbDh2Y2EwajUyQzlHNFVsMFJt?=
 =?utf-8?B?SXRxUk5ZS1FXZzV5eDV1VjlDWEtBYXNJNXVCYjJOM29QUUJabXFaM09rUnRB?=
 =?utf-8?B?RzdqaXlIRHlBUWdGdmo2Zklsa29ZUGc0c0NiWS8zNmlzU0cxZlhKQVRjZEhO?=
 =?utf-8?B?MTRMeGN6U0tPUXZWMW5leDUwSVVlcURtdWswQmM5M3FsTGkyZ1pmOHJUTXVk?=
 =?utf-8?Q?eR5oqIcdtmQtzsxo3sShmoHFzcKCo2SFD9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1ACE20C6A0266440B6158520B58DA764@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ccdcdf-0634-490d-05e7-08d8b965eddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2021 14:57:50.5135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9C/Momc7nSaWz9l1FdLsj6e5kdXeKOBUeSrwnrkALUT2anIuS50ROUCKsGFLFdnV5l57lJvt3KRCw9T+d80gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB2816
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

SGkgQXJlbmQsDQoNCk9uIDEvMTUvMjEgMzoxMCBQTSwgQXJlbmQgVmFuIFNwcmllbCB3cm90ZToN
Cj4gKyBKb2hhbm5lcw0KPiAtIG5ldGRldnMNCj4gDQo+IE9uIDEvMTQvMjAyMSA1OjM2IFBNLCAn
QWx2aW4gxaBpcHJhZ2EnIHZpYSBCUkNNODAyMTEtREVWLUxJU1QsUERMIHdyb3RlOg0KPj4gQWRk
IHN1cHBvcnQgZm9yIENRTSBSU1NJIG1lYXN1cmVtZW50IHJlcG9ydGluZyBhbmQgYWR2ZXJ0aXNl
IHRoZQ0KPj4gTkw4MDIxMV9FWFRfRkVBVFVSRV9DUU1fUlNTSV9MSVNUIGZlYXR1cmUuIFRoaXMg
ZW5hYmxlcyBhIHVzZXJzcGFjZQ0KPj4gc3VwcGxpY2FudCBzdWNoIGFzIGl3ZCB0byBiZSBub3Rp
ZmllZCBvZiBjaGFuZ2VzIGluIHRoZSBSU1NJIGZvciByb2FtaW5nDQo+PiBhbmQgc2lnbmFsIG1v
bml0b3JpbmcgcHVycG9zZXMuDQo+IA0KPiBUaGUgbW9yZSBJIGFtIGxvb2tpbmcgaW50byB0aGlz
IEFQSSB0aGUgbGVzcyBJIHVuZGVyc3RhbmQgaXQgb3IgYXQgbGVhc3QgDQo+IGl0IHJhaXNlcyBh
IGNvdXBsZSBvZiBxdWVzdGlvbnMuIExvb2tpbmcgaW50byBubDgwMjExX3NldF9jcW1fcnNzaSgp
IFsxXSANCj4gdHdvIGJlaGF2aW9ycyBhcmUgc3VwcG9ydGVkOiAxKSBkcml2ZXIgaXMgcHJvdmlz
aW9uZWQgd2l0aCBhIHRocmVzaG9sZCANCj4gYW5kIGh5c3RlcmVzaXMsIG9yIDIpIGRyaXZlciBp
cyBwcm92aXNpb25lZCB3aXRoIGhpZ2ggYW5kIGxvdyB0aHJlc2hvbGQuID4NCj4gVGhlIHNlY29u
ZCBiZWhhdmlvciBpcyB1c2VkIHdoZW4gdGhlIGRyaXZlciBhZHZlcnRpc2VzIA0KPiBOTDgwMjEx
X0VYVF9GRUFUVVJFX0NRTV9SU1NJX0xJU1QgKmFuZCogdXNlci1zcGFjZSBwcm92aWRlcyBtb3Jl
IHRoYW4gDQo+IG9uZSBSU1NJIHRocmVzaG9sZC4gSW4gYm90aCBjYXNlcyB0aGUgc2FtZSBkcml2
ZXIgY2FsbGJhY2sgaXMgYmVpbmcgdXNlZCANCj4gc28gSSB3b25kZXIgd2hhdCBpcyBleHBlY3Rl
ZCBmcm9tIHRoZSBkcml2ZXIuIFNlZW1zIHRvIG1lIHRoZSBkcml2ZXIgDQo+IHdvdWxkIG5lZWQg
dG8gYmUgYWJsZSB0byBkaXN0aW5ndWlzaCBiZXR3ZWVuIHRoZSB0d28gYmVoYXZpb3JhbCANCj4g
c2NlbmFyaW9zLiBBcyB0aGVyZSBpcyBubyBvYnZpb3VzIHdheSBJIGFzc3VtZSB0aGUgZHJpdmVy
IHNob3VsZCBiZWhhdmUgDQo+IHRoZSBzYW1lIGZvciBib3RoIGNhc2VzLCBidXQgYWdhaW4gaXQg
aXMgdW5jbGVhciB0byBtZSB3aGF0IHRoYXQgDQo+IGV4cGVjdGVkL3JlcXVpcmVkIGJlaGF2aW9y
IGlzLg0KDQpJdCB3aWxsIG9ubHkgcHJvdmlzaW9uIHRoZSBkcml2ZXIgYWNjb3JkaW5nIHRvIGJl
aGF2aW91ciAoMSkgaWYgMCBvciAxIA0KdGhyZXNob2xkcyBhcmUgYmVpbmcgc2V0IEFORCB0aGUg
ZHJpdmVyIGltcGxlbWVudHMgDQpzZXRfY3FtX3Jzc2lfY29uZmlnKCkuIEJ1dCBpdCBzYXlzIGlu
IHRoZSBkb2N1bWVudGF0aW9uIGZvciB0aGUgDQpzZXRfY3FtX3Jzc2lfcmFuZ2VfY29uZmlnKCkg
Y2FsbGJhY2tbMV0gdGhhdCBpdCBzdXBlcnNlZGVzIA0Kc2V0X2NxbV9yc3NpX2NvbmZpZygpIChv
ciBhdCBsZWFzdCB0aGF0IHRoZXJlIGlzIG5vIHBvaW50IGluIA0KaW1wbGVtZW50aW5nIF9jb25m
aWcgaWYgcmFuZ2VfY29uZmlnIGlzIGltcGxlbWVudGVkKS4gSW4gdGhhdCBjYXNlLCBhbmQgDQpp
ZiBqdXN0IG9uZSB0aHJlc2hvbGQgaXMgc3VwcGxpZWQgKHdpdGggYSBoeXN0ZXJlc2lzKSwgdGhl
biBhIHN1aXRhYmxlIA0KcmFuZ2UgaXMgY29tcHV0ZWQgYnkgY2ZnODAyMTFfY3FtX3Jzc2lfdXBk
YXRlKCkgYW5kIHByb3ZpZGVkIHRvIA0Kc2V0X2NxbV9yc3NpX3JhbmdlX2NvbmZpZygpLiBJIGd1
ZXNzIHRoZSBpbXBsaWNhdGlvbiBoZXJlIGlzIHRoYXQgdGhlIA0KdHdvIGJlaGF2aW91cnMgYXJl
IGZ1bmN0aW9uYWxseSBlcXVpdmFsZW50LiBJJ20gbm90IHN1cmUgSSBjYW4gYXJndWUgZm9yIA0K
b3IgYWdhaW5zdCB0aGF0IGJlY2F1c2UgSSBkb24ndCByZWFsbHkga25vdyB3aGF0IHRoZSBzZW1h
bnRpY3Mgb2YgdGhlIA0Kb3JpZ2luYWwgQVBJIHdlcmUgc3VwcG9zZWQgdG8gYmUsIGJ1dCBpdCBz
ZWVtcyByZWFzb25hYmxlLg0KDQpBcyBhIHN0YXJ0aW5nIHBvaW50IC0gYW5kIHNpbmNlIHRoZSBm
aXJtd2FyZSBiZWhhdmlvdXIgaXMgdmVyeSBjbG9zZSANCmFscmVhZHkgLSBJIGltcGxlbWVudGVk
IG9ubHkgc2V0X2NxbV9yc3NpX3JhbmdlKCkuIEkgaGF2ZSBiZWVuIHRlc3RpbmcgDQp3aXRoIGl3
ZCwgd2hpY2ggYnkgZGVmYXVsdCBzZXRzIGp1c3QgYSBzaW5nbGUgdGhyZXNob2xkIGFuZCBoeXN0
ZXJlc2lzLCANCmFuZCB0aGUgZHJpdmVyIHdhcyBzZW5kaW5nIG5vdGlmaWNhdGlvbnMgYXMgd291
bGQgYmUgZXhwZWN0ZWQuDQoNClsxXSANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y1LjEwLjcvc291cmNlL2luY2x1ZGUvbmV0L2NmZzgwMjExLmgjTDM3ODANCg0KPiANCj4gV2l0
aCBiZWhhdmlvciAyKSBzb21lIHByb2Nlc3NpbmcgaXMgZG9uZSBpbiBjZmc4MDIxMSBpdHNlbGYg
YnkgDQo+IGNmZzgwMjExX2NxbV9yc3NpX3VwZGF0ZSgpIHdoaWNoIGlzIGNhbGxlZCBmcm9tIG5s
ODAyMTFfc2V0X2NxbV9yc3NpKCkgDQo+IHVwb24gTkw4MDIxMV9DTURfU0VUX0NRTSBhbmQgY2Zn
ODAyMTFfY3FtX3Jzc2lfbm90aWZ5KCkgY2FsbGVkIGJ5IA0KPiBkcml2ZXIuIElmIEkgbG9vayBh
dCB0aGF0IGl0IG1hdGNoZXMgcHJldHR5IGNsb3NlIHdoYXQgb3VyIGZpcm13YXJlIGlzIA0KPiBk
b2luZy4gVGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBvdXIgZmlybXdhcmUgYXZvaWRzIFJTU0kgb3Nj
aWxsYXRpb24gd2l0aCANCj4gYSB0aW1lIGNvbnN0cmFpbnQgYmV0d2VlbiBSU1NJIGV2ZW50cyB3
aGVyZWFzIGNmZzgwMjExIHVzZXMgdGhlIGh5c3RlcmVzaXMuDQoNCiBGcm9tIHdoYXQgSSBnYXRo
ZXJlZCwgdGhlIHNldF9jcW1fcnNzaV9yYW5nZV9jb25maWcobG93LCBoaWdoKSBBUEkgDQpzaG91
bGQgY29uZmlndXJlIHRoZSBkcml2ZXIgdG8gc2VuZCBhIExPVy9ISUdIIGV2ZW50IHRvIGNmZzgw
MjExIA0Kd2hlbmV2ZXIgdGhlIFJTU0kgaXMgb3V0c2lkZSBvZiB0aGUgcmFuZ2UgW2xvdywgaGln
aF0uIGNmZzgwMjExIHNlZW1zIHRvIA0KdGFrZSBjYXJlIG9mIGhvdyB0byBkZWFsIHdpdGggbXVs
dGlwbGUgdGhyZXNob2xkcyB0aGVuIGJ5IGNhbGxpbmcgYmFjayANCmludG8gX3JhbmdlX2NvbmZp
ZyBmcm9tIGNmZzgwMjExX2NxbV9yc3NpX25vdGlmeSgpIHRvIHJlYWRqdXN0IHRoZSANCnJhbmdl
LiBJIGNvdWxkIGJlIG92ZXJzaW1wbGlmeWluZyB0aGluZ3MgdGhvdWdoIGFuZCBJIHdvdWxkIGJl
IGdsYWQgdG8gDQpnZXQgc29tZSBjbGFyaWZpY2F0aW9uLg0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZp
bg0KDQo+IA0KPiBTbyBiZWZvcmUgbW92aW5nIGZvcndhcmQsIEkgaG9wZSBKb2hhbm5lcyBjYW4g
Y2hpbWUgaW4gYW5kIGNsYXJpZnkgDQo+IHRoaW5ncy4gQWRkZWQgdGhlIGNvbW1pdCBtZXNzYWdl
IGludHJvZHVjaW5nIHRoZSBleHRlbmRlZCBmZWF0dXJlIGJlbG93LiANCj4gSXQgbWVudGlvbnMg
YmFja3dhcmQgY29tcGF0aWJpbGl0eSwgYnV0IGl0IG9ubHkgY29uc2lkZXJzIHRoZSBleHRlbmRl
ZCANCj4gZmVhdHVyZSBzZXR0aW5nIHdoZW4gdXNlci1zcGFjZSBwcm92aWRlcyBtb3JlIHRoYW4g
b25lIHRocmVzaG9sZC4gDQo+IEhvd2V2ZXIsIHdoZW4gdGhlIGRyaXZlcnMgc2V0IHRoZSBleHRl
bmRlZCBmZWF0dXJlIGlzIGV4cGVjdHMgKGxvdywgDQo+IGhpZ2gpIGFuZCAodGhyZXNob2xkLCBo
eXN0ZXJlc2lzKSBpZiBub3QuIFNvIGl0IHNlZW1zIHRoZSBleHRlbmRlZCANCj4gZmVhdHVyZSBz
aG91bGQgaGF2ZSBwcmVjZWRlbmNlIG92ZXIgdGhlIG51bWJlciBvZiB0aHJlc2hvbGRzIHByb3Zp
ZGVkIGJ5IA0KPiB1c2VyLXNwYWNlLg0KPiAgPiBSZWdhcmRzLA0KPiBBcmVuZA0KPiANCj4gWzFd
IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xMC43L3NvdXJjZS9uZXQv
d2lyZWxlc3Mvbmw4MDIxMS5jI0wxMTQ3OSANCj4gDQo+IA0KPiAtLS04PC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IGNv
bW1pdCA0YTRiODE2OTUwMWIxOGMzNDUwYWM3MzVhN2UyNzdiMjQ4ODZhNjUxDQo+IEF1dGhvcjog
QW5kcmV3IFphYm9yb3dza2kgPGFuZHJldy56YWJvcm93c2tpQGludGVsLmNvbT4NCj4gRGF0ZTrC
oMKgIEZyaSBGZWIgMTAgMTA6MDI6MzEgMjAxNyArMDEwMA0KPiANCj4gIMKgwqDCoCBjZmc4MDIx
MTogQWNjZXB0IG11bHRpcGxlIFJTU0kgdGhyZXNob2xkcyBmb3IgQ1FNDQo+IA0KPiAgwqDCoMKg
IENoYW5nZSB0aGUgU0VUIENRTSBjb21tYW5kJ3MgUlNTSSB0aHJlc2hvbGQgYXR0cmlidXRlIHRv
IGFjY2VwdCBhbnkNCj4gIMKgwqDCoCBudW1iZXIgb2YgdGhyZXNob2xkcyBhcyBhIHNvcnRlZCBh
cnJheS7CoCBUaGUgQVBJIHNob3VsZCBiZSBiYWNrd2FyZHMNCj4gIMKgwqDCoCBjb21wYXRpYmxl
IHNvIHRoYXQgaWYgb25lIHMzMiB0aHJlc2hvbGQgdmFsdWUgaXMgcGFzc2VkLCB0aGUgb2xkDQo+
ICDCoMKgwqAgbWVjaGFuaXNtIGlzIGVuYWJsZWQuwqAgVGhlIG5ldGxpbmsgZXZlbnQgZ2VuZXJh
dGVkIGlzIHRoZSBzYW1lIGluIGJvdGgNCj4gIMKgwqDCoCBjYXNlcy4NCj4gDQo+ICDCoMKgwqAg
Y2ZnODAyMTEgaGFuZGxlcyBhbiBhcmJpdHJhcnkgbnVtYmVyIG9mIFJTU0kgdGhyZXNob2xkcyBi
dXQgZHJpdmVycyANCj4gaGF2ZQ0KPiAgwqDCoMKgIHRvIHByb3ZpZGUgYSBtZXRob2QgKHNldF9j
cW1fcnNzaV9yYW5nZV9jb25maWcpIHRoYXQgY29uZmlndXJlcyBhIA0KPiByYW5nZQ0KPiAgwqDC
oMKgIHNldCBieSBhIGhpZ2ggYW5kIGEgbG93IHZhbHVlLsKgIERyaXZlcnMgaGF2ZSB0byBjYWxs
IGJhY2sgd2hlbiB0aGUgDQo+IFJTU0kNCj4gIMKgwqDCoCBnb2VzIG91dCBvZiB0aGF0IHJhbmdl
IGFuZCB0aGVyZSdzIG5vIGFkZGl0aW9uYWwgZXZlbnQgZm9yIGVhY2ggDQo+IHRpbWUgdGhlDQo+
ICDCoMKgwqAgcmFuZ2UgaXMgcmVjb25maWd1cmVkIGFzIHRoZXJlIHdhcyB3aXRoIHRoZSBjdXJy
ZW50IG9uZS10aHJlc2hvbGQgQVBJLg0KPiANCj4gIMKgwqDCoCBUaGlzIG1ldGhvZCBkb2Vzbid0
IGhhdmUgYSBoeXN0ZXJlc2lzIHBhcmFtZXRlciBiZWNhdXNlIHRoZXJlJ3Mgbm8NCj4gIMKgwqDC
oCBiZW5lZml0IHRvIHRoZSBjZmc4MDIxMSBjb2RlIGZyb20gaGF2aW5nIHRoZSBoeXN0ZXJlc2lz
IGJlIGhhbmRsZWQgYnkNCj4gIMKgwqDCoCBoYXJkd2FyZS9kcml2ZXIgaW4gdGVybXMgb2YgdGhl
IG51bWJlciBvZiB3YWtldXBzLsKgIEF0IHRoZSBzYW1lIHRpbWUNCj4gIMKgwqDCoCBpdCB3b3Vs
ZCBsaWtlbHkgYmUgbGVzcyBjb25zaXN0ZW50IGJldHdlZW4gZHJpdmVycyBpZiBvZmZsb2FkZWQg
b3INCj4gIMKgwqDCoCBkb25lIGluIHRoZSBkcml2ZXJzLg0KPiANCj4gIMKgwqDCoCBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXcgWmFib3Jvd3NraSA8YW5kcmV3LnphYm9yb3dza2lAaW50ZWwuY29tPg0K
PiAgwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50
ZWwuY29tPg0KPiA=
