Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92912AAA09
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Nov 2020 09:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKHILr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Nov 2020 03:11:47 -0500
Received: from mail-eopbgr80047.outbound.protection.outlook.com ([40.107.8.47]:26016
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbgKHILr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Nov 2020 03:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BesfK9rS+r/ODIBeCrHAxu6zkPb3mZ2BZ+c7xNB71htthnemXwASIqirn9LSQJIfFP3mqJBW6Cb4DN6vpyDwotdKXrXUJu0rKfG5aNcIHGuhhjhIWvu0Itrd2bwQzAq+FWdY7zI1aSNEeWszdDzNf2rB7Ol2dipnUG9wtcPdpqBjEqnJs8ihtqmcUQnQpbnZnqZ2LDXR/6CqCAMHwnQrRjqs6/KuLE02az2y3mbbKjQdzbkPR2jjMdsoGp8WL21EwJyeyR7gH5BXvE5sbkSisVQj3yrOzPcCV0yvVKjTQTUxuC8rWROFUFBez3eNqqC+ZnqWZdD3m7rM9ZrhQ52e/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0Kh7McH8iSaCbSmC6yLwKRWfhlQ4V18A8vPgEHi75g=;
 b=FihVGCJVaH0d6tGAmORt6QE1xV2SNryIvtqVpzEqM+1XqMm/CM4zGG20LU2ThVlC/YLBsJfWa46TN6C3n9n4FETTUmkNqmn6iIMHNj/yAUQVXPt9MRiiqFL5SqPKD1YnrckBliAUP2/LzbAquUcWiB2j160E9/aGbSrTdY0RKiqukpgU3p8f5enaZRQ22nVhtfz9dPUqQFCof9qWAXx9I9OBmLAperpE6Qkr2jCZGgxCpbZjvxPJpQvE6wjUwMdVLrq2YWdMeYrFT6Txt+r5umd4AoPj5CYMpSspwfJH4aVSiHSrU1SGCRZm5QxKQJ/NNcc70X+haVbv/2rflb/1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0Kh7McH8iSaCbSmC6yLwKRWfhlQ4V18A8vPgEHi75g=;
 b=KXSBpr3NdsU5ZyZTZJ7/CKO/znDDwvuI6SJzU++b4kFZgkWz+xvPp36aYuPymZkq9mySqVAj3xeRVsBbGHLqeeYpPsbGTnG6PD9ig7BnPYSDfpqmF7cwLP9b+ksPVAKu72wrQvAYYyKRP884CsLW60fcS9Vcjz+EpVl3HSH02ss=
Authentication-Results: celeno.com; dkim=none (message not signed)
 header.d=none;celeno.com; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0434.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Sun, 8 Nov
 2020 08:11:43 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::148d:ab6b:a633:c543%5]) with mapi id 15.20.3499.032; Sun, 8 Nov 2020
 08:11:43 +0000
Subject: Re: [PATCH v3 v3] mac80211: 160MHz support per IEEE802.11ax standard
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
References: <20201019063921.4335-1-shay.bar@celeno.com>
 <20201019132616.32286-1-shay.bar@celeno.com>
 <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <4f38e1cf-fc8c-c9fd-e064-e433a8b82186@celeno.com>
Date:   Sun, 8 Nov 2020 10:11:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <9a043fdcf1c6324688f4c92b18f31c267969f5fc.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [87.70.55.13]
X-ClientProxiedBy: LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::21) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (87.70.55.13) by LO2P265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Sun, 8 Nov 2020 08:11:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39d9ef1-9d9e-46e1-989a-08d883bdedaa
X-MS-TrafficTypeDiagnostic: AM0P192MB0434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04344309A03B0BF2B94005C3E7EB0@AM0P192MB0434.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5cA8Fb1JU8bjZiIPPFvDyzhq4CyM9nj/F9XJWqp60fV+Fq6WMIvKvU7Z/hHPrFj4MCcVRmwQT66Mw9BvsbmtvP+I11auWCfO4mnF0STdRsob7L+3aiqYqLZSR66rcJuHa7sRr1pptiWD7LqbOpRqkJ5TYkTgFvp75YuvdH9lfSN6k7Qpor93vSNt9IdFXZEio+yCCguJ/ewREdMqYpIpvZ8kkN2FYatpp+4TDjfONfbnplK0nr4SDv22nYwwCgBMIPmTxuP7mBhLsZOSKE5Dr9/0rdILqnATl224MOpZWdeRW76rFdlEzQ9qRKy7E9Tw4q9GwrlDp/Qel6VzmnqRZF3eo923+s2Ot32i87L++nNEcJjVs81vV/9UuX5nucm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39830400003)(66556008)(66476007)(66946007)(6486002)(8936002)(4326008)(107886003)(86362001)(2906002)(31696002)(6666004)(5660300002)(26005)(956004)(2616005)(53546011)(478600001)(16576012)(36756003)(8676002)(31686004)(52116002)(16526019)(186003)(44832011)(316002)(4001150100001)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pmkmq+8hRhoJLmWJrnGNZ+ZcK6dhT4QJc2tx8xgULKNYJ3gWkGixe1O7e+jH/e0TUuA0aV0iFYQ4U8xwKnq5RopRzjVkg+FmsimNKarij3jZ128LgTqKAXc8yAyXsgq+8CeGGHf3ZjhdwIJ1BCNA9kqkEuKnTWMUkYNM03xtQ1BdtX+eJgUP4Mm9qw5D5MqooZg1W54S3mA8CYlo6ScwqliV5FWqppyI30WLjTQgVRHKkVEPkaMoDDHtMDUi2Kj2YoHSQGIM+oPLWHa/ntMyZMLRydwleMYkCErivQhCDQTFJabkWk0ClQT4nQceJQ+wdF9e5pJ1SJBP4UX2p8R0MZWGX/m6Ndqcglfn+3CnEG+mKkPa8XlAqLmm4sRtQ52mOSJivfRjexvVMxhNH+LlnD4iFh2DsFQFwejWbagi/AAQi9X4eSlCevQLtZ5I47TcNv+RaF1uiR1DslcT2THxfC3/Z03QeBBRelK+lQovM23OKhsVsHnf03detRPFsbZP5rRXD46sl/V/WeJw66E5eJY3UgvtzM2dVSX7oAOzD4urnjWgnijOevOC6jgsf53+yBUYZ251Cl/v/C9Akfk5XfDmZCsUwx6zhEW2f9lfH7Tjp6Xs3LhTevr0THBEKTQ0x2tUmTpLEDCfEZ6WmWPfvQ==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39d9ef1-9d9e-46e1-989a-08d883bdedaa
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 08:11:43.3992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okPL/4MEv5r2YlDT2y/5Q5dKMGI6E6f5fo7RnUogwNl1jCN4TRwUqIEiME3ZGjZtODCmVWNFRqZA5YbpSDOIvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0434
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 06/11/2020 12:35, Johannes Berg wrote:
> External Email
>
>
> On Mon, 2020-10-19 at 16:26 +0300, Shay Bar wrote:
>> According to the new IEEE802.11ax standard center frequency of the 160MHz
>> should be published in segment2 field of HT operation IE when using EXT NSS
>> (when supporting smaller number of NSS in VHT in 160MHz BW).
>> This patch adds the required support to mac80211, cfg80211 to parse it properly
>> according to the new style as appears in the new standard.
>>
>> According to the new style, the AP should publish that its bw is 80MHz and not
>> 160MHz.
>> A STA should conclude that an AP is working in 160MHz if it publishes
>> the center frequency of the 160MHz bandwidth in seg1 field of VHT operation IE
>> or seg2 field of HT operation IE.
> Is this referring to D6.2 Table 26-9 "Setting of the VHT Channel Width
> and VHT NSS at an HE STA transmitting the OM Control subfield"?

No, it is referring to IEEE P802.11-REVmd™/D5.0, September 2020 Table 
9-81- "Setting of the Channel Width subfield and 160/80+80 BW subfield 
at a VHT STA transmitting the Operating Mode field" (where it doesn't 
refer to OM)

The nl80211.c change is also described in the first 3 rows of Table 
9-274 "VHT Operation Information subfields".

