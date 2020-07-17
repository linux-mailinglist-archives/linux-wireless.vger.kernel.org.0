Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096622232C8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 07:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgGQFLn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 01:11:43 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:57471 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgGQFLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 01:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594962703; x=1626498703;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=LsQg5S8CEAj3Yq45I3Mdgw00v1olwHEMQkEnmsbJo58=;
  b=JA7wUbCMoUvNkuyS9lkGqCBhTapJJs/YvWt2lp5DzCiqaHy1H4Nvzke5
   24NSHUmaKIp0MP5QyYpt7MX5Ciy9tCPI4tuXVY9vtYozShvqdLMk90XNs
   nbFotH1xK2LPNRgaE6Z2MdmCsDdh1vGPvrT4J7M0jLeU4I4YFwHiOEbHn
   wDyF+8vSktJO+ydoooKm7uyIoUcIG+V8kDrubUBGT+fpuEdQjhJiLvX5n
   nHixWkYp5XUFvs0HUlcnJ/bCwK6ZZrCqFU16ARioFuqFuRHn/lLa15/ZL
   kMcRH+pPicbg4ODmPsKu6QLJ31FNNo8XzctliEnfaRZlpmYU0H2ocnM4p
   A==;
IronPort-SDR: w5KTxSdL77hRA9p1pCqGqMhbxFt5PuimsDAZjHDlIj0qVZRcLspZgCIAkFHCliz8DkF+cKjN+/
 DXe+YQrmc6/fmaFs9SpIVKCp88KqtT/50zFmfUrYZMuRNp8T3jILQeh57QOK1d0TNI5WQaawgc
 N44rD4gwHG/NE30Mnu/qJrPEriCFqWO1MB5ZcCa4YgzWjpAdrvcwo3gyj2Um8/Vuos3lpqlpr/
 gOrxbe/bJoJtz6t4cT2NRqwf0q5TsldQg5Mk+E7CEpCOFpMw17ec2vWhGevu+qtdNCkqY3frTr
 rG8=
X-IronPort-AV: E=Sophos;i="5.75,361,1589266800"; 
   d="scan'208";a="83531683"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2020 22:11:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 16 Jul 2020 22:11:41 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 16 Jul 2020 22:11:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+YvJgxYn5BbmscTfDgIT29JrQuo1VSBTA4J2QGWfnJ0+q9Ikz63LPVOzPQVjjZxHbSvby76HtRh4m+uR9YSFKxTBsR6VeE0uaUiG3bsFOfaPaaOV0zz50yajE5efLIdxYS3DfZ8rv6WiIZFjSIxt5pwXYbImrlV8lGL5OJ+nInX6UbyH2MoTIvJJC9tP6ZZpni6w/jHyeCaVCi/hOrN4ylbkvneFWmBQVPGnCOjm5aVy/O84pjYEHq+GPQQTBi6Mz2Qvg20lycW/V7ZJPR/XnxfKyMGcckzKxCHLzFNyMsQwUNZQ/4fZC7q/CbtXXK4Ohh5HqGfTocJj0T5XOS6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooeFrmbbikyeVrTNwEY60zPLehfDkF5Uzw/67b45kOk=;
 b=CXWYuxxYOtuGUT3rMxQDX3SjN+SbjzFMC1+0O9dZJ0WBkUp4n2Z2YBlYDD/e5930tni5xIPswLAJ1jBkj0a6Kf+EuJEGBFGCJgpwsL0flMd8GwoYxjrfciFWmkkSyuQXSsp14Dk9tQiP6RPhQPbVUatl0ipvCsPZLSxoSWFyVApjeg/mDVNdHmeZy+IJRHd/GU4+9OSqB3Ent8gr5epgog2hp2tSpGTM146Q4eCiu1QrVtKf1S3+87u8MJfM1HMsqxa4iYXW/2we7WyMn5d0IIlpLNjuxiZQo/KYf+jprsNUXreg3MB1qW8pe9hmMiKWXREDepgigs5E/KSqHao7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooeFrmbbikyeVrTNwEY60zPLehfDkF5Uzw/67b45kOk=;
 b=W4ZtP4XSvjN2uH6TjErT/s1i2v4m+D9tqsAKjsGFzCmrzYvyENYAn05PQ20LDb6r6yq2Yj86s4sFdcFsOx6CXURVYsg+2wkf0eMc+9SWqjv+73zHSon5qTZ2Dq2gKxh8zUB2VEhbK0l4YS51JTlx+CXsFlQtx7WT5x4JE6MBms8=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB4144.namprd11.prod.outlook.com (2603:10b6:208:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 05:11:38 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3174.025; Fri, 17 Jul 2020
 05:11:38 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <ulf.hansson@linaro.org>, <pali@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to
 common header file
Thread-Topic: [PATCH] wilc1000: Move wilc1000 SDIO ID's from driver source to
 common header file
Thread-Index: AQHWW/i/AKFAAT2qFUW4iObkjBIzvw==
Date:   Fri, 17 Jul 2020 05:11:38 +0000
Message-ID: <20200717051134.19160-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.204.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55094e65-c0b3-48d4-705f-08d82a0fe265
x-ms-traffictypediagnostic: MN2PR11MB4144:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4144C286471AF135E1E99510E37C0@MN2PR11MB4144.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mvF0vIwXpuaQ340ryy+nDlLg11e0+koZctHVjH86oJHetXcrmWVfJyLgtZ92n6HMhRbzk9z/SqYRry74QjJYxB1O5+u5bcwnbZZQYwA2anVcT/eR1WmQmYQsoc7Ui41K2GcOO7AT5Iolhi1GA7B5a1N8DX/fh2jRLeKEWMWo2TaOocBetQ87MDbyDvhL0VrIQSuzda/8fxBkbJQvtHGsMRUYSg8kbVMkP50bsdL5CnPY/zhzJGL5f7VjLKy4hEdqz04fGds5eF7wcDSvUcTuAW+jLJym54S7ydF4JaqTNG6qR67qNFWmmGnHnPeeVpB+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(39860400002)(396003)(346002)(71200400001)(54906003)(6486002)(1076003)(2906002)(107886003)(5660300002)(55236004)(6506007)(4326008)(186003)(66946007)(8936002)(64756008)(6916009)(76116006)(66556008)(8676002)(26005)(91956017)(83380400001)(478600001)(36756003)(2616005)(66476007)(6512007)(66446008)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 33aW6TV0BW4W3wOcbocTzmawrG3/Uic/hVdJ4svfsMff70vgZkzwStozC0nGbINXwCZx0afRPrXySOPyTOLYeJ8JEQLZVsGyNyOZDX6yVL7EEJwqx/MdtEMAzZQXMxAyeq6gtnlC5etwRKpQn+ok9n1Qzyub3bTXWfE3RjP8/lI0uYWzBK18+xIISEsM7P7aT2CcY9JkgGhGEXVO4MCKBsoVzQnF4dSL/LVYUBrWY9w8BJOKuTNWHHVRae5HObXK0bGfszHpghKbOqugEK1DQ51e3eN1H1OzypS6A9keODvyD442bGasS6BDFNfObAXWTsTr+682ziXk0SwUu6/A14vPkHMGi5V+W9USpsDBtj6UHUMlZB+1UI0PfOeQ13Csa0qsILLnIzmisdvlfxYeV5iI7J2MczF3TevqX+lEi8I9l85YD97vjrL/TmYscKlsI7Rkvcl/5qk+xQ77rIg6DUn7S5EvtJCluUhjBBwP2tLwtyh2OMigCFsjziDxYmPW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55094e65-c0b3-48d4-705f-08d82a0fe265
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 05:11:38.2760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWGXOlxqX2rgjumq8kE3vzZ02+0K5xRMreqEzBWt1+eC89ozJsfqLdNAyQor5Fbgs2VK98K112iTFmcUQXPcy6yWgzseJZDF3nBa/PoiT40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4144
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved macros used for Vendor/Device ID from wilc1000 driver to common
header file and changed macro name for consistency with other macros.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 6 ++----
 include/linux/mmc/sdio_ids.h                   | 3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index 36eb589263bf..3ece7b0b0392 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -6,6 +6,7 @@
=20
 #include <linux/clk.h>
 #include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
 #include <linux/of_irq.h>
@@ -15,11 +16,8 @@
=20
 #define SDIO_MODALIAS "wilc1000_sdio"
=20
-#define SDIO_VENDOR_ID_WILC 0x0296
-#define SDIO_DEVICE_ID_WILC 0x5347
-
 static const struct sdio_device_id wilc_sdio_ids[] =3D {
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_WILC, SDIO_DEVICE_ID_WILC) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MICROCHIP_WILC, SDIO_DEVICE_ID_MICROCHIP_WIL=
C1000) },
 	{ },
 };
=20
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 15ed8ce9d394..519820d18e62 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -105,6 +105,9 @@
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
 #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
=20
+#define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
+#define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
+
 #define SDIO_VENDOR_ID_SIANO			0x039a
 #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
 #define SDIO_DEVICE_ID_SIANO_NICE		0x0202
--=20
2.24.0
