Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 031B614A23F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgA0Ks2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:48:28 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:31258 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726428AbgA0Ks1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:48:27 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAj2EA006182
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:26 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xrh3032d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISBqNd65ndI29uKjyO2n6UvtQ8SkA2i941Qi7OprcEY/v4k0AJmMfeV0czXpCO2Idmxi16W7d5dGbAfv8W8rbppk8lO6XXcUsg8K0O2XbZ5cw94P/0JHcoWP8dzACu+cK5hkI9/aOWeCicyENeMlggw3hI1LVfYeg8H6aMOKyOrlcRDlKVXDqV2Vh25uJp6Gn/073vtYk9A657mpFaFwlNxR5OpVKwxFHRhbH33OZp3PsbhlSXjLykP0QaDwYX2RU5uMMye5W0pzsgOVHfbLs7n+Ljh5hVAZYX9qt0wZ1RPop7tmucJKoRbsqq4TgravsooxSbKZfgzls7dy6NZM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV4Jd3neiwkvQntvpLJJ5bjawzqJGmw/YW99OPPXc8M=;
 b=gcJ7ZUqhgiH2LZgHyWurVI7dbHbisjp9cR5LauXA1tPtwD3is12tSQXAlpPdM/VeT414KRUWj5+OLKj+RBrd59Mu5SnIBb2KeFi+j1gC5iWL1flcyVqeBihAOpdZob4Id0UEW9bNS3REQXAg3OdwVhLOBvSQzcCl13ZMTTVJNPay/kLnqvIbf+X8l0JliJkHo99udv8QxTGrkfjULHijKMMLeDJNPIoUmDIKWSppO5xRSZ2ZO6yvA64PASoiugfswNYqvBD7zYE3hb+k5PJ5bBP72iKKBHIAchIJhOa+A6V2AVXwzCSBl4F9B3Ts+6WujO8fRMi7XR4ubl2cnDyjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV4Jd3neiwkvQntvpLJJ5bjawzqJGmw/YW99OPPXc8M=;
 b=cXnZMLxkjB9PxtIt9GthsOIjw8r0uWfdampnmATqXAg7NduH92fyDoQy/ybv+jUSq+nAlaWJMGbCi9JK/k4U82Z6wd031W7t2O8J08ADFTw3OdPDTX9/u7Js90uMBXnxpRL11Fv5o2QNyzkEznx+IRZaZShetcCodI4fdm2Ss5I=
Received: from DM6PR05MB5786.namprd05.prod.outlook.com (20.178.25.95) by
 DM6PR05MB6332.namprd05.prod.outlook.com (20.178.227.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.14; Mon, 27 Jan 2020 10:48:24 +0000
Received: from DM6PR05MB5786.namprd05.prod.outlook.com
 ([fe80::a186:bc44:281:5774]) by DM6PR05MB5786.namprd05.prod.outlook.com
 ([fe80::a186:bc44:281:5774%6]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:48:24 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:55 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:55 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:53 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 08/10] qtnfmac: update channel switch command to support 6GHz
 band
Thread-Topic: [PATCH 08/10] qtnfmac: update channel switch command to support
 6GHz band
Thread-Index: AQHV1P8Xw/Yd+jgnmE6Z2jOn5zs8Mw==
Date:   Mon, 27 Jan 2020 10:46:55 +0000
Message-ID: <20200127104634.7248-9-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 7bac7453-8e6f-4773-6358-08d7a31639a6
x-ms-traffictypediagnostic: SN6PR05MB5391:|DM6PR05MB6332:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391CC582EB3F8D274807728A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:48:20 AM
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(366004)(136003)(346002)(376002)(189003)(199004)(26005)(186003)(16526019)(956004)(2616005)(36756003)(86362001)(103116003)(66446008)(7696005)(2906002)(66946007)(66556008)(71200400001)(66476007)(64756008)(478600001)(52116002)(81156014)(316002)(4326008)(54906003)(8676002)(107886003)(81166006)(5660300002)(8936002)(15650500001)(6486002)(6916009)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB6332;H:DM6PR05MB5786.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCIx4P22Cy0yjq59exbO6XPYZtPJF7WgzUwHUekETcdY+ejkL2KZmo7nnLFpqV+nPrZOBaqHfc4eclukYPqQO87g/NBM5bDy1oC6XA0UWYxlLGq0DOAheOSv06oDZFX6p4VvECLB4ldFCQOJABBjMsoeuCvv/Gf4ws+GsfSVr+alcMC8BXJN6m47pCz+gQ5v3QFSDRJJ54eyWeCh25vd/OkAhciP0E3Q1nGF0/XCLA7vhfvdjZzBTtmNIu3Ebl+xMVrOAEv7ToLJrMVPfN6vIFQ11qgUZnllZkV4w4sF7pJPijIUWIdANBYlccw7IZstMNEYxG0X44h37xoeC6fyG80fHsSX87m+A82UeJFU1jDOAhnLJgMzeBikQUAM2m6jZ4cmCI64+ZineVfTjdiW2FxNXvvlGhvly7eXhx9APBPxSL/xi0jcLWf/94IstgAt
x-ms-exchange-antispam-messagedata: 0eE5ZEvaQmCoXW/XZ/bTaE1yM37pI8261ThIzs2C8xVtQBkmAdDt0v/+AharjKsbleTtJwberAzDM6mhC8l5VddLyaL6ibk6e8au/FiIcfsqHfOHu4ZkXTiy0uHjcMnhMX+Ai+kG9oiwD3PpffEmVQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bac7453-8e6f-4773-6358-08d7a31639a6
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ad3J3jbPcXD4QUPz9D0tT+Ula7V6y7RiWhf90Ho42NvQUiOXGxfUSb/iRUg1gXIugQoaRBif+LKHoBRs/kPkNvqq36lj/0RgZjm6FTswiE9zCFm3lG7MArv/X698F7KcCirnVQOU2IOSsE9qxHOKmdQqoa46OBcf+uvEC+snJ6Xd1IMK/ULJdTevYw2RcNnGGXMZ+tpfmLDGLlq60F3htA5LSTa5QhjDPgGe8wausL0=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:48:24.5152
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB6332
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 clxscore=1015 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

With an addition of 6GHz band support, channel number can no longer be
used to uniquely identify a specific channel. Modify channel switch
command to use chandef data.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 17 +++++++--------
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 25 +++++++++++++++++--=
----
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 1271d38e4c7a..31286699a5b7 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2519,6 +2519,7 @@ int qtnf_cmd_send_chan_switch(struct qtnf_vif *vif,
 	struct qlink_cmd_chan_switch *cmd;
 	struct sk_buff *cmd_skb;
 	int ret;
+	u64 flags =3D 0;
=20
 	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(mac->macid, vif->vifid,
 					    QLINK_CMD_CHAN_SWITCH,
@@ -2526,19 +2527,19 @@ int qtnf_cmd_send_chan_switch(struct qtnf_vif *vif,
 	if (!cmd_skb)
 		return -ENOMEM;
=20
-	qtnf_bus_lock(mac->bus);
+	if (params->radar_required)
+		flags |=3D QLINK_CHAN_SW_RADAR_REQUIRED;
+
+	if (params->block_tx)
+		flags |=3D QLINK_CHAN_SW_BLOCK_TX;
=20
 	cmd =3D (struct qlink_cmd_chan_switch *)cmd_skb->data;
-	cmd->channel =3D cpu_to_le16(params->chandef.chan->hw_value);
-	cmd->radar_required =3D params->radar_required;
-	cmd->block_tx =3D params->block_tx;
+	qlink_chandef_cfg2q(&params->chandef, &cmd->channel);
+	cmd->flags =3D cpu_to_le64(flags);
 	cmd->beacon_count =3D params->count;
=20
+	qtnf_bus_lock(mac->bus);
 	ret =3D qtnf_cmd_send(mac->bus, cmd_skb);
-	if (ret)
-		goto out;
-
-out:
 	qtnf_bus_unlock(mac->bus);
=20
 	return ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 3577482c5076..ab2bfae7ff3e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -701,18 +701,31 @@ struct qlink_cmd_reg_notify {
 } __packed;
=20
 /**
+ * enum qlink_chan_sw_flags - channel switch control flags
+ *
+ * @QLINK_CHAN_SW_RADAR_REQUIRED: whether radar detection is required on a=
 new
+ *	channel.
+ * @QLINK_CHAN_SW_BLOCK_TX: whether transmissions should be blocked while
+ *	changing a channel.
+ */
+enum qlink_chan_sw_flags {
+	QLINK_CHAN_SW_RADAR_REQUIRED =3D BIT(0),
+	QLINK_CHAN_SW_BLOCK_TX =3D BIT(1),
+};
+
+/**
  * struct qlink_cmd_chan_switch - data for QLINK_CMD_CHAN_SWITCH command
  *
- * @channel: channel number according to 802.11 17.3.8.3.2 and Annex J
- * @radar_required: whether radar detection is required on the new channel
- * @block_tx: whether transmissions should be blocked while changing
+ * @channel: channel to switch to.
+ * @flags: flags to control channel switch, bitmap of &enum qlink_chan_sw_=
flags.
  * @beacon_count: number of beacons until switch
  */
 struct qlink_cmd_chan_switch {
 	struct qlink_cmd chdr;
-	__le16 channel;
-	u8 radar_required;
-	u8 block_tx;
+	struct qlink_chandef channel;
+	__le64 flags;
+	__le32 n_counter_offsets_beacon;
+	__le32 n_counter_offsets_presp;
 	u8 beacon_count;
 	u8 rsvd[3];
 } __packed;
--=20
2.11.0

