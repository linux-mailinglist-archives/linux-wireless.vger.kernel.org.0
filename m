Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACFC5F41FD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJDL3L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJDL3J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:29:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB7248E81
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:29:07 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294BT3Ph023937;
        Tue, 4 Oct 2022 11:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=OQAn96IdVgKmm5OvJq2IYXeJj3pX4GMGPASlD4Tgl7E=;
 b=AqBbd1IMLRcZdHPBnCb0G4UE2sru0MsJ5HNf0lR0bEQzsvg1ppTPDoly7TGBfDAcfRNM
 btArujRiKT4sWacQr4sxI5bz4EsoRj7503i8yoSRUfXYVZBlHodFO55Vv8oDJCV/El66
 3osNifoazgfSq0NRQjAGtlTuT1fM4R6oF0qrIlcLLDLLNC5y7viRl8uXP7nyPXlpnVGf
 SfQloKc+65Vt14Gq/2N983ayqBldHJXCmVV6LH2YEtFsuBpExdUEGo6+00eIjhElTnuM
 YipJ8mukrUDE3pvcL+QyEw8hdDSlB1Vx7IishcB3kHVey+dNK13+0XtD2zKNy8LXFcnt pw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0jtdg406-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loNI3sPwATx6vENaM9+pBiZQv8O0Q/ja9FHv7+t6+hoBt5K1S6a0gKvBCMVjk/AEXW+9xpFVTgc7JG6hS8Z62tNbCLwatF2bLu32v1Zl4IavVUMQTAXhgTJ2NGDGB/0T6KouFm4aU+aUiTry9cV8vpG9HTHeh4lPKOkrwL93dfGE2ta/GOqvE/n9pNB2uN3bV0kiKgUR0BlIWoSt0o3PyGQjTv67Di9tbm+mYSpfHKjoS1G8WZ7HJ6t6DaapJr/LYsWHDTynnfFsnRbqqt6oOXOYgjMy+5rJSAK/uPFu1U1t9y/OL6sRpL36dN2qWCfqKwlM1ciffOs4mObcb9c8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQAn96IdVgKmm5OvJq2IYXeJj3pX4GMGPASlD4Tgl7E=;
 b=hHgjkv9NLzrOITGiH/IctzBJ2GOBTaAi4DS21mdTEvgVrmLhiEzUdXDbJlpKIR/REIsR9ef3k2FPuGccnqwgeQ2uPvIM6XhtbsdrXeNbN8sU/d4jqA5x0TLAto0ssEP5Sac4qwjc36AVcv1uwzFPI2/9+xDjEa0peVCYdm1kQw2s6VXGpcZRlbdWfSyVXBd5uMEea0VAAzAabbvXdT1xpnnHv6cNyfaVQf0KM6sXBCMOls3MbUEeUQuMNYqKRNA1Jz1L3q9qRAU5oBjKGfnAy368Ch9xty/bKNgOMMq5ZXE2tUri8TZkLC18Y2Ht8Nc4tlLB3yRqoMfSAtD/mJMZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by BY5PR02MB6882.namprd02.prod.outlook.com (2603:10b6:a03:23b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 11:28:59 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:28:59 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 29/50] wifi: ath12k: add hw.c
Thread-Topic: [PATCH 29/50] wifi: ath12k: add hw.c
Thread-Index: AQHYrmYmcy/ZUffLkkCFYty3gCEjeK21NuSAgEk1AzA=
Date:   Tue, 4 Oct 2022 11:28:58 +0000
Message-ID: <CH0PR02MB8212240385F6783B06951B43F65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-30-kvalo@kernel.org>
 <5babeb15-801d-b280-b8fc-c87ba980c9ff@quicinc.com>
In-Reply-To: <5babeb15-801d-b280-b8fc-c87ba980c9ff@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|BY5PR02MB6882:EE_
x-ms-office365-filtering-correlation-id: a4f47148-b7fa-46ea-6fa1-08daa5fba166
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SLLYSGVVQ53QiDOJM4JyBx1NthIFDyngsBeJh1WnpZPfIztj7YdZ3gY/r5j8Jaqlpgcek600t/yow7wm18qHPLf+4nEi74XibR/7liGayrhhxkSP6ASTW8HX4U/iLqUdtPMYDfV5Wx8oD/TXwsJJR6ZbGvlozIjO01F4qVLsANULUxbsuHRttki5KHXZm+Ev9GuRz9pOvWsqVdaxqKtltaDYJPk/B6ULNin3YcU3ODvPkmJK882tVzW06gzpn4pDBekRK5ZkdqKq8R/Xx84h2RTTTqwuLYAprMcU6vTr0wAE6uEYnw3EOHHdCwKn/enjPj/EtO8ZEkKy1ztbMfT/jrMIHNzYdTLpXJZv0dyBT0uXpeB40ct/SOvP5XUvEI9qh95JxaaM6G9lSoW52VAthdK2+FOMkte4/GqgY8zJd9vSbsaXBG+Kq8/DHn9gQq6SnXwmFVCvzwoU72kZxTlAZNVXA5Kwyw85FKQ634yYewbayYw4Ru3g3XRkr3bGdEU6nghrD1ssimXOAMrFtdojZLP4qFHqbG+GVI02h4SApcm25peB7QWo3CWwCh84Y4n8a43ZbJsA+qJbobqO6tVDLosIIb0csWj2JvK/8UkbFGD0vXnfGclwSHSXWO1kCSvT9bRVFHa8IIo1bwIuAzvA+onT2/05y0Hsc/Bot7P+CrliOuEkzBhj0R209iheS3TwzlyJMXiqcHD0zLSQ2CoV1tWP5r3AO/HcKUTEOp0LSVlk9TLpP6VTpJkv0MZYVpxFLoxpxfVZUpdzL8tmKsMuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(6506007)(33656002)(7696005)(478600001)(53546011)(71200400001)(76116006)(66446008)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(110136005)(38100700002)(122000001)(64756008)(38070700005)(55016003)(186003)(9686003)(26005)(86362001)(83380400001)(41300700001)(5660300002)(2906002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU9iT1Q3U2NCSDRqTUtMbGFnSCtoNnJoUHp3QnBRYlVYTjNnT0JVVkQ3S0NS?=
 =?utf-8?B?RE9WUzdUN003RlpKOHg5SHJYRjdlQ0ZCNmlmRk1iSXNQTFNPQUY0YjN2MktF?=
 =?utf-8?B?TlExWWJZYVNyaDJ0YVdjUitPTDdjeHBBMzVwMStjU0ptY0dXZ3RtM1hDcTQw?=
 =?utf-8?B?VTJYdkd6dlZCVFBWL2N2akQrRVczSnhuUjMyQkVwNllYNGg2dExFR0QvaVhX?=
 =?utf-8?B?WTZ6b1pDSzhBekx1a0ZKalEwMWlCZUFKMFFhUUpicUxNYUhQanprVmdrNk45?=
 =?utf-8?B?ZUV0a0xKNUdSbjBhNTg0TTBXUGZZZVRtWk1vVWc5RDVCazdwMXNuZ0tZdFds?=
 =?utf-8?B?RmZaTitFUzF3dytSRDduU1VQUVpmQ1FjVmIvRHQxU3FyRitLOFUxSEJvV2x3?=
 =?utf-8?B?enhYa3ZlWnRIaFBXaWdVVzF3V0k3NUNLZmpDdzJNNjNKOFNjbUdMZHJEaVNY?=
 =?utf-8?B?Q2Z0M2l0bGJqenZweTRmdGtPZ0ZsWHp1TXk4OW9sQlVWNHhHZjZwRWFzblRT?=
 =?utf-8?B?ZWRGRUZFVnorU3VoVVRuMk1xdUpTTDYvakkweDc0c0pxaklZTUNFTmpHcVZh?=
 =?utf-8?B?R0llQ1JHbVN2MzdNL3JMdHRSYncwTUZ5OElZVkx1RWhtMTk0dlNmL0xRL0Fk?=
 =?utf-8?B?YnpPVkV0b3pma2Q1OGhHMUgvc0kxTTNXL1RTV0E5VFRZNlE1MHdGSllGZVFw?=
 =?utf-8?B?STlOekhHMjhoQkovdE5wVDlZbmgwanEwbkhHRDF1MWNWdEdGZnVUbVk0MTdD?=
 =?utf-8?B?aFpuMm9VR0dnSjZTbjlHczQ4c0RzZW9tc1hnY2RPTHVwSjRkL1lRK2svWFlJ?=
 =?utf-8?B?d2NlY1k3MGJ6enVlYm5aL0ZXRHY0OWdaZGI3R2xGUjV6bld0NHhLTkZqSVZN?=
 =?utf-8?B?Mm1qV0tRS1BxTzFWRTZGU3hmTGlJQnpCdGlzR2xLTHJSRURLYkQ3WWpsWHhP?=
 =?utf-8?B?aWQxVEFpSDBZYkZYVUwwcmhFa0xOZjB2NjhrSUt1bkgwTkJkQ0N0aGlnTVZ3?=
 =?utf-8?B?Rmg5Mm9jZ3RVTy84d09xcjZzN0x6bTNZcFJ3T1pDMUcyb2JJellIUG1MaUQw?=
 =?utf-8?B?WUlwanAwMjZZaExVYzQvaEd5MDVuc0J0OCsyaWhqZHBLcGNZa0J0NHpGVnp1?=
 =?utf-8?B?d0hUbmU3bW9oZDVSYzMvNWNiQzNxSnN5bkNCUlI1Vk5EYXNDTmdRVGFVb0c2?=
 =?utf-8?B?RVc5TGZSdXFISWJGUTBmdXB2eDE2WEJYeHRUeW5FdGNFaktRSzNYdWhQOGdI?=
 =?utf-8?B?YlFvRUpmWnc4NXpXNmxNVnBHMU1MQ09wNlp6WXUrWmUrNjQ3dGdSZXJnOHdK?=
 =?utf-8?B?WHREdmhFajFDNkN3NlU2cmx0c05uM3c0M3IvcXpvN0lHTjVlRkRBUWRlV2Rm?=
 =?utf-8?B?Vm1jTzdMZnkxYkJPZ2xxYXpmK3FyVzlqZTkzZTN3MWs4dWRSSXA4ZmRnVVA5?=
 =?utf-8?B?SnNQSVNIbmQvTUYrUGZqUU0xejh2U0RKZGZ4STRQSDh5Z3pmUVdVWkdKbmpE?=
 =?utf-8?B?YTJUemxMNmlIckc2aDR4UzJQbG1hSGlFVXVpWktiamY3Tml0aDhQVk85TTJV?=
 =?utf-8?B?cDVoLzFaNG9rWEt0ckllL2ZxNUhsanVpUXFHYnZQZjB1eWVnTGkwTUtQd1JN?=
 =?utf-8?B?elJCUDNlZVpZYUNQcENCYmIwM0tVNWxFblBCcldlRjYwYUZlVHJmYjJmamx6?=
 =?utf-8?B?ZndKdEdreG5DQU1keERsWFRlQm4rYndRT0xxSkNPYWRMd3BadVJPb1crSHBt?=
 =?utf-8?B?aUxGVElReXZkMlZveng0dDhJWFkyZFFNYnZtbTRoSjl0MXMyaDZzdHU3bHhQ?=
 =?utf-8?B?bUxFamZhNWlndTBQQ1FGYzRkck5TQURHRlM0UzY2SXdhNFU3T0hpM0thU2Np?=
 =?utf-8?B?Zk4vbnNhNHVkVTA2NDIyOGlqcnN4U2puU3l3WTlvV3lQVkJ5WkFpWTZXRHRn?=
 =?utf-8?B?NGU4Q0VwckVjQlhveUkxU242OG1LS004ZE5FemZtTHJMZWdwOFBSRHYxclBK?=
 =?utf-8?B?NWxXK0ZqRkFQeno2RU5XbmtDRU94TW8vMEI3b3BFRHRTUHZzRDlqWldLM0FP?=
 =?utf-8?B?QTZvdW1zV1d3L1NBc3RNZnU1UHpZL3dEaG9GVWk3bVRNZjJsMmtwSXlLWE9R?=
 =?utf-8?Q?rJAe3CdAHTM/TlPWVUqwTIJgf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4f47148-b7fa-46ea-6fa1-08daa5fba166
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:28:58.9253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IwZYzr7JcPpXY6N0t+ioIksUdNmYca2TIRZgeqlJnrRTK+QdjiG9uc5occ5dIDDr/KG9lXk9ilD56H26HzeoS04+Xyk+2j/eLogQSza2M5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6882
X-Proofpoint-GUID: KXIxtMFLrxmwmzEg0wNv9LdLpseY39k0
X-Proofpoint-ORIG-GUID: KXIxtMFLrxmwmzEg0wNv9LdLpseY39k0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEpvaG5zb24gPHF1aWNf
ampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE5LCAyMDIyIDM6
MDEgQU0NCj4gVG86IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGF0aDEya0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMjkvNTBdIHdpZmk6IGF0aDEyazogYWRkIGh3LmMNCj4gDQo+IFdB
Uk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBs
ZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBl
bmFibGUgbWFjcm9zLg0KPiANCj4gT24gOC8xMi8yMDIyIDk6MDkgQU0sIEthbGxlIFZhbG8gd3Jv
dGU6DQo+ID4gRnJvbTogS2FsbGUgVmFsbyA8cXVpY19rdmFsb0BxdWljaW5jLmNvbT4NCj4gPg0K
PiA+IChQYXRjaGVzIHNwbGl0IGludG8gb25lIHBhdGNoIHBlciBmaWxlIGZvciBlYXNpZXIgcmV2
aWV3LCBidXQgdGhlDQo+ID4gZmluYWwgY29tbWl0IHdpbGwgYmUgb25lIGJpZyBwYXRjaC4gU2Vl
IHRoZSBjb3ZlciBsZXR0ZXIgZm9yIG1vcmUNCj4gPiBpbmZvLikNCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEthbGxlIFZhbG8gPHF1aWNfa3ZhbG9AcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+ID4g
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2h3LmMgfCA5NjENCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA5NjEgaW5z
ZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0
aC9hdGgxMmsvaHcuYw0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9ody5j
DQo+IA0KPiBzbmlwDQo+IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGF0aDEya19od19yaW5n
X21hc2sgYXRoMTJrX2h3X3JpbmdfbWFza19xY245Mjc0DQo+ID0gew0KPiA+ICsgICAgIC50eCAg
PSB7DQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfVFhfUklOR19NQVNLXzAsDQo+ID4gKyAgICAg
ICAgICAgICBBVEgxMktfVFhfUklOR19NQVNLXzEsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktf
VFhfUklOR19NQVNLXzIsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfVFhfUklOR19NQVNLXzMs
DQo+ID4gKyAgICAgfSwNCj4gPiArICAgICAucnhfbW9uX2Rlc3QgPSB7DQo+ID4gKyAgICAgICAg
ICAgICAwLCAwLCAwLA0KPiA+ICsgICAgICAgICAgICAgQVRIMTJLX1JYX01PTl9SSU5HX01BU0tf
MCwNCj4gPiArICAgICAgICAgICAgIEFUSDEyS19SWF9NT05fUklOR19NQVNLXzEsDQo+ID4gKyAg
ICAgICAgICAgICBBVEgxMktfUlhfTU9OX1JJTkdfTUFTS18yLA0KPiA+ICsgICAgIH0sDQo+ID4g
KyAgICAgLnJ4ID0gew0KPiA+ICsgICAgICAgICAgICAgMCwgMCwgMCwgMCwNCj4gPiArICAgICAg
ICAgICAgIEFUSDEyS19SWF9SSU5HX01BU0tfMCwNCj4gPiArICAgICAgICAgICAgIEFUSDEyS19S
WF9SSU5HX01BU0tfMSwNCj4gPiArICAgICAgICAgICAgIEFUSDEyS19SWF9SSU5HX01BU0tfMiwN
Cj4gPiArICAgICAgICAgICAgIEFUSDEyS19SWF9SSU5HX01BU0tfMywNCj4gPiArICAgICB9LA0K
PiA+ICsgICAgIC5yeF9lcnIgPSB7DQo+ID4gKyAgICAgICAgICAgICAwLCAwLCAwLA0KPiA+ICsg
ICAgICAgICAgICAgQVRIMTJLX1JYX0VSUl9SSU5HX01BU0tfMCwNCj4gPiArICAgICB9LA0KPiA+
ICsgICAgIC5yeF93Ym1fcmVsID0gew0KPiA+ICsgICAgICAgICAgICAgMCwgMCwgMCwNCj4gPiAr
ICAgICAgICAgICAgIEFUSDEyS19SWF9XQk1fUkVMX1JJTkdfTUFTS18wLA0KPiA+ICsgICAgIH0s
DQo+ID4gKyAgICAgLnJlb19zdGF0dXMgPSB7DQo+ID4gKyAgICAgICAgICAgICAwLCAwLCAwLA0K
PiA+ICsgICAgICAgICAgICAgQVRIMTJLX1JFT19TVEFUVVNfUklOR19NQVNLXzAsDQo+ID4gKyAg
ICAgfSwNCj4gPiArICAgICAuaG9zdDJyeGRtYSA9IHsNCj4gPiArICAgICAgICAgICAgIDAsIDAs
IDAsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfSE9TVDJSWERNQV9SSU5HX01BU0tfMCwNCj4g
PiArICAgICB9LA0KPiA+ICsgICAgIC50eF9tb25fZGVzdCA9IHsNCj4gPiArICAgICAgICAgICAg
IEFUSDEyS19UWF9NT05fUklOR19NQVNLXzAsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfVFhf
TU9OX1JJTkdfTUFTS18xLA0KPiA+ICsgICAgICAgICAgICAgMCwgMCwgMCwgMCwgMCwgMA0KPiAN
Cj4gbml0OiB0cmFpbGluZyAwcyBkbyBub3QgbmVlZCB0byBiZSBzcGVjaWZpZWQgKG5vbmUgb2Yg
dGhlIG90aGVyIGluaXRpYWxpemVycyBoYXZlDQo+IHRoZW0pDQo+IA0KDQpTdXJlIHdpbGwgYWRk
cmVzcyB0aGlzIGNvbW1lbnQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gNCg0KPiAN
Cj4gPiArICAgICB9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBh
dGgxMmtfaHdfcmluZ19tYXNrIGF0aDEya19od19yaW5nX21hc2tfd2NuNzg1MA0KPiA9IHsNCj4g
PiArICAgICAudHggID0gew0KPiA+ICsgICAgICAgICAgICAgQVRIMTJLX1RYX1JJTkdfTUFTS18w
LA0KPiA+ICsgICAgICAgICAgICAgQVRIMTJLX1RYX1JJTkdfTUFTS18yLA0KPiA+ICsgICAgICAg
ICAgICAgQVRIMTJLX1RYX1JJTkdfTUFTS180LA0KPiA+ICsgICAgIH0sDQo+ID4gKw0KPiA+ICsg
ICAgIC5yeCA9IHsNCj4gPiArICAgICAgICAgICAgIDAsIDAsIDAsDQo+ID4gKyAgICAgICAgICAg
ICBBVEgxMktfUlhfUklOR19NQVNLXzAsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfUlhfUklO
R19NQVNLXzEsDQo+ID4gKyAgICAgICAgICAgICBBVEgxMktfUlhfUklOR19NQVNLXzIsDQo+ID4g
KyAgICAgICAgICAgICBBVEgxMktfUlhfUklOR19NQVNLXzMsDQo+ID4gKyAgICAgfSwNCj4gPiAr
ICAgICAucnhfZXJyID0gew0KPiA+ICsgICAgICAgICAgICAgQVRIMTJLX1JYX0VSUl9SSU5HX01B
U0tfMCwNCj4gPiArICAgICB9LA0KPiA+ICsgICAgIC5yeF93Ym1fcmVsID0gew0KPiA+ICsgICAg
ICAgICAgICAgQVRIMTJLX1JYX1dCTV9SRUxfUklOR19NQVNLXzAsDQo+ID4gKyAgICAgfSwNCj4g
PiArICAgICAucmVvX3N0YXR1cyA9IHsNCj4gPiArICAgICAgICAgICAgIEFUSDEyS19SRU9fU1RB
VFVTX1JJTkdfTUFTS18wLA0KPiA+ICsgICAgIH0sDQo+ID4gKw0KPiA+ICsgICAgIC5ob3N0MnJ4
ZG1hID0gew0KPiA+ICsgICAgIH0sDQo+IA0KPiBuaXQ6IGFkZCBlbXB0eSAucnhfbW9uX2Rlc3Qg
JiAudHhfbW9uX2Rlc3QgaW5pdGlhbGl6ZXJzPw0KDQpTdXJlIHdpbGwgYWRkcmVzcyB0aGlzIGNv
bW1lbnQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gNCg0KPiANCj4gPiArfTsNCj4g
PiArDQo+IA0KPiBzbmlwDQoNClRoYW5rcw0KS2FydGhpa2V5YW4NCg==
