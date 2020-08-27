Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F4254004
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 09:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgH0H7z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 03:59:55 -0400
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:48704
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728479AbgH0H7o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 03:59:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeXqdsfbyxn9y7hjzUYGhPvgLXTT/aMD51mpX9ZTkIs/NooqY4WQyp1RMKa7NaFI3SMU6QR19obHvb9aPiwbSmevsslLaMnNgfO/L1qlb2hQ2X4lP1+vDpBdTDPzKqspgWy5IfRpKU04vyWQDtruLvtQFwgbuV9eHL44E5UZzcYfUgjmIk8sVXK68MYGEltrKSxyvxSaHXDcRIlhDFQVkI3/hTRZTFbWFR3O6/AuOi/UfihPJTpS0jEMqA7cmByJN1PQeY7Q3IUY51e037K5WE6bESOjojdiJRickOTUzVBn7THGPVCqlVFVyyDEVw4IAo0q56Meb3Uf0scUgkS9EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8RGmBeA02Q9De2ZYql5mteM8X7aHuiN/j1sZd1iPjU=;
 b=BDkUzJDe4byH6fx+YrnjflHZ8sJoqHUOiq1LueJgIfuNzl86xB7bDEunkoHPDZ5y8m5vRVKUkgxXZd6RUa8yojQIOiFM0cM2JAZtWKnNKrlnAkfReP1FgZZEiHl84KxZo/BNnUTeEFRIDghfzc5ool4Z8TGJiW4Ua0jk6nIoQzZc5JHDPBiWT58xN6mkwJYvWVgkpEt05X9NXGq/MISFuXLCcDxhnbEe9z5p8rEql8Zoc/DLRioo0p2k+HF5KZDoV2L5lR9stu5WvsgDQJLy6KejY6x29XY2JRelB8j1Roe9r6RcmMB46PcKLP/+ZLnomTNLIN4A8yZpyQE3S83Wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8RGmBeA02Q9De2ZYql5mteM8X7aHuiN/j1sZd1iPjU=;
 b=Zz/HSsmQf/Ce1JF/Ls1XqPkXMaDU4Aq44jKA545gRLgNHkCAffEIMxiq8877WRFVLEWomZE5mUzd9Aa7EiNOgFkEgkCjePD+36X7Ufpx5xu13/QdDGgcZZxbTAL2+6YzVV6r4VYpSR9gBNDPJDKo31A2bE+uYdVumvPznOy4rWI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=bang-olufsen.dk;
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com (2603:10a6:802:32::30)
 by VI1PR0302MB3423.eurprd03.prod.outlook.com (2603:10a6:803:20::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 07:59:41 +0000
Received: from VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::b0bd:fbfc:cc0f:f43a]) by VI1PR03MB3166.eurprd03.prod.outlook.com
 ([fe80::b0bd:fbfc:cc0f:f43a%5]) with mapi id 15.20.3305.026; Thu, 27 Aug 2020
 07:59:40 +0000
Subject: Re: [PATCH] Revert "ath: add support for special 0x0 regulatory
 domain"
To:     Wen Gong <wgong@codeaurora.org>, kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        linux-wireless@vger.kernel.org
References: <20200730124923.271429-1-alsi@bang-olufsen.dk>
From:   =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>
Message-ID: <c21bfe94-2de8-8178-7762-5a9b068a0e4a@bang-olufsen.dk>
Date:   Thu, 27 Aug 2020 09:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200730124923.271429-1-alsi@bang-olufsen.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM5PR0201CA0010.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::20) To VI1PR03MB3166.eurprd03.prod.outlook.com
 (2603:10a6:802:32::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.1.67] (193.89.194.27) by AM5PR0201CA0010.eurprd02.prod.outlook.com (2603:10a6:203:3d::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 07:59:40 +0000
X-Originating-IP: [193.89.194.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b100783-e9ee-4d20-55f6-08d84a5f26dd
X-MS-TrafficTypeDiagnostic: VI1PR0302MB3423:
X-Microsoft-Antispam-PRVS: <VI1PR0302MB3423591BCAB916D34C829E9583550@VI1PR0302MB3423.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WOPeWNGja/3E/WlaUnMP6jxEAD6zfXDBiCGSV/vgpo2/b3C6DVVwyqDfCio7f5svY0pay3LcPENjUo4zc4R5V5+Z82dBGGw5S0GcIbD2blMDyk6oxfMAM4aJ3zcP0ZptBSOKwBU7RLcotkxRMB/oph0qfaqujHIr4TzJKrKoeYWrA+le6qT2hU3PkOoeONzszc9aGnrEfDBM2NnDjDvbQDdh5qYgOBgYOpPrIZh+TmtaArWUYmPci8b98rmhAxfZCnwF37CO8vkLOYZTK8kkf5WEXaHrxtJvqJmyBNnAV+f6DWupp7pr39VDmQyO6XsC8NlC8LmvALO9x5QaZd7wExjEwkL3WQXfjN4Tej8X/ynYmJUj3jgUrdQN/zcFDektjhq658uPjjBsiZ4qlUc/Em5QIED5qEzCBTBWjHJWSgnJdbLAxbFVKTvr9eV8Oc7LvrhEhD26cYoHZrlKbE0Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3166.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(396003)(376002)(346002)(15650500001)(66556008)(6666004)(956004)(8936002)(66946007)(186003)(53546011)(26005)(16526019)(2616005)(52116002)(8676002)(6486002)(66476007)(8976002)(86362001)(36756003)(16576012)(31696002)(4326008)(5660300002)(31686004)(66574015)(83380400001)(316002)(2906002)(478600001)(966005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Aaa6eJCVCaCVxQu9rvj7i30x6tOs67iYzkt5K8woW2kQ7rxED7tqGIUSos4+S2kmfFKW50b3Cf3ptDCLmzuORzi80sBNI/E8GzhE3AfqcY2fH0nhlIrAzxnHogCqV7/PztsXCLnEoyum0QXwwQ0SqIgKO+TGDcH3ZCF2/MrTDeZbKZkLk9fTyrfnPnTtIWDx92P1qn5Wr6yvp+achEAhgbCFaxfPDAE8wzB/sPEcOLVrvftyx2XYf5yt/gRrO92newIFhV0p6tyBWbC0btG49CvNUpJqCR6EOMyJaHGmmQjyrfEWVOyCNQnuVhiziZinjdWJlnGCzTNs32ElLcUuyhb87LhtHwc36/t6Ec4PeGpdl79j6t/CWL0KEOMjuU8G4w6jIurLgPfBHTuS8uRdLzTUKEX0He0CofWs72Ay1z6GHfr4mNZWSoXgviIVG494CRp0vXohv3KyrpCSu8EV4cgt+ycjGko1ogHeaXTzOXO0NNORyCr0HzS+1QnQg781mQwbIDKH/LgKJ90Qg9SZ3wE4pQNW6bVUD6DTfRv4CKkzjTRTZaA+XDVshEkrDALD/U+kc+7qco28Uw4pnCIhljnLpDKDkAthnkXEoPUqfK0kZjif0YioqYVk9YJ+fNrWRsHniN+N6KVlFDpWxGIjZA==
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b100783-e9ee-4d20-55f6-08d84a5f26dd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3166.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 07:59:40.8662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOEOSXNS41+FQbFsC0Vl4skNFJ2T2aSfFv/Zi2AMqouOF8DTHH6yto5EOZqEgkPc0wF4Uyp66/9748Y3n0W0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0302MB3423
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On 7/30/20 2:49 PM, Alvin Šipraga wrote:
> This reverts commit 2dc016599cfa9672a147528ca26d70c3654a5423.
> 
> Per Atheros documentation to manufacturers, the EEPROM regulatory domain
> code 0x0 must always map to "US". In particular, it should not map to a
> custom world regulatory domain. For references, see [1] and [2] below.
> Furthermore, __ath_regd_init() has a specific condition to set the
> country code to "US" in this case, which emits the following log
> message:
> 
> [    7.814307] ath: EEPROM indicates default country code should be used
> 
> The patch being reverted mistakenly maps 0x0 to the custom world
> regulatory domain 0x64 - the most restrictive of the world regulatory
> domains. The premise of the patch is that in the case of EEPROM
> regulatory domain code 0x0, ath_is_world_regd() should return true. But,
> as stated above, 0x0 should not map to a world regulatory domain, and so
> the function should return false. The original behaviour, whereby
> NL80211_REGDOM_SET_BY_COUNTRY_IE is ignored, was correct according to
> the manufacturer's intent and should not have been changed.
> 
> [1] https://wireless.wiki.kernel.org/en/users/drivers/ath#the_0x0_regulatory_domain
> [2] http://article.gmane.org/gmane.linux.kernel.wireless.general/38410
> 
> Fixes: 2dc016599cfa ("ath: add support for special 0x0 regulatory domain")
> Cc: Wen Gong <wgong@codeaurora.org>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Tested-on: QCA9880 hw2.0 PCI 10.2.4-1.0-00047
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>   drivers/net/wireless/ath/regd.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
Do you have any feedback on this patch? No problem if you simply have 
not looked yet - I am not sure what kind of lead time to expect on the 
list. But without the patch, a (correctly) programmed 0x0 (US) card will 
not be able to operate on 5GHz channels without some hacking. I have 
cited some references to justify reverting this patch, so I would like 
to know if anything further should be done to get this into future kernels?

I wonder also if Wen Gong could comment, whose patch I am reverting in 
the first place. Maybe there is something I am missing?

Kind regards,
Alvin
