Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37755FCEFE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJLXkI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJLXkG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 19:40:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DF020357
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 16:40:05 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CN6kNX020168;
        Wed, 12 Oct 2022 23:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=9JkDan5jXGLzli+PkcT9tUVqwEwPcTs7efmQ1UXDZyI=;
 b=TrnyTwQ790mWF6hTJZVfdwhf3L/B3Cbd0ZOXDkhIeGHmfKLzHBjEIceYvRO0htm73jDE
 AS1g6SQNEbRT8ra4Iov19ErvtZxhkzwVD1Y+rqf+BjYeIXFW1xDE7lo0m9ZGyiF5wTvw
 rxGSHZ6ombTC84GQfhqCb2OBvfX+c6C4O9c7p4Bd3Hu8EmMNuQGJrALorHZ8dZ8Qk8Xt
 eJeZH1JGOZ+dqHQj+FiaqHCyF9hUsjAIySAW4f8XltOJyW334ab1rjsPNI2xE81Ml1sC
 aTlG94d6eu71TvFjiVIjz50OBazMoMMjN9fOl7UxctL5NjyM4crPmw9gsIZysEJiS8WE 4A== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k66xjr228-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 23:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GocnTcfmN8S8N7bG5AuHIVKcAjd1L31lKfmnrrQjXwi7vlvp5TCHR9lJK2sHmthDLFE8A9/TmLgU5IU2CXS3Xc1RtQPALz15pUmpTBVupnIrWxhdFi84msGK1ASXDJ9pkFsTas9eSZrFGE3LFJ5WbDxALnlz0cWew3dK96u0aOo1HrN7v8mfgWetQ47IU+5/lg3jzE4GZRCWh/EYB7ORyZd63MaBRLRoBilKu2iuo8Jjhz6BamlNvS53zAzMHPH9UBMpuVvifHXGO6wQ3o+FAPPtb/QBqYLRnxXMuQ5dWziWcdrfC2n02kT0af0+dJ2kEDOFsixrQuDSHCCnO9qWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JkDan5jXGLzli+PkcT9tUVqwEwPcTs7efmQ1UXDZyI=;
 b=b7kZrWqRuLH49rmUrnKDJ2XzTsGZ5SA+TeNSrf7oQ1nYHi22i4qmjr05pnvCe/RcgL4EjK3A9CdC10hXDv6E20hYGsoruB3t52HZKm2I4Bjy0wxd8usQqu15TDo1Yy24Z8sglxLhgC96LED9qn+tyXRQyQ6JBAFZds/9GOpwXpnJGwnA5YSN+Emw8ITFP41PLlrelcy9jSmEUwOmXzwUqb2yA2XdgVDladVRJRyyHNw35PLnilsJkJ8AIe78jMDe3bcAaGp7zR4TC9mXNjWFMv6SMlSadvBdtzZbtZVqbICwmJVk25/rpvurpMOYOuAVtEhAr7q/QNAI6mnr75gWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by CH3PR02MB9115.namprd02.prod.outlook.com (2603:10b6:610:147::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Wed, 12 Oct
 2022 23:39:58 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 23:39:58 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2zws4AgFgFrRA=
Date:   Wed, 12 Oct 2022 23:39:58 +0000
Message-ID: <SN6PR02MB433498DC221CF70BE3B6CE63F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
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
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|CH3PR02MB9115:EE_
x-ms-office365-filtering-correlation-id: 50bb1cb9-30e3-4ff1-74cf-08daacab1320
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b51FFKOHAVx6ZQhZtDVXcmO94prQwZV95dqwHchbSWyRLO3frE5cg5BWHbu4vrBmyp2nRLcg0BjK+KU0b6JF3oIm3wrprnJ7coDSnEe/OSWsVbaEPxn4n4BjjmzAva+oImlvT6IjAFySFDWQ8x975AB/BOYtavUxEEll/MGgzaWn4gg+7NqP55gzr0WDRXBUNCKycDPYy9jsv179SRlHj6D4kmy/YhvnoJ5UqKs4HNCBOkvbUG2r9EjBYWBs/7uRoN9IKW8QXOJOORiAoESssqDZBeJjdJ1WM66znzqT7GSC9EO/XmKkIZZzPRm7HETDYpzjZMgMpKNdzM+vLkiP03E/Oz8mWIT4nBIHtVLUwnP8e8y/8uJzLSLq331oBKHn5+q6H9JL8xqAef1K/oFZW6SRkbnoIevXmCZwzCcXhgGFpcYvnhnPTWvyvnVKX26ruYNA/4Al6QIhp/28ZQfOxLr8m8b38eViqwSrVT5M/Qz9Vrpxf9BzE4P1kfmpSLUV6X/AuhV0PdoE5Q+NUBvKyIyEl8ujzsOZBeJwMEmF6u4N3ihc5uhGQMIMJ3U5An3Zb/qkXL4Uzrrs0y7cXA9hA9gZVhywmZ1bvlOlfZNkCaqgFWjZvvZGToKLd4QZ/tW/wdE4hBbKwyxcXuEh8TfdQMeryoslcFwqt7zHCsqna7EJaZT44KNpNjTdgQPBUuDii0GOZBdzfn4aN42ZX2vG5H0YJVPrssScVKAC3pWjqG2crkGrzHCEsOFRerJr36ZIGSlmQ1Lb0PQ2Iy8UcH1uOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(122000001)(86362001)(33656002)(55016003)(38070700005)(38100700002)(316002)(8676002)(4326008)(64756008)(66446008)(66556008)(66476007)(66946007)(76116006)(71200400001)(110136005)(2906002)(52536014)(8936002)(41300700001)(5660300002)(186003)(83380400001)(478600001)(9686003)(6506007)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWsyZmozWE4xenI3NjE0MlJOaEpDcFZ1OHR2OEZHbGswMVJIRzZhZUxKMFB2?=
 =?utf-8?B?UUFUdGlxOTRoK1BoZytVdWJyUEg2WjlJcmhBM0xOTFNSVkFGdVZDQ0VwNExJ?=
 =?utf-8?B?TG1IZVBhY0dic2V6bzNKWmg1ZDVzemx3SXhGOGlES1BnaUdYV0hSUmM3T1dX?=
 =?utf-8?B?bGFYZ0FmZ0dkdUxsWnpRMTUzSFlXRmZYaHRwQkJCSTNselRkdTBUYjRPekpo?=
 =?utf-8?B?ZDN6aVVURVdSOEx3NjJBKzlBVk9vZFl0M1dzRk9YK1JoaDcxOVd1WjZhQkhJ?=
 =?utf-8?B?UlVudnpDVDV1blJCdEVqanhkWndSV0F3TEREQmZxZjJwaU5VcnFDNXV3Sndh?=
 =?utf-8?B?OFVDMTIwU1hzaHRKRnp0Z2RWRmtkWGxJazVaVUR1RlpEcnkvS1BjMFVCdEZG?=
 =?utf-8?B?RXdiaUt4dzZTSk8zYnpSNVNTemlRdXJaSzdaV3B1ZFJXNmwvVVE5WW1oUlFJ?=
 =?utf-8?B?REsxK0lWcHcxL3JTK2JhQWNJVU5ET2tzazFGMGs5am9naDgvS1RwYnhjN2lw?=
 =?utf-8?B?NVl3YUZLc2JqMktKSVY2a0dmNHY3KzZWb0d0WUhtdXhyUjFqVzN5L2RTdUx3?=
 =?utf-8?B?NnRZWWthSDRQWVVYNjNOemxGZzk4dGFkY3JMZityeWtNZG0vaFVnOFNna1Fl?=
 =?utf-8?B?cHdwdjlVVzk1WmNtNFdsY3REd2pPWkp2QWtNODRmS1hnQXozVEsyTDgweWFD?=
 =?utf-8?B?SWlidnVmM2pVaDBCUUZDOVRaaDFRK0tQSXpwM0kwdWFadTJPd2ZqUVJ2c2hW?=
 =?utf-8?B?Y1FQQnpxNTF3NTdRb1BLWUxQanBHNXdrWWxsTUZPNlIwQnZrSkRleEFDVGNC?=
 =?utf-8?B?a1RFWVB1U2NuaGg0QVlIQ1MxMUdpdURBb2hIOEFOb3FaclJ2RjBORXorSGxB?=
 =?utf-8?B?aFRzSHk4ejF2VTBlVmVjcDd6V2RNajY0NVpoZHN3a2lGSEdEakQxUnAyd2Rx?=
 =?utf-8?B?Uy9hbzdER2NOTVJteXN3SjhJZTc4T1MyWWEwUFBDc3MrcnZtSDJCNHUrcTV2?=
 =?utf-8?B?dHFFQWhiL1A2Z3l3RUVTNFRxbjdoYndkakdwY1o5bmhQWjVoTUF0UTZnbEVn?=
 =?utf-8?B?QUVtQzhWelVtdkJVbXl5QkNBWS9yQzVEY1JwM0tOLytTUk9QS0R3Q0tXRTJi?=
 =?utf-8?B?bW5hME1SOG5ycW53eCtNNmYzdFBqdEQrTjhMYi85VnZjbk5pUFMwMDg5WHJN?=
 =?utf-8?B?dUhkMG5Xak1ETmdyL3ZTN0U1bUNCQWhPMi84MVdxSDRDTlJ2YXpwOVdpNTNx?=
 =?utf-8?B?Mkh0dmprMG1TOTFqMU9VQkcwbjRLZ08zTjl0UFB4bGpVRmIzUWhpUHhFWGVN?=
 =?utf-8?B?WUEzYUZGZVJXVDhtRW56RVBsa3Nvd1BHUUJCQlNra2FrZDlJUjl5TnQ1WUp1?=
 =?utf-8?B?cEROV3NIWU56MDJodlQ2L1Vlb3p5ak1oV2R0RUdZOU8yYjZJbUFEd2dPYnFv?=
 =?utf-8?B?SFBVSXgySjBCSUlqTzVGaTVWNHdNV2VsREdQajdCdW1SRVNmQWNwOWVYUEF5?=
 =?utf-8?B?TjFnbnI2MHhSUkNhVHlXeGxjSVczYk9zdTVwWHh2cUdFV0JMeEgwUCtjT2Jp?=
 =?utf-8?B?SmtqcndwVk5TaENYellweVlpWFhsMlJhZUlUcGs4RGxZdFliVDhYeld6TFpP?=
 =?utf-8?B?dzcvVHk0RGV3b0dWSEo4eEl3UW9JN2UwRHdmemRFOUUvOGZPanBJbmFOZCtT?=
 =?utf-8?B?VUdXUkhXNzJkY3FSTnA1UmxvSHFVY0NReElHT2FSbWU0NDVxZGppeWlwSXZW?=
 =?utf-8?B?bE1XMTZpc2pQMFI1a2xwdElteE51NktvRVU5N1NjdXZMc2JlWDQrYkR3R1Ru?=
 =?utf-8?B?TnZoTGJ4UjQxQTErNlFFYVhNVmlKRnNiTzdaMDl1emFMeGQwdDhJNnpybzdo?=
 =?utf-8?B?bXdIclE3aUFiVkFsSEEwR3RyVkRIV25HTmpHNjVEWjZWKzFXaE41bVRMVmt4?=
 =?utf-8?B?NVNvR2x5c1duRFhtNldReVhiM1ZNWktpcUh0R3RlT2x3MlF1RmErUlBXTUJE?=
 =?utf-8?B?eE50QXlHUEpjTzlUSDB3aTJoRFROdWRienNDUFZTSUFZVThWU29UZEdBTzlI?=
 =?utf-8?B?d2Fsc1RjYk8wU0dWdkpjS0NrVDFZR0xyYUlOMDlraStWbWcvMXZuQVlTUStE?=
 =?utf-8?Q?vcux0wvjRvFwo5q/Q2Bf3Ol8H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bb1cb9-30e3-4ff1-74cf-08daacab1320
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 23:39:58.6469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EuNiBdvIrlK2kRYY3XOOc3Q7G2eQ/KFak69topjXxadWMRWrorF/tDq6UpuSePg6caKQo4J2uDVhrZ4JkYQti9JJ/i/xsmerzGsGXDo9OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9115
X-Proofpoint-GUID: gPlUebb1GdLD6XNM6GhquXVo1E4hxpPf
X-Proofpoint-ORIG-GUID: gPlUebb1GdLD6XNM6GhquXVo1E4hxpPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_11,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=546 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120147
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4gKyAgICAgZWxlbSA9IGt6YWxsb2Moc2l6ZW9mKCplbGVtKSwgR0ZQX0FUT01JQyk7DQo+PiAr
ICAgICBpZiAoIWVsZW0pDQo+PiArICAgICAgICAgICAgIGdvdG8gZnJlZV9kZXNjOw0KPj4gKw0K
Pj4gKyAgICAgZWxlbS0+dHMgPSBqaWZmaWVzOw0KPj4gKyAgICAgbWVtY3B5KCZlbGVtLT5kYXRh
LCByeF90aWQsIHNpemVvZigqcnhfdGlkKSk7DQo+PiArDQo+PiArICAgICBzcGluX2xvY2tfYmgo
JmRwLT5yZW9fY21kX2xvY2spOw0KPj4gKyAgICAgbGlzdF9hZGRfdGFpbCgmZWxlbS0+bGlzdCwg
JmRwLT5yZW9fY21kX2NhY2hlX2ZsdXNoX2xpc3QpOw0KPj4gKyAgICAgZHAtPnJlb19jbWRfY2Fj
aGVfZmx1c2hfY291bnQrKzsNCj4+ICsNCj4+ICsgICAgIC8qIEZsdXNoIGFuZCBpbnZhbGlkYXRl
IGFnZWQgUkVPIGRlc2MgZnJvbSBIVyBjYWNoZSAqLw0KPj4gKyAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKGVsZW0sIHRtcCwgJmRwLT5yZW9fY21kX2NhY2hlX2ZsdXNoX2xpc3QsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdCkgew0KPj4gKyAgICAgICAgICAgICBp
ZiAoZHAtPnJlb19jbWRfY2FjaGVfZmx1c2hfY291bnQgPg0KPkFUSDEyS19EUF9SWF9SRU9fREVT
Q19GUkVFX1RIUkVTIHx8DQo+PiArICAgICAgICAgICAgICAgICB0aW1lX2FmdGVyKGppZmZpZXMs
IGVsZW0tPnRzICsNCj4+ICsNCj5tc2Vjc190b19qaWZmaWVzKEFUSDEyS19EUF9SWF9SRU9fREVT
Q19GUkVFX1RJTUVPVVRfTVMpKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGxpc3RfZGVs
KCZlbGVtLT5saXN0KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBkcC0+cmVvX2NtZF9jYWNo
ZV9mbHVzaF9jb3VudC0tOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2Jo
KCZkcC0+cmVvX2NtZF9sb2NrKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBhdGgx
MmtfZHBfcmVvX2NhY2hlX2ZsdXNoKGFiLCAmZWxlbS0+ZGF0YSk7DQo+PiArICAgICAgICAgICAg
ICAgICAgICAga2ZyZWUoZWxlbSk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgc3Bpbl9sb2Nr
X2JoKCZkcC0+cmVvX2NtZF9sb2NrKTsNCj4NCj5pcyB0aGlzIHJlYWxseSBhIHNhZmUgaXRlcmF0
aW9uIGlmIHlvdSB1bmxvY2sgJiBsb2NrIGluIHRoZSBtaWRkbGU/DQo+d2hhdCBwcmV2ZW50cyB0
aGUgdG1wIG5vZGUgZnJvbSBiZWluZyBkZWxldGVkIGR1cmluZyB0aGlzIHdpbmRvdz8NClRoZSBy
ZW9fY21kX2NhY2hlX2ZsdXNoX2xpc3QgaXMgdXNlZCBpbiBvbmx5IHR3byBjb250ZXh0cywgb25l
IGlzIHRoaXMNCkZ1bmN0aW9uIGNhbGxlZCBmcm9tIG5hcGkgYW5kIHRoZSBvdGhlciBpbiBhdGgx
MmtfZHBfZnJlZSBkdXJpbmcNCmNvcmUgZGVzdHJveS4gQmVmb3JlIGRwX2ZyZWUsIHRoZSBpcnFz
IHdvdWxkIGJlIGRpc2FibGVkIGFuZCB3b3VsZCB3YWl0DQpzeW5jaHJvbml6ZS4gSGVuY2UgdGhl
cmUgd291bGRu4oCZdCBiZSBhbnkgcmFjZSBhZ2FpbnN0IGFkZCBvciBkZWxldGUNCnRvIHRoaXMg
bGlzdC4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHRoYXTigJlzIGZpbmUuDQoNClRoYW5rcywNClNy
aXJhbS5SDQo=
