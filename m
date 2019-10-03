Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91687C999B
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 10:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfJCINn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 04:13:43 -0400
Received: from mail-eopbgr00097.outbound.protection.outlook.com ([40.107.0.97]:56898
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725879AbfJCINn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 04:13:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUMyl8/wGVSj5UWGCxwqM6/8Bz+Fnzr0ZUP9kBoiTwFGzPJ2L1c6pa/S0Anmbg93WnGxcsOoXqKQxc/8qQ+O1/p3S4+GH8uU9R9FbDKv9f65ZGgiAu4kgPCise60ziT4FI98gx3c1qGUyg4zTrjJrqaI/dZuT3wAOcFcxTx9DeauRSvxMZxRKFoLV/ig2flS4TLWYvyNriDC0nDJdE9bTmPz9/mtPtbxh2oqg3pomk/tuNRdlzu8Ebzkyx3BHQgLF8wlu9B89QqvjWz2wUPkEdl4X5l387ArPHFyBnB22DbGLgvMa/e0OP/e7Eo2ruUVMzX26YMU+YThQVyWakUrOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsyf800x72H9+ETQ0ssLBSEpyhKde32bLKSDWhKzhB4=;
 b=UyfpD14apwKNM3TPd2ncwfWJ8YNpbjOvgVEi2rZH4/GtjK0yYWhz4+BXDYkIZysfDy3P8dgGx2ggSjPYEFbWl+bsE/h+PNtvqIH50Id7gQzPcKrMpM2AJhQ3KOrzMnDOfBGBTRqM/T/In+PsTbPb1VVfoFjBQWhkAzTh+WZNiGAdUcGP/b2CBwE1szHdzMKwtYtqBeVAQ+V1QkMEx5+85/UQ81L6NZaF1ZuDN7/uGOFfh+JgZohG1v0lOGGzxmJmxj/StefvDpEh2KKbLhTrRxq2KVHQupssJufm0/MWedhyHHb/j+ZY/DI6SfhUEwnlA0sbZ5ECvstjHx0V8eDyrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vsyf800x72H9+ETQ0ssLBSEpyhKde32bLKSDWhKzhB4=;
 b=CL+OZuY9/efSQXLJ19sUXJfWK+FiH+GQ+yG593uG0PbwOaDxVRS9GatNFFGJEIuUMt2r3sdmvZggS6R45ux8tjnafVVOtHaa6Va2KUnkb//lrVedJgWx2zn7rCWCuU2Peg3Bgx+nIOZCD1UaBCvYHKUTlRrtLWyHEn7zsqJwilU=
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com (20.176.239.11) by
 DB7PR02MB4619.eurprd02.prod.outlook.com (20.178.42.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 08:13:38 +0000
Received: from DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::f978:a0d8:4042:92b]) by DB7PR02MB4314.eurprd02.prod.outlook.com
 ([fe80::f978:a0d8:4042:92b%5]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 08:13:38 +0000
From:   Aaron Komisar <aaron.komisar@tandemg.com>
To:     "peter.oh@eero.com" <peter.oh@eero.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI domains
Thread-Topic: [PATCH v3] mac80211: fix scan blocked on DFS channels in ETSI
 domains
Thread-Index: AQHVeSmOSAENpyhoVE6RI/+qs7ypzKdHoGQAgADyMIA=
Date:   Thu, 3 Oct 2019 08:13:38 +0000
Message-ID: <1570090415-28671-1-git-send-email-aaron.komisar@tandemg.com>
References: <02f58201-4b92-0a1e-d237-6838543a3513@eero.com>
In-Reply-To: <02f58201-4b92-0a1e-d237-6838543a3513@eero.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR01CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:e6::23) To DB7PR02MB4314.eurprd02.prod.outlook.com
 (2603:10a6:10:44::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaron.komisar@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24602111-8b1a-4fb6-ee7d-08d747d997d5
x-ms-traffictypediagnostic: DB7PR02MB4619:
x-microsoft-antispam-prvs: <DB7PR02MB4619B3B149BC03EF9AED9352F89F0@DB7PR02MB4619.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(376002)(396003)(366004)(136003)(199004)(189003)(51444003)(446003)(14454004)(2616005)(11346002)(6486002)(476003)(44832011)(15650500001)(66066001)(102836004)(26005)(186003)(316002)(76176011)(2906002)(66476007)(6436002)(486006)(5640700003)(99286004)(8676002)(3846002)(6116002)(6916009)(6512007)(2351001)(71190400001)(508600001)(71200400001)(52116002)(66446008)(66556008)(66946007)(64756008)(8936002)(305945005)(7736002)(5660300002)(53546011)(6506007)(386003)(25786009)(50226002)(36756003)(14444005)(81166006)(81156014)(256004)(2501003)(4326008)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4619;H:DB7PR02MB4314.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OblGzlFDNYC2UzdY/cTvzpHzMfg0Xx/zku04X3qJAMfwgqgeotoukaP/Sz+0Dd4n5lUiEOSjs8Do2dURg17zezW57IXG5Q1TrHhv8N4afhAqdHxDh1yFAOQs+6gPfRwuIK+26Zkamt9zTb7hTip1qfLAuS05o5w/4VdjGbgwdo9/XN8F5/yO75r7/0UNIdU9TydjjtV1C8lz01PP3v3+FRJ2zXBMzcZCcRZ51fhbjxm0givTkxANTz6kgLLd16cXRUqgxQUCy3CiF0rP9I/W8s2lRRoZpoUXj6P7cMbT9zZKQ5gM+x2VN2Xv1rFsOYJx2Co7otNs7M4sGCT84z+qdiqWp5ZKtw1BncNN8uVSRazQf63KO6OpGo6mif76x/0i5ZdLkvFTrBT4TIE7LVdd2zEoerP4hFy3FHn6t9iWyyA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24602111-8b1a-4fb6-ee7d-08d747d997d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 08:13:38.0717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F/GI6lAXu+3fu3XgDdhn8qmx3XRSSinT15hMgFDct3fTT7eoDf/Eod3oiKRkNCS7sjsZozf2e753INqQCZfseG92aDnn1Jpmmn+SOivo9e4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4619
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/2/19 5:46 PM, Peter Oh wrote:
>On 10/2/19 6:59 AM, Aaron Komisar wrote:
>> In non-ETSI reg domains scan is blocked when operating channel is a DFS =
ch.
>> For ETSI domains, however, once DFS channel is marked as available afer
>> the CAC, this channel will remain available even after leaving this chan=
nel.
>> Therefore a new CAC will not be required when scan is done.
>>
>> In cfg80211 scan is not blocked for ETSI reg domains.
>> This patch enables scan in mac80211 as well when operating channel is a =
radar
>> channel for ETSI reg domains (unless CAC is in progress).
>>
>This is not the right approach to solve the problem.
>
>The real reason of scan failure is because mac80211 checks if it's DFS
>channel, but it doesn't check if CAC is done or not.

The problem is that scan request is blocked in ETSI reg domains. In non-ETS=
I
reg domains the behavior is fine.

cfg80211 blocks scan in non-ETSI reg domains and allows leaving the channel
in ETSI reg domains. I think that if we add a function in mac80211, which
checks if we can leave the operating channel this function should also take
into account the reg domain for completeness.
>
>So to solve the issue, the right approach should be "check if DFS
>channels and check if CAC is done".

We can't scan while CAC is in progress but why must we verify that CAC was =
done
in order to perform a scan operation?
>
>You may refer how "cfg80211_reg_can_beacon()" is doing for that.
>
>
>Thanks,
>
>Peter

Thanks,
Aaron
