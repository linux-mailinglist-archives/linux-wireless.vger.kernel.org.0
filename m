Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F970DA9B
	for <lists+linux-wireless@lfdr.de>; Tue, 23 May 2023 12:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbjEWKcq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 May 2023 06:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjEWKco (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 May 2023 06:32:44 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2107.outbound.protection.outlook.com [40.107.220.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E496FFD
        for <linux-wireless@vger.kernel.org>; Tue, 23 May 2023 03:32:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb0c/hgN4UrI5/K3npXm/EqB3uvCdCY2EO/hgIQQGytC+IgNXJoUIaydbukxmT6RsQV5dSPC4U9UUnjluDn0Odn0N8LZZry3qVNbWKeHQaMh8P2B2JPFwY0d7dimZvT7qIPo4pF49qwBN4n+dmBuqMe6rEhO412G3RY9gLUKMO7QnjugFiHGBknGWa7EFq1vcZI5WxcJ96ptQpulju/cHYpG3pLjNZCcrQ3W9WdrBpUN5SyUJx3C6CxN1Rzzz5Wze5W0q0JQaMD/Miw9tUBsmapwPJOdmjMOEaN65VA7DZULblaC+obT4ZDm1OIXZo24Soofkl72/OPafCbspvqqUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCVovuYwwVYmFsdrzlPUHJ8U3W9YKhRMU8TYJr+iCjA=;
 b=Y09s9MhTbTv32ip8HihL7Y3XVMsRhBo8iX4FPXnbEEVto+p0YrxE1Sx6erngMTJ4LzykN2DqM4rBCLZcEGOyBCaQ3Vyc8cYV1vgwEMOj5S+nvwRlk0k8ia9pj7ccnprZHqmPdZg0gMTpCrOyuC+SA6ZY1ZqCcCYUoOA0JtKqJS252/kHz8RWLgu7/qVW4KvgsyBg44wn1oR9GnTEmOPivTKAhLZzQdE2YC1HUMI85UFUTfGxGYiBI9rBnXjb79/ivdDd36g+PIvHN7CNBk0ltXdUakQyZnZ2rjl8efpeMamm7OBmS2Y3o7IQ1uRIVSuPluCUK0b4ER3TR1D0YjwcaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCVovuYwwVYmFsdrzlPUHJ8U3W9YKhRMU8TYJr+iCjA=;
 b=p9UK4ZLAV6tcJqtveg57PgeNjVd3sa/RdFJ/6uC9vLaHhKOWV9W+PNKSVmJKl8G4Ynn6x8kjsa0hCMUhT6d7PoqjYaCiDw54gH8PuViqMDRQTqy1ZcuavHRaZ0aOs3YUlpzbd3+QJRSdWO/llmC5NNH1an4/QPpFc96+Fykvjvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4523.namprd13.prod.outlook.com (2603:10b6:610:6e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:32:39 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 10:32:39 +0000
Date:   Tue, 23 May 2023 12:32:34 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v3] wifi: iwlwifi: add ethtool tx and rx stats.
Message-ID: <ZGyWQpFs9DDAlsx6@corigine.com>
References: <20230522233743.3058844-1-greearb@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522233743.3058844-1-greearb@candelatech.com>
X-ClientProxiedBy: AS4P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c112a62-1691-4733-daa6-08db5b790893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB8yGkszxp5XfYnJizhe0iWWfe0jj60pTxaRLagKhP/DivFHGpCXd7/JaVeo0ikV1IVNNubVs7LFwoVNZdj1NytXt57kA9xEl0HJPcQ4/izqlY4zrwC1UzI1d0O/RgLdTrGxqk6BjfyVY3H7bbBWO/NLJrfknJU7V3sSDESl0E2VAoBmKixhvk56w7v9AjnENm7RL8kfcpjn6ybuvC/CDqAmC6UIYP3KMcNixJaBewuchD77L2E6vQtPpnaxJbBOGoitzyZ+MMnwYovKENfvZwdBRS7gHiDz5cJ4mbIgC3yr5eZNFWmoTeULYCFdGk03tLnBKMnz+zgyYtjb4qALAdOoIofPH8ud1BIPtasKuguonCI97Gkqp2tOXn27A7nmoyVN/euaT8MRKwgKaGEKfnyAjqq86bAR9oxiqHybJYUJr9ihEo8CUrRN7En9yradtauBaHpqU1qxdyC6ivZV7mM+CtNXYPoBAgXB+T4PLUIwOUYzi143jpCf2ICCV0EA2YzWHELAVRxwHWAK3yE4l39Z224iVZi4b1XOSQ7NJPUfNqkKHjHsSbzEArijgxIK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(346002)(136003)(376002)(366004)(396003)(451199021)(316002)(4326008)(6916009)(66946007)(66476007)(66556008)(38100700002)(6666004)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(86362001)(83380400001)(6506007)(6512007)(44832011)(36756003)(2616005)(2906002)(4744005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPaRB6yoLm+bYj4GgY9dG9IEuCNR25LQ2ixA+jdo2Y53FnnrcACiX+i6+fCL?=
 =?us-ascii?Q?/6X8G28yshpCyyiIThTEiT6hp9UMPxktWUYsRXWWzslldDMo0k0pK5LtMVVd?=
 =?us-ascii?Q?yz4wxg+OUiDEL0/DLrZIRhiVqzHKfL9WNLOxyAItCO8bhG5T4Jzy4ntJV+W8?=
 =?us-ascii?Q?6wuWs/u+RDqNvWex/U462luO0SWpbI+P5+0GC1LeuU2q5PPW7oIqEUlxA+vg?=
 =?us-ascii?Q?07CorGjKD9vhbd1abG84hoUFpa5zRFP4kQfmd2SzW9V9orvnwOhD1eR+psfi?=
 =?us-ascii?Q?kjjJ9aKPiqKTDxOerxDsu4WiqGjOoGFRB8yP84OZ//6EK7Q4Y/Wh5yQCtrhl?=
 =?us-ascii?Q?DitI0AT7nHFTXqSKuDKUgLRCLJFlph2qhZRkqJ5alojSjeSoj6L1HhqDJvWI?=
 =?us-ascii?Q?PklCG7uUxc0KBP4Pzwjm/GNc25f5if3LVRMQlTRyFK2L0DbBRpLwRHISMuGQ?=
 =?us-ascii?Q?OuPyHsVstxI9g3fYKQSntJpE82+cMn0lXlEg+km1PrxQ/ZuhRdKhcDNBkZi/?=
 =?us-ascii?Q?fBBuJJYgM5cBCboAfc5IP2lDN9/TdXS4jHvU0epCxwIx3QpImZa4zuzjVw1/?=
 =?us-ascii?Q?/BUIUQ94Mz83iaT/AqS+DniaJHpC8HjBtzIcX5cdTjMIFZbIP+DIgsx/GzSf?=
 =?us-ascii?Q?+9yfJN41NFA9AHriMfQwPm3jN7W5+NqkObIyNry6i51286vPwcrsXw+Y78ir?=
 =?us-ascii?Q?1+jQfcxFUViMVgUWyZQDwmWU4pV87+FiER8bX2n0bGCkYiHDcpuhHN3t9XU+?=
 =?us-ascii?Q?QKHBK9NhilDeUWdOoea9Wn3l3auCSScDjnef3HXOjZpcqYwKIzRDkxLLWmlF?=
 =?us-ascii?Q?ITWKpG7NUIzjmDGsAhuU1W03FMjaMo4xrOKZeCqc7Zn3zRSDV5RxOpGTwjxR?=
 =?us-ascii?Q?d4VBUQVzABN6jV7SjYO6T9s/KgGBf/0wmLP56ZkHEH6a8YP0JkF9O5XwyF8T?=
 =?us-ascii?Q?3g/w7VdsVaeQxRD0HPmVlA97OOu83CEGljSDBiJrzXRgw2zb6Yki2hGlLtMx?=
 =?us-ascii?Q?3X6GrGJ56cEtV0ddbsTwGgBR4YcN/FQP/jUwA5uc1pyyhd1VEyJtK1mZCRVK?=
 =?us-ascii?Q?1VeqL+CbcQ1EsG892P0d9x4vs2LuWnZobl/rWGT2ZjsY1ybRLHViU3fcqJJt?=
 =?us-ascii?Q?a2p+jN0ks37kA5nuRXMzdg1CkXI4qrbBHmhVp8U5Tjg/N8B5fBFQgWusZnLA?=
 =?us-ascii?Q?bbSul/Q9PT9cHnwK1zp5QuvTyyMraCrE9fxFU5MSKqtVUu/rmSou4BEZoyqv?=
 =?us-ascii?Q?XwjuHuNm0epruXcsfPg/tHC1+Ap8jVkF/vUuvFGTSGmZMm3qOZygy7lBru9Z?=
 =?us-ascii?Q?g3PVbnwvoe2KxRkWugmRx0WzJBx4OI6LlD4V0FwGjjJXxx80EdVpSB+6Km2P?=
 =?us-ascii?Q?yWUURiZnWYZwQj4sjieYHxo+WDe2O3yrcc0w3kXyHX2mqtrvLgkeeLSzabqp?=
 =?us-ascii?Q?Nk25WW1+4q9c3XSYyug5I+9O7zxFt5E9+bhTjTv3pAVbqcxVlXNLY8QYDhaM?=
 =?us-ascii?Q?MBWWHgBEEN2SFn9h0DGXW1ZB3IeK+YkGla6tEqtTw2QN2V7Hq7ddEZ1GszT8?=
 =?us-ascii?Q?Z2IDct5Kexw2dKEtPEh0hD3EPgj5tSQWjpfzY15oEC9UtCvfCO1Ff9CcXzZE?=
 =?us-ascii?Q?FyG348KvZFIBxun3UlOkF7EE2MFB3H5/Zcd7ZA6UneY+blNr5Yi+hXFfaTVP?=
 =?us-ascii?Q?C587HQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c112a62-1691-4733-daa6-08db5b790893
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:32:39.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3685X4EmnodGidU9ulnPMtNsLLSX4o9E5vb4WiaPxZe3oZCH2WAu6OHN2i6eN5deDkbmS7++RhhB/qq8zQXsppC5lM6jcBTggECU7ZFWJVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4523
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, May 22, 2023 at 04:37:43PM -0700, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Report tx/rx error codes, nss, mcs, bandwidth, mode, he types,
> tx ampdu length histogram.
> 
> To provide some clues about how transmit and receive path is
> actually working.
> 
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
> 
> v3:  Combine tx and rx ethtool patches into single patch.
> Fix some stats calculations, especially the path that consumes
> tx frames based on block-ack receipt.
> 
> Comparing the stats with expected values now matches better, but
> hard to verify everything exactly.

Hi Ben,

I am a little (lot) confused about what tree/branch this patch applies to.
