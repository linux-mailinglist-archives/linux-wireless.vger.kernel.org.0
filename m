Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00615630CD
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiGAJ6R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 05:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiGAJ6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 05:58:16 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD87BE38
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656669494; x=1657274294;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tWEgjyzj9Ks5S6p09rIO2B51St5r6PyvbxpdmSkNUKM=;
  b=bQz6ToHLTBbU6gNamCmaSBMEF2wcfa3NSGUJudCRINqnQy8dZVvumSx0
   ZdgmtNKWyXQ8/O1WRgYg/b+OuhGk8Lglj9uo4iCcj54LRNf+mNQACmGM2
   8RyH+U2X6mgNFj6NvxJ2r0to6ZeQFMjvZ0fa2WLHwWa0NEgufQzYa1VGG
   0=;
Received: from mail-bn1nam07lp2047.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.47])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 09:58:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URwnPNf98/mb6LaMTnYoVNyWqmqYwQ+OZMgWl6zwtCOP62tFmJHLEDuM6cWLcXzEKi6Xf36DA89gsvdqAd83XsiolXj4xmM/6p5ghaSsTOC/4B7ziNDBxAg5bipGSW2SCSrpOiimFpOfdBxZ4FuXtmdd6+g69njfY/BqtksvnrCw4Fua8kA6hAOlyZrmceY4w6P63Mm+fTs2Z3vlhvgwvouXIUU2IKtoy3fmGFUmSpHZdHBQpZMQAs0LdryFz6wDCcId954UsCcvSOukGksXk++uaP+Mvk9CS/wQv52/N4rxYjuJRJXfvHt5wlzRV+USFpdwAF8iyCRlSNpQ/Vmncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWEgjyzj9Ks5S6p09rIO2B51St5r6PyvbxpdmSkNUKM=;
 b=FosjWWvr5qrwDwyapmXXq1ZoMtXB99VWG2FJtJh4Dl4kn0HwmV9v20PkH3yCL6vMd6FcNGDYIQbOe2BxL32NJ1a4B5JfT2FXpks6+CUVmOfEfWrPn8qHEacVBs+axfjvi+eeEERkP9GcNdVE1F3XKIjjosMs5RB6C+2K/EoIqr5ag1ua4+aAPvx2hm1ZqL9hpFL/8gcmVZkqhg9EwsgaSY9MGFUt6oJo0RJPd4vaMTN+gnJjgKuKDLKtBcMPtq6HboxaVopG1KwkM5J1DRtYfy/vQck26U8eMozyJiylgMGHew4sa0qky4Rt5vbeRmroFcbTFKwWXrtVTM8kIkkdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by SN6PR02MB4798.namprd02.prod.outlook.com (2603:10b6:805:90::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 09:58:11 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7%7]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 09:58:11 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "nbd@nbd.name" <nbd@nbd.name>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/3] Mesh Fast xmit support
Thread-Topic: [PATCH 0/3] Mesh Fast xmit support
Thread-Index: AQHYfLaXMbJihDi2mEOB7VV8wA6h161pVU0AgAAGcSCAAARXgIAABBPw
Date:   Fri, 1 Jul 2022 09:58:11 +0000
Message-ID: <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
         <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
         <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
In-Reply-To: <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a275a631-c0ca-4c73-3acc-08da5b483504
x-ms-traffictypediagnostic: SN6PR02MB4798:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3MiWtjr4ECpB0VqUAnuYF0nbIYfSsp76qbIuHgqC8HNmumqlYOowf9kU7C9FliLFKrmVx73D4tqtuXXCXLqdfvS0ViZO9UrFi0cZzHqQpWVWQOqAEYvNT1FljVKoCEYagVCwwowQ+8X6rzsmJCAEn1gHRt1umety0ylPRRtWfqokxh+3G8S4Sy8yiyLfCW6cLIwx4Usurl0bpGuQR4hVFoNydiKbKSg+nyh7YBIxq9wwkO0eDs2vJAgYJwUxtjW5TmhIwQa/yICdzNkhvZozRj6YlrrgTx3xK1yOoTDxgun1yv0DrPNc6hsyEJ76YnJq+ocLj9UIu1mFxc3NqL+yQaRkcUEQVKN8U8LBb0NmidV5ED7ZSOX6Tnqkddm+j+Obz5yVz1nEZ0HQMeE1ME7jRi16lt0EUOYTGfIr/674GpQo1q06NUdq8u9tP6FMMUMTHCR+1/i18Nh1XiQkoYI6QyAy8WKbA8O9PiPNqc1dVpBvfJXmfsa4xyre7eK260HTUrTBbhulobB4wEFot/Mz5J2uK6MYpo8luOqYYTEj3HKSa67m9H7yNCzxReRncVT51vPwEaSohSPiLStjBBSFUOrpPd92YAVe7OGO6kZf/Ny739ypd4aqNMdkk1EAPy+s0JwUo6CxmSTE5KLXOp43wWIMBQIm8QUbjqRX+xjZRY3G4xflTwwJUGyyzbVUgrEA7YmxCuaCODYd+spkFrknSRVw3JME2wERamEofGi4X4AZWw9wTiBANVkhjUZ6HHhmQqLWYyVuzsOrqOo8caPvgzbiSJxNUfjkV3ah91QSf+XbZfiNU+UH2Xdi8VISBGMD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(55016003)(38070700005)(86362001)(8936002)(71200400001)(26005)(9686003)(66476007)(33656002)(66446008)(64756008)(7696005)(66556008)(5660300002)(38100700002)(122000001)(6506007)(2906002)(186003)(83380400001)(316002)(52536014)(110136005)(478600001)(4326008)(76116006)(66946007)(8676002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUpmNG5ldkd5YlllM2FZcHhqUSs5T25QT2ZRcWxWVmJqOVpNT25DbGtSNGts?=
 =?utf-8?B?MnFkVHVycEZ6YjRrbVM3NUpJTExKOFVnZzZOOHBOMERrYVJhZ0kxajNlN2JG?=
 =?utf-8?B?VVdIaFBaSDY3U1Q2Y0NKeTZlMjI0U05VcklYVktUckhQL3A4OGpsellPaGNC?=
 =?utf-8?B?RlY2bnVBZnVHWmxxeDB5dFlKNzBKemF2K2hmREtmbFFGUkREaERXdmRaMWE3?=
 =?utf-8?B?bTZRbXIxYUxqRFk0c2hZS2dYVkpxRlZRY3BtSm5pU0ZyY3ZDSitXZFA1Z0pl?=
 =?utf-8?B?Q1AwYWpXam5aUWx1alNzQmRwTlhMWHRHelc5Q3E5M3NaYy80TDVrdUc0ckNR?=
 =?utf-8?B?TzM5aUw0Nnc4Y0tjY1JlcVVvWEZialdWQ09CSlpFc1puMEJ4YTRTT1YxNHhl?=
 =?utf-8?B?N0hHZWRJZjg4aStTZVNvczlWMFlvR3FnelNCeW1XZ2F0dlk1VTJreHA5R1hN?=
 =?utf-8?B?cXhveGpVQUtDeDlHOC83L2xZa0Y5L2tsMVYvK1UwYjBVTHdadmR3M1VtTy8y?=
 =?utf-8?B?NXlibGdQdEI1TlR3ZjdJaUt2L3hwVkxuQVI1SitmNVVEaml3aWRmc3l1eEtL?=
 =?utf-8?B?eFVLbWVPYTZpSUQrZFhwekdoK01HUWp0VHBpdm94T0N5c29zYVJYTGRkWC9X?=
 =?utf-8?B?WUlWdXdQQ1dQSXdDQnBMUHErTVpSZlo2RU5KWGVTMGVIdkZaZnpEU2NHZUhZ?=
 =?utf-8?B?UVFMUmVYOW4rTjYvWVFlRWxobjE3Wm9UUFJZbzdiQ3VldFhUU3lsSUlJZWhX?=
 =?utf-8?B?MW4xVm4zV1JnSlJQMFY2TTBuSDdmVFY4TTRRVGxxQWFUTk1wVzk2S2pQbWRv?=
 =?utf-8?B?eFprcDZ1YjBIeFVjbzAzT3IwMHcvMnQxS2FVK2ZuZU4rU3dONjQ2UW0yRmx1?=
 =?utf-8?B?TVpYcGtyZWs1RC94elJIOGZQQlI1NWZWL1hBdVhRKzNMYXk1b0Z4Y3FlYkp6?=
 =?utf-8?B?NDVKbWQvY0JkRTduNWw2MTc2R0Z1ZWQzcHpVUXB1eG5RUDRqemhGT2htYjN6?=
 =?utf-8?B?cFFQNGZEbzhLY29ZOXdEZzZzZkdicTdIUHlaMmpoUEVIYklaNTVyOVMyWjRN?=
 =?utf-8?B?bHVJY1k1RkIxWE9tYzgwK3J6YWludjIwNGZySTJ4TGJGNnUyUnRIc2dZdlpn?=
 =?utf-8?B?bWIzZm9abmpvVUE3d0xwd3RSYkpORWFSbTZhTFBUdndENitkVkc0ZDBkY2Qr?=
 =?utf-8?B?R0RMTXV4QmUweDVudkI0QVlrd0w4NXlPU3I3NWszTnd4LzllaW0vU0tQMnZu?=
 =?utf-8?B?Yy9ZQktUN0lGaU9VejRlODh0ZE8wZXBPdFFwdEFWUTdTODlUTkFQQnd1TCtL?=
 =?utf-8?B?WTk0RkRxYWlBenJudW1SOVlRTXQ2ckU3NnNQS2l5L1p2V3IyT2I2T1pSR1kr?=
 =?utf-8?B?SUdDVEhtUGQ0MU53K1U3a0x5Z3lyRWZNZEpHMHdiTXJjaWlxV0hYUWg1Q1Br?=
 =?utf-8?B?Y1Q3NXNWRDd1a0ExdWwxaVFIMnVuZC9tVDhNNDV1d25WOG16N0NGSW1WSldn?=
 =?utf-8?B?eGJ6azcwcklaQWJuWWZMSGZFQytwam9oZWlhRy9FTEJtSXZCV3hpSUkybm9m?=
 =?utf-8?B?dXlEWnBmbnh6SFhia3FnMWRuRU9pVXd1anZ4aU1RdkcxM0UvLzhweVBOT3Jn?=
 =?utf-8?B?dTk2V1JkL0tPMGM0eFBya21XUGtKQXdqems2Tm9LNG9GM1NQNDVmKzgvZXpO?=
 =?utf-8?B?TG56QkZYcXllRnpNc0VmTFBlRjc4UzdjczZDWmdEMlRtWE9GT2xOdi9xcVY5?=
 =?utf-8?B?UXRPazdFR0tLdEJoVkV5cXo1UWpra25KVHZjbUhBVDUwcHhMczJRNEYxNmI1?=
 =?utf-8?B?eDQ0SmYxMzRYMDFGeHVoWUx1dVhMSUhkRDJGeTBQckpMc2w2WXp2Um11cG5S?=
 =?utf-8?B?SzB4SzhlOWdEYWhaVXpxdFJhVThPN3JvQWJsY0dqUm51MlI5eXNiZ3c1c0hS?=
 =?utf-8?B?KzRDOFFSTFNsbFBYNmVFZUk3SnRhTFZuVm5qODNveXpSMkxWVFJhRjVjRzkw?=
 =?utf-8?B?Wkw4SDZ4MXpRNmdBUVdQT3k3bkRtc2d3UDVsZ1ZJTDBCc0R4a2pqZHBLQ2F1?=
 =?utf-8?B?R3d1T09QWDVGTEV2Yk44dEtUeUp1bjk0ZnMwRVZIaFpFaFNDaG54Zy9FOHJr?=
 =?utf-8?Q?E83zCGqz49tWsuBYsUzdlLfO2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a275a631-c0ca-4c73-3acc-08da5b483504
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 09:58:11.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dh9kMOsh8yKiNtZ7gU8h3cEyc9B4plA+nverKpdQOhXxUqRJ+179QJnziRbc2c9IZSRFRKbe35n2By6PaBV4/Q4vt9j5NhGkZgNkWDy2Pww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4798
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiAyOjU3IFBN
DQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT47IG5iZEBu
YmQubmFtZQ0KPkNjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBS
ZTogW1BBVENIIDAvM10gTWVzaCBGYXN0IHhtaXQgc3VwcG9ydA0KPg0KPldBUk5JTkc6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5
IG9mDQo+YW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3Mu
DQo+DQo+PiAgIEluaXRpYWxseSBpdCB3YXMgc2V0IGl0IHRvIGEgZGVmYXVsdCBzaXplIG9mIDUw
IHdoZW4gUkZDIHdhcyBzZW50Lg0KPj4gVGhlcmUgd2FzIGEgc3VnZ2VzdGlvbiB0bw0KPj4gbWFr
ZSBpdCBjb25maWd1cmFibGUgd2hlcmUgdXNlcnMgY291bGQgY29uZmlndXJlIHRoaXMgY2FjaGUg
c2l6ZQ0KPj4gcHJvcG9ydGlvbmFsIHRvIHRoZSByZXF1aXJlZC9hbnRpY2lwYXRlZCBuZXR3b3Jr
IGNhcGFjaXR5Lg0KPg0KPk9oLCByaWdodCwgSSBtaXNzZWQgdGhhdCB0aGlzIHdhcyBpbiB0aGUg
ZGlzY3Vzc2lvbiBlYXJsaWVyLg0KPg0KPlRoZSBxdWVzdGlvbiBpcyB3aGF0IGFyZSB5b3UgYWZy
YWlkIG9mPyBJIG1lYW4sIGV2ZW4gc2V0dGluZyBpdCB0byA1MDAgd291bGRuJ3QNCj5iZSBhIGh1
Z2UgYW1vdW50IG9mIG1lbW9yeSB1c2UgKH41MGspLCBhbmQgcHJvYmFibHkgbW9zdGx5IHN1ZmZp
Y2llbnQNCj5yZWdhcmRsZXNzIG9mIHRoZSBuZXR3b3JrPyBBbmQgaWYgeW91IG5ldmVyIHNlZSBh
bGwgdGhvc2Ugbm9kZXMsIHRoZW4gaXQgd291bGRuJ3QNCj51c2UgYWxsIHRoYXQgbWVtb3J5IGVp
dGhlci4NCj4NCj5UaW1pbmcgb3V0IG9sZCBlbnRyaWVzIHdpbGwgYWxzbyBrZWVwIG1lbW9yeSB1
c2FnZSBkb3duLg0KPg0KPlNvIGFyZSB5b3Ugd29ycmllZCBhYm91dCB3b3JzdC1jYXNlIGJlaGF2
aW91ciBpbiBhdHRhY2tzLCBlLmcuIHNvbWVib2R5DQo+YXR0ZW1wdGluZyB0byBqb2luIHRoZSBt
ZXNoPyBCdXQgdGhlbiBpZiB5b3UncmUgd29ycmllZCBhYm91dCB0aGF0IEkgZ3Vlc3MgeW91DQo+
aGF2ZSBiaWdnZXIgcHJvYmxlbXMgKGFuZCBzaG91bGQgYmUgdXNpbmcgc2VjdXJlIG1lc2gpLCBz
dWNoIGFzIHRoZSBudW1iZXIgb2YNCj5zdGF0aW9uIGVudHJpZXM/DQo+DQo+T3IgYW4gYXR0YWNr
ZXIgbXV0YXRpbmcgdGhlaXIgRXRoZXJuZXQgYWRkcmVzcyBiZWhpbmQgc29tZSBnYXRld2F5PyBC
dXQgdGhleQ0KPnN0aWxsIG5lZWQgdG8gY29udmluY2UgdGhlIHN0YXRpb24gdG8gZXZlbiB3YW50
IHRvIHNlbmQgdHJhZmZpYyB0aGVyZS4uLg0KPg0KPkJ1dCBldmVuIHRoZW4sIHNldHRpbmcgYSBt
dWNoIGhpZ2hlciBsaW1pdCB0aGFuIDUwIHNob3VsZCBjb3BlIHdpdGggdGhlc2UgY2FzZXMsDQo+
d2hpbGUgZ2l2aW5nIGVub3VnaCBicmVhdGhpbmcgcm9vbSBmb3IgdGhlIHJlYWwgdXNhZ2U/DQo+
DQpIaSBKb2hhbm5lcywNCg0KICAgVGhlIG9ubHkgY29uY2Vybi9yZWFzb24gaXMgdG8gbm90IHNp
bGVudGx5IGluY3JlYXNlIHRoZSBtZW1vcnkgcmVxdWlyZW1lbnQgb2YgTWVzaA0Kc3VwcG9ydCB3
aXRoIHRoaXMgcGF0Y2guICBTbyB3YXMgc2tlcHRpY2FsIG9uIGhhdmluZyBhIGhpZ2hlciBjYWNo
ZSBzaXplKGxpa2UgMjUwIG9yIDUwMCBtYXgpLg0KSGVuY2UgaGFkIGEgdmFsdWUgb2YgNTAgYW5k
IGxlZnQgdGhlIGNvbmZpZ3VyYXRpb24gcGFydCBmb3IgZGV2aWNlcyB3aGljaCBuZWVkZWQgaGln
aGVyDQpjYWNoZS4gDQpCdXQgYXMgeW91IG1lbnRpb25lZCwgdGhpcyBpcyBvbmx5IHJ1bnRpbWUg
bWF4IG1lbW9yeSBhbmQgbm90IGRlZmF1bHQuDQogU28gd2Ugc2hvdWxkIGJlIGZpbmUgdG8gc2V0
IHNvbWUgaGlnaCBsaW1pdCwgSWYgYWJvdmUgaXMgbm90IGEgY29uY2VybiBjb3VsZCB3ZSBzdGlj
ayB0bw0KYW4gdXBwZXIgbGltaXQgb2YgfjE1MC0yMDAgPw0KDQpBcGFydCBmcm9tIHRoYXQsIHRo
b3VnaCB0aGUgcG9pbnRzIHlvdSBtZW50aW9uZWQgYXJlIHF1aXRlIHBvc3NpYmxlLCB0aGUgY2Fj
aGUNCk1hbmFnZW1lbnQgbG9naWMgd2lsbCBlbnN1cmUgdG8gY2xlYW51cCBzdGFsZSBlbnRyaWVz
IGFuZCBpbiB3b3JzdCBjYXNlIHdpbGwNCnVzZSByZWd1bGFyIGhlYWRlciBnZW5lcmF0aW9uIHBy
b2Nlc3MgaWYgY2FjaGUgaXMgZnVsbC4gU28gSSBmZWVsIHRoYXQgc2hvdWxkIGVuc3VyZQ0KdGhp
bmdzIHdvcmsgYXMgbm9ybWFsIGV2ZW4gdW5kZXIgYXR0YWNrLg0KDQpUaGFua3MsDQpTcmlyYW0u
Ug0KDQo=
