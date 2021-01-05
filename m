Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CF12EA6AC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbhAEIgQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:36:16 -0500
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:61901
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbhAEIgQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:36:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkuZuoELwP4es2gvQT7WQcFpqKsRHIXH2Hq4V9FnwG05D1lq1Hg53JLXcbsHKjBmVeNoHwZVlPrRg1YO5BEB5M8Wx93LOKgKNuqjkD/OwSHkTRiAUYGdjaQ4je0klzArmbF+snkf+fCjC52fxo1zVKXmFn4b7MT+eAVcWBTq/Zt9M3QuqBQIZ4UesdT5wjfxaom/L0MUipPXOwbApFw6K9+o1LsRwBBpwM4vMapjbKe9yzojvMag1zkawM5HT9SI3zRzkcGNdfu0YeSTxR6YMqMOYjyaMAxoV+gjcQA2QwXHAQv77yZ9oDXrJfwkH+VpWe+0HuBcmKwfa8r2671ASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5GZR6d3CXEEkH9QktyIjhguh1bA4X+YSCSaXZk+WV4=;
 b=INwe8SOOzrFL7dZcbtOCalQXy1y8uWFeWVcXj3fQD2rM6GUdAalOEowMVCQOkvuiOUiOzWzQ8mBaGDkcMorjJBC3D3p9SJ5v/dEnSCnG4AhwemEHQETMydn0HQJkc4dEvbHhbtryvCACeerilqP+PBFCp4S7lJJIm9m+P+TmFJ2CS78O+joLwY5nSQY0FwgkX1L51YYdeUDhpZwq5neLvhDm4xDYQULy78Odam1i4mppZXAx0Yag3ljMgUN5ZqnrMJwIOBhPz9WLhKFPRReDtyxYLzLgtJt9RaOJIHGJbjtw6OE+oio87YAsgFiZmmeushIi/qa4YsVD4aVVoI4apQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5GZR6d3CXEEkH9QktyIjhguh1bA4X+YSCSaXZk+WV4=;
 b=pcbOZb42YOVe4MCieZ9ckQQkMFeiPNM6b2mSdBV0jKQVC5BoT+M9C1AroJfyrXRbe3z5EUZIFl0K0bg1OG6z0A7KuLDmJL3czAU6T9hYFCIsUYyLlUlH9OH7Ph711sMjqvGO1G2hY8aXit+ypxX9NkattDHAMzVLP0RZGY44Fkg=
Authentication-Results: celeno.com; dkim=none (message not signed)
 header.d=none;celeno.com; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0467.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 08:35:27 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::f46c:536b:3238:a27f]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::f46c:536b:3238:a27f%5]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 08:35:27 +0000
Subject: Re: [PATCH] mac80211: do not allow bigger VHT MPDUs than the hardware
 supports
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, eliav.farber@celeno.com,
        aviad.brikman@celeno.com
References: <20200917125031.45009-1-nbd@nbd.name>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <6327afad-03d4-f35d-e7ae-17ea2fdf1ff9@celeno.com>
Date:   Tue, 5 Jan 2021 10:35:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20200917125031.45009-1-nbd@nbd.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [87.70.56.235]
X-ClientProxiedBy: LO2P265CA0459.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::15) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (87.70.56.235) by LO2P265CA0459.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Tue, 5 Jan 2021 08:35:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0150e5f8-dc01-46c0-22ae-08d8b154da68
X-MS-TrafficTypeDiagnostic: AM0P192MB0467:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB046747C993464C83A270DC02E7D10@AM0P192MB0467.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /M/qQabYLLbAqZFbJX5AblNmwpaQ/5LR6yS9vi/izUShuC9/zk1DAYrhq+BojAMyQxSROgASm3yYv2Lnyqf6FM7IBEwO2ZheepxxDgv/hWXrEJHGfjVm5NRZZWDRLipMLfMagCTr02JOrJGuZoF49IhQ8m7Umq4Z85IuDkbxlVo+wDmF4qpKJ6cXdxyWkRGDafRFs3zvEz7BSdKjfITFy8jFv4jNV64dKRTOBp9YGJjAbCtSp3nXhgBGF0bqsbJ5FjLgfCpJQJv9nL4E4BJvrOXfzClQGuNP+nZrGscgVYh7cricvKW7ncFNFMKBwHbxO912MFqQyH3WX3Md7/JTEq9JGciJ/xBP6B7K+HyUbDrT4KNomzF/EYkQqV65qxFlMx7IKVdCiPjTQgSAtd8HWecSNjRSbOrtbMuwyKGIrE53WHOxzb5ofyXVrJViHt8Z5wXSGCiJmZ9xisRekbZGJkFel0wjY+XG1KUHgU1KQe0ioyKFPFB0k9+N4tpuFD2d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(346002)(376002)(136003)(366004)(396003)(316002)(478600001)(16526019)(86362001)(4326008)(16576012)(66476007)(956004)(2616005)(53546011)(52116002)(31696002)(44832011)(66556008)(107886003)(6486002)(36756003)(8936002)(26005)(66946007)(2906002)(83380400001)(6666004)(31686004)(186003)(5660300002)(8676002)(135533001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dFpEVDJFeEVFS2hjRG1qckxCeUVYUE1Pbmk3ZTlnd0RFNk94Q0V0dktIZDZ3?=
 =?utf-8?B?ZGc3Zk1tbU92WC96S3grZVcvZkRhbWk0dXY5NVZJblJsR3lGd25icFFzWGs4?=
 =?utf-8?B?N2FTdjFGSVF2b1RBZ01UWktDZ3ZGbnl1b2FIYk5XMWRhbENFUlRFWVFKbmJ4?=
 =?utf-8?B?ZTRJZkxNNTlGTDNZakRDR0MzanNyalo3QVpNL3I1cC9ZWjZxZC9lby9PUDl3?=
 =?utf-8?B?blpOaUV1NndBYnRJTmJoZFBIVVoyUkJsYjhnc3Jxai9sVTh0QXJWTlZwYW85?=
 =?utf-8?B?ZTVoaW8vWWRHVm5ZWjBjdytBUVlDY3RKQk10UDBCdFZGK0Q5cVJHYnlnOElj?=
 =?utf-8?B?OE91SXVYb2ZpMEt6bmhvbFRvL3RoQm5Lc3pkUzlwZ2dYbWxRWDFVSzhOUHBU?=
 =?utf-8?B?RGFvK25uMTJrbkxTS3hUN2hiL2NZL3QrbzQzZE1NZGJvdkxteThHMVB3dG5h?=
 =?utf-8?B?Y1VLRm5rSVIwNzQwYkdYVGhiNGlkbnJLTU9vdUJ0MHk0UXZzWFVnUWx3akxs?=
 =?utf-8?B?enlBMUo0ajBVdFkvTEEzYWFrZk5MSTY2WElhRlJ6dlBLS1FpN29tM1RoWHI3?=
 =?utf-8?B?UUprZUJYblJUeFlwN0JrNmV1Q0xET3A3dXVvczZsM3ZJelZZbW1JRkF1Vnh4?=
 =?utf-8?B?SFNKRjJrdkFQejZPekVmQnJhNjlUemgwVGQzNzMrNTg3R3E3QzZkaHRXN1Vq?=
 =?utf-8?B?ZklKRjBtdmMxemU4Ym91clgzS0FORjgyS1RabElSSS9lUGdZSWNNaVJFalBK?=
 =?utf-8?B?MHVRTk42anhmaXJsc1BwZFdEUVJhMldGMUZoQ2dDbEx0M3B4c3hKeFk4OHJr?=
 =?utf-8?B?aUZFQkdDQWtrNUpPdWVWWWdOR1h3S3hkUkc0MG9PMlhEN3dvMEliZ0w5YzBv?=
 =?utf-8?B?bFRpak1aa2RYTnJUVUFzQ2pqNnUyeFMzT0VIZjVHUXAxcFdkSW44R1p3MmxY?=
 =?utf-8?B?cU5FZ1ZIN1ZpbnpDVWg4ek5VMVpHNmVRM2ZEN3NPOTRUeHNGZjBSRE41N0o0?=
 =?utf-8?B?K2VJNVI4NGljREovZDdJTVdqQXJHTnprb29qNHZIdTVaYTRadGprZUNJNTll?=
 =?utf-8?B?bUZqdGM4aHlEVjFvN2lsUjlGSWNLYlJuUld3YTFWRmZuWTFZeHF5ZHBSYUhm?=
 =?utf-8?B?UjI4QlA0c01GZ1AyQ3hoZUVzS0p1YXM3ZExoM29kNmg0NDZ1dWlnZ20raS85?=
 =?utf-8?B?VDlCbXd4cml3akVXUjFralZBK1VlNVZXRzRlc1UrNDhxaHZGVTJEeEw5MllX?=
 =?utf-8?B?Z0N3MGFJS0x5bzlmN2FyNlY4aGdDR1ExRm53dkFGaWxpM3N4R3JyMVNGSjlH?=
 =?utf-8?Q?meR/sI2Dr+8rQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 08:35:27.1552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-Network-Message-Id: 0150e5f8-dc01-46c0-22ae-08d8b154da68
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TWgpU3+m8z4TczoQCh+SzjjcBVY4UNcYcr0somjOFlft71shxIwG5XWoZ7f98Ki2zVVPZ4djYhGHlOc54oU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0467
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 17/09/2020 15:50, Felix Fietkau wrote:
> Limit maximum VHT MPDU size by local capability
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>   net/mac80211/vht.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
> index 7e601d067d53..fb0e3a657d2d 100644
> --- a/net/mac80211/vht.c
> +++ b/net/mac80211/vht.c
> @@ -168,10 +168,7 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
>          /* take some capabilities as-is */
>          cap_info = le32_to_cpu(vht_cap_ie->vht_cap_info);
>          vht_cap->cap = cap_info;
> -       vht_cap->cap &= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895 |
> -                       IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991 |
> -                       IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
> -                       IEEE80211_VHT_CAP_RXLDPC |
> +       vht_cap->cap &= IEEE80211_VHT_CAP_RXLDPC |
>                          IEEE80211_VHT_CAP_VHT_TXOP_PS |
>                          IEEE80211_VHT_CAP_HTC_VHT |
>                          IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK |
> @@ -180,6 +177,9 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
>                          IEEE80211_VHT_CAP_RX_ANTENNA_PATTERN |
>                          IEEE80211_VHT_CAP_TX_ANTENNA_PATTERN;
>
> +       vht_cap->cap |= min_t(u32, cap_info & IEEE80211_VHT_CAP_MAX_MPDU_MASK,
> +                             own_cap.cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK);
> +
>          /* and some based on our own capabilities */
>          switch (own_cap.cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
>          case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
>

The vht_cap->cap IEEE80211_VHT_CAP_MAX_MPDU* reflect the associated STA 
_RX_ capabilities.

Why would you override the original STA _RX_ capabilities (vht_cap->cap) 
with your own HW _RX_ size limitation ?

e.g. if HW support 11454 in TX and 3895 in RX, due to this change, you 
limit your TX to your own _RX_ limitation (3895) while STA actually 
reported 11454 RX.

