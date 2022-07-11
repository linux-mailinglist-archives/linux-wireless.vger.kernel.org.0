Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63547570E23
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiGKXS5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGKXS4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:18:56 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872D71E3FF
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSAFjEycXB4SeU2w1092N1cFPY+KM+HKn5OaPa8nFtjgxpaxSuUQAosVJJGqnrxSz5h00Dk6QvMHk2fGL46JPnDa+oo8eKtDFqR9SILSqdGYBFZdjd4LhbgOyqKtqPmiVxs3f/ockFkYgIntsgt2NfZc2WgV75/WEQcy0v3PEQ8PcfL6hzfNi/DL83dUkfplR5u3+xeH7sIWqtKO84l0ebZdMn2d+wcXP49pmbmoMgcYslGRPwqOAZrS+HPergZ4uIIQNZVRUNGmbRjMY3RC/qK7l1sm9vKwjuuVZYSnTdVhSNRpuEuHTDVRSEM0sADZHoHlxpQK0nBSYU/uNq9dRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMLFJNueZEX8/JEdt5J/HiPNKPUrQUmj9VYcjBxRnhU=;
 b=Tup/sPqja8EZVr7Avnhn1Ql6w2hVkZqXxZB+SCCzCv1iYK8q3VEnFcDy2bNxeiR+oYmVtl26g343s+s6aW/13BKFePwtNhYG1OibD/Wcx2hpTZiPWA1uVAMzbptPAxJP9cvhYvxSRz6ogPzrUlrY8WtUn0yRPZwppim/zAzsDe8drUh1LwZRfkHNU21WpoGN2ta3+/aX3TDwDVzymD6BDEjYIUMJbyNEP2jnsqXHtLLxskQdTsWaGbQlJ2XCN2pp7r9hDFfYKK+bFwCSGtSAf/GiBDR5tGbda3ceMb6/44xClCkyJkErH70y4MnA1yPbTCHPjdRcK78ODhRGBnBXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMLFJNueZEX8/JEdt5J/HiPNKPUrQUmj9VYcjBxRnhU=;
 b=HicTQfCeY85NNfW3qZ1UyXFNS57biJmn10RZEAqT2vL0sa83Gpl3n8zFIrDXOlgrdaRszpJLHLZIw1gpppnivgRzsoEXCIq0HphC8elnNYjm4pRMylrEon75grsTjAfHNhPbJvYjQLnxYr3Tp4SFo8Oun5ebGwd60bdZsjNYbg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0849.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:18:51 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:18:51 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     johannes@sipsolutions.net
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 59/96] cl8k: add rates.h
Date:   Tue, 12 Jul 2022 02:17:55 +0300
Message-Id: <20220711231755.2955984-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <79365d0387a73baa82cf07c81637a622492ed9d6.camel@sipsolutions.net>
References: <79365d0387a73baa82cf07c81637a622492ed9d6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::6) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf813d3d-6fe4-483b-9677-08da6393b74f
X-MS-TrafficTypeDiagnostic: AM8P192MB0849:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6anBd8BV0nlD/WgoGt2Lp10TpFomf5xEJqWjGhijj6JbbybgyK1oQ1YhFjvdI853Xe59O9LhrSzJDXUCOJigBZnRVenxCVV/X2JJmxKs9xmlBe9ZdVNgNOIaH7RslY6tViolBAQ3YZC1ToSqM8bADnvAagOpGrtzck8QQqzh3Hciqc0qPkN5aMqWi/dfPJoe59QTHNAqozslLh0LlsgrQCrUfBezY9zkKWjveFoboHR2q6gjHtKzeUc+6C1x1xCwR1MGwhW6SZW9EZTZhan+mUUFRBhhkpHSEQ08ZQXMvordgU7LwX6zkI3X6DziIhcetifi4+XaYt5eSjZW097mI4ua8kERaiE3NWyrP4Il0nxGCg8dRGfzamDRJQtr88egztyksPLKPHW4bfmYAd2OG1xksN2Ae5fTn8VIythwkeFOLeKHJHJ59rn7WH7O1+Hh++CDKeAy0IcS7KkAytLS6ibuT9wMKicBEjRpHLcQggju084lw/VOeyA+xG7r76bS03ILfOnZ66+0H/nG1wU47nAmNr/eMZ/solsc0avvMJKlUPGiTO+XUZ9Z2FaW2S2u7W5jA96OMY9HENj9oFI/zDTwb6mUP+drUxTvzXQh7ong6ljZCJYkCbUOoBAn8933HIuKx8eNk3j0acGXe+1pSJ4cLo70BJY1n5LyhdXXbOIcEZzhTdoh4KhiK5jQAfToxYNoADz0ozv318M9z/Nwo3t5zfeRgmUoH1egV+ilkRspOtYt0gJvJjsHOYUhNqgbzqawPOx+u1gBOmvzLaqvuG/I7zlRYXt27/pNp+OTQCM6y02C4Wbkh7wPwYMBNb88Y+xdxqLpeW3CLQZbaEA1ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(396003)(39850400004)(8936002)(8676002)(186003)(478600001)(44832011)(4744005)(1076003)(5660300002)(6486002)(26005)(52116002)(107886003)(55236004)(2616005)(6916009)(66556008)(83380400001)(6506007)(2906002)(86362001)(316002)(66946007)(41300700001)(66476007)(6512007)(4326008)(38350700002)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXJjVVMvYUlCaHE1aU0wcDFrbzBSeHdva1FPVng0WEF4WVNEaFZiM1E3SEtH?=
 =?utf-8?B?V3QxWjFTenhsSmNsc0hYZ2VZWjhqZjcwWjZhcVJjekFvZE0xMHpCeHBnVm9D?=
 =?utf-8?B?TTVXY2xNWFZUUUNjdEQ2RkpDRXp1RmZYR2Y1Sk8rYUw5eTZ2RnlLMDYyd3NL?=
 =?utf-8?B?cVZOWW5DSlplQzEvOFpzSnJYbmxBbFB2Q3JKMW1lRTF4WnNOL21ibXpxNTVy?=
 =?utf-8?B?MWpyTUs1anZKbGdsQWs0U3MyVmFxL2lnYU90YTVaWmJiK3Z6dFVDUzBRbWhh?=
 =?utf-8?B?QlE1dUNTWjZwWXlnOUdXZmt3Tm5nZFAxMVhuMjhMQnU0c1UyYUlsQWNnNDJk?=
 =?utf-8?B?aVl0Y29qSXpIOUcxV2VpRlJ3N1RKdWd5cUszTG1ORXNYOThvY2laNmFzTzQw?=
 =?utf-8?B?U0xsSU9sTkZDUjR1RUNIWEZ1Z0RsWmlxTlViZ2ZZRHo4MDNkNWE1bGRyUEVF?=
 =?utf-8?B?TndCM1FkSVo4TVAwc2lXaUFwd3dKWk1pMTY4UG1tYW42TGY4WXdSYlVKcFZG?=
 =?utf-8?B?TWEvSitIOHhucjM0UVJLdWZ4L0Y1SkFIZjY3RHFPT2pVK25KY1lKNmRvZmtP?=
 =?utf-8?B?TWNiemwxaTlUcGpRR3lBVkZoOCtKTU5icmNWcmk1L1RCczdjbUxjVGlxanB0?=
 =?utf-8?B?NXhOZnQzSXpleXkyTHZlc1cwZDhPTkZnVlk1L3krVTNVQ0dWZUpNOVdvT3No?=
 =?utf-8?B?RzZIM3EwcjVDN3NleWpvUkZjM0REeEtXWDBQNzZROGprOVpmWnE4blh2aUk0?=
 =?utf-8?B?MW94UkR6ZkFsSG9TR0RlZDRTaUpqdTZVZk12Y2xnWVArTDErZWdOZnZxdHQx?=
 =?utf-8?B?Vm5uZDJNMFFPWkNlVEwxUU5tTDlLWkMwM0pQZnJOdGVSckpPS0g2VkRaZjBa?=
 =?utf-8?B?bzIzeVlSUWZHaXZpYkxNcEdIME4yRWpoSXRLMDRnbEEvN1NJVGNvMmYyTHhz?=
 =?utf-8?B?Nm5BNHkzR0tGVjBNL0p6bEFMYURIRTlvRXBnS0RxcXBYTlFVdlB1SnZUNVFq?=
 =?utf-8?B?TUdseFRtYnR3ZDZZSzdocExJUzhScnUxYXhEL2FFaHRsMjJHVkEvSDVhMnM1?=
 =?utf-8?B?S1ozbEVqSjZZN1R3K1JNaWo5QXdUQnR0b2hlTjVSV2JZWGZrTXJUQmlORHlT?=
 =?utf-8?B?MDdhYW14c2FUdW43dVBZdEhUUDMzOGY4ai9kNDR1SXd6QXdWUXZ1N2pTVDBv?=
 =?utf-8?B?b3YvTCs1OS9xV0xidzEwak5TbGh0VnJYaks2SmlIUCtEMkRrZ0RwT3ZEb1ov?=
 =?utf-8?B?QVo4NVhqZkVuM0lPby93bnphSk9lenZnTHAyd28vZDB6NTBwTWd0SDRaZ3o4?=
 =?utf-8?B?bnFQWlZieDNhL09pWU0yWGZZVGtlMG5iaXdTaURoak1leWh1bFgrRkJDaklT?=
 =?utf-8?B?Sm5uWC9oV3pDaDh6cXRuRkdPUmNOd2hkRThFbzU0bmJzbVdYNnlPcE0zb0xP?=
 =?utf-8?B?dzVOZysyS2QxWkNkNUtOb0xGRWx3Q0JNRWJabHNSdkl6YldqTjZ4SGd3Y1lq?=
 =?utf-8?B?MGFVYk8xSGd5ZnpMQzI2cy82L1l3ekpZU3NZTlRQRU5BWHdVbW1RZE9Mejc0?=
 =?utf-8?B?TFI4Z0pKckpFTFIyZ0tHTnFZakFkdG9tQS9QTFVRZGRCRldZR08yZnRHSjJQ?=
 =?utf-8?B?WERnazhkU2lJcmsyamNRNnRuektKMGNnU05UZ0JDMXNpS0ZqdGVBV3pNeWYr?=
 =?utf-8?B?Y3VNNG5YTjdWRUV2RGtPa0xkeDBDbjdGbVFCeEJYMGZEd1YrU0k2Rnl1RXFC?=
 =?utf-8?B?N2lIVmkybVhCeVpCemlPYkM0SHk1RWlVb2hJWXRtbnlEMTlPcC9UK0RXY0lL?=
 =?utf-8?B?N3E4SUhSYmpRaUF3NDdHblIvWEkybk0rUkNXcWd5OGcza1JUY3AwMGR2TlFX?=
 =?utf-8?B?azBETUZYaDlhS1BnRkRMY085bXo5bS9nN3Y2VnIzWTUxY2l5QjFZalhqd1lX?=
 =?utf-8?B?a3NHWHN5SmZlS3VYNVdVN0hBNU9sSGh2YUQxMU5lbnNNaUMxVFFLLzA5ZEFp?=
 =?utf-8?B?cndVSFdITDZVekF0dDBVNW9jeW1kQ09aMnVoYll0MFNaTFl0YjcyR1FlNVhO?=
 =?utf-8?B?R3NudG53NlJPYjd1SHQzQzFIZkZSUGxYZTh5cE5mUE1COGFaek1teUJteW1F?=
 =?utf-8?B?dFVtVUMyZkpXa2V3SFU0d3g2MEltSEtoSnpyYWlkR25QSTNwdmoyOTlCOE5Q?=
 =?utf-8?B?TkE9PQ==?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf813d3d-6fe4-483b-9677-08da6393b74f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:18:51.5010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZeAlBO5xEBXb54oGxZdn9tPVh+d0z6982ks3ewKLYa5ugWprvoD2URmjWNa7vHq9ti8nHT1nNPsIaBv6gYZGA==
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

On Thu, 26 May 2022 21:54:36 +0200, johannes@sipsolutions.net wrote:
> that makes it sound like these are firmware things and should be endian
> safe? 

Yes, it should, thanks! PS: can you, please, clarify whether it is ok to reply
with “ACK” for all comments, those does not imply anything special in response?
Just to show, that we saw the comment and will take it into account. Or …is it
enough to mention that in RFCv3 changelist? We are grateful for the review!

Best regards,
Viktor Barna
