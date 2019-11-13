Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEFFAF54
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfKMLHm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:42 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:19398 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbfKMLHm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:42 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADB6RQt030927
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:41 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2051.outbound.protection.outlook.com [104.47.45.51])
        by mx0a-00183b01.pphosted.com with ESMTP id 2w7pt5mam6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8cysSSZyIWlqDYOP/hVur7e5hT84k7RL2sdaaqRHZIJmx5e8+PtN72ZcG9NbqmAW4jSJbNx8DGbBd38XB/yuLwc4E+BQBk1XTAKfq4sRi1QzSjEYzp6Bkfd5Pl3B2hugcIPSgvePylDnItj33h7uWutFnZi258NDCBrwLbVdAmmYlfvhe2FY/6KP0ufUTIF4o68xnT+BtiIxUVNBJo6LLaRQQ7jtZ8PUWct42lJBLVvSqflygNUHupeulVmBnNOhFz1hAVSITPEs2eAdJ7a04pRG4V1fOG39vYbp9C8RNwTy7/zBmsuI59mZsFHvWZMBaUZ2mG47x8Aw2HUhZPVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpRH9Iop/mqBTBgs14ttrJUEeW/T7y6sCPDM5hII+i4=;
 b=MuDzLgHs0nfNhRyE/zucV3xEOLX1wk/oHaFZWeNGvqRtJIOLBg3XkGrJsE0+rRkAqaI0/YAmQ3bJiM3JC5IwoZrHnao6L3w1UImB3EM34y8MfMBnJbBstlM4mXsbzM7NY7j6l69b63ikYGx0ZRHob2MvGUmAKud6m2zke8hGTUUGpR+v56uebRYW7e8VWSv8Nxibp0Fj/BdGGpI/zZGU3VytlDqa7NBTBuI7NHNUAjTLEM1+61U9Mg7APSLegdhP4ESUmx9VPcjuYmruu8xMtdXiJRwIpKIvnqtYr+EPVEHFQquDgU5oLMMf2jL+a2U/clHqEi1W14dn5/SbDGa/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpRH9Iop/mqBTBgs14ttrJUEeW/T7y6sCPDM5hII+i4=;
 b=LuDgeV/xDpmnR8IkzxRgUV1mej/dAKxTASyQ9Tztnr8BfAkTASAlAB14wSd7XFJch1kPZBg3yvXXtXXetN9EWkc0/VASZV0EZKrZXmiMnwaTEamoEek6Vf0HJjWyvlf5h2GxH/JAUxtLC+CX9gAqB7QpZYtRB+Wlj+k4GOHO3qw=
Received: from BYAPR05MB6039.namprd05.prod.outlook.com (20.178.54.92) by
 BYAPR05MB6677.namprd05.prod.outlook.com (20.178.234.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:07:39 +0000
Received: from BYAPR05MB6039.namprd05.prod.outlook.com
 ([fe80::9099:5295:2974:2a43]) by BYAPR05MB6039.namprd05.prod.outlook.com
 ([fe80::9099:5295:2974:2a43%3]) with mapi id 15.20.2474.007; Wed, 13 Nov 2019
 11:07:39 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5295.namprd05.prod.outlook.com (52.135.109.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:07:00 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:00 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 7/7] qtnfmac: add support for getting/setting transmit power
Thread-Topic: [PATCH 7/7] qtnfmac: add support for getting/setting transmit
 power
Thread-Index: AQHVmhJ4MFdQ+c8ksESvTPWTOD3mJQ==
Date:   Wed, 13 Nov 2019 11:06:59 +0000
Message-ID: <20191113110639.9226-8-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: d8e0aef9-0760-4404-963b-08d768299ac9
x-ms-traffictypediagnostic: SN6PR05MB5295:|BYAPR05MB6677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB52950F8AC74756E21A50F0C9A3760@SN6PR05MB5295.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:37 AM
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39850400004)(366004)(189003)(199004)(386003)(3846002)(99286004)(66446008)(6116002)(26005)(14454004)(66066001)(76176011)(6916009)(52116002)(66556008)(6506007)(64756008)(2906002)(305945005)(7736002)(2501003)(54906003)(316002)(86362001)(36756003)(436003)(5660300002)(5640700003)(107886003)(66946007)(6486002)(6436002)(6512007)(256004)(14444005)(8936002)(446003)(81166006)(2616005)(50226002)(486006)(2351001)(11346002)(8676002)(81156014)(476003)(1076003)(4326008)(478600001)(103116003)(186003)(71200400001)(25786009)(102836004)(66476007)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6677;H:BYAPR05MB6039.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tQKRHzuEh3p2nuSH3HhRiFsx+dALWAQ8aCYgBbwjbAiVzzC2vZQW2iWxHl6Cb4Ym/BYtEY5oVUFF/n5WBVs4SsmGUxaAAVrPulfJw3YoCT387fUCJ+v8F3g+FToOoN6S2mI6mRLcJC2gqZPpBFPYssxYo1m1IoCThHyTNreHvs2z944Wqidr0dlp+a1ZThUFKANXQJRggV+KD7KryV06du+t9ffteGphiV+iCXaxO1lwvCTvjQFDYoz9be8DucSbpzI0jFUU45+xx3BEl1GuLqdiiWpSTqgirNHK/QMYL53U8oaR9nmC3MYnxbn9FSUOY1XYW7KBc0+3jrL7EcIfMiqJ4iyEs+YNqLdmCfpgykXOSctRZLWnH7g5ev/eclbjUO4s+CGaOop8fL4Pur77mKV4JjRiac9XzGwtSN1W/LkZZkNireQDkI2JxIf1Fsmj
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e0aef9-0760-4404-963b-08d768299ac9
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RqqXRq/RZiGHwA7cUXnp5wzGYcx2f+8P0SGdyHlAGWJB3xskaDtVeGFpqMJpshclI4tUC295P3uDkHK2TKe0UTU0uJqhm0jIAgGfsrhOVXKqVT3soz8EWuQirz61SVuFD1xqzanplgQ2F/daxSEcoEZymnkqHEjD38vt0yJhd93BJSrhf9zF0n+SIj6VbWbSv2RtxZEUgCygTf2ECII3uHc4ogQ6mUHxU+UctC1C4aM=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:39.6390
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6677
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mikhail Karpenko <mkarpenko@quantenna.com>

Add new command for getting/setting current transmit power
and propagate requests from user space to firmware.

Signed-off-by: Mikhail Karpenko <mkarpenko@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 41 ++++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 65 +++++++++++++++++++=
++++
 drivers/net/wireless/quantenna/qtnfmac/commands.h |  3 ++
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 42 +++++++++++++++
 4 files changed, 151 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index d90016125dfc..aa0ed0f2b973 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -897,6 +897,45 @@ static int qtnf_set_power_mgmt(struct wiphy *wiphy, st=
ruct net_device *dev,
 	return ret;
 }
=20
+static int qtnf_get_tx_power(struct wiphy *wiphy, struct wireless_dev *wde=
v,
+			     int *dbm)
+{
+	struct qtnf_vif *vif =3D qtnf_netdev_get_priv(wdev->netdev);
+	int ret;
+
+	ret =3D qtnf_cmd_get_tx_power(vif, dbm);
+	if (ret)
+		pr_err("MAC%u: failed to get Tx power\n", vif->mac->macid);
+
+	return ret;
+}
+
+static int qtnf_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wde=
v,
+			     enum nl80211_tx_power_setting type, int mbm)
+{
+	struct qtnf_vif *vif;
+	int ret;
+
+	if (wdev) {
+		vif =3D qtnf_netdev_get_priv(wdev->netdev);
+	} else {
+		struct qtnf_wmac *mac =3D wiphy_priv(wiphy);
+
+		vif =3D qtnf_mac_get_base_vif(mac);
+		if (!vif) {
+			pr_err("MAC%u: primary VIF is not configured\n",
+			       mac->macid);
+			return -EFAULT;
+		}
+	}
+
+	ret =3D qtnf_cmd_set_tx_power(vif, type, mbm);
+	if (ret)
+		pr_err("MAC%u: failed to set Tx power\n", vif->mac->macid);
+
+	return ret;
+}
+
 #ifdef CONFIG_PM
 static int qtnf_suspend(struct wiphy *wiphy, struct cfg80211_wowlan *wowla=
n)
 {
@@ -991,6 +1030,8 @@ static struct cfg80211_ops qtn_cfg80211_ops =3D {
 	.start_radar_detection	=3D qtnf_start_radar_detection,
 	.set_mac_acl		=3D qtnf_set_mac_acl,
 	.set_power_mgmt		=3D qtnf_set_power_mgmt,
+	.get_tx_power		=3D qtnf_get_tx_power,
+	.set_tx_power		=3D qtnf_set_tx_power,
 #ifdef CONFIG_PM
 	.suspend		=3D qtnf_suspend,
 	.resume			=3D qtnf_resume,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index c0c32805fb8d..61bda34e2ac2 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2643,6 +2643,71 @@ int qtnf_cmd_send_pm_set(const struct qtnf_vif *vif,=
 u8 pm_mode, int timeout)
 	return ret;
 }
=20
+int qtnf_cmd_get_tx_power(const struct qtnf_vif *vif, int *dbm)
+{
+	struct qtnf_bus *bus =3D vif->mac->bus;
+	const struct qlink_resp_txpwr *resp;
+	struct sk_buff *resp_skb =3D NULL;
+	struct qlink_cmd_txpwr *cmd;
+	struct sk_buff *cmd_skb;
+	int ret =3D 0;
+
+	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
+					    QLINK_CMD_TXPWR, sizeof(*cmd));
+	if (!cmd_skb)
+		return -ENOMEM;
+
+	cmd =3D (struct qlink_cmd_txpwr *)cmd_skb->data;
+	cmd->op_type =3D QLINK_TXPWR_GET;
+
+	qtnf_bus_lock(bus);
+
+	ret =3D qtnf_cmd_send_with_reply(bus, cmd_skb, &resp_skb,
+				       sizeof(*resp), NULL);
+	if (ret)
+		goto out;
+
+	resp =3D (const struct qlink_resp_txpwr *)resp_skb->data;
+	*dbm =3D MBM_TO_DBM(le32_to_cpu(resp->txpwr));
+
+out:
+	qtnf_bus_unlock(bus);
+	consume_skb(resp_skb);
+
+	return ret;
+}
+
+int qtnf_cmd_set_tx_power(const struct qtnf_vif *vif,
+			  enum nl80211_tx_power_setting type, int mbm)
+{
+	struct qtnf_bus *bus =3D vif->mac->bus;
+	const struct qlink_resp_txpwr *resp;
+	struct sk_buff *resp_skb =3D NULL;
+	struct qlink_cmd_txpwr *cmd;
+	struct sk_buff *cmd_skb;
+	int ret =3D 0;
+
+	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
+					    QLINK_CMD_TXPWR, sizeof(*cmd));
+	if (!cmd_skb)
+		return -ENOMEM;
+
+	cmd =3D (struct qlink_cmd_txpwr *)cmd_skb->data;
+	cmd->op_type =3D QLINK_TXPWR_SET;
+	cmd->txpwr_setting =3D type;
+	cmd->txpwr =3D cpu_to_le32(mbm);
+
+	qtnf_bus_lock(bus);
+
+	ret =3D qtnf_cmd_send_with_reply(bus, cmd_skb, &resp_skb,
+				       sizeof(*resp), NULL);
+
+	qtnf_bus_unlock(bus);
+	consume_skb(resp_skb);
+
+	return ret;
+}
+
 int qtnf_cmd_send_wowlan_set(const struct qtnf_vif *vif,
 			     const struct cfg80211_wowlan *wowl)
 {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.h b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.h
index 88d7a3cd90d2..e0de65261213 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.h
@@ -70,6 +70,9 @@ int qtnf_cmd_start_cac(const struct qtnf_vif *vif,
 int qtnf_cmd_set_mac_acl(const struct qtnf_vif *vif,
 			 const struct cfg80211_acl_data *params);
 int qtnf_cmd_send_pm_set(const struct qtnf_vif *vif, u8 pm_mode, int timeo=
ut);
+int qtnf_cmd_get_tx_power(const struct qtnf_vif *vif, int *dbm);
+int qtnf_cmd_set_tx_power(const struct qtnf_vif *vif,
+			  enum nl80211_tx_power_setting type, int mbm);
 int qtnf_cmd_send_wowlan_set(const struct qtnf_vif *vif,
 			     const struct cfg80211_wowlan *wowl);
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index ac1ebe4bb580..59c69c0a6e06 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -217,6 +217,8 @@ struct qlink_sta_info_state {
  *	command is supported only if device reports QLINK_HW_SUPPORTS_REG_UPDAT=
E
  *	capability.
  * @QLINK_CMD_START_CAC: start radar detection procedure on a specified ch=
annel.
+ * @QLINK_CMD_TXPWR: get or set current channel transmit power for
+ *	the specified MAC.
  */
 enum qlink_cmd_type {
 	QLINK_CMD_FW_INIT		=3D 0x0001,
@@ -254,6 +256,7 @@ enum qlink_cmd_type {
 	QLINK_CMD_PM_SET		=3D 0x0062,
 	QLINK_CMD_WOWLAN_SET		=3D 0x0063,
 	QLINK_CMD_EXTERNAL_AUTH		=3D 0x0066,
+	QLINK_CMD_TXPWR			=3D 0x0067,
 };
=20
 /**
@@ -719,6 +722,32 @@ struct qlink_cmd_pm_set {
 } __packed;
=20
 /**
+ * enum qlink_txpwr_op - transmit power operation type
+ * @QLINK_TXPWR_SET: set tx power
+ * @QLINK_TXPWR_GET: get current tx power setting
+ */
+enum qlink_txpwr_op {
+	QLINK_TXPWR_SET,
+	QLINK_TXPWR_GET
+};
+
+/**
+ * struct qlink_cmd_txpwr - get or set current transmit power
+ *
+ * @txpwr: new transmit power setting, in mBm
+ * @txpwr_setting: transmit power setting type, one of
+ *	&enum nl80211_tx_power_setting
+ * @op_type: type of operation, one of &enum qlink_txpwr_op
+ */
+struct qlink_cmd_txpwr {
+	struct qlink_cmd chdr;
+	__le32 txpwr;
+	u8 txpwr_setting;
+	u8 op_type;
+	u8 rsvd[2];
+} __packed;
+
+/**
  * enum qlink_wowlan_trigger
  *
  * @QLINK_WOWLAN_TRIG_DISCONNECT: wakeup on disconnect
@@ -944,6 +973,19 @@ struct qlink_resp_channel_get {
 	struct qlink_chandef chan;
 } __packed;
=20
+/**
+ * struct qlink_resp_txpwr - response for QLINK_CMD_TXPWR command
+ *
+ * This response is intended for QLINK_TXPWR_GET operation and does not
+ * contain any meaningful information in case of QLINK_TXPWR_SET operation=
.
+ *
+ * @txpwr: current transmit power setting, in mBm
+ */
+struct qlink_resp_txpwr {
+	struct qlink_resp rhdr;
+	__le32 txpwr;
+} __packed;
+
 /* QLINK Events messages related definitions
  */
=20
--=20
2.11.0

