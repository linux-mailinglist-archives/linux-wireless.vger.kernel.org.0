Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4172A5FE716
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 04:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiJNCny (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJNCnv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 22:43:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B1D18D805
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 19:43:50 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29E2e4w8006934;
        Fri, 14 Oct 2022 02:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=rSL3eH0Zm/9P8zd/lcQg01g/n9U0bIPWwbBIctfi97g=;
 b=mb8tOEZ62N3fc4YslLIVLzQLvKjzPnuo2V1GIUjf/9VbvVtvnEGsf5OM5zpvYUrKktoh
 WSaCv/74jZ0o5HRD80y0SuKzWjX2lCtOcrv7NWoYEdfkU/DKuxWYRcfQMsRlG6vhSZ8E
 7hFY0lP2vvDBpszxqJAfO/VgwPI8AaYTJ0piTlYmCrwTHIwXqUBqhdbAt52dEA1o1I0Y
 A6oLCLgtm1Huh3kFmOBIsMayaOnkeOiew5dC6jt5Lt5Yb7+jQ2imX2/FvoUNYvT0B2K2
 Rd/pFJ3zCzq5hlFWsgAXmjp2S7mculCDm49LjByg+omWyboW9V/VVDKSekz3KtltVoAK vg== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6fpst8r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 02:43:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDaP5Lb7iCRt4JxVB4Uq6PT2AiUTOuNLzWn8RjQOvvd6FyF6mgxM1y/Y8ISTZ8+uBY+/rVzsIokXP1k1qiVKbQlRvKa2is9Pm8rRTk8XtEoaoEXmjZRWjaB7+zGR3n134cW966bOFaTgLm/1MrHs33vPq9ZXpHyTxtl7DEqgBhWZ+nTyWU2SNhaxQsij8Y6krqZfTZWMv+pvWcRY0zVG8/RNS27M68RHazD+x1DOxFf6jXOMUBsPcNRAn+2mJRvgA619uGFEauoJVeSEZRakk+eueRbJJZEtCCTI+nDbUfLwbiSAmaT+s8cm6WgswdYLu627MqD+SC1pZvymw9gJeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSL3eH0Zm/9P8zd/lcQg01g/n9U0bIPWwbBIctfi97g=;
 b=ZAP1bFHbUYNmdkD86FXphXrDPJvf13bENP/nh3s45p6UzmTZS8DCL7/17apUrJtauF+czF0VWONFCwIkO1z2erSQK6zLfMY9h3/QwcCgQDF8mNGgr5dvD170l/Rw8Et0+k4VFcTmswq5/EOmdTsuHXqS2W359S/uKnTdBfvuU3wHh1YXncyEgZgf/tOnbgO8dF96J7Ri5u7uO9vg1w+EdY6S8T68dsZjvLAG58K7G1REDhwQGw9VIMgXvGxctxJ0TlMEcJ3vevxjc+ToqZK0F5KvLkEdZAZ6AnS8ovfiQUhtzjITbgQnKAX9wSepIl339vCbc0+v+7nyJAfAeNM3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by PH0PR02MB7558.namprd02.prod.outlook.com (2603:10b6:510:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 02:43:33 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Fri, 14 Oct 2022
 02:43:33 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2yRiIAgFmBm/CAAHsxAIABTZhQ
Date:   Fri, 14 Oct 2022 02:43:33 +0000
Message-ID: <SN6PR02MB43347B7046715E5DFA83652AF7249@SN6PR02MB4334.namprd02.prod.outlook.com>
References: <20220812161003.27279-1-kvalo@kernel.org>
 <20220812161003.27279-16-kvalo@kernel.org>
 <576a0720-fe45-36bd-abd1-b772dbe380b0@quicinc.com>
 <SN6PR02MB43342E0EDCE5420D93DD1EC7F7229@SN6PR02MB4334.namprd02.prod.outlook.com>
 <92ad1bee-d9c6-9244-f8bf-5fce8ddf4a55@quicinc.com>
In-Reply-To: <92ad1bee-d9c6-9244-f8bf-5fce8ddf4a55@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|PH0PR02MB7558:EE_
x-ms-office365-filtering-correlation-id: 1c1bd203-7109-4de0-f010-08daad8de2d7
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tK6a0klIJXgrkD3NR6wLL+RObSB0NDadtqV2kPqhQ7dxnfzo7MxeUQ8YeMGpcrM+j3JXEg6C0juPGjisJIz3vsJBQ/KdXQAf8Z7aAKPxq7NersH3trjLkdMroeCJnhNYkS0MM6RCb82n/KugrEGnz/0RNmVYuVOhdHIefv3ZCya6PnxkfbSq4xzr6/cZHZ4XtnTUNGW7rfabds6LuqFVvlumspnlcPoWSNVVkdKmcMb2m2hKIoXlLwfs09/gH+kvz1D77du1vMVXnIqns41SaHWvGTJ+Tzy2WRJo6XbBryWQUXT5UKucTHEkmde74/ih3y8QERA67EQs5HBjW27tHyGdzDeU+v+OOJFjcWW3H0DHb1cD29oBj9u1o8vZ4bCNQYa6DBBsf7lddunIUX0NETwDGOmFb9+sjO/gY5saCSbPM3Yxm78HOrXrYO+y5he9NRPu2FQbGWzlQEJbiBr1mzNTkeYtyLmsChDQT25f4MoczyfjXm8Pa/On1U3cwLG7UGDzct7RCaygVDILND5T2vmzWzcZnbVH+kgP6Ky/Jzk6tJwt3f/9Klgp2sreXNVC84ONeikKO/3iSGVu4pxCvt+tVIbUSSrrOSPSinpP6HwAeoNkYlVGm9lvZXjULidbd+1sr4kYCGHSQKD61gRqhA2S1vCOeut+X+vEIHF8iwV74OHgUTpRkWBRFy+FiAnmw/Dgp3WgBrrHOJSWuaQs1cJai8aIWZa5jPpoCud76MJ4r1IhMdrdZVQe4Es59e1k8OLH19Glucw6njoG6/A5EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(5660300002)(7696005)(2906002)(4744005)(186003)(6506007)(41300700001)(9686003)(52536014)(26005)(8936002)(33656002)(38100700002)(38070700005)(86362001)(55016003)(122000001)(83380400001)(316002)(110136005)(76116006)(478600001)(66556008)(66476007)(64756008)(8676002)(4326008)(66446008)(71200400001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkRSSDhSNGtrWGcxS0kzTzEyNDBwL21pNmlGMmpDN21Rems2TnNoZ0VNZUhn?=
 =?utf-8?B?b1UzaHJBTG0weHAzWm43TnZ2OTYydFFZUTVJSU1wTWEwbEk0WnNxWmRJN3BN?=
 =?utf-8?B?Q2pvSFVRNjRqaHNiOEFrSVJSaU5xTjNzSDNIclA1WmI3TVN2N0dqOXVUdE9V?=
 =?utf-8?B?aGRWblZuYlExUDYwMjZwRFh5dEtkdjY1bjlrNGFrTUIrUnE5TEZsMCtDM3JG?=
 =?utf-8?B?dVRkN3J3aEFOMUdWYThPNGx1czRNamRmak8xc2VXYkwyOHR6TFI4SVM0Nit1?=
 =?utf-8?B?Y29aYk8rZHNLUndZLzhqMnZxd1BZTlh2VEYrSE1KcVdXVE13THBWa2pESjk1?=
 =?utf-8?B?dVA1MDc5aDZ4MGZNQXAxdWJtUW10SEZMZUhIVWkwR3QrU2RoNUZwaHNZOVNy?=
 =?utf-8?B?UWg2b3pzUzFweFUxbjRtUDN5dUNtM091WW1kczAxWDhOV2VvTWpFcWFseTFP?=
 =?utf-8?B?cmxTbUhkUmdqdUpaWUhPL01zK2gwdngrdnYwSU15dExCa0ZsRzNVNi9WNE9B?=
 =?utf-8?B?NTJ1cEpmN0pUUXRSL0tZUVZnM2NHTVBYWVZFTThYMExlcXh2Lzc5TnMza3Q0?=
 =?utf-8?B?M0FQRFpNSnZQcmtNN2MrNzY0TkFzWExOemI2UmwzblgxVU5vMVFENGtwMVFy?=
 =?utf-8?B?QzlPOU5kNFBXNHljTUl2alYzOC9LUWp2TEs2Y1hYT2VxRDJKenBqUndBR29U?=
 =?utf-8?B?dy82bFlULyt2L0ZhMnNTRUZ1cXZWTFhpUllrN09IRExkd2IyemxienZwU3hB?=
 =?utf-8?B?WUpTWXBwaUx0Z0NWQnpkZldzL2pvTktJNTh6Nk1ETmJyNDRsTTYwdG1iOG9V?=
 =?utf-8?B?ajdhZ2tjS3pNaVJxbUNoeEtjVEpXQUlsTEtTSlRTWDZ0eFpibTk3bG9JZ3ZQ?=
 =?utf-8?B?UWtYWGpsWWVnd2JWL2FIaGxKMkJJaGw5eUZPNzRxTDREV0tEVEpIZmFnVVpL?=
 =?utf-8?B?K2Fka1g1RWRLemsrcmIzMFAyWkx4anRjU1JCRmZjUVBBU3d5dnI2T3gycUNZ?=
 =?utf-8?B?Z2x2SERNb1Zrc0Z3dXVIQTAySHRndDVobnNYakg0c0pOY1pZRHVtSm8vd3c1?=
 =?utf-8?B?QW5MaXBwUWlDTG05YVhibEJpNHRlcGlBY2VJL3plelh0Szc2eW5aeWQrOGU2?=
 =?utf-8?B?Kzk1VHp6UDVEUWxTNHZ6Z1pwaHhHOG14VWloN010Y1k2NGxPMGtoTzlZc2E3?=
 =?utf-8?B?d1REcCtyUElxMHp3ZHNXWHNDWEd3TXBWWXlDNG12SzNmbEU5V1ViTWFJdUU1?=
 =?utf-8?B?b0JFY04yOHpKbU9SWHZlSVc4RjAvOWNVRnFHdUlJcm8xdVQyWm40RlNnRmcw?=
 =?utf-8?B?WXd0cUh2RzQ3ZjZYOVdoS3h1eC9hMDhjb1RZZnBTWTVuVW9YaEMrQXc4RXV6?=
 =?utf-8?B?NGkyRng0Z1UxWmhGdENWQkRxdXl2Q3lGdjVNVjF0bkl6WmFsZkJxT1gyWUwv?=
 =?utf-8?B?eWpjVHJyaEZIYWp0Zmh4WlJpb05zYjZYdVRhaG0wOWNaWkp2R2VaNURqTkhX?=
 =?utf-8?B?SEdKVGJjZjF1bVJsQmN3VkR4SHJxeERPcngzaHcwNjZUQ1dtQnRKNk1hT2R2?=
 =?utf-8?B?K0RZR3l3cHRiNnFZUmlOWmplbjJpVzg2cGovTFhHSWxSTGp3bWVPTUpjdWVT?=
 =?utf-8?B?SlZydU4zbjdQMTRGM2VabmZ4TGxobWhnd0l3TC9uZTJ0eWUycklCdlQ5SDQr?=
 =?utf-8?B?bWlmRXRaa3RMU3gvUi9SVXVEanVndnRHQlFSVlFMR1BsRzk1bEt1d2xlTmcw?=
 =?utf-8?B?T2gyWkozMXFTWWVkK0VES3R0ZXJjWkFidURPcGpIT2kxWWtHNUQ2MVo2NUhh?=
 =?utf-8?B?V3d5Y1BUL2ZwRysrdU5sVDJQeDBETCt0S0ZiRHRpNUJKMFhNbDV4dVRKWFBr?=
 =?utf-8?B?YUhtdVVkcXdJSkJiMy9Rc2x1RzN4azhYUExBOVgxTkVROFFWSjJWZ2xrYS9U?=
 =?utf-8?B?a01mZjlxa2pDZEdrYkowT056dy9Pak9OYmNrUERxRzBJc1Z0dGdLcXpva3Ni?=
 =?utf-8?B?T3lMamhGWE96czZIRWs0TElENWk2Sms0ays1YW1FZFBmR2Z1OXpmbWFVTk1T?=
 =?utf-8?B?WnJoMkJ5WmMvU0lHQlFkcVRmTkhNd3ZSOVFpZ09YYTA3T2lYeDFGSEV0ckxO?=
 =?utf-8?Q?UY9FECZgjNvmnHslodoaysg1/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1bd203-7109-4de0-f010-08daad8de2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2022 02:43:33.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPg2D0kwxcQ5A6LOE9Q6whDExYm4VP/9yCDmqLkIxau3SEiY/f+78xiET5eS0LzEc2pUMuGKYh5XFM0iGUaEZGOkZllXkOPsJrIlOfHsi4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7558
X-Proofpoint-ORIG-GUID: yGeJgl5gvUCev16OC6i-NQD8DpzHFxcZ
X-Proofpoint-GUID: yGeJgl5gvUCev16OC6i-NQD8DpzHFxcZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_10,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=533 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
MjAyMiAxMjoxOSBQTQ0KPlRvOiBTcmlyYW0gUiAoUVVJQykgPHF1aWNfc3JpcnJhbWFAcXVpY2lu
Yy5jb20+OyBLYWxsZSBWYWxvDQo+PGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13aXJlbGVzc0B2
Z2VyLmtlcm5lbC5vcmcNCj5DYzogYXRoMTJrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0
OiBSZTogW1BBVENIIDE1LzUwXSB3aWZpOiBhdGgxMms6IGFkZCBkcF9yeC5jDQo+DQo+T24gMTAv
MTIvMjAyMiA0OjI5IFBNLCBTcmlyYW0gUiAoUVVJQykgd3JvdGU6DQo+Pj4+ICtzdGF0aWMgdTE2
IGF0aDEya19kcF9yeF9oX2ZyYWdfbm8oc3RydWN0IGF0aDEya19iYXNlICphYiwNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKSB7DQo+Pj4+
ICsgICAgIHN0cnVjdCBpZWVlODAyMTFfaGRyICpoZHI7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgaGRy
ID0gKHN0cnVjdCBpZWVlODAyMTFfaGRyICopKHNrYi0+ZGF0YSArIGFiLT5od19wYXJhbXMtDQo+
Pj4+IGhhbF9kZXNjX3N6KTsNCj4+Pj4gKyAgICAgcmV0dXJuIGxlMTZfdG9fY3B1KGhkci0+c2Vx
X2N0cmwpICYgSUVFRTgwMjExX1NDVExfRlJBRzsNCj4+Pg0KPj4+IHNob3VsZCB0aGVyZSBiZSBh
biBpZWVlODAyMTEuaCBmdW5jdGlvbiBmb3IgdGhpcz8gd2UgYWxyZWFkeSBoYXZlOg0KPj4+IGll
ZWU4MDIxMV9pc19maXJzdF9mcmFnKCkNCj4+PiBpZWVlODAyMTFfaXNfZnJhZygpDQo+PiBZZWFo
LCBidXQgd2UgbmVlZGVkIHRoZSBmcmFnIG5vIGluIHRoaXMgY2FzZS4NCj4NCj51bmRlcnN0YW5k
LiBzbyBjcmVhdGUgYW4gaWVlZTgwMjExX2ZyYWdfbnVtYmVyKCkgZnVuY3Rpb24gaW4gaWVlZTgw
MjExLmgNClJpZ2h0LiBUaGF0IGNvdWxkIGJlIGFkZGVkIGFuZCB1c2VkIGhlcmUsDQoNClRoYW5r
cywNClNyaXJhbS5SDQoNCg==
