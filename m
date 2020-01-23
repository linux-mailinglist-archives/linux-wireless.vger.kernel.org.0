Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C4146868
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jan 2020 13:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAWMux (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jan 2020 07:50:53 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:35263 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWMux (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jan 2020 07:50:53 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: GEjeQyLv10kbOJhMJvHG5SN0qTZObvQBVdfiG0bKaEQhozMTXUjbgCoFK2kJJQFuRQGaL4xzg4
 k10YgOUESkSmG+SqNo9SpinzfqCjFNJvoT9HYdIi0YGfPNuhlbL4zCQJ1K8fLQFpLRpDutQ30a
 MONeYgQPfl+y1vGeRGe5ZVXoHazGbPKWV0fsgfoxaNFSWMq9PzFQgxsXhZZBWbxJzzL1y2WxBB
 LiSQ3uUqpYWg6nrRea/zHywPSHNwxttL8oXJUWxRMfzi9AyRBTFxUT+Fdkj1/Dn3SZX2sGIxzS
 Nb4=
X-IronPort-AV: E=Sophos;i="5.70,353,1574146800"; 
   d="scan'208";a="65725540"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2020 05:50:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 23 Jan 2020 05:50:52 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 23 Jan 2020 05:50:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGQNj3dcuAyXibWXLSSh/whgeYVGw0GU9YqCR9zZSxAGSkpznkhvNh82C5RPYxeSAE5xuNZKS/xibuRZcyYuizbA+vj5hLET+8MRPxgRrHkRL9QFUChAelHXJE8ukRGxK0rWa18gkFTco4FMhXNzYn5aAPpqFjWDIJulOkuDPi1juxYNyMgcqJ/Ri73auuGDIDAkIUBhB0sanZjv2giMOhFh1HLJZ60uA9kWYdQzLlu6FldHC1EV+2dHdpyMC+MZ20GnH2S5FMXpPCArKJ5xr9p2mbM1O7bmaruCpOAF43CgWysO/+pz2I33/Sp98jGneRQlfB7Sp6R3mZ6sPEupdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot/G4/1Xj+mT9o9Wymq7V1qq7PqH2r8HkjiXsM7u4zU=;
 b=SnzYqVzBoI34Gm7R3YemDCdZH5SqYTqtBm1piidpv4zaFsBQCAkNpv+tns/MIAAGorhrc1eZVf/TjwlNxDxRBt9kOD2JrgFeqlFtFI58jic1rDtc7WN7z5/0gASWjS0k0e9xJEJIqIEStOYGHZRZ/u5LNy2DiHbvawZEkoqcqDTNuAiiCpJWF2UJjic0a4U7Jn6Hvmfg1qlArXa3O7yK4UavOO+LDGtJ54VI2ciKtrJdnArhH1p6DuNtQd3aa+Unk6EwyricGXa9AtauDT2n+HwUkQUKnK+1RnMT3J2tFAXtZgqxGvVDk/R5OsmXf6Gj5VZsg8v4LIkTxeR4RQRH6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot/G4/1Xj+mT9o9Wymq7V1qq7PqH2r8HkjiXsM7u4zU=;
 b=HeG2dAvg2tQeV7Xfy8H58Nw/T3Wq9qdommANULGYADzfAGpbKfkc7wooRUyo1hUyDjU1J3e5IBNvOEBFmwWPNQ8Ouy5qyMrtlvcchgMzKXSizuirnQkBU79ViiuY+kBNXXUxIJsDBZuhnTXz6TymYwyPX6dJlL+rrr2DgxRjMTg=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1507.namprd11.prod.outlook.com (10.172.20.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 23 Jan 2020 12:50:49 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61%3]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 12:50:49 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/2] staging: wilc1000: avoid mutex unlock without lock in
 wilc_wlan_handle_txq()
Thread-Topic: [PATCH 2/2] staging: wilc1000: avoid mutex unlock without lock
 in wilc_wlan_handle_txq()
Thread-Index: AQHV0eu8iPwrjsHTqkWp6RV25i6i3g==
Date:   Thu, 23 Jan 2020 12:50:49 +0000
Message-ID: <20200123182129.4053-2-ajay.kathat@microchip.com>
References: <20200123182129.4053-1-ajay.kathat@microchip.com>
In-Reply-To: <20200123182129.4053-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b30548d-d98a-46bf-72ef-08d7a002df62
x-ms-traffictypediagnostic: BN6PR11MB1507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB150793797DB8D9764C96B5FBE30F0@BN6PR11MB1507.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(39860400002)(346002)(366004)(199004)(189003)(26005)(5660300002)(36756003)(2906002)(107886003)(4326008)(6916009)(54906003)(6486002)(186003)(478600001)(316002)(86362001)(6506007)(81156014)(8676002)(71200400001)(66556008)(76116006)(91956017)(2616005)(66446008)(66946007)(66476007)(64756008)(6512007)(966005)(81166006)(8936002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1507;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aLCMV94jFZNOrRiz9zizKBiBs5m3OKvL4llYBOCa9Nw2fVdRkRJ5xX59T7C9z+GsmMoZWFrSWqmdn1U2xfGmCVqiAsxqUdFv/6KjzVviMRr70aGdiCF506c0SDTzpfCimpJeHX2GkMpJL+z5CN4Avc7EQ9+P29ydaVJv20AJuLK1NHSn1F/ix1QVy8h0gU0+NDqlpuzAcy4f+CghFKORjSufUExSRJ9LSuZ6HU/M13TZRq8E1PfFPrP7USuQOzxZN0EiZk/3GxmtKXVXhDgorAFl/WV0WYeIe2dMgPkh5ZSZiOmMlv9pwDGGszzyHuu+KcAmsFfnCis3kHRyPAj+vd6IQSCArOmDKqNQOiYjh9g1yKIEqWCxWh1VmGBsTHvzLPo05eG22IqFSLGfLFr9/ul4e5y4LvqJg6fE7mJBEbnfDIKNyNgngBTPHDtUQjZ/xnHobPdWPXnSowJ4fua6Wywkk+dpC+SC2sPhTOjvwI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b30548d-d98a-46bf-72ef-08d7a002df62
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 12:50:49.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hlDGt/IZ9JgLUnxwE/+fRUwoRm9hXPDyF+NtbUYx1PKV55l6DP+kgtn/o6QW7uFWV9YCKoyFCR0zmFPe9R2d/fjNUlEBAYoWS5Z9I+E6W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1507
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

In wilc_wlan_handle_txq(), mutex unlock was called without acquiring
it. Also error code for full VMM condition was incorrect as discussed in
[1]. Now used a proper code to indicate VMM is full, for which transfer
to VMM is required again. 'wilc_wlan_handle_txq()' should be called
again if the VMM space was full earlier or otherwise based on
'txq_event' signal.

1. https://lore.kernel.org/driverdev-devel/20191113183322.a54mh2w6dulklgsd@=
kili.mountain/

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/netdev.c |  2 +-
 drivers/staging/wilc1000/wlan.c   | 15 ++++++++++-----
 drivers/staging/wilc1000/wlan.h   |  1 +
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/n=
etdev.c
index 0f48e74aa3ea..fce5bf2d82fa 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -174,7 +174,7 @@ static int wilc_txq_task(void *vp)
 				}
 				srcu_read_unlock(&wl->srcu, srcu_idx);
 			}
-		} while (ret =3D=3D -ENOBUFS && !wl->close);
+		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
 	}
 	return 0;
 }
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index b904eda42806..601e4d1345d2 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -489,12 +489,12 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_=
count)
 	struct wilc_vif *vif;
=20
 	if (wilc->quit)
-		goto out;
+		goto out_update_cnt;
=20
 	mutex_lock(&wilc->txq_add_to_head_cs);
 	tqe =3D wilc_wlan_txq_get_first(wilc);
 	if (!tqe)
-		goto out;
+		goto out_unlock;
 	dev =3D tqe->vif->ndev;
 	wilc_wlan_txq_filter_dup_tcp_ack(dev);
 	i =3D 0;
@@ -526,7 +526,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 	}
=20
 	if (i =3D=3D 0)
-		goto out;
+		goto out_unlock;
 	vmm_table[i] =3D 0x0;
=20
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
@@ -595,7 +595,11 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_c=
ount)
 		goto out_release_bus;
=20
 	if (entries =3D=3D 0) {
-		ret =3D -ENOBUFS;
+		/*
+		 * No VMM space available in firmware so retry to transmit
+		 * the packet from tx queue.
+		 */
+		ret =3D WILC_VMM_ENTRY_FULL_RETRY;
 		goto out_release_bus;
 	}
=20
@@ -662,9 +666,10 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_c=
ount)
 out_release_bus:
 	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
=20
-out:
+out_unlock:
 	mutex_unlock(&wilc->txq_add_to_head_cs);
=20
+out_update_cnt:
 	*txq_count =3D wilc->txq_entries;
 	return ret;
 }
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 44ae6ed6882c..8c4634262adb 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -198,6 +198,7 @@
 #define IS_MGMT_STATUS_SUCCES	0x040
=20
 #define WILC_WID_TYPE		GENMASK(15, 12)
+#define WILC_VMM_ENTRY_FULL_RETRY	1
 /********************************************
  *
  *      Tx/Rx Queue Structure
--=20
2.24.0
