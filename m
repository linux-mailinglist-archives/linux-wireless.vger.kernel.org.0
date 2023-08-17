Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4075D78019F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Aug 2023 01:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbjHQXVi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Aug 2023 19:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356043AbjHQXVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Aug 2023 19:21:11 -0400
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01hn2212.outbound.protection.outlook.com [52.100.221.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9D03588
        for <linux-wireless@vger.kernel.org>; Thu, 17 Aug 2023 16:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjdIPiMnxjDsHR/5Zyjgcmh8r6ZDlJ4Y4/MuXL+42kH7rLI0eip+4sRQ5E2R8GlJ9LoaEQeJOJIDhdl9GcR7PXHUllKNh166P6/QVB9hgp7+uvK1D2Mpd14/gfcJGjoSGHDnYmKTLP78bTQCwVJkfNYK8bZt9JT8z+xyHH+qZRONGggccoibqGMiEUUCmQHSdma0b3bm67FwyoCDHqOaDnSqFFotQ/nxWZ8zTyxYXfWu2F5f/XAkV+1E0gjmyaS2B7XFK99b+G5ZUIjvHE3lGfeenF+Fn0hbfp7RU4wX5ksD/RoiR9aBv/w+ga4Yhn1JlpqOnV50tNyod8wqJe8v4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvyBjDYdsNS0N2qWINyzPq83H7PDOJKsrECGAUZnrcM=;
 b=Q6Ti5PPKgW4+W+cjiFA8OEpmLvyHTBE2iZ3b2U8AqkDaNBu9LlhnGOu/NpkcQdOKXNwHqlXEdNUbozk9yaBi+Wd4oapEddTTyDK6p4Mjh79Htta0ZH7qP/dmp6yWW9OgUcxm85LMyWb8re+c5a1KJdHegbn01jQAz4hnxlqXyMvg63YOXrR8HC9NwlBQkjhxkykfmYIodGLQD5nq/BNui3qqMohlVd2/uqfrW2wRMIZfifk6sMwz54Rf4KpMKLCP9SIw0dDWv6bc08DufP5ZVqHOoEAsLmUouZQddY5gK9K76luP2vi3jCUU2GZPVtdgE/9GtiixVYW2J3uy+7wJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ucalgary.ca; dmarc=pass action=none header.from=ucalgary.ca;
 dkim=pass header.d=ucalgary.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ucalgary.ca;
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:4a::23)
 by YT3PR01MB6034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 23:21:01 +0000
Received: from YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9c02:4e44:d4f0:4632]) by YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::9c02:4e44:d4f0:4632%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 23:21:01 +0000
Date:   Thu, 17 Aug 2023 16:20:31 -0700 (PDT)
From:   Wenli Looi <wlooi@ucalgary.ca>
To:     =?ISO-8859-15?Q?Toke_H=F8iland-J=F8rgensen?= <toke@toke.dk>
cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v3 00/11] wifi: ath9k: add support for QCN550x
In-Reply-To: <87a5uyg7rp.fsf@toke.dk>
Message-ID: <593029a3-8bf4-4c19-5ebd-523f34d11d2@ucalgary.ca>
References: <20230629231625.951744-1-wlooi@ucalgary.ca> <87a5uyg7rp.fsf@toke.dk>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SJ0PR03CA0187.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::12) To YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:4a::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB3302:EE_|YT3PR01MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab03d00-3f05-4d9d-86ca-08db9f789f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:OSPM;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199024)(1800799009)(186009)(36756003)(86362001)(38100700002)(478600001)(2616005)(5660300002)(66556008)(66476007)(6506007)(6666004)(786003)(6486002)(6916009)(54906003)(316002)(66946007)(6512007)(26005)(41300700001)(8936002)(4326008)(8676002)(2906002)(83380400001)(58440200007)(45980500001);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YZKkGfvSea/ij4W7X5CCBPXktClbdYPmyvJRAV+mN/NvrHe+eH3mAP9xLyX5?=
 =?us-ascii?Q?XK2V3uGdRxdHuWQW6q79lDyyEgB99NFRb2qEYsZSygWPuHvNPXWTe+ozjjU/?=
 =?us-ascii?Q?kasJmQ5ELUe7pb/ttd0XrubErCASCEP4GeISfTLkOuCs3VsOcmlbcOWG+OrW?=
 =?us-ascii?Q?fvaXhhLwC6CgfbChkUnvfU5Jark83fYveOkwie5B1zf651zr46XbG9x/e8Nr?=
 =?us-ascii?Q?qcJnW0jITYWTF4YWriMCPvptNMaJi74uSTRVh/wlPK7EsdW1lJNGrNuqFY7l?=
 =?us-ascii?Q?pZN5VgDTpgXalrP5nU7OcAHFYaVbQOVqOSyLqB2QRn2iuZfsG7POHhfSmRef?=
 =?us-ascii?Q?tmoB5JL/qx5aDGNEZEVdLYMtPwpb+dh1EUVAhHPNPVirbhyF8xeH4l03/7h0?=
 =?us-ascii?Q?kKV+G6SQFouR9Tj8NTxineW9/UHlfqQqVkIsI0PSj2MrNpZziWSQia+5Vf+E?=
 =?us-ascii?Q?43frm5vRBHIhinerhcezL5vS8kIwdxdLURspNaB2MF+pYUV0XTp7pP4Q3bKb?=
 =?us-ascii?Q?WwDiX/HkPEURw32DmXO6YozwB/RUk/AtSi8jo1dUd4t1s+sSvV/0OJMyEYNd?=
 =?us-ascii?Q?/RphK77sQCXzH65wOYBJqxWIpJG0wwLBxPUAqrhZEibH14GTybeZqBQ654eJ?=
 =?us-ascii?Q?6WiAAnfyjAdoCnL6RThn/4gDxbh134AyNvBl3Ttv1kM3uk/MdRJMb8W3RGC0?=
 =?us-ascii?Q?PYeXp+Pi46UQ0/PBd7v4tSezNb6TQLuNJXIgYLsi28Efac8e8PgFcjJvixa1?=
 =?us-ascii?Q?KPgB5Zd8Q1xhiV+N6UUtvYbprD5zeBnxekwWMchTpwAhH1kd1ov2LyALn+oV?=
 =?us-ascii?Q?QVQq0WSLO67uaEeuzxlsmNRPveJ/+xoSx7v1zYhG/MykX1fct8i1D151s3HO?=
 =?us-ascii?Q?7UaOq27oqzlDyydhVS7n86N1FutVhWyKP3rE+K96RGvxavy/uqyTrnqjoGrM?=
 =?us-ascii?Q?JEmMpNwTtHdIVjii6Wrm6crnrP24g7+77VJwvVpkAgG+Jm977c/E0BlvbtSR?=
 =?us-ascii?Q?AVG6S7Faz5aVJh2W21khAhs5cwhFbe+nMcvkY0YcGTs/H58=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5gnWFZKqZXHd3lQ4bxVCAWOEpBUJ9kps4DNvEXv2ZD5uAGIwFWuUcVfPuL7A?=
 =?us-ascii?Q?1V58mBVzIiTT0Uh8Y25WDLSO9PnfZynwmC9jOSFEwpnF1oCQ8UpqNXZ2wU7X?=
 =?us-ascii?Q?M9qWxjI1SUwHjqePwqv+y8EcpNXklbTY0aPsPn+lIvQUqJHWPolQ5qp7auY+?=
 =?us-ascii?Q?n9a/imUPYnXby3oreK/P4fz9tBnJt8vbdO8h/a4mDq8LG2HT6B919+fiDFc5?=
 =?us-ascii?Q?la5WjZI+VyT8/y9S+3PkMcmuPZ0evjjXhLbUspoxhnyjVg/0wmgRS+V5iUOP?=
 =?us-ascii?Q?zXJmfQaiyY0ZumBLQVp/cTPNv0vOKDpoM5zX5X+GF+CIhDhAJociB5tKCXUz?=
 =?us-ascii?Q?U69vGs/y+FgpWF154osknmHCFyQLa8ONxATLjFjGVLdJZ6JH7lz+y8aiP13W?=
 =?us-ascii?Q?iL4TdQyUJ+3m/suC502vUlgeGZWc8Dpa4pK5eG90jPPMwdEWbw6Qww3Aeszv?=
 =?us-ascii?Q?pNghiNs+eWTNmMl9xbE7E4p0FEb8zagIoQDNHuxaVP1LQNnkauQ14xLjVF+i?=
 =?us-ascii?Q?x67jDVdoFHE8t7qdYnfoibCppVOeC6vzgdsiXBnuOUZ2jFuMHdYEi39kuyzk?=
 =?us-ascii?Q?Y0+ETUaCNSVyVa+KzdJd140IZy8wIIDLi/5pJ9ysR6FToN1gFVXLoZ4/eI3t?=
 =?us-ascii?Q?UZMMvrk8ENY5uSmdLGHFQtIygehLAkhOznDzckLaD9pm33nqhkU5BL2QaWIs?=
 =?us-ascii?Q?Ct1v657Fm5dzVJSYyxFuriFO+9j+5FlRl8T3Nlx66hWrfIPYg99v+bAuvQAq?=
 =?us-ascii?Q?Xl2qVro8slZUJJeTSVC7btRtG6/ZUm6pcxTrZKL6AVNbUv2FDPSqnXK+Qcv5?=
 =?us-ascii?Q?LQTjqU0MUtL3xtyVgfalKxfUTnZMhIay4SOYmOLV9Ba0xyhwBoH5PJAtJKAB?=
 =?us-ascii?Q?qildqco6fUUGyP5rB0t71gzGKY87Q7tydMuqHR3/a+IkhwsdU3S3OlmLcwZw?=
 =?us-ascii?Q?qtkByU7igG7SlffqMsSZFDp1nrclcsjtEM602VVVrqbB7iWAXS2f2duWTUDe?=
 =?us-ascii?Q?W22qgTipkaPHkvwMHf5Yu4ygVain1hjfadPRxYX1W4FPHrz/CVGUL2Xw3XQ3?=
 =?us-ascii?Q?0mo3LX0KUMm2bOj0fShK/uffVZxrBmNlRjVzD0fmaMLrIgOIxK8zRHKBioS9?=
 =?us-ascii?Q?3jcgojuxAIuTpdvAvxkNOxR8eitm3Erwo7QcDJUA+RxxDu/65vN0pBu3tR3e?=
 =?us-ascii?Q?b0TzwKAWQxb15UpMmMrI4Vaniw05CuK6Bahtp98kWM5Q/DFkscR5lIybpE0x?=
 =?us-ascii?Q?dMycnIayhKJkQgiXOZsFKqhnspEmHlVtguusI6wWyYLqB4fySsh6lvul71ns?=
 =?us-ascii?Q?rV/7juNlqb6QmmBnDb4XAyllplkzvW/Cb6JgVOLJdCVe7N3R7kjpj/TgBXXU?=
 =?us-ascii?Q?s56jIGz2tq+3UKnTk/nVgNdRufNksHThEE9TovqgCTesq4vtr0omdGr5VyfK?=
 =?us-ascii?Q?Ss5jLJ/WgYr1AOiJ9/XN/wT6P4OSUrzWUcHgW2tAco1rMfpHRdvuijYADSNp?=
 =?us-ascii?Q?gbpc3J8+EJtVY1cVb44JWgnTwbi8zIcJyXpbmD46IyjFrhzIUl3/xrYDKlV4?=
 =?us-ascii?Q?ip8ZboI+e7bNTGwPftWeIYCfELxck8oqoWgfQh/I?=
X-OriginatorOrg: ucalgary.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab03d00-3f05-4d9d-86ca-08db9f789f02
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB3302.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 23:21:01.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c609a0ec-a5e3-4631-9686-192280bd9151
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpjjRR678nR+LrK7ssU8REXgR8wyqvhky2z2wifd1MatiVMf92wE2BojPM6z2HINjiTzj44/F2L3UcXpS7auww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6034
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Did you do any regression tests on other types of ar9300 hardware to
> ensure these patches don't negatively affect existing systems?

I've tried this new driver on a QCA9558 SoC (Netgear EX7300v1) which is
another ar9300 device, and the access point performance didn't seem to
be affected. I could do more detailed tests if desired.

> 
> >   Revert "ath9k_hw: fall back to OTP ROM when platform data has no valid
> >     eeprom data"
> 
> This revert seems a bit dodgy; the commit message states "Users
> currently relying on this silent fallback will need to stop providing
> invalid EEPROM data to the driver." - which kinda sounds like a
> kernel-to-userspace regression to me? Do any such systems actually
> exist?

I'm not sure if such systems exist. They shouldn't for the SoC devices
like QCA9558, because i don't think they support EEPROM at all. It's
possible that they exist for pcie devices, but I expect the vast
majority of users would not be overriding the eeprom. Arguably, if they
are setting qca,no-eeprom and this silent fallback ignores and uses
eeprom anyways, that could be considered a bug that is fixed here? We
could also choose to keep the fallback except for this new device.

I cc'ed Felix Fietkau here. If you remember the context for this change,
that would probably be helpful.
