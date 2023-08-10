Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150967780A5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 20:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbjHJSqt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 14:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbjHJSqr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 14:46:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089852717
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691693206; x=1723229206;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=FkH9Ka2lFuogyB/jeVNJPpx4snDyRlrhOQ10Rhs20TA=;
  b=pYq+kCq0fIobmlBMcs2EiMrD5brXgOhcaYfARalmsNYiM6lQw43cxtp9
   ln/BiLvibNrZXmuRU0xCP/kRIgTKN10fKTWTWpRRR51i5R5oazxyoII/6
   IgMkA0fyCvo5kHwcZdWUp2aHeh0Mv932ogcJwUJhtMY3KxqR+o7ecb5+H
   6qR/JlZAM0yJXzaSmkvlwOBBdaeWHrboReI8u2CtRD2DM3ckfcZypPJbb
   FDwkEo+P1c5Y48A1egena3Gr+YLqfIqSSm/UKcxOHVXiDTLdkK4E0nzs0
   6QU7tlRo6OfGwXIXV6PkOeiVbwSwWIC25V+k8Lcob027RnO8+n4ORiVWy
   g==;
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="228311034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 11:46:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 11:46:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 10 Aug 2023 11:46:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imRY2nqfmj3KLnR9VAxKljUHcK+aFA8ljCKpd0P0sgk8cTLm3oEb8RJI1Cx9N1FaBfCBAC49dUleR0zhOk5Oo7HBNj0oMgT4KSDUFBJLJSm88q6qSPfNOQ9YuUCUvnFxoIpCUiwx+JAU4VxYlAFtviv++pbw49GwKG2sHlIXW8xGws7bkAm9lGqUvsG/6YRI8K13O+kW0FgVUKdnd/yfSCn6oaaeujdF2SlTeBxC7AU0zelXZ+lfUHFHub+yf9R2kBbwxNhargJJthfhicd+pdbYCTbCVVUcnZkehvHcJp3OTPxXbZrfkK83wBQpK4wY+7NlquzaNslNWfXcKjB7ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFufDLn8Roa5LOMasuAe6zfmxktsVD9wi0fEwZan7ig=;
 b=inLquuom5BhNlK2bzLiY/nPdNS6aXN9qv3kpINwjwDlPOBA45x8/8R7FVgSpLE/MbHL5tu2FVtpKqqPml2IbHCp/6+x+Hnlf4pnd9A4hNwg9xKQvXhMHWfeNVuLG/2XoewwCJDKLimPhASCkqJK3948qYEi1VSitNHM+Vt/pkS3CQsQ6xi9b8n4IjmptlWmuCzaDQERGSjADbuL6+6SICH7Y/OTllBZYMCBIJKOMB+eILUYT/K0Px2ySe/d7gEasNE0O9k53UusO/VcEUEFMIwIIN5XAFSAteGceuseyrohfSvNvOgMBvt2bjVwRV/aOjb0Hg1AFmf8ZHt5rCE+maA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFufDLn8Roa5LOMasuAe6zfmxktsVD9wi0fEwZan7ig=;
 b=Um1w/1tnv68ezn3tQCtu7sfHQskAmS+CTBh3BvrqtVBHYwtgmNqoSN/UjZp79i6CuZKNI7UNGGItBky+DqL66XdRgB8J3Pvi/uPai2QZJtTDv/FuWj+idcKpvoJ0Dyda7lhr1bUKPGP/s+/+Yk+ys1vDgZ6O9njFQejKs4ZOygE=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 MW4PR11MB8265.namprd11.prod.outlook.com (2603:10b6:303:1e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 18:46:34 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 18:46:34 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH] wifi: wilc1000: Added back-off algorithm to balance tx queue
 packets.
Thread-Topic: [PATCH] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Index: AQHZy7r8s5kkCcXuAEuvbOps7pjZnQ==
Date:   Thu, 10 Aug 2023 18:46:34 +0000
Message-ID: <20230810184633.94338-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|MW4PR11MB8265:EE_
x-ms-office365-filtering-correlation-id: 642cce29-3704-4c1a-b5e8-08db99d21f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZHFXcBVmZpxALAsdTHL9pZ0WipXvcRLORcW7r6G0/By+ifuYBM3Co8Zv8ECaT5fF3w279FJRp0gN6nnt7bI03NJ5pGFY2cTpQxP0cWEX5Q30nij3ZSbQsXKNLtJMbUXF3rkDAcTGCtdCd3eSJYyzxqy2mBYqOCAJLZRY0Q0Fs8QukldziEO9Z/qHd/0E08WqHLwk2tD4uhsc6xr2MlddenJ+1rvvLTku/HriZPWF4M8X2fGrNDszqJqJdNxCyBkJ9WIapWMxonrv1u7WUBTY+2DntfScAWpvDsJqsnbRP5pKibP513iiv3Ztkoc7cK2afL1opBqFRDeRYMmWv3twMqZWj6REKiOOmTcvyq9VJJSvkknPmzkHjnmM+dmTZDuSA3w+vW52yF6RIO27Cchuku5WyLtpWC7GauxPav7tILVszhUHnLJ38fd39RnLbMjr9ImBaebwtsTDnj3WnwvShKsoYyePMi1WPNG5OR73JUhNiguJo8eTCYBzCCgtVso/oJ1SmSUaT+MZ+FEOkDHarXergXv4+ZAM1PsyYSy9Bz3ci9SYbWYjHJmxsmN8tybvhtAyEFBzFDXZexaJdMWkhnR4FfioOqqbXN65jVESjWdMIe9zH055ZHaeVSLpW7A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(186006)(1800799006)(26005)(6506007)(1076003)(8936002)(8676002)(41300700001)(107886003)(36756003)(2906002)(83380400001)(2616005)(122000001)(38100700002)(38070700005)(86362001)(54906003)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(4326008)(6916009)(91956017)(6512007)(71200400001)(478600001)(6486002)(5660300002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sVO2/4ij4Pw7L11PmBSGDB45aS5yJ5+adIMv24rssXd8mbmgPVvHho9QrI?=
 =?iso-8859-1?Q?//Cp0demo6YN/Tcgv3LUi8Jz+tWCf557lnvAMFIIahnz23UKcHicFI/DAt?=
 =?iso-8859-1?Q?7qImHcqcjRGMcROWeFyH0Vbx5YrneItZ1X3bXhTuXp+K7aBWY4l7g1za0l?=
 =?iso-8859-1?Q?tvzcM+5yS9TEXoyzGkYXLGi0iBcGAxrwXxToe77t4fiUfBK1AdiGHZvbna?=
 =?iso-8859-1?Q?pMYVXq9E2c9/fhdJmN7l/t2fHgliIt6CN+GNMfS9rvYGbajanQyrcBg2SS?=
 =?iso-8859-1?Q?joEMCfnjtdliuzy7nGU1JSi6lh7lOS/QcfFT4lr9tHjcjPamXR6069n5pt?=
 =?iso-8859-1?Q?xM5oTuauu6nzZAUokKbDq2n62hEyOS1HSp9i16vXOF/9wFQp3oJ/t3/mB3?=
 =?iso-8859-1?Q?fdiNBft6gKfu01ro0fwU/w0aQMQMw6w3rxhXigXg84mossJd4+rcRBKqyO?=
 =?iso-8859-1?Q?mb7mnutfHCw2mZ3zhgX6hslM8KlQP/+b4tQCgCAD+UouIm1lU6theL5X2W?=
 =?iso-8859-1?Q?gFZdN6gtoqpvs5ur226Q3xxG2cms2GYfhVl2z5t0/PKQZacnun7u9H9f08?=
 =?iso-8859-1?Q?tt7mXSMs1v6vkaEXZLXiV3etrvItywo1OKK/gi/rVP5tm/xKJszjVgSBGP?=
 =?iso-8859-1?Q?gOGmoArz9bYDyj5tVTxtefxLOTAg2CCkJV+gm3eheHeEIfNHh5DM0a64li?=
 =?iso-8859-1?Q?apBVuJDR2RIaHTfgMg8RuWJHfx6+ZGJwDp205FLFVbPpw423ymPA5gHyjm?=
 =?iso-8859-1?Q?yWSgi7gJ3lke710F2i0OTuR6J9ytZQctfLL/je9HQKpNGaTmNgNmwoyAQ3?=
 =?iso-8859-1?Q?kafFs1e9xc8iAmpTScnc8Awy34Dtn8cqHdsbnzTYylzcndlqMNM7uwDq+P?=
 =?iso-8859-1?Q?BOx0VaNDRNBuN5Lnnqk9M9MK1gsKOcnLa33aYZixxW/LOS0fPeEgjIzTrP?=
 =?iso-8859-1?Q?ub+SJuED18f+wtqp7OZVi0usJEn3hVw6UsohQtb7R1DTFu32YuCNpnn14/?=
 =?iso-8859-1?Q?XAZtbQOAdEdhUjgcKjfZlwhVv0lfSMz6dx36026gvb5zy70yrUhpJwKmXl?=
 =?iso-8859-1?Q?IuEwHdYueAUjWW5NPvLlnyru3hzf7smS5+DhyQV8AqlfMdpQT6/nyJCcdJ?=
 =?iso-8859-1?Q?dqh6aqWbOZz0k9YYu85+A+UQrjQLsg58HGIXgyM3FXZCs/Bidm6nWVnkQf?=
 =?iso-8859-1?Q?YUkrXuOy0XVE/m1k9TI0hzxn/4++Cfa/6eAuGvNsAaCj1UlgjlLH9XCsDO?=
 =?iso-8859-1?Q?/Yu5Ry6k0FzoVXfSwbc/ea+nZ1qfXpPuZNd4ZNxxXbZZDn8t/eiKsQnAtE?=
 =?iso-8859-1?Q?0ANi0VA7zX2apelBTEwFPcC+JKHyCwW/Q4oOA6h8rFxqcUK21gnOXbAkMp?=
 =?iso-8859-1?Q?V9xixulnhnHlVz72QpagA7ybiuk+/U8pndyLxV+EDYVWID9HAYacsF3ZdG?=
 =?iso-8859-1?Q?ARlCNBbnZ6IipD4BjrajOZ4wo+OhdFkIqDTAM9XT7FHh+18pz4U+g+3GkD?=
 =?iso-8859-1?Q?naW01EVJzwSeAK1myZA10yugtxW76QCP52v8QbLuU37PFn9Ru02ldGGOPR?=
 =?iso-8859-1?Q?OBAtvcTqOFDTPZYg9c81L51wZ5yjquugyGJLl1y2/sou3a6TjFsNjbTg/K?=
 =?iso-8859-1?Q?F5xoaenme+79mU+2J8tt6k1qY3aWtqQ+VWsqy24vEcFawHkpVMraFtYOHr?=
 =?iso-8859-1?Q?1NmMDSlvwnKTHuTUxCQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 642cce29-3704-4c1a-b5e8-08db99d21f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 18:46:34.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iJyTYcFWEscl5SrxG7jKy/R1bAq3Spm3TtYswmRV/JNJNoTPAoiH/5H5z7AP38FsKDlytIsG4JnkUQ5/3K8YArP6eBYN6wkjRFt+ceQv96UNRyG6GHWY8kYf4Oi5/cAb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8265
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>

Added an algorithm to backoff the Tx Task when low memory scenario is
triggered at firmware. During high data transfer from host, the firmware
runs out of VMM memory, which is used to hold the frames from the host.
So added flow control to delay the transmit from host side when there is
not enough space to accomodate frames in firmware side.

Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 19 ++++++++++++++++---
 .../net/wireless/microchip/wilc1000/netdev.h  |  2 ++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..40b34490f6ef 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -144,12 +144,13 @@ static int wilc_txq_task(void *vp)
 {
 	int ret;
 	u32 txq_count;
+	signed long timeout;
 	struct wilc *wl =3D vp;
=20
 	complete(&wl->txq_thread_started);
 	while (1) {
-		wait_for_completion(&wl->txq_event);
-
+		if (wait_for_completion_interruptible(&wl->txq_event))
+			continue;
 		if (wl->close) {
 			complete(&wl->txq_thread_started);
=20
@@ -166,11 +167,23 @@ static int wilc_txq_task(void *vp)
 				srcu_idx =3D srcu_read_lock(&wl->srcu);
 				list_for_each_entry_rcu(ifc, &wl->vif_list,
 							list) {
-					if (ifc->mac_opened && ifc->ndev)
+					if (ifc->mac_opened &&
+					    netif_queue_stopped(ifc->ndev))
 						netif_wake_queue(ifc->ndev);
 				}
 				srcu_read_unlock(&wl->srcu, srcu_idx);
 			}
+			if (ret !=3D WILC_VMM_ENTRY_FULL_RETRY)
+				break;
+			/* Back off from sending packets for some time.
+			 * schedule_timeout will allow RX task to run and free
+			 * buffers. Setting state to TASK_INTERRUPTIBLE will
+			 * put the thread back to CPU running queue when it's
+			 * signaled even if 'timeout' isn't elapsed. This gives
+			 * faster chance for reserved SK buffers to be freed
+			 */
+			set_current_state(TASK_INTERRUPTIBLE);
+			timeout =3D schedule_timeout(msecs_to_jiffies(TX_BACKOFF_WEIGHT_MS));
 		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
 	}
 	return 0;
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..380ad38ecb64 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -27,6 +27,8 @@
 #define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
 #define DEFAULT_LINK_SPEED			72
=20
+#define TX_BACKOFF_WEIGHT_MS 1
+
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
 	unsigned long tx_packets;
--=20
2.34.1
