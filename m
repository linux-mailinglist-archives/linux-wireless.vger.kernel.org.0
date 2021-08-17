Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BED33EF063
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Aug 2021 18:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhHQQtT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Aug 2021 12:49:19 -0400
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:55437
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231285AbhHQQtN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Aug 2021 12:49:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGGx3Tso7JaZhGov3H45t2gQ6/hExlgdG+aY6eLdPhG2n+LqkjwZYLfGQ508sHbhf6avXvQiHnn2A5G/MqRgVh6qyrUmcJbJFjs82OgGqiqyw/FUZ/0A65TjGNKrfCJWsNS1MQVMvM2N7YK3JIU00mnNbjy9qcw9lBYF9fG3DD9pgHpZrALqDIUliJlc8Bggxe0d47Gss5jqeoS0Vp2cb6k9AZsCQJPq8g/75lSOq6ISsT88HNjo76iu95kq7SOTMJ/sZkZ0sItWRuRhJTV97cDKzpef3PRCtJ8Z9bV4VAHlO2Y2qJ+9gomh2h0p0WqVAq4LnOUdILDDsTmNBY3dvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK23zKh+1wQQOiF7BHnofW13ZvIpt1COfGn8CFN3Cjs=;
 b=CfleGAxSGPhRWcFfIMVYDgQSt1OhdeqFtS5FyniQQjuni/HnIa1+KxsOAXyGAHy1eJKKl1hSF8vZKT+wdPFV1Xx4yz+A2/CWYOMY2wWBe0JXYVRs1taWeH4XGrvzELPX+Nm4gGze5FvwoqJ45j55eaAcomo/nvRcg5YrzlnTn9t/4YYZd0AAvEWSY0QqJZAq9MFnAiQf0GnlGJi12WRodsrUeboZRtuvl/WoNyEDPvaylLiiX95caDaNTOpzk9nhCrawgbbi3VFj/7LZMQ+cRGn7wKyTLusYY0ae7iq1kus+bhmQVzcjNzNucpeNL+dUXerEpFgCuosmVdu+bzwxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QK23zKh+1wQQOiF7BHnofW13ZvIpt1COfGn8CFN3Cjs=;
 b=nLwavwMQR2syBmYN20N11DAXXX2axtqRvyLGGXfbS3Y45nY68aWIebTPKDUC8sczPM7vYHiIMyBZacRfwelIRAwzTn01PDc+uYegOC8AdBaS24+2C4HNsIuxkl47I8SR7ytYOzZEAFT/P8n5If4OnxAn3qqn69QLGPiFqwmQXcE=
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB5882.eurprd03.prod.outlook.com (2603:10a6:10:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 16:48:38 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 16:48:38 +0000
Subject: Re: [PATCH] brcmfmac: Set SDIO workqueue as WQ_HIGHPRI
To:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     Chi-hsien Lin <chi-hsien.lin@cypress.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Tejun Heo <tj@kernel.org>, SHA-cyfmac-dev-list@infineon.com,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        brcm80211-dev-list.pdl@broadcom.com
References: <20210802170904.3116223-1-sean.anderson@seco.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <e6eb89af-b81e-b96e-70a6-c9498eb681fd@seco.com>
Date:   Tue, 17 Aug 2021 12:48:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210802170904.3116223-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:208:32d::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BLAPR03CA0054.namprd03.prod.outlook.com (2603:10b6:208:32d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 16:48:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f767c96-9dbe-4dab-de46-08d9619edc5a
X-MS-TrafficTypeDiagnostic: DB8PR03MB5882:
X-Microsoft-Antispam-PRVS: <DB8PR03MB588213FB5CB12C7621D74EBE96FE9@DB8PR03MB5882.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OzkjiU/SvaXhCQEedkO7am71cG03j8yjEljcfzqDvayxXWPdLFiZ2ftxYfZnjyDRppD2jvzPhsAb4oCx5yz8NOTQjOsuLPhrq/N5VKCco6XTCifwPz0ikFzBu50VOSq03vJX5s9xGjo8Z8ntkSIv68M/VFNB02k2NF13rEM2OznJA89PN6LqMk6qSIEe+yWU7pvii4NzsXljsJ4+VedIHaE830LltPrHBChda5omMBekV7+5FoJZA02dm9Adg5mtWDFi8wsy/f0tC7fuMWcH3psuR2rMxnrdOgALxs+dmgVoBQMQ+np80sCUO8EeiSTOkpvJRcHQhGGccJQz+ga80AGZQg9yiQ+bxc0N2WeNFEpB2eDG1/n0Xqy1n7HFLI5v13RL+qqFfpsz/X9MDD6qguYfn0BxJEBtt4xpZRqXDOJCGREIlXJpr+683HZheE+T/USfLQh2WAa1TGgmTR9hZkn3iCl1qF2Q4WyArExVyqDbRRORLBRD+uYbvZt8cpAXVPwR8b5bA8gbA45aXVK3rvRek4hI2ouzv8p2KdcmV2WXrQM0S1/YVYZicURoYARuHJzEDTJogDYCZEKWkChqFAr0oZl63Rw+buGolVPVHW7C1rC4MqTt9D2zeyV9vcmGysUxwYz1RjaQ9ByP1kPdX5JzJc3/0xN4rvOD/viPpNQ5tLtVCEdz2bLjJiArk5fL+dmqLcRjlPjXD5Fih3BDGzuZ4UfWUivoRl8vz/DXpoLBwfvAUzxZuG+UjU53AT7dFW5KcNOkID/9NbdlfHzVKpLYOoDVpm6o+p61tPKxH0/T3Ls0A8p0OHhunBaXFSx2UE5895Q8rV7jTkFJ05bwwxUfAQ0IDmnonkW/efEZEBk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39830400003)(366004)(396003)(136003)(4326008)(6666004)(186003)(38350700002)(6486002)(38100700002)(44832011)(31686004)(26005)(6916009)(2906002)(7416002)(54906003)(66946007)(66556008)(66476007)(31696002)(16576012)(52116002)(316002)(956004)(86362001)(8676002)(2616005)(5660300002)(53546011)(83380400001)(8936002)(478600001)(36756003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdDcHlDUFRSK0hYREs5U0d1TDNwdjNYaG43eFZpVUhIQXlFQmdiN2V0Nklx?=
 =?utf-8?B?dU40U0Y3L1RzcGROQytFMk5aVUZMNmRJTENnY0dIY0JGREN6M2I0Nmcvd0VN?=
 =?utf-8?B?MG04b1pscW5XdVdRL29RcnJnMmtBWFNJWEVob1VpRzNJNmNnL0ZBVjBhRit1?=
 =?utf-8?B?UmUrMHVKa3RlVjNyODVlcU94OEk4bk5lVlV5R2FjUlh4d2lXK215enJmM0Ny?=
 =?utf-8?B?VXVoQ3VvQ3A0dW9BOWdQOVFPeDRnVW9aOFhWNjIyclBJOGkwRGJjd0Y4aFRp?=
 =?utf-8?B?Z1NQRDMvWXNBR21pV0hpQmRrL0JSQVVaUmppakwxSEpJT0hsc0NwSEc0TnRZ?=
 =?utf-8?B?WDhEYmltYThwTG1SdkpxYW5qRmx0WG1COWNRNk9sNmZRMEhxZkx2cnFQMC9i?=
 =?utf-8?B?aEtlNmVIWlI5OGZ1M3FRS3Y3OURveHJIV2FGcGpVdXdhelFxTkxyUGVsRGpO?=
 =?utf-8?B?NXI1RXJLOTVvZFpXZGZKZC9iWXRkVDJ3cTlJT0ZEbkVmbGF1UmpDbzNmRUhD?=
 =?utf-8?B?MEk5K0hlcnY2VnB6YW8wblF4S1luZUpsKy9OZkJzQWxkQUpQMmkyUTd2SEpl?=
 =?utf-8?B?YXpFWFVQK0RHbThWOXhycll5czBGZ2ZWbEhOT3BaQjNaTFV0aGlSWDhiNDVh?=
 =?utf-8?B?b282UE1jcDV0VE50ME54TmRUVURaQlFlK0RNeVVEQ1ZsckJxVnRJYzF5dks5?=
 =?utf-8?B?RmcyQ1lDbXNNTjMvNU96eGxSWHhsRUl6Y0t6VUViQ0J0TkZwUzBra3dnd2t2?=
 =?utf-8?B?SlJ6bHNWalJKSHd2NU4yNnJmZUJtNEh0QjlpWmdmZENKdFVHQ21nZUY0cjBj?=
 =?utf-8?B?andqWkw5V3d1L2pTOTU5aUEzaWM1clQ4VjVxdXU3L1A3aWhmSmtZN3NOTHhj?=
 =?utf-8?B?TGU5a2JldU1mTTRqbWI4VlhWcEtEbWJlWmg2VTZkM3dYdGJKUjlCQUx4NmVS?=
 =?utf-8?B?TG9GcmRFN21jNkNuV3p1NHhvT1BmQVRYY1BaVTRlS1hXcllCQUZOREdLQXd2?=
 =?utf-8?B?c0x4cno1bEpDd2NWeEg0RHppRXZXalRxMUF2aXFyOTdGZjZDdEpDVlFmaUh0?=
 =?utf-8?B?cTVQcDRNRXZhWE9VaCtya0Q3dTlFM2RKL3RrdFZzTmNTcU1peFdaS3IvV1pP?=
 =?utf-8?B?L0NNeDdKTHBFTEw2V1VobkgwbU9uZkFKaFNTU2ZsVDE5b3pibFE2dnQvMVY2?=
 =?utf-8?B?cUFsWmRLbndtSjRPcE5ydW1ZYXNVMlZmL0ZCa1E5ek1WTTZzei8xRW41eVQ0?=
 =?utf-8?B?bHErd3ZzWTR3Uy8vejJFWkV3Y0NxcXBoUXpIbzlENWRtVzcvYmpuVmtmSmFR?=
 =?utf-8?B?WFBzM0VIdTVrZWdTWTIxUmlMbUdBZlE1RGJIYXFNbkIwRlkvVDVxZDdENCs2?=
 =?utf-8?B?NWoxVlpwZGZ1eitrZS9oRWF3TmpKV1RzYTNIcEJ5UVJxWVRxeUIvNHpmZWla?=
 =?utf-8?B?UmN3SWZjTGh1NURWN1hSNzZvQU1SV3ZYaDZpODZwR004QjcvYWx6T3EzdFg1?=
 =?utf-8?B?L3RVT1VyWXg4ZkkwakwxckdqeExCcUs0YW5rVE9tejFCT1dTdldXUmZLOVNl?=
 =?utf-8?B?VVhqOGhyYU1RakQzY0l3c0FNQ2czbm5vTWxwVnhqMHU5aFFZeWR4NDdLa1A0?=
 =?utf-8?B?eHpiOUM5TS9ZTDJjV05QV0JIUm4rNkNGbHhnaE5DbHBGdG5iQnJPUC9TSzdq?=
 =?utf-8?B?VzQ0MEV4ZkFiaGhBdzZxdFhBRmI3aS9GZ0IxQWlnWTVtYTZ6OFE2ZzgzWnRm?=
 =?utf-8?Q?WAFQVx/lxBiR22vjzSVt1dbTmRzHaoqNdKYkCtf?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f767c96-9dbe-4dab-de46-08d9619edc5a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 16:48:38.0264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rk7dxnqzkh7P4VEEBQzcpMhdfQYfNcqV5oPe4Sp2qEnhljsSb2p+dAGOmpmgwa2oNBMNnGyK3D2KhZyHGD1roQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5882
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ping?

On 8/2/21 1:09 PM, Sean Anderson wrote:
> This puts tasks submitted to the SDIO workqueue at the head of the queue
> and runs them immediately. This gets higher RX throughput with the SDIO
> bus.
> 
> This was originally submitted as [1]. The original author Wright Feng
> reports
> 
>> throughput result with 43455(11ac) on 1 core 1.6 Ghz platform is
>>     Without WQ_HIGGPRI TX/RX: 293/301 (mbps)
>>     With    WQ_HIGHPRI TX/RX: 293/321 (mbps)
> 
> I tested this with a 43364(11bgn) on a 1 core 800 MHz platform and got
>      Without WQ_HIGHPRI TX/RX: 16/19 (Mbits/sec)
>      With    WQ_HIGHPRI TX/RX: 24/20 (MBits/sec)
> 
> [1] https://lore.kernel.org/linux-wireless/1584604406-15452-4-git-send-email-wright.feng@cypress.com/
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> index 97ee9e2e2e35..5e10176c6c7e 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
> @@ -4442,7 +4442,7 @@ struct brcmf_sdio *brcmf_sdio_probe(struct brcmf_sdio_dev *sdiodev)
>   	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
>   
>   	/* single-threaded workqueue */
> -	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM,
> +	wq = alloc_ordered_workqueue("brcmf_wq/%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
>   				     dev_name(&sdiodev->func1->dev));
>   	if (!wq) {
>   		brcmf_err("insufficient memory to create txworkqueue\n");
> 
