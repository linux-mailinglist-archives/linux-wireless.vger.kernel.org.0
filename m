Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEF45F41D5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Oct 2022 13:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDLPj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Oct 2022 07:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJDLPh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Oct 2022 07:15:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D47275F0
        for <linux-wireless@vger.kernel.org>; Tue,  4 Oct 2022 04:15:37 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294B7Cg9029939;
        Tue, 4 Oct 2022 11:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=8z7aOcD+f+6v75thUSQVOI4ZYr+4SEfuOQjarwXwOaw=;
 b=C3xWSA611hlLZst9KmMxp9SKBv4Nmwmb/5dSepOSbjPnVsoMgPI9nmSPpgbigkly0Fvn
 cVJKxu0WHZjCcoIP7B4iVtIbXo9K6TGIo1SCyzcR1O4jPD1QPvgh3AUNyQhF9lG+1t3c
 OpwNtj8RQAp6DjBRWARH9fJwv+JF26RaQPUa6vxkOnvRCSLwtYDl3iwSRG+zKdDywVEa
 NKX/ZJnwUGKb60pcrQgixvx7lVczKA8oskixfaW7wmZcJPyiYxq/ObGWUVQfTxLT/Eji
 EbbPCEY7WdW7GOplxEXqpdE4XGdM0xijwFb0ySj061zfD34q7anvjuwgKIniYiam0wy0 UQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k0hxpr66p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 11:15:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHO0mZvoN0WSx46PqXxT29YAAF24D6aVxBMFGyRQv0GHk2OfjlOl8Vfnggo34ZppRif+31J0W4+0P48if5xuVc+34rhNKxUy8+66R1oU9sBVBTBf1L/4W5gFCKiyCMTUTVyhv4bKvz0u20jCGIrFCIq5g3yF/4fQ1hyYPJ8Py46si1RRyTS/M4ueK0gk11ZpvHSjDjfChcyne62UAcSXSP8Ba3QmfIe03FJoOBYqetMl4Mb7/j/H+wF9fq/BXxBO306HN7W6WnMKPnyZWnEf2faVZHUEeiTbqHOJC5nS9hm7Pk5k8goqHlcQMACpTiKOeFqamBoNXxc6Rt043Re3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z7aOcD+f+6v75thUSQVOI4ZYr+4SEfuOQjarwXwOaw=;
 b=BiaFJh6MRZbWqdKVK7jGIa6YmgxMfrrsOF4T8tHKO5QDro2i2s2TJoxRPXrlcqiN/DrDshWgccNi4j8VqZ3aeYfi753LU0Uc3fxxomyMvOq74Na+HOIWeG/mWcjOvEmmT8hFzd/Xu+Ue3S/c1N5Aj4ywQbUJ88h530PLHJqFdTiqtGjeODdlYzUYns5Mptdrqd1TdMD6B30KmaZtx4satN4jtODagKkk+s580PvLMKGBVIAfNklvmso5gLK8Q6TEpBH/1knRSg7Pzo0QpRdRl0tpapfhmH1QbFqx+qNr4EBNLxdFVbQgBixshLn6vwwDLaetwnOPK8R+oZqDkzwaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH0PR02MB8212.namprd02.prod.outlook.com (2603:10b6:610:eb::20)
 by IA1PR02MB9207.namprd02.prod.outlook.com (2603:10b6:208:425::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Tue, 4 Oct
 2022 11:15:18 +0000
Received: from CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1]) by CH0PR02MB8212.namprd02.prod.outlook.com
 ([fe80::a2aa:7ce8:a34:fdb1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 11:15:18 +0000
From:   "Karthikeyan Periyasamy (QUIC)" <quic_periyasa@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 23/50] wifi: ath12k: add hal_rx.h
Thread-Topic: [PATCH 23/50] wifi: ath12k: add hal_rx.h
Thread-Index: AQHYrmYen13fOdS1qku2BWKhi8rn/q2z1DSAgEqT0oA=
Date:   Tue, 4 Oct 2022 11:15:18 +0000
Message-ID: <CH0PR02MB821240EB39EA61EA69767B60F65A9@CH0PR02MB8212.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-24-kvalo@kernel.org>
 <8a84fd8d-14db-97ec-0376-10b554aed257@quicinc.com>
In-Reply-To: <8a84fd8d-14db-97ec-0376-10b554aed257@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR02MB8212:EE_|IA1PR02MB9207:EE_
x-ms-office365-filtering-correlation-id: f9919681-ce47-4eab-500f-08daa5f9b875
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nezGswhUDPHMApe39wIehQRq3RAo0eLD60GNj10AETkKNWL2vY2edwblTZ0kVEwrJBRqeSJT9LL49bFMqFKOQBZfQ36bxrF0cSPRg/LHOTzvCD0OvbDQ4RQvs90EzMB41VQMasI/IQFqRGxKpycjtt31dCLYMTqSs0S8/+OOXI7gIHvUCbksR3XB0uWM18S6AunKG4via6l3PoBvbFPZvHMQSrA/u0FH6x9lYJHMwPHz8Zsnfl/EutdFtsKqSx4liRrIMjfCNRVfM5EKutF8qAvFOiGIlnEhU6YDV0oFqzv9olKCHtkm7gQKjDWtMrdfrxzxr2SiZuXQ0AkC8kPp+E8BbOkRGxX7yhdPeHM0NxCyqsT5jzgYWzcffkFwWJCQSED/LWEhdZAYTv+6r2vgXwTfisQiOjlRDDFKoThi37/JUMZcSmsb0Mr1Cxwg50rcO43g/Dr0tIjkJgac0RV/jEPukHMFja1KlTbQU8xTZWkyjmvzBa7ig1pdcfNrAw7UYq4JoiovP6BbwXucYsrsirR+G7AASH8MUNYdhk0B0OMNdUKJw+d85hnfyt3OhSKefDKoenjjKU+5kECkiJlv9MFDsiyVwY/ZqBNKEwdKwLu2p4i3Sbi04zxxch/nQ9jjm9hL6l6W9nooyklzu/8DRvj0aRXRZMAnC6UzKiEjMx2v9EIh8g6Hmp03LYmkbtzJA4ByFrIXE1mQ8DK9yLnOY/FbALENQ+U8va1rw6yA9i+//s+AhIrueBcLfLIZucXw3E7UDTEuKllB0CYsETCl+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR02MB8212.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(451199015)(38070700005)(33656002)(86362001)(122000001)(38100700002)(2906002)(52536014)(186003)(26005)(8936002)(53546011)(55016003)(6506007)(71200400001)(83380400001)(7696005)(478600001)(9686003)(110136005)(316002)(76116006)(66946007)(66556008)(64756008)(41300700001)(66446008)(8676002)(4326008)(5660300002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emdRTWE3dUI1WnM1Q1VRUHFSK3pXemMxL0pZOFRIbFFrM3o4aUFwVmc5bkN3?=
 =?utf-8?B?Tlo0MXRJeSthSklYNVgzVzhMZUwzZDk1NXZmNVBUelBUR2hYY243aDd6d24x?=
 =?utf-8?B?a0ZLQmpkN2o0NW1Tcm0ybWlnTHVPYWJoMTJrTUM2VU9DSitNQTNKTDdtNFhm?=
 =?utf-8?B?enRGZUVnMFVNcTlyQ09ESkhML2dPQTNuSEJZVHNsdXNOeURZQUljM2Nlc1R2?=
 =?utf-8?B?bFowOFJsSEY4OEN3TnJHTGlqc0p2bGt6dThjUE12dG85WkEzN0dNeEd5bW5h?=
 =?utf-8?B?VkZNNEY1d2lnZ0NIMkg1QVJLbDBSNWc2NzF3ZWhWM1cyQlZnMkM2UmJ4clY0?=
 =?utf-8?B?RFZLQi9Qd1RSK2ZNWHBBUXRtZ2J1NzViN01WRVRCTU9XRlFub01xNS81WUhr?=
 =?utf-8?B?blhidnpqUlpUclY1ckVJYXdXNE82dWhCTy9qNnZOcWVWdDZEQUs2MVprUVZK?=
 =?utf-8?B?MkxzbEl0dHdXSkNBcFQ4ejFkV3Q4ZVNacUZRTkZLMlFka1g4YVUvSjFWZEw2?=
 =?utf-8?B?cWZVWW9ldXdnaTFzTUM5Z2FXdXExdE04QU9XRGJMamF3OWxXYXd2M2toaWdZ?=
 =?utf-8?B?K2wvdVRSWU91QTN3R04xQmYyZ3kycU53bS9sVmJMeDNXNjl5SkpRSS92OFhZ?=
 =?utf-8?B?akROcjVZQ1l5MFE2bm5rM2RZbk9wblpQUlBURWdXOHZDeEJpUWZ0OGZoWXpm?=
 =?utf-8?B?cFgwSmdWd0VQZlE4Mml4NzltcGJ0a1ltSGVRL2ZubnR6enRjMnBpKzBCejRK?=
 =?utf-8?B?K253cTI3alpiMEpUNFVsWkE2cm41U0V4bEpGSVJadm5uS1IyQkNSTFREd3gv?=
 =?utf-8?B?WU5zMXQ2NkVjbnI2Tm5FUmhUcmYxd1dmaXRTcmFIMnA2cG1ubGhFZWdLT1V4?=
 =?utf-8?B?Ujd2WEdLQjBoS05lYnd0UTJJaUEySjR6UFRpQXJxMXMwVnJmbFh0VlBoZ25G?=
 =?utf-8?B?ckpkeStPQklWdnZpSEkwempOZzNBdU1LVVF1R0J2d0ZENG4waUVZc0VYa0Rj?=
 =?utf-8?B?ZEwyM1VDWThBQ1M1UjRIYWJZT2hDY001WmJRa0dVMVRHVVdpNUU0WCsrRC9Z?=
 =?utf-8?B?UURhRDhHZnFlZzFyTzdaL1VsZHF5eU5RRXJwa1M1ckFVSWRuMXpOaFhWeUcr?=
 =?utf-8?B?QzcyRDR5V3pnTnd3R05YWDZkZTFmTjlKTnJsbG9LNEpVNHBqcUt1dU5hd0Ja?=
 =?utf-8?B?WDkzK1IxS3RPckp2SzhLaHkxbmFBZlI2aFhydTExQS9XcnlWaGJ5bGNDZm51?=
 =?utf-8?B?NCtVaGJBN1MyMDJNRjk4a0NUZVIxZEJTSXlMSllrVG5odWVnKytkbXJPam9O?=
 =?utf-8?B?T3lEemhxVEpFdjRJcTNlNlBOMmd4MldaUVFpK2NCUzZ0U08vVzE0cUhLcHBh?=
 =?utf-8?B?UFFzb2MrSG9hWDgzMWZObEJTYkdPaEhGcXY2WndXR0ZubWJOMTVkWEc1RFhW?=
 =?utf-8?B?K245ZGRFMzdGZU5EODBsQWQ1U0ROOG0wMk5RWGpxY3FKSXEzcy91VnBKcUZC?=
 =?utf-8?B?NFQ1MWlZcjdUL3Y4ODlIczJPckVZTk1MeFRZL2MrU0tCSnB2RHFRSGluaEJ3?=
 =?utf-8?B?L2xVZ0dpVkI1VkVDdEE3ck9iTGJpZ0RJcUNKdjRzS2hMbVZJd2dTTlBwMmNV?=
 =?utf-8?B?Q0pZUEtmd2tMd2JneDJDNWQvc0V0c2ViNWIwK2czMmV3bmVxOG9IZUZrc0VW?=
 =?utf-8?B?RjRselFaenhHdUhhaXlyZ2VKd2Y4SVgwU3IzU1N4TTZYc0F6QytmaGFWMFZx?=
 =?utf-8?B?VUlCMHNCeTZtWTRWVjlYWGlVT0JzZXVqbEhtT2hEMDVrUktncVM2eEhweFFn?=
 =?utf-8?B?bmsyWW9HV3grWVRPOERUSVdyclhwZDBTdmhOeFZGQTJ1QytkQnI4ZXhab04v?=
 =?utf-8?B?VVJqQjVDbi9WcmRWY2xrTUdUL1AvL1M4WlAxMjVjV0VlS1lEMFpaSzBjZ3lP?=
 =?utf-8?B?T0hXdnVkTHp4dmJ5RlBVTTZoTWJQZFZqSmZzUm95NmZRNlU1clp4YUVxc3Rq?=
 =?utf-8?B?eCtuWFd2RGQ0czVJbThHMmJOWDliQjFpNmpicWUzbGwxczR1UnRXWlk3WWFV?=
 =?utf-8?B?UkhtS3Y0eVZqclRwa1VHNXZ5Y29TNDErd2xMME1SOW5sQ3htUkRmTUNTNkZa?=
 =?utf-8?Q?61ld4crHKYqSIAuzLq7uMorWn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR02MB8212.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9919681-ce47-4eab-500f-08daa5f9b875
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 11:15:18.6013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9YshT+GK/nx/iVqOKrT5k/b3HQIuGs3LYeli1vldAXbFR64KI8emXnT6L6V97q9w6XnrFVeuUYgteIB3NUSiD3yR2OxZ9BqlBCXk07wrfHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9207
X-Proofpoint-GUID: N008PR6uaoO2R0FyvQUXyTU14DZroPOm
X-Proofpoint-ORIG-GUID: N008PR6uaoO2R0FyvQUXyTU14DZroPOm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_04,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=652 lowpriorityscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
Y19qam9obnNvbkBxdWljaW5jLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxOCwgMjAy
MiA1OjUyIEFNDQo+IFRvOiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPjsgbGludXgtd2ly
ZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBhdGgxMmtAbGlzdHMuaW5mcmFkZWFkLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDIzLzUwXSB3aWZpOiBhdGgxMms6IGFkZCBoYWxfcnguaA0K
PiANCj4gV0FSTklORzogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBRdWFs
Y29tbS4gUGxlYXNlIGJlIHdhcnkNCj4gb2YgYW55IGxpbmtzIG9yIGF0dGFjaG1lbnRzLCBhbmQg
ZG8gbm90IGVuYWJsZSBtYWNyb3MuDQo+IA0KPiBPbiA4LzEyLzIwMjIgOTowOSBBTSwgS2FsbGUg
VmFsbyB3cm90ZToNCj4gPiBGcm9tOiBLYWxsZSBWYWxvIDxxdWljX2t2YWxvQHF1aWNpbmMuY29t
Pg0KPiA+DQo+ID4gKFBhdGNoZXMgc3BsaXQgaW50byBvbmUgcGF0Y2ggcGVyIGZpbGUgZm9yIGVh
c2llciByZXZpZXcsIGJ1dCB0aGUNCj4gPiBmaW5hbCBjb21taXQgd2lsbCBiZSBvbmUgYmlnIHBh
dGNoLiBTZWUgdGhlIGNvdmVyIGxldHRlciBmb3IgbW9yZQ0KPiA+IGluZm8uKQ0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogS2FsbGUgVmFsbyA8cXVpY19rdmFsb0BxdWljaW5jLmNvbT4NCj4gPiAt
LS0NCj4gPiAgIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2F0aC9hdGgxMmsvaGFsX3J4LmggfCA2OTQN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDY5NCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2ly
ZWxlc3MvYXRoL2F0aDEyay9oYWxfcnguaA0KPiA+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvYXRo
L2F0aDEyay9oYWxfcnguaA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAw
MDAwMDAwMDAwLi44ODNlYTFiZTI1MjUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvYXRoL2F0aDEyay9oYWxfcnguaA0KPiANCj4gc25pcA0KPiANCj4g
PiArc3RhdGljIGlubGluZSB1MzIgYXRoMTJrX2hlX3J1X3RvbmVzX3RvX25sODAyMTFfaGVfcnVf
YWxsb2ModTE2DQo+ID4gK3J1X3RvbmVzKQ0KPiANCj4gd2h5IGRvZXNuJ3QgdGhpcyBmdW5jdGlv
biByZXR1cm4gZW51bSBubDgwMjExX2hlX3J1X2FsbG9jDQoNClN1cmUgd2lsbCBhZGRyZXNzIHRo
aXMgY29tbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0KDQo+IA0KPiA+ICt7
DQo+ID4gKyAgICAgdTMyIHJldCA9IDA7DQo+IA0KPiBzaG91bGRuJ3QgdGhpcyBiZSBpbml0aWFs
aXplZCB0byBhIGVudW0gbmw4MDIxMV9oZV9ydV9hbGxvYyBlbnVtZXJhdG9yPw0KPiAoMCBpcyBO
TDgwMjExX1JBVEVfSU5GT19IRV9SVV9BTExPQ18yNikNCj4gDQo+IG9yIHBlcmhhcHMgcmVtb3Zl
IHRoZSBpbml0aWFsaXplciBhbmQgYWRkIGEgZGVmYXVsdDo/DQoNClN1cmUgd2lsbCBhZGRyZXNz
IHRoaXMgY29tbWVudCBpbiB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaA0KDQo+IA0KPiA+
ICsNCj4gPiArICAgICBzd2l0Y2ggKHJ1X3RvbmVzKSB7DQo+ID4gKyAgICAgY2FzZSBSVV8yNjoN
Cj4gDQo+IGFkZCBkZWZhdWx0OiBoZXJlPw0KDQpTdXJlIHdpbGwgYWRkcmVzcyB0aGlzIGNvbW1l
bnQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gNCg0KPiANCj4gPiArICAgICAgICAg
ICAgIHJldCA9IE5MODAyMTFfUkFURV9JTkZPX0hFX1JVX0FMTE9DXzI2Ow0KPiA+ICsgICAgICAg
ICAgICAgYnJlYWs7DQo+ID4gKyAgICAgY2FzZSBSVV81MjoNCj4gPiArICAgICAgICAgICAgIHJl
dCA9IE5MODAyMTFfUkFURV9JTkZPX0hFX1JVX0FMTE9DXzUyOw0KPiA+ICsgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gKyAgICAgY2FzZSBSVV8xMDY6DQo+ID4gKyAgICAgICAgICAgICByZXQgPSBO
TDgwMjExX1JBVEVfSU5GT19IRV9SVV9BTExPQ18xMDY7DQo+ID4gKyAgICAgICAgICAgICBicmVh
azsNCj4gPiArICAgICBjYXNlIFJVXzI0MjoNCj4gPiArICAgICAgICAgICAgIHJldCA9IE5MODAy
MTFfUkFURV9JTkZPX0hFX1JVX0FMTE9DXzI0MjsNCj4gPiArICAgICAgICAgICAgIGJyZWFrOw0K
PiA+ICsgICAgIGNhc2UgUlVfNDg0Og0KPiA+ICsgICAgICAgICAgICAgcmV0ID0gTkw4MDIxMV9S
QVRFX0lORk9fSEVfUlVfQUxMT0NfNDg0Ow0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+ID4g
KyAgICAgY2FzZSBSVV85OTY6DQo+ID4gKyAgICAgICAgICAgICByZXQgPSBOTDgwMjExX1JBVEVf
SU5GT19IRV9SVV9BTExPQ185OTY7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiArICAg
ICB9DQo+ID4gKyAgICAgcmV0dXJuIHJldDsNCj4gDQo+IHNuaXANCg0KVGhhbmtzDQpLYXJ0aGlr
ZXlhbg0K
