Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA696E0266
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 01:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDLXUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 19:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDLXUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 19:20:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740604EC5
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 16:20:11 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CMqki6003512;
        Wed, 12 Apr 2023 23:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=YFYoAqpOzW2ZFOj62628n5aiAm2EaPgOWdjFpJbPTrA=;
 b=WbKamOp37IjFsz9dllwu8Z2dvMTvAF/5ONyCK2gc+kq4wIVwXIy5NHD+HhHpBO6FcaNe
 JLFm+EI8GX58vLdEKfWu4Q1bmpSznPQggSrodsdKncReiy7PRxzw/nTDcu3gKEK/cKK6
 Zjok80JBsGH1zfAXHzGYVV+0edY45lTKfAdQTHGaRAqbE53qOn8+9mg8XtCdMt/ZZemy
 HhUJ46F5bQc4L1t8p3TPAtvENRZwH52S0kwxVu6krweJcx+XiBfajZyGptRFGWWU30UB
 ErAPsJ+36GsuE2Wq9iEcDIS77h8mXa9pMmwPKiturDbxjm7FWfxAhytMZQb8hSr4mo0L Tg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px5pkr1ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 23:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZlcgwwDzBkcRit62qA1ohPYjGR6Ctycuj/Gq+vJemTMp49mj7d2MgjdRCoWxxUH13vqDfZ5hNT0CtQU+BntxAA7zTIBdG8gBNCneUT9WJVGGDsJIQLRtXZxR6+HzU1hnmGHXwlIkuhGwcZG19LkuQfoIlmdryoy29rcA65+hF3+W7KaD/aRFqP6GMG8cWTZjCaxnCOBJr3LIb0E5XZsRCwfvJInnp1nrEa6FXDQGAgbxrhdW8gcXc8WnIvkp4k7ZC0XTtBayDEIGEslD+8mEllQ1FvcY3CRT1Qzohjwax7qDhSqCPWIZ338X1ns8Avp48GIc3goOsPj6OVgYUZDmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFYoAqpOzW2ZFOj62628n5aiAm2EaPgOWdjFpJbPTrA=;
 b=esAGCDRZdppAA6Bp5v7oi/qaymgqCY1yCq4JuWf5N5Zb+rAb1QkIl9Tk0NKBPlobBStk+hAFLsMG1wDEYHgItmE4kvfrFZLthtqBablnvyEICqA2i49a7VHQ0tzCOeSurObE78QHmYavWOcIJh/5eMmWOmxAbFXcPY9psk7FSF+bqJAxe9BWZE9rZ4Wk4kiGcnMwLIOfwfqlri7O201yIobSvx2agiAL7c/1UoJ9BfqKNejnOsZZ01E3/cxwKzJpPP6EuPr9LiMNflsg91bxxYVmFXTWM/9crQUmgo97ip3o8xTZYY7ftncawL5d6XghvES2BJSPmhhiGqEHkxJTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BY5PR02MB6164.namprd02.prod.outlook.com (2603:10b6:a03:1b0::23)
 by BL3PR02MB8297.namprd02.prod.outlook.com (2603:10b6:208:344::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 23:19:50 +0000
Received: from BY5PR02MB6164.namprd02.prod.outlook.com
 ([fe80::a37b:c6f1:4f42:bdd8]) by BY5PR02MB6164.namprd02.prod.outlook.com
 ([fe80::a37b:c6f1:4f42:bdd8%4]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 23:19:50 +0000
From:   "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
CC:     "Muna Sinada (QUIC)" <quic_msinada@quicinc.com>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Anilkumar Kolli (QUIC)" <quic_akolli@quicinc.com>
Subject: RE: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to
 hardware
Thread-Topic: [PATCH v2 2/4] wifi: ath11k: push MU-MIMO params from hostapd to
 hardware
Thread-Index: AQHY4ziZO85H7SGYhUe+moxeKU23/68RevYAgAEFENiAAIU4AP//l3U7gArLuQmAC/kAUA==
Date:   Wed, 12 Apr 2023 23:19:49 +0000
Message-ID: <BY5PR02MB6164BAC2A418B3C5462C2C348F9B9@BY5PR02MB6164.namprd02.prod.outlook.com>
References: <1666128501-12364-1-git-send-email-quic_msinada@quicinc.com>
        <1666128501-12364-3-git-send-email-quic_msinada@quicinc.com>
        <CA+HBbNHw-0+Ty_-masxGKwT6ju_EBxT3n5B0Ygcn3XzQi_CzWg@mail.gmail.com>
        <87fs9ndh6s.fsf@kernel.org>
        <CA+HBbNEaNTkUv_UPgQievxaLya0XC6=AVj0=GWiH+qB9=vRZHg@mail.gmail.com>
        <87bkkbdcfu.fsf@kernel.org> <87pm8iaggt.fsf@kernel.org>
In-Reply-To: <87pm8iaggt.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR02MB6164:EE_|BL3PR02MB8297:EE_
x-ms-office365-filtering-correlation-id: 46907cb2-c519-4954-8899-08db3bac69b9
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: glEIj+nE7MzD4jBVVQJMZyF+taRmUqInlg7eOy4l55HtN5ftcFdLSYHRJRa9vXbmoD7Y+TssFzhECkAYSDNtzorsYfQZ67QABJBi+AYJiwPr59mWD7HXQV7kEJnXX9gi1Xndfwg06IYJI2n5/nO23bYOAEUGc+d8Qc4m/t+sk+Qcqn39+zLVZuzfndun8ISv4NHowsxbohaPaMDmJDhIoXWW7LBgCkuvm8PvuluG40zHK4tL957DdAXbgQed1P95DPlf+EAeHoGYxXd3QxZbjrYzDCRjhHPmB/5Bn1VpYZLMZj0Sqm0nW5RnHsgtF/UwfYf/Qu1FsdNU+Nv4SDrUQHrMEd3Ytwu2medHeLt5AJNcFuqtFucpixFJ6YviOKYaE/DLRF0Xl1tKUrjiQO3/mVDTDsyFZa2HS63dHb7YsnaDwxTVyaOxjoW/7cVfwc4ppL6tIt1Satr8qp2m9RJyFSi1zUYXnQYWhXEFBIA23+YkUFnSPIzOdJ66bhOEMCCvuF1NAsom4946TUMOMAgOclDPKVwdB0cl7JZ+ztoAOEGft5tmpDQjZq+yn8IDyH4S2S27pjKPWq+nzEwrd2NXd6GNFivyyd6QRnM1fx7mSYSZrJz0pIclsgB4tz26kdC4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR02MB6164.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(33656002)(76116006)(7696005)(110136005)(26005)(54906003)(107886003)(6506007)(186003)(478600001)(53546011)(9686003)(2906002)(52536014)(38100700002)(122000001)(5660300002)(64756008)(66446008)(66556008)(41300700001)(66946007)(4326008)(66476007)(38070700005)(316002)(8676002)(86362001)(8936002)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEw4ckdDOVAxdlJKQk9DOFFieDBrSGdvRFNhZ3VkOEgyeWR5Zk9hd29RdXN2?=
 =?utf-8?B?UjJFVXlSM2FVRVNWU2Foa0NwbzlHb3N2eU9YSUJZdFpNS1hmRnZ0ZWMrZEU3?=
 =?utf-8?B?dW5GSWtUTkw5bzhvYjhPSE5hS2FucFJTSFR4b2FXckpIb1U0MURBdHF5QXA5?=
 =?utf-8?B?LzIvOGwwYXo1ZlZtQytVNS8xblpUSXFYeDY5WFZGQll6R29WSW9XRFh6OUdW?=
 =?utf-8?B?ejIvdUlja05sNFFyV0o4bWl1RnlLQzQ1K1JadjFab3p2QytDUnB0M0dHUWZ2?=
 =?utf-8?B?V0N4dmY5SVNYeEdMMWNPQ3ROeDNLazRRaXFUY2ZUc1NxRDVqR09KWjBFSlN0?=
 =?utf-8?B?dDJsWTE4ZmlreU82RTNlVkhyYllzVDQ1M3lJbzh1MWJIWEhMd1RLYkJrMUhZ?=
 =?utf-8?B?Z1JWUkp2S3VLMnlUclY2MDdPbnV6R05waldiTVJOZUxIZUJzZFZCcWtKWFFQ?=
 =?utf-8?B?M0lCeDVGQXE4Vkk0MkVEbnl6TGNDaGNhSzRlU1RRTjNhQkNXb3RWbFpCa055?=
 =?utf-8?B?d2dtM3VybEJBaEZ0RmZnRWVxeFdrbUNVdW12bUpHUGwrOVVUQ2o0SWhNaDhX?=
 =?utf-8?B?Q2x3UUxYQVU3OXNsTFNpUkFCUmlpU2NsN2tzeVFrRUpoN1NZS0I3cFNKbEo2?=
 =?utf-8?B?N2ljeU9kTmhERGJEZ1p6cElmdFoxUC81bzFxL3RmcjlPUHk5dDlRRmJxVFJr?=
 =?utf-8?B?VVJJSlV1d2V4ZUVuK0tQS1NIbUtxMGVOd0tVRFl4a2o3Rm91blpoQmhMOHpQ?=
 =?utf-8?B?UC9yYmxJUHJrSkFhelZyR1pwYXpXYmNNbjA4akNvYUUyNC84Mjk5S0NaU09Q?=
 =?utf-8?B?aHIyRWhFZU1jZXVOZVFEd0IyditSeWgxVzlUTEc1dm9zR3RzS0lDbUVXVlFn?=
 =?utf-8?B?Nkt3aDJ0djdzamVGNXBJNElub0pjdTlZenlWNDQ5bFdiaHZ1ZncvbzdNenhr?=
 =?utf-8?B?cEp0bVhYZFVWaGFOWlpZc0xPVFJDNG1OVEJuRWZDYjA1Q1Flb1BpaEJyQWZ5?=
 =?utf-8?B?S28vK0NoTVpEY2RhNnRITUpUSGUrVVpockZBZVlxeEtNWEtpOEpia1dMVEVl?=
 =?utf-8?B?OGhHb3Fwc0IvY1NmSUZFNjZ2QlZsTGZQMytXUWNjZnhhejY0L09PbEg2Tkxo?=
 =?utf-8?B?YmdLdTgvVEpuWUtlQmJhRUh3Z3VpUFhQc0d1bWViYmJFNWx1R1Zla2FBdTdD?=
 =?utf-8?B?ZFZzT1A4RnZ5cTBZc0lnOS8xYkRSUkY4azVCbUhlNzFCQTFDWkpBMmJ2TWRU?=
 =?utf-8?B?MWlhOGhEM29uSHhjQm8wWTF1NVhVY3VNcGk1eWdadGhGL2xmbjNlVUNIa1ZM?=
 =?utf-8?B?aHRpZllyUDZTNkxHdE8rQndrODNxcUZkeVFJN0JHWFd1UThodDU3MVgyalFr?=
 =?utf-8?B?b0JGSHoyOGhnUnFFU0ZDaWJBN3ppNDhKQWtVVU1sdU9IK0l0VG44V1hwOXUz?=
 =?utf-8?B?SVNOY0UwYjBLS1Bxc2hINUFESWZiTi9FKzRjZitlM0VJeU12bmM3bzlUWjFG?=
 =?utf-8?B?OGpkVUdJSmxmdlpJUUFaQ1U4dFY0NGJvWForRWJrZzlyejQxTHVFakpJckho?=
 =?utf-8?B?NGlkWHBoRFJrU2JRZEJzM3gvS1ZXQ1JkMXJWUVlhT1ZOR0R4YXVnVzN0T3RS?=
 =?utf-8?B?Q2g1eXBhMlJtYmluYURTdzZoL2d6NDRRbTQ3S1cxTDlPRFpZdEhScWRLUE5j?=
 =?utf-8?B?YSs5Ynd5d0t6Z0J2VW5yd3R2ZGZERGNZY0F1bkNpLytDQ3lhbjlDWW96eHFK?=
 =?utf-8?B?THRtdk5MeHNBNGNZcm4rbE9sbGtaSWJVbld3cXdCTXZUVFdvRTA4eW1SSnpn?=
 =?utf-8?B?Y2tTMnZwMU5mdG4wK2ZYamVRcnc1cmJMUDhwNVB6SGh2eC9BellZdkhRaWlD?=
 =?utf-8?B?SXhmaEtnTzV4ZjNPRG9ObklpSk1QT2hQT0VMQVJISzZQOTBTa0N5U0l2UzRt?=
 =?utf-8?B?akF1NjR1RW1nclZtbmdrK0U2ZkMrVTI4TGZpa0NlNjlMcFlacWFOdU5FRnpR?=
 =?utf-8?B?OWg5R2NWUXZtbFZKN3ZPdEpyRktVYjlJeVp1TUs0bEw5Q2dQT3psUWIwUkdi?=
 =?utf-8?B?OURjc1BjV3RndWFJT1NOTEJ1cUQxVGdPZkVSM2hpbVYwSjQ0cXV6Q0hSSE9N?=
 =?utf-8?Q?VqZ9KV3EJSreP5ab9GfUwQvFv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bNcP4loJXSWGHU92qfEBOyr3g4msOGitwWpuM7eLa7JfkYKzQDh1gLDB0k5Ytw3wqKGxhHs/+/ol/xZx8puVjIszNIY3SyVVY0K61wikxLm2MJRiUghbt85Od5M9CCDAmFsq+Cd+CQUYJKUdtiM+1wxZ2MfyHkIWu1O42HyGyfhgAHA/o+cogV5O4G3FLOFOLh+Fg7NXORJZ/a3mEN8lzdzxWg8qpAFF4weJSzHPKJxFSVOVxPlG/1pNx5Tg6dXKKoKdlOVbnDMmDLYFQTrNeSYR5hFAeMWOhoPfTCY0citqr5ONSgkh5s63NOQUdrTOXRTSy+uzkl0Rmcpy510GS6d50mCzXJ5SOsDzJAGGQwb2DW396rUzIieu/qhogFnY4w+pLe5KJnvrTQgyPh/qfj2seIFTwIAhPDIhtmc/vCHfocRpmfpya6Zv7R6ZFruNIltN0F/jHBHqwFu6mW0B9NUF9/YqbcYUnYohweO/48CL3zfapSXZYnaTUsRU3yR4ECqeK2mYHr+/99Lhxmj4XD9Op7WTQJaH0KWkyrvVkxaxRdOcpe7M1scuasvtAiyuM3MCkYrh0tX+Kn9X+DMlTqfIzVIfZ/tSvuKW4vp2x3E/xAdTn0de9nWdnedPA0GXuLlVNrSGw9UlOY4dQIXpYDUicH+3jUD7hPykydgFuM2KUnaRf8aX6DLBZsyOOd9bUflnDiP6Iqv9K+ZIRh0WKDSOgMsARlONeLu4BmcGncY8iJrUcDMs7ZHsI35YC3mCabhhJMZBEQ5Tu5IIWE8aUj/v5x/EHbCdbTAkMtb01nHeIK4K0Suy9HWmSyEHlrMgql6NkztylBzmhNh8W3CVGRezFUUihqaXWEE2QHPL6qRrHWkVTBoTyesV2vkjnpO9ub5rOqFTD5r+aZY/wu4hVw==
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6164.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46907cb2-c519-4954-8899-08db3bac69b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 23:19:49.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JO4OQvgLweyVyrCjW9QoAefNpSnTCfhMinEDdKYFO0/Ug6M5HUyegEowRrA3oJ0a0G4Ya6nxUQYGNkSsBjPUHACIJxb2PWhRxEFFfqwruOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8297
X-Proofpoint-ORIG-GUID: pc0X8D02xipPlwGshk-rmZtOJtZ8XmoW
X-Proofpoint-GUID: pc0X8D02xipPlwGshk-rmZtOJtZ8XmoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_12,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304120197
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

TXVuYSBTaW5hZGEgPHF1aWNfbXNpbmFkYUBxdWljaW5jLmNvbT4gd3JpdGVzOg0KPiBLYWxsZSBW
YWxvIDxrdmFsb0BrZXJuZWwub3JnPiB3cml0ZXM6DQo+PiBSb2JlcnQgTWFya28gPHJvYmVydC5t
YXJrb0BzYXJ0dXJhLmhyPiB3cml0ZXM6DQo+Pg0KPj4+IE9uIFdlZCwgTWFyIDI5LCAyMDIzIGF0
IDExOjQ14oCvQU0gS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+Pj4NCj4+
Pj4gPj4gQEAgLTUzNjksNiArNTQ5MSwxMCBAQCBzdGF0aWMgaW50IGF0aDExa19tYWNfY29weV9o
ZV9jYXAoc3RydWN0IA0KPj4+PiA+PiBhdGgxMWsgKmFyLA0KPj4+PiA+Pg0KPj4+PiA+PiAgICAg
ICAgICAgICAgICAgaGVfY2FwX2VsZW0tPm1hY19jYXBfaW5mb1sxXSAmPQ0KPj4+PiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICANCj4+Pj4gPj4gSUVFRTgwMjExX0hFX01BQ19DQVAxX1RGX01B
Q19QQURfRFVSX01BU0s7DQo+Pj4+ID4+ICsgICAgICAgICAgICAgICBoZV9jYXBfZWxlbS0+cGh5
X2NhcF9pbmZvWzBdICY9DQo+Pj4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIH5JRUVFODAy
MTFfSEVfUEhZX0NBUDBfQ0hBTk5FTF9XSURUSF9TRVRfMTYwTUhaX0lOXzVHOw0KPj4+PiA+PiAr
ICAgICAgICAgICAgICAgaGVfY2FwX2VsZW0tPnBoeV9jYXBfaW5mb1swXSAmPQ0KPj4+PiA+PiAr
ICAgICAgICAgICAgICAgICAgICAgICANCj4+Pj4gPj4gKyB+SUVFRTgwMjExX0hFX1BIWV9DQVAw
X0NIQU5ORUxfV0lEVEhfU0VUXzgwUExVUzgwX01IWl9JTl81RzsNCj4+Pj4gPg0KPj4+PiA+IFRo
aXMgaXMgY2F1c2luZyBhIHJlZ3Jlc3Npb24gZm9yIHVzIGluIE9wZW5XcnQgYXQgbGVhc3Qgb24g
SVBRODA3NCANCj4+Pj4gPiBidXQgcHJvYmFibHkgb24gYWxsIGF0aDExay1zdXBwb3J0ZWQgSFcu
IENhdXNlIDgwKzgwIGFuZCAxNjBNSHogDQo+Pj4+ID4gc3VwcG9ydCBiaXRzIGFyZSBiZWluZyBj
bGVhcmVkIGhlcmUgc28gMTYwTUh6IGlzIG5vdCBiZWluZyANCj4+Pj4gPiBhZHZlcnRpc2VkIGFm
dGVyIHRoaXMgcGF0Y2guDQo+Pj4+DQo+Pj4+IE9oIG1hbiwgbm90IGdvb2QuIFJvYmVydCwgc2hv
dWxkIHdlIHJldmVydCB0aGlzIHBhdGNoc2V0IGVudGlyZWx5PyANCj4+Pj4gT2YgY291cnNlIGl0
IHdvdWxkIGJlIGJldHRlciBpZiBNdW5hIGNhbiBzdWJtaXQgcXVpY2tseSBhIGZpeCwgYnV0IA0K
Pj4+PiBJJ20gbm90IGdvaW5nIHRvIHdhaXQgZm9yIGxvbmcuDQo+Pj4NCj4+PiBJIHdvdWxkIHBy
ZWZlciB0byBzZWUgaXQgZ2V0IGZpeGVkLCBjYXVzZSBqdXN0IHJlbW92aW5nIHRoZSBmbGFnIA0K
Pj4+IHJlbW92YWwgZ2V0cyAxNjBNSHogd29ya2luZywgYnV0IEkgYW0gbm90IHN1cmUgYWJvdXQg
b3RoZXIgZmxhZ3MgYXMgDQo+Pj4gd2VsbC4NCj4+DQo+PiBPaywgbGV0J3MgdHJ5IHRvIGdldCBp
dCBmaXhlZCB0aGVuLiBNdW5hLCBjYW4geW91IGNvbW1lbnQgYW5kIHNlbmQgYSANCj4+IGZpeCBB
U0FQPw0KPg0KPk5vIHJlcGx5IGZyb20gTXVuYS4gSSdsbCB0cnkgdGhlIG5ldyBidWdib3QgdG8g
b3BlbiBhIGJ1ZyBmb3IgdGhpcyByZWdyZXNzaW9uOg0KPg0KPmJ1Z2JvdCBvbg0KDQpJIGhhdmUg
Y3JlYXRlZCBmaXgsIHRlc3RlZCBpdCBhbmQgcHVzaGVkIGludGVybmFsbHkgZm9yIHJldmlldy4N
Cg0KQEthbGxlLCBob3cgZG8gSSBnbyBhYm91dCBjb250aW51aW5nIHRoZSBjb252ZXJzYXRpb24g
b24gQnVnemlsbGE/DQoNCg==
