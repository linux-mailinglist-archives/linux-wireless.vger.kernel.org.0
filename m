Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE946F8CDC
	for <lists+linux-wireless@lfdr.de>; Sat,  6 May 2023 01:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjEEXm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 19:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEEXm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 19:42:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E0E5FE0;
        Fri,  5 May 2023 16:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1683330175; x=1714866175;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ss4zvdQxHWzO0aLDppOAeoomW17Lkg1cC5xQl/hehCQ=;
  b=A8yg9v1T8FFTTNX9Bl75JYD+hYVh/SnjyimqACxpOJBtqEpD7h8Viqdi
   3e9Ke8u58Z5VGHQyRerX3c7tKbeoLEWKkm7O7yZ6PadfKLHPo1BaLiam4
   Yek8vJLpo5tSOqA8zlvh95vCjCFPgnDklOrR5z7kUa7maaJpcnL1Mv0ez
   DIeSd8re3shJ/CGsMp6Fkika2IMOLwRDQ6MAg5twePGGGmN1XLoywUYDu
   8gCY4w5SSLJPvdyNyZOMOtnkiMnTMbb5khG8dsUkRjvHCKTOwHdAjZodd
   wJOV8E3C53SZtS401BW7pzrXsz2VUDOePzh9DszkLMRO9E1SqWUW1mAu7
   A==;
X-IronPort-AV: E=Sophos;i="5.99,253,1677567600"; 
   d="scan'208";a="213973018"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2023 16:42:54 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 5 May 2023 16:42:54 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 5 May 2023 16:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoQZLejViTDf1EQcp7JbJmlL7+Po/Hkil9ZmmfteYX4ocbmOa5eSQQJNsSgzM2+GNh4DU2LRXwF1XGvWumkZBxzfFElpfmk4QJPPEl/gWhsH68QAJhr4SFKemYdq3epaLNzZixjjklU5cYG5Cn2hVAdy3FuDaLC30qU4IMv//Xwx0IGwuh+0nRWlNJu4SaHfyQlUz+5znEBiBAW3fTg1IF7cLldvGUezifUJmrGoc75ru/ZO+Crh6Jebs6tGS0o91MvEpWsxHqOCs0HoL1RwR2/T1vvLfkaHGHQp5d0x7MU6vDA5BzE/apAX/OPm/clhkd2X8px8FUj3qiqrVGbLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC0NyFRLU7UR6goB9o91e+L5/smFer1jRy2a+IDeHUk=;
 b=ZRrUU/IsoZwmGO80kqminsLdNx/uIfbUFEQvjZC+zYySFW6Vr9hUVULO7D3ohqNdrbwM4ruhEjbAZhTuUtJYoerQTrE5L0GJBlw+u3H068RubhgtlrHqyd7dXRiynSCr0du87nfSMdGukfeRQ8rUiHjlEFQxwcaijEErS21szc/TwLdjDuIMJiucMOdc+0JvcNIMHq23JeQvTWw/pwwRcP79HGd7yvZ5m2JEsHbKRdD5lVnP1bHubytlbpCu8Sd/QhOs/20Iy3ywldqnWzjD+49lQGTv/waI16Qs3CCI30FsulQ3xeDSeB1/n7rgJ05o1+oJZFR8bnTkyoCbOQt7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YC0NyFRLU7UR6goB9o91e+L5/smFer1jRy2a+IDeHUk=;
 b=T8Nx1jW21k5d4KdhffIIuti+4qx+3P+xyj8mIITiwHEe+9GPSr1xs+nC/3dbIMCJ5nQveIpy4D2gTUDctPx5eCFQ/m8X7DSqs6dClDnWBKahmn6c2TYSmHbJeTkEErGMGhU7ndinbWpP0e0wxDIRYVET7wS6pgOZQH/QqLIUip0=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SJ0PR11MB6671.namprd11.prod.outlook.com (2603:10b6:a03:44b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 23:42:51 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::30d9:173b:e580:28c6%5]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 23:42:51 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>, <stable@vger.kernel.org>,
        <mwalle@kernel.org>
Subject: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Topic: [PATCH v2] wifi: wilc1000: fix kernel oops during interface down
 during background scan
Thread-Index: AQHZf6tOCZz1EGCoL0mIVwhtQSxjPw==
Date:   Fri, 5 May 2023 23:42:51 +0000
Message-ID: <20230505232902.22651-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5176:EE_|SJ0PR11MB6671:EE_
x-ms-office365-filtering-correlation-id: 8895f3cc-41e1-45a8-2eb0-08db4dc270a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gTScYcSB4d7wB9QU9zNXyMZO7dZnva19w6SjhiZXsvEBnFRiTOJ88aodn3TQVVTmRAgwTyzMLaHsWUEDyET25M1K3BUBZzrXzdKO3jy3CyFdExNbznyWTIcrCjutvuXlbFf+w8uhrkKYxSJGlQLiObyFzRtS8r8j+Yli6IBcL2rHS3FbvDMAVECG/LMgTMoGN2kdzT6Pb90vodMCZc5NEArltjZnr87fWt5w6hTPcdlLDx/F7tQRSCrtkfjoigMd1NPuCFPiQ9wKbWoYYtYSSbBK7fovEWKcEwPtK9AdsZfj84dHbPfrt3ife8dMreJonEN2l5MLhfl+1Di24mJTzIyyvY/Udrb9zfYrQx7ouZ4xWZUmCRjuBk4teMMg9ZGJZlJOyeKaW9kw5BYmo96JJ3eU6xwWNHIIq8qRfRTHD54jxaJu94qyC6gZoymVF5baJ853g2SlEHpTaXossRyH5i5r8dR9Y5uCzzfn+ohkB3yhXx769dxkkh+JChevCFOfEibvhpuygbauiKE0R1ZAF03DZTrttFzdv3nSTDqY2WrYIVaQI8fa576BAGoRVUeSzs81P3PP4Z4hMEfHH8EbTnjTT6OW8OzvVmrwWk1qeII=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(41300700001)(83380400001)(316002)(8936002)(8676002)(5660300002)(2616005)(76116006)(4326008)(66946007)(6916009)(66446008)(66556008)(66476007)(64756008)(38100700002)(2906002)(186003)(54906003)(122000001)(6512007)(6506007)(1076003)(26005)(6486002)(38070700005)(36756003)(966005)(86362001)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+BCOxsamt6dtTE/Fpodem6nceoEtx8Vdwu4WT5jlm8FaMD9xGdJojcKUTs?=
 =?iso-8859-1?Q?WuvaJN15Q6f2NQebRZDTbfSK1guoX6Tz/tdYFODD/8vKceiAaS5KGWHexk?=
 =?iso-8859-1?Q?DtBKo3YjUIXbgfz9jnaPwTdc6keAigGIg0UbOTQPC5Y0ZqCOr/zO0KXfmj?=
 =?iso-8859-1?Q?jE/AkIzPPS3xaq9q+gJo/L84u5b//1a6g1IhgluLPKNlLnDjOY5C0Jbtub?=
 =?iso-8859-1?Q?Jt2+Z1836QPZllvK151kKYtm6DdDc5M4Pk0NMYrMCsKu98HuD0xJfUFCCL?=
 =?iso-8859-1?Q?4Y4eWzFG6E32GbvcrJoQbC4b26NSabBLFro05YpFwFYi419YZrtOxIjZcb?=
 =?iso-8859-1?Q?NHXJJJ8+/IH3D4Z0myOSBc0dc6BB/d4GtD9Qbs9rBYaG7G9cydEwN7dVlR?=
 =?iso-8859-1?Q?JFAEndxFgwNi1XAgcxkY+k0xfMUcBM7akyTk/uOZIcCcDQUmigGqa3eznc?=
 =?iso-8859-1?Q?ZQxiBGschD00uSADgzkWXdjGMeKhT+8qtGXf2lDAF8f0vbo9luF2x9XfeO?=
 =?iso-8859-1?Q?Bqvn7YsuGxIwhim5CYNnBJVekURbuMJuaNZAEkVbbP3QUIuOp03fxa39pK?=
 =?iso-8859-1?Q?WLnFnCl4eCUZhuLT/nKss3eD8lmpYt765im1vO/bKc9vCQfN04PEmOIQkc?=
 =?iso-8859-1?Q?B/Jefn1Rz0sckCRgGhElvJCIdS4SHwoKMtwqUQOYZhKNAInSqHIcRdrhPe?=
 =?iso-8859-1?Q?xgzlyWez0MbQocBYgBH2vO0fb1g/1SKg/UVHxPZMavDB+3RV7aCtorq17w?=
 =?iso-8859-1?Q?ni03oG94BLkhtQGKHVd+GDXDWGoyoukirgV3VLRlVZPfZfGxk6zcH4j0Zf?=
 =?iso-8859-1?Q?l3HCsnTqB3f1UW2mrpkHzM3FzANkOZxwAdZcA3m3IvG/MaaOpo2VxDZb0+?=
 =?iso-8859-1?Q?F5nCsGnivmzHZEE+U0NNklu97GS4TMDf+lVuFeI9Ucxj87YOCbiQUg+qQS?=
 =?iso-8859-1?Q?LF7aqPvLunJupOS6cvZB5gBwtZlcBCZlLrtEWSJNYGsHtcGoZ79AFSI6H+?=
 =?iso-8859-1?Q?X2sxqpeMVbERuVGStkr7UCQ0nHOx/0tCmHUvUuYXz9M6JXdSOcMmoEBQsb?=
 =?iso-8859-1?Q?H6K8wCvTa5HldlIHpliuc2EuLMu2M6IRjXupmyJQkfkyauiVTbcubPX4G1?=
 =?iso-8859-1?Q?zFtJhemZTCDMhN/8zPZWEqY9Xo5vPFmgR0aYf1dwqJpitnhtsqRcAOugT6?=
 =?iso-8859-1?Q?EilIr+ojx3rM2JviAMBXWEgT/yRdVIzgsYLBn7PHut8MiSNccCTJUy10FU?=
 =?iso-8859-1?Q?OcrDtZVlAS47sCqUh5wrtTG6GAi0dl6TSUIU291vKt5hXGOUBEp9q871zM?=
 =?iso-8859-1?Q?Y7zKWCOaK+iw87UO1NkGTHZJc+0HuElwBVDaFcNDlBg6Yyiws3hqc5nQPJ?=
 =?iso-8859-1?Q?tKt26VUMnIS02FiX1hfVcM09OVkVdUH/cNTjX7ESFTIW58N75xcO/kaD6O?=
 =?iso-8859-1?Q?vt31AcOXIIms93IhYeFHJVtDvz6RNI/mTBPTocJR2Qsm4BRhUX6BEBaqcE?=
 =?iso-8859-1?Q?GutIe4+SEtFvx5BBOAjgHDNo8LU4jOoSCLlaDTE1SLkoW/g8KlOt6UHySJ?=
 =?iso-8859-1?Q?nKPDT27oBb7v/KqJoUBLZlppQn8ugyfzZVkBmflPhYIKOVDmVHAf3p7w/e?=
 =?iso-8859-1?Q?yr+3cHBLLpM8EHBrO83Rvsyh6jAikG/NQO58NERVc+NfZzvKKBJLu2uQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8895f3cc-41e1-45a8-2eb0-08db4dc270a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 23:42:51.1574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KN4MrBSaHwHuCrw6iNeKSI9cECkFFubHH5w4v22qOBmSM/mvqx2Kio/nLCiWqxPAgCcochK7MjD/qhWr9VaSgrBv4r4w3vUOtY/czQOd580=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6671
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix for kernel crash observed with following test procedure:
  while true;
    do ifconfig wlan0 up;
    iw dev wlan0 scan &
    ifconfig wlan0 down;
  done

During the above test procedure, the scan results are received from firmwar=
e
for 'iw scan' command gets queued even when the interface is going down. It
was causing the kernel oops when dereferencing the freed pointers.

For synchronization, 'mac_close()' calls flush_workqueue() to block its
execution till all pending work is completed. Afterwards 'wilc->close' flag
which is set before the flush_workqueue() should avoid adding new work.
Added 'wilc->close' check in wilc_handle_isr() which is common for
SPI/SDIO bus to ignore the interrupts from firmware that inturns adds the
work since the interface is getting closed.

Also, removed isr_uh_routine() as it's not necessary after 'wl->close' chec=
k
is added in wilc_handle_isr(). So now the default primary handler would be
used for threaded IRQ.

Cc: stable@vger.kernel.org
Reported-by: Michael Walle <mwalle@kernel.org>
Link: https://lore.kernel.org/linux-wireless/20221024135407.7udo3dwl3mqyv2y=
j@0002.3ffe.de/
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 changes since v1:
  - updated commit description and included 'Link:' tag
  - use atomic_t type for 'close' variable
  - set close state after clearing ongoing scan operation
  - make use of default primary handler for threaded_irq
  - avoid false failure debug message during mac_close

 .../wireless/microchip/wilc1000/cfg80211.c    |  2 +-
 drivers/net/wireless/microchip/wilc1000/hif.c |  2 +-
 .../net/wireless/microchip/wilc1000/netdev.c  | 33 ++++++-------------
 .../net/wireless/microchip/wilc1000/netdev.h  |  2 +-
 .../net/wireless/microchip/wilc1000/wlan.c    |  3 ++
 5 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index b545d93c6e37..a90a75094486 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -461,7 +461,7 @@ static int disconnect(struct wiphy *wiphy, struct net_d=
evice *dev,
 	if (!wilc)
 		return -EIO;

-	if (wilc->close) {
+	if (atomic_read(&wilc->close)) {
 		/* already disconnected done */
 		cfg80211_disconnected(dev, 0, NULL, 0, true, GFP_KERNEL);
 		return 0;
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 5adc69d5bcae..6cac92ba0075 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -983,7 +983,7 @@ static void handle_set_mcast_filter(struct work_struct =
*work)
 		memcpy(cur_byte, set_mc->mc_list, set_mc->cnt * ETH_ALEN);

 	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
-	if (result)
+	if (result && !atomic_read(&vif->wilc->close))
 		netdev_err(vif->ndev, "Failed to send setup multicast\n");

 error:
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..c8f3b15f029b 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -23,26 +23,10 @@
 #define __WILC1000_FW(api)		WILC1000_FW_PREFIX #api ".bin"
 #define WILC1000_FW(api)		__WILC1000_FW(api)

-static irqreturn_t isr_uh_routine(int irq, void *user_data)
-{
-	struct wilc *wilc =3D user_data;
-
-	if (wilc->close) {
-		pr_err("Can't handle UH interrupt\n");
-		return IRQ_HANDLED;
-	}
-	return IRQ_WAKE_THREAD;
-}
-
 static irqreturn_t isr_bh_routine(int irq, void *userdata)
 {
 	struct wilc *wilc =3D userdata;

-	if (wilc->close) {
-		pr_err("Can't handle BH interrupt\n");
-		return IRQ_HANDLED;
-	}
-
 	wilc_handle_isr(wilc);

 	return IRQ_HANDLED;
@@ -54,7 +38,7 @@ static int init_irq(struct net_device *dev)
 	struct wilc *wl =3D vif->wilc;
 	int ret;

-	ret =3D request_threaded_irq(wl->dev_irq_num, isr_uh_routine,
+	ret =3D request_threaded_irq(wl->dev_irq_num, NULL,
 				   isr_bh_routine,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   dev->name, wl);
@@ -150,7 +134,7 @@ static int wilc_txq_task(void *vp)
 	while (1) {
 		wait_for_completion(&wl->txq_event);

-		if (wl->close) {
+		if (atomic_read(&wl->close)) {
 			complete(&wl->txq_thread_started);

 			while (!kthread_should_stop())
@@ -171,7 +155,7 @@ static int wilc_txq_task(void *vp)
 				}
 				srcu_read_unlock(&wl->srcu, srcu_idx);
 			}
-		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
+		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !atomic_read(&wl->close=
));
 	}
 	return 0;
 }
@@ -418,7 +402,7 @@ static void wlan_deinitialize_threads(struct net_device=
 *dev)
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wl =3D vif->wilc;

-	wl->close =3D 1;
+	atomic_set(&wl->close, 1);

 	complete(&wl->txq_event);

@@ -472,7 +456,7 @@ static int wlan_initialize_threads(struct net_device *d=
ev)
 				       "%s-tx", dev->name);
 	if (IS_ERR(wilc->txq_thread)) {
 		netdev_err(dev, "couldn't create TXQ thread\n");
-		wilc->close =3D 1;
+		atomic_set(&wilc->close, 1);
 		return PTR_ERR(wilc->txq_thread);
 	}
 	wait_for_completion(&wilc->txq_thread_started);
@@ -487,7 +471,7 @@ static int wilc_wlan_initialize(struct net_device *dev,=
 struct wilc_vif *vif)

 	if (!wl->initialized) {
 		wl->mac_status =3D WILC_MAC_STATUS_INIT;
-		wl->close =3D 0;
+		atomic_set(&wl->close, 0);

 		ret =3D wilc_wlan_init(dev);
 		if (ret)
@@ -782,12 +766,15 @@ static int wilc_mac_close(struct net_device *ndev)
 		netif_stop_queue(vif->ndev);

 		wilc_handle_disconnect(vif);
+
+		if (wl->open_ifcs =3D=3D 0)
+			atomic_set(&wl->close, 1);
+
 		wilc_deinit_host_int(vif->ndev);
 	}

 	if (wl->open_ifcs =3D=3D 0) {
 		netdev_dbg(ndev, "Deinitializing wilc1000\n");
-		wl->close =3D 1;
 		wilc_wlan_deinitialize(ndev);
 	}

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..44f7e479604e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -206,7 +206,7 @@ struct wilc {
 	u32 chipid;
 	bool power_save_mode;
 	int dev_irq_num;
-	int close;
+	atomic_t close;
 	u8 vif_num;
 	struct list_head vif_list;

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 58bbf50081e4..3eec2acd2f2f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1066,6 +1066,9 @@ void wilc_handle_isr(struct wilc *wilc)
 {
 	u32 int_status;

+	if (atomic_read(&wilc->close))
+		return;
+
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_read_int(wilc, &int_status);

--
2.34.1
