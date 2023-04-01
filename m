Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1776D2DA0
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 04:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjDACLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Mar 2023 22:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjDACLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Mar 2023 22:11:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2077.outbound.protection.outlook.com [40.92.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A991025E
        for <linux-wireless@vger.kernel.org>; Fri, 31 Mar 2023 19:11:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhHqPFly6XdsnnBSi1QzVHr2nWsCWq0ubqZH09jCBTEU2ppSS2RaNVumyM8amsmXJP8mkQN7XX76ZWeIToqq24BNpFhCuT4RawEQ8r8o6h097bkAOu/Hz8rSuBgBMECNsztAvbpqoBuHC9nmyO7PULCKo/Oqbw9qvQoG/tuJb62wHqj2lW4uq++hA0RGHQk9WlZiSFWBUwald/0PbGR7zXEvPISvNcZcG8408bqPPior7XEp/RdmV+yCSYn0lXmcX3AvPfcIZkniclWAL2iWNdYGdbA/K7XhIL5V/LqZCHzFRlEENgeO7X9c3/9sdpTZGNJgI/bQr35zBnYsCLZmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RORkSRvfnScOtJWgo3H8wMM6n4sL7l8ZWbmIcRuDuHo=;
 b=KSOl4CrADoIY7JSppnfJ5klojFcmySHt7LyDEETKwXAHG9vOoqcIxJTebWZhlr6FlHrhj/UOqa7pJE1TrgC648G+3R4clwcEEohle38+Du9gIu+2kJHip+ykvwBFJXjGmc9bE+cxpmE/bpngK7j/FJEaKoULHUGIRSId4f1urOv03bY8kRri2G8hP+wMv1hZs9fonOXDoGJSkz/KCapCceZWUuv85wvYsI1eVTzM4r4XwarUXdCaeXbHOO81EGzoq8CWTDxDYh84RCZTvENQ0yQmIF/4iwSix4hwpIxCSH8h5DoCg6aFvaJmCDglzva5tfdwLUWsR1uvQaLh70388w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RORkSRvfnScOtJWgo3H8wMM6n4sL7l8ZWbmIcRuDuHo=;
 b=BwkPgJT1oX9m9WcZBllNkk5BQPV62QsQcNCeqlyglP2a6uOQqmGS5hulsyndtmwx40u0AUebRAsBRTx6Ika8spYszByvd6CLpTaw8UPXFu/GlInBd1elyjU5cfbjBVI/J2YmkMZlHnKuTHu+/reTSgxrdWDH5yk2E1GshHjrlqihGOrqs5YnRnpSjKAaj+MxJZ3/qS6LKYSgxMqYdo34+vhP+/nbGcFu9NTxSXTiHJkVHpOciAYWZEReTmEP4RgZQWRa0y/Ov66BeTGyS54Lat8NRki3Dy28BdpP7Wx8ArOT02x3LAXxgfD9Blk89O5xjTINeyuaTNN7zVJC/019jA==
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com (2603:10b6:a03:328::13)
 by PH0PR22MB4008.namprd22.prod.outlook.com (2603:10b6:510:2a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 1 Apr
 2023 02:11:05 +0000
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239]) by SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239%8]) with mapi id 15.20.6254.026; Sat, 1 Apr 2023
 02:11:04 +0000
From:   Eric Sellman <GAK_ACTION@live.com>
To:     "sforshee@kernel.org" <sforshee@kernel.org>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wireless-regdb: Update regulatory rules for canada on 5GHz
Thread-Topic: wireless-regdb: Update regulatory rules for canada on 5GHz
Thread-Index: AQHZZD4WXRyFZKmuLUmT9dLETqAkMg==
Date:   Sat, 1 Apr 2023 02:11:04 +0000
Message-ID: <SJ0PR22MB2495707E5FC7EF2334A699BC8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [DoIGZse1C4MjtCN32cbU7fNs5+0TI3AQHVgSFDiDszk=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2495:EE_|PH0PR22MB4008:EE_
x-ms-office365-filtering-correlation-id: 2fc1f9ac-ba61-4ee6-6d5a-08db32565949
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MaCPLLdxr2ou6edc5/pkWbkVBT/ZdN6UVCmW5XvD9Bh/uQN/c7ms+VovrsK8TBC4AbgjcIDpoNUaknVaxriUKyZQ2mgFUYFncg4n9Bf8ufyF7Easd5JiGzjO9piFgBWxf9EiBwJbWGS28DUlWFIDF6mu3TC1xwnq7oMxsOc3k6ulRtVyE32GTOmdWzEQNnWvHYgXzpNqMkQ5hj/8Z8TgsRDDv9kZGO5MzOZGIDHnwHzLnQ6q6S+Yfn3rlTg2NbOM4j3WB+t3wtEENJom5W1W5dbGsgmNZreMhh4+2XF66ooHDIUUJr/MDzOFXashriSu7Tte/IMtHMBNRLymOf3zvWw4IKNgGyd7dx70lHcRiht/u3RW0NsNxrgn5x2yJFZeBsHlEwz1QzD+tBk8WVS7rKf81pW7/So2GpaPo5xgB9DrC1PuCU7wwOuGtNQ3wZX5w/d2Oht0l+4qW61xbr6BEmuE7nO+DoW3WmhRAP9QadrmFSEEdtWQMbrO//aJyyTLqtgLNm/MNAE8dMiuNmcfU3iw1rivZjLRVHYEkxPwR0pYJcea78UJqVkOItyzCl+8
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?sYNhwU3KBB0bEwRMgbfjH3onu2CG3UkNymhu73dgfywVyfR3g8ipOQnM?=
 =?Windows-1252?Q?3OGOE80yGrry7DpXWA+L21Ffq95Lsarxjx9JwN45dhsJK8M7SDjW6Ia+?=
 =?Windows-1252?Q?nPtfKlITf8V9UR8loeqoAgAq1xYqw3jXSSYpJGxH5saS3fRyzFATrgul?=
 =?Windows-1252?Q?Y2Xv9ne9g3247zB6vfpzHIEI9kji507HTRPoeqFOvlcOe9zxMKTdzbkt?=
 =?Windows-1252?Q?6qXTvHuUo2L0+qj1grvNDlmZVeLuSQoIqZZgafH2Q6Q0Is5o5Of6iL9z?=
 =?Windows-1252?Q?AsS2vnzgL58+KLBN+dCKkf2IqxwW2k/rd6AwJcnxwfz4WJnhDb49MvoU?=
 =?Windows-1252?Q?dmJQUM+SSUDAqhxNTAySV7NfBcwss7vqEb5dxFzAbsNiQG4NY62udjk1?=
 =?Windows-1252?Q?UkNinboRJ3BTMabXFiU2CK3m/CuN7wUOumxD2kqZNHrNq2rXeJXFKuS/?=
 =?Windows-1252?Q?lsghJCz3T1g+td8tiJKvxvyxWpKGz0yTJErQcBD+veD0DJ7Fuueshz0Q?=
 =?Windows-1252?Q?CGSuNKIeca6zhNUcWWoeyPB2i8EUJbR39EinJxljCrDVh3dJKm7GsweB?=
 =?Windows-1252?Q?BYDj2ZkfNvlUWQdWDHh30ZTMVMQumBE3VR9+8bTHI/KYd2eoLPCBqkxH?=
 =?Windows-1252?Q?GrgW65LaHJA/44HTmKhZuslOuqp52kWKrnxnJ+DjIox3CQ/pkv0WYfFR?=
 =?Windows-1252?Q?dWqrusXkVL2AturT+nWLoF5KwWFts92g+Ggzgj/2haSk1L8kzpzJgnek?=
 =?Windows-1252?Q?gSrT1SXOsvlXtlUkF2OXg8keMIjW8Y4KNfGpijKLovaIYaAaKcBIlk7g?=
 =?Windows-1252?Q?o9stDkZS9mUKz3k9L2ON7NkAlEJEsGOHcnd9Hv6D8XPy11nsw+crD/pD?=
 =?Windows-1252?Q?Ybk1M4Vn+YHwG6VfzHZRGJiJ/QUsPDQbgr43ZhkmeoJlqIU2Xc8sIo4Z?=
 =?Windows-1252?Q?n92oMqrzb9E88nL/G8IkoyVi+pLrlwHV/k0dYfNR9hsUBm1BWaLlNMH3?=
 =?Windows-1252?Q?jaUPg9Kr35tW189IqPg6rDck4n+BY8oNCpMPb6KRd11+Teo3Jq7ei4Qk?=
 =?Windows-1252?Q?Sm4U4Ui08WwYNM0Mq0xy3+j5oQSv3oOynuqZYRAehoQs9IQs9mY7d7c6?=
 =?Windows-1252?Q?tPgAHt2X5eFHhdeuelJW/iSVsXmm1WsiJ2ZJ8UtzbgmC8SnmdZOAd3Fp?=
 =?Windows-1252?Q?QOKtwuiDAsVn3sIusbtTHDwkxpfkjEa3RHAUtVhYjIZdbU3NG32qG/EN?=
 =?Windows-1252?Q?Hka39HhW5uPQ0v8zadkfc10iEKQRfgl4S39u/sjG4SSTPXyi3dJLMjAb?=
 =?Windows-1252?Q?lCXElA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2495.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc1f9ac-ba61-4ee6-6d5a-08db32565949
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2023 02:11:04.9391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB4008
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I would like to submit a correction to the wireless regulatory database for=
 canada. =0A=
=0A=
https://ised-isde.canada.ca/site/spectrum-management-telecommunications/en/=
devices-and-equipment/radio-equipment-standards/radio-standards-specificati=
ons-rss/rss-247-digital-transmission-systems-dtss-frequency-hopping-systems=
-fhss-and-licence-exempt-local#s6=0A=
=0A=
"6.2.3 Frequency bands 5470-5600 MHz and5650-5725 MHz=0A=
=0A=
Until further notice, devices subject to this section shall not be capable =
of transmitting in the band 5600-5650 MHz. This restriction is for the prot=
ection of Environment Canada=92s weather radars operating in this band."=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git=
/tree/db.txt#n326=0A=
=0A=
Lines 330 and 331 have frequencies 5600mhz to 5650mhz and therefore need to=
 be modified to have those frequencies removed.=
