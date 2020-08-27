Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABD12543AF
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 12:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgH0K0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 06:26:15 -0400
Received: from mail-eopbgr60090.outbound.protection.outlook.com ([40.107.6.90]:2181
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726938AbgH0K0O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 06:26:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCXVLaETksj2RLtsso+DZErtfoVL3bok0xz3kJvbCS9cGHMMco8b+p5Q3Fl1jPTNYluY6t8j92Nn5L+qt+rydX8mn+zD2h8zWMjPxWBEaxDr1lzOjQ+cIfj3wGj8CegDGzh9DQ5Sn6GVjGnVi82FCPADGFASoqH9lcIMCTorbOu4bZtYatD41San9K9lUPEApd0XGq3ygNY0yES4Bqm8+C0P3daGHtZcP/9AHqL9knlYlU9sB2MKKCKtdXT2+RgbhSmguq09gG0qSwHb//y9Gu1cZSrnIovhHePF4boWTdvitCoGmMLqotNUAO1ycW30GgwkcDN5IFHf4V55fSi5zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=favfr7ewlqGMVL/kl7XySUYfSh7k9EH0hCxwx4X8cic=;
 b=esnNs3iOQDkT58wtK8a937a7cpVcTIspGnTwzxTFZj/M/2jX8HZKaAAIVKE3wokGyhzgQi8XUjp9tkCZUAb/ZcMy/T2VxfAiQG6xD4QNntBOGPd2xOUX9aK9aGWJVxXAosoVL3I3RzgO3wwDQ215NiDNlAvog9Ow/Kz1G9faz96kmNQr1EWYObUXYx83f67zUUVcs6U2oZoiXGpjaqTwJBxh21UJAvQpwQGy+g+Upi49PcQBch1j1f7QTg34vqd5mVvfUadAbXy3dZ/nh5a4EzkBc135jgc3Qit/SBNSAHZdZFiVsCdLdbtX5+YlNvytRuCIZ/ORnIBAzMCyquRbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=favfr7ewlqGMVL/kl7XySUYfSh7k9EH0hCxwx4X8cic=;
 b=dND7Ah8aB9d4CX8gElb/goX41uW8SKMzvN1XzfUVS+SK7NpAp5+W1A0VXUW/XXDVXANnG3ssF6zs/kY+mntPxwOBebM2AydHNnudQ4kTnGB3YmuohbvCKqRDh4YtFmgIVt8ueG/byTWdd/K+dHZszjDg3VLLTA8Q1foPNp7wvHM=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR03MB6430.eurprd03.prod.outlook.com (2603:10a6:800:194::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Thu, 27 Aug
 2020 10:26:10 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::b0bd:fbfc:cc0f:f43a]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::b0bd:fbfc:cc0f:f43a%5]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 10:26:10 +0000
Subject: Re: [PATCH] Revert "ath: add support for special 0x0 regulatory
 domain"
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Wen Gong <wgong@codeaurora.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20200730124923.271429-1-alsi@bang-olufsen.dk>
 <c21bfe94-2de8-8178-7762-5a9b068a0e4a@bang-olufsen.dk>
 <87r1rsbdnx.fsf@codeaurora.org>
From:   =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
Message-ID: <3a7cfd9b-200d-ac98-9e48-9cbaf50b9c47@bang-olufsen.dk>
Date:   Thu, 27 Aug 2020 12:25:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <87r1rsbdnx.fsf@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0015.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::28) To VI1PR03MB3166.eurprd03.prod.outlook.com
 (2603:10a6:802:32::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.1.67] (193.89.194.27) by AM6PR10CA0015.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 10:26:09 +0000
X-Originating-IP: [193.89.194.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc5e4ee7-71f2-46ed-d5a3-08d84a739dbd
X-MS-TrafficTypeDiagnostic: VI1PR03MB6430:
X-Microsoft-Antispam-PRVS: <VI1PR03MB6430FA37C21050B791E0406683550@VI1PR03MB6430.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SfHkMAYhPfMhESR2T5Hhw4g8SVo5FKLAxhLv1Gncacz/8CP2l7st0sakugW49QD/G2RQAmW+rJIUH+KMmDsP+uFviuFrgr/hafNisGcoxb4fX5CHW21mLeUKdJS2ahToNcxWazvZDlH5H09/6vtje+OZu3CbkkT6aSbftlGjfEGvm47jJGSPyIqnHQylJyWGHaMwBaMNjTvFUYTHIV64MlU8Mn3D6YsVn0c+ZebrHsCn/nG3pc43jZh2RvAQ/EpJZOR2bB6wpOBYY+Xuh/CzFieU9cKugbZVqnJvyDhPjAVB6X/olWy7ZLkzPeZx6tjwrO9pJPNvWRdQG6X4+x3sUNq8raYtCDQom0CgzhH7xkplgwVYMVzpxIUOgXwKSKrX3/lmFJSvepikfLtM6uS7sYI9Mgkeer5nDl+mArby0SLCI0MUlDfUDehQTJ6IHNNM1mvx8uE638ljSdS8Z+QVcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(39850400004)(346002)(8936002)(26005)(186003)(16526019)(52116002)(66574015)(16576012)(15650500001)(6666004)(53546011)(8976002)(83380400001)(2906002)(31686004)(966005)(54906003)(66556008)(66476007)(66946007)(4326008)(6916009)(316002)(8676002)(36756003)(5660300002)(2616005)(478600001)(86362001)(6486002)(31696002)(956004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rmBvm1NnO9DddNhHnuR9/MkaqvkG2Z3kT1kdbRf5xCNeHWHeuyVt0Z9ayzNOdoL0ej897DcRFGhkqe0E7SgmMU2IQ5nyD65bXTerVtmMLQ27xAggXBes76eQAHMDbDPd4iPCNkermrC6WtalhEM58R8gj+sXnboBQIqMwXRMh3s0XfzmoNH8mpO7o97WvUSA3a7utKoJVBdV15XZtyL4QpRTU7IiCDZACR3oZBkHoXN+CRUwKTjcIqKzd7cc++oLwkcfSW90Cd8KpmWyvHbsPpMftXtFAPvwj/KmIplCyzFC1I9oCF2jpN3juDvoBRS6dteJY0IgKWqwCF1cO6KCSL5qV2v78FYFpbO/X9hjKp6uwT76cnQeHOuLyOuf6ur8WZXWlj5CYqKVHBr4tYVZmDz+0vDQjavnQkHZjpXNhapYmtL7dgx0ahvYuK3WqpkTcDLOLTp4B+UskcrOSBusfZc1nZTTzsieer0zTv9O6yt59hCaY7gmMaflnpOwy96hyj5vHt5dVUHJI2kzatXO3xSTWOgEBAkjTf09fzGD5MislXkGN4gG7IvMVyX3SEhXMpMpZTLbYxAQl/+zHiFaxuP3Nh4borxzNDhvnO42rkqdePVb3AAzLP3AC4Bpa0xZyt6d8XWtboa0z/DIYaL4SQ==
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5e4ee7-71f2-46ed-d5a3-08d84a739dbd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 10:26:10.3971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUVlsXCbBQw7N3qrpzIBqa0KgcnzS247ENIFhlzn5LOd0refWQSt/CfUDAN+dX3Rnc5c+4i6lpr9XcD+YNyAFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB6430
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/20 12:12 PM, Kalle Valo wrote:
> Alvin Šipraga <alsi@bang-olufsen.dk> writes:
> 
>> Hi Kalle,
>>
>> On 7/30/20 2:49 PM, Alvin Šipraga wrote:
>>> This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.
>>>
>>> Per Atheros documentation to manufacturers, the EEPROM regulatory domain
>>> code 0x0 must always map to "US". In particular, it should not map to a
>>> custom world regulatory domain. For references, see [1] and [2] below.
>>> Furthermore, __ath_regd_init() has a specific condition to set the
>>> country code to "US" in this case, which emits the following log
>>> message:
>>>
>>> [    7.814307] ath: EEPROM indicates default country code should be used
>>>
>>> The patch being reverted mistakenly maps 0x0 to the custom world
>>> regulatory domain 0x64 - the most restrictive of the world regulatory
>>> domains. The premise of the patch is that in the case of EEPROM
>>> regulatory domain code 0x0, ath_is_world_regd() should return true. But,
>>> as stated above, 0x0 should not map to a world regulatory domain, and so
>>> the function should return false. The original behaviour, whereby
>>> NL80211_REGDOM_SET_BY_COUNTRY_IE is ignored, was correct according to
>>> the manufacturer's intent and should not have been changed.
>>>
>>> [1] https://wireless.wiki.kernel.org/en/users/drivers/ath#the_0x0_regulatory_domain
>>> [2] http://article.gmane.org/gmane.linux.kernel.wireless.general/38410
>>>
>>> Fixes: 2dc016599cfa ("ath: add support for special 0x0 regulatory domain")
>>> Cc: Wen Gong <wgong@codeaurora.org>
>>> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
>>> Cc: linux-wireless@vger.kernel.org
>>> Tested-on: QCA9880 hw2.0 PCI 10.2.4-1.0-00047
>>> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
>>> ---
>>>    drivers/net/wireless/ath/regd.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> Do you have any feedback on this patch? No problem if you simply have
>> not looked yet - I am not sure what kind of lead time to expect on the
>> list. But without the patch, a (correctly) programmed 0x0 (US) card
>> will not be able to operate on 5GHz channels without some hacking. I
>> have cited some references to justify reverting this patch, so I would
>> like to know if anything further should be done to get this into
>> future kernels?
>>
>> I wonder also if Wen Gong could comment, whose patch I am reverting in
>> the first place. Maybe there is something I am missing?
> 
> I'm working on it, I just need to check something internally first.
> 
> BTW, Brian submitted an identical revert first so I'm planning to use
> his patch instead of yours:
> 
> https://patchwork.kernel.org/patch/11573585/

Hi Kalle,

Thank you for the update, glad to hear it. Sorry that I did not notice 
Brian's patch - I guess you can close my one on patchwork then.

Kind regards,
Alvin
