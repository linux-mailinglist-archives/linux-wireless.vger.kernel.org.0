Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE8313A905
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 13:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgANMKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 07:10:30 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:58670 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 07:10:30 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EC2ns7009123;
        Tue, 14 Jan 2020 05:10:25 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2057.outbound.protection.outlook.com [104.47.45.57])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xfa3a7464-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 05:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laL/c2MQCx3+MJWV4MWLqKP6baAUR4dGVpPHuMIliZvecxiVFd+02Fd3ILPDyyk7Sp2P0XdBSDzBUOXoPTFJhLbNd+hmiC3HsTnlK4KAwuXavEsekN4tbhSIWz6FhFJ9k9mtmqxDE5imodIhGkU19zSisiB6jPnJLtiiOFNAqj1+vyUMazfJj38ZqWZClg1c6CjR7bQui6EQZn+nM8MLRdCufeuWfgl4MFdaWi0Q2lvIE0evfp0L3BO7t7rBJbF4LfOqLylMwZfxxJmR5D0MYEI0csa+dPResHRcCteZ57OrWypnT/FxFbkfhQzY0KWKdD4hmW0vb2wutvrx3aZCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlXWeVjZqssf3fpoxxWxFfeOMyTZ+alfN5lbyHw4MvQ=;
 b=T7Eq5HMCWQ+32KldRSa0/axaHyG3Y1kUxslulbSgESAZaJS+79Pihiaxi2W6aWFIEsPFEvYh50lBo+/lIid883kFC4mhFT1Rs4YhZCS4kbYhAgpCW0X+xu0hvTwn34e0nSdo8fAzAQf8hPW5uPU7f4ie2eRjXApZIGm9m3fdPJsHZklkKcFAvyI6uA1VU8gxMCy2ufi/0DQM753iIRnT0uawuzd1PzqJ6b/BYY0tUYQNfaW5cWN+kZH04Y+Lup8eecreyCXiZFD5ax78x6CbYW9Cy5/lhmi8H11kpBk05VS1z8qIJSB+hxq0kbsbS6f2Y5Z9wTxUR+gvB8CnO8xnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlXWeVjZqssf3fpoxxWxFfeOMyTZ+alfN5lbyHw4MvQ=;
 b=AybaJOeaX40uAx4vZvh1hZKB7JfZeAnjCfKl5YVl9mfvS7ujF/VA2dNhjRU5iVK/FdLS3qPnbowUMxiTigQsMCYcVAkFP8YtyaNMvTM2leKv8VCwL1hMOVherNU2uuWcgrUw7O+gDhwB5SACa4R1LkSaRnZdKoMpDN9Yd2LEJdw=
Received: from BYAPR05MB6039.namprd05.prod.outlook.com (20.178.54.92) by
 BYAPR05MB4821.namprd05.prod.outlook.com (52.135.233.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.8; Tue, 14 Jan 2020 12:10:24 +0000
Received: from BYAPR05MB6039.namprd05.prod.outlook.com
 ([fe80::80b2:e0c7:df66:9c04]) by BYAPR05MB6039.namprd05.prod.outlook.com
 ([fe80::80b2:e0c7:df66:9c04%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 12:10:23 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6SPR01MB0057.namprd05.prod.outlook.com (52.132.127.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 14 Jan 2020 12:09:56 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 12:09:56 +0000
Date:   Tue, 14 Jan 2020 15:09:50 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
CC:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv9 1/6] nl80211: Add NL command to support TID speicific
 configurations
Message-ID: <20200114120949.7yl2qcahfgifohvl@bars>
Mail-Followup-To: Tamizh Chelvam <tamizhr@codeaurora.org>,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
 <1578921090-9758-2-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578921090-9758-2-git-send-email-tamizhr@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: LO2P265CA0400.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars (195.182.157.78) by LO2P265CA0400.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend Transport; Tue, 14 Jan 2020 12:09:55 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26e81a2d-7b0f-407b-de1b-08d798eaab5e
X-MS-TrafficTypeDiagnostic: SN6SPR01MB0057:|BYAPR05MB4821:
X-Microsoft-Antispam-PRVS: <SN6SPR01MB00578361562BA88849DCED4AA3340@SN6SPR01MB0057.namprd05.prod.outlook.com>
X-Moderation-Data: 1/14/2020 12:10:21 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39850400004)(366004)(189003)(199004)(66556008)(8936002)(6916009)(66476007)(1076003)(6666004)(81156014)(5660300002)(9686003)(55016002)(956004)(81166006)(66946007)(316002)(52116002)(4326008)(8676002)(16526019)(2906002)(86362001)(33716001)(478600001)(6496006)(26005)(9576002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4821;H:BYAPR05MB6039.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPGjOEjKKw2/Qi5EPSlPk8R7PuJHyizF13i7VZazUSrqxRJfs5g4HwnOoa1lo1dvl0Rfp3sFuMGKbMh8FIhfI26971jLqG67dL+AwVK+TeaZzNiNOB+BG9mTv/Cf0pFoNnjcFWaqwIM+/6eXo4YUJHL+LwgL5d1TtZcLoqkg1muEouyiORGHrmE+qRJwR0Lx7erTXM2DAxIzmSUbwt+gJC/hqrsh6T6zix/ruKhfeQlpCzFLhsmM2rjErcCrIHeHvPrbp9K2SlW5TR215c0YYc6crbs5GNYouYKKMMaGr6RMwc8NSUa47UPiNpDbkMd2uxK6vvGIvdqtGDFrX6S+qo5wnuj0pR3BLz1IeHj64yQgKddnMaPoT46t0RdE3fW2tzn5a/BKvl/XAR1f5RrxOd6IXn2gYG6m6602tGCD1pUTXGZ/e2EsrfqUqrgZiD0u
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e81a2d-7b0f-407b-de1b-08d798eaab5e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6SVl0+7E8R2dAw7Y3z//rX4wLTg5CzVd3Wlybt0XfzHxn3HwPj4sRoxv6cUKMkMoWGpUs53qZg6pSDRgwoTjc1RRu2quoi82r98pBO8nhggmw6LgIhzZiksqKyncp2m7kJqNMliUVtVv9rPZaR5nYnyhDq+9Yljov4QxAcjGP9pgiCqYraYDO6EF20iOeqD0mHZNtAPoSL5KAS8PxKZ9F5hmDN+J9agom2L9Ruyp4U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 12:10:23.8707
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4821
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Add the new NL80211_CMD_SET_TID_CONFIG command to support
> data TID specific configuration. Per TID configuration is
> passed in the nested NL80211_ATTR_TID_CONFIG attribute.
> 
> This patch adds support to configure per TID noack policy
> through the NL80211_TID_CONFIG_ATTR_NOACK attribute.
> 
> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
> ---
>  include/net/cfg80211.h       |   40 ++++++++++++
>  include/uapi/linux/nl80211.h |   71 +++++++++++++++++++++
>  net/wireless/nl80211.c       |  142 ++++++++++++++++++++++++++++++++++++++++++
>  net/wireless/rdev-ops.h      |   24 +++++++
>  net/wireless/trace.h         |   37 +++++++++++
>  5 files changed, 314 insertions(+)

...

> +/**
> + * struct ieee80211_tid_cfg - TID specific configuration
> + * @config_override: Flag to notify driver to reset TID configuration
> + *	of the peer.
> + * @tid: TID number
> + * @tid_conf_mask: bitmap indicating which parameter changed
> + *	see &enum ieee80211_tid_conf_mask
> + * @noack: noack configuration value for the TID
> + */
> +struct ieee80211_tid_cfg {
> +	bool config_override;
> +	u8 tid;
> +	u32 tid_conf_mask;
> +	enum nl80211_tid_config noack;

You are using nl80211_tid_conf type for noack, but u8 for ampdu and
rtscts in further patches. On the other hand, they are using the same
validation policy: NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE).
It looks like it makes sense to use the same type for all of them,
either u8 or nl80211_tid_config.

> +};
> +
> +/**
> + * struct ieee80211_tid_config - TID configuration
> + * @peer: Station's MAC address
> + * @n_tid_conf: Number of TID specific configurations to be applied
> + * @tid_conf: Configuration change info
> + */
> +struct ieee80211_tid_config {
> +	const u8 *peer;
> +	u32 n_tid_conf;
> +	struct ieee80211_tid_cfg tid_conf[];
> +};

...

>  /**
> + * DOC: TID configuration
> + *
> + * TID configuration support can be advertised by drivers by setting
> + * @NL80211_EXT_FEATURE_PER_TID_* and/or @NL80211_EXT_FEATURE_PER_STA_* config
> + * mentioned in &enum nl80211_tid_config_attr.
> + * Needed configuration parameters are mentioned &enum nl80211_tid_config_attr

are mentioned in ?

> + * and it will be passed using %NL80211_CMD_SET_TID_CONFIG through
> + * %NL80211_ATTR_TID_CONFIG. If the configuration needs to be applied for
> + * specific peer then MAC address of the peer needs to be passed in
> + * %NL80211_ATT_MAC, otherwise the configuration will be applied for all the
> + * connected peers in the vif except the peer which has peer specific
> + * configuration for the TID. And the peer specific configuration will be
> + * override if %NL80211_TID_CONFIG_ATTR_OVERRIDE flag is set.

overridden ?

BTW, it looks like there is a minor mismatch between docs and code here.
Looking into the implementation, peer specific configuration can be
overridden only if both override flag and peer address are specified.

> + * All this configurations are valid only for STA's current connection
> + * i.e. the configurations will be reset to default when the STA connects back
> + * after disconnectiion/roaming, and this configuration will be cleared when

typo: ii

> + * the interface goes down.
> + */

...

> +static int
> +__nl80211_check_tid_conf_support(struct cfg80211_registered_device *rdev,
> +				 struct netlink_ext_ack *extack,
> +				 const u8 *peer, struct nlattr *attrs[],
> +				 struct ieee80211_tid_cfg *tid_conf,
> +				 enum nl80211_tid_config_attr attr,
> +				 enum nl80211_ext_feature_index per_tid_config,
> +				 enum nl80211_ext_feature_index per_sta_config)
> +{
> +	if (!wiphy_ext_feature_isset(&rdev->wiphy, per_tid_config)) {
> +		NL_SET_ERR_MSG_ATTR(extack, attrs[attr],
> +				    "TID specific configuration not supported");
> +		return -ENOTSUPP;
> +	}
> +
> +	if (peer && !wiphy_ext_feature_isset(&rdev->wiphy, per_sta_config)) {
> +		NL_SET_ERR_MSG_ATTR(extack, attrs[attr],
> +				    "peer specific TID configuration not supported");
> +		return -ENOTSUPP;
> +	}
> +
> +	tid_conf->tid_conf_mask |= BIT(attr);

Unless I missing something, the first 3 bits in mask are going to be unused
since NL80211_TID_CONFIG_ATTR_NOACK is 3.

> +	return 0;
> +}

Regards,
Sergey
