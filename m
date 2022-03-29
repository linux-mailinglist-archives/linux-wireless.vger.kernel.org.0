Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FF94EABF4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 13:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiC2LK2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 07:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235566AbiC2LK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 07:10:26 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84691AF33
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 04:08:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbt8DAynJy/6TOPeOMHu/1EwV4oWiDC6k1UuWis0S3LmSNWup+4qSexhALYvdtWuJCpLE4l1CR0tDcA6jKhxl2TjjmXlzFmEp9PIgwoXHD1dOCg1cAH5McoOWY2fcmMAVBo/pMuWTwZokAhK7sYAoAGfGAdKEh252uBmDz+ZButDb/Lvb2itLkWGXbgtXUr79wtKjWA2b5atFfnHjS6KrSngITiEniBox/PRvcb6waGbJ/26bEg7pxTMOU681IgbjNmvsxsUqFC0f2iCGJm0gL8qb36a2UwlWlCG97ctPkgP3zE0J6yowiwuRR4U418Po11b91C6AUJtjKB48Dn4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYfmPWtyaC66PNuhXX44IhTjCZlGxj3FmFGo2cSyhzk=;
 b=jURp1VBiC2oR66MzLybWEGH4omd/RhGDHbgMvWavBQzWsULkFJ143O4m5yysUYsY9Iv9tMlVOwh3Ntwl1xlvfF3r9SbgtB8YVjlsftKYVke1yiDKd4xxKvd6n3f05GzAxjLDOUhbidh84oQ6l2eRajv3hgLCQp7XxvaEK4IE1N+DaWRv2n31eAaGlUq8GIJlEUlgZIpxgpJJTDouewIdYNn2K2okZCs8SucV3GXftdhMO4meSvkT3qjz7MzzB8KAB4Udp3tEbik4UhayjYn7wlSfv2JE+/ym5gAN0fTSfWryZAGQWGBXm+l5/YFGwtMJbfkwy/BIZok8rmdYYimhAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYfmPWtyaC66PNuhXX44IhTjCZlGxj3FmFGo2cSyhzk=;
 b=U95tlDrJakmYSanshiAnc52IJlH9fIR0p+P/Y6zJa4oieT2XFP6VJPhoGzX3fgdgP8p/DrJ7fwIRZ3g0Y0PQ8Dld6F3ctuxW4Xt94CbTYwuYYhRxM6ABDVItlaxMm4o1687sgn2o9LiD6obU60Y/dAUUjTX+ezTXSwhSx6CByfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by PAXPR04MB8766.eurprd04.prod.outlook.com (2603:10a6:102:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Tue, 29 Mar
 2022 11:08:39 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::8ca9:a2e2:60c8:95e%6]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 11:08:39 +0000
Message-ID: <324b056d-3952-5e46-7321-16bb0fa3b590@theobroma-systems.com>
Date:   Tue, 29 Mar 2022 12:08:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [OE-core] Which vendors maintain SDIO WiFi in mainline stable
 kernel
Content-Language: en-US
To:     JH <jupiter.hce@gmail.com>, yocto <yocto@lists.yoctoproject.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        oe-core <openembedded-core@lists.openembedded.org>
References: <CAA=hcWRay+5Xqz+RO_EX1-Yr2Ef_uXcLUL7dZE45d6wBga4mzA@mail.gmail.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <CAA=hcWRay+5Xqz+RO_EX1-Yr2Ef_uXcLUL7dZE45d6wBga4mzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0394.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::27) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3879218b-3f56-45e1-df95-08da11747a04
X-MS-TrafficTypeDiagnostic: PAXPR04MB8766:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB876652BE32BBE855BB75DF28C21E9@PAXPR04MB8766.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RaY+v0NElodfb4/xiO3nEmfSMoaKDoKAREv8WoW+tTOjQb4isP09Y189dX23uXONLat8S5CaMllWT8b4V2LDsBzhC64bm+5JmVTlDyAKC3vmhNJrdo2D4A4DQ1o26iz2247RQsFC6JsHGggZQfu1rqueJ6+a+CKb4CrZxIS23pRbeGChhu+wThU3iCDvCkStiBlo0xPlKDu7bOGzueKE0dDhA9tad5bZrmP2B3i6xfjuziC50+EOTM4toOXGSii5ogRTWwtKM1cfXNQcL4Zm9UBa99ffzrhExdzCjZ87t0BSyyjds5WamXDOQyAml2Ev0Si4ihozAErsMBNiYXfRUjW2rE5UngqQ5Fe73jIT1Hwe/7GpGbr0MWFNS/calmkPTHozNqGKMNtmGw7XtF7i/4eqhWuohQY2Nx40umI1v2IfGF2t9xpFAzHLTVB5JngBLVlhBed0HWQhR41IolsJbrHCR7k2Cl9VCHYIq5OSLl9lwv+nQ9NNyX05slb+GTjF8WTqUzeJ8+hzGDhODi/Q9m1icXPvy2dKKe747zgAXogH6+wYzUOeqRz83v1tl4+Hd06NvodovmEB71svbOKa2UkKP5FkzKVT7Ym1r/wEoKr66NkMUkeNO5txGMpY+zUY9zWuB/VFXBjePAn0gMoFXvGyLCDWOSpiXe82/N5i9MUJ9nlbJy6oPO3nTXOkOflJtnmyF4a3GhHB5sTFLgnkrs0CEicPj9+69gvxW0SwD/fdoxVjlN7x2nmEg12uJvyPt2os/9WViyNKR7kH3v9h2LsJIZDaPj4aZFUmqSiAFx3GpFaFEQG+tnJoKJKl2Ep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(6029001)(366004)(83380400001)(4326008)(66556008)(66476007)(110136005)(38100700002)(36756003)(66946007)(8676002)(508600001)(8936002)(53546011)(2906002)(6512007)(6506007)(31696002)(6486002)(31686004)(86362001)(5660300002)(54906003)(44832011)(316002)(966005)(26005)(2616005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzZSQTBDV2xmL1FmckdxTjZnTHdCdmNSeDZQUGRpSDhaZG1DMnVqMWFDaXpw?=
 =?utf-8?B?T0Nzc2YxL3d3RWxaeVY5ZGwwTmtJNlB4RDR1ZE5jL0VVWVJGZVYvL0JBaGFx?=
 =?utf-8?B?VXFNZlhpd29za0hGOXdoWTNodGZJWXlFUjZTcFA4ZHVBMUY0WHhiY2liVUh6?=
 =?utf-8?B?UFFZQVFyaFZ1Wk1QOEYwbnBFUklqdW44YzRDbHNSc1JEZnMwMGNBQ2lCSC9q?=
 =?utf-8?B?WFVkSUpzVGx0ajBxdlJrSzhWQmI3T1p5REZ4VFBnM2FhdXRCakR5SkFqWEU0?=
 =?utf-8?B?QU9NQjFJL0o2alV4dEZWMXMzOVkydXJIajlBdGV2V254amJ0SmpSVGw0TEJI?=
 =?utf-8?B?d1Z1dmVralgyeFR3eDlDUElvWW9OQXBxK3JVRzF3djdpVE9tVGN6TTlEelZz?=
 =?utf-8?B?eXIzMEpGbnBNTjFhVTliN1F1YXVpS2Y4b2xPRXp3Zmo1WFByNE9IQzcyZWZC?=
 =?utf-8?B?Rnc3UUVMQ3N6MlR2ZjZ0SmlqSnFLazRiNytHWG4yL1YvTmxObjZhc0tYczNv?=
 =?utf-8?B?WWlBN3BHVjFYZ2FlRTNZeDFlYk9ydERlRlZwK0ViTXZrdi9Rb3BkSFZkcjFF?=
 =?utf-8?B?aHhzVnNUKzFZUUhTU0lNZ3VoZXg5M01JQkhTY2xQZ296YnlkcmR2SU04YkhY?=
 =?utf-8?B?V1RlOCt5aTBRNHIvN2ZKUldYQVVCWUx1L2ZwczhvdkdBRDFMRTM5YW40RHJN?=
 =?utf-8?B?MTdXNzB5NkNWamVKTHpnejlFZjFTL2V6N05RZCtXNUl1UWsvT1NPVWhQOWJj?=
 =?utf-8?B?bXRKbXdLbDZOY1l5S2VDSk14aEdOUzlGR09ZdFA4QVBnSkdDNEtCZXZwTHo0?=
 =?utf-8?B?T0RPZHljVzc4ZDNOVEpsNFAwZlpCUGF0ZWVxR3FSdzhWYUhmZUFuWlEwV3RB?=
 =?utf-8?B?MDRQNDgrVkNCeHhqeHg3OU1qOHdGMG0veEJzQlZwa2syNjc1SmJUdFJvK3E1?=
 =?utf-8?B?emltU0NRNWNMVlM4TkJ2QmpYYXJKOGhpdk1TMC9XZXcxd2hxNlBSVVpHOEtK?=
 =?utf-8?B?ZHQwT0hBR1ErT1dMbVZ1eGdWOFVJc3I4Qko1QzRGNlFybzVoK2gwMmRJV0sv?=
 =?utf-8?B?d0xSTEt3cExkL0xXS0dxYkFkeWhHdXhoUjNPT3hVdHNsY1Y1OUZ0UG5ISDhC?=
 =?utf-8?B?Tms5R2dsZnpVc3d4R0FpaGpmWDJwWi9Zc2w1V2NBM2htWTV2cndwbXlLZWtB?=
 =?utf-8?B?MzUzdEVJbVRyQS9iQ2cycjduWjVXM0tvbU4xcDgvdFFHN3VpQ0NINHFJK2p4?=
 =?utf-8?B?QWxSN24yNXNkdHhxR3BFMk9XWkJJSEE1ekxKeENUK1Y5MDdnZEhLdHFZYkM5?=
 =?utf-8?B?WVNPZDE0Q3J0d3dvMlBxS2FreTBYbFc5dnFiU290QjBRRmdTUjJadlJ1RS93?=
 =?utf-8?B?TmdjN1Q0dEpCaFZBSHdEa2dQeVROcUw0Wms2Mnp4VGdYc3NyTGxVcldTbVc4?=
 =?utf-8?B?Z0RuNkppSnJoZjR2b0FMdlkvRkswcVZDci91T0NleFVzMVgvTDNzSmlOeUov?=
 =?utf-8?B?L09hVlovUUJSS0ZKQmRtbDVNRGxsdkFXOXd3TWxQY3N2SGs4NjN1djljOHBC?=
 =?utf-8?B?MEFJeG4yUVdGeVIweUhKWVR5WllaOFJPcmZadVBVaEtGNXgvOUxHMTF1S3JM?=
 =?utf-8?B?QUNxVkNMazF4ZThBNTJ1WjZ3VDdwMXg2cTNWdWlPeFhrVzVRdXpRQm5zNTNS?=
 =?utf-8?B?R08yM2MzU3drVHlCK1lKVXVVV3k0aE1EajdGUFpVMnR5VVJzQm42c0l3WDVL?=
 =?utf-8?B?OUdobDlweHF0RmZnb1dKNjNWSlYrU3RLbktVczNEcEx5ZXFnQW9nY2xoMjJt?=
 =?utf-8?B?MmNTSThqbGlTeWN0WTYzd0RuRW85ZWlPcmRDVVkwTDU2SDl3SXk4SWsyNlUy?=
 =?utf-8?B?RzVERVc3UWhKWmliNXI2SDVRUEtGVGdvWnhOTUlvWVF6aFBhTFMvM2M1YTlm?=
 =?utf-8?B?NDdYbUtHQmR4OGd0VytGSkdGT2VabW55QWdJTFc3MHBqZkMzVTlYT0pPNjRi?=
 =?utf-8?B?REF1cXdFbnlBU0Q2aTRKMUhPeXBhb0p3b1FjSCtMVTk0TFdqdDBSbFhKcnJF?=
 =?utf-8?B?SjVSM1llT09IaVZkYUxGWkJNOTlLR1VkUHlGdmdaL1JuVmVUREFFY3lHUWR5?=
 =?utf-8?B?YTVaQlF1amJTRGNzQnF2TEc1b0N1QkZjODBHcGx4Ym1ieTBySThFNGRiSUhX?=
 =?utf-8?B?bktjeEUwYjVFL25zQXA2bW10NEJIY1FDb29aSW1ZMUU1RGpWUEFXa0lFeElR?=
 =?utf-8?B?M2FDL2F4ZUVzb00wdG5SN09HRW9xYWJkK3dZVEhhRlVWNEtZUEdGUmszdlA5?=
 =?utf-8?B?OXU4aEVFTlBMUTFGc0kySXR6NmJ6UGRTNk5QTlZPdG0wUXFWVXRwaStnSG5Y?=
 =?utf-8?Q?tKSEHtKw9aFRqjV2kyFbb7sIgjQxpSIQ+6+HC?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3879218b-3f56-45e1-df95-08da11747a04
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:08:38.8926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYmDfABcj3coY3+ihrzuABUiOBrpiEFkILO2LLTXh6kUOfZAH+zacM88WgysM29eja6+7WKaQUmdRipfn657Khkv1PrfYyHaBKILEeYQGILgIDxeRy77h/Wt+bM9rV7Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8766
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jupiter,

On 3/29/22 07:16, JH wrote:
> Hi,
> 
> I could not understand why so many large WiFi chip vendors retreat to
> stop maintaining WiFi SDIO chips to mainline Linux kernel, and to
> settle it's chip support to out of the tree, use its own SDK and
> proprietary kernel tree to source.codeaurora.org or private repository
> which are not compatible to mainline stable kernel, the kernel
> configures are also different.
> 

It is extremely rare to have vendors not have out-of-tree drivers or 
forked branches (I don't know of any, personally). Some vendors do end 
up upstreaming some of their patches in the end to reduce the amount of 
maintenance they have to do on their downstream drivers/kernel tree.

Upstreaming takes time, knowledge and soft (as in "communicating with 
people") skills that some vendors aren't willing to invest in. It's also 
usually not an urgent matter (as opposed to have *something* that works, 
so they can sell the product ASAP).

Also, quality of vendor (understand downstream) code is often subpar (to 
be polite) and would not be accepted as-is in Linux kernel upstream git 
repository.

Finally, it is also a strategical choice for vendors to have an 
out-of-tree driver so that people stuck with an older kernel can still 
use this driver/product. One simple example: a bad vendor sells you an 
SoC with BSP supporting kernel 4.4 (let's say). Now, you want to use a 
specific WiFi module with this SoC. Fortunately, there's upstream 
support for it, but only in 5.10 and later. Considering the number of 
changes between 4.4 and 5.10, you won't be able to easily backport the 
driver to work on 4.4. This means the WiFi module vendor loses you as a 
customer because you wont be able to use their solution.

Now, you could also have a nicer SoC vendor which provides you with a 
5.10 kernel. However, there's an important fix available in 5.16 that 
isn't in the WiFi driver you have on 5.10. You could try to backport 
this yourself but not all customers of said WiFi vendor are skilled 
enough to do this. The WiFi vendor needs to provide support for 
backporting this for the customer and/or deal with unhappy customers.

However, with an out-of-tree driver with appropriate ifdefs everywhere 
to adapt for specific versions of the Linux kernel ABI, they have ONE 
driver that is known to work on many different Linux kernel versions. It 
also makes the maintenance of the driver much more simple for them. This 
also allows them to do releases much more often than the Linux kernel 
allows (one every 2-3 months). Considering the usually bad quality of 
code and maybe lack of proper reviews, you might end up with regressions 
and more importantly security issues that will never be discovered 
because less eyes will be on the code.

Out-of-tree drivers make sense in a self-feeding loop of vendors not 
upstreaming stuff because they need to support other vendors not 
upstreaming, even if they wanted to in the first place.

Finally, I've had to patch locally about 3-4 WiFi drivers and the 
changes weren't implemented by the vendor in the next releases. So you 
might just have issues other companies have fixed but it was never 
reported or fixed by the vendor. (Note that upstreaming does not 
necessarily fix this issue, it just makes it in theory less likely to 
happen since more people are supposed to use it than some vendor kernel).

Also, some vendors are historically reluctant to contribute anything to 
the upstream Linux kernel and the support of their hardware was added by 
hobbyists or one of their clients, bearing the costs themselves.

> I looked at the following link, the mwifiex and mwifiex_sdio support
> the Marvell (NXP) 88W88 chipset, but only kernel 4.19 was able to
> build and to run, kernel 5 cannot support 88W88 chipset, any more.

You'd need to request the newer versions of mwifiex to NXP (which 
acquired Marvell some years ago) or patch it yourself. Welcome to the 
world of downstream support :)

> Same to Qualcomm, the old Atheros WiFi modules are supported, the
> QCA-9377-3 chipset is in source.codeaurora.org only supported by old
> kernel 4.9.
> 
> Given the OE/Yocto poky kernel build is based on a mainline stable
> kernel repository, how can I build kernel 5 for 88W88 chipset or
> QCA-9377-3 from source.codeaurora.org or private repository? Or which
> WiFi vendors are still well maintaining the WiFi chips for kernel 5,
> the only sensible solution is to switch WiFi SDIO chips? Appreciate
> your advice and comments.
> 

Yocto only builds what you tell it to build. The company I work for 
provides[1] Yocto support for a vendor kernel based on Android-flavored 
4.4 (note: though we do actually support and encourage using mainline, 
GPU/VPU support was - years ago - just not comparable between vendor and 
upstream kernels) for our System on Module, all of this on Honister 
(latest release of Yocto to date). You just need to create your own 
recipe (or adapt an existing one) to point to the BSP components your 
vendor gave you (or whatever you want to use) and build it. Nothing 
forces you to use linux-yocto 5.14 or whatever else.

[1] 
https://git.theobroma-systems.com/yocto-layers/meta-theobroma-systems-bsp.git/tree/recipes-kernel/linux/linux-tsd_4.4.bb

Cheers,
Quentin
