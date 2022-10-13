Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAA85FD458
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Oct 2022 07:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJMFzL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Oct 2022 01:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJMFzG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Oct 2022 01:55:06 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054EB3FEE4
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 22:55:03 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29D5fEUk012866;
        Thu, 13 Oct 2022 05:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=b3YRSYJWbpBoe5ZatNdK25TjQXx0X75Y6KT+y1Tw/aA=;
 b=a0pvM3K8wYzS4UyRcVAytBh5qZ1L8xHcBs+y8yp9M1sNcaOu1SGMGYlnsC1XqCYQ8a06
 cIiTPfE5y7jUesaTkI5A9FG/BQ8ulAtUl/F4nP2JMabXl1399hvwQ3dEIrRHFpIV9tId
 ivo5kwy+hP/L0rF1oZHC+MSwIMGjIBRtGdTUyY6v4a2xz1dYWNkaDMOoSCzc+MLomHpC
 b2871YRfH0CtLm514jBLVo6N9Ju8cQ2IMSmzL/eBS7+G/4tEG4Z+655uuC3K1E8BBmLg
 Uv2YUrQO+eEcdzxpnu4K37/LOQDMwTDn5CazOwpEPXpcAcjY/wHP7YaPemLWDDxMbtJJ cQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k66xjrwfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 05:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnwqQcnLOKuUjpCfg6yM3PKCmVmm78hPfTyhkkYwV53LrmWh2muw9aqeEFnWQRtKR28KcQHy+yXvpqKE73kaw6j64vnKDlKDJqF9o5X/Fgf6RIEZ1Kxc4drA9uct7d4XJtzo0PsmVgI5i5F0ie4uRqXwy94e9QwLsrFmL7n9hCT8sKxEGj30Hf+k0VXvAj8b+GS4B0C6UnTkOtya5J5OCPSav1bhapJG9D5PZsFbb4vPxjgsffH13OylANy4UkHJkqR7JwVKRdxkpynAkUvK9pMx/DIQ2qJVUA3GkEvMnSvEulYyaELR6klTG2r/Bc32kK9cJvScpeK1EO2Qhr6x5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3YRSYJWbpBoe5ZatNdK25TjQXx0X75Y6KT+y1Tw/aA=;
 b=bU+I+dWYPU8UVAd7Dta+rlxas8q1VWlXPcDCtCit1yHdd5kMnz8umgp2rWMm8QF9a2eMGchlj49HWXadpFHG6dUTu658ZbaK5DsMm9WIrl835RGu5VvAc+4CY8teIcC+BvpUsd+cZjm9Yj3HLD4SsBLH5soWZixkZ2Y7jysnZVDsc/QbjemfQh2fh2fxKw9jvUQacJuKwOrTHLu6CuZYAU8C3G055VKuPOodrS+GN22iN8s8rmooXkV+mhCAk7W0TVQj5kEP3ZrNa4gWIUsgQX9D4BKzru01j9nmRWMDKaSGGi68mM1atPka3dwpNmi3SLpy/KhgtJbe07hWlhC/6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4334.namprd02.prod.outlook.com (2603:10b6:805:ac::20)
 by DM6PR02MB6541.namprd02.prod.outlook.com (2603:10b6:5:20b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Thu, 13 Oct
 2022 05:54:55 +0000
Received: from SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc]) by SN6PR02MB4334.namprd02.prod.outlook.com
 ([fe80::8bd9:bdd5:901e:3afc%2]) with mapi id 15.20.5709.021; Thu, 13 Oct 2022
 05:54:55 +0000
From:   "Sriram R (QUIC)" <quic_srirrama@quicinc.com>
To:     "Jeff Johnson (QUIC)" <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: RE: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Topic: [PATCH 15/50] wifi: ath12k: add dp_rx.c
Thread-Index: AQHYrmYbHK9N0DA8vkGURLObKZSNEa2zws4AgFhwA1A=
Date:   Thu, 13 Oct 2022 05:54:54 +0000
Message-ID: <SN6PR02MB4334C052EA71CD13F0506E55F7259@SN6PR02MB4334.namprd02.prod.outlook.com>
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
x-ms-traffictypediagnostic: SN6PR02MB4334:EE_|DM6PR02MB6541:EE_
x-ms-office365-filtering-correlation-id: 7b71a00a-aaa6-4935-5dc5-08daacdf73fc
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XZbYFUjSRFVl4XayasaOjCOFhoD1FPLTlqrR3mP5UNk0IDnEJfwuvQOOT+6yPJI12L4HMEPbTmdgAXNMYjJfOJwkqWOpzhOh6adk5MuU2H1X6WQfAtAF4IqEujNGZVPmOcixBA7rRfih1KZ3qs3q0QO8vzH28sQZZiOFJXGmtbMVbx06iElnMdlOy23T9Oa3FNbKQjBR3GeYzn44laV7k9JwtWVekjc9xZ1DzAbXoCeiqNYVRjCBZsZRwB27Hyg+xO4wAQVNWNYV4Pn8EEZ5qOTBwTrfArst/YmuzrsPm43P6MmCp1c2gKJxey7HWikEUu1lO33xqTqKFifv+VTZ6xP1eWXLW61CUZyrsfP3bvtY7+/T8ykD0BPKuTsLrFzSU/MRsbMAgGGcI8op4ceGJIZFi4Le8O51lUSOfhGBmMsAD2ZgJHqINzMjoQbrRh2NKjassGm0Iqa6TF702RY9MjfThspuinmmcJ88IA6WbuPNNEcGaInsmN47tcTaPiOcSLHDtEOfCNKktcGp0kX457wm2aAQyekRbs9EdApso2F02CBSlPoTdKhfFXYyP654Vho0KtncIfNHP471sx2R4hvVSBT6tcYIeFitRn4K5p2Q/kCXcTMt2wNdXaaVG+PfrIU1o//lziUIw4bGwKb9XvahDl5/BkGbhK1zW6uF3kE1x51dUiEF72FBB9BVXoKQfLTo6N6GV50cwKxtRbQX1l3VlkF2p/dYJ1tQrU+FMaZipGUSXW/qgXO2eePYIGU5Clx3iB+RkDUawewzQKK+AA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4334.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(451199015)(316002)(5660300002)(7696005)(6506007)(4326008)(8676002)(66556008)(66946007)(76116006)(64756008)(41300700001)(66476007)(8936002)(9686003)(52536014)(26005)(38100700002)(122000001)(38070700005)(55016003)(2906002)(33656002)(186003)(86362001)(83380400001)(66446008)(478600001)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFlXam93TlUvbnpkTVJhUHdUdnorTkIvQmtJOUlSZ1JEeFlQWE5FSE9MVXV0?=
 =?utf-8?B?ME13bkYvYzN5aVdtYUxiNG83WXpLY0NqRWFnNkkxOE1SN0hYSjhIalB0ZkpM?=
 =?utf-8?B?WkhHT2dLTjhIY2N5U0Z3VklWRm1ESkZiZ0JhYW1Gd1hJVXpUOXZJZ3BxMnYy?=
 =?utf-8?B?ZXN3SUJ2SnNLd2IwSzVkNExkalRWVlBYYlFpRi9Ub3JuRVZVK2E5dzhQS0hK?=
 =?utf-8?B?eWhHOUdLOUY3RjZPa1BaWjhNWjcrbUhPU3ZWcm1vY21JV0JObU9hejJRaFc2?=
 =?utf-8?B?QytPb0VNSDFkWkdsRnZmN05MOXNhbmpLeXJtTW94ZnI1L1Rwc0c1QVhDY0hD?=
 =?utf-8?B?SUIzVkR0QU92a0VCYXgzckhVcSttSm0xNnpqbklCTnB2eVNsZWJ0NVVSeDR2?=
 =?utf-8?B?ejRLWHltV1JtOGFoZjRhV1U1L0pBZSs4MVk0WCsyclB4SGswN0tCSnF1WVZB?=
 =?utf-8?B?QkZ0a0Q2U2dZWXhGLzB3MEdWcnA4ck5ZeXlIRndwL1RYaEN1V09BTDNoRHpm?=
 =?utf-8?B?QytHLzF5dStDTUJpZGN4enhhcU1vek94QmNWZng0TXlOWlUxM052SlM2OWg2?=
 =?utf-8?B?VXFPZC9tQ2hXSU0xNVdZSzhNSkFWUjcwUXB4a3ZUaSthTDg1N1Q0bUEvclla?=
 =?utf-8?B?NFJxcUlBUkd4b0xmN2k3c0xGUVBwUVkvbDJnTGNqUDNDWXF0U2Q4anBzSFE3?=
 =?utf-8?B?R0dWNWpuUEtteXJXOVVQVXE2Q200SS9CYjQvNW9yNHluNXBSWUJEV3k1S3Zn?=
 =?utf-8?B?Yk5KaDlVQ05pdDFkek1RR1RrbUM4aDhLYjZVLzM5c0pvVVlNd0dVbWhudUlo?=
 =?utf-8?B?Q0dIVW90ZDN3NTRxbEY2YXFKdm1aU3krMm04WGFMMzZmQndOd0JrWEhPelB2?=
 =?utf-8?B?WWUxcEw3V0JnbHRIUVVUMkNzUnJUOGdreFFPaEs5cnJTdmNMdVNIMDBSQTJW?=
 =?utf-8?B?TGZaWVJwNHpzYlhGUkRDTDJBNXhQemp3ZldJTUR6MWVKb092SFFaSklURksw?=
 =?utf-8?B?Q1pVVzNqeWl4TDZSYkVUbVZyZ1JlQUN0RnpybXdEZWNzVTV0ZEozOFNoRC9l?=
 =?utf-8?B?VTNkMkp2SkQ3dTNJR1QrWnNncGU2aG8veDJ4SVZXVXQwRWF0Vm9rNk0rb3BP?=
 =?utf-8?B?RmI2WjY0Y3dDRVhxZnJHKzMxYU11RTEvTVJRY3ZwRE83YzdSc3JYM0J1aWNF?=
 =?utf-8?B?YmJsWWIvVzR4ZnRBcFlGbXRhZ041Y3RuVHRDeldZeTlFZ0tDSHJWVTJNZmx4?=
 =?utf-8?B?aWJpR3ZzVzRwSWEvSFBIRGNuZlMwWDhGWGZVWXRkUGgxcHBDTy9lcHloNlhp?=
 =?utf-8?B?YTZxeWU5OUVQUkw5N09xN3V2Tnd2WlQ3ZjFybjVyUlVFVVcrNUlDb1FDZVpm?=
 =?utf-8?B?QStsYmY4ZEYzcDhPQjY1QzJpYjBFREdPeGQrdWRtTmRCaUsxeUhzVEV5M1dv?=
 =?utf-8?B?aXFybEc0MHNMb0p0M05iRXNBbkhzOXZDTGQ5aHBNL2JOdTlkK1JUS0tWUWIx?=
 =?utf-8?B?STFXTFVpZURsd3JkWEVYZmovc1dJeGxYVHNLRkdKOUNmVUh6SEd5U2pSMXRN?=
 =?utf-8?B?TzA3WEIrRllpR0dDKzhYbDc0b1RzQlVZbmlBbWVMK01nN0Y1STZUTmJ4aXFT?=
 =?utf-8?B?bDR1dG04OFZLZEttMjZ3dThSSEdwS0J1a01CQkpDaUdCK2RVRWM1WkZzY1Rw?=
 =?utf-8?B?M3dSbDBRaGdNMFBkWktqZlF0SExBNWlFSWNmOTFMUmpZY1J6M1ZpTndhbjJl?=
 =?utf-8?B?OEJaQlg5L092UGpiRmozR2g0ekhCYTFkOVkzcnFjWDVIcC9QZENwQ2Y0OGNZ?=
 =?utf-8?B?VDlSMlNRMlBrT01Da05sSzF0aHlxL1ZSUWFDaXhqbTFPL093T2VLc25mMEJI?=
 =?utf-8?B?bmZBRFIrU0syQW8vTWpwQkYwM1p2aG10czJ1ZUdmbmhEa1luWmcvLytLRjE4?=
 =?utf-8?B?b0lGa2EyWVptRVluRStrYjRKaUFmSnhCcTBaOXIzSkVieG9iaW02Vy9neFJo?=
 =?utf-8?B?b2R6eEUvN2FjWG5idEdHcFlMbTMvaGQ3ZzlGZ0ZTUGZITkx4d3pDa3RmRXk4?=
 =?utf-8?B?VnFNdWZSNVRKK3ZHYzVFa1F3OStnSzBLMWtjNU9kZDBnaW5oTlliak1uUjcr?=
 =?utf-8?Q?D7TBDdFvhP/qO517HdHXH3P86?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4334.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b71a00a-aaa6-4935-5dc5-08daacdf73fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2022 05:54:54.9637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jn4qCwdMBZ4K7Q2wEi+m+B35oT4yXBgKhawtbBtBQWExbuN3TTtopldlbQWtqluE5PBfmfGAamqJL3Zz0LlBfSv4c9jCQufSrrw3QpENvEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6541
X-Proofpoint-GUID: m_uzBA8meAqOnZu92goeqpFdTcgsiUZi
X-Proofpoint-ORIG-GUID: m_uzBA8meAqOnZu92goeqpFdTcgsiUZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_04,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=717 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130035
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pj4gK3N0YXRpYyB2b2lkIGF0aDEya19kcF9yeF9wcm9jZXNzX3JlY2VpdmVkX3BhY2tldHMoc3Ry
dWN0IGF0aDEya19iYXNlDQo+KmFiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmZfaGVh
ZCAqbXNkdV9saXN0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IHJpbmdfaWQpIHsNCj4+ICsgICAgIHN0cnVjdCBpZWVlODAyMTFfcnhfc3Rh
dHVzIHJ4X3N0YXR1cyA9IHswfTsNCj4NCj5pbml0aWFsaXppbmcganVzdCBvbiBlbnRyeSBzZWVt
cyB3cm9uZywgc2VlIGJlbG93DQpXZSByZXNldCB0aGUgd2hvbGUgc3RydWN0IG9uY2UsIGFuZCBy
ZXNldCB0aGUgbmVjZXNzYXJ5IGZpZWxkcyBhbG9uZSBmb3IgZXZlcnkgbG9vcCB3aXRoaW4gYXRo
MTJrX2RwX3J4X2hfcHBkdSBvciBzaW1pbGFyIHBsYWNlcyBhcyBuZWNlc3NhcnkNCmFuZCBwYXNz
IHRoZSBzdGF0dXMgdG8gbWFjODAyMTEuDQpUaGUgaW5pdGlhbCByZXNldCBpcyBuZWNlc3Nhcnkg
c28gYXMgdG8gcmVzZXQgYWxsIHVudXNlZCBmaWVsZHMuIFRoaXMgaXMgYW4gb3B0aW1pemF0aW9u
IHRvIG5vdCBtZW1zZXQgdGhlIHN0cnVjdCBmb3IgZXZlcnkgbG9vcC4NCj4NCj4+ICsgICAgIHN0
cnVjdCBhdGgxMmtfc2tiX3J4Y2IgKnJ4Y2I7DQo+PiArICAgICBzdHJ1Y3Qgc2tfYnVmZiAqbXNk
dTsNCj4+ICsgICAgIHN0cnVjdCBhdGgxMmsgKmFyOw0KPj4gKyAgICAgdTggbWFjX2lkOw0KPj4g
KyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIGlmIChza2JfcXVldWVfZW1wdHkobXNkdV9s
aXN0KSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJuOw0KPj4gKw0KPj4gKyAgICAgcmN1X3JlYWRf
bG9jaygpOw0KPj4gKw0KPj4gKyAgICAgd2hpbGUgKChtc2R1ID0gX19za2JfZGVxdWV1ZShtc2R1
X2xpc3QpKSkgew0KPj4gKyAgICAgICAgICAgICByeGNiID0gQVRIMTJLX1NLQl9SWENCKG1zZHUp
Ow0KPj4gKyAgICAgICAgICAgICBtYWNfaWQgPSByeGNiLT5tYWNfaWQ7DQo+PiArICAgICAgICAg
ICAgIGFyID0gYWItPnBkZXZzW21hY19pZF0uYXI7DQo+PiArICAgICAgICAgICAgIGlmICghcmN1
X2RlcmVmZXJlbmNlKGFiLT5wZGV2c19hY3RpdmVbbWFjX2lkXSkpIHsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICBkZXZfa2ZyZWVfc2tiX2FueShtc2R1KTsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAg
ICBpZiAodGVzdF9iaXQoQVRIMTJLX0NBQ19SVU5OSU5HLCAmYXItPmRldl9mbGFncykpIHsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICBkZXZfa2ZyZWVfc2tiX2FueShtc2R1KTsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICAgICAgICByZXQgPSBhdGgxMmtfZHBfcnhfcHJvY2Vzc19tc2R1KGFyLCBtc2R1LCBt
c2R1X2xpc3QsDQo+PiArICZyeF9zdGF0dXMpOw0KPg0KPnlvdSBkb24ndCBuZWVkIHRvIHJlaW5p
dGlhbGl6ZSByeF9zdGF0dXMgZm9yIGV2ZXJ5IGl0ZXJhdGlvbiBvZiB0aGUgbG9vcD8NClNhbWUg
YXMgYWJvdmUgY29tbWVudC4NCj4NCj4+ICsgICAgICAgICAgICAgaWYgKHJldCkgew0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGF0aDEya19kYmcoYWIsIEFUSDEyS19EQkdfREFUQSwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJVbmFibGUgdG8gcHJvY2VzcyBtc2R1ICVk
IiwgcmV0KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBkZXZfa2ZyZWVfc2tiX2FueShtc2R1
KTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAgICAgICAgICAg
fQ0KPj4gKw0KPj4gKyAgICAgICAgICAgICBhdGgxMmtfZHBfcnhfZGVsaXZlcl9tc2R1KGFyLCBu
YXBpLCBtc2R1LCAmcnhfc3RhdHVzKTsNCj4+ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIHJjdV9y
ZWFkX3VubG9jaygpOw0KPj4gK30NClRoYW5rcywNClNyaXJhbS5SDQo=
