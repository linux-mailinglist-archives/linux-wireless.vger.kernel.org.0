Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89243570E28
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGKXTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiGKXTx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:19:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80075.outbound.protection.outlook.com [40.107.8.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D3240A2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/HNXAD9zJQz+05gMiqTlhXoSVqfAwGm7Dce2EFm2Qb1vpjuDyK7dIAsSTSMvKgtdvkU/TQ8ICOKs4j6Z+lJF3LFeAdxI98RfTMOmWgh1YqIueUCqgXXhFSzch1JeLvlgzCSldtPxm5ZREMf+l7KSQ4maLf5Ds1klTk+8EWO+T/A0ZiRjC19EceMSif9j4mo+9SY6+YSvyp7Vfg7Ea1oxOiiZTqHLM/t8+Mgj/RUnbZWGD+mXUx6xdaXE6Hu7O4kkRulqxosNP4TDSSynMccvsLRuknve8q3L44n390MfzUFNYpLFqxiT51mZ8pLvGDPP7JkvpjGTxVW3yOiEta8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=towjGM0TgQoCNxttb7IhUHLdtRLVNVPDKyCbVH68z3M=;
 b=V9+RfVVUOOFk18QY/t2j403bpnSMvCkP0R0luwW11jHu3iZW45Vq895qY2AA1lBLSSobE7qtpdjOV5j/kdaMe1Fdw9BJg/5+aKz8RWzzg2lLALnjpACTOc9okxQU/pXgvdfQoZRwiDkdiFejbIZc/IiSfp8ZotXz2Gmix30jDX4UFYXxZ/QnUysu2SAJr3vOO6ur5zkYFyK8BARbGnmRhqR7Stu/Ltb2TrqFq4RJNweBr8MfH2qWBDzAgy5DmUBmt4b823ivjZ9Fz9M6oXwAiwSaBtJoc+3W72yZnsJQzKYgFc8B+Lx7KxJq5GLQUMvALrQkPJdOdkVkDsZjE0FubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=towjGM0TgQoCNxttb7IhUHLdtRLVNVPDKyCbVH68z3M=;
 b=yTJWLQlBk4R2itylZx24oxDHXcj5TYTAT2bGLqLF13iEe8rVX083MCmk/lPO3xVz/XN+cKo9HQpD3IbWMBS3On+QRnRjYSIp1DmeXCuxRBGhvN/3fjounRhRDuRugw1aJ5odf/NaYy9PkCWssg4a6Hvpdijm8E8c2HfpUZ7I+Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0388.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:19:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:19:48 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     quic_jjohnson@quicinc.com
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 67/96] cl8k: add rfic.h
Date:   Tue, 12 Jul 2022 02:18:52 +0300
Message-Id: <20220711231852.2956502-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <8bf132e6-9a31-075a-c592-0f4025425cb8@quicinc.com>
References: <8bf132e6-9a31-075a-c592-0f4025425cb8@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8P189CA0024.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:31f::29) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a27ca0fb-c151-42b8-6f7e-08da6393d966
X-MS-TrafficTypeDiagnostic: AM0P192MB0388:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2K4OiJdVg80KOeLudj8zATDXXi777W1lfV/CGfUol+in+mG5KZ4zUsQ0/Vcff5i4axrQ8D7Oj+T10ySVHZzI5kwEEf6rcoAIVMwhkCf7Xk/3a/f5ljJnplQy2nVhtJrvuLJcCZDq9K7873iEAsAVuRYEt8rbmL1GPIDl63X2j2WJkJYGisADIsV1cY57zEgT+wY9r+r0vfFzBFWugs4kBLf6lWD9XwPcZE0pzRpJ/hw0th5rn6BScjb50n7iefOl4x5WbEQxpxCp+8Hje5YdFMNAxGG3zYOx4Kym9ZNsL7Rw9FuV9tPhBAeogDRL2B4Oj7PJHkno1z5zwHHpi5g3tx6+NusZ7R0RwJF90n/hchMoVwYrNPy2+P+Ylu6W2DTguymMgysU789X3sguoWgDwJfZZrZV6pZYJVaKWd9FRqpQ6w3QWlVI0vvYaLY39iKlmVZQvFt4RaazT+0CJsija4+J7F3gFzNg4o01s35NOK4Lop+GUKAkKknQCLz5l54mYaJBJmAu0s+b/j5a2ZiSDW1Bn68WmRy6imOKPAL5kVymA2NtN/8TecJ7x4r8mwj5bQEK7IA/A9eWPtavbwXpuNiJbufT4MXKgBAJo5c/nErVxf05YSgBZfJPtMGCUB++jd0vIxlUUZtPNpDhL6gMDeCABSTR2oqcKcy2yc+H3Rp+ApWWGEVzh5uxlIRn2H8GDjU6scBN08KgXEaB61CNgp7WQR2a6ToBrdQgagsUXw9XRh+UZHnxCH7zk+CSnnH2ZAza2/F/ltD8koTG7ibXakXtRMd54nX/cvCJjeEE2ge8Jba2WpYh7/LAA3PcINx6NGwsGDtckpa0wSqCtvaiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(346002)(396003)(366004)(376002)(66946007)(66556008)(66476007)(38350700002)(38100700002)(44832011)(2906002)(4744005)(8936002)(4326008)(8676002)(26005)(6506007)(52116002)(55236004)(41300700001)(6916009)(6512007)(478600001)(316002)(6666004)(6486002)(186003)(5660300002)(86362001)(36756003)(2616005)(107886003)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xC8Yq6fRh64yKxxv0S7gQSj5lv7ypezCeMYkSlCOuj9WisIDc5nRubsT5Gff?=
 =?us-ascii?Q?Dzi4myTHA4bTR8pR1AmJPrwpxQghTD50IuRXNfCDe0h8bhaKIDAAH4fCDs4a?=
 =?us-ascii?Q?p790PG+kCrKYMc0nanvMgWws//Wmkhsw8HB6pHss7kCYVFTJvTXhP0eAaO7e?=
 =?us-ascii?Q?y0zEOi+qv+Q5f4t4+QxAtmDYJ1Cht1MbHREGPN5MIL0V0Yq5X7DnQmVfF/Z6?=
 =?us-ascii?Q?fl55V3YiFxVkR+vszGvt3eME2kFFmfI0xhNDgRY24jtT7lX3MHHjlnb+VfRt?=
 =?us-ascii?Q?zBWZIhsErRv5mfdcGuUdN9KC/06nsXi5Q1EkqxZBRHgu0v54mPSuCYHHClcQ?=
 =?us-ascii?Q?qZ2sUZpUYIVqQXxvizrFd7T+Az+kT7wvdwPKQOiXUeOv0LXTIXI6YvVzS849?=
 =?us-ascii?Q?SVSC1gOv6jSUdDr0s2wVFYv5tE0iVm2RcomfianEexdbtkGifLOtijEunUjD?=
 =?us-ascii?Q?7N+oHpFT+lvG9BdSskENhogYkYvi7/WVgeRhS3bF/yS7MuUigfT6P+r/sVhN?=
 =?us-ascii?Q?0OEtzZ0t5PJTFiJZzHcJADN5RJeVrlsalGC8PkZvlsc6fsdxMNfR954f02T9?=
 =?us-ascii?Q?sBs+lgx9a3AxsRIbjIwbJ2rPcQhNj/pYVGgm3qmuFSrIPTST7SvkF4abSGN6?=
 =?us-ascii?Q?QZc13jo/5EapVDEws8Jecg39Riuom8roqfW/Zx488vsU/7eqHCV4UwG1z7pP?=
 =?us-ascii?Q?0aFEBbsrHYerlH18PLV7YS6daIk5037p3X5MMYghP8Qbu0SQxNZIiHwYZwcd?=
 =?us-ascii?Q?8LGppA6eQY3o0ICaaEVpgguiXF6bHkqTLaBNmFioeN3wV7oSDrKblpkfiq+g?=
 =?us-ascii?Q?NJ9cHJD9NAqUqM2W2GhNUvrxIZMLXEKLIEUisQmA69Gu7HADT2TWpT8TnB8X?=
 =?us-ascii?Q?XmRlkCOAue+DAR01pXlX4/zobix34O0P+hILXCDeZ/6yFy8lY5usVtDAmwOz?=
 =?us-ascii?Q?5jrJHdxr+HO1YycZyvF5WIkiqlRq9xlTNccVt7hCqIxFeEhdNx/hqu1+CB3o?=
 =?us-ascii?Q?eTW8kD0g7GRll6hGs7n6Gv1g4OvnpMNv7elK0XAsMuyYRmHykZncZHxJsJeh?=
 =?us-ascii?Q?EhhqXsP5t4PkuCcaluabFXbsykq+WRC5DQyON5CoaUVO8sbQGLxPPiQsNb7h?=
 =?us-ascii?Q?1O/egaozo95A73DD6IUNJm4qUXHAcJ2K4A8RWkT0TBZKwp/UJoPa7VpHq+dy?=
 =?us-ascii?Q?4Y87J0Mn/6FV1KOlvg3709a0g0RWxTwpwaEhX0tHn0MD25EUlCDVb3zJw5wA?=
 =?us-ascii?Q?SR136SQm1znQzGkxBhpr/ZwTYf8aD/AfJzhotHF6yTXN1MmXQK6SIphaxjCI?=
 =?us-ascii?Q?sPqk1HRazbhmWi9cIK8j0wmfr/9v/4KTGhUFxVNvnd9KjGZ92E06ZKlNQ69I?=
 =?us-ascii?Q?v05l4AedImIZwlHQsvGEKIDxH4PiAFR3IbxOq6zYkdq7WdQHOw6WSu4JhrKV?=
 =?us-ascii?Q?xAy3cJD+aXPP+kqyphDB75riMAIEH13p80tJ+QyvabFIYTsqm04UWs0VgJoe?=
 =?us-ascii?Q?qOMKAAY9tYj8z4vPxLuceI7bpOdV7SKKECajX+P3bozaSriuUHGwUS5OFPL6?=
 =?us-ascii?Q?pw8FdrgOqY1aOi7kHrVmltzfcxm2a60YgY4B71qBhchxjCPirovfYIwVzuEY?=
 =?us-ascii?Q?ew=3D=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a27ca0fb-c151-42b8-6f7e-08da6393d966
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:19:48.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9DmECpYhHgMxK6oBy8eb6nRZ/NkbFv04zrTfFitlu/JHS3Qxqe9Y57YF+YjF+0gO64vIFuS/GzNCe0K25HeQYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0388
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2 Jun 2022 13:40:23 -0700, quic_jjohnson@quicinc.com wrote:
> consider adding CL_ prefix to the enumerators to avoid namespace collision.

Yes, thanks.

> why is OVERWRITE_DONE the max command? that doesn't seem to make sense 
> since other enumerators are defined after it.

Agree, that is an odd place. We likely will remove that in the next version of
the code.

Best regards,
Viktor Barna
