Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED585F4202
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJDLaW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiJDLaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:30:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0059C18B0B
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:30:19 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294BQUlH023330;
        Tue, 4 Oct 2022 11:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=E6W+zLbjGVqTmUcIzMagB6mJN9t2K9z/eigePYImBxM=;
 b=e7aC+oaO85SC8xVkRgfqhDDF9fBTrXexH3OBRhR8D+VssgrWQ8g1Gpi4NbJIvzXSWcL8
 1lhEg76PtLemrYG4hkNa3S2VaTVn+c8u8NSkInmcIer6rTFk03Rb75bT56sY83grRnpL
 W23/Z0l7mYRXR8GhqCaw07bUnGT0XQCbc9xSO27Z8ztMzLjoU2YWECN2PssKbnOL/RK3
 BoYEGrWE5L81oicnFWi16dhvtuhUEloEmKrKT1vO5/Tpj+IEL9yLPsz97uQ7Dv/OciuR
 tGNau48g+FO1/wz1HB/Rxea5aF2tnOsvd2JAOctFvGZYJV1ExnoMGoBx8+kvgYmHnZFe /A== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxawu60ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHLNJw5XBb4mAgdG4Y07GcWLftwibrypqdf6ysRBjugjzlhqtR7kBaNw5ci2CVb/c7LE7n3APnNW7LIuBjaq5xFuVQ0V1VbjuPGrU2sdRb1MSRGGIEe8C+gFwOfnC5NXs9hMMBv/1K+AutdKjcD0fYa9la+pCO8IQaygwfGRvHO42Ofnf2yJ5xyGDmwoAbDzS02eMZyPZ+1z7m2Q0+Y9VKW7skrS49FBIKw1bft/VEEE6+BvrLedcyS3XKuw78gDUUK0ib0CTTcEmaAAzvMIktXDyBOUEwIcjC7aIclPmQDKD1hM2Lswi2xhULbfVcceLMaYwAKQE7k4Df0E0LM65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6W+zLbjGVqTmUcIzMagB6mJN9t2K9z/eigePYImBxM=;
 b=kaX4/4Tm8PIf/6r9tM6UQCTW8eIQoOMz1JXvvKP8JWdN1JkB0qm1YJUUVWkEZAk4nW82tIVbrHbwTTxOhgsZilo6h0Xm0h/amb+OllqvCpRqoKPcjAWIHE8g0y/9MO37HCPiqok/ZJ70eyXOUPvxXjAMmltwsoDF9Rhnt1chDhSznUdRwIuc30A+vPqqtqhKLuf4Vj5tss96ovIe8lGOsenR3rCV7lt6X57Bw5gDLy6vTqHzVgrfPWiT8sASZxMX5i/KA/85f1kZ+94fsqJFnasRUpvrCw6tg+ykKNiflxwJZCUixyhx/zDbb83BGO3gjUOG0BPFUquxTM15vWI0SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by BY5PR02MB6882.namprd02.prod.outlook.com (2603:10b6:a03:23b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 11:30:11 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:30:11 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 37/50] wifi: ath12k: add peer.c
Thread-Topic: [PATCH 37/50] wifi: ath12k: add peer.c
Thread-Index: AQHYrmYoGlPGh5U2kEqvzi4XYG2Jia21WUwAgEkS/7A=
Date:   Tue, 4 Oct 2022 11:30:11 +0000
Message-ID: <CH0PR02MB821262DF3ABBBA911E31B1CFF65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-38-kvalo@kernel.org>
 <c5a1b013-d53a-77b3-eaf8-05b5bbc23b0a@quicinc.com>
In-Reply-To: <c5a1b013-d53a-77b3-eaf8-05b5bbc23b0a@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|BY5PR02MB6882:EE_
x-ms-office365-filtering-correlation-id: 003ab370-0d86-41e4-a04e-08daa5fbcc72
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQvQgOzpS1sXeQSFmxWdPfcPGwKAyigffAeDSViJvq4HC+XYMStQkRErPC3loeXp3mdV3i8rpFu0oN70gEmyE3HDMpU9Lp8gcKZOGebtLLoKPHw9GUjrI9T75ZrxlOU0lKShazlvGKNxat0Yujbu/OutPTdnZ1RCYCKB6/1A0TRhvk4Mpfz7fL/na5krJX9LJFZIyLc10C0YUIFxICEt6pdsIEMKoZNRPjTAgKshV4TZ9j2F75x8Melum2La1OwuvWSc2X07tbrvhXlj6ZLHWkc+ZopF8sUEhKsObnF0DSLbD6AVVAZ6XHv8nBAEeinAN+UkQ0n+XAODpkXBY7AxxCTmVMr79c7s0czKfJu95LvFJojt6nRSP40cIP/rR7ZUsgZ8MUIHYFa5Q/VC4HuLrIcVDLjauvAUTIQ902YkJVpqlu4B1E/E9HZWIbcEZa1oMPbUOJpTkVgu4bA5nB7SXGgmwBnxR/QypNQoTBApjn8HDUnnMeTJkgO8ouv7VPYMwrH8QbWTB35Pk6dW+/FOvZpWxx2KFxeH3pC2b5byRwuak4neJu7lVNXfUK3Kkozghwjln40o9EIeVVatxJTpy7uEECIStoDXdSRshvlTVlnXO9ii/NElDAi6RGH6+MY54uCCx+lcfR+r0YU76xA4o8HnVgKAb9BWZoObmquhLxZiG0mtdttxhzDkRmJFMUCXyaDvA1W0EbnJMg64GeptLTaXMhiHEXkiRo/by+i0MevPZ5aRJCA7THNWW2Cp5VGsYho1mxMmXGhpIu4ji91Siw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(6506007)(33656002)(7696005)(478600001)(53546011)(71200400001)(76116006)(66446008)(66946007)(66556008)(66476007)(8676002)(4326008)(316002)(110136005)(38100700002)(122000001)(64756008)(38070700005)(55016003)(186003)(9686003)(26005)(86362001)(83380400001)(41300700001)(5660300002)(2906002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWJGNWQ1aGZKRTN5ZjRHeThZYlJSN0wvTE4rZlZoWDRlTW01bXVyOUZnVm95?=
 =?utf-8?B?cUVRQzdTZ20zZmZaNEJtTGVVTklDZFB1eklhcytmTVJTUkdaNFhkcUwxSFhV?=
 =?utf-8?B?NnB0NmNhN05GVWtEUkJOTUd3NDFRSjAzS0d4dzhJYjAyaGh0VmM2Rm1BQXV1?=
 =?utf-8?B?dk5lai9TTzJuWWtyQlhTU1BUOUhqR3JJekQ4M21nNUJvdjlmOWxTcDl2YzRp?=
 =?utf-8?B?MTZXN0g1MERzRVkxV0VWVittOUw2d2d5WmQrRE1DVWhYM3JxZ1RrYklNbEoz?=
 =?utf-8?B?UHBNNFVQSFBTSFlXTDVuVFNMeC8zcGliakc5MjlWZVQvMDRrbXVlTGI2UFRr?=
 =?utf-8?B?Yk5LTSt0bDVpQWRvSi9PeWhpdkFRbHNsM0d1ZnhRMWIxNWwzd1dUMUFwTlgr?=
 =?utf-8?B?QkZ1QWQycC8ybzFvSmtaUGVzUVJ0TVF0VGRDb1gzSDViNDRnNDFadFE1NExD?=
 =?utf-8?B?dDZwQnRCNjgyaVVUVDVkNDhvM1FZTHVDUE5MMVlqZ0tvQXIrWXpKYmVXMEsw?=
 =?utf-8?B?ZDE1cmlsQXgvSjJzd2d3QmFXTTBpbkxFYnZPYndOcGcwd2QrbERVVytNUS9R?=
 =?utf-8?B?TGhaZDNiRWxybmlLdUlnNGpkRzVweFYrNkNIeHpZMElNVWpENFhCZmU2dnox?=
 =?utf-8?B?K1ZiKzA3ZDFWWXpKVWtBbVZWQ1lrL0RscGd5Tk5TcEY1OGpEMytRcHUyaWUw?=
 =?utf-8?B?ZWhqL3liNEc3eXgyQUNlZzdxeEg4QWhKWTJ1RDRzUXVEaTBicHVsYlBWY1FE?=
 =?utf-8?B?OHFzUm1XYVZBam5Ob3BzNk4yeVJPTStxdXlPK0lEaHk1bWVWVDdRNS81OVY2?=
 =?utf-8?B?MHcrRzhZUE1Cd0tiekU4ODRzMld4SFlNUXhoNkZIZWpQQXd0OUhkMkxHbGtG?=
 =?utf-8?B?clE5T0pvb04yVU5IYWZrQ2tkQWtCNVFadjBDaTFHc0o3ZUsxQ2MxUGU1elR6?=
 =?utf-8?B?bm5tT2taMmErZEZLOG1QQWFVZHhNSHUzNVd1dWxndHV5QnRIRXRINDF2TmRj?=
 =?utf-8?B?eXg1TmRqVnMyZGlWbk1Yb1c4MkdJQ05mN1VuUkNZOEdJYUJQRUh2ZE1pNVM5?=
 =?utf-8?B?S2dsN2hXNUJoQ012L2NkSkNMNmRpRXZ0M1RjUnQ4QjgrRGpRSms0MTFlSGtP?=
 =?utf-8?B?WThMUm1Vanl0R2N6MzBRSmEvZ3pPaFQ0Z25PUjRvakFHT0lhaTFWN1ZGc1Jh?=
 =?utf-8?B?Zm52ZnBwb0hMSlhmV2wxSC9xUVhFMnlDMFhqamkxelhlbUlQNGNQSWVVQkdD?=
 =?utf-8?B?ckpneDU2elFBcHVUZHhjQ0VRbzBTMUVsellnM2txREl6ZGorUERsWVNMQlNO?=
 =?utf-8?B?STkwUytUUG1nUGxrZ2tITm8yamcyYlFOM0pCRjB3cW9oVDJLVkxFUWVvNmps?=
 =?utf-8?B?WTRFNWN0cUJ0WlV2ak0wanRnbVBrc1ozS3RRdHk4RzF5K3Erb1l0NmYrYUJz?=
 =?utf-8?B?N1l4UVB5SmhRNTZGNzZzRXc2Z3VaTldqQmpMOUZhdlBvY1VycURrNmd6b2lo?=
 =?utf-8?B?VXdjZTZ1TGhjWVBkdWpJRTRTeGNiMS95SWxXeDJqbmVHZTNPZ2RySXl1TXYz?=
 =?utf-8?B?TFZTWDIwdU1yMWV4SlVIcW1LelpEQWJKWE5QWlhaSjNUQ1ZQL3U0SGp3RVFD?=
 =?utf-8?B?Q1FsaFRuSVpjbFlmZkNzRm84ekZDS1hzNnM2d2pUSDdPZnZsZGR5VG55K0JN?=
 =?utf-8?B?N2RyYTM4bTYxaU5veFlZSTdYWDJwQ0RyYzByR3pod3JkaFlHVmdBZXYxV2Nx?=
 =?utf-8?B?c1ZvcStnNEFQMHhNbDlpMjFNaGxPM0srMVUyMEExaTZoVG45SUNMS3h5bFNQ?=
 =?utf-8?B?VTQxV09tM3psaXhQWHgzSDZkT1ZyR3hOU1hMRFNHSENDKzZGV2l2ZmhGK2hs?=
 =?utf-8?B?VXpXTnhNY2E1cWZRTVJWSlNhd1V1bU5ndFRPa1lNM3hvb0sxckVxQUlyQWRn?=
 =?utf-8?B?TkhVL1ZNaVByVTBvK2ZXeVo3TWRMVXR6R3hpckgxaXlTNWRHaXFDSnJCN3l4?=
 =?utf-8?B?RXZEZ290ZnQ1eSswZ0haVVBGT21LMFAxbnVZMWtWenYyZzVFNnBTYkZKM1RC?=
 =?utf-8?B?WTE1ekxUNUNVUC9uL280a25PbW1RV1gzamswMG9SSjFqYzZnVGFqMWF2THhU?=
 =?utf-8?Q?Q8H5Yd0KTaNODHF+JX7fvtmI1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003ab370-0d86-41e4-a04e-08daa5fbcc72
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:30:11.1160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gw52v0rzAJ3VulYj8soGPFSnfxkRASQmw118eU+iiVoJWQdbR+uuHu31yK1iySrS2mpMsF7+3B+ZcEbbatZDmD64oUCCgXHKCrGm87/GCys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6882
X-Proofpoint-GUID: YyBNtilHjk6ibSPfZI2aCJv9Ba51zPx1
X-Proofpoint-ORIG-GUID: YyBNtilHjk6ibSPfZI2aCJv9Ba51zPx1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=970 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210040074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEpvaG5zb24gPHF1aWNf
ampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDE5LCAyMDIyIDU6
MDQgQU0NCj4gVG86IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13aXJlbGVz
c0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGF0aDEya0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMzcvNTBdIHdpZmk6IGF0aDEyazogYWRkIHBlZXIuYw0KPiANCj4g
V0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFsY29tbS4g
UGxlYXNlIGJlIHdhcnkNCj4gb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90
IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiA4LzEyLzIwMjIgOTowOSBBTSwgS2FsbGUgVmFsbyB3
cm90ZToNCj4gPiBGcm9tOiBLYWxsZSBWYWxvIDxxdWljX2t2YWxvQHF1aWNpbmMuY29tPg0KPiA+
DQo+ID4gKFBhdGNoZXMgc3BsaXQgaW50byBvbmUgcGF0Y2ggcGVyIGZpbGUgZm9yIGVhc2llciBy
ZXZpZXcsIGJ1dCB0aGUNCj4gPiBmaW5hbCBjb21taXQgd2lsbCBiZSBvbmUgYmlnIHBhdGNoLiBT
ZWUgdGhlIGNvdmVyIGxldHRlciBmb3IgbW9yZQ0KPiA+IGluZm8uKQ0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogS2FsbGUgVmFsbyA8cXVpY19rdmFsb0BxdWljaW5jLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvcGVlci5jIHwgMzQzDQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDM0MyBp
bnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
YXRoL2F0aDEyay9wZWVyLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsv
cGVlci5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjMwZmZkYmJkY2M3Zg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTJrL3BlZXIuYw0KPiA+IEBAIC0wLDAgKzEsMzQzIEBADQo+ID4gKy8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0QtMy1DbGF1c2UtQ2xlYXINCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IChjKSAyMDE4LTIwMjEgVGhlIExpbnV4IEZvdW5kYXRpb24uIEFsbCBy
aWdodHMgcmVzZXJ2ZWQuDQo+ID4gKyAqIENvcHlyaWdodCAoYykgMjAyMS0yMDIyIFF1YWxjb21t
IElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCByaWdodHMNCj4gcmVzZXJ2ZWQuDQo+ID4gKyAq
Lw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgImNvcmUuaCINCj4gPiArI2luY2x1ZGUgInBlZXIuaCIN
Cj4gPiArI2luY2x1ZGUgImRlYnVnLmgiDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYXRoMTJrX3BlZXIg
KmF0aDEya19wZWVyX2ZpbmQoc3RydWN0IGF0aDEya19iYXNlICphYiwgaW50DQo+IHZkZXZfaWQs
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1OCAqYWRkcikg
ew0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtfcGVlciAqcGVlcjsNCj4gPiArDQo+ID4gKyAgICAg
bG9ja2RlcF9hc3NlcnRfaGVsZCgmYWItPmJhc2VfbG9jayk7DQo+ID4gKw0KPiA+ICsgICAgIGxp
c3RfZm9yX2VhY2hfZW50cnkocGVlciwgJmFiLT5wZWVycywgbGlzdCkgew0KPiA+ICsgICAgICAg
ICAgICAgaWYgKHBlZXItPnZkZXZfaWQgIT0gdmRldl9pZCkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICBpZiAoIWV0aGVyX2FkZHJfZXF1YWwo
cGVlci0+YWRkciwgYWRkcikpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0K
PiA+ICsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBwZWVyOw0KPiA+ICsgICAgIH0NCj4gPiAr
DQo+ID4gKyAgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1
Y3QgYXRoMTJrX3BlZXIgKmF0aDEya19wZWVyX2ZpbmRfYnlfcGRldl9pZHgoc3RydWN0DQo+IGF0
aDEya19iYXNlICphYiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1OCBwZGV2X2lkeCwNCj4gPiArY29uc3QgdTggKmFkZHIpIHsNCj4g
PiArICAgICBzdHJ1Y3QgYXRoMTJrX3BlZXIgKnBlZXI7DQo+ID4gKw0KPiA+ICsgICAgIGxvY2tk
ZXBfYXNzZXJ0X2hlbGQoJmFiLT5iYXNlX2xvY2spOw0KPiA+ICsNCj4gPiArICAgICBsaXN0X2Zv
cl9lYWNoX2VudHJ5KHBlZXIsICZhYi0+cGVlcnMsIGxpc3QpIHsNCj4gPiArICAgICAgICAgICAg
IGlmIChwZWVyLT5wZGV2X2lkeCAhPSBwZGV2X2lkeCkNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+ID4gKyAgICAgICAgICAgICBpZiAoIWV0aGVyX2FkZHJfZXF1YWwocGVl
ci0+YWRkciwgYWRkcikpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ICsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBwZWVyOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+
ID4gKyAgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0cnVjdCBhdGgxMmtf
cGVlciAqYXRoMTJrX3BlZXJfZmluZF9ieV9hZGRyKHN0cnVjdCBhdGgxMmtfYmFzZSAqYWIsDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHU4ICph
ZGRyKSB7DQo+ID4gKyAgICAgc3RydWN0IGF0aDEya19wZWVyICpwZWVyOw0KPiA+ICsNCj4gPiAr
ICAgICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZhYi0+YmFzZV9sb2NrKTsNCj4gPiArDQo+ID4gKyAg
ICAgbGlzdF9mb3JfZWFjaF9lbnRyeShwZWVyLCAmYWItPnBlZXJzLCBsaXN0KSB7DQo+ID4gKyAg
ICAgICAgICAgICBpZiAoIWV0aGVyX2FkZHJfZXF1YWwocGVlci0+YWRkciwgYWRkcikpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAg
IHJldHVybiBwZWVyOw0KPiA+ICsgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIE5VTEw7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0cnVjdCBhdGgxMmtfcGVlciAqYXRoMTJrX3BlZXJfZmlu
ZF9ieV9pZChzdHJ1Y3QgYXRoMTJrX2Jhc2UgKmFiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaW50IHBlZXJfaWQpIHsNCj4gPiArICAgICBzdHJ1Y3QgYXRo
MTJrX3BlZXIgKnBlZXI7DQo+ID4gKw0KPiA+ICsgICAgIGxvY2tkZXBfYXNzZXJ0X2hlbGQoJmFi
LT5iYXNlX2xvY2spOw0KPiA+ICsNCj4gPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBlZXIs
ICZhYi0+cGVlcnMsIGxpc3QpDQo+ID4gKyAgICAgICAgICAgICBpZiAocGVlcl9pZCA9PSBwZWVy
LT5wZWVyX2lkKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcGVlcjsNCj4gPiAr
DQo+ID4gKyAgICAgcmV0dXJuIE5VTEw7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0cnVjdCBhdGgx
MmtfcGVlciAqYXRoMTJrX3BlZXJfZmluZF9ieV92ZGV2X2lkKHN0cnVjdCBhdGgxMmtfYmFzZQ0K
PiAqYWIsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGludCB2ZGV2X2lkKSB7DQo+ID4gKyAgICAgc3RydWN0IGF0aDEya19wZWVyICpwZWVyOw0KPiA+
ICsNCj4gPiArICAgICBzcGluX2xvY2tfYmgoJmFiLT5iYXNlX2xvY2spOw0KPiANCj4gdGhlIG90
aGVyIGF0aDEya19wZWVyX2ZpbmRfKigpIGZ1bmN0aW9ucyBleHBlY3QgdGhlIGNhbGxlciB0byB0
YWtlIHRoZSBsb2NrLA0KPiBidXQgaW4gdGhpcyBvbmUgdGhlIGZ1bmN0aW9uIGl0c2VsZiB0YWtl
cyB0aGUgbG9jay4gd2h5IHRoZSBkaXNjcmVwYW5jeT8gc2hvdWxkDQo+IHRoZXNlIGhhdmUgYSBj
b25zaXN0ZW50IGludGVyZmFjZT8gbm90ZSB0aGF0IHRoZSByZXR1cm5lZCBwZWVyIHdvbid0IGJl
DQo+IHByb3RlY3RlZCBieSB0aGUgbG9jay4NCj4gDQo+IG5vdGUgaSBzZWUgdGhpcyBpcyBvbmx5
IHVzZWQgaW4gb25lIHBsYWNlLCBhbmQgdGhlcmUgaXQgZG9lc24ndCB1c2UgdGhlIHBlZXIsIGl0
DQo+IGp1c3QgY2hlY2tzIGlmIGl0IGV4aXN0cy4NCj4gDQo+IHBlcmhhcHMgcmVuYW1lIHRoaXMg
dG8gYm9vbCBhdGgxMmtfcGVlcl9leGlzdHNfYnlfdmRldigpIHRvIGp1c3RpZnkgdGhlDQo+IGRp
ZmZlcmVuY2UgaW4gbG9ja2luZz8NCj4gDQoNClN1cmUgd2lsbCBhZGRyZXNzIHRoaXMgY29tbWVu
dCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0KDQo+IA0KPiA+ICsNCj4gPiArICAg
ICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHBlZXIsICZhYi0+cGVlcnMsIGxpc3QpIHsNCj4gPiArICAg
ICAgICAgICAgIGlmICh2ZGV2X2lkID09IHBlZXItPnZkZXZfaWQpIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgc3Bpbl91bmxvY2tfYmgoJmFiLT5iYXNlX2xvY2spOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gcGVlcjsNCj4gPiArICAgICAgICAgICAgIH0NCj4gPiArICAg
ICB9DQo+ID4gKyAgICAgc3Bpbl91bmxvY2tfYmgoJmFiLT5iYXNlX2xvY2spOw0KPiA+ICsgICAg
IHJldHVybiBOVUxMOw0KPiA+ICt9DQo+IA0KPiBbLi4uXQ0KDQpUaGFua3MNCkthcnRoaWtleWFu
DQo=
