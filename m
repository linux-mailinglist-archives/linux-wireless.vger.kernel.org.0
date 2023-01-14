Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBB866A978
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Jan 2023 06:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjANFlp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 14 Jan 2023 00:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjANFln (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 14 Jan 2023 00:41:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2106.outbound.protection.outlook.com [40.92.41.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF37A35B5
        for <linux-wireless@vger.kernel.org>; Fri, 13 Jan 2023 21:41:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD4F56P6dafcAJTXipuyxHu1p1xUwP29yBnZIyJoGbNizwDIv9AXdk4DzqBbbkn5Dazot5ZHWREYwzEI0FlkCF9NOQj57OiaucqgLVfYLY3rkcQub0YnW48cc5Vp0Aey68o/9dw/Z9RVsJP7hKBEbrhDvFy5ZHjbzGOI6dWQixM9tg71MKPBpRYpdBvy2wsPmjL+c/t2N/EC6UI0f4pVag/eaZCtHCRoavsHekWA15ltkI2DyrrZWd1IJekAqVGZA/wdydtcp0lNnN4qqScrChMuoZFjpz9bTnFvmRHAl6BlFDqd6BcHo1TNI+WxGyEYAlNLapgFAEYxeQWlJZwnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T4goZEsZCEJeqlSTdxBZdpfQ7BIpgeQ88jPd45zZTw=;
 b=XhJp7waMdq3Q4s+z27wIYetcoOSos+m4Le6qsYJgP2qcNz7KQNUxZig5rZLaf/k3ss8+z0bYuY0DiAWnGVx7MTdtAuRdjXP8KeV4P4svKWEKVRcDSL/SntaEMjzRk6kedgi7haj/P1xkiFkkCxqwOFNDXPO9YiBZlxej6XGXePIONMvijcmP5q+X9whIa6Ic6k8V/yE02rLF4nfAVlcSGGHy8X7xQqpmrDSQz//+on9ziJxrRPCayEgzhmqXSDaB++aHIVtpOrizqjz747oObLbYKrUrXehevVniKPDJFHnV+SJmWm24Pv1VspgYmHDU2Tp2gHaxP8O74iGG4gpOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T4goZEsZCEJeqlSTdxBZdpfQ7BIpgeQ88jPd45zZTw=;
 b=tuG7GzvZDY754m/5vKbsY6cVB/84dgBUE61jtXSG6DKpcRj+ZY8HCB5jYz6ABVIQovPPPFaDkqECWb8ZuSpTu/11vkUWiBFFLD2JJlWin3TJgWDLqSkjAJDoKsPSbIUFpQvzDNeEkW/NhUaIFWUDmCWKr/CQwTPAp5oCXNCYJLocPKx8PK/C2rwTMNLtupIFDXerVMAKJyCZcqOA05mtJDVM+slrOaDjRg/YaFf3DImXLSW6GnS678i4I51ndT/6qL0jRFICoNgy1ggDBMwwJZwzQZQxjDqit79BjWY8aNUDVQGftSbYLNGi6vQguCMrypTIU0mii+VuA/RdKiTqEA==
Received: from CY4PR1001MB2375.namprd10.prod.outlook.com
 (2603:10b6:910:47::35) by PH0PR10MB4567.namprd10.prod.outlook.com
 (2603:10b6:510:33::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Sat, 14 Jan
 2023 05:41:41 +0000
Received: from CY4PR1001MB2375.namprd10.prod.outlook.com
 ([fe80::5090:bf77:f059:b858]) by CY4PR1001MB2375.namprd10.prod.outlook.com
 ([fe80::5090:bf77:f059:b858%5]) with mapi id 15.20.6002.012; Sat, 14 Jan 2023
 05:41:41 +0000
Message-ID: <CY4PR1001MB237594C816BB0C957FC7CF9CC9C39@CY4PR1001MB2375.namprd10.prod.outlook.com>
Date:   Fri, 13 Jan 2023 21:41:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linuxwifi@intel.com, linux-wireless@vger.kernel.org
From:   Chris <powersurge69@hotmail.com>
Subject: Wireless 7260 on Debian 11
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [FIoqHRMQR24nMfXE+2hEcnmdSs+eURsW]
X-ClientProxiedBy: BY5PR16CA0008.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::21) To CY4PR1001MB2375.namprd10.prod.outlook.com
 (2603:10b6:910:47::35)
X-Microsoft-Original-Message-ID: <9e28a0c5-f0b2-f9a5-bdfb-b16cfe06a592@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2375:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 3451dd13-5748-4b12-f23d-08daf5f2030c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: STRnaNqsibQsPHtW8bw1KyFV508zroR8sNyXmiQy8sjF9ecH2YvQA3TRQ0T64mdijod6XNa3pX3rLYX1FG/CpmWcS/+EzfEmQieFJelkW02I7AKU9HnFUh+0CyC8QOWNdBc/Q9BqxACAslKDy/cBWnbdjdiSUKmxApLbL4dZt0Vr9OaF8FlXV0MSUMK5bqHhj6OycuJGZ7jVnnhnIPtXh7mnqexxDkbyKj1OFrdud843vRH7xVvyc8+DEwZA1aJF7XjBd9MWkCi3gSeNBSJH4zfmpdg80wJpIjFo7T6sVt+6r1mof9/uY9VuRQyrtG2HzjCSZRqd00rPZKOeAiXtGcYsx4loEsYINoxeg9CDRL/rPKMiTKwfdWuJa81BzTyyYue0wpmnpQx/mx45WIfL0BFxusxev5BXUWX6V6g2++EWoFSirkTQFrih4bn6Tw8P+Bi5eT5g35UEtiJgOdIH9tbS5M99f330PAaDw9TvZ+wCPjuJIpKSTBwQcO4OE/07YiAOSkPIt4Wi6acYEU3tOxXpeWDCT8nzr1oyFn68BEPfRy29T9l/GkKy/+Cl6wp/qgXwMzMvZMOd8Y959ycWhQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXJBejdRQi9PeXdYenpVM011Y1FhTGQ5QklTcTlMclVvdzBmM083dVlMc1hQ?=
 =?utf-8?B?eW1HcFhTdWVWZE83bjBkOTVGY0huUnduMEpHTFo0clNTQmFrZDBqQnN2R0pY?=
 =?utf-8?B?TnhTZEMzMDRWUFNKcmZjTm52SjNmdWVTWlBYSVI2Z3lBY2hNcWo1VkdhdE9B?=
 =?utf-8?B?bmR6UFhYT3dUZnljczBoMWlPUktQblVLd1RXdjFzK2twRTNoQkQ1RGVNOUVR?=
 =?utf-8?B?ZlhSUW8yZ2RJekhLblIxZWdPTXgxVFl6dWNoaWpScnpiOWY2OFB5VDVTdEM5?=
 =?utf-8?B?L290cXJUU3M0bDVNaGVtbkZQQURPM0RmcnFvMDZxdkd1MzZObHVIZUVHK1Zx?=
 =?utf-8?B?RlE3blBLdHBBcHNaZ2oxZ05zbVNyNnF4bnZIeHBKcjE2S3IyWXlQRE5iWkNW?=
 =?utf-8?B?V0YyZVpteGJSZW9vWk1IMUNXNHRDWUhsc210bUN6U2lZdGt6OWp1di9qaVJt?=
 =?utf-8?B?MHBiK08rOTlrajl3bmNjRmw4QVNKK3NPOVU4T0llWmx3VW9McThnWHZ2azV6?=
 =?utf-8?B?V0E5NFhKR3RQc3FWZktBOVVlRzN6TXBtSzJCbTh0SUR0TFFCQVNLcjNqTFVy?=
 =?utf-8?B?WWZiS0oyY1lYVy9WSGFyVXRRcHRnWk5ScSs3VHZKblZBazlTVG9mR3JoakY5?=
 =?utf-8?B?a3M4UXU3S3hPYzJncWE5ZHZhVVJSU3FZQU9OcWFLSkRSMFVrSlBQMVpRU0dQ?=
 =?utf-8?B?b081Z3ZiQ3VuRWhnaHY4UGQzREY5Q09Ub0JMOWhrZlJqcHFhZUVYQ3hrenZT?=
 =?utf-8?B?YVVvNU9xZ0ZUQm40RHlCVFJ1aEoyMHNkU1hxQ1A0TkNrSlVaWWhwSmZrWVl6?=
 =?utf-8?B?TGV3c0JMNzJTN0UvQWNBY0FTUk9RK2hXUUo4eDAxeFdNL3lPSjI4T1dqb1kw?=
 =?utf-8?B?WkJuM2cyZXNLUDRaRWxhOTQzMEhBNUptanBTaGJVczNidzhjN2VTYVhseG5a?=
 =?utf-8?B?QnJ3Y2JuRFk2S21yeHNVNTdDdi9YQlhIZFBxdzkvdHRkY2tZM1dwQllzbjNI?=
 =?utf-8?B?SHlYSWVoVmFPRzJFdjV3UDFkR1F0eDBmSGt1ckU1N0s2dWVBMTRYQTNVRlVq?=
 =?utf-8?B?RFdnR0FYQWp0MFhQMkZkbm1HK3paT3BKelN4czVVVW1lUXU4djVqazBoZ1p5?=
 =?utf-8?B?dnhrTGZNZjY1Wi9YdlhUSXVSRjNiTGsxci92YWVjYkYyaVd2R0RFd0REMnFu?=
 =?utf-8?B?c0s2UzZHeHlEK29pT09Hd3RkQmVLTStIVmpvb1A0aUpQbCtQWVA0dkpad2Ev?=
 =?utf-8?B?Q1FpRlZxK1N6WklobzdacFM0R01Sek1RaEdHQlVHNk1iUkJwanZCaFllVmUr?=
 =?utf-8?B?K0IybDRVc1J0QlFvdS8wdFFDT1N2SUZWcC9BTldpTHdMdS9GTitOcTZrc0Ew?=
 =?utf-8?B?ZFg0OWx5Z2x5dnhLZ2pucUJPNUhJYlNjSFJLclVodjVaR2J4dW5WM1U0M0h3?=
 =?utf-8?B?T0M2bnpvb2ZIOS9HYUN0bG1xOU51UmVUYmRZUTlnRThCcjNwZFVhd1BNZ0RG?=
 =?utf-8?B?YXNNSWQ4U1hXak9sZW1uempSeHlQNGpGYnBpN00zSmwrY0lmdEw4UDNPSFVk?=
 =?utf-8?B?bzBzeDBsdGwvMXBUdWd4cVdJSTdKc2JYSWhCaHNacTdpS3JJYU9CMU9GYVVk?=
 =?utf-8?B?eXFCNFBEdTdkWjNSYXZLdlNpRndCZnhyV0hiMENwYVc4ckczZ09Jem9lblZE?=
 =?utf-8?B?dUVuOHMzeHZqMWg3VU43ekVTRXh6VW54TXhmMS9yQWhpQkxTanVyT3VUa0Qz?=
 =?utf-8?Q?ueIQ4ZHd76LfuJjwqc=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-28291.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3451dd13-5748-4b12-f23d-08daf5f2030c
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2375.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2023 05:41:41.3729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I just purchased a Dell Latitude 3340 on eBay and I tried installing 
Debian 11 on it but I am unable to get the wireless network to enable. 
The wireless was working perfectly in Windows 10. According to lshw the 
laptop uses a Wireless 7260. I first tried running 'apt install 
firmware-iwlwifi', but Network Manager just says that the wireless 
network is unavailable. I then tried downloading 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/iwlwifi-7260-17.ucode 
and copying it into the /lib/firmware folder, but that didn't work 
either. Is there anything else that I can try? Thank you in advance for 
your assistance.

Sincerely,

Chris

