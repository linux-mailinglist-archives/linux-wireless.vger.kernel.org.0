Return-Path: <linux-wireless+bounces-2576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F70183E25A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08591C21491
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEBE2233B;
	Fri, 26 Jan 2024 19:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=locusrobotics.com header.i=@locusrobotics.com header.b="Dbxdoh/S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD58E1DDEA
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296744; cv=fail; b=EOlqcYOVq6Hsq3izzYTZW9JPD3FmTScB1LQiampjDTrvB4+KqYRcoJFjPX1P6Es9oW5BmJM6eatSkUziTa9thSgodBIfEM9oKnJBLLJNXzwjLs6uzVggKaG1YmvnrtXFfXnSkmOlFVVevryjmquth7QSWt6+2Yt0IzQyZY1/O6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296744; c=relaxed/simple;
	bh=PkwX7HHGU4ld0OPnv5EYQ4EK0t+6V5jHqSw9PhgYKYo=;
	h=Message-ID:Date:Subject:From:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e89QDv+RryftBXYgGSYNvga7V6Kb5UECvFTGBd0DpKAD1mCd6WZ7Ti8I+dBJAev1kp4yCoLBelcRKpygjoAgYtioXylk1NeRGefHah5yNb56SjZ0Ia5diQ4xtoagbhFaWCP5rA6QGwhKm5SOORNOqo2vuIgbH2kxSV+XCap7pB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locusrobotics.com; spf=pass smtp.mailfrom=locusrobotics.com; dkim=pass (1024-bit key) header.d=locusrobotics.com header.i=@locusrobotics.com header.b=Dbxdoh/S; arc=fail smtp.client-ip=40.107.92.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=locusrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=locusrobotics.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4r8ZrdPVEaUhuNXMj2QwFMxLNWLW5HBd8jPR0joV/R6tPExi1F7MsVvG3uGB4rnkQJr3Sj28tW1hc20NqtwuHJmKYAbqBH1uZ/31mlWOMmm2r3IJ4TdqGo4HYXVtph/wuDQwNPxsPf0w1LiC4v4ocyJXSmu1vhaKPO/GnqrFWi50OsTDdSPPmLhuzByhNq8MCf1ZcM3WPNfUHLX1wqVSmQ3Yz4OywcURcpazZJc6volB/Po4gOKvfIHCaWDnKoJuxxCHE7obBYmtC+t2oZti4pfMCYe9tKBJglkGYvTgRIEpNIJPXCSt8Bt3iA5QBznetOlSCKycRVoMNFhqAQZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJWRUGQeST4pCM3fwqmNX3iZ0tBjcVbua4D8tBWZI6U=;
 b=M4iWuxua7F2EKCTBKsCQ/mg+/dM1yth3ducW07NxmA/n4JMktMbMii7E6FbfyLcbOESe7BSOVR2vqFsqGbhlkZmGzAzXfyT24VD8/OErpfQsU133zfmFxymBk4lfRFAOOHtS0js6DBETcCm71XZBhtJk2MvANxATwWFmItpRlLby41KMaXaeIJxW4MbEWxe97M/BGBc50g+qLV8Gca+nFdakn3h0UB0ZHNrMUOvY3FT6Gx7K0w9oX3MP+ZQZvv7ohyFcqw25YeKe/PSCJ+L0Qc0Fg3GaSa8CxqwPpqXxEGUN2U5vICf1feT88bFiY1Fs/K0dGrM+f3HbhtIH6M6ZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=locusrobotics.com; dmarc=pass action=none
 header.from=locusrobotics.com; dkim=pass header.d=locusrobotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=locusrobotics.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJWRUGQeST4pCM3fwqmNX3iZ0tBjcVbua4D8tBWZI6U=;
 b=Dbxdoh/SpPkG1MwGmThvlH6O6zUL8caN4b+809v5YRHn9dYonbQYPIT/JHasVvfTkF7hK23AdliCXf9FIqm5n/OiI4GdEzYWmBpUkfX8Ej97n8MYleIAA7cz7NnckhvueSqoX/REghO7md6rvSGi+vKUWruenK2yff0eUnfqy+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=locusrobotics.com;
Received: from BL3PR10MB6163.namprd10.prod.outlook.com (2603:10b6:208:3be::9)
 by BN0PR10MB5384.namprd10.prod.outlook.com (2603:10b6:408:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 19:19:00 +0000
Received: from BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::fa77:414c:bd6f:3bac]) by BL3PR10MB6163.namprd10.prod.outlook.com
 ([fe80::fa77:414c:bd6f:3bac%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 19:19:00 +0000
Message-ID: <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
Date: Fri, 26 Jan 2024 11:18:57 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
From: James Prestwood <jprestwood@locusrobotics.com>
To: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
Content-Language: en-US
In-Reply-To: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0061.prod.exchangelabs.com
 (2603:10b6:208:25::38) To BL3PR10MB6163.namprd10.prod.outlook.com
 (2603:10b6:208:3be::9)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR10MB6163:EE_|BN0PR10MB5384:EE_
X-MS-Office365-Filtering-Correlation-Id: 837dac87-00fe-44a3-795f-08dc1ea3a657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NBWh9tqaQa8Ho+mCrVo+uZtk4kyICyOa/C0wCjhMc1Us0A9RgnMa2RLSJUtKcUiymImcgdmNeRhNWXtnirDpAK0j7Ofcu8XSv0Tl+iYt3NdikySIfIJdB6l2zUs6dCtP0zvxGuMbRrGgNpwlOdS2j4/DU+H4mevX9ACpvQi1flLR50Ukt5iN/idAN440aIhj1hzckQHzmcTgtfEjGewJuEoJpUADdDtIM1B3EKeNsMPV+wIaULeoFzK0sZv0CHV95E+AcB27xWwO2EUmtK1gtx7LZo2kr/2BHsV7+h09NkjfbHghFOyMtO70RtieHe6DkAFupJ4ZsGyiNIbXck2G/cuH2Mro5jAZQWajBI29Liln02xvzPOOm8omOLsrRlBXH5brVAYujl26jDGGgK65jSA+z6jqRR+tKj6sh1gRaOX2plvi5oFLCQtDByFVruEZ7WvvUQSCDAtH1etIPvjy+NABIoteE9x20mUxmfrL87erh2Fz9ssOJxUIxtKrIhBemuQInKZd1sGljjB7xj7X6PgPtax90D7jzZjlAmm9T2LxJa+m5z9RBed/KAyHds7C6R/BaIbLdiO1mnj5HXE4fc/xodDFYHacQpG4QMTdIcL/wLcXFqh0WS/0M3b/cmZVfopboK5AI7FQDR6MhVgVwtFbyt8XKWkCF7Kyf51hS71Bclt9VsAW5eLCSlQTxS3a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR10MB6163.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(396003)(366004)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(31686004)(6486002)(6666004)(5660300002)(83380400001)(8676002)(53546011)(66946007)(316002)(66476007)(8936002)(66556008)(6512007)(2616005)(26005)(6506007)(478600001)(38100700002)(2906002)(86362001)(36756003)(31696002)(41300700001)(83323001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjU3bDZDOFdhQVZuSmQ3Z2dvbStXcVE4OGFVR0RFdERkMERaVHk4VkMrTTdx?=
 =?utf-8?B?RVNZS1FqL2dZN3NYTE9JU010REFxVXRDRFpWMnNSMkNxMzR0RmRodjNyMmY3?=
 =?utf-8?B?NDFlTHBZQXN5SEVHREE5dENrL0FCSXBRb0VsaVVydSttalRKNmhaNjdlU21x?=
 =?utf-8?B?cEY0eVZUMDI1eUtrY1QrQ2VnbjBHeWFvdnFFcTloVUNYSjVTaVpWMXppMjdW?=
 =?utf-8?B?S1hIdFNGWjZSTWtGaS9tMFRDOUhBSHlaNm9iejByUUI1VHJUK1pJZlRkR0N3?=
 =?utf-8?B?RCtySm0zNjJSQjZod3ZHd0VsSTFtRHVJc1BqT2Z2MWR0eDJuN3ZBTkx6Q0VZ?=
 =?utf-8?B?NTFkMFZDaDBpRHA4ckpOQkZzUnBFVDJVL09wRk50WjREaXFsVTlHdFd4ZzRm?=
 =?utf-8?B?TXZ1VHowOGpuWFpuaWRGYWFhK1hBenFDZlBQc2Z5MEg3WHlpZlprM2tMSkRz?=
 =?utf-8?B?MFRXVVNEaWV3dUJxTFZoejlJS1JHVUdpTERYWXV0OGtZZTdjbDZCUVQ5bzFh?=
 =?utf-8?B?Qk1FcDFrNFEzU0tPZ3ljN0tkRXRUL2R3bU0xanpSUDV2ZGdpL29Qak1nNE9Z?=
 =?utf-8?B?bGR0L0hiM044cG03RjJmTHE5cFQwV1ZNbWR5SUQvTXFXNzFUN2F1RnJSM0xt?=
 =?utf-8?B?K0hvd29yZElKYThSRjhpa2lqNDkrQmVTVVZPS3M4RXN3V1hnbVdjWEFqMzRx?=
 =?utf-8?B?K2oyWGt6Z1oxelU2NkdVTEVGZ0lKVzltQTIxR2V0L25RbVgxVVIwc09yN3JJ?=
 =?utf-8?B?Vkt0SE50Y0NxY05zUHRpRzJLYXhSNkVDWWMrU0pkakpleEtPYUpXckIvZ0hN?=
 =?utf-8?B?YWorMWFKcnlmR2JmNzI5Y3VQblNFSjBBNTVtc1hDOXFXVGwyQ3VKd0MrOG9r?=
 =?utf-8?B?aW1OaUE3MktSY3Ryb1FnNnQ1Z25RSVdoeFFFUGp6VFVTM2sxaklmVC9jaFdF?=
 =?utf-8?B?Tjd4OGUyWVJQRENzQUNMc2tIYVAzQW5jUkZITWRYS1ZTQzUwdjRCUFJKejBJ?=
 =?utf-8?B?M2lRcm9kOGYwYml4ODY5SWFTTWlhR1M3aEd3WkVYSjdHazhRYWhTRDFQNVNu?=
 =?utf-8?B?QmMvbGFZM2VzdjhmOE5wZEx6MTJFV1BmV3FFcmtrNzlOUk9ERkkveWN6Y1JC?=
 =?utf-8?B?b3ZVSFNXSWlzaDh1Vy8xajl5eTU0TjQ0ZlNDc0lQTm1kRWhNMWNLYjRGWllq?=
 =?utf-8?B?Z1A5MjJPWjI2dWE0eEx2VitnR0xBSTI1blZmZHhhUWs5WnU2TnF6aEwzeE81?=
 =?utf-8?B?MmtXRkZJSVYvUERyRDlCdkV2MTRPazJpa1VBclNXK3gvWDNPL2dQeHlkRjZx?=
 =?utf-8?B?a3dkVnkrWm10VjdJdEtZOWdvL0QwY2pFaUYxdXBGaWFGVjR4ZmRxVURxQnNl?=
 =?utf-8?B?NEY0cWVKYUJmaG9US0QyYnY2KzRzOFh4UGJBamJQZ21vYzMzc3oyR2dOQldV?=
 =?utf-8?B?dWdGdzU5T3ROZU10VmtnUHFhVkN4bXRrRDBWTFRnRUlmenVGWFN3dlJsalFO?=
 =?utf-8?B?ckR0L0I4TkFrSXpnSVlKTkU0cUQzNTBVRkFaaW5OaytoQm40QW1XczF5V1hK?=
 =?utf-8?B?cjlsRmdwZ0d3REdGaEdSUEFwSXVTSWxRcHltOGM4djVDSURvNE84SVpDMTM4?=
 =?utf-8?B?bnlQUE9FWUZIOE1hUXBlcFEySWplclJ4a3lVTEt0eE56UGVXWThBVTRTRDRE?=
 =?utf-8?B?U0x1TmZwZ1dXZFhKdE1KdStFanF1REUwNFpKSWFXVldWbGJJNVcvcFFPb294?=
 =?utf-8?B?bStIK3VEcG5iMktaOVhhZWFLdXRiMUhXdTFMVk1Udi90eWxZR3RSbUNMSkNk?=
 =?utf-8?B?bStTelR0bmNuZXhSZDNDa2YyL3BRSXR2SEVoSno5S1pMM3J6TUMxeXVXL3RG?=
 =?utf-8?B?eG15NkNES09FV3VJSThpMER2dGZERkhhVk45eWUrckZJbHdPMDVscWxsSytE?=
 =?utf-8?B?OUNCVTd5N0Uyei9xVm9zelc3UmxOUzlhVzZEb29FVTBXWC9NY3plTWxqMitx?=
 =?utf-8?B?R1NsM2hWWjE0d0l3V2lWMmZPRmdpMmF4bm5wdzJuRUhxWmQ1dm1zZHNxdTdL?=
 =?utf-8?B?b2g3YVFvK21KYUY2cEc2YUlTWjh6ZzZRZTZGMzl4eC9pcUpFQTV1a1U0ODVp?=
 =?utf-8?B?T1dza3ZFMzA2Vm42RkZzdzc2cUs2SFNIZW11R2xoVW5PU0FSMEdJQWE1c2c2?=
 =?utf-8?B?WkE9PQ==?=
X-OriginatorOrg: locusrobotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837dac87-00fe-44a3-795f-08dc1ea3a657
X-MS-Exchange-CrossTenant-AuthSource: BL3PR10MB6163.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 19:19:00.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 068f275f-67fa-4977-a33b-80fe854a9590
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwwXM40su8QaybZEPmp9cJqmIiiyTG7pAOX47c2dd765/XwNkAuQlwSbOVIqfBmTJDG11m1goNG7RQPyWJ03AbOpVATpeMpokmGpA1/J/u8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5384

On 1/24/24 5:06 AM, James Prestwood wrote:

> Hi,
>
> I recently added support to ath10k, for the QCA6174, to receive 
> multicast action frames in order to support DPP. I'm trying to do this 
> for the ath11k QCNFA765/WCN6855. I took the same approach as ath10k 
> which was actually quite simple but I'm unable to see any multicast 
> frames coming over even when I enable RX/DATA debugging.
>
> What I've done so far is:
>
>  - Add FIF_MCAST_ACTION to the supported filters list
>
>  - Created/started a monitor vdev from within 
> ath11k_mac_op_configure_filter()
>
>     ath11k_mac_monitor_vdev_create(ar);
>
>     ath11k_mac_monitor_start(ar);
>
> - Also tried adding
>
>     ath11k_mac_config_mon_status_default(ar, true);
>
> I can successfully create/start the monitor vdev. I see now as I'm 
> writing this email that my specific hardware does not support monitor 
> mode outright... Is this a dead end or is there hope with purely 
> driver changes? or is it some filtering at the firmware level 
> preventing this?

I was able to finally see my broadcast frame after some additional 
testing. It seems the driver/firmware/something gets a bit hung up when 
I attempt to put it in monitor mode. It will start printing these 
messages for about a minute:

[   51.093034] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a2 
!= status ppdu_id a1a1 dest_mon_not_reaped = 650 dest_mon_stuck = 12
[   51.094461] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a3 
!= status ppdu_id a1a2 dest_mon_not_reaped = 651 dest_mon_stuck = 12
[   51.096281] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id a1a5 
!= status ppdu_id a1a3 dest_mon_not_reaped = 652 dest_mon_stuck = 12

In most cases these ppdu ID's are a one-off from the expected ID which 
seemed weird to me. But if I let it sit long enough I all of a sudden 
get a ton of "data rx" messages, which is what I would expect if I 
enabled a monitor vdev. Once this flurry starts I see the action frame 
from my other client, sometimes at least. The firmware generally crashes 
after a while so I've still got a ways to go but it seems within the 
realm of possibility that this device could receive broadcast action frames?

Hoping for some breadcrumbs to follow here...

Thanks,

James

>
> Thanks,
>
> James
>
>

