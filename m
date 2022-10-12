Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177955FCEF0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 01:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJLX3Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 19:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJLX3O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 19:29:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A607139568
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 16:29:14 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CLpRRL004509;
        Wed, 12 Oct 2022 23:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=kOwSwsnZCe9mHISysMtRGnEXhDUoKwXlqHCHcQ42fO8=;
 b=mcwv1AT0NUojfRsDh722iZA0jmvV+GRQyHWeIp7wnvmV4uUKCBxJXPD+nH2dQYmlfA8O
 vPtl6gaTHF8ieMMpfghhd5yM798V6BBIezKvttF6L5DOWyIErVgYVd/GUMogP4og94IC
 +/ozCm5FowQAO3xoYNjPlkMxZ9o6Aq+Ew84Omjl4mOZd4oEkNbrj0dI7Ly6VXHDd8bOZ
 rgZ7DSo7fknVmOVsMKbn3gICDBUSecT5hMARD/NJY6GiWcXTDzcOtHihhzxWtP1wohz1
 PdnBSVCi+Iks803P2nbfZo5avcshr19A1wLL5a3Q5Lii74ZNjihGKOsWvpsziB+ncXa5 tw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k643h0hcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 23:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwLbcVEqnarXRRoYj+jqM5MGKPW9OjqUAi9DL6lgXkrtsJ/9QfbhGJIz6yW4TXSjuNO0xAoBrcCVJf+iNb2975RDHzTS9gyqkLj/GkWYJD6BqIC7hQvb7N/xRSRABLm59HTb+Gb3uWOZ00JuKPPwLaTV7DBYxLq6p/MMjaKR+dOQJmvJlhuuZsjJXcfCrnawsIu0uy8n4Qv5N1bN7KPT1wFWu2DKettKxLZwhXHJHUde3N1K51vj6Osxpcp9SQZP1f5LmHwybSIj03hz17AcuAQd/e2aYDRDkkHzrBYkjFA55LhyvPjat1fA+2w4bTj0kyQwK7XIamkLUSK919H/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kOwSwsnZCe9mHISysMtRGnEXhDUoKwXlqHCHcQ42fO8=;
 b=HjGgHI0DpbdwPJgoq95UehC2iLXr2xAQSEU978lGJ8oR7zCS3xKFHxJKNc3zLUI5j3+e/bOYNcsIJO3o/oGkdGgIoJCp5Pmf79a9sjC5QfXoLdiyZ1WwGG+670NFg0ELLGUusjj7MxQHW4TwQwp+K8H0s6+0Utd4pHnGZZegcIR3EG++57+P3Idauz3cTHGLJt2znUXRcHlghpfVlB9Pe4Ki7e5/pPGnMxKXnUyH/ZtZNspKTi+sf/D92ugNyHaouHxe0bsetqtTMiNwSxIJeZcLBISlm6t/dbS1qOUvvoRJrZoIv2iwMC2k0EJR8eOG8KCg/J9RyMiSM7LYDFTt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by MN2PR02MB6832.namprd02.prod.outlook.com (2603:10b6:208:1d8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 23:29:08 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:29:07 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2yRiIAgFmBm/A=
Date:   Wed, 12 Oct 2022 23:29:07 +0000
Message-ID: <SN6PR02MB43342E0EDCE5420D93DD1EC7F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
In-Reply-To: <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|MN2PR02MB6832:EE_
x-ms-office365-filtering-correlation-id: 104eb78e-a2bb-4a05-d646-08daaca98f33
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Hfvuh/73xxYH+xV6cLoykTmNzUiC1fCNkp4/YQdSrEIWUUWGdZszx5hIQFqbE14K08lKhlhOH10B1iv6IK/n4cNI7qxJd1Yv117lYeqgVfUE1HimtnW6LV3xMGZQca+lo00+gxRwRLR5GYUX7imnKf2Gxv2bVUyeSZ8N3NbYD1Fdx/3S4llfvAKkjZ+FgL98ypRCXjbDrR0XCzdPhrU+N0nnkcoSO4UVeA3BX5eoq1lnxQOJpKWe+sWHEuz7O6wRmyXjhfwuzQsWrnbsK/mDcDVl5PgAjKW0kLEUz7/Gm4XbbplmALy909oYrqvB5kcV8+18l9wq77Q5UgpBUzpaG6Oe3paZ2c/y/FQLnAeSNC+541nc34CEqhBrP82ojXE/g9Ya2xSqqAkLTcsUJXp1WnQg4B8N/Dk6MDNHFiCTupgms/qyDe2gBjCiiBpYegrP6wzKSH/1j4VX+Ot+dn+SEqi2fjluqD3izb4UR8xjOfC8uxopNXxV9Zt2BoJqXZpscdT9e9CowqPxs7mvDJqpYglAGYDY7CuCOoaL7mOpvt7Wi/yeRcdIaQYiASr/cB9sMP+M0g/tFmMn7N8eGZ1sV+oFnX8iF0K7+7a1Vh0GpcDOK2kHtBR1Cnk2TOlexAfPb3lla7ewe3tu6wbEc5pxKBwmV0BY02rfdEODFXfqtMfSMLFeoWgbk1edhqPuMEc+dgDFlCFekQ2VQGb9YDQz76Kc4NzaQyK7hTuoKGNSX8rG3NBfrYvQJTE9i5XamyHQOIy6U7ibANTbhy89yRCcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199015)(66446008)(52536014)(66946007)(38070700005)(66476007)(4326008)(8676002)(110136005)(64756008)(26005)(8936002)(66556008)(33656002)(76116006)(478600001)(6506007)(7696005)(122000001)(41300700001)(38100700002)(86362001)(55016003)(4744005)(2906002)(9686003)(71200400001)(316002)(186003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTVDdzk4RGZYQWx1NFFsbDFzeFUvdzd1U201OHJ4K1ltMlo1cjZwSXZyV1VB?=
 =?utf-8?B?Q3VnSXVyVGFTUnBYUXR5SXF0UHpxNFF0RldleXlKY2h5MS9KeWJraWo1Vyt6?=
 =?utf-8?B?MDA5S3NCK080NEYxeFFPN2xYWnV5Zk15YWJlZzhZMjJZbFAyMW5qOXM3MFQv?=
 =?utf-8?B?SHVQaitwWUFpa0hmU21nYnRnSWlSZHY5SEUrbTNwTVpzMzBJcFBrTmtaZDBH?=
 =?utf-8?B?dUdYOUpCUnJGQ3N4Sjh2NlAxT29Bc2xwb3hUamtQUWZVK1M4S1IxMUtOQlAr?=
 =?utf-8?B?QXdIYW9aWUVuV0FTcFZnS1Q0NGlSWjBQdkl2VE9IV2RsZVQ2UnZmRGl4L2ZK?=
 =?utf-8?B?aThFQ2pQMllONnY1aXRTdmVBSUlVbm9QeitBb0JsMENhNlF0cEVEdzhrSC9k?=
 =?utf-8?B?RlJDTndveEg2TzNiZGloNjNvYWNUcUdxSVlqeW96bDRiMVhpalBnQ2pkMzF0?=
 =?utf-8?B?TGRTVHNoMWVCQUF4Njk5MWZFRzlGTDMxNHgxNTNQWDFwd1dPZkx2TjVvTHFN?=
 =?utf-8?B?QWV4OE14QVI4YVczNU1PZjEyN3lPd29DNDFEVTV6ZU1vV0o1M0hSU05QV0Jy?=
 =?utf-8?B?dWY2bzB1cENjSkw3dk9zMWJlUVlUdG9zZktkYmg5RjJCWXgyajk0ZU9IVFN6?=
 =?utf-8?B?QUNIQzNHbUxvaGRsYVdwZ3B1d1JWN1J3cWlycWNWc0JYSWt5dlBIQVNoUTRi?=
 =?utf-8?B?Vi9yTWNoYTNHM1lGckNSV21uZ1FNUWoyc3ZsTm5CbUJjY3JDam15S2V6OXlG?=
 =?utf-8?B?VnZxWlFLME5ReXlsQU9jY3BMQk1SNjhCcGpUUG5KV0U3SGg4d2svSjZtTG5F?=
 =?utf-8?B?TDlQWlJHKzFiemE0cWZXWlBveW4rdzZCZHB5YjdIZ2ltRk15dlhEeDJBMytD?=
 =?utf-8?B?bnpIaHhIcjVMdWtNcnplSFpxY3Z6UmcyeEpEdHFZbE4ycDBhbndmZGd4N0o4?=
 =?utf-8?B?bzRkeGFSOHA2Zm9SUDhRcktPbUZhclA5UkM5N3owV1VjaXRXVS90N1BkSjAv?=
 =?utf-8?B?S2dPa2NxYm1ON0hQMjQ0S1JyckVnTlg2OE9UUU8raGlqZlhneVZ5ck1RVXZu?=
 =?utf-8?B?QzFza0Q2MWlLaS8wN2s1SVc1bXNJQzB2R1JtczlwWUhLRXAyM012LzZTcGtn?=
 =?utf-8?B?Y3RpOEpyWHRwc0k0bFg1bElpa3RiaGJCNzRNbGVBWG05S051bmZYanRBOUxY?=
 =?utf-8?B?TEQvdDlrczl3SnE1djJkRWNpY0NjOHBPaWtLdFdwNUFqOVNQQm9WL0hUSjgy?=
 =?utf-8?B?MURYS2JFaDhKT0xiaGVtRGFncVoxd0UwRFgxYlBUWlE4bjVBdGtrUlNvZGQy?=
 =?utf-8?B?S1NwdXZxcmQ5VUVrcnd3MVR1VUJhYm1KbERPbVI0VHA4LzE4YVd5S3JiaEpp?=
 =?utf-8?B?bFdBZ0JvR2dyR3BqV1M1UERZSUIyRDV3UnBzeWJUUmZ3LzRLbTk3NmVsN0dM?=
 =?utf-8?B?OFZRNk5TNURiWGRORTdOZ1c0OGIyclFGVXNyQWZYeC9aWkthLzlOTmRmVFdS?=
 =?utf-8?B?eU1JNXBERDFBYS9pQkhzSmZrN1hucGhSODltRUtDOWsxaFZ3ZzBCaU1WUFhX?=
 =?utf-8?B?Q2E2c0tXVXNkMnQ2ZUVnbHVQY0Q4UWN4SVI0ejlqNGRMNkd2dkZiVThFSTBD?=
 =?utf-8?B?dDNuZW9wZ1pBQ2JDb2wxcno2YTBIaXpRWUJlRmcvRWlTeGxaWjBBRldFdzQ0?=
 =?utf-8?B?cG52ZWxGQjAwZThPR2hJVWMxY1c0TlRyKy94ci9nUzIwdTk4Z0xkdmxJV2FE?=
 =?utf-8?B?WitQZjU2ZURvY1lFMkdVTmpIMjRPeFZlT05wNFBlY1BLTGRjbmpmMW9ra3BM?=
 =?utf-8?B?SDAzekZyK01Md1lEVHVRNUtXd1YvZVFtOUU5Z2JRbklNMzF2cUdrcDlDL2lJ?=
 =?utf-8?B?UzZEeE5uVUQxRndLQUdBUXBEMVR4NzVUR0l3ZHowcEt5OWhlUlNDOUJwM3h1?=
 =?utf-8?B?cmc4QmJOZ1JUUTdvMHVLNVlOd1dDTndFVEw0NGhVd3hydFQxdk9rdGhXN0tG?=
 =?utf-8?B?SFRrbzBtSnV6S0grZ0dqTllYb21NS0dnWlZSdUEwemJjREhUa044Z1RxUm1l?=
 =?utf-8?B?cnJRMEtWTjJuNmpDVnBUYUYxVWVXd3lQZ2R1d2dNWXNQaFlqUWs0SU5TNFpv?=
 =?utf-8?Q?yB39AXj5EhyRBq56KYgLXNJbi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104eb78e-a2bb-4a05-d646-08daaca98f33
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 23:29:07.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2uldlrAEUDW2fo7iMBPF5zTbYeqQZEccpE8WNYbMkgz036FIsVPJafaYO/vs+f+W72iwbNaithh8+Au6ux1O3MAtowccywKwL6KU3mw8wHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6832
X-Proofpoint-GUID: jWUaKv8uJhMBOYTjjN1RJR2dOLC8u4UY
X-Proofpoint-ORIG-GUID: jWUaKv8uJhMBOYTjjN1RJR2dOLC8u4UY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=552 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4gK3N0YXRpYyB1MTYgYXRoMTJrX2RwX3J4X2hfZnJhZ19ubyhzdHJ1Y3QgYXRoMTJrX2Jhc2Ug
KmFiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiKSB7DQo+PiArICAgICBzdHJ1Y3QgaWVlZTgwMjExX2hkciAqaGRyOw0KPj4gKw0KPj4gKyAg
ICAgaGRyID0gKHN0cnVjdCBpZWVlODAyMTFfaGRyICopKHNrYi0+ZGF0YSArIGFiLT5od19wYXJh
bXMtDQo+PmhhbF9kZXNjX3N6KTsNCj4+ICsgICAgIHJldHVybiBsZTE2X3RvX2NwdShoZHItPnNl
cV9jdHJsKSAmIElFRUU4MDIxMV9TQ1RMX0ZSQUc7DQo+DQo+c2hvdWxkIHRoZXJlIGJlIGFuIGll
ZWU4MDIxMS5oIGZ1bmN0aW9uIGZvciB0aGlzPyB3ZSBhbHJlYWR5IGhhdmU6DQo+aWVlZTgwMjEx
X2lzX2ZpcnN0X2ZyYWcoKQ0KPmllZWU4MDIxMV9pc19mcmFnKCkNClllYWgsIGJ1dCB3ZSBuZWVk
ZWQgdGhlIGZyYWcgbm8gaW4gdGhpcyBjYXNlLiANCg0KVGhhbmtzLA0KU3JpcmFtLlINCg==
