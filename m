Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172624676AA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 12:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380518AbhLCLpb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 06:45:31 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.140.77]:62488 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLCLpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 06:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1638531725; x=1639136525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s1pYeitpERugWcivjRRCm2tCC1pbIp+k68e6hn1rCGQ=;
  b=rYJtV2KnShuhlKmY/V8DLnyXXOJxLSreS06NOTrp/O9XGmLaA74UFcK5
   nLyjTe/uqgkWNX44E5+ASDC8Y5TJ46y9Q0STT78rBHp37m8MQ68pNr+N3
   q3nXWao3Y7FCCiBxpC2gOnIDrZe4Z6VV3xPu9iSnO3FVkrpdYfYwRYq10
   g=;
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loQChumbPXW+Hr/A83d7PFpUYBQ8QqW9WuI3wS7qxxVGNHYMRu0UY5klLF0rWqVv+Wu4eF810E65bFAPaFQC5CFrAJ6jjp36HcmYKFua9AvbaXUhEYXAFvjE5e3gIl/t4OzijV3g2Uo8Lz198HocsLpQped8CMH7hJKTwF6r7+iMYtHEde4ckaf4JJGLpA2vOZkxi9RwcT32f+OdAdGk0KksMVJRCP5SOZb1qLhpdNVixPvgAFKeFvrAigrEBBGM7bT/LZeuGTKr/gvkB/+IxpQQv7umGkJ35n8ABnB0RT4VcMKB7n9hFdIlRcg3UKyBNNC982K5tu9bi2ORCiCLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1pYeitpERugWcivjRRCm2tCC1pbIp+k68e6hn1rCGQ=;
 b=Eh4PmlIu0/yrgM6onztkZfmbW1khQagUTA4a+u4hhGWARL+cZwgWGfTRXvYaILRlhCLGs/Dk0sKgVIzwk4DMoDQC5edDlUgfJMnuWr3tAhWIbetdFe0+hcjP8vwLdc3D4/Aon/Y5vcIKZDtG/0poStWXvjj031hSPZkIZ6ZOwZ6kvztZyMBBqZ37NrKnu3jJHNsTjdeb3xTq/sfL6bK0Hwd/apaKM5ZSPyfdAH/aZX/tgrCNb2plX9evMHfU/86cWsHsY1sD2dru59sY76F/Hyaqoq7SLEgyyxIDARq148aI9wQbyDwOtEeKtGULjdFD0BAXGZoh/28WphxEHGQjOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 DM6PR02MB5002.namprd02.prod.outlook.com (2603:10b6:5:4f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.24; Fri, 3 Dec 2021 11:42:03 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::28da:19ab:735d:d442]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::28da:19ab:735d:d442%6]) with mapi id 15.20.4734.024; Fri, 3 Dec 2021
 11:42:03 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: RE: [PATCH] mac80211: disable BSS color collision detection in case
 of no free colors
Thread-Topic: [PATCH] mac80211: disable BSS color collision detection in case
 of no free colors
Thread-Index: AQHX6AAslqznWr8AlEqfIDAqDVMsZqwgaewAgAA7oxA=
Date:   Fri, 3 Dec 2021 11:42:03 +0000
Message-ID: <DM6PR02MB49375D43B73E14EC6B0E5754E96A9@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
 <3a4fc4398a5dfe03933de8d695a8b605d700a94b.camel@sipsolutions.net>
In-Reply-To: <3a4fc4398a5dfe03933de8d695a8b605d700a94b.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a75ce969-44ca-4cbc-df30-08d9b651ecd0
x-ms-traffictypediagnostic: DM6PR02MB5002:
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB5002D71AF19CFF3FE716C5E7956A9@DM6PR02MB5002.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hxXAeqGEfTNEvsiociCTBMOtPRQQLJBUTTJsRIdWq2LdMo4IiznlpdZtOJnu2Z61Chi4ZIIFIhGVOkBvbP/rvX9aM6V1oz4FCMjWRz+2vYl9dfEJpMuXObSfr6pz1sX6mC2ea0br17QFCxN2fEW+sQO4ALEEp2KaCzNypryy57bbTFar44OmTVn3y8I760whmZLuDwPPOvTK8EPepUeWp7PoJUMc3ul1eHTlmp5KaHXyXLj+p3fDNumKVyJW/wzDsM9M/MJUlDLcK908nrCOhNt+tgR2MLFANnACHtfwPkodrjqzrRHsBY0Ck8OFHjb71d8V5NyipdokZTKqT+z6VvNFyeMxd5Vdk746188SGeJJSPKJGgfzxuCN25OAvsHoPWaqNVGiCTMabFsyrp7Q1lAg6FWKjVwlz5xAVViJjnjA5XWGPJvWv0MhVoGuuyodvIDO1UpSrTuBA5asrTHSeJaw1mehWcW7NcJgMw519jdbcF/S54Ci6NYGrJfl3BvgrnsM0mjAE0NsU9Ri5m5hHydJj+S6NEMsa06/z5+sdZzwaMvB9gnB7FLVe1nwwnnpLlMCMgmzt2AxEG+wtKX7flGkP1QhlaiHw8/KntBaQAJGHEiMXDxaCB0SiP8ByErK4+XImPYI4qoisplwEUzjzpnw9Pw/Wg6lxjJ7DWlNczHe3SD4jfrUapOXdSCRn25705QLYE4T1FyeO/pBYE9pGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(122000001)(66476007)(66946007)(4326008)(66446008)(83380400001)(5660300002)(2906002)(508600001)(110136005)(52536014)(76116006)(64756008)(316002)(54906003)(66556008)(71200400001)(33656002)(6506007)(55016003)(38070700005)(53546011)(26005)(86362001)(8936002)(7696005)(186003)(38100700002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBTLzRKem11L016OVZHOWg0SzB5UHN2TExTWjRXbnlIOXNwa0lLVGdPUmVT?=
 =?utf-8?B?K3hjeW9OU2UrZmdMcXJiT3dtK25xUjBlNHpwRFFOUnRNdlM1OWk5eEJwdzh3?=
 =?utf-8?B?MUM5L2t3VUc2cmVNZHVucUF4Y1VYRnVwTDVGWHhZSHhwYUtZUDcyYmdxNDFv?=
 =?utf-8?B?eEV1cVhUSDgrZGNQTGFjd04yM01Na1lWYnRBZE9NSGZhdldSYjllWkFhcExa?=
 =?utf-8?B?cHN0VzZHS3VyK3JpbFRzNEdIOUg0T1FSMnk3a0plRFJ5dGZRWkpuWW1TeUUw?=
 =?utf-8?B?T2ttcUM5V2xKQ1VvTnBFL25SRWZnQTF0ZEVtbFVacyttV1ZXb0FqTUNmV01y?=
 =?utf-8?B?WmlRNnhPc1VLVko3QXBxUXkwQndsLzFtSjl6THZ0VFp1Qm5ObVU4ZjY0VElE?=
 =?utf-8?B?QUI2ZE9XNUdqc0hvL0M0VllaL3dBS092aUZDcUc0RWlOOEl5VGJYNHB6SThP?=
 =?utf-8?B?Nk12SEF4TFAwOWQ5dFNnUE1lQmk5WGg4YmpLS2FCWjFaZnhBUmR1Zzd6S3pR?=
 =?utf-8?B?RENteWNMUUpYZWZtK3dFZXBWdjRGQW9KYzJTQTVteHZEVGJFa2ZOMm03c1Ux?=
 =?utf-8?B?dkY5bWJvdkt3ejBTUTkzdXJlaFJtbmJYSHl2NDRwVjlOWjJjR1o5MC83NkMy?=
 =?utf-8?B?YjNrOXZYUmxOenYzalN2b3ZocjZ4Q3VJRzNRUFVpUXRTMDBqYkJtaDg5QlAv?=
 =?utf-8?B?ZGxaQXo1bUxJWEdueGswcW1QRXFKYUp4disraldvdTlvTnRyTzRjM3hNcjJH?=
 =?utf-8?B?aXlSVlcxeEtSUSs0RmhXNHZ4VzBQQXlqSVN4cGdWNS8vNzkwTnlRS0gzeXZE?=
 =?utf-8?B?bFNiY0MvK29HdVhsN3hpbVBZRUVzL0RJeTFxRldrQ1Ura1VrcXhqdy9IVTVs?=
 =?utf-8?B?aWwwQzJZclJSUEt6TUZ4U1lqQy91Q0Uwa2JhcWpKc0J4c3ZuOFFQY2tHdWN1?=
 =?utf-8?B?V2s4Sm1kb1QzdEtjeEtVR3RDZUJzd0xWUnQzSFo4YlJQUUIrYlA2Qmg4SGs4?=
 =?utf-8?B?VUVlM3VhNzJTcHFJWFIzNitwM2FGYW1FZDBuRjdwZGo1TkErWGVYMk1TV0ll?=
 =?utf-8?B?eFhZMXBHbFNob3dvTjFQbWpINjRETEdKMTVFTVc2ZmtOZFlCL3g2KzVRMWkz?=
 =?utf-8?B?bUtUdXQ2eTNlL0o5MWxBbXEvcG1kL1lOZ2VVMXMxQjZsRnhsV0JQcmdQRVhF?=
 =?utf-8?B?bnVsQzY0V095c1dWSkxTSGFuSHFHeENZYUlhK1lyeDFUcTVQeGFVRlJGS0wy?=
 =?utf-8?B?S3FpVmMzU2xUSXlnSmRrLzBqOUlOR3N4dzIxZ0MvbEhoWHJ4SWFNV3IzbExt?=
 =?utf-8?B?MVp3N1krbElIV1Y5WXROeElzREowK3ZrdUFjTzltUzl6VUdzSkw0WnZmdEp3?=
 =?utf-8?B?QkcwZGtXV3BmcUVQWjlYZTI4MExHTTNuVWQwaVRvalo0NkxPWTRQU2NZWVpU?=
 =?utf-8?B?OHVoL1E3NEhSWjQ1b2k0ZDRld2R2Sk5VcXd3MVVsb0k4NjIyMjA4MnNaTUNm?=
 =?utf-8?B?V00yYTRGOFBiUFZ0MEtlSy9LWHV3WVBtVFlGaFIrcGRCRDNzSDBzc2FKZ01o?=
 =?utf-8?B?V09mV2FGMTgwT3U0Vlhlc0crb1pnTmNjNDQwVlM1VXJ3c09waEd5WUo3TE9j?=
 =?utf-8?B?QlRXRW9LeE0zS2c0bjVqcXJSR0Y3Z25PdUNuZ3JQTndMN1AzVzhzcE9Qa2Uy?=
 =?utf-8?B?UW0wcmNTMjM2UTEvWGVFYnJjSUZvRzJOb3RYOXAvcnJoUlU0L09oeFhZbnNS?=
 =?utf-8?B?UHZ2b3Q1Q2JtUGoxd2JVY3kwbEFJMWtLeVpSaEVhUUVLTmRPWHVlQ1RSUzda?=
 =?utf-8?B?dkY0Zkp1eWZJZlFKOC9ZZ2dKSDFaRUYwUHhPTC91K3dveWcyc3Y4QkhmTlFj?=
 =?utf-8?B?V1MzT0NRSjJhQTdnYjFVZTA3dTVzTUh6WWIvWUE3K2ZYZFlqcFpJVlRNWm9L?=
 =?utf-8?B?cmhreTdEelJ6V0tJQkhhTGRNNERZVW1YY1dZQ2ZYWG5OS2xDaW1YZFNMd0Ex?=
 =?utf-8?B?azFOZVYxMzdJVjlYMmJDeCtzTVZNeUFvNWsxN1dRRnZEUzBQYmRmbElEWFRD?=
 =?utf-8?B?UW5yeVpVaVBKQ0l3SmJPRE40akhHMVZYRythM2lCUUZSRE80WDA5VVFkdXNO?=
 =?utf-8?B?YWFiRmtXUXJIN1MwR2pVSHQ0dVc0MS9IZ1RzR1lZUDlXK1RycTMzYTQ1RUxZ?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a75ce969-44ca-4cbc-df30-08d9b651ecd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 11:42:03.0803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7tDmqSHZmQtvPygB72Ytho2AgdzoiAOVoM3g6lSXUHIOumhd5lF/Jr+5bru0bKtDHWaWp62bt5272PSG562Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5002
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMywgMjAy
MSAxOjM5IFBNDQo+IFRvOiBSYW1lc2hrdW1hciBTdW5kYXJhbSAoUVVJQykgPHF1aWNfcmFtZXNz
QHF1aWNpbmMuY29tPg0KPiBDYzogbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOyBMYXZh
bnlhIFN1cmVzaA0KPiA8bGF2YWtzQGNvZGVhdXJvcmEub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBtYWM4MDIxMTogZGlzYWJsZSBCU1MgY29sb3IgY29sbGlzaW9uIGRldGVjdGlvbiBpbiBj
YXNlDQo+IG9mIG5vIGZyZWUgY29sb3JzDQo+IA0KPiBPbiBGcmksIDIwMjEtMTItMDMgYXQgMTA6
MTEgKzA1MzAsIFJhbWVzaGt1bWFyIFN1bmRhcmFtIHdyb3RlOg0KPiA+DQo+ID4gKysrIGIvbmV0
L21hYzgwMjExL2NmZy5jDQo+ID4gQEAgLTk5NSw2ICs5OTUsOCBAQCBzdGF0aWMgaW50IGllZWU4
MDIxMV9hc3NpZ25fYmVhY29uKHN0cnVjdA0KPiBpZWVlODAyMTFfc3ViX2lmX2RhdGEgKnNkYXRh
LA0KPiA+ICAJc3RydWN0IGJlYWNvbl9kYXRhICpuZXcsICpvbGQ7DQo+ID4gIAlpbnQgbmV3X2hl
YWRfbGVuLCBuZXdfdGFpbF9sZW47DQo+ID4gIAlpbnQgc2l6ZSwgZXJyOw0KPiA+ICsJY29uc3Qg
dTggKmNhcDsNCj4gPiArCXN0cnVjdCBpZWVlODAyMTFfaGVfb3BlcmF0aW9uICpoZV9vcGVyID0g
TlVMTDsNCj4gPiAgCXUzMiBjaGFuZ2VkID0gQlNTX0NIQU5HRURfQkVBQ09OOw0KPiA+DQo+ID4g
IAlvbGQgPSBzZGF0YV9kZXJlZmVyZW5jZShzZGF0YS0+dS5hcC5iZWFjb24sIHNkYXRhKTsgQEAg
LTEwODIsNg0KPiA+ICsxMDg0LDI3IEBAIHN0YXRpYyBpbnQgaWVlZTgwMjExX2Fzc2lnbl9iZWFj
b24oc3RydWN0DQo+IGllZWU4MDIxMV9zdWJfaWZfZGF0YSAqc2RhdGEsDQo+ID4gIAkJY2hhbmdl
ZCB8PSBCU1NfQ0hBTkdFRF9GVE1fUkVTUE9OREVSOw0KPiA+ICAJfQ0KPiA+DQo+ID4gKwlpZiAo
c2RhdGEtPnZpZi5ic3NfY29uZi5oZV9zdXBwb3J0KSB7DQo+ID4gKwkJY2FwID0gY2ZnODAyMTFf
ZmluZF9leHRfaWUoV0xBTl9FSURfRVhUX0hFX09QRVJBVElPTiwNCj4gPiArCQkJCQkgICBwYXJh
bXMtPnRhaWwsIHBhcmFtcy0+dGFpbF9sZW4pOw0KPiA+ICsJCWlmIChjYXAgJiYgY2FwWzFdID49
IHNpemVvZigqaGVfb3BlcikgKyAxKQ0KPiA+ICsJCQloZV9vcGVyID0gKHZvaWQgKikoY2FwICsg
Myk7DQo+ID4NCj4gDQo+IEknbSBub3Qgc3VyZSBJIGxpa2UgdGhpcyBtZWNoYW5pc20gLSBpbiBp
ZWVlODAyMTFfc3RhcnRfYXAoKSB3ZSBleHBsaWNpdGx5IHRha2UNCj4gaXQgZnJvbSB0aGUgcGFy
YW1ldGVycyBnaXZlbiB2aWEgbmw4MDIxMSwgc28gaXQgZmVlbHMgdGhlIHNhbWUgc2hvdWxkIGJl
IHRydWUNCj4gaGVyZS4gV2h5IGlzbid0IGl0IGRvbmUgdGhhdCB3YXk/DQoNClRoaXMgaXMgYmVj
YXVzZSBpbiB0aGlzIGNhc2Ugb25seSBiZWFjb24gd2lsbCBjaGFuZ2UgYW5kIGluIG5sODAyMTFf
c2V0X2JlYWNvbigpDQp3ZSBkb27igJl0IHBhcnNlIE5MODAyMTFfQVRUUl9IRV9CU1NfQ09MT1Ig
YXR0cmlidXRlIG9yIGRvIG5sODAyMTFfY2FsY3VsYXRlX2FwX3BhcmFtcygpDQo+IA0KPiAoQW5k
IGlmIHdlIGRlY2lkZSBpdCBzaG91bGQgYmUgdGhpcyB3YXkgdGhlbiB5b3Ugc2hvdWxkIGJlIHVz
aW5nIGEgbmV3DQo+ICJjb25zdCBzdHJ1Y3QgZWxlbWVudCAqY2FwIiBpbnN0ZWFkIG9mICJjb25z
dCB1OCAqY2FwIiwgd2l0aCB0aGUgYmV0dGVyDQo+IGhlbHBlcnMgZnVuY3Rpb25zIGV0Yy4pDQo+
IA0KU3VyZSBjZmc4MDIxMV9maW5kX2V4dF9pZSgpIHJldHVybnMgY29uc3QgdTggKiwgeW91IHdh
bnQgbWUgdG8gdXNlIGNmZzgwMjExX2ZpbmRfZXh0X2VsZW0gaW5zdGVhZCAoaS5lLiBsaWtlIGhv
dyBubDgwMjExX2NhbGN1bGF0ZV9hcF9wYXJhbXMoKSBkb2VzID8NCg0KPiBqb2hhbm5lcw0K
