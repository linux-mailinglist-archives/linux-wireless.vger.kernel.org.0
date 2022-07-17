Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81395774E6
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jul 2022 09:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbiGQHQX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jul 2022 03:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGQHQW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jul 2022 03:16:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2D911A0C
        for <linux-wireless@vger.kernel.org>; Sun, 17 Jul 2022 00:16:20 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26H7GFiD025295;
        Sun, 17 Jul 2022 07:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=H0Z688E0TgMaxxAuLOgA8dz8rfjv9EQUsH3u2CMT8lQ=;
 b=pi/sspgpt45fHA778wyu/B9eGUXpIQLO5Iasg1oFdXAeEK5gny04A0E0E69tjLHQSAQt
 Mr9Wf9XPspPpYH1/XjQ96SoGFYuZW1+50OJcCu+hkiIqJSSWCvWwprr+R4DXkO3dX4WF
 evmOo5BK8qR4oRMWTOILP6sNyL+Oux3Hf55jHWchVSHHaAPSCfJUYbE0tFlnyU88jpWz
 gsVKXAdlO/5BQIDYmH7SpGwkqLoQ4ygJ+fVT6OItvIZGaAJZnknh8ZB1/wnNs7mBEXp9
 sMNt50zVubIKXzMuvh7+bruuUNZ3ynxR7b1SiOS7AuZlLWZozMywi9Zzra5vr19XAyc3 rA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hbnppabk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 17 Jul 2022 07:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gck6crmHfsAKBOHnRv2doRDDKU248DbQ81sj6HNpnd2yzFymQp7GCX8leYZh+GikNnkcyBCUd8OQuxr1c+hf76C4tFNHyuJTtAMsZ3gJ+rD3zW7gv2iBZ+i59ytqA91W44vcrglcsG938ZiccNQNYFAY+HtOLsXqg1KzlCqZe2iLM1pZY4YUY6Vu5Y3TjpqFPfCHiIfsS1IYNpks3vEiHSKcVJicdwI/LltJp1ZXLev3+CCLcbOGHoRMY9RjWyGG6r4PIAMuoUZrYrVL75phgj2avYqbnubTh1BIO8Z3tfU05wyZ83sdTg9yCzEOypH0cQa359F62+AoKEgZOiVKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0Z688E0TgMaxxAuLOgA8dz8rfjv9EQUsH3u2CMT8lQ=;
 b=XV7UKhnEpcWeHqgdiFY8lTX5zIxbSnt6EWAEAIijyg+jy8yk7SObOyw3ufztnA+dPDxLujRVe7J8ejp6SeoSZ6yE2a3I5GP4kcWIlkwOhN8QebyiEWCh3tY4Dx+tdVNyWRtFu3efMZQ6N4YN3tf7lQI6k0Thpun4cR2BOP67sgJt5Fijk1r6h5MaRC3lyg0FLRzkH+4uu2e+3b/kgwLVaWaVsfVANJNiU2Q37DmIpIwCnR6ci70sEj+TvX2te3GLDA32icHdaMSAYlFzPiPwRExt4u/SC18W3ulScrGSfowZVGoFKgTXpjRWgE/VGWwghAzv39Bxxd5Lr89jJCgnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by BN7PR02MB5217.namprd02.prod.outlook.com (2603:10b6:408:25::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 07:16:11 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::70cb:fc3b:3525:43b7%7]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 07:16:11 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "nbd@nbd.name" <nbd@nbd.name>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 0/3] Mesh Fast xmit support
Thread-Topic: [PATCH 0/3] Mesh Fast xmit support
Thread-Index: AQHYfLaXMbJihDi2mEOB7VV8wA6h161pVU0AgAAGcSCAAARXgIAABBPwgAAE8YCAAAA0gIAVfpYggANTjACAACTl0A==
Date:   Sun, 17 Jul 2022 07:16:11 +0000
Message-ID: <SN6PR02MB43345D6CD65E1B23B0261F9FF78D9@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <1654857639-12346-1-git-send-email-quic_srirrama@quicinc.com>
 <98e3a2743ab770fbd3f14dca14b62105c8457bf6.camel@sipsolutions.net>
 <SN6PR02MB4334670B5FD85EB6940A64F8F7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <9bce16843dcc698740d90d8963a1a55516fb1d39.camel@sipsolutions.net>
 <SN6PR02MB4334F77368A1AC3F1202117CF7BD9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <940aa2fe0f2497e9fab9a5118001034b5de18d64.camel@sipsolutions.net>
 <19477e0584f7031b37fcdfcc5ef10e7b00842f07.camel@sipsolutions.net>
 <SN6PR02MB433432544D1F5FF9672579C3F78B9@SN6PR02MB4334.namprd02.prod.outlook.com>
 <a438e076-7fa1-1b1c-0e39-597b57c39367@nbd.name>
In-Reply-To: <a438e076-7fa1-1b1c-0e39-597b57c39367@nbd.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01b28324-913c-4fc0-2525-08da67c43a19
x-ms-traffictypediagnostic: BN7PR02MB5217:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoeRZsypbi8ya59SO/hN3mnAf0s9+KrInXqQl9W570tyxg0uJVrwYYUHSwB4w9D1fUV1ymVLnHwSRWzEy66W3VqZW0ps88MV00HVyqVM+YJbGUYhOVQUD641+MpX6azBAFWITdnUlW+DtKvIqsIugOifUuymlNhIJ8VxLxtOi1O54KikicUyWNgseU8+NA2J7/ximds/9nsjzHF3n4k/wwWDMPy+x1DPpaXoAN039mL6+iSHbu3bt0zrzkHU0Ipm3JviYcKh28aaOcWExF3XhC0A6i+pMNJ3qUb+FHa+TwOk+Iyxh1e3teHtieSzoMgZNsOaQwxP443EF8brvVkpsDH5bSjjKSxKXfjivt5pDOcqyiYMjDab10i8zRiMOYF8dRHbdNhWnm5bmkgm05Nbhm1CUld17yb9wTMSCZiu+B7WmmeBBQsXOb0KCfkSFGTQWab/6hG91zIdeka46ibfgpOmuBiZRnXocX08lNBNMg7qakm6AoMx1J4mNXTVoVVC5Xe52Q+66ooHB/1OGFjULGzSEgKTo8Oi3REHdtxBhzhYA6Xx8ANK6qwOGhvrTZ1v3f4I8wsXceAKYsWbUkl1WjiKW4vRfWClQKdijCKdphzXL9PMli9vPDNew6VI+lBH8oSVsAnEeN9A9NTjzqtlhJs8zjWFkcuTUNYc71YUKNvC2JoJs34TP6ravb0k2dZdsl+EE64el2btv9BQwezR1QnOmtq0LR/HY+llxGkK4jMJNAvvflCVb8U1ZUfzt5b+HybdFCa9qSDaA/bf+jJnu/NnruY1Roh1eRtyleow68jLbs9yurkPFlMidXdhO+9+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(5660300002)(8936002)(66556008)(41300700001)(4326008)(38100700002)(66946007)(8676002)(66476007)(2906002)(122000001)(66446008)(64756008)(38070700005)(478600001)(7696005)(55016003)(26005)(71200400001)(86362001)(9686003)(76116006)(110136005)(52536014)(316002)(33656002)(83380400001)(186003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjZyRks5Y1dTRGJra3NOU3FYOGp5ZUZLNnVKZVJ1K2xNbFpiS3R5ZDhsVzMv?=
 =?utf-8?B?blZVUGtzYWdRemo3V0ptbzBQSmNRMjhEWmUveENVcHp1UjFuRmtyYlVYL3NJ?=
 =?utf-8?B?NUoyMVZYT3NRdThYbWQ4YzhSUU53emxoN1FPcmJoRFBsemlvRU9EMkNvRVlu?=
 =?utf-8?B?eHBtTlN1ZGhJT1RZSFcxczdSMksydzRtWE1mRStaTHBEd1E4a2MyZ2lhL01s?=
 =?utf-8?B?VTdaVzJKZ0xCMWVMNVdkbFBZSkRzcHcvZThUdDJGRHBLWFhBd3dCYlBsdUVM?=
 =?utf-8?B?S0dEYmVsbjVacERSNUkzTGpSUWZVaklpV2ZtazJ1ZlBFOXNsdlNMMUNwc0xT?=
 =?utf-8?B?b1lXa2cyR1ZLK2RZeTVtU2ZSRVluTzRrRUs3bVdGbS9oZWgzdmN0YmI5ekI3?=
 =?utf-8?B?T0dsTWpJbHZZa2RabVJ3eFh6SXVBb3ZWRWtQdVBDTDV5eU5VeGpJN244RVNp?=
 =?utf-8?B?MDNWcVBiVVRyazZFa1BnRWZ6UE1HckNsUkV1TWFLbW1zSTBzSmZPeUk0ME9I?=
 =?utf-8?B?T212NVptNjRUTEl2dW1kOXVCdnpNanQyaW9KRVVEa1BDNE1tK0tzOFJDQmRR?=
 =?utf-8?B?RlFtUUlldXFVUmgvVy9mWmRSdEM1cisyb1dRSWVJWGZIVDlaUnpaUGJhQ2F0?=
 =?utf-8?B?czBrb3puVU9RbjZOMlNISUZNS0VnUGZRbWUrUmE1WjJqZ3R1QkFJckJDaUxr?=
 =?utf-8?B?ZTVONHFPZTJHR1dDSXAwUC9YSTZtZmc5NjMzOHNjUjRpakcxaWdvNDdFRGRt?=
 =?utf-8?B?RUNjKzFMNUxaZEhFN1BiMm5XY0RVVDRUUG9iN0M3ZFNPZWUwSnlnMWJKRzYw?=
 =?utf-8?B?WUhvZ3phcWwyV2dDZWxTUG1YZGV5aVR0S29ZN1FjNyt3cGFud0t0QW5nOFcw?=
 =?utf-8?B?dSs4QUhxRmFhWFFWTFNaM2tuWVhCbUZCQ251MFNwTlJ6anhHOXVqV2ZJbmdX?=
 =?utf-8?B?RHRtMENhVG9Wa3dHUUFQTXBwS3RMZk9oOXpSOXpNMktvMklTbmFEcXdBNTZX?=
 =?utf-8?B?UFBRdk80OG5vbDJXKy80bzR5eGl3b1ArSWY0cXZZQ2t3NngzL3BEUFc2RGJN?=
 =?utf-8?B?YnAzeHNWeHJXakZ6bktzOHhqS0p1ZkRkU2tveWdlSlpoWWRiWjI2aHAwMkRn?=
 =?utf-8?B?MUxVVlkwSkVqcUYvVzBmTnpqeldSNWJ6QUJMaDJmeG9VTEVVVEowblNkanNJ?=
 =?utf-8?B?VWxQYnBvQ3ZadkRXNXptWHhadVc1SXgxNGZrYkxWUDl4UmtyRjVjcE92Nmxo?=
 =?utf-8?B?Z1BQL3hOTnJzeE5nRjlrVjc5Y3lYSGs2RnRQV3BKS0RNRDNXbmhoSVVLVm50?=
 =?utf-8?B?QTZLeDl3SGZyOHdVWUgwcG0yNVJ5T053My9aMGlRQkF4bHZtZkJwa3oxRUhW?=
 =?utf-8?B?UFpXVUZZQ2tYczBFVVB6bnhYU2dHbmhqZk1PZE9xTnVSZXJBZGo4cjBxcXBy?=
 =?utf-8?B?a3FKaFdxY2dwUVI2WTZpQVhtWi9KK1JJMGlYY1FFdGJnOTZuWHF3Zm90MDlO?=
 =?utf-8?B?SlI4bC9CVHJjbU5LUDJveUgzS2oyLzQvWHcrTEk1bkhRTVZsanV3L3JKajR0?=
 =?utf-8?B?QVhpdXRqSm8vcDBuaVo3T0V0Z0Rqd3R3Wkx5U0R5aTJselk0UzV6dXBOUmZM?=
 =?utf-8?B?TUttb09lbmNLUXVvS1IrRVA5VDdMdUtGdDJ3S3VBRktpWUFkVkVpYjUzemx5?=
 =?utf-8?B?RkF0MGFWeGx3UVZTaEgzNWdaMjhyYlZud01YRWFyNmEzejlwajlHTWUzc1hV?=
 =?utf-8?B?SGtWR3FsdHZFWEhRWkhveGtSODQ3ek9KaWxValI2bEV5UW5wTmZzeWlnSEZt?=
 =?utf-8?B?bWhSQmNHY09weDR0N21HbDdlWHNsendlVGdBNklHOGFqOG45WStSS0xkUjZ5?=
 =?utf-8?B?eWFpWDV0a3lUbTNjTzk0b21vZnVXOWVyMHA4Wm8vMHlhOFIyZTVxUkNsMHEw?=
 =?utf-8?B?ZEJRd2xYY2ZWQVUveTZRREg5NW1RT09SUE5XOW54YUF1VUx4T0svL05SYUpU?=
 =?utf-8?B?ZFhEMzVJdWVaTm1LeW5xTm1NZVhZd3ZSQ0RKVGNaeXlHSFpIRE1JOE01NmVF?=
 =?utf-8?B?YzVBa1Z4L1owdXIrZGJKRFBvVTkwY1RZK1J5V3BUQ2xYQ0c3WEl1NUZXVTIw?=
 =?utf-8?Q?H1cCSxrEd7eYYDc/srx2AuGfi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b28324-913c-4fc0-2525-08da67c43a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 07:16:11.2167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPGkZFqw7/U8A1d3FtQt3ixfaSaxVXW+jqXgtkIfLIzd4u0xmLtzG9k8FyHAFYpHQUtWBzwZ3M6Mke8izU7NbWpJdy1QUYwOelODKxpm88g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5217
X-Proofpoint-GUID: YEHJXeicUAcrjZEvr8XB4_WHzOoGSsHQ
X-Proofpoint-ORIG-GUID: YEHJXeicUAcrjZEvr8XB4_WHzOoGSsHQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_03,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxlogscore=858
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207170034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4+PiA+ICAgU28gd2FzIHNrZXB0aWNhbCBvbiBoYXZpbmcgYSBoaWdoZXIgY2FjaGUgc2l6ZShs
aWtlIDI1MCBvciA1MDAgbWF4KS4NCj4+Pj4gPiBIZW5jZSBoYWQgYSB2YWx1ZSBvZiA1MCBhbmQg
bGVmdCB0aGUgY29uZmlndXJhdGlvbiBwYXJ0IGZvcg0KPj4+PiA+IGRldmljZXMgd2hpY2ggbmVl
ZGVkIGhpZ2hlciBjYWNoZS4NCj4+Pj4gPiBCdXQgYXMgeW91IG1lbnRpb25lZCwgdGhpcyBpcyBv
bmx5IHJ1bnRpbWUgbWF4IG1lbW9yeSBhbmQgbm90IGRlZmF1bHQuDQo+Pj4+ID4gIFNvIHdlIHNo
b3VsZCBiZSBmaW5lIHRvIHNldCBzb21lIGhpZ2ggbGltaXQsIElmIGFib3ZlIGlzIG5vdCBhDQo+
Pj4+ID4gY29uY2VybiBjb3VsZCB3ZSBzdGljayB0byBhbiB1cHBlciBsaW1pdCBvZiB+MTUwLTIw
MCA/DQo+Pj4+DQo+Pj4+IFJpZ2h0LCBJJ20gZmluZSB3aXRoIHRoYXQuIEkgd2FzIGp1c3QgdGhy
b3dpbmcgb3V0IDUwMCBhcyBhIHJhbmRvbQ0KPj4+PiBudW1iZXIgdG8gc2hvdyB0aGF0IGl0J3Mg
bm90IHJlYWxseSBhIGh1Z2UgbWVtb3J5IHJlcXVpcmVtZW50Lg0KPj4+Pg0KPj4+DQo+Pj5CdXQg
bWF5YmUgRmVsaXggd2FudHMgdG8gY29tbWVudD8gRmVsaXg/DQo+PiBIaSBGZWxpeCwNCj4+DQo+
PiAgICBDb3VsZCB5b3Uga2luZGx5IHNoYXJlIHlvdXIgY29tbWVudHMgb24gdGhpcy4NCj5JIGFn
cmVlIHdpdGggbWFraW5nIGl0IGJpZyBlbm91Z2ggc28gdGhhdCBhbG1vc3Qgbm9ib2R5IGhhcyB0
byB0dW5lIGl0Lg0KPkkgdGhpbmsgNTEyIHdvdWxkIGJlIGEgcmVhc29uYWJsZSBkZWZhdWx0Lg0K
U3VyZS4NCj5CeSB0aGUgd2F5LCBpZiBJJ20gY291bnRpbmcgY29ycmVjdGx5LCB5b3UgbWlnaHQg
YmUgYWJsZSB0byByZWR1Y2UgdGhlIHNpemUgb2YgdGhlDQo+Y2FjaGUgZW50cmllcyBhIGJpdCBi
eSBtb3ZpbmcgdGhlICdrZXknIGZpZWxkIGJlbG93IHRoZSAnYmFuZCcgZmllbGQsIGdldHRpbmcg
cmlkIG9mDQo+c29tZSBwYWRkaW5nLg0KT2ggb2theSwgVGhhbmtzIGZvciBjaGVja2luZywgbGV0
IG1lIHJldmlzaXQgdGhpcyBwYWNraW5nLg0KDQpSZWdhcmRzLA0KU3JpcmFtLlINCg0KPg0KPi0g
RmVsaXgNCg==
