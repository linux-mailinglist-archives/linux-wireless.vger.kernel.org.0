Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A367FAF55
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKMLHn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:43 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:46248 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727780AbfKMLHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:43 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADB6R1w012528
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:42 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2054.outbound.protection.outlook.com [104.47.36.54])
        by mx0a-00183b01.pphosted.com with ESMTP id 2w7pt7m9c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fue8aoSCrv+RVOjSErxJX4mbW9RgAR9GsVZ74VY4Tenxzqxqgs5VKYspT7Fp/EHMxx+HPIGma49wz4m4nY39vamflHx62uftuXJymr+uSBp3s7baIyYjibu8CMVuU6bonthcX5LlvqCNs3BsADtHH7Az1Oipl3X4irC4/c8z/Lo4LeqtSZH6fys2QrNx/chfbPXJOS4S78RrrdFDgZkBaCHF6+xUYvek2AIXlbWHdjo6UXDGf9zz5kdFnSI7OrNGxnUG6Wm1jjAuWUa9G1jfmcQqVutOtWAh/F4DE+DjFu3IUdSQmNpKt54Hn3ODPs0Kyc39Zp/PDdYn9Fp0A2XtRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO2O1MgH8oyvycws5rp47XY/JJLmJcqsM/Y0s7jomFI=;
 b=BF+rA8DCV1DsmZI7fZBiLjOg5VVuYTSiDBgW1YQpn/2v/XMAGSR4ZrSpTHCPMEbcK94azSLY1C/212873ki4H+cvbWvZAcIuwx/IoPZDhYj2+jI7KZlOuO6QST8QhI7nn6cG8GYEq6cR1admRzQy7dqnaFwRQXjLgOB+/+/90tGm0TPd/cawx7Hu4TI3fiHPX6G09FptQHAjj6BJ1h4mkjXfsizyL+y4fEgMOgjqzQZdCnd4BM+RXFLJk4xzbd9CrzNlEk27CKyh+H9gd9orYFQyV8mnXlTautKfGOPOUpCpT4OXQDNYPJNyy2pCdQ5F4Bo/M0FuM7LFvpZchLBOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uO2O1MgH8oyvycws5rp47XY/JJLmJcqsM/Y0s7jomFI=;
 b=InnLaHKE6rz5JkKWHqyy7ctAXG2Hu6roy2szYujtVGyGUSxbeM0DfncX3j5EaWGGm53Zu7Ny6Qb7YEC3fuvuVJ69b2eLrqIWMl3Ar2BJVJ8uuOeQrX0c3F5NKKV2EkfmhqES/GICFn2BgHIThapbqJYw7FW9KeHJ5NCcMLL1pNs=
Received: from SN6PR05MB4496.namprd05.prod.outlook.com (52.135.74.149) by
 SN6PR05MB4781.namprd05.prod.outlook.com (52.135.115.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.21; Wed, 13 Nov 2019 11:07:40 +0000
Received: from SN6PR05MB4496.namprd05.prod.outlook.com
 ([fe80::fc6e:cad2:ffb3:22bb]) by SN6PR05MB4496.namprd05.prod.outlook.com
 ([fe80::fc6e:cad2:ffb3:22bb%7]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:40 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5295.namprd05.prod.outlook.com (52.135.109.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:56 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:56 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 5/7] qtnfmac: send EAPOL frames via control path
Thread-Topic: [PATCH 5/7] qtnfmac: send EAPOL frames via control path
Thread-Index: AQHVmhJ2MjnOC2xosUKtc48SE29I8g==
Date:   Wed, 13 Nov 2019 11:06:55 +0000
Message-ID: <20191113110639.9226-6-sergey.matyukevich.os@quantenna.com>
References: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191113110639.9226-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::35) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ef726b-0f53-4888-1557-08d768299864
x-ms-traffictypediagnostic: SN6PR05MB5295:|SN6PR05MB4781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB52956F3BAF63D55FE6A6C05DA3760@SN6PR05MB5295.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:36 AM
x-ms-oob-tlc-oobclassifiers: OLM:194;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(366004)(39830400003)(199004)(189003)(71190400001)(305945005)(64756008)(71200400001)(7736002)(2501003)(66556008)(103116003)(66476007)(76176011)(66946007)(2351001)(66066001)(99286004)(52116002)(81166006)(81156014)(8936002)(8676002)(6916009)(6506007)(386003)(6116002)(3846002)(50226002)(107886003)(66446008)(4326008)(2616005)(36756003)(436003)(486006)(476003)(11346002)(102836004)(26005)(14444005)(446003)(186003)(25786009)(54906003)(5660300002)(2906002)(316002)(6436002)(6486002)(478600001)(86362001)(14454004)(5640700003)(6512007)(1076003)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4781;H:SN6PR05MB4496.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjdS/Bt5jN1qa7e1qGSa4use36/zhz0M/73Q0MB1+Ly3JSqAuTWZ3v5MdZmh+jse8F5tWdF/GBrAMikJwr62SK6Q2e0C/FGTIaL7kIfnOzSvzG+9BnSBmfnj0c/arXGEQ+gxvzNWkQay6g2ci5qIppbedG7MrCOOGBr8JQilMft9XJ+VKEKsrVssh/K5ezd6a/B2l/hkB7h+bncLOcKZEh0pOFhU7S8B7CLuJwOjOlgFTh0NrF05u8C1IJOGETtVEVVO2QiqJI98vOsIz1pzEwD5BZuYTj2vrU/bbNS29a/dpRHsBT3q68s8yVsel0uT6be41HYK1r+F5ifLcXdVPtPvxFxCanXS8YcpUHbVHQqKJezG/jGWJtNSEE3AC996SeF1G5fy829I6HNQwYV7HJp+KeoJYF3+sQWd0Q/2htOazcdIeBVe0qqkg5DlbnYn
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ef726b-0f53-4888-1557-08d768299864
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHVEcJrgGRWpQtrhpISFJeKfVcN1XZeRnqnZiXXxt0BgzVVKBXqaIrGgPldGvBiUqiYDwlJEjsFi5L6Uxm33uDT8bLUBquemVzhssGTfyeD2/w4+2Eijeg7I1yFjy0PfQ5OwHuaXXAoqnCU2lwAfAXgVI/1ZYgzvMqNGhNUtR2STdLo5HBXae1j2H2wIOYD8IsS7qzKp/0QO0Xr+fT26mQ==
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:40.4395
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4781
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Send EAPOL frames via control path so they can be treated in a different
way rather than normal data frames. In this case EAPOLs are sent with
higher priority and with disabled aggregation and encryption. Besides,
all devices benefit from sending EAPOL frames via high priority path,
so move the functionality from chip specific to common code.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 23 +++++++++++++-----=
----
 drivers/net/wireless/quantenna/qtnfmac/core.h      |  1 -
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |  1 -
 .../wireless/quantenna/qtnfmac/pcie/pcie_priv.h    |  1 -
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |  8 --------
 5 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 8d699cc03d26..8116b224c946 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -67,6 +67,14 @@ static int qtnf_netdev_close(struct net_device *ndev)
 	return 0;
 }
=20
+static void qtnf_packet_send_hi_pri(struct sk_buff *skb)
+{
+	struct qtnf_vif *vif =3D qtnf_netdev_get_priv(skb->dev);
+
+	skb_queue_tail(&vif->high_pri_tx_queue, skb);
+	queue_work(vif->mac->bus->hprio_workqueue, &vif->high_pri_tx_work);
+}
+
 /* Netdev handler for data transmission.
  */
 static netdev_tx_t
@@ -107,6 +115,12 @@ qtnf_netdev_hard_start_xmit(struct sk_buff *skb, struc=
t net_device *ndev)
 	/* tx path is enabled: reset vif timeout */
 	vif->cons_tx_timeout_cnt =3D 0;
=20
+	if (unlikely(skb->protocol =3D=3D htons(ETH_P_PAE))) {
+		qtnf_packet_send_hi_pri(skb);
+		qtnf_update_tx_stats(ndev, skb);
+		return NETDEV_TX_OK;
+	}
+
 	return qtnf_bus_data_tx(mac->bus, skb);
 }
=20
@@ -841,15 +855,6 @@ void qtnf_update_tx_stats(struct net_device *ndev, con=
st struct sk_buff *skb)
 }
 EXPORT_SYMBOL_GPL(qtnf_update_tx_stats);
=20
-void qtnf_packet_send_hi_pri(struct sk_buff *skb)
-{
-	struct qtnf_vif *vif =3D qtnf_netdev_get_priv(skb->dev);
-
-	skb_queue_tail(&vif->high_pri_tx_queue, skb);
-	queue_work(vif->mac->bus->hprio_workqueue, &vif->high_pri_tx_work);
-}
-EXPORT_SYMBOL_GPL(qtnf_packet_send_hi_pri);
-
 struct dentry *qtnf_get_debugfs_dir(void)
 {
 	return qtnf_debugfs_dir;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index 322858df600c..e3feea31191e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -152,7 +152,6 @@ void qtnf_virtual_intf_cleanup(struct net_device *ndev)=
;
=20
 void qtnf_netdev_updown(struct net_device *ndev, bool up);
 void qtnf_scan_done(struct qtnf_wmac *mac, bool aborted);
-void qtnf_packet_send_hi_pri(struct sk_buff *skb);
 struct dentry *qtnf_get_debugfs_dir(void);
=20
 static inline struct qtnf_vif *qtnf_netdev_get_priv(struct net_device *dev=
)
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/n=
et/wireless/quantenna/qtnfmac/pcie/pcie.c
index 3360b836fc44..5337e67092ca 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -357,7 +357,6 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const =
struct pci_device_id *id)
 	pcie_priv->pcie_irq_count =3D 0;
 	pcie_priv->tx_reclaim_done =3D 0;
 	pcie_priv->tx_reclaim_req =3D 0;
-	pcie_priv->tx_eapol =3D 0;
=20
 	pcie_priv->workqueue =3D create_singlethread_workqueue("QTNF_PCIE");
 	if (!pcie_priv->workqueue) {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h b/driv=
ers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
index 8bc4300518d0..2a6a928e13bd 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
@@ -63,7 +63,6 @@ struct qtnf_pcie_bus_priv {
 	u32 tx_done_count;
 	u32 tx_reclaim_done;
 	u32 tx_reclaim_req;
-	u32 tx_eapol;
=20
 	u8 msi_enabled;
 	u8 tx_stopped;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index ef255fb57405..a0587472736f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -509,13 +509,6 @@ static int qtnf_pcie_data_tx(struct qtnf_bus *bus, str=
uct sk_buff *skb)
 	int len;
 	int i;
=20
-	if (unlikely(skb->protocol =3D=3D htons(ETH_P_PAE))) {
-		qtnf_packet_send_hi_pri(skb);
-		qtnf_update_tx_stats(skb->dev, skb);
-		priv->tx_eapol++;
-		return NETDEV_TX_OK;
-	}
-
 	spin_lock_irqsave(&priv->tx_lock, flags);
=20
 	if (!qtnf_tx_queue_ready(ts)) {
@@ -779,7 +772,6 @@ static int qtnf_dbg_pkt_stats(struct seq_file *s, void =
*data)
 	seq_printf(s, "tx_done_count(%u)\n", priv->tx_done_count);
 	seq_printf(s, "tx_reclaim_done(%u)\n", priv->tx_reclaim_done);
 	seq_printf(s, "tx_reclaim_req(%u)\n", priv->tx_reclaim_req);
-	seq_printf(s, "tx_eapol(%u)\n", priv->tx_eapol);
=20
 	seq_printf(s, "tx_bd_r_index(%u)\n", priv->tx_bd_r_index);
 	seq_printf(s, "tx_done_index(%u)\n", tx_done_index);
--=20
2.11.0

