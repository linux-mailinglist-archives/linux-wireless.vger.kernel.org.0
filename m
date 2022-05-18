Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C3052B21C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiERGIy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 02:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiERGIw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 02:08:52 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-qb1can01on2041.outbound.protection.outlook.com [40.107.66.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F56EC6E65
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 23:08:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTYzgn4Fjcj5idKAGVBoRF5njDPfaJEI8uT9Btzvxy0NdURIjE/s7VH1hY3r1Ctl5wY+jCvrjQYbqDi7l5M0OKS8BVy8SRfXT86K/cay+ovm/Bar91YKqt8jv8AW4/OCRY+nVGk79E8JIS0znXBgNpG+92BOQ76FDn5LJ2VfLD2B5SaB5tKIRQj8/hGplYmTa0Hk27SF5bww2sDNJcPIWUXj8p9T77iEQ/dopSO4ibFx9NIsHL0/2rLIXd+0kG1JI7MJeqUrEsD/Pd3kWSNJA05WrtVVcK4xuyefcUFFaLBQ1kzhn+IGB5MdAFPoRNst52QHAdJyVArz9fsMv8o17Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZsWiz7EIHLLbKD2FcBwMgkmLuu7RysGL6gJwqNKhdk=;
 b=EmgXSVkr5MQLpj51cs+AzAfTQgHxPv8xQacWA86WS2gSr1c4q6pEgiMXy7JLsku1MELjZoEoaQeXZ8wFxAMnQ77EqS/VDY5EjFFXEBMcSmAKwPnyfD3c0FEwoDs66cZr4PfrJjhtXpJx3pwNugPFMtMA2TUIeV8Jnx1LU53HT864LhGAhyhhIAFkO6gCfNeJqT8CdiOe7dTzkDiOKSJWBysp23rP8NFK06DcZnsZv8WzM650Ne8p0vuNDkMS0VpU2xqikuZkVxG+bOiXDIdgqxcnpnjauUTfHU44VThjYSgbWqpx35vOJf+TPvLPDSYGBj9oedFKVDFuH1mMXdbY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT2PR01MB5888.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 06:08:44 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 06:08:44 +0000
X-Gm-Message-State: AOAM532k3LNi8g4QMWWeJKVQ2Dzowv5QIGwprBHEwXtmOzXm3F0r6P5U
        UZxlAZTln/e9XGoRNzRxI6wYSyMScL+hvLjiQ+E=
X-Google-Smtp-Source: ABdhPJwOzADeZ9yHvAk3xsEsyXl3w0PHgyujMicAFnImbVSud1zIv8HijtNGzwVxz68coE+8LW1CYIzzGU3jSgHQYQU=
X-Received: by 2002:a05:622a:6184:b0:2f1:e213:9c7 with SMTP id
 hh4-20020a05622a618400b002f1e21309c7mr22686993qtb.467.1652854122353; Tue, 17
 May 2022 23:08:42 -0700 (PDT)
References: <20220512195319.14635-1-wlooi@ucalgary.ca> <20220512195319.14635-3-wlooi@ucalgary.ca>
 <69feb893-d73a-46e5-fbe6-2f49e091c625@quicinc.com>
In-Reply-To: <69feb893-d73a-46e5-fbe6-2f49e091c625@quicinc.com>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Tue, 17 May 2022 23:08:31 -0700
X-Gmail-Original-Message-ID: <CAKe_nd3u+iiCGC7M_i+ovF+_bgDMkFUh0OpJ7HFWMhmgZQa7bw@mail.gmail.com>
Message-ID: <CAKe_nd3u+iiCGC7M_i+ovF+_bgDMkFUh0OpJ7HFWMhmgZQa7bw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] ath9k: basic support for QCN550x
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:207:3d::28) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e5ac18-1f32-415c-ca25-08da3894dce7
X-MS-TrafficTypeDiagnostic: YT2PR01MB5888:EE_
X-Microsoft-Antispam-PRVS: <YT2PR01MB588846D00CA323086B57385EB2D19@YT2PR01MB5888.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vkgja1MoRXKq7Rip/ElNLLUoAQ0vON5YqgRSliqRNgwaIMpKWNd7ZzKIHVI5O1cO1B8aII0bJmFXByFA3UVPeaIbLrVVfIW113wzIjlgaJ2PChdR/1kqwdgTR1t9JBBhqYxmMH1gfD8TbY3bCz6i/dTf3uKtcu0SJV9xaiV6bPmQhVWFaM6mf9oMpBUrQPh0lgW7bb2gLZB/lRoNarGOH2iMhgQU9OMYjb5884WyJ/v9YUreDxH6IO+55/NGXMzk/7/9wn9jemgU1aOWUP/Ce9qh7ns6NG3HKW745+QLWc7cNCQf7GmzJCBFSpnsmCWjKuj7t+F5oM5BuX0VSUXCfPz9hIQc901hIPanvMTYOmAHt2NogfU9DLMM33hJbsYswIDJ+OxOS9Rdw2Ucb66312cGYE4ajvCuBnqRzdnAEbJI/c1stgHTucKcFzJHtrh6npU45JoemTtYe/3fAfz3UQBjJgEVvLPj0G2gkVvj3eGLGapl0g+ebPoDAiqpfhlc0LZYcDetRJ2cRyHDkAIH5wBee4ecoD1poG5PzdNwdnD9GZo/UobGPOb8eDz8O99vxIK8mlQr5tJhP9NJ8Dgt0EJBseDW0RC5g7+/Zfg08OFS38EMLhiUicnp+Pftu2mT+t24caYHHrG93jDkUeDEi1aB6YV6t+wufNphtWStV+FyAcxAfC6WbsGFyNpVVwOYipDx+m5CbCAm8wbEdSG9Tq9mSRfpBI52Q7Wf4a1uGieghlMp5XqnVXCJSG7dVIHrRHfGA4uVT5dJYEkaPo8yjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6862004)(54906003)(4326008)(186003)(38100700002)(38350700002)(26005)(786003)(86362001)(9686003)(55236004)(6512007)(6666004)(52116002)(53546011)(5660300002)(966005)(6506007)(2906002)(6486002)(316002)(8936002)(66476007)(66946007)(66556008)(508600001)(55446002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFVObnNHYXBPZ2E1VXc2SCtPTThTYktWRG9HZFAvcGdPdHU2RnEzSHR6emI1?=
 =?utf-8?B?ZWp0cEJqTlpQOFVRRXRWTWlHalR1cG1ORmlMcEloalQ3blFZZGJKQVlNSy9n?=
 =?utf-8?B?MkcyVkdIZk5rMHJVVzJ2M0xwTnE3ZUNzNWdJV2llYkhYbmN4TjY1KzFuSXZ5?=
 =?utf-8?B?TjBTSDVqcjZ6WU1zbjQzU3pwMEVpVVlGRE1wc216YUgva0lKWXlXRW9VRFNq?=
 =?utf-8?B?cEZWWHVPeWwyYXlNY0crL2JhcFFoWXRpbHlsaDJmYitpaThMNHpLNzNvSDVk?=
 =?utf-8?B?b050STNGaFJJMDE1VE5ybXBVeVZ5cXQvNDVETUhrSjFBUlV5RWRCTXByQmlF?=
 =?utf-8?B?UDN0MnZNUllpMHJNNzU1bkNTQkVGMVE5bkNxUGF0c1pDSkhGSzVHZ2trTjlO?=
 =?utf-8?B?dDJmakE2TTFObnpMV0JBejlIMjVNOXYyMHhzYnpqZ0htUHBSZDBqaTMyT0Vn?=
 =?utf-8?B?UjlWak0yN0hMZDhGR1FhSnhqWVFxSkgwcDBXdWhHTTEwSWI0NjlMR3gxWWNR?=
 =?utf-8?B?aE5jQys1WTZaOHhLRzNhUWptMXh6MXRBREYrNWpabmpwRFgyKzVqUWgwWG9T?=
 =?utf-8?B?UFkzTG1NYlBERGdBN005UXFhMHB5djA3YS9Hb0FUcDFWc0ZYUy9QellWUUtP?=
 =?utf-8?B?SU1KQmlBYVA4WjBDWUhITmRZY0VNMi9zQm9qajZBNlVpMmtxY1RnWmQ4L1Zr?=
 =?utf-8?B?d0RRUElFNXVKYVorNkpHV1pKbXBzaUlIY1dJZTR2Y0VlVjIxVnRYdTNHdXE4?=
 =?utf-8?B?dGNQT2UvRFVqZ284K05tMGJ0RTlzcnFXRU53VU1qQTU5Uk10OUlpN3ZpK1g2?=
 =?utf-8?B?bWo5c0hxU3NyUWVYWTFGMThLVWRuVkt5NDZwYytNMVVkMHA0TExyWnVLNEpo?=
 =?utf-8?B?bmpTRWs2SlJ2WSs1eXVvM3Z1Sk84SXQ5Tm43Z0NveDdReTVvMGVza295M2Iv?=
 =?utf-8?B?R3FBWDlQNUJhOHNvZDRheVdOdm9wS0tFdGJvbzk3ZWRvVC9SL0J4YklDVGdv?=
 =?utf-8?B?TVZPZWovbVJtaFRQSGRDRkhSb1REbGtwNmZ0QkFpVTF0K0RjYnBLaEhWUXhO?=
 =?utf-8?B?T3V5d0JYRk53VWVwY2w2V1oxNjRvUWZnc1lwQk1LZGx6d1NyOHFnZmFiWDR0?=
 =?utf-8?B?dVQrT0hGcTl6TVVJRWNubVdaUkxLaFdnb3gyTCtUM1pMb1kxemFMbUM3b3pn?=
 =?utf-8?B?aFVkSkkxZldMMlB0bWJ6eWZTQmJiMkV3dE1Dc20wTE1HRjg1S25YQ0dUTUpW?=
 =?utf-8?B?U3c3dHUwZ21sUVRTYVN3TDBQc2VZcTg3aGI4TThPTTIvL1RFKzIyZDZyUDhS?=
 =?utf-8?B?M2NYd095dndFU1V5QmgwSk1zZ1pSWUJkZ2hEL2wrc3JOeFA1b2I2dmZHbmw3?=
 =?utf-8?B?WXoxUEtoaTduSUhyeDF6aHRRbDVWL2RGYmdIaGM3WCtZZU94Qk9vb1g5RnpN?=
 =?utf-8?B?NmlMK05tM3pabXpYQkhEY1VlYWR2ZXRWTlBaTnR0NWQ1ZTczQVcreDJLN0sv?=
 =?utf-8?B?VmI5MFlCWlVyaGppRjdZd2ZlaXFCK0VkUjBUN0svMlZOK25JcThvb2hmbm5r?=
 =?utf-8?B?RXZ1SDU2TGE4TW0vbjJuaEJjK1BJWklkZnlpaHN6cE9yTHlrb1FIRElWTXpx?=
 =?utf-8?B?Q1lBQ0g2STg1OEFoS0NDK0NFUms3d2piV3VFeDNUUCtxOWRFYzJVSFhQUG1n?=
 =?utf-8?B?bVNSWEVjN1Q0TUtyZm95VWNoa09SQXF2Z3dlSGdQWFdNa0hwM1lVQzFXTXVN?=
 =?utf-8?B?ZStob0xxS0IxNHFsL2ZrTFZwTExZL255d0g5S3JuQ1puUmFHMG1mSE1SM09M?=
 =?utf-8?B?WmRHSmpRcGRYM3p6cDBnbURVRURMWVRzRUtHMlAwN2JyYnhYKzVNUm9FSDIv?=
 =?utf-8?B?ZjduLzhWMjdyNFY1S1lsVVR2SXZTcFh0N0NIOHV4eG9WYnB4aEhXYVppZk8y?=
 =?utf-8?B?T2lhYTJ1R2hNUkUyNlQrcHV0dGJvUUdTbHFjeE82WXE4RzNxck1DVGJEazM3?=
 =?utf-8?B?bU56K3ZwKzAyd0YwZkYwTSt3QnR4WnVkZHNhQkdoaENKalNLUjJSZGRUeXdx?=
 =?utf-8?B?WjFtUEpjTXZWM2RHZ3A1c1M3Qko2bFJkam1vU2dHdzBGYWh2RDlBZFM4OHRU?=
 =?utf-8?B?YXAvVGxIaUZpbnRIRW5ob3dSM1NZb0FObWlBenlsTHJFQXFBVEVvYXhzQmox?=
 =?utf-8?B?azIyOXBoNHA4bmZUTDV1K3lEQ2JoQ2RleWdXSHBrTmdCSGQyK3lLUERNSFpo?=
 =?utf-8?B?RC94V3FXVWkzZXkyQUhqY05adW5WRHBxcXVNVnBFbVpUM2VXcVk1UkU1UTh4?=
 =?utf-8?B?WVlUamM2RmJuYmwzc2RLN2ltckMrWTVRZ3orRVJtaWw0TGhvWUE2QT09?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e5ac18-1f32-415c-ca25-08da3894dce7
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:08:44.1495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vduTGwqQEJEIzSO29ZXg/UqCuedzZVW4nidsdypxL3ihLP1d3pmQ/hYPw5mJgYxRHT0LtVdVBJGbWkohei0Lcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5888
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, May 12, 2022 at 2:45 PM Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> On 5/12/2022 12:53 PM, Wenli Looi wrote:
> > QCN550x is very similar to QCA956x. Note that AR_CH0_XTAL is
> > intentionally unchanged. Certain arrays are no longer static because
> > they are no longer constant.
>
> I don't understand the last sentence. You removed the 'static' keyword
> but left the 'const' keyword, hence they are still constant.
>
> And I didn't actually see any instances where the arrays are being modified.
>
> Can you highlight which are being modified?

I changed several arrays from "static const" to "const" because their
values now depend on ah, so it won't compile if they are static. For
example, offset_array contains AR_PHY_RX_IQCAL_CORR_B0 which depends
on AR_CHAN_BASE (which now depends on ah but did not before).

> > -#define AR_CHAN_BASE 0x9800
> > +#define AR_CHAN_BASE (AR_SREV_5502(ah) ? 0x29800 : 0x9800)
>
> this violates the coding style:
> <https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl>
>
> Things to avoid when using macros:
> macros that depend on having a local variable with a magic name
>
> So you should add ah as a parameter to the macro
>
> Repeat for all instances below where ah is being used
>

The macros like AR_CHAN_BASE and AR_SM_BASE are referenced by a lot of
other macros, some of which already have a "magic name" dependency on
ah like these ones:

https://github.com/torvalds/linux/blob/210e04ff768142b96452030c4c2627512b30ad95/drivers/net/wireless/ath/ath9k/ar9003_phy.h#L527

However I think it's probably good to avoid introducing new macros
with the magic name dependency. If desired, for every macro that I
have modified, I could try to add the ah parameter to all dependent
macros. This would probably be a rather large change so it might make
sense to be a separate commit.
