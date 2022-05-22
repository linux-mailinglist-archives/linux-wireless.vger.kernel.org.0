Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97076530508
	for <lists+linux-wireless@lfdr.de>; Sun, 22 May 2022 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbiEVRvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 May 2022 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiEVRvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 May 2022 13:51:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1521E3E1
        for <linux-wireless@vger.kernel.org>; Sun, 22 May 2022 10:51:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eka8yfu/Ew6QMjsbnbblTz2Llv5DjbdWEymnI3SgmGOXq80oXJErMckEz+4YJvly3oA/RSnuxJpjO7XAsr6Z9zxQTwjbsZcwLuSQRq+wZDM6uop9XbHXCyjtajL1ydN/zy/rrZszgexog+YUOtDzNJk4NdiMk0aG3mFWlAMDNEuAdGLb8F6JkiJ+ObEldVV9Llc2FUKkzBxvSu1wXsFTIqZGkqeTAJU2IDHuKG8Tm60wxZuGBL1HEvz5XnQZ1Nk2tCCLT7bH2dghXv0A9buHeVhvXbc/L7Nvy21b0YcLYBhju8EBCaFX1y6T0HHYhzBAbTdkYFAkNl6tOk2+yhTpoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3E+d7zhQlF8K33/aug/XcT8KN/8QVPclDw3ZthJpbQk=;
 b=a7Uiz+WvWi1+cmqFIkiKo7DNItKypJxSXgArQ0yH17fikheKCTpikjRl/1HWmztKx5RAAB60d3WizsqhRK36XeSX3Y7j+5hlN1BuiBJzYejtiGe7+imSg/udodq6wb1V9t1T8Yzdg+S0q29ElRks2P+v98wn5eIoBO4eEHq2paFzn3tld4zmu18GXlYQ9qMk9byb4NFQOjpeJDdNkgvJCNOSccIXIgV7Pwwm7SFPqAupAeuDnhi4o7EreUEvB8gG13ZE+rpH4twLUiU/9AvhaE7qVz/iQeRp0x+kWyf9vpa8uuaP0HMJy713xlp/wCi5i/qiJR+Ih3WKKeYyFMb6OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3E+d7zhQlF8K33/aug/XcT8KN/8QVPclDw3ZthJpbQk=;
 b=EGx3cAiXucNDPSEUSzx/16lPSpDeTmhJZIKXw94NzpHoneuwGzGks52mvf4lijyEJTJltBEmqONedFzE3uQKYYVMvwnEgXXF1uXYYsnaAxcqVD6bDxU847cDNesVcUTQq95qzXhBbRcjPZmI8LMT1/Jgn9aOeBuTRqI4FrWWw3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB0987.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Sun, 22 May
 2022 17:51:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 17:51:36 +0000
From:   viktor.barna@celeno.com
To:     johannes@sipsolutions.net
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, oleksandr.savchenko@celeno.com,
        shay.bar@celeno.com, viktor.barna@celeno.com
Subject: Re: [RFC v1 000/256] wireless: cl8k driver for Celeno IEEE 802.11ax devices
Date:   Sun, 22 May 2022 20:51:19 +0300
Message-Id: <20220522175119.285719-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <4526c9fb8269675a98845160d15d4b746ae3b62e.camel@sipsolutions.net>
References: <4526c9fb8269675a98845160d15d4b746ae3b62e.camel@sipsolutions.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P193CA0120.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::25) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9f512d2-50c3-48cc-1c95-08da3c1bb6fc
X-MS-TrafficTypeDiagnostic: DBAP192MB0987:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB09879C11AC781572CF65E95BF6D59@DBAP192MB0987.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8TVeF0MMW6CJ7HBHsB+rgznsktcvQinJFNFNyAOBXkfdTJLCoiLJ+HWU+m7WNXxXYPFq67gqOC730sd38eCUNuxLK/WTprh0Jr7YsdZhr0eUslepi8cgRrSBbMOceWp85jzyu4S36c5XfygEc0DkWxGWDg0ecxQPM7SQXJKN71+ZGPoIjR9Msx8L0fPwWDgMctpmP8RrfjF1umJ1Ojns2VoC3KyPV+Pt4KFzPVozUbA04Ssfir9ys8J2euxNRFM7ncYTxlBBTzT6IpXKc+lBMfo9U53kDJvqeI+K9h6RD9mKe7wTICv0f0dMWIJpC3xygFL8nD0WKYElzR03aOsyZtR5N8I6CXSG5JMmpavBho8/DEz+bLPHK2ze0S8ciM/QBTPpJFRw12EBUY4nAOvzJ/jBwhfMdnSEixe1Xqv3dFGCgGHJsv+dFXsI2NvuVMfWcZuc7U70LBBpov9Rqx5NG462VtlVs00BL+mr43mqv+ZoyfvlHZT9GMQorMYlhvL3KCEiXFfJsct0f29rja8DVSBmRhkG3tim5WYwoRoqMZq+6NZjKP+WGbmlqgVw7HTCBt4egTPz9gOcbzsW4OjbStiVKDqXH0DHV/dxaLXGBM0zNN3gpUxjGe0ZdVOvOqvykBHETfUdBqU+4gBf14kdfYbyjsBZqulTo49wnQL9Xx3VeDay+o9lf0EYx+ZK5zQqQzDoob+qSiS8PJ02TjDMkNrPMmapVCmSDSeoF3b0EMOT7keozp9fWqc0/6ASFpG6OPKizTCxSE2P73YfPwjWwuIHsUICEhDISerBa2FMIiipVnxmQmq8rTcetfD8sSj9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(39850400004)(136003)(396003)(376002)(366004)(346002)(966005)(6486002)(1076003)(508600001)(83380400001)(2906002)(316002)(6666004)(26005)(8936002)(36756003)(38100700002)(6512007)(9686003)(52116002)(41300700001)(86362001)(107886003)(55236004)(2616005)(6506007)(66946007)(34206002)(5660300002)(8676002)(66556008)(66476007)(38350700002)(186003)(4326008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e+hoC5nS6cwTHzvpTp3HTFPA1nZd/P/o0HED76n6ADiNsrD3W8rUNCVdxkgj?=
 =?us-ascii?Q?3AoRcKZkT+3yrtG4xAiNM3UQ6xLS9IZ1+krK0+eh7sM2XE85ZeNu8e1rrvC5?=
 =?us-ascii?Q?HuOzq31xxfH2bRC/zsqEtAYNRw0vlRmriJnTdyyDt1iGVnRFmXKOGSm6XzAH?=
 =?us-ascii?Q?26yekTKRmtNtlgDRiOuPZ43bH5KTq0UR1tYqgvnl2h1ZCEMuxP7ZyBZVMBdU?=
 =?us-ascii?Q?fqdIKV788xxsgfyJKVGOiJ3b1DQAMdVaqtN4dDiuRkpAIsVw7YS1IZTrIBoD?=
 =?us-ascii?Q?H3IqYX0sQbyXCrVH060Mv+Xb5+3LT9kCqYplBar8SzpZrFgo2TnBO6cMVufL?=
 =?us-ascii?Q?OxsgSk+hG6fw8fI7RbO3S0A/LXSPiquHPmwip70QGGVPLx1bANd4ynxIyIJS?=
 =?us-ascii?Q?+gLsthyBs8VAINDe+VVDGZJvWghYBqrQFNUjgX2r2PMEY53V0qx6xToRq+y3?=
 =?us-ascii?Q?/LMOMDsIu/JiLamv2fHxBRpQCCDO3DXuCA1odVoess5hrozcE2Nal2AxjnOD?=
 =?us-ascii?Q?zSIQJ4IluTRcP0csE53n6FYGdHrVvIwf7pp8cXO6lBVTHGxCf2aDJCuBxP4P?=
 =?us-ascii?Q?Cv1Spv8YEEUqM0iTjye2gBswdI4fNjbBzvqlbMkBe5r+zgS4vIr/KK6NXvAE?=
 =?us-ascii?Q?5QP99Zdj1yrtfndwt3xTiT+kuwaQKOjHWWIeq68Ifgv4ll9dlQF2n64HVQzV?=
 =?us-ascii?Q?q+drzXvTlV2Ti47gVjlcAPOjonEH6qxtJGIvJLPeiLSX7c7QbUtT9vy2zi/6?=
 =?us-ascii?Q?xAVn3aVvXylNHJtBMzc4AHqrJZZSiWbZpxyy8F/jjxxa5vlzk4j0fgpBmreo?=
 =?us-ascii?Q?exv4HjaumAiBbUpWRCP3QYFTXKsZU9NwC3vlAmw1aHvW1SAog9Pq/DQ7Odjp?=
 =?us-ascii?Q?NxPdMPkX1zDSQYqfjpYRV5CQbAzM5sQT6YzxhbunlBklfdxHr55ZkDnmYkSp?=
 =?us-ascii?Q?42oQHTJueDeldAf5sYD0RLwoaVwiXqqevp3fuUzW+Fn2n4RlkjZXBcGEqmsb?=
 =?us-ascii?Q?RgawT/vpbJdH+iKFzyrlP3B915l7vD2HH/4UXouzujfzWxosaILSaQSYoa15?=
 =?us-ascii?Q?IFpicmNYPZQYIXVKtloyAPSoIm8WmSsl0GS1E6VkRf1P9UGmjHxnlDrxiQ+0?=
 =?us-ascii?Q?U7uG/wLohrdJeKiSImSTbzFG70FyCD/RKLIsSlEBJQShCT3XybkrJ065kftX?=
 =?us-ascii?Q?hufZqumMLoMjLyM+eJnHFn2mboG7+VCfYoUBwDcKdnXmsq/5O4WTe8okvyjt?=
 =?us-ascii?Q?UkhTRMXlKLRQ+5xDkI0EYmQG0qdYbEAAuqk4kX+L68agWCfwpElfQmv+tfwo?=
 =?us-ascii?Q?II9bCqhOeIOWzAhpGmbP1yBEvQMON0LxzkL6vpo/CdlLpNmrf3zYC0ueEz7j?=
 =?us-ascii?Q?MVNpwoTWWMt7PnMshmTVEb+QZByhZd9Hn9bTjCIP8BllX/mGrlmbZmEhN+bq?=
 =?us-ascii?Q?e4JlopC+a1NhESV9E89Rus8HgL2iK89q5kHLqzMcGr61zMEQnnhf+nWxY99+?=
 =?us-ascii?Q?/IDXmrs6m8WP9rcdYwp3gr0o26Xbod200ZbFiBl3NwU7TQ7eDvv7NzEEZvjv?=
 =?us-ascii?Q?/I7okb0fqPtctrT9nmBYWoxwkxkVR6d5ud+kS2aRKbQvB3rMr79VU1HCCYAW?=
 =?us-ascii?Q?5tHYvOBqD0WdseexB24r0JH8q5kGUe8iLKNE5XK2sK0tMkCKRSPQlrxJwoKZ?=
 =?us-ascii?Q?2IaHJfl3nxHQs0/b20Ts2DRrDC/TrnbOInVxUvathnZjtXQrLGlpXUdSp359?=
 =?us-ascii?Q?weAOdYBQEoyF/maDcwjzvpzPmxVIxu8=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f512d2-50c3-48cc-1c95-08da3c1bb6fc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2022 17:51:36.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0USjdzBZwg4G4AJY0cLgzkg49BCSFPO/vvk3my81THzS2g+CkgpTsvzmRJzzCe1Aw0a70o7jZ7bzU02PEMN3Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB0987
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

we are very grateful for the initial review and a big sorry for such a
prolonged delayed response from our side - we were working on minimizing driver
and RFCv2 is almost ready.

> * without command line interfaces with string parsing built into the
>   kernel
>   (OK, that's probably something that will never go upstream anyway)

RFCv2 will contain removed CLI, some of the stuff moved to the debugfs
(because in most of the cases that's only debugging commands), but we will
publish that patchset even without that - to have as minimum solution as
possible (as it is also required in the guide). Some time later we can
re-introduce the debugfs solution in the future after aproval of base driver.

> * Kconfig vs. code inconsistencies cleaned up, you have a TON of
>   CONFIG_* ifdefs that don't even exist and can never be set, so remove
>   the code, at least for now?

ACK. Unused defines were removed, and others were refactored in a way, that
allows to tune them via Kconfig.

> * remove wrappers like cl_snprintf(), though that seems part of all
>   those command line interfaces built into the driver

ACK. RFCv2 will be without them at all.

> * consider joining some of the many header files into bigger chunks,
>   header files that are 50% boilerplate aren't really all that useful

ACK. RFCv2 consists of ~98 files now (functionality was merged by some similar
area - like all the TX in tx.c, all the RX stuff in the rx.c etc). If that is
still huge - please, feel free to comment. Maybe, there is some acceptance
criteria? It looks much closer to existing drivers. If the number is still high,
just for the sake of review we can merge header files into bigger pieces.

> * namespace your things better - e.g. "is_ipv4_packet" and friends?
>   (why do you even care?)

ACK. That case was related to the lookup of time-sensitive traffic - to avoid
putting it in the slowpath.

> * remove all vendor commands for now, and read the vendor commands
>   upstreaming documentation before re-introducing them
>   https://wireless.wiki.kernel.org/en/developers/documentation/nl80211#vendor-specific_api

ACK. All the netlink will be removed in RFCv2.

> * remove utils/string.c, obviously, use kernel stuff directly or
>   improve where needed I guess - but likely all part of the weird CLI-
>   in-kernel stuff?

Yep, you are correct, in most the cases, custom abstraction was part of the CLI
(and configuration parsing). It will be removed in RFCv2.

> * remove abstraction layers like cl_timer

ACK.

> * what's this VNS stuff? doesn't look like it belongs into a driver
>   (a mac80211 one at that!)

Very Near STA - extra functionality, that allows to tune TX power regarding STA
position. We can move it out temporary since it has bindings to the FW and
reimplement in the mac80211 if there is necessity.

> * bitfields in endian-safe code are generally frowned upon, so you
>   shouldn't need cl_are_host_bits_le(). And also cl_are_host_bits_be()?
>   What?

cl8k driver is using dev_coredump subsystem for dump preparation, and these
functions were part of dump information about the host - it could be useful for
postmortem analysis of the dump themselves outside of environment where they
were collected.

> * Use ERR_PTR() and friends, instead of out pointer parameters.

ACK. We will take it into account during RFCv3.

Again, thanks for the initial review!

PS: Mr. Kalle confirmed, that disclaimer issue is resolved, that is good,
thanks!

Best regards,
Viktor Barna
