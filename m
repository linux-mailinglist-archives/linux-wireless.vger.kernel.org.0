Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B56D7E0E83
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Nov 2023 10:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjKDJL6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Nov 2023 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJL5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Nov 2023 05:11:57 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2039.outbound.protection.outlook.com [40.92.99.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCB2194
        for <linux-wireless@vger.kernel.org>; Sat,  4 Nov 2023 02:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+ojJkU8XE3d2Ayks09bdG2f7TPWeK8AZc0Qi3j8WU4CBBOPBJKSXTpSvTo6bWleyI+GPCwNP6k912lbGNpgFiaVg1tqukhJ/ouS+3AhsgTRVK7IOa5jUYSGJw6VkF6dJPdMp3L0YlMVQdwyj5osqxXEsq2MhTKEzB70+/XPLGOKiG1L59L343+DiISc/x9hPd7SK1nmTfSj/asQK9/KqnSHJI6OREFPSNMb9bDxje5Zz5EZcDfjMNyKKH3K7CLaczHfDAqz1/fcOa/q2qREW8hwLITj7uktNjoNgQh/KeoT3QNm47FxVwmhGUmPZrwTCtMJGocgcGnv6/lCPvpvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L0UQx7j8nbW720YSy/7dqh7FzE+RGEqLBDAun4rF3Y=;
 b=ZaPGhshTCSWAezRxb3akKdi5kf6obuP8eQ08M/WJpdgKZpIuV3NJsYkVXGCPZp7zLTWh4lCvuQLTTYCtFxTDmcfrEqGdlasvXXhQPlfDBcc8vKZBWRfw/ZpGGlf5eCJmbDsKfvbImr+NHAMesgkOL8/qc4pr4OYDnO0Rz8w/+kHL8vs1HsOvrBGVOLfbkFIBcMpMC0WIWsseUv28XPkgP1QXQDdoZjSfwnGzLsrkGcECseiHI1RQJx0+qaKEBxWgTPwjDBaxY1YeE+Xk4ZSlhDh+J8r6nKsaRtbwIgj6AFeCT0nQhZf1uACJOkPtDsMezs8I615T/+I4odMmimTWZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L0UQx7j8nbW720YSy/7dqh7FzE+RGEqLBDAun4rF3Y=;
 b=m4W/dMTE4NmmPRUPcY3ik2ohZvbg9wlt/xvN3V63VNJzK280+sZQmy/bramWhGHQ/OfnarCRB3AxmAcPG5rE62kzGTiKcD5AnEDlfT+pt2ryHkpC/7Kg9050w5kljjb7mh9b58kYZVqy4egk9HC8moTNdUV9LUN7qf6ex+yH3BgQg90hz4tBQ8wbLEGenRYotjQa64IkGumTHpQnLMPElPpJFQ9uX6MdtHdFF2trZfj8eNOM4Zk7tf3HQJu2dz/UfKSMx4Jh3yyfkeTUiIVhy+uS9M4ecdFWMkXKT/u+G2omJRToWnolUrERZHnxrAUYwm8p0LYEnl5WeN+7imOM5w==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OSZP286MB1608.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Sat, 4 Nov
 2023 09:11:51 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.025; Sat, 4 Nov 2023
 09:11:51 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: rt2x00: restart beacon queue when hardware reset
Date:   Sat,  4 Nov 2023 17:11:40 +0800
Message-ID: <TYAP286MB0315EA21678C650588F7AD4EBCA4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103055547.GA27419@wp.pl>
References: <20231103055547.GA27419@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [PwEogNpTFMqQDE5V6+kmJt/7FaRPKAcfQxWpXi9C5LU=]
X-ClientProxiedBy: TYAPR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::19) To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231104091140.20055-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OSZP286MB1608:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a9bd2e-7871-4855-c575-08dbdd161473
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvG2MxDRZTdoA4Uq4HupE6+FpEaK8fZS8PzEOeElBhOppDh0oaEZMBM7Fp71iH+aTGAWpxCiUdmCdfJP1+1UBolEocIg+3syNS6DdVA4/6tv4c+OMp13ww8hdpAHC5bPjzexyUGSQo+DktiOXwxp8gNFsxUKz3SXK0hzO3mZm2ktBAsQ/UWaAgKY5tcI0HHouXNIZLVvUR/0jpfRwseXWHbcBnCp9KbEQkQnZLHmKyWj8U3DJNoUv7alzh4jmzPiISlbWhozXydH5qJexelZFb+4FGhue2TlW4Gt7pTOXd4Iiu7oO8/Lig5+ZkROc97FfD+jBI3CWArUnnhtl1fIFWudVRb1U9jS4CNWK9GD785GBZiI7bOwK5xFrwhOny1SsyIzPgDDcFB5JZVPLy+QWchqjeVn2S64XxWDqXVKXFKAGTdWAlp+CfcWN52rNI044VwC0i4Y9h0t0dSLm24+CODu2UibWyFIHCAS7Rvwx9VPFQUI9Qhp1VpDUJfLziZi0pgiVaM2zQflueA07fimtyb/IFoOlg/F/u9vsNApEIigrDnZWhLfbbZI9XoG11mK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3ZDmtcHMvierOZ9NNHdH0Cq6rQSYULnXYPAdCRcdfHCswZJRBkrib5kK8Gb?=
 =?us-ascii?Q?kuvmzDzoCahrFEf3/1V51tcyxdWFH1iQMDSlxtqkyfT2gyDE3VTmHU2AGQPg?=
 =?us-ascii?Q?axCQwHfn+z2fXnsMQz3/p77pngtIfwG/5+aphV/pKp3GP+OQZJIJI0XN6EgN?=
 =?us-ascii?Q?btSIrNfCcRtKVMMq3cPxz9JFL6tuMjY0YFSj86sKOVQMQKAuM/sMpyQtbRNK?=
 =?us-ascii?Q?hxehZ5doGMQOhlOVUKEs7EDdWtoS93dScJ5tVdzPFHsYyEukdIH3DxsfIqhq?=
 =?us-ascii?Q?b/BLLvNFpLFp4iNe4BphvUCiBjtPp9s/Sk8RoDtYWeIf1xJokDKBQoaEojiF?=
 =?us-ascii?Q?Z46vH5w+HumwqQzvTlg6Y5bMeFRWLMLIpQtqCbdRhg7DsswFzUcdiKeTB7qe?=
 =?us-ascii?Q?akTfia78ehT+HVAP3gsYJ+advtlrxy0hFTB0zvNkrYEVYw77bsBHdK8MCx/2?=
 =?us-ascii?Q?uufFO7Y2M4+0njzNKDwliv9HWbzdniI/mkWStnrFbl5cUvpFne59uCYTAtlC?=
 =?us-ascii?Q?R5X/EjfUyO9Wtk3zRRtTkw5hPGKVeAJYRndYpHBiqsqPGyqCkXpNKTIOtX0V?=
 =?us-ascii?Q?Cb/Hs7SVwNUkZqNR1a4+fiSuE8nIxKiH6xovvV83gFLl3yIWPwKf1TDA0FU4?=
 =?us-ascii?Q?a6DXri8KLcKd8ElwL7FMTa8OifuzbJzc/V9D5R0sGzlTXAb3P+drEdgKoZ7J?=
 =?us-ascii?Q?4y+d1EqqWKJDXX6EZsjKs/CtHjliLd+/HmG8InTEOjpSET8BsN3MEjgFPy8G?=
 =?us-ascii?Q?j/fVA9/fUeFBWo/eZ+lSRzyCcIOWObaJEwWTqJmKrGlB/5Y4aBr5Ir3+hIZk?=
 =?us-ascii?Q?Zuj8tVfv86P8JRaRQvEcJ+soAwar8eonv1XxdWqzKzYyjNsh8AYvNvNll2iL?=
 =?us-ascii?Q?+y6qdQ5mYfdZaYCq7tmo+oZbUSXjMxiwuuckcLexTCrnFntujBlJx8nv4LvM?=
 =?us-ascii?Q?+qSUlASfSZ9eXA5XgLG89kPgT7FhPXngdukwR5sKCRdQ3ovF2wJEKsct2/7/?=
 =?us-ascii?Q?ihoe15no0kQJwXuJHu+WG0Iyu1x70lrOKdx2vGkw3HVCJT/VUd4f9raRaWx8?=
 =?us-ascii?Q?JKIEurmIAZPxqJsaQ0QdaoIjILG9+hF7MS2ZsU/L1TlhndhvUebnQlIotm3L?=
 =?us-ascii?Q?plNnZInp7P7UQ/CEnLwQVD7+f9JtrAKzo8j3KW5sWPuNxJ/jCB993eOUl+9E?=
 =?us-ascii?Q?RyVs5pIeM61YrfHjzcWNI/8r4ceWqVUbfzl/Ui+G2dj1zQSAIXNOTdUZuA0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a9bd2e-7871-4855-c575-08dbdd161473
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2023 09:11:51.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1608
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 3 Nov 2023 06:55:47 +0100, Stanislaw Gruszka wrote:

>On Thu, Nov 02, 2023 at 08:36:04PM +0800, Shiji Yang wrote:
>> On Wed, 1 Nov 2023 10:07:10 +0100, Stanislaw Gruszka wrote:
>> 
>> >On Sat, Oct 28, 2023 at 08:15:32PM +0800, Shiji Yang wrote:
>> >> When a hardware reset is triggered, all registers are reset, so all
>> >> queues are forced to stop in hardware interface. However, mac80211
>> >> will not automatically stop the queue. If we don't manually stop the
>> >> beacon queue, the queue will be deadlocked and unable to start again.
>> >> This patch fixes the issue where Apple devices cannot connect to the
>> >> AP after calling ieee80211_restart_hw().
>> >
>> >Should not this be solved in mac80211 then? ieee80211_restart_work
>> >does a lot o diffrent things, why beconing is not also
>> >stoped/started there ? 
>> >
>> >Regards
>> >Stanislaw
>> >
>> 
>> Hi! Thanks for your review.
>> 
>> I think this issue is a bug of the rt2x00. When restart is called,
>Yes, I think you have right, this is rt2x00 issue. 
>
>> mac80211 didn't call rt2x00mac_bss_info_changed() to update the
>> flag (This may be expected? I'm not sure. But all other Tx/Rx queues
>> are also manually disabled). And after resetting,
>> 'bss_conf->enable_beacon' and 'intf->enable_beacon' are still true.
>> Though mac80211 will call this function and try to enable the beacon
>> queue again. However, both 'if' and 'else if' blocks will never be
>> entered anymore because all conditions are false. This patch just
>> fixes this dead lock.
>Ok, I see. 
>
>I don't remember how this supposed to work. I see we do 
>
>        for (i = 0; i < queue->limit; i++) {
>                entry = &queue->entries[i];
>                clear_bit(ENTRY_BCN_ASSIGNED, &entry->flags);
>        }
>
>in rt2800_pre_reset_hw() But I think what should be done there is
>clear intf->enable_beacon for each interface. 

Yes, idealy we should do that. But 'intf->enable_beacon' variable is
owned by mac80211, we can not access it here. So I can only say that
the current solution just a reasonable workaround. I made some little
changes in v2 patch will help developers to understand what happened
in rt2x00mac_bss_info_changed() after reset.

>
>Now I don't remember how I tested this, probably only in STA mode.
>
>> Maybe Kalle Valo knows if it's a mac80211 bug. This issue has been
>> here for several years.
>> 
>> Looking forward to your reply.
>
>:-)  
>
>> By the way, it seems that 'intf_beaconing' variable is useless. Does
>> it really can be increased to '2'? Maybe in multi ssid mode?
>
>Yes. When you can have multiple vif interfaces this variable 
>can be bigger than 1. We advertise support for that for AP
>and mesh interfaces in rt2x00lib_set_if_combinations().
>
>> 		} else if (bss_conf->enable_beacon && !intf->enable_beacon) {
>> 			rt2x00dev->intf_beaconing++;
>> 			intf->enable_beacon = true;
>> 			/*
>> 			 * Upload beacon to the H/W. This is only required on
>> 			 * USB devices. PCI devices fetch beacons periodically.
>> 			 */
>> 			if (rt2x00_is_usb(rt2x00dev))
>> 				rt2x00queue_update_beacon(rt2x00dev, vif);
>Hmm, maybe I also tested on AP USB, but don't remember.
>
>Thanks for explanations! Patch is ok for me.
>
>Regards
>Stanislaw
>

Regards,
Shiji Yang
