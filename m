Return-Path: <linux-wireless+bounces-807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D1B8136B2
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 17:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67228B21767
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA160BB1;
	Thu, 14 Dec 2023 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RPkEGy3N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EC9136;
	Thu, 14 Dec 2023 08:47:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoAXg+ovyfFwLf+9clOa+7OCme6ubLCSrmx3SjVK3TZFQvJ1291rMijZG74hikZDW8R8JdwZqKlzZ0rTQOAnGE2gxSyYYDrPpMAvRgmY8U1wYlHVEN/xAQhhTJ4bzRXqSfS8twilbGE7nW7l1IojcY/gnKtBoor3xadyyAPbm93rEZjRmfIbZAdtEnMY4+ZCPoLy7UepkI/PtXmngKRIBR/GfCowQ4DenjW4oIxjryLyBrZVAdlRbqkGIg/Z6EazvQQGBVo7g6ucKS6qjDECz5Jje7btdyaAkkLh73586+AYXJRmN95G7qFpBITK75ts8DbDciHLtIhMDnGab6JuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unbF496iuVNkmRj5zLl3drLxqKoyDQQo2t/COEyPq7k=;
 b=VTrw87uMVfF3d21DG/8gCgMgQEGx/f4xW4KS15mNTUWVyu96oUfO0klW0p7Lk3SfkrrE20hNjctSqanHB9T5k7EkR5rtIKzSWRGR+ujgnCEpt7PD1+TRJSqbfEquMos+n+4oMKLu/AJljsSRk6jBj+6ubmtHgAySstlxCHaful8fyMyhDHci9Vs6zVlAAOZi0euK/TjiwyMmEwJfxycbWK2JM4Jt2Xe2K/V3J9yDOSWAzyy3y7khtXMDwmKBvOANQ08G9bEwuKJaA5SpWsxsGhFwUg3wFsCM7stayD1Vu29xqpdIdg4iVREjOkcM8fF5CWx5kkgTDcA7grvNoJNftw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unbF496iuVNkmRj5zLl3drLxqKoyDQQo2t/COEyPq7k=;
 b=RPkEGy3N9B3PylhLtnnwD+wssU9wrx6OhzpfnTD4quiACnLe3liUBZ4grH25L8TZLLQUrr/LaFt7qvwIWjvMBDBY0GU47UsggxL6YYMmpAFXCN6peBbbwx/aFJTcxRm0PNaM5GY6we0Z7bY3pQvV/lTlPJUJmtQ3p3sQQyY7ja4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.38; Thu, 14 Dec
 2023 16:47:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:47:03 +0000
Message-ID: <8bd60010-7534-4c22-9337-c4219946d8d6@amd.com>
Date: Thu, 14 Dec 2023 10:47:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <87le9w4u6v.fsf@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87le9w4u6v.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fc512d-4f37-4a13-6fd2-08dbfcc44c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eZ0iBQ1hq6xJv8cY/dHKe0jxnNFpXX33qN6Z5UpfuWX1hwlaFXdLwECJ/weQZ8gbmvRECF49hU1Pv+7lfWldrc+qzP2Uq7piI9+M4HH0ZaLQwuuZ3LlAatEevigA/aQLbgTKIQT4kyK9Go09qdUh/fFp3YpIUePDI8zWgg4+0NuxmW75NU/S3qawxHSuYnVgRHwBzQcmy+DwacCmto6MbSdDLbzcHnA6hOY0QEXqSFG7O6xLbzweEujbTYYv7zZ1QzTdJeHGVo+JprYq+rsoqszLNhia5IojXWnaH6vC/zxftgJqMy+8t7QFHCg5hO1v5hQ5PL5ekYRSiJ33Pyn06oIYe3FMkH+3UiGlGDccwud5qtt0fytTpDdVGDnp97U2sMk7qh1O4uMXH2pRoL58lKWI+3ODq3qjelgup53Xf6Q38S0ngNJKfPew+IrF2AZe2Sa9lotczLdC2pFElncUCZ32pzaDA+ZT25XC3wajSbqHyMBpaZ5eB1q6F7uNFXUaP4/c7xvVS/ElAQHdbDhuqYIFT2Y8Q/RwyYpSElhiTIml2K5XmVGJNu54P+GB4NWoq3ZTNez/X5toM7O5LUuyItMQqt9ne6RoZPz2fy/u2OPffUACc4jtYN3nxArAKyAa0/z7KtrAHvF8F76LYacvGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(83380400001)(41300700001)(2906002)(6486002)(478600001)(5660300002)(966005)(31696002)(53546011)(6506007)(6512007)(66556008)(66476007)(316002)(54906003)(66946007)(44832011)(110136005)(31686004)(36756003)(8676002)(8936002)(4326008)(2616005)(26005)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXNJVmNxSnl4V2FtYjR1cDBUaFRCaVV2N2hXVzhjU0dhSmRua2lTemtOa3NL?=
 =?utf-8?B?ZUViUmRRTXBOd0FIRGRJdjNCL0hxbWRGbldNYXZDT2E5a0M2czQrMnpDU1gx?=
 =?utf-8?B?dkVFWVNxVURVQ1hkdkJvTXdWeE5Dd2VoN1RPNmt0U0VUclZ2MDAvYmNkdHBt?=
 =?utf-8?B?MFJLVXN2Q3JieFYweXMrMzNTM0pyV3ZZcU5GamRHS0gwV0x1REJwY3Z5ZTBT?=
 =?utf-8?B?aVhaUFJIRDRiaXRQWGJWU0hTR0xWdGJvd1VyUGVlbDIwQ0NLRVR6Y0dMa2xE?=
 =?utf-8?B?M1liZXU3Y3plZEx6dGh4dWxQZUdlNzJTOTFGclUvaFFYdFY1U0xTaVRqZk05?=
 =?utf-8?B?NmJuR3hCNExXSUgreHpNdUVtZ3BSQmhUZlVXYmp1bTdWL3o2ZldBM04zSmJE?=
 =?utf-8?B?Wk5tMG9GRDdlK3VzMExIV2IwWjNJSXI0cS9IZEVnb3hvTkhxdHRFNmJYbmJp?=
 =?utf-8?B?SWlDRlpCb3k5S1RlYUlsR1FXZHN2cnVSTUZCeE1ib1dBWE03dlZrY0NoQXBj?=
 =?utf-8?B?Q00yNnhFRjVlemE2d01qS0FtK0h2T3pSZHFxclpWQkhJT2F6NlRBdkFTekpX?=
 =?utf-8?B?QmJDM0haY1ZiejYwc05TZjlWdUlaTUs1ak9WVjc1VkxoQVFjSDRtMlF4YitS?=
 =?utf-8?B?RlBwcld6VGhMcnlEY1MyQVRHWEhlVzNFR2o2RFByeGUwQnRYQkFRMVpFb1pS?=
 =?utf-8?B?cGFUZWdNY2I1d1creFAwVHJtYitrQzNRTFVzZS9yeFZpY0lFOHRhMU9yaGpL?=
 =?utf-8?B?Z3lqSnhnTWtrSlBWUzdGRlV0M0NkYk9kSTZ3dUQ3N1d4UnFCTGZVOVhYYUFw?=
 =?utf-8?B?SFU4UktiaWI4Yk05MlhRMmdnYm5FaHpTYXA0RWdLZ2owQ1hCZEhsS3FoZFJS?=
 =?utf-8?B?blBYVjFNbEYzaGJoVFlpZFliYmJ0U1BMRVg1UmhDZ2tqTXB0WnFoTko2aWRJ?=
 =?utf-8?B?NXZpM0RERDVxNmpaWmRMUCtHcjcyR0l1UjVzejlXUG4zYjZpS3lId2xOMm53?=
 =?utf-8?B?V0REbkF6QW96bUtFV1NxUGgzcStpT09CUDNBZ2FHZXNXTFNJdkN5UGQ5QTlp?=
 =?utf-8?B?by9iRmthMFZZcXVQL3JSSDFtYzJqSVcrZ1pOVFZJZUZFTjd5YnMzVjJNRDlU?=
 =?utf-8?B?b2JGSVpNbGFSNzhNSTAvZDVMVndHb2Z4aC9HU0dCNXpnYk95d0tUd3NzWktN?=
 =?utf-8?B?bkx3NTl6ZGptcWhKeEM4VzB3cTQyVVBUZVFqUWxNUWVIaGZZay9DUTZlYVRr?=
 =?utf-8?B?emgxd3dQUThTSng3UXhvSHNCaHdqZEpPOEJ4RnMvZ3pkQTFJT1MwKzllNEhi?=
 =?utf-8?B?eEcyallWOU8xUWR4MzZicnJueVFNa2ZiS0Y1T0M0b1gvb2hMeHc1ZVozRW5U?=
 =?utf-8?B?ZnZ0Ym9mVWpZVWV4YlZ4bVlUajE5cTlrZ1Y3QkIraGg3ZTBac2ZrQjJ1cjl1?=
 =?utf-8?B?bm43SC9JQWM2eHBVMjl0bGZDd09pTzN2bFZwYjU2QVR4M3RRNERXL3AwWURB?=
 =?utf-8?B?NXBqdDM5R2Myd09HbzlxNkljUFBCd3dNaGNESnV5YUsyVnhkN0dBay9ZVDVI?=
 =?utf-8?B?OGQrRWR0SHpsOHRhZHVMRzF0clcyUUI3Rkhzb2swaUNhVlpCWFdUbW56VWov?=
 =?utf-8?B?T3RuT0RmQkFMQmJweDBjUHVBa0VXMnVGeWlBdm90dVppdGpPcVpxQXhkQkJp?=
 =?utf-8?B?TWJhSWFwait2K2ZqMnJZMzUvTHUybXYwYWxWN3hYdE9DRTRtNjJ6cnpZT25E?=
 =?utf-8?B?SmgxRFpLU2taMXI1WWllNGdQVkJvSnR2OGJKZmh1V3JzZDJnMExpejdFYnlq?=
 =?utf-8?B?UUdWcE5GcVZBT0JJV0xET1ZwZEFhbnBxVHFrLzhCMDFueGFKQUdKZkVrTW9L?=
 =?utf-8?B?MC9pNmxRb3Vzb0hTNW0xcWVLMjF4OVVKQWs4REhocGR6alhWblRlMG95bnph?=
 =?utf-8?B?MVFUaGp5dnNsTWQ3QU1zaUZqMnNEL3ZpcE1DZ0xOK3RtK1pweU5xYTJiRXlV?=
 =?utf-8?B?YVA1TlIyZkN3ZVRaOWtQbVFjNEVMRTBkZnMyemYwZFJhaXBDd2pKS1RPM0Fu?=
 =?utf-8?B?RlkyRTJaamNPOUN3MVhFTVd3eG1aL1BITU1KOHNuOU9LTWFBSFZVLzZGUStO?=
 =?utf-8?Q?CytBNPgdT4jturK/mdWQuFoO3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fc512d-4f37-4a13-6fd2-08dbfcc44c8a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:47:03.2496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUz0KCp9qg5AGLpJrv6syNTOq2NdBCyDlN0o1nSTQNIwZTa27T8aI4mifSIzemTOsiQjb6YgcOx/2C6mjzCaQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

On 12/14/2023 10:36, Kalle Valo wrote:
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> Hi Wifi and AMDGPU maintainers,
>>
>> Here is a pull-request for the platform-drivers-x86 parts of:
>>
>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>
>>  From my pov the pdx86 bits are ready and the
>> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
>> the wifi-subsys resp. the amdgpu driver changes on top.
>>
>> This only adds kernel internal API, so if in the future the API needs work that can be done.
>>
>> I've not merged this branch into pdx86/for-next yet, since I see
>> little use in merging it without any users. I'll merge it once either
>> the wifi or amdgpu changes are also merged (and if some blocking
>> issues get identified before either are merged I can prepare a new
>> pull-request fixing the issues).
> 
> I was testing latest wireless-testing with ath11k and noticed this:
> 
> [  370.796884] ath11k_pci 0000:06:00.0: WBRF is not supported
> 
> I think that's just spam and not really necessary. Could someone remove
> that or change to a debug message, please?
> 

Do you have dynamic debug turned up perhaps?  It's already supposed to 
be a dbg message.

+	dev_dbg(dev, "WBRF is %s supported\n",
+		local->wbrf_supported ? "" : "not");

