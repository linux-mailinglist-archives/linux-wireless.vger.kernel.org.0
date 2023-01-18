Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929E46722C7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jan 2023 17:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjARQQt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Jan 2023 11:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjARQQa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Jan 2023 11:16:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A149974
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674058320; x=1705594320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfti0KukJfeMBr/6frsH7cOafKOONnxWQw4ui1evbp8=;
  b=NXOjzWKSUwgg4HO0QygmY6jBzF8ctWW2oJOB2KhVhorYrliursdgbQtV
   V1+itId7lPOGnIPtAbMIqH6m1Y+4CB7ilES5ORx6MS0pCCee3uq9utq0G
   +uqoA7N2OUdQKsRvByRkvwlpPQjs+AFEQFXmz1p0kQoaky8AESzfbIyr1
   lQmO4XjhnKkJoYMt/gZe4ffUXBEHiS+COM3WgTDBFAgtjUakny6+c/TuU
   UWLvuUTL/keWeqXy9gPcBKPF/iCpm+CwLn+uy6OiKNt4vR7vcBOvfiB/Z
   umtDjN2I8Qeg/jHWAx9IPjvpw8/3NO7v6IRVZaC7tuJmipcmJ0jlYg/NI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322711182"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322711182"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 08:10:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="905157736"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="905157736"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2023 08:10:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:10:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 08:10:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 08:10:23 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 08:10:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li3yBu/sPkguvfbLnQE6ChXvO11/TA7ak8Myg5tqH+Ou5O6BFYCL2Anx7WrYVdEY9g+vIE98jTDGEqfkV4opnJzHMBLdkTftr30rCa6rA4CN8C+2PDHl8F+Vc9Nf3aExqE2OQleM3RsnR0Vx3FKHMQlUGC0BCH9bx4bPo2U8tqiM8Q0JNC5/1reBp4djqZqd+SNZNHpLdi4x7B7njLmcAvNvn7m0DAHbxSGUGKRPNtOKreyo2sx/jCridBWWXv/DMBgwk01Q8b3bIToDIOMUJvQAl5bqDUG89trbZOfuerNzUCLZU5ua3yN0zeev9BW3i0dl73yBOP7AsxZ9Kb9+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrrFXPERU+PGkRNEsH1m3n8z4DpbgNUGkoeXECG53J8=;
 b=X14RGLDS1VPDl2IA1rhlH9wjGDVkAcUivCnkgBKRYnh+nkH0r+vfb9qGNPkoKmHgUUBE1WYVhAoz6nHJ9N18tSmRLDSGUbVjBC/0cm7PU8ksZBcEiUuYqxv443ppNjXShtKK9xjl5bLrUcMBdIUpsUHj3H0nMonjFzJNIjOZQp4Ovnq2bLuh2lqe6+QBS89kRNvLiHcU7gZiVpa8VQ8bg4S5v3mbiLyctzJM2nhrvyUtjVswnJL+5q1JaLS+/sCsyOARIR3LJdG3yKHTOqU6H9xcorxLeTnpplUow72q308z535zuJcSuW0f/QX+OedsM4fK1JfC/jv7MqR/kKvpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB7769.namprd11.prod.outlook.com (2603:10b6:610:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 16:10:21 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::3ff6:ca60:f9fe:6934%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 16:10:21 +0000
Message-ID: <92209c00-7fcf-1592-e97c-f49e7734fdfc@intel.com>
Date:   Wed, 18 Jan 2023 17:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] bitfield: add FIELD_PREP_CONST()
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
References: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
In-Reply-To: <20230118142652.53f20593504b.Iaeea0aee77a6493d70e573b4aa55c91c00e01e4b@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: adffc524-9e7a-4dac-5fd7-08daf96e7f75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a54rQPnns5R+5dJqWdTtO4FtohFF/iG7q0v/wUXsCnSAm9YrKPDdBgb0ZOYtTlYvHaPClx8R20uaZceFi5ecxbPo6EQhC6yy2zpCJnDdgf/1vNtX8YPSfxdxkhcQNuzrf8ZhX+RufioX5qJ8J737GSeT3qDOI5laSuxUhFkmcmqgXjlM57T+dcWwr+ufQSW51PnF+vFAjbTuxNP5rLUBSo4Wfm0wmWbC6loJs/Qo8fvF/x71aMLZS7IvclC6NwzsEWsXlkOaKqS4xUYpIGoCt/kmGzNMkat8CZWA7NbhVGWwdPzMx/qO41VcuLSWF8xrvKz7p14x7UtgbOls69oZ5FA5cHL/mbyNrSnedw2+g1WRRyBt25GfPjFfPb0WYHQTT0DOWjmMmGF8VwHpVY6WOpWKXBgwJo0BwXWaLU5v1BRriQLnyXGeiFQPTHlY5+aGQwHR3W1K1G+mhTIOtNm9KQ5sig5EvKm5NWXbWoogmshu3buXFaaZaQX2fh+AC6cvmo3zKIOtBReTA+Af3ag+GGFWZQyLCAWjoKBwkyh0HyuVTLAstFA0jLqeRMlA3MF/hKZQV9SfrfhTBSvi/WECScPP2wmimuzpy/P8MyDQQHH1ZFieZ9Ye7ZvRvqwS5vJM2p2XHPhHaxzWAh2H/c4vdO3wXi8oZWvICik6VjjbUzZ2ZNwr38muINhOvhjsPkqc0EC67y9Nh6ZVk4zpjLEB7lUClv6jFCHorvqzACXqLdQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(36756003)(41300700001)(86362001)(31696002)(38100700002)(6916009)(8676002)(4326008)(316002)(66946007)(66476007)(82960400001)(66556008)(31686004)(6506007)(107886003)(6666004)(8936002)(6486002)(478600001)(2906002)(26005)(2616005)(5660300002)(6512007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3pWS1ovY0hIM1JHOGFDUHBUOHB5aDV6UE1VbU1SMkJTaFlDN2owLzFXeWJ4?=
 =?utf-8?B?RWVFWE1tWlZFWnBjcnZjWmZEQlZLcjlNbDAvQWxVMVpMUDExWFpLek5Da3FH?=
 =?utf-8?B?MmRJbEZ0RllBWGhWTEdqOWJYS1htMittUThWZXFRMUcrSzJLZ0c1TUlhWE0y?=
 =?utf-8?B?Q2tybDc3UHRjbUxKaEVNZlFWL1A2Rkw3UVpXK3JyOGFFQW1nY2hHL3BvcXVM?=
 =?utf-8?B?NTNLdkw0UjNQdHdlVE5wSkNtT0pjTmNhcGFXRGUzc255OHpCV2RLYXZDN1B0?=
 =?utf-8?B?a2FiVjdrMTRzc0FWbkNabUxYbnNaZ1hpcXMxRTVlQ05mN0JydjY4c08vS0sr?=
 =?utf-8?B?bmNyZXptVTVKNDlCcjk2NWZnREt5L0EvcGQvNFFvajdHTGVDdStab0dHdWxy?=
 =?utf-8?B?RHkzdDdSY2JMTGppRk1TRVl0alZDWEJXMFA3WnFvbXkzSTZNVmNDN0VNdk93?=
 =?utf-8?B?SmVQQktGMnoyWTNnZjRSSWRlUHIzZzFLM2RENjFXd2IrRXl4eVVrYmtnckVl?=
 =?utf-8?B?NzlISTkxSUVvTEhtMFdtRSsrL3NsVXlTa0FldFlVWVhWOENIOWt0T0hOTHNu?=
 =?utf-8?B?VFRWYlN6SW8ybU9mcjYyemg3bU84UWJLRGpqUWZxcjJxcnNhLzQ1elBEYTNE?=
 =?utf-8?B?RGdZYjJLNkkrVElmWDhnOWQ4L3J4VHFJcWs3RzNsd3JscEk3ZDl5NTAwcE5P?=
 =?utf-8?B?TTVWUWUvTlhIVDZrVVpLN0llcTJWSW9DeGQxZVpiWVN3NlZud3Y2cEo2MllW?=
 =?utf-8?B?aFJkRjdrcWxWbU9WTWcrcVdxT1lDVTZ5VTJBZ3A0bDdxY1VJc1E1SmN5eUhM?=
 =?utf-8?B?WWF0RlYweHB2MUgxa3FtSC9VaFg0ZXZyYlNQMGFkdVllVlJZTlpmQWlFU1Mz?=
 =?utf-8?B?V1RHQTlCVGRROU4wZnl5S0ppUTFWM1RiNlFVL3ZjVGc4RVhkWC9ybzlVdWEw?=
 =?utf-8?B?RUJNMkI2aU9BRVphRmF4VEljbWU5TW40em1GTGxJMDZPSG1oREE2UDNpSDNz?=
 =?utf-8?B?V2pDNyt3V2s2VkFSUkM4QVFaQmE1ODdHOTJWUm5tS3ZKdUp0SDNibjgvcWJ3?=
 =?utf-8?B?TDFhVG9IcXNYL2RhV3lOS3owOUhHay9Za0owUkIxb2ZpajV5eGl1S012WHIz?=
 =?utf-8?B?TkNLbVdTQ3YweExQcW9qa3VoeHNRSyt0YVFlMEJmYlNISEgyVDRQT3lTUnNk?=
 =?utf-8?B?dnArZ0c0OHUzQnNwUlpjRm1TeGVBNDlhTG81OGRwWjk0WE9HVTlEQlN4SXNs?=
 =?utf-8?B?UGFkNDJpdWptRDhpR05FNFhTRkx6UWp6WjBzVGYvMXJNNFc3bTJoYVlJNFhZ?=
 =?utf-8?B?eUIzQjlyalJZNWlFajZJb2Q3NURFa1hZY2FjUUNGdlVKM1RheUFpWmlkOVdE?=
 =?utf-8?B?aHFvUUs1NEJGcCtsbVk1NTk3ZjhNV3VkdFFnRGE0ZnlHREtPczlHSzhpVjJz?=
 =?utf-8?B?YjBSYW94d2N4andyc29RamtNY0s1c04rdlNEVkhHVHNEenl1dHEvL1M4TTBh?=
 =?utf-8?B?WTVyS3ZkY1l5N0d4Zm00S2FHN0thR2ZKTUNUQXhTQktyK1RzSmZJTDRIL09o?=
 =?utf-8?B?MjN6bFVoZlQ5M3NuWHQzdXQzU0EzTmlOZzFwQzlDaXh6NGhqcVoxd2FxMlN2?=
 =?utf-8?B?d2VNT1gvY2U5WEdxU011YUR5TEdXaTlBVFRxeGpGK2EvK2J0ZnkrOFJuOUlV?=
 =?utf-8?B?MWZudXM5TG9DWll0L01KeTV0R2hBL05lTWIwbnBUdHlNSVEzYmlDMkVyd2lZ?=
 =?utf-8?B?UlBvWFBTV0RpdzVvY0hyZ2ppMXNHQkYwV1h4Qm8wYnNGME1JMGVzSzE4NHpU?=
 =?utf-8?B?L0FaYVRHUDhrbXdQWC9mNTFpZHh5eC9ZV21vNGVvRlFoOC9DYVByM0g0bDBp?=
 =?utf-8?B?OFhkZFRCZTBhWU9HL3dBMVpiM0V4K1VUOHVTQTFtd0pteWpBYTRJUFpXRzhK?=
 =?utf-8?B?aVZRRkVkalpqcGx2cmltY1YwOW5BNVNQa0l1ZTVDREdOMlZaZDRQRFVES3Jp?=
 =?utf-8?B?VXgxaFhBeldURXB6MHRHcE1TUXdGR2F0ODdmelg4MCtTM0laTlBvRVdVWEhu?=
 =?utf-8?B?VE5Mc0lMckdRZk9YSlVwTFArdGNqcWk4bnRXTitZV0FVUnhqMzVVQm1RUVlx?=
 =?utf-8?B?TjIrbkRkSmNwQ1BmZFdXdit3NU9zV1lnU0hIOVNTdm02SHFnNVBGMU00WlRv?=
 =?utf-8?B?ZXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: adffc524-9e7a-4dac-5fd7-08daf96e7f75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 16:10:20.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3xA3zvpzHtPRb7Zj23gYl2qxZQ8mrquoYzbpnRJFPW6KG/xytoZxXoysqxRdOiGj6d17JVOjk5c/XUBgSAemQFpaW4HltDJk7AVhsspXv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 18 Jan 2023 14:26:53 +0100

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Neither FIELD_PREP() nor *_encode_bits() can be used
> in constant contexts (such as initializers), but we
> don't want to define shift constants for all masks
> just for use in initializers, and having checks that
> the values fit is also useful.
> 
> Therefore, add FIELD_PREP_CONST() which is a smaller
> version of FIELD_PREP() that can only take constant
> arguments and has less friendly (but not less strict)
> error checks, and expands to a constant value.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  include/linux/bitfield.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index c9be1657f03d..ebfa12f69501 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -115,6 +115,32 @@
>  		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
>  	})
>  
> +#define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
> +
> +/**
> + * FIELD_PREP_CONST() - prepare a constant bitfield element
> + * @_mask: shifted mask defining the field's length and position
> + * @_val:  value to put in the field
> + *
> + * FIELD_PREP_CONST() masks and shifts up the value.  The result should
> + * be combined with other fields of the bitfield using logical OR.
> + *
> + * Unlike FIELD_PREP() this is a constant expression and can therefore
> + * be used in initializers. Error checking is less comfortable for this
> + * version, and non-constant masks cannot be used.
> + */
> +#define FIELD_PREP_CONST(_mask, _val)					\

Have you tried combining it with FIELD_PREP() using
__builtin_choose_expr() + __builtin_is_constexpr() (or
__builtin_constant_p() depending on which will satisfy the compiler)?
I'm not saying it's 100% possible, but worth trying.

> +	(								\
> +		/* mask must be non-zero */				\
> +		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
> +		/* check if value fits */				\
> +		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
> +		/* check if mask is contiguous */			\
> +		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
> +		/* and create the value */				\
> +		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
> +	)
> +
>  /**
>   * FIELD_GET() - extract a bitfield element
>   * @_mask: shifted mask defining the field's length and position

Thanks,
Olek
