Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B3C1F4CD0
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2020 07:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgFJFTS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jun 2020 01:19:18 -0400
Received: from mail-bn8nam12on2100.outbound.protection.outlook.com ([40.107.237.100]:50912
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgFJFTO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jun 2020 01:19:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJdjOSvDAUGu2/G6QlsjFzl9jiosNAKCQiuMxiqlOMf3anp8bsgaVlMlByGMoZCYsbqKpEbThG7ZdaIa6ihxdcaGPbr2JPaB4L5k+uCYN8ACy4T0ET5RpbHtsr2Fdwze2utZAG6J4QPRfKpq6Xk2pX7YUHRM22lRfRJ2Xm92rJh23Cl1mKTIpfYhx9v1F4fKy9YBjeLehL96o5mUu//fGjYWzEdTZv6tqOhx6pcIrnFc4d1+F1/8Q9jg7B66Z6aiKU+p71pizvYYyB+5Mv0P699yslNnjEKvLqCeV/KCBzbAtDZtpPaHCH4vRNYqVvxGpjP0DrJGIFF9+kuhf5FnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fefTwR9CiBtiysz5UUSyhhzzdWmyj5L/MzeJjMS74I8=;
 b=i3VYKyvltUdAid8zDJuNEuLUGEMXrqsVdf74UhGqjOZ+9p2Rb/R/LEgk3VEVt/jvy+KtCWzHBGlxaqQIk9uhfrkZ+6azBToe48Vb53IOvpAaXEMlVmgXE7PNOpbHZ2Ux/3N0jrQ7LT5Dyf5xWL1UfRT3AgHjUT1RpyFElhMft++LNVoS1VytK8dTC54l+slzXXE7/Wv6Oq33xDOD/3Kx9ndoARQ/Mwp5qKiU+SUjhCjnl7ICrysx7rpr3aebWf1Oj1YWhcEj3t1ZwrnGncNQCH/v+bgg05pLa/Yuh8ZNhFSX8oiA31UQIzD66ymmJwpz9fkSa/+1427AL/haELoaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fefTwR9CiBtiysz5UUSyhhzzdWmyj5L/MzeJjMS74I8=;
 b=JhaBeSup1v7G0lZyng/wtBnFVkjuQzBme3v3UNY654ghBHpHu38csDak/76vajTzJ8YjRobrbM+cQAYQC8V37CRKn+ZgriSxZO5/JO5dOvNHlAYGkQzoNsgIibN75rSDEMikqCEfS/hXhusR9kZYV2tP1IrAe7zGSrXEG2J1YIE=
Authentication-Results: cypress.com; dkim=none (message not signed)
 header.d=none;cypress.com; dmarc=none action=none header.from=cypress.com;
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5288.namprd06.prod.outlook.com (2603:10b6:a03:c1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 10 Jun
 2020 05:19:10 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::b972:c25d:c8fc:fc0e%7]) with mapi id 15.20.3088.018; Wed, 10 Jun 2020
 05:19:10 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 3/6] brcmfmac: reserve 2 credits for host tx control path
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Amar Shankar <amsr@cypress.com>,
        Jia-Shyr Chuang <saint.chuang@cypress.com>
References: <20200609105913.163239-1-chi-hsien.lin@cypress.com>
 <20200609105913.163239-4-chi-hsien.lin@cypress.com>
 <873674o3t3.fsf@codeaurora.org>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <d9985b4e-992f-cd08-c2d6-b2b3c3834706@cypress.com>
Date:   Wed, 10 Jun 2020 13:19:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <873674o3t3.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.9.112.143] (61.222.14.99) by BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.7 via Frontend Transport; Wed, 10 Jun 2020 05:19:08 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b900e90a-eecb-4622-d7b5-08d80cfdce52
X-MS-TrafficTypeDiagnostic: BYAPR06MB5288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB528812AE1005F9BBA6F57132BB830@BYAPR06MB5288.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0430FA5CB7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1MxDigff1mGZEzgd99FytY9q0sRKCseU2WXNOhyKNfdNN248kXkrb5QQ1rs68s9fTuVcRYtYCjCqi0cpJ0L5LaIznJ9txsXBNzS2e7BGkqDm0HkI6O64N5vgTCpXOXd5f0TOoLA46/WetOoAr3SrNdEg7vfUNIbNMnuyJjay6N9tluMUSuZRqICo+8DgS7ub35196AFfVNx81jMM42Nf3IuafMRMqI7znFkJOHKkry41F1eYlfbvVJU+JBDdzGu4hFnEs8m/0JkgIRuynjGTymSYPbddfKs8RaVyzK88ncj9iSpUWBkocav1HgihHJvoUfcd/lpoFPUTzSBnhtxMRaeFkK7ptXKfTACJMSiB5cJXbtGlFjp6vU1kqW7912uj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB4901.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(396003)(39860400002)(366004)(2616005)(107886003)(52116002)(8676002)(478600001)(4326008)(83380400001)(956004)(31696002)(8936002)(86362001)(16576012)(26005)(2906002)(3450700001)(316002)(186003)(54906003)(6916009)(6666004)(31686004)(36756003)(16526019)(5660300002)(66946007)(53546011)(66476007)(6486002)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 8rFOvggSQd/yY1sZXjVUSepFQLaPqriOeQAP7m6eJrq+V04HUXLol8KRZDvnLdwhMPro8kfVO0hEXFlsOA3hGMkA2egebhhUSf5Jyx+RfN9Yf8j1DLKqp6w8mNhTpOck0K1jLlbuTGXyul9/l96Tq0G3GInEhXeH+wEnTDoiL0sVkvqc6czAUjMv3AjFGXlLT2OZfCVi5uPkbjaNC/vf/ZYxz+yooSmIc9vy+ttZ3ZJvGSVJHqNSzCUrmHexSj921SeYliXfxXBj+JloBHhGYKAcrb9l+qoLJ6mRJi+XKu8jZlJLdwGPovH4u+fGvctESl7QLzduO7VDSYCsLHR3rWJ/eP5y7mE96ik2dtoiHKG9Hqgj5j0xgbT8b9jzXs+G1InfLxbpXvcWkaFq5+PymIv6YO2BO5WLzS8PGGXB5Wxn83KzLKHYuN9QnBdEeqYjyooJ/v/bqNNypzGsm2zthCo/13Tr5zMj8n2sh8v2Ag8=
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b900e90a-eecb-4622-d7b5-08d80cfdce52
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2020 05:19:10.4847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9HWkXxo96IeAD0VK32nptmYpw907+T/L0vuzHD03/+gcPyEIvx9jVZQAF1J22Rzg40EhfCxWH1xkZ9+++NRIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5288
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 06/09/2020 7:51, Kalle Valo wrote:
> Chi-Hsien Lin <chi-hsien.lin@cypress.com> writes:
> 
>> From: Amar Shankar <amsr@cypress.com>
>>
>> It is observed that sometimes when sdiod is low in tx credits in low
>> rssi scenarios, the data path consumes all sdiod rx all credits and
>> there is no sdiod rx credit available for control path causing host
>> and card to go out of sync resulting in link loss between host and
>> card. So in order to prevent it some credits are reserved for control
>> path.
>>
>> Note that TXCTL_CREDITS can't be larger than the firmware default
>> credit update threshold 2; otherwise there will be a deadlock for both
>> side waiting for each other.
>>
>> Signed-off-by: Amar Shankar <amsr@cypress.com>
>> Signed-off-by: Jia-Shyr Chuang <saint.chuang@cypress.com>
>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>> ---
>>   .../wireless/broadcom/brcm80211/brcmfmac/sdio.c   | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> index ce6f15284277..163bb7f41e44 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
>> @@ -635,6 +635,8 @@ static const struct brcmf_firmware_mapping brcmf_sdio_fwnames[] = {
>>   	BRCMF_FW_ENTRY(CY_CC_43012_CHIP_ID, 0xFFFFFFFF, 43012)
>>   };
>>   
>> +#define TXCTL_CREDITS	2
>> +
>>   static void pkt_align(struct sk_buff *p, int len, int align)
>>   {
>>   	uint datalign;
>> @@ -647,6 +649,14 @@ static void pkt_align(struct sk_buff *p, int len, int align)
>>   
>>   /* To check if there's window offered */
>>   static bool data_ok(struct brcmf_sdio *bus)
>> +{
>> +	/* Reserve TXCTL_CREDITS credits for txctl */
>> +	return (u8)(bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
>> +	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
>> +}
> 
> Why casting to u8? Is it really necessary?

I don't think the casting is necessary since tx_max and tx_seq are both u8.

The code is taken from a similar function data_ok(). I'll remove the 
casting from both functions in V2.



> 
