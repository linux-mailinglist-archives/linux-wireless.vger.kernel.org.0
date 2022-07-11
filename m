Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CFC570DD2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiGKXFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGKXFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:05:08 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3A7419A4
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/7yKW2STgg3uBpfhEzjVarx1EgEb+edazy/MNSHKxF4vllBbC7niLi+WUTm5Yjbzla7yIoeXeR7SxKjigbJs7DlWlS7N7uZPbXb+tmXDGXWT8QT9nMkZiFavGaafUfSbQVHVx1JpY+As/05kJ5WpuJqNuiACa+9grp2ccGp2zrYp5RBDHJR+XaF3hC4Isujo1YKMSMjYD3uWO8wBawr9UlOvPlujxHJdagmkcro4LJCs96PP1RXUJEnLob4PtAm2oCfojtoVYzGf9g5J5Qah+jgdTzRqTqgaJX3vsNavASos6kyZmxT7zvoubQE+uc4IV64ddGHHNslRbxfrmc0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZZiFWlBCabSZh071KEtqsae8Btmwuj5LBLdPkolx0k=;
 b=A09pdUzxfNhE6ZcqqGao1o8cihY7DaA37J+2qB60krH6bHNg3XF/P3Yv4vwzcJa88Dc51ma3PGH+7RhKYj3NYsQ8qEglaTGBWibJ4X5JvLaAOIstuaDHFGHzBVzdpQgzusOGwiQmTU04CJOLhle6lxABFC38p/hpuT48gApZ4u6X2+WTWITLDu9aTq6qQ8wKszunK+I2+kecG5DS3ValJRs7bVMG5ElYyYuOgVX7qfEzoVZdj1XYWn8eFhNwJP7x36HI96XABfy5iT8g+Ni932/wc6wpczpGgnj225GGGoRd5RZKBA/52lYf+Xc74vN/m3iZxXfXp75TQvDnZP5uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZZiFWlBCabSZh071KEtqsae8Btmwuj5LBLdPkolx0k=;
 b=Ttlp1BdQnE9f+LbIT8006pBLb1E/7fiBreAJtHERLL2zZltJub2Vx8R3Me2LvO3WseYN7t1uEPozjAMwO8z3QbC3ng4g7dtpb5AVSjLLkAv3Q+4zJh/6z41NVsbh3nUq9DQJmbEFWiagqePqdxhurU2GXAk85CbAEhmHxiraxMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1889.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:3b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Mon, 11 Jul
 2022 23:05:03 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:04:57 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     kvalo@kernel.org
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, johannes@sipsolutions.net, kuba@kernel.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 03/96] cl8k: add Kconfig
Date:   Tue, 12 Jul 2022 02:04:01 +0300
Message-Id: <20220711230401.2949860-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <87a6b3wlps.fsf@kernel.org>
References: <87a6b3wlps.fsf@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BEXP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::25)
 To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5900552-e13b-4602-33c6-08da6391c5fe
X-MS-TrafficTypeDiagnostic: DU0P192MB1889:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cBmrya9tnLJL7Dx6JIxwocUZVRmVa7T0qfbnjPiGiQyjmuPZFianu08CKnWerPlVptDdegDsMFsXCa3ixfqLNeqhsFOWXf0P+IiV/tsChLnyTsxv4MxrzuxLXk8K7OyaTFOtXEzAqX0DzVRzLX1NTnnYE2x2yZisaNWUOpWlWgj20KqMNTy/4X+p1nvyossYTOIwnw7dDy8EVuf6DTm5qUQ44/FqoNVGbRStdnnblewPCzI9dMZKGVKBUv0V7OhI+I5fdec2A+KCe8edvVhvsar6RgS2mrmGsqL6JIi3NvauKQnWbcOlwCYGhW71cxoMbSsPN8+Fh5ZsJKTWjRvSkZ8gQH8p8sYv0DHBBIGIULVD7NcdiSTHhO5NaeGB3R/aebwL+gp51a+Vn6YbKuoAAHSKX0FeTXykJ4+fZ8X4OMC9xKqaqoVGrMU0WpB1FCNXqWWoZaDDtQQF9wuNxY776g4RfwN7fjouH3jO2GStz/dXjR6iFpuy17CB+Oav925wbwHWyYRlCEDhT+2NaZdpdYLsbGD5YETc79MV5l5LQKeCKuE47sLyuT/MX1o5plOfoGWts1WjEvms5LXx/mgHDE5Tg2snqVUahOHjVhCmC6E891Cl+rF1C1pEsK+NOHGxUedFamxDuTeBzcUc5j9eqY3XFAETeSF0ec3nIvrpL79IRC+e5si2xfQH3iGnMmIuZUE+rDzIiOrzsr86LFlFthEktUTRKMn/Vds1A0tojMiBAj6YuPOcLbY85BZuG90DR4G5YtW83xa85vuZTUZYx81LXruGJrBguxIMjEeNomKnwUvtW0AC9polheKYus461CBDtpRJP7ndf0re+RFfdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39850400004)(346002)(136003)(376002)(6506007)(86362001)(8936002)(478600001)(41300700001)(2906002)(6666004)(26005)(6916009)(52116002)(6512007)(5660300002)(1076003)(107886003)(2616005)(316002)(55236004)(6486002)(186003)(44832011)(38100700002)(38350700002)(66476007)(8676002)(4326008)(36756003)(66946007)(4744005)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JsOTZTGAg/3p+hTEIfBM5OSKIRP7DUOvq/BHkbW0kPHB4ukPSr8yk9X0bLN0?=
 =?us-ascii?Q?Hz4VU4Md6bEb7C48THtLYYEMhWgJUYEbIzh56RPImWP/HN88r3OeAyGzLco/?=
 =?us-ascii?Q?5+sFWYZDTDJZK82DFWrmzneo5tJwnyUXC/0mQcz2dC9CelzerxRhVsanKyvK?=
 =?us-ascii?Q?0inERgHHEGSfU+dqrvFxDLS4WMkM1N0bZJgwqlwKcyswgajbPipeHusVrsxG?=
 =?us-ascii?Q?7qqb6fWCB5r6sOxm0ImsR0+EVvwtojeKr9eRTPC7GPFHn1e2rgtZ6yvqU6Ph?=
 =?us-ascii?Q?jxbhdo1+rrurQfKngbHU+FH9Ya19EA/+uOmYGaqeBJru+63FfQdLgevPJFmB?=
 =?us-ascii?Q?bMs3+rovtZkyKwErBttUw6ni8OGL2D+JpMMFbYk7/4andniK8ICWwhZZmb7t?=
 =?us-ascii?Q?RhdhZRIZHnOKRZxpSllgRV6gSgbnWAwlGIyqTsGzV4EAZ2zfEo3u+1Jj8vdz?=
 =?us-ascii?Q?KQJsVN+PKfCz/BnngjqV1xhtp4LF7mHgacMeApGpmbPCHsBjpO7IrtR7Z2VH?=
 =?us-ascii?Q?iBdiH9piNgKXwSSVhE9nIRBzQyBTd78moGzfC3HGtEFNaFVHNgIf3xc0vuX8?=
 =?us-ascii?Q?aTvR9U3Yn2mTgq+oR5nk6EmqOH7svlkSRAK3U183Ep545uwmu9+3rDrh7dUU?=
 =?us-ascii?Q?DZ6IxwKi+5n532HqyqMXVrmZSYS7ClmyRFnjyLDyVinmeEwJg/2YnhrAa+LE?=
 =?us-ascii?Q?HE+btGSGaZXzi9UOEXbYT/QkOj7xxh1VFhLVFit5QhTNspTpuxRDAswcT5/9?=
 =?us-ascii?Q?/3NiHQeMat/pjdHqkTqc5DIxRa5ALBK6uWdWTGDDiXIk1aNB2c7PGNCYzL0F?=
 =?us-ascii?Q?S7tmMFXqMYf7oXBlT+GbrITTCdBEIeCW178MO6rxAh344S0fENYdG889JVLK?=
 =?us-ascii?Q?FEK3YwlYspTY3ZpOoKiRvUzCkKNAqJwGIHb9/WlzXr9xI5cBcUPN1Rj4/U7b?=
 =?us-ascii?Q?AigduOzSqmRglj5OUc73CDvjGvID+rMpNMacMKVmwQkquMcj+YH/v+r2+R22?=
 =?us-ascii?Q?rzvFycRFeD5R43xQRvYsup17dYjiUOAnj4OISfXDyRUsA9J/pgU8n7X6ADVW?=
 =?us-ascii?Q?8Xewc6ivbomBGGGl5EH7Rhy6kyjh35FKZhShnEw62nUvvGxD1aT/cMFR17cN?=
 =?us-ascii?Q?x1/Cd+M+LCKFkWywVkJBPj9ytWdtx1soXq0GU1TFp6IPnwlCZQ2fMEF9PYqk?=
 =?us-ascii?Q?VzYvJ+dbO1BySpkBhjPIAHHO3WkAYrf7PIIsJOcWwDovUizhfOdM6Sjivhvp?=
 =?us-ascii?Q?HL1/RO2lHhfIiTpq7x7KrHzz7ZTm9B3eYS9VeK3b/KyQ711gUTorR61i8fMD?=
 =?us-ascii?Q?wOWIyqrOcg6figtaMf3aIc9D21XsIH8DSHtBOl7Nu0Wtj6f1aFnrnNmIJXTz?=
 =?us-ascii?Q?xlA0h1kPHDQDIqRBMVLZlW2Big5kOnoHJOGPQT0ioaBSOJy13+xjILb5qDfs?=
 =?us-ascii?Q?Q2hOQcpFLJgcjlQoGB2SAsfwHhSmLYryNzzoyEpNdWg5VyXWcLw+7OUxAFmU?=
 =?us-ascii?Q?2i9Z9WVPVxNB97w2KflId5s5fy0s17PfEfvXLVi7abXesajwEc2hO0V6NInj?=
 =?us-ascii?Q?6rZNLWGwYpBEnerneZvxPbe8907f6bMssCrG/kCfC5JcxBl2QTIbNxVXzQrT?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5900552-e13b-4602-33c6-08da6391c5fe
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:04:57.1868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6NEuXbWN+5aoclXzWFAm/3lXeho9y0WTJJKzIxqw0I6XOs3mmQm9iP7Q0mrCZIDswEX4Jl5oplqEven+KjmLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1889
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 27 May 2022 09:09:19 +0300, kvalo@kernel.org wrote:
>
>> On Thu, 26 May 2022 20:18:35 +0200, johannes@sipsolutions.net wrote:
>> 
>> This, along with the def.h stuff using it, and MODULE_VERSION(), is all
>> rather pointless, I think you should remove it.
>
> s/should/need to/ :)
>

That is an unexpected comment:) Can you please clarify what is wrong with that
place and why it is pointless (regarding the fact that it can be used to keep
track of versions of the code, that were upstreamed)? I can see multiple
drivers with that macro and related defines.

Best regards,
Viktor Barna
