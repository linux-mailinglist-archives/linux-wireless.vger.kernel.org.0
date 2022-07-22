Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D8F57E96F
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Jul 2022 00:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbiGVWBF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jul 2022 18:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiGVWBE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jul 2022 18:01:04 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F412AD3
        for <linux-wireless@vger.kernel.org>; Fri, 22 Jul 2022 15:01:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=blo/0DdDsqN/7jec1mWELxC73vXPJM/IaC9bgobqgEVBOQ5bvLAUcHIlSAjboJH4ZUQnd+kzM/ZVt8xhh9q8N+Dw4Ut4Rik5IdvoFB8CRmDaIJACEcW8A/qImLCuXYvFd/7CE5GIWs8iNBxQ4OveN0Mtc3ZalODeogGBDNWk4xtuBhBYqawe1siNOesG8Fj5d130pA6VQslQmIYZIivfopHNP/Mb7QwgPL8gaNzgXujrJ7Vs32cIMgoA1zdRwD30vf9nBAKhEq4lNcUDNVoGFEzyF9eb7Sms/ZP6d8MnerXxafdyIF87T242FHeHIfcIFiA9p9DYLgchOQ2i0VBnRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ih4p3vYIOqnpSHbaYqJ7JqE61Jyg5Ze2nKNNWanDHT0=;
 b=MD4P5ccAGNJ2DMTDMSntKzwsFV1mZ5suRRIgmWpjtB6LvTHTQbEVmwgguYtF8xbb2r9DqQYL8xw9EHEZHBmJdoCopNF4wWw2YQQiZWaEd25ncft2OkyVh5NJNugloETIMaE20EJ58GpDNFzTzzPNj3XtQ2EXeIb0yc7QCs1igsic7P8gSSdc+baoJK38yDkPU+nGo5onFLhQ3USUHmfz1277wGHeAs7r0WuNWrrYFWmtBgN2em8b6EW5/DykL/RkEMrf8JFs0lxKqWxRTRmNSmy4K/C96uAYyENge3JIELj9WoTedoeo9MlMa50IOSCdTRdZK9JLat1zdMm6Oa9MXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih4p3vYIOqnpSHbaYqJ7JqE61Jyg5Ze2nKNNWanDHT0=;
 b=T7sSKvGgeANG04/lGAts4wjB8hWctESOZ6qmaXqzYEbr2nXcYT5HBHId3O4IKs1QljbTQwh7flAYOxO9Zhz8bFF9Tb508GKiR1m1pedLbwEGyroEls/S2H+GIpz78ttgLqfD5ON9aKM+46LP0EOK0mFyNJe2lhWBvhjRwL5ly7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BN8PR12MB4593.namprd12.prod.outlook.com (2603:10b6:408:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 22:00:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%6]) with mapi id 15.20.5438.023; Fri, 22 Jul 2022
 22:00:56 +0000
Message-ID: <ad99d238-dc1a-3233-fc6b-0cd49e428903@amd.com>
Date:   Fri, 22 Jul 2022 17:00:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] ath11k: Enable low power mode when WLAN is not active
Content-Language: en-US
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20220720134959.15688-1-quic_mpubbise@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:610:76::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9a04abe-6cef-403c-5ca4-08da6c2da730
X-MS-TrafficTypeDiagnostic: BN8PR12MB4593:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yi7ssbc2AAXWkh6VIUWeS7tHqjIggQwH0vbDwWP/Rl8NOX5afud6HpWvaL6MTmFnYdNoLcaX0ZocEapB+VGiNc7VbEkWIr2G6EzvZx97XfvP4xUrGvPClCwI8BwGh0f5vw7zy2g/qHtDWnhIYTOZhpSsBhb+8cpQFXit+rR2xzLLzQHq4Y4dW3uEcoGNAInvVFjnVBs1BSnmyCL8TJL61yLUQDzRHNwaop5qE6RMv43r2tMpnVeWS4iSWyqMnXXSASXB/W/RMsTjrgrr/m8LmciaNIaC41wZmSIz+DvPnPA8OgLr5qZby0Y8O9Kx1pG/n4y0me7iaHaZJtGjqYIIeA5LK/7z1nkX5M3tJ4Cpd3QvGNi6K88/ZmcyZhaXotmyuPvHMFYoJlC2zRCGwhek7fOZmM9shjVacrpitDOmUGqY+OUhojg5hQfJiFrIxsFuccuvPiDT17OBScgYG5m+HxsBwuK+H2mkSTsTjRlS/I5avPo2aogtAeTiyGNQI3g6XSxWzDBVYe/k3vbaCwFDBCrYTFt0ELAU40Bos5NKtj6ikEhpizUg+zbMtCeZrDOF20tVHNwBjxq+PLzM0ZzTSDtjG9SazBo4glxB/k8oSxKCSTyLns089vYY44RtE8Dnj2NvURh3afh/H7T5LPl+7nDU7io8G4KqWbHyP2XR65Fx44jd+oXjvI8JjjvY/jU5Xms+IqXXtf63fFsLouPOI3K9YufPcuV5vOwJp1zkCJmSeopSdzXRaE5bn/C4ek9nIC9loXinxH6SWolfOkWJ/HR5RMOnsncUAfGjfslDIiPKmOPOwTU2ZqyW570CP/grPoRzRMQAOKQynVAIoMDQVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(83380400001)(26005)(6512007)(2616005)(6506007)(41300700001)(36756003)(31686004)(4001150100001)(2906002)(31696002)(38100700002)(8936002)(5660300002)(478600001)(6486002)(66476007)(8676002)(4326008)(66556008)(186003)(53546011)(66946007)(316002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2RzaElJdU11SWlOYi9DcGRsSkVEQXpUZjlFVGcrbERkOWxqMGZJNktKNmF4?=
 =?utf-8?B?eWtQYUhScHQ2dXRwcVlBclY0Z0xjVDhjYnhFdWJVT1JaQ3FjYzZRampNU0pY?=
 =?utf-8?B?cmJDaWhCOEQ3RkJtbUxtZEpHZmRVV2FobmtZUk5Tc3FxQ0U3dDBjem9LbEMx?=
 =?utf-8?B?N2l6VFQrZEEzRFJEa29vM0dOcTB1U0dxbHFOT2Jwc0FRWWFlbEI5Rm1PSThr?=
 =?utf-8?B?NFVrMy9SeTNMcXlIcGh3T3BWMkpyQmxYVmdLWXRZRHRkbzQ0SGF0WnpHR1FX?=
 =?utf-8?B?RzhmeE1UQnZyR1N1dXJiNkR5SXZzM0g1ZjhMRlVCWHQyQkUwZUVkT0o2UDhh?=
 =?utf-8?B?ZmhaemcxWHVoTkJmOWpueU1RVEwwQnpORlRVcGpwbzIwT1RmL29veG12dkRw?=
 =?utf-8?B?NHg5emdzWndiN2oxbm1OcUpxME54NmUvTEdnYnhldlhTU0wyVVBLQWx1U2R4?=
 =?utf-8?B?QlN5ZFgxR2VjQjlWQkVJQXZDV0krbWxSMWFzUkY5cHNUeUhJUlRiNzhOakpv?=
 =?utf-8?B?L3BNWFl2Qk1MREF5RXUxUFA5QnhIZEpUOGZ5endlSGhrNU54TGFDaDJUZjdY?=
 =?utf-8?B?MjJ4bDJhWDRiRXJzTER6SVBvUlJxQ3EzVFU3OXY4ZC94aE5ET2hMbTZVanB3?=
 =?utf-8?B?RXdEeVBicmI3UVMxR2NtekJmeXlnaDZkZWFpeENsQmx2SmM5aUtrRHF5ZWlI?=
 =?utf-8?B?OW4vRnZ1cWR5VngvZkJrcU03VHhIK3lUdVRHTFpGOUoyME1VcmYvMVVuSDRz?=
 =?utf-8?B?aE1JOGV5Nk13YnFPNG9FUFNveGdxWFdVNlU4bzlSN09qZE9wVENhdENiVlNK?=
 =?utf-8?B?Ly9vZVhmYUkyWk1ZS2JsVHJSaDVSNW5tUTZIVVc3ZCsxTTNBcVZaM2hpWjIx?=
 =?utf-8?B?eFRPYVdWbVRJaVk1a1VYcU1RcERJWWVTS2MwV3Rqa3h3dFdOVHJJdUpxS1RE?=
 =?utf-8?B?cDhzK20yemhHR0JKSEgwQktYd2xyYVFPSkRrRDRpNjZUL1FJaWtTYlBMSjdu?=
 =?utf-8?B?WmxDSDEvVGRUd0VxSFVpL3B0VUZmRTVHY21Ia3doUE1WcVF0OVVRRFhMZk5r?=
 =?utf-8?B?MklGOFYrZHp5cDNmcnk5RkJCM0R1VnRKT3hRSUgwak1QUnMyaE85ODdYOGNT?=
 =?utf-8?B?Z2RRWStVamNmVUZxSTllZHV3cVBaMHNyTHc1dEdrUW9JcXNiemQyZmkzU1A2?=
 =?utf-8?B?RE1ncDdqNjVYRWZvcDhLNUI0VXY2RHlhUUFnbnJKOE44RUZVdXRvSUNCbWNv?=
 =?utf-8?B?S1d3Q2s5QVQ2WG1KR0dIaEpHRDRZTUdXR3ZVYS9UaGZza1p6K3YrTTRobXFV?=
 =?utf-8?B?elQxMEh6azFNYkw3d3F5QXBkSW9peDVOQlY0T2JEcVpsdnRENHBFVGRZYU5r?=
 =?utf-8?B?VlIwTkNPSk1yN09jRWNIU05wdWdTOFNHWW9sbEdob292ajJIS29tL08wYk5m?=
 =?utf-8?B?RGRXelEzQlhyUVhXbU53NkRmZHNQUzJGYmhubVFaNE1CdlhSU0JwMlJBckxa?=
 =?utf-8?B?OGZ0Ni9lb1BHQndTZzMraEFWZmIvV1BrYWFveS80ekx2VjE1cHZZZ0ZxalN0?=
 =?utf-8?B?SGZBRkwvMmNYak1ERW9QMjhVMGNrRndQdS9IZU5UYWJWczJ4ZUQ4RUhnN0JS?=
 =?utf-8?B?Q3AvT29aVExVcnFka1hzbDJMdlJhdllxNk56L0g1ZDlrUGpaTkVnU1I3b1NV?=
 =?utf-8?B?eEgxeTNXRjgxWmxEbm91RXE0UUg5a3lrWVJnV1FXNzJ6Q2I2NDBSMERwblhO?=
 =?utf-8?B?TUVPT1RranhmYWJONHY2RWF6cVROZGc5THE0VWd0dEpzaGN2VGJSTGtMMEhy?=
 =?utf-8?B?dElsVk1NS0ptN3JWc1FFSmxkWENVT0FGbUtYaXlaTHlxZmxKNEsrN0l5em5z?=
 =?utf-8?B?RmYweG1jcEN2eXExZU1lWDlaNS9IcHUwNEhHcFZUdGsrT2xRRHorQUMvdlJh?=
 =?utf-8?B?YXdYV0c3TzVndVdVZVRSa2hIaWJWMlpLTktCSGltcGVyTzFic251QmRXNE9M?=
 =?utf-8?B?VVZYdmQzUzZQbTl2bjhLN0hvNDBjODc4VHBDRTcrYmladTJvOUplbU9QNTVn?=
 =?utf-8?B?Q2RZRmgrL01wOFZSOVc2dENmVnpva1JSSjhzbDF2QndhYUd6andxVXl2ZVZI?=
 =?utf-8?Q?C3L3s2IJN0vnTGIhcMS//GuBl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a04abe-6cef-403c-5ca4-08da6c2da730
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 22:00:56.1732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edTnk4JolREdc54lG97sbkIVlCrAwJB7FbEcafgZv/8UkcErsjwRdlBJqfoLib70VNk2Odm8h8S+/xDbqd+PEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4593
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/20/2022 08:49, Manikanta Pubbisetty wrote:
> Currently, WLAN chip is powered once during driver probe and is kept
> ON (powered) always even when WLAN is not active; keeping the chip
> powered ON all the time will consume extra power which is not
> desirable on a battery operated device. Same is the case with non-WoW
> suspend, chip will not be put into low power mode when the system is
> suspended resulting in higher battery drain.
> 
> Send QMI MODE OFF command to firmware during WiFi OFF to put device
> into low power mode.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
> 
> Manikanta Pubbisetty (4):
>    ath11k: Fix double free issue during SRNG deinit
>    ath11k: Move hardware initialization logic to start()
>    ath11k: Enable low power mode when WLAN is not active
>    ath11k: Fix failed to parse regulatory event print
> 
>   drivers/net/wireless/ath/ath11k/core.c | 237 ++++++++++++++++++-------
>   drivers/net/wireless/ath/ath11k/core.h |   8 +-
>   drivers/net/wireless/ath/ath11k/hal.c  |   1 +
>   drivers/net/wireless/ath/ath11k/mac.c  |  33 ++--
>   drivers/net/wireless/ath/ath11k/reg.c  |   2 +
>   5 files changed, 189 insertions(+), 92 deletions(-)
> 

This series looked potentially promising to me for a problem that I'm 
seeing on a notebook failing to sleep where WLAN_WAKE is asserted on the 
WCN6855 on resume even though WoW wasn't set at all.  This is 
problematic as it causes a spurious wake while SUT is reading from the 
EC since two IRQs are now active and the kernel wakes from that.
Removing the WCN6855 from the system it doesn't happen.

I figured I'd give it a spin to see if it improved things.
I applied the series on top of 5.19-rc7 and it applied cleanly but I get 
timeouts on wlan card init (and of course suspend fails now too).

Here's the mhi/ath11k_pci snippets:

[    2.864110] ath11k_pci 0000:01:00.0: BAR 0: assigned [mem 
0xb4000000-0xb41fffff 64bit]
[    2.864901] ath11k_pci 0000:01:00.0: MSI vectors: 32
[    2.864912] ath11k_pci 0000:01:00.0: wcn6855 hw2.1
[    3.106892] mhi mhi0: Requested to power ON
[    3.107054] mhi mhi0: Power on setup success
[    3.198178] mhi mhi0: Wait for device to enter SBL or Mission mode
[    3.971019] ath11k_pci 0000:01:00.0: chip_id 0x2 chip_family 0xb 
board_id 0xff soc_id 0x400c0210
[    3.971025] ath11k_pci 0000:01:00.0: fw_version 0x11080bbb 
fw_build_timestamp 2021-12-16 03:42 fw_build_id 
WLAN.HSP.1.1-03003-QCAHSPSWPL_V1_V2_SILICONZ_LITE-2
[    4.290328] ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0
[    4.308760] ath11k_pci 0000:01:00.0: Failed to set the requested 
Country regulatory setting
[    4.309028] ath11k_pci 0000:01:00.0: Failed to set the requested 
Country regulatory setting
[   14.386201] ath11k_pci 0000:01:00.0: qmi failed wlan ini request, err 
= -110
[   14.386210] ath11k_pci 0000:01:00.0: qmi failed to send wlan fw ini:-110
[   14.386214] ath11k_pci 0000:01:00.0: failed to send firmware start: -110
[   14.386243] ath11k_pci 0000:01:00.0: failed to start firmware: -110
[   14.386266] ath11k_pci 0000:01:00.0: failed to setup device: -110
[   14.386300] ath11k_pci 0000:01:00.0: failed to start device : -110

And so - on.
Is it functionally dependent on other patches in linux-next or another 
tree I won't see in 5.19?
