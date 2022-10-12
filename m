Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED15FCEC6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJLXNT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJLXNS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 19:13:18 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2BE125733
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 16:13:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CLbULj032079;
        Wed, 12 Oct 2022 23:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=BO9mQixa+vvYYebJbULf87kjRqI99nfs6YGrQB4QIyo=;
 b=njH+uKZ+ycCZKz3ZLhzhBJGbzwdyl4FDnWTCqB4YeeXcpwHeVZG+N5xzgvu8Q6nqF5Sd
 PoO4YnGNGn06nQu3D06/YRLU1P7Ksl7lyxJxBKR2hvBuD/dvLfyslBA8rvNb2eBID5tP
 DvItPV1UkKVhfJwZG/uB2i2Rn5jXAPfUfusjMmcbt8m+R0Fg0Y457zhgyVu1ILvshY4q
 w9xRwn0lnGgpidnlDNkWFPQUaROyfe3tSHf6DBY/3mdJJEB9IHRL0qdYmQzzfAGdJstB
 6R1YOFd+FssuUIn/vaqLCmAUo4AQL8Y8f2HlYWoXXeor/NKvUqlGWfDtcYsg4VhLqI5k Bg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5t05hx15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 23:13:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOSL/Kp6/XUyzCiU9R9GcbLtO2QcdPeff8oV6U1sA8y6++5bkd7YgIBIdRHj81jhgvNII/zj5tzNd89+5qhoBzPE6yFO5BauWdP3prOEwf9JUIkRngXECPshrkyhc1ZNjFt6YYQpnrVIs04CO38DXz0mGrZBDtc8AdwsASnd+vT9iIv5tJaR8rSpVmTVyZSFCJcY612eHWldKblaxEgPk5uQvcCzMS2oTVaSlIzZwDGstvIHKyHxdJutj7aLlhJMK2KdCsayjwOqBh6o80aPg8EVYtBZFxgTuyrhF/wRIO3q9XsttnW0jyl9k2redjER/cfNVt2+resCckyFQWusIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO9mQixa+vvYYebJbULf87kjRqI99nfs6YGrQB4QIyo=;
 b=L1tjpg5Yb3Uk6sIyXxdECWjOWuMuXbCYfhx20r5jignyEYDJNeDIXhlSG3sgqlRrV9wz0GE0AiTG59KAZ//Fglw3O2eC8fGyK5Eq6fM6P0sARiNmoujYlrrjbeXXBl/kYKh0+5GOEDVvZxPpUvOU37OsOM6mWWLYfcfxPSVvZMG0HRMZGuvD0+xB72hH0ZOr61q0sly9Z5CEzfG/lxeKW6I6Ss6XnexAH21xKdOju0mau7JExgCl7RysdAcGWk/wYHGBc1370ZUEVAKCiy9+D13Q3Cki9unOGwlcBraVQwDkliYhe5ruSzE250ba733WhG7gqC78toClzKpXt1ouEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by MN2PR02MB6781.namprd02.prod.outlook.com (2603:10b6:208:1d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.18; Wed, 12 Oct
 2022 23:13:10 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:13:10 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 38/50] wifi: ath12k: add peer.h
Thread-Topic: [PATCH 38/50] wifi: ath12k: add peer.h
Thread-Index: AQHYrmYmTd6pJHUS90e/FC5Eit/9Yq2zgWeAgFhCAxA=
Date:   Wed, 12 Oct 2022 23:13:10 +0000
Message-ID: <SN6PR02MB4334D304627589F8857DDC3FF7229@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-39-kvalo@kernel.org>
 <4b5421a2-f111-b7f2-4eeb-6404e8f390d6@quicinc.com>
In-Reply-To: <4b5421a2-f111-b7f2-4eeb-6404e8f390d6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|MN2PR02MB6781:EE_
x-ms-office365-filtering-correlation-id: e3b6d142-ff2d-4526-77be-08daaca75482
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xdemSBAMwiAbnO+jqXUAY9EiX5fVuZpm2iiZcc0yxiMzZ+PkJQ6X+srL1oBGQw0A/TsikyNf5HSDswIsGZNvSkjBtPuiP7u5OPWRzPIaollrB2cbiwOIUFHK9+qFxlbFgRcqreyZaZpGEPGMNxtyhD2l2S9AaeiluZ/xlHsWPYkaCeICJdPY0kbIwBaSdWXEWdOvA6b5z6f+Zb9TNmIz+Rth902nyXg8kBK8krWg/ggl2uzmQlK/40QwTz/WhjJK4BD+Ng5ZT5/t2zXDqFcaZu1sPMXNI/0e7OAWVV91sdaPnPdWlEidbmNC7686xz/Qq0A7jccxpu6ByhkR5RnCkZxrxz0C21dfY2Q1MWm4GGNp3EgQTweJUKV23lVtrbngv1RJ3G4AZsR+4DRf57oQLPVLDqARzJwFNhBzn6Bz7/LmKeRKS2rHwzbg4ITVSA6I0SisypzNeJ8XWqg1FwmsnvKFhfdNRJlsrVldS2D17q16q6+Uaf6BSWpyyaZnuXIw/lg2eOHTKoynYagTd6Q6y4W3WP22ZB7FFR5O/5KwXHVcsF39HxouSY86aRG5mQb3Ge2WXVP1/E4BCyI/W++qsrs961vGIDOw6waC9KR93Ub/XkPt/Ykkm1sch5Qnql2BkkkRdOzcTcR0G7mQjhBqatqXi2BmjUzL4wMb5WoPDpGIf+vWKC2AT0i1E0NwE8recQUKL6Q5WPPK+14a9xMAXMJ8q/yHG6kVAykHI3E+2N3An5/fcRJ+CD/lcx4kZX1jvqqaNj5Eew/cgfsOXLWojA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(66446008)(38100700002)(7696005)(8676002)(4326008)(38070700005)(55016003)(41300700001)(86362001)(64756008)(6506007)(33656002)(52536014)(76116006)(8936002)(66946007)(5660300002)(9686003)(110136005)(478600001)(186003)(71200400001)(66556008)(316002)(26005)(122000001)(66476007)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk1UdENnQ3hoSitQZXZLZXpaWERxWlliQk5oamxRUDFUZkRSWEZ0NThIeWpP?=
 =?utf-8?B?TE9OY1YzTWFXWmNja2VrRWR6U1JaR2U3ajNJaEdHWVNMOU1YeGhIUVNOandV?=
 =?utf-8?B?SVZoc25TL1RPN1JnS0JNU0VQakxkbklSQkc4OHcwem5QZFY3U1Z1bUhDR3Za?=
 =?utf-8?B?VnFqdmx2dHJJWWRjTkxENVhkS29mYnVjOG5SU2duK3hVaVlNNlFGMFVqUUpt?=
 =?utf-8?B?VzFQZHZLSm1SZkJlVG9jd2tCNXRtdlRBajI5S0hTVXBUWDFGcldDcHprUGN3?=
 =?utf-8?B?YUJwUExHK3FzeG03cGtSNDZ3amVSNTJWcUdEeUxEV2lDMkcweTdJNjhrSFVO?=
 =?utf-8?B?SDBsZUVvUHZEendpVk5WRnVvZjFOODg5M2l3SU5Qei9SallyOWZFZ29MTWE3?=
 =?utf-8?B?dnpkRE1HTGJYZUNjYjZtSHZCSC9QUy9EQ0U3SGQ0MXI4ZVJBeVhKdm1lZWRw?=
 =?utf-8?B?bHFvMERVYUNJTWxqVmtKTFIrM0lMZDBUV3Y2OTZOdTVJbnk2aE8yUnlLYlVv?=
 =?utf-8?B?Y3Z1K0gycHU0N2ZaZWZCNWdlQWxSZ0t3ZmN0TkFXa1o3c3lUdnpiVnNHak96?=
 =?utf-8?B?NlRna2pOa2pVcVF3YWVFYTJaSE5LR0t4THJCSnc0czF3c21DNkJpczZaVEF1?=
 =?utf-8?B?Yk9qc09kSXE2NElpVFV1L0UyQ3gwNE9JYndOZzR6NitCaytucVFTSnErMEhT?=
 =?utf-8?B?V09nYlRXNHEwRC9YRXAwS0xnUHBqeXdVWkZYVXRIQlNWODBrV0ZSYitqcFZw?=
 =?utf-8?B?MEUwK3JEelU3bHV5SERuTmVNKzN2eFhQbEZHL1VZMUcxN0NPeTFNMzRyMXZ5?=
 =?utf-8?B?OXpvZ0tmVzltWDVVRGxLWWppZEVkazA3eTNHRmRKaHcvU2ZTNk5YRkNXZ0tu?=
 =?utf-8?B?dVZNQlJLU3RLMVpsWDlZWnIzdzAzUjY1MzZXSFR3NEVPYkhQTDRKOU8wZGhQ?=
 =?utf-8?B?OVUrZ2ZkLzIyekhRV2xaTzYzMjF6eDVTSHBsTzhid1BDVVorSkhzcmhZNVcw?=
 =?utf-8?B?Szl4ZWdpei9Rc3hJYStEcFpHYWJCR1BjcU1zVlBrZzlScnVWcVd6a2QvM1Nv?=
 =?utf-8?B?aVV2STNEZkpwaVI5THM2UzNpd3ZBZ3VqUnVRVGpjb3JVWHpaamRvRENQWElU?=
 =?utf-8?B?RHJGYmk0VzV5UUlCdVVqMFcxazVFRy9lREVnUW5uYUJEem9OM3RYZUxLS1JQ?=
 =?utf-8?B?b2NlNmdSSUJXRE1aSkRmVU1hTDJRRlNoS0I1ZTMxQncxL25NM056NEhZMTJk?=
 =?utf-8?B?VGtlKzF5cUQ2Ni82VlhiblBGeWdJOFNaVzN3UTdoN0x5b1paRXd6NzJ4eUZa?=
 =?utf-8?B?bWx1N0ZtdmIwT2NFbDY0V1g1bGxmeUVML2ZYZWJGbE1vRHVER1RBT0ZLR3dx?=
 =?utf-8?B?UGRiTTBJQnpHRlZtS2pGbzF6enpVVEd3MFkzWlIvanY3L0dKTFdIeE04d3hR?=
 =?utf-8?B?Nk55NnNoSmRYeThjNkx1ajIrNnFqdE9hc1lKZ2NERHluVXVSbVBtVFJrTmEz?=
 =?utf-8?B?eWUwMUwyL2tDS2Z5YmF0MVlYaHE2WGJaQmlOeU5GY0gwV3hhazBuWHNKWnhv?=
 =?utf-8?B?Vll2dnBjTzM5RDgyM0RiZXFnNzFydG1pUEFMdnJIaUNRRmR5SlU4NlNEM0pO?=
 =?utf-8?B?V1crRUdlSmYwbUJIQ1E5bVI3ejI0akY4MmdVbkJqalpvSVNSMlMvV2h0MDBK?=
 =?utf-8?B?M0RHQndNSkVlOGVSUEdybWt4c2YvYUU0d1RjZDhHNkZIRFhBWDNqQXRtYTFE?=
 =?utf-8?B?R2s2ZSthbEtyeWh2bjVJOHNOL2F0cDR3OUd2cExDZ2RDK0RXMGtzOTB5V1BY?=
 =?utf-8?B?NUNtL0Z1N3pHZFEzaUkvRGc4eWx2dzlvQ0d5LzVxSHFJcHRUeEllQk1RNXRa?=
 =?utf-8?B?aXFSMmZzREtBZDVaVThsVzBYUjc5dkh6YjMrMTN6R3Nva1JsYVh3d3RuRlg1?=
 =?utf-8?B?aDRoMElmek1EZnVoQUNkVG82QzBrQ3hJakpFWi9GWXNBOUpzVjNmOXlaYVhE?=
 =?utf-8?B?amFWMjgvQzFrRW5lQk5kbWhpR1YxZmF4eWlTWjVyTkdCRjUveWowWmVtL2p1?=
 =?utf-8?B?MWNJSDJvcVNkYStja2cveXN4c0QyZkttU3Zob1ovSmtPTW1sMEhPYk90Wnhn?=
 =?utf-8?Q?BiSFNzUTkBv46bwVmt6EJ17Zw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b6d142-ff2d-4526-77be-08daaca75482
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 23:13:10.3542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: conPS7Ox0mQaJNc6xZYrV4m/xjgR1zymPMgyYpOgzFHAjktwRYdd0GfdWcdln4WQiEWB3szpaVvhTQ95zyKzmMJ1LbP25SBAk5/2Ojk2L2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6781
X-Proofpoint-GUID: raMCEJiAiKAJNRj43JQYDpo4gZT7ap8n
X-Proofpoint-ORIG-GUID: raMCEJiAiKAJNRj43JQYDpo4gZT7ap8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=982
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210120145
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmVmZiBKb2huc29uIDxxdWljX2pq
b2huc29uQHF1aWNpbmMuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMTgsIDIwMjIgMTI6
NTUgQU0NCj5UbzogS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IGxpbnV4LXdpcmVsZXNz
QHZnZXIua2VybmVsLm9yZw0KPkNjOiBhdGgxMmtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMzgvNTBdIHdpZmk6IGF0aDEyazogYWRkIHBlZXIuaA0KPg0KPldBUk5J
Tkc6IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFz
ZSBiZSB3YXJ5DQo+b2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQgZG8gbm90IGVuYWJs
ZSBtYWNyb3MuDQo+DQo+T24gOC8xMi8yMDIyIDk6MDkgQU0sIEthbGxlIFZhbG8gd3JvdGU6DQo+
PiBGcm9tOiBLYWxsZSBWYWxvIDxxdWljX2t2YWxvQHF1aWNpbmMuY29tPg0KPj4NCj4+IChQYXRj
aGVzIHNwbGl0IGludG8gb25lIHBhdGNoIHBlciBmaWxlIGZvciBlYXNpZXIgcmV2aWV3LCBidXQg
dGhlDQo+PiBmaW5hbCBjb21taXQgd2lsbCBiZSBvbmUgYmlnIHBhdGNoLiBTZWUgdGhlIGNvdmVy
IGxldHRlciBmb3IgbW9yZQ0KPj4gaW5mby4pDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2FsbGUg
VmFsbyA8cXVpY19rdmFsb0BxdWljaW5jLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJzL25ldC93
aXJlbGVzcy9hdGgvYXRoMTJrL3BlZXIuaCB8IDY5DQo+KysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL3BlZXIuaA0KPj4g
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL3BlZXIuaA0KPj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDAzNDZlOGIxYjYwDQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9hdGgvYXRoMTJrL3BlZXIuaA0K
Pj4gQEAgLTAsMCArMSw2OSBAQA0KPj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBCU0Qt
My1DbGF1c2UtQ2xlYXIgKi8NCj4+ICsvKg0KPj4gKyAqIENvcHlyaWdodCAoYykgMjAxOC0yMDIx
IFRoZSBMaW51eCBGb3VuZGF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPj4gKyAqIENvcHly
aWdodCAoYykgMjAyMS0yMDIyIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBy
aWdodHMNCj5yZXNlcnZlZC4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaWZuZGVmIEFUSDEyS19QRUVS
X0gNCj4+ICsjZGVmaW5lIEFUSDEyS19QRUVSX0gNCj4+ICsNCj4+ICsjaW5jbHVkZSAiZHBfcngu
aCINCj4+ICsNCj4+ICtzdHJ1Y3QgcHBkdV91c2VyX2RlbGF5YmEgew0KPj4gKyAgICAgdTggcmVz
ZXJ2ZWQwOw0KPj4gKyAgICAgdTE2IHN3X3BlZXJfaWQ7DQo+PiArICAgICB1MzIgaW5mbzA7DQo+
PiArICAgICB1MTYgcnVfZW5kOw0KPj4gKyAgICAgdTE2IHJ1X3N0YXJ0Ow0KPj4gKyAgICAgdTMy
IGluZm8xOw0KPj4gKyAgICAgdTMyIHJhdGVfZmxhZ3M7DQo+PiArICAgICB1MzIgcmVzcF9yYXRl
X2ZsYWdzOw0KPj4gK30gX19wYWNrZWQ7DQo+DQo+KHJldmlld2luZyB0aGlzIG91dCBvZiBvcmRl
ciBzaW5jZSBJIHNhdyBzdHJhbmdlIHVzYWdlIGluIGRwX3J4LmMgcmV2aWV3KQ0KPg0KPnRoZSBh
Ym92ZSBzdHJ1Y3Qgc2VlbXMgdG8gYmUgYSBob3N0LW9ubHkgc3RydWN0IHRoYXQgaXMgb25seSB3
cml0dGVuIGJ5DQo+YXRoMTJrX2NvcHlfdG9fZGVsYXlfc3RhdHMoKSBhbmQgb25seSByZWFkIGJ5
IGF0aDEya19jb3B5X3RvX2JhcigpLg0KPlRoZXJlZm9yZSB1c2Ugb2YgX19wYWNrZWQgc2VlbXMg
dW5uZWNlc3NhcnksIGVzcGVjaWFsbHkgc2luY2UgZHVlIHRvIHRoZQ0KPmxheW91dCB0aGF0IHdp
bGwgY2F1c2UgbWFueSBtZW1iZXJzIHRvIGJlIHVuYWxpZ25lZC4gSW4gYWRkaXRpb24gdGhlDQo+
cmVzZXJ2ZWQwIG1lbWJlciBpcyBub3QgdXNlZCwgYW5kIHNpbmNlIHRoaXMgaXMgYSBob3N0LW9u
bHkgc3RydWN0LCBpcw0KPnVubmVjZXNzYXJ5Lg0KPg0KPmFuIGFsdGVybmF0aXZlIGltcGxlbWVu
dGF0aW9uIHdvdWxkIGJlIHRvIHVzZSB0aGUgYWN0dWFsIGhhcmR3YXJlDQo+ZGVmaW5pdGlvbiBo
ZXJlLCBzdHJ1Y3QgaHR0X3BwZHVfc3RhdHNfdXNlcl9yYXRlLCBhbmQgdGhlbiBmdW5jdGlvbnMN
Cj5hdGgxMmtfY29weV90b19kZWxheV9zdGF0cygpIGFuZCBhdGgxMmtfY29weV90b19iYXIoKSBj
b3VsZCBiZSBzaW1wbGUNCj5zdHJ1Y3QgYXNzaWdubWVudHMuDQo+DQpTdXJlIEplZmYuIFdpbGwg
YWRkcmVzcyBpdC4NCg0KVGhhbmtzLA0KU3JpcmFtLlINCg==
