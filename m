Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9297514A236
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgA0Krm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:42 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:19204 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725908AbgA0Krl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:41 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAleLb020795
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:40 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xrkfeb1py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY8dvJ8G0WiCAocsZjaVjw9bdmL/aknX7dmZPGzb1+Kg4uwJhIdQnJweRSlFbXW4BJdZ0097RDPx00ulRKVZQBTUOfKp9cQquVDUtSKZIMBY8ktMDgxttb6NwcPEEOz/cN2HVlVcWYE2JrtFIiArOpQ4vjf1RrSOdUfjJd8cPJ9vyooiPJdI64FyA5wUjMVijEcQVXGqFoeUn6v/bJLwOfY6d36ThpMTbLHfALFWtmlgPJs2er+0Fg12NvvmDga83wve3R39NAyARRrlnECvcbG3+Ke3Cx4QRiFphLD/Smiamx4+RQz1QkaIeS10VWH5X3tU2hu956+AdwhLkzoprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezbg2osE3wpisdnAKPIbdCbRvS5nxajRxyQAjrWLFMQ=;
 b=mJVtAmpMwhkeMdYLuvAGuAsFndgHF/9UxkvETF5QXkSIaEVdJ9qI2avHk9Tcl2zDYU+XaDnjsDUYMrUJ8pr4bZZlUHIX9UcoNyP3YqBUkmHv5SkcVb3CRhJ3YXC/jX8gGID5KQrHe78KNEk1ByTZBxR6/g4s7U8fw2HhMcXXeax3aRKYrhufNQNegwAzKrKtztLRWNgC8Yu+fTLWF5/QGlkvH8oeGsGA3pjyzCGeRSapiW6SQMi8RxMtaDqh4xnRd4NyQpN/McnbG8lIRa9Wdov5sz3kD9GJ+KIfdS6fp9nHyJLPQPzrRGj7uOI2+kbOM8QSa5701tsoLPDTKinWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezbg2osE3wpisdnAKPIbdCbRvS5nxajRxyQAjrWLFMQ=;
 b=OsLyNm1SPlig2btI7NyttFhl3tMq9PLoHMyOFCP0SyVY1N2awiIANsNQKu416qozmrbGQtCBAOF67Rd8shc11a8lL/wFIoT+fHkQ1/Bah+tv+3VmleStDHIlRdBHjbSJHDIjfJnmlEBV+VP5MQ25UbDY+AYekvQdFFSzyGXUOQg=
Received: from BYAPR05MB4984.namprd05.prod.outlook.com (20.177.230.202) by
 BYAPR05MB5653.namprd05.prod.outlook.com (20.177.186.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 10:47:38 +0000
Received: from BYAPR05MB4984.namprd05.prod.outlook.com
 ([fe80::7d5a:bc67:c985:d410]) by BYAPR05MB4984.namprd05.prod.outlook.com
 ([fe80::7d5a:bc67:c985:d410%7]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:38 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:46 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:46 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:44 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 02/10] qtnfmac: pass hardware capabilities in TLV element
Thread-Topic: [PATCH 02/10] qtnfmac: pass hardware capabilities in TLV element
Thread-Index: AQHV1P8Sg5lNb32wwEa1gIEtZSFKMg==
Date:   Mon, 27 Jan 2020 10:46:46 +0000
Message-ID: <20200127104634.7248-3-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 29300581-4c79-44ac-637e-08d7a316344d
x-ms-traffictypediagnostic: SN6PR05MB5391:|BYAPR05MB5653:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB539129E0B5E9C1D3630C2EEAA30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:35 AM
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(66946007)(66476007)(66556008)(64756008)(30864003)(54906003)(107886003)(86362001)(6486002)(66446008)(6916009)(103116003)(36756003)(2906002)(316002)(26005)(8676002)(81166006)(81156014)(8936002)(2616005)(71200400001)(7696005)(4326008)(5660300002)(956004)(1076003)(186003)(16526019)(52116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5653;H:BYAPR05MB4984.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N660Cd6k6ZgqFz5QeNBGileMhp1+3r/1LcLZwlf6v75e9KildXtoWsuAfW+VUhgz92/u+hvHjT4X3bjx8F09bPsUWU4kPg2mlPcnd73D4HvIoPKPua+e0DGkZbaHKM89FK8LWVCL3zJfuzN72LSpG7cyXUWLRKS1u6liPO6oyQzlG9PHNLx2pA6hunbFw3acNubIngFOETgrmLkm91LLh4EahZ8za/0Imh5jzIMVNkuCOEyDvC92v66Mx5LC5QvqToaKjPROlTotONLZ49cp9VOaS/fso39cy72M3PrnF1FrWyMKg81ZR3SrJRWUZCj/BSkQTysqThqbjjsulvGn2PPCBHteaGhpaTG/pfuIycmhj9rKD9LR4hHHg1G/4K3Dr9sQHlFFBCXJZ+gxqj6PQ86z+OVZd5+WNlTovvJJXwoykJu+vxn1KwMqNJEPyqKd
x-ms-exchange-antispam-messagedata: 9pkLeWBe27KOWM2HnJvlRforlSRmggN0rpzV1abXYJIArCGMfPFUJvjmmt/JDqIziySaqSxkVSU0Wut8qN803wBcN+DHwYY/+N/K9c/XTXUWEkIe8eQXMWVmH0Mpq83MIiWOBnCgznGKHx6+WXKuMA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29300581-4c79-44ac-637e-08d7a316344d
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5K9IlrOc0ALoaub9HSq0GSNcPfpm/GB77oMDUPmufdEpa6YpKJSnxvPRx+GxH6tayvCW4NW7Fh3tn9puLS9tW3mmypkl8suwDOxf73pQ11C/j62a95LwNQU3U0yiRWumaVsyI8Jbw0aOkP58Z9jAarwTKiddd8t3FSSkD3wirK4G7wOu5wWLB+vVarI/0EHGanptZQm9Ea7ec6YvmG0Zr2XuTh66ntx99KXlUbBNmhE=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:38.3986
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5653
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

To support any number of capabilities bits in the future,
replace u32 capabilities bitmask by array. Pass
capabilities from firmware using TLV element.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 20 +++++-----
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 19 ++++++----
 drivers/net/wireless/quantenna/qtnfmac/core.c     |  9 +++--
 drivers/net/wireless/quantenna/qtnfmac/core.h     | 10 ++++-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 45 ++++++++++++++-----=
----
 5 files changed, 63 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index 8849faa5bc10..bc7ed8f4a813 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -248,7 +248,7 @@ static struct wireless_dev *qtnf_add_virtual_intf(struc=
t wiphy *wiphy,
 		goto error_del_vif;
 	}
=20
-	if (mac->bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
+	if (qtnf_hwcap_is_set(&mac->bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE)) {
 		ret =3D qtnf_cmd_netdev_changeupper(vif, vif->netdev->ifindex);
 		if (ret) {
 			unregister_netdevice(vif->netdev);
@@ -1080,10 +1080,10 @@ struct wiphy *qtnf_wiphy_allocate(struct qtnf_bus *=
bus)
 	struct wiphy *wiphy;
=20
 	if (qtnf_dfs_offload_get() &&
-	    (bus->hw_info.hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD))
+	    qtnf_hwcap_is_set(&bus->hw_info, QLINK_HW_CAPAB_DFS_OFFLOAD))
 		qtn_cfg80211_ops.start_radar_detection =3D NULL;
=20
-	if (!(bus->hw_info.hw_capab & QLINK_HW_CAPAB_PWR_MGMT))
+	if (!qtnf_hwcap_is_set(&bus->hw_info, QLINK_HW_CAPAB_PWR_MGMT))
 		qtn_cfg80211_ops.set_power_mgmt	=3D NULL;
=20
 	wiphy =3D wiphy_new(&qtn_cfg80211_ops, sizeof(struct qtnf_wmac));
@@ -1166,10 +1166,10 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_inf=
o, struct qtnf_wmac *mac)
 	wiphy->flags &=3D ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
=20
 	if (qtnf_dfs_offload_get() &&
-	    (hw_info->hw_capab & QLINK_HW_CAPAB_DFS_OFFLOAD))
+	    qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_DFS_OFFLOAD))
 		wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_DFS_OFFLOAD);
=20
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_SCAN_DWELL)
+	if (qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_SCAN_DWELL))
 		wiphy_ext_feature_set(wiphy,
 				      NL80211_EXT_FEATURE_SET_SCAN_DWELL);
=20
@@ -1185,16 +1185,16 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_inf=
o, struct qtnf_wmac *mac)
=20
 	ether_addr_copy(wiphy->perm_addr, mac->macaddr);
=20
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_STA_INACT_TIMEOUT)
+	if (qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_STA_INACT_TIMEOUT))
 		wiphy->features |=3D NL80211_FEATURE_INACTIVITY_TIMER;
=20
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_SCAN_RANDOM_MAC_ADDR)
+	if (qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_SCAN_RANDOM_MAC_ADDR))
 		wiphy->features |=3D NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
=20
-	if (!(hw_info->hw_capab & QLINK_HW_CAPAB_OBSS_SCAN))
+	if (!qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_OBSS_SCAN))
 		wiphy->features |=3D NL80211_FEATURE_NEED_OBSS_SCAN;
=20
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_SAE)
+	if (qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_SAE))
 		wiphy->features |=3D NL80211_FEATURE_SAE;
=20
 #ifdef CONFIG_PM
@@ -1205,7 +1205,7 @@ int qtnf_wiphy_register(struct qtnf_hw_info *hw_info,=
 struct qtnf_wmac *mac)
 	regdomain_is_known =3D isalpha(mac->rd->alpha2[0]) &&
 				isalpha(mac->rd->alpha2[1]);
=20
-	if (hw_info->hw_capab & QLINK_HW_CAPAB_REG_UPDATE) {
+	if (qtnf_hwcap_is_set(hw_info, QLINK_HW_CAPAB_REG_UPDATE)) {
 		wiphy->reg_notifier =3D qtnf_cfg80211_reg_notifier;
=20
 		if (mac->rd->alpha2[0] =3D=3D '9' && mac->rd->alpha2[1] =3D=3D '9') {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 4f52e2fd7f38..4d494732b2d2 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -599,7 +599,7 @@ qtnf_cmd_sta_info_parse(struct station_info *sinfo,
 		tlv_len =3D le16_to_cpu(tlv->len);
=20
 		switch (le16_to_cpu(tlv->type)) {
-		case QTN_TLV_ID_STA_STATS_MAP:
+		case QTN_TLV_ID_BITMAP:
 			map_len =3D tlv_len;
 			map =3D tlv->val;
 			break;
@@ -895,14 +895,13 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 	const char *uboot_ver =3D NULL;
 	u32 hw_ver =3D 0;
 	u16 tlv_type;
-	u16 tlv_value_len;
+	u16 tlv_len;
=20
 	hwinfo->num_mac =3D resp->num_mac;
 	hwinfo->mac_bitmap =3D resp->mac_bitmap;
 	hwinfo->fw_ver =3D le32_to_cpu(resp->fw_ver);
 	hwinfo->total_tx_chain =3D resp->total_tx_chain;
 	hwinfo->total_rx_chain =3D resp->total_rx_chain;
-	hwinfo->hw_capab =3D le32_to_cpu(resp->hw_capab);
=20
 	bld_tmstamp =3D le32_to_cpu(resp->bld_tmstamp);
 	plat_id =3D le32_to_cpu(resp->plat_id);
@@ -912,11 +911,11 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
=20
 	while (info_len >=3D sizeof(*tlv)) {
 		tlv_type =3D le16_to_cpu(tlv->type);
-		tlv_value_len =3D le16_to_cpu(tlv->len);
+		tlv_len =3D le16_to_cpu(tlv->len);
=20
-		if (tlv_value_len + sizeof(*tlv) > info_len) {
+		if (tlv_len + sizeof(*tlv) > info_len) {
 			pr_warn("malformed TLV 0x%.2X; LEN: %u\n",
-				tlv_type, tlv_value_len);
+				tlv_type, tlv_len);
 			return -EINVAL;
 		}
=20
@@ -945,12 +944,16 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 		case QTN_TLV_ID_MAX_SCAN_SSIDS:
 			hwinfo->max_scan_ssids =3D *tlv->val;
 			break;
+		case QTN_TLV_ID_BITMAP:
+			memcpy(hwinfo->hw_capab, tlv->val,
+			       min(sizeof(hwinfo->hw_capab), (size_t)tlv_len));
+			break;
 		default:
 			break;
 		}
=20
-		info_len -=3D tlv_value_len + sizeof(*tlv);
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
+		info_len -=3D tlv_len + sizeof(*tlv);
+		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_len);
 	}
=20
 	pr_info("\nBuild name:            %s\n"
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index a21b09afd103..853429de57c9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -497,7 +497,7 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *vif,
 	dev->tx_queue_len =3D 100;
 	dev->ethtool_ops =3D &qtnf_ethtool_ops;
=20
-	if (mac->bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE)
+	if (qtnf_hwcap_is_set(&mac->bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE))
 		dev->needed_tailroom =3D sizeof(struct qtnf_frame_meta_info);
=20
 	qdev_vif =3D netdev_priv(dev);
@@ -639,7 +639,7 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, u=
nsigned int macid)
 		goto error_del_vif;
 	}
=20
-	if (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) {
+	if (qtnf_hwcap_is_set(&bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE)) {
 		ret =3D qtnf_cmd_netdev_changeupper(vif, vif->netdev->ifindex);
 		if (ret)
 			goto error;
@@ -705,7 +705,8 @@ static int qtnf_core_netdevice_event(struct notifier_bl=
ock *nb,
 			 info->linking ? "add" : "del");
=20
 		if (IS_ENABLED(CONFIG_NET_SWITCHDEV) &&
-		    (bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE)) {
+		    qtnf_hwcap_is_set(&bus->hw_info,
+				      QLINK_HW_CAPAB_HW_BRIDGE)) {
 			if (info->linking)
 				br_domain =3D brdev->ifindex;
 			else
@@ -772,7 +773,7 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
=20
-	if ((bus->hw_info.hw_capab & QLINK_HW_CAPAB_HW_BRIDGE) &&
+	if (qtnf_hwcap_is_set(&bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE) &&
 	    bus->bus_ops->data_tx_use_meta_set)
 		bus->bus_ops->data_tx_use_meta_set(bus, true);
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index 78fee516cea4..cdefe24c2f27 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -23,6 +23,7 @@
=20
 #include "qlink.h"
 #include "trans.h"
+#include "qlink_util.h"
=20
 #undef pr_fmt
 #define pr_fmt(fmt)	KBUILD_MODNAME ": %s: " fmt, __func__
@@ -121,12 +122,12 @@ struct qtnf_hw_info {
 	u8 num_mac;
 	u8 mac_bitmap;
 	u32 fw_ver;
-	u32 hw_capab;
 	u8 total_tx_chain;
 	u8 total_rx_chain;
 	char fw_version[ETHTOOL_FWVERS_LEN];
 	u32 hw_version;
 	u8 max_scan_ssids;
+	u8 hw_capab[QLINK_HW_CAPAB_NUM / BITS_PER_BYTE + 1];
 };
=20
 struct qtnf_vif *qtnf_mac_get_free_vif(struct qtnf_wmac *mac);
@@ -160,4 +161,11 @@ static inline struct qtnf_vif *qtnf_netdev_get_priv(st=
ruct net_device *dev)
 	return *((void **)netdev_priv(dev));
 }
=20
+static inline bool qtnf_hwcap_is_set(const struct qtnf_hw_info *info,
+				     unsigned int bit)
+{
+	return qtnf_utils_is_bit_set(info->hw_capab, bit,
+				     sizeof(info->hw_capab));
+}
+
 #endif /* _QTN_FMAC_CORE_H_ */
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 3722e707232c..20b9e90e377c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -73,15 +73,24 @@ struct qlink_msg_header {
  * @QLINK_HW_CAPAB_HW_BRIDGE: device has hardware switch capabilities.
  */
 enum qlink_hw_capab {
-	QLINK_HW_CAPAB_REG_UPDATE		=3D BIT(0),
-	QLINK_HW_CAPAB_STA_INACT_TIMEOUT	=3D BIT(1),
-	QLINK_HW_CAPAB_DFS_OFFLOAD		=3D BIT(2),
-	QLINK_HW_CAPAB_SCAN_RANDOM_MAC_ADDR	=3D BIT(3),
-	QLINK_HW_CAPAB_PWR_MGMT			=3D BIT(4),
-	QLINK_HW_CAPAB_OBSS_SCAN		=3D BIT(5),
-	QLINK_HW_CAPAB_SCAN_DWELL		=3D BIT(6),
-	QLINK_HW_CAPAB_SAE			=3D BIT(8),
-	QLINK_HW_CAPAB_HW_BRIDGE		=3D BIT(9),
+	QLINK_HW_CAPAB_REG_UPDATE =3D 0,
+	QLINK_HW_CAPAB_STA_INACT_TIMEOUT,
+	QLINK_HW_CAPAB_DFS_OFFLOAD,
+	QLINK_HW_CAPAB_SCAN_RANDOM_MAC_ADDR,
+	QLINK_HW_CAPAB_PWR_MGMT,
+	QLINK_HW_CAPAB_OBSS_SCAN,
+	QLINK_HW_CAPAB_SCAN_DWELL,
+	QLINK_HW_CAPAB_SAE,
+	QLINK_HW_CAPAB_HW_BRIDGE,
+	QLINK_HW_CAPAB_NUM
+};
+
+/**
+ * enum qlink_driver_capab - host driver capabilities.
+ *
+ */
+enum qlink_driver_capab {
+	QLINK_DRV_CAPAB_NUM =3D 0
 };
=20
 enum qlink_iface_type {
@@ -990,7 +999,6 @@ struct qlink_resp_get_mac_info {
  * Description of wireless hardware capabilities and features.
  *
  * @fw_ver: wireless hardware firmware version.
- * @hw_capab: Bitmap of capabilities supported by firmware.
  * @num_mac: Number of separate physical radio devices provided by hardwar=
e.
  * @mac_bitmap: Bitmap of MAC IDs that are active and can be used in firmw=
are.
  * @total_tx_chains: total number of transmit chains used by device.
@@ -1000,7 +1008,6 @@ struct qlink_resp_get_mac_info {
 struct qlink_resp_get_hw_info {
 	struct qlink_resp rhdr;
 	__le32 fw_ver;
-	__le32 hw_capab;
 	__le32 bld_tmstamp;
 	__le32 plat_id;
 	__le32 hw_ver;
@@ -1337,11 +1344,15 @@ struct qlink_event_mic_failure {
 /**
  * enum qlink_tlv_id - list of TLVs that Qlink messages can carry
  *
- * @QTN_TLV_ID_STA_STATS_MAP: a bitmap of &enum qlink_sta_info, used to
- *	indicate which statistic carried in QTN_TLV_ID_STA_STATS is valid.
+ * @QTN_TLV_ID_BITMAP: a data representing a bitmap that is used together =
with
+ *	other TLVs:
+ *	&enum qlink_sta_info used to indicate which statistic carried in
+ *	QTN_TLV_ID_STA_STATS is valid.
+ *	&enum qlink_hw_capab listing wireless card capabilities.
+ *	&enum qlink_driver_capab listing driver/host system capabilities.
  * @QTN_TLV_ID_STA_STATS: per-STA statistics as defined by
  *	&struct qlink_sta_stats. Valid values are marked as such in a bitmap
- *	carried by QTN_TLV_ID_STA_STATS_MAP.
+ *	carried by QTN_TLV_ID_BITMAP.
  * @QTN_TLV_ID_MAX_SCAN_SSIDS: maximum number of SSIDs the device can scan
  *	for in any given scan.
  * @QTN_TLV_ID_SCAN_DWELL_ACTIVE: time spent on a single channel for an ac=
tive
@@ -1361,7 +1372,7 @@ enum qlink_tlv_id {
 	QTN_TLV_ID_REG_RULE		=3D 0x0207,
 	QTN_TLV_ID_CHANNEL		=3D 0x020F,
 	QTN_TLV_ID_CHANDEF		=3D 0x0210,
-	QTN_TLV_ID_STA_STATS_MAP	=3D 0x0211,
+	QTN_TLV_ID_BITMAP		=3D 0x0211,
 	QTN_TLV_ID_STA_STATS		=3D 0x0212,
 	QTN_TLV_ID_COVERAGE_CLASS	=3D 0x0213,
 	QTN_TLV_ID_IFACE_LIMIT		=3D 0x0214,
@@ -1596,7 +1607,7 @@ struct qlink_chan_stats {
  *
  * Used to indicate which statistics values in &struct qlink_sta_stats
  * are valid. Individual values are used to fill a bitmap carried in a
- * payload of QTN_TLV_ID_STA_STATS_MAP.
+ * payload of QTN_TLV_ID_BITMAP.
  *
  * @QLINK_STA_INFO_CONNECTED_TIME: connected_time value is valid.
  * @QLINK_STA_INFO_INACTIVE_TIME: inactive_time value is valid.
@@ -1660,7 +1671,7 @@ struct qlink_sta_info_rate {
  * Carries statistics of a STA. Not all fields may be filled with
  * valid values. Valid fields should be indicated as such using a bitmap o=
f
  * &enum qlink_sta_info. Bitmap is carried separately in a payload of
- * QTN_TLV_ID_STA_STATS_MAP.
+ * QTN_TLV_ID_BITMAP.
  */
 struct qlink_sta_stats {
 	__le64 rx_bytes;
--=20
2.11.0

