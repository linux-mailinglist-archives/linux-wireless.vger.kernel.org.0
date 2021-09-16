Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E82940E3E9
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbhIPQxA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:53:00 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:11873 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345752AbhIPQut (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810969; x=1663346969;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snusMlwh7w0F89xQSSWO47PnEfQYhjgNsKCRezcNchc=;
  b=VQOxbGJkMwnvAM4y1kdaRKCjWsXM0usUnJcU/t7oDh/DEdCovW/dm0QR
   9lzoWIhYB68XlzM9I5si2/63nHV298nfbCTXQlKeyGatOTr6WnDNmb+9h
   k/bOhkzKUVNWgLbQx/544dSoh3wVDs2JvH/00etbBoiILWp1xd/EfLFLD
   OYB6MxTxH5Zg3JKg3t8pQUZ+leGNB7GDCSVo6Whp3hYIeCBUJPq6c6akh
   NB8hT13ewXxYQCXtPbnCJ8YnDrwXWlIIOU5SR7+tg0siRzZcf378rok67
   NIO9Cbd1UB+cludfqH8b7WFCsD6gKFXQNKacteIWcwMfGdTB86L0JbHcj
   w==;
IronPort-SDR: wbfGaCxPwuwiANZg+a1bc45AMMCwqGfrDgLfAn9ilgkqzDtdZUHAkK4twce4wTgVZUiJipr33r
 jSy+CWsD6XoiynY+oZaA6hyQ//CXp26O87ZWDmH1rM58bauoeoyWQlnOIrsxMFoMGghsgkt1WI
 gfcS6ixxcMHAi8pVdno0VAr1zCSFl6rzeAjVib30SqXOYss/0eSNxi3LqqvhFGf0r60K1OW/vY
 lNpu3HBA1CmIfCA0KDjg1/UoLw/lcYFLsap5rOFj/ISd87MPBydilHGsvuBmJrr1C0HGlewseK
 v558HNTV1BkYKHsfDs8WNQ8k
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="132089778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqGZqnrZmaicvVkI2UcUvSjoCwHCDYg5UtVAgUX1trZH1FSCGd6glCLJ3CtKufV0FXKEUt3kk5QNi8CcbHPPi+nGY2embByiJCbAkTEZQactIsm1muGkZL1FVE11KJ9hxsQtk9Z6Im6nmIan9VSP7Fo4SsOa9N/zfq6oEgyF/5NG3M04wKU5T1kUOlTnni0pHUG9eknM35oICgRvFrvVZPvAwJOhoo4vIAMPe2Jl+lzrYsp8C7x083unS+c6MZg0neWXlsNKoUsVoMJsLR5M6cN2MXJ2DZcTpd5v0WZr0HypTncCJgHnALxShL4SYe8u/pfM8sYD9+jpBKvAhv8pjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fZVSgySNqzZP8CQHePX2jefRh9byqXnOJDJw/kVNV4Q=;
 b=hURi2Nwrcr9qpPghGxcH4rsfyxzb+LGQI6bL1b+C1BOYmq3XRoui4i1aQpwkTscK0iloWaQXVR2IPBTM18Y4sOkivo9/d77ZYjvPXiD/Hbr00zlcK3t75pyVWov7Kwv4TwNcyzxzD08piqcOm15ud/HLyPE6SjnDVd3HcwJsxYUgZKyJtTux0/3fWisU398pufcJrOOllJNoboORws6BDuaRQ31le2WwAJRk7lvyODHikbZQmQGKOPWu3RwAOrESbVeF+peecboRiKOtvT4IEZycc2Gsu46B7+MfHqGCccCUEZAloxx8drTI19kzRTXm9FvaGiQg3ASvQkPIrjLL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZVSgySNqzZP8CQHePX2jefRh9byqXnOJDJw/kVNV4Q=;
 b=mNZkx4VZjUwtACeuDCJX0d6lmAS4SCLloc3nPmhe+W/An4nHy0VD4mqwndnObY8AY/KR0Fi2KtqJ4fEjaJ+kz3h9omUNMkuejX5VWDkm+AlgmO4wj4zmy2fbBCRCqidyPwzjxMVGtvWI+dQ7GDstSypui5eq6LxcAQfLbxcLQ3k=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:19 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 04/11] wilc1000: configure registers to handle chip wakeup
 sequence
Thread-Topic: [PATCH v2 04/11] wilc1000: configure registers to handle chip
 wakeup sequence
Thread-Index: AQHXqxrKCB5luK3DD0ulSA8CbfvGcA==
Date:   Thu, 16 Sep 2021 16:49:19 +0000
Message-ID: <20210916164902.74629-5-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c368b93-408d-44f2-45c9-08d97931ed69
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5197B46EA0D018B936C3A4DEE3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SM+Cluv4o7zGntFOGe3iI79yb28UaP5SIzrKUJPWGYulX5W0gDJTFzl2wS/YG/EWNobt9nBPsjAevPJMq9w733GFGpskzD5VuqrTWialbe+Z8AprkKzE/5HSs0d9wsyMEkh79iooqrLY2ESHgGPbXyosgiMOMuhsoJFBgqdO/RDE+3DKB1o8+NxiqLyrsJCj3W0M36TGoAAEeJzSwjf3uMgnISpk2oHndbE7EHuRoVX94LVGQPGCOskfVGwqwg5mLiY7M3h4RoYba+3X5/8oqeJodELS7cBevOOk2jnDa4RYJMBgbzmD7D416CHA1GwMYS7YNMpT/HVdXwmjd6+sxG0deDT2Re8RTw/ddyg/dt93TCRClceUAbwgIZDc445RK6FcqcBrRXt8URGs7JUKg1QiPPC0FFkM+oJ3hv4ySr+ZpCX2FBYENB5nQhOhzbpEn1c+wDFaGn0vIbaNR5oSMLI9dSu5qisjgmRGh7nH659VVHdxCqszUSelBa35oq3ZyjKT3KMdL5b3rkLMJ3ozoqEPCPsaM+woZpwmPEDewixwzE/QwK4DsUMSWmbXVoj6WK9YX7B2Bnpjf5RqUKKCsNKZIkIQO4XvP51nd8bstNF6MFWszZLJvbuJusmHa25jpOwwUa4nS6ETVJfogVWDPxn5lKhQQowv47xxZfQTrgLgMZLrM0sXRArku8VcR7Kp/VXGs0jnk8QmW8kAskyv4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?blSHp97CS7Iw6Sx975r5sLoynbpRS9jpC4u92st5lJPNicyiBFAbZ7oZC1?=
 =?iso-8859-1?Q?1a6n5KEdyfEnjtNH+1uT1rLlDbsJKuK0mk5cJQR0i2Rda/FRHayq2xXiHF?=
 =?iso-8859-1?Q?/YxNGx2RZItodIB3wLyV2XVgMunGi3Rto0rihiV5Twhc/51ol6CtRoGfXJ?=
 =?iso-8859-1?Q?CR3LBaccwyBbrDPFmGJvUomRveYgPW1p1bOS7GlMx0bNb1HJHrhWpBKQCA?=
 =?iso-8859-1?Q?ZS3tBANs9dBjvbTZ8ydw5EHT3PRaVaCfPVsFAMqG988uzDV9tFrDWgnqA/?=
 =?iso-8859-1?Q?x4U0wLeCvg4qxf2L9X9gCv+LnG51YCgediSUlQy2oHjykB9AgMLPmUAHtk?=
 =?iso-8859-1?Q?+rCgjcUkX9nJZwZ2v5FKLXNG6xVQPN8BUmPG4K7MFmAZNyvF2TnwLpeSh5?=
 =?iso-8859-1?Q?7oet2H0Zh5UUdgk5PZIOODj3kAkZPS/0F7devB7xoY2+FcuFwbNlHX4Tqb?=
 =?iso-8859-1?Q?KJglvIiG3kYLMeF9M2SNMNiLu41/J3tbpJCJr3paUPu+ANfnXmsEdRGZA4?=
 =?iso-8859-1?Q?mHPP6ZoN+cIlN0jnENBiJqfSwSNyG/5rf1wELpmkxX1s9HM51zBYMh1Uhc?=
 =?iso-8859-1?Q?nxjASJslrKkwo8Y/KIV1ZuQXHNFXWRodE1HSeVIjng/d2omjnB3fK0RL3w?=
 =?iso-8859-1?Q?h45Tlepn3qG7VRRuI8V+hQyfcNp3d+n0L+wf6W/uguejCSle5Q8pyuqfmi?=
 =?iso-8859-1?Q?QFuYpEetBoKzGw0OxytKRlYt0DPaFlJ6jU3QWxrO5QYlr5P4aIs+NVed8o?=
 =?iso-8859-1?Q?avPYYw1Ilh+xBLeIK1SOc1b2jMMbMAxOGllmuBAufiFhLsvcjWy3afXSgt?=
 =?iso-8859-1?Q?efnXRQzC5FXvbo6529RYrMY95Y1s2eSx0o/iK6d/+Ug4LmzzHb5ZSY2KHJ?=
 =?iso-8859-1?Q?e0oy7HhF9lLovyhTs57vIUqENk4kVm4Xh8JvJ6dS/vjghM4R9LhlgUTMdH?=
 =?iso-8859-1?Q?e2tns/b3j07k1u7IO/Z5S5Hrv/ZU4A6VltGm+KqhvbizxmxEDHoYJzmEXe?=
 =?iso-8859-1?Q?lFwoGDreSqEb2gXyzOd3iY86+Oi4dXBhNHZ2Ev2UlzlLOAZiw0DR8P8WFy?=
 =?iso-8859-1?Q?JliXPOx7ufZG/WNWV1u8OX6pt3LnBtwH7VtH2FFptF80BwqLQJQqSTZeE9?=
 =?iso-8859-1?Q?jZNDvOi28T2GwPMXRtSkoLqNycxpeI5kazbgxz7WZoGJ7rrNX7M1DkFiv/?=
 =?iso-8859-1?Q?yTiXnnnQwP2oFMZ0CC9mWTtc5NCd5is+68kqHDCDVt9JnAJ4O1XmjOy6m+?=
 =?iso-8859-1?Q?jekPfzZIn7idiyrQXa615V7xVSNHutbt/uslYqXxkN3WKjYosoHwvJxlor?=
 =?iso-8859-1?Q?fHRokdHSA2Y1ZSKikWBfvH04R794AxQ1dKM3D9m/JfhxhWwf4zmlqvXjeJ?=
 =?iso-8859-1?Q?0qsgaImHaW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c368b93-408d-44f2-45c9-08d97931ed69
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:19.2187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/x+GoRZlStL8RlZR4rZYKXkBaVW4OjNvdZlY53E8LJIeyjEyogbyRQkGHfAPJU9Kgpr5ezXtIvBKPZ1xt4XY2TTxlj+ly5o2J/fHVNnIZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use the correct sequence to configure clockless registers for chip wake-up.
The following sequence is expected from WILC chip for wakeup:
 - set wakeup bit in wakeup_reg register
 - after setting the wakeup bit, read back the clock status bit for wakeup
   complete.

For SDIO/SPI modules, the wakeup sequence is the same except uses different
register values so refactored the code to use common function for both
SDIO/SPI bus.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  1 -
 .../net/wireless/microchip/wilc1000/netdev.h  |  1 -
 .../net/wireless/microchip/wilc1000/wlan.c    | 98 ++++++++++---------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  6 --
 5 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 75160ab3914a..91a471f3b1c8 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1726,7 +1726,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 	*wilc =3D wl;
 	wl->io_type =3D io_type;
 	wl->hif_func =3D ops;
-	wl->chip_ps_state =3D WILC_CHIP_WAKEDUP;
=20
 	for (i =3D 0; i < NQUEUES; i++)
 		INIT_LIST_HEAD(&wl->txq[i].txq_head.list);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a39c62a20f04..79f73a72da57 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -265,7 +265,6 @@ struct wilc {
 	bool suspend_event;
=20
 	struct workqueue_struct *hif_workqueue;
-	enum chip_ps_states chip_ps_state;
 	struct wilc_cfg cfg;
 	void *bus_data;
 	struct net_device *monitor_dev;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 200a103a0a85..1aad537c468f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -10,6 +10,8 @@
 #include "cfg80211.h"
 #include "wlan_cfg.h"
=20
+#define WAKE_UP_TRIAL_RETRY		10000
+
 static inline bool is_wilc1000(u32 id)
 {
 	return (id & (~WILC_CHIP_REV_FIELD)) =3D=3D WILC_1000_BASE_ID;
@@ -611,60 +613,62 @@ EXPORT_SYMBOL_GPL(chip_allow_sleep);
=20
 void chip_wakeup(struct wilc *wilc)
 {
-	u32 reg, clk_status_reg;
-	const struct wilc_hif_func *h =3D wilc->hif_func;
-
-	if (wilc->io_type =3D=3D WILC_HIF_SPI) {
-		do {
-			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
-			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
-					 reg | WILC_SPI_WAKEUP_BIT);
-			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
-					 reg & ~WILC_SPI_WAKEUP_BIT);
-
-			do {
-				usleep_range(2000, 2500);
-				wilc_get_chipid(wilc, true);
-			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
-		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
-	} else if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
-		h->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG,
-				 WILC_SDIO_HOST_TO_FW_BIT);
-		usleep_range(200, 400);
-		h->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
-		do {
-			h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
-					 reg | WILC_SDIO_WAKEUP_BIT);
-			h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
-					&clk_status_reg);
-
-			while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
-				usleep_range(2000, 2500);
+	u32 ret =3D 0;
+	u32 clk_status_val =3D 0, trials =3D 0;
+	u32 wakeup_reg, wakeup_bit;
+	u32 clk_status_reg, clk_status_bit;
+	u32 to_host_from_fw_reg, to_host_from_fw_bit;
+	u32 from_host_to_fw_reg, from_host_to_fw_bit;
+	const struct wilc_hif_func *hif_func =3D wilc->hif_func;
=20
-				h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
-						&clk_status_reg);
-			}
-			if (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
-				h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
-						 reg & ~WILC_SDIO_WAKEUP_BIT);
-			}
-		} while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT));
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
+		wakeup_reg =3D WILC_SDIO_WAKEUP_REG;
+		wakeup_bit =3D WILC_SDIO_WAKEUP_BIT;
+		clk_status_reg =3D WILC_SDIO_CLK_STATUS_REG;
+		clk_status_bit =3D WILC_SDIO_CLK_STATUS_BIT;
+		from_host_to_fw_reg =3D WILC_SDIO_HOST_TO_FW_REG;
+		from_host_to_fw_bit =3D WILC_SDIO_HOST_TO_FW_BIT;
+		to_host_from_fw_reg =3D WILC_SDIO_FW_TO_HOST_REG;
+		to_host_from_fw_bit =3D WILC_SDIO_FW_TO_HOST_BIT;
+	} else {
+		wakeup_reg =3D WILC_SPI_WAKEUP_REG;
+		wakeup_bit =3D WILC_SPI_WAKEUP_BIT;
+		clk_status_reg =3D WILC_SPI_CLK_STATUS_REG;
+		clk_status_bit =3D WILC_SPI_CLK_STATUS_BIT;
+		from_host_to_fw_reg =3D WILC_SPI_HOST_TO_FW_REG;
+		from_host_to_fw_bit =3D WILC_SPI_HOST_TO_FW_BIT;
+		to_host_from_fw_reg =3D WILC_SPI_FW_TO_HOST_REG;
+		to_host_from_fw_bit =3D WILC_SPI_FW_TO_HOST_BIT;
 	}
=20
-	if (wilc->chip_ps_state =3D=3D WILC_CHIP_SLEEPING_MANUAL) {
-		if (wilc_get_chipid(wilc, false) < WILC_1000_BASE_ID_2B) {
-			u32 val32;
+	/* indicate host wakeup */
+	ret =3D hif_func->hif_write_reg(wilc, from_host_to_fw_reg,
+				      from_host_to_fw_bit);
+	if (ret)
+		return;
=20
-			h->hif_read_reg(wilc, WILC_REG_4_TO_1_RX, &val32);
-			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, WILC_REG_4_TO_1_RX, val32);
+	/* Set wake-up bit */
+	ret =3D hif_func->hif_write_reg(wilc, wakeup_reg,
+				      wakeup_bit);
+	if (ret)
+		return;
=20
-			h->hif_read_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, &val32);
-			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, val32);
+	while (trials < WAKE_UP_TRIAL_RETRY) {
+		ret =3D hif_func->hif_read_reg(wilc, clk_status_reg,
+					     &clk_status_val);
+		if (ret) {
+			pr_err("Bus error %d %x\n", ret, clk_status_val);
+			return;
 		}
+		if (clk_status_val & clk_status_bit)
+			break;
+
+		trials++;
+	}
+	if (trials >=3D WAKE_UP_TRIAL_RETRY) {
+		pr_err("Failed to wake-up the chip\n");
+		return;
 	}
-	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
 }
 EXPORT_SYMBOL_GPL(chip_wakeup);
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 771c25fa849b..285e5d9a2b48 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -97,6 +97,8 @@
 #define WILC_SPI_WAKEUP_REG		0x1
 #define WILC_SPI_WAKEUP_BIT		BIT(1)
=20
+#define WILC_SPI_CLK_STATUS_REG        0x0f
+#define WILC_SPI_CLK_STATUS_BIT        BIT(2)
 #define WILC_SPI_HOST_TO_FW_REG		0x0b
 #define WILC_SPI_HOST_TO_FW_BIT		BIT(0)
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 31c68643731d..6eb7eb4ac294 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -48,12 +48,6 @@ enum {
 	WILC_FW_MAX_PSPOLL_PS =3D 4
 };
=20
-enum chip_ps_states {
-	WILC_CHIP_WAKEDUP =3D 0,
-	WILC_CHIP_SLEEPING_AUTO =3D 1,
-	WILC_CHIP_SLEEPING_MANUAL =3D 2
-};
-
 enum bus_acquire {
 	WILC_BUS_ACQUIRE_ONLY =3D 0,
 	WILC_BUS_ACQUIRE_AND_WAKEUP =3D 1,
--=20
2.25.1
