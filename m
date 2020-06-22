Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC62039E0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgFVOs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 10:48:27 -0400
Received: from mail-bn7nam10on2120.outbound.protection.outlook.com ([40.107.92.120]:17504
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728504AbgFVOs0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 10:48:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LumxNkY44pxhgRB/Li6gvd0sO5QJUButJkXDDGG7ag8hi1pHSM2B8/SwJsblrRRwfklfZ9EOSzmRaLSBHQJ3hWNU9nB8UB9RaOS5JiGBJHFgAT/miW2UNbkEXSLKgBuHzrrK2c/MCssqOTFxU+4mwrln+roDq7qLyD5CadQxwwoDZWD1NejzC9EBvjMjJoR5R0yN0qQeANzvmTh+bR7wDYZUt1X8D9Tt41PE8d5BAt2NqPOC7wfJodbYe+gJCsEGGGa4/o1cFAZlzrD+CdAC4RdPUl5cghkuG7/3yLYaxr6c3yog+8McS7XYPsoTQQ0NVIoNoDE3vvUUkhiSFO0RZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5s3L4ddF0dGvLJ3lCRHjRm4l14rTNR5gztdCcvoers=;
 b=AYHk/HdpXhVuV0f4d+sXykeCNJAKAkIHy1YoiIIW6cFR+I+vAiehSt2hVO3U3yACU9WKNjmZq0g6txiAwuMJeA6C65kpNX9lx1V1xykWCQi0z6MVYoLXejXpnDQHdxFeiLxYWR1yK+Gw91tGXy9B20sf6qVllfdxecGR89408KkamiohYzAYEvtWcj8bc0VH8PrJVxtYfiiRaazcrcorpOkDKvyRtzpWcKdPKQTML1SrBAkYhVwX4VohHn0Y4DmXOzR0gV+e/Tkt8Hgzhoml4UqZKYYi4OtD6WrFNUAKvSLBSsUSi+2Uu3Bmzpbla2uu2DhWGYgtwiV8CnCxEQ21iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5s3L4ddF0dGvLJ3lCRHjRm4l14rTNR5gztdCcvoers=;
 b=m0X8BGlWcMb7tRtl7ZGJmaTgIruIDR0f5lhwuzPm9sQB+0ikTg8MhVpxfjwC+DAY2BnDiJlQJOmDVsCzUMZ05dOsR7ALKR7Y3FpvYbL889JQuHJ5mXyBuKYJknQaZ1sK8i0fQ0NMALa97Ih1vyY79VzzbbA5cWZAod3IiZKrigU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BY5PR06MB6513.namprd06.prod.outlook.com (2603:10b6:a03:234::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 14:48:23 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 14:48:23 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
 sparse: sparse: incorrect type in initializer (different base types)
To:     Kalle Valo <kvalo@codeaurora.org>,
        kernel test robot <lkp@intel.com>
Cc:     Joseph Chuang <joseph.chuang@cypress.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <202006190422.VymyEbuu%lkp@intel.com>
 <87a70vgpkb.fsf@codeaurora.org>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <76e75ef2-850b-2860-f28b-ba773ee50117@cypress.com>
Date:   Mon, 22 Jun 2020 22:48:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <87a70vgpkb.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BYAPR08CA0050.namprd08.prod.outlook.com (2603:10b6:a03:117::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 14:48:21 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23aa3272-9d44-4e95-2405-08d816bb4fba
X-MS-TrafficTypeDiagnostic: BY5PR06MB6513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR06MB6513021DF2FCAACF2A470EBDBB970@BY5PR06MB6513.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeU0YsxZ6waBb3Zadfkuu7VrKi0Oq1xDceCPMMSvqCFnfzNqDUJCD+3AtKCJT06TXwwDWQe0UJzXjuBA5W2ZlPI2NWaDjxzYQR+mYCUZvkumHecr32PEdDO4s2CRk+7oRWl62f33aZTFFuSqVNjZRoQDbrSkdInobxZ2S7U9bv5oxJavuzGAYGnVoYQ0BOqUnYuQ4nMZtKg2JK/isojwGAfPfilzXW28ryZbXVK5aJJb7CC/J84N+z21is/1LYl3nlgnFhfbHft93eDTdkv5dxWfTIyj+ZY7DWmP2WT5/LwuUJscZaSvDIBG6zkZqQ0KOrcWK/Ya5/PxvdtEeyJOy8+WHRD9ZlGy7ffXqIOHXUIxZ+0MO/hqKLb39qqSFUO7afJViQ8Beham7xq6SbJjFrkTp1PQAGb0A6RBmwgRBNVuUI8pjW4PRMxnDrDiaCSyVxzPFOvfRD7tj1IaVht+1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(396003)(366004)(346002)(8936002)(16576012)(2906002)(478600001)(3450700001)(316002)(4326008)(2616005)(16526019)(956004)(6666004)(26005)(186003)(31696002)(5660300002)(110136005)(6486002)(83380400001)(8676002)(66556008)(66476007)(53546011)(66946007)(36756003)(31686004)(86362001)(52116002)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: p0U+Mm7JJw4K0vIO66o4Z3Rc/mE6kuSHsArkrM7gtTZTvH56rkTWe4OCt+qGlI1XtdbXdGb3bJuy47RAFw8ThN3PdX+5sqKtGimytYl8V8JlIzN5J/zsBrJZsqKIHv7rZRd0Z6185j3vH/STe5khUZLYc8oW0uunDV5o5bQlIz4IitZuXIRObKSlXNb7uFkeIfq004qOvtaq3hdKjVhmDRS1VPa8eosI2E7sGtWWbGgVjtJxtWq4NrYaGLrnW5iXmlKJweAqhvmMVGhxpLjcsxZgRfZnwj79XRK9YhVd7FxFdR2H515kiFi4D31raRwiDvgqtShh+gXXFOHGsQMub48GR72aOcqnDhc4cAMnyEfm8GNWNr2vmkDwFo+MNJoUZbu4+4BAbdDkn6Y/GaafEdT5/QpLVzr3lhdiPU9FkP/6QnAKsIhVDZ9fjj6N0j4YyLZHM0z6fk9Tf0Ur7OLdTI5cPsabPpohDNbXPIDXLmc=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23aa3272-9d44-4e95-2405-08d816bb4fba
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 14:48:22.7828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgFNRtfszlJuruSSmTOhhiVpG3j3gzsaKI34xL7r10UuYmmKLpwFmHTa+sHiMtGaHAS9EN8pksCyyEdCZ13PCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR06MB6513
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/22/2020 10:09, Kalle Valo wrote:
> + linux-wireless
> 
> kernel test robot <lkp@intel.com> writes:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
>> commit: 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8 brcmfmac: Fix P2P
>> Group Formation failure via Go-neg method
>> date:   6 weeks ago
>> config: riscv-randconfig-s032-20200618 (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          # apt-get install sparse
>>          # sparse version: v0.6.2-rc1-10-gc17b1b06-dirty
>>          git checkout 9c29da3f4e7ef9810bdfaf3d8aa5e6d2e33136f8
>>          # save the attached .config to linux build tree
>>          make W=1 C=1 ARCH=riscv CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>> sparse: sparse: incorrect type in initializer (different base
>>>> types) @@ expected signed int [usertype] requested_dwell @@ got
>>>> restricted __le32 [usertype] dwell_time @@
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>> sparse: expected signed int [usertype] requested_dwell
>>>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:1710:40:
>>>> sparse: got restricted __le32 [usertype] dwell_time
> 
> Joseph, please send a followup patch to fix these.
Kalle,

The fix is this one
https://patchwork.kernel.org/patch/11598109/

Do I need to submit a V2 with "Reported-by: kernel test robot 
<lkp@intel.com>" tag?


> 
