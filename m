Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8059518C89D
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 09:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTIFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 04:05:03 -0400
Received: from mail-mw2nam10on2118.outbound.protection.outlook.com ([40.107.94.118]:52096
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726654AbgCTIFC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 04:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSXv5qlaXVRo9RQiQVVj7DqXCSzy/NlS8EyIj04u3OrwQHNS3BQBAFMT242pFLijJL9P9dRqkNjPak95KhtlnpftXSXVt2rLvRVlyPZSVKP4nLPnAVel34xxppD21hqPZcDUvELEAfpW4H714igXMJySErmkyJUCetryj/YVhO31CGDXxDtnxVChHGyKdV4VPq/8KY04HX+cCtVm8dxeUWa1gG9vH4qYP6006LhtOgkWWMA7arWERCjKYAf7CDiXkNaYPaKSdzSfERX9J2ZX0/I1gm7w/UrwsoQQWJ/MgBCjJjsYayCdEbVCDSvdeqboNydZJ98i5Si0rLaEcRJcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqsO6ChMTIp1WKxxlYtiddNm2gXJ9cjn56X14kO+AGQ=;
 b=Hu3JIAG/rudi39KEsbHy7UnuHnqz20AqlvROny79E8XUXnFbAujzWAnlnQprxTzyUirdwT5II8ysMM5cD2yIgOYyDpSnG0609OXPlOeOyqpye/nzoS5W2SUpEGSFx4JgcNRnqK39VlmvGqJV6zCW/UffI9tZkI77eCm/B6gqj87VZTOf+3xnvurBCgyMtJPdNf6DkIfgXdWFN9BUvS4Xz5jr7eiQ241mwAw/J8yZBbuBf2GUr5R7N7knSGP6krRM0DEZFfnTTXCOaZ/jpe5ZLHeZhMyP+nLaNCRMU7elyBXVFqOGzuVyawbKF9TnCzbZZlDGmTI3ej98xW3LnnAWMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqsO6ChMTIp1WKxxlYtiddNm2gXJ9cjn56X14kO+AGQ=;
 b=bgVAu4/bpvdUkSctEGS/UQiD8lwLg5cVE39TiRAN2IEmQ0zTZ/aZrFjR8N1K5zGL7ZDrrPE5G7remd5naQPJ7JrsWEfndrg1biWUAapXjgne1klS0kfgYFvof+ioOOXWTy0wk/VyLar1DSUPVBEPbueH1lHWw/vPgWosdVs7aRg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Wright.Feng@cypress.com; 
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB5577.namprd06.prod.outlook.com (2603:10b6:5:119::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19; Fri, 20 Mar 2020 08:04:59 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::299a:b6f7:1338:e451%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 08:04:59 +0000
Subject: Re: [PATCH 1/3] brcmfmac: support AP isolate
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@codeaurora.org, chi-hsien.lin@cypress.com
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
References: <1584604406-15452-1-git-send-email-wright.feng@cypress.com>
 <1584604406-15452-2-git-send-email-wright.feng@cypress.com>
 <32bb2e43-76f5-5c41-af20-3cec1baa7bd8@broadcom.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <bdf0b3ea-6934-8409-52b7-1ccc2ef56203@cypress.com>
Date:   Fri, 20 Mar 2020 16:04:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
In-Reply-To: <32bb2e43-76f5-5c41-af20-3cec1baa7bd8@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:a03:40::26) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.177] (61.222.14.99) by BYAPR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:40::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Fri, 20 Mar 2020 08:04:57 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dab5f877-db31-488e-a940-08d7cca562af
X-MS-TrafficTypeDiagnostic: DM6PR06MB5577:|DM6PR06MB5577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB5577B7905C404594AF71BAA1FBF50@DM6PR06MB5577.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(53546011)(316002)(956004)(6666004)(8936002)(16526019)(2906002)(4326008)(31696002)(52116002)(81166006)(186003)(86362001)(8676002)(16576012)(26005)(2616005)(6486002)(36756003)(81156014)(66946007)(66556008)(66476007)(5660300002)(31686004)(44832011)(6636002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR06MB5577;H:DM6PR06MB4748.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6sBuaehFy51qvwHtJvVNcubnPl/uirvrLI/59JY94RyR91fkll6l/XtJnrNHXJ7TxwRQ6CqfTe8ern+Gb/9874nx1C7PHZXbBGOmPjts6mLsGEpEL6+Zq4NqA98ModJAAYfhdblv3S9loDDuF/4k0bEAQRtzdA4d7g4kZXTQAmUqsjWccOBKDb4BjdcJ/dk9n8Txbs3UhIhVgQTSLzAKXFmYyrY4lezutOq17SaoJ9/k5JWgpmrx0odLL5pFmLAQ3GTz/fT85OkDIjrnSgmRtEcq79T27xaozdTaf31SAb32YrJx12CLXe1bIXmMdF4gv1KCEjzMyHJOHkaG/6dfz6HYlcS5DgRxUReT7HF0fu+BmWfUImB9vbzEBnH9B0y/IrgdEjiP1ZSqcziYnblJvdm1nFtX5yvZH2LnWwOXtrgMVXhqyGiHAiEuuuUGuyE
X-MS-Exchange-AntiSpam-MessageData: KNDTtBxU5iguw9V6QzMsq1DuwjNMVnnqa1Rzp12/qrepaGzyeSZILXbA3b6o8VJ28FRHKgZHhn968v4GdFU0iFMnWSw9B3j7ZkajSvmhLwOmEjRrnMwFUvWzj0mkhRgBYstlTEN2kBMzUWqKIL6Dzw==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dab5f877-db31-488e-a940-08d7cca562af
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 08:04:59.5232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcPVLjXhJjxMYTxGB5rZnvYOFmKsw79plZdOhInS4ERKPyyToJG98MRZeyG3iLr2JEMbSswiBSDY80ayg97IiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5577
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Arend Van Spriel 於 3/19/2020 4:48 PM 寫道:
> On 3/19/2020 8:53 AM, Wright Feng wrote:
>> Hostap daemon has a parameter "ap_isolate" which is used to prevent
>> low-level bridging of frames between associated stations in the BSS.
>> For driver side, we add cfg80211 ops method change_bss to support
>> setting AP isolate from user space.
>>
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>   .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 21 
>> +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git 
>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index a2328d3..eb49900 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> 
> [...]
> 
>> @@ -5421,6 +5441,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
>>       .update_connect_params = brcmf_cfg80211_update_conn_params,
>>       .set_pmk = brcmf_cfg80211_set_pmk,
>>       .del_pmk = brcmf_cfg80211_del_pmk,
>> +    .change_bss = brcmf_cfg80211_change_bss,
> 
> maybe only add this when firmware support "ap_isolate"?
Sounds great, will do it in V2.
> 
> Regards,
> Arend
