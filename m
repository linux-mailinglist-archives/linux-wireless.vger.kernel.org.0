Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0071353B
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 16:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjE0O4e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjE0O4c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 10:56:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2099.outbound.protection.outlook.com [40.107.223.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7606E1
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 07:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/UZ1EZgq23hDwoXJLD6uTVg8pKKDGDSRJ5Dxf/ZqNbaf0tgmD7QVplnNem0k+JQcdHY8kYd/eFpbKxCNnXhxuZkvqUNofUwRhuB57PVC14j7TaeQ6VE6IunGVggjHQEcUkg9A86wzkrWJIcNUavz2p32BetNUbVs88BQCT0PLNmHJdN1xT/1VB8jYH6gnqA1YNRPvceeqWQlAM/zN6VIFF1gFG1BtJd845uqgPZecRIRcG/8+mtEaV41aef413CGqjpaBB/37odB87MoiOoJwTtVLE4b3W+QFV8KBpH/g5u7To7yeqgBEXOdrLui/2rybEBoCxBY1R8wgqQHrS4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cEgbv7341n4+Ivbs0rv8C2IPJdTxkVdmJjGV3/eV64=;
 b=l87oZ4yJpzMEE4M5PSjtThXvZXIrn6esNIe9Phr44vycbeabrKHEEGtm8kUJHaqZMSid1sBdbaNUzHWtJX9WMg2fLBYdChz+0L33GGNQu5KYp5BFDMyggtPksSHWN4XZ/LM6rwzZuZOv3VGqTNUc+kHE/sZc8isTqxtt1V8Y5lQWWG0rUp90jIp9OPbG6326O4xHaz6wEBeTI5OeyWz6VkzHrXLX3Y5/Eukra2wwiDnSz/uu4hYec5UEke1bVyMhTU2kArHKq+nXKyOfrTnkRu525ScHd74sG9rELXgzClZCecHVVuEqqOdQhQ93KO8zB9l7IIOidul7a61HGXwlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cEgbv7341n4+Ivbs0rv8C2IPJdTxkVdmJjGV3/eV64=;
 b=T5PYl0+v8EPUKObGsfNjzH0shWA76O/8F/wjb05YHqfeLNYt5DtE70ZanTiJHG2WxePGtE9Dncu87S9PYKEnRwt+k9PIm5AqILjcUPouykmjxSOMFyMebyN7gNfxRaNAQZ4yH7xh55dvkjnT6YwdH03UgMcMgssL+51eQx6KEfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH2PR13MB4555.namprd13.prod.outlook.com (2603:10b6:610:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Sat, 27 May
 2023 14:56:29 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::5e55:9a39:751f:55f6%3]) with mapi id 15.20.6433.018; Sat, 27 May 2023
 14:56:29 +0000
Date:   Sat, 27 May 2023 16:56:22 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Juhee Kang <claudiajkang@gmail.com>
Cc:     aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pkshih@realtek.com,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Subject: Re: [PATCH wireless-next 2/2] brcmutil: use helper function
 pktq_empty() instead of open code
Message-ID: <ZHIaFvyeUvelj/rG@corigine.com>
References: <20230527114954.3281-1-claudiajkang@gmail.com>
 <20230527114954.3281-2-claudiajkang@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230527114954.3281-2-claudiajkang@gmail.com>
X-ClientProxiedBy: AM9P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH2PR13MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 6657b456-3a8b-449a-7fb3-08db5ec28d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGUCO9GEY9hp3GSd/K6Wc0l9S6ohBNXhL9WZ1sf7j4w5EIC2jSEcaTtG3SDGkDv5eWrPJ/umbh5bb1ho2taSh2aWZw32ZhV5S4STmC0UDjaS7EoSd5EZ1SPZQMu3XHsZqbWAN+BfwU6vrumwdgRQYjU6+odgkhzqHU2KVRRzcam8VqrQ6SbpUjjSrNDnSFgvto1U9PZvaG/fXmLOwFm/xPwZVK5yuLyt2xwQxk3WY91WsCkHfpn9rQxqvOzDva+fRAADQ68H6B4AyJc+LqH3tOXUBFXx2vTWrT80tBL02vB5ywZeajzmFzJchQblchyw+J4kU2y8EOPkAULBWIiI8SY8jxH4yKiZBoOJFoQCx9qSxj1xrtfFxoMJUN9H9lV1sJFWecmq9vMVgxRt9LLScsB7OTeGDOnzC+4D9kjtfADIvZ/ybZuVN4aLbLu1NyH0FVy4oeKyOMrvUH+xtc3jhsLzUgYb7ymtQRbIzYLmJIT/quIBoOOxBh88X1O4IVK2G949oG1nBTJA4gDX0h9fG2QZ7drDIFGojnhaoROQxDadq3aJB43vIqBt/PjgQh4P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(366004)(39830400003)(451199021)(186003)(86362001)(478600001)(2616005)(4744005)(2906002)(66476007)(66946007)(44832011)(36756003)(66556008)(4326008)(6916009)(6666004)(6512007)(316002)(6506007)(6486002)(5660300002)(8676002)(41300700001)(8936002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B50g9mRjxphhpJKfjGeTtLdgK3caPpZbxuSc06v+ebanqFE2B1YlrhN1p56Q?=
 =?us-ascii?Q?ILuukk7FdayLAiDpZzg1Gnp6HSdROt/xlUt0yi4Vi9P7vv4UqzHXJ/1ycdVM?=
 =?us-ascii?Q?P4uo4xcjDsLfIvEJxnwp62LPXNmbjEiFbuW2B3sRhYqXMd6qWHGNJxMLHHvS?=
 =?us-ascii?Q?zramy+t0BDYGwgJa0b3qjjSXQnG5E6hw093YyZecQoyT46DwrA9X4fqffnNO?=
 =?us-ascii?Q?5OFwKOAkVwocLhNLyFnm3bzIDEOr6OoIJgPZU3Cn4s+1T01tvlc0a4KgrRDF?=
 =?us-ascii?Q?tNgDLrZXpJIeeG0/hBIBueeW20jv0ZlALKF91STYS/Xvyb54bjm+2pael0KK?=
 =?us-ascii?Q?+ZLhjUfJ2ritX24Bp7w2xNFId5kG5EWi2d+PGkBwl0TG4l/8VJbOU3kyPTIe?=
 =?us-ascii?Q?3NFDzuZCDBinfwdlBc+1A3W6m//9niNQOZRx2dMKvdFx9/OsOja+Gl6jxj8V?=
 =?us-ascii?Q?5kgB6egQ3AJiv/y16HEnBQeXGScP0C+n1ueFPCNpS+UuEUtf4UecU+//IGWQ?=
 =?us-ascii?Q?N11u8802mT7wXYHHhLr3ueZ3q3fHuG4tsWHj1c0EnDlwuCe/pNf97VLtMji2?=
 =?us-ascii?Q?VSGma7u1rBJpFKK983mFvm4IPgBXW11W76QCdDeVg4Njvwom0otefMIpqNWM?=
 =?us-ascii?Q?gonS3Vz3vLvG3bTpM9h7aYG0IcLiA1yfaEi2/TfCwEgUSjoTE+sKMXhjl0+5?=
 =?us-ascii?Q?he8v2iqUH9iwLrkjf0vnS5mAFmqSbxfOi0kbpmK1X4pKcZvTZg0qcv090fQb?=
 =?us-ascii?Q?N1oyiQ9QxdyJrjqUXHHOJkGXsp6wfnVQM5Ebqkr6lNoiu6yQW5Vn26iyiOgb?=
 =?us-ascii?Q?iXhIvcmU1xnBsZDwUM/cq7k37IPUca9UaFfQJEEYSmqM98mhBKqkbuJc2yBp?=
 =?us-ascii?Q?oknkpC70VS1Y9Jn5qxPgPWD1G+XErd+vuAZVyFwT/q+9lG7o1mpZgGTohpJH?=
 =?us-ascii?Q?WnwIy38Vt126Fyj9wNjq4WRxoGljR/0nUfYQPZzJYWtQwOy2fcod5yjdjyy5?=
 =?us-ascii?Q?74KF2xov+n+puNRko2CQ7XRGl0vOjZLdJD5TJxNXp4ezY3LJZXAIf647nAD2?=
 =?us-ascii?Q?1jyWzk2Wxz+K6X/rLPsn2NpJCK+SdP2n6zWlMJhc1wcIYm5BxKQaYyZHDjBc?=
 =?us-ascii?Q?Bjg3/MFjj7/b11OiwxM99mAZOM4HIdFLqrIiFrqiEA98lV9jQevFPHViHtbn?=
 =?us-ascii?Q?9HZ+xe93GKjikv9JMyuMj5qBLVmBYIs72vXpZlIbNf/DtnduI0llAk1IOQU5?=
 =?us-ascii?Q?CqA9esicJvSsfgEQ6JvNcsW2jORvi5wFjLUjaSPgePI4ZkB7axeQxoSOtXr+?=
 =?us-ascii?Q?4trMwCQ8DBP6AOh65LVdwDH7Jr8zLv5MvWvIIUS848qjPvN1h3uR3hlCUyde?=
 =?us-ascii?Q?L1FzerhkczHJWQ1e3WUbPcoihZgLHiJjA/cl3IdERoRYqQS0ak4LcQbp0Q22?=
 =?us-ascii?Q?Nsjg3jiyApgiQmA3Ee3eXzChcX3uk/fNm0xRDrm+z0IcFyZ/VCwAio4hCFS9?=
 =?us-ascii?Q?h17XQfVMBjS8/CGvCvdKqpQOquLHhqlvabsFaouITcuLaxP7jxKL/5JzNMfo?=
 =?us-ascii?Q?dcFt8yz1KtVdxV/1CIBKD42SqPpRHyKGy7NEbRm1NT+vPNxvGDvFjl/YUcJZ?=
 =?us-ascii?Q?Hv5DwQpZi2IXIbEuCA0fxm+Z8WwplEBKlajERcIl81u4Z+1NCGAog+kXaSXf?=
 =?us-ascii?Q?r+7Hxw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6657b456-3a8b-449a-7fb3-08db5ec28d9c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 14:56:29.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cn59AZNnP0+cPENPbnpoEEPFnOTCt/vS6GP1CalBpaSNFW5rYOr4Jli8HF7/vUbXYEEytRredLOT95NGN7ZrXzn7IYU5UjMyp4ZWOjCQ4PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB4555
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, May 27, 2023 at 08:49:54PM +0900, Juhee Kang wrote:
> pktq_empty was added in commit 5b435de0d786 ("net: wireless: add brcm80211
> drivers") but it is currently not being utilized in some areas. This commit
> replaces the open code with the pktq_empty() function.
> 
> Signed-off-by: Juhee Kang <claudiajkang@gmail.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

