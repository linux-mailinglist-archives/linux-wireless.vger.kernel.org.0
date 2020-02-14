Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1D615D9DD
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbgBNO5E (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 09:57:04 -0500
Received: from mail-mw2nam10on2100.outbound.protection.outlook.com ([40.107.94.100]:25408
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729241AbgBNO5E (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 09:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw9vhdYzPXs81YxSBkOpRFxTdZoUVMIlRGnL22j3CZBwpKtOmHVe+hl/9UBHA4Umd2u+VtB1kZWMoiuXrTwcx4ZzCi7k4bHEeotBJ9TA9gd34SoN6DrYS85l82DiKKlZdmAvBFJrIy6f6oUTUWOaDAKeO+a/K75xCn+dQSK5G0UYrGVxI+H3KON6QNNhXy+A2QlO6ExzaJfP/evMLquF/Rw9TGkRcC7Il+FpZU8uYQHBtIoCD6arttTEc+QTAkyPG0EWsCkGTl90LPpZgTc3Vlu7CuJHKyEZMqDVTh/gjxbu0sbEvJ0xfLmL1HSNl8g9nZsH0V0H0wy7trB0UxJSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq05MqqSMqAfNKFI8p8quR7HGOq3te0uJRG41TXsjRI=;
 b=DnBm1pfGUsNTNsuZ+D0vKF6Dd5r0Wb11hPp/PP8FwC7yIODeZO7jMeGaM50BdVwrSZlK895hCuKX/JRs6qD+8PivnNCkcB+fa0x+3YvsKENXQtJgl1NGsnA0AXFHGqAxTf6ZBpWf2OBsnluu0qsU5dF9w4kBrQx1crMLNqQeIniRuF47a6AAeZKjO/8P5TGYiYctftM4y8DUxvbODttnwO70augI8lD+N1YxXsNODmmj3v6fZrS2tEjhBASU2Uhx8mS4oCL8HlBwcU2w2kHbTPpg5jjKpVGd2mNmnldR0DzlOt+FspfeUlxvKji0HrvOtosmZXZGeAWf1ZfwctQUUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq05MqqSMqAfNKFI8p8quR7HGOq3te0uJRG41TXsjRI=;
 b=Q38qXwpR11QMb0IQ1T9F2D69/GDWawo7YevngcvZylk7SknWuQcro/TkAW1bvoLJq/PQKokMtIii+4fdL5VX2Blb4aqkT1/VoH73VziP6hba3MldPa1HFJTXi6HzPUmD8qiqRAMr9aBbFzHhBZZjcii6PJqnVxgqkjiwaFGzNOE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5992.namprd06.prod.outlook.com (20.179.158.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 14:56:59 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:56:59 +0000
Reply-To: chi-hsien.lin@cypress.com
Subject: Re: [PATCH 3/6] brcmfmac: fix the incorrect return value in
 brcmf_inform_single_bss().
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
 <1581583476-60155-4-git-send-email-chi-hsien.lin@cypress.com>
 <6c45797d-840b-5835-55fd-572c2b2abde7@broadcom.com>
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Message-ID: <166b1990-c693-dd6e-68ef-add2878c21c5@cypress.com>
Date:   Fri, 14 Feb 2020 22:56:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
In-Reply-To: <6c45797d-840b-5835-55fd-572c2b2abde7@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from [10.9.112.143] (61.222.14.99) by BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Fri, 14 Feb 2020 14:56:57 +0000
X-Originating-IP: [61.222.14.99]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bb4c12c-f950-4a2f-e7a4-08d7b15e2464
X-MS-TrafficTypeDiagnostic: BYAPR06MB5992:|BYAPR06MB5992:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5992BDAB6C6700F8D39E82F9BB150@BYAPR06MB5992.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(366004)(396003)(136003)(346002)(189003)(199004)(478600001)(66556008)(36756003)(186003)(86362001)(66476007)(26005)(4326008)(16526019)(53546011)(66946007)(6486002)(31686004)(956004)(5660300002)(2906002)(16576012)(54906003)(316002)(81156014)(3450700001)(81166006)(52116002)(31696002)(8676002)(8936002)(107886003)(6666004)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5992;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drD40OXf4LoD17z4/pf6R1UG/h9GIOZDVwTvZ2C+4wVY0Bp8kIbjnwkILVxBvnYSxC+PyLL2ZeCEEgeMPEw4PIA+AmK8aorkstW33uNzKl8aH+RqWywcXPOunGbMUsZGk+vHtkpCHmACPHMvbqK3q1Fkln352A705zc0iEqJzhvgT1ylSqEIvfDMq0H1mdBvn5pwz6im84DDqCy14RfNOYX/nhv7naURmcJLSDu43m6zxQB+pMEa5DBUhUXdroFvjGACSgRNvjzUMtgkF8nqUBQdj+GzMPnWGTjl52mRZg153SDQMJlNvLQSg8S6vIlkE3W3WwTYN36unqP5jlamdP0PIDOLFFjT6vCFhwWjMl5wi2iZ0Vh5yI1aA2OFhq69Lb7lF8VkFYzGaS+AgWgFYOu6NAYXjs6ICheYUP89ng4QCs0/IC1limteUXMOeSXY
X-MS-Exchange-AntiSpam-MessageData: cyKEkEugWq7i2ERdBPXsqbNQYXYFAY39Q/6zJFHYPiSn20puv5tCYMwCfy6oeqiSvOlFhEed7rIM8zAKHy7Zic0JttPLAv9oWKgb6HdB1Mx1kVwSWm3LKOEatJFGXDX1uIcGy/FsVql2A950CIAu9w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb4c12c-f950-4a2f-e7a4-08d7b15e2464
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:56:59.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nctaF9jgUrl+VnwtWqjvPszEsGXr2WZ+7fcLiDCvMjrg7xPeg6m6buPusE7G2NWVKgz5Um4C+F9A3rPrIWDhUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5992
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 02/13/2020 5:30, Arend Van Spriel wrote:
> On 2/13/2020 9:44 AM, Chi-Hsien Lin wrote:
>> From: Raveendran Somu <raveendran.somu@cypress.com>
>>
>> The function brcmf_inform_single_bss returns the value as success,
>> even when the length exceeds the maximum value.
>> The fix is to send appropriate code on this error.
>> This issue is observed when SVT reported random fmac crashes
>> when running their tests and the path was identified from the
>> crash logs. With this fix the random failure issue in SVT was
>> resolved.
> 
> Although I know what SVT is it not clear in a public commit message. 
> Just refer to "Broadcom test group" or something similar. It would be 
> good to have the crash log in the commit message though. I suspect it 
> occurs upon next_bss_le() call, but having the crash log is better than 
> having me guess. Anyway, here is my...
> 
> Reviewed-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Arend,

Thanks a lot for the feedback. I'll update the comment in V2. This is an 
issue that we solved a while back. I'll do some search and see if I can 
find the crash log.

Regards,
Chi-hsien Lin

> 
> Regards,
> Arend
> .
> 
