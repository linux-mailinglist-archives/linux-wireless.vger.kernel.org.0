Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A4A7CF36
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfGaVBZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 17:01:25 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1664 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfGaVBZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:25 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: PHzbmqKmC52ldHR4A6xwXRQrXL4DEwvBQ9yKGdjnbQbJOuIhE1OmTaaRj0fkFMNvK52LG5Sn4c
 7cqtk/IQumDynJjwBfe1kfJbDBjk2CRPqhfIt5/uewB88aDmT6lNJQPe7fl8BXFLAxB+WKyrk5
 7WS5LBt+yWFiT63ih/t0SBglvNDNKDReXjJnUI1TPqA+33udgobZoNyTRyQvIA8NjuEHcLLGwi
 RBsF1EzLGpq123QeY+P+PI6051u7BcM3uKtadfY89NmOe8Yinp8H+53dtaidXhAIgnoxKJeN7/
 QB8=
X-IronPort-AV: E=Sophos;i="5.64,331,1559545200"; 
   d="scan'208";a="40503464"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jul 2019 14:01:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 31 Jul 2019 14:01:21 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 31 Jul 2019 14:01:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTsQ/nvPVyNxwR8BNub/ENYUul8cE5/erBtejbaSnGWypTsLK+/BFaVUxDDjoHQG7X1Cxbcp+L8eATKb+GIvvTDiqILJmHdtNOi03f8O4LF/nKEgDbPdp6Mat/rTxEjq4xfSSx6YjZWUKI5DnZ3Rzu6E3gviTo7Gl+48fNTkPupmC3tRURsXgGytT3WZPmdX+PwtpzLq3T51UK8sv/fFyjEEMDuxxzttbuSRpC4PttqvN7e6XCkJZTfhv3X67pJPUuPuNEQfYuGua60S4kNo2nQPOSgLiLv+4/LHtRPfe34XJsoeDV9oEdV1INm6y46a8XF7lukzxExK13VOugMGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGKk+I1KwG6nI2zPtK+CkHVFZM2urDixCJohymu5yQw=;
 b=bHw4UvDNC5wqvuEfDoArODEsyPZbbEc5dv21/rQEF/v3rVNcmoo67qCkOuCr7vhyR8de4AYwNajvCkr4paCvEa48jizA9sbrkWhr/zAwP08o7mu8LdLrIggcGIIr1S3jT1eLDN7Qn/PoFi/KjOQPHEkNcryOiZ8FcQiLKzFq9T4BXzkAxhw6FJ+1LrW3PV0c4AENjo2o6tZvZAoDlW1XPweeXZWeUUxHryLhw90uc2G/8JpQUZwdVTejqU1YIbdlUYkKuoKrARG6xIw5fwZZe7wsTvEetaiXRagFd2odLIY4oQ6gSTRarAB/YXq/Js4GQ3s2fSbKQMUi9s5xqWGBlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGKk+I1KwG6nI2zPtK+CkHVFZM2urDixCJohymu5yQw=;
 b=pVRFEG8Lu015RhgPi/QvUBLuvS3nEvWP7u3YaoSGIE39vjYaB3VvLAeS0mHtI0/RpS1jVechh8JedBTbp7SkWI4PR9gRNWoMqjKfHrsC+SwF6XCsSWQ1oQfoDDHwh74GHfc2SQTW7oiSVZGFBc2LPqfxZVpqfhMD7CpW4tS/js4=
Received: from DM5PR11MB1371.namprd11.prod.outlook.com (10.168.101.145) by
 DM5PR11MB1804.namprd11.prod.outlook.com (10.175.92.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 21:01:20 +0000
Received: from DM5PR11MB1371.namprd11.prod.outlook.com
 ([fe80::751e:92c:b069:7c65]) by DM5PR11MB1371.namprd11.prod.outlook.com
 ([fe80::751e:92c:b069:7c65%3]) with mapi id 15.20.2115.005; Wed, 31 Jul 2019
 21:01:20 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: remove unused function
Thread-Topic: [PATCH] staging: wilc1000: remove unused function
Thread-Index: AQHVR+MaFjYQZQwqbEaDGN6ISGntZg==
Date:   Wed, 31 Jul 2019 21:01:20 +0000
Message-ID: <20190731205546.6647-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR08CA0071.namprd08.prod.outlook.com
 (2603:10b6:a03:117::48) To DM5PR11MB1371.namprd11.prod.outlook.com
 (2603:10b6:3:7::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d12e1d24-8dac-4bd0-7855-08d715fa3cb1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1804;
x-ms-traffictypediagnostic: DM5PR11MB1804:
x-microsoft-antispam-prvs: <DM5PR11MB180499F424F5D2413A28E8948DDF0@DM5PR11MB1804.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(189003)(199004)(6916009)(6512007)(305945005)(256004)(36756003)(6436002)(6116002)(2501003)(14454004)(6486002)(54906003)(2906002)(5640700003)(476003)(2616005)(53936002)(486006)(71190400001)(316002)(86362001)(66066001)(3846002)(81156014)(6506007)(26005)(50226002)(66556008)(66446008)(102836004)(2351001)(478600001)(71200400001)(1076003)(386003)(5660300002)(107886003)(4326008)(99286004)(52116002)(186003)(66946007)(8936002)(66476007)(64756008)(81166006)(68736007)(7736002)(25786009)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1804;H:DM5PR11MB1371.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9b3IrJRl+I0FYtCJQZZCNooHREdEpAlXU5ilyQxxhKnFoafNqzEwNNAB/w2xQ2zPmxXVm+H4jFprlSr+DDdxENo6dpTFbQrxWkMg7to2eTQRSmWexocQmpEQD6rTjr4A9il9XLjUlt4TFP+CoS3rM4aAYAkyY6SzRt7eBAfYfud6zZqQk63Fn57QB4GUAnCZmvInIsEEJl0kQh3wnBmolXPbxyaCHktL6J9PWYOUY1/e+ghrfu7Y8+WTCdTfQ5DR0ZRnPM5AEEjwJt+9j19tqosoPgHVo9NBSYsVxByKAW3rC7cFjxRkS02Fk9aRdELgqmA/wd5iItoBQzs8e/rA65jsdp6itVgkz9R9w+Xr0vFyl5oQlUm/TLzxy92aTdGmEqM6hlLjNkM+Ye8gGPynm6UuYQOdHy89Ou4TUdu4Ybw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d12e1d24-8dac-4bd0-7855-08d715fa3cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 21:01:20.3908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1804
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

function wilc_resolve_disconnect_aberration isn't referenced, so
removing it

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_hif.c | 9 ---------
 drivers/staging/wilc1000/wilc_hif.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_hif.c b/drivers/staging/wilc1000=
/wilc_hif.c
index ca252a43cd8c..4d809804c784 100644
--- a/drivers/staging/wilc1000/wilc_hif.c
+++ b/drivers/staging/wilc1000/wilc_hif.c
@@ -798,15 +798,6 @@ int wilc_disconnect(struct wilc_vif *vif)
 	return 0;
 }
=20
-void wilc_resolve_disconnect_aberration(struct wilc_vif *vif)
-{
-	if (!vif->hif_drv)
-		return;
-	if (vif->hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP ||
-	    vif->hif_drv->hif_state =3D=3D HOST_IF_CONNECTING)
-		wilc_disconnect(vif);
-}
-
 int wilc_get_statistics(struct wilc_vif *vif, struct rf_info *stats)
 {
 	struct wid wid_list[5];
diff --git a/drivers/staging/wilc1000/wilc_hif.h b/drivers/staging/wilc1000=
/wilc_hif.h
index 3bc305151651..ac5fe57f872b 100644
--- a/drivers/staging/wilc1000/wilc_hif.h
+++ b/drivers/staging/wilc1000/wilc_hif.h
@@ -222,7 +222,6 @@ void wilc_frame_register(struct wilc_vif *vif, u16 fram=
e_type, bool reg);
 int wilc_set_operation_mode(struct wilc_vif *vif, int index, u8 mode,
 			    u8 ifc_id);
 int wilc_get_statistics(struct wilc_vif *vif, struct rf_info *stats);
-void wilc_resolve_disconnect_aberration(struct wilc_vif *vif);
 int wilc_get_vif_idx(struct wilc_vif *vif);
 int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
 int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
--=20
2.17.1

