Return-Path: <linux-wireless+bounces-674-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F285F80DD7E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 22:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A49E1F21ABD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 21:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA854FA0;
	Mon, 11 Dec 2023 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oGNr9FtC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00BEBD;
	Mon, 11 Dec 2023 13:47:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z13Yw80k3EfcIbIa87xA26lC/w1wnKEzjix2ExkbIuHj9hsPGEs/EOuBkvtnCBCNybjNOwl/fozYlIFlXA7wY5nHWNn9v28H7da5c8wjA03xAi+AcMFguP7tF/aZ6vv25nxznyrD4DIFVn1RQar8ns6uaUOHsFvOOjV+b0DlaT0lehLY6oRH183r05HMd8EDrRj0ZFlL0dwqF7GpvuH92Fk1LIz/OWGF4wWl3WZrGIexvOEZbdUydekOR6X+os37xLqxW89omSyrcqX+JOkkgcysem3TOGFlyRKiv+BNVr7zETIW6uCx+u4PPcPiKRFj8AFpZOWazGLy+RnI3dffEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjj1mkZnKgXgoZR4EPwq3SootZWaHc8fCNxfsRkIxTg=;
 b=HZnUqXTcp+QzMJWobAdILzhV7J2ArU/YOiMvy+pzcKAWm9/VN5Alf/fUSlNOLC9UepwtjobGqwkMDF7lN7TTeTKUx/Sxg2xBrSaglGcd/gip4QT/oFR1cixA0D2n0PBqpJGeZ1i1HVp8o9qxiJeMSYFH5YVmiukO3os8McYrDWmOrY230YFU4X6GGJR3M/xQ5QV9g03En1j1GSeNQ3mSjTYTI2BUB60ZBLq4lrdycNofowbSvavlfwfvZF65dUU7XmgtX8OJCeN4BZWdDRLQLiJcu/1PGyHzjKGwhiSgFQqg0agLW83i2UUbBm4f3z7EthmDbvWuCGT54o16nwmgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjj1mkZnKgXgoZR4EPwq3SootZWaHc8fCNxfsRkIxTg=;
 b=oGNr9FtC7BxD6le5JE7M0zl6So4h23Dc050L/3N7xvaDEcPAdDjE5iDue1ihP+2gzO02/mA1QzIIp8lUxgCDjgC7FVsHNjErpv3Fg4WdVrSqTVyY9P9rM3T3MmnghZIiCwKhPFrN/Jdxoj1gt+PgPHHTBrHfxvUShlUXeCXeoDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:46:57 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 21:46:56 +0000
Message-ID: <8f28351e-27c7-428b-8b9a-6f0755a3878f@amd.com>
Date: Mon, 11 Dec 2023 15:46:54 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com>
 <23850b71-f530-4094-81cc-26cd762dc231@amd.com>
 <CADnq5_OXRrGRH6iyFc_kfP2BARyav4uw3X0kuV3tP-7VXv3tMw@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CADnq5_OXRrGRH6iyFc_kfP2BARyav4uw3X0kuV3tP-7VXv3tMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: ca56a841-f9fb-4d55-8b36-08dbfa92b246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o5n8p2QZjwBYQb3G6jmZgy2Jq6LfrcIWSHTfiU6ZlGK90sAK+VUYkBoxwiz7+GDYviasWatxm+NMbiIqRyw+6Dfb6eDQ4Iim8Yl61zvPwv4enLU0TyzWZBAEqnZ6YRnsMisWSif+UX3la+istOxeEACkxA+4TVlAnv9VV00ziU41BxJRbl5P6VeK82Zzt6rx2T6e4PLI+wjZOexePPS/RMpJwFlxNE6BwO9ClXYgyx1bvgWyJAkTmJAfxm00B4uuBdMTzw2ryifS9pCsn56sljJLO+0FGMt8+qY3iIdgkKjWrnOvnKcA/io11h5E0CySCnBjLcl8DTucg/j61ftiV9MxKxvXVrobYqrLu38d/dvSedjGWWLxE0vMrs4FRcS3fBH6S/v8NY/Qy/U14ujJEmDgPxC0fFrjd0NHUUAt/cHwNIx8wOoS3CausZTiwq5sZpGUijnL1EJ5clxfeZIpdz8dciNrbZxLNwINxHyIFn1yYQIR4VQwytNXfhGW12e/XYeeCUvQaB867ihapSIFSwc04RGNs80hdeLe0ZtFA3rfQlXXGw6EtXzHcvxgceDMirqEB7+lTDu2YVlJDM6ZanlzjYbod0H8XmM/9sxqxHE4Ma0I9iYoPIeOEGJx0PqZAUZdNUwTphYcD0MQWZRRkGUAzJyVDqgmhtBWuyW06Dw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(38100700002)(2906002)(44832011)(5660300002)(316002)(4326008)(8936002)(66946007)(8676002)(6916009)(66476007)(66556008)(54906003)(2616005)(31696002)(36756003)(86362001)(66574015)(966005)(26005)(6512007)(478600001)(6506007)(53546011)(83380400001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG12UUEveEtNRWp5bllTaXNLa3NKamprNVlXOHZaSUhsWWRxWkFGRk4rVlp5?=
 =?utf-8?B?ZHcweUtPdzBFSEFPZHpVTGd3Zm1XSDB1Ulc4RlFaQXozWkRrS0hZdlVpN0dH?=
 =?utf-8?B?OURVOEF6YVRWV3VxWGt0Y3hnSFQwR01mMVdYelRFMzRRZGduVzRBUEdJdTF2?=
 =?utf-8?B?ZEhnSEE1TzdmZ1dsc1NON083QllsdlhYbVBvTkhaeGdrNm9aTjg4N3lLaktM?=
 =?utf-8?B?bGVUVnlkVERua21wZVBVd0VOcjd6djgrbXE0OFY5WFNSK3ZFVU1wcHZWSEZn?=
 =?utf-8?B?UGRVcERaUzlTb2p4TVp4SzVUMkd3blNlZCtZekpUWVJCemdVdXB1aGtweTFk?=
 =?utf-8?B?TnNzTHNwOWQrQjJqZ0xnUjNpb3UvY3dQaEwrRzRaalMxSDdRTEp5aVArVHNL?=
 =?utf-8?B?RVV2TDFjSC9nUm04cnoxS0RuSHg0dnBmbkV1bjYwaGZ3WTV5bGNBWjFVZWxM?=
 =?utf-8?B?dlIxNGlHSGM3eDNTNUhMdUhldUF6SHZ6b25yWmdBWDFkM1dsRTc5dmpiUjdB?=
 =?utf-8?B?RUFxcWFkcGRoeFRsb2VIbDJ0SFpJcG81RXBxRk16ZVlxU0pYRWljUG9ocCsx?=
 =?utf-8?B?bEpXaWQzRTF4SzZRUStXM2xYMGRNZHhsbzhaVVN2dUxGVUIyOHdGa3lURTB2?=
 =?utf-8?B?Ylk2bWFnRkFxc2s5SmpKcEFDVEZHNjlSZm9BVm83bnFUU1ppQ2N1NE0vSFJR?=
 =?utf-8?B?bCtPNm1RdXF4YmNNd0RZNjdUeUZmU3F2MlhhbmdJeVZKMHJvc3VUR2tsMzFN?=
 =?utf-8?B?bkdOa01pVlZtQlFoaWw1Z3ZHRFBzNjdoKy9iTjIzTzlFeHNTMkJUNjlXZERX?=
 =?utf-8?B?QVMvN3lBdVZEOXZPRXo1TXh2V3QwdkNTYnhyRWRDakk4d3pnZDMvNXdOQW5n?=
 =?utf-8?B?U3JydkxoNUtjUnFEaUd5TURyZXdPOVZrZEZSV1NMeGFGRjlEdUJQUHhmSDhn?=
 =?utf-8?B?bTBIVENGUU9KaElGK0k0WE9WNUVPNGZqTms2SHFOaDVpcTFYZ0l6bjFtRnVU?=
 =?utf-8?B?dThONTRJUk5MTEtXT3dFVEIwU2ovODFySkdpVnZLTHdxUFJlRVdNc2o0S0Mr?=
 =?utf-8?B?NHRKa3ZqcG0rV1BpL2NzNC9wYnIzbE5LTjN2bUxQS0x2Uk1JYU51SEVMNm9r?=
 =?utf-8?B?MmxEQzlMUmljN2dkK1Jvd2Z1VCt5VDJVQ2Vsb09HVWRFazdWeDIrbmJnYVgv?=
 =?utf-8?B?eU9QdjFSUmhDSWRtcVVoT3JZc2QyTzR1eTJsY2FrNmNBbnZYQUw1K05la2Zu?=
 =?utf-8?B?dmhZeWlrSnZRTFhsZXJrMmZMRXh0bUZtUGxMWjVXdW0zclp1OFF4bENXc2dM?=
 =?utf-8?B?QVNhMXhsMjN1elNOeVRBSGYremNMNUtCMFZrenFKTjlKakI2ZC9tVlRXNTBH?=
 =?utf-8?B?UEpnUDJaTmNNMEVVSW14M3h3ZWZ6cC9JV2VBUWliZ000WWkxSk9aUjJIYlZx?=
 =?utf-8?B?VG4ydlBsY1llalU5REQ5Mml3M25QVm1RV3pIQ3RZYVBid2dNRXFaQ1RUelNG?=
 =?utf-8?B?cEpOOWpabnQrZkhPOVIzYVgwN1J6clJvRHduZ04xT0dqekg5T015TmQzenNF?=
 =?utf-8?B?SkJFYUMzeXlmUHJkMXQ5S3l5TkNGMDB3TkJ2ejcrcFR6U0JDWC9BRzdNcnly?=
 =?utf-8?B?VVkreFcwdmZMclk5NG4rUEpOYXJldWk1WDRSS291WVE5WGZxdEFwNDVGMWp2?=
 =?utf-8?B?OW1hWGFFQmY2RDVFU3pDSWlSeEJrRkJSN3AzMmtPMS9POHpZN29ORGlURGdW?=
 =?utf-8?B?cXFIQjAyM3lGOXprUisrVzI3UXI1L2wxN2hPOXVUM2MybnBSakpqVG44TExy?=
 =?utf-8?B?UGhNbUtVeGNVb2hVNkJ5Ukp4czBIN2RtWHhPMnI1Z2V3M3RiR1VuVjFVb3pK?=
 =?utf-8?B?RXdrL2RidGlVZUVIekV3TGJldHFwM2Evall6MXlSeEdSMzhCMDRjMElhdGs2?=
 =?utf-8?B?UXFaZUJsYW1ldStwa0x6VjQzK0ptU1BhNnhqUXcyYmduSWwwalI4UTlQNk5Z?=
 =?utf-8?B?VGtoQ3lnZStBcXF6SER3OEtmYnE4TGg3SitVcDNQaUowVG9aVHhQWG8rMGJM?=
 =?utf-8?B?cTRlRG4wT2pROVNFSlVuMnJLZlpjUFJkU3JiOW1xUEVsa0poTHNYSHRlQktX?=
 =?utf-8?Q?eGW9mHm44Y1Hjeia6DQqkfNxu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca56a841-f9fb-4d55-8b36-08dbfa92b246
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:46:56.8608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fLCCbqrwgxjYeodbxGyIcpXUwGWKYH9zwJrJUMFrFhgOGMCqP/05bZWGx/jw1R2GvPCKjOJX4znthbkD5Shtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604

On 12/11/2023 09:27, Alex Deucher wrote:
> On Mon, Dec 11, 2023 at 10:20 AM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 12/11/2023 08:47, Christian König wrote:
>>> Am 11.12.23 um 12:02 schrieb Hans de Goede:
>>>> Hi Wifi and AMDGPU maintainers,
>>>>
>>>> Here is a pull-request for the platform-drivers-x86 parts of:
>>>>
>>>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>>>
>>>>   From my pov the pdx86 bits are ready and the
>>>> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
>>>> the wifi-subsys resp. the amdgpu driver changes on top.
>>>
>>> The few comments I had for the amdgpu patches were addressed and I
>>> honestly don't have time to take a detailed look at the general framework.
>>>
>>> So perfectly fine to merge that stuff from my side. Alex or Mario might
>>> have some additional comments, but I think they will give their go as well.
>>
>> My feedback has been taken into account already, I'm happy with the
>> series now.
>>
>> I'm a bit confused how exactly the drm/amd patches get applied though.
>> Is it like this:
>> 1) immutable branch for platform-x86
>> 2) immutable branch for platform-x86 merged into wlan-next
>> 3) immutable branch for platform-x86 merged into drm-next?
>> 4) wlan-next and drm-next come together for 6.8
>>
>> Normally stuff from amd-staging-drm-next is put into the drm-next branch
>> and then merge through the drm.
>>
>> amd-staging-drm-next tracks a much older tree so I'm thinking merging
>> the immutable branch for platform-x86 won't work.
>>
>> Maybe the right answer is that the "immutable branch gets merged into
>> drm-next" and we just have some cherry-picks for all the commits into
>> amd-staging-drm-next so we can compile but Alex doesn't put them as part
>> of the next PR to drm-next.  When ASDN rebased to 6.8 or newer they
>> would drop off.
> 
> amd-staging-drm-next is just our development branch, the actual
> amdgpu-next branch is:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next
> I'll merge the platform branch there and then apply the amdgpu patches on top.
> For amd-staging-drm-next, we can just apply the whole set since that
> branch is just for development so there won't be any conflicts with
> upstream.
> 

Got it, thanks.

