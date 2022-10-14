Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31915FE717
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 04:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJNCoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 22:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJNCoJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 22:44:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC05197FA2
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 19:44:06 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E21hKU010167;
        Fri, 14 Oct 2022 02:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=SiJavFvYpHpb1WSdfYjeqbfWKoBhio6hkwqsD4Vk2uE=;
 b=fpv06Zw9qVfhMKN+gGRpRePLgYtITIULkiMEd+SJNl+TUB7OL8rweNPGndBrBtG0e23p
 ecppCivP+LIi+aZZjX4eeiOfCQ8HSw2oa6os+2Tm2MrhAmgEEm3op5tMze0ho4376GGC
 wgLQctu2JCo+kyn80w79GaOx+3M8ybPJyzZIGq3PALAoUujtX9ON6yrmONPl1PRgYW4H
 Ln8JO+nwbxEKGwXoJyZnHvdgE2A3tANMTHJwQZ8Fx1R1z25haCPWUlm7zJjO7+IhnfBQ
 D/7P74MJ+z0/sJIB4bxLgJzvIeTFlPM2RlwDSpCGwBNuQ7uQEf9pg34CaLr+ci/LghLd 1Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6pg4h4y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 02:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFSyRmg6R3gHBt1Der696A8W4ML6BL8yIloQ4r0BoHeI3cTwglio3vTvq1uLPWEH2uwUopEWOAlpsXXwtByiwPDEpysSe53KkGZi2mZeiFaqSnCzQ+gK9IWGdBD5fTSSRlUcbQqZsGEQBovbY9j1Z8mW1aApK/xWfw1428AiYQduSJuiDeGRzkTBHMwAko81xFiVs4/H6gfzHtlNxteIPt7Ezjkb8bJsPB2a8kXFN/wMvUx/SjWNXPnv5VM2uYQu42iYgqvEZKxYdKkims+0/frdk4vWUbds85uhY6hetGaLk8m1v2GtgXGa9TlZH+dk5vSeYI0YUxV2FSKtMQxbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiJavFvYpHpb1WSdfYjeqbfWKoBhio6hkwqsD4Vk2uE=;
 b=PgVnG/YjRAReTLLZ0F4dnqcBGqRsFpwuEk5MEufNRDrEk8J+bgUybUqzSVlP8vuI2fjGkTvzJT+DU5924iJnRDj5QZdlFwCzzohvEobr4cRJqPN+TIqB1SAjm0XLez2v67En93JOKZbauZRb8oc9qeLwedYWdJqvUbuMeA6MzUxLs+jP1Hb5HamC+hW+vc6FqY7y1t2rkK+HYjcYNJntgc4McXpFCEHNE6cfv5uC1U4Azo1i07RPsY1kN/bDL2TsCHxtuUoCKVvy7G78PbNfrC4lhAnuQvJKoPv5PHK+54HCj1GSy65COsVJdEXgXEE3r3noqcqKNf4TqjT3stIJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by PH0PR02MB7558.namprd02.prod.outlook.com (2603:10b6:510:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 02:43:56 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 02:43:56 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2zws4AgFgFrRCAAHrdgIABTV2A
Date:   Fri, 14 Oct 2022 02:43:56 +0000
Message-ID: <SN6PR02MB4334B3501B6CBC630C4DA7F6F7249@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
 <SN6PR02MB433498DC221CF70BE3B6CE63F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
 <0e4a896d-1d57-166b-9cef-fd551d22464b@quicinc.com>
In-Reply-To: <0e4a896d-1d57-166b-9cef-fd551d22464b@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|PH0PR02MB7558:EE_
x-ms-office365-filtering-correlation-id: 290d67a5-9d74-4c60-0d5a-08daad8df073
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXEdaeGkaVe7cC1FFp3AVvdD/VTgC6pxjRMDki9tx5xXml0nQ/hT9zQmCuaSMwR1vfKMOSfXPX6LoBPAYvf3pNcU5HB72kn27zGHjNnLUuIjJg2SminAprjJ3J/tnRM16ZtSE1ChNnD9Bp/8bYCg0O7L2+Ga/tWN9ZD2oL18CCZ8qyEa7xEdd33QsuqM4klbzQL54BmV5ccFEz8UmT7B678t2lWcmcqy+v2UjxveOgwUkiQKEPUQySoyvuWx664QluUBTZT2nI8M0yFJqt3sGFEujRw7lw9MYY2Mtz4FpJ+UEy56ISaxbrJTwJnSC6ad+KslChhnRaIWo69EROKwHVDR6POwjt6EupPp2cw24iwLT9h7UOhnRdBpp6SXNT1HAtCDK4ADlbXidwY0g6EFL4XtMGDDY4C631h3SFvFgd3ExjavMXEHjQdKIBMYxvcZN2YGq2e0Zd/NerUFOI6FqzdiM4ayQRvGHFaXyRf5GpM/Y3u9scttj0ZGB5KEsLik4qmLL9FYntlLhKoAqTxhD385kyKjqz4lzeuA9/J+dC7zYdOGNm4bB6ktw6eewetlSfI+2nzKRlXzxAVVb65tIKC1Bk4GORlLVE5GFg2ktDyHyYGnqd9CrDe2a1x53iQYF/Eo+HA7orLg0XGTGocqkFwEsOO3fRbvtiYS8IIJaVNH2rp0ZhAWCfFL/CsqVxmwsZIBalYZEzAqffrGnV/Xqj6D85MgKjGdFCoImJdYaA+mLSi5c3MBfoVDuGzISLqvbWcVSy7dNSXlxRjNckW3Bw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(5660300002)(7696005)(2906002)(186003)(6506007)(41300700001)(9686003)(52536014)(26005)(8936002)(33656002)(38100700002)(38070700005)(86362001)(55016003)(122000001)(83380400001)(316002)(110136005)(76116006)(478600001)(66556008)(66476007)(64756008)(8676002)(4326008)(66446008)(71200400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWJEUllLalZhaUFmR2tnUWNpdEczaVRLUGFVSnJUWlZlS0dFc1NwdkNjY25O?=
 =?utf-8?B?aVF0L2U1Rytud1VHbG5sZjdqaUs1aUhvK3hHdUtmZWtVN1lNQzd2a1dwRUtH?=
 =?utf-8?B?NDFiZWVPWmRnVmdYbSsxSVdKKzJBZGpqeVRqVEM3WUVFTW9uQzlLd1dsb0Jo?=
 =?utf-8?B?aEMwWDV1R243ZDBtbFBWSTArd1gwazF0dFpCSGtaZThMOElTVGxXTm9RT3dS?=
 =?utf-8?B?SGJ6eklTUXM2b3ZFSjZOZDhESk9QTVhzM3o0amZTVWtidlAyb29PQkFpK1Q0?=
 =?utf-8?B?SWtXOU8rODh3SnlMVkxZaXhFb1BlN3NaNVZ5dmVySzkvSHByMG5UcTlUSHZG?=
 =?utf-8?B?NmxCRXUwMWF1Szd5TXFrOTFSaUY2blk5c2tKSUFWTzF0c20rcWZXbVFuQ1JT?=
 =?utf-8?B?cW1CRDRhVVViVXNNM0UxQ01ZVWwxRHN3NzQ2VEtnWkc5eDVwUlZDSVE5bXRo?=
 =?utf-8?B?WXBJdnpFY09SSU5QWHIzd0x6TzFrMXF6c2J3c016Y2EyWGxkTkVWK01lMGY5?=
 =?utf-8?B?ZHY0WENiQzR1M05zamUvWEpPbU1EYU96Q1F0U3k1YWhiZzBFTEkzTkl3Y2t3?=
 =?utf-8?B?aXdtcjQ2eDVVT2Y4VDZvenVKTGIzYmVxWkVaSWVYOXUwa0xMUmkzYnNWTWIz?=
 =?utf-8?B?aVFYUFF1QVk0ZGpXNGdhZDJIMjUzSC9RQTZFeW5IQyt0MEN0QXJZRkQ5ZWsx?=
 =?utf-8?B?R0d1SGtRL202QmR5SUJ2cDdnVFptVFA0MUxIQ0JyZ1FNM1BZKzRmYmpKaTds?=
 =?utf-8?B?WGZLbTV5MlpMK1NRMDVWZkZqWGFtWHJXOWVwdjJvcFE2dTBoNGFIQ3ptai8y?=
 =?utf-8?B?VlExd1MzV2UxR2VZMnRtTGN6aEo5eGVCK2dabzBVYWhTWEVuNXZmcHhkeUdw?=
 =?utf-8?B?VW0rUm5nOUNJSTdWWHJaeXpYYVJ5SVRqaDQvRmVxVUxYdi9HeXdKSW5SYkpM?=
 =?utf-8?B?WVVHRlZsUnErZVMyNHJYK1k2RzFGU1NzM0R4ejc2VEZLWnB0QXdoNzJjYndC?=
 =?utf-8?B?ZHdmY2wwQm5yc0J6UW83SzZzOFFLYzlsRGhCZHFjeFZTTzdWMHhCamg4cndq?=
 =?utf-8?B?dmRCSzlpWlVIbDJrRzZOekkyTDFYWGs3MFNSS0NmMi9SOEFGUHE2MDNPdTFQ?=
 =?utf-8?B?OU5Pam9yVHNSQzh0TGdNdmhSSTVaWnRnNkcwUmgzbUVoU050MmNqTWdIR0ZW?=
 =?utf-8?B?UXZ3VGF1d1gycXBGMGtOVWY1Mjl2OEg1c1dVOU9MU3VSeEU1TjZoNW5jTDRz?=
 =?utf-8?B?MmpFODBaSmdIZzhuSlN3dUcwaHpPaUkxdVQyKzBIUXFzT3NMTWRIb2p2VWRU?=
 =?utf-8?B?Vk9MdWZlbjF3eGNLcVJ0MnpsZnVVS1JZeFh5TXBDUTVuV0VvajNIZEdzUzZ3?=
 =?utf-8?B?Nk1CVXpSUnFuQ2ZpenlXQytwVlhpQ1kyV2lUMUwwYlVuUXVaZ3dyaGhMcC9G?=
 =?utf-8?B?eFJKVEpKY2Z6SlFtbXZqYWhBYm9nR0taSGw0VjYwRW8yL3FVcG16QUlrak41?=
 =?utf-8?B?aDBubko5YXZRNXoxSndoYW1YZHhhbGFIblN3cVVFeWF6WlJmdEIxNHNtaXlY?=
 =?utf-8?B?bHF2bXJoS0xHWms5QWNGdU1ZUUtJWElnTzd5ZlNOUGNKYk56dEhONytQK1M4?=
 =?utf-8?B?YVBTYngrdnhLRFk1ZmZIU0xFU0wrenBFNGxiSHlrM3RZbHdzVUcrMUN5TVZE?=
 =?utf-8?B?b2xrWmZHaVMzVytmU0Vla2lFSHhIYjdJalBudTJ3blEyeE9VR2NhbWdPZllW?=
 =?utf-8?B?ZHdUbndtUkVleVpXa1NCWHNodnhyOXpzVVU2ajVKc2kzMjluWUNIOFZZakly?=
 =?utf-8?B?L3JncDVFRC9SQUZQTzRUVnp2azYxb1pZMFp2Smc2MGxzM1JvMWlrK1JOVmJ0?=
 =?utf-8?B?dmh4VWRnM3U5NGdRS2VRYmV4dXNsSUhHVitXVUw3RXNVbmJsS3NnYkxKVWYr?=
 =?utf-8?B?bnRhTzAzekZYQTZQdDRQejI2MzV0N1BWNExVY0VvZURoZlhucFYranNPSlNj?=
 =?utf-8?B?dEgrN3MvOVQ3Ulk4MTA3RVJYTEk5S2xmdkh4TGVaSmsxMFp2WnowSXFjQ2cr?=
 =?utf-8?B?a3J5aVM3L0lZLy85SlA5RjVadWZQMWprT3NkWGllaFd1cG0raElqZE9vdktm?=
 =?utf-8?Q?a4KyYVTHmkcLqFKWWZ6tE5PQA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290d67a5-9d74-4c60-0d5a-08daad8df073
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 02:43:56.2099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qzsr/WhcRjBHr/Bv9fTOntAk1gnf5jj+V9I+J7I41qEcPEgch6UhXDiiwnnEdtWCEkxPNwhcVQgEBHhw06/sKqpuxKWH8SrvJ2gJKfuS7KY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7558
X-Proofpoint-ORIG-GUID: EC_8tM3FQLIabetSSJBuS55xIIhZopAK
X-Proofpoint-GUID: EC_8tM3FQLIabetSSJBuS55xIIhZopAK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_10,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=612
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140013
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVmZiBKb2huc29uIChRVUlDKSA8
cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgT2N0b2JlciAxMywg
MjAyMiAxMjoyMCBQTQ0KPlRvOiBTcmlyYW0gUiAoUVVJQykgPHF1aWNfc3JpcnJhbWFAcXVpY2lu
Yy5jb20+OyBLYWxsZSBWYWxvDQo+PGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13aXJlbGVzc0B2
Z2VyLmtlcm5lbC5vcmcNCj5DYzogYXRoMTJrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0
OiBSZTogW1BBVENIIDE1LzUwXSB3aWZpOiBhdGgxMms6IGFkZCBkcF9yeC5jDQo+DQo+T24gMTAv
MTIvMjAyMiA0OjM5IFBNLCBTcmlyYW0gUiAoUVVJQykgd3JvdGU6DQo+Pj4+ICsgICAgIGVsZW0g
PSBremFsbG9jKHNpemVvZigqZWxlbSksIEdGUF9BVE9NSUMpOw0KPj4+PiArICAgICBpZiAoIWVs
ZW0pDQo+Pj4+ICsgICAgICAgICAgICAgZ290byBmcmVlX2Rlc2M7DQo+Pj4+ICsNCj4+Pj4gKyAg
ICAgZWxlbS0+dHMgPSBqaWZmaWVzOw0KPj4+PiArICAgICBtZW1jcHkoJmVsZW0tPmRhdGEsIHJ4
X3RpZCwgc2l6ZW9mKCpyeF90aWQpKTsNCj4+Pj4gKw0KPj4+PiArICAgICBzcGluX2xvY2tfYmgo
JmRwLT5yZW9fY21kX2xvY2spOw0KPj4+PiArICAgICBsaXN0X2FkZF90YWlsKCZlbGVtLT5saXN0
LCAmZHAtPnJlb19jbWRfY2FjaGVfZmx1c2hfbGlzdCk7DQo+Pj4+ICsgICAgIGRwLT5yZW9fY21k
X2NhY2hlX2ZsdXNoX2NvdW50Kys7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgLyogRmx1c2ggYW5kIGlu
dmFsaWRhdGUgYWdlZCBSRU8gZGVzYyBmcm9tIEhXIGNhY2hlICovDQo+Pj4+ICsgICAgIGxpc3Rf
Zm9yX2VhY2hfZW50cnlfc2FmZShlbGVtLCB0bXAsICZkcC0NCj4+cmVvX2NtZF9jYWNoZV9mbHVz
aF9saXN0LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdCkgew0KPj4+
PiArICAgICAgICAgICAgIGlmIChkcC0+cmVvX2NtZF9jYWNoZV9mbHVzaF9jb3VudCA+DQo+Pj4g
QVRIMTJLX0RQX1JYX1JFT19ERVNDX0ZSRUVfVEhSRVMgfHwNCj4+Pj4gKyAgICAgICAgICAgICAg
ICAgdGltZV9hZnRlcihqaWZmaWVzLCBlbGVtLT50cyArDQo+Pj4+ICsNCj4+PiBtc2Vjc190b19q
aWZmaWVzKEFUSDEyS19EUF9SWF9SRU9fREVTQ19GUkVFX1RJTUVPVVRfTVMpKSkgew0KPj4+PiAr
ICAgICAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJmVsZW0tPmxpc3QpOw0KPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgZHAtPnJlb19jbWRfY2FjaGVfZmx1c2hfY291bnQtLTsNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2JoKCZkcC0+cmVvX2NtZF9sb2NrKTsNCj4+
Pj4gKw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgYXRoMTJrX2RwX3Jlb19jYWNoZV9mbHVz
aChhYiwgJmVsZW0tPmRhdGEpOw0KPj4+PiArICAgICAgICAgICAgICAgICAgICAga2ZyZWUoZWxl
bSk7DQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tfYmgoJmRwLT5yZW9fY21k
X2xvY2spOw0KPj4+DQo+Pj4gaXMgdGhpcyByZWFsbHkgYSBzYWZlIGl0ZXJhdGlvbiBpZiB5b3Ug
dW5sb2NrICYgbG9jayBpbiB0aGUgbWlkZGxlPw0KPj4+IHdoYXQgcHJldmVudHMgdGhlIHRtcCBu
b2RlIGZyb20gYmVpbmcgZGVsZXRlZCBkdXJpbmcgdGhpcyB3aW5kb3c/DQo+PiBUaGUgcmVvX2Nt
ZF9jYWNoZV9mbHVzaF9saXN0IGlzIHVzZWQgaW4gb25seSB0d28gY29udGV4dHMsIG9uZSBpcyB0
aGlzDQo+PiBGdW5jdGlvbiBjYWxsZWQgZnJvbSBuYXBpIGFuZCB0aGUgb3RoZXIgaW4gYXRoMTJr
X2RwX2ZyZWUgZHVyaW5nIGNvcmUNCj4+IGRlc3Ryb3kuIEJlZm9yZSBkcF9mcmVlLCB0aGUgaXJx
cyB3b3VsZCBiZSBkaXNhYmxlZCBhbmQgd291bGQgd2FpdA0KPj4gc3luY2hyb25pemUuIEhlbmNl
IHRoZXJlIHdvdWxkbuKAmXQgYmUgYW55IHJhY2UgYWdhaW5zdCBhZGQgb3IgZGVsZXRlIHRvDQo+
PiB0aGlzIGxpc3QuIFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGF04oCZcyBmaW5lLg0KPg0KPnBs
ZWFzZSBhZGQgdGhhdCBhcyBhIGNvZGUgY29tbWVudCBzaW5jZSB1bmxvY2svZG8gc29tZXRoaW5n
L2xvY2sgaXMgYQ0KPiJjb2RlIHNtZWxsIiBzbyB5b3Ugc2hvdWxkIGp1c3RpZnkgdGhlIHNtZWxs
DQpTdXJlIEplZmYuDQoNClRoYW5rcywNClNyaXJhbS5SDQoNCg==
