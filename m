Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B516209CDE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jun 2020 12:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404026AbgFYK3l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jun 2020 06:29:41 -0400
Received: from mail-eopbgr60081.outbound.protection.outlook.com ([40.107.6.81]:28630
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404063AbgFYK3h (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jun 2020 06:29:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dioLejdLwLpuMRTgAj/BdSJ4Ix9R7UsPEfATib8ULhE91cu27xubK6BRgh99tEF30sP9yzayQcFSaZTvkLJYZAj5rj9ZScSgYQ6Gn/ib1NxruH6pwTqRbZuWg3AUWDcOevQEVr8f0tYD+FRqhQ6gtOAP0g6iYzXba36C0HV/zD7xQBKC3GVDUUQurKJOffgxkIcmYAs7YBFAqYgJdgwUNsEvNfcxy+ra8R8jeF0eHtn1ewkWAKgx0NSRrwrYlKOmx8bA7iqoBz3sJmefK4VydnXn1u0mcKmNwPMyWp/Hm/RqEpEhm8loPYW31FDqezc2RfRyeuZIzFp0pui/KdHSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6msjl9bpoR5N6iYEA4+vt5eeE32ns8CE4qU3j5bo+48=;
 b=JFQDV9mVlPjOHEJWbW135sKB854mCKbFFRm5I3XQGgaPH8DrHFudU4ifwAmBktqbmfPhlJ++gNDy6noHhp1o+tXcQDZ7DudQQk7w4TdUj8GPRBYRmauFfmj5yFkgCXFiLief/Wn8oe9HBMcdxoRoMFxN3I0+JyopnzbUOCL72ZDlJ4jgYq+fNdysA3wQ+K7xA3kUDXo7m9TbY/tnma2Wl6U9NOHotSFWEPaDcS6bcYKE2nUXP9Peou9iWPjmBZjK2T08/4HcNAko3h6O96vip8ZKIxbKgLLNAEJlH4czEsao25x7FTLv7pKa4OAQOA6Zoj8EHegwCpI5khaDjgnqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6msjl9bpoR5N6iYEA4+vt5eeE32ns8CE4qU3j5bo+48=;
 b=pzskGDSSy+7LNifrzGaTHvRm/f//1JHIOobjeKQddWaPwQRHaUqHV/DhOFqxmhibX9dzAJrD+0d8kc3uqB8jQOXVTALW3IfG9rRW2Wqy9vosobubByU2cjXgM7A3dHT+agOFhKSF4JsBv1nsXjQNTroBrS+mMAyjjbYVkUCq1KY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0434.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Thu, 25 Jun
 2020 10:29:32 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::5cae:415:1979:1de1%5]) with mapi id 15.20.3109.027; Thu, 25 Jun 2020
 10:29:32 +0000
Subject: Re: [PATCH] mac80211: Send deauth to STA's upon AP stop
To:     Johannes Berg <johannes@sipsolutions.net>,
        Ben Greear <greearb@candelatech.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20200618093609.16514-1-shay.bar@celeno.com>
 <d57c8bf64d6ea2e3f7355c2f7ca9b376db7fe21c.camel@sipsolutions.net>
 <AM0P192MB04682E48D814F5F6CAFBF9CAE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a7b33ace030fdeda96e60b2abd6c70a11f426e0.camel@sipsolutions.net>
 <AM0P192MB0468CA3DA7C8EC62366AC04AE79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <54236bdd708c53ec2f2a776bb3badcd77c7fecc6.camel@sipsolutions.net>
 <AM0P192MB046896A59F91F976EE7AB287E79B0@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <6da8757ac90a4d34ed1bdc7c84b40aac06c01af9.camel@sipsolutions.net>
 <f0b038b4-fbd8-0b9b-2c2e-6337f0d408ea@candelatech.com>
 <AM0P192MB0468ED699FC0BE6431812B03E7960@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
 <2a607392179a76f0f6fc3cef2e6e141f25dc0254.camel@sipsolutions.net>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <90ea9478-a42e-be89-0ee1-9e05c2ef8cc9@celeno.com>
Date:   Thu, 25 Jun 2020 13:29:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <2a607392179a76f0f6fc3cef2e6e141f25dc0254.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::25) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.9] (87.71.73.65) by LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Thu, 25 Jun 2020 10:29:31 +0000
X-Originating-IP: [87.71.73.65]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4afe94f0-204f-498d-feb1-08d818f2a641
X-MS-TrafficTypeDiagnostic: AM0P192MB0434:
X-Microsoft-Antispam-PRVS: <AM0P192MB0434864C0A36AB2DC93D12B9E7920@AM0P192MB0434.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXjUe1CNoHmyHrKxZctTNkW5GbVz0m6yfWZswsxFq6tTV4yCUGMQxbreSQbi8zSzB9PsNBr+r/PdHOpUbgudAMwZfo2MtX7T5AmnA7uHT9b7Q5wAX/jAI4M5dY4ILf3Okumv/1RzdaVRzXMGCH9Sd6dYKpO7JeJaIY5lwVIEjTsSndAhj3lLsmg/6mx12r/Bs/gD20d+R5s4LX76HiA0fmutUwKHPw0d06M72THixy3P5ki2YL/LSHkX7lke2fRnbsTrypTccGE2+ZTLiivCMU9DPi6qbNQuXtqNYk43fkNE3Fu5Gwh2mMKsp9lksRtiogNGOmtZVfeObfOGIG56S5Wd04XvLCOqjVbSp9308XfvGNcQ97ebAXik6PtdCfkC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39840400004)(396003)(366004)(136003)(346002)(2906002)(110136005)(316002)(16576012)(52116002)(5660300002)(6486002)(16526019)(26005)(31686004)(53546011)(186003)(8676002)(956004)(66946007)(2616005)(36756003)(44832011)(4326008)(478600001)(66556008)(86362001)(66476007)(6666004)(8936002)(83380400001)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4tGX1npqopZ7Th4IPVb6LRoY6sg76zhgr3g4JWGQZYs4lUDOXLekpiJ/LjuWWya8UxbwBCgylDAgbDaXxrKv3f8UPo/H9Vnrq7N7oSnwSxdTgUtw9k1W6hMyvUJLjrGAjH0wXz0E62EJD7683M25oo47HfeYJyoPQU4jo0CGCvSDY5vF1do/J4RZQ3Qo9LgnmEbFNWE58vYpsqI8lxzNIDiW/H72jWh7OzmWKi2Wpg7QodLNLqzqiRPBMw6XqT+sQpaUalcW9Hk/bAf+0SJVIdSLaXP3ulxKQbfYoC3Go8/v+JZrNFf6GZEy0bma3YnskygI2tBEcl++o0y+KG62LGNHoXjDOgmmUempIbM0cyNWeVClzpFe8ANWu2eXgs1+VRrBBvJBHznPL7TUUrTh6tdXEmrJWHbrIJDvgk9z3D+Qb1YjJcpJHt076xWToKYHPfcOmaf1IgDKt0w+84H4YD4ilxIY58Fui0/RPJPML1k=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afe94f0-204f-498d-feb1-08d818f2a641
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 10:29:32.5329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2XvcSkLlE18NtmgD4EwPvI3tBWMVaxk5SQMT5alFkpdPb1SogkNkYKnkWjglZbkCs1c5H9r9oAsh/PSqLbpow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0434
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/06/2020 12:51, Johannes Berg wrote:
> External Email
>
>
> On Sun, 2020-06-21 at 10:12 +0000, Shay Bar wrote:
>> Hi Johannes and Ben,
>>
>> To conclude this thread, hostapd doesn=E2=80=99t send any deauth/disasso=
c
>> upon AP stop (when hostapd is killed _or_ when "ifconfig down" the
>> AP interface).
>
> Right. I'm sort of suggesting you just shouldn't be doing this, and it
> doesn't seem like most people actually do, otherwise we'd have seen this
> issue before?
>
I shouldn't kill hostapd? Isn't this a very basic action?
What is the alternative for stopping the AP?

>> This is causing a situation where stations keep sending unicast frames
>> to a down AP interface as it doesn=E2=80=99t know it's gone down.
>> I tried your suggestion and sent 1 deauth/disassoc as broadcast
>> (instead of unicast to each STA), but some stations (e.g. Samsung S8)
>> Ignore this broadcast (while it will not ignore unicast deauth/disassoc)=
.
>> Although not indicated in the standard, I think it's better to let STA
>> Know AP gone down by sending this unicast deauth to each STA
>> (as this patch does).
>
> I'm not really sure. That's a _lot_ of frames and potentially quite a
> long time. In the patch, as written, I'm not even convinced you can be
> sure that they will all make it out to the air?
I agree, but what's the alternative?

Thanks,
Shay
________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

