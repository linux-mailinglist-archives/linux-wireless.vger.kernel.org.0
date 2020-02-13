Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A260015BDF5
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgBMLqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:46:09 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:60652 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729511AbgBMLqJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:46:09 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBh9lZ010055
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:08 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00183b01.pphosted.com with ESMTP id 2y1ufxerh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7vLqPIC6ODoGKvNusuH0ugosEguvcK7oRkXgdJJvow7GrTlQC8xRZQM+KHVLIFoCxSz+z9aFtSUO1P0H0j9rtOpp5Qtg0Z0HHSvP0P9DNfo+SLXlgYHfjndTyNDvhJ/yQ85zgaxTbtmzNkBGwORMOCMoTlZcAHH+9jhjUQW+o3frFI5NTVK9WkcNMEpbru437Mo5T22DOjKTpa1QIiZBnhyiZsPtGt42uQxNLL8paL3Yn1QFY2sHLXLNhlKzt9SyTq8kJyrPE5OBrTsOUYo4T3iCOBc/VT3KyecfjSRCk0iJGWQGaTN72aJrKxpj4aFgMNDXFfsnW94v/CEgUcgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5blg9/oW9eT7WvvePOqZm6F5uKC6acr5xwktSAq2KSw=;
 b=lW7DJeqCoRrjyd2Djd1W1aCa+hNmg5rLiGZR+q8d1mwHc346/YdYrqexCWf36+j7X8pwteBdKjtJYCVLqMWs9kJsoE5lo9/2TLFvw8qZc7Vqku0uK5Y7wdrBjuxBLSm8VacOJX4xwsM62RZ+AMG43mOSwWd6fWSBFUh8C2ojbdockmNWbGNYV6CbqMm+WlSL99hXZKsxMKVIJm9cl1p3yqNQA0pbHaP0oDQQ7mvNBWeLE1LQY39ofQDegcQMenaQz8IGVr1FNgtPWQkorsuexs66bAFx60730EHHFoZrT/sp31mkToEC/t8BpP4IVpd7uQOlwl72FhFEMSlQb5IMPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5blg9/oW9eT7WvvePOqZm6F5uKC6acr5xwktSAq2KSw=;
 b=OO2PGvYTtb4S74q90Z1Pnn/lgB+ajp7xFFdpEFBHS5srCnL6vWUX2qcQ8bka7QSyZWzQgtV2D+Lwey3g2XwTIlRc5RR+JCG+d52p6Ea4BRU80CcM10Er3mjy3Lz82vdIW7eqQFccXeBYaW3n4PApLQP010cxk+/oe5nXpmP2bzs=
Received: from CY4PR0501MB3779.namprd05.prod.outlook.com (52.132.101.18) by
 CY4PR0501MB3841.namprd05.prod.outlook.com (52.132.100.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.14; Thu, 13 Feb 2020 11:46:05 +0000
Received: from CY4PR0501MB3779.namprd05.prod.outlook.com
 ([fe80::11cd:7387:5fdc:2f7a]) by CY4PR0501MB3779.namprd05.prod.outlook.com
 ([fe80::11cd:7387:5fdc:2f7a%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:46:05 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:29 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:29 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:28 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/5] qtnfmac: support WPA3 OWE in AP mode
Thread-Topic: [PATCH 2/5] qtnfmac: support WPA3 OWE in AP mode
Thread-Index: AQHV4mMWiyW5CBbo+EifJhfDrmMz+A==
Date:   Thu, 13 Feb 2020 11:45:29 +0000
Message-ID: <20200213114518.4415-3-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0129.eurprd05.prod.outlook.com
 (2603:10a6:7:28::16) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb0ba5c-1733-4058-fd2d-08d7b07a3956
x-ms-traffictypediagnostic: SN6PR05MB5597:|CY4PR0501MB3841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5597C645F6A726F8DDB0DD90A31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:46:01 AM
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39850400004)(366004)(189003)(199004)(52116002)(7696005)(26005)(71200400001)(186003)(16526019)(81156014)(478600001)(36756003)(86362001)(6486002)(316002)(4326008)(2906002)(81166006)(8676002)(66476007)(107886003)(103116003)(956004)(2616005)(5660300002)(1076003)(66946007)(6916009)(64756008)(66556008)(8936002)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0501MB3841;H:CY4PR0501MB3779.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:3;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwAe0q2LvcDPm6BjLr9MT6SMufSyngjCMHDwF810tqSoKMzcBrZFOHbYlLbaBuvX07u/PBG3UtCpQRUgg2dcfxEGpQiTPB0ENj+a/YZ5fg/N18C86ApMOvINxFLmx50B26WOc4Oz3HoGs5CzvPYMivJgzyn6hTr2Lrog8Io0yg/pgzgx/N1iQUdjkIktBScR1REib07TEbTJmZ6wWVVrnB/YC2Lrigt+6KXYdHaFVwNUxz2ZmwHmu3/U5yg9PsGXpSl+dI4LLdNiGkjeYLZcy2F3kq8bUr3wi/5nAlCE41Ody/tpcGKn9w6Ny0S8GqZLBsit3moDn5vY09r2yfqaxd93JUm6me4ZGoa/1UH7gM7xipalf88om3gz3fAuBL6PkZ5LeYUL8VJ0oRtMQ2hhmHhkNbWlnD4q/eS7vdblymFghKDB2wKzFh8x9judAHdk
x-ms-exchange-antispam-messagedata: fVGNPAnDY6TydYdEHDRfFjpvXiy7MbKN2ywrQFeYlsMSEpknyRyuESwCmFTzyXNvzcxUrx9HjVTRPLst8xOmix2RicIK3GTqWvG9gH08GtjNtFOEwoLy14P6yE65db57w+fCgzBOAnqm2XPtTmR18Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0ba5c-1733-4058-fd2d-08d7b07a3956
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsWuO0GcOrBBe75xp+TAnmjr05vpYQmrEXKN0O8yjC3nP60YXL5foXuvjNbZyyJI+u+Ok6E7tsupwj+nU8fRDEAvOYdrtKrZPKK+AT8EJIzqbezrA/GNL0HzOoWva4V0YQ53hWfjPfg22VUyzs1tRQwkDILMu0B0UJ31Tkxezi+ciUqtyvExYN3hxF1TQBnCXGDWweNiSFmW1eZGxmCJmMR1QYjY356ggIR4BCxindk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:46:05.2666
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0501MB3841
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable WPA3 OWE support in AP mode. Driver currently supports cards that
offload OWE processing to userspace. This patch adds all the required
tools for such offloading. Firmware requests OWE processing sending new
UPDATE_OWE event to driver, which uses cfg80211_update_owe_info_event to
notify userspace software. After OWE processing is completed, userspace
sends calculated IEs to firmware using update_owe_info cfg80211 callback.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 21 ++++++++++
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 36 +++++++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/commands.h |  2 +
 drivers/net/wireless/quantenna/qtnfmac/event.c    | 48 +++++++++++++++++++=
++++
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    | 31 ++++++++++++++-
 5 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index a5ab1270add1..722d5caefe3c 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -908,6 +908,26 @@ static int qtnf_set_tx_power(struct wiphy *wiphy, stru=
ct wireless_dev *wdev,
 	return ret;
 }
=20
+static int qtnf_update_owe_info(struct wiphy *wiphy, struct net_device *de=
v,
+				struct cfg80211_update_owe_info *owe_info)
+{
+	struct qtnf_vif *vif =3D qtnf_netdev_get_priv(dev);
+	int ret;
+
+	if (vif->wdev.iftype !=3D NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	ret =3D qtnf_cmd_send_update_owe(vif, owe_info);
+	if (ret) {
+		pr_err("VIF%u.%u: failed to update owe info\n",
+		       vif->mac->macid, vif->vifid);
+		goto out;
+	}
+
+out:
+	return ret;
+}
+
 #ifdef CONFIG_PM
 static int qtnf_suspend(struct wiphy *wiphy, struct cfg80211_wowlan *wowla=
n)
 {
@@ -1004,6 +1024,7 @@ static struct cfg80211_ops qtn_cfg80211_ops =3D {
 	.set_power_mgmt		=3D qtnf_set_power_mgmt,
 	.get_tx_power		=3D qtnf_get_tx_power,
 	.set_tx_power		=3D qtnf_set_tx_power,
+	.update_owe_info	=3D qtnf_update_owe_info,
 #ifdef CONFIG_PM
 	.suspend		=3D qtnf_suspend,
 	.resume			=3D qtnf_resume,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 4a4c213fe9f1..f40d8c3c3d9e 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -2791,3 +2791,39 @@ int qtnf_cmd_netdev_changeupper(const struct qtnf_vi=
f *vif, int br_domain)
=20
 	return ret;
 }
+
+int qtnf_cmd_send_update_owe(struct qtnf_vif *vif,
+			     struct cfg80211_update_owe_info *owe)
+{
+	struct qlink_cmd_update_owe *cmd;
+	struct sk_buff *cmd_skb;
+	int ret;
+
+	if (sizeof(*cmd) + owe->ie_len > QTNF_MAX_CMD_BUF_SIZE) {
+		pr_warn("VIF%u.%u: OWE update IEs too big: %zu\n",
+			vif->mac->macid, vif->vifid, owe->ie_len);
+		return -E2BIG;
+	}
+
+	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(vif->mac->macid, vif->vifid,
+					    QLINK_CMD_UPDATE_OWE,
+					    sizeof(*cmd));
+	if (!cmd_skb)
+		return -ENOMEM;
+
+	cmd =3D (struct qlink_cmd_update_owe *)cmd_skb->data;
+	ether_addr_copy(cmd->peer, owe->peer);
+	cmd->status =3D cpu_to_le16(owe->status);
+	if (owe->ie_len && owe->ie)
+		qtnf_cmd_skb_put_buffer(cmd_skb, owe->ie, owe->ie_len);
+
+	qtnf_bus_lock(vif->mac->bus);
+	ret =3D qtnf_cmd_send(vif->mac->bus, cmd_skb);
+	if (ret)
+		goto out;
+
+out:
+	qtnf_bus_unlock(vif->mac->bus);
+
+	return ret;
+}
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.h b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.h
index 9db695101d28..72ad6ae5c750 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.h
@@ -76,5 +76,7 @@ int qtnf_cmd_set_tx_power(const struct qtnf_vif *vif,
 int qtnf_cmd_send_wowlan_set(const struct qtnf_vif *vif,
 			     const struct cfg80211_wowlan *wowl);
 int qtnf_cmd_netdev_changeupper(const struct qtnf_vif *vif, int br_domain)=
;
+int qtnf_cmd_send_update_owe(struct qtnf_vif *vif,
+			     struct cfg80211_update_owe_info *owe);
=20
 #endif /* QLINK_COMMANDS_H_ */
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index cb610a7864ea..c775c177933b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -625,6 +625,50 @@ qtnf_event_handle_mic_failure(struct qtnf_vif *vif,
 	return 0;
 }
=20
+static int
+qtnf_event_handle_update_owe(struct qtnf_vif *vif,
+			     const struct qlink_event_update_owe *owe_ev,
+			     u16 len)
+{
+	struct wiphy *wiphy =3D priv_to_wiphy(vif->mac);
+	struct cfg80211_update_owe_info owe_info =3D {};
+	const u16 ie_len =3D len - sizeof(*owe_ev);
+	u8 *ie;
+
+	if (len < sizeof(*owe_ev)) {
+		pr_err("VIF%u.%u: payload is too short (%u < %zu)\n",
+		       vif->mac->macid, vif->vifid, len,
+		       sizeof(struct qlink_event_update_owe));
+		return -EINVAL;
+	}
+
+	if (!wiphy->registered || !vif->netdev)
+		return 0;
+
+	if (vif->wdev.iftype !=3D NL80211_IFTYPE_AP) {
+		pr_err("VIF%u.%u: UPDATE_OWE event when not in AP mode\n",
+		       vif->mac->macid, vif->vifid);
+		return -EPROTO;
+	}
+
+	ie =3D kzalloc(ie_len, GFP_KERNEL);
+	if (!ie)
+		return -ENOMEM;
+
+	memcpy(owe_info.peer, owe_ev->peer, ETH_ALEN);
+	memcpy(ie, owe_ev->ies, ie_len);
+	owe_info.ie_len =3D ie_len;
+	owe_info.ie =3D ie;
+
+	pr_info("%s: external OWE processing: peer=3D%pM\n",
+		vif->netdev->name, owe_ev->peer);
+
+	cfg80211_update_owe_info_event(vif->netdev, &owe_info, GFP_KERNEL);
+	kfree(ie);
+
+	return 0;
+}
+
 static int qtnf_event_parse(struct qtnf_wmac *mac,
 			    const struct sk_buff *event_skb)
 {
@@ -693,6 +737,10 @@ static int qtnf_event_parse(struct qtnf_wmac *mac,
 		ret =3D qtnf_event_handle_mic_failure(vif, (const void *)event,
 						    event_len);
 		break;
+	case QLINK_EVENT_UPDATE_OWE:
+		ret =3D qtnf_event_handle_update_owe(vif, (const void *)event,
+						   event_len);
+		break;
 	default:
 		pr_warn("unknown event type: %x\n", event_id);
 		break;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 5e9254f8fa8a..4d22a54c034f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -15,7 +15,7 @@
 #define QLINK_VER(_maj, _min)	(((_maj) << QLINK_PROTO_VER_MAJOR_S) | (_min=
))
=20
 #define QLINK_PROTO_VER_MAJOR		18
-#define QLINK_PROTO_VER_MINOR		0
+#define QLINK_PROTO_VER_MINOR		1
 #define QLINK_PROTO_VER		\
 	QLINK_VER(QLINK_PROTO_VER_MAJOR, QLINK_PROTO_VER_MINOR)
=20
@@ -322,6 +322,7 @@ enum qlink_cmd_type {
 	QLINK_CMD_WOWLAN_SET		=3D 0x0063,
 	QLINK_CMD_EXTERNAL_AUTH		=3D 0x0066,
 	QLINK_CMD_TXPWR			=3D 0x0067,
+	QLINK_CMD_UPDATE_OWE		=3D 0x0068,
 };
=20
 /**
@@ -960,6 +961,20 @@ struct qlink_cmd_scan {
 	u8 var_info[0];
 } __packed;
=20
+/**
+ * struct qlink_cmd_update_owe - data for QLINK_CMD_UPDATE_OWE_INFO comman=
d
+ *
+ * @peer: MAC of the peer device for which OWE processing has been complet=
ed
+ * @status: OWE external processing status code
+ * @ies: IEs for the peer constructed by the user space
+ */
+struct qlink_cmd_update_owe {
+	struct qlink_cmd chdr;
+	u8 peer[ETH_ALEN];
+	__le16 status;
+	u8 ies[0];
+} __packed;
+
 /* QLINK Command Responses messages related definitions
  */
=20
@@ -1222,6 +1237,7 @@ enum qlink_event_type {
 	QLINK_EVENT_RADAR		=3D 0x0029,
 	QLINK_EVENT_EXTERNAL_AUTH	=3D 0x0030,
 	QLINK_EVENT_MIC_FAILURE		=3D 0x0031,
+	QLINK_EVENT_UPDATE_OWE		=3D 0x0032,
 };
=20
 /**
@@ -1430,6 +1446,19 @@ struct qlink_event_mic_failure {
 	u8 pairwise;
 } __packed;
=20
+/**
+ * struct qlink_event_update_owe - data for QLINK_EVENT_UPDATE_OWE event
+ *
+ * @peer: MAC addr of the peer device for which OWE processing needs to be=
 done
+ * @ies: IEs from the peer
+ */
+struct qlink_event_update_owe {
+	struct qlink_event ehdr;
+	u8 peer[ETH_ALEN];
+	u8 rsvd[2];
+	u8 ies[0];
+} __packed;
+
 /* QLINK TLVs (Type-Length Values) definitions
  */
=20
--=20
2.11.0

