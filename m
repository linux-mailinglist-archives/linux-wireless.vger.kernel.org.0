Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A2D13A959
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 13:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgANMdx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 07:33:53 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:48936 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725994AbgANMdx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 07:33:53 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00ECUhac018769;
        Tue, 14 Jan 2020 05:32:08 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xfafg5w4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 05:32:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSDz9LFV8YmSPJtMfQZ8IZh9N2egpSdHTnEKNiYpNEzIv5LY66wZu6XC6dvg0qeoQVIlTUwRHLuz2LKD4XaGKQ88jQpTtXxDrsnMqxDZi/0vfqbjFEtcAMBYAtT1EANQ7qO8tXBP4/pKLfRXd4EZrZz3ax2Yu7GaYSxFWoiIurj8DfUnIv0ThwLBZeRrGHOqrlQ+yxaR5ugr7MEs7k4CyD/hmfGBhO7mEmNlt7YGUzWHrsfrzrGUsrnEL+ro2a+komEcegjUtHK63/7YPUTInm6NUGvyYJM0wbGab23xy+0oY+NJi15pfrP9f7hQbIJG/yheiIFvg6GWErV4XDYQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ9DrkMfOAwTbDwAUSwryqa4w/tyyodWQu7goL2Yy0E=;
 b=C9jvPi3OOSa7dP/SAcJxr8GM3Xsq0mO8wI7J9Pyl5zch9v06j43K4Q6+TPD3N5dltGyU0BiJsPG8nEtbSlCvDJFtek+PUpibF/gW+IWHiZZJT+zNTLGpWGuw2ar5SaskzjNBp3jRrLmbyuIOhywVxx3BTMQo1tGZaJtTP6+PpN0dx9Ez2nrQRlYVVfno9qF/TqGv7sPEadStog1PFLDls+lb+7I2AduSNAo95Mv0x413ASjDOyWCyOVRPDuQMeRi01yBFm+C/rd23WdBH6sH5saJx+3ipMXczmh4/IL7+ZCl1KflAoGGT+JjuFNAuLaRanxdfKcMah3YWR5pyIxePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQ9DrkMfOAwTbDwAUSwryqa4w/tyyodWQu7goL2Yy0E=;
 b=NO/5m/YiBA9sBI/0dhADH1zL5pBx6yRfPPF6lZLc5TqUFJFpacMy6gkgxtKpvxrWEo4irgEzVfH3D3GsNnMOiZ1IeHtYejES8zayGcqkXVEsqdfhSjKRXlzgRNd+TfUYSKs/azRgr5k6N6q7zjGv8x97SmWIs20kGBzN2TSC1MA=
Received: from SN6PR05MB4159.namprd05.prod.outlook.com (52.135.67.138) by
 SN6PR05MB4751.namprd05.prod.outlook.com (52.135.114.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.16; Tue, 14 Jan 2020 12:32:06 +0000
Received: from SN6PR05MB4159.namprd05.prod.outlook.com
 ([fe80::1cb0:4867:5f58:4959]) by SN6PR05MB4159.namprd05.prod.outlook.com
 ([fe80::1cb0:4867:5f58:4959%6]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 12:32:06 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5854.namprd05.prod.outlook.com (20.178.6.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10; Tue, 14 Jan 2020 12:31:15 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 12:31:15 +0000
Date:   Tue, 14 Jan 2020 15:31:09 +0300
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     Tamizh Chelvam <tamizhr@codeaurora.org>
CC:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCHv9 5/6] nl80211: Add support to configure TID specific
 txrate configuration
Message-ID: <20200114123108.5mrzvyqkjp7defln@bars>
Mail-Followup-To: Tamizh Chelvam <tamizhr@codeaurora.org>,
        johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <1578921090-9758-1-git-send-email-tamizhr@codeaurora.org>
 <1578921090-9758-6-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578921090-9758-6-git-send-email-tamizhr@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: LO2P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
MIME-Version: 1.0
Received: from bars (195.182.157.78) by LO2P265CA0100.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 12:31:13 +0000
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 633ac74e-5311-43d0-4716-08d798eda57d
X-MS-TrafficTypeDiagnostic: SN6PR05MB5854:|SN6PR05MB4751:
X-Microsoft-Antispam-PRVS: <SN6PR05MB5854DC55CAD2E013E92E5E46A3340@SN6PR05MB5854.namprd05.prod.outlook.com>
X-Moderation-Data: 1/14/2020 12:31:39 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39850400004)(346002)(136003)(199004)(189003)(316002)(478600001)(55016002)(26005)(81156014)(4326008)(9686003)(8676002)(52116002)(81166006)(6496006)(1076003)(6916009)(9576002)(186003)(33716001)(6666004)(16526019)(8936002)(86362001)(66476007)(66556008)(5660300002)(2906002)(956004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4751;H:SN6PR05MB4159.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fjr80ElGTNphSvY3vqKlON+pa84I3CGGJFU3PY33kaWtDSaSE5Ueov8YElPQkz1IVzYMNnRQmnYqLqsjSciH+6IBaBPU3gZWDhgARsPcL2DKVv05Wj5Ly8hiSJ+AtlqEyjHV37DPnVKUhFWZqBgvzBAmH+KCy81+spw83R4UIDHYhb7h8mnyNw6UFLeEV2EGyI8lRuQrgRAMN899TmTK38+MCl0kkR1pbv/MAQXg6vP5I9ynLjq12oueNTMwponmIfgiD4dNZKPD5ZVqJjqWxnSpwKqGAlGn88UxokIdruFZ8iIhc1Jj0yTV8OLW3B/okgF2Qk7sNxnNKpBCwkWfjByeqpEKcdk4v4Ylh7N1ccfdaOVNMTrzFyhgikbhdcZdMmGGjJpnAc8FAN3Gbz5vmL6zQL2ZDSS+IM0p2x6c/AUo373ifXbLHipmGm6K4PXf
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633ac74e-5311-43d0-4716-08d798eda57d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8VPmWBYdxTVECQcBlS514eD5yF+7V4TV/eq+MPFHW1nrNOQR4SxiJK/bYBYf3KbrkEvVmLVJkl3e+sOcvHSlVlWvSrnMSSc40zaAQaJChzL18m0JD7N/dSnB3EmCHOntPTnBQdgIZvTvEKxlyQ+Bcb+EGPbajqOJbyvVEgVgOjvch7I502xOPvemV4ZXq774ISyEc+URnml+7niLKM7kBYlK4igAAtZi9u1tuX09+U=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 12:32:06.3393
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4751
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 suspectscore=2 spamscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This patch adds support to configure per TID txrate configuration
> configuration through the NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE
> and NL80211_TID_CONFIG_ATTR_TX_RATE
> attribute. TX bitrate mask values passed
> in NL80211_ATTR_TX_RATES attribute and NL80211_TID_CONFIG_ATTR_TX_RATES
> attribute will have types of the TX rate should be applied. This uses
> nl80211_parse_tx_bitrate_mask to validate and calculate the bitrate
> mask.
> 
> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
> ---
>  include/net/cfg80211.h       |    5 +++
>  include/uapi/linux/nl80211.h |   24 +++++++++++++
>  net/wireless/nl80211.c       |   76 ++++++++++++++++++++++++++++++++----------
>  3 files changed, 88 insertions(+), 17 deletions(-)

...

> @@ -13936,6 +13947,37 @@ static int parse_tid_conf(struct cfg80211_registered_device *rdev,
>  			nla_get_u8(attrs[NL80211_TID_CONFIG_ATTR_RTSCTS_CTRL]);
>  	}
>  
> +	if (attrs[NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE]) {
> +		int idx;
> +		enum nl80211_attrs attr;
> +
> +		err = nl80211_check_tid_config_support(rdev, extack, peer,
> +						       attrs, tid_conf,
> +						       TX_RATE);
> +		if (err)
> +			return err;
> +		idx = NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE;
> +		tid_conf->txrate_type = nla_get_u8(attrs[idx]);
> +		if (tid_conf->txrate_type != NL80211_TX_RATE_AUTOMATIC) {
> +			tid_conf->mask =
> +				kzalloc(sizeof(struct cfg80211_bitrate_mask),
> +					GFP_KERNEL);
> +			if (!tid_conf->mask)
> +				return -ENOMEM;
> +
> +			attr =
> +			(enum nl80211_attrs)NL80211_TID_CONFIG_ATTR_TX_RATE;
> +			err = nl80211_parse_tx_bitrate_mask(info, attrs, attr,
> +							    tid_conf->mask);
> +			if (err) {
> +				kfree(tid_conf->mask);
> +				return err;
> +			}

IIUC we have to free all the allocated tid_conf->mask entries in the end of
nl80211_set_tid_config, right before tid_config is freed. Alternatively,
struct ieee80211_tid_cfg can be modified to keep cfg80211_bitrate_mask
value rather than pointer.

> +		} else {
> +			tid_conf->mask = NULL;
> +		}
> +	}
> +
>  	return 0;
>  }

Regards,
Sergey
