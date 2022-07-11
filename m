Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13731570E0D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiGKXO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiGKXO6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:14:58 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20048.outbound.protection.outlook.com [40.107.2.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA72784EC8
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5QZOMk0ScD/xl31nsHCj4dPvwlWtHCk2xJnUskzYxp5vdGf2/37xJ817x26rMZtGz1MFuxo/Lvbyk45kAWUabooX+gTRbzd2aq8cEQ0XKo0jgQWa68NoB8o8cM2pyEw8Mfb5JEAVQSqCMufJcJWWcqTVpUDsPyXNkjoBMHVWvqiVqYUxyfvkMQa5AEQwv/HUNI8CgRNGJt5Tjk6mhvoenkR5jJdWW/slijSi19U0eq+04G+zc8Qymc11yjWSLaUm1ng1w87LxaPM3HCH/WUiqOOuPL86rs+Nh5Y6mx998UM7j64RwTEEXrt2uTdrIT1PiM1tneT0+3XYZr+sfyi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRUuD/wxwLB8ddip0o1Vzl91wewz4xcGUSprgXG7vOs=;
 b=H923P+AFU+RN9QUyfO9ijmxJhqKnHQVfXtweUU2DDcm8Nl3oI5J5uCPvZequAZfw4XxNcpYe9v4Ci2izBEvEndmzDKtdeYf2M1NLt1QItONQMkrhb1Trcvmo2XbLQGreLB+ptt/XHpoTRKBiuBwg9uM9obAjajbjambYZF4stFIOU7gtKeTSVji9I95Ltz8svBXWVYbiFtE1H8hrLaJNRRz+lU7Zl+r2VIUdMAKKblTDJrduxumGNzSBmvgVGrNHHVwPBzLj9kfIaOu46r8nm5NAO7fFAHhKttv/1buAYqT4vN+pjPbFe3Bklgz/A9XIBXQOrNVHervSMP5Lo/LNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRUuD/wxwLB8ddip0o1Vzl91wewz4xcGUSprgXG7vOs=;
 b=G0imaRp0nviSiMfjqQRo70hdLMNSlAcMGUh38FPkPTevT7fehn+Bs8g46tZdN+q6MrR8uSAUD9D+Xu5WltuiFhlmPZXq5MCzN0OknneZSx2nKF60Xeg1xFmxc9v51syLelfWV3G8Coh5pLTdau7T3ZK8Jn01NQPTdaa1rASMNKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0849.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:14:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:14:55 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     johannes@sipsolutions.net
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 38/96] cl8k: add mac80211.c
Date:   Tue, 12 Jul 2022 02:13:59 +0300
Message-Id: <20220711231359.2954157-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <200a74dbed0ec37b4d374d963bcd0961a249b0ed.camel@sipsolutions.net>
References: <200a74dbed0ec37b4d374d963bcd0961a249b0ed.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE0P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::11) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2952aac7-4f11-414f-0bc7-08da63932add
X-MS-TrafficTypeDiagnostic: AM8P192MB0849:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PKxZLPWeGsX6zg8V7uowNilGuneXayyUE19KiOWYkReAUyC7YZSAYFebakMSFP486o6LPa5u6/UBVFnC058KFpNj/TwL8OINgTeBGEZYzvXiKj4VnpNJhmISqGd7VbQpyudT6kUM2qsQM39RPIL+uVie6nu2Ih3ZTdr+eJVRxni4ku9ADsMl4l88Ls3QsWcuNSpezDxjrYH0rkDJJlQ1inqcyzmB0H3z43YhEbCQsLxPijBOZ2DGA4+wItduHhaVt24K6dpljhb29MU3Pkya1iaq25Eb2KntoCKCDpCDnqkulpUT66IYVgWRdMlPMdI2SQbGy1yHanDHG2RjucQNKzE/a/y+wEWdbbeM2PGmowfM14hcY9IqPDz3p+lvGAIPg27vXyf1uZTA2vTP8oWxUHqWerBrlRi0Gc1688eE5BlG0CP7ZgGTxoUJ/C3LJ1VUf6SLOVQxfNHQt+8+R9FELXXrF2zWmIbbRlGVlUcgfkReRzbELp7isBzFbf9QoyIbMOhBu/tAx4+mugZKnxSQQTbso9YUQyppl8WXbXIwcxOvcl2iQyMI16RXAT8M0TI5NGv4VxL2/nGOV1ez4CEf8sX918kt80ambSvTNrrCjSA3htoY0C8YHPFdtT6+VgY7ZKJS1B2JvZka6JFa7SZaTyny2ODPv3uXzCkg9LajxZ+dC0Qts7bpVr00lg6eQfP+iP11dpB7BvnxBG4VY2N7CuxXLxW8zFm5dQ2YH83Q+8Gvg4kBExlNVGOC9g90VQiMsUpCJ2nuBQQk15AvRQE6XYKOJshviPWA9b/XXuB5FdqIPreWJPs2USBfQNvgGb1+CsmR23K5BOxY9RltW+DSnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(396003)(39850400004)(8936002)(8676002)(186003)(478600001)(44832011)(1076003)(5660300002)(6486002)(26005)(52116002)(107886003)(55236004)(2616005)(6916009)(66556008)(83380400001)(6506007)(2906002)(86362001)(316002)(66946007)(41300700001)(66476007)(6512007)(4326008)(38350700002)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFAxdFY2bW01cXVYOTdGWUtMdWNnc2drd2lNTjNDcXp5QXVoVDE2RFArODVh?=
 =?utf-8?B?Z3l2eVFTQXJ2bTJLV0dNNVNTd2pxTktQdm1wVjRmYW10MERSWnBkam1ZVFll?=
 =?utf-8?B?VVcwMDZ5WE5CTTBQN1Z3SWxnL2VhbGdVZEhlK1F6cW9mSktpSXFSTFBxbEhm?=
 =?utf-8?B?Q0dsdEYrUldXWXlKdmNOQVFCQ1F0OU1xOCtaVXdjMlhlZXpyVlhwbjhpRDNN?=
 =?utf-8?B?N004aDlkR3FkaEVZdGdFMzA3R0oxZldOSVB1eitnTzc3OUlmdW93dWZJOUth?=
 =?utf-8?B?cmtXQy9CZkQ4dGFkNndCaUloOW8wR1JPaCtiWkM4alBsYU5lMTdpNkFRVFlM?=
 =?utf-8?B?OERTMlJ6MTVBZWg5V3h3UUJEVFFXS05oL3VCWE9wQlNUR0I5VWIzSVp1OGpu?=
 =?utf-8?B?YlBJV2grTGo4Q1VmRGpUNFgvdFlGZURoWFRLMGx6TFBhcllrTUpvTDZocTR0?=
 =?utf-8?B?cW9hNmZjMHFmRWQzTVIzZ0ZEY2NjQlRYZjZZQ24vUFB2dzFsYzlOaGFnZmxH?=
 =?utf-8?B?RDg0d05mbWpxeEp0MmM3T3dFQWptNFlwOWRLTmMzQ3JkYXZ6VzNQZFR1bjBh?=
 =?utf-8?B?Unl4cFh4YU0zMEN6cWVJcWxpd2ljMWNIU1Q0S1NsN3lCVG1UeGZzbFR5RGQ4?=
 =?utf-8?B?Ui9jUkZSeVV0NzNTdndjcG1iaVppemlNUjhkRjFlZjZUNmtUNkJudWFITkZH?=
 =?utf-8?B?UnowbkMzZWdMYjVPRGxTaWlxVDVvODA3Q1lBT2x6Q3BYR3g0eG5zNDdmeVdO?=
 =?utf-8?B?VUl6OE9SdXZBWHlFZ0E2MHE5TWRqZDNYWnRoaExvUHRpK0VaWkhBNWMwRURL?=
 =?utf-8?B?Wnh6bTU1R2w4RFZTZ0o4V1lqUTB5cER0anBpa1ZvbnhSY095YmhuVlJlUk5t?=
 =?utf-8?B?amVLbktqSnQxTml3ekI1MG14cHl4ZFBBMnZzdm00aCsrVzdSWTJaYjhiTm1Q?=
 =?utf-8?B?S0czZzdkcDRhWUQ1dzBPUkxkY2RLRHJ4RzdpY2xBdXA4ZEtrSnhreWcxc2tw?=
 =?utf-8?B?bTV0L01Ta2ZialBRYk03Y3FnNnFwck5QdnhtaVhkZlhqVjI1VEVpR094N1JS?=
 =?utf-8?B?RktUMFQwSXhXdEJtbDBqKy9vMnBiVHJnUWVlZ1VEZFVKMzJSRDQrR1hRd3Nr?=
 =?utf-8?B?ZmZVdjg5OTZGZ3NtT0RjVEJkeXRkVTh4SFV3SEgzTUhiUEppRGhOS1dLRHVM?=
 =?utf-8?B?dStETUloY3Myc1h6eTBnU2tsQ1RGVUxCOVVGQlFYWjJRKytEWE1Ob2JVNVNY?=
 =?utf-8?B?MUJybWtHc1JzMmdpRG1ZOXozdzBBQ1ArYmhRaFl6OXlWMkpVZGhsS3lmS0xK?=
 =?utf-8?B?ak9OZU5uMS9aTUVkTXVpb0Q3MDVmV2x3ZFE2bW8rdVRKTlZTaGhDcWFvczBn?=
 =?utf-8?B?dndFWkY4SjZudHMycklaKytZLzhZWENsNHpkY0U1RkxXT0h6QVBhT3JteWNv?=
 =?utf-8?B?ZGpkSW5FRkF5KytKeGRWL0hJZW5QQkhiUFNCM3FwempUY0Zrd1Qzem5SdjBE?=
 =?utf-8?B?ZGsrZlZqQkVKck15a3JEdEpWaEhlSTZTN2JGQ1F1Nnc5NlIyNHBOaUJFMjdk?=
 =?utf-8?B?TWIrdGlJS01FRmczTFV2NFFDamU5cFR2OEtmbnNIMm0ycWZwOGw2UXppOWNj?=
 =?utf-8?B?Z2V6RlBGcVZ6YW5yaVB4dEwyM2dQd0lRUURTdTUxSjdST3dJek5NVVNiMkQ1?=
 =?utf-8?B?OXZDMzBodVFNMzRoWjN2NGh3M2ZKSjdBWE9USWdSNXFZekNTNEM0Uko1MFVh?=
 =?utf-8?B?Q2RSYnRwVnp3UThkNEU4UTNzb2VOYWw0czVBZjZhYjQvZGYyUTMyNlMxRkdz?=
 =?utf-8?B?QkFGV2JReTkwemw3V1JWeis0SXFFYTFlSk93eFFuSGlBZ2hNQ3dhNWJoRGdK?=
 =?utf-8?B?SlNZL085aGZoSEpTWFpLZXduUFFBdTdWUGpRQnROd2dIRlAyL0xLdklHMW4w?=
 =?utf-8?B?bENiMDUyM2ZwdmdUY28yNmNUT21TQlIyQ0xmS0JKSkhJRkpYMWdPQWVqRkVF?=
 =?utf-8?B?TUhENFVybVVMS0xEQzhpemQwaHFnV0s5UzdZZUZqTmk1OXJZRDFqT2ZTMGRM?=
 =?utf-8?B?NWNwOHd4SUU3WlovM3JOOWFpMm9qbC9XTTZCdzJzZ1VRV29UUnRVUVBPejJ4?=
 =?utf-8?B?UUJPdUZSVWNVenZoWTF5azFzT2FvRTNnY2ozWm95d1ZRVVg5TFhyWjNHdlRD?=
 =?utf-8?B?dWc9PQ==?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2952aac7-4f11-414f-0bc7-08da63932add
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:14:55.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4LZzLuqBTDqvEKsNR19O1OjR5HeHO962O0kk1W0rl1qisCqZWnlAw5T217yP9MbP3BU5Mw8SJDk/U/m1ulSsMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0849
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 26 May 2022 21:49:17 +0200, johannes@sipsolutions.net wrote:
> I'm really surprised to see this callback in a modern driver - wouldn't
> you want to support some form of multi-channel operation? Even just
> using the chanctx callbacks might make some of the DFS things you have
> there easier?

That is a good point. We picked the “old” channel API, which took less time to
implement – the benefits of channel context were not clear enough during that
time.

> This feels ... odd. You really shouldn't have to look into the beacon to
> figure out these things?
> 
> And SGI etc. are per-STA rate control parameters anyway? Hmm.

Information from this dynamic parsing is required for our driver and FW to
function properly.

> You have all this hardware/firmware and you implement this? Interesting
> design choice. One that I'm sure you'll revisit for WiFi 7 ;-)

Actually, the driver is doing that in cl_tx_handle_beacon_tim function as a
result of TBTT interrupt. However, the next version of the RFC will be without
that code – we are moving the routine to the FW side due to timing issues in
the multiclient setup.

Best regards,
Viktor Barna
