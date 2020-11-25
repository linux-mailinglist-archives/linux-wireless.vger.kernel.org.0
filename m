Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE0B2C3F3C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Nov 2020 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgKYLlR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 06:41:17 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38099 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgKYLlQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 06:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304475; x=1637840475;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q8SSyjFwQLV3pH35wsNuNTcgt4UpXo89ak0633EPj9g=;
  b=eQUq8IzyJKq0tK35miSGuLFQLTMgLAMKr55hL1d3SRlBjB/DJy+Fofvj
   rkvsZZspQvrkiGayAhmSlIUtUmLIrwmsVXU17DkT7PKe7WvY2EjGoVnTC
   oJvnqdlCXmjUkjhpGL8xOfNS0yLdXnT/rb4AjUfp/a2XXwoUSsSTLSEVg
   6UBN84neEnO3hQXaMNJXEMCLainCy0LAOlvghR+QfxfFGFPxLZULIM88u
   9hKtI72bxt4BkzsJI4OyxNEtDIvNx1P/nrOp9aMfcdX+7HxyT//UO/JF/
   MB4CGrHL9Qu7GCley5E+gvQnS65smBicJmsAqAQfpoL4H5/5s9FTwVaDB
   w==;
IronPort-SDR: hmddJNtHN+pJbdV4e4OrvMkOpA/CTKTuD4cFizoqQPupNvj3LuTp17fVwnxOn0TLntpz55rI/B
 L9Nwhm0XMIr+EW4ix70lNGAgJPgiDqY2Y0NiJ5CPZRDHRxL/TSR7p2yAsng0PMeM/jJToY0sqL
 JWfV7gZMGefbKbZRuJva6KyoxKutlD70vpyuWtVfCvyr3wC4OCPmjx1DuL4KN583S+E6TFqcSz
 lQFA1oKiTm35oCNm7bQqtQ8p5f+dlrdorjuGIVtZTlMvcw7ndIbsAq7V0/hr05k/MdRER8NWz4
 5h0=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="104995331"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:41:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:41:15 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 25 Nov 2020 04:41:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnikaqYirziRQrEg2kE09uniXtRHdO309fAslLW2+6FC5xFP9FAjHwqw0qtPa/Kn8qArSyrWeTucdWtXOhc0OIyk/Rud/TCFUfNbo3v4H6BtpLNPe49lvT+sCtZXSG7Geogna7EXroa5R3upmkMqOTckYuON8xjzbiY71OBFrMLZL/xZ8C3tBhHY6qAfsZDqIifQSi/AtIBd6E+hZ4jWDKT8nI2euwZXdgBbVNKl5mwhrqCnAojRf27FOoYXxw3axkgOdcpp/nx8PdVi9khU7N2BVfRtNZMfxuA+5XkmgkXjyIS4lEi4CMp2myIf9aLITO0Xp2h0w1rx7Gk5NLnQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAa+nFWB1Jq/y2sMmcJyudggnWveUayc1Ab3y+fCZJQ=;
 b=NH4JWFA7PVyzU4v1ujusR2D0q6EGHtoJ+Bi3Wee6rENN65VP8rh1MG0QxmlWo9vMdI5Puj44HC3HI/rfIEEvxUfLMmvkdJBQF/wVru2vknJI4eJKMbH+ly9ZEIg6iqWgD6tIOH17PTfZ5JvwJ9+GZ/eniNg8b3yEyunRKIqHMFrckVjHgA3E0VMU0ZMv28+o+cuLfbQk1lUYrG9AZoPFXHX/CmUFE5rhnrv/qtI03YiyWfOayRdLbCFCAP06tuprYDLb9wMpiDCzPhSRBGHU3g0dqM5x8eeduoOpyUyFp936SLLfp5k/7Qt8hffvDkJVLNZ/is7ahHTvtJPOWCl/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aAa+nFWB1Jq/y2sMmcJyudggnWveUayc1Ab3y+fCZJQ=;
 b=fmd9kOtA+Ct9OOibyEk1V+lJCckOEVVIKm9kJRGz52NIqXVVmr6dlXTJe9GhPv99oPRcY1wPMJ/oUbxYG+DdmS+IpwBHtLNfNmz8DN/563fUC4tS0AoQijeV8nQttnTP+zacSywizvAbSLvrBY+TL9T9Bcuxb/NJPDP0m/wkx0Y=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR11MB1287.namprd11.prod.outlook.com (2603:10b6:903:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 11:41:09 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:41:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/5] wilc1000: free resource in wilc_wlan_txq_add_mgmt_pkt()
 for failure path
Thread-Topic: [PATCH 3/5] wilc1000: free resource in
 wilc_wlan_txq_add_mgmt_pkt() for failure path
Thread-Index: AQHWwx/ef/9yBNwo30Wr1rzW7nXWOg==
Date:   Wed, 25 Nov 2020 11:41:09 +0000
Message-ID: <20201125114059.10006-4-ajay.kathat@microchip.com>
References: <20201125114059.10006-1-ajay.kathat@microchip.com>
In-Reply-To: <20201125114059.10006-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [171.61.34.149]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e03ea29a-2c35-4185-d934-08d8913700da
x-ms-traffictypediagnostic: CY4PR11MB1287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1287D5AE59B5F0B45F6965B7E3FA0@CY4PR11MB1287.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pH/Y8exDWDAma01rr2rhwgHbsSK8gmTPV2Gh/ocqlytzSavJK5spBiKs3zk/PNogSQk8fdhSetZwdoHGgTx8IordCaTNvRVeVTmOu5FHpDhS8ETPzmoIebAj666DdeYbX3cqyUajcoB4udABoAZCP6hjjsseXLyhTIMUHKZnSnDthozd9h9gaGrloBpieBjJvV1K7Q5neezfBduPNNvURlUYvfRrFDF9xzDVZdqB48yi4ils2S9ExEqlXdX/lTHdKsyu7S3BLEXVSYZQZOAlkmhuD14PP+wuXrTCB40EHP9cUKLhGd/NXelR9ey6pe4XKOMQ9kh3r5am1Td0WTDsZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(107886003)(66476007)(4744005)(66446008)(5660300002)(83380400001)(64756008)(8676002)(54906003)(2616005)(6486002)(66556008)(4326008)(316002)(110136005)(26005)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(478600001)(66946007)(76116006)(91956017)(8936002)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LGzSMck6BH4XAMXVgfV2EEwvVuonA/Flg0710ex7lc9d8xDlzwCNYhFDZ9mwWGAunI2oxpYQb/RA+nvbK224NWnSIIOZrr6ZCkh7H4FuZzF5j3bLMSM/PjUJSCMAKIsQvNWGanNHVwoEoeoDU/R+F+DO2t2b4e4+eB3ksgiJ4tf5QCu9muak6YLej2YnyeVlzISaz5q+x7UxIhwrrhqh1b2q+Do4mN3ppp+NIjChlzvU/+M3jt7EV5AGCwG3onQkq6xLyafuF/k5ob0Zavq7qZAQBjzucNUd5wZGzXkV5ZUfTS3p+e2J5hHqcBA719dH6C6xJzfhwrKCetBgTNURnbiYs2RdBjwuNwpf+Egc6uEqmdsBdwHpj7aHucijCnxKWwluJBWzKE1aQ51Q2D8hbQX1j41aIrmFgwzlj2RuYmB1xZ3qe3hsxImwN4L6W2WCh9FIMATtLetwDMR4hm7d8FxKpaq8gmwP7pk5EC03w6g/qUljn9oB+p6fTOsD7t7U3kyC8f9VD3SKQhnaFRflvKrQz010gKr3WBhpRIONBn8uQsQ0oKoJI0K3ZRkmJVIxlsVXXgo4DL0oZ2Bh0dLDdPFOoAhZIw4EKJ+51en6F/x2/iSV20THNIbJvCDUCI9faNqD6Ew56yVyu5WJ4GY/Wcu6EJxWWNp3NaMBHcmAQXvB4K+tcYEPCTNtksZvxX0rEtT/VQyRPPi/f+9MmllfcP8o9aYa0cWHvg6nPrD/HxXq5rLsLRiVGdOeMkOiL/VZbO6csujQW+4g6dIDFIDQY3jjLOSZrl248zGXf7/57dTy/ZoXJ+QBXllkseG3VjBaGtWNvBtChnJ+bTcoj03Uch4GFx+2YZz89w3CKsL2U2vV2xT6SoTEkSPhuai0RMfBpNg85UNTUlAUpjmnzDC5NA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03ea29a-2c35-4185-d934-08d8913700da
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:41:09.5057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cc7O+cwDu2u/DsozGjuX//YlDfhoS3nQPvWXhLe9DXJViiTUfyv6HLgxVOngYek4uc2A646DYw5QShh0xzcVzNOMIFoFJ3inBh75OLepj4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1287
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Before returing from wilc_wlan_txq_add_mgmt_pkt() invoke tx_complete_fn()
callback to free up allocated memory for failure case.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wlan.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index f0cc2da7c9c7..42b5db4e2d81 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -319,13 +319,17 @@ int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev=
, void *priv, u8 *buffer,
=20
 	wilc =3D vif->wilc;
=20
-	if (wilc->quit)
+	if (wilc->quit) {
+		tx_complete_fn(priv, 0);
 		return 0;
+	}
=20
 	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
=20
-	if (!tqe)
+	if (!tqe) {
+		tx_complete_fn(priv, 0);
 		return 0;
+	}
 	tqe->type =3D WILC_MGMT_PKT;
 	tqe->buffer =3D buffer;
 	tqe->buffer_size =3D buffer_size;
--=20
2.24.0
