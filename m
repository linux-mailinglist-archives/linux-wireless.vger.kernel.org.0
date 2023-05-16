Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE9870517A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjEPPEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 11:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbjEPPED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 11:04:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2124.outbound.protection.outlook.com [40.107.93.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65215768C
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 08:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1eEjr6eoeP6wlP/cym0VxtPbzNJQWMhL0caZLgn6/do3L3msEBveuF1QwMxRKSEO5rV/MaqW0NZXHU/90OsZqyt3UCBiytROWzYj7dwqO1vs8ydIoenmS705HZ54LHPY5dv2A1yU/ZBM5BKm7KjRj4xgvm3Sd+UJn+39bJoyOcSVacXxqN7oBfPvrr0hpfbS6x3c6a01wIdoWQ4J26+WCViVgrCl5UXODAsJhUfbZJdmFbXsnQU23b3RQ8U5RWS96ZFKxsp3wKGmbVx9K98DhTOfvM/k5VpSqDK958EDI+rFs2NMGE4U0f9It7JXeJ+8nLcCacOwAwiVjEr6itoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nnBukdrNivtHj3y7iTPUoCDXNU3w606xr7ZY5QMzJY=;
 b=D2DkQTob/iAkoNG+1a71DzBSuDWR3xR8wPmcElqA+6nnI5y3HJKwBxphiH/sj9hCuS+BGuXcQmQL7kf9iNu2BpUrNxx0CcMh7WYE0cWfQZa5JIjt3VBhVGss05+Hxy/o+a7mBr/Ecpcrb1wM56iK/Jd8/fF9M5hsKLXl2qsCHW3DMgQdFcH5DnS78k3MuQyUthqrxfzR0UahaYky7hAUcxzJm+8KRE74mi3nLskQA/sZR7dl8YGezUrKqggqqOoMd/pvlOFjXzZW/g421hDTtD4gVSyspB1wThp6Oo3uj/X47CNVpMUqG9yXdgvKOk2ibZIsJUrkCcg9AKGn0UKydg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nnBukdrNivtHj3y7iTPUoCDXNU3w606xr7ZY5QMzJY=;
 b=uNwVf5R6ffFk0XNXo8T98hUHG3gGzn8bPE/zaD0XI4yKmb2NbetDVQCEMdxEfkJBuzIOMSFbvx6DqWlVS6cHVR3R7X5TorPzd2z+CYh4rnXC+9W1hXsuIcQ2n+940GnURTbcHkhxh8SHhf56T347vhq/0iIjBxqZkI83qCGF9o0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB3851.namprd13.prod.outlook.com (2603:10b6:5:249::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 15:03:57 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::f416:544d:18b7:bb34%5]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 15:03:57 +0000
Date:   Tue, 16 May 2023 17:03:51 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/3] wifi: mt76: mt7996: rely on mib_stats shared
 definition
Message-ID: <ZGObVzW2dLD1naIP@corigine.com>
References: <cover.1683930235.git.lorenzo@kernel.org>
 <5e3b29165f2f431621edce1e7fd4e8c913ef6345.1683930235.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3b29165f2f431621edce1e7fd4e8c913ef6345.1683930235.git.lorenzo@kernel.org>
X-ClientProxiedBy: AM9P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::30) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB3851:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf15320-7ac9-4c83-2222-08db561ec623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6b8HzAvGlwr4kBlKeVgnOhq60Xj+CDZSguj5ije0DuJH384S6xnzuElwRZXUIY6/BwWvA4adRxvJX/Fi2RQWqtC/Eb29Rk7ev8djp9Z1qxqFCSPeSbK1MFbFLBHEy1g9RivBK16ycksyxF0Fp3TIspZsmr1pm4eIQCrxOlBF60RHRfUDuUHj8eZlFrHCTZyoAFqSdJYy580pJLGkqMxEnXbZCG0S9YPdteebOnoayvbV/sAzE+/C6NGxhHd1cFG/RVlKfdj7nO42o09q4l6oOZXEiicjygkkw3isTCpYYkPyf6SE+RYusaY5ozHMz+UB3+X2MRAnwqL3SBx1IvpUtwYQgTy7eSipH2uKFNlk3mYh0jlN4HVbuR0TSL7+sJu/hJFhUNjxduf469bIAefQfLkdRWwhLMQlyO+18Duksy6/fjisKWoApna0lyYmgGuG3SXKoqxDraTCo/jGwFdT1P5bULCZf46dl4s7OjWyxaUOg+objnCePYK8S8ibZUa21TCZus644NX/yW3GzdXTc/Zn2bWY08E+TLMnJ0cDAb3Yv4BP1+sPxL164X+eRDjO/AbvX9fV0ALk7oBNW7yGfdy4HATMlYZx25pmxbSGAoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39840400004)(376002)(136003)(451199021)(5660300002)(8676002)(8936002)(44832011)(2616005)(6512007)(6506007)(38100700002)(186003)(478600001)(6666004)(6486002)(558084003)(41300700001)(316002)(66556008)(66946007)(66476007)(86362001)(6916009)(4326008)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dz3E+cyXTv2/7fwWu8wjtMJ7LqRtGg7eB6yLcudXb08gb6Aj6wb2HXnxuxrq?=
 =?us-ascii?Q?4f/FZp6DLy+q6gE8zOqQ9u+YZmVnvj2wL/L6f2A1XwKFX1JR1zSE5RQRN/iE?=
 =?us-ascii?Q?N/tLsVYJIehyS1Ax7ttYcGIMWXO8qzSQ2ymiQt5fsSaXTuRlREuyBs0zzQgQ?=
 =?us-ascii?Q?cjdU8eV6UxhclgEugd/br+t1WgbyrbTv8gP+AGvnFT8JM3MvlsOpMZ3Wt+Ft?=
 =?us-ascii?Q?vRg1+O+8BZt67L5IhQ5mZpVDaG8xBanD04TMIdMlTOclrQVLKVodzNGT2aln?=
 =?us-ascii?Q?Bl1/eDMksj89/ICdQNQ5E2SQSWsdJcC92QBTIKAkJfvejmlu5szFORA7KzNh?=
 =?us-ascii?Q?oZ+wPitzRMUlrSZXSxPiVIwPasE9MEf0824yos7+YPU/cKQnKLMHRIx2hgzK?=
 =?us-ascii?Q?F0MboOAUsfPeyRTECjLF1NjYkcc1n4TmdSkbokZeWPfAmHDlCMW1jbWZ0tg5?=
 =?us-ascii?Q?AR7D6M8XJ8+E51PPH/w6QYzp7OcXP1TgM1a5T3/DIGzoe/6pTChYHhkRz+lK?=
 =?us-ascii?Q?CIEaTeBfzMNJZxYqePuEG7hlqjqvEAMXrNes0GEQxVta/M8B6QTtEo0PWrkC?=
 =?us-ascii?Q?bw52/NYbJ6w32U/uF67WK0HCN15HiknD0+aj9dS4vsWkX9xlfq0g2pVDr61V?=
 =?us-ascii?Q?DHRNRL0bDtroOR7gRTdYkhGQfz0qP4HTh5J722mKwSd7fLJY5hv/RUgpD3qb?=
 =?us-ascii?Q?N2G5aVH9fFSN8u+GSpU1P466vV9yk8K/dWya5F/DNyaPpKjQZzyyS+OL+NZO?=
 =?us-ascii?Q?uUNxwUpf+/czRaDVHGI1qII6zNfQnq5tdum84AQ/jGEW4rhT3dHTVVE8ZqUX?=
 =?us-ascii?Q?+8xGi+J3Lg2ZlBiL4KU1BBkOcQxxzJVhbk2B6o1o8SsDxIqO0StT7pXa3Qz4?=
 =?us-ascii?Q?avobqcqaTnsmNd7GG5ycvMNGhgMJ3HOlQ2otTaffZsxPmFlQbZHtWdKIOLTw?=
 =?us-ascii?Q?02v6lc6g0bX6196FwzHoi/Y09ZWeLXGlpfD9AjWJ0mX8SwY6mgj5vtOK0gUz?=
 =?us-ascii?Q?GinyuIzjH2a7vp08hhcswR4tEjIR4uSkPsfAbP0H/Nm47RZPZQBZo9iksoIy?=
 =?us-ascii?Q?2235fGPCuW5+c9jXSlCccYR6oXydOifrIncu502hnmHQGE88wzDJVfVClMjt?=
 =?us-ascii?Q?HXyZT6gcIFX/D8HDF3UZ2Qrb3FSBQ5FY2faB7CW0TnAYl0AuZMfGW2ejjMIZ?=
 =?us-ascii?Q?vYTTlp523YrNcBYn6wT0cHmf5iO8UWoruBqrVEYSmvEUDHb/4RhaqDp+ye0C?=
 =?us-ascii?Q?So/cc//BbF7Tae4qkl59UtWy9dxv2AykITjUElIsqhVFNXFq3TLVqU1PuM3Z?=
 =?us-ascii?Q?2mqLlIsqEWqsir0d1tjCDdWLRB4rqleIwgISCfEDgosT/qNsH1H4jnt2t8l6?=
 =?us-ascii?Q?kGZFZIxos87UsVUTdNEMyiYoDBPw0T1isvzzZEcAARLemTYWZQRtCR2jXE/P?=
 =?us-ascii?Q?ZtDm88aDehd+pFvbRKAO2sL5dnm1f2aVNW59XqzlkEonKngsp3k/RaHb2zvJ?=
 =?us-ascii?Q?3tz6uR4/nMqwFD8oUKT+9xh6D+sYR12lVNdLEq8R067BWhzXpXo+DNnSe/M2?=
 =?us-ascii?Q?MF6jX2dOFWlSK8aY+angy87LrMDURTJIeOS5WDQnhs5Nxw8I/+hhOZZwjOqI?=
 =?us-ascii?Q?3RA4jw/NLOd77bVbHmtS3JjyPk4Oe0gSFXW7A2zNWx5zuCJ2ZH+T44vrwY/5?=
 =?us-ascii?Q?R45UPQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf15320-7ac9-4c83-2222-08db561ec623
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 15:03:57.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/7sVTnYkmhzR93ivwy2ey27q6ND4L+mvwA5IWfiQpklNImbKhHDGkkdLYp839l+QHBsOLfNPgpkTaCL0HAzymLY2kMbrhmhg0M78TU1pkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 13, 2023 at 12:29:54AM +0200, Lorenzo Bianconi wrote:
> Get rid of private copy of mib_stats structure.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

