Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE03249BD
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Feb 2021 05:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhBYEYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Feb 2021 23:24:30 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:44334 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbhBYEY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Feb 2021 23:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614227068; x=1645763068;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=zxljzHz8iaeseBTZjhvz7u99RorKnpdI/2MdvmD42AE=;
  b=EwmBZGuf2IRQaZJGs3xAmm87Fclcj9kbWOnjsZZXOF/gw7NwKQWQZjmi
   6sucVWjdaLoVCr0Q7/D8Hmw5zt9zRMfe37W+njWaqcwGO/Lh6JVSI7E48
   F608og4I9wAbehUZTZmWAy2DcuZTiEVhD7hHSycLasuQ5vEThDbtGo11g
   rpkXXIay6CsuhII0XiUv7nWpgXF6m6GLquC0TcrjWEXUBuTv35qt1QQsd
   aHSGHfrvkf2n9qoelYMVFmE1wlIShDc3YtO9MQjIRGw3uTlnpi3eTOHyl
   W+j1CTFeFgAXehcb3ApHgF04kcwYvDPZC5iW/gOxlwg4pPt97Pk/Fg8fb
   Q==;
IronPort-SDR: OioUDkXsT0OGJjrQKd5N7aVSDToLajFhWrDUoMtKBddgVmI6Tt8sqwbxCbVjdzUSltj4uA4r2c
 8SYMTg7VLgtJeFOLuEl9Erpc+fr3YsvLmrg6kN8iRhqlb4qrDW0CBhmG6P4VmaU2MX1yMJPRwO
 aJ4OSeIOYw54YtSiv52RsUbHe87hUBwByS/7WWySNy6HezDPKU/CMXIQyaGl7dKYY6Qqb1ZDYD
 3xM0n1EMqCfyrNvf7tWOxqCp0p291EuHjjRbflxbvttWztLsZX/u76IK7NfFwzTYzNU+HpoYI3
 y6c=
X-IronPort-AV: E=Sophos;i="5.81,203,1610434800"; 
   d="scan'208";a="111042451"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Feb 2021 21:23:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Feb 2021 21:23:12 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Feb 2021 21:23:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPauozuC/oDiJltWCksSgIiz5MsabBzBRM3UIH5Dxpbi4G6G9+nMOAaXBmPXBDXykSt01b1CU2Ia8mlMIx3nHXC3joo4041z/D6zJ3OVUiG6eCfNpIhAkAZy9xejc3Y3UZx42ADmg5EglNVtILdNe5ADA2C+/6gjlFC3HyS9tz5n8DOxO1dzDeoE5gzRomz4QdAErTik23a0g0i6OzkbAJwpwx+izxjPEc256BFYw8kI59g1lLv1emX+xkyFTUAikzbncu+97LI5tv9Lpt+9wsE7UaDdiiUPIS04M2V9PzikaIY332Cl5Lrn+XUdedAFvjtlPj1sXZFAiUt/QLKCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fhj17TJY8eAbqiNlTbZtbbuQHImr/Tb+60ZhSoiIGs=;
 b=VMLQRODQtSShBhm6sUW1v6UFqohekgEA6p9tpASdQIZfQJ/eMgFE3k7d+3stfTGRM1Qgs2uhc8desbCbvWBJPuQLGE44t6rx0N/AOZrtxG/JzPICZqJGZviyyB8S7bM4fLRxhn8BI2z3gy7qpWkmDV2yH1IveU+jgkJAcNwSuibFTa5UzQJ6EtGJf9LZTxulOLUnWEgrmVcMRUQxiFKvbW9xPGdHgAgqBtZm/ofuObOWPhpiE5jDTbcpUB/tOcqVu7scxMT3F3uN7j5AcUSq7LUv0ijk56RRkHB/QSsNd3mX+IONav4pxZvkixldRJ563HwlRr6NAT4YFkrDNFy34A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Fhj17TJY8eAbqiNlTbZtbbuQHImr/Tb+60ZhSoiIGs=;
 b=KAD5dnpMKmfTEkJmhO686NIsW+tsqGVZa4nW0Fef1j1fUlszvR3Tue08Xtp6OVJEdJBX+nu9NbRPKzsIwjO4sDmIKGOw84HJJPP1BgRj5M1xUBesHFHyvKgmFtjoxS7XX7gmtDm8PcwejQCvmQVolXpgifal5iErB9tMdZ0WW5Y=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB2663.namprd11.prod.outlook.com (2603:10b6:a02:ca::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Thu, 25 Feb
 2021 04:23:11 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::6c3c:2ae0:c40b:6082%3]) with mapi id 15.20.3868.034; Thu, 25 Feb 2021
 04:23:11 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Topic: [PATCH v2] wilc1000: use wilc handler as cookie in
 request_threaded_irq()
Thread-Index: AQHXCy3tDOxH11sOa0C8Y0/ug/HApg==
Date:   Thu, 25 Feb 2021 04:23:10 +0000
Message-ID: <20210225042302.17048-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.110.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd82d2fd-7525-492a-a137-08d8d9450f9c
x-ms-traffictypediagnostic: BYAPR11MB2663:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2663963805255FAA8641DD80E39E9@BYAPR11MB2663.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b1CMao6/jXzDZQ/Lr1cyaSbppBXuoewsKsMwVl5dNv82DYgef5rlKfc6PpjNxb8zPPylTWqcG0a1I2ZZHpWihGEt3Q31OEBK9aTc1UFB67D5ISlwdNelVBrImUT9kmG2KhqOeCww8wfUrADERGPL4yrSekz37HLde7FJUcBRvoeSKeux1c/a8lpxot4SJh6MifWQdauk302FXBYlBW3zYKqqk/fVtHxd4G3y8Wb/c6xoJ0I0v+G7X7BOVArp++Lt5dc1V3BmGnX9Vt+4AULwetMhNbQvmgO0/rIqklPNhnTYXLuDHOrb6y8LjZ8qllw0yQIe9XAnZfJDRUlD3AkrXKn93FOJykhQNxK59zs3XpU6Au4WczoPvu31rW2jhfbjfTIShDzowkMdxq17E58WemP0CdUzwmoGXHniXUP1A5s1S1t84YW6GOMk1HYvHodjJs42IWLOyJUy8uXu9J89+e3vP4+GheD31y7YVnuj1TskRpg0oNKHv6V5PjjrN7PqsKUXsx02LV19iy1ppTn3/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(136003)(376002)(366004)(54906003)(6486002)(478600001)(66556008)(66946007)(55236004)(83380400001)(8676002)(6512007)(316002)(5660300002)(71200400001)(36756003)(110136005)(2906002)(76116006)(86362001)(66446008)(2616005)(26005)(107886003)(1076003)(8936002)(91956017)(66476007)(6506007)(64756008)(4326008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Jw4zljtQyvAag7zwPq9pUR+tt/thUnNVt2ieFTdaXWHkBflkn36Ebcsj59?=
 =?iso-8859-1?Q?enbWL26J/qAhxbLunMxbf3vwgUXZ5wmIjDKRGbzib0Roh9hCQv7lpyyVLV?=
 =?iso-8859-1?Q?qJE5C5NkYG8eqKMt5k3yAR/PT0BvaiUPG9zcGuOCll4XGFlyidXbSC0frw?=
 =?iso-8859-1?Q?3PyeVbVtk4bGgpgTNrq6+DCpEoNfib7uVRriIdRQL/CkEeQsnf71Xomg/v?=
 =?iso-8859-1?Q?ImCwsv/CXsyvNtzaWhQ5x33pQOo/0uCBCeY//SLrzsEAiTqqmqSBjjNqaR?=
 =?iso-8859-1?Q?E3oQCGjcWu48ku1An4QFIaOh73fflaSOLv+Hb2eaE/H9i6i8qECCVf9QuX?=
 =?iso-8859-1?Q?Z7L7/tUGEODACqIGX2xnF9gTq4u9x16xmK+TG8OdTgHNhPnkcJC3D2zfux?=
 =?iso-8859-1?Q?/VipNTzR+KiGU/5DhzDQLgTrsFzCkBbKtyhpVo2VsZ0LLO8JRcgqFl2kiv?=
 =?iso-8859-1?Q?8BQTE4vW+/8BxNpcL8NY/vBogX7Q3FEX+8D0y7wnZNS8RZq5+H8aWeeN/G?=
 =?iso-8859-1?Q?Rnig4eRgo5sDEcNI1wPmoCxQV1w3F4hs4OPhJAl4+99+35QqwubYRvRtg7?=
 =?iso-8859-1?Q?SGQLCKXKuzV1973gdSV+PvMtaq2GFDcsFQ9u0Eeq17tKDSAiI6YU1vgDhF?=
 =?iso-8859-1?Q?Sw88vSev9rwrBWoHC1AmvYpkjNNnwOgbispQBdIx7W70hSiWOWp+cVm9GZ?=
 =?iso-8859-1?Q?EahKmxdcP/07a4hbvjiEh5uy1xlpp+WxFuedCMLwJXrbXgtMXCNiNx4kMo?=
 =?iso-8859-1?Q?v6S3oyD6EMTRXuX6/jZwGJ6f02g8VohOmzEsHMCagkCRn7s0nuG4JhMzGK?=
 =?iso-8859-1?Q?clurb0C6Nr4GHr+OG6hmDtaQ7N1ysSraEEs4/cSWEAPmABrCUoI9lEVwl2?=
 =?iso-8859-1?Q?qOw7iWuyvKJfOw8PvOeI9y63vsO1qdbUJ5/2EDr5iBUUnZ691tneg1kuwi?=
 =?iso-8859-1?Q?c69NGwDx4kP6qiTpyG2vH4zIZk2v7vVkq7f4yuebf7C7A+bER0gW6T4tEA?=
 =?iso-8859-1?Q?wFJm+7UwNbnYvKFz0eAe+ibUlBDeAfU7B6NGr0zW+b1mIr8u2eEs+jBRe6?=
 =?iso-8859-1?Q?kuYET8/Wpw6Bp9PuOH9iYRDu4iiprZ2s+5oBYuCCI0C/asMXCumBtUcAyb?=
 =?iso-8859-1?Q?XRLA0N22QwySx56wKBpvMEsgMiN3nEixiEK5G2GpxRW/im8bH8fPjbwAta?=
 =?iso-8859-1?Q?XWLgP7lqCe8v0m00ArKRZsGS5fhWlxu/wxUASii84Wo2n2y1cLT2RWHONL?=
 =?iso-8859-1?Q?RqyPidc77tLdJxEqXsuwJIMCNZ6rjSXFr28T/UAYzDCJPs8Xl6mjYnC+jS?=
 =?iso-8859-1?Q?n9BQLdaYuX6wr7lynDaWdU51UXctsVgRiJ4NDHDlePVOpJyumyfnwh9koX?=
 =?iso-8859-1?Q?2LLHTNdiBibWf0GI5MKTtYgvoNCHoesA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd82d2fd-7525-492a-a137-08d8d9450f9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2021 04:23:11.0171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/NqNlAGYC1c0v+uWL2K2DTeihNYN/RQ7UbocXY31MclQaZOkr6KtMvfYTG56AqAMg6T8LccTLUEqq8Ep4U1UTjOEvnK83+m7oEsukZLdhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2663
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use same cookie for request_threaded_irq() & free_irq() to properly free
IRQ during module unload. free_irq() already uses *wilc* handler so the
changes are required for request_threaded_irq().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 1b205e7d97a8..9928e91c8ffa 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -24,12 +24,10 @@
=20
 static irqreturn_t isr_uh_routine(int irq, void *user_data)
 {
-	struct net_device *dev =3D user_data;
-	struct wilc_vif *vif =3D netdev_priv(dev);
-	struct wilc *wilc =3D vif->wilc;
+	struct wilc *wilc =3D user_data;
=20
 	if (wilc->close) {
-		netdev_err(dev, "Can't handle UH interrupt\n");
+		pr_err("Can't handle UH interrupt");
 		return IRQ_HANDLED;
 	}
 	return IRQ_WAKE_THREAD;
@@ -37,12 +35,10 @@ static irqreturn_t isr_uh_routine(int irq, void *user_d=
ata)
=20
 static irqreturn_t isr_bh_routine(int irq, void *userdata)
 {
-	struct net_device *dev =3D userdata;
-	struct wilc_vif *vif =3D netdev_priv(userdata);
-	struct wilc *wilc =3D vif->wilc;
+	struct wilc *wilc =3D userdata;
=20
 	if (wilc->close) {
-		netdev_err(dev, "Can't handle BH interrupt\n");
+		pr_err("Can't handle BH interrupt\n");
 		return IRQ_HANDLED;
 	}
=20
@@ -60,7 +56,7 @@ static int init_irq(struct net_device *dev)
 	ret =3D request_threaded_irq(wl->dev_irq_num, isr_uh_routine,
 				   isr_bh_routine,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				   "WILC_IRQ", dev);
+				   "WILC_IRQ", wl);
 	if (ret) {
 		netdev_err(dev, "Failed to request IRQ [%d]\n", ret);
 		return ret;
--=20
2.24.0
