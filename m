Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A263B14A238
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgA0Krt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:49 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:5326 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgA0Krt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:49 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAj04Q006078
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:47 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xrh3032bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHJKcuOEyJBsbDeVIPkMJovGJpp8B+RL2mepNtSYfUo24KADpkoymU0uOrLth1Vzg2XgV9RMsZxNbS75r3Gykc4Z7RdcsQD3qYCvz9FwNS7/f5ylgnNLeGlT9cdUlD4jEuV4rvhKRSDTy/F913TxHh+eSkDXir6Ex1wdcupawEfW3XMHahogYDIt1MfnJU87qngMgbOjSBBlT1djI0yBzwU0qAOoXC9cHm5XS9OY9kh4PNz/F2RAEevLpbhEKCXqsbGFSQKeCXwCUtVV+hM+tDiLIqWNdhohqbYBCXImFJvLuzbUXNnv2bueXpALx8MhVy7od3rUpWoSwNlIH+0PFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJL6u5Z8T14jqMw1/1//D5Bl+yZAeFag9R0iFQCrPV4=;
 b=frQnysX1DcIZtAI929D1H1FN2A+1H0g2RaUkHPeb80UKwxGV3YOuhv0v9h/xy97e0nbUYX+EWoPmC9U5TWFOQCIUwmUO8kMnYhCIlBjFVjdMlyIw+C/hiR8afRIy8yGdQlIzdobiXSZbRxhCyl9h1G4Bmd2v3ptW8ynmxP0X9mlC5k1+yT7lCq59v7TqOyxzBS+Cya4kbDxWBKzGjj3SdaL4/XewP354voLM3fpufAnaswMGKE+lE2lmbz+nQzv8dXLfZeXmgFgHbTBofAy+FeZL4wZCyG2A6NA4xoGsZqk+pllbRUu27905S0wdixP3+vA87/PckPaDIRWwhCEQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJL6u5Z8T14jqMw1/1//D5Bl+yZAeFag9R0iFQCrPV4=;
 b=eHH0V4jdXAkicZHVXQCuG8p/GaNQVZOur77Wd5T1pfrFkxx1pZabaUEVdWLVCS2KY7RHU3H/20A9Mih6hqbRK2CrBpTn+ff3F4VqET8B1kPwQjLGYOhx0UeqlUeBQrkrQf8qEKo8XU521FwobJLyj0xtZKcoDpyekTP9Fhi4nBc=
Received: from BYAPR05MB5413.namprd05.prod.outlook.com (20.177.127.143) by
 BYAPR05MB6392.namprd05.prod.outlook.com (20.178.234.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12; Mon, 27 Jan 2020 10:47:44 +0000
Received: from BYAPR05MB5413.namprd05.prod.outlook.com
 ([fe80::d8ec:f9a4:c25a:6feb]) by BYAPR05MB5413.namprd05.prod.outlook.com
 ([fe80::d8ec:f9a4:c25a:6feb%7]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:44 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:47 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:47 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:46 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 03/10] qtnfmac: merge PHY_PARAMS_GET into MAC_INFO
Thread-Topic: [PATCH 03/10] qtnfmac: merge PHY_PARAMS_GET into MAC_INFO
Thread-Index: AQHV1P8TovdWgST+8EWSREOkfui6TQ==
Date:   Mon, 27 Jan 2020 10:46:47 +0000
Message-ID: <20200127104634.7248-4-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 556460a6-7ee3-41fc-f522-08d7a3163560
x-ms-traffictypediagnostic: SN6PR05MB5391:|BYAPR05MB6392:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391350E129EFF2B931724E1A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:42 AM
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(36756003)(103116003)(16526019)(478600001)(6486002)(81166006)(6916009)(8676002)(81156014)(186003)(8936002)(2616005)(956004)(26005)(66446008)(54906003)(5660300002)(1076003)(2906002)(66476007)(66556008)(64756008)(66946007)(4326008)(71200400001)(107886003)(86362001)(316002)(7696005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6392;H:BYAPR05MB5413.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlvCZA0SzxSnWQMSHE1IknUYplEVw/zaaaXIncDzc8vqGHzZfBV0LIpzkc+tJd7E21PZTxjQzUMEnlSqT7Vizvbr8wWXBDSkSNmOO4bWtht80G3enm3nl1S9o42AEh5SrpUh4WSkAQBouxfQdFxCULge/kLg88ukeRN/ObwlKJ7Rfxhq/ot6DgTnLZxJfbVaO4KT2XFyW26wN0sj/ll1oPnivsiaCyaoXfxQ0j9u0L5xB4kpCNfLSvvnXq8CHff+SqIPyolAxGppxvp1UPu1tbfnbNtuE7/fj7YApgLz5hws+jILSKj1LnmFOytXDmwmHVhXOTJS8kPJKXztoBtK2Fye3N7SJejNOpkXn8ccU3HkWplg8y4LZTwodjSs6TCAKeL+8qfnldTdzTSjRLuNY5nViqlk3uvgOYcuIwjsVa+5f7VS6q1Up9c+kRfGHlxq
x-ms-exchange-antispam-messagedata: GxFpLqVRfAEjtSBHlzo5RlWX75RSRaDoYPK8KVy76g7gs/DfSF6aEpjlOKShdyZJRdl+ShHxQx5RNHSkIA8lGqLcHXOtReiHdxa0+rQx5D4zzi21S9UEe/3PYvSFoIR51carLy1RsauI+nQ8SCRaPw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556460a6-7ee3-41fc-f522-08d7a3163560
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s1FRLEep2UxUgME2avNZg1GMROBYurxar0ifEAifNclMXM5gKcML2T9c1VmKNlF+hlJom11VxxfCpe5d1KQv5ubfzLUVDWnwZuu7aNJ0gLqnXAIHWaiJ2E75eaQRYrZWOKdNnvgVHtn/JtWwfBrzfhrrmLZbQUu5w12ff9jZgKoWYOZifDs2OJrPo2aMvPCCtACcgDZZM7EjQ626hxS+/zx524Uy6lqb2Fg+yJ441yU=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:44.7652
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6392
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

QLINK_CMD_PHY_PARAMS_GET command does not need to be separate,
it can be included into GET_MAC_INFO command. Merge these two
commands adding all the missing wiphy data.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 102 ++----------------=
----
 drivers/net/wireless/quantenna/qtnfmac/core.c     |  18 ++--
 drivers/net/wireless/quantenna/qtnfmac/core.h     |   3 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    |  64 ++++++++------
 4 files changed, 49 insertions(+), 138 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 4d494732b2d2..ca7d59a0a848 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1291,7 +1291,12 @@ qtnf_cmd_resp_proc_mac_info(struct qtnf_wmac *mac,
 	mac_info->radar_detect_widths =3D
 			qlink_chan_width_mask_to_nl(le16_to_cpu(
 					resp_info->radar_detect_widths));
-	mac_info->max_acl_mac_addrs =3D le32_to_cpu(resp_info->max_acl_mac_addrs)=
;
+	mac_info->max_acl_mac_addrs =3D le16_to_cpu(resp_info->max_acl_mac_addrs)=
;
+	mac_info->frag_thr =3D le32_to_cpu(resp_info->frag_threshold);
+	mac_info->rts_thr =3D le32_to_cpu(resp_info->rts_threshold);
+	mac_info->sretry_limit =3D resp_info->retry_short;
+	mac_info->lretry_limit =3D resp_info->retry_long;
+	mac_info->coverage_class =3D resp_info->coverage_class;
=20
 	memcpy(&mac_info->ht_cap_mod_mask, &resp_info->ht_cap_mod_mask,
 	       sizeof(mac_info->ht_cap_mod_mask));
@@ -1576,72 +1581,6 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_suppor=
ted_band *band,
 	return ret;
 }
=20
-static int qtnf_cmd_resp_proc_phy_params(struct qtnf_wmac *mac,
-					 const u8 *payload, size_t payload_len)
-{
-	struct qtnf_mac_info *mac_info;
-	struct qlink_tlv_frag_rts_thr *phy_thr;
-	struct qlink_tlv_rlimit *limit;
-	struct qlink_tlv_cclass *class;
-	u16 tlv_type;
-	u16 tlv_value_len;
-	size_t tlv_full_len;
-	const struct qlink_tlv_hdr *tlv;
-
-	mac_info =3D &mac->macinfo;
-
-	tlv =3D (struct qlink_tlv_hdr *)payload;
-	while (payload_len >=3D sizeof(struct qlink_tlv_hdr)) {
-		tlv_type =3D le16_to_cpu(tlv->type);
-		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-
-		if (tlv_full_len > payload_len) {
-			pr_warn("MAC%u: malformed TLV 0x%.2X; LEN: %u\n",
-				mac->macid, tlv_type, tlv_value_len);
-			return -EINVAL;
-		}
-
-		switch (tlv_type) {
-		case QTN_TLV_ID_FRAG_THRESH:
-			phy_thr =3D (void *)tlv;
-			mac_info->frag_thr =3D le32_to_cpu(phy_thr->thr);
-			break;
-		case QTN_TLV_ID_RTS_THRESH:
-			phy_thr =3D (void *)tlv;
-			mac_info->rts_thr =3D le32_to_cpu(phy_thr->thr);
-			break;
-		case QTN_TLV_ID_SRETRY_LIMIT:
-			limit =3D (void *)tlv;
-			mac_info->sretry_limit =3D limit->rlimit;
-			break;
-		case QTN_TLV_ID_LRETRY_LIMIT:
-			limit =3D (void *)tlv;
-			mac_info->lretry_limit =3D limit->rlimit;
-			break;
-		case QTN_TLV_ID_COVERAGE_CLASS:
-			class =3D (void *)tlv;
-			mac_info->coverage_class =3D class->cclass;
-			break;
-		default:
-			pr_err("MAC%u: Unknown TLV type: %#x\n", mac->macid,
-			       le16_to_cpu(tlv->type));
-			break;
-		}
-
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
-	}
-
-	if (payload_len) {
-		pr_warn("MAC%u: malformed TLV buf; bytes left: %zu\n",
-			mac->macid, payload_len);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int
 qtnf_cmd_resp_proc_chan_stat_info(struct qtnf_chan_stats *stats,
 				  const u8 *payload, size_t payload_len)
@@ -1799,35 +1738,6 @@ int qtnf_cmd_band_info_get(struct qtnf_wmac *mac,
 	return ret;
 }
=20
-int qtnf_cmd_send_get_phy_params(struct qtnf_wmac *mac)
-{
-	struct sk_buff *cmd_skb, *resp_skb =3D NULL;
-	struct qlink_resp_phy_params *resp;
-	size_t response_size =3D 0;
-	int ret =3D 0;
-
-	cmd_skb =3D qtnf_cmd_alloc_new_cmdskb(mac->macid, 0,
-					    QLINK_CMD_PHY_PARAMS_GET,
-					    sizeof(struct qlink_cmd));
-	if (!cmd_skb)
-		return -ENOMEM;
-
-	qtnf_bus_lock(mac->bus);
-	ret =3D qtnf_cmd_send_with_reply(mac->bus, cmd_skb, &resp_skb,
-				       sizeof(*resp), &response_size);
-	if (ret)
-		goto out;
-
-	resp =3D (struct qlink_resp_phy_params *)resp_skb->data;
-	ret =3D qtnf_cmd_resp_proc_phy_params(mac, resp->info, response_size);
-
-out:
-	qtnf_bus_unlock(mac->bus);
-	consume_skb(resp_skb);
-
-	return ret;
-}
-
 int qtnf_cmd_send_update_phy_params(struct qtnf_wmac *mac, u32 changed)
 {
 	struct wiphy *wiphy =3D priv_to_wiphy(mac);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 853429de57c9..74c9aa297ec9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -585,16 +585,6 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus, =
unsigned int macid)
 		return PTR_ERR(mac);
 	}
=20
-	ret =3D qtnf_cmd_get_mac_info(mac);
-	if (ret) {
-		pr_err("MAC%u: failed to get info\n", macid);
-		goto error;
-	}
-
-	/* Use MAC address of the first active radio as a unique device ID */
-	if (is_zero_ether_addr(mac->bus->hw_id))
-		ether_addr_copy(mac->bus->hw_id, mac->macaddr);
-
 	vif =3D qtnf_mac_get_base_vif(mac);
 	if (!vif) {
 		pr_err("MAC%u: primary VIF is not ready\n", macid);
@@ -609,12 +599,16 @@ static int qtnf_core_mac_attach(struct qtnf_bus *bus,=
 unsigned int macid)
 		goto error;
 	}
=20
-	ret =3D qtnf_cmd_send_get_phy_params(mac);
+	ret =3D qtnf_cmd_get_mac_info(mac);
 	if (ret) {
-		pr_err("MAC%u: failed to get PHY settings\n", macid);
+		pr_err("MAC%u: failed to get MAC info\n", macid);
 		goto error_del_vif;
 	}
=20
+	/* Use MAC address of the first active radio as a unique device ID */
+	if (is_zero_ether_addr(mac->bus->hw_id))
+		ether_addr_copy(mac->bus->hw_id, mac->macaddr);
+
 	ret =3D qtnf_mac_init_bands(mac);
 	if (ret) {
 		pr_err("MAC%u: failed to init bands\n", macid);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index cdefe24c2f27..d7491e965691 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -84,7 +84,7 @@ struct qtnf_mac_info {
 	u8 sretry_limit;
 	u8 coverage_class;
 	u8 radar_detect_widths;
-	u32 max_acl_mac_addrs;
+	u16 max_acl_mac_addrs;
 	struct ieee80211_ht_cap ht_cap_mod_mask;
 	struct ieee80211_vht_cap vht_cap_mod_mask;
 	struct ieee80211_iface_combination *if_comb;
@@ -141,7 +141,6 @@ int qtnf_core_net_attach(struct qtnf_wmac *mac, struct =
qtnf_vif *priv,
 			 const char *name, unsigned char name_assign_type);
 void qtnf_main_work_queue(struct work_struct *work);
 int qtnf_cmd_send_update_phy_params(struct qtnf_wmac *mac, u32 changed);
-int qtnf_cmd_send_get_phy_params(struct qtnf_wmac *mac);
=20
 struct qtnf_wmac *qtnf_core_get_mac(const struct qtnf_bus *bus, u8 macid);
 struct net_device *qtnf_classify_skb(struct qtnf_bus *bus, struct sk_buff =
*skb);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 20b9e90e377c..9838ea6b212a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -289,7 +289,6 @@ enum qlink_cmd_type {
 	QLINK_CMD_REGISTER_MGMT		=3D 0x0003,
 	QLINK_CMD_SEND_FRAME		=3D 0x0004,
 	QLINK_CMD_MGMT_SET_APPIE	=3D 0x0005,
-	QLINK_CMD_PHY_PARAMS_GET	=3D 0x0011,
 	QLINK_CMD_PHY_PARAMS_SET	=3D 0x0012,
 	QLINK_CMD_GET_HW_INFO		=3D 0x0013,
 	QLINK_CMD_MAC_INFO		=3D 0x0014,
@@ -982,14 +981,48 @@ struct qlink_resp_get_mac_info {
 	u8 num_rx_chain;
 	struct ieee80211_vht_cap vht_cap_mod_mask;
 	struct ieee80211_ht_cap ht_cap_mod_mask;
+
 	__le16 max_ap_assoc_sta;
+	__le32 hw_version;
+	__le32 probe_resp_offload;
+	__le32 bss_select_support;
+	__le16 n_addresses;
 	__le16 radar_detect_widths;
-	__le32 max_acl_mac_addrs;
+	__le16 max_remain_on_channel_duration;
+	__le16 max_acl_mac_addrs;
+
+	__le32 frag_threshold;
+	__le32 rts_threshold;
+	u8 retry_short;
+	u8 retry_long;
+	u8 coverage_class;
+
+	u8 max_scan_ssids;
+	u8 max_sched_scan_reqs;
+	u8 max_sched_scan_ssids;
+	u8 max_match_sets;
+	u8 max_adj_channel_rssi_comp;
+
+	__le16 max_scan_ie_len;
+	__le16 max_sched_scan_ie_len;
+	__le32 max_sched_scan_plans;
+	__le32 max_sched_scan_plan_interval;
+	__le32 max_sched_scan_plan_iterations;
+
+	u8 n_cipher_suites;
+	u8 n_akm_suites;
+	u8 max_num_pmkids;
+	u8 num_iftype_ext_capab;
+	u8 extended_capabilities_len;
+	u8 max_data_retry_count;
+	u8 n_iface_combinations;
+	u8 max_num_csa_counters;
+
 	u8 bands_cap;
 	u8 alpha2[2];
 	u8 n_reg_rules;
 	u8 dfs_region;
-	u8 rsvd[1];
+	u8 rsvd[3];
 	u8 var_info[0];
 } __packed;
=20
@@ -1074,16 +1107,6 @@ struct qlink_resp_band_info_get {
 } __packed;
=20
 /**
- * struct qlink_resp_phy_params - response for QLINK_CMD_PHY_PARAMS_GET co=
mmand
- *
- * @info: variable-length array of PHY params.
- */
-struct qlink_resp_phy_params {
-	struct qlink_resp rhdr;
-	u8 info[0];
-} __packed;
-
-/**
  * struct qlink_resp_get_chan_stats - response for QLINK_CMD_CHAN_STATS cm=
d
  *
  * @info: variable-length channel info.
@@ -1425,21 +1448,6 @@ struct qlink_iface_limit_record {
=20
 #define QLINK_RSSI_OFFSET	120
=20
-struct qlink_tlv_frag_rts_thr {
-	struct qlink_tlv_hdr hdr;
-	__le32 thr;
-} __packed;
-
-struct qlink_tlv_rlimit {
-	struct qlink_tlv_hdr hdr;
-	u8 rlimit;
-} __packed;
-
-struct qlink_tlv_cclass {
-	struct qlink_tlv_hdr hdr;
-	u8 cclass;
-} __packed;
-
 /**
  * enum qlink_reg_rule_flags - regulatory rule flags
  *
--=20
2.11.0

