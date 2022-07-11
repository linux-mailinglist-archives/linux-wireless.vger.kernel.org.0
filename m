Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F04570DFC
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiGKXLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGKXLO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:11:14 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20067.outbound.protection.outlook.com [40.107.2.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CBF509DD
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVwmpn2w/Z0m++L0WupUPQbQHUR0uCzyURKCzW5sC14gZwJGy47G2TkxdjHDXgvYTCQsU6s/ltMCIXrqJNHXKx7FULWOHc65mvh9QDPJgeJMK5TozgoU7BWMV1N2+F9c2hQ08enf3XdMwhiukwaCd1prgByS5p/DE0+4qhxtY2DWQglShnTYCNxMIVYntuCTZjRy1Hb4pDFFMEmYC6i850uEnVmDXk4RYOXmrkltdLJeAHRO18DYI3GXtaDtpRP7t+vvYQ/wO7xcaH9NIVPFlATQKj50DYmKaOnHOb6BHsnC4ZTU5TldmISIpdI9vlkAlS+rKw4r4v7Fo8cNpzs4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPz1Yq92ihpBRoC+WlB0bla2aH8B8nlMbc4bXgqTUSM=;
 b=RtHuu8H7DOiati3t/23Z4kcIEyVWLdxUWb+gnh/nJYp1AmGoRbB9aXAUCKJdPNvafeZZsohDLAr5Zq8NqXi94JMMkHXKMc7/ct2F7sZ/prGociRcyJZoAwOs7rhwnAmO0U/4jG9VnYo6ffLU/M+gljshmnv7AQJxw8lyYxzF0wwcbVAQiq4n3a3bxKIG00xHqAaRbdA+dOJRfwK7C6jgbSMU0HfgwuwuagiDnFwwv3TnHD4/c6/Vb3OCHjgTpAzeImlObTSfqy2uuTGdcQAs5NfaDGB6SUqff6eApr6hjYCIi28lWXgCn/V7MUmUxNAb1M3tAvI6mOK1cZg6q04Wqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NPz1Yq92ihpBRoC+WlB0bla2aH8B8nlMbc4bXgqTUSM=;
 b=m3v4PJKO/wLw2iQDSTxtpHBd05UtpZSrwKHx9LnHMLELKaa7QEUFBiDFmhNIQpQHoKTgiYpOJpycRTrOaVYi3Uq57pLnw5MPbqksW4Tj6swkego9H+K6B497I6SenRSC5fyJkLG3QHlT7dX5YmjTJNgTAMgUozkh4hMcuT7x10w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0849.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:11:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:11:09 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     johannes@sipsolutions.net
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 36/96] cl8k: add key.c
Date:   Tue, 12 Jul 2022 02:10:13 +0300
Message-Id: <20220711231013.2952309-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <09f6890123176f5b31e15a8b61303d65b83527a6.camel@sipsolutions.net>
References: <09f6890123176f5b31e15a8b61303d65b83527a6.camel@sipsolutions.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::19) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba02fb0-f638-4bff-ab6e-08da6392a408
X-MS-TrafficTypeDiagnostic: AM8P192MB0849:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4eyoFGZtu1IZF63J/Ty0wTzBYXUVzUnXolYpbSTNvKYrBuw7n2TBPQ6BNhmuBI8RdPhGCt4Mv52AM2RLDcszBWhkGhc5uHgl/i2pCy+2GcUV4FmE5JdIg0DYjliJUsdiE5C3DiwruE/eMxU2Wfq7y9NMCJGy72IUxvxNNS+RQVA4RWVBXONCGnrqjWdvehXa31HT0WdHHBZs/aMDaozFawwlO/YpfIvPNpiFkW0oLqu3M7Y0phqlcZyG8hOrfGxws09oO/XLN9vbGYIUwMowurOloBVubgZyXt/eIaJO2T84fJnEKTqNkxL/aPf9lC9uvnZ/28ygT28Oy1cSvx++XRLDjyZFtZ4osyDZUwNBbI6mg4wdzYQVlFv5ZADzku8UydlCA9Sgeej1aPEoolMILx0MbYLPse3sxTW73T0mIXlK6fgCmi1f8IYmLNyyT5yDw6/kyi3JRAoWOxtZRuo9ELFpB0YvVpXFkqqqVlZQA9sUQ1e6+Th9VGLf+mrSddLusdrDE+17T5MKOkobmxuTS0CDi0/gOwnn6rwtn/lQSDf6NCiGzEripKVQAr8oji5mIxyK4RW5bej+Z3jYkC6+OLQzPcDZdjcZA3PeeYvgYTjf1ARMPju1DfgWAPPQQ+yYoKVVyvJGTUaNYbamSdcL8aTKjANZmOeNOH1D2vlFuCFwj+hHphqYLITxcCHsvXBRUBP+QNBDNlMCTIvsGyKwfVFZuwL/bcUlUPw0e29FTiNPXPJ7fYODgiHaKEi8JCMOXq4Bk9AR2q90L20fCZKIb9OjI9AV125ucoBSsYZj2T53h77m93jv/cKfzdpdPRIlQvJZg9rfz3evmTsfOgK9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(396003)(39850400004)(8936002)(8676002)(186003)(478600001)(44832011)(4744005)(1076003)(5660300002)(6486002)(26005)(52116002)(107886003)(55236004)(2616005)(6916009)(6666004)(66556008)(6506007)(2906002)(86362001)(316002)(66946007)(41300700001)(66476007)(6512007)(4326008)(38350700002)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LcCaw3lsLB/Hd/IFWnOpl2ZIvjXbVnaMH08FcrzBsEfvW2ETrG2rn2p+fDSI?=
 =?us-ascii?Q?QC3Vdv7VG8Q9lIIHVUOs+XJqjUfKq+CgWJ89/DcgTSygyCHcvllb+ZpPertn?=
 =?us-ascii?Q?5C0YQ73t450qMyLHzigEpAhwo6uyUIf+nW7JzMUDyZMD1qM/J1njEGw3BEaL?=
 =?us-ascii?Q?sqIzMnZACyDEwIZy3Vr2Y4uGHfKSN8LhoobPVwsD7SpKUkbaY6o+8qIdZqsq?=
 =?us-ascii?Q?g9BfwXAVberskc08fy0wE2ORtcjeQIGrFybhiOTfuLl6Y0lp5dKO78mlEECo?=
 =?us-ascii?Q?qL+uZQ5tWB2uV8kBQF/hiOrIwT01meQYTO3TYr1LrbTCoCVtdGbNjTnLEuOP?=
 =?us-ascii?Q?jov2+DAbKvhlQ3rt3tpYZfFduxqdcztd4nWAtx3wCxvknAC195MSImH0gPiL?=
 =?us-ascii?Q?6oHX5g0kPC7eKtXKx2f7sofOPfW7VLHBBkVR9KYRAPT0svI5sXAM7+O5/GsB?=
 =?us-ascii?Q?3QoduAkbdWjcTUDP+jllCA3y/Kqn7guA6HTjqi6zfbgyuT0Fmqehtmt/XNbq?=
 =?us-ascii?Q?6nMDIsJ1jBLh+DE9XSCdHfRtyxOfiBdLpgN4R8HL+pabVSqMI7fDbyw8navv?=
 =?us-ascii?Q?yxKjbx7OBMaiS4s8sITsRmg362oEKxW1V9Gs5uDHLdskiKCiADD7M6pj++e+?=
 =?us-ascii?Q?31W+W2obNT5pj5f4BPwHt2ntyA5Nr3557Qk8IJ4YdB4oR3K9tRFWSp5JeqN2?=
 =?us-ascii?Q?az3NbHkkYow0LpLO0+phYbqf8dD8idShztGDmJG3aQa7b10Kb8XwM6U2GO/S?=
 =?us-ascii?Q?4/POVYCyhXkn4uV6NOzkCl/weS9j2BO4lyeUfLszOkTJFCaygzHbBFuehwUy?=
 =?us-ascii?Q?DGdaGNgOl1go77JsIQxJPioh3GWJvbLmxZIiwbTElT9AyUNzjfxJEEkSCgsr?=
 =?us-ascii?Q?omkPp5q0J7cxwcqyrpvlGuFvfcx9MQ/5EGR7eEXF2ShBw9bXqw6Kzpdaje6F?=
 =?us-ascii?Q?WynzREl9yji28gUUIeXqwk5C724fRcMnHr5YpYCLY49QiNRALohBmdkZBimG?=
 =?us-ascii?Q?WYk9ydiLYU577gcF9hOlqulIydLgufIbttAWasT3rZHbnm4cSCiIR/PaYsYx?=
 =?us-ascii?Q?/DUFhvZLB37Evr7YDM+iWtbiVWpNeUT5CyT4vMxcuxXdjK4nKFnZHNWe0AZe?=
 =?us-ascii?Q?Jc5bx8BzWMuUMevJYJ1bWaIT2VW1Vd0z+13wh+Ua+q59QLWZUAUo2xwcL6Pq?=
 =?us-ascii?Q?ScM19JhhNHTG2WTx9eixYHuHHeFSqTaIMBbHZpsl0kIcidUp7S9S91S3Di7i?=
 =?us-ascii?Q?765G7ZHA8RGm0HlgHbOucFN5Pq581hF8VkddnBt6mKVLwKl2O5QcK0T6cva6?=
 =?us-ascii?Q?GA4lMcGSOSedDKNVKDOjmlb0fJOXkeJld7pnuybBRds9mAzF08b6GCzUD9id?=
 =?us-ascii?Q?/NSfY3tOEHC+sbcBdp/Ipft9w+uOmWeRyruQRTtuWu5M2M7QvZtQUyl8zlhi?=
 =?us-ascii?Q?4wz+qQNw7Rfrvo/29i2SXXy7NYRY2JY2LRtvy3IB8a/eRtHgy7YmrLrhX2rV?=
 =?us-ascii?Q?8nxzwlr+Hj5vV+doCoLNiFmQMljIb2e3gpv2T7bdIWCZ01SRtYmJpF88G8+l?=
 =?us-ascii?Q?TlfQJReSIvCSN+eE9vFdPhIXOWlc5ANWy5UP2RTXiiVIAihzzDRcpdKdu3YV?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba02fb0-f638-4bff-ab6e-08da6392a408
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:11:09.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uj/cA331dNY6EvyzWGvlRXWH8vOBYTPzQI1uo89f5L4D+i1FSOTgKAugBRslAJQ4MVad6PomJeoOnV/v5qL/wA==
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

On Thu, 26 May 2022 21:38:08 +0200, johannes@sipsolutions.net wrote:
> Why do you do this stuff in the driver if it's effectively the same as
> in mac80211?

Indeed, thanks, we will remove that. We just wanted to have replay protection
in our RX path. Another point to do something with our version is related to
the most recent WPA3SAE mesh test results, where this custom implementation
broke multicast/broadcast frames.

Best regards,
Viktor Barna
