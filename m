Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D15588262
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406219AbfHISZb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 14:25:31 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:32511 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfHISZa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 14:25:30 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: RvXlqprSjXUvT05ajsqTgBszIr8GBv5dlkGzFr1Ze++KqAE2CJOM7kxrG4t0WxgiUc4m6uwRYp
 l2vsur7MQXyLTWYj4fpuT+Kyf3HS/CD1hpe74cmT4+96OXl2XbtVOWk/y5mfzxUt9RqY586n/n
 vJfEK/rPrQLTrRfFVQI4ELNI1ui7FuU8HH/g+rPl5XhK5LykzUIUlijQGQLip/W2c9WFL431Ws
 CBM0oycSDf8pOLFBZStDyM0Tk66cufkuvBXxHr9hS/vGmwAwmW9TSA/oC2KwnP4c6ygxyAwjje
 ghI=
X-IronPort-AV: E=Sophos;i="5.64,366,1559545200"; 
   d="scan'208";a="43782627"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2019 11:25:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 9 Aug 2019 11:25:23 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 9 Aug 2019 11:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrFYWzBBSDvutPlvxdEuq0RDZ55ol7MtApNAE/NCObYS74S+OGtFEnVpgA71AgSeYnyIbrTw6J5xedv6eUDIuwWsxIZQFH8IsBEkSq3gqdg+PKzR4wl67kcdKmMuACR1rTGXYww5XxAaqoR0XWb9WQG3uovUwFrs8x+d8CW1hIl982dzva96erWKRSprtdcSDpVldB/wEn8fPUb/CYfb+uaYHQZ7dWHQTksx7JP8T9Uz4joF48imhe8oDabXP08P3+uAgjIymERc1eycaA6GsGUo4N2bKAmHXk8HN7sgTTg8TWTLOV0hSnn3Qxc4cxzlS9qASl1+Qb30jhAtS5m3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIcI27aQJwo4OugbGOiKqRRehRbwf1u9SlVkhpc5n0=;
 b=YQox08C5lnu2ZUPkX1OfUoRwKthMdAKJdNJK0gftecRXX8unvMgbrM5bp2hShDfakULKLwqYkiPWqy+ecEB6I5MtSMpQurhOcX15jKpIikcbIKVAb8WbtWzaIQXzNv7NKsXMitjx87/0AGbfQqQLqzj83DHLmOKb6ji/3DJmHuPXF4ivetZmHmwgfwGqDJ9pNydQrlFiULqEpoBvu7GPFmNd7+J4Sg9U8Wfj9CJjcwOUJ87m3ZtWMgMdwtnxqftboC0q68YjCvf1QmRt70TtKbuZTmiATliH0HedDspa92AhiD1xV4XI4SFp+HS+dct/R4AInG513bSGf0uv3K0ohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iIcI27aQJwo4OugbGOiKqRRehRbwf1u9SlVkhpc5n0=;
 b=ktE9Uf/y4UwLEBxxwS80610PqFg545ytpoavgkzVwAa+Zac9peTTv0QZ9nUUiSv8fk2HvVj233jX2QK44B8LEwru67tIEbS6wkBZbiHZuH2r9V+UK1OTaKeKEkK+JPDDzHaLHPAgwgDfeLzCoWO6QBbSwH5MmKoSaeNTAH6RV6g=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1950.namprd11.prod.outlook.com (10.175.55.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.15; Fri, 9 Aug 2019 18:25:19 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::480d:becc:c567:3336%2]) with mapi id 15.20.2157.020; Fri, 9 Aug 2019
 18:25:19 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH v2 2/2] staging: wilc1000: return kernel error codes from
 wilc_wlan_stop
Thread-Topic: [PATCH v2 2/2] staging: wilc1000: return kernel error codes from
 wilc_wlan_stop
Thread-Index: AQHVTt/Megb7GILlxkecONemIE97uQ==
Date:   Fri, 9 Aug 2019 18:25:19 +0000
Message-ID: <20190809182510.22443-3-adham.abozaeid@microchip.com>
References: <20190809182510.22443-1-adham.abozaeid@microchip.com>
In-Reply-To: <20190809182510.22443-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR02CA0035.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::48) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f255cc06-c4bd-42ca-67b6-08d71cf6ef03
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1950;
x-ms-traffictypediagnostic: MWHPR11MB1950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1950F30A3AC32AEA73CF85058DD60@MWHPR11MB1950.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(366004)(396003)(376002)(199004)(189003)(5660300002)(6486002)(71200400001)(5640700003)(186003)(6436002)(26005)(66066001)(2351001)(107886003)(6512007)(53936002)(50226002)(1076003)(54906003)(7736002)(2906002)(86362001)(386003)(2501003)(71190400001)(305945005)(8676002)(6506007)(14454004)(11346002)(2616005)(476003)(446003)(256004)(99286004)(6116002)(3846002)(486006)(64756008)(76176011)(66556008)(66946007)(52116002)(66446008)(66476007)(81156014)(81166006)(6916009)(8936002)(4326008)(316002)(25786009)(102836004)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1950;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9QCvnwkfRI+ETEb1hgDZ1OKUdl+TLS+1U8CxlRInAx5lg2f3w+bbSPh/Zvc/Hm16vyfl681qXHTZm6+vhvyL+EN+BvuMPPOr/B83sNBhAXZ6pO+Xky7vCIaG9JjqG8CsFQRrA7fIfiAmfih9u7c/3J9uPbIoVOI9wPi/PXcac8oWD9h8JF83+Ms3BolCvtGgTzQtPazDnsQ7J3JbiFJ2aME2TM+/kV0c6ZxKN2LjAJnV8HEYNf6vxKQCk9153OxgoVMsGu+UqH90rbls2XfctOvglcDIIA6hplQJ41h5THW+qZYgGJGgaFVyEDNHBS8vRTqS0jyTZKB7SHkXvuUJQlvv7kM5+ikoiX/UKRwD5sBc8K2ZJLPZm1+SolBzR7StRzhcGebaqkax6cCnowePzYTXDBJCCRBOHTWuMLxD77M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f255cc06-c4bd-42ca-67b6-08d71cf6ef03
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 18:25:19.5693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8rGMGJTPN3s9Ng4/FGX8LnhYLh1DO42ZLkl17NGnQ7h8G0m6iqYsUvLKkarmiF8J9ftryJOGsAYudqtxDscLsz2zGT+iZcxA3mp5heI5oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1950
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

return -EIO for bus failures, 0 otherwise.

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_wlan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc100=
0/wilc_wlan.c
index 3d902b499a34..2bbb359d2119 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -979,7 +979,7 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *=
vif)
 	if (!ret) {
 		netdev_err(vif->ndev, "Error while reading reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return ret;
+		return -EIO;
 	}
=20
 	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
@@ -987,14 +987,14 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif=
 *vif)
 	if (!ret) {
 		netdev_err(vif->ndev, "Error while writing reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return ret;
+		return -EIO;
 	}
=20
 	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_FW_HOST_COMM, &reg);
 	if (!ret) {
 		netdev_err(vif->ndev, "Error while reading reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return ret;
+		return -EIO;
 	}
 	reg =3D BIT(0);
=20
@@ -1002,12 +1002,12 @@ int wilc_wlan_stop(struct wilc *wilc, struct wilc_v=
if *vif)
 	if (!ret) {
 		netdev_err(vif->ndev, "Error while writing reg\n");
 		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
-		return ret;
+		return -EIO;
 	}
=20
 	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
=20
-	return ret;
+	return 0;
 }
=20
 void wilc_wlan_cleanup(struct net_device *dev)
--=20
2.17.1

