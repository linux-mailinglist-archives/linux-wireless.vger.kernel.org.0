Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B7526C20
	for <lists+linux-wireless@lfdr.de>; Fri, 13 May 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376264AbiEMVMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 May 2022 17:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343722AbiEMVMB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 May 2022 17:12:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3311010
        for <linux-wireless@vger.kernel.org>; Fri, 13 May 2022 14:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3rjJq69rwUKgLQCfnCFHP+L5RIxAUho0N/ZfkxGhV9UOHWUi3S160D3xNL63gXD7vxNCvK6yrdr/MaHhyJHfhQ+wjRHEFQE7HNx8Rl1I8lCMQIQFASaOckwkL54DmgFBJ/JNeqZUsDkC/lqT1sJxSdvpg3gpc4keycQEXfAmYqgN/hPX1pGx9OQp5MVvhHhrIo9AYb0/T/VwJ1hd+fr+vixvTN2f2EeSc/aAHwN8of1ud3/xCuFgW0/++vBXLLfxFGkPVa09N8jEmgICpu7ESbuGpzQQXmbaF8K6WTjbKHRNUu0We0h2A6b12j/fLcXy6/eWHmVSPyXCAcnIGVyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZCzUX+t1GqLLmaLR6YrmC/uJRt5jqnhbb9wZWbejWM=;
 b=YojibQOZzzL2JMDHx0E2QzCswaN38xqPKZtZ9Ldk6g3CDMdIwk/hKX/YBImYxaTYQ9fkNyZbtNX8tmantfCiq7FB0EP8hK3V0WzgE8i29M4uB6pxYtOl7CLoLceXN8KMfsx1OcWy09ccCaXmzO0lUvJb4fapKsEWaxC8z0LuVeX6WIGuybo4o6cYl2X9qFDz9iOL3GsplOfCykaCMnmXPo8lKMIWY+yXy0t1OjwvUx7Mskfsv6cxytKAqdEIIewYWmFSfJjstKJaG++GD1sR+cXESozClJD6rnmZ3TuvCuuh053yI9sXQjZU6F/pIVoifX2JSFmLO4+HAOQhr3csUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZCzUX+t1GqLLmaLR6YrmC/uJRt5jqnhbb9wZWbejWM=;
 b=lS+h+JbsRZBxM6UrnZXCzOKs2r8dn1eRSt2QVFOhm3qHhLAaWdbKOGa99xDgwtjklUP7dEFwzb8blQ5TwnJn3CWn/j4pU+KqjnfE5KR8k4iu7yA0KdhXXa3bWzIr43yzXjaj6MGKLfpHCCwGUgTj+9OGkUnA0fAg2xAYqKAke6c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from PAXP192MB1423.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:1a5::21)
 by VE1P192MB0815.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 21:11:51 +0000
Received: from PAXP192MB1423.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0df:27f:4129:1dd8]) by PAXP192MB1423.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0df:27f:4129:1dd8%5]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 21:11:51 +0000
From:   viktor.barna@celeno.com
To:     kvalo@codeaurora.org
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org,
        linux-wireless@vger.kernel.org, oleksandr.savchenko@celeno.com,
        shay.bar@celeno.com, viktor.barna@celeno.com
Subject: Re: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax devices
Date:   Sat, 14 May 2022 00:11:40 +0300
Message-Id: <20220513211140.2596547-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <87mtrmicj8.fsf@codeaurora.org>
References: <87mtrmicj8.fsf@codeaurora.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR1001CA0058.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::35) To PAXP192MB1423.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:1a5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7533c15c-7d55-483e-8d97-08da352532f0
X-MS-TrafficTypeDiagnostic: VE1P192MB0815:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0815A472E389F530113E1BB1F6CA9@VE1P192MB0815.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GUqWzMwOKq8H2pawIjlfbQUkpEo2llpff6H+5PXaCS23miPLJkBOHMwLhHwwEUyT5xAIHItX7Diqg3owzvvtiN2ra9KtpYpd1vIGUa0Kc+IHHdJTLurt7BMRiEBCUJfAKxsFVbydEZCl0l8cyDGwVqQKyQIQH+gOusNdPfE2VFpqn3B2ck9bddnhmYOzRLbMcbWMDwlOeuRN7HALUbnzi4KVzKHcz8k6dvAAA4hzdcCGuJkDZWCPw9aCD2/q+yv5SfzEt0AEtdZzZzZ3/jt+xiChaE2jidY87tISYf+yEfmD3+zz8Swr6XE+PX6QEgOwNXUR22skt46mDkMaSH5Z0Wx6b9G1AbmGpofqKz+FpIpaJWH/0lT9HyTsWMC86kJesAK+uODrHc3zGv1+QDD06HTkyqYIr7DyGzyfggHoIUTvSqdyhVlJszb6+UD1s7TbnsR8aWKfOBQKJCV3WaZikC/R+jMTIFeVPUH8t0CtMeRjtm/ZA+cvBEiGHmUCgjhWJQ7FeUjIF4wfAVttpSHUjBYq4B+CIAUuwgoSdTnim5uXdEugQ8BsUttPK6jigdW0C4YAqTm+44ZkeoUD27vOn7cP78wTUTWXc/kp6KpmxlBB9Zn0puSgoh+7N69wqfHs5Tgb7/7cQN+cr3LTRXoutmfdnLcKhrV9QDEPVHlTXJrlX8CCzkxS4RKQ5QJ0aS6axwjbcmcnx/OciyD5B7T2Feciv5DFY0i/c5rdA3im8Dg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP192MB1423.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(39850400004)(376002)(396003)(136003)(346002)(366004)(66946007)(508600001)(86362001)(66556008)(66476007)(6666004)(6486002)(8676002)(4326008)(38100700002)(38350700002)(316002)(6916009)(186003)(1076003)(83380400001)(52116002)(9686003)(6506007)(26005)(6512007)(107886003)(2616005)(2906002)(5660300002)(36756003)(4744005)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QIZJqZTMeaya9so08ama/Y4guIOpQuKQ4cwOGQCQe06Nva784782X3MjoD2M?=
 =?us-ascii?Q?p1JeVPgM35mmu0dpHSBO2tLH9DjZiT4xqsQsqTWwkfnhXyFjrn5bn3aTEPWT?=
 =?us-ascii?Q?/ZQmBfWhIV32zA5gqb/iiCAP1/hcRTFjnhjhOArM23KAd9yE3hnqPNNrbFEZ?=
 =?us-ascii?Q?SPavxej460jsRnoSCj/UEYwAc1vP1HyAjHwtZVJO0BZLgsomak0V6ghaCvue?=
 =?us-ascii?Q?DSOIkY25zxTrIsNZhMTBjRB7HwUp/N0BNhbeY6uBn1OxuRm3qlJ4UBCS+l0T?=
 =?us-ascii?Q?6G/QvpZ9NulbJNyHsnUSfTOpuchzNNgTmveKyTbbV/UJ5YWhPIuQxSafm4P/?=
 =?us-ascii?Q?sNdABLfi/KxW6b3I87xtCEkObGcUdVn6/Z26g7EjedM1ye2xeCbQ0pvj9maz?=
 =?us-ascii?Q?+cZeFj0Cmum8a/5cCrbM9ScI3our5Gt51YS2rtF69NCnH1GBjTEfSceloT85?=
 =?us-ascii?Q?z8lnXRqnQ7v6Fys/Qrdk/dMQux8Fw2M1d+CQpcBCfd/PGgWT8z42JOYzX7vJ?=
 =?us-ascii?Q?8OTShKERQFaNchNNOYqB86QLluhElyvRPmF+UuBpfahBpfXo06X7QjKq7i7u?=
 =?us-ascii?Q?BP/QHaDAvdpuJVOdZAZKak4YoSO1Z+0sq4AB1k+EM6KZOdZq9UVTXn3328Ng?=
 =?us-ascii?Q?BCGvPnlyCVCHhSzrthU8aLz8dGuvAUUCz28viWNIU356q2FEvcWgCSE+dDqF?=
 =?us-ascii?Q?aQ0yBq5v9IHJOvOypxNgrYJTyV86xztAN+EAm7V/IcVJY2u2G9pKEVPIZUzo?=
 =?us-ascii?Q?fpA9HZ8dkkbhj1g46PaxSjHs1A9urtWhSPnm8eMNU8zVmw+kz/iBiSudVlW6?=
 =?us-ascii?Q?Gh5B4YS93EUR4O0L/cvfz6Bjj9JXh4jDGio/ATNDi0+5vVp3nwD0js4ZrpUl?=
 =?us-ascii?Q?DhqvHT6BiBgngrwCuKPLYPFynOKEUrw1YADGNwsvkwttscVQfU+OVTP7bfbr?=
 =?us-ascii?Q?4ezkvnNTcHQN3deGDcas+TVqXkns5EXAi9lfp04mgj3xIcDA/3XqG7MkoMin?=
 =?us-ascii?Q?C012R6ppyP7nrOM1OJpD61C+1uxcaCYwn2rLaTBlBj4tO14vRwFURXceNX9h?=
 =?us-ascii?Q?reKuH0CNM+iJVFvPux4ua5B5B+oV8/r00LfN+4IC6N0YMTSU8dVRfEmlWVYa?=
 =?us-ascii?Q?kRKzfuuaZRVB+PWr+qvvjqVaTCS3kt97dvjpKUuLTMAJBgSfJS700Zjb/SZX?=
 =?us-ascii?Q?YhaJ5JqbDF+KV2YG0wfxVsC8Eu3aNEp26qoH+TGsTZV59pnw1xcgo6uwGgT1?=
 =?us-ascii?Q?oxrH4pPVx1icHSeiFLEFGG07729GZiLT7BKz4ao4BTdPflP06oPC3CtHeyd8?=
 =?us-ascii?Q?gFop7eYOuDFP/5XylIksQCw8AVA9HWRyEvNuFKAIRKbPGU+RFpHpgUKwe6Ia?=
 =?us-ascii?Q?xlGs5wmUBqza9iSmufMXrR6NRShqzvdbDBSkAlT1zqL9juZDfyKfQ7trAmNn?=
 =?us-ascii?Q?w/IbLVQi+VYJY+/AD9FqAs5JI5ABMzYpMK7KELpUUGCZjzgOOgUOKjQAIWby?=
 =?us-ascii?Q?QSoYxrEsb+c+71+Lw1hES3MU52e4oNbPAf1yd8DBdzLQnQYFaKYKoCtSaRnc?=
 =?us-ascii?Q?QY79RFBPgF7BSgQmAvYVuc1execdACMgH7LoLPH53Q7s+HlU9W4MKUZDNV2A?=
 =?us-ascii?Q?Q9CrCGOY8q7CrrbXJM8vYolYUfxcPG4YrxE/L+kW4r6J9XLURVz6IWR9Us1G?=
 =?us-ascii?Q?7JBhJFppF3tJhtfW3xJdiZ0ChB7R7g6FHcU/9q/lptWwSjQCZCfSMxk4u9uT?=
 =?us-ascii?Q?vGhazruop89R2rP9At1JnEROCEG8hfQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7533c15c-7d55-483e-8d97-08da352532f0
X-MS-Exchange-CrossTenant-AuthSource: PAXP192MB1423.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 21:11:51.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CYiCPvC3SFlckRIhwVOBXC0f7fMNpFyr/rWqdzoU2DElNKH9HFjzbdI50y5aNDZmgWBtOrhB2I6JD5SRIxXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0815
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:
> I'm not going to review a driver with a disclaimer like this.
    
Hi Kalle,

first of all, thanks for the comment, we are very sorry for the
prolonged delay in the response - comments from Johannes were taken into
account and the new RFC is almost ready and on the way. Regarding the
disclaimer mistake - our mail gateway automatically appends such text by
modifying original message and it was not detected earlier because of the
advanced filters which skipped such appending in internal tests. Many
apologizes for that. Now the filter has several new exceptions for kernel.org
and friends.

Can you, please, respond to this email with info whether the disclaimer is
still present in your inbox? That will help to continue with RFCv2. 

Best regards,
Viktor Barna
