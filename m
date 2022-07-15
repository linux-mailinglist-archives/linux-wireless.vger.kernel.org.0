Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF057599A
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jul 2022 04:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiGOCaE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 22:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiGOCaC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 22:30:02 -0400
X-Greylist: delayed 815 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Jul 2022 19:30:02 PDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A03D596
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 19:30:02 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26F00suU019768;
        Fri, 15 Jul 2022 02:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=9vtIgc+fADSvgMZs+5l7ompyYWOzG3nyYUTL+LQIJno=;
 b=VwZsguoSnAeDcruamtWV1x2yxrAas7K5LhcJ1GctxTWuRomY9WAsWaVBDEc3JX8DQF7r
 zHC2qe4E0iKRwkBtxkcoM6AhGcaaJ/QrD2YuzQNeXosIkicv6I4Qi4eCUg7imOg81jOY
 Zxx1K4LTNusdpPyVVnq44Rn/zp17Pd2ovIonAaW2xazfOFCkqhb/o9405fnbRuBVQOvE
 wu1Tu2c5TF8hs0VKpdGTtJmqv19qiAla4K+MLQCWBFTD8CNz8CddD0QVFDsOycvjlsD0
 cUlsIW++3olibyYzua5qshA25qazLd7QeB5InMhTx0BXvQGDXDGR4hYaMpiiye/XwMH5 Zw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hatsqgqt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 02:16:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoEYufjCpK9rePAfLMpuVaIOn+kJ1q9Xqt6q24479ntMP6M9D/mWCfODhYAuGrnwBxzfM0yUDTDabSNZIdxWU8ADXEhbYtgBhyHn0y7PYHCZRMdYBy0iMR4dfcfotyuDj2ie+gIah0q9sc/eo3Q1CzgmZfq5lFSEBq7i9N1JiZSMHhO66Er2GGvEiSPNQEOONsniW3zLCJZQ6YLR+2Xp8ls+OhwEcFMacf2vs2qZKJH1TLsQOQcUEu1crWjj8JvSGhJzbS3MC2HMuNrynze1RjI4IoC65pKzWbcvuAwd4c9OaR84wfteC4P0mDFyInsEDjw06kH4GC0JKT+VZqpAlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vtIgc+fADSvgMZs+5l7ompyYWOzG3nyYUTL+LQIJno=;
 b=S6F31sVl6zemP+YrZ7exhpIQ4JEbIA+SzM7vS1Xt17QqNXXDBXL9DfujI8UX2BIut5x0EDXBGT9rKmmlEj/4unnkr2QrIdowm1/KqDgteNz5KqWdU0Bl+5l55xWhhfdWGHUoLLCwegF9BCps+NXdby5J1sDR0u9Xf9YolzChrVJXhkgYeXRniQsXeNhLv8WWgOd3R3nITVIEihRcmLtTe4aHa7xk3Hd7llzlsZd0GHY3Kn1LQezqhVWn2+ddVmlQY8ppRLyUeOngvB6VAW5Jd5DXTsK8/8edqWeUHAAkeZauRbhEC7UCrRjbdNbsq1G96+S4Vx4bTC/RDoX3hsQjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by DM6PR02MB4969.namprd02.prod.outlook.com (2603:10b6:5:fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 02:16:19 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7%7]) with mapi id 15.20.5438.012; Fri, 15 Jul 2022
 02:16:19 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "nbd@nbd.name" <nbd@nbd.name>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/3] Mesh Fast xmit support
Thread-Topic: [PATCH 0/3] Mesh Fast xmit support
Thread-Index: AQHYfLaXMbJihDi2mEOB7VV8wA6h161pVU0AgAAGcSCAAARXgIAABBPwgAAE8YCAAAA0gIAVfpYg
Date:   Fri, 15 Jul 2022 02:16:19 +0000
Message-ID: <SN6PR02MB433432544D1F5FF9672579C3F78B9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
         <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
         <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
         <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
         <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
         <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
 <19477e0584f7031b37fcdfcc5ef10e7b00842f07.camel@sipsolutions.net>
In-Reply-To: <19477e0584f7031b37fcdfcc5ef10e7b00842f07.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d806a3a-792f-4558-993b-08da66080137
x-ms-traffictypediagnostic: DM6PR02MB4969:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kKMMx6djj7jjp/jPFaalUMt4ad4rB2mT7o42sHLhOuUxU098T5D3nDeBm8ABHzCMK60miG70J7OLw+CKwpHilG+Sc9gwjfmivGM/0xfxVbQDEH2jBXnN2wjZY87FPa7uI/XCIJ/BZU2arCUvMg/jrGY6CzLwMvY+GenFXGZMgS+9YxwOVwPnCXHjv2+j+xK4liRUeV+YRBTnTEjc5T2YuFKI2QsLzknBELC9hp91OGl+9jGbFH31v4rpDvfuQoeWRw6kx8cSbR1+0eiXLpubWMJRCqBNvVSAWspsU3vrf7ROyzqYLThyYaTKh8bxMdhhbFaoWEWgucv/KAX0msyOi4Ygic1dt7Spl6+c/be7HiLSwxDjEMfeva85HzNlaRutrIZ0AExWFdVOabfztbhEDeVmxMzTYCJGdw1acF+/fLlUpopwL4gYty2K+D6PZLbJtj+VsMwLrlueaPE7lnVOFqC1FGJ8c+AGX/eIVkqEAyiCnhBRdX9lylCTLnpYw858HtNHNLQ7deOn0gv2WS0RMBuVDQnePfcMdOH9cKTtwqFBPMfylynBxsGTN5bq+0z3ZSyAjPMRFUQgeitwvBYMxtHStR2StJpAJvLohMXZunNPX2oT0oQIE2AIVFGWyxSNJ8iorxcftDU0mtmQyJmJwHXfrsKyz5R7724ZdcVIk8pqgFHVFy4p9RLx7GRmJ+ZZuHY/LyLdFkZTrCeKpcsfCGihWk0FXyy99ypb1htGdDTCUJtDfu6k+ijfypzUZ3SjFEhHP/dL8mXgiwK34hSuea/mNVbMajkY1USKwJJnbIIsNuC3gtu9fum8QtFdlRgl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(38100700002)(6506007)(9686003)(71200400001)(66556008)(52536014)(7696005)(26005)(41300700001)(38070700005)(76116006)(66476007)(316002)(8676002)(4326008)(8936002)(66946007)(122000001)(110136005)(186003)(83380400001)(2906002)(64756008)(66446008)(478600001)(33656002)(55016003)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGNVR0tmQmRuYVE2aWd3bHcvdUg3YnlhWGhOU2p3UnN0RUh5TjczVU4xU3N3?=
 =?utf-8?B?RnBtTFNrNWM5V1EyVGNRZ2RCSmplemNhMk0yamd3RWVLZ0pBeTd4bzV3VlF0?=
 =?utf-8?B?QkZSdWQ2ZkRQU1ZSNHBoQWxlK24ralJ4OTA5T0EwR1U1WWY1b2JudTBFT0hW?=
 =?utf-8?B?VFlqRHFPdHRDWjRDRW8ybXZCVFNNZGRaQSsrNkNtZVNmRzlNTlhINzhIT201?=
 =?utf-8?B?ZXUzYUxRWmdnQU5NdFA4NEt4L1gwRmQ1Mmt0TXJvQVkrV0hlaVB1amNsd21K?=
 =?utf-8?B?QjVLU3BNRWNBK2Jya3FPK3BKNEx0ZmtGT0Vuek83MFpOWEU5NFZPWGRuTUtS?=
 =?utf-8?B?a3dDMEx5ZENvS2FPRVNRNy92UUNNMVVyVVJYRjRhWjRhNi9HY3hnQjVic1k3?=
 =?utf-8?B?YXZZNTNjK2VYc0hxK2N1ZDdWdkxrTW8xZTlWZWErckFKZEVnMW9xSzQvRnda?=
 =?utf-8?B?THlqQW1OdjN4VkFRaUFZRmtEejFyc3c0cDdEOVVTMkFMcXZxWTVCZkd6eHgr?=
 =?utf-8?B?enZsTy80Q2luSE5NZWZkdG5VNWc0WVdXUEMwNy9xQWtZZWRYS1BycksrVncw?=
 =?utf-8?B?K0ZUSHhmRmt3ZXIwbjgrdGtibjVUaXlxdStBRGt4VWhmcHRyRTF1SGE2b0lU?=
 =?utf-8?B?UjZOSEs5VVJJTWhXcnRKODBic085OUN5blZiQ2pUSnhLK25seG9tUERJWmdB?=
 =?utf-8?B?aDRUYW9JZjcwbTE4T0ltYzIvQXIzb3lqT0dvMk9NYXdISEZ0T2VhbkM1cFVN?=
 =?utf-8?B?UXVxQ2NESWVQZkw4MExxSEVGcDcwbTRScnIzV2Vic3pMZGUwRFN1ZDYyUGd4?=
 =?utf-8?B?a3lyY0Q2VVBsbEhQdGErS0xNMkt6ejVNVmNrZ24xSytpd0lIdVRHRkJYTjZG?=
 =?utf-8?B?Y1prYjRvRlRwUnk0UHdodUw1QTg2aGRTMDFIaVFocGJ3NjVYbm5QR2NGRXdv?=
 =?utf-8?B?bTEvVkZ1cVdsNzRMRHFucklsS1NPV1ZvYytSa2YyZ1V2MU5lTzRPME54aGM0?=
 =?utf-8?B?S2o2Z3VyY3VlSGFkNWZ1MEl5MFJ2SURST0hEaU9TQTRKMEM1bXVLUS9hRWVl?=
 =?utf-8?B?SkdoUjFlaU5EV2E1VkpKTWpCTDB6dzdKTEd0NFpZelRqbGRyWHRjaHB6bkh3?=
 =?utf-8?B?LzBCMHRrL1hRcmYxU2ZSOTZvc2tnbmtpWlR3dVowczdYaGo3bXNmMjNDdDZR?=
 =?utf-8?B?SUcraVJaZEJQZnVhNHlMWXgwbDlSZmFBSDZHZGc0SXBMYStpTUNxNWE3Tk8z?=
 =?utf-8?B?YXdZZEhXVURiUU5FWEszQTdLczIvQ2U5ZG1RMkRMekxQQ1V1T2t0ZUtZYXZ2?=
 =?utf-8?B?TUhraW1XbDA2V1RSUEQ1VXd6ZGYvWVNmNUtXTmpmNnN5Umw4bVpPVlc0MUI5?=
 =?utf-8?B?ZmFCRFExb1hjSHBaT29SS0ZXalIxZlNrdkNRcktjanhiRVRCQmFzbXMvTFN3?=
 =?utf-8?B?SzladzVHYm9iTkgzY2hnV1hvZ1NZZ0lhS3FyOEZIVktBQ0JPcHdFbW1kSFgv?=
 =?utf-8?B?SDExVTQvVlYrQit3N0xvWTRHNWw5Q3htakJ2SDNta3Vha3kzV253c2orUlFl?=
 =?utf-8?B?NlZsRE1FMTk3N0tWamUyMXFQa1VBMEg5aFRzcU5HNWJkQ2liMlhLdGxKb3lY?=
 =?utf-8?B?V01QM3lFeEJCalk5NDVta2JGSTM3RnptVnp4dG5oVFZSQlRpdFdaOTdqeWM5?=
 =?utf-8?B?ckh6RXdONk5TYWhnNVIzeEc1VnFEeGdNK24zNmhjeFdEZHRZeEhjK1BkL0dS?=
 =?utf-8?B?eFVNN2gxZlpsaktoWUFqUExqOElVc3F0QmcxZXdBTHZLR3M3b3l6YU05VXlw?=
 =?utf-8?B?alBhZm1mZnowUUM4cEVmcHFEc0lIdEY5UWd2NzJxMTRUeEZqcm12MWdBM0Yx?=
 =?utf-8?B?M0FROUk2UUNQSzBKSEhtVDNEMnlSaDN2QXRqK0cxdW8zMWpZcmFkRUlueTJK?=
 =?utf-8?B?dXlIcGNFKzlpdndpQ2x0TWZSUE9GS0RLOHlXTm5vS3lPdXJxd05wdkUrNVRn?=
 =?utf-8?B?NnlTQnRsMnFLKyt4S1pxbGVhMG9RTE5TNFRhMlFWckhJZTZJWXVPYjVNclJX?=
 =?utf-8?B?dnJkWGlLWlo0SlMzUkp3bXB4cFZjOXpZMGFOaFBuU3pYeHpkN0ZaTXAxWkw0?=
 =?utf-8?Q?7iQ4KXzPwcGXung4Z1tepdh0n?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d806a3a-792f-4558-993b-08da66080137
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 02:16:19.2382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XED/oNw+z6HQBZJAR2wJLOuyPH1+vyCnkPvhekomgcrdZuFUHCw3TkUadQ0PiCuoMqIIjg/baQEh7IEizTl8b23zxH2llkLnyZLUX9GmrlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4969
X-Proofpoint-ORIG-GUID: wvTwCyoaXqjze-zdRm8CsGb50ucQ9_jb
X-Proofpoint-GUID: wvTwCyoaXqjze-zdRm8CsGb50ucQ9_jb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_19,2022-07-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxscore=0 suspectscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=607 priorityscore=1501 adultscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207150009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5u
ZXNAc2lwc29sdXRpb25zLm5ldD4NCj5TZW50OiBGcmlkYXksIEp1bHkgMSwgMjAyMiAzOjMwIFBN
DQo+VG86IFNyaXJhbSBSIChRVUlDKSA8cXVpY19zcmlycmFtYUBxdWljaW5jLmNvbT47IG5iZEBu
YmQubmFtZQ0KPkNjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBS
ZTogW1BBVENIIDAvM10gTWVzaCBGYXN0IHhtaXQgc3VwcG9ydA0KPg0KPldBUk5JTkc6IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5
IG9mDQo+YW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJsZSBtYWNyb3Mu
DQo+DQo+T24gRnJpLCAyMDIyLTA3LTAxIGF0IDExOjU5ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdy
b3RlOg0KPj4NCj4+ID4gICBTbyB3YXMgc2tlcHRpY2FsIG9uIGhhdmluZyBhIGhpZ2hlciBjYWNo
ZSBzaXplKGxpa2UgMjUwIG9yIDUwMCBtYXgpLg0KPj4gPiBIZW5jZSBoYWQgYSB2YWx1ZSBvZiA1
MCBhbmQgbGVmdCB0aGUgY29uZmlndXJhdGlvbiBwYXJ0IGZvciBkZXZpY2VzDQo+PiA+IHdoaWNo
IG5lZWRlZCBoaWdoZXIgY2FjaGUuDQo+PiA+IEJ1dCBhcyB5b3UgbWVudGlvbmVkLCB0aGlzIGlz
IG9ubHkgcnVudGltZSBtYXggbWVtb3J5IGFuZCBub3QgZGVmYXVsdC4NCj4+ID4gIFNvIHdlIHNo
b3VsZCBiZSBmaW5lIHRvIHNldCBzb21lIGhpZ2ggbGltaXQsIElmIGFib3ZlIGlzIG5vdCBhDQo+
PiA+IGNvbmNlcm4gY291bGQgd2Ugc3RpY2sgdG8gYW4gdXBwZXIgbGltaXQgb2YgfjE1MC0yMDAg
Pw0KPj4NCj4+IFJpZ2h0LCBJJ20gZmluZSB3aXRoIHRoYXQuIEkgd2FzIGp1c3QgdGhyb3dpbmcg
b3V0IDUwMCBhcyBhIHJhbmRvbQ0KPj4gbnVtYmVyIHRvIHNob3cgdGhhdCBpdCdzIG5vdCByZWFs
bHkgYSBodWdlIG1lbW9yeSByZXF1aXJlbWVudC4NCj4+DQo+DQo+QnV0IG1heWJlIEZlbGl4IHdh
bnRzIHRvIGNvbW1lbnQ/IEZlbGl4Pw0KSGkgRmVsaXgsDQoNCiAgQ291bGQgeW91IGtpbmRseSBz
aGFyZSB5b3VyIGNvbW1lbnRzIG9uIHRoaXMuDQoNClRoYW5rcywNClNyaXJhbS5SDQo=
