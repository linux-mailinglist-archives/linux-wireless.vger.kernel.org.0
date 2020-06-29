Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A4720DD98
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 23:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgF2TTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Jun 2020 15:19:42 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:35783 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbgF2TTl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593458380; x=1624994380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YRxFko49T/RkTyYo5LydKE3gdEuk4o7OwqcKxxEnhm4=;
  b=sj72FVZl10q6JC3nj4s8qAiEsujwx499LiePVteA/kXuCBIkilSLol4h
   fG/Av8h+nXXZmiUR7L+0WlYbwDiiFu6IIslyUjA9N8vTX8pjppvuuiIYK
   leNL81HpEFFDVUgZpYo3QPqIaCpDR6g+eg5PauQvF5cmUjcDOPOgFdWJr
   N3J1/BfSqDyr8g84PIc8QqNzuO0u/5U5ezxx2lrHHlQRaFmiUFH8A1lJ5
   AecWotLnPx5NzEH55yE9kxo/ebytmO1YR3OrkAlVjq5m8O7V7IdtNOI7s
   JA4N0bReFinxytWjAv8GIhIPy3AQUfkxG86hQWvmS1+Z6X9yl+amia8FP
   g==;
IronPort-SDR: KimqwOEICyCQsndK3x2OUhXf5pbJPm2F6UnHTRODQQVfS7xU8PBwQrQm0Znt9xsjd6Y0N9CdHi
 67oOmV7Jzwpm4R5t0wePftcohW1D2MW2apsNCdgtUXV9ye9QAqS3TS7H9X+hpVx2X2K+qjzVrR
 iFoMnqVZs+k+28O3P40JckZkpRmTUqcqhoh1I9huUYFb//pElmFL3DzWCyLXwq8Oz11RXycAMI
 32ilmqlWxsj2p1UzVr6ax74yV+wdm0PlzG8Nl81R4wrqpg5nmbZqOZifh0cTEuHNvbhHYFb/3+
 11A=
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="80042894"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2020 00:58:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 00:57:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 29 Jun 2020 00:57:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGYPx51bqXylkdw/3pS+7vHtblY3Yf/fLPAJixEIhzyyuozt9G8LAT0VlMldHERPdilBLS+ZhafJsQ8t5Z1I/IESzf8TLUNzu6YhrJwtpapEs/R+R+GmApuz7bRbUKPko1WIaSHfzullgV7U1kJDGMwROGBKBh47h64xXRK+f15iSBP3Yzz6vpJgC16AbuKFwCM/Mg60k6tdW0IIoTdVmMDLJgr6Vs2PwO/+PK89t6oDK6ROZcgFrSYU54k6l6T8QjBO7xeZEqIyxSaSjFhIXh+AaIZr2htIJXR4XCX61UC8TVojNfbm4mbC9YooRLJEIdsb+lgS3hg0RVnI0hw/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg3yeOWd2KZKnrbwXZ1HFczYIm/VMiEqtO92m6zu8Q8=;
 b=RC0jy44JbUpA/aFz4Qe7Cv1THCekhHuv7s6CVRIwv2SM9HsTVQQoHvOhBbCOXo6oFKzo1R6xvU7pIUmvEieiaEkDgh+UGHvi0IuGNEqD/9T/Ny76mYiKBJ+5Kq24Xh/KDakJfDMUYmNAW/xxdqUDXN0Rsu6rFgGOLLCx8mDofhtLT8kFmAYgzE9uaTPtH6WRtF6xXybUUQvFVFBMGpONaEw/pdwatKF9pkDQsOVCG1O8mfrJ9Vzg6wZEEjqKRSIA9QJ67rUgG31uuvK/p2YXuxs7MxkUEppXYFzCVaTXF8gZI+CIrYd0F2Yhmkdjv6pqbxzInu+JKwni+oLnzAyz7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg3yeOWd2KZKnrbwXZ1HFczYIm/VMiEqtO92m6zu8Q8=;
 b=R3sHFEMciqcbghEgOCGyWbU0E5e23SQt2LqlKQNlQz2hFFTXsS8uOFemUbqH0mUszNz0hzgtqL+c0JedOnq2LUmCYJ2Lcsjm4MNX1X0LTxMfS26x1t/Gop9klKqVjy5alDCWv1bkLylo32F9jhXjWqSoo2JK6nYaoMEqaV5u/fc=
Received: from MWHPR11MB0061.namprd11.prod.outlook.com (2603:10b6:301:65::37)
 by MWHPR1101MB2205.namprd11.prod.outlook.com (2603:10b6:301:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 07:58:10 +0000
Received: from MWHPR11MB0061.namprd11.prod.outlook.com
 ([fe80::839:6dcc:f6ca:c110]) by MWHPR11MB0061.namprd11.prod.outlook.com
 ([fe80::839:6dcc:f6ca:c110%5]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 07:58:09 +0000
From:   <Nicolas.Ferre@microchip.com>
To:     <luc.vanoostenryck@gmail.com>, <adham.abozaeid@microchip.com>,
        <Ajay.Kathat@microchip.com>, <gregkh@linuxfoundation.org>,
        <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging/wilc1000: let wilc_mac_xmit() to NETDEV_TX_OK
Thread-Topic: [PATCH] staging/wilc1000: let wilc_mac_xmit() to NETDEV_TX_OK
Thread-Index: AQHWTesHl2p6IKflZUGXS90sZNaWRg==
Date:   Mon, 29 Jun 2020 07:58:09 +0000
Message-ID: <8a2f50dc-2cbe-64e4-438c-4320bb574f4f@microchip.com>
References: <20200628183237.74749-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200628183237.74749-1-luc.vanoostenryck@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a01:cb1c:8c:b200:48f4:f3d1:160f:9dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f0df8e5-d09f-47d3-e92a-08d81c022a4c
x-ms-traffictypediagnostic: MWHPR1101MB2205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2205BDBFAE52AE9858248379E06E0@MWHPR1101MB2205.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EE/i1N9M8uVwlBptaOofCPXXkdtdLh26Wz4rR56eU3MDW2mNndNPLi2P+KszUyzGoS5RytWuZNYOY3I8kDs3ctst8zvJVlcRnXVPzy8kEIml8ubnPJriba4H5Cok2JvVi0nI4rnojspRFCtzb+i+yHtgjHy1nvZoGgNDC8ldkoifIjbo5bAgUnszsf7w5EFKk12vOeg1Y930gnAz3J4l+iYDvUr+StjbDnyRSOOgywbqAYMH34W9FbFXMTnkoPB2KriJpe3pent6Aq8eH7DjjLYTtMo24bZe8RwNaTvA5kMccBjMFqAIly1ScwrWJ40DrOdmd/mXQCnsUP91iNchXplgf7nwDQYZY40PNxQ3ffslA+awog0Q/QBx1b9uMDF/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0061.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(39860400002)(376002)(396003)(346002)(6506007)(86362001)(53546011)(2616005)(6512007)(31696002)(83380400001)(71200400001)(54906003)(478600001)(2906002)(6486002)(4326008)(31686004)(186003)(8676002)(66476007)(66446008)(5660300002)(66556008)(76116006)(36756003)(316002)(8936002)(110136005)(66946007)(91956017)(64756008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uRP9mmhXKgFaO6Pfs1kcUlAD7BuE0zPYa8rNbFLlWKTMx9+xvAXwHSPnmAUGUm+Sv8+HHGNmlxJ82Qn8Q+o4VNmRmROLH6VKSn2AzasuR6zBIbGrX3Jo3l6nRVNlzxDcYLiZJ2gcpOn5mz4/FtEzyU8VhH4kPg4u0agSWb6f4KoImNp1qg5vsPxul/rxt/Un3V16e61Fx2cQ2X8S2uUKqW5AHK2D8sDnQmA1K9JuUVf9RjN8l+pRYOfHlBJObsj71JbVje4411pzmPsIOW5zYlEwoPFScXvHJpv29Uay75KNxbe2D1nSB8iKXYQ9sEl0LkJTjIktt+HH4hqI3hTxWvRKTN2ynugaCLb9HKKZbHKneIoA31SfaegPCOGgrPjlX4Ig1b89/FzR5yFCbJQu8FPvlYXju95O5SLYCy4FL0Q/PbEDPx3C/wkV+oPd45bVzeHVBgIWe7WSKeyDT00b1D3/AZuJIV5Vc+LUMznf9nlwUZkRe6HhAXWiymMrgJzzRcELiFsqxn/GgonkD1aif+pkkC+Wdr8AjJyqckSeUhM=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0937E8E2F395B749BB5BB95C20BC8D24@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0061.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0df8e5-d09f-47d3-e92a-08d81c022a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 07:58:09.5942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzzZAPdFENlras2QwTFl+rgA0DAJZjVnlkN4VC05SsOdB8iJ5I4+EsCInall0/yB7Ab01OTPDShfwq5k6b/efmFeKLvE6HahH1SZOFdvtzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2205
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luc,

Thanks for your patch...

On 28/06/2020 at 20:32, Luc Van Oostenryck wrote:
> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type defining 'NETDEV_TX_OK' but this
> driver returns '0' instead of 'NETDEV_TX_OK'.
>=20
> Fix this by returning ''NETDEV_TX_OK' instead of 0.
>=20
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   drivers/staging/wilc1000/netdev.c | 6 +++---

... would it be possible that you re-spin it so that it applies to the=20
new location of this driver:
drivers/net/wireless/microchip/wilc1000/netdev.c

You can rebase your patch on the wireless-driver-next tree with=20
wilc1000-move-out-of-staging branch:

tree:=20
git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.g=
it
branch: wilc1000-move-out-of-staging

(Then you can also review the subject line of your patch, BTW)

Thanks for your help. Best regards,
   Nicolas

>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000=
/netdev.c
> index fda0ab97b02c..be3ae5486f44 100644
> --- a/drivers/staging/wilc1000/netdev.c
> +++ b/drivers/staging/wilc1000/netdev.c
> @@ -678,14 +678,14 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, stru=
ct net_device *ndev)
>=20
>          if (skb->dev !=3D ndev) {
>                  netdev_err(ndev, "Packet not destined to this device\n")=
;
> -               return 0;
> +               return NETDEV_TX_OK;
>          }
>=20
>          tx_data =3D kmalloc(sizeof(*tx_data), GFP_ATOMIC);
>          if (!tx_data) {
>                  dev_kfree_skb(skb);
>                  netif_wake_queue(ndev);
> -               return 0;
> +               return NETDEV_TX_OK;
>          }
>=20
>          tx_data->buff =3D skb->data;
> @@ -710,7 +710,7 @@ netdev_tx_t wilc_mac_xmit(struct sk_buff *skb, struct=
 net_device *ndev)
>                  srcu_read_unlock(&wilc->srcu, srcu_idx);
>          }
>=20
> -       return 0;
> +       return NETDEV_TX_OK;
>   }
>=20
>   static int wilc_mac_close(struct net_device *ndev)
> --
> 2.27.0
>=20


--=20
Nicolas Ferre
