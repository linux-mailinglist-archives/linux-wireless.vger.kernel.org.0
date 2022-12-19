Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547965127B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbiLSTNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 14:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiLSTNK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 14:13:10 -0500
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01hn2231.outbound.protection.outlook.com [52.100.222.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065BE02F
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 11:13:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHDKqhAISoFdKR597dXSwjX7XVYY7GBiQ5A+9iqb083z/fCWXiXo7JuoAWq7p6wIxSKdENK6r5ciaBFOrnPC/8gbuXg924jGRWFOoxoOeeUL6jCmFjtD8M+9oVubtUoP+10rey/yUysv1Seb+56Oh+4YX3NCHGmr3h1rk7/l+i/Gz8nraDC/UuotdKCN2psPIL1LsjaaasRH2634iMGqzcRmwnqQWUS6i2VU4cezi2dibe0glJE11mH0Tvdb9tvfzcZIAUjlgwMwxOUkJBczlwKrqsRtHeuzfai1OHzDXDzI7D21ZMPnNUfE4Fgq1bf2WK/v2kiOE0twiXTI53R4TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAuY3UpU3IiF+b+XPDQk+8TvBWuH/1CIN3IiPiedtto=;
 b=QGB+y5jQSHr9V2kzX71ONDIfEPpX9YPvSk+qDl/8hhs7PP6/9cIAEPToIbCftHgDjC9M//pYZwVWB2O7FT3159NHadlzrucpR/8H8XlC46YpqY19+8/qftB5Zkl11kWjJhOOjsGkYnCZQOsAjfhE3ORW7+4CoqB4/osr/GQlaVkOCjvGCkYriKyBjwOgD7GDdJMPVt90xRH8QAmuM6v4E29QK0xEzlXVcxH52RLXiEDStfJXsLa8lC873isiG0Nba/Yef6W9dATiZWX/GKXLPTpo5umvcnPgTRMK5vyL2DJMLxCKegLnhMjTrv40ExWhamR44mjnGt1sZDmPYnE9CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT1PR01MB8297.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 19:12:58 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a3d2:e86a:1a9a:9cc6]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::a3d2:e86a:1a9a:9cc6%3]) with mapi id 15.20.5924.016; Mon, 19 Dec 2022
 19:12:58 +0000
Date:   Mon, 19 Dec 2022 11:12:59 -0800 (PST)
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
cc:     Wenli Looi <wlooi@ucalgary.ca>, linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] ath9k: remove most hidden macro dependencies on ah
In-Reply-To: <87v8mcd7kh.fsf@toke.dk>
Message-ID: <df8c4daf-7bec-a877-285a-4f690fdc87c@ucalgary.ca>
References: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca> <87v8mcd7kh.fsf@toke.dk>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB3302:EE_|YT1PR01MB8297:EE_
X-MS-Office365-Filtering-Correlation-Id: e841d72d-4be3-4c80-8fc3-08dae1f50a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(2616005)(86362001)(38100700002)(26005)(6512007)(2906002)(186003)(6506007)(478600001)(6486002)(36756003)(6916009)(316002)(8936002)(786003)(54906003)(66946007)(66476007)(4326008)(66556008)(41300700001)(4744005)(8676002)(5660300002)(83380400001)(58440200007)(45980500001);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KTpSnELNVJLAyZuaMLUmaoxRhuGOIuHdzdMmVx5ol9pcBONSsU1V8YDp6l0L?=
 =?us-ascii?Q?DqmB6fLMbbUm/E+enPHeEGQCIcdjF3kb+EY6MmuEXIjbF8XKes7cDs1/3UNw?=
 =?us-ascii?Q?QykxTIMFpYSUSHPcn124tjEz7D4jUyEQ9t7x13rOq/qnawnXgEK6mZYC7mo0?=
 =?us-ascii?Q?+nW2VgJDtFw9aOeVY0SquvbAsNbOmnIOrcrD6yKUFLWfYKXG7J6Nh8QdaFEQ?=
 =?us-ascii?Q?2q+HImTVRh1rXqQMvS917No04pojsdzsOFrkzpV28+5v9pKJ92sG9xgJROKJ?=
 =?us-ascii?Q?fzBUb9l7A1Phl5ef/dtF4iA6NrLlGcPk67bgXn0P5KClR9STHvqEvxg+iAPG?=
 =?us-ascii?Q?vXo8RC6TrMTA/MS5AviPVNGs8ojSEAZ+1UO3+/9lGYJcNeKTuoiIFZSqV218?=
 =?us-ascii?Q?rcmIRoCCbjE8vIsIDtbl0gIUeqJzRq3TCbE9CKzCavMWFzZ/42zHegfqF4P/?=
 =?us-ascii?Q?EG2M8Kw9gw3+AHrKsDj0Jccd/ZQUcTlpf1AJ1rrBnJsmtdNwW5l1/kjBT7HY?=
 =?us-ascii?Q?aWxFIssKvIX5wz/p6ggsoDvv2hwr3IZkmBn1K0zGEVRTqqAU6GH9NUgJQCYr?=
 =?us-ascii?Q?i76a8XTtVKayTIats6rbiQQ6Zi8B+9oIbKrP+tgFKebgM1SnZqDpqTL66XGU?=
 =?us-ascii?Q?dRIQ9Vo8/53zTzedgkieUqVC7lj4T6xzOdmIgw12NfE6LmlGl3laZ180Gsza?=
 =?us-ascii?Q?pVnu1wSvQSZog4qxk2OsYF5MDzU4HkrJfcYRx5VwqXyzbmWxVS42zhEK67xK?=
 =?us-ascii?Q?JBQyNV09B2y5nevTGSG1XoIKI2NALbTBd5rvJ5SeAUlzCqoM3sJjwRMOG4zz?=
 =?us-ascii?Q?pHuF1HnulRreEHRlD3YdNt4SDXxGCmOgWb1RocIRGT36PVS6sjYvB+O06hpy?=
 =?us-ascii?Q?SpfWzJ5Ile68KwWFOLr0sY1EjJVoRnj3efKhFOdfTxKnB+2nAYdSRCTwxp0/?=
 =?us-ascii?Q?jsTtss29juimZonYrVsqlUYq1Etin+m4Ur/OHwsoR2nl0FT52fZpKFZ9vKQa?=
 =?us-ascii?Q?ew+QCga7x+iYyZ5NT9T5s/bAzPF+kuocr1OrDo20ov+Pz9dE3U3FQgTpG/aF?=
 =?us-ascii?Q?EUym7iatzvRpLkcrFWQKLCnrwq2hfqljjMuXfWPl61ffJ2VhK4E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r9TDTzXTVHocBgOUxiE2r3qEHX2WiRAqFikf1XWGRmm+rmHcSksM5ZwvVgkA?=
 =?us-ascii?Q?pqYOs4OFOXvcYST0oDJoAgb89sfAVGkNpCEs5jCR7AenFxovK5kcFn5DyPLJ?=
 =?us-ascii?Q?4/+S7j4hdOsrLlrz/M9x9yIdWX3RAKCXkDIK3OrgR/IXvWWRT+vkT7XBn59J?=
 =?us-ascii?Q?Iiy88b5wr7upDfCarUFwsRI4vJX0ick41AdKBeRmZGLW2nPuJcZd/GB10Ha2?=
 =?us-ascii?Q?1XnoM89kfInEEYSniDyfY1Qle2HBQF+LcUK8AWjp7VPwnBOwm8U8vXINeU8C?=
 =?us-ascii?Q?Jo8ErbU1XG3oOGmmr7Yj4BxKatv7LEqYGwhQ+6iri3bzJjGbDssTEGnIVPil?=
 =?us-ascii?Q?IP6tZ1ykJiBjKvasfPtGh4rG3Omn/E3TVrULTzGCyOCiS7m0LvONdusOtvWz?=
 =?us-ascii?Q?py8/hCIb29xyNmzx/KE3tWBUq7B4VQkd7janzY2khpBhn4OCRHIwyeU0vubf?=
 =?us-ascii?Q?WSgrWcEarj5v1vIPW5Lp6KromT/Be/phQ5GkdNFD480YhfDuI5zzw/uabRKN?=
 =?us-ascii?Q?elR5JDvHhmAbIwlwmxU6DpmB92xvdBqpKqQjlL6ZxxVlxD3+dWjJPClCbipM?=
 =?us-ascii?Q?fD3oTI76rfHLkO/ciGrRfLpmNtFDKdqRdIkRIAsPksDqc7amxL2fhmSwlQU8?=
 =?us-ascii?Q?4ib5uTGJ81OWG3Rr5OcZ3VgRczD+b+qZ2+XBzSQrZsVWQ28KdSScwKBoivBH?=
 =?us-ascii?Q?TkPSMoiXXx00PDwUJIT4Akch1ptQ/WNPze4zxI0AQLfaGel4KEJCH6aXksxf?=
 =?us-ascii?Q?XPpY6XxDR7aF7AikAR9Jk3xPRMsO2IyGfnDCwupjfBuFbF0pii0LnWxg+GpD?=
 =?us-ascii?Q?I7I9txro8QV5WrWinYoF4495BzIIqInqnj4FFXry0r+JSnbwsLB7UaooSyIT?=
 =?us-ascii?Q?2SpompEsBGZ01x6Hk5Zhf741e5TpuH5ceXalN398NZscxZ2wIm6XLyypw6cq?=
 =?us-ascii?Q?1LhAnMOmeX7McyMKXezEM9cX6YPPY+3/ev/An+sILv0nsFKJIkHg60pdVCsb?=
 =?us-ascii?Q?LH2sHrTFrx+7Inv32+q2S2EjK+uEE+kh8JF0gOHpPWvJ4tkoZU1DK+Qm9E/q?=
 =?us-ascii?Q?tYtAIE73l9BtF5XgvsPfIGqXhMg/TMF+JT8tQbLae9GfUMVb0vDcb2MZmsVh?=
 =?us-ascii?Q?acsjN45xmyzLFL47y/voNY1rHC8ghUnkqlB3C3e5EAETQOrqkENc/SaISOGm?=
 =?us-ascii?Q?UQqdjZgowxuZyxFBr3Ctzcmz3nn006hLz7s0UgLHhVtbo0YFcBe6O68cx4wF?=
 =?us-ascii?Q?EAzMbn7960BfdmGB/Uf0yGD4ApcXiVqF6KY4UJq+P7yvCjkFZCEIRbbLNXzp?=
 =?us-ascii?Q?QgZurGTP9/IERZ0lV5MZEWlm3CgNPJsVHmuAWmWyKzEETI0Eq6dqWIzBGzsn?=
 =?us-ascii?Q?fx7f6abIFGZsFISqcS7ob4LQutmw/sQv33LAwg4pgquqANwJ+iVNfY4NnzVU?=
 =?us-ascii?Q?LdO1f8SxpzoNtiSJpG5rD3yNTAvQOsz/OVeBxVGH44CPLxdPEV9VfYKcpSsL?=
 =?us-ascii?Q?4qykmfLcFvTUYcpVIylTP4NMB960fYH9+lv46u0EG898UIiX+xSxs0DrZ3ND?=
 =?us-ascii?Q?7LeBbijkFL4WwVdA5QGkCIFzms8v57AopoFthf3T?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: e841d72d-4be3-4c80-8fc3-08dae1f50a20
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 19:12:58.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyV1IyU0Gva5XoQJG0VCSyUg4ZuRki7qlRVWpWlry5PR58lmIXTaL1H9C3Pih4r18hKabeHSbBj4F8eFN9/Sag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8297
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

One thing I just noticed is that when compiling with CONFIG_ATH_DEBUG, 
there is one slight difference in the binary because of this change:

-			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL=0x%x\n",
-			REG_READ(ah, AR_PHY_AGC_CONTROL));
+			"Timeout while waiting for nf to load: AR_PHY_AGC_CONTROL(ah)=0x%x\n",
+			REG_READ(ah, AR_PHY_AGC_CONTROL(ah)));
