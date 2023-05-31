Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB017717DD3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 13:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjEaLPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbjEaLPd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 07:15:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2091.outbound.protection.outlook.com [40.107.220.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC7319D
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 04:15:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpuDXnTCFu/RlJoU3ZLDHDPQFQWOes1hojD67jKWCPwiepA6g8/29VzfsbRIfJyP4XxQre2PNLvQsX27kWBbyqdxy7zYzLSXxA+dAxiVbhbEbg+/6LTO2iRHJ0FOV5+J6KWEDggdE0Tf9YbT3MAbpr8FBKjC75Evrap3XrT43qO+VP+FJymXrF1lBaxtfv5q82BBiXyY1knUMcA/EguToKZnPrGprTaYLVV+Drr8PlDhbFVMMqnNNWh2G2MegBE8+Lmww2uLRLMXYpe4Zxt5GleoPScQ6aYnAtPvSdxWbjzN/VLDvwru2cv15bYB8Rk9qkRHZOlTofMtuNv56WOUbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK7TinaRiffWmuixUzgLKPEvOShyfpg/9/gCAsAVf+8=;
 b=JZu+B6qMK8Me8+n/81AXG3tnNgcx4i/cpOzRlX36viv1mrnIh24TeoCh769PJUO0Kt7jBT9BUpnqZqf2GyMAH8oE3tjv1enJsabwqdy5V5eDApKDfBZ9vBihoiTRiSLkak4UtFktILzcQTxN4U0SciAXch87bkWfz2BrQvnBFKxmvIgEYmEdV8fCvyP4jyw9R/BKzx5CuEcn/Y8O9peFyyCWO0oHz561eu4H/VcDBvI3ne/lsvqcXzPtg8KFdAyfX/KI7dNHPRJYq+ZK2MWKLh50i78hIV0gKkNxlcxiU8eiMYE2L0Wd4fT2Ci+xjapVPEwRLVf+q3MXSyvmzEU+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK7TinaRiffWmuixUzgLKPEvOShyfpg/9/gCAsAVf+8=;
 b=P5AMJc66d8WlnjaDEVRoKNowSsLFZsBSmLX2+pyNEIvd5DFo2rhDFFt6BcV11myDGFmDg4wUIlPBWrO2E3ZeAOuXs7RS0jB6OM6Ea9mqO/XjD2KrwpnTatdoG+A3nT8/pNkMzfVCp3VDpoGkVRbY2ghePUtWNF0AOc8MS4vU94s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MN2PR13MB3822.namprd13.prod.outlook.com (2603:10b6:208:19e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 11:15:23 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 11:15:23 +0000
Date:   Wed, 31 May 2023 13:15:17 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     kvalo@kernel.org, nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: mt76: mt7996: fix possible NULL pointer
 dereference in mt7996_mac_write_txwi()
Message-ID: <ZHcsRawTdXRWPLPr@corigine.com>
References: <2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2637628a84f42ad6d7b774e706f041d5b45c8cb5.1685269638.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM4PR0101CA0062.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MN2PR13MB3822:EE_
X-MS-Office365-Filtering-Correlation-Id: 4285b222-abd3-47ca-919b-08db61c8538d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zlmpjCPItvvIe8jaNjJMZj6oF+9KRk0V2SrpcOEv7g/lYbAKECOpe9U1iSV7vuLOwqoevVHnZD5YmCUqAFKRO8yavo0mWiWGgBMlG0L6IsljJiL6ifq0rzYOAjNhCdpI+S50LtQbC6MlOaWaRAN7O5H4a/YanD4MDct/PxMD2v8/Nn90y/Abk1BLjDbTwVrjbAMy+pXcfqiNE3UJp4PCLlh9ZKlBUXN/stPtz1UEDXCgTm6mMMumijGrHpOgFEiPgAViCm2hB15u6ZIRKv/cz7uw/tCMHhHhUueb0GqfvbUf3jpPimURFfYSIdw0tQCWZI06e8Y402fqC1AdPIS35+invd7duNRCmJIRRGE29RohopU1Q8P3RxMrPwfiviROKxUMVn5LDC//kc4VlfDLrCsipoNx5dnRzREtJq6U4PFzETNcrdisVoA3M0I6M10pUB6d37JhdFJ0sdrhs/X8ovV3MBB9h2syBI0yVz+yFwrkfO+7mOKcqMdUxCgZCP0btY0IwgVgeBuI4Y3M2Be4PJpN0TG31EpuiD1ztHLnaGKhNQLHuIsC+Tg24DxBmSfrUpWqB7dNizkeBkTsD5CVI6IjdMwe8Vuqh4xM2T4FRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39840400004)(396003)(346002)(451199021)(2616005)(186003)(4744005)(2906002)(6916009)(4326008)(66556008)(66476007)(66946007)(6486002)(6666004)(316002)(478600001)(5660300002)(6506007)(6512007)(44832011)(41300700001)(8936002)(8676002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?msYE3j2xR90BU2taUP7YUIdPnFzXs3lloubMXq1WuqIgS+G0t6rNqzGx/GqL?=
 =?us-ascii?Q?EoWUhx3Fpnuar3rxtgldzRK0vU/kB+RRiZPbUuyL7dbDp/rzf4LUXT8RfKVv?=
 =?us-ascii?Q?BuEEnw/ZanaHjjyc6Sam86cX1dW9hxV/b3k3+iPWjjZmYUndTiv/SKKdXWr3?=
 =?us-ascii?Q?h2FHanFNpXTrVBlVY4xRtOdzlXNmZJkvhEUdcN1wOKU1gfAqnewpAVTFCC03?=
 =?us-ascii?Q?+KopcGswNSeO1SpZZZx2+EWzjxgmjI8+LCnwC8CYnMPyllk/i5BMcuoEWf4e?=
 =?us-ascii?Q?LLBVavqMA4h0BDuXN9CddtpFA+zM4mfAcK0qcsz6Xd0GhoKuYhME6C0M8BqS?=
 =?us-ascii?Q?Qn5GTMgiNFlRu/FVzG6hUN1a9g3gKJx3gsBD4NpP0Sm8yUfkE9R5LbkrNdoK?=
 =?us-ascii?Q?uzUIvTtTvZ+EaquonmkiT9naTbJMVU7Ak2uwdFMRgqqqAshHt6FghHsQ9IOa?=
 =?us-ascii?Q?Sy6CbqI3m7s28c08LKo2N3z9Ht+jl5r/bozdPDUOWgVJfNNC753IRWpx5uTH?=
 =?us-ascii?Q?OrZdwujQMlmkb+JFYEKSMiy+tEAA5s/nC9ekRugF3THqxzKaSJy6GTRXpfc9?=
 =?us-ascii?Q?BUSX8kfunVbccIx5kK3m6hgAq5ZCFkCE5E0Myqcz02NGd04zbI1eqOVCRP5A?=
 =?us-ascii?Q?7nDaiMy3QvsV15wdpFpOY8MSKkuVd+OLlt8C3Rr3hS/Y/RN+OYYIFQVR13tS?=
 =?us-ascii?Q?B5N+WdM1S3WVx7OJSV7J6JDE45ECb4hdeSqmgEAriqk8IktJ36tF3xwmxHLf?=
 =?us-ascii?Q?yRTvfBS+gFb/2NtavozeozhLg3m9xWsgh11rRLZvnEnseUgFizMQnI6ro26Q?=
 =?us-ascii?Q?gsMmcZbUVQ/WSsINYvObVAFX7db2w0+638IclIYkiUXP27TBWbeM5BbqLAq8?=
 =?us-ascii?Q?iBPG5KsXAAUovmLTJ0es5niUGWHhs2PEE0Xg0Y9xvhlLkj+6APQO0mw9f/Mz?=
 =?us-ascii?Q?2l6LTDTIVsLyyyLT0oTIp3mSsDUL87pWZsPABZtgdQMjl3Q2g2pBwxl02P++?=
 =?us-ascii?Q?U7uu5QVU5XYvpyp3lGJeTNk0tVEI/1CaMLM3kjT9hJ4lxXgDWEJ0NQCOKRXT?=
 =?us-ascii?Q?GVD9cLjNWv/VVoecZAXYR/hfKQhKBKeOKwWVPbE8yGKd2we4EUR3pJ/TS9rS?=
 =?us-ascii?Q?nOmLbK8d5pSUnLOV/nrcbUUt2OAdlXpxFrei/KFZ5DM4KPAbtrtrfQSLdUfd?=
 =?us-ascii?Q?vWjZ9CBYwMPY5P5p7gbpVzLHMO8vtfNfGbsbO+oKX1kKMmorP8vGZY6H2zHE?=
 =?us-ascii?Q?xDYW7yKW70ZffgJIB0wdwUUxESTc7AZuJc1PBbtVHE66WPexq9cKNfVJAVvU?=
 =?us-ascii?Q?JTD3gLoL9O9b+LKYoInuFNqQY4J0Gofrj20a0evU7lLbF/YAvRqTpwwKAgKn?=
 =?us-ascii?Q?agjHxvTD5twNSvJL5uVH3uzC/m0TBm1KfRLRgD3a2YGpc23DRtCQKlS2cn6P?=
 =?us-ascii?Q?si8tAH32RXI/9quIx1CQLyzaYTyG2zdg+qvpUgJnZ1MwND9HXvL3SksyeP/l?=
 =?us-ascii?Q?U8ER8CNqFfyh8PHg5RVl+csQyc3Xiha1/a0SZUgsSJJYvMzfnTL1eqA3O4SJ?=
 =?us-ascii?Q?C1r6DJFugNE0y5kqRnfDikeS7lrEqCx4ft1hoywkRkszAbjPMKqD2xLUFD96?=
 =?us-ascii?Q?x3BQddd+DDsLxVUj8/QUArutv4oWQya4FQbbECp5YNlnczPwfxaNuiBLc8T1?=
 =?us-ascii?Q?YOCQWw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4285b222-abd3-47ca-919b-08db61c8538d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 11:15:22.8251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwaXkCaPBOvyicSjVna8QNpqye1uhhjSRs6hGsSGqO2Ag6U5vbcs7EByRkaJUUZj/3hfmXBu10uq32C9kKLY+4k96nCUgHirmnL1IaCIwAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3822
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, May 28, 2023 at 12:28:49PM +0200, Lorenzo Bianconi wrote:
> Fix possible NULL pointer dereference on mvif pointer in
> mt7996_mac_write_txwi routine.
> 
> Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

