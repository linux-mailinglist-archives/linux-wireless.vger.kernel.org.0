Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784FD28B594
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Oct 2020 15:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730374AbgJLNKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Oct 2020 09:10:23 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:36773
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730354AbgJLNKU (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Oct 2020 09:10:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1c+pw8fHFfGvi6mmXvxt+E4n83EogBSEKYRIJqSXnB48BKbFx8fSPWgbm1ctOIM/gs+kUmmlBWtvUc8XToKmGkzaz6FEvudMKU8mJDiygH8vHcAiE5+R46RKWtxLzkENJY1fPKk8kKnFwPfYO18YYwq+XBpXzuG8N2XeT3pbGjOGR8V8dXFZNHlq6lmzG5RHuX20zfCuBEaSOWonKESnhZsoeNE+w9Jvw3gy4AuzwvMUfQaMsZtPdAipZ5bssROjWxNJ+iOXPzC62yzvkbTSRKFvc1CDYDyb18UzUmr7IDhCWe08KB6I5vk7zndWzP7GMz+rvIUBoyjQAUiEpU2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDN5xEixwfIJMW/X5GICquS7elFh6R78stUSUJwVZ+c=;
 b=Dnd2dEmbR5nLxo+xguqrPBHARU9PzExCk9ZkpdpGiu49lknTDeqtGJc6aYJX1UqcrAyKJuIlt3Txa+RICYPvahEM+9AGu47LfOypPGcE4xFKMm6mloqMJO2znMwVSGU9cthmmFtfJ4r++HsmnHgOJSbEn1vTDqWiFvtxf8zY1CtU5SExo5JAXy7qFeCPYZLU17+pV7S7yuzevBUVbLP23RPIUE7qU4KqsnPX6++ncrjIGMYKJeM9nrv7Nv/eOo3FPVfN40lVZ0SIDZK5TJQFQ1Ea+jOnNn+WISuoILvUDQrGtIRxyYYHPfIRLE0ZE8aQe1uA24dYyBdUihDe8opi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDN5xEixwfIJMW/X5GICquS7elFh6R78stUSUJwVZ+c=;
 b=BreRGxGjw86Da6hjn1RGrLMZgDnLK8eBNfZ5YbPfUt66Q3VxdvAVFdlPI8rEcV2vu6w6QRz63BHgzHy93Rkra1BlU0iS3bDBRafI74kDzolHYxjItYF1i1zIc64pn765vOrU0XR4TkZS7AzZ2gxN2krqZP3JqbxlFszuigRHs/c=
Authentication-Results: celeno.com; dkim=none (message not signed)
 header.d=none;celeno.com; dmarc=none action=none header.from=celeno.com;
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15)
 by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Mon, 12 Oct
 2020 13:10:16 +0000
Received: from AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189]) by AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 ([fe80::86f:dc24:7a0f:6189%4]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 13:10:16 +0000
Subject: Re: [PATCH] nl80211: Trigger channel switch from driver
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, aviad.brikman@celeno.com,
        eliav.farber@celeno.com
References: <20200826131709.25530-1-shay.bar@celeno.com>
 <f1117adbcd57f3481c215626cd2120b6aa5dcf02.camel@sipsolutions.net>
From:   Shay Bar <shay.bar@celeno.com>
Message-ID: <6ec8e541-0446-f71f-41bc-0106a5a90189@celeno.com>
Date:   Mon, 12 Oct 2020 16:10:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
In-Reply-To: <f1117adbcd57f3481c215626cd2120b6aa5dcf02.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [77.124.52.93]
X-ClientProxiedBy: AM3PR07CA0055.eurprd07.prod.outlook.com
 (2603:10a6:207:4::13) To AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:208:45::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.0.13] (77.124.52.93) by AM3PR07CA0055.eurprd07.prod.outlook.com (2603:10a6:207:4::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.11 via Frontend Transport; Mon, 12 Oct 2020 13:10:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c1f3c1c-e568-46aa-aae8-08d86eb02980
X-MS-TrafficTypeDiagnostic: AM0P192MB0468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB046830867492543393BF8977E7070@AM0P192MB0468.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujJaPkXE5AqD7bRtDV6810JBFBw602jjANIhxJnOxf24iyogdCLUjNI9A0YDK1BKdfAKvZnqwtv9vFdMBgODnQ5xWK3pKxnw944w0oLepgnJOmT/9V1+MnR7Oy8PDdWAiLYTyRRLZ69AuY33IdkBI8oJkbKdS5QbJ8j1WzwXO3+Y7UybdaUix+aAqFIVklUaErjkCfNqmXYaUURw0xCBdpmvxYtf6P0oZVUNPs6mJcPacWq81uKJzkZeO8eL8ykVpNM37LbEVdaK5MYaO7tsbdKlY+I9D/lxYbiL7Sa6pGnAEvr/Y/WbybSwznRA2Gaa5x7AZKo170VnIYSPjB1aDp1m25GRt+yJQOt96MRl+89LQ6urT/BvaBCDUWJoM1bA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0P192MB0468.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(376002)(136003)(39840400004)(478600001)(2616005)(956004)(8676002)(86362001)(44832011)(8936002)(5660300002)(83380400001)(2906002)(6916009)(316002)(31696002)(16576012)(36756003)(66556008)(16526019)(6486002)(107886003)(52116002)(66476007)(186003)(66946007)(26005)(31686004)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P5Y9+HopSrQyTu8xcJByxPLxXrBGOmWeplFqQ4SL4eCQn0HPMmnig8CIvT9Plr+TSn1GhqL6ASC7cbXZgdOg/2r1jFNGXq3mr1ieXl7IEV+QcReiIWCqYPwDmgDBwfSIvM2qTFFgiMeuqVbcZjiPQwl03IG91bDP11ZO10t9AU1zQSIsa+lNAIVuRUuXuwQj+wrG1wpFwJMecT0hKjl6k9M+smGiOtiGKpvR+g0/eyNYI0Z8jKp2SU6J27hJto7OAKgOjpjfXKl6CwCVBAlh3zdtPxNTtLPOh+KFS8vZ/p22/VIIdcNyYlCDVHWYJYfM3j1FCXzbPEa+iG9kvFpYFv08CDeGgWduF1C0x5IKMuU5MfRPjVKcvlkXIeExDlD0URNa3Z+AUreWf3zUZM2ZbolGwdzq0P9wc3DNscAVWepafMb9sookc1aK/QpkbVWElizk9oQ46nI6sqVLfGbZQ/ePeDYntTer7LXli+P7PjXh7yVHrqUaoIcvliL4yKxt8apSWF/WuNi7eE7dSw3IUIZiNgSkoJM8CHuFlLLO4uO6K3K4QP+TxPyIlcwKriVtNTdG3dAr2qFBAIWnEZ1RdtOOa0Bk3pTbAoPCaREdBSvfIUWgkjzcpch/jc4ARvn+qNJjyUrUC7t2Yi2wcWnJRQ==
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1f3c1c-e568-46aa-aae8-08d86eb02980
X-MS-Exchange-CrossTenant-AuthSource: AM0P192MB0468.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 13:10:16.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhfrIAGLMeQ9APlDH8UJq20RqSWpd+U5ZcbsexitgUlJMb5tYBj3riCbKnT5iPdlOa6/YPFJuLaixAgcXFIvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0468
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 28/09/2020 14:30, Johannes Berg wrote
>> using the already existing NL80211_CMD_CHANNEL_SWITCH.
> I'm a little confused as to how this would work - did the driver just
> *do* a channel switch? Or does it want to do a channel switch, and then
> hostapd has to deal with it? Is it able to? What happens if it doesn't
> do anything when this happens, e.g. an older version?

The driver "wants" to do channel switch and hostapd, once receiving the 
above command, will take the same action as if it received a 
"hostapd_cli chan_switch.

The driver will not assume channel was switched upon sending this 
command (it will have to wait until hostapd will handle the entire 
channel switch "loop").

There are many reasons why kernel driver will want to trigger a channel 
switch (e.g. dynamic channel selection).

With older version of hostapd, it will not be able to handle this 
command and nothing will happen.

>> +/*
>> + * cfg80211_ch_switch - trigger channel switch from driver
>> + * same as is can be triggered from hostapd_cli chan_switch
> Not sure "same as ... hostapd_cli chan_switch" makes a lot of sense here
> in the kernel-doc, tbh.
can remove the "hostapd_cli chan_switch" reference.
> Also, you say "trigger" here, but ...
>
>> + * @dev: the device which switched channels
> "switched" here, which didn't help my above question at all.
Agree "wants to switch" is clearer
>> + * @chandef: the new channel definition
>> + * @csa_count: the number of TBTTs until the channel switch happens
> though I guess this makes it a bit clearer, unless it can be zero? :)
csa_count of 0/1 is valid, but it means the channel switch will happen 
at the current TBTT (see ieee80211_set_csa_beacon())
>> + */
>> +bool cfg80211_ch_switch(struct net_device *dev,
>> +                              struct cfg80211_chan_def *chandef,
>> +                              u8 csa_count);
> nit: indentation
will fix
>> +       if (chandef->width == NL80211_CHAN_WIDTH_40) {
>> +               enum nl80211_channel_type chan_type = NL80211_CHAN_HT40MINUS;
>> +
>> +               if (chandef->center_freq1 > chandef->chan->center_freq)
>> +                       chan_type = NL80211_CHAN_HT40PLUS;
>> +
>> +               if (nla_put_u32(msg, NL80211_ATTR_WIPHY_CHANNEL_TYPE,
>> +                               chan_type))
>> +                       goto nla_put_failure;
>> +       }
> This a bit ties in with the "compatibility" question above - does older
> hostapd even understand this? I'd suspect not, and then I'm not sure why
> you'd include these attributes?
older hostapd will not handle NL80211_CMD_CHANNEL_SWITCH anyway.
>> The information transmitted is intended only for the person or entity
>> to which it is addressed and may contain confidential and/or
>> privileged material. Any retransmission, dissemination, copying or
>> other use of, or taking of any action in reliance upon this
>> information is prohibited. If you received this in error, please
>> contact the sender and delete the material from any computer. Nothing
>> contained herein shall be deemed as a representation, warranty or a
>> commitment by Celeno. No warranties are expressed or implied,
>> including, but not limited to, any implied warranties of non-
>> infringement, merchantability and fitness for a particular purpose.
> Hm. I guess I'm the "intended [...] person or entity" but I'm still a
> bit wary about applying patches with that, I guess.
:) the disclaimer will be removed from now on.
