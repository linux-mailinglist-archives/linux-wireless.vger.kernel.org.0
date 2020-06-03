Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D94F1EC9A5
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 08:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgFCGkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 02:40:55 -0400
Received: from mail-dm6nam12on2134.outbound.protection.outlook.com ([40.107.243.134]:32161
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgFCGkz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 02:40:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTMzD0k+PsBEeFEc0/wroDNkLBI8e3iMxH1bvDskUGrZ3Fgp+DYUOHsAHs9pBocipnAUBkkOmWGqixHsyhou/U1EoSs612Hm3+KuzWrwtzdziVxCzNZQuJXXgRmizP720NB2ZSUFrr7+bfwAWkUZjRxDW/MQo6rIwwlYhoEKKhykO8mxnz8rd0uyHgHsid2z8SOYNmiSi/631NrzrFif4x8cVpe/iVtxJrHw9MGP5zB/MDapfrt5Ql/NThV2fhuJ5DtomLb2bGeUWAOEEqpPxNTIAITIIe/AaebGQOogl8mrxxVS5RvSeC9FWk+ZX1N6GrdQkaRnC2DFWw1SqJTbNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwaCu+fkRQlMxNU81rXoF4YaX8bSZmcahvHQbDAdSUw=;
 b=Mm7puI4qe4K06aIz4C7CDT/McnYl9qCGPheRll506qIiPFcoRcE713UXYJnsujWqzBHKUN4Rc3adcr3zEUX/BCw1C3P4S6jAI1dZJpgcIG+o5iDETPHZOfg/169faci0FwKeeK5t58BGX9sarBu6No6qFKB+07evna9kw4siMsoyfCC49/HFo/ionVYrzp5X2Y8Wi6yDiJwDQtM0cufMEyF3vS12YLbGvH/YGNeU8D02wRPh99ROz67oIGQmCv8P3nYSDT4/B9LsxinPJ07oR0JdhnEiss1EdbEdC4Bp5rpgIGszPTJ+EeUzOjpd4aFR58dd1MFKimJbjyE/wZ7lWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwaCu+fkRQlMxNU81rXoF4YaX8bSZmcahvHQbDAdSUw=;
 b=b1JaxLmyAWzf5a3CzA0hvJLoBTFGEbUbsgq1Zn6RFlD8qiX9N/cBsmS0CK4doqGbN7WpWCnWwLZafR7kpZAMrxYeIGJu4X1ysioA1f9jbb2GC/fkNSU6dAoXOfAKEDTTYlVEkJ+ZaA65OmdRREc6U0DbY06GUSZm0b4pqq8MfzI=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from DM6PR06MB4748.namprd06.prod.outlook.com (2603:10b6:5:fd::18) by
 DM6PR06MB4393.namprd06.prod.outlook.com (2603:10b6:5:1d::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19; Wed, 3 Jun 2020 06:40:51 +0000
Received: from DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb]) by DM6PR06MB4748.namprd06.prod.outlook.com
 ([fe80::9f0:c02f:7b54:51eb%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 06:40:51 +0000
Subject: Re: [PATCH 1/5] brcmfmac: To fix kernel crash on out of boundary
 access
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>, chi-hsien.lin@cypress.com,
        Raveendran Somu <raveendran.somu@cypress.com>
References: <20200601071953.23252-1-wright.feng@cypress.com>
 <20200601071953.23252-2-wright.feng@cypress.com>
 <8fe5fdf5-1b26-a127-3567-321017455a49@gmail.com>
From:   Wright Feng <wright.feng@cypress.com>
Message-ID: <69c1658c-fb6c-e410-49df-2c98cb8501b0@cypress.com>
Date:   Wed, 3 Jun 2020 14:40:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <8fe5fdf5-1b26-a127-3567-321017455a49@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYXPR01CA0049.jpnprd01.prod.outlook.com
 (2603:1096:403:a::19) To DM6PR06MB4748.namprd06.prod.outlook.com
 (2603:10b6:5:fd::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.236] (123.194.189.67) by TYXPR01CA0049.jpnprd01.prod.outlook.com (2603:1096:403:a::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Wed, 3 Jun 2020 06:40:48 +0000
X-Originating-IP: [123.194.189.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bb1a818-3273-427e-d8f6-08d807890ecc
X-MS-TrafficTypeDiagnostic: DM6PR06MB4393:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR06MB43930D48DACCEE8DB678D4E0FB880@DM6PR06MB4393.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-Forefront-PRVS: 04238CD941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsl1AsL4RjkPEYtnwc9aGlHKlx8lQdsPfL7/GT11XIO3rTZnRP80HBDvXjn9RHYk8zulizUpjixo+4p0D7XvnLJ5+5BiJ9C2B/nNWUfU0IYLyglmwmKldhNXeyb7OMn1QHsEqKfcj9RodepqvlDoTkpN3GsP4VhZxbrxNBPB5GDVeSz+2zaMnKrzsXRNZPP6gn/ASkbrXYGviWXmg8MOxD1XzELgPC725RiJVYJadXVe82k+TPJnnQdvVgTLhdkfZrywJwWrgoDN5C2zbyeBOgLH3R3n7EyDz8h6TCP1bxzpZJEYVXqfXvGrSC+EQ/ftWwteH8eSOxGhrFvoAUSalibetFI+Lj9vG00bj+pHkdbUf2y5ep+VahgYozIKCBxT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB4748.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(376002)(366004)(136003)(346002)(2616005)(956004)(36756003)(2906002)(4326008)(52116002)(26005)(6666004)(5660300002)(53546011)(186003)(16526019)(8676002)(31686004)(6486002)(66946007)(66476007)(478600001)(107886003)(8936002)(86362001)(54906003)(31696002)(16576012)(44832011)(316002)(83380400001)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: nLm1sSchUlrEWIAAPWpfb5j1rOc2Ob3EQ9J6sIbc4O3/kleUEQDjxeAvGg5eaMngkUjvCReyjLCBbhBn/nkuR7RW5txAWJdy6DnLmjKANB/i7MGShN57vnfDuqybakxnd9uMkpxlfN0QgsFyJKGTJ0HwkJKt1MuJ57mHf0TUfzpeabEesK+QZ125wCeaB3PzO5Ourec1wOsMBHv4vqG0biRDVo6t6Z7v6k90MggPapkfzlhGH1/Q4IV6UMOO2y5mYfFO4/Jje8bOkP5u5bApj/aI8+DA0sDIbiuwex59mTEzCyna5xPCnANExG3kt1zpst4zUevyme5uPyVDfdk+kGIO1BWU+6I1lKFp8L3EcZjL4mV3HseElPblFRGwrbSsO7JAJ7bw5WvOUNA7Ar9Gdbz5apCAs8CEJyEBUPqWBPFmXtaoSRN/pBHYUOnkdF5TIO24L0+3E5WT9StricH/O1seTBZ4tupjJwewPzhHiaM19xVKK2WwMzabJK6HmVaw
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb1a818-3273-427e-d8f6-08d807890ecc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2020 06:40:51.6239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OiFl3K1LUHDQGyeO2h/IgpIBFvcQE2S64AeTH9O2Fm2Z9wtUaR3FhYbFEPcFXdt/ZdTc3/leZuJytuiyvUQiCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB4393
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



Florian Fainelli 於 6/2/2020 12:34 PM 寫道:
> 
> 
> On 6/1/2020 12:19 AM, Wright Feng wrote:
>> From: Raveendran Somu <raveendran.somu@cypress.com>
>>
>> To trunkcate the addtional bytes, if extra bytes been received.
> 
> typo: truncate. Missing "have been received".
Thanks for catching this, Raveendran will correct it in V2.
> 
>> Current code only have a warning and proceed without handling it.
>> But in one of the crash reported by DVT, these causes the
>> crash intermittently. So the processing is limit to the skb->len.
>>
>> Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
>> index 09701262330d..531fe9be4025 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
>> @@ -1843,6 +1843,9 @@ void brcmf_fws_hdrpull(struct brcmf_if *ifp, s16 siglen, struct sk_buff *skb)
>>   
>>   	WARN_ON(siglen > skb->len);
>>   
>> +	if (siglen > skb->len)
>> +		siglen = skb->len;
> 
> Does it make sense to keep the WARN_ON() one live above then?
Regarding the change, I believe it is better to have the WARN_ON as 
getting something more than expected is indicating the violation of 
protocol.So it may be better to leave the warning, instead of quietly 
correctly it, which can help in identifying the malicious operations.

If the warning is not complying with the rules, we can remove it, if not 
we suggest to have it.
>> +
>>   	if (!siglen)
>>   		return;
>>   	/* if flow control disabled, skip to packet data and leave */
>>
> 
