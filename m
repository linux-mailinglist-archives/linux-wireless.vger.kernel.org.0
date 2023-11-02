Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CACE7DF292
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Nov 2023 13:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376527AbjKBMiC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Nov 2023 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347588AbjKBMhe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Nov 2023 08:37:34 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2107.outbound.protection.outlook.com [40.92.99.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EED1AB
        for <linux-wireless@vger.kernel.org>; Thu,  2 Nov 2023 05:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQkigd162XfMwwlGYsul5xVzR9XOPlukVimNuSXTOzQojRUfWi1jZMTUPVzvz+0cGbIgX/+EgNkTmma1FXI+03Am8aM4wYFqnzYFxtgz6lATm3yKIK1326t/hcLQfIkHv5ZwT88HXj1y08IwcdkXAaNrjZlqHHK+zRAJ9ULIH+FQcr3OR+l99bsBgy/1yjgZGT/8p3JuKXJKZ0x/Gg+I+zEJy1BUIYEqROHsiuaHYbAAiuY7BIuwu3pasJK8cRB0kFDyFrueCQho8DXVGtygU4w8IBm0T50s5RVelehpisp1bmosAuPFFVd3s30X6WrTszskX3+jbMSel7ICX+dKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVKV7JnITI6sQtqswZLr5U95ZbYju1jJd2uroLyzwy4=;
 b=cEd6ThRkWbmEWowawpeaiXC20T9qO+wvsKQzdOyVZdAOQrKUPYfNFrqlqIGxvgjzekApP16lbPfw6ZKYxQ5tMFMo4tqo/DYmErdLyaXvXYcVN7Aci6fvGvmKeWhUoyYbvJLSsjm59JjapGuqR/lVYf2xY/iFXgYfzY7YCLPVhP4lQQ2hoKInmiMacqDLDjTF/d/HuukldKN+Tkfs5udSpWkGGGQojgy7i/+jT3yqMSe8cND3sZlSmLUBPPiOTNHefGckSlqhZr8ltRMLQxy9dCdzqwgqdI0PflG86gLR94HUi9/Il8v3sIv6YFg7lZUSYMbesfKZrloUUlZM183GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVKV7JnITI6sQtqswZLr5U95ZbYju1jJd2uroLyzwy4=;
 b=ZpBiSWFtMSIMmM4mUoA+SSkI4BlaYiMyrWBOGJgixHQ+dKOgrBAOlI2G7SCI3bnFhVCttlJ4BijODnT7FLqRja5A2dUQHF3anQIwq/z6m9d005JEInN0gWDV6I2i4k4/4rlrQkmI4cIiczey2PXwQPkzK14MBOzE1jEJk1X2VOm/1nsMB+QCEug9nx3HkauVYUBrEAp65yYE0qdgZd4eD8CGcMegHq4PhDpg6oKT1bt3nWBAWoy6rJNVhhUZAoL0qnli+q21UBY0/LFYKtwMw3IYkTeGrqAzrjuCxPJzNvhQWqXqtQNCDvpw/y0+s4R+ecQ80x22+J+JAZVFNO8g6Q==
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
 by OS3P286MB1832.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:172::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 12:36:16 +0000
Received: from TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b]) by TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
 ([fe80::465a:2534:4d99:a25b%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 12:36:16 +0000
From:   Shiji Yang <yangshiji66@outlook.com>
To:     stf_xl@wp.pl
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 3/3] wifi: rt2x00: restart beacon queue when hardware reset
Date:   Thu,  2 Nov 2023 20:36:04 +0800
Message-ID: <TYAP286MB031594295F216D06BD076F4FBCA6A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101090710.GB552433@wp.pl>
References: <20231101090710.GB552433@wp.pl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [S5g4XuNPA7Xd8bOzYeEnobLBq+qZksqOppIVFiYynRY=]
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8041::8)
X-Microsoft-Original-Message-ID: <20231102123604.1353-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYAP286MB0315:EE_|OS3P286MB1832:EE_
X-MS-Office365-Filtering-Correlation-Id: 614360f3-400d-4c92-2e78-08dbdba04e2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACYmxLPchIeBj9kQW6MJ21N2QJhLVgDpBOAyn5exDN7K+RN5GoYetCyoXb3VjS28Bgf6NTsIC12eLacttlmow3HgmfUDHlgdsSgv/1F/mdRFHC7mYD5TZdkPq+ekigZQXmWMbqf6W4zyO8YLhuK8LBZ3nJEyeqzCpftFkIyYAxWzwM9t5zO159rHDc5M1pLulgr74KBLPvxzn/PLpudi5JqCP9MzYB2nEcMYuzlLRB8ERrcEltFKO15lmbSThvouPR5gCq6mG3nT/Jp9m//qmNRnD7HArUJLZurL5VmsuG9O5zGM/rhGxXjDRJD/LPTLKZfG3OlPOfgwB0F5BeKtL0vL/YpGKb4iYVCBN4Q3AKubtKbf03VlIZCvWAyx2KqnCqoTwGYUQQntbGIlIA3zdUOfvgdfg7FiiSkChIR1U0f1dqX13v9dgAqFjf7PDTyjv894NPheHn7prz4uZFpPdZFr9vW9NazLquHobLna0uAQB9In46NTO+T33bktsONiciKtU0ExaOUacZKG4pxvOs9tfxF+ux1jPCZ6sVrWmSdyp2Xh71jCiidFlWEkrvxD
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rh4p81vbXpfHI9IPsx9cDUPdqaRrPEjGlv5A0AJ6c+RcaUsSJ4Uvg8IiU7p6?=
 =?us-ascii?Q?TCHRxJ2cNQijVgzfnZ+ybjk6JkTn9piZv3S3sfWDQ0nHIh5fHWaEY1Kp8H3G?=
 =?us-ascii?Q?ThQpCEJV7nRgE4xCj9AKMLA3z2TkhOd/XF975Q8jN2eGVCNmpV+G3UfCTkkH?=
 =?us-ascii?Q?vbVweGvJFSqOuW4lm3ic9Vev1HIGbsvGoJNu/LrsP+KSYp1EWL4OTjLDeDRk?=
 =?us-ascii?Q?zIA3UCDsKDqtyEwb6S1Q8gxNXEgC0zGu8Z/nwuDVDtdJuJbRT1ao2CvyJTRK?=
 =?us-ascii?Q?JNDXB+m9cpZXlusVfw3bToAr3iAUa/V8k4KKHcaPOBUB3xJuJdvZ1tfjopD9?=
 =?us-ascii?Q?c9tn+ooCSlQ4FpdwKFBxkW9cGyg9+MWE0QtMtySVbNOPuvH2uc4peWNVAjRQ?=
 =?us-ascii?Q?uEE6JGlcKLFKrstY9MlyMTMuWF+5VNlfJCFQftcJ+WqifBI60suvx7tWFsia?=
 =?us-ascii?Q?VzCY5FPqagcI7UnJBofdtBZtlX1DW6Ha78kJoZIb2yX82rnwwDgvhsjULoSY?=
 =?us-ascii?Q?Gd9B1LAm+2dzhhsvk80eT+1e28tVzw/OhF4msd13MDKtkMVx5kVfw8LppY3/?=
 =?us-ascii?Q?ptxX6zUlede9BySJHeY9MmwFM1Q0u2EIBbbpMgCaEmRS6OofoCTRQpJaZitR?=
 =?us-ascii?Q?n9M5ZKWnqJH3bByrzo4U/2GS8lFJT4eaBdmzlxYyOdRymOfaeWlieQ+J7GVA?=
 =?us-ascii?Q?B6qaS+/7yZT8kuh6aatzs3ykIw3m6+L5xj7QoRYyJUFkQQxirwnJdX9FA1Nu?=
 =?us-ascii?Q?PVcXvnEWwnCYFwpGkxBAFK/XQVGW923EFCAsQCWA4oXnX1L3c+YucW7fxuB0?=
 =?us-ascii?Q?UracykcJy9T7sWVzmXUuCGpkNk4JQpd4gkgIeKNU5lssEC41ssbKnxRj/bXe?=
 =?us-ascii?Q?SJT90kZQvwJ0f+bNqA8CsuQxKI5b09eb1F/jH9PFOH91FsTtnLKBpa917bdD?=
 =?us-ascii?Q?uP9Q3pNiCPmrxADg19bh0cLOcMI8+1Q0wracf/7qis8Eq0rohheLH76H9Qzb?=
 =?us-ascii?Q?Fxtarft+JxavtUYNCLo73Ab+mQlhcQxC6aAqnvtvzZIJbozl8jdYWrgQaS5p?=
 =?us-ascii?Q?iCC8mAPjPRgzVMq5nIyA/GrhpcnvGQeiDkm9H5aor67ffk9b5i5H3hiFfzMz?=
 =?us-ascii?Q?rL5BFU2tKC+tR2tsP1+ywZtbKGzczafZ4UEIW9vkHps/ZWCDugCCHMGqgW9d?=
 =?us-ascii?Q?Xzxj3kRevRNq2CGvwCeuIMoSfciXDRjM+k4JKw6GhowoV1fVAK+KBJYDESg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614360f3-400d-4c92-2e78-08dbdba04e2a
X-MS-Exchange-CrossTenant-AuthSource: TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 12:36:16.4556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1832
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

On Wed, 1 Nov 2023 10:07:10 +0100, Stanislaw Gruszka wrote:

>On Sat, Oct 28, 2023 at 08:15:32PM +0800, Shiji Yang wrote:
>> When a hardware reset is triggered, all registers are reset, so all
>> queues are forced to stop in hardware interface. However, mac80211
>> will not automatically stop the queue. If we don't manually stop the
>> beacon queue, the queue will be deadlocked and unable to start again.
>> This patch fixes the issue where Apple devices cannot connect to the
>> AP after calling ieee80211_restart_hw().
>
>Should not this be solved in mac80211 then? ieee80211_restart_work
>does a lot o diffrent things, why beconing is not also
>stoped/started there ? 
>
>Regards
>Stanislaw
>

Hi! Thanks for your review.

I think this issue is a bug of the rt2x00. When restart is called,
mac80211 didn't call rt2x00mac_bss_info_changed() to update the
flag (This may be expected? I'm not sure. But all other Tx/Rx queues
are also manually disabled). And after resetting,
'bss_conf->enable_beacon' and 'intf->enable_beacon' are still true.
Though mac80211 will call this function and try to enable the beacon
queue again. However, both 'if' and 'else if' blocks will never be
entered anymore because all conditions are false. This patch just
fixes this dead lock.

Maybe Kalle Valo knows if it's a mac80211 bug. This issue has been
here for several years.

Looking forward to your reply.

By the way, it seems that 'intf_beaconing' variable is useless. Does
it really can be increased to '2'? Maybe in multi ssid mode?

```
void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
				struct ieee80211_vif *vif,
				struct ieee80211_bss_conf *bss_conf,
				u64 changes)
{
......
		if (!bss_conf->enable_beacon && intf->enable_beacon) {
			rt2x00dev->intf_beaconing--;
			intf->enable_beacon = false;

			if (rt2x00dev->intf_beaconing == 0) {
				/*
				 * Last beaconing interface disabled
				 * -> stop beacon queue.
				 */
				rt2x00queue_stop_queue(rt2x00dev->bcn);
			}
			/*
			 * Clear beacon in the H/W for this vif. This is needed
			 * to disable beaconing on this particular interface
			 * and keep it running on other interfaces.
			 */
			rt2x00queue_clear_beacon(rt2x00dev, vif);
		} else if (bss_conf->enable_beacon && !intf->enable_beacon) {
			rt2x00dev->intf_beaconing++;
			intf->enable_beacon = true;
			/*
			 * Upload beacon to the H/W. This is only required on
			 * USB devices. PCI devices fetch beacons periodically.
			 */
			if (rt2x00_is_usb(rt2x00dev))
				rt2x00queue_update_beacon(rt2x00dev, vif);

			if (rt2x00dev->intf_beaconing == 1) {
				/*
				 * First beaconing interface enabled
				 * -> start beacon queue.
				 */
				rt2x00queue_start_queue(rt2x00dev->bcn);
			}
		}
```

Regards,
Shiji Yang
