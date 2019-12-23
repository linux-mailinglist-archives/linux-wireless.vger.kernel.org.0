Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41376129473
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2019 11:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLWKxY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Dec 2019 05:53:24 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:61956 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbfLWKxX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Dec 2019 05:53:23 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBNAqnOP023461;
        Mon, 23 Dec 2019 03:53:16 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by m0059812.ppops.net with ESMTP id 2x1eu13bpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Dec 2019 03:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+3dR0wWyD936UGviX6FI63fJ2nZjnPigqaTbF1pI3SQ8GW2T/9x9Y3M1bbnuC6eAmnRGf+rWxkxZR7bMOB4+SKN4gyeY3UpYJ+SGpP7XAjlviCQgmt23Ghc54GkUOStJJ84hTFEayzIwfPeO7Y/rkiFk6WMK2s1ELal/waxnfVrYEUAezvEAh1wqRqXgdf9wlYoONjqENYPPPkUV9nmoE9NwRP5sAiNhD48kZ6NO1v64hzqeLBlCMdi+pcYEq0hwGRgQS8VsAdaHcGG5x/58N6pT9ovyczuuhkoJyS5Mlzi/6k2ZGCJNGPL1CgJfne+1nzKYytWQZQnLtT8+lI0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E90+380u87Szk8n8igZwa3a1GXSZGcxBJ2Qg0mGUyjY=;
 b=mhGeQlfBWI88rmE2tj/imL2e9ZhCGhrQsM0+mWH/WpxFTwuaj6PoL7HBLgIceCF+R4R7kLPoEVFNXXPlgKuuZDhW3jY7o9Ao93kMgbPx0/JKVCKCWjN+4QHZ1DMq8/bANTDoIQmnqEy28UxcwrA5nwFqSdeiKhWIUHfll5mHwroDhjtGMBEPp+Quc7VDiSkSdVQHrAOEaSMzNO1ie7C8UYb+wV8CIynnOJNeDgR79qDVdjpx4laMCCc4OQfb64tA9HMdsT3bfKnsJhHa1eZjG9I07WEAkkodQ7MEM2Nz5jM7LIg3Btd6DdslAdBNSoO7JXwr8ujEV0ao1tk5rBH/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E90+380u87Szk8n8igZwa3a1GXSZGcxBJ2Qg0mGUyjY=;
 b=Zz+x5zNdzWQT8ZWw3hNT+Lo0Xvdwh8U06JQnM/i1Kl9cWPg8l7n/tZRSUFYw+g/jp9dsCHJOgXVAtzTJi5BCpgJjkXvmbKOE52dCcbKIu3kyK2sqodQujBmYA7I9fACLO4Sd/Y5KNzWbsHOXsinwQ/0RLd8g3JK1nylqQmw/SJM=
Received: from DM5PR0501MB3768.namprd05.prod.outlook.com (10.167.109.30) by
 DM5PR0501MB3911.namprd05.prod.outlook.com (10.167.108.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.8; Mon, 23 Dec 2019 10:53:15 +0000
Received: from DM5PR0501MB3768.namprd05.prod.outlook.com
 ([fe80::69cc:e366:dd60:7bb0]) by DM5PR0501MB3768.namprd05.prod.outlook.com
 ([fe80::69cc:e366:dd60:7bb0%3]) with mapi id 15.20.2581.007; Mon, 23 Dec 2019
 10:53:14 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB4286.namprd05.prod.outlook.com (52.135.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.6; Mon, 23 Dec 2019 10:52:41 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2581.007; Mon, 23 Dec 2019
 10:52:41 +0000
Date:   Mon, 23 Dec 2019 13:52:35 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Orr Mazor <orr.mazor@tandemg.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] subsystem: Fix radar event during another phy CAC
Message-ID: <20191223105234.lgsupxfapbmxuvc5@bars>
Mail-Followup-To: Orr Mazor <orr.mazor@tandemg.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191222145449.15792-1-Orr.Mazor@tandemg.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: AM4PR0202CA0004.eurprd02.prod.outlook.com
 (2603:10a6:200:89::14) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars (195.182.157.78) by AM4PR0202CA0004.eurprd02.prod.outlook.com (2603:10a6:200:89::14) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Mon, 23 Dec 2019 10:52:39 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 524d7bf2-9a78-49ae-5ae7-08d787963b4a
X-MS-TrafficTypeDiagnostic: SN6PR05MB4286:|DM5PR0501MB3911:
X-Microsoft-Antispam-PRVS: <SN6PR05MB42868CC93C4AEDDC34022541A32E0@SN6PR05MB4286.namprd05.prod.outlook.com>
X-Moderation-Data: 12/23/2019 10:53:11 AM
Content-Transfer-Encoding: quoted-printable
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0260457E99
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39840400004)(366004)(199004)(189003)(186003)(5660300002)(956004)(26005)(316002)(6496006)(52116002)(86362001)(1076003)(478600001)(16526019)(9686003)(4326008)(55016002)(2906002)(8936002)(6666004)(81166006)(81156014)(8676002)(6916009)(66946007)(33716001)(9576002)(66556008)(66476007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0501MB3911;H:DM5PR0501MB3768.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vk90ehgzXCY+Axsp1JjDMZsQ7nG/lkBP1AdpmEyVNrSffXlCP3vqJ+1QwRXu5JrImy2p0iB/aDAYxZ+tP0ofIsGYcqhrONPM+vQZqwrOMPD7+xFu0bQwh/34sivynHAcUSizHwD0xHtSXwDDsOT2xCpYF4KoMQ0XFcISdHV3TGyID3Y4OosdDPI3EmNPE/siRE9eXAHwvt+zpuA1ZxEhJ3eoq5V5gW5UB1WAvUuElj3INAppPEh/bELe8Y+mV28tme4o8UBPy0xrU0Cs2akbw0UV/uYuWXGpevp3+z1OSbw5ROoZmt3KHve4N99rnlUaWWF691nc4ppG4eBSupS7oYsz1jfrsojHAachi/MV0gAXOUqgmKSNjMPo0nMbymT5uSEMBPu15sgxlb7aTeAqpUnJPnMvB+SjWdS9YBWGIGx2/QrdOJZG/jOvika0kka8
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 524d7bf2-9a78-49ae-5ae7-08d787963b4a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiN6PxjgcihCHxPTgFBwZps9uZuAVFZVCgFFH8w56uEMC+YK/04AVCjoMeR47ADVyBu9+xD+mk11ePLDMCRg48RCwAV3l6tcUk5Vy38nVvrl9owVTjRRe+oR5ErFo65NKY2YmmRR69FJ/BwUWKNpYRac30pJhYmOdSiqKATTNSlGoj8olN8Dwuboiych66KPEl6yv+F7HLuWePt+FmmF3hKtpSj6FjqDCU7Ep+ZjIwk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2019 10:53:14.5223
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3911
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-23_05:2019-12-23,2019-12-23 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Orr,

> In case a radar event of CAC_FINISHED or RADAR_DETECTED
> happens during another phy is during CAC we might need
> to cancel that CAC.
> If we got a radar in a channel that another phy is now
> doing CAC on then the CAC should be canceled.
> If, for example, 2 phys doing CAC on the same channels,
> or on comptable channels, once on of them will finish his CAC
> the other might need to cancel his CAC, since it is no
> longer relevant.
>
> To fix that the commit adds an callback and implement it in mac80211
> to end CAC.
> This commit also adds a call to said callback if after a radar
> event we see the cac is no longer relevant

>  net/mac80211/cfg.c      | 23 +++++++++++++++++++++++
>  net/wireless/rdev-ops.h | 10 ++++++++++
>  net/wireless/reg.c      | 24 +++++++++++++++++++++++-
>  net/wireless/trace.h    |  5 +++++
>  5 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 4ab2c49423dc..68782ba8b6e8 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -3537,6 +3537,9 @@ struct cfg80211_update_owe_info {
>   *
>   * @start_radar_detection: Start radar detection in the driver.
>   *
> + * @end_cac: End running CAC, probably because a related CAC
> + *   was finished on another phy.
> + *

Maybe it makes sense to follow existing naming convention here
and to use something like 'stop_radar_detection' ?

>   * @update_ft_ies: Provide updated Fast BSS Transition information to th=
e
>   *   driver. If the SME is in the driver/firmware, this information can =
be
>   *   used in building Authentication and Reassociation Request frames.
> @@ -3863,6 +3866,8 @@ struct cfg80211_ops {
>                                        struct net_device *dev,
>                                        struct cfg80211_chan_def *chandef,
>                                        u32 cac_time_ms);
> +     void    (*end_cac)(struct wiphy *wiphy,
> +                             struct net_device *dev);

...

> +static void cfg80211_check_and_end_cac(struct cfg80211_registered_device=
 *rdev)
> +{
> +     struct wireless_dev *wdev;
> +     /* If we finished CAC or received radar, we should end any
> +      * CAC running on the same channels.
> +      * the check !cfg80211_chandef_dfs_usable contain 2 options:
> +      * either all channels are available - those the CAC_FINISHED
> +      * event has effected another wdev state, or there is a channel
> +      * in unavailable state in wdev chandef - those the RADAR_DETECTED
> +      * event has effected another wdev state.
> +      * In both cases we should end the CAC on the wdev.
> +      *
> +      */
> +     list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
> +             if (wdev->cac_started &&
> +                 !cfg80211_chandef_dfs_usable(&rdev->wiphy, &wdev->chand=
ef))
> +                     rdev_end_cac(rdev, wdev->netdev);
> +     }
> +}
> +

IIUC, this code does not match your commit message. You are stopping CAC
on all the virtual wireless interfaces on the same PHY, but not CACs on
different PHYs. Meanwhile CAC does not need to be started on multiple
virtual interfaces. For instance, in multiple BSSID configuration,
hostapd performs CAC only on primary interface.

Could you please clarify the use-case which requires this functionality ?

Regards,
Sergey


This email, including its contents and any attachment(s), may contain confi=
dential information of ON Semiconductor and is solely for the intended reci=
pient(s). If you may have received this in error, please contact the sender=
 and permanently delete this email, its contents and any attachment(s).
