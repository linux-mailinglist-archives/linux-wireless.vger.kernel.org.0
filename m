Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DCF2B331B
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Nov 2020 09:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgKOI5n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Nov 2020 03:57:43 -0500
Received: from mail-db8eur05on2063.outbound.protection.outlook.com ([40.107.20.63]:43456
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726614AbgKOI5n (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Nov 2020 03:57:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJsHpu2/dz4TyntKCEVezOEpLNEIj8dSKRZq6ZT98M9cKEnYZu1LY7H/AGeaBRSo14pqzg/+OE1W11lbO5Xqt86lXFBHrEe3pV/S3Zn+nP5fjzNoiE0mAy0+8u0KG3Gl8vPSSR24q1YdD8gCAbzSKlx/Dw0LpapABvvM0tDrT0FhUdTQVyURuetoN7lcjWyLwPPlyWFcREH8JP1c1l3FPDWoR3/+H8CCRmdqat/1IXcAA8vKjNiKw3QItka5cUHXa1MAMSdvUdXN1ImQ5knxpcToU2bpM7fuIC39958MuECaFGEIF+wUNg48REcEF6frTJdplvyrofesQmelWLdTlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5K4jRF+JBlQADyMRLpvkJU5d4vBEtCqL9Ux+9hVLTk=;
 b=ObHmV+Yy9oFav6YX7gkwpWF1ZCz2lD02w/ijUwa1iFzxmsgzzYv9JI3Ebcef067rfuIw+b0CEiBrKEF2ltITR2bcCBcHm3x1/IkYbuy9AKxJXJcey3TeDGBIf9drR90L2+/hkNrSig1zFZ7l8O/KFwLI+KYSGYSal7syjKKlLG6jEe+T5oTqRKVS5kQFMKx7l8hb4hcDG4AbWnJBFwIAaLy8TaacxGO8o74bAuVLOx2UYU/kmm7lLxukAoZQfjn6AkRgtJniLt/4fYNR41pV3UJVQ6KzpeugDCof1Pi7BtostVfyUuATFeoLFsV0QLC9VS5Rezm1xfn5VQ2420f8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5K4jRF+JBlQADyMRLpvkJU5d4vBEtCqL9Ux+9hVLTk=;
 b=Vi3guDRymwCAfwhGi7Jc/zmiIEIrKK9sZkEMw0YpaCb9xG+abSIAyuvpKMwzrdtMfrJlKxcn3cugKVMVl8Qvttd9zn/vA2k1pNxzj8ytv4LDs8E/lz1BuLAJjzM2BB0JRpfP6WNhDCI281ym1IzZRpQceBvEofTHLHvL15NQk9I=
Authentication-Results: celeno.com; dkim=none (message not signed)
 header.d=none;celeno.com; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM8P192MB1009.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Sun, 15 Nov
 2020 08:57:40 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543%5]) with mapi id 15.20.3564.028; Sun, 15 Nov 2020
 08:57:40 +0000
Subject: Re: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
References: <20201019063921.4335-1-shay.bar@celeno.com>
 <20201019132616.32286-1-shay.bar@celeno.com>
 <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
 <4f38e1cf-fc8c-c9fd-e064-e433a8b82186@celeno.com>
 <84e63d2b334b8dbfb2de23f604030c7ea355444d.camel@sipsolutions.net>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <4e7d4c76-93a5-0863-bffa-897183bfb4fb@celeno.com>
Date:   Sun, 15 Nov 2020 10:57:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
In-Reply-To: <84e63d2b334b8dbfb2de23f604030c7ea355444d.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [87.71.36.60]
X-ClientProxiedBy: LO2P265CA0436.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::16) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (87.71.36.60) by LO2P265CA0436.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Sun, 15 Nov 2020 08:57:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 402bd53e-1f76-4600-9ca3-08d88944819a
X-MS-TrafficTypeDiagnostic: AM8P192MB1009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10099BC961EB48C878D820A6E7E40@AM8P192MB1009.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dRqQIGqzzwYxEmvil4My24r2xBKLbwBw0RgOGYeQtnFjGMAorGzz4iDK8bEAYwfKoYLwtNbYjT6tTwQkOKrCBq91F+qd3/EI+xjnQuNUS9i5ebqmN/nuMsHe+rlgzrvpCpNCn5RGC3JitVCm0IYawwRN5K7rlpSfy6BkW5gh2kyy5YmpwMo6l6FcUPJwXxO/gGb/nvjWBfjN5FS/ffci9GdsqAa6HK5wTrc2LyqHSA0XSTNir9v0M1s7jUh6Yh8imtxos99AhvfAqQBLFtTWytYDMUom/69nYeeAv1G8/NbB8XbdkfjIYu5W/IOVF5l1A4qxLcRqpPKMdBwl2urdfExsFCB8RKfTwkemrMnq5Zpj1685IkUxaqNZxNZPxfUL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39830400003)(346002)(376002)(396003)(136003)(8936002)(6486002)(2906002)(52116002)(186003)(2616005)(16526019)(107886003)(53546011)(6666004)(44832011)(31696002)(66476007)(956004)(4001150100001)(4326008)(8676002)(66556008)(66946007)(316002)(5660300002)(6916009)(16576012)(478600001)(86362001)(36756003)(26005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MNUeEsE4b6f+1Yjp8gyg/G7DfYHGVP/MB1a6f+KV6Hl3tt5k8MIP1DMUfA8cItqlCwhXHsyWVqU6wusxIiSl9pFOxi6wbRbmdcJTIfTYBRB7Nzzwejvw/x9xGwV2mEhVfthUWjvdSgbKLR1zAs6w7lwv8E7kw2CIGrOcXnXnTq9eEmlrb4MdSv/vm8SlLtryVuRauMLCi0/EkDeicCWXgA4wTYtjgL+0FnqF49IhCajMU95ODFuyyiUKGgtwHIISHYV4gm60dWriMa0wsfwVGQAKOravoznAbP4iix3Dxaoth6RCE/g6v3bLRGPUbxx5YN4ueQbaV9uQbysaKk3LIiyc2APqOniu+BzEeYRL7P7xXLFUiZQI7CwBDuvPwE6zgc9LHKRvD+KYx3e61L5IkkIDeHPaN6qZ+H+hP8eImcTP6trq5Os2Wq/0svupN2vDzPlk6qIYpl637KkNe8Hm28HluqJwyiA2xSvQ+vmSXbI9AiK4OiQfHviUnQ/ECPpj2f0BWGCl8WuPLpiKaFWWNBwpJD5EdpEgsFCSeyjcoaF8AVuwycukBKW3A68LeKLBxAlPaa0Y+ZxVuSWmQGpBXRBZ0g7rC3bydhJDYGhLzaANFyqTFe7j0eP1r7crHi29BO7oPpfct+SDnaUk76VUd/W1HvgLeFShBvjILiwhyU9ODoRNMhlAWUzVsgKYfVIPVoGsZ7E18W/ti/fiqjURaTDqjbY3qSPrXVprGFIjDkiN2bzx4TWXG9CO7wVk3j1Eaeu3aElD7pSfqcN6R7b4dBXMHfzzXXelfGkuSDyna6zPu+fbkNd00D02qkoUsHJnz3jOwYBJgF5r3/sgRfGX8SmY10VmAT2msoBmuU4dVRfYJZSnr3/iEERLUGLonSkU
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 402bd53e-1f76-4600-9ca3-08d88944819a
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2020 08:57:39.9559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+YO1tSINcFETSawcgOtQNPqRXaoyRyp0wbuuT9mlgKS2e1yRIoNgRAgSleLTrDMt3OSda6K562wkhKyyaDjQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1009
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 13/11/2020 11:04, Johannes Berg wrote:
> On Sun, 2020-11-08 at 10:11 +0200, Shay Bar wrote:
>> On 06/11/2020 12:35, Johannes Berg wrote:
>>> On Mon, 2020-10-19 at 16:26 +0300, Shay Bar wrote:
>>>> According to the new IEEE802.11ax standard center frequency of the 160MHz
>>>> should be published in segment2 field of HT operation IE when using EXT NSS
>>>> (when supporting smaller number of NSS in VHT in 160MHz BW).
>> No, it is referring to IEEE P802.11-REVmd™/D5.0, September 2020 Table
>> 9-81- "Setting of the Channel Width subfield and 160/80+80 BW subfield
>> at a VHT STA transmitting the Operating Mode field" (where it doesn't
>> refer to OM)
> But you said above "according to the new IEEE802.11ax"? I guess that
> confuses me.
>
> Or did D5.0 incorporate 802.11ax? But that seems unlikely, 802.11ax D8.0
> was still in circulation until yesterday, i.e. after you sent the patch?

"Setting of the VHT Channel Width and VHT NSS at an HE STA transmitting 
the OM Control subfield" table in the 802.11ax D* files is identical to 
the "Setting of the Channel Width subfield and 160/80+80 BW subfield at 
a VHT STA transmitting the Operating Mode field" table in the Draft 
P802.11REVmd_D* files.

This is the source of confusion, sorry :)

>> The nl80211.c change is also described in the first 3 rows of Table
>> 9-274 "VHT Operation Information subfields".
> OK, thanks, I'll have to check that out.
Thanks.
