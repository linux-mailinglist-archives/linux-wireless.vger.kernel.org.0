Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C065681C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Dec 2022 09:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiL0IEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Dec 2022 03:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiL0IEV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Dec 2022 03:04:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315BB114F
        for <linux-wireless@vger.kernel.org>; Tue, 27 Dec 2022 00:04:20 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR6URo2021808;
        Tue, 27 Dec 2022 08:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=mkQZVzuB1DCd5pAyOYwq8YPY23l/HNAslh9d0r45ACc=;
 b=O2KxihezSJB7ZtcI/ABHv3k7j/PAZtkJz0AV1+HUf5T/vlDTAvHZl0ef9UVg/t42ElqF
 zOFnd/ObKhv7bjeapRI+nDcpA1YZWYVufM4nlAZUQmwySTVAWzhuVnlJVLZUva0tRg6Q
 5zxEnX14PshKvW1gv4XYsmEaM1AUQw+ps9wGPQc2HqOUzRPNlGWLoksdqeMOQ0WwiSJ1
 0PMF7/Q+bGZUF0z4AhTYpUpYRbWqXKzWnofX6BfdMMnCe/IXDgFrOkcLlb4fk5I7A3a3
 dKczaTRxLX26PdscuawSYY+3fZKngZkdzf9Br0SMAIqjnfwLjk9jGt70UnKObZk3jlP8 oA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mnq4qv8ba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Dec 2022 08:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wi32SQRopL2f83w1JqsGaC3Jbatrx9uWrSc9ssp8NgVsORoQEj8FqxajR7VdvR94nUZQlPMEcO2oFIFXupUMG8X+pIiKj1UhOKumyccd7XisnuEV/0bxGWnMADqg3dFplha3NOyD3umAGsXfFZVgny2PQC/6tS1TVjyVhxdMabEYDXA2b+e07aRZY7fOblN4vhii+PmfbivrNojNXWZvH6oWdrB5RaNCqecyVO/yilfZ0Ykp1rPpS7hsIAzI7hPgqWXvWFbzpWIRMzI6xDGXLivClRWtn8x/LCCzhcCD+SYkDkuhk/GVM4w1ivKFKsV3MW4FKy8/pva1l3/ayb5pCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkQZVzuB1DCd5pAyOYwq8YPY23l/HNAslh9d0r45ACc=;
 b=hecSbmK5Krq9wo3zPBpDbvINmkobOaLnsKcCh+45XFWQV5Vg8qTLSEMOYjt683fjGwm3dsc9XpE6VkBKfPH0rKt7Bn5lOIT9RmVUmWBKc64ppUApFeC+4RVK6j+ZLej0x6HWhlS9j6J1U/JNjKf/J1rfv1kR37Qo8VdgscNhtdJwqMxF3nfp2ysRMqwAuAGOoNLySk5DBOm0Xsd50uu7224VEPhmtz+8ELBI3PFh5IMOF/mNrWo5b6bVTWpivJbgbEYGwiVZSBFwlcJbB5znW742qdLm/N+wLIm/hd+URuuWjp/anMfgQsa5okstPjOOYl6m9FOX+gJotQQse2qpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4937.namprd02.prod.outlook.com (2603:10b6:5:1a::16) by
 DM8PR02MB8007.namprd02.prod.outlook.com (2603:10b6:8:18::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.16; Tue, 27 Dec 2022 08:04:14 +0000
Received: from DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6ed6:d20d:c1a:e391]) by DM6PR02MB4937.namprd02.prod.outlook.com
 ([fe80::6ed6:d20d:c1a:e391%4]) with mapi id 15.20.5944.006; Tue, 27 Dec 2022
 08:04:13 +0000
From:   "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: Allow NSS change only up to capability
Thread-Topic: [PATCH] wifi: mac80211: Allow NSS change only up to capability
Thread-Index: AQHY4qw8zeNm6c+9jkG2F/Ykv474hq4ZNGyAgGiWJqA=
Date:   Tue, 27 Dec 2022 08:04:13 +0000
Message-ID: <DM6PR02MB4937DDAF64A4880FD81C11CDE9ED9@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <20221018044341.5453-1-quic_ramess@quicinc.com>
 <b763a390dedff804015a540f097bf804ed0e1436.camel@sipsolutions.net>
In-Reply-To: <b763a390dedff804015a540f097bf804ed0e1436.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR02MB4937:EE_|DM8PR02MB8007:EE_
x-ms-office365-filtering-correlation-id: 76a435a9-049a-4fa6-933e-08dae7e0f1a6
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fpwub/GB9HG6oJSjgTkSdAaKY96qFK+GcdLTB85NSaNyKI+B3waTyIH/NDBUdaeDp5mALNmMffhFFtaw4tYxF2jwWCGItxjnScmoj9t6QClYf8Ck3yKUsIUPF6zlRR32RE3hj8ZGWmtXTORpnzzkray1YC7JZzZWj3DTjAEHKEU85ncvrtoozbTJDgtHJVfz1nvZruWkAC99/kbvwLNT0To4wP8FJfEFpDLN7qxzibrAdrnvSIZB7M5zmdOock7JzuFJ1j7mirURH0vlRqZfoSQWsqOLQlWYCZb4CCksUir/SB8m0Zsu133wLGe144LDKuQ1w9YM9+feNHcu4GfNoe1CCSbgOsR7tCwbw8pu7rlL+bN6ZewZKAbZUe7/Dwr9PZG4/wNN4LmqMF1WaPNXlFEo29SNtL5yzDJ1saZ0R9N/YheTku2H6JxUQKDCERc8b4Bh8wQwbD0GEXEgPcNhtgCxLU4I3tRQqFIGYd5GHHHCx+BjLixRvI5P3wE45NOhlrgARqfl3YSNUECtaiDAfKyoIHug0gfE+NEOfKuptvWan5bN0UwLw4WB64kFMTWE1a4lkw81WpBTT56TdTxbHsp1PpLiZpQxHW00PMoX4gud/hGzdS423Wv1lIhc3XIZrOmbJPfz0bEZ4k+ZmKjPmOtFNVsoOUXpl5+d6q5Q6S2hKmG91v3vTN7QJJIRT0ltbY7OI4CKOHH1Oe3msdmuew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4937.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199015)(83380400001)(86362001)(38100700002)(38070700005)(8936002)(122000001)(2906002)(4001150100001)(5660300002)(52536014)(41300700001)(55016003)(478600001)(7696005)(6506007)(186003)(76116006)(26005)(53546011)(9686003)(8676002)(4326008)(64756008)(316002)(71200400001)(66446008)(66946007)(110136005)(66556008)(66476007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDh5ZWdWRHZJc2N2RzFrR0gwL1lMcjFhMW0yM0hJSnIxVUsyMXQxYVFMSWd5?=
 =?utf-8?B?elZNM2w5Y1d1S1Bpamp3c2dmalR3ZGxJR0x2RG5tclpiVis1bWJDWDRHUzF0?=
 =?utf-8?B?YkxIdnJDUFQ4a2FyZDdLRFJBS2kwZUxJMHJCZE5DZ01YMG9uTEhQRmVFYXVy?=
 =?utf-8?B?bkVJZnd0TDkvSDBQTGVMeGkvME51aFI5RnZVdklIMUpodmdGUFRRM3BHanpE?=
 =?utf-8?B?RFpad3NlK1dxWFZmcVZJSk5BaWZSWHUwbzg0RUJjRHhnNXpVR1cyVUt2bDZC?=
 =?utf-8?B?WUs2bnRYVHE1a0hkSHRrN3B0ZDZDQ0V4azQ5b3N3aDY4NEphaXFobWlzeWhi?=
 =?utf-8?B?aXQ2Z0hFZDF1ZmIxbnlsUjJQSVk4a2JiaXd4WXM5TGFYZDlTbXhHT1BZdS9v?=
 =?utf-8?B?alJlYndTV0hHMUNYNHZHZXRDdHUzdkFKYlVKUnl4NDc3TlhvWWp5RVZEckc4?=
 =?utf-8?B?eURiSnpoWUFDaGR0aUlOcFVKaWhzTVR6MzlReVpqeGdHZE1KZkltMzZtV0VL?=
 =?utf-8?B?NWpLNkxyaW9SU3FKMXU0ckJTMU1LS3gvcUVBMElYNGtrL2J0dnJzam9peEJn?=
 =?utf-8?B?SzU2NDZjMk5QNTY0emhjSFhjNVMzUmJmU2w5V0ZoeHBVWUlSdXJuSmw2aW5I?=
 =?utf-8?B?TGtMN3ZKRjkrTXNBeHY4WE92TVZLelVZYmErejQ2MS8xeFNid0lYNlFieVlz?=
 =?utf-8?B?c0J4L3huSENyY3E4K3dPTXhaZkhQVkVnbnZzM1gxeWhOM1BLbHlYRnRqZy9r?=
 =?utf-8?B?MFFwdFZpY09QcUxyb1IrOEU0Q2RLek9jRUg2WkxXMVNQeVNxeFIvdmJyL1dL?=
 =?utf-8?B?TWtoaEptN21HVDJNSTNyOXg0ZFN4WXd3a0JXdlJSSm8wckppZExYdDFPMWpO?=
 =?utf-8?B?U0hoSUM0WDVoNkxxeFU0bjA3dE4zQjdpWFhQcHQwQStsckdtMURLOXY4Y3gy?=
 =?utf-8?B?UTZPSTdwM2RrMTNpUHQ0WkFEY1F5UUNDUytia1FqVHA0ZzVUN1cycGRUd3g2?=
 =?utf-8?B?Z0NuYmtxeFFCODlGQzRFUk1PY0IvTW1CZmJabGhpWExrMjJqeHh6UWpJSERU?=
 =?utf-8?B?T0hhZ254WkN4MVBaa3FENC9LOHRMZ1dwQ1BwTk11S29RNlhIcXRIRGxLcWxR?=
 =?utf-8?B?RDBNUmlsdlpKYnhFdGNoQTh0ZithMlc0K24zaStYN2M5NGhlelpXaUptcnBp?=
 =?utf-8?B?WTVzUUVZTHJvSWJmL2Rmbk1SYmk1MngrSDZCRU80bXFNNGtGTCtaVmpUOWpL?=
 =?utf-8?B?eW5QTFNjNmh0TklwZXE5dXpwTlZGSTR2aTlHRVBjS3p0TzdsUThKNUsza1Q0?=
 =?utf-8?B?SnF2N1d6TnNoNHVMYjc1M3hEZCs5cEhLaVhUWUhDMzRKSGVKZWZtOGlweDVG?=
 =?utf-8?B?WHE5bkh0ZldLZkdXb1FQNDBSd2lJd0hhOFEzTUFKYU5kMHR3Y2tNMENQTEpI?=
 =?utf-8?B?K1ppcTZDZWRhTXVESHEyRzZxWlgrNmdxTHltY09GazNvWVR2Q2JHbWlwcGYv?=
 =?utf-8?B?NFprS1czUnd5M2NOVEhhRUZBSzJuOE1uaENhcWtnYXhQR1JSODFwOHZ4Y2NF?=
 =?utf-8?B?bTNSU09OL2Z5RldVa1lVZzZrNitNaWoyTEszWjlmeXV3TTYxb0VuQlgzTUZa?=
 =?utf-8?B?ak1IZzZtNFhxUlVlc0djdFZ4RDVjVnVTS3dpV0wrbTBLYmp0akovRlBENjl5?=
 =?utf-8?B?S0hIb1YvbFFua0h5c3NPS3M2S1VWMUkwYzdYOWZrV2JkOTNDYWRkbkdyS1c1?=
 =?utf-8?B?Q1VRMFVPdElLcjg1TkVsc3lNcVdPWG1zVXJLOHFrT2pyaU9HTy9GdWhpdDNy?=
 =?utf-8?B?aWJuR1R4U1RpNWRZQVduSDhUbWkyeThLMjFQWVNjQ0lSeEd2Kyt3eDB3VGs4?=
 =?utf-8?B?ODBGalF1VnJndndKbUZsSEVKN3kzNGtua01kVld2dVQ0Sk8zaXF1VFFsNm9k?=
 =?utf-8?B?RmU5TG13ZW14UGVnS2w5YVhVS1FCS21uMVVnKzhYUnlhSSsySjJtSkhvY1JI?=
 =?utf-8?B?Sms1VE9YTnpoNDZGOXNwVkx5K0xxZDhDbDBJU090eHZmTVY2ZXVDbGpwc2w5?=
 =?utf-8?B?ZzgvNXVwR2ZxMnhaNHZZTHBKWW9tQ0daUGJDQks5S085Q2JIbm50dTFwSTYz?=
 =?utf-8?Q?T121IQ8bYylnyFl3DVdyjorPe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4937.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a435a9-049a-4fa6-933e-08dae7e0f1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2022 08:04:13.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbOJOhB4tJR1tiqQ5PsmnBJq/+cCW2jbsw1tmOvOtRhkb29QWvcSwGwSDL2SWa/uyPK/5sE23JfGAFsfjzxaTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8007
X-Proofpoint-GUID: 3dy71Gdhv3aH7AMHFZIyWZNo2IvmwTyi
X-Proofpoint-ORIG-GUID: 3dy71Gdhv3aH7AMHFZIyWZNo2IvmwTyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_04,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=541 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270066
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hh
bm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMjEsIDIwMjIg
NToxMyBQTQ0KPiBUbzogUmFtZXNoa3VtYXIgU3VuZGFyYW0gKFFVSUMpIDxxdWljX3JhbWVzc0Bx
dWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSB3aWZpOiBtYWM4MDIxMTogQWxsb3cgTlNTIGNoYW5nZSBvbmx5IHVw
IHRvIGNhcGFiaWxpdHkNCj4gDQo+IE9uIFR1ZSwgMjAyMi0xMC0xOCBhdCAxMDoxMyArMDUzMCwg
UmFtZXNoa3VtYXIgU3VuZGFyYW0gd3JvdGU6DQo+ID4gU3RhdGlvbnMgY2FuIHVwZGF0ZSBiYW5k
d2lkdGgvTlNTIGNoYW5nZSBpbiBWSFQgYWN0aW9uIGZyYW1lIHdpdGgNCj4gPiBhY3Rpb24gdHlw
ZSBPcGVyYXRpbmcgTW9kZSBOb3RpZmljYXRpb24uDQo+ID4gKElFRUUgU3RkIDgwMi4xMS0yMDIw
IC0gOS40LjEuNTMgT3BlcmF0aW5nIE1vZGUgZmllbGQpDQo+ID4NCj4gPiBGb3IgT3BlcmF0aW5n
IE1vZGUgTm90aWZpY2F0aW9uLCBhbiBSWCBOU1MgY2hhbmdlIHRvIGEgdmFsdWUgZ3JlYXRlcg0K
PiA+IHRoYW4gQVAncyBtYXhpbXVtIE5TUyBzaG91bGQgbm90IGJlIGFsbG93ZWQuDQo+ID4gSGVu
Y2UgYWxsb3cgTlNTIGNoYW5nZSBvbmx5IHVwIHRvIG1heGltdW0gTlNTIHRoYXQgaXMgbmVnb3Rp
YXRlZCBhbmQNCj4gPiBjYXBwZWQgdG8gQVAncyBjYXBhYmlsaXR5IGR1cmluZyBhc3NvY2lhdGlv
bi4NCj4gDQo+IFRoYXQgc2VlbXMgcmVhc29uYWJsZS4gTWlnaHQgYmUgd29ydGggbm90aW5nIGlu
IGEgY29tbWVudCBpbiB0aGUgY29kZQ0KPiB3aGljaCBBUCBoYXMgc3VjaCBidWdzIHRob3VnaCwg
anVzdCBzbyB3ZSBrbm93IGl0IGxhdGVyLg0KPiANClRoZXNlIGFyZSBmb3VuZCBkdXJpbmcgZnV6
eiB0ZXN0aW5nIGJ5IGZvcmNlZnVsbHkgc2VuZGluZyBWSFQgT3AuIG1vZGUgbm90aWYuIGZyYW1l
cyBmcm9tIFNUQSB3aXRoDQpSYW5kb20gcnhfbnNzIHZhbHVlcy4gV2UgYWNjZXB0ZWQgYWxsIHRo
ZSB2YWx1ZXMuDQoNCj4gPiAgCWlmIChsaW5rX3N0YS0+cHViLT5yeF9uc3MgIT0gbnNzKSB7DQo+
ID4gLQkJbGlua19zdGEtPnB1Yi0+cnhfbnNzID0gbnNzOw0KPiA+IC0JCXN0YV9vcG1vZGUucnhf
bnNzID0gbnNzOw0KPiA+IC0JCWNoYW5nZWQgfD0gSUVFRTgwMjExX1JDX05TU19DSEFOR0VEOw0K
PiA+IC0JCXN0YV9vcG1vZGUuY2hhbmdlZCB8PSBTVEFfT1BNT0RFX05fU1NfQ0hBTkdFRDsNCj4g
PiArCQljdXJfbnNzID0gbGlua19zdGEtPnB1Yi0+cnhfbnNzOw0KPiA+ICsJCWxpbmtfc3RhLT5w
dWItPnJ4X25zcyA9IDA7DQo+ID4gKwkJaWVlZTgwMjExX3N0YV9zZXRfcnhfbnNzKGxpbmtfc3Rh
KTsNCj4gPiArCQkvKiBEbyBub3QgYWxsb3cgYW4gbnNzIGNoYW5nZSB0byByeF9uc3MgZ3JlYXRl
ciB0aGFuDQo+IG1heF9uc3MNCj4gPiArCQkgKiBuZWdvdGlhdGVkIGFuZCBjYXBwZWQgdG8gQVBz
IGNhcGFiaWxpdHkgZHVyaW5nDQo+IGFzc29jaWF0aW9uLg0KPiA+ICsJCSAqLw0KPiA+ICsJCWlm
IChuc3MgPD0gbGlua19zdGEtPnB1Yi0+cnhfbnNzKSB7DQo+ID4gKwkJCWxpbmtfc3RhLT5wdWIt
PnJ4X25zcyA9IG5zczsNCj4gDQo+IFRoYXQsIGhvd2V2ZXIsIGRvZXNuJ3Qgc2VlbSByaWdodC4g
SXQgbWVhbnMgdGhhdCB5b3UgY2FuIG9ubHkgZXZlciByZWR1Y2UNCj4gdGhlIFJYIE5TUywgbm90
IHN3aXRjaCBpdCBhcm91bmQgd2l0aGluIHRoZSBvcmlnaW5hbGx5IG5lZ290aWF0ZWQgcmFuZ2Uu
DQo+IA0KTm90IHN1cmUgaWYgSSB1bmRlcnN0b29kIHlvdSBjb21tZW50Lg0KV2UgcmVzZXQgU3Rh
J3MgcnhfbnNzIGFuZCBtYWtlIGEgY2FsbCB0byBpZWVlODAyMTFfc3RhX3NldF9yeF9uc3MoKSB3
aGljaCB3aWxsIHNldCB0aGUgc2FtZSB0byBtYXggbnNzIG5lZ290aWF0ZWQsIHNvIHRoaXMNCldp
bGwgYWxsb3cgYW55IG5zcyBjaGFuZ2Ugd2l0aGluIG5lZ290aWF0ZWQgcmFuZ2UsIGlzbuKAmXQg
aXQgPw0KDQo+IGpvaGFubmVzDQo=
