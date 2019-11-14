Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFD3FCFB0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2019 21:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNUbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Nov 2019 15:31:07 -0500
Received: from mx3.watchguard.com ([63.251.166.21]:20772 "EHLO
        mx3.watchguard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKNUbH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Nov 2019 15:31:07 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Nov 2019 15:31:06 EST
Received: from PRDITOMBX02.wgti.net (172.24.2.22) by PRDITOMBX01.wgti.net
 (172.24.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3; Thu, 14 Nov
 2019 12:16:04 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (172.24.2.15) by
 owa.watchguard.com (172.24.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1531.3 via Frontend
 Transport; Thu, 14 Nov 2019 12:16:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrSttZibDIGnXaUBYK+5pZ8j5QY8S8jNSHlIPFAk0MEli658lKuClejTCJ/n7yywI+MLkZG0mJPAuMVEB3ZiMQB6GbiYJaCzOcql/P9fUYS0wMhg7FbbwrgcQT4orku3gRne0qZDu1uH3XaUDMn1Gamwht5cYlpsLg1cy3Xka8MuHOIGRvA/zI3UzPgNT1sxCNb66Af/JBZOV/xMtM4w/KxkKgxooUwjSDZAabLghDGFeX66tnfkm6yXFv3ZK1zTs7weM0UykL7yeFhHJW2JvpcGGKiQWgx58wHp5jxe/gB2aQug/9C6N4ct0nJXOjWojne02e1V9b+9o2LsNhxlAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkjGPGm2vhIIPk+0HQaR2sXWd/dfQQ1yIZUME0LzZI4=;
 b=F1AMY7piMjUNk5JqYSQrBwc7PDwD8ttpAqGWe9Wi3sRROh9glDLlJkJw/+elYew7KRhyq3gJP7RM246JGQLWStPCTs32EV42ifKLM2YNayCOuE29rtmM+Y+KTqnoYUCj3FK74Q16yBeTiXBHmkYH7FM/qzUB6tmRAavrW3UHXapmuXBh4ehHWIclqA2LnwQ8ekasBKNiZ2fW6gNQdPGEAhH4Wo3GMn7OciAfKu6Pgg+PPfyFtk5FmMf0jipF/+iifvHNrnwMGRIiCrHc+kvNGvw9NnhpsdAbkfNwwKXwlKTTX9CUNXY+oZzhSP7oyYuSQ6LpOaVbniGToTuFYiSXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=watchguard.com; dmarc=pass action=none
 header.from=watchguard.com; dkim=pass header.d=watchguard.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wgt.onmicrosoft.com;
 s=selector2-wgt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkjGPGm2vhIIPk+0HQaR2sXWd/dfQQ1yIZUME0LzZI4=;
 b=fEY/cF3fNEch7OV7vc07xfppo8UFciYNJxj0xUxKIztKrps6LR45YUD/bieIYKkDA2Hj0nsQbTDdoHU0MuQStEyW3PVS2o8vbXKhUUY/QDaN48JTxsN1YRW/dthpD67l4gM2BOvXyWWwuys8wYbTL2jfPozhW6SIaB0yhx3Sphk=
Received: from DM6PR10MB2873.namprd10.prod.outlook.com (20.177.216.210) by
 DM6PR10MB3195.namprd10.prod.outlook.com (20.179.163.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Thu, 14 Nov 2019 20:16:03 +0000
Received: from DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326]) by DM6PR10MB2873.namprd10.prod.outlook.com
 ([fe80::481a:55d7:e282:c326%7]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 20:16:03 +0000
From:   Ming Chen <Ming.Chen@watchguard.com>
To:     Kalle Valo <kvalo@codeaurora.org>, Ming Chen <ming032217@gmail.com>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Topic: [PATCH] mac80211: Drop the packets whose source or destination
 mac address is empty
Thread-Index: AQHVmoA5bkZqiMBEWk6Kd/b0qWYy/qeKX2USgACXCHA=
Date:   Thu, 14 Nov 2019 20:16:03 +0000
Message-ID: <DM6PR10MB2873322F546E57D9C6D4DA6F9A710@DM6PR10MB2873.namprd10.prod.outlook.com>
References: <20191114001230.71469-1-ming.chen@watchguard.com>
 <874kz6de5z.fsf@tynnyri.adurom.net>
In-Reply-To: <874kz6de5z.fsf@tynnyri.adurom.net>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ming.Chen@watchguard.com; 
x-originating-ip: [64.94.121.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de677145-65dd-4aaf-7750-08d7693f792a
x-ms-traffictypediagnostic: DM6PR10MB3195:
x-microsoft-antispam-prvs: <DM6PR10MB319565D143C81240FE4066C09A710@DM6PR10MB3195.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(39850400004)(376002)(396003)(13464003)(199004)(189003)(8936002)(7696005)(74316002)(86362001)(102836004)(6306002)(55016002)(76176011)(9686003)(6506007)(53546011)(6436002)(305945005)(71200400001)(71190400001)(256004)(7736002)(2906002)(76116006)(66066001)(6116002)(476003)(33656002)(486006)(4326008)(446003)(11346002)(26005)(186003)(6246003)(316002)(110136005)(966005)(81156014)(229853002)(25786009)(66476007)(64756008)(54906003)(66556008)(66946007)(99286004)(66446008)(52536014)(8676002)(478600001)(3846002)(81166006)(14454004)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR10MB3195;H:DM6PR10MB2873.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: watchguard.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWctZaQrUYp/CV4fShYNf/Ycl7hWDTisG4sLFsaXneKBvELEHm9AhaHaEVHm8IfYOLarIQ44JD6CZf0a33zYnkYiaFDI/M9pql62rbS+e22fhauNTaEiCKxbe97teiPzFg7l/8UHgdLp9Kk8FtuelZkIrFiFqwYgVK39UizYroSbc+JrbysxPBKguCZ0t9irsF//MZeLun+DPjIpr5YqesjgMFYhvCqe0lz/fRRkp4Wf92uD0NPvv37jMPdOnDyci3u445iu9VAgprGWtYSlZo/wEQ1eeuJMzFtsIjlXcUng3G4h0uZKChVKHJ2X7FmjPejaRjpFekasuyMu1njD7cpQUDWDJ1pgJxemD5MWpv2Dt+rSFCjG7yDqdvvbeo/v8vwdvY6f1+HjI1DG/sLyXr8f0bp1rylay3fWDSy4wbT/7LZibvgw/gajaMO64Wbv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: de677145-65dd-4aaf-7750-08d7693f792a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 20:16:03.2377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2563c132-88f5-466f-bbb2-e83153b3c808
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLzF1Tx2xCFIK5jQj+lSZVGMd7l20erdglJdXx9mg7vuNmHXpibPG+FfcOAcZfF9M9JAbzOP4bkndMqvbJuDO5GaAeKR7nZr8qZY8uGy8IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3195
X-OriginatorOrg: watchguard.com
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Kalle,

Thanks for your review. I just sent a V2 patch. Please help me review it ag=
ain.=20


Ming=20

-----Original Message-----
From: Kalle Valo <kvalo@codeaurora.org>=20
Sent: Thursday, November 14, 2019 1:02 AM
To: Ming Chen <ming032217@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>; linux-wireless@vger.kernel.o=
rg; Ming Chen <Ming.Chen@watchguard.com>
Subject: Re: [PATCH] mac80211: Drop the packets whose source or destination=
 mac address is empty

Ming Chen <ming032217@gmail.com> writes:

> We occasionally found ath9k could receive some packets from Linux IP=20
> stack with empty source and destination mac address,which will result=20
> in the driver cannot find the station node in TX complete. And thus,=20
> the driver will complete this buffer but without updating the block ack w=
indow.
>
> To fix this issue, we should drop this kind of error packet before it=20
> goes into the driver.

s-o-b missing, please read:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes#signed-off-by_missing

> ---
>  net/mac80211/tx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c index=20
> db38be1b75fa..0668123e8e85 100644
> --- a/net/mac80211/tx.c
> +++ b/net/mac80211/tx.c
> @@ -2481,6 +2481,7 @@ static struct sk_buff *ieee80211_build_hdr(struct i=
eee80211_sub_if_data *sdata,
>  	bool tdls_peer;
>  	bool multicast;
>  	u16 info_id =3D 0;
> +	const int empty_mac[ETH_ALEN] =3D {0};
>  	struct ieee80211_chanctx_conf *chanctx_conf;
>  	struct ieee80211_sub_if_data *ap_sdata;
>  	enum nl80211_band band;
> @@ -2489,6 +2490,13 @@ static struct sk_buff *ieee80211_build_hdr(struct =
ieee80211_sub_if_data *sdata,
>  	if (IS_ERR(sta))
>  		sta =3D NULL;
> =20
> +	/* drop this skb when source mac or destination mac is empty */
> +	if (!memcmp(skb->data, empty_mac, ETH_ALEN) ||
> +	    !memcmp(skb->data + ETH_ALEN, empty_mac, ETH_ALEN)) {
> +		ret =3D -ENOTCONN;
> +		goto free;
> +	}

Can you use is_zero_ether_addr()?

--
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
