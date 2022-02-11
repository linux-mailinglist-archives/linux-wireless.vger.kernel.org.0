Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C64B28EE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbiBKPQL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 10:16:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiBKPQK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 10:16:10 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC221AE
        for <linux-wireless@vger.kernel.org>; Fri, 11 Feb 2022 07:16:05 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BF06Sf009588;
        Fri, 11 Feb 2022 15:15:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=mpM3TsKooktRi9enuAa1hbTu56dB+cZHGgn+fQ3IT7A=;
 b=S8YlVv6TPLVniHDNhQ8TdZe9zUNttp89IWYob11WNahvJQwOd5BsLdYDPR+UXtb89BLj
 rufEXdCVGlBmx7HGqHTzR2RysCcwCpfW/1NXO1HTVt2x9bHam/0wxrtrQjilmfIfOVAI
 uvBZ8T5K1xFUW8AU9Vg3yyJFSyjGsxZvSE/Va8fP45fZDH/a3M+lj0CfppqHJmdZ1qSf
 snuReNv0V2T68BlCsxBFUEdDcLXcKT+0obrHSnvBvHYoC6QPFO7pm798c+VaFxn9Q1aH
 AuttVAD1t2r+UnGQYVpPA3wAdzX4XVrGzpdp16y6E564Ccxl0G6HD+54tXvNoH76kKEv hA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e4f9e1wh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 15:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEDxIIlVuoRTO/TLZ3tmX7phxTSUSWtdIKQa7JQXkNxy6RPpz8xuBjttHvEtw9PXx/CgKoXQG24mprxT3NbE/SfQ7LtJWEij/plykg3HFsigG7uc2calxSMu7TZxQ2XnquFxLQ3XTTzwH7sB198uXlww9/cl3ocK/AFHiodwDgkKNRFVAF9OIyzsDa6uFLuHVpT5JncehmJHcljnF08YvWnUWjOGzg57veUtjjPtYX0jmJVQ2Q5ZAOBKPrceR9jnFd1eN2J4AtteCWU3hVDofH2mFGz3HpZweMqexPx6ocPug5sbKlZC04Aft9zpHoVtxcmnrTot4qgzvChljjYifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpM3TsKooktRi9enuAa1hbTu56dB+cZHGgn+fQ3IT7A=;
 b=bd6pdWXtDVoEu6HVtvNljw/C/5a+IIbh5lRJjZTln2bq5CiYc0/zVm8+/n+ZkHsiLp6nkzfQ5PbZJF8M700NWQS+n9YyCIoOmh+p5ETLhTeGfIrd65KyY4zhSVM8roaZSgAL23mRPN6QMFNNUOd93Pa9Xj8DcTLZPcWdoQZaGXROpEQ0Tk9GSogcfxaqifWLxWuHkpzjHzMK7THtMMUjpZb9zbJl28ja/wWgcBsZD/R6VMcbWru3F/hKinh01JQvGSocb0Gp5V1uNSdKmZG5OsvYj3E13c0fw+uQzUnfgJWX/9oq4XAehFdN57WxhToGwsCyIA4HZEc8roQzvAVRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8)
 by BL1PR11MB5320.namprd11.prod.outlook.com (2603:10b6:208:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 15:15:49 +0000
Received: from PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::7062:2a50:3478:8dc6]) by PH0PR11MB5175.namprd11.prod.outlook.com
 ([fe80::7062:2a50:3478:8dc6%5]) with mapi id 15.20.4951.019; Fri, 11 Feb 2022
 15:15:49 +0000
From:   "Liu, Yongxin" <Yongxin.Liu@windriver.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "luca@coelho.fi" <luca@coelho.fi>,
        "luciano.coelho@intel.com" <luciano.coelho@intel.com>
CC:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 07/10] iwlwifi: fix leaks/bad data after failed firmware
 load
Thread-Topic: [PATCH 07/10] iwlwifi: fix leaks/bad data after failed firmware
 load
Thread-Index: AQHYH1felPiaddbFeUWPK+VzqEJnwqyOdbkQ
Date:   Fri, 11 Feb 2022 15:15:48 +0000
Message-ID: <PH0PR11MB5175B79FF738A1D29C1513C1E5309@PH0PR11MB5175.namprd11.prod.outlook.com>
References: <PH0PR11MB51755AE791AC9BBE5B97DCF9E5309@PH0PR11MB5175.namprd11.prod.outlook.com>
 <ebc85132546c8d7e5f62f260ccb50c73ce07c6ab.camel@sipsolutions.net>
In-Reply-To: <ebc85132546c8d7e5f62f260ccb50c73ce07c6ab.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8672dd73-3ec2-4197-72e1-08d9ed716294
x-ms-traffictypediagnostic: BL1PR11MB5320:EE_
x-microsoft-antispam-prvs: <BL1PR11MB5320B90B13BBE55AADA1ED20E5309@BL1PR11MB5320.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBQnHzN4O9SJOlsTbBwZnOxWQBuOgDsJ9S8Cqc6IkmeJjIiGNmYP4bx9Q8/Mr2OEEPZoh+6INtjsuu7Uu6ro2eXglyAVt4TjOY0xo3juOd19YejqCs7N+nlMUgBaEajxUBQRhRVHhnadxG5skrylkzWVdd6evdOL6mSXhaaKY/tCoNVw0kuKvLc2AY+DwNHenxCQGwFHmF+eWGw5I5IDRDRjJj6g+MIp9PVISZ7gbDCQZF7nz1XD7Ap+7W4rwFp72bZ/WJKgU6G42znvuZ7Y+74gUBONGSrbfEKJ+Lf5oE2lg+X9xtLD2Nij8uOt0KSzS68W8PTV0THqfep9mxJ3YW8efcIjT4RJcgUWWtTb1HgO411AlghA6NoO7VtzqoRnfpqbI/04baZm2UjWl1sBlB3LQaYsTs0H+qKEGUJ+MVMtM9PhATQx3duaIhZiED6a+ihX7kOMuafBOO8vs4yQTQZQq9mBFhR4o59lt685MBJ7VQs9KIXx742uE1j3raA3+GM6CxBYidcn8KSaTVZuermV+CexjjwKn6aSTE8XyhBSj5kn+2WOx4R03+HmJOQGst9x9XugmvsThAS8AJ1gUuT/qjl5/0oI0ybiQNCk6IroNSsqlEmseNGP1w31trQEioAfWaslymjKdrA1NjUnvIelt7tG2NboOcaQ9gV/0MzTTAPytdQWEegz1buExpfJSuq+n7Qy8+QGEDjDsSpMZNe4bS5Mn0TVCnokzYg1Yb5lGfDr2C5Vsdx1xID8H64bqxNMiSaQh4bQFgNs30blkXtnAtv+QTRV+ZPo2IL9mks=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(38100700002)(71200400001)(122000001)(52536014)(33656002)(186003)(26005)(8936002)(508600001)(53546011)(86362001)(55016003)(7696005)(6506007)(4744005)(38070700005)(2906002)(9686003)(66946007)(66476007)(66556008)(8676002)(83380400001)(316002)(110136005)(54906003)(966005)(4326008)(64756008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFdabmhiVVlYbGFjSU9UWHN0cFF5ZnZZMVpCUTA0QzM1Y2pBZFV3alpLTVJk?=
 =?utf-8?B?SjYrOEVoVG9pZzFWQ05OZVR4dFhRWnJKMkY1bDhFZnNpOStya013Ty9CM042?=
 =?utf-8?B?OUNnTXNjWHVRbTY2NWhNYnFwMFpSV3RFMnhkR1VuWVZJWG52aW5VdnNIcFpa?=
 =?utf-8?B?RjJxZmpESUJBRWpOTmVuZ3NScngwQUZwclZXTEdveFpLcWxUeWdmSnBZKytD?=
 =?utf-8?B?OEhWYTkyVHhXMzUxUmgzSnlBajA1SFpJRHJmQnJXcXpxc3VzWHBhQ1Zzenpn?=
 =?utf-8?B?dTUyZ092L3FjK2NFc3VxT1FKZWYxN2lGQWZBcUtsVFBpZGJFeXRrRGwzQXZO?=
 =?utf-8?B?Um9JNmNhY25CdDdBMEtQRXlRYXZuUTJmSnF2L0xmdnhwWlV5RnMxWU1ZUHdQ?=
 =?utf-8?B?NEU0TnJYOG1OZnBLY1NKak91ZDJONmptQjFJMlR1WlRCbmJiVmQ4ZHQ0bnFR?=
 =?utf-8?B?Z0tkd3VsMEREeDdsYTFSK0paMy94ZmowOTk3WUU1aXJJRkVwK2hoWnhCb2V0?=
 =?utf-8?B?VE5TeGE2T2wvLzdjcktrajdBcURLZFNNZGxrTzNhYUdFelE1Ni83S3g2d1cz?=
 =?utf-8?B?RHVNWEQyR2Z2VldpWVJ3ZWhQNnAzWlJTYVNJeTJtWWFuckQ0Um44THR6K05z?=
 =?utf-8?B?eFRjMGhMeHRCWWMzL3kzTllLbmRuWk1NNVl6YTBUN0E5a1d3Ukk3WnZkM3JG?=
 =?utf-8?B?VXV2RnNpMGc1eUNGU1ZDbmZwUW94bkxFU3lnWGM1M2pQeEROQkozbjdMSnhZ?=
 =?utf-8?B?ZENZTTk4WHMxZFZpL2t1NkxURTErMHNvWk9XQVkwTWQzWVQ4T1gzbEl4OUJ2?=
 =?utf-8?B?Y1NjQkdFNTdpRTlRc2NVWDNCZGlmMFBoMUJwdmN1djJWcDJYajIzQUZWdzNL?=
 =?utf-8?B?UnBGTjl5NTFZOFFUSkdWYUl2RWFIV1JmY0UrSm85ZDJFZ3lLYTlJdGpYc2I1?=
 =?utf-8?B?Z0s3UU1uWDdpUFZ2N3BwK2Y2U3RaTHROZkJua3pHYVE4TTR1MzF6TTlTZXhF?=
 =?utf-8?B?d3pyeUsrQ0ZZbklTQW5SNG8rUzFaYU02Ti9jdEljSzJnZ1VKc1JOK2lLTldS?=
 =?utf-8?B?K0hVaWk4ODY3UThoZC9FRkthQXR6U3JsUm1ocmZMc21FaXZYbHlyRDVJNFk4?=
 =?utf-8?B?MTAxWGJrMEJyN3J5Q2VhbHdheGYrcHQ1OWJuenRrRXFPOVdiTnF6SDJLT1k4?=
 =?utf-8?B?NGhxeGMrUG05MTBIWWt5WUZ3MG5jT3RCQUxnTjh3YWo5ODVySU0xVkpkREJH?=
 =?utf-8?B?VXdsZlN1cktBQjQ1UHBFVnJMdFJKQWFWaktZdlVGSDFpS2g1V05CdHp2eEdt?=
 =?utf-8?B?MHBJNUJ0UXZEbE5yM1NySThyK1dpRnlwWDFoT0IxTDZqTGo1VXFRV2RCQ0FM?=
 =?utf-8?B?KzIwS3p3UXA3MDgreWx2aU1BUUFPSFIxbjEvN3NDR25QYU5zOEgySjRGMk9z?=
 =?utf-8?B?bnRCNVlySkd5TlF2d0NvckxrdVhBRXhjc2VUTXlWQ2tzeHZ6OVJpenBxa1lC?=
 =?utf-8?B?U0wzM0V5OTl0THN4RjFKbTlHZGJvbk9GdkttQVFBUVVRbitXaGptSEdlanZm?=
 =?utf-8?B?czdDTnYzeFhDbTI3c0xUT1FmUDA1TGVGUDU4VUVNWm4xNENiMW81RXlUMGM2?=
 =?utf-8?B?OHArRVlTenoreGZFT3grVUZmYU9aZTkvam5jejRGTy83VWU0THR1SCt5VFQy?=
 =?utf-8?B?ejJnY1Mrb3hmYzVxRUtIVi84RkN6T1hVTU5YcG1LWjAzdHNBckRneUlUV2lK?=
 =?utf-8?B?VkJuZTBlS1hnSEVqdlViQVp6b29OQ3JnYmJPRUJnS2xzUVJVblptUFV4dGdK?=
 =?utf-8?B?WDM2YzFqRWhLODhJS0NLbFJYL0lIc3JTMUNWYThWbXYyVDJ3cnVCRWZDcG8v?=
 =?utf-8?B?V0kvTExJb0pJMmhIbmx6b0FlWXREUEtMeXArYnNVZGNLUDVwaXdqTnRtYTdu?=
 =?utf-8?B?U09kRGd4YVRYN1pYak5ocVgxazBvbU5jMGFHLy9oM1BuMlliUzFEQUdSWmlr?=
 =?utf-8?B?cjcyc2RvQjBRMC96TTJXK3pnQXNuSG5XM0hPWE1CM21lM2JlOGdMWnp3U2do?=
 =?utf-8?B?d2xJYzNMNzlVTkZlYnRpWCsvdG5IMy9wMmxxS3JhT2Z5Q3JlQXBrWDRpQk5u?=
 =?utf-8?B?M09uK28yKzc5SGdHV3MwSFlibHRPbkVBV1dUeitRTUJBcTh1SlY1ejUvK2tR?=
 =?utf-8?B?cDE2ZFZMaGJFV2VXcXJDSWxONHFkVHMvK1EvYVdxbVd4QVVCaWFtVXgxNmRM?=
 =?utf-8?B?WkswQS93dTZ5dzBnZVhPM0k2eTNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8672dd73-3ec2-4197-72e1-08d9ed716294
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2022 15:15:48.9213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QxyPHoE9xAMhqb23YOEi+OKYoXyhg+7DdR/7xvzZ2InncyYZD5OvBYswCqS0sofs7JoeVY6rXc2d6Uc2xyZDbUdnxsgz//vJ6l7ySADSiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5320
X-Proofpoint-ORIG-GUID: 1Gh9mMjUZZKw7mHbhHyRR1HO8hw8QjeZ
X-Proofpoint-GUID: 1Gh9mMjUZZKw7mHbhHyRR1HO8hw8QjeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxlogscore=798 malwarescore=0 phishscore=0 clxscore=1011 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110084
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDog
RnJpZGF5LCBGZWJydWFyeSAxMSwgMjAyMiAyMjo1OQ0KPiBUbzogTGl1LCBZb25neGluIDxZb25n
eGluLkxpdUB3aW5kcml2ZXIuY29tPjsgbHVjYUBjb2VsaG8uZmk7DQo+IGx1Y2lhbm8uY29lbGhv
QGludGVsLmNvbQ0KPiBDYzoga3ZhbG9Aa2VybmVsLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMDcvMTBdIGl3bHdpZmk6IGZpeCBsZWFr
cy9iYWQgZGF0YSBhZnRlciBmYWlsZWQgZmlybXdhcmUNCj4gbG9hZA0KPiANCj4gW1BsZWFzZSBu
b3RlOiBUaGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRyZXNzXQ0KPiAN
Cj4gT24gRnJpLCAyMDIyLTAyLTExIGF0IDE0OjUyICswMDAwLCBMaXUsIFlvbmd4aW4gd3JvdGU6
DQo+ID4gSGksDQo+ID4NCj4gPiBJZiB0aGVyZSBpcyBubyBzdWl0YWJsZSBmaXJtd2FyZSBmb3Vu
ZCAobm8gZmlybXdhcmUgbG9hZGVkKSwgdGhpcyBwYXRjaA0KPiB3aWxsIGNhdXNlIHRoZSBmb2xs
b3dpbmcgZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0Lg0KPiA+IFBsZWFzZSBoZWxwIHRvIGNoZWNr
Lg0KPiA+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L25ldGRldi9uZXQuZ2l0L2NvbW1pdC8/aWQ9YmVhDQo+IDI2NjJlNzgxOGUxNWQ3NjA3ZDE3ZDU3
OTEyYWM5ODQyNzVkOTQNCj4gDQo+IGpvaGFubmVzDQoNCg==
