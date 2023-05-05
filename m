Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1336F7AAB
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 03:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEEBXg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 May 2023 21:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEBXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 May 2023 21:23:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FA124A9
        for <linux-wireless@vger.kernel.org>; Thu,  4 May 2023 18:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hx3XlZBgeV7ib8CtAVz9S+9H0/B6TPW5qQPDSD8loqFN9SY77pSn9ynPYhFfJxMDPkk1I8ll98+MPs07kC+MOXYd39u0tbK51/bSOAAKSlX+lcmEzSyeZ3C2kxBegkWY3d8AviqQ67DW14BDZywN+FX/OTgWEELNyINbeChYb60cSLugBZQtHjfMyeRislWxpDqTlUCHDKHm3HaL16TtAHNoil7WTjc36WK4L+RGCxBpC/VCKhJ2gt2Xsj/rz1zPb+7Imhej5TOMiyeB0oGhJVWpcKD+YreiIvdFJpx0WMIZXnR7t9i5YFodwGkwmt5HGlsEdFzk4hNxKps+eVBLDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=py9/eGyowymyNDjJM4x9gkv/sGUTWykCXAOPJOwc8EA=;
 b=O9UiAcoFvUt8P939L35oqul8qzS/Hh1RZSlwy7sUThMVrTYtHKxdFqgD23doiAap2XOs2AsIvCORYCNqnurttJ9Nnfzi5kAK1vK/MSZ3b/SjcvICVOIsiBXTwT4Y9vvuxvT00VHh7ync7AgiGSQUNIHnwuYvFirRTOKOu2ID8j+Q6UsvBK3PP7y6HsMBnmSztBYIZzlf5uTfp+2e2sR7dck/EPXwvaBiS64n+htOjV6kVprcQcgqKwVbyYM4gh22X8nCce9E1DLIB76pk/g8NNGAx3QuUSDSzM9OqSP2dmFoVjYTuephhH9pDHfK5M9ZyF/6v2ooYscE/C3C1ih9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=py9/eGyowymyNDjJM4x9gkv/sGUTWykCXAOPJOwc8EA=;
 b=1Q9qMGL24ShG+sd7jGG48DhavL36ZXPgI8mm8e/F6SFqY8ri2BXNPhZYrXhDKSvzXv/eby+lXlBrqsaXLZ7Ha1t5wz3ckrPnO4wePSL8a6dB8fs+SQY/nmC5NQUo8UtvYLiv/+PvHAIOKxivuS1XpqWmwQgjWpcKK4JTeHIdaYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2843.namprd12.prod.outlook.com (2603:10b6:5:48::24) by
 SJ0PR12MB6904.namprd12.prod.outlook.com (2603:10b6:a03:483::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26; Fri, 5 May 2023 01:23:28 +0000
Received: from DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60]) by DM6PR12MB2843.namprd12.prod.outlook.com
 ([fe80::863a:5f29:1e76:db60%5]) with mapi id 15.20.6363.020; Fri, 5 May 2023
 01:23:28 +0000
Message-ID: <eed0261b-6447-fe8a-ef98-073ae45ff137@amd.com>
Date:   Fri, 5 May 2023 11:23:19 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: Slow RTL8822CE 802.11ac PCIe Wireless Network Adapter
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Cc:     linux-wireless@vger.kernel.org
References: <75906666-df37-988a-c448-a6338b8a1cff@amd.com>
 <b7a59145-37b0-eade-3a9e-b565cc75de35@lwfinger.net>
 <4b3f4c5b-cada-bb7c-65f3-936437261b08@amd.com>
 <98f8852a-1710-2792-3196-e74fe614a03d@lwfinger.net>
Content-Language: en-US
From:   Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <98f8852a-1710-2792-3196-e74fe614a03d@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYXPR01CA0144.ausprd01.prod.outlook.com
 (2603:10c6:0:30::29) To DM6PR12MB2843.namprd12.prod.outlook.com
 (2603:10b6:5:48::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2843:EE_|SJ0PR12MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2abeee-e728-483b-d88b-08db4d075452
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkC5rs2Ew4O1QAAi6BE+vj3Tj+L5tHI8sj4ccj7E8RG4IViM7mQQdFONbNvQdcZ3UeYTbwULGHhBPkiD6zzVbniU4tnZbNB7ue/4DSaZfJiCOsGKFEJ48ozSAcTFCBeSe1kTFNK6pW7a0jgC+/nL2HtrwcmyPWLJZ0OKfA11vVwd14g1cWVaPd0fhlD9iD8KW/3uFuSLdPP3TDsYahMYWtePLJ5yI9nkELrvp/xdpXqw/fh6fTNo+dUNlJvqCW92S3gkQdvzqoCY8OC57WOas4g7fPVpZgytSGmhH1HzbWeZVqsmu1c/oHjsUxSvkpA0ihUlTsvPVoWdqBrBAgP/wX4WJGeiy4/cyUzPjp3b1kbMja5+xhRaEthitnCzFmHGl4B7pEEqkRUJxvbmnUVjsuNvVWOiyrcDZPvfbqwAm2h/B97OOecLb0xCgv04fgfpKBRcQBdQ+DA8rBk6S6xDlGGOpCcvwFgsxVoAmhZH2WpJ6IZMTRJRAuHXrDzzNQCSd0nDfPejtygxWogU1P7vBquAwHZu1y0c4QtDoK/F1OHLejKxP7IxE9F0mF5Rd7x20fUVZKsambk/HNxxa+hGPM1ciki0GWWbY8ukrOxMgiQmfl6cJPVAGD4ll6wqciXKWPtbwXNTfQwtjZtJ87Et7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2843.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(110136005)(5660300002)(2906002)(66946007)(31686004)(38100700002)(186003)(316002)(8676002)(966005)(8936002)(53546011)(6506007)(26005)(41300700001)(36756003)(6486002)(2616005)(66476007)(66556008)(6512007)(4326008)(478600001)(6666004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVweVpiOTBsaHkvMU95RWJzZHBXaFhXTFgyanlvS2c3RHErRlNIU3NITm1W?=
 =?utf-8?B?SjYvZXBJSFhPLzBlU0N2UzA3amhsZm95d3RSemJKQXBxeEdtbzZrTXdlZU5I?=
 =?utf-8?B?NUFRTlJBZ21NVjJaaUVoMkJBUzNQMVJqcHp3c3loSEpWU3I4VGxJUkh2Q3Av?=
 =?utf-8?B?WGY4ckNZT2VLUW0wTEpZY2gyRGgxSjV4aXBISm9qZWVQUUx3RjFoMmh2VXdW?=
 =?utf-8?B?eXJGNEZXR1BCTSt3cDN3a1EvSnZTdnQrcEc2ZkFEa1d5T2hZd2pVTXhPMDlZ?=
 =?utf-8?B?YWUxTk5Vd0Q1L2N6TlQ1aVZxS1FBaUhlU1NpVThuRHNQTjhtTlhEMkFaNUlY?=
 =?utf-8?B?MmFGYkFSQ0NmWmgyYUdaNWl2QkllRHRidEwreExUMkJVei9iWlRQcXVmVU5z?=
 =?utf-8?B?eGg0YmRodVZlYlVwV0xVSUxnK3RvaWEzRkxQRGx6dlVJVDlRNmlqcUx0TXds?=
 =?utf-8?B?WXNHZ3FPZmpDOWZmZEcwdVdTbzI1a01WaHI0TENoemg0Q0FVdFgwTnZNT0da?=
 =?utf-8?B?NytlUFpJbE9jdTJrM1hUQ1hSYzJjcHJMMHBCdFJQNStiMWlDZEp4WlBaZHpo?=
 =?utf-8?B?NjJpM0VtSnRYRkQweWdwMlE1QXNZN1ZwSVJqMFRreHgzQlhFMWxPRDF5bkR0?=
 =?utf-8?B?MGI1UTJpN212YUtJczFsQ1JsVktENENpMGNreFY5NytUMk52cjMxdWZlM0Qy?=
 =?utf-8?B?Vk5RbFh3S3pIMVRzSFFTbVBSa2RGUlZKN1hQU0wyMFl2aVZaL3BDVjd6Y2ZW?=
 =?utf-8?B?QktzZVA1cnJsY09IUGZpZG94MHhlbkt2Ui9EL3B1aFZKYWhRYzVLSi9paU00?=
 =?utf-8?B?REhBQXprb1FBNDYvL2l6Q09rUlpDYjJRMTIyZ3lmcDFnK0NKVDVvNGNaSHNz?=
 =?utf-8?B?KzhkZE8yOGtjUXpuUDIrRDZJck5ITGE1WlJDbTJ0SDg1YUxCdWk2Z2xMUWE0?=
 =?utf-8?B?NW1LUC9mdTJrYnRYZUNiNi9OcVloYmxMK1YyLzZTSzRRS1piR1hHZ0MwS05s?=
 =?utf-8?B?NTBtVEFtSWdjZEFCNzRoZnpHK0drM0pFT00zeldNU2d4SXhnWkFib0xYVFZO?=
 =?utf-8?B?YlpMWXA0NlNFVWtEWG5XZzFpRjVValJJZkdrS1ovVllQdjBCQUhIL1pSU3NE?=
 =?utf-8?B?YnF2bUZuVDZMRXRrZHg2cjBYOUdGNXNXVVRsTzViQnhPWWFxamg1akxMcGhQ?=
 =?utf-8?B?TFhIZW54anNGeFRZQ1hCVHZXK2Z6K1dPVXVZTFVqT0pQeFIrVWRqa3FrMGI3?=
 =?utf-8?B?VHZwcmJDWEVZYlpzZG9zbFF5SmcvamplaHkyM2J5T2E5Q3lFQXl3bnBMenpK?=
 =?utf-8?B?UmVqeHh0OFJacU5ZamNqY0V1cXUrTWZNUW9pZTVZd0Z2ZXlOUnVVNzhpcFBj?=
 =?utf-8?B?WHFsb1lBbXlHdVkyYmdWWkxiZDhUaVRSQkVFRnlxcDlNeU5qTEczMXZWWitu?=
 =?utf-8?B?UmVCQkFMbndYbEhxZ0RkajVhQ2EwOGgvSW1wZHlYeVFoSURIbnFmdEFhVGE5?=
 =?utf-8?B?andkRVZ0MXNlaWl1dlREbWs5VUtxYnRuSUQ4ZHQyUkk2Z1BpNUZQYmlqeFlS?=
 =?utf-8?B?Mng4cUorbGV2TWl0VGlhTzQ5SFN1alhXc1lHdWtrVzlmSWpnSlNDSnNPVW5M?=
 =?utf-8?B?a2pNTHpMMittb09Fb0Z3cU1nd3FHOWwwQkxoUHpLMWYzc2swUnlQTnpRMTM5?=
 =?utf-8?B?cUJKdHRMYUlGYXZBeUc3MFpiMzlUdUlXTUIzR05VbXdqY056eDJYLy81OTdx?=
 =?utf-8?B?T2VmckVuSkNILzJlblllaFhTQ3JTSHRwcWVoanprZHRsNjRBRkxnU0VuSFl4?=
 =?utf-8?B?NTN5N0tiOFpYWlk1NzU5VzVrNkt1enZOTkhtUUJLTmZLMlVwamVWeW5rZ2lB?=
 =?utf-8?B?ck53Zm9yZlg2bFFnS28zSHVUNDF6WkZuKzJ5b01JK2kwT1F6MUZINERxSlV6?=
 =?utf-8?B?SGg4bUxlWSszTFVXODN5UmhNcUJESlpWNVowQzlFWFQ0WEpkYVVPelRCUC9O?=
 =?utf-8?B?VUVyOHlBMS9YUXVvT0pPZ1liRDluWW9xVFkrbWRtcWRJNHJBYWpXaDJHNHo3?=
 =?utf-8?B?eWZ0WUVmZEpVOUZNbWsrTmFHSCtUdUNFSTFSZExlNHdjUjY0WUY3bDdJdC81?=
 =?utf-8?Q?pHzJxciHtzPnLfilPJsgEjObH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2abeee-e728-483b-d88b-08db4d075452
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2843.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:23:27.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /D1xDZqexfjrOHAIkyoNOC7ne+tLZIZG9qJUsamREq2tWfeF4mu/dkzAH9+phCDh5XgQLMUcqDkWv5YBUIvlEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6904
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 5/5/23 01:04, Larry Finger wrote:
> On 5/3/23 22:10, Alexey Kardashevskiy wrote:
>> My bad, I should have mentioned that I tried this one as well, 
>> https://github.com/lwfinger/rtw88/commit/75e2c81 3weeks old, no 
>> difference there.
>>
>> And it does not look like there was any change related to my problem 
>> since then, is it still worth trying the very latest version? Btw 
>> reboot is not really required, it is Linux, not Windows, 
>> rmmod+modprobe should do 😉 Thanks,
> 
> I added a bunch of stuff on April 24-25, so a 3-week old pull would have 
> missed some important stuff.
> 
> The problem with rmmod+modprobe is that the rtw88_core module is not 
> removed, certainly not with a 'sudo modprobe -rv rtw88_8822ce, and it is 
> really easy to get a mixed bunch. I get tired of explaining that to a 
> bunch of newbies, thus I recommend a reboot. Of course, I do not reboot.

Turns out I had to reboot because of the module signature :-/

Anyway it does not appear to work any better. Below are bad ping and 
good ping, the difference is moving laptop 2cm to the left. I believe 
the right driver is loaded as the modules are "rtw_" and not "rtw88_". 
It is quite bizarre how moving the laptop for a little bit helps and 
moving it back does not necessarily put it in the bad state, may be 
there is a microcrack in some PCB or something :-/


aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=7707 ms
64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=6677 ms
64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=5653 ms

--- 192.168.10.200 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2054ms
rtt min/avg/max/mdev = 5653.382/6679.203/7706.911/838.350 ms, pipe 3
	signal: -56 dBm
aik@aiemdeew ~> ping -c3 192.168.10.200 ; iw wlp1s0 link | grep signal
PING 192.168.10.200 (192.168.10.200) 56(84) bytes of data.
64 bytes from 192.168.10.200: icmp_seq=1 ttl=64 time=3.35 ms
64 bytes from 192.168.10.200: icmp_seq=2 ttl=64 time=3.48 ms
64 bytes from 192.168.10.200: icmp_seq=3 ttl=64 time=3.84 ms

--- 192.168.10.200 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 3.347/3.553/3.837/0.207 ms
	signal: -55 dBm


aik@aiemdeew ~> modinfo rtw_8822ce
filename: 
/lib/modules/6.2.9-100.fc36.x86_64/kernel/drivers/net/wireless/realtek/rtw88/rtw_8822ce.ko.xz
license:        Dual BSD/GPL
description:    Realtek 802.11ac wireless 8822ce driver
author:         Realtek Corporation
alias:          pci:v000010ECd0000C82Fsv*sd*bc*sc*i*
alias:          pci:v000010ECd0000C822sv*sd*bc*sc*i*
depends:        rtw_pci,rtw_8822c
retpoline:      Y
name:           rtw_8822ce
vermagic:       6.2.9-100.fc36.x86_64 SMP preempt mod_unload
sig_id:         PKCS#7
signer:         Custom MOK
sig_key:        0C:F6:31:12:B9:95:09:20:A6:62:E6:72:4F:D1:85:00:F4:A6:A9:B6
sig_hashalgo:   sha256
signature:      9F:F1:74:86:E8:B6:63:FA:F5:EC:2C:84:02:75:63:DC:66:C8:99:92:
		9D:A8:1E:2F:FB:5F:50:EE:DD:59:A5:EC:DE:5F:AB:8A:4C:F9:D3:8A:
		CC:CE:BE:3B:55:C8:E9:D9:AF:12:D0:A4:DE:B7:FB:A4:44:B2:F0:96:
		CD:E2:C0:69:0C:A8:EB:1C:9C:BF:A8:91:3E:D2:7F:AD:9B:7D:22:A4:
		3F:33:8F:86:40:DD:B3:42:B9:96:5B:94:CD:0B:E3:38:A0:8E:4E:8C:
		62:38:11:01:D6:16:EC:B6:E2:28:48:07:A0:C4:6C:6C:55:04:01:F6:
		C6:82:7E:F9:DE:EA:D0:20:63:41:4F:0A:D8:27:56:49:F6:84:E2:B9:
		21:DF:3E:4B:C2:A7:C6:0A:8C:B7:66:17:E5:81:13:D6:5E:CA:94:D1:
		E7:60:EF:B1:9D:52:E0:64:F8:4D:C5:54:CE:EF:F5:DC:2F:AA:22:5C:
		81:52:CE:AF:9B:FA:9B:8B:88:99:2F:2C:8E:6A:A3:44:58:3B:6B:08:
		78:43:B1:E9:27:C9:43:E6:49:BB:86:0E:23:10:0E:05:33:0C:23:B0:
		5E:47:92:EE:0B:96:EA:65:92:89:69:DC:73:50:1D:A5:96:5A:11:32:
		C6:2A:69:7A:B6:FE:6A:22:7F:69:61:B1:9B:F1:CF:66
aik@aiemdeew ~> lsmod | grep rtw
rtw_8822ce             16384  0
rtw_8822c             499712  1 rtw_8822ce
rtw_pci                40960  1 rtw_8822ce
rtw_core              319488  2 rtw_8822c,rtw_pci
mac80211             1486848  2 rtw_core,rtw_pci
cfg80211             1273856  2 rtw_core,mac80211


-- 
Alexey
