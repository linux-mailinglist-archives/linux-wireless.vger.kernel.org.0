Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19405F41EA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiJDLX1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJDLXZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:23:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C02528C
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:23:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294BF04p016461;
        Tue, 4 Oct 2022 11:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=IwH81++/RQj7WgxuwrmBoLnzo5Ds4/BVpvicH4AkN5Q=;
 b=cv9HbDUko+NecRF/mEvG0XPMZ/cKBhmyLDNN9ZemOPGI1h3CAn1xdORmrGJ5XmH42Fjk
 zGCoOpQObs08ZMrW9hxWm36/Ze6rOLbwajmQd3jt8x00ghBbw5Ix45RxWGW/TO/4Zhyj
 u6d/MOuGkEjZ0pAghYUVpkZR/dLAObV4HWdBpb1MjMi9dkjgK1opANwVf4vs+lCP8ReC
 aR2/oqQcMtX1Z6hI/tByNpVhkGqXaFVxYt3xzZwr1fflBNdHPIp1MyTyDg0pD2Sz+Cb3
 4HjHgl8yz2gowo7FBJhRg4fDXBHTXcZ/gPtVW4zUHDsK24hL2HID2jPpLF7YYjwrhSJL DA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0jtdg3qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z03onimYgkJyP4PKfpGndZ0Feurfj/vTR36mgqLXVLYTtofCalPX8kTT0iPZDBmDQj8D/vaVmjOkgE9Q4hUd2qfLMOPpVHgFiFtu0OisRsuDh7gI87MtatB32MxSz5mFMgbuM8KH9Saow0Mds9bqpFrzh9RYSHcTZi9OdVK5tRpQJNv2ovF47W3IG2HbjATs1U+yzHGy0z1sCJtPgQ3UmJTQ9YVgI3KhyvL9lJnQF2+jdQy1VWczIxOzLkr9WLCgKmhVAKMYlvcCQNL27ruPPTkXiH/TCAcjBpfUKvelguRifENW6YlMrV7zIrUTGTpFGeALK2L9dBmH6AkbBL5Egg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwH81++/RQj7WgxuwrmBoLnzo5Ds4/BVpvicH4AkN5Q=;
 b=fK29uzMBP+7j0qcAAGxznlYQDaro1GvaZQ7+3rQZ8LrfBRJLcvLNxCxHmi80ZO3gAd+Hsjw2h7yrarPpruJBazf+ue6NLwHngl5aRzn5Z+S2RRhUheirFzdnnoQRbfSCKYjwLvhoYzjRnGO0VBNw7q1v3C6WBAuPXTQ+IyGhlHFeEeE5bHw2e/E/ZmynSk4vqAUXDDN52fM7jZ5ZAkEMxH6B6iUXuzyU+U3vUfM8t+Lm4kd+k9LJp94Yo7FE8EvRSBhyzvusrvOD52cRNc7Ql8Ksjursg3IDN4970RpSara0b2FPn5Jt4LVBVCrnWWGkdQSxS4EDeuclqiy5TXlGKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by MN2PR02MB6927.namprd02.prod.outlook.com (2603:10b6:208:203::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 11:23:17 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:23:17 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 27/50] wifi: ath12k: add htc.c
Thread-Topic: [PATCH 27/50] wifi: ath12k: add htc.c
Thread-Index: AQHYrmYePCUhRNcBHUGvjdEmmmOGUa21FeCAgElUBMA=
Date:   Tue, 4 Oct 2022 11:23:17 +0000
Message-ID: <CH0PR02MB821210E572752A69EF00FA59F65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-28-kvalo@kernel.org>
 <8ebc4b7e-6b65-8443-eac6-13b940337166@quicinc.com>
In-Reply-To: <8ebc4b7e-6b65-8443-eac6-13b940337166@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|MN2PR02MB6927:EE_
x-ms-office365-filtering-correlation-id: 265232f2-72a7-42ec-e842-08daa5fad5a9
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qcnDWDgzICxeNoAaqCuN82N/CTrrRuaFRBoy8rsQfeUo2VVLA08vzbVsY9Yh54FcUuRGlX42jWKg+Dvrt/o+3VFguJb3y6ebAPOfuXztLlU48p6I0ukQycgbDMqVaKnX10DhBWeKw+IALOCuPpe9UFAmpzhfcAz1AnRjO3vTBIviN88Fq+F5jaGY2z72YRn/xyRfXC2CdaCNYX/p91X+TxcjGTNajNDjl/BFJ0qTGqOB1ZMQn8iy9eZ8saSijEbxDR6HxC/7L0qjTea+Ac0L8iIMqKfhcDBEWvU1rYN08gjQQ7zCpS/1mRxypErfL7955QLm/xRZ9/mWbX50UMZKXsElC4kax3jowbfdS6QFLelouTMBIzbmOS13qjLTRXoJtHQoKx8grYwzLbdd9+FEA4E4QxOFJ++SxT2LSLIv46mdnMZUW40jSGk3v3gLTqAE6NInf4vemm80D4DZnUJVRYlj1Hkz/y1hqYLm8wF4Ghld3/7DST7An1LIjgY+8KnQ6FhrTbEf2eEOl33ZFnKPKoV+CW7U20npTDczyFmERU93W43pbIIe75MVfwkbNtq6G2Xogn4dCeiOh3gyc4fP1pZL1VkwPgfV7LUpp1pnMujKbKr5dBS5CR8S8MGYphdS+P38aQl4GApt0NkBBhT10QI1Y2zYGoCXls9rQKOlqUs6rpMEeW0eMQP4QyvnQjCB/g5np7m3wHBpZjWVG5QNJIZxcRiTb0fVB97cDlBAE/rxOqG71ryO6VvF4AJGbTi0T7cFybnkeJD3cY7j3mXUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199015)(52536014)(2906002)(6506007)(186003)(5660300002)(53546011)(55016003)(9686003)(7696005)(8936002)(26005)(478600001)(66946007)(86362001)(66556008)(8676002)(64756008)(76116006)(4326008)(66446008)(66476007)(83380400001)(38070700005)(33656002)(110136005)(316002)(71200400001)(41300700001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxiM2IyUGhLUXp1U2duUzFVOU5jcnBwcFAxYThNWStvTFhpVUNVZElXY1Yy?=
 =?utf-8?B?VXNWd3dGbXQ4bzVhcUx2RC9wOUJNNVI5YVNBMkxEcUZqVnJwMituR3dNTWhI?=
 =?utf-8?B?RnVmOU8rOUxPcy9tWXJ5NGd6SjRTUHhDK1pxbkRFWFo3MXY1RE81cjAyc1da?=
 =?utf-8?B?QTVSNGlKajFGQW1ZWmh1Tkd3d3BKbnZtbnVkOVoxTG84WHpXdE5HWW5Cekpt?=
 =?utf-8?B?ZVpFb2g4bjYwUFJNVjBaMGpnZXpDTTJqa1pxOG82TWVWSDlRMTBLTzlDQXQv?=
 =?utf-8?B?ZVNGbXRxY0g4YnI4a3RUZWg0NlRJM0FnQ3hNRHF1aE5FSk16a3hCVVRMMHo2?=
 =?utf-8?B?TklTUFNnZ2pzbzVVNGdOektJdUhCZzlSc3F1ZUZaTTE2RzhNTXdqL1M4VEd6?=
 =?utf-8?B?NmRHdEJJY0luRDVRKzdpUHJDTUtYM1ZTZVUwYnoxc3UrWktJcy9yUHVER1Z2?=
 =?utf-8?B?Q3NOZUVxYjUrTXdFT01XNDZ0YWZwZnJjOGpiSlBBZjVUVWl3bTVCa2wvcUgv?=
 =?utf-8?B?OEdYbngrc29UZ1JQTENUUDNIVVBiRTZXUXlIdWp5WTJ1dG85Vlo0Sm9XeTI3?=
 =?utf-8?B?T3pLcXdvdjdjYkgyVzByTXBaNnNLaU95QjV3RHRiTlA0R1lrclJpSEdYdWV6?=
 =?utf-8?B?ckJ4Y1l4by9QUjZlZElxTUtEaVU3Y3JNZjFaWU43R1lvVXYyRFEzVFFHR0N1?=
 =?utf-8?B?bUo1WTIyKzhXRGppWHF0OWhTSHJ0YmZxNWV4a0dBTXczSlBuMjhLN1piZzBY?=
 =?utf-8?B?VmtOaWdVdktTRlpCczJjV3M0NmVhSUVPL0JmenR3dmsyeVRGa3NTM0VJZUJ4?=
 =?utf-8?B?YWNsWnVUMm1iR2pwSWtReGxQb0FEa3RuUG5nemZCZ1RVcnQydEwvTUhpRlNI?=
 =?utf-8?B?dVhhOG03Y29Bc3A1VzlYUDBmMVZhTjZENk11KzZ5SFNJSEYrOEFoeTg1cGo4?=
 =?utf-8?B?TDFyMG53M09yWnpoQkx2K1FtQWNDTG5BdHMvQTNrY3FLTVJmWHhIZzI2UEll?=
 =?utf-8?B?YzA4Y2ovS2ExTWZxRHVtWGJMRnNwblF4dVRNQ014ZGhOUWFCQXpib0dpeStK?=
 =?utf-8?B?UUdxd090ck1JcFUvdG1mc1VUMWo5aFBtb2FYRURTSW9mak9oVWU4RWhNV3Nr?=
 =?utf-8?B?ZExqZ1RYMjliZVNJZ2J3N3J1ajY1aDhoTHBIeTN5Qi9FZjNOa3h5Q0VneitZ?=
 =?utf-8?B?K1MzUDFpYmh6MDNDRnBvNVZXdWw5amR4TmlLNmNkY0U3V3dEck5KL1JOZ1o3?=
 =?utf-8?B?eHozVVVvd3FqejB0WWd1dmUzZFFVWU5WSHd6bHFoZ21FT2FGYUwrbXdkZnZX?=
 =?utf-8?B?N3M0U3pvOTRzOU5jWVVldUxRTmxLYjUxSmlqUmZLVlNnQ0w3T3BCSTVhQkJQ?=
 =?utf-8?B?ZEdUUFBoNnJsTkdpRUFQcDd2UjRmMWw3M2RnMTJVcG1IT0hiUXJhcHVqSVBD?=
 =?utf-8?B?SDgyQkNSUzNPM0tqb3l5a2ptVmVTdjdQM3ZmK3RVeHZ3ZDlLT2NWT3R6UXla?=
 =?utf-8?B?RG9YM2xKQ1hySlcyYUQ5cUxUaFpKQitZQ3p0TFBsUXNXL2hmVlhYa3RSOGlS?=
 =?utf-8?B?NkdnQWVKOVE5SldDVDQwa2tXTHVhWFlHdjVxWTc4TEZKM281cmhnZ3BKdTFS?=
 =?utf-8?B?eG1tYy9kbUdENE1zcEFPUWpkREdTVUQzM0lhMGUybkFMU2E1MXR3V0wwL1Fa?=
 =?utf-8?B?a1J4NXMxRjM3WTB3M085R0NsWHhDT01TMVdCSHVMUnFCSHRzait3Z1kyZVR0?=
 =?utf-8?B?RDQzUzU1SWhWeUtjQXhOT082czA2WEloZWd2aWhVd2pxc1cxYnNwbzZTSm5F?=
 =?utf-8?B?ZG1LSWI1MjEzQ2c1dmo2YnhUUktFdlgwNWFleTVKZ3NUdjRBeno5TUUvam1Y?=
 =?utf-8?B?UVF3QTU4T05lc3J4dDkraEZsNGkzUjhsQUVXOUFJbmNJbDMveG1kcWtRSHlT?=
 =?utf-8?B?MlZva3JINUlMcUI2TUY1bmFiTE14NFIvNDRoNDBaWWxaU1FSNFEwYS8yYjBM?=
 =?utf-8?B?MHppMkwzMG8vaG13WFJSUitBRDkrbGRjK3ZOTUtYRHBHOVk4dFdBT2Z5elN4?=
 =?utf-8?B?QTVzc1prcmdRWko0VHZsWUlmWkJmUVpkWkF2ZHlmM1NEMkhBRXhDc21IcVdF?=
 =?utf-8?Q?gDggFYASpzmIvaNoSv1QXLSnw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265232f2-72a7-42ec-e842-08daa5fad5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:23:17.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rcu+LrsBDpyIt405pG+67D6YqtdYqRnsEhkLqxPOKm5U3fVnKnn7qDoTrlb/n41+3bJOrHtsvdwojYrkq4r0iCd5ovt+DwAVfQR5dpEkgV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6927
X-Proofpoint-GUID: Ff5-L2RgCORtjf2gspao502oa4VAT510
X-Proofpoint-ORIG-GUID: Ff5-L2RgCORtjf2gspao502oa4VAT510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040073
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplZmYgSm9obnNvbiA8cXVp
Y19qam9obnNvbkBxdWljaW5jLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTksIDIwMjIg
MTowMyBBTQ0KPiBUbzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IGxpbnV4LXdpcmVs
ZXNzQHZnZXIua2VybmVsLm9yZw0KPiBDYzogYXRoMTJrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSCAyNy81MF0gd2lmaTogYXRoMTJrOiBhZGQgaHRjLmMNCj4gDQo+
IFdBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0u
IFBsZWFzZSBiZSB3YXJ5DQo+IG9mIGFueSBsaW5rcyBvciBhdHRhY2htZW50cywgYW5kIGRvIG5v
dCBlbmFibGUgbWFjcm9zLg0KPiANCj4gT24gOC8xMi8yMDIyIDk6MDkgQU0sIEthbGxlIFZhbG8g
d3JvdGU6DQo+ID4gRnJvbTogS2FsbGUgVmFsbyA8cXVpY19rdmFsb0BxdWljaW5jLmNvbT4NCj4g
Pg0KPiA+IChQYXRjaGVzIHNwbGl0IGludG8gb25lIHBhdGNoIHBlciBmaWxlIGZvciBlYXNpZXIg
cmV2aWV3LCBidXQgdGhlDQo+ID4gZmluYWwgY29tbWl0IHdpbGwgYmUgb25lIGJpZyBwYXRjaC4g
U2VlIHRoZSBjb3ZlciBsZXR0ZXIgZm9yIG1vcmUNCj4gPiBpbmZvLikNCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEthbGxlIFZhbG8gPHF1aWNfa3ZhbG9AcXVpY2luYy5jb20+DQo+ID4gLS0tDQo+
ID4gICBkcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL2h0Yy5jIHwgNzg5DQo+ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3ODkg
aW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L2F0aC9hdGgxMmsvaHRjLmMNCj4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsv
aHRjLmMNCj4gDQo+IHNuaXANCj4gDQo+ID4gK3N0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqYXRoMTJr
X2h0Y19idWlsZF90eF9jdHJsX3NrYih2b2lkICphYikNCj4gDQo+IHdoeSB2b2lkICogaW5zdGVh
ZCBvZiBzdHJ1Y3QgYXRoMTJrX2Jhc2UgKj8NCg0KU3VyZSB3aWxsIGFkZHJlc3MgdGhpcyBjb21t
ZW50IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoDQoNCj4gDQo+ID4gK3sNCj4gPiAr
ICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtfc2tiX2Ni
ICpza2JfY2I7DQo+ID4gKw0KPiA+ICsgICAgIHNrYiA9IGRldl9hbGxvY19za2IoQVRIMTJLX0hU
Q19DT05UUk9MX0JVRkZFUl9TSVpFKTsNCj4gPiArICAgICBpZiAoIXNrYikNCj4gPiArICAgICAg
ICAgICAgIHJldHVybiBOVUxMOw0KPiA+ICsNCj4gPiArICAgICBza2JfcmVzZXJ2ZShza2IsIHNp
emVvZihzdHJ1Y3QgYXRoMTJrX2h0Y19oZHIpKTsNCj4gPiArICAgICBXQVJOX09OX09OQ0UoIUlT
X0FMSUdORUQoKHVuc2lnbmVkIGxvbmcpc2tiLT5kYXRhLCA0KSk7DQo+ID4gKw0KPiA+ICsgICAg
IHNrYl9jYiA9IEFUSDEyS19TS0JfQ0Ioc2tiKTsNCj4gPiArICAgICBtZW1zZXQoc2tiX2NiLCAw
LCBzaXplb2YoKnNrYl9jYikpOw0KPiA+ICsNCj4gPiArICAgICBhdGgxMmtfZGJnKGFiLCBBVEgx
MktfREJHX0hUQywgIiVzOiBza2IgJXBLXG4iLCBfX2Z1bmNfXywgc2tiKTsNCj4gDQo+IGRvZXMg
dGhpcyBsb2cgcmVhbGx5IHNlcnZlIGFueSB1c2VmdWwgcHVycG9zZT8NCg0KU3VyZSB3aWxsIGFk
ZHJlc3MgdGhpcyBjb21tZW50IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoDQoNCj4g
DQo+ID4gKyAgICAgcmV0dXJuIHNrYjsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IHNuaXANCj4gDQo+
ID4gK3N0YXRpYyB1OCBhdGgxMmtfaHRjX2dldF9jcmVkaXRfYWxsb2NhdGlvbihzdHJ1Y3QgYXRo
MTJrX2h0YyAqaHRjLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTE2IHNlcnZpY2VfaWQpIHsNCj4gPiArICAgICB1OCBpLCBhbGxvY2F0aW9uID0gMDsNCj4g
PiArDQo+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IEFUSDEyS19IVENfTUFYX1NFUlZJQ0VfQUxM
T0NfRU5UUklFUzsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICBpZiAoaHRjLT5zZXJ2aWNlX2Fs
bG9jX3RhYmxlW2ldLnNlcnZpY2VfaWQgPT0gc2VydmljZV9pZCkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBhbGxvY2F0aW9uID0NCj4gPiArDQo+ID4gKyBodGMtPnNlcnZpY2VfYWxsb2Nf
dGFibGVbaV0uY3JlZGl0X2FsbG9jYXRpb247DQo+IA0KPiBzaG91bGQgeW91IGJyZWFrIGZyb20g
dGhlIGxvb3AgaGVyZSwgb3IgY2FuIHRoZXJlIGJlIG1vcmUvYmlnZ2VyDQo+IGFsbG9jYXRpb25z
IGZvciB0aGUgc2FtZSBzZXJ2aWNlIGlkPw0KPiANCg0KU3VyZSB3aWxsIGFkZHJlc3MgdGhpcyBj
b21tZW50IGluIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoDQoNCj4gPiArICAgICAgICAg
ICAgIH0NCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBhbGxvY2F0aW9uOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGF0aDEya19odGNfc2V0dXBfdGFyZ2V0X2J1
ZmZlcl9hc3NpZ25tZW50cyhzdHJ1Y3QNCj4gPiArYXRoMTJrX2h0YyAqaHRjKSB7DQo+ID4gKyAg
ICAgc3RydWN0IGF0aDEya19odGNfc3ZjX3R4X2NyZWRpdHMgKnNlcnZfZW50cnk7DQo+ID4gKyAg
ICAgdTMyIHN2Y19pZFtdID0gew0KPiANCj4gc3RhdGljIGNvbnN0Pw0KPiANCj4gPiArICAgICAg
ICAgICAgIEFUSDEyS19IVENfU1ZDX0lEX1dNSV9DT05UUk9MLA0KPiA+ICsgICAgICAgICAgICAg
QVRIMTJLX0hUQ19TVkNfSURfV01JX0NPTlRST0xfTUFDMSwNCj4gPiArICAgICAgICAgICAgIEFU
SDEyS19IVENfU1ZDX0lEX1dNSV9DT05UUk9MX01BQzIsDQo+ID4gKyAgICAgfTsNCj4gPiArICAg
ICBpbnQgaSwgY3JlZGl0czsNCj4gPiArDQo+ID4gKyAgICAgY3JlZGl0cyA9IGh0Yy0+dG90YWxf
dHJhbnNtaXRfY3JlZGl0czsNCj4gPiArICAgICBzZXJ2X2VudHJ5ID0gaHRjLT5zZXJ2aWNlX2Fs
bG9jX3RhYmxlOw0KPiA+ICsNCj4gPiArICAgICBpZiAoKGh0Yy0+d21pX2VwX2NvdW50ID09IDAp
IHx8DQo+ID4gKyAgICAgICAgIChodGMtPndtaV9lcF9jb3VudCA+IEFSUkFZX1NJWkUoc3ZjX2lk
KSkpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAg
LyogRGl2aWRlIGNyZWRpdHMgYW1vbmcgbnVtYmVyIG9mIGVuZHBvaW50cyBmb3IgV01JICovDQo+
ID4gKyAgICAgY3JlZGl0cyA9IGNyZWRpdHMgLyBodGMtPndtaV9lcF9jb3VudDsNCj4gPiArICAg
ICBmb3IgKGkgPSAwOyBpIDwgaHRjLT53bWlfZXBfY291bnQ7IGkrKykgew0KPiA+ICsgICAgICAg
ICAgICAgc2Vydl9lbnRyeVtpXS5zZXJ2aWNlX2lkID0gc3ZjX2lkW2ldOw0KPiA+ICsgICAgICAg
ICAgICAgc2Vydl9lbnRyeVtpXS5jcmVkaXRfYWxsb2NhdGlvbiA9IGNyZWRpdHM7DQo+ID4gKyAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gDQo+IHNu
aXANCj4gDQo+ID4gK2ludCBhdGgxMmtfaHRjX3N0YXJ0KHN0cnVjdCBhdGgxMmtfaHRjICpodGMp
IHsNCj4gPiArICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiOw0KPiA+ICsgICAgIGludCBzdGF0dXMg
PSAwOw0KPiANCj4gbml0OiBpbml0aWFsaXplciBhbHdheXMgb3ZlcndyaXR0ZW4gYnkgYXRoMTJr
X2h0Y19zZW5kKCk/DQo+IA0KDQpTdXJlIHdpbGwgYWRkcmVzcyB0aGlzIGNvbW1lbnQgaW4gdGhl
IG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gNCg0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtfYmFz
ZSAqYWIgPSBodGMtPmFiOw0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtfaHRjX3NldHVwX2NvbXBs
ZXRlX2V4dGVuZGVkICptc2c7DQo+ID4gKw0KPiA+ICsgICAgIHNrYiA9IGF0aDEya19odGNfYnVp
bGRfdHhfY3RybF9za2IoaHRjLT5hYik7DQo+ID4gKyAgICAgaWYgKCFza2IpDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKyAgICAgc2tiX3B1dChza2IsIHNp
emVvZigqbXNnKSk7DQo+ID4gKyAgICAgbWVtc2V0KHNrYi0+ZGF0YSwgMCwgc2tiLT5sZW4pOw0K
PiA+ICsNCj4gPiArICAgICBtc2cgPSAoc3RydWN0IGF0aDEya19odGNfc2V0dXBfY29tcGxldGVf
ZXh0ZW5kZWQgKilza2ItPmRhdGE7DQo+ID4gKyAgICAgbXNnLT5tc2dfaWQgPQ0KPiBsZTMyX2Vu
Y29kZV9iaXRzKEFUSDEyS19IVENfTVNHX1NFVFVQX0NPTVBMRVRFX0VYX0lELA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIVENfTVNHX01FU1NBR0VJRCk7DQo+ID4g
Kw0KPiA+ICsgICAgIGF0aDEya19kYmcoYWIsIEFUSDEyS19EQkdfSFRDLCAiSFRDIGlzIHVzaW5n
IFRYIGNyZWRpdCBmbG93DQo+ID4gKyBjb250cm9sXG4iKTsNCj4gPiArDQo+ID4gKyAgICAgc3Rh
dHVzID0gYXRoMTJrX2h0Y19zZW5kKGh0YywgQVRIMTJLX0hUQ19FUF8wLCBza2IpOw0KPiA+ICsg
ICAgIGlmIChzdGF0dXMpIHsNCj4gPiArICAgICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsg
ICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtpbnQgYXRoMTJrX2h0Y19pbml0KHN0
cnVjdCBhdGgxMmtfYmFzZSAqYWIpIHsNCj4gPiArICAgICBzdHJ1Y3QgYXRoMTJrX2h0YyAqaHRj
ID0gJmFiLT5odGM7DQo+ID4gKyAgICAgc3RydWN0IGF0aDEya19odGNfc3ZjX2Nvbm5fcmVxIGNv
bm5fcmVxOw0KPiA+ICsgICAgIHN0cnVjdCBhdGgxMmtfaHRjX3N2Y19jb25uX3Jlc3AgY29ubl9y
ZXNwOw0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIHNwaW5fbG9ja19pbml0
KCZodGMtPnR4X2xvY2spOw0KPiA+ICsNCj4gPiArICAgICBhdGgxMmtfaHRjX3Jlc2V0X2VuZHBv
aW50X3N0YXRlcyhodGMpOw0KPiA+ICsNCj4gPiArICAgICBodGMtPmFiID0gYWI7DQo+ID4gKw0K
PiA+ICsgICAgIHN3aXRjaCAoYWItPndtaV9hYi5wcmVmZXJyZWRfaHdfbW9kZSkgew0KPiA+ICsg
ICAgIGNhc2UgV01JX0hPU1RfSFdfTU9ERV9TSU5HTEU6DQo+ID4gKyAgICAgICAgICAgICBodGMt
PndtaV9lcF9jb3VudCA9IDE7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBj
YXNlIFdNSV9IT1NUX0hXX01PREVfREJTOg0KPiA+ICsgICAgIGNhc2UgV01JX0hPU1RfSFdfTU9E
RV9EQlNfT1JfU0JTOg0KPiA+ICsgICAgICAgICAgICAgaHRjLT53bWlfZXBfY291bnQgPSAyOw0K
PiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgY2FzZSBXTUlfSE9TVF9IV19NT0RF
X0RCU19TQlM6DQo+ID4gKyAgICAgICAgICAgICBodGMtPndtaV9lcF9jb3VudCA9IDM7DQo+ID4g
KyAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBkZWZhdWx0Og0KPiA+ICsgICAgICAgICAg
ICAgaHRjLT53bWlfZXBfY291bnQgPSBhYi0+aHdfcGFyYW1zLT5tYXhfcmFkaW9zOw0KPiA+ICsg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAvKiBzZXR1
cCBvdXIgcHNldWRvIEhUQyBjb250cm9sIGVuZHBvaW50IGNvbm5lY3Rpb24gKi8NCj4gPiArICAg
ICBtZW1zZXQoJmNvbm5fcmVxLCAwLCBzaXplb2YoY29ubl9yZXEpKTsNCj4gPiArICAgICBtZW1z
ZXQoJmNvbm5fcmVzcCwgMCwgc2l6ZW9mKGNvbm5fcmVzcCkpOw0KPiANCj4gaXMgdGhpcyBiZXR0
ZXIgdGhhbiBoYXZpbmcgPSB7fSBpbml0aWFsaXplcnM/DQo+IA0KPiA+ICsgICAgIGNvbm5fcmVx
LmVwX29wcy5lcF90eF9jb21wbGV0ZSA9DQo+IGF0aDEya19odGNfY29udHJvbF90eF9jb21wbGV0
ZTsNCj4gPiArICAgICBjb25uX3JlcS5lcF9vcHMuZXBfcnhfY29tcGxldGUgPQ0KPiBhdGgxMmtf
aHRjX2NvbnRyb2xfcnhfY29tcGxldGU7DQo+ID4gKyAgICAgY29ubl9yZXEubWF4X3NlbmRfcXVl
dWVfZGVwdGggPQ0KPiBBVEgxMktfTlVNX0NPTlRST0xfVFhfQlVGRkVSUzsNCj4gPiArICAgICBj
b25uX3JlcS5zZXJ2aWNlX2lkID0gQVRIMTJLX0hUQ19TVkNfSURfUlNWRF9DVFJMOw0KPiA+ICsN
Cj4gPiArICAgICAvKiBjb25uZWN0IGZha2Ugc2VydmljZSAqLw0KPiA+ICsgICAgIHJldCA9IGF0
aDEya19odGNfY29ubmVjdF9zZXJ2aWNlKGh0YywgJmNvbm5fcmVxLCAmY29ubl9yZXNwKTsNCj4g
PiArICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICBhdGgxMmtfZXJyKGFiLCAiY291
bGQgbm90IGNvbm5lY3QgdG8gaHRjIHNlcnZpY2UgKCVkKVxuIiwgcmV0KTsNCj4gPiArICAgICAg
ICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICBpbml0X2Nv
bXBsZXRpb24oJmh0Yy0+Y3RsX3Jlc3ApOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4g
PiArfQ0KPiA+DQoNClRoYW5rcw0KS2FydGhpa2V5YW4NCg==
