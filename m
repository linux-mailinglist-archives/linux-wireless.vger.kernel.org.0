Return-Path: <linux-wireless+bounces-666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AED80CEF0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 16:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE911F2198A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB04A98B;
	Mon, 11 Dec 2023 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KTXceBIp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494B0AB;
	Mon, 11 Dec 2023 07:03:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn+jGfKSO/EzQ9DFnro1NcvZIwBLPT+P1iz5fg4hWlv9uA663heL5O4O83Xa1VNsW+pOJn7VH9K4XJgKBlwhsNubNFSRI2oHlsYM4d/6R3th/cMkGCHBfOaHAYesSR/dT68W+5B/Ches3lxzQ6Wi3xgPiIb0+L0UjdjIXDrc9pkS6vh4pLS121ZH9xsg2LbBh5J/qAWBR4k0Fpowe4eSlE2wDrhWUjQCp/9gRE8I2glGV6WdwM7hSWUulyplVK4HfWhrXpIPtfRsnjMec2vhC/8FGBkx7HlQQSpiy3HjKqtMZ9DX/MpOxSkVGJ41/mfLHr3vz0kUY/dv4EvGBnNgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pzpt8XwdcgPgvdQUM/8dS7G3qQZZeiCyB/ZiWWtzXKY=;
 b=i7b/vcU/O1RgLgOe98rqZ9xRXmCtHy5JH1+r/BSi1y4v85bmyHwdAFz3padUYw3ShL11wHQZlMJ73hwi7qJFE+/Axfaf+Sh6iVDlTJ0sLABJG7LmkjeMl9kc/E6NtF2llUiPi0C97rK6SXY1o0IU9aEc3QszRQrcjEgpdDstNKK4gY+VDCp8YxFHSTrZCVlGylOzT2y6jH0kFCiQga7/GeUtdVYvCuq+xPKCXENGpKZb3mGqJYrWAoNT866VKhJs9sGy6fYy/ZbTFGTC5n4FqQ+SDsuAO0YihGixHf4GEDgbD54Yd5fzo7axWbo13iQPi9isuEVbYZW1Ghc6r3pnBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pzpt8XwdcgPgvdQUM/8dS7G3qQZZeiCyB/ZiWWtzXKY=;
 b=KTXceBIpydLLxGEYoVm1pS8BMOmG8/aZ7ndE9cwve+nYyLnWzsrQbO3dl95r4SZF1HCW6jqSUQyujWlv3XGEyFMu1F+ZjYdkmf5Yh1K/+kuSQpM21/HCjU6m6ULuNP5dQf/HTCb6RSY2Adtb7btRVMO9ZjU7fKaHVwqaExkpxZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4526.namprd12.prod.outlook.com (2603:10b6:806:98::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:03:05 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.033; Mon, 11 Dec 2023
 15:03:05 +0000
Message-ID: <23850b71-f530-4094-81cc-26cd762dc231@amd.com>
Date: Mon, 11 Dec 2023 09:03:02 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b2a4dfa9-e3ec-4c90-bb53-f2e6c70603b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:805:de::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4526:EE_
X-MS-Office365-Filtering-Correlation-Id: 64425070-b265-4b43-20ab-08dbfa5a4747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+yLdDQjUmnsNqumqq1PmyVltY5v/uF8Xg0UUThzdpc+YXyZhn6LP6L9HhpYyhcSln5N2jqqXzyUrf6pwOTGWV+QaTfcX9+LOGPh9ehoDnhP3RXHORIaXQ+WSRQi7wcu5iq7rTlXK19IEYnYOJjWmz4e/sj6zcgPUcB0AWkmeP5SlJ6xVsOG9XKZsJdvYyF76x6LvvcG819jNu6tQMnL+m1wNfatsusvWPMTeUCj6VYM3vlg++tHMINoX9g9wes9uwObo6s5YwbFS3+pj9+o83tyVXONU26Sw+4M9WrUBfhmgKFuZ/LPV+xGi3nWf5E9QTCPWbvCTx4T9MMDqEsJZKZtttBDVilnCIe+/lYA6h/+GhRs8BZsd/1pHfbZDDzCBXAHLQZ75YImyD3IEzKEIUYLO4dbgn7diaLKw7Tn1vn2W0dsz1gfFngyoTBP160707dPfpn6AKkZR3sCtvG1oV05T6iZrSsVtb83E1ccAvfAfK9pTW6EAg1BeR5KZGwDoMn3dbQpd7inVBCeyai42BqQ2uKaKnwi4YCW9qi9lY43cI9kIjoYngj3VSxID1rJUPvHF2seopvSiFqjz+0V0rHH6K9okU02hpZzpmBSUT7sWVLcWnzPn5NLuX49TFbXMfvjqTyrBH7q/4vXlOxhbIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(66574015)(26005)(2616005)(83380400001)(36756003)(86362001)(31696002)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(4001150100001)(6666004)(6512007)(6506007)(53546011)(44832011)(66476007)(54906003)(66556008)(66946007)(478600001)(6486002)(966005)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWRtNy81SUdjYlBxTmpzajdidUhnVEg5dXk1Tks5bVZDSDE4VGg0QkpLTEFF?=
 =?utf-8?B?dTZHWlgxa1gxeHJqNEJDSHZGYWkwdi9NUlpOcTlzVEVldzBwbUx6MTdZOGFk?=
 =?utf-8?B?dEZjUEprbkZZdnBDSGVjNXllbTY4UWtxbmcvV2pkRGNVMG1YQ3d6WTJTdk5O?=
 =?utf-8?B?MHZxd1c3SGRmSjdWY2FlR3JDRlVIb3VvNG9ER0xGeVJ1WlBPMm9jTnREM290?=
 =?utf-8?B?VFV2aC9FcENuWVgzZnQ4cjdraGpPSEtqRmsxcFlkaHFUQmxGWHl6Umg1Z25H?=
 =?utf-8?B?bVA4bkxoWnZjdlRZcnB3aXRDYmdmNE8yRzREZDh1MkxsVjZEVjlpY3lLV28r?=
 =?utf-8?B?ZWpQQ3pJbm1GSkFXNWVFQ1pqWjR2bHRORzBDcE02Qy9wL3k4eENjUGZQZlpX?=
 =?utf-8?B?NHBYdXNZSFZOdXBrZENHTmRTTjIzWGJSaVQ0Y2g5OWxiRjBVdjhMNmNiVHFo?=
 =?utf-8?B?VzVObE9MZWVhd1g1cVVUUnVadmZkUnYwK2h0NEZPOXI0UThCdGhnT0ZOa3p1?=
 =?utf-8?B?NlFFTHFsSkhlOU9naS9CT1hwbGg2em1lTDlqWngxbFd4T1J4TG1QL1JLVnU3?=
 =?utf-8?B?cjBhdEZCQmdiWWQwUEpQckZtVDB0OHl2LzlDbXM2ZUQwekNHaHF4RUV5SlpZ?=
 =?utf-8?B?MjloRFl1SzYvRGVDNURpQ083dWY3akRNcGFNMGlXaHZNVGRqVU9oU3Ftdk85?=
 =?utf-8?B?R0c1NVp6cjQ1OUN5V1FwTHNKYVNEUGtoU2VoZERIQXdUWGJMbjJ6VEJwQXdJ?=
 =?utf-8?B?RlFSZXVhZ0VZeFBmdXdIQnR5ZHlZUlVoQ2hPbWJaWGsxUUkwMFhRa2VQWUNB?=
 =?utf-8?B?ZXlNa1hQajJMWlJ6ZmRldUhCbnpYdzFMaFRlM1lsKzFkRTdidit0eFZwbGNH?=
 =?utf-8?B?UDh3WE5oL3h4NWhBQVFhM3kvVFBFdThKUVF3akxsTjJldDBGOElHOERWeHMx?=
 =?utf-8?B?cnJLck1UNUNBTkdabGhxZG1SMVEzeVI4SWNuWnhLV3hsVTlodU1ldUJWTjE2?=
 =?utf-8?B?ZjNob0VBbFg5M0xIV1BrWnYwaDdySW9tOXVobmYvcG9MTy83SVlEUysyanl5?=
 =?utf-8?B?Lys5c0dJb0h3RWp2WUNWb0VZVGZCT3A0M05aUVo0aVp0Ukk2UzlwVjNhUldq?=
 =?utf-8?B?ZjJncVZyRitsNDJhL2cwdnhIUmlnMmk4OHA2TXgwUnRGL3d0QTBIL2ZHWmt4?=
 =?utf-8?B?L1NiNU1HQ2F6K2xSVFpaMjZYR2kwb281ODIyS0NDTmE1WkhuQlB2UFN3Vjkr?=
 =?utf-8?B?dzRtRkRZdzdONWdrcXVHelROTDR1bWRueTE3dEZBY0tuR0M5SzdpWGluRFgy?=
 =?utf-8?B?WjBSOGtxYzN4dEM3ZzljTllIYTBzbVVycXRyTGc5TytxaEo3eVlXS2xvVkRv?=
 =?utf-8?B?VVJVWVZORFVhWXIwbEZadzZPRmx3WFdRUWMwbmNTZ2F5S0dIbDljOWxRQkI5?=
 =?utf-8?B?aFd3Nmp3T29QR0RsOTRLVjFQMTg2M0l0UVBrTVFaRVVySjdJZWNtRlQwOFpM?=
 =?utf-8?B?eGZYd2wza0ZYU0xUY25NL2duQnM0dTI1NzlFblJqbnptYjFPakltM0NTb2hG?=
 =?utf-8?B?d2R6Nm95WWViRlVpZGpYKzJkelUxcnYvR1cvb2FJUmh3bkJxVlVYRGovODM1?=
 =?utf-8?B?U2lUbWZXSWN1RWdaY1hSK2NUeXRTZXUzWm5uNU56NkVTdy95SVRHQzU3Q1E5?=
 =?utf-8?B?YVROblJXS2NqaHJ3cVFEM0lsVzZZc0tLQzA0UjQ1QWpueWhxQ0pWUFhNek5N?=
 =?utf-8?B?TURIRVNDd0pGK240SDNvckZUUXlCaDZ1Umx4WkJtZUp1aDBvWkhyVHB5Zmlx?=
 =?utf-8?B?cGFuSEczQmR5Vmk2WVB5Nm5ydUtDeXRlM2d2c3VjZUo5aGYyOFFMNWxsM21n?=
 =?utf-8?B?Rnd6NXdiQVpJV2RrSFJ0aEVHdGxRVlBraEpyZ043Vmc2Q05oZW9vU29ubUVN?=
 =?utf-8?B?WUdQMXV3TjFJT0hxVk9yRlQvTFhEaTdvSVYxaEtOaTRMUVNWN1JPcForYnR3?=
 =?utf-8?B?RlpVcG9PNmR4d0oxYXFDbWpMRUJVTVlVUG93aWlxSFI1UC9Hb1FTRVpvaEti?=
 =?utf-8?B?SW1LeUtGVStoVTNldEtFR1o4L0dNQ1dVdEoxQmcyZDZYa08vZ3FvU09kM1dL?=
 =?utf-8?Q?tF2ZFPMzSoCDc2ymBepPc1XHY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64425070-b265-4b43-20ab-08dbfa5a4747
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:03:05.4744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE6DOe2cY0iQ7CJg3Xj0AFMnohVetALwsx81wTRnbDczvhfBPQditlGdqH9toWx1zkdlfu0yc5HqbvaSOodT0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4526

On 12/11/2023 08:47, Christian König wrote:
> Am 11.12.23 um 12:02 schrieb Hans de Goede:
>> Hi Wifi and AMDGPU maintainers,
>>
>> Here is a pull-request for the platform-drivers-x86 parts of:
>>
>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>
>>  From my pov the pdx86 bits are ready and the 
>> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge 
>> the wifi-subsys resp. the amdgpu driver changes on top.
> 
> The few comments I had for the amdgpu patches were addressed and I 
> honestly don't have time to take a detailed look at the general framework.
> 
> So perfectly fine to merge that stuff from my side. Alex or Mario might 
> have some additional comments, but I think they will give their go as well.

My feedback has been taken into account already, I'm happy with the 
series now.

I'm a bit confused how exactly the drm/amd patches get applied though.
Is it like this:
1) immutable branch for platform-x86
2) immutable branch for platform-x86 merged into wlan-next
3) immutable branch for platform-x86 merged into drm-next?
4) wlan-next and drm-next come together for 6.8

Normally stuff from amd-staging-drm-next is put into the drm-next branch 
and then merge through the drm.

amd-staging-drm-next tracks a much older tree so I'm thinking merging 
the immutable branch for platform-x86 won't work.

Maybe the right answer is that the "immutable branch gets merged into 
drm-next" and we just have some cherry-picks for all the commits into 
amd-staging-drm-next so we can compile but Alex doesn't put them as part 
of the next PR to drm-next.  When ASDN rebased to 6.8 or newer they 
would drop off.

> 
> Regards,
> Christian.
> 
>>
>> This only adds kernel internal API, so if in the future the API needs 
>> work that can be done.
>>
>> I've not merged this branch into pdx86/for-next yet, since I see 
>> little use in merging it without any users. I'll merge it once either 
>> the wifi or amdgpu changes are also merged
>> (and if some blocking issues get identified before either are merged I 
>> can prepare a new pull-request fixing the issues).
>>
>> Regards,
>>
>> Hans
>>
>>
>>
>> The following changes since commit 
>> b85ea95d086471afb4ad062012a4d73cd328fa86:
>>
>>    Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
>>
>> are available in the Git repository at:
>>
>>    
>> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-amd-wbrf-v6.8-1
>>
>> for you to fetch changes up to 58e82a62669da52e688f4a8b89922c1839bf1001:
>>
>>    platform/x86/amd: Add support for AMD ACPI based Wifi band RFI 
>> mitigation feature (2023-12-11 11:33:44 +0100)
>>
>> ----------------------------------------------------------------
>> Immutable branch between pdx86 amd wbrf branch and wifi / amdgpu due 
>> for the v6.8 merge window
>>
>> platform-drivers-x86-amd-wbrf-v6.8-1: v6.7-rc1 + AMD WBRF support
>> for merging into the wifi subsys and amdgpu driver for 6.8.
>>
>> ----------------------------------------------------------------
>> Ma Jun (2):
>>        Documentation/driver-api: Add document about WBRF mechanism
>>        platform/x86/amd: Add support for AMD ACPI based Wifi band RFI 
>> mitigation feature
>>
>>   Documentation/driver-api/index.rst |   1 +
>>   Documentation/driver-api/wbrf.rst  |  78 +++++++++
>>   drivers/platform/x86/amd/Kconfig   |  14 ++
>>   drivers/platform/x86/amd/Makefile  |   1 +
>>   drivers/platform/x86/amd/wbrf.c    | 317 
>> +++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi_amd_wbrf.h      |  91 +++++++++++
>>   6 files changed, 502 insertions(+)
>>   create mode 100644 Documentation/driver-api/wbrf.rst
>>   create mode 100644 drivers/platform/x86/amd/wbrf.c
>>   create mode 100644 include/linux/acpi_amd_wbrf.h
>>
> 


