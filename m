Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE04656D12
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 17:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiL0QpE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 11:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiL0QpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 11:45:00 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E176738C
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 08:44:49 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BRG8CLf002857;
        Tue, 27 Dec 2022 16:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=5FPnHnlK2lzvk4Wk8WIdIBqGPJBGnizqq3dRgGR9FN4=;
 b=L2PPI2MUhUDi2W2MNMNqJzECjFI63kc5yfr55wlPQfjC6v11SMRyE+7rjd12D9sJYHXa
 ehNyKoXHNXrSUEj6hqDbZvYhbG398TTcKEsmfo+fUwx6E/1Ha3HcLvFkXuPKbABWYoC9
 7i3zh2aihzHZRYWm0zld0o0diAo4OBtFhKLZOsQII+6x7EOM0tbMKKaTnBBwRSU7h3Ya
 tl1WRNgExQMPyYNkL8zbPsGrbuu+9K+QcZAQlIFlttcZTo0KaB1X9jr2DvOmVikFk8cM
 SeDZnAWbScR4QzbbcCy87DqC2412e4d6WiIkZe5VUZ0Zxj4026LmfbNK67vvKG2ROmJ9 sw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnrrrwkj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 16:44:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERurK1NjlNPMc+cMlz8km+mukTs8zYwA1BtmpUR5bSHVggTUNrmkuUre3W+QTnO+xGkkno2OMxP6KSmOALKlJQ534b50NZF5mESSNK7St9QGbXExTzDD7AgHX1C9lmo96LGl+rcWAU4EBpM2EyZEcBQTSLBNQ70x7rDejcOubT5U5QQC2Opfp/5kfb6tKrTncUTWeHUwt1iYNZn83rbsCeCenDvOZ0VT12tDoQ0KLmpIxTOEmQeMKe6yiGuzN15MMMYBavMkbeun+XDMwa0Xb9TGvHDiFb1cEmVAd+5Jt88i/0xgucU+Lw9UfhEBHCPQxnHuTRmglmg8HrwhJWGQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5FPnHnlK2lzvk4Wk8WIdIBqGPJBGnizqq3dRgGR9FN4=;
 b=YyUzA587poe/GZCGuag7Cq0ZUV5qbhz9DRVc4pQsLXGrCshWT836IMneEdP1e4NJaj4VkqPO6x86++w00YL9FLQIZkV3fBX/Opox0wuSGt/gOPcsdlEq0wTo5gPfvRMfqTcgxPY9Qe3F0a73KlcW/usaMs/E3ob7zRHyowy0M/i0VcnB7D9Wzf5lC4D9MoUXscWrLxol0DOm4lA6HYbkrTrseC40luOOXbdDwcHrr/RUrOVoiyLUca5zXs91NgpZG5JZDVNw4hJHEnV8nz3LcdfN7ziD5yE0Xkiy2vARQZbxTR5TKJQSfPwOLZy8kfdd4vym+Bi+o2Sc8haIb/+v/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4930.namprd02.prod.outlook.com (2603:10b6:208:53::27)
 by SJ0PR02MB7517.namprd02.prod.outlook.com (2603:10b6:a03:319::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Tue, 27 Dec
 2022 16:44:43 +0000
Received: from BL0PR02MB4930.namprd02.prod.outlook.com
 ([fe80::1c33:72f7:e3e3:4d79]) by BL0PR02MB4930.namprd02.prod.outlook.com
 ([fe80::1c33:72f7:e3e3:4d79%4]) with mapi id 15.20.5924.016; Tue, 27 Dec 2022
 16:44:42 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: Allow NSS change only up to capability
Thread-Topic: [PATCH] wifi: mac80211: Allow NSS change only up to capability
Thread-Index: AQHY4qw8zeNm6c+9jkG2F/Ykv474hq4ZNGyAgGiWJqCAAQnvAP//iXfw
Date:   Tue, 27 Dec 2022 16:44:42 +0000
Message-ID: <BL0PR02MB49303DA7724885A6D8DBCEC3E9ED9@BL0PR02MB4930.namprd02.prod.outlook.com>
References: <20221018044341.5453-1-quic_ramess@quicinc.com>
         <b763a390dedff804015a540f097bf804ed0e1436.camel@sipsolutions.net>
         <DM6PR02MB4937DDAF64A4880FD81C11CDE9ED9@DM6PR02MB4937.namprd02.prod.outlook.com>
 <a4507149db27f761e0edb228623103711dd9a6fd.camel@sipsolutions.net>
In-Reply-To: <a4507149db27f761e0edb228623103711dd9a6fd.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4930:EE_|SJ0PR02MB7517:EE_
x-ms-office365-filtering-correlation-id: 579b44d4-5dfe-4415-8570-08dae829a762
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aZOM1anlciStOCzb9OBvS4e6OMUFBivhiDKVn24GwKTezcXedpr4B31nXgMWwPcVnOOj4mU0w4yPR/UBbDDnNno/J8PccGdN/lSHX8F4xXRaiRkf3z41jfqY0cA9bXxS1axWQe8ri+w2CAhEQA6xRlQC/14mbDYRb8zGMIz+p4lXJGskjShXXEStI7KSd0CDxZCip7GSdc9VH3I1guqcWXj4zTxaXZoLdJhjyhrqr/qLBVL02bNyqPB6c2flNQuEU8BMvQJmUHtVma8cHT8JGA428mDek401zNVb57KgDg7b0ZsiiJLyS90I269nZEH4w0fBBGjcNX0EB1AZQvomK12xCUjHmKeqnsCGGCQfdlAN0i3/qWYOdrriTk4cybPDdJr/NEi0UWbtCvG0A6zZm5u1XUyrNpPIQ9DahsiMjOwyvHB/w/Ht2Axpilru3PObe9/V0/CRP6GzL7pNL7htx9YCCSk6yiDVVUbvbuRQWxGU/4/BPv3B9aNfG1+VgIhBKXG9IOV6hlw6X+LUFhrR/ZoPeKcQL45Gpk5O4yEc0MVLBnx2J4hasWry3zMhFHELqY2dXS3qk4bKvjXSj61LjGxmpBlzTaFiRlSoEFZm0Kwn9yJknmfjKu/YT5wrX7zD1KScdpKQyFDz2n6lAGyK/Ck0Z1Z7/bPibpvgERXAcuCMG9rAfIJw/JE4OLk1UlGDk0iY01bFFGdRXIkR8Ot3Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4930.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199015)(33656002)(4001150100001)(83380400001)(110136005)(2906002)(71200400001)(316002)(38070700005)(478600001)(186003)(122000001)(9686003)(38100700002)(53546011)(7696005)(6506007)(86362001)(55016003)(76116006)(4326008)(66476007)(64756008)(8676002)(66446008)(66556008)(41300700001)(66946007)(8936002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nlc5MmNSUGZTNEdoZ2J1cWJla0ZmL2JjalQvUy9TU2Z3RXpBZUhYSFBXY1Vh?=
 =?utf-8?B?dDhUVU9WYklKS2wrcGlqVUZyUW5PZVFsczEvdXlWUVhNSHkyeC9Ja1p2dVJv?=
 =?utf-8?B?VU81S0pBUEhMSVJXUW5VRTlkRXd4c3BYNWU0T3BaWHhqT21XaVkydHVyYjJj?=
 =?utf-8?B?VjdkeUpKMmVaTzRDRWQ1UWNzOHlJR1dnRy9FUHVhU1dQaE9WWTI0VUZQdzF2?=
 =?utf-8?B?K3Z1NFlDU3NtQmNyTUZxVzM0QkNRcldkSkc0WWg1UXJVb3E3TEg1Q1gvK2hl?=
 =?utf-8?B?MDVJMUdqRThmSTV5RU5FVmNuSGd4bUF5Sm43bzk4S3ZDZENPbHl6cUt0dS8z?=
 =?utf-8?B?aEpPQk0yNXNLUmFGMytGQU91Z3V4RzVoUnltVG1aelpMOGpLK0hkbzF4Q1p1?=
 =?utf-8?B?TWdqOXBjZ1VEc2tJdGhwaFhXd01wMDNxOW9VN2xYODEzazkrMk9zKzFpVThZ?=
 =?utf-8?B?ZzdqUW0ybWk4UkFhV21ZYUtFOXJmb25OMU9vcG0xWTlHMEN0UmhCYkI4bEZI?=
 =?utf-8?B?eXZ1c0ZrMjgxc05KanlPWEM2VDZGK3RHVWVVWG4wZUROZ2pnSlFyUTA4U1Q1?=
 =?utf-8?B?aW1iVkkzdEhnc2VJVUhXRmFCZXhlTWx5ZXZIaXBJQ0lYT2RFdXVrek1jOWxv?=
 =?utf-8?B?d3BzR1o3TzZLOGRFdkZlU3BDSGlFZVdmYjIxNk9qaFBlSW1PbEloN0VtZ1B2?=
 =?utf-8?B?TFlBS1FRWGhIekJsbzRkTVZ3NVQ3akVuTEwwdHBJSzJJMzdPTE43SFdCYjZU?=
 =?utf-8?B?QWwwU3NZNjZkelMvMjVqRFdXUThudXNsOXlibjRIMkJ3OU1RYzJxaG4rdFRr?=
 =?utf-8?B?U0hPNGtCbXVweWRzcEdmUFI1N2pqSkhBNFBFR0tNemloR3huQmpDZEpFRjdW?=
 =?utf-8?B?d0ROK1p5MWZPZkI3RDNzMDhKYmhVbjlIYi9oTW1hVXlwRm5mLzFhQXFZUExm?=
 =?utf-8?B?V25OTHJyNFB3RkczblpwbXVjUk5ZaEF0WmVNR1dxVWMrUSswU0JYTFV4NjZ2?=
 =?utf-8?B?SFJSVWR1aFJtbENwc1Myb2JQcURsdHU4V1NrVXFDYms2QjRJQitFMnRzNGVD?=
 =?utf-8?B?MGlsZ2dsK1dQNDdGTVZWRnR1V3o4ajE1Umgvc2QxM3RMM0ZkTFVvN1llcmF6?=
 =?utf-8?B?YytvOE5DNVNtT0Y2WlFSSzJoK0tHczNXYnJZZi9kRmd3UkptVkFjcExIYmNJ?=
 =?utf-8?B?THRBQjBiekt1N0J3TUJISWZ4OWo0UTZiUWlrUnN1dUY2UGJ1cno0b1JXaUVB?=
 =?utf-8?B?K2RMOUNqWXQ1TUpyZXpTQ3ZUb1N4WmtwbSt1RjRRY2dmMlVjRno5WHA2aWdK?=
 =?utf-8?B?RUFxYVpVWUo5bkJtbmIzdTFyTUp5L3BNQytCcGYxejdlL21NSGFJSlhSaVVM?=
 =?utf-8?B?UHVrWWZWS2pEclIrNnBGWFRBczVGengwdjlDb0swNFpyS1ZvYVNnT0JoR3dD?=
 =?utf-8?B?UmR1OW85SWtKSjN6aENYZ25aNVEvY1JZU0tLOHJKNUU0L253dTNlM01GcExx?=
 =?utf-8?B?SWw4R1VDWUJGUlZrbUc4MXlhaDFoZ3hvTngrYWR0V0kwQ0NzN3E1MkRDYmJq?=
 =?utf-8?B?eWFzWko0VkdKSURGYlQ1Z2U0anhWWUdwMFhzKzFaTzV5NzREeGZNcXhTTXo5?=
 =?utf-8?B?SWZ6ZExzbjNFQWxyZkNBWFd2aFdMMmtKYWVheUZ3VXVQUjRPd3B5K1hkQ0g5?=
 =?utf-8?B?MFJ2MEhOTC9kY3lrRG1HZkxIT1hKU3piY3k2ZTNwQ3Qyc1VVNDdJdTloZzhw?=
 =?utf-8?B?dG9hTUNqeGxCUUEyK0Fqa21ONitnc3hXYmdEWVprNWZGUVhJUUdqUkZTNU84?=
 =?utf-8?B?OEIyMUdxSllwQmI2N0pXdDdkSGE3cDh3RDZvRmJIOG00cWd4TFI2czFRMlBZ?=
 =?utf-8?B?SG1tS0FNQ1pONjRhTm1keTJrbjEybm8vcnF2Z042dndOWUcvQi9LSGQ1NTRX?=
 =?utf-8?B?V1grZnZpeUttbjE0bmQyamlNTFdoaTVUTHUwaU5JVG55WlJhcm5hbFhya0lJ?=
 =?utf-8?B?YnpseVFFS3RyekJ3OWRPdW4yQ1FhWlBZTU9obVljeHF1bk9RN2VEQW1YQjky?=
 =?utf-8?B?RDRjNVBUaWxsRitPR1RMeklaVW4ycmkySjZDNjJ3dmNLKzRmNklVbXBFQnpY?=
 =?utf-8?B?RjFZRXRwUFNQVSsrT2pZYUxSVHJzM01MUGJIVm9xU1REN2wzK0VQdHlBYXBL?=
 =?utf-8?Q?YgrsidOj/INWpQk4sPj+WeTQZU2V1R3UY/P5E9ISO0zU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4930.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 579b44d4-5dfe-4415-8570-08dae829a762
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 16:44:42.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +itkGNOP4tgOzCBDiFcwkNfJmE55WCwg3TPWHRV6WnHw8iukQNGJwIxkADE6vxRgIrpTiB4S8mduvKnWdsLaVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7517
X-Proofpoint-GUID: hx5YoGW2Zi5UoWHdXRpRK2q_tWbQV7N5
X-Proofpoint-ORIG-GUID: hx5YoGW2Zi5UoWHdXRpRK2q_tWbQV7N5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_11,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=688 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDI3LCAy
MDIyIDk6MTMgUE0NCj4gVG86IFJhbWVzaGt1bWFyIFN1bmRhcmFtIChRVUlDKSA8cXVpY19yYW1l
c3NAcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gd2lmaTogbWFjODAyMTE6IEFsbG93IE5TUyBjaGFuZ2Ugb25s
eSB1cCB0byBjYXBhYmlsaXR5DQo+IA0KPiBPbiBUdWUsIDIwMjItMTItMjcgYXQgMDg6MDQgKzAw
MDAsIFJhbWVzaGt1bWFyIFN1bmRhcmFtIChRVUlDKSB3cm90ZToNCj4gPiA+DQo+ID4gPiA+ICsJ
CWlmIChuc3MgPD0gbGlua19zdGEtPnB1Yi0+cnhfbnNzKSB7DQo+ID4gPiA+ICsJCQlsaW5rX3N0
YS0+cHViLT5yeF9uc3MgPSBuc3M7DQo+ID4gPg0KPiA+ID4gVGhhdCwgaG93ZXZlciwgZG9lc24n
dCBzZWVtIHJpZ2h0LiBJdCBtZWFucyB0aGF0IHlvdSBjYW4gb25seSBldmVyDQo+ID4gPiByZWR1
Y2UgdGhlIFJYIE5TUywgbm90IHN3aXRjaCBpdCBhcm91bmQgd2l0aGluIHRoZSBvcmlnaW5hbGx5
DQo+ID4gPiBuZWdvdGlhdGVkIHJhbmdlLg0KPiA+ID4NCj4gPiBOb3Qgc3VyZSBpZiBJIHVuZGVy
c3Rvb2QgeW91IGNvbW1lbnQuDQo+ID4gV2UgcmVzZXQgU3RhJ3MgcnhfbnNzDQo+IA0KPiBJIGRv
bid0IHNlZSB3aGVyZSBpdCdzIGJlaW5nIHJlc2V0Pw0KPiANCj4gVGhlIHdheSBJJ20gcmVhZGlu
ZyB0aGlzLCB5b3UgY2hlY2sgbnNzPD1yeF9uc3MgYW5kIHRoZW4gc2V0IHJ4X25zcz1uc3MuDQo+
IEkgZGlkbid0IHNlZSBhbnkgY29kZSB0aGF0IHNldHMgcnhfbnNzIGhpZ2hlciwgYnV0IG1heWJl
IEkgbWlzc2VkIGl0Pw0KPiANCisJCWN1cl9uc3MgPSBsaW5rX3N0YS0+cHViLT5yeF9uc3M7DQor
CQlsaW5rX3N0YS0+cHViLT5yeF9uc3MgPSAwOw0KKwkJaWVlZTgwMjExX3N0YV9zZXRfcnhfbnNz
KGxpbmtfc3RhKTsNCkhlcmUgd2UgdGFrZSBjb3B5IG9mIGN1cnJlbnQgcnhfbnNzIG9mIFNUQSAo
dGhhdCBzZW50IHRoZSBWSFQgT3AuIG1vZGUgbm90aWYgZnJhbWUgdG8gQVApLCByZXNldCBpdCBh
bmQgY2FsbA0KaWVlZTgwMjExX3N0YV9zZXRfcnhfbnNzKCkgd2hpY2ggd2lsbCBzZXQgbGlua19z
dGEtPnB1Yi0+cnhfbnNzIHRvIE1heCBuc3MgdGhhdCB3YXMgY2FwcGVkIGFuZCANCnN0b3JlZCBm
b3IgdGhpcyBTVEEgZHVyaW5nIGFzc29jaWF0aW9uLg0KSGVuY2UgQmVsb3cgY2hlY2sgd2lsbCBh
bGxvdyBhbiBuc3MgY2hhbmdlIHVudGlsIG1heF9uc3MgYXQgYW55IHBvaW50Lg0KKwkJaWYgKG5z
cyA8PSBsaW5rX3N0YS0+cHViLT5yeF9uc3MpIHsNCisJCQlsaW5rX3N0YS0+cHViLT5yeF9uc3Mg
PSBuc3M7DQoNCj4gU28gaWYgc2F5IHJ4X25zcyBpcyA0LCBhbmQgbnNzIGlzIDIsIHRoZW4gd2Ug
c2V0IHJ4X25zcyB0byAyLiBCdXQgbm93IGlmIHRoZSBBUA0KPiB3YW50cyB0byBzd2l0Y2ggYmFj
ayB0byA0LCBuc3Mgd2lsbCBiZSA0LCByeF9uc3Mgd2lsbCBiZSAyLCBhbmQgdGhlIGNoYW5nZSBp
cw0KPiBpZ25vcmVkLCBubz8NCj4gDQo+IGpvaGFubmVzDQo=
