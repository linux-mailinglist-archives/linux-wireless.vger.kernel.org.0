Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803FD52243C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 20:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbiEJSj1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344053AbiEJSj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 14:39:26 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2072.outbound.protection.outlook.com [40.107.115.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414B495486
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 11:39:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgJmv6cAH50Sln5GboCJ+91GiiwigRq/6zpmllyx7wtEEzDPS1XB2dAwXetxTymwb7avKrqyWOU8zkHOzwfjap1mFnAnKGDZSL89eAnO3gS4C23K1b121mTgnjoaqhnICgga8yaNNdTHy9ZbHGkNXEmu8y3cdb2hqdvONP6e85Nlkol1z1KMMlZhDhLoyRLDDU/WZsAjktFP96pLTI3DKIalM4zSkSWSa6bWlrxw9CIt/cPf6KPkr11QR2IxKZow5vnJkjsPrJANFffUuDwEpbsJESjlZB1MXdO7JvU8/RKibw3iCucQVaSz+k8Yf8VfLV5zOk57QR/KnN7n/+U1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZWW1U5OP9eGC3dDfD/l+qUvpT2VfZvNF+2QLp3F1yw=;
 b=FV1eKmUdLSNo7MEspAvCYEpQz+1I7HW6/EstVTx3Uk0bGFdRusqzBaASzDSpTgGUIKc3vborslpicT2/TOoIBh60RWDZctT1WAijMo7l7OgOpNTG9RUVC3NBOsxhy6OjMV7epee23PQR7hmFDZgvcP0US64HTHQSWFrybqY2B/22hG9MYvWYw5TIKSWVFgUo8ZuCaI0ve4MgloiyGYXiFenRGFrviBqp3nmOySZboJSXDM2ZurtOpk7mY2Tt+J9lWpvSSINemNKciSf+RZLajAbs4Vbc+1ZiY7PT6Op2/39s9Etbc5y2kTF1tycmFwQejauUpMPxlj++PXr1Qs6cpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB8135.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 18:39:23 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a17b:bb51:f663:e98f%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 18:39:23 +0000
X-Gm-Message-State: AOAM530NHMQvM/13601t+/ypULiiFMXZiPFXoC/ZMsVOuhTQJu2VXjHB
        wYPXuaR0mQ+RSsvEYjajnPQnU6fRRMqBnLR9L0Y=
X-Google-Smtp-Source: ABdhPJxURQoGqxTjLz7Tmn4EE/usT8OABTLZwtR+SjaWSrUJP4AGHPHZmmidgymYGh7/fCawmYxhIBEXUk+5Ssj7R0E=
X-Received: by 2002:a05:622a:6184:b0:2f1:e213:9c7 with SMTP id
 hh4-20020a05622a618400b002f1e21309c7mr20684570qtb.467.1652207961959; Tue, 10
 May 2022 11:39:21 -0700 (PDT)
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
In-Reply-To: <20220418071313.882179-1-wlooi@ucalgary.ca>
From:   Wenli Looi <wlooi@ucalgary.ca>
Date:   Tue, 10 May 2022 11:39:11 -0700
X-Gmail-Original-Message-ID: <CAKe_nd1-twgutVV8Ls_7Y=q8o6ua9_W9x6q_HvevWsv3uwnh5Q@mail.gmail.com>
Message-ID: <CAKe_nd1-twgutVV8Ls_7Y=q8o6ua9_W9x6q_HvevWsv3uwnh5Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] ath9k: add support for QCN550x
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BLAPR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:208:32a::34) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d64a75f1-8ec3-4f1b-0082-08da32b4673d
X-MS-TrafficTypeDiagnostic: YT3PR01MB8135:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB813558D88251796B585132F0B2C99@YT3PR01MB8135.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /L/6Eq/E2IpdBZaFMHjKmweHPJrI9hFcQ99j9ysJhEaeKKvSlD+2YHnVNFMI3DSDOB/l9O+EpMXZstuVU8uSOBWKcH7a3k7N77lQkjiZhJ4HKyPgBM9Epf8Bxu4W/95e5ysZiXe9efGy998KruHpu49BvMaci8iBxCXzT3tGy8lgxJOawsefp+zwyCMwPBW4AOMlCi+3azAgrKpJ7v14ISiva/NJtB6Vng13gObRwYcq3ovtyLw2MGoCzXJvB0IXSpGQmu6kJZx2uKWoMyzkJ7/VbBXHrcfXHoJjkD5rL2xEp1ovf//BpijUdJwOAqULtkejiu6rya44wkAXGn1ya7vCJBO2o8fi4icLjJ42xtIyQKLzN4KuHoCew3GNMT4RY3G4xt9JTKuQxjC2KGfFJcyuT/fEbGrJNVTWkYoUzSbtxnIp8iZb547lzdRR1NCmVqmkHm0zLaCDwMQcdGzVp1jac9myhc1PPie8uyBL4gMOhZ8fmLCzqlKT4BCKME5T93rYMxBXCtuMMy9/xIIaNijcsDIaEEH7uHu3qivfRZinQl1JiiM21+fd4k+BHv2boqfZ/Y9oMQTKSQ4yPnm/4vBl9n0oXo0yOnwX8XHbBnaoqD2bpRCkiVULYnCSD9IIVEKhGzzZVeh4Sokm3eKTkMOa+vz4+TPMBO8bDQll0rgRo9tqHuKbOG/E2dtrOxOEkip2gA3QM/wO/JVEK4U42S/8KMteTR+3KN8C3Yq8gY6oYj9hcql3KeT7GFBs6LlIWIYkd57Ka45vAUhVPUOHcyTZKRu1dFD6ZhBU5Kd2h7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(4326008)(66556008)(66476007)(8676002)(66946007)(186003)(6512007)(26005)(6486002)(55446002)(9686003)(966005)(86362001)(6666004)(786003)(316002)(52116002)(110136005)(55236004)(6506007)(8936002)(4744005)(2906002)(5660300002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlk2cy9wckhoZWI5OFc5ZGFsT1V5WWtWSnF0b0ZyYld1MkdsMThhUlVXRUVP?=
 =?utf-8?B?TzJNWDlZQWdKVVVuTHNYRlF5Y0c3eGttTDNpNmpJU1dJVDQzVHl2aERtMmJJ?=
 =?utf-8?B?WW5kMkNsZjNUcFBpOFJxRjZiZ1daaUlsNXphN2cxNTlYQlJpdXlvRldKa1cx?=
 =?utf-8?B?YXRDRWR5bFUzbk10TkNZZS90WVlVZUtzQTZQbTJkUnFyYnJpc1ljOGJuRm9i?=
 =?utf-8?B?N3o0OHd4QVNLZ0ZyTnU0RC91SGVaTzFQQ05hQyt4N2tKMW9LTFVPQjV4b2wv?=
 =?utf-8?B?M01uQ0lKbSt4Uy9WOWJmbVpDQXo2WW1hNmd3WDFRTnAwMnYyZUhVQ3lkU0dX?=
 =?utf-8?B?ejBiTENVa1VIMEcvREM3T2x0ZFpNUENQTThjLzNjaTNaMXV6ZzNYYmhQc2Jh?=
 =?utf-8?B?Wm5mclorVnk2cnRVM3l2eGJLN1VQZTAzdzRJQUk2aXpaOTZXK1psajlsYzMv?=
 =?utf-8?B?N3RTMFZyL3pEQXlGQk9iRjQ3aDZ2MEQvK1VkbE9nM1pMWkZqWkJNbzAzYWJC?=
 =?utf-8?B?S0JFYjhONXdIS25MemNsN1F5ZnJDYVBBdGVnN3VZdnJRdlhqc3k1eXFxZE1r?=
 =?utf-8?B?OG1uM2Q4UjJOdmZRYnhpUmhaaVV0c3oyYVUvKzJIMmZZanA4N29GaHhSWmpU?=
 =?utf-8?B?UVRjZjBxVGxPbFBIZkpwUmtSdkN4REdzeDBqUjczZVYyVndBQk5kc3pxeE1W?=
 =?utf-8?B?TjNLYlI0UkpKZjMrWmM4TzN5aTlYOUJjYi9TaHNRSzFzbFd1VjdDMmtNNW1s?=
 =?utf-8?B?YWNkcWx3ck00cStxb20rSEIyWG9oMDBwY2g5RHpsNlVidzU5MldMbVhvSEdX?=
 =?utf-8?B?NTd2NUJDOXFjcFNhbVhDQ09HVjhweGxKei8wVVRpUWl4cFBrQzFVT1pqR1l1?=
 =?utf-8?B?Q1JmeVkrTWg0YjlDOEJSWmJuK2xPTmw2Yytua0hzWHFmY0FLMDFqNGx0bnpm?=
 =?utf-8?B?bGdubEJuS3BEM04xWmFXOTVzeGFWYkQ5c3pWU2ZZS0xMYi9tUVhHYW1JalNr?=
 =?utf-8?B?MUVoaVFRZlJ1a0lyZGgyUXpxQjFBNkR5UThkaHYyemEvRXhpRDFBeHBwTWJh?=
 =?utf-8?B?Vy96SmdGTjllUjFOUjAxc1RvTEE3N1BNQ0Z0U2NuQ0N3dnRmNGRyT2IrcnA2?=
 =?utf-8?B?cklTVHhvU3M5S1A1N2daWGgyZnlLZzRlSXprUzFpMmduMlVwRitYaDgraFlL?=
 =?utf-8?B?bHhSMU1xVVVIVmx6dnQ1dSttdFZzSnJyVno1V1dWYmV0ZFNjbmRpUUZtOGpz?=
 =?utf-8?B?MlhER0NzWXpESDdKVURYVXVyKzd4eWI3dk5pYVU4UlN0MGhWYWJxenBQSXNr?=
 =?utf-8?B?alR3Z3luT0FOdGo4REt1S2kwNTNnaVNkd3U1dDlRdXR2a0UzZS9jajU4eENY?=
 =?utf-8?B?WTUzcmdKUWVZbDZUdFBXNDZUaFNIeWN6Q0hRZTJ3NG1qSGZIR0lXNnIyK1dZ?=
 =?utf-8?B?UWU1VW4zdjZ6c2psdldQd0pKQlp2Q2ZYSCtQUVJxV2ZWNGNxT21BWDk1c2tj?=
 =?utf-8?B?K1FzYWZXOWhIQ09uVTNVbkRvUUxqTmVGVFlIVFFzOEpJdjZWVXB5bkVoRFdz?=
 =?utf-8?B?S1hYMGZHTk1WTmFTc2VQcFVaNEp6L0I4aTlWMUlSZENWcytxcStxRU9JTUtN?=
 =?utf-8?B?STBvMTd0ZmsweUdlSkFSN0RiYWs1ZGMvTlZaekxEK1dXNUc0OStnOStFTzRV?=
 =?utf-8?B?eExFbHVSVk1ReG5qR0RrSDFtbmM5d1RmaWpwRUR2RTczSXdLWkV3K2VTMk1a?=
 =?utf-8?B?aTNyYkJ3dkNKZXpxWmZ4bmhGYkN5Rk1XbjQ0ai92eDk1UFdZK0NCMy9PeExO?=
 =?utf-8?B?OEhaSXJLTHpOSUUyQjFLWEcxWnFBODI0S3FSUFlpcG5VTmhXNG1qMVJLbzht?=
 =?utf-8?B?cjBQUXZZdXplZGlYc1JSWTM1TFd5cmx2aTJUL3RzMW5RVkRUUksxc0hiTGVL?=
 =?utf-8?B?cFg0VXJ4MCt3bGtWOVlPKzd1aHBjbHhkNWxERWpBV0ZuaXM0U3BIU1NCVGRv?=
 =?utf-8?B?WFpodmZwa2UwWjV0c1A4Y25KaU1qZjh0T3EvaUt5bHJ1M2VmN2hEWjAwenZj?=
 =?utf-8?B?Nnk2RS9iN2VSMmNkOTN0U0N3cVpTZWc5M3lhNHJLbHQwOGJiaTFBZFhLbHor?=
 =?utf-8?B?Z1plQXQ4djRCZW53MW94QlUyT200MFBuUStpQUc5MTVSV1FoaDhhbHdFcTRF?=
 =?utf-8?B?YU15dW5qMy8vaDFNRldhZkJ6TUc2eVVoY0I0OC9LUVlwejhwN2pVUGFIaHlJ?=
 =?utf-8?B?TS80SEhUa2JMcVo0ZEEvVm84b2FtdXRqdFJWUU1lZFlzUjNkcHJmQjdYb20w?=
 =?utf-8?B?Q2tjZ0F5ckgrakRFczdYS1pVK0lwVmp3ODN2YUtyVkNRTm41N3FVZz09?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a75f1-8ec3-4f1b-0082-08da32b4673d
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 18:39:23.6555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gajqkeaHJ4crr1A5WiMCu5l7Rw5tDNRXkzQLWh02yLfcuL16q2MU/QTWn1IE+GKHlp2uqA046WQliiDgIKZoNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8135
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Thanks Kalle for the comments.

Please let me know if I should resend the patch with the minor changes
or if there are additional comments.

It would probably be ideal if this patch could be reviewed by someone
who is familiar with this device and could provide official initvals
like described here:

https://wireless.wiki.kernel.org/en/users/drivers/ath9k/initvals-tool#synch_initvals_from_the_atheros_hal

I would be happy to test other initvals on my device. The hacked
QCA956x initvals do appear to work stably for me though so this could
be done later.
