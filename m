Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A96774B8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 05:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjAWE6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Jan 2023 23:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAWE6H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Jan 2023 23:58:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B04310242
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 20:58:06 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N4vWbZ004256;
        Mon, 23 Jan 2023 04:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=OAxjjSyJhs/+CIOCKk9oH5SXbeNSkMDBacqqv0sv3/g=;
 b=R57SZohot1EBJIBKAdFWuxfM5pdnvUZPVTIJpBT9gMnSwWNK8yWO0hPd3qHIWXXGIm6/
 vDIiL4k7xS9mPefRYhSmXqJFu2Jx1kCjBmGEoxi5Jds/RTTDIrSk0+I9mMbTFFvOSYCZ
 002CWcLSCqNV0/dfKyEwr0UNQmdDClCBmL9KnpK7A+N7GSWr/FG0OIrjlmoaiErJMTRW
 OgZF4IbyxTz0nAd2fVuMH/f6PWhTq8+p/DoMj2EUcRmHqsCxEP0bGgpgnlITFmYABFH7
 klaRF5OWr6cw7PEA9hZR0p/OXbY3rmgzoSxxhI68oCI3hCHHoZLp3Uju+zI81XpmYH9v Sg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89fra9re-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 04:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9JTWTyXCEssEfn894tuRgRJopvZ+6psMnZ3aizZyqgObU5Nd1ERiPyDuST+xFaWb0us8R5joCI2U8fA8q4TmC6ypjW4M/o+VW2NqhLdk0NXeVEtduFW13SGfnRhflAAuXY04gwmBWMXxM0KKff9xaJ7N0pevI4ZrohQEzgUGXesOnRT7F4E9Y7ke8AwgIN2gZUxq5saekKIIIpUXeAVmOkBnM2gcmWaZ10+pLqVoaByxJcRZsfuPqjuPto/23HwSSQQU1f/2aMT/0kVSaCvoxvNEIyt7HW82aE1WXq3z52q88QX7mXdd8HZwmaVkmYriDVjmPv8JBBXZso0jEZhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAxjjSyJhs/+CIOCKk9oH5SXbeNSkMDBacqqv0sv3/g=;
 b=VObUDe1JuiR5yckD2mv3oTRq5A3THoZ9zi0uZnniZIucyx4euuPTLWQb9QqKw694QqcoV2cCYWuWK4btfjjEfpnR8YNUJOdPogh92LX7FGeaaDY2c/d6nXe9U1MrJoQy+KRgZDUYqCpL8pVJb7z/W3RbbE4ELqmDWal6m4SEn1IOXSNZla/Q7rKl/PAiU2OpY6NsR/7IXrZfz23rftByBU7JDzmv1RAMX7tskh53m7XPxttOBrvi6SLpIx29T+3hzuL7kZjEp21U+LwGDGuPJstlreQVzqdGiYL1XCZhmCYg3+XJEsUcWI8WIMo32aaWd3tY72tcyCNVHm0DgF97rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 IA0PR02MB9463.namprd02.prod.outlook.com (2603:10b6:208:402::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.28; Mon, 23 Jan 2023 04:57:27 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::c7ad:bed:829a:e7b2]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::c7ad:bed:829a:e7b2%3]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 04:57:27 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Thread-Topic: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Thread-Index: AQHZGQTEdMPbxxNBSEOPQ9UHmDOQsa6mcV8AgAUpSvA=
Date:   Mon, 23 Jan 2023 04:57:27 +0000
Message-ID: <DM6PR02MB49372BB7FCB6E31CCAC20E9AE9C89@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
         <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
In-Reply-To: <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB4937:EE_|IA0PR02MB9463:EE_
x-ms-office365-filtering-correlation-id: d1f91813-af26-4a61-0d93-08dafcfe5353
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9m0TCRoKMfWxW5m+aioBsCLGeDthS6Km6DmvwX+nUAgwr06/ZwwvDjMMaEQxr71bneAEjgSdcfmpP+RoOwJMpWwiew6quSHTOcDK8tu397r7Szo7mW05voC7S2UNrfH2i5QJJkEgNIW8x/JEC3R0Jjjj0Lo25rJMQ5e1RwD+PBbjoYDROs9NO1kqXTp3RgBWYaf/zopKkrQ8wL+ZDHY8HDJJ1x5EaLPXGrXjq3aMBSci5ZhtGU1ALCD9SaFuWDw6dPDmirrko6XjSXe27S1aOnlhoDGZimjcdwXhKUnwXigzz/FdJ4OWznkOhTwcSNejUjibTIpIVpeemngsVs8+rON0ZphDsC95oJiviscNRxkvLErgIOXTSHTnD+GWKgGb/9GE6ZayQPUEjwnptJ2nfh/STZRJvwrQamsRAhwUb0S17RrRB6b9P/28STA5aqeFlDdZr8Y/ByQeZ7UTiawUd8PFjeZ7QZ+LHGdU/wXC6XXgBGgFzP2ZGtdzHkgknrCPzkn+K2mC9vkehcC6uYIoHRj7MBNsdBrHDi+lzF/EPPHdMvlv/uHdXcged8WQn2X841pFvTTTYEtEjUBqfnjIzHm34m5EvD/PG7HieUfKr2mYL0ZlywG6O/+ujuJoYY+CMWOX2YhiTPjdfXsjSNRysf4ExzF+iWkaboClBfPqFLqACx41LAyrmRerHFs5Q305IdLEqyXvgR9aCJxYN0NjXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199015)(4001150100001)(86362001)(55016003)(33656002)(4326008)(41300700001)(2906002)(66556008)(76116006)(66476007)(9686003)(186003)(26005)(66446008)(478600001)(8676002)(64756008)(66946007)(53546011)(71200400001)(6506007)(122000001)(110136005)(5660300002)(8936002)(38100700002)(316002)(38070700005)(52536014)(83380400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emNGTFpCRVdBZzhoNi8xL3BVVHl0cWVhbGRrVHJDMzdVTWgrR3JSck03NWNP?=
 =?utf-8?B?TlRzRmlrTWhtdkcrTzRBb3l1VnVTZXNXbGRpeGpMTkpjcVVhTmZqTWhMR3hC?=
 =?utf-8?B?RXczbXVFYWpYRGRQakZYL3BCY0p0WVhXQnRrWEFLbWhObmMwVzVYbzc5a3VU?=
 =?utf-8?B?Q0VWc3VacHNWY0tqSHVSOWNlQm02Y1NSckNrZm8zdE5vRzdRWlhKa0Z3SURZ?=
 =?utf-8?B?TCt1TEQvUGt5KzgxR1FrZXVNQ25nbHlGNDh5V05SNVFwdTlsSzZ0aERMZGk3?=
 =?utf-8?B?SkFwYVdzbmxidjBSVDRqRmhkOFpDMzN3ZkxRTWtpYnhWN21nTDNXZytBNTRT?=
 =?utf-8?B?ZjlXMG1ob1MrWE1RNVpmcTBER0c2ZHp3SHZQUjgwR0lxeHhTLzRicGdTT2Uz?=
 =?utf-8?B?Z0FvTTNpVmh0VWM4c2VRQUdlUXFTUkZ2MWpkV1pMUGhIRnZtSHo1OE1ieUg4?=
 =?utf-8?B?M216TDQrRlV2aklEMzNnc0YxWFpvZWVPOGdxRTNHQXk2N05VZnVGN2c3Z0ha?=
 =?utf-8?B?OVhsZkt6dXVJRW5pNXBhUHlweTZyaDlPeGZzUllWb2ZjdXI3alFqYlY2YmJI?=
 =?utf-8?B?V1pCTHpGaDJHNEd4K3NLclJHZVJXazI1MlNKS1hTamxkR0dWVDQvdlZDeTJE?=
 =?utf-8?B?eTVUTnR3UmFycGM3RDRsYWhsYmxMTGZrcytWaENmVmJzeTduWERHVUx2QUJq?=
 =?utf-8?B?a08rS0lXV0J0NWhVNUpJcVBFVGhWdHNVbUNvSDRhYjYwU0VkL1o1eVJKaWo1?=
 =?utf-8?B?TEt5WnNibU9DNGxaYzVMN1djRk9JUnlSbitHaUMzVVNsSTlHTm1IZlYvSXEv?=
 =?utf-8?B?RGM4UEFLWjhWT0xPZm1zekY1aUtMNVpDTG00aVExZVVLZWJKek9vZmxvQU9Y?=
 =?utf-8?B?RGx5V3E2NWtOYWNmWWJaMFlaMEJXR1hYMTFTbTNKdkwwYlRKS0ZMNlZvZ2Vv?=
 =?utf-8?B?N25kQ0xTYkE1NXpCN092SXA4MFB2RVIxYWxmWkNvdzFxWUxLNjJUWVZwZXNG?=
 =?utf-8?B?ZzJBcmNHdk92STlvOEV3T29PZHlzNWVkMWI0Vjc4TkpXSkxPK3libGlBVjVv?=
 =?utf-8?B?enlwc2dzVGpVbi9GZmltVVNId2pyb3lTdUtyZ3JidEQ1b2plUkNFZVJ1dkJu?=
 =?utf-8?B?OTVWQXBBSVo2OXhxcUZSVHduQmljSnQ0VXdmMWpHOUFEb2REUnZSYzNWWGF2?=
 =?utf-8?B?d3dEWGJUTU1mYXUwcXJSbzFGR0h4ZUhHaklKWld0VDlmZVJ4UEc5MXJWb3Zi?=
 =?utf-8?B?dW1ydkZ2YTloVzNmNWVCZWREV1J0a21GRFZSTnl2Z3hOQ3owK3NTWGVVSVNU?=
 =?utf-8?B?TGlnbEh5NERQRGxOVU1UcUg0U2huenhDWVc5eFgxZ1ZGa0VTakZXZzMwN1VM?=
 =?utf-8?B?SFpWa3Z5KzJsZEtxbjczRzRENmordUJIbm1QTThTRC9VV213bHcyMmZwOHI5?=
 =?utf-8?B?MTZZbEgrY3FaMGxoaHhXZmhzUFYvaS9TTENVb0daVzhLamNmdnc4QWxBNjds?=
 =?utf-8?B?emJmbWRHTHJEdGJKODBtbGZUYk12Z1JSMXhUOFVROG1FeUN6QVAyaVhycEFE?=
 =?utf-8?B?M3gxWFd5eWdCbVNjdEJQZTBFMk9ic3Vzc1dhang1ZVFsNkF2NWk3bkFpVndx?=
 =?utf-8?B?WGtVTTRBZVJJdHRMMXpsWTlBU3lFTTR4dndNdFFPYnFzOE84VkxoK0pKR0Vr?=
 =?utf-8?B?NGh4dXJ3a0tMM2NxN3RuSTdZZ2hsRCtMVjA0dkkvN0t5dDR6amRXby91SUZG?=
 =?utf-8?B?TjhYNkRyUHMyeVFKbE9zUEVSNWswSCsrZEdLSGhkdEZpVkZJbjZXMU4zQlRX?=
 =?utf-8?B?RkIvYjVNb1RDTk5BU0ZJU3NKcVNmaFZLYk1mbm9BK2RGYVZWUFRuVU5hSGNB?=
 =?utf-8?B?YVpSKytRb3dJMUoxeWxYU3gyTUVxbFhhR2NiczY3aUNPMVYyWlRhOUxlVmlT?=
 =?utf-8?B?NE43bUlFWi8yd0RaUk9aTGlVL1M4OU4zSFZnbEFtM0pxYUpOQTJlVmdteU1F?=
 =?utf-8?B?MmwrbFdRWmRhVHc1dkphYUx1aVNONWptOWRvTTFvR0RHa1ZUbzJ6MzZHUVUr?=
 =?utf-8?B?MVZtTkdWeENVOUwwZEt4Vyt4SEVQazJYNWZmbWtSNWpjUjdMSE1Yc2MwNC9R?=
 =?utf-8?Q?rtBRD+vAKVP1AyjCMqDXU7Lxk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKcyWveMi+Y4PQQnFqBGoHLOycULKhNEv8clVGK1tBKx1X2yq0AjnnZh81E0kmMR6tgg+zKRDpL/6N0lN6ZmDW/TWAc1MgVc54Jz6jvvk1VgeozLifHbQRik/oZxnSSJPPgA1v2OUdx8JreecoNzj2cIyHdjs773lYZPFnuZZMpwp7lQmChficUqlww5eDqEDRRxvKCanVw1y4qStUonyswzpAM7kLDsM4AIv272kvT8dBY/KDpD5AjQqBTZMge63dmPd+pqvTkj80EFuwcsiVc3+ZBGbkadAcABfUmVrvt/i/UqqYCvdhR5Cx6wKCygBtzhgXMZyGgy7ZjOVmcUWz2VZWd/oLW5QgHb7PGoznizw6uwk4UWNNgafZ0yUAwzj60dHaHcjR38ikrw5iQI09cqZDO3JNtJcOL7upsNphmYUih/ysX0OSZ/lC5VJidkMe/1JTzizxYNStZrg9OfR7/PNaIZ8XohyY+eLTkaZdgv9u+SD1dVELnDkXtUqdyZDjo3mOsQYe9gx+AHFhve+9ctRPv2Yl2hpyE7grIXyWebt244jLs1zk2SSd8gAVozL4RUS4WhhvIBnb52oxkIixKLSkvfokbBNRD1v1X67dWzanyf16QjWG/cXByTBbtxaNFPaaptuMUkvkilAwiuuMA6w+RfBVB5myygUJpBNkEPRVky9UluqLhAgc0zI3P6YitK8b3jNBmaJsUZtvUWqxwdcznzGfKz6L5QlW87mlEx2UikFbp52W65Zqet4Tfxlhg7w285ff5aDmuFrigCyvIgm4RSFKhiMmFTpPIDkQQYWtjP7kh+lD6Vt+9ftyLZ70NltCGWuhvY+QcQMdrex/arYtcODWWX1ply5bIhb+4AUP18+nJFDaKcL2n5dZJS
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f91813-af26-4a61-0d93-08dafcfe5353
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 04:57:27.6034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tbZjOR+V2hT1CqA0AaHPhvnAMxOkdUek7t3mp9AauEV8L8oWnNmxQD7QuCEP6y7hBU0P6RD8hoq4AgCKT2t3oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9463
X-Proofpoint-ORIG-GUID: ExvL7j2XgTwQ8P97G3j0fhQvpMaUNC0z
X-Proofpoint-GUID: ExvL7j2XgTwQ8P97G3j0fhQvpMaUNC0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_02,2023-01-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=566
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230046
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDE5LCAy
MDIzIDc6MzIgUE0NCj4gVG86IFJhbWVzaGt1bWFyIFN1bmRhcmFtIChRVUlDKSA8cXVpY19yYW1l
c3NAcXVpY2luYy5jb20+Ow0KPiBhdGgxMWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBDYzogbGlu
dXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBu
bDgwMjExOiBhZGQgc3VwcG9ydCB0byBlbmFibGUvZGlzYWJsZSBic3MgY29sb3INCj4gY29sbGlz
aW9uIGRldGVjdGlvbg0KPiANCj4gT24gTW9uLCAyMDIyLTEyLTI2IGF0IDE0OjAzICswNTMwLCBS
YW1lc2hrdW1hciBTdW5kYXJhbSB3cm90ZToNCj4gPiBBcyBwZXIgODAyLjExYXgtMjAyMSwgU1RB
cyBzaGFsbCBwcm9jZXNzIEJTUyBDb2xvciBDaGFuZ2UgQW5ub3VuY2VtZW50DQo+ID4gKEJDQ0Ep
IGZyb20gQVAgYW5kIHN3aXRjaCB0byBuZXcgY29sb3IsIGJ1dCBzb21lIFNUQXMgYXJlbid0DQo+
ID4gcHJvY2Vzc2luZyBCQ0NBIGZyb20gQVAgYW5kIG5vdCBkb2luZyBjb2xvciBzd2l0Y2gsIGNh
dXNpbmcgdGhlbSB0bw0KPiA+IGRyb3AgZGF0YSBmcmFtZXMgZnJvbSBBUCBwb3N0IGNvbG9yIGNo
YW5nZS4NCj4gPg0KPiA+IFByb3ZpZGUgYW4gb3B0aW9uIHRvIGRpc2FibGUgY29sb3IgY29sbGlz
aW9uIGRldGVjdGlvbiBhbmQgdGhlcmVmb3JlDQo+ID4gbm90IHRvIGRvIEJDQ0EgdG8gbWl0aWdh
dGUgdGhlIHNhbWUgZnJvbSBBUC4gSWYgaXQncyByZXF1aXJlZCBpbiBjYXNlDQo+ID4gd2hlcmUg
U1RBIHN1cHBvcnRzIEJDQ0EgaGFuZGxpbmcsIHRoZW4gaXQgY2FuIGVuYWJsZWQgaW4gQVAgdXNp
bmcgdGhpcw0KPiA+IG9wdGlvbi4NCj4gPg0KPiANCj4gWW91IHNob3VsZCBwcm9iYWJseSBzcGxp
dCB0aGlzIGludG8gY2ZnODAyMTEgYW5kIG1hYzgwMjExLg0KU3VyZSBJIHdpbGwgZG8gaXQuDQo+
IA0KPiBBbHNvLCB0aGlzIGRvZXNuJ3QgcmVhbGx5IHNlZW0gdG8gbWFrZSBhIGxvdCBvZiBfc2Vu
c2VfIHNpbmNlIG5vdGhpbmcgaW4gdGhlDQo+IGtlcm5lbCBhY3R1YWxseSBhY3RzIG9uIGRldGVj
dGlvbiBvZiBhIGNvbG9yIGNvbGxpc2lvbiAtIGhvc3RhcGQgaXMgYWN0aW5nIG9uDQo+IHRoYXQu
DQo+IA0KPiBTbyBzaW5jZSB5b3UgY2FuIGVhc2lseSBtYWtlIGhvc3RhcGQgaWdub3JlIHRoZSBl
dmVudCwgd2h5IGRvIHlvdSBldmVuDQo+IG5lZWQgdGhpcz8NCj4gDQpLZXJuZWwgd2lsbCBrZWVw
IHNlbmRpbmcgY29sbGlzaW9uIGV2ZW50cyB1bnRpbCB3ZSBzd2l0Y2ggY29sb3IvZGlzYWJsZSBC
U1MgY29sb3INCkhlbmNlIHdhbnRlZCB0byBhdm9pZCB0aGUgZGV0ZWN0aW9uIGl0c2VsZi4NCg0K
PiBqb2hhbm5lcw0K
