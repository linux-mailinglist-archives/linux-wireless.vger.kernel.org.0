Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E08E914A23D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgA0KsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:48:24 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:64014 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730011AbgA0KsY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:48:24 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAh5XZ020666
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:21 -0700
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2056.outbound.protection.outlook.com [104.47.37.56])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrhdav4af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WM9V/1FPfatLAHQIKAikad6S60qzumljHx9+17yt3YaLZ4CYC4GDP50QKEUOV5uzLlVP0k/Zu6KNXMYiRqWM3XzYLoSMy0KCbRznphN0NvLeG/0Re+End6HYfoSU7VjTIboRA7bfD5mmaT4gmxNmLw2Mp1cssf+Ch2Vw9T74hty71t7EbyvLsFAQ3o6TaPmuktNy2IJvPYeEImOB+LnXicKUZ+Hj67iAoDKMmOrpatxKv9m6lx3aCGyg9Q20BEYl2UEXIVfdrDZVMQAZ+WH6Z+lHYRXBbe6nTa4e7eY/9qlJXoNOtHuueS0kOZQoFTyp0InQQdfuCwDF5TGd7JtjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prUoUt9Fn4c11remkL03VBBBKZdqcwdTUfI7OdyR1ZI=;
 b=C++ePENsp9E+/MxUCTGbHPgbk1khP7aP27eGbotdp5JxnDaSWHYkCB2muq+uN8s8qwFMnBpfW3Rdu063eOws3xX7bAHeB0t/VfFVthDqpKZk9GKqlLEykqksaohF+4G0M78J4hfDZSNckK4BfTkGDEiJC2cHh5t/StRi4iezRvs38S0feoTDM8SZNn97A+c8CalP1EqYeqflfBBh1K53xtbOP3jl9MsT9qCwnAnBZ29hIaUwSzqSZvXf8VNN9DoJzNx8cg6pxmPBntjt7plZHlrRstiEMYStIqBlcx7M61J85Lub2tRRSkLtLCCdbLDTwtnN/GCHHfSQSfAFxD43cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prUoUt9Fn4c11remkL03VBBBKZdqcwdTUfI7OdyR1ZI=;
 b=b9/rAGn3/qVF9uYvPcL8s2iGc3AR22nlCzAO2hS0dQXzBxldt4Gf0xSLSJgTNY8I8XPnh8L2n9S+AUuIXDr87jwkFLXbRiP/8zNgGYjsNtDNgT/gYyMDeMjzHVHhKg7xEuU/acy9nXQO+fLO4ZWCMZANxaK+ZrZcBSu+9JNdv8Q=
Received: from BN7PR05MB5874.namprd05.prod.outlook.com (20.176.29.22) by
 BN7PR05MB4306.namprd05.prod.outlook.com (52.133.220.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.19; Mon, 27 Jan 2020 10:48:20 +0000
Received: from BN7PR05MB5874.namprd05.prod.outlook.com
 ([fe80::60e4:931b:3c94:8d1f]) by BN7PR05MB5874.namprd05.prod.outlook.com
 ([fe80::60e4:931b:3c94:8d1f%7]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:48:19 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:57 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:57 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:55 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 09/10] qtnfmac: drop unnecessary TLVs from scan command
Thread-Topic: [PATCH 09/10] qtnfmac: drop unnecessary TLVs from scan command
Thread-Index: AQHV1P8YoGp2x7LMKkGSUuBVx97qmw==
Date:   Mon, 27 Jan 2020 10:46:56 +0000
Message-ID: <20200127104634.7248-10-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 9c1e32b1-36b8-424c-23ae-08d7a3163ac8
x-ms-traffictypediagnostic: SN6PR05MB5391:|BN7PR05MB4306:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB53913B367C9351EBED52F425A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:48:15 AM
x-ms-oob-tlc-oobclassifiers: OLM:353;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(136003)(376002)(346002)(366004)(199004)(189003)(66946007)(8936002)(8676002)(478600001)(54906003)(956004)(2616005)(1076003)(316002)(71200400001)(4326008)(86362001)(81156014)(81166006)(26005)(7696005)(66556008)(66476007)(36756003)(107886003)(52116002)(5660300002)(6916009)(66446008)(64756008)(6486002)(2906002)(186003)(16526019)(103116003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR05MB4306;H:BN7PR05MB5874.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Efu71vw4yfxwkvCZuNTRfM21/BnYVR0yvAs3vcZn7YrDR87FD9eeRGroN5IYH7GKvYJGxTIP/vNPgnuRwQ/EEjAinnL/5NiadvdQGgKH26x6b/332mG5kv5f9fVlD2oUDihaGP/7wofIDk1d2xZL90EjV8WwIMz9f02k6RMxDlr3f18Dva+4iLtjJ8pZbjDsJHNzoyJ2LfWQAKC34uaEuWJHV8GUGJ9Wty/1B3/QIwT26amG4WVjaeemIXf8oAD4am9fTIa4rM7lAKV2RB4sXW8COZ2ORJ1mjgFPrB/45iSivCq30LFUSQV1QYOotI0ZrIND39QAc4b3l5DxjwCqd2W89E54GDON75WixK2MbmbdFz43zdIk2tA42rIiTWTl7YehdmvlUxcPCA2GH/H2mjJrvTaI+UVTP725n2d09Vni11GwrifMFsQscvfAskhj
x-ms-exchange-antispam-messagedata: dOOophqL3h8Li7qib+x2vgs53RBTHQShwMJbVfEDLz6vtolZW/npAkZQ5VVWGkIuewrcNTYY4j5A0G6m0ugBTOCqdpY12WLz+KmqSonp9F2A23wZ3/N4wnGgZrm+s1Bz1hILEsTMuf3bm1lW9uQc5Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1e32b1-36b8-424c-23ae-08d7a3163ac8
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oBgs8EHFRmJtQ3UHhh1LqOiXQgfyuwP3O3z6AjrsmhAiEKJMqR98iBFsFrGD1IsPku+0+7/Ld9sRj2qz2m4trcYYWWhfXaCW0jc5zELvfbyMp2pCce4U/ubFMV9//Q38CAG4zEZJrKPTRz+NqOfq+PmNscLUWBzmgrIVW702eVUa0xVV5dc/A9G+IyYk+ygVQ5NXgDZARizOkI1FEHSxvDwEPA7ediJlY1zzLvIDHeQ=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:48:19.6511
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR05MB4306
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Most part of scan command data is always present, so no need
to keep it in TLV. Simplify scan command processing moving
most part of its parameters into a fixed part of
qlink_cmd_scan message.

Use fixed dwell time values for normal scan when device is not
connected, and allow wireless card decide on dwell times by
itself if it's operating as a STA and is connected. When
connected, card can select dwell times dynamically based on
traffic conditions to get best results.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 130 +++++++++--------=
----
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |  51 ++++++--
 .../net/wireless/quantenna/qtnfmac/qlink_util.h    |   8 --
 3 files changed, 96 insertions(+), 93 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 31286699a5b7..ccc1e06dfcf6 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -11,11 +11,11 @@
 #include "bus.h"
 #include "commands.h"
=20
+/* Let device itself to select best values for current conditions */
 #define QTNF_SCAN_TIME_AUTO	0
=20
-/* Let device itself to select best values for current conditions */
-#define QTNF_SCAN_DWELL_ACTIVE_DEFAULT		QTNF_SCAN_TIME_AUTO
-#define QTNF_SCAN_DWELL_PASSIVE_DEFAULT		QTNF_SCAN_TIME_AUTO
+#define QTNF_SCAN_DWELL_ACTIVE_DEFAULT		90
+#define QTNF_SCAN_DWELL_PASSIVE_DEFAULT		100
 #define QTNF_SCAN_SAMPLE_DURATION_DEFAULT	QTNF_SCAN_TIME_AUTO
=20
 static int qtnf_cmd_check_reply_header(const struct qlink_resp *resp,
@@ -2011,108 +2011,90 @@ static void qtnf_cmd_randmac_tlv_add(struct sk_buf=
f *cmd_skb,
 	memcpy(randmac->mac_addr_mask, mac_addr_mask, ETH_ALEN);
 }
=20
-static void qtnf_cmd_scan_set_dwell(struct qtnf_wmac *mac,
-				    struct sk_buff *cmd_skb)
+int qtnf_cmd_send_scan(struct qtnf_wmac *mac)
 {
 	struct cfg80211_scan_request *scan_req =3D mac->scan_req;
-	u16 dwell_active =3D QTNF_SCAN_DWELL_ACTIVE_DEFAULT;
 	u16 dwell_passive =3D QTNF_SCAN_DWELL_PASSIVE_DEFAULT;
-	u16 duration =3D QTNF_SCAN_SAMPLE_DURATION_DEFAULT;
-
-	if (scan_req->duration) {
-		dwell_active =3D scan_req->duration;
-		dwell_passive =3D scan_req->duration;
-	}
-
-	pr_debug("MAC%u: %s scan dwell active=3D%u, passive=3D%u, duration=3D%u\n=
",
-		 mac->macid,
-		 scan_req->duration_mandatory ? "mandatory" : "max",
-		 dwell_active, dwell_passive, duration);
-
-	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
-				 QTN_TLV_ID_SCAN_DWELL_ACTIVE,
-				 dwell_active);
-	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
-				 QTN_TLV_ID_SCAN_DWELL_PASSIVE,
-				 dwell_passive);
-	qtnf_cmd_skb_put_tlv_u32(cmd_skb,
-				 QTN_TLV_ID_SCAN_SAMPLE_DURATION,
-				 duration);
-}
-
-int qtnf_cmd_send_scan(struct qtnf_wmac *mac)
-{
-	struct sk_buff *cmd_skb;
+	u16 dwell_active =3D QTNF_SCAN_DWELL_ACTIVE_DEFAULT;
+	struct wireless_dev *wdev =3D scan_req->wdev;
 	struct ieee80211_channel *sc;
-	struct cfg80211_scan_request *scan_req =3D mac->scan_req;
-	int n_channels;
-	int count =3D 0;
+	struct qlink_cmd_scan *cmd;
+	struct sk_buff *cmd_skb;
+	int n_channels =3D 0;
+	u64 flags =3D 0;
+	int count;
 	int ret;
=20
 	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(mac->macid, QLINK_VIFID_RSVD,
 					    QLINK_CMD_SCAN,
-					    sizeof(struct qlink_cmd));
+					    sizeof(*cmd));
 	if (!cmd_skb)
 		return -ENOMEM;
=20
-	qtnf_bus_lock(mac->bus);
+	cmd =3D (struct qlink_cmd_scan *)cmd_skb->data;
=20
-	if (scan_req->n_ssids !=3D 0) {
-		while (count < scan_req->n_ssids) {
-			qtnf_cmd_skb_put_tlv_arr(cmd_skb, WLAN_EID_SSID,
-				scan_req->ssids[count].ssid,
-				scan_req->ssids[count].ssid_len);
-			count++;
-		}
+	if (scan_req->duration) {
+		dwell_active =3D scan_req->duration;
+		dwell_passive =3D scan_req->duration;
+	} else if (wdev->iftype =3D=3D NL80211_IFTYPE_STATION &&
+		   wdev->current_bss) {
+		/* let device select dwell based on traffic conditions */
+		dwell_active =3D QTNF_SCAN_TIME_AUTO;
+		dwell_passive =3D QTNF_SCAN_TIME_AUTO;
+	}
+
+	cmd->n_ssids =3D cpu_to_le16(scan_req->n_ssids);
+	for (count =3D 0; count < scan_req->n_ssids; ++count) {
+		qtnf_cmd_skb_put_tlv_arr(cmd_skb, WLAN_EID_SSID,
+					 scan_req->ssids[count].ssid,
+					 scan_req->ssids[count].ssid_len);
 	}
=20
 	if (scan_req->ie_len !=3D 0)
 		qtnf_cmd_tlv_ie_set_add(cmd_skb, QLINK_IE_SET_PROBE_REQ,
 					scan_req->ie, scan_req->ie_len);
=20
-	if (scan_req->n_channels) {
-		n_channels =3D scan_req->n_channels;
-		count =3D 0;
-
-		while (n_channels !=3D 0) {
-			sc =3D scan_req->channels[count];
-			if (sc->flags & IEEE80211_CHAN_DISABLED) {
-				n_channels--;
-				continue;
-			}
+	for (count =3D 0; count < scan_req->n_channels; ++count) {
+		sc =3D scan_req->channels[count];
+		if (sc->flags & IEEE80211_CHAN_DISABLED)
+			continue;
=20
-			pr_debug("MAC%u: scan chan=3D%d, freq=3D%d, flags=3D%#x\n",
-				 mac->macid, sc->hw_value, sc->center_freq,
-				 sc->flags);
+		pr_debug("[MAC%u] scan chan=3D%d, freq=3D%d, flags=3D%#x\n",
+			 mac->macid, sc->hw_value, sc->center_freq,
+			 sc->flags);
=20
-			qtnf_cmd_channel_tlv_add(cmd_skb, sc);
-			n_channels--;
-			count++;
-		}
+		qtnf_cmd_channel_tlv_add(cmd_skb, sc);
+		++n_channels;
 	}
=20
-	qtnf_cmd_scan_set_dwell(mac, cmd_skb);
+	if (scan_req->flags & NL80211_SCAN_FLAG_FLUSH)
+		flags |=3D QLINK_SCAN_FLAG_FLUSH;
+
+	if (scan_req->duration_mandatory)
+		flags |=3D QLINK_SCAN_FLAG_DURATION_MANDATORY;
+
+	cmd->n_channels =3D cpu_to_le16(n_channels);
+	cmd->active_dwell =3D cpu_to_le16(dwell_active);
+	cmd->passive_dwell =3D cpu_to_le16(dwell_passive);
+	cmd->sample_duration =3D cpu_to_le16(QTNF_SCAN_SAMPLE_DURATION_DEFAULT);
+	cmd->flags =3D cpu_to_le64(flags);
+
+	pr_debug("[MAC%u] %s scan dwell active=3D%u passive=3D%u duration=3D%u\n"=
,
+		 mac->macid,
+		 scan_req->duration_mandatory ? "mandatory" : "max",
+		 dwell_active, dwell_passive,
+		 QTNF_SCAN_SAMPLE_DURATION_DEFAULT);
=20
 	if (scan_req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		pr_debug("MAC%u: scan with random addr=3D%pM, mask=3D%pM\n",
+		pr_debug("[MAC%u] scan with random addr=3D%pM, mask=3D%pM\n",
 			 mac->macid,
 			 scan_req->mac_addr, scan_req->mac_addr_mask);
-
 		qtnf_cmd_randmac_tlv_add(cmd_skb, scan_req->mac_addr,
 					 scan_req->mac_addr_mask);
 	}
=20
-	if (scan_req->flags & NL80211_SCAN_FLAG_FLUSH) {
-		pr_debug("MAC%u: flush cache before scan\n", mac->macid);
-
-		qtnf_cmd_skb_put_tlv_tag(cmd_skb, QTN_TLV_ID_SCAN_FLUSH);
-	}
-
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
index ab2bfae7ff3e..7ee1070f985f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -920,6 +920,46 @@ struct qlink_cmd_ndev_changeupper {
 	u8 rsvd[1];
 } __packed;
=20
+/**
+ * enum qlink_scan_flags -  scan request control flags
+ *
+ * Scan flags are used to control QLINK_CMD_SCAN behavior.
+ *
+ * @QLINK_SCAN_FLAG_FLUSH: flush cache before scanning.
+ */
+enum qlink_scan_flags {
+	QLINK_SCAN_FLAG_FLUSH =3D BIT(0),
+	QLINK_SCAN_FLAG_DURATION_MANDATORY =3D BIT(1),
+};
+
+/**
+ * struct qlink_cmd_scan - data for QLINK_CMD_SCAN command
+ *
+ * @flags: scan flags, a bitmap of &enum qlink_scan_flags.
+ * @n_ssids: number of WLAN_EID_SSID TLVs expected in variable portion of =
the
+ *	command.
+ * @n_channels: number of QTN_TLV_ID_CHANNEL TLVs expected in variable pay=
load.
+ * @active_dwell: time spent on a single channel for an active scan.
+ * @passive_dwell: time spent on a single channel for a passive scan.
+ * @sample_duration: total duration of sampling a single channel during a =
scan
+ *	including off-channel dwell time and operating channel time.
+ * @bssid: specific BSSID to scan for or a broadcast BSSID.
+ * @scan_width: channel width to use, one of &enum qlink_channel_width.
+ */
+struct qlink_cmd_scan {
+	struct qlink_cmd chdr;
+	__le64 flags;
+	__le16 n_ssids;
+	__le16 n_channels;
+	__le16 active_dwell;
+	__le16 passive_dwell;
+	__le16 sample_duration;
+	u8 bssid[ETH_ALEN];
+	u8 scan_width;
+	u8 rsvd[3];
+	u8 var_info[0];
+} __packed;
+
 /* QLINK Command Responses messages related definitions
  */
=20
@@ -1407,13 +1447,6 @@ struct qlink_event_mic_failure {
  * @QTN_TLV_ID_STA_STATS: per-STA statistics as defined by
  *	&struct qlink_sta_stats. Valid values are marked as such in a bitmap
  *	carried by QTN_TLV_ID_BITMAP.
- * @QTN_TLV_ID_SCAN_DWELL_ACTIVE: time spent on a single channel for an ac=
tive
- *	scan.
- * @QTN_TLV_ID_SCAN_DWELL_PASSIVE: time spent on a single channel for a pa=
ssive
- *	scan.
- * @QTN_TLV_ID_SCAN_SAMPLE_DURATION: total duration of sampling a single c=
hannel
- *	during a scan including off-channel dwell time and operating channel
- *	time.
  * @QTN_TLV_ID_IFTYPE_DATA: supported band data.
  */
 enum qlink_tlv_id {
@@ -1444,10 +1477,6 @@ enum qlink_tlv_id {
 	QTN_TLV_ID_RANDOM_MAC_ADDR	=3D 0x0408,
 	QTN_TLV_ID_WOWLAN_CAPAB		=3D 0x0410,
 	QTN_TLV_ID_WOWLAN_PATTERN	=3D 0x0411,
-	QTN_TLV_ID_SCAN_FLUSH		=3D 0x0412,
-	QTN_TLV_ID_SCAN_DWELL_ACTIVE	=3D 0x0413,
-	QTN_TLV_ID_SCAN_DWELL_PASSIVE	=3D 0x0416,
-	QTN_TLV_ID_SCAN_SAMPLE_DURATION	=3D 0x0417,
 	QTN_TLV_ID_IFTYPE_DATA		=3D 0x0418,
 };
=20
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h b/drivers/=
net/wireless/quantenna/qtnfmac/qlink_util.h
index 9164b750396c..230a10a41c7a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink_util.h
@@ -28,14 +28,6 @@ static inline void qtnf_cmd_skb_put_tlv_arr(struct sk_bu=
ff *skb,
 	memcpy(hdr->val, arr, arr_len);
 }
=20
-static inline void qtnf_cmd_skb_put_tlv_tag(struct sk_buff *skb, u16 tlv_i=
d)
-{
-	struct qlink_tlv_hdr *hdr =3D skb_put(skb, sizeof(*hdr));
-
-	hdr->type =3D cpu_to_le16(tlv_id);
-	hdr->len =3D cpu_to_le16(0);
-}
-
 static inline void qtnf_cmd_skb_put_tlv_u32(struct sk_buff *skb,
 					    u16 tlv_id, u32 value)
 {
--=20
2.11.0

