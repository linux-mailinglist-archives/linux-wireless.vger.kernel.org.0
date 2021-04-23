Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2813699AD
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbhDWSac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:32 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3594 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243723AbhDWSab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202594; x=1650738594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bYhaGcQCRZn/7J7SkQWVCRs6ykftsD2zlNT3xIeznjo=;
  b=DtjfLHAfy6uAGqkCmyM5iJYqWTmtKdfsrPowj/zxwsw8Fuwac9tAEkMV
   oGwcmXEnpTF0jBFgqKj3Jdw6oH7KCw1FIx+UiG7b+wiIAAiISZ4wkEZ2t
   pTg/7i27butsgLeQ467QFMmYZ8AfuZLuFtHJtqUhRdedLeKp9m6zhVmhU
   iljhCIpfTY/Z66SlUD3lLuhDSDBt+iGKmfMUhYcMmQWSsslB84RIPVmcV
   Ku2OKtKHuxBTrRbXM0Z4PgtZCfH1GqXYwHDA8CwDYnjYsqctFHaErHN/c
   Ta3baeOm/L7dssB24eTwro69TVqUTIvuWh2IX+Wa1hs80q9WbAZ5TOsS4
   Q==;
IronPort-SDR: 4wW0zPpsVS0zOGddzq/DjNfkdPoe+8tgZz5nBHb+ITV6c2siAzOkOqg5W8aqHlBdvfgREjbK9m
 DAFsisByyqs2zvkmOxcM2dbFPK2mk6EpJKC3gu6w607A9rUvMCPG13LMqKWRrYqwjmCxexc5zg
 zJO5PdpRh2KM6YBtopTgToY6J5A9lZHV9c9XY57tUgSqClsBc4PY7ATpB6WD61Ed+4VRmfY8Ty
 0YcnkZ5U1fcJA0ytn4Bis6s89+jokOnV08Y/ybDbH5Wnb2zWOK0rqgAvlrY2WaS9oFSwgnuoz2
 SYQ=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174649"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOg6CyQJ52FQDoVXzw7fRAj+1w0gsFFXnW3t6PXuID9/RV/rUraRpB2cioh2WB7BwErvznvhKAe2zBQAekraoMapwNGypdVpa9q5M6+mguqudOgmgWe1TIKHmBFbhA9ZTaA2pcpaOWtqmiuqoZz1mJXcOEtHv8zjshX4AvHORbsOlOrvpNqGiG40oXDqme/T6CX8MFP7u7jxchLt/S4nsv8mZs/siOB7mxhWyhOSdbznBS59HyirHRzQKHkdt5V/aXAXQQ/wFoabM4Fb4Q26VaMvP5SNZ5MbgDq9qNw1tfy1+ANZm+Bp4bmMes4IjNjZTmzIkdMx3K+FoA91/zYrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERsdS5s7ed0q32z2cd5Fw684ylQPbPC9CqA/EawwHFM=;
 b=JWsVRg9ZDuM+hlU1qrn7lP9jDkWMIDcK69a1d0obSFpKFYorDTlZVC6TKrk/h48PvePCSH+jM8rEXK55EJF3HIYKYqwJFj60RmfY/Tvn38jzu9EeoEAXxMVJrKjAjT8lohMS/ge1S6kD66upRIlMCg0elywzI1luFNEZXtIFjhcAjMCy+DV2/RdhQq2MTzH4DyrYCwzUxAgJQaNTtpKghMpr8tGc5xdg10l1qTVwaGG89o4H3yCg9AFkH37+crUukwkELiE051K+BZ+zZwwrid3biN6yC9Nd6hRSAUGnDAlelLa/mNfuSze31GmBLcGpBjci7gkRqAPCdRZyuW9PcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERsdS5s7ed0q32z2cd5Fw684ylQPbPC9CqA/EawwHFM=;
 b=XS+mwSJVKvaDgr6Akjyn/4IDwTCUWlJ9C9FHKmyC4yrFVp2vvMJGKDv2qVsNsk3Gsb0AD6xoZ/RTfMRMqmlzKCaYu/vYwXGuB+YGSPhEk7t/LQuOTp91ndUnS3B5G9Hy+BqG63tosEmb9BLaAaExxXAGrK6jUZtN/tsvx+16Ucw=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:42 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:42 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 03/12] wilc1000: added new WID to pass WOW info to firmware
Thread-Topic: [PATCH 03/12] wilc1000: added new WID to pass WOW info to
 firmware
Thread-Index: AQHXOG6gPjibZyJzLUi012SKzLZdng==
Date:   Fri, 23 Apr 2021 18:29:42 +0000
Message-ID: <20210423182925.5865-4-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58bc36ea-300c-41e6-c709-08d90685c35c
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB331870A07625EBEFD186CCDCE3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djGta5PfUjEFAK2qJCPHbqOvRxxDdKQZHVrQEG/OgsyRIPuFh3OBTYX+HN6sATzlT7exR2y8P20o7udbY731kMAfxqvTUFk/FpQTfnrfPWsTTpkuhNexWy1ZV7rpj/DHWuRWmhOEwAU4mDsPlz8DBb50IDE+bMZHrDcHvPjoory4+cirp96UP1F70zKq9lqEd1L+fxTGZNTAbhEYY0ycNSMAkYgrnW6yY5p68Rzg181UviANZoLWSbr0Kze6Q6a7GnNiDo3c3Gy0SPywP7pqE/4gXrfRxzBK0+8o7L+YMigy7xkzzx3h4NDa9m6MB4dWCld9WaHf1hQ53gskjVlCDFu8BI0+DszPbdsAmv27MxTOaTqMtl+vpOTMbVN6SnkC75n5BOo5s66hB1XFWY7Kb8VF7mqGBQT71B+a3jXYJyOtWDqvh6pgylMWozEWgEhAdwb5ihfjD/re44i2eDj90UZfMqr0gSsCPkZe37a1/J6GzvGlEMQVhuKU9gnPeWDT63W44d3ZA9/T+9AkYWBIKBp65DHCngHFSdgdLyWaqngefRzx4ZmnmvMOiyXqKf3KufWwWxZsD2DlvwiZN1Hco6Vl98ofe9loscS//Dfc4II=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vFEb7kc5xAyhBak/oKNhRMSiNq+tS82krpE0R8atuhqG5H6ejD8NxdThSZ?=
 =?iso-8859-1?Q?raHVvRF1gLqq6tQ+7dyURBGyvFCl7tlYpKr7leWDOIeSZkWz4kc0OTerFX?=
 =?iso-8859-1?Q?ndV7DsIyU00+Bb3XbCn7WvKIOcWwtXWFQtyhE/kmO3vhQkqOcoNYoLW4e/?=
 =?iso-8859-1?Q?C92gCOYruzOhlEz7RiB1C4F9kG64tTuFQc3pQT+E2m4NzwayD8YmTUfKJW?=
 =?iso-8859-1?Q?ReKf0cw2RpTF21iyvGCzuCAG2B9Y2rLo+7K3z9SwEG+R44NqfKkYt9INco?=
 =?iso-8859-1?Q?vUbYw2PnxvGXj9/zWNPLxkNHqcrv4HwhZ4Wd5iIFC3iJj5p9yOor3uUi1x?=
 =?iso-8859-1?Q?HI5z+UNLFedtHggHDMwHKrc1uSA6wSMmr7bJ6THCGiDeyHD3igdSbO7Aa5?=
 =?iso-8859-1?Q?s9UPHccc02W6EZhj4Y8f3/gfI3zMZYx3qOYIR3DeVvOAe8dZkb3uq4Umcv?=
 =?iso-8859-1?Q?i5XQCx8xBZetqwjoTKkNSSlTfiZBkl6u1KfFxVJEaUX9P1oiK88vddCAqy?=
 =?iso-8859-1?Q?+Y2kyLbS1ReDZe5IJwo7Q9YXjmbuHbpz94GZOBKEH8koccu4o1r1yTW/hx?=
 =?iso-8859-1?Q?AFQGS64y3a55/VmdPkZMLoUZDcbJUMG9vvHhI+PNBZVn1+HVyuVY96MPUY?=
 =?iso-8859-1?Q?D6e6O0nMIt5HyTDqAcIUjGRr/Yh4qkd6ZsaJz6mF1iUppag64T+yQ139yr?=
 =?iso-8859-1?Q?//8/VnnZ+PxhtO74p4WnxeuBWt0ZTXI9oPyl8bNjtjsBAByAxg2ph/UMGL?=
 =?iso-8859-1?Q?73+u4VbgUxE7RnXKrTG9qd8HKxSyWdLSLREnyYEczXo1g9rzIt7qJ3ZmY7?=
 =?iso-8859-1?Q?TGLcACWA6knDStwAu++nHZd/eEVDwZqxJ+teSPNsYKK/6PFLRzdnfnVx4Q?=
 =?iso-8859-1?Q?yqzh102IYH8GsXpy5/x9Ux3zaiAhnE9z4v7sJoQHR7sw90CCBHbi3jr42c?=
 =?iso-8859-1?Q?8VzO04ICmfrEjsUkp1rdFGTf6OauKnha7f2uSDbJWlsNbvFn2ziPKd82U0?=
 =?iso-8859-1?Q?bj2TPakZWuCB9ivR+e6V/RhmhX5pTWSrtksXvQbQFouYswHJFICmQez0iL?=
 =?iso-8859-1?Q?xmJsTaJnCEqVZnsSMozfNm27pPfEJ9Ud9H2G+7oZUJmJBIqatA2ha6UIHY?=
 =?iso-8859-1?Q?0SXaqM+EmI9VtjJyGdoamnLPIsTkAIASaP7TVaZ08KMx58arHo6KZomWvw?=
 =?iso-8859-1?Q?U+b5cbsRR3NzbzyKw2NjpHxERJSMejc6/E8C1xHohhsdspgyocmREMHP1X?=
 =?iso-8859-1?Q?jkflFxFA8B7CjdL7exmdkjW0wjgyw2xVHIo/iMhmD4l51kXl7q6kFvSKYh?=
 =?iso-8859-1?Q?D9XkpucwEbTo+GabO8EQIQIqOdvGiNHMl4iBmnEcEfm37Qy7EPF5avNIi6?=
 =?iso-8859-1?Q?yFd8JSJvvbMXAcTLDt3HJF4CJRcC25ZA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bc36ea-300c-41e6-c709-08d90685c35c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:42.6843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFsCf91ldwflVtyJTSQAmx8gmgAY4y7hlgfYMDz3AR71IFOTfb7gx6fZ0KEjDZi/fEBfashjh1edQAjmMvzsqcHrIBj013TyPKiyO5V+Cj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added new WID to handle WOW and pass the information to FW in
wilc_set_wakeup().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  1 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 24 +++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  1 +
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  1 +
 5 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 36b87ed38092..75160ab3914a 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1580,6 +1580,7 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool=
 enabled)
 	}
=20
 	netdev_info(vif->ndev, "cfg set wake up =3D %d\n", enabled);
+	wilc_set_wowlan_trigger(vif, enabled);
 	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 497a49a182ef..e69b9c7f3d31 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -23,6 +23,10 @@ struct wilc_set_multicast {
 	u8 *mc_list;
 };
=20
+struct host_if_wowlan_trigger {
+	u8 wowlan_trigger;
+};
+
 struct wilc_del_all_sta {
 	u8 assoc_sta;
 	u8 mac[WILC_MAX_NUM_STA][ETH_ALEN];
@@ -34,6 +38,7 @@ union wilc_message_body {
 	struct wilc_set_multicast mc_info;
 	struct wilc_remain_ch remain_on_ch;
 	char *data;
+	struct host_if_wowlan_trigger wow_trigger;
 };
=20
 struct host_if_msg {
@@ -962,6 +967,25 @@ static void handle_set_mcast_filter(struct work_struct=
 *work)
 	kfree(msg);
 }
=20
+void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled)
+{
+	int ret;
+	struct wid wid;
+	u8 wowlan_trigger =3D 0;
+
+	if (enabled)
+		wowlan_trigger =3D 1;
+
+	wid.id =3D WID_WOWLAN_TRIGGER;
+	wid.type =3D WID_CHAR;
+	wid.val =3D &wowlan_trigger;
+	wid.size =3D sizeof(char);
+
+	ret =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (ret)
+		pr_err("Failed to send wowlan trigger config packet\n");
+}
+
 static void handle_scan_timer(struct work_struct *work)
 {
 	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index 58811911213b..cccd54ed0518 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -207,6 +207,7 @@ int wilc_get_statistics(struct wilc_vif *vif, struct rf=
_info *stats);
 int wilc_get_vif_idx(struct wilc_vif *vif);
 int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
 int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
+void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled);
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
);
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)=
;
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index fe2a7ed8e5cd..dba301378b7f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -22,6 +22,7 @@ static const struct wilc_cfg_byte g_cfg_byte[] =3D {
 	{WID_STATUS, 0},
 	{WID_RSSI, 0},
 	{WID_LINKSPEED, 0},
+	{WID_WOWLAN_TRIGGER, 0},
 	{WID_NIL, 0}
 };
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index f85fd575136d..31c68643731d 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -662,6 +662,7 @@ enum {
=20
 	WID_LOG_TERMINAL_SWITCH		=3D 0x00CD,
 	WID_TX_POWER			=3D 0x00CE,
+	WID_WOWLAN_TRIGGER		=3D 0X00CF,
 	/*  EMAC Short WID list */
 	/*  RTS Threshold */
 	/*
--=20
2.24.0
