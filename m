Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43BE02F9F3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 12:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfE3KDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 06:03:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42186 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725440AbfE3KDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 06:03:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UA1eD7008511
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 03:03:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=zLoJLAugWQtrpsjTQ1TCevvrsf/hEY4pUiVG0TzYUlk=;
 b=ta0uB11imI6ysISsRM9VRQLtxZ4n2jibMULVdUfD5A007MqWquHdFuA87AQeOgjkK+UN
 k1qKhBmmsbn25s7R5e2ky5XS+t4CnjlcMwmKFiLMra4wdor+U9Ul80J0Evf4Nb9HbRz2
 qlkvdmBt93058PxlCsgEQ9pL9IkQ0RHjb87uYAERdY/Urm4HKtPkZrX2xwm6k++z9twc
 AY2bTOyezrR4x72aOKFLMgjGhDBZP9vFFTrGCeH6MnzugMGPDd0CJy5jCq+tPimtPWBq
 qSs2nBfcY2nhTMTLqZFoX80lS8ZblLHsqW6d0nCPC/ej8FhFQBO+hLyhRvoHBVprkKgA oA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2stba98dnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 03:03:51 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 30 May
 2019 03:03:51 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 30 May 2019 03:03:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLoJLAugWQtrpsjTQ1TCevvrsf/hEY4pUiVG0TzYUlk=;
 b=cltWcifGFCeCTMgsuQDSd9lCNK5VKO81kv8pFNlocFsRXAFMgI1Ecw7gBF0JV4+NNQf/6P1su63z1cJ24paSuNQaZabADpUCoutnABOd4ocB6+hbcnUY6PMfXGBEnesW1zno57tUCAd38v1tpuWWPubgCN8FYraDra7wRidXZIY=
Received: from MN2PR18MB2637.namprd18.prod.outlook.com (20.179.80.147) by
 MN2PR18MB3104.namprd18.prod.outlook.com (10.255.86.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 10:03:46 +0000
Received: from MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8]) by MN2PR18MB2637.namprd18.prod.outlook.com
 ([fe80::3c77:9f53:7e47:7eb8%7]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 10:03:46 +0000
From:   Ganapathi Bhat <gbhat@marvell.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>,
        James Cao <jcao@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Sharvari Harisangam <sharvari@marvell.com>
Subject: RE: [PATCH 2/2] mwifiex: add support for WIPHY_WOWLAN_ANY
Thread-Topic: [PATCH 2/2] mwifiex: add support for WIPHY_WOWLAN_ANY
Thread-Index: AQHVFs1/8zyTkymwpkCT7xicipVzuqaDcCtw
Date:   Thu, 30 May 2019 10:03:46 +0000
Message-ID: <MN2PR18MB2637696EA96F4EDB41C41319A0180@MN2PR18MB2637.namprd18.prod.outlook.com>
References: <1559209955-10089-1-git-send-email-gbhat@marvell.com>
 <1559209955-10089-2-git-send-email-gbhat@marvell.com>
In-Reply-To: <1559209955-10089-2-git-send-email-gbhat@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [182.72.17.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d929c320-4234-49c5-8f3d-08d6e4e61ae0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR18MB3104;
x-ms-traffictypediagnostic: MN2PR18MB3104:
x-microsoft-antispam-prvs: <MN2PR18MB3104C406E3A2BB0E8894325CA0180@MN2PR18MB3104.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(136003)(346002)(199004)(189003)(13464003)(486006)(478600001)(7696005)(86362001)(476003)(14444005)(6436002)(8936002)(6916009)(81156014)(53936002)(446003)(8676002)(71190400001)(76176011)(107886003)(5640700003)(14454004)(2906002)(3846002)(6246003)(6116002)(11346002)(71200400001)(256004)(2351001)(54906003)(25786009)(99286004)(4326008)(81166006)(9686003)(305945005)(68736007)(76116006)(186003)(33656002)(66446008)(64756008)(73956011)(55016002)(66556008)(52536014)(316002)(66066001)(66476007)(26005)(66946007)(5660300002)(53546011)(7736002)(6506007)(102836004)(229853002)(74316002)(55236004)(78486014)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3104;H:MN2PR18MB2637.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vr80HU1xhSen6tB7Wpo2chY8OM4xHeWUlr3415rp44MlmPoiS7RxVxVOb0myzMGpzRcsCcIkRdUH0E4Hebs+YFL2yPnbihu28xF/gRAo51t6zW6whgsfAkjJEpV9gscT2OAFYk9LlL1iLI3jhh266Dzk8pkfg1IqGgojNXwyDYJseSkhd+LX0QgsYDgb/kduC4oMjIDa1EAOHQ3hdGvfDZGdt11pP3B0OZNaAYYPstQQDBmLcbm7M7Ct2vJN2FF2O0DjrErtwRlnW1WGNNN2BbQQ+e46zG6fKx+xea0kL99fWOKmF+zxYa2GWatH/qFx1k/H9+K3UIiajHY3HzNH96xwxQht+wJ8jYbOajvldts/BH4TD5cs0jDVqISXPU17d/zcz4ooZOzsWVJDE6EY2JE7h3WFwOeT3ou4eBuktkQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d929c320-4234-49c5-8f3d-08d6e4e61ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 10:03:46.3439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gbhat@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3104
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_05:,,
 signatures=0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

Below is the second patch in the series; Kindly help to merge both;

Regards,
Ganapathi
> -----Original Message-----
> From: Ganapathi Bhat <gbhat@marvell.com>
> Sent: Thursday, May 30, 2019 3:23 PM
> To: linux-wireless@vger.kernel.org
> Cc: Cathy Luo <cluo@marvell.com>; Zhiyuan Yang <yangzy@marvell.com>;
> James Cao <jcao@marvell.com>; Rakesh Parmar <rakeshp@marvell.com>;
> Sharvari Harisangam <sharvari@marvell.com>; Ganapathi Bhat
> <gbhat@marvell.com>
> Subject: [PATCH 2/2] mwifiex: add support for WIPHY_WOWLAN_ANY
>=20
> From: Sharvari Harisangam <sharvari@marvell.com>
>=20
> Advertise support for WIPHY_WOWLAN_ANY trigger. Update default
> hostsleep condition to handle magic packet.
>=20
> Signed-off-by: Sharvari Harisangam <sharvari@marvell.com>
> Signed-off-by: Ganapathi Bhat <gbhat@marvell.com>
> ---
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 +++---
>  drivers/net/wireless/marvell/mwifiex/fw.h       | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> index e11a4bb..f23bb9c 100644
> --- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> +++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
> @@ -3492,7 +3492,7 @@ static int mwifiex_cfg80211_suspend(struct wiphy
> *wiphy,
>  						  wowlan->nd_config);
>  	}
>=20
> -	if (wowlan->disconnect) {
> +	if (wowlan->disconnect || wowlan->any || wowlan->magic_pkt) {
>  		hs_cfg.conditions |=3D HS_CFG_COND_MAC_EVENT;
>  		mwifiex_dbg(sta_priv->adapter, INFO, "Wake on device
> disconnect\n");
>  	}
> @@ -4232,7 +4232,7 @@ static int mwifiex_tm_cmd(struct wiphy *wiphy,
> struct wireless_dev *wdev,  static const struct wiphy_wowlan_support
> mwifiex_wowlan_support =3D {
>  	.flags =3D WIPHY_WOWLAN_MAGIC_PKT |
> WIPHY_WOWLAN_DISCONNECT |
>  		WIPHY_WOWLAN_NET_DETECT |
> WIPHY_WOWLAN_SUPPORTS_GTK_REKEY |
> -		WIPHY_WOWLAN_GTK_REKEY_FAILURE,
> +		WIPHY_WOWLAN_GTK_REKEY_FAILURE |
> WIPHY_WOWLAN_ANY,
>  	.n_patterns =3D MWIFIEX_MEF_MAX_FILTERS,
>  	.pattern_min_len =3D 1,
>  	.pattern_max_len =3D MWIFIEX_MAX_PATTERN_LEN, @@ -4242,7
> +4242,7 @@ static int mwifiex_tm_cmd(struct wiphy *wiphy, struct
> wireless_dev *wdev,
>=20
>  static const struct wiphy_wowlan_support
> mwifiex_wowlan_support_no_gtk =3D {
>  	.flags =3D WIPHY_WOWLAN_MAGIC_PKT |
> WIPHY_WOWLAN_DISCONNECT |
> -		 WIPHY_WOWLAN_NET_DETECT,
> +		 WIPHY_WOWLAN_NET_DETECT | WIPHY_WOWLAN_ANY,
>  	.n_patterns =3D MWIFIEX_MEF_MAX_FILTERS,
>  	.pattern_min_len =3D 1,
>  	.pattern_max_len =3D MWIFIEX_MAX_PATTERN_LEN, diff --git
> a/drivers/net/wireless/marvell/mwifiex/fw.h
> b/drivers/net/wireless/marvell/mwifiex/fw.h
> index b73f99d..ad34b25 100644
> --- a/drivers/net/wireless/marvell/mwifiex/fw.h
> +++ b/drivers/net/wireless/marvell/mwifiex/fw.h
> @@ -478,7 +478,9 @@ enum mwifiex_channel_flags {
>  #define HostCmd_SCAN_RADIO_TYPE_A           1
>=20
>  #define HS_CFG_CANCEL			0xffffffff
> -#define HS_CFG_COND_DEF			0x00000000
> +#define HS_CFG_COND_DEF		(HS_CFG_COND_BROADCAST_DATA
> |\
> +				 HS_CFG_COND_UNICAST_DATA |\
> +				 HS_CFG_COND_MULTICAST_DATA)
>  #define HS_CFG_GPIO_DEF			0xff
>  #define HS_CFG_GAP_DEF			0xff
>  #define HS_CFG_COND_BROADCAST_DATA	0x00000001
> --
> 1.9.1

