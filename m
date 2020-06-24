Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E5206BE8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jun 2020 07:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbgFXFph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Jun 2020 01:45:37 -0400
Received: from mail-dm6nam10on2117.outbound.protection.outlook.com ([40.107.93.117]:49728
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbgFXFph (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Jun 2020 01:45:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TV/Xhe497hRrVB9MJud4AKYmDbJRoxqKkLmwq+Iq1j+smyKs4vSSzpmc4oeymbKXNsjVXJVYeaJ4RDrZiBNMIWqTdQX5M3wgtjIFXrzYGrf5PSjFuVUxmy0smbLwUMoiJuSzsVbeykT2RME5Zm2SpYH8mFax6s1UBe+8oalT98DUl1yoAJeC2ej5Cv1+Imz9viud3a2q+MUnEhaL8oJwlxENGEzgehMydY4cgig1qn70/Wh7G0riGyp9Rbph5d4m2P7a7jp6XwggOgUpnWgheg4uB91QWA3muaAcYeODuh/NV+AUjo+VnIihEKuBQUNnWWmzsgTqZpMvz3/xxSno8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOpu3SCmk8RH9MxTQOa0ebjHLZPmK4OiYd7pso2JHRM=;
 b=BYAsA8DORCBQpQz2zoHTCClr/qufb69X87A/1MKQsJDeE4S/JH8WjzRnfJ963fMNOVZkrUXGyWdtJTia0yjkB+swtFOilSXHMlu+3EmHex2kGmBAoIPUWOD8W9KKO7reeqG6gb+fNuiCrP7u+l+I8psQowVTNWMtn+FubNi00AgmBx41aUjEBOs+T431MAgVSYwIedWf1WLD0DkSXhm7AutKK8AhuT1aO3H30gpue3XldBaELCppQdi0zGdEpIRF8qqRn+OORjlgyajRRsN0kc3QUGtHdZunDkXLivR/8ZEf+2IfozGrF5aBOhmxNaWT+avc4c+GszBFzomriz4V+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOpu3SCmk8RH9MxTQOa0ebjHLZPmK4OiYd7pso2JHRM=;
 b=WIKddf9WY8DwrsNSRUO37+kR/vJhml5t3xMh12JdDANs2pk5pWaMlEGYrIQ0J3ll+pxXd11ZuHDhPud2sZV2hf25gCXVZj1Mwo5pvRKjvMYUV8diJ6Ut4KyvTmEugK5Yly4wpWIgl3tSrcG4eyv0EUpTtC1fy8/JQtH7dtCE5ns=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BN8PR06MB5889.namprd06.prod.outlook.com (2603:10b6:408:c2::25)
 by BN7PR06MB3924.namprd06.prod.outlook.com (2603:10b6:406:8a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 05:45:34 +0000
Received: from BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e]) by BN8PR06MB5889.namprd06.prod.outlook.com
 ([fe80::ed59:825d:5fdf:dd3e%3]) with mapi id 15.20.3131.021; Wed, 24 Jun 2020
 05:45:34 +0000
Subject: Re: [PATCH 2/2] brcmfmac: Set pacing shift before transmitting skb to
 bus
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com
References: <20200622020721.498-1-wright.feng@cypress.com>
 <20200622020721.498-3-wright.feng@cypress.com>
 <83f89386-f5ae-91ef-d135-a1a0c9a55acb@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <c709a13d-d822-4f51-fc56-612a6fb1aebf@cypress.com>
Date:   Wed, 24 Jun 2020 13:45:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <83f89386-f5ae-91ef-d135-a1a0c9a55acb@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::34) To BN8PR06MB5889.namprd06.prod.outlook.com
 (2603:10b6:408:c2::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.16] (61.222.14.99) by BY5PR20CA0021.namprd20.prod.outlook.com (2603:10b6:a03:1f4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 05:45:31 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f1e133c5-c395-41aa-fc9f-08d81801cff5
X-MS-TrafficTypeDiagnostic: BN7PR06MB3924:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN7PR06MB3924F22ACB401A5222D295ACFB950@BN7PR06MB3924.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BszFF6qwDyP1mmK1bnRxUjmcSw7ylMGKPmK7ZAUBujQhISYiTloOe35hrRSldjWmr/rODwOfn1b1TRyDLYCS9pHaAVv4A1QYhIIDllZ+/oVlKVjZpP/KTviZmH/jkRRFSgZusKvVd1fj26kuZG8KwEN/qh4/JL/Ajghb0dFFm0nnIJwxIS02HGQrMBVYtK8gFdI+z1I6jquRO/vKEuejY+xPPbBUsoiHFQm6CzA6YSNfHRM1r0Bx0EkSDcFCWe1vTZTNnWl0L1iLbOkK2oVxj+HzIsyzUJ0nhmmI8VGxZuzoUtmz/n8sqXPc6fEe0yDxrQuQSECmtc1pJ0EebHl1x+gHyKmoSwsy9kj6pfCbmRpZlGmCYBVaF8ECywxVzaf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR06MB5889.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39860400002)(366004)(376002)(136003)(346002)(107886003)(6486002)(83380400001)(8676002)(2906002)(31686004)(478600001)(6666004)(5660300002)(52116002)(16526019)(53546011)(26005)(54906003)(186003)(16576012)(66946007)(66556008)(316002)(66476007)(8936002)(86362001)(956004)(4326008)(44832011)(36756003)(31696002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 3JViyj2Y4J+7qVNZwTWv45RRGBVEn7fqpsawqT6qspi/eHRHCfxrriSB6IyexLEBEnTPbnl6xgazra4m43noPRHptVz2Rq1/73IxOb3lP48gsTzzr2V1kch9AUBjC1WENNPCgCFKaFQG1Fv3jkRAsjHAs99Q73Q28iqvijsi1U3H4+pe5KkAFoyiFCg5BQyG0LFHi0CUgrtGd9/ABpES/yJp6u/TefJqbtk40Hkv0+S/tcJTfg/3F8nCQefZnlX/DyJxq0/rRplMfo/agK7N9ggZUvXncwbh6B3ODUEH7ak/NQKvR5O8Bu9d03pqE+QHfINlz2CQ7FBiNuNq+rH8IS6wGeicLt/eiYxeE4rMTLeVDQot/FHRRMErgyH7rulOYODvkPTt7ANMsykHPf1I6DJmWIKmcdWRba5phDKgGBc+kZUr0UmbpT3tCvdcItt7DVGfXVRc+AFmDPLuSiTJ2Kw+ea7IDWngvnu8U29YZek=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e133c5-c395-41aa-fc9f-08d81801cff5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 05:45:33.9901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9MOIettDzu8rLdEKsU+Dw7+eoLejmGwEcuBQeKMdMcw2pQXQNauND4ExhC4/6W0uBkVHfQobFZWeQI3ZEG/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3924
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 6/22/2020 4:57 PM 寫道:
> On 6/22/2020 4:07 AM, Wright Feng wrote:
>> Linux 3.6 introduces TSQ which has a per socket threshold for TCP Tx
>> packet to reduce latency. In flow control mode, host driver enqueues skb
>> in hanger and TCP doesn't push new skb frees until host frees the skb 
>> when
>> receiving fwstatus event. So set pacing shift 8 to send them as a single
>> large aggregate frame to the bus layer.
>>
>> 43455 TX TCP throughput in FC mode 2 on Linux 5.4.18
>> sk_pacing_shift : Throughput
>> 10: 190 Mbps
>>   9: 216 Mbps
>>   8: 233 Mbps (Max throughput)
>>   7: 233 Mpbs
> 
> In this patch the pacing shift update is done irrespective of the FC 
> mode so I would like to see similar measurements for the other FC mode 
> configurations.
> 
Measure 43455 TX TCP throughput again with different FC mode.
Here is the result and I will update result in patch v2.

43455 TX TCP throughput on Linux 5.4.18
FC mode 0
sk_pacing_shift : Throughput
10: 245 Mbps
  9: 245 Mbps
  8: 246 Mbps
  7: 246 Mbps

FC mode 1
sk_pacing_shift : Throughput
10: 182 Mbps
  9: 197 Mbps
  8: 206 Mbps
  7: 207 Mbps

FC mode 2
sk_pacing_shift : Throughput
10: 180 Mbps
  9: 197 Mbps
  8: 206 Mbps
  7: 207 Mbps
> Regards,
> Arend
