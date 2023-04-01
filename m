Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A249C6D2F16
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Apr 2023 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjDAI06 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 Apr 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAI05 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 Apr 2023 04:26:57 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2068.outbound.protection.outlook.com [40.92.41.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09841CC17
        for <linux-wireless@vger.kernel.org>; Sat,  1 Apr 2023 01:26:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMMIEQN9ZYS+3XAQXVj2Jq96ZZfMAuBIKvmYS6mbaaj/lG0pfFewYQgJ4t8lyHrJ70u+Zc68OAHtGExfWwt4vi3J2V4ky/FiGN/5NqZ9GBOtt2/R5PxGQP8bfH+o++szwNH0jTRt90/Pxlj3HlFotGRAT1qnuBeqPfvhHzsLbjADJ9ce3uQsSRJnu/dAhxiEp88cfETw+I49ZLZnvSyZaZthCm2gtBOSmn+mBneCfCMlk7pDL6saDTwnE2M+PqgnwAu6B5QobdHwlUxdZO90qS3DAYLdT4iY2Qju2BAmOC3d5S5Dr3uq8skxxN41k2z/sAKuelavgQtMonlIJeiSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31LyEhtw+FlBwF0afwQghMzuGKy1irpWiKxhi8lfCbE=;
 b=VBohVLrFbS2+tSMQt0HzwE1F2aRgcBaud9jzaZnkyoPVgGTXfiV4WyoiwThkZjJ+c20U2nkv2YwL8YiPVeHN58js2ap1fXoag6MH63R6r2lWFys5Ong/eSrHm2DnoA0kXAw+14wJJdn1HVLAVtohXV+SSx5WBX7+xhofUa13RaBjth0Ezvm+1MfmTjeXLFscUluRWM0Px3WgAPiyPMaZ71iDGHATeMWWvE+LF8esPpdygHm4kJxZaVrJF6EZIKNb6jFF+HL8CAG9eJl14JU4zSeTqIFoueEWI0TvZmAy2jq9q+dAOIoSswtZ5AEWQyTs6WRoasFYMgFbWHSzM6C6TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31LyEhtw+FlBwF0afwQghMzuGKy1irpWiKxhi8lfCbE=;
 b=QumQ3EBJdf5o0gT4uQmZJgPFnw5KGHjA8MvupnC9fEt7qKOGEdsQenSbvZNX1RRSDq2pvUDEqgjoRQaORmkqpLAmKLPCCoA08BeebKpQNl/+Gcir6h2p0zV9dLc1RDV1/O1ln1JXM3XssmYo5KGeypEcigGFOZhxDmx0fgNGvFeegc/4aDprBST3HcR4Aakh2Q6kJWDCqFIaod82MArf5+aXMAGGpb1dVPe+2beWoB3eeK3MgR87vXHZ0MfO4UJad9usC6rYtYw26IKGiUlzbZ+CGrjUNRLZlkmGPqs3GecA8YGzFxs7tOAawf7nd2J7lLOXmTCeKl3fgo5F7jttIg==
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com (2603:10b6:a03:328::13)
 by SJ0PR22MB3899.namprd22.prod.outlook.com (2603:10b6:a03:4d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 1 Apr
 2023 08:26:51 +0000
Received: from SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239]) by SJ0PR22MB2495.namprd22.prod.outlook.com
 ([fe80::f3de:f07b:7676:239%8]) with mapi id 15.20.6254.026; Sat, 1 Apr 2023
 08:26:51 +0000
From:   Eric Sellman <GAK_ACTION@live.com>
To:     "sforshee@kernel.org" <sforshee@kernel.org>
CC:     "wireless-regdb@lists.infradead.org" 
        <wireless-regdb@lists.infradead.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: wireless-regdb: Update regulatory rules for Canada on 5GHz
Thread-Topic: wireless-regdb: Update regulatory rules for Canada on 5GHz
Thread-Index: AQHZZG/W2khU8CF3xEqzPMPYLcV43Q==
Date:   Sat, 1 Apr 2023 08:26:51 +0000
Message-ID: <SJ0PR22MB249501047C8F6F51CCB9D06A8F8C9@SJ0PR22MB2495.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn:  [XfKpI/Nto5L83a/ghEuiTx/FwASc5kc/IKsLSwPBXQg=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR22MB2495:EE_|SJ0PR22MB3899:EE_
x-ms-office365-filtering-correlation-id: b2bf9ce2-5531-42ce-6f74-08db328ad83b
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eAuY6SwKfSMz/4oAlIuRxhHWLAn3rfS1Qb2uIAX+P7sr1PfHPyn6CRG1xln2eUBsx9jKX6Z5Za0x81jkjefdlMQJLCKkSGTep4u/VrKTM+HHJM2AujVrDumTVJUyLPLxfBaNML+fX8A3CEsTKTpF975iSDl/LztXC9onNp5gCb9QGZowcj+68enMoGCHBTK9oJswxQ3XAP8wHGxWgI2rODndo5F8spCU167dqKtmuE3lf8IKmg/xnAp/EX7pC5LkHFEbKcNUhf6csw8g7oEHaqDwPEFTpE9/U38yRuTIKn8uqRgurSZSR3pMXpuJ5EStSplKraTN5LE6kCkDQPgK31LFzXIwbiBtH//UNP7XIicsoey4hoEZQ99PgPKBcuqgNlglk839+p87I5GXrrMWcMCPJvqlDoy0VeOTypWNB9aq1UrS/80WWE8V2RGHRIZC6Pn86FBWd/KR4nJhEqhS3qYQcHa/w/yGbW9SjhXcTdxUEOaB3HJ4Td/ApfVvJZkxAIK43ri2hz+TukSs4issV8fgE36A+npfAVlzDpIIEBaQvGudOpHVCRQRonZANehaumczNzo+KWc4taEEqD63VA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9fbbfRP0CEGAYHiPSmRtaIxvVtsCAFH5oLhxiptDMQb736U+FuIB4hexrS?=
 =?iso-8859-1?Q?itYeK4tejI7sGmcCBHgvBd1UhyMv6Dult0QHKpRZDiM014AWXV7IUQMyKJ?=
 =?iso-8859-1?Q?MwKIejEDPHeY/L3Szz+teu+b4pgvsAUeQ95oDmRBNSsLzl8QrWKGyvUDIe?=
 =?iso-8859-1?Q?CrViLx8mOJv5R78jft0XsAZu1SO09/VkdUhiNTcdrI60v2AT0VFiR2YRk9?=
 =?iso-8859-1?Q?NOUCjdSe2xFkZnQabY2L3P783ZuRPgBNT4KgLmBD01n3nV/sN8oXGPrNP/?=
 =?iso-8859-1?Q?0dpy3V2AlCv14+pDphBzONUUQjtWtZgbqwm1SY6kIh4EmkyHZ+Ha08dB1o?=
 =?iso-8859-1?Q?a5JtBowd7yH6f3/VQxwz1yuEulQMWsKf0Y8OqAfrlnhTPovUKt+qpAMJP1?=
 =?iso-8859-1?Q?x+R1Kii5nl4J1E6jbImpN1ehUKmC5QrQK7xWSLyll1FyOSb/72rRbY2LD9?=
 =?iso-8859-1?Q?m+9kMH/KP0KKIlpD/nWIbqDb0fps6KNQyIqgilWr0UwuD+eL31BqYLsyU0?=
 =?iso-8859-1?Q?yypYjJFj6lt3/pf6sU3qlewlk17c+FqaZh3xIAM052CkEL7B7fev+DBoPT?=
 =?iso-8859-1?Q?88BIk4FCxM+mgsfQSb8bKlZvYWIWSYurg+Gas+VjZSOwaQyQ+7cWwnNHDu?=
 =?iso-8859-1?Q?Hwsa+ECFze74CLY9GWuwlrkz2UImXX4wen/bN8awv3XNUWq8iRSOXPVe0m?=
 =?iso-8859-1?Q?WZBKdgRvmTgo/ZBGvDRRq7Q6Dpeh6rGjQAfxTzsbKiulm5F5XWe0vwh01m?=
 =?iso-8859-1?Q?xjnUrTIKhM/+OER/6uFedcaWy6b5XF/ec4sAg+7931T0DmqcMj0ZLnjM42?=
 =?iso-8859-1?Q?+UxPSs8F9xXvcjwzaqw4h7p2e4o61rCIUAwleRaw9dLc6HjfWKJjkHXYyU?=
 =?iso-8859-1?Q?Au6wh5S6IMkBMpXyUv3hq7SAsVJ/+8gTKjvRQ0peFg/lg6nWqu9CP7AH5z?=
 =?iso-8859-1?Q?7ZB20ikH5j76ZUJyg5wMHsc+gykHJ2DrHc8QeRFqxJG8PyaCHRYksvOZ4d?=
 =?iso-8859-1?Q?w3lFfOvso/XkoRMIx8t6+6y2zj7HMOpT02RmrcUvjIXGiDVa/TeyA4XBZM?=
 =?iso-8859-1?Q?iiEyl6WmCG4eqxADOQNDQdP3khXBCncrG+AJg4yph1pe0tYG4QDDacrn3g?=
 =?iso-8859-1?Q?Ubf1SqMTcfu3Fy5nFLXUzzB8EkrC5iRZ90eTxmxQeMId3FIAenkwttjWdm?=
 =?iso-8859-1?Q?SNOhC30kWhU17midlb5nHJQnyEDrAMKie4N3QzId2AcW+fLaBDn9Judtmf?=
 =?iso-8859-1?Q?eyeV1PHdb8Ak2eTD8xUg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-c3c87.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR22MB2495.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bf9ce2-5531-42ce-6f74-08db328ad83b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2023 08:26:51.7695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR22MB3899
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

My apologies but I have made a mistake.=0A=
=0A=
My previous submission about Canada is invalid. The weather frequency range=
 has already been avoided.=0A=
=0A=
Here is the correct information I meant to share with you.=0A=
=0A=
https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf10971.html#s6=0A=
=0A=
"Devices with occupied bandwidths which overlap different bands shall compl=
y with all operational requirements for each band."=0A=
=0A=
https://semfionetworks.com/blog/5ghz-regulations-in-canada-2018-update/=0A=
=0A=
Canada still permits the lower 5ghz frequencies to be used for VHT 160. But=
 it's missing according to the information for the Canadian profile in line=
 326=0A=
=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git=
/tree/db.txt#n326.=0A=
=0A=
And I wanted to mention that for 5150 - 5250 on line 328, the transmit powe=
r has been increased to 1 watt or "30 dBm" according to this document here.=
=0A=
=0A=
https://www.ic.gc.ca/eic/site/smt-gst.nsf/eng/sf11294.html=
