Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4714A237
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgA0Krn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:43 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:16354 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgA0Krn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:43 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAh2jh020659
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:41 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrhdav48w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkRu1ibwi+YEg2rky0jtqD1Gb6cDipD1sUE5o+6jlIKxpHxqMM/9dudRb65sV046DpMjgt8eGh4oHjxM+w+HEfqWuPZR+5aTUPEcjDt5mjbCT3g3VOVTCfCWBWKKwS2W/i0621lrByKcn7j8AmcnmlD82hxD+j5WSsa4cLAFFumfkXAkGNBJcnxs08khRvaFZc94DbmtSD51xvhOrMWIR2v7bxoAqdKS7A45AuFlwqBVN8TidWinwp1UgivUm4JX2hgk6tUxcJqGaLaqYJbIv4i/2drzLKhPr7QNLNGHZzVJlZMzOoA6ZtkgmjFc+lgC3Oq6223+ifExQ0cz0Sayeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML2X7/K12x+4j58moGvcHB9OAFfTylFbyVXnmn963ho=;
 b=XhftJdnP706bZS/9zKflB4gzu3xR3zN5q9DAX6LqFrXCK5dR3p9kdWDcpRHRhJa2M5jsa+efKGqs5ZTUEP4KwoWymKLq1fcYIbeFsggjTCduJ5gDNb7QGwU97hzlWJqq15zq3KM7JxvST5bDPbzTpTNDM8hgNCRRYB8nA9K6u298LoQPRakb1LAHwXVU5oYOHj5qjpD13T4Cyhr+r2LU19GD13RkQhYvJ8+GQsayzOvySoxbJwO5+A66aSFvToYIC6WZvdu4fORn0epwSS5444ik04z61VX9KqjmirLTEk19ErE2TT/5Mcl5X63CiWpWYD8ffyX79J/74u3vLZz3zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML2X7/K12x+4j58moGvcHB9OAFfTylFbyVXnmn963ho=;
 b=UljbKw+uuA16G3KOFCyV3GZ3oslPugEbXhdx6XXQs/e2hIi7eDdedTMMvgf90cCl3mFp0J1zmxZydp6Q9khbrIIivLQkGRBCKwWwSNjMMMrbMrVkDNm/oWxHTiGsYpEV3BYy+JbnjPxT983vOIVrnf2frPYS8ILI5qzA4IkNdRk=
Received: from SN6PR05MB4686.namprd05.prod.outlook.com (52.135.114.208) by
 SN6PR05MB4591.namprd05.prod.outlook.com (52.135.75.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.10; Mon, 27 Jan 2020 10:47:39 +0000
Received: from SN6PR05MB4686.namprd05.prod.outlook.com
 ([fe80::d5e9:ea40:273f:4129]) by SN6PR05MB4686.namprd05.prod.outlook.com
 ([fe80::d5e9:ea40:273f:4129%7]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:39 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:44 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:44 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:43 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 01/10] qtnfmac: use MAJOR.MINOR format for firmware protocol
Thread-Topic: [PATCH 01/10] qtnfmac: use MAJOR.MINOR format for firmware
 protocol
Thread-Index: AQHV1P8RH4aLidAgdUeQ6uifwATGzQ==
Date:   Mon, 27 Jan 2020 10:46:44 +0000
Message-ID: <20200127104634.7248-2-sergey.matyukevich.os@quantenna.com>
References: <20200127104634.7248-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200127104634.7248-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:7:67::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bd5cb2b-a349-4e33-9f59-08d7a3163361
x-ms-traffictypediagnostic: SN6PR05MB5391:|SN6PR05MB4591:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB539127F596C9A275ACC04C2DA30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:27 AM
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39840400004)(366004)(199004)(189003)(66476007)(66946007)(66446008)(64756008)(4326008)(66556008)(6486002)(107886003)(2906002)(478600001)(6916009)(36756003)(5660300002)(54906003)(316002)(8676002)(8936002)(52116002)(86362001)(956004)(2616005)(7696005)(71200400001)(16526019)(1076003)(81156014)(26005)(81166006)(186003)(103116003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4591;H:SN6PR05MB4686.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XX+5qwSW6LN3JtLM/JFLFv9BZM6Ca7OzS1w3UX+bCOEDFy3phqrtV5aOKcMPrjCDofQPQseumTYhk5nOHkJM8DbH/sQyoFi/2iTtJHSxj2v3CdbeE1tAuHkIsw/BgzHds4WB/UKAppVME0SrQDj8k+LiVmibnizybf25ObVR50n1bBy3nsYfuaz78i7rUZViVKFTghQftDDTaPddcqqIPe5wW8gaWMWKxD3ODPwVFSMmiWQDEgN3u0WdIfEfEsJynk31QkY2FhvZIhEk3XYVkytWCYrsUXBSmRV551EQwgI5zvRG4Cc/8zgcLAg6trWDyuVs0hqoeGriXCqCJ390si8LjlN5uDRO5S+tHX/JFKSKSJkHjQILsrVWY7TLLeZHuFzYzocelFxSmau1qcx9jaEdkmHSc4deK34q+aDjLEBnEzyf9DaPhvy21s33zdHR
x-ms-exchange-antispam-messagedata: jk9JIcyH4m5TnzNuLv5sR3gKQnbBb2Iptd0dCquMu7yaZlJHOHworTumcJFVZmeUL1Md4+x1m0Jn/lk2iv7pRNKd3h8cjx1W8kTbzPo44poviCXmg3GyhjuZzqo2nwzmjnKwBvwqAcIw5mz9H70PWw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd5cb2b-a349-4e33-9f59-08d7a3163361
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCC68gBy0E+e/GDdhRJJf9MsczdzU+UQGM4WTZpYSHK0WHCUUKsMFT5Rvj3WyYjou1+llwjU5d24Kuh63VvVgswLjQ+5e1mdvZHybI/ubU7oD0GA2NhQajDsPA9ppbwtHkyypqO5SmCVtVRz1bnLsw==
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:39.3997
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4591
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Use MAJOR.MINOR format for QLink firmware protocol. MAJOR part is
incremented when backward compatibility is broken. Normally this
part should not be incremented unless there is a good reason for
that. MINOR part is incremented each time when new features are
added to qlink.h, e.g. new TLVs, events, commands. These changes
should not break backward compatibility. For instance, older
firmware versions may not be able to parse new flags or send new
types of events, but this does not impact normal system operations.

As part of initialization sequence, driver requests protocol version
from firmware and refuses to start in case there is a mismatch in MAJOR
part of the version.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 59 ++++++++++++++-----=
----
 drivers/net/wireless/quantenna/qtnfmac/core.c     | 16 +++---
 drivers/net/wireless/quantenna/qtnfmac/core.h     |  2 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 42 ++++++++++++++--
 4 files changed, 86 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index d0d7ec8794c4..4f52e2fd7f38 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -900,7 +900,6 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 	hwinfo->num_mac =3D resp->num_mac;
 	hwinfo->mac_bitmap =3D resp->mac_bitmap;
 	hwinfo->fw_ver =3D le32_to_cpu(resp->fw_ver);
-	hwinfo->ql_proto_ver =3D le16_to_cpu(resp->ql_proto_ver);
 	hwinfo->total_tx_chain =3D resp->total_tx_chain;
 	hwinfo->total_rx_chain =3D resp->total_rx_chain;
 	hwinfo->hw_capab =3D le32_to_cpu(resp->hw_capab);
@@ -954,25 +953,29 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
 	}
=20
-	pr_info("fw_version=3D%d, MACs map %#x, chains Tx=3D%u Rx=3D%u, capab=3D0=
x%x\n",
-		hwinfo->fw_ver, hwinfo->mac_bitmap,
-		hwinfo->total_tx_chain, hwinfo->total_rx_chain,
-		hwinfo->hw_capab);
-
-	pr_info("\nBuild name:            %s"  \
-		"\nBuild revision:        %s"  \
-		"\nBuild type:            %s"  \
-		"\nBuild label:           %s"  \
-		"\nBuild timestamp:       %lu" \
-		"\nPlatform ID:           %lu" \
-		"\nHardware ID:           %s"  \
-		"\nCalibration version:   %s"  \
-		"\nU-Boot version:        %s"  \
-		"\nHardware version:      0x%08x\n",
+	pr_info("\nBuild name:            %s\n"
+		"Build revision:        %s\n"
+		"Build type:            %s\n"
+		"Build label:           %s\n"
+		"Build timestamp:       %lu\n"
+		"Platform ID:           %lu\n"
+		"Hardware ID:           %s\n"
+		"Calibration version:   %s\n"
+		"U-Boot version:        %s\n"
+		"Hardware version:      0x%08x\n"
+		"Qlink ver:             %u.%u\n"
+		"MACs map:              %#x\n"
+		"Chains Rx-Tx:          %ux%u\n"
+		"FW version:            0x%x\n",
 		bld_name, bld_rev, bld_type, bld_label,
 		(unsigned long)bld_tmstamp,
 		(unsigned long)plat_id,
-		hw_id, calibration_ver, uboot_ver, hw_ver);
+		hw_id, calibration_ver, uboot_ver, hw_ver,
+		QLINK_VER_MAJOR(bus->hw_info.ql_proto_ver),
+		QLINK_VER_MINOR(bus->hw_info.ql_proto_ver),
+		hwinfo->mac_bitmap,
+		hwinfo->total_rx_chain, hwinfo->total_tx_chain,
+		hwinfo->fw_ver);
=20
 	strlcpy(hwinfo->fw_version, bld_label, sizeof(hwinfo->fw_version));
 	hwinfo->hw_version =3D hw_ver;
@@ -1866,23 +1869,35 @@ int qtnf_cmd_send_update_phy_params(struct qtnf_wma=
c *mac, u32 changed)
=20
 int qtnf_cmd_send_init_fw(struct qtnf_bus *bus)
 {
+	struct sk_buff *resp_skb =3D NULL;
+	struct qlink_resp_init_fw *resp;
+	struct qlink_cmd_init_fw *cmd;
 	struct sk_buff *cmd_skb;
-	int ret =3D 0;
+	size_t info_len =3D 0;
+	int ret;
=20
 	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(QLINK_MACID_RSVD, QLINK_VIFID_RSVD,
 					    QLINK_CMD_FW_INIT,
-					    sizeof(struct qlink_cmd));
+					    sizeof(*cmd));
 	if (!cmd_skb)
 		return -ENOMEM;
=20
+	cmd =3D (struct qlink_cmd_init_fw *)cmd_skb->data;
+	cmd->qlink_proto_ver =3D cpu_to_le32(QLINK_PROTO_VER);
+
 	qtnf_bus_lock(bus);
-	ret =3D qtnf_cmd_send(bus, cmd_skb);
+	ret =3D qtnf_cmd_send_with_reply(bus, cmd_skb, &resp_skb,
+				       sizeof(*resp), &info_len);
+	qtnf_bus_unlock(bus);
+
 	if (ret)
 		goto out;
=20
-out:
-	qtnf_bus_unlock(bus);
+	resp =3D (struct qlink_resp_init_fw *)resp_skb->data;
+	bus->hw_info.ql_proto_ver =3D le32_to_cpu(resp->qlink_proto_ver);
=20
+out:
+	consume_skb(resp_skb);
 	return ret;
 }
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 4320180f8c07..a21b09afd103 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -756,6 +756,15 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
=20
+	if (QLINK_VER_MAJOR(bus->hw_info.ql_proto_ver) !=3D
+	    QLINK_PROTO_VER_MAJOR) {
+		pr_err("qlink driver vs FW version mismatch: %u vs %u\n",
+		       QLINK_PROTO_VER_MAJOR,
+		       QLINK_VER_MAJOR(bus->hw_info.ql_proto_ver));
+		ret =3D -EPROTONOSUPPORT;
+		goto error;
+	}
+
 	bus->fw_state =3D QTNF_FW_STATE_ACTIVE;
 	ret =3D qtnf_cmd_get_hw_info(bus);
 	if (ret) {
@@ -763,13 +772,6 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
=20
-	if (bus->hw_info.ql_proto_ver !=3D QLINK_PROTO_VER) {
-		pr_err("qlink version mismatch %u !=3D %u\n",
-		       QLINK_PROTO_VER, bus->hw_info.ql_proto_ver);
-		ret =3D -EPROTONOSUPPORT;
-		goto error;
-	}
-
 	if ((bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) &&
 	    bus->bus_ops->data_tx_use_meta_set)
 		bus->bus_ops->data_tx_use_meta_set(bus, true);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index d715e1cd0006..78fee516cea4 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -117,7 +117,7 @@ struct qtnf_wmac {
 };
=20
 struct qtnf_hw_info {
-	u16 ql_proto_ver;
+	u32 ql_proto_ver;
 	u8 num_mac;
 	u8 mac_bitmap;
 	u32 fw_ver;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index b2edb03819d1..3722e707232c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -6,7 +6,18 @@
=20
 #include <linux/ieee80211.h>
=20
-#define QLINK_PROTO_VER		16
+#define QLINK_PROTO_VER_MAJOR_M		0xFFFF
+#define QLINK_PROTO_VER_MAJOR_S		16
+#define QLINK_PROTO_VER_MINOR_M		0xFFFF
+#define QLINK_VER_MINOR(_ver)	((_ver) & QLINK_PROTO_VER_MINOR_M)
+#define QLINK_VER_MAJOR(_ver)	\
+	(((_ver) >> QLINK_PROTO_VER_MAJOR_S) & QLINK_PROTO_VER_MAJOR_M)
+#define QLINK_VER(_maj, _min)	(((_maj) << QLINK_PROTO_VER_MAJOR_S) | (_min=
))
+
+#define QLINK_PROTO_VER_MAJOR		18
+#define QLINK_PROTO_VER_MINOR		0
+#define QLINK_PROTO_VER		\
+	QLINK_VER(QLINK_PROTO_VER_MAJOR, QLINK_PROTO_VER_MINOR)
=20
 #define QLINK_MACID_RSVD		0xFF
 #define QLINK_VIFID_RSVD		0xFF
@@ -327,6 +338,23 @@ struct qlink_cmd {
 } __packed;
=20
 /**
+ * struct qlink_cmd_init_fw - data for QLINK_CMD_FW_INIT
+ *
+ * Initialize firmware based on specified host configuration. This is the =
first
+ * command sent to wifi card and it's fixed part should never be changed, =
any
+ * additions must be done by appending TLVs.
+ * If wifi card can not operate with a specified parameters it will return
+ * error.
+ *
+ * @qlink_proto_ver: QLINK protocol version used by host driver.
+ */
+struct qlink_cmd_init_fw {
+	struct qlink_cmd chdr;
+	__le32 qlink_proto_ver;
+	u8 var_info[0];
+} __packed;
+
+/**
  * struct qlink_cmd_manage_intf - interface management command
  *
  * Data for interface management commands QLINK_CMD_ADD_INTF, QLINK_CMD_DE=
L_INTF
@@ -896,6 +924,16 @@ struct qlink_resp {
 } __packed;
=20
 /**
+ * struct qlink_resp_init_fw - response for QLINK_CMD_FW_INIT
+ *
+ * @qlink_proto_ver: QLINK protocol version used by wifi card firmware.
+ */
+struct qlink_resp_init_fw {
+	struct qlink_resp rhdr;
+	__le32 qlink_proto_ver;
+} __packed;
+
+/**
  * enum qlink_dfs_regions - regulatory DFS regions
  *
  * Corresponds to &enum nl80211_dfs_regions.
@@ -953,7 +991,6 @@ struct qlink_resp_get_mac_info {
  *
  * @fw_ver: wireless hardware firmware version.
  * @hw_capab: Bitmap of capabilities supported by firmware.
- * @ql_proto_ver: Version of QLINK protocol used by firmware.
  * @num_mac: Number of separate physical radio devices provided by hardwar=
e.
  * @mac_bitmap: Bitmap of MAC IDs that are active and can be used in firmw=
are.
  * @total_tx_chains: total number of transmit chains used by device.
@@ -967,7 +1004,6 @@ struct qlink_resp_get_hw_info {
 	__le32 bld_tmstamp;
 	__le32 plat_id;
 	__le32 hw_ver;
-	__le16 ql_proto_ver;
 	u8 num_mac;
 	u8 mac_bitmap;
 	u8 total_tx_chain;
--=20
2.11.0

