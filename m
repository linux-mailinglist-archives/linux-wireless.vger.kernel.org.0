Return-Path: <linux-wireless+bounces-536-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB77808595
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 11:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC0A1F22542
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Dec 2023 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A1037D15;
	Thu,  7 Dec 2023 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SCQ/y6ty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83E6AA
	for <linux-wireless@vger.kernel.org>; Thu,  7 Dec 2023 02:34:00 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B7AQnBc008290;
	Thu, 7 Dec 2023 10:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=WKARqz42MP0YRGg4zmEU3uP3smAFaeaKWW3Q7lIbFD0=;
 b=SCQ/y6tyY2/fg2cTNK2fg76d+XR8dE2vh6aXUktvFcgz0orqCtgAaae9k9KyQzvW5R3B
 AeJr0b2WFkDMmtVtoIKGGE39oF2Ph4DGvAxfS7DTBcvrbs0B0DVmLv0IUOcjgJS4rLK8
 BuBN7PMLuLiQZT+14tBth9pP+ayFHcVDPCZlX+2jIffS2Q4Vd9Lj6x4NJ9YxvFL3D2fU
 BeDtUaAI/3On8sodfk4mLvfbsZeqCuVEudlkTB7E9OzM7yiC+A85m9Kcy4s6ddvzxlWT
 UTjZkHx3aK0++Z5F6BogLJwLg80u+RoqXJQVBKaSaDeKjFBtY7GJ6eiaYSm+faB0TCj+ 7A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uu928gey9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 10:33:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRw2jLz0gJO26J6RDkgxaId9ky03+GVumeDH4EDABV8udZuImdBmGv6znJJVX8rv8WZ8P+YfoS2dyQ49fziRyCP9pA0Cl9LhQtsJbaRk6mWShdSaN7oAQIxlFsEvngz1qp6ULDLsDYBWfyF5AmM7r2rb70HUolF7mVtH4mKI2TatvA4DpPK7ny6APmalRh+9XIiZBW7Lqi569YJR5+NkTao1yeWi4rz96drxpa0ZjcynpaPNmRccCkvP91Pa4kZ3JI39B8Mx/pAqxtwWd5ZfLi35qzBGIkpZczLLL8kI/KTe6c53EgR1GPCp6EWDo2ZywpqxN4hDi3AsOl8pPP50xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKARqz42MP0YRGg4zmEU3uP3smAFaeaKWW3Q7lIbFD0=;
 b=CaPRyLAZNdPjPpu8BQgvGEbFxGjaFpMjO3bo6otOaoVRWnErfEFNg+QjYM2e+32DPeL/zNID/mRUy+l4NBByhGkA2xUYRwn6pxYGr0v+0KmSG4p5mp5/i+NwIlEuS6FzXDfI/s8jwz5jEI5lxhZsDNISZb3oZ/d93+ozfwjDGgpBjdYqRt5xq5BF0OemtH+j326n3SyYMf8Mj13088GOsB3tug13R/9rjvz02A/Mk/qPAa/+Zs9AoWmRT/L0OxW1NNrtUggmTduWN5dzOQdbPhu7RdBDRe6O/QX0HhIUgOOGuy0WRreoUqK2KKorzIPzDxRnYRnl3a58tZ84ipoQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from DS0PR02MB9046.namprd02.prod.outlook.com (2603:10b6:8:c2::18) by
 CH3PR02MB9907.namprd02.prod.outlook.com (2603:10b6:610:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 10:33:50 +0000
Received: from DS0PR02MB9046.namprd02.prod.outlook.com
 ([fe80::ad80:6ae6:e3a4:c4a7]) by DS0PR02MB9046.namprd02.prod.outlook.com
 ([fe80::ad80:6ae6:e3a4:c4a7%3]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 10:33:50 +0000
From: Lingbo Kong <lingbok@qti.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>,
        "Lingbo Kong (QUIC)"
	<quic_lingbok@quicinc.com>
CC: "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Lingbo
 Kong (QUIC)" <quic_lingbok@quicinc.com>
Subject: RE: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Thread-Topic: [PATCH] wifi: ath12k: report tx bitrate for iw dev xxx station
 dump
Thread-Index: AQHaKEswEmZPWvNkDUS4DJhT1UXDiLCdndkAgAAB1kA=
Date: Thu, 7 Dec 2023 10:33:50 +0000
Message-ID: 
 <DS0PR02MB90467BDF7E0A0903D37955C0988BA@DS0PR02MB9046.namprd02.prod.outlook.com>
References: <20231206134654.24662-1-quic_lingbok@quicinc.com>
 <170194452077.2749331.9096558532469392640.kvalo@kernel.org>
In-Reply-To: <170194452077.2749331.9096558532469392640.kvalo@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR02MB9046:EE_|CH3PR02MB9907:EE_
x-ms-office365-filtering-correlation-id: 0f9fe2b6-cd58-4daf-cc31-08dbf7100060
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zgZosmZPBnyNLWzjFAwzDToJlat3pBSSuzW+if7aYaFdUkbwI7d+eKLDxr0NxuaryZpfsyafU0IT8iIl/2ABvU66/P4ugkcmyjQ+BEQ+KhYhCBzeQjHjGI84mIlD5BLJuA14vb3H56H+f1q+gVAxIheoaIyiwsIJtVq8tUneVZ1F49bGmq+iyc6DS7sYKqQLXAKJQTLR8Eu3VJh3h1bsAYnnjRyCpf66tRs5IiGvOGjOTEjyph3oKYoFAk9uBv7DCaplJ7v9iJcLNPXuDyfaegJGUdFFUPdR01mKonIkZ0ILYKVNcvaCPvWdVIfFEn8sdVKkI6m+wdjoyFQvMYKw2VgNuGN/24ydr9b5xKof/jVpwSh07RbrqJIJM5n7/i2/gMVbYzbo/gAr3f6Pcla3/hvGBBKiuc7ajSdIpvEH28pb8n2H4c8zZpnYfjR5ikcqErCMjhqnoFgRIkCkb6K2t+Qet6Tu8j0y05h7KpyJbolhP7f5u0MFpvrPTr/SFVY//fas7YUL4g1UZThceLx+e6rUT4LNBmY/HcgAPwWcnJJwa1yfY0tTiIOvWkYe3bnw/jvD7g3TomMPA1gPnfVeIV+89n1arRG6kdyU9k7JDqaz5YSiZO+hd0klnH5qnUcspRiGQZ8b29IgNQU5rIdCKzxityMar0uFETi1qSKHHXs=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB9046.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(33656002)(2906002)(5660300002)(41300700001)(52536014)(122000001)(86362001)(8676002)(4326008)(8936002)(316002)(66946007)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(110136005)(38070700009)(38100700002)(55016003)(966005)(478600001)(71200400001)(107886003)(7696005)(83380400001)(6506007)(26005)(9686003)(13513002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?akdWeTIzWW81dXJlWW1OUElzMlROR2NOc0RCODlFL0F5ZmtpU3c0SGt0V1ZG?=
 =?utf-8?B?cVlGSkhMQ1VsRVh5MG5aMm41bXA2TC9icHBkOTFYd1dwc0RxdFUyUVdhd1U2?=
 =?utf-8?B?N1ZpeDhVQUJSTi9iZlRlZHRkU0EzK0l4WFU3MGF6RnJTL1BvRWNZbkpTSXQ2?=
 =?utf-8?B?UzJ1SXBjZnZlSGZpVVNvcis1MXo2ODRvQ1BHeTNoQ0JZcnByYTBueGc4TWdj?=
 =?utf-8?B?SmZweDVUd0xNRVRkUVBlc0ZueGI4UDhWRHljUmxxdzUrdHQzanhlSU0ybDVP?=
 =?utf-8?B?R0Z3eUYyQVhYdHM1VHdzQlMxYitXZS9JR2NQUS91cDFSUm4xcENhUmlWSE9M?=
 =?utf-8?B?dzBFOGVqa0ZFNzhrczJ6N0toeXdlMzU4MFJDWTI1VzdGWEEwWWpIVGc2TE4v?=
 =?utf-8?B?WEMvU0VhaUx5dlNBZ2VTc2hZaUk0Q3UzSFJRZlVxZGl0SW5FUHA2Mmw3SkVX?=
 =?utf-8?B?b0Q3bmV6TUMzYTUrUTNreXNBc2FxR2pBUzhmUjhtdnFRVlRvTENaVGhKYTI5?=
 =?utf-8?B?WXJ4UzRycUdEdS9NVC9KVk03TUlzK3FiNTdVRjU2TWlvT2JCK0lRdFp6d3Jv?=
 =?utf-8?B?TDEveXMwbzk4SlFvQWJDZnVuaUxYMHcvTWVaU0hYRFFWd2lscktpMTc3VThw?=
 =?utf-8?B?bnhIa09ONjMvVGRsdUJhcFdNbVpMd3RYdHFMenIvVkdBeS9vL1VpVGVoeStH?=
 =?utf-8?B?MjFYWlpHdnFKT2hhdVp3UFBwNlArQjlGZFJYY295TFlzVEIvWkZWUjR1SjVI?=
 =?utf-8?B?WTVucmswU0hhTkNmQUcyWndJUEVqZWJZRzZtNHhNKzVzVTdwZW43ckRkdkN1?=
 =?utf-8?B?dzArbWY0ZG5rNWFGektIZy8rL2tVWHZ2SXhQejgyd3NMMi9reFhndXEzeUZH?=
 =?utf-8?B?Sjh3dGYrS3k4cEVreUVzYVVaS1hGV2E5SHpFdTFGcnBRajBBOWZ0bTVTQ3Fy?=
 =?utf-8?B?Lys4ajlBakcvbkZ5eWlnNWhheUR0YXdZbjZQYmNScXhTK2ZteVY2bmVtZmJn?=
 =?utf-8?B?emQwZ2cwdlZhSnJMS1NYekhUc3czayt0MU5ZRGdSUWRyalJiZUlQTVdBeTk0?=
 =?utf-8?B?OFBhOG5NbGs5Y0dxdHBKbWdrd2xwNEd5RWpaTzk1ZVVzbzR6UGhaMTdTeklH?=
 =?utf-8?B?SHViMFg0WGU0b0w4KzY1N1l1Tm44SFBieXpUd1hIUW9aVkYvSWhwQ0xPSWdF?=
 =?utf-8?B?TThoMElBZms3S1JLeEVudG9KU0ROMzRsR1BhSTA4aUdydGNQdnJvaGIrdTNp?=
 =?utf-8?B?U3NVMm1jVTdjREdYbHZEVm5NTEF4SzFQNlRUN3ZXRVUwY3h6TGJDcC9JVXhh?=
 =?utf-8?B?L25UbmNEK3FUdm5nVVJMMnBDOU1tTzJKNStjWXpMSElUT2RIbTh5TllYTU1G?=
 =?utf-8?B?TkN2QXJQSDZHRDVTV1BFZm1CYk50V0ZFbWhRZUhsbmFsQWxwOHdDMEQxdVhV?=
 =?utf-8?B?RDlJVzZxaW5rNVlhcEJCZ0ZuM1RXaE5BWUVNOGRZV0dpY3dteGdOQjhtSHVX?=
 =?utf-8?B?OThLL0lnUGJMeE5McXE5a0MweHFYTkRaY0xyaU5oU295aU53RkMvcDJoWUlB?=
 =?utf-8?B?RWhlYXlkVDV4b2tLSkNOWXdVQTRSNjlNeW5RT3VWVkYrQUVsZm1QM3lETXZh?=
 =?utf-8?B?cXRJcGxtcmVlVUxIejk3YjljZ3p4WkpMcDJQSXVYczBrN3J3Y2YrcjBYcDFq?=
 =?utf-8?B?UldIWEFtUTRTckFTNlo4NjhHU05xZEk5RDVtZFJnV2l1NGlCWHllc1dTVlpS?=
 =?utf-8?B?eWdmaFpIV2NWM3MvUkpMRUh3b3F2QmRHNmZZS2ZFYjJpKzB6Sjg3UzhYM0Ir?=
 =?utf-8?B?V2xvb1lGYy9KcXU4NjQ5YlpnLzF2NktMdjVRTkQzSTU3YmVNdjl5ODIwM2Ir?=
 =?utf-8?B?YWt0WmE3MFJ2T3ZhcFpaUHlza29YSUNsa1BicDJkOTYzYXBWUFZGMkJoNDEv?=
 =?utf-8?B?S1BzUDVsajZ6UDVUOUZndnVQQnZBVWtPVjRvZXZFL1ZjNmhqSXdDb2ZRVkdK?=
 =?utf-8?B?ZG5OVWVvYUowM3Rpa2V0M0FjQWRSUSt5bHN2dzdEVEMzUHcrYTdJdTd1VXlG?=
 =?utf-8?B?SjVVT1lQZ3l5UkZTakJWUjRuMUlYSUgzVE1odCtmN1E5TzQ5WkZleHY2VFdl?=
 =?utf-8?Q?iGubEg9ZXL0mGN6O8SJe1cwHL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iB4kZOtSD8GbCttq3hUjQ4bH/zlDGKwXBa1lErwcCL+0umWA3k3if1+XbKF1ZJO812/v+a+HYjMGHq7AHeHg7UWcoJTi46iqnqdfdI/vs+lTjNyZn2Rg76ZHmMuuGLIXGJUc1f15o1CoTiikWlhNveidZ259MtbhOuuOP6tgPoZ7oH18V7hvkvUpKSq1y/MZXLbXPPwHzE9Et3yz65WDWyoLIvFQq7Pmelks/YAjO9KIq81xtyKac6lVh39YfHaJYhsJsq0pYgC34qBid9+obMDB9s8peWF68vbZsn+pwID0Fy/XgQjXOIDNe45EmTUJiXVbs6a5QOIJwMDGVUhdHz5WLp7VIpNg0SupmCKuFV+ELyWNWuirZ3R5DN1Cz0VNBoJ9YtDrH++wbwt47gZFyaq/RupMjNQW7DD4I3HBxzdefUkkV0DMvhpnJZzuzoBzD6oco8dzIdxbtZiR/3cxz/46ohaQqEhzN3ocM3PcounBDVRmjv8ChAfwXq5RkV5u+/IUtiP2NCTvEqLiMamuIjUn/t19XhOeVTm854J4B6X2t7SMnOiPoIlqTcH2urn1PuPO9C9pBsGl378dIw670N5xxL14EshtLHGulXMJrKixx66kKoJqYI1TsWDwq20D8Z4cH4uDzsJr4+UKQbABflxwW5hZkJsvPNj/0kIPJrIeCih3/qkTmsdfj8PWTJJ+wgKhHmCf1t86+bK6SAo24vxOVLb8oP62UpwZBiEBzFbPbhYKijO3Npovz3eVNIj3Xm2bR3x5PYXrjuYeKkMshuScwV/mfP7F4B6F4HVnzdukWH6sYHNKVFrUAZ+Is8fGNClrj6dCs77/u+Wm2gRzMPa7OGlOpvTBw7avv8GEiMg=
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB9046.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f9fe2b6-cd58-4daf-cc31-08dbf7100060
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 10:33:50.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgKE+SBwp5HyTWA4i6n3S0zPAchDYNfHeXJBE93m49dMsxnhoeujkVM1IGbyJyUmoeZVRKdiwri/h/O9FcAm+qGeh9Hyuo7N43lrMqZR55A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9907
X-Proofpoint-ORIG-GUID: IrKqMxbAhqooFY_j1z62nwrQ7-3FvIKH
X-Proofpoint-GUID: IrKqMxbAhqooFY_j1z62nwrQ7-3FvIKH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_08,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=801 mlxscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070085

PiBGYWlscyB0byBjb21waWxlLiBNYWtlcyBtZSB3b25kZXIgaG93IGRpZCB5b3UgZXZlbiB0ZXN0
IHRoaXM/DQo+IA0KPiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL21hYy5jOjc3NDM6
MjA6IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3INCj4gJ2F0aDEya19tYWNfaGVfZ2lfdG9f
bmw4MDIxMV9oZV9naScgZHVlIHRvIGVudW0vaW50ZWdlciBtaXNtYXRjaDsgaGF2ZQ0KPiAnZW51
bSBubDgwMjExX2hlX2dpKHU4KScge2FrYSAnZW51bSBubDgwMjExX2hlX2dpKHVuc2lnbmVkIGNo
YXIpJ30gWy0NCj4gV2Vycm9yPWVudW0taW50LW1pc21hdGNoXQ0KPiAgNzc0MyB8IGVudW0gbmw4
MDIxMV9oZV9naSBhdGgxMmtfbWFjX2hlX2dpX3RvX25sODAyMTFfaGVfZ2kodTggc2dpKQ0KPiAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgx
MmsvbWFjLmM6OToNCj4gZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9tYWMuaDo3OTo1
OiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZg0KPiAnYXRoMTJrX21hY19oZV9naV90b19u
bDgwMjExX2hlX2dpJyB3aXRoIHR5cGUgJ3UzMih1OCknIHtha2EgJ3Vuc2lnbmVkDQo+IGludCh1
bnNpZ25lZCBjaGFyKSd9DQo+ICAgIDc5IHwgdTMyIGF0aDEya19tYWNfaGVfZ2lfdG9fbmw4MDIx
MV9oZV9naSh1OCBzZ2kpOw0KPiAgICAgICB8ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4g
bWFrZVs3XTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI0MzoNCj4gZHJpdmVycy9uZXQv
d2lyZWxlc3MvYXRoL2F0aDEyay9tYWMub10gRXJyb3IgMQ0KPiBtYWtlWzZdOiAqKiogW3Njcmlw
dHMvTWFrZWZpbGUuYnVpbGQ6NDgwOiBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrXQ0K
PiBFcnJvciAyDQo+IG1ha2VbNV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo0ODA6IGRy
aXZlcnMvbmV0L3dpcmVsZXNzL2F0aF0gRXJyb3IgMg0KPiBtYWtlWzRdOiAqKiogW3NjcmlwdHMv
TWFrZWZpbGUuYnVpbGQ6NDgwOiBkcml2ZXJzL25ldC93aXJlbGVzc10gRXJyb3IgMg0KPiBtYWtl
WzNdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDgwOiBkcml2ZXJzL25ldF0gRXJyb3Ig
Mg0KPiBtYWtlWzJdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NDgwOiBkcml2ZXJzXSBF
cnJvciAyDQo+IG1ha2VbMV06ICoqKg0KPiBbL2hvbWUva3ZhbG8vcHJvamVjdHMvYXRoZXJvcy9h
dGgxMGsvc3JjL2F0aC9NYWtlZmlsZToxOTEzOiAuXSBFcnJvciAyDQo+IG1ha2U6ICoqKiBbTWFr
ZWZpbGU6MjM0OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQo+IA0KPiBQYXRjaCBzZXQgdG8gQ2hhbmdl
cyBSZXF1ZXN0ZWQuDQoNCkhpIGthbGxlLCANCkkgZGlkbid0IGhhdmUgdGhpcyBpc3N1ZSB3aGVu
IEkgdGVzdCBpdCB5ZXN0ZXJkYXkuDQpJdCBtYXkgYmUgdGhhdCB0aGUgdmVyc2lvbiBvZiBvdXIg
Z2NjIGlzIG5vdCB0aGUgc2FtZS4NCk15IERVVCdzIGdjYyB2ZXJzaW9uIDExLjQuMC4NCkkgaGF2
ZSBzZW50IHRoZSBwYXRjaCB2Mi4NCg0KQmVzdCByZWdhcmRzDQpMaW5nYm8gS29uZw0KDQo+IC0t
DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC0NCj4gd2lyZWxl
c3MvcGF0Y2gvMjAyMzEyMDYxMzQ2NTQuMjQ2NjItMS1xdWljX2xpbmdib2tAcXVpY2luYy5jb20v
DQo+IA0KPiBodHRwczovL3dpcmVsZXNzLndpa2kua2VybmVsLm9yZy9lbi9kZXZlbG9wZXJzL2Rv
Y3VtZW50YXRpb24vc3VibWl0dGluZ3BhDQo+IHRjaGVzDQoNCg==

