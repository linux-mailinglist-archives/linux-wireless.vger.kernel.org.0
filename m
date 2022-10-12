Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967E5FCEEF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 01:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJLX10 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 19:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJLX1Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 19:27:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8294A10A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 16:27:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CMCI7k014255;
        Wed, 12 Oct 2022 23:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=qAIZr9MMrpLXxL5XzLCjK4rlNbfbNIs6XhZR1Dq4Fss=;
 b=dFoqCzElu0yC+0sSeHMzhxQhDEpguFAnQ3rBmCD36BMfmbT2iFyXfDc3IwhKz6vu0eaI
 smrrhtnwY1xkz4XnD1Cza3flRpHgHBa/AYbi+1C1xbK2ysMgb2PmLbs6gmnbgst5sFXU
 jY6cGaHG3drJzcBdl7FTbzDtpEwb8gwRHr165j90nJKShveJlbSqvzIjquOpWrQG2Ytr
 x1ZHO4Hml1fLv4dfYQSyHoBXquiNQI+u2M1HaWWvWtNviuxBURPjIVqfkvNt4476L1/Y
 nhqsb7Whg0oN6o/KC11ge1gr717mid8+vqJI5FEjUYYhEksGTmTjc4QDiOLBSm4wv9Wl Qw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k5t8r2ep0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 23:27:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp8FkMt3mUkzR4VaYnbPOgiTsDmn9UxbVwXmSMeCOgvmyDRG17t9yz45DdkVn6LlqIKvpZ3kRl/7rBd44DasNS4Ic3z8fbBeZZOCNkWvREhoAUaIGFcI2PDrznLfm/X46/2XII7V59li94CzQ7Z5hdSkOizR60YNqewhdiv7M5CFuTWNxxje1vd+dMhSu/OYygKfJyeC12DWiETSEtCfMUPp8KIunF+RzWo6Bss4ypif5dAS1OahB/5mqSDZs0kKJvOfgeM086dVKoAgjv+ERDFXgqT75pUslUM6okiw3P+AEjxstRVo6GbxgTl2Jro+eFCPznBaaW4IMHDt1+/cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAIZr9MMrpLXxL5XzLCjK4rlNbfbNIs6XhZR1Dq4Fss=;
 b=DOfH9zxueAQ9AQG+0cMejtf0QizHVK41+j9rLkurCLYqlrBJ1kxik2OJzI5DglTcGQjrZMZg091p75WBaNgTv6U0PNIRmaNyjhVRmB0E7h0vhJPckc3BZQPHmtycOtcqQnt2V/W2mRvPeHkAi74CNreODli9AyTViy6ZVTkw28FAWSwcRyvd3jeLVWg9p1dl7LDQs0J42kjzvJaRAXUkg78LjMjZNgfD4v4DFPU1jtNoRfx7L1p5ArcIJ59TStuIu6ohZp2DUKphR+TsqP6ON6NmXI91pIXPmTpgFgoAYi2UsLRiITJKVeuhvPVsp1CgtGozf2tyjjMm1Rfcx+UdzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by DM8PR02MB8005.namprd02.prod.outlook.com (2603:10b6:8:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 23:27:16 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:27:16 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2zws4AgFgD5HA=
Date:   Wed, 12 Oct 2022 23:27:16 +0000
Message-ID: <SN6PR02MB4334DD96B41E68997CCCE660F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
In-Reply-To: <b2cd5b02-60ca-c788-af71-9f36f6a8ede3@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|DM8PR02MB8005:EE_
x-ms-office365-filtering-correlation-id: fe4edd57-0907-4e15-d70f-08daaca94ce0
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wc4Epd1b3mtNMWEfy5HDL29jC5Q+lq7dzxDGvD8w0Yr/WMX+ArWuHzxJR73DnLtoSmvcwePP8M46XcVVgTfqMwkTLmA9hxPUcg+PrWEAWi4HwD7/V3ytqVsux2qfRPz1sSne9BR7MHSsjIse36JlYBmk5klGxhyT7o9KxuNU8u+DiIBM+Sj6F0EotzeLnFla5lI8j5Xb6xvmlBumaJuHax7FkGXziQb63QZjwrbuowzi34DgQ4c5eKtXsWQR8KM8tYe1Egtad4CQJ/QAymBG9oCGvKXg3ppH97m9biUUvMGk51eeJ/0zAj5cy+0u2GO/OSHXKOxpbYRtgLQji9TzZ8H2M3idhM8R6QNSgQblqO4PMnHS5PGOSSfka6KLKbSvjNUUaGlOEzsKFyOkUpgTbZ+P44axwlTSKgqToN8sBBX8cc6UzmFbu+LzMocXCsQV4TAlEJ2xaFmTnuNFL5+Vj3OfmkAPKmnfidZGxDLShJuZUkb4ziIwgsclGp/pKfqGm+uxNaTLT8lBampYznqoejC7Xt0XRg9ZLXPRv0xT3/BaZJHh7Fi2e6tompfaCuucOhlcpkJFdAc3hI/r6Ne9VV9YwEIf/D6rAO60VQkuSYPEfQZ4993jLjU3LowMnXr8RORrEZSy2zkQ15jvLrUxcsfkRC7LAUsWIjb1lWJ/sXdbeauxXyCN1d2TZF62yHePIJMe/nUpIPD8xtzfPbXBgXHQrq9FtHl1bAIG4eNb60INcGnH4X4hGTttsHoreKjuUlc/szbxkhetdtgqJtSPtw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(33656002)(86362001)(4744005)(5660300002)(38100700002)(122000001)(186003)(83380400001)(8676002)(38070700005)(9686003)(316002)(7696005)(6506007)(26005)(64756008)(71200400001)(76116006)(66946007)(66556008)(66476007)(66446008)(478600001)(2906002)(8936002)(110136005)(41300700001)(52536014)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm1MR3RERlRkSEZqMEN4QVVZZ0MwemowZWpCcmdEMXJCOFpUVC8rcHJLTTFI?=
 =?utf-8?B?aXdROWlEOTJ1dXlIOWFMYkR2SmgxZmFDKzhLR005MlI3eVV1eUhPUCtsdjlv?=
 =?utf-8?B?SDJ4ZEhEaGF3ZEdCbU5sQlhKeUFLYjNNRHF5cTZqMWpiS08yRU45b3dlS3RD?=
 =?utf-8?B?VEZUOWh3MEZpSVBSNlFwU21kTWRydzFmR21ab1Rkd053YitmM0tZbHBqUk8w?=
 =?utf-8?B?WHkwQkVoVGgvOUNmeU0vbGRNMmI1NTRQUEsrcTNMOTZtaTJEaFBzOVNUL2tN?=
 =?utf-8?B?RXEvTk0zem1KQU5BZktTUmROcjdnU2d1dlMxaVBIR1lmZnJYL0xpOE9UOEF6?=
 =?utf-8?B?TVIrZllQMldNRUhpcHZXajJXZzc4UmVsZlB0c3kxbzRlaVc5eDNsYmw0TmFa?=
 =?utf-8?B?KzVkV2RyWktyUWpsUXBJYmV2aVNmdFE2b3lvMGdGMHlBdHZLc1grdTFvczZS?=
 =?utf-8?B?bkNFOS9qamt1Wm90clgybnN3c01HcEZiVUlZUE1LVFFqYlN2UHYzVVQwVjBs?=
 =?utf-8?B?KytrOHREU05MRW91UkZrR1QydUh1M25jd2xldXJ5RHM2c0lRUUJrQmcvdEVZ?=
 =?utf-8?B?bVExY29mc1UzOHRVVnlxY2VnZjN6RTN0MGxVTnlzNTIwZ2dIZld1S0ZCa1Jn?=
 =?utf-8?B?MmtxNVN3enVXMlZiVG1OSWFNdTlZcmprVGYzOE1RbGNDMGxhTjRwOHhCVWh2?=
 =?utf-8?B?bXVrM1VmTm1FeXNWMlF1RDNVaG9PL25ZVkNoQ2lUQURaZlVKZHBwK1dlMmhk?=
 =?utf-8?B?VGxGa1NGc0lUejRVNzNEOUN3UW1ONjMvY0JOWU1kaSt1TzQvbUV0QmFFbHRv?=
 =?utf-8?B?RVhBc0o0K0pPV3htQUQxMHJGcFg1ekR6M04rZFFBK0tNd2ltdmpLZEFqREYr?=
 =?utf-8?B?d0E0R3Nld29BcTBEMTJhZmxzUGxkWnZ0QkRHQmtock8zMmMxVTlvWnN5amRZ?=
 =?utf-8?B?aGczVnpZUXhaMERlbTJ3NGE3R2tTeUV0T0xzZGl6ZkQ0S2xtUDNjd3JRTkEw?=
 =?utf-8?B?NzFuSlU5ajJEWDZBdEhwN0FySE4xR2E1VmZXUUMwalFhb2VoYWdweDJnNlBN?=
 =?utf-8?B?b2x4K0VYK1hNQk1Na1U5WnpQWXZxQWxmbGFHR0wycS9ZMkVyWC9sQSt1ZE9S?=
 =?utf-8?B?TEJGclo1M2pzS0pOQ0NMK1JPMlpWUlV3aXV3TTVmVmtqOFRYZS84MVRvdXF4?=
 =?utf-8?B?cnJJemdEMkhyaS9neFVIMWhuZU9KMTVTNzRoS2Z3UFFodGFJY0F1RVlvOVM0?=
 =?utf-8?B?N0lwcDVFQnFUeC9kLy8xN3RFOVh3djI1bVpqVE16RUFzaWhMSEpLaDFJMUFO?=
 =?utf-8?B?OHhoSEFzeDhjUVhzOG5QcVVFbHhVQVBvYnVCV1BHb1BKU1VSVWMwRW1pOUNY?=
 =?utf-8?B?a3N1UDQvTllVZGxkSzBhRE01WmNjTldYblkvYzVRNXFGZnY1RTcrWTNFUFVx?=
 =?utf-8?B?TERpNGE3SHp4V3NOTFRNcnByMUYxTitoM1QxT1ByS2h2UHhXa1VjWGFsR01E?=
 =?utf-8?B?V09OUGVscVdLVkFXMUFKd29rWjRjcXJjQWdZSzJzd1BQNzBDMWQyTlpIQkVh?=
 =?utf-8?B?VmxlajY3MzRTOFVQMWJrTjFQblYzRUZ1RVJkQzZRSnFnUTRCTHRwNDJXOUNt?=
 =?utf-8?B?SlJYc2FCNlpMMmY0M0RiUEd2S2VYRHFscUFpMjVsSEVub29BY1VkTFRtOTZz?=
 =?utf-8?B?S0toSW5DRWUrcEUxRFBSVWhJbFExUnFVd1dxcGorbzJVTXoza1ZrOE43bkd5?=
 =?utf-8?B?Z1NacHgwTElQN2crb1ljSHMxSWoyZ3NjYnltdmdmL1dNUnRneHkrYnNmNmov?=
 =?utf-8?B?aFJGcFdpV3JkMkpmc2JORkxIeE1RRmlpQ0hwRHRFNXE1VG9QaC93NWZwaDk3?=
 =?utf-8?B?c1h1MVJnd3NpM0NTUzd6dUFYcVVCekk2VW9mU1djbXJIOEJDWEdkSHM5anBG?=
 =?utf-8?B?MmU1V3FVME1ramJ2YndRTjZFdS9HdktmRmZyV1lDQzhJMGIyOUdocG41REZH?=
 =?utf-8?B?MGphamlockF2N1JPOVdRZzZnY09VSVpBZFZHZytncnpFOHo0ZDdYbk1WcXE1?=
 =?utf-8?B?WmZYMWVlODJablh1M05JbmRMUVZMaW1zcytGT3RwOTJSVG53Z01zNGtCN29z?=
 =?utf-8?Q?szkSswaninEy+vKS0GjfDoZkZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4edd57-0907-4e15-d70f-08daaca94ce0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 23:27:16.5131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfeYM1I0kvfMC583yl5bwvuJtQjzIYUeM7744ZQoUNM6YPvnOrCHAsLAIuOtwbqkaWGkMddj1iecsdTvHa8FbukM8yAknjgkP1yBSfC4kS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8005
X-Proofpoint-GUID: RTh78KPJmCKrzcDbicJ84koSkz06kRYD
X-Proofpoint-ORIG-GUID: RTh78KPJmCKrzcDbicJ84koSkz06kRYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=863 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4gK3N0YXRpYyBpbnQgYXRoMTJrX2dldF9wcGR1X3VzZXJfaW5kZXgoc3RydWN0IGh0dF9wcGR1
X3N0YXRzDQo+KnBwZHVfc3RhdHMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1MTYgcGVlcl9pZCkgew0KPj4gKyAgICAgaW50IGk7DQo+PiArDQo+PiArICAgICBmb3Ig
KGkgPSAwOyBpIDwgSFRUX1BQRFVfU1RBVFNfTUFYX1VTRVJTIC0gMTsgaSsrKSB7DQo+PiArICAg
ICAgICAgICAgIGlmIChwcGR1X3N0YXRzLT51c2VyX3N0YXRzW2ldLmlzX3ZhbGlkX3BlZXJfaWQp
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBpZiAocGVlcl9pZCA9PSBwcGR1X3N0YXRzLT51
c2VyX3N0YXRzW2ldLnBlZXJfaWQpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gaTsNCj4+ICsgICAgICAgICAgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gaTsNCj4+ICsgICAgICAgICAgICAgfQ0KPg0KPmlzIHRoZSB1c2VyX3N0YXRz
W10gYXJyYXkgbWFpbnRhaW5lZCBpbiBhIG1hbm5lciB3aGVyZSB0aGUNCj4iaXNfdmFsaWRfcGVl
cl9pZCIgcmVjb3JkcyBhcmUgYWx3YXlzIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGFycmF5Pw0K
Pg0KPmlmIG5vdCwgdGhlbiBkb24ndCB5b3UgaGF2ZSBhbiBpc3N1ZSBpZiBlbnRyeSAwIGhhcyBp
c192YWxpZF9wZWVyX2lkID0gZmFsc2UNCj5hbmQgZW50cnkgMSBoYXMgaXNfdmFsaWRfcGVlcl9p
ZCA9IHRydWUgYW5kIHBlZXJfaWQgaXMgbWF0Y2hpbmcgc2luY2UgaW4gdGhhdA0KPmNhc2UgeW91
J2QgcmV0dXJuIDAgaW5zdGVhZCBvZiAxPw0KVGhhdOKAmXMgcmlnaHQuIFdlIHVzZSB0aGlzIGZ1
bmN0aW9uIHRvIGdldCBuZXcgaWRzIHN0YXJ0aW5nIGZyb20gMC4gU28gaWYgYW4gaWQgaXMgYWxy
ZWFkeQ0KdXNlZCAoaW5kaWNhdGVkIGJ5IGlzX3ZhbGlkX3BlZXJfaWQpIHdlIG1vdmUgdG8gdGhl
IG5leHQgaWQgYW5kIHJldHVybiBpdCBhbmQgdGhlDQpjYWxsZXIgd291bGQgc2V0IHRoZSBpc192
YWxpZF9wZWVyX2lkIGZvciB0aGF0IGlkIGFuZCBtYXJrIGl0Lg0K
