Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FB97EE59B
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 17:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjKPQ7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 11:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKPQ7O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 11:59:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C42D49
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 08:59:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDyF/Ny131sSaz8ICYHbakheiIH7gnLG9kAhnU0x6e8+tgRJee/5u+uDS3slpLikUXtKFJh/6kv7R+58RIOldrvk4gihXz42JUm241zzakW/vTDA6eNpYAVHCtB2fcIUm7HkjBW2kGXUyr+uVHcmvTc60rTNrjGw2q809C6mBn7iebLWZ8JnYrCnZToaoRMNdZUbsgegiMBaX6Cptsm64cpGCAzR5dmNZKlsn6QrMSZPa7WnraDwGvBklGRrCZl5x/YkBjjBpVS7lpSeplqp3BDXm5jFOBIoOwyNEpP49oXf9EwcguydLLOhnIuDegO8qwHdUU6csS13xmrPfjS6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KeQ4xTFDS3UElsxjOLU1tPbqFxlv5fH1gm04kJPeYy0=;
 b=jH74/ZB2tynSV5th0AgXlmRuvtRlUZmWceME62+yxutu1C6j3QiShnk2vI0+P8jPGw5jg0gPfAyElE/OrKLdCfyFEcimqIGrjSEop14euPHs6dJnyV55aeznv68urSo0MyqWSEZrfW+AI5K05+Wx4XkPzIXvuKZ7bqFTVsrcVn8UIoVwndeo+AK7/1eBFnts30E6P2DupQONSfDiTbRfKu8J/xr+oRoCjV8RII052OKJreGB2+2MmW0dfNs0ujrptzgBxKRklQp/+Zv8yhfDTGTU6Wi8BRqiWNYQ6dXb1wG//v0YLbXGftdFTgDCa60gSUvPsQNqNbmdDSbgcdBS6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KeQ4xTFDS3UElsxjOLU1tPbqFxlv5fH1gm04kJPeYy0=;
 b=5SrUtszZZ5tMt9tGeE0TGaynKvgfX2CDI+nUf0K2Py3Xfihn1PVpRSFVG2nRbTu0q7xS4y5HXtEjnA6MMW1qivlhDWVhJaJHKgn9p6+bgkow7/6RgeFYcC9QZ9shB2L3jXvuKJyeOKdUeCQtL2iZw4BJMxvtJ/d7SZpQcV1ZP2o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 16:59:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 16:59:07 +0000
Message-ID: <d02a862a-2bba-4169-8c14-e52e358c5dd2@amd.com>
Date:   Thu, 16 Nov 2023 10:59:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: iwlwifi firmware updates 2023-11-16-fixed
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <877cd7e05d187b48ec2615c7b4c1def200370eef.camel@intel.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <877cd7e05d187b48ec2615c7b4c1def200370eef.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR07CA0124.namprd07.prod.outlook.com
 (2603:10b6:5:330::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: cae53bce-06fb-4c44-828a-08dbe6c55852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bilExsifYCl1Rvni26oBkVg+asqYUES4CrNounFnHpqUz6hJLxKWRLRiCQNxIj4OnznUM92tVXN+tur9N7QT17NzToRqE7j/mk7ZEBr6NwYcwRF8yLU8QoVgq/iCfb8RzdMmSnoMWtzU/WoAIKk64Gw3+eKliINrDyYIr/vLLbf7zxSq3TYU9y8dX48leFImetPWu7eS1D1Z+tLvwztEvTU+kxnqCXV5PpPC7FK+qRICXhtfrjFmzV7aVbdrwjrFcva/3Kcl+k6z+kR3MT+24MWBx2REa+nJ1OLmOSK+lu2RD+lRfIUq21znKGt2VVJlXTs9ZsNWMkdoi6z/UGZ7tJ1waQkUbx2m/c9OGokFaaTHTyuyuoqIfBJPMV9uDJBwQlzLBy2SqxDb1X0x+oA/7iVeI94W4RSxmqZF80vrFM3iJPwAb5oB4MfBjFyUafd9xvAcI5BBGz48XhIOPpdoXzqzYhifXCCpxl68YcO2QKR0BS9nxbCLc4bjmEeSBYu1aZYq0KMVji8eg4AQbbwUI0QkZt6XpPBd7WC6ogNXxzrHbGH4O0tZ/FiVXfRUvYcICGgoEf8LR3D0xK3wJGhpmO2AyLVETIXn+dS+mz1WMfP3VYUhrl/SPKg4PC/BDjV0r7RNNxnoHHaASn33Il0z3Mx9oo3ZLMCkd595Jv3IBkg6HPOJ/TVQecnZ6kZH+9UG4X65YYmz7UOSnup895euQGSkO+pcCiWsQoUWXWglSPA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(36756003)(6506007)(26005)(6666004)(6512007)(53546011)(2616005)(83380400001)(478600001)(44832011)(5660300002)(8936002)(4326008)(8676002)(41300700001)(7416002)(966005)(2906002)(4001150100001)(6486002)(316002)(66476007)(110136005)(66556008)(54906003)(66946007)(31696002)(86362001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3ZibGc3MGZrQk1sQWhqcjJXM2Z3Q1pGTE03QUxaZjJ4eXJXazBWS2J3ZXdE?=
 =?utf-8?B?QldoSW9xUlhWT1pmSkk4QzV6d2lRZkNQN0xRcTNmKytNeDV1RzQzdHVON25V?=
 =?utf-8?B?cFNvNFRLQmo0eGQwcGIxdTA2cHlUUDVySmNXQzdWd3ZXblJ6SE1WNnlmQkU1?=
 =?utf-8?B?aGFwbGN0ci8rZ1dHblB3eG5sYUxlOTdHWEJ5KzgvaUNRTTJXcUNsMGpnV2py?=
 =?utf-8?B?ZFFvNDBtSDFSN1J3L0R6RU4yallNUlZKYno3b3UwVHZIYlMzQVpOTDFncW1W?=
 =?utf-8?B?TnRmdlQ5VGxSSnZidVFOMlFrYUlDZ0RUSTlLVjMwNnAvczdZbEphbk1abjNa?=
 =?utf-8?B?YXFaWlI5UjhsOWF5aXpqMURwcG84ei9iRVZ6TVlGbHgwTnhSS0xWdFpDVFVV?=
 =?utf-8?B?NkNtbTBzaUFuWlJJT2x3L1ROeVl5NjJneUZSWE95dHozdVFxVVE2MURJcmZy?=
 =?utf-8?B?OFhJcmpMNUQ1MEthVEk3UWg4YStJRk5iLzlWRjhEWTZrUUV6N1gxdHNFRXVy?=
 =?utf-8?B?dllOb3VxcjZpZXRkVjBMdG0yYzFaYjRSc1N2c0dZL0ZubzNieTFDYStMN2NB?=
 =?utf-8?B?aGFaVWJKNi9RL2pacHgwRTVRMktVT2tLc0tEckpDTkR3T2ZOOCtZMVRzSnYv?=
 =?utf-8?B?NFVXODJCTytLbHl2U0RGcm4xRkQ0amhnZER2NnBudU9BOTRGKzVva3BBMjN6?=
 =?utf-8?B?c25kTVBJUnBZQXh5SUFnQWx1MnhvRXE3QW5SM0JFVzdVNVhCd2lYYTVwKzln?=
 =?utf-8?B?R2JzL2tSMjRZQks3d2tkNE5CTHg3Q29PZVUzeG11QnhlZG1mV0pWa29QTFJn?=
 =?utf-8?B?bXZ3TllBaWU5MjQ0MVN6UGtRakVLQVpqL1BuOWI4VGY5WXkxZk81a3NNK2xl?=
 =?utf-8?B?Mit3TDVOMzhCL1JLZkFrV0VqZFVYTGFxcmpHbUk4TG16RnBnUDZvNTA0SFg5?=
 =?utf-8?B?OVBsQUQrZUdZSEFLNWZteEhVSm1veERhM0d2N1R0cER1ZnVTRFNJeGZ5UW5F?=
 =?utf-8?B?c3hlT1lFU05VUmZKZUhQWEVTeEFza3ZBMUMvaW01MFFMdnZBRU9lLzMvb1F1?=
 =?utf-8?B?UW00QlZnV3d6ek9vU3VRWmRsMDFETFA1Q29saU1OVUpjTVNOREV2QWFFNWk2?=
 =?utf-8?B?dGpsaTRHWnppUWNKL2s4N3Y1di9IdVVHTWtjaEQ4S3BZdTM0OFlJS2JtV0xK?=
 =?utf-8?B?aW0vTzlhdFcraUdyb0hQUnNJcEROenRQTjlRMmNONzlIOEs1c3A4WitqcHdh?=
 =?utf-8?B?NENzd29GcW9nTDVta01Tdmo3UHg5dW55azZFc2VoYW4zTlF6K3lMNVFBdnNP?=
 =?utf-8?B?Q0IvZndsalErKzNQcnJicVUzTVlVeDJ6NjBxTnhwN1J5cW51dGx2S0hwUE80?=
 =?utf-8?B?eGxOdHlNaFpIRVVKZlQyZTY4VmV6WUp1Tk54UFZuUTFJN2JjL3llbVJtQWJq?=
 =?utf-8?B?MGZPeVFkTGNuMHVjd296bXN0YW1YZzlHRllmTkNRMSsrbHFBZ0hCaWMrVG5K?=
 =?utf-8?B?OS9CNmZsdHhTc2hQN2d6TXYxa3BHNCsxNG1hQzljaTJIZXh6bC9ybXNHK09B?=
 =?utf-8?B?ZFBBQnNCL2d0Q1NNZXRHeUJSamFZNXdtamltR0ZHbkwzdytMVTZBcDQwbjdL?=
 =?utf-8?B?Zmt5U3R1cjlFUlJFelZwT1UraW1kajNqazIzY2xCQUVjSXlaL2Z1QWpZYUZM?=
 =?utf-8?B?bzEvdW5WTGNRckJ6RjBZWDQ2QmVnQU5WWllKbXp3QXJsMWlNdXV1YTlKanhv?=
 =?utf-8?B?UDBrNWtHdFBZb2o3blhzaTRRd0piNmtDVkNOMzh6K2Q3QUkySFBPRmJkQ3Rr?=
 =?utf-8?B?d2Faa3FBeFI1ZngzL1p0QnU3UUt1UWxQajZEK2k1L0V3bUNvWGI0VFIyaDUy?=
 =?utf-8?B?aGFtV214VVcrNmtpT0F1MXBNN0t4WXZDUTVNaDRuVHhhUi9HaFl0bnlHblFO?=
 =?utf-8?B?RGFVUmhRV251VlBsUVJ4UUFmMVVOT0ExR1VRM1JYdnhsSDBzbEV4QWpQME1B?=
 =?utf-8?B?WEl3OXBicmVaV0pFdnFNQi9jMjRodTBGaWZScmh3TERvZytOaEdTMUtudUVD?=
 =?utf-8?B?UWxSWTVJTHNITTZEbHBjUHo1QnJ6R2I4MWhZRzhjODAxbkZzQ0VLMEE2RUVw?=
 =?utf-8?Q?qmubQ1LyIjzohWbfJ+svf3aIt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cae53bce-06fb-4c44-828a-08dbe6c55852
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:59:07.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HgnPGnAhJ6Swa17yRNYXvGw1PvOlENFYFhP3vQTARVj08BEcGaaRR3SSIzYO/vrp+PDXPXb6qpJnubxLLTzRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/2023 04:26, Greenman, Gregory wrote:
> Hi,
> 
> This contains a second fix for core83-55 firmware which had a signing issue.
> It should be working this time, sorry for the mess.
> 
> Please pull or let me know if there are any issues.
> 
> Thanks,
> Gregory
> 
> 
> The following changes since commit 124b66396ac7a6dce724d04ac7b3bcef1db1d551:
> 
>    Merge branch 'robot/pr-0-1700068965' into 'main' (2023-11-15 17:24:46 +0000)
> 
> are available in the Git repository at:
> 
>    http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2023-11-16-fixed
> 
> for you to fetch changes up to f27dec616e29e44cd90645926c1459639d112c3d:
> 
>    iwlwifi: fix for the new FWs from core83-55 release (2023-11-16 12:15:53 +0200)
> 
> ----------------------------------------------------------------
> Fixed firmware and PNVM signatures
> 
> ----------------------------------------------------------------
> Gregory Greenman (1):
>        iwlwifi: fix for the new FWs from core83-55 release
> 
>   iwlwifi-gl-c0-fm-c0-86.ucode  | Bin 1840116 -> 1840116 bytes
>   iwlwifi-gl-c0-fm-c0.pnvm      | Bin 226668 -> 226668 bytes
>   iwlwifi-ma-b0-gf-a0-86.ucode  | Bin 1695788 -> 1695788 bytes
>   iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55092 -> 55092 bytes
>   iwlwifi-ma-b0-gf4-a0-86.ucode | Bin 1670940 -> 1670940 bytes
>   iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27820 -> 27820 bytes
>   iwlwifi-ma-b0-hr-b0-86.ucode  | Bin 1520636 -> 1520636 bytes
>   iwlwifi-so-a0-gf-a0-86.ucode  | Bin 1679788 -> 1679788 bytes
>   iwlwifi-so-a0-gf-a0.pnvm      | Bin 55172 -> 55172 bytes
>   iwlwifi-so-a0-gf4-a0-86.ucode | Bin 1653836 -> 1653836 bytes
>   iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27860 -> 27860 bytes
>   iwlwifi-so-a0-hr-b0-86.ucode  | Bin 1507388 -> 1507388 bytes
>   iwlwifi-ty-a0-gf-a0-86.ucode  | Bin 1632464 -> 1632464 bytes
>   iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55020 -> 55020 bytes
>   14 files changed, 0 insertions(+), 0 deletions(-)

Hopefully pulled the right one in, the robot that scans the list got a 
bit confused by your multiple submissions.  Please check what got 
committed to ensure it worked.

If it got messed up, can you please resubmit one more time?

It's not strictly necessary but in the future it might be easier to do 
merge requests at 
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests to 
avoid multiple back and forth emails for mistakes.
