Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C4E4D57C5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbiCKB50 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 20:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345462AbiCKB5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 20:57:21 -0500
Received: from CAN01-TO1-obe.outbound.protection.outlook.com (mail-eopbgr670060.outbound.protection.outlook.com [40.107.67.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5287519E738
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 17:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mxa6kwYKC7TCmrVwp4qEYtq9aTqJo/is6p45QmefX3hb555XO8bviWF+APPmVzJ+ytl4PGM6Eu6WXqeMKKhybiexNmyTjkAq/SHG2kh1HlDy/WN1rQ2xpSQcsNc1aR4fm8ayW8sk6V8bmmKuKi8nhhth/ZLm8vlSbGNbrkjrk2WVemRfTaFzYDMhNVCeZssFDIzE2YNzYHTDmHu4wxxvtxx7O6puW5kI6oHiZXuUHuBHlkxM/yM9TShXEcFXXiVNlnPSStKlNA/XukR0fRbber9iUO/I+q5hSjJ1pK+32gxqcRAd4dlm40dOdDvjN6B+ctsS7I6LXoD1IoGrd4d6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn/QMc4Sbd0OAKfMjkyIe2OBq3wHgk3hi/D1g4929gc=;
 b=VK7mhPAyyAESGp6JlA64VH0YAFae5r64MN6T/+3riybMMhgGa4tKKF65fKrwLHf0nQbuC7f34uZPbjwFT5sbGt9OoJJjfAV3uPwiLtZ5FGs7Q5NraOOX1XWaMjUjlT9WvyKwu3IPKATg9Kg3ZnBkOSSTlXuD9HbGvDim03zDKyhyEnhXVkgPoWbLvQgFvinX6epjuc8QYfrxNdRM8v2hazzydlUuOOeGrjd0uKyBhwamnfrBIaLlnWdqTbVrES5dE5rqqSl7hYUBY2zaoZ/pjcizrhIBADs7glf8LRwPcxUh02m6L93EuVzpNqM8R/LFBcARkLKoyRkE1uuQo4kyzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB3930.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Fri, 11 Mar
 2022 01:56:03 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::dd8c:6e57:c431:9323%6]) with mapi id 15.20.5061.021; Fri, 11 Mar 2022
 01:56:03 +0000
X-Gm-Message-State: AOAM532LygI/iMIsLDYYyoOKuUbeHjUPXOquuSGHVGj/opqWdUcMgYeg
        0VNJtFQGdgZTus77Oz7z/QfqH4DeFNKeR9oXHn0=
X-Google-Smtp-Source: ABdhPJy1lS+jnFEQ7Lb0YLB9Viu4Z0H6axsGxr+nz9IsNTeITgVJZLOKdqfCbZzmrRXCBnR5vmfUY/EDRWJoc3u+tEE=
X-Received: by 2002:a05:622a:1a98:b0:2e1:a40d:825d with SMTP id
 s24-20020a05622a1a9800b002e1a40d825dmr6610847qtc.56.1646963760674; Thu, 10
 Mar 2022 17:56:00 -0800 (PST)
References: <CAKe_nd1jthFhJhojQLXMeU741AoTks74K+J1v5FqS6ABB6gW-Q@mail.gmail.com>
 <87r18d1upk.fsf@kernel.org> <CAKe_nd3Hc+5u9O0Bd31oFF_mTOJU9bx5hmcS1TkSy0FMtQamBA@mail.gmail.com>
 <87mthyvhev.fsf@toke.dk>
In-Reply-To: <87mthyvhev.fsf@toke.dk>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Thu, 10 Mar 2022 17:55:49 -0800
X-Gmail-Original-Message-ID: <CAKe_nd1A4PBZKEFTARoFu8aStWmRbB8-WkCU18g-2U=VoZx5NA@mail.gmail.com>
Message-ID: <CAKe_nd1A4PBZKEFTARoFu8aStWmRbB8-WkCU18g-2U=VoZx5NA@mail.gmail.com>
Subject: Re: QCN5502 support in ath9k
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Kalle Valo <kvalo@kernel.org>, ath9k-devel@qca.qualcomm.com,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-ClientProxiedBy: BL0PR02CA0106.namprd02.prod.outlook.com
 (2603:10b6:208:51::47) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46ceac3-4aad-42d6-8df6-08da03024bd9
X-MS-TrafficTypeDiagnostic: YT1PR01MB3930:EE_
X-Microsoft-Antispam-PRVS: <YT1PR01MB3930C9209A55C7402732C809B20C9@YT1PR01MB3930.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjEwSdewA5VVm7nEEnSosoD4E9SjaCM82YaZH2LHbP0i8ouCMkWGzGgcdgn0UfVjEB8RK+mqx68PyikB8FRPaBdvfmpFHf4Wmg+DPCM9xXnoVbNx4lXQqSef2cD28Z/wj//J7vGpcrAIu0T3I50e9IeGfzpzGiKVC4gGa5AzwTa4d+29aYDJvs4CjCSN3eI9LAic4EJLCdZsUyRaYWPe5b2E0hYBcclqJ8KZTiIC7bclFkidKBUfSYce0Jf2LLa8w/qRzqqy6NjEoL8NsZQvrpqgeHJaToh/g5yNOd6fMYgnT3NIwr18CY4zPXSbR4+T+DoSb68i2Ax0nFN6+cI1m1gK9p60K+I//XZiBZSRcyfRVZWI4cFeKWVOZZAbPEIJgHRN7xmDsCR1S9hynzf8jfuKNJm4W6Lv0izn3YvC4h0MHqXGF0mT423FDjNlANySNnIDA8GdBf+Fee39K3o4/YEfHUbQtBr5m72m21DavqDIwaHACo/lqfsafRhajWGXDPCYhmPUIJfJ2RMytDsjxrVKvN7wzlzbmwrkOeM8+dxMZcoo6pUIb4aBtH8nzQSgAieuf5ebq91u1MK49uxdC6oCFDE/5imDR0hafbmfYmfZh5ikkmwQK3SBfJ6bCFkVtN1I5XhcaPkJJ/bY2G0OdwHul/jQq84mTVmreaT20lMb+WTv2Qe9I1KOuZ/O9gCqWBHRi31wmQ9Q/NK8PriM82gfVGqw5b1kvUoJZMaw08gJBaBh76WZM8E99JjGdUZ4liP7HCFr15Qlmk7Ig8HdEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55446002)(53546011)(52116002)(6512007)(6666004)(9686003)(8936002)(5660300002)(6506007)(55236004)(26005)(186003)(2906002)(86362001)(38100700002)(38350700002)(316002)(508600001)(786003)(966005)(6486002)(54906003)(6862004)(4326008)(66476007)(8676002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NS83N3UzVGt6TUdzOHNDK3VFOExHaHhvZENNbkZrYVk0ZWRmTUtXYVczYWJJ?=
 =?utf-8?B?WHFBZDcwY1VBV1c5VFJURW8zcUJoMlpEL2tSNkhMYnNwNFd0bS91WHAzK053?=
 =?utf-8?B?KzhlbHVsaGxVMEVlRVg3c2ZDRnNEaXdGbXlzcFRuNit4U2NQellUczNjS0hX?=
 =?utf-8?B?Y3BzYm1IcndhM0tWaGNPQzRLc2Niemt1RWdWNUxFVjNZNm1pd09yVkJUV1hs?=
 =?utf-8?B?WXZvMkUrRjdLVXh6Z1E0dGE5aG1HVWl3QzZaYkNsOVh0L0pvVHFlR2JBTUdO?=
 =?utf-8?B?Vkl4b1RuUTBDNHU3RVd6Slh3Yk1vOTBLQ05mUmxqK0d0SW1hVHl1TnhRVFh6?=
 =?utf-8?B?MEtZaTZteVhqMmh6bm1aazNyTnBkNWtDWnkvZ1EvL3hYUXBDZHZoZHB4eFJ1?=
 =?utf-8?B?OHA1Z0FreEhrNm5WU2tkYnBJdzRLWnIxV2pIREJMaWV0UDZqUTB4YnNuVFp0?=
 =?utf-8?B?bVN6VjlGdlo1RmpSSlZZQ3NwODNEZEFZS3orNnpqeUVwVFVaUDVEaks0bnlj?=
 =?utf-8?B?VGYrejNIanBEM295MnZDNTM5TkdZRjRZQ3Q2WHQ0M2RSQW41aGdEcnQ0WDNE?=
 =?utf-8?B?Z2o3cHVaZlJCSUppMWYvN0FkVjFhdlMrWkxBSG83LzFMaGd2MjJtWjlnVHVQ?=
 =?utf-8?B?amo0YVlpVmw0ZVdqMm4xSm9iQUhnaUVJemtsVDZqbXJvUERyUmd0d24wSnR1?=
 =?utf-8?B?dEZtby9aNDRlMm45cXp3ektwbktjNVI0b0x3dmNJcmd5R1A5YVdVK2ZxSE5h?=
 =?utf-8?B?YTk5WllLQjBqOGtzWWJBUDBKYUYwNDdZdExPQTd2ZTNnRzBBTGg1OTNjOGg1?=
 =?utf-8?B?c2YxRWFWa3paVnhsaEUzVmZIYmlQUHp3dWlTZXVGNXNoV3A0Y2hDdm91WHg4?=
 =?utf-8?B?bFJyWHpBaFo3R1VBNlhpVndvMzNmQXkxZllxRk9zbTRmTFE3OUM4SjJ3RitH?=
 =?utf-8?B?YWV6dHlWWlZCeGxud3lmMWdrd2lXWGZDTW1MNEc1ZVBlR0lmbGxrbG51RkV2?=
 =?utf-8?B?Q1ZtaWU1aGFKc2xuUjMxZkFpQnpnUnNUSTI1NW5ROC9SQ1lXclkvb0dvcWNG?=
 =?utf-8?B?UXBiTjRCekdKVFo0RXRHb1RmUFBpMlBLOWZTREpmKzNiSnRWMUVhdWlTS05n?=
 =?utf-8?B?WVpnYWhocm50cXlOYUY5VmRtQWl0cWhLeWV3QTcrYytBWVFZMzRRV0dUK2ty?=
 =?utf-8?B?WlphellvdldGazlaQXUwdjBIb0pUbUY0RjBma1R2ZHllblAxM0ZLVGRqdlZn?=
 =?utf-8?B?cjlpZ1RYV0cyWnpEdmN5Y1dtNDFoWjlQQ0FUbUlTV0MzckZPTTlVcFhYQ1d1?=
 =?utf-8?B?MC9haUhxOUFlQnRDOEp6ayt3UFc3S01oTTVaK0hGSlBDb2dVOExHWU1KSmxu?=
 =?utf-8?B?K010dmFZNE1sZWh3akVaakVVMHJrTHpPczVCRFlRSGdTUTVuYWVzV29GMTlC?=
 =?utf-8?B?aWJWYk11d09DdUNVTmdiYi9BWkhROVhzNTFjVTNZTGNmR1RYc0dKTlY4alN2?=
 =?utf-8?B?bEtESUkzY2lNVnhqLzVlbVZuVmowaVVaajh2N0tJcUpiM3NBNWVWN3l2VGw1?=
 =?utf-8?B?YkxoeElOSFBLTkYyMlpVZW5iOFN6T1JzZmkrNWVvRDgxYlg0cnNydWx2SjFM?=
 =?utf-8?B?OGJweXRtWDF4cFFmVE9oY2c2bzhpSFRUaW5mKy91STRoK1hFaXR0WWFzeXZi?=
 =?utf-8?B?WUNDeTgvSGdwL2hORzh3YmxjeEV4Nm9ocTVEWlFKOUFrSXJBd05abjBUNTJI?=
 =?utf-8?B?RVZtQlF1N1VpUFhaZkpVcGFGOTNFSnBWRFhRb29LaE9uTHJkOVVWWUxHNy9X?=
 =?utf-8?B?M2xiL0xUK24yUVVqOGxRd2VPZG5td2FSYnBJVkdkV1Nud0JrZVUrT2hGNGtx?=
 =?utf-8?B?c1g5enNxZUNDRG1DL2ttZGhXWW5aaG9JSDQxVXB2K1N1STNGbXJYYzVTazRR?=
 =?utf-8?B?Vm91NnVFS2pQcXJGbkRLbUV4aWJUTEh4L2xiMWliRW5Na1hZRzg0Sm9ZV0ZL?=
 =?utf-8?B?RXRzeWx4T3M4YjFHb2l2ZjhkMytnM2FSL1hIdGR3MDdtU2FtbjhYNjQ3NFVn?=
 =?utf-8?B?MmgxUjdEY2c2SjM4bDBLb29iS0d1SE9meGpnYWRJRmZlOUdFV3QwOEltWEZM?=
 =?utf-8?B?dzJwZ213OEZoTkRmMnhBdkV3cEQyMUhubEJBSmJ0OTFybUFNb3o4UUdWRXZv?=
 =?utf-8?Q?oLWKCt11vRGfHapkT8q/46k=3D?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: b46ceac3-4aad-42d6-8df6-08da03024bd9
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 01:56:02.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c0GEHTYNhmlS55S/6CZvdlmjUUTYzyA5bQ0r1O2u0ganr4wgdhArGfI4wNcB2HPOo1YRLgroY3EIFAz7HVxKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB3930
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Mar 9, 2022 at 3:24 PM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>
> Wenli Looi <wlooi@ucalgary.ca> writes:
>
> > I've managed to get QCN5502 working in ath9k in a very hacky way, by
> > mainly treating it as QCA956x, including the initvals:
> >
> > https://github.com/openwrt/openwrt/pull/9389
> >
> > It would be great if anyone could provide comments on the code, as
> > well as the ideas for incorporating this cleanly into ath9k (and
> > whether there would be interest in doing so).
>
> I certainly wouldn't mind merging this support if it can be implemented
> in a clean way; we'd have to be sure it doesn't break anything on
> existing devices, of course.
>
> You'll have to split out the code to co-exist with the ar9003. My
> immediate thought would be that it would be a mistake to employ too
> clever tricks to maximise code reuse. By all means, try to reuse as much
> code as possible, but I'd rather take a bit of code duplication than end
> up with something that works in non-obvious ways :)
>
> Hope that helps!
>
> -Toke
>

Thanks, I'm glad you would consider merging this support. Sounds good
to avoid something that works in non-obvious ways. I'll think more
about how to implement the code cleanly.
