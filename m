Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1B8570E18
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Jul 2022 01:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiGKXRb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jul 2022 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGKXRa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jul 2022 19:17:30 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20057.outbound.protection.outlook.com [40.107.2.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210EA87F70
        for <linux-wireless@vger.kernel.org>; Mon, 11 Jul 2022 16:17:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExkIf6GN8T05epjbO3oQ+UiUd8krooJGbIykTsFLJIhOVZ9MZl6QBcRhcuG9qQW4+v7H4P7SR6wwTdAgpAX7JM9im4quCGNEGljEclzUTbJFHmyhAwapjQt51znLrInDQvHJKFe1h5A9gFsvqwpsNk2ipctq9rUVGV7vhp92OtbL5OTi7H391UKKgUvylWLvlevvHjAu0356o/20kve1xA+W0p+YtH3ihe9Ahlm3tDjuJJBQ42bI5C9APpf/F1kguEpyY+bmWju+bbGm+PgxWb4UaG3vzCs5ujNOcpBAbKX1hJ74+YkKEb2o/d9ov/oFRhWUgRCmY2EBR8eBtpgoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAhlvlzFjo28u+nwpHFHqZmqBtPb6qtxdJdhSHPfktc=;
 b=IDiABVSLZ3VkQ2681seK3OVIE1fRcS8nJNhjPYoHu3ieXsz+dw54X6o7bVp0hC824MQpLHErg8US0DD5qObUZ9UR5wRj6HRVFy4A2E2SYM+ACeczwmLiTED6SvjHR+rhSNttWuloheki8mGS1K4tqM9vbIrf9ZVdJPC3h46nRjKrG4vyXvoO3d92CLdZf8lST+6RImaJ1J61wXDqnGNp6Aw0Wvm+5WEbW7+5gEBb1DT/cvIV5joe/KYGGeQgCdXCIh0M2aUk4O4aX7z/UHB+I2ZueysET4Bd5P08zF+RliAAv+K2oeHHduqXJ7ue4cidn03MeU6iOeSXSbdNRTX/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAhlvlzFjo28u+nwpHFHqZmqBtPb6qtxdJdhSHPfktc=;
 b=nUJV72Qbr+4XFlDRares4NLB2hVVCr4fHrc7PfGifCvwMv51L4PH8xbI19/3UFBtXZb+KEbQhaeMLJ72OXUDv/e/SOSbsEzvwFMnnszzo+kVd8dQqTG0I+Ddr2OW4NDuinYxMj4nCyuy83Zsvi+sqGy6KgGtyBUXB2v3Z/Bvmv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0849.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Mon, 11 Jul
 2022 23:17:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::520:799d:7417:95ce%6]) with mapi id 15.20.5417.026; Mon, 11 Jul 2022
 23:17:26 +0000
From:   Viktor Barna <viktor.barna@celeno.com>
To:     quic_jjohnson@quicinc.com
Cc:     aviad.brikman@celeno.com, davem@davemloft.net,
        eliav.farber@gmail.com, kuba@kernel.org, kvalo@codeaurora.org,
        linux-wireless@vger.kernel.org, maksym.kokhan@celeno.com,
        oleksandr.savchenko@celeno.com, shay.bar@celeno.com,
        viktor.barna@celeno.com
Subject: Re: [RFC v2 50/96] cl8k: add phy.c
Date:   Tue, 12 Jul 2022 02:16:30 +0300
Message-Id: <20220711231630.2955379-1-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <51843710-a1ec-b1f6-8d1a-972ca5b40af4@quicinc.com>
References: <51843710-a1ec-b1f6-8d1a-972ca5b40af4@quicinc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::7) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c489506-7515-4486-2f7c-08da639384d7
X-MS-TrafficTypeDiagnostic: AM8P192MB0849:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCgLO7KVD+r7yWPX8L2xFbj7/yYeIK20uQ9heTaaJMvohmWSeZh9q5Ab4TS1m5wsaJSLrOi29S8Sks/j3ZPSeovTi75K+BTdKRdSt+iG0xeZnxuIAN7GK72rCHnmicI+Jrncz8HUTOtt21sl9yX+8rv0zGRC/lgYZIylbacyXeBRo21jaC7V7/a9/RkVqw3pJVAVcy/xc1w93GDsgQYx82B2TiNYwmdKthZX4dzn9/SwycwJHa9REe+cqEPP5RE2FNXBIook1HNy/Zvpsh9OrBBNfDKjGCxyQ+UjRojehPDZykRp3+8+xrvws8RN1PDqmulFG0/qYq++EIw8Nvv24Sc4hOUTtlAUyHEffN503jz6kYvEHelTLlwFogwGa0DTcI7eWUWcIZvOwsUIy7jwjLqqga/kGWGZl/WIyJF0+G0o1nE5K5nIdA5ZuU0G0FflNNiT0AhG4HYjQ8EQKjuIbYQFiEfAHHmLOBQc4Lkw1DObTwx/TubWCAVyT/Mvzlx/j4upAo5FQV85EpXTAJuyooIvk7jFgcDGwXk/G4RjTov2RPZTmcEvKHpH5VktLccprLRpPvVy/T+AcuCTqgfQQAltFn1QhEsAWCFH+7T/A1J8QD1ML4Yo2MqUbncUY8KLfPgOWG54unz9A8/mQFuncsyxbn2aSqojIYt360rkHO5YAwqTlTqjMdgOFEo7MNgCsVWMlHKHocNXjfqHrVHnhHDumFZbVHstUx6OvK0XSVagtrHxoJEzqgbHVmPPtxpULs3CegwdmycmIZk501cKBBcDMe9e+bGyTXgw5kqkrDUNmM8IQjSNRaigtPVCloin
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(366004)(396003)(39850400004)(8936002)(8676002)(186003)(478600001)(44832011)(1076003)(5660300002)(6486002)(26005)(52116002)(107886003)(55236004)(2616005)(6916009)(6666004)(66556008)(83380400001)(6506007)(2906002)(86362001)(558084003)(316002)(66946007)(41300700001)(66476007)(6512007)(4326008)(38350700002)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gtEqTaDPu6XuzWI5xGMDfxdE1DPu7i76evi9Se/oOnDvpulIaQ2r1jZ9c39s?=
 =?us-ascii?Q?zb5cGcy643JE9BNKtxeYc/+y037YD66ibQ4H79xdUvlrhTJmX5VbAefjs/py?=
 =?us-ascii?Q?PaiIkaXSF0zCILOPQr/fBlhmJ/6EsV3G3HpCx90vSfgZxCA04ESoKIACbOvH?=
 =?us-ascii?Q?EDSZK7wCHHzTUgkLTuMBHPHLUDi0AMDMvp1+/4Rab3faa19iBq3FNN9fGnYF?=
 =?us-ascii?Q?RPtg0MctjbC5KXYCRmGp72Je1i1UjkdZrsrhBZ8iJnwrxIQKpkWIdPfVBWKR?=
 =?us-ascii?Q?URq/0VpDkesQBzGGqnczv+LAMcvE6SAfUuyhPwqcgfN1w9Ofh3jJq1Ik3sxL?=
 =?us-ascii?Q?OLg7TvncWpIgJM5eQID0d+BpiWrIDyYxhCQckyKux1THKf5j4AKq274BQ7/w?=
 =?us-ascii?Q?9KEEe21roH9/zEXttI4Wj/76JUDspWL1DtPUDNrjDyzBIo4MzT8EflReu8Kz?=
 =?us-ascii?Q?hn9kNDNBzUGVAd0RkuurCdohrHUfkcGlz22Hwh9Tgu7wzp61Re9AkVadSVMB?=
 =?us-ascii?Q?xty/gRWQqB4lQCn7mUXmjIFotRhK1H6trFCHTDQeLla6sXu1Zc9knF97kdr5?=
 =?us-ascii?Q?yjh0mQDic2MtU08//dF6P6tbDI/pKHApJU+4v3Tpo14i71XoirZxG9iolDmq?=
 =?us-ascii?Q?ma4NdiiD+WY8gk1IrqT0dKiISvrAxleIslfP86wu/bJPwT7pKLHLdtNPm+Mv?=
 =?us-ascii?Q?dRolwredWDiw2EsJXItb9+jpMX+iTKMlVLAU0757cwO12Ef6SvC38Sg6ArPF?=
 =?us-ascii?Q?6sS1d4Hzuc7UWzBvuim9e3tjWQCR9QbhOPUj1VUKXE6+3b/xyfrxB1gqGRrl?=
 =?us-ascii?Q?4+2003Sqg9VdjmhG5KeZVLLWVtMzPyXam4gvwmDeGTzjTKMhICw1FUUABHYX?=
 =?us-ascii?Q?RZc4j+oNkPo5XsV/4krJ62VM1T2M0WKJLZEJ3+NohIJNuuhLFqwmB0oa1AJr?=
 =?us-ascii?Q?UxR1ZoY2KckBlGW7Np1GjQ8gfH4x8QaI7kG2rt8+Gw5tpVGzEdaMscQ49ODY?=
 =?us-ascii?Q?e/HsiJUkwNMovyTG8oJ6/YcNQLFtqW1TVPQcHGGieZ0/kERh6sLwYybf58sk?=
 =?us-ascii?Q?4027OBiZyZ0y1FzsamSDZgKYMH2wP+s2EjZT0KTJvNrtHrE82vBl7wgwZYes?=
 =?us-ascii?Q?qWVyh7Oia3VSJYHFVHUkM/pR+SbQpq0i/nxw7rEreryBqT8UCyupMoMv5N4D?=
 =?us-ascii?Q?0WwCUIGaNBiC70IDF0L5lp7VM+UvRRIJ7hmL4W2AQovF9fuFTcZlzutiVp9S?=
 =?us-ascii?Q?W29eZ3BkViaEHs0bhPlGrkISyfMANt5lMRnr24ALtEOmcCZ97Ob8624O+OxS?=
 =?us-ascii?Q?fcJiDiRjMgjj83jsuR5tCORcW/FCuk3SNBABiqrXN31GFksBTCl0mkXVF24y?=
 =?us-ascii?Q?il/1rt8xb03zd/oE/Z1LB0sLhe6Wn5qNJjv4fhQ1psCLcVCHGVHUeYZnoEe1?=
 =?us-ascii?Q?MCTjJoEufrkWvziv+cJGcRIXS8hc3u9FNnVFreVsyO7HmclQtzKo7/XPPmRs?=
 =?us-ascii?Q?IN+yHjkAap1Bq0c7ZUELLB/qJnrbFjbrrgolE+sPFacF/3ZcjnJVkP1Y/ua9?=
 =?us-ascii?Q?Nrsdj1jpOo3agqrtutiQJyzSFJjCT+OaT/7RbzaDh9cUtn3JlwTQ31PxX/+P?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c489506-7515-4486-2f7c-08da639384d7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2022 23:17:26.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFEO06NJOOoJUiji0CYibabZsrvTJ/kmyntzNKx5EmrVSd/RUjnxbrmp4KBaRCYxHwXVSs3VM562JOFeL4wFLg==
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

On Tue, 31 May 2022 17:27:36 -0700, quic_jjohnson@quicinc.com wrote:
> in this file and in power.c you have multiple lookup tables that look 
> like they could/should be static to limit their scope to the current file 

Yes, thanks, it makes sense.

Best regards,
Viktor Barna
