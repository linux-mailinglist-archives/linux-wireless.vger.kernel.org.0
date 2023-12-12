Return-Path: <linux-wireless+bounces-705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F5A80F20E
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 17:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273841F2158F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD9977657;
	Tue, 12 Dec 2023 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CSJ8ehYD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3A8DC;
	Tue, 12 Dec 2023 08:12:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BiMrkw2o61ZJrT/D+6k4mK4/TVNOh3D04WI0ICF+0K/V3DOj12d1uKDLWiw8WYjkzcUQ2+fqWbVZYyxyk+UG2IA83XZLY5p0bOx6xeyEEQLSALt4iyOOxbiMzzR6/powhBkMQgEEiU9x/jImgEGdqW8ze4EGs3yUQW61tQuThAjV11oz3jyqjucrJZUUJVzww6D6k58ZHW2dEKMnVD1kUYxZds14RJ2d+IlIw0Kj37Qz7LKiBlIQfy3lrPjMXSKjIKqn0zVbAMBjsld5BkKLE3lT3/yTxDsNSa0KMm+LLKzDxEJ9i/8id9jaJtcjgW0AZ9NZgsGABAC3wiTJn7Tp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkP0vSLU86tMe5FwbFcWr7Escc64hqZeemtPdJSXSAg=;
 b=OcZGKMYjJF7nETr4/NNqRb32H/ep6kFji4lfK7OES5aDbgJcn7hMhtui9trOaie3esGVv5FXOUVRNkSbSY4lUAPzCRz4ENfyKNNwvChaJ2/N4dmNX2AlNJKOEmqs6CpWFLM0ntrtkxJ41q08U2WQRfvcRAcQVm4+mT5eM29KHQMM/YjXI8CGG6yDhq7ZrpTjYH7E/27+lweAFq0Gt4/8iNTn48VTj5aYCkp+4M44SBls2X3JAcXM2kYzJiXwqCJKA41r7aNQmp85EwlOtSTWijFAZDvNrcXK530U8/M0JGBylF2hJfQai0D+VW5Fz3c4paTKdR5tx9AnSCqh33GZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkP0vSLU86tMe5FwbFcWr7Escc64hqZeemtPdJSXSAg=;
 b=CSJ8ehYDAHBLjDI1FIB5knhAhcb2G4fEP2FSBeBIF2XN3l9w6Ebh30dJmiNBrOWp3/Q7N2ruUWGUrkaZxeHq/ayRSC4mI62sxLCfltSCK341CMxmkTBx9pm7R2YxPZoYRbDMD4xRZtSBQy3JlSChdgnWDDVKjAylPwXzuQ8SBwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4517.namprd12.prod.outlook.com (2603:10b6:208:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:12:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:12:56 +0000
Message-ID: <c4dc3d03-5241-4b2b-b0ff-6517f063ba29@amd.com>
Date: Tue, 12 Dec 2023 10:12:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <3a06ae67808800386117c90714637ef9a0267b37.camel@sipsolutions.net>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <3a06ae67808800386117c90714637ef9a0267b37.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR14CA0049.namprd14.prod.outlook.com
 (2603:10b6:5:18f::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN2PR12MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 141f3901-5cc5-422c-2f92-08dbfb2d33dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbkZie4wQK2us6JO2qI0QiOyfYtVQB0mcIKH3zwG86heGsrntYdwrMcYCHvo4ECKyPU2Sy7Qfu8XSrhheolw2dKrs0XvKRitIDm5YUDftSTL3FpTUzwRcYFXhA4Lwumk52CkqQNdf1alkZo7c97f7SI8vciffZZ38JzHte1fIi2EKJ8WRAtwDxJhv2yHorLVZFHa2AlbcertT9sICNd93mpM7rXsY89K3Ch0ZzqpMkCrDRrWugUVcbgHmhBErM0p3ZWw3rf2dbXT0AWGLsBs6vS0MdtKuVwdG3qz46QlcKT3Jde4ni86cmD+FeoiHvMF6ozsoC9Ap33n0HzHp9xJvxktqpHsaKOzqq0AlEkGlYq1qOwfpV9EXFFMkCRulbiKn3emBuB1+lLnIwClsjj4Iv2hLXUTv8s6sVlfsDYkCx/ED4EUwbOBUEnwjQgD6szeU0wd4vJNbPGXjtVZeOPopMdd6Ad5By2rc0Dyctwwf0bZhwsBcl+kVp8ATN9eMWE9Umaaw8eGhHGpRSqavPNAbA2gvSW65wUEZ7cji6uYY2ul5ZAzCUkHTdvoBGNOaGjDXUCAYkUNQ1GId1LhVfqPUErx3bUyCeE9ffe94iVCUv45rK6f3trX+xGNGOfH3nH0E2WqmYuqQTTbRxTNPVLVwQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(38100700002)(2906002)(4001150100001)(5660300002)(44832011)(316002)(4326008)(8936002)(8676002)(66946007)(66476007)(66556008)(54906003)(2616005)(31696002)(6512007)(110136005)(86362001)(36756003)(83380400001)(6486002)(966005)(478600001)(6666004)(6506007)(26005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXJLVXk2cm84M0tLMSszYjZuR2xoMWFseUdVeVExd2JPenIvUWg5NzBFVVNw?=
 =?utf-8?B?cFlHY3p1RktobTUramdrakZpQkZtWDd1VElSOUlDMjExUktVYjRCcVFqTTJz?=
 =?utf-8?B?VmwzVHE0TDF6cFE4NWRab0kxZWNBYTF4aXV5dFJFVjB5RzlSeEo2dElHTXQx?=
 =?utf-8?B?U0VNQ0kzWGFmY2MyeDhuZXovSjB2QUdKNXhoQ3JUS1AxS2JKTUczNUhyaXRP?=
 =?utf-8?B?OE9OdjJXa3hGbEwvb2ZCWSthSkdRaFdTVEdESG9oSTRrNTlyZ2U5SlYrL0xJ?=
 =?utf-8?B?T3hnU3VIS3RYTWJYeENFZ0lLMGxHa0N4M1pGaHNTOUtJL2hmeHIwSFJkN2pH?=
 =?utf-8?B?cjhTZisvMndabVRKcG44UW1FNDhLd1BQdzhjYVl1eThTWE9rMWVHMXhkWktm?=
 =?utf-8?B?bHFKanczT1p1bDNZTzdvdm1KTU13RHlWZlZyN0xVMFhvNk1OalpvZjI4bytT?=
 =?utf-8?B?MzJmR3p0QnNMd0h3OWFqOFBWb3ZzWEVUWjd5TUpZeStacDZxZzV4QlFvTmNU?=
 =?utf-8?B?SXFxOGRleUhqME8xd3I1YlZPejlDanFqZ216QUlZN08zSndyYjBydWtiY0NE?=
 =?utf-8?B?Mk0yUktxZmgwWEp4RmlHU1JsdHBQMzdxZEgvdWpkK291d2p0cWZ6R0t3djQ4?=
 =?utf-8?B?Zmh2MDR6VldVRy9admJzN1EzQ2NWUU43ZW9PK0RSRzJQS3pQOVZJbkFaYnFy?=
 =?utf-8?B?bkU2eUZEMndVQ2oyK2FnMHJ5c1ZIcjFwekJmUnVMWU5MRUZza3pJS3NtUUl1?=
 =?utf-8?B?VVlvenlzQkZhUVBDWC9Uc2NweW04aFJXTnZyZHVxb2lkWjU2M3hkNDZNZHRY?=
 =?utf-8?B?N0RsQ2xzQUpweFplM01ncjc3Zmh3eERmbklZRlh2elpBUWlGdDY4V29La3Fp?=
 =?utf-8?B?UzM0OEJDV1liVHJFazdUa2NTWjhjM1A3Zm5xWVZlbWJCUk84VGE2TllrWDNn?=
 =?utf-8?B?SytBOCtreG9QdmxhU3kySEpYQUlMeFpOd1lKc3VGUUxsMURkbFVyK2hPaDBP?=
 =?utf-8?B?aDhQcFNKWjh5ZW51Q3NHSnhFSWl4M21aMmhtbElQek11L09EbDNkZ3Z5YjI0?=
 =?utf-8?B?anFCbGpMemZqdFViRVR3WjFuL1dJbFlqS2M4dU9pMEhOZ1d0ejRycnpDanFC?=
 =?utf-8?B?d3lJbkxqNHFMMTBOZVVHOWxIdmtPVEp4YXgzQkd6S0lSandxREdJdU1YQU5K?=
 =?utf-8?B?YWV2SWF5ZGxrSDJNMDFIcWpqYWZoVitTUmhBUDgwS3R2OU8wZ2N3cEVRK0Ru?=
 =?utf-8?B?aHdkR2xxTzFLNjZwRjIvNEtiT0dycFVxMnh6c2pUY3FYNjI2ZU9VSGlTMjVa?=
 =?utf-8?B?ZTRmRnRSNHQwc3hWL1dLYXV2Q09qWmFBMXlJcUxDOFEyYzZrdHY0eXlONitP?=
 =?utf-8?B?NmZJdVU2NTRxMWdPYjlEOW0xdDh0SWhHMnNoR1FwcHRtRlBXaGJ4aXByVWRn?=
 =?utf-8?B?cEkzbXNrK3QvSndhUUdPRHV0NjRqV2lLK05YQUdEYlo2UlRuME9OdnJxbk5n?=
 =?utf-8?B?NER5SDdGYS93cWp6M1oydlpQY2hLMlVVTHdhSkFCTy9pdzRZSmlIQ2I3NkpK?=
 =?utf-8?B?VklLRzBsc015WUtBSUlyVXA3SUcwVHVnbUV3bWEwcG1sM2dMTEtVTkdZMGFU?=
 =?utf-8?B?enZBRmxMc1NTWUpHRmM4TlRPMDRUbTBEeU1ZeGdtWUUyS2VqY1d6VnE0VVBM?=
 =?utf-8?B?eUI1U3AvNjJJUTJjWVJJakc1ZkFtV1NzVjdEbklFakJrcVc1eng3MjdRWXVC?=
 =?utf-8?B?dzhMRnowbG50YzBoWjdIenV6UFhBNHVUQ3d6RW5SVko4Q2Z2cUJhenhsdzJl?=
 =?utf-8?B?Y3Vyd3pGMWg1SEViMS84bjJReFhkVGVxbFNVZCtXTklPQmY1YU53dmxITVBy?=
 =?utf-8?B?djhrNVJRczBiZVNCZDRlb0o1N2FJbkFBMlJWQ0pVRVlDMkxLSVFWMnE1NE1P?=
 =?utf-8?B?MnpnOGNiL0lFUEFLaFhNUGxoRE5mNG94dmpwektndi8yZGRtMEFLdlM4UHNK?=
 =?utf-8?B?MDI5N0pNVHRTekFSNHNlaEdteDVCM2RnUzUycU1yOEdqa1BhWk5HMmtCMEhR?=
 =?utf-8?B?bTNIRlBLVU1KcWYvZ3UwNnlmeXVXOGg5YlNBUDFxaW1Od0ZTdDNpKzRMendn?=
 =?utf-8?Q?Zq7ZPNhkrdGLA9zd36MgZxjIc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 141f3901-5cc5-422c-2f92-08dbfb2d33dc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:12:56.6494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pRgMe33UWW0B0QHzu+CrjKhYMJ6Oa+YnaldVIvyK93hrOOwfc/8lRYjoYtNAYyzKdcb4/vwkTbm+YJYRde0IoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4517

On 12/12/2023 03:46, Johannes Berg wrote:
> On Mon, 2023-12-11 at 12:02 +0100, Hans de Goede wrote:
>> Hi Wifi and AMDGPU maintainers,
>>
>> Here is a pull-request for the platform-drivers-x86 parts of:
>>
>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>
>>  From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu driver changes on top.
>>
>> This only adds kernel internal API, so if in the future the API needs work that can be done.
> 
> OK, thanks! I've pulled this into wireless-next, and applied the two
> wireless related patches on top.
> 
> I guess if AMDGPU does the same, it will combine nicely in 6.8.
> 
> johannes

Yup, I've pulled the whole series into amd-staging-drm-next for now and 
I expect as long as we have no problems with it reported under our 
testing Alex or Christian will do the same include drm/amd portions of 
it in an upcoming drm-next pull request.

Thanks!

