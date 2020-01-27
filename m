Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53AD14A23A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbgA0Kry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:47:54 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:10802 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730012AbgA0Krx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:47:53 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAhDg4020880
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:52 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrkum3usq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElWI/Q51nzBpu3wai+m/AK49s2rJNTKxpb1zkb+7E3SWFh5dTdS675jLbSPX2WTKTCLPjzX3rC3d+DUPTE1UGR+bCc76Hpa4Qs3EKLe4SY1Ob9uEnkeyyLD4e/3jcIJ/r4EKYxC0M5WYmY3xw/FI7t0DUo5EI1CV6REcjTUob1mHV38IB1Q3fDcsZm2jEqtzYPe8D5HlOizvbOCYfUcdk1moqHDOv3MPtVmwZTQ9DQJyjIgGYgaNoZxM2QmdP6H5ssf5Y8GyTYI/ztlng3yZFS/jQo3J37AsMUL+H32k28ihGcPZCQeEfd8grXGaW9gCEv/VQU604wvgRT6mmnkB9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aim6VQeuBCyyK84BO1cuwcqAQWx/3nzeJoBCuDhLk8s=;
 b=aHd00lFISL1U2iKU4YLawlun2QD+pRkJpCz0LQNxs2OPNYe8uV7lBSYc4QVpATxB6vGTWK57jopTmbtkOvaIRpxm7dLxQlxgQZKll0MPutiRQY695v4BI3zHPQ4T6q98mbfHp+ClP9smH3JrdoQ6y96OrkvD/PtDz1EHMOnhuEJthLgIzvzkkadshniIpRa83UK2k0BrdTIaPYChKPIdgeoN8WHxW3N4D1Aq2ooBZd2U8+dufsSVYtOgp6fENY/SMfqoyF3C7WOwHSH/nIdIocuZc6IAw2i8jH35KbuhBmzxwM1mZblpt5pXZAv+WljkhpIjyCLnDdK1z37e5aTdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aim6VQeuBCyyK84BO1cuwcqAQWx/3nzeJoBCuDhLk8s=;
 b=SRYSYxkFrogexm/tnJrhVtvzOzBWwEWoCKaK8+2r1BJHBPWhdtUInD+joRq4OkSTBmeVMZ/lkPxq71QYx4nGJU511bFVvJTxeQokeWqAngzeXKPQWLddoP4GRTKw8K5c7gKSvxc+AcD/e5YcGSLgg63xcsSgdxqFmgzLjYhHcJo=
Received: from BYAPR05MB6245.namprd05.prod.outlook.com (20.178.53.219) by
 BYAPR05MB6054.namprd05.prod.outlook.com (20.178.55.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.14; Mon, 27 Jan 2020 10:47:50 +0000
Received: from BYAPR05MB6245.namprd05.prod.outlook.com
 ([fe80::a034:b752:9b6f:5c86]) by BYAPR05MB6245.namprd05.prod.outlook.com
 ([fe80::a034:b752:9b6f:5c86%7]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:47:50 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:50 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:50 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:49 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 05/10] qtnfmac: implement extendable channel survey dump
Thread-Topic: [PATCH 05/10] qtnfmac: implement extendable channel survey dump
Thread-Index: AQHV1P8UbGpQvXT20k6pkN1Xx8UFoA==
Date:   Mon, 27 Jan 2020 10:46:50 +0000
Message-ID: <20200127104634.7248-6-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 1d1d798f-9201-4871-7c14-08d7a316370d
x-ms-traffictypediagnostic: SN6PR05MB5391:|BYAPR05MB6054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391CD6A0539B499D074BD75A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:47:47 AM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39840400004)(376002)(366004)(396003)(346002)(189003)(199004)(6666004)(71200400001)(81166006)(81156014)(8676002)(103116003)(8936002)(66946007)(186003)(26005)(2906002)(107886003)(66446008)(64756008)(66556008)(16526019)(7696005)(52116002)(66476007)(36756003)(4326008)(6916009)(478600001)(6486002)(1076003)(5660300002)(30864003)(86362001)(316002)(956004)(2616005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB6054;H:BYAPR05MB6245.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P8Lyq57CF6MwGweP5SNEzoa8flhzZv4D5l/BdaBOOGkIJXILf4E7K0iooPpd62X2G4eXDJsxAN/NvD8FojJKcr2YAn8qsIDK8j1Y3ed1uV6pYhUVzvyPMKZikeMlBTH+NFlK6Kitg07/XXQ/Ms+8vywK6TSU00UwMa+3xtK1LC/+StvHsRTR5g7TcCzvmbBRpdEuZ/KAQnm+tf4BhjNCRCG29/vIV/n3J61dGRQmGU4tUS/ZhZFiKI6Dm6J/1W7ktP15AQ6M4K8b+zced3fpwJCFiGvGScDOu/qwvsg6WlqgzaOQ4t80Xkxjx22RxXipqPGo+6o5DK7uKtZewu0IY+qf5qKUxb6+RVD6oOKjB7Qj8czWCq5FiQb6/o5afOeGupLx3B/ZIIbQqN1t3unE4icEXYml2152pX9OMjj9OQFqnFaz6sYrfA+OTTK71yJO
x-ms-exchange-antispam-messagedata: CnUXQQ1ZAE20e5kbrzRFRCuB/JfDHO6UDIG8GXrxbtJ10fRAXkl0w/xd9HZqDdlApBuFKwilxqjVFnA5QKDDiSRcYWs1kTE+b3259Ef8qYbMk9rA5PA1NPMZ/5zcR9zzGaoEF8sqLdDW0eneDsIY/w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1d798f-9201-4871-7c14-08d7a316370d
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qt0SgfB0EKT2+SOLsPYvkesBMWPPoqXDD7yJ7IYPFOy9hRi/eweNeJAnNI7U+eqQVqcHwNP6iR6bG4VXX3Fm7FcFA70aPBGWUUYap33uQPldH6Wm1VJktVi0MvtefcQOlKgFCcL8p3O1rwgppDn41fGSq6uE9Vl4wDAeA/LB5IYRpdxyhUe6WlmiPlHNe7zri0tXh3Vbb1OB8HwfQvFjEsA0s82RGzUoRWRlxdrfqGA=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:47:50.0494
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_02:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 adultscore=0
 spamscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2001270091
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Switch to extendable implementation of channel survey dump to make sure
that any new channel statistics can be added in the future without any
backwards compatibility issues. For this purpose use a separate variable
length bitmap to pass the list of valid statistics in firmware response.
Besides, switch to using channel frequency instead of IEEE channel
number to prepare for adding support of 6GHz band.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c |  42 +-----
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 174 ++++++++++++++----=
----
 drivers/net/wireless/quantenna/qtnfmac/commands.h |   4 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h     |   9 --
 drivers/net/wireless/quantenna/qtnfmac/qlink.h    |  66 ++++++--
 5 files changed, 173 insertions(+), 122 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index bc7ed8f4a813..a53ffe04a903 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -739,7 +739,6 @@ qtnf_dump_survey(struct wiphy *wiphy, struct net_device=
 *dev,
 	struct ieee80211_supported_band *sband;
 	const struct cfg80211_chan_def *chandef =3D &wdev->chandef;
 	struct ieee80211_channel *chan;
-	struct qtnf_chan_stats stats;
 	int ret;
=20
 	sband =3D wiphy->bands[NL80211_BAND_2GHZ];
@@ -755,49 +754,16 @@ qtnf_dump_survey(struct wiphy *wiphy, struct net_devi=
ce *dev,
 		return -ENOENT;
=20
 	chan =3D &sband->channels[idx];
-	memset(&stats, 0, sizeof(stats));
-
 	survey->channel =3D chan;
 	survey->filled =3D 0x0;
=20
-	if (chandef->chan) {
-		if (chan->hw_value =3D=3D chandef->chan->hw_value)
-			survey->filled =3D SURVEY_INFO_IN_USE;
-	}
+	if (chan =3D=3D chandef->chan)
+		survey->filled =3D SURVEY_INFO_IN_USE;
=20
-	ret =3D qtnf_cmd_get_chan_stats(mac, chan->hw_value, &stats);
-	switch (ret) {
-	case 0:
-		if (unlikely(stats.chan_num !=3D chan->hw_value)) {
-			pr_err("received stats for channel %d instead of %d\n",
-			       stats.chan_num, chan->hw_value);
-			ret =3D -EINVAL;
-			break;
-		}
-
-		survey->filled |=3D SURVEY_INFO_TIME |
-				 SURVEY_INFO_TIME_SCAN |
-				 SURVEY_INFO_TIME_BUSY |
-				 SURVEY_INFO_TIME_RX |
-				 SURVEY_INFO_TIME_TX |
-				 SURVEY_INFO_NOISE_DBM;
-
-		survey->time_scan =3D stats.cca_try;
-		survey->time =3D stats.cca_try;
-		survey->time_tx =3D stats.cca_tx;
-		survey->time_rx =3D stats.cca_rx;
-		survey->time_busy =3D stats.cca_busy;
-		survey->noise =3D stats.chan_noise;
-		break;
-	case -ENOENT:
-		pr_debug("no stats for channel %u\n", chan->hw_value);
-		ret =3D 0;
-		break;
-	default:
+	ret =3D qtnf_cmd_get_chan_stats(mac, chan->center_freq, survey);
+	if (ret)
 		pr_debug("failed to get chan(%d) stats from card\n",
 			 chan->hw_value);
-		break;
-	}
=20
 	return ret;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index 1cba0182a5b8..6a13b29bf814 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -1566,62 +1566,6 @@ qtnf_cmd_resp_fill_band_info(struct ieee80211_suppor=
ted_band *band,
 	return ret;
 }
=20
-static int
-qtnf_cmd_resp_proc_chan_stat_info(struct qtnf_chan_stats *stats,
-				  const u8 *payload, size_t payload_len)
-{
-	struct qlink_chan_stats *qlink_stats;
-	const struct qlink_tlv_hdr *tlv;
-	size_t tlv_full_len;
-	u16 tlv_value_len;
-	u16 tlv_type;
-
-	tlv =3D (struct qlink_tlv_hdr *)payload;
-	while (payload_len >=3D sizeof(struct qlink_tlv_hdr)) {
-		tlv_type =3D le16_to_cpu(tlv->type);
-		tlv_value_len =3D le16_to_cpu(tlv->len);
-		tlv_full_len =3D tlv_value_len + sizeof(struct qlink_tlv_hdr);
-		if (tlv_full_len > payload_len) {
-			pr_warn("malformed TLV 0x%.2X; LEN: %u\n",
-				tlv_type, tlv_value_len);
-			return -EINVAL;
-		}
-		switch (tlv_type) {
-		case QTN_TLV_ID_CHANNEL_STATS:
-			if (unlikely(tlv_value_len !=3D sizeof(*qlink_stats))) {
-				pr_err("invalid CHANNEL_STATS entry size\n");
-				return -EINVAL;
-			}
-
-			qlink_stats =3D (void *)tlv->val;
-
-			stats->chan_num =3D le32_to_cpu(qlink_stats->chan_num);
-			stats->cca_tx =3D le32_to_cpu(qlink_stats->cca_tx);
-			stats->cca_rx =3D le32_to_cpu(qlink_stats->cca_rx);
-			stats->cca_busy =3D le32_to_cpu(qlink_stats->cca_busy);
-			stats->cca_try =3D le32_to_cpu(qlink_stats->cca_try);
-			stats->chan_noise =3D qlink_stats->chan_noise;
-
-			pr_debug("chan(%u) try(%u) busy(%u) noise(%d)\n",
-				 stats->chan_num, stats->cca_try,
-				 stats->cca_busy, stats->chan_noise);
-			break;
-		default:
-			pr_warn("Unknown TLV type: %#x\n",
-				le16_to_cpu(tlv->type));
-		}
-		payload_len -=3D tlv_full_len;
-		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
-	}
-
-	if (payload_len) {
-		pr_warn("malformed TLV buf; bytes left: %zu\n", payload_len);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 int qtnf_cmd_get_mac_info(struct qtnf_wmac *mac)
 {
 	struct sk_buff *cmd_skb, *resp_skb =3D NULL;
@@ -2468,8 +2412,104 @@ int qtnf_cmd_reg_notify(struct qtnf_wmac *mac, stru=
ct regulatory_request *req,
 	return ret;
 }
=20
-int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, u16 channel,
-			    struct qtnf_chan_stats *stats)
+static int
+qtnf_cmd_resp_proc_chan_stat_info(struct survey_info *survey,
+				  const u8 *payload, size_t payload_len)
+{
+	const struct qlink_chan_stats *stats =3D NULL;
+	const struct qlink_tlv_hdr *tlv;
+	size_t tlv_full_len;
+	u16 tlv_value_len;
+	u16 tlv_type;
+	const u8 *map =3D NULL;
+	unsigned int map_len =3D 0;
+	unsigned int stats_len =3D 0;
+
+	tlv =3D (struct qlink_tlv_hdr *)payload;
+
+	while (payload_len >=3D sizeof(*tlv)) {
+		tlv_type =3D le16_to_cpu(tlv->type);
+		tlv_value_len =3D le16_to_cpu(tlv->len);
+		tlv_full_len =3D tlv_value_len + sizeof(*tlv);
+
+		if (tlv_full_len > payload_len) {
+			pr_warn("malformed TLV 0x%.2X; LEN: %u\n",
+				tlv_type, tlv_value_len);
+			return -ENOSPC;
+		}
+
+		switch (tlv_type) {
+		case QTN_TLV_ID_BITMAP:
+			map =3D tlv->val;
+			map_len =3D tlv_value_len;
+			break;
+		case QTN_TLV_ID_CHANNEL_STATS:
+			stats =3D (struct qlink_chan_stats *)tlv->val;
+			stats_len =3D tlv_value_len;
+			break;
+		default:
+			pr_info("Unknown TLV type: %#x\n", tlv_type);
+			break;
+		}
+
+		payload_len -=3D tlv_full_len;
+		tlv =3D (struct qlink_tlv_hdr *)(tlv->val + tlv_value_len);
+	}
+
+	if (payload_len) {
+		pr_warn("malformed TLV buf; bytes left: %zu\n", payload_len);
+		return -EINVAL;
+	}
+
+	if (!map || !stats)
+		return 0;
+
+#define qtnf_chan_stat_avail(stat_name, bitn)	\
+	(qtnf_utils_is_bit_set(map, bitn, map_len) && \
+	 (offsetofend(struct qlink_chan_stats, stat_name) <=3D stats_len))
+
+	if (qtnf_chan_stat_avail(time_on, QLINK_CHAN_STAT_TIME_ON)) {
+		survey->filled |=3D SURVEY_INFO_TIME;
+		survey->time =3D le64_to_cpu(stats->time_on);
+	}
+
+	if (qtnf_chan_stat_avail(time_tx, QLINK_CHAN_STAT_TIME_TX)) {
+		survey->filled |=3D SURVEY_INFO_TIME_TX;
+		survey->time_tx =3D le64_to_cpu(stats->time_tx);
+	}
+
+	if (qtnf_chan_stat_avail(time_rx, QLINK_CHAN_STAT_TIME_RX)) {
+		survey->filled |=3D SURVEY_INFO_TIME_RX;
+		survey->time_rx =3D le64_to_cpu(stats->time_rx);
+	}
+
+	if (qtnf_chan_stat_avail(cca_busy, QLINK_CHAN_STAT_CCA_BUSY)) {
+		survey->filled |=3D SURVEY_INFO_TIME_BUSY;
+		survey->time_busy =3D le64_to_cpu(stats->cca_busy);
+	}
+
+	if (qtnf_chan_stat_avail(cca_busy_ext, QLINK_CHAN_STAT_CCA_BUSY_EXT)) {
+		survey->filled |=3D SURVEY_INFO_TIME_EXT_BUSY;
+		survey->time_ext_busy =3D le64_to_cpu(stats->cca_busy_ext);
+	}
+
+	if (qtnf_chan_stat_avail(time_scan, QLINK_CHAN_STAT_TIME_SCAN)) {
+		survey->filled |=3D SURVEY_INFO_TIME_SCAN;
+		survey->time_scan =3D le64_to_cpu(stats->time_scan);
+	}
+
+	if (qtnf_chan_stat_avail(chan_noise, QLINK_CHAN_STAT_CHAN_NOISE)) {
+		survey->filled |=3D SURVEY_INFO_NOISE_DBM;
+		survey->noise =3D stats->chan_noise;
+	}
+
+#undef qtnf_chan_stat_avail
+
+	return 0;
+}
+
+int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, u32 chan_freq,
+			    struct survey_info *survey)
 {
 	struct sk_buff *cmd_skb, *resp_skb =3D NULL;
 	struct qlink_cmd_get_chan_stats *cmd;
@@ -2483,22 +2523,30 @@ int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, =
u16 channel,
 	if (!cmd_skb)
 		return -ENOMEM;
=20
-	qtnf_bus_lock(mac->bus);
-
 	cmd =3D (struct qlink_cmd_get_chan_stats *)cmd_skb->data;
-	cmd->channel =3D cpu_to_le16(channel);
+	cmd->channel_freq =3D cpu_to_le32(chan_freq);
=20
+	qtnf_bus_lock(mac->bus);
 	ret =3D qtnf_cmd_send_with_reply(mac->bus, cmd_skb, &resp_skb,
 				       sizeof(*resp), &var_data_len);
+	qtnf_bus_unlock(mac->bus);
+
 	if (ret)
 		goto out;
=20
 	resp =3D (struct qlink_resp_get_chan_stats *)resp_skb->data;
-	ret =3D qtnf_cmd_resp_proc_chan_stat_info(stats, resp->info,
+
+	if (le32_to_cpu(resp->chan_freq) !=3D chan_freq) {
+		pr_err("[MAC%u] channel stats freq %u !=3D requested %u\n",
+		       mac->macid, le32_to_cpu(resp->chan_freq), chan_freq);
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D qtnf_cmd_resp_proc_chan_stat_info(survey, resp->info,
 						var_data_len);
=20
 out:
-	qtnf_bus_unlock(mac->bus);
 	consume_skb(resp_skb);
=20
 	return ret;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.h b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.h
index ab273257b078..9db695101d28 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.h
@@ -59,8 +59,8 @@ int qtnf_cmd_send_updown_intf(struct qtnf_vif *vif,
 			      bool up);
 int qtnf_cmd_reg_notify(struct qtnf_wmac *mac, struct regulatory_request *=
req,
 			bool slave_radar, bool dfs_offload);
-int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, u16 channel,
-			    struct qtnf_chan_stats *stats);
+int qtnf_cmd_get_chan_stats(struct qtnf_wmac *mac, u32 chan_freq,
+			    struct survey_info *survey);
 int qtnf_cmd_send_chan_switch(struct qtnf_vif *vif,
 			      struct cfg80211_csa_settings *params);
 int qtnf_cmd_get_channel(struct qtnf_vif *vif, struct cfg80211_chan_def *c=
hdef);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wi=
reless/quantenna/qtnfmac/core.h
index d7491e965691..6fe82179df7f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -95,15 +95,6 @@ struct qtnf_mac_info {
 	struct wiphy_wowlan_support *wowlan;
 };
=20
-struct qtnf_chan_stats {
-	u32 chan_num;
-	u32 cca_tx;
-	u32 cca_rx;
-	u32 cca_busy;
-	u32 cca_try;
-	s8 chan_noise;
-};
-
 struct qtnf_wmac {
 	u8 macid;
 	u8 wiphy_registered;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/w=
ireless/quantenna/qtnfmac/qlink.h
index 8966fb68a61a..38d3d60926ff 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -632,11 +632,11 @@ struct qlink_cmd_band_info_get {
 /**
  * struct qlink_cmd_get_chan_stats - data for QLINK_CMD_CHAN_STATS command
  *
- * @channel: channel number according to 802.11 17.3.8.3.2 and Annex J
+ * @channel_freq: channel center frequency
  */
 struct qlink_cmd_get_chan_stats {
 	struct qlink_cmd chdr;
-	__le16 channel;
+	__le32 channel_freq;
 } __packed;
=20
 /**
@@ -1077,8 +1077,6 @@ enum qlink_sta_info_rate_flags {
  *
  * Response data containing statistics for specified STA.
  *
- * @filled: a bitmask of &enum qlink_sta_info, specifies which info in res=
ponse
- *	is valid.
  * @sta_addr: MAC address of STA the response carries statistic for.
  * @info: variable statistics for specified STA.
  */
@@ -1109,10 +1107,12 @@ struct qlink_resp_band_info_get {
 /**
  * struct qlink_resp_get_chan_stats - response for QLINK_CMD_CHAN_STATS cm=
d
  *
+ * @chan_freq: center frequency for a channel the report is sent for.
  * @info: variable-length channel info.
  */
 struct qlink_resp_get_chan_stats {
-	struct qlink_cmd rhdr;
+	struct qlink_resp rhdr;
+	__le32 chan_freq;
 	u8 info[0];
 } __packed;
=20
@@ -1373,6 +1373,8 @@ struct qlink_event_mic_failure {
  *	QTN_TLV_ID_STA_STATS is valid.
  *	&enum qlink_hw_capab listing wireless card capabilities.
  *	&enum qlink_driver_capab listing driver/host system capabilities.
+ *	&enum qlink_chan_stat used to indicate which statistic carried in
+ *	QTN_TLV_ID_CHANNEL_STATS is valid.
  * @QTN_TLV_ID_STA_STATS: per-STA statistics as defined by
  *	&struct qlink_sta_stats. Valid values are marked as such in a bitmap
  *	carried by QTN_TLV_ID_BITMAP.
@@ -1596,13 +1598,57 @@ struct qlink_tlv_iftype_data {
 	struct qlink_sband_iftype_data iftype_data[0];
 } __packed;
=20
+/**
+ * enum qlink_chan_stat - channel statistics bitmap
+ *
+ * Used to indicate which statistics values in &struct qlink_chan_stats
+ * are valid. Individual values are used to fill a bitmap carried in a
+ * payload of QTN_TLV_ID_BITMAP.
+ *
+ * @QLINK_CHAN_STAT_TIME_ON: time_on value is valid.
+ * @QLINK_CHAN_STAT_TIME_TX: time_tx value is valid.
+ * @QLINK_CHAN_STAT_TIME_RX: time_rx value is valid.
+ * @QLINK_CHAN_STAT_CCA_BUSY: cca_busy value is valid.
+ * @QLINK_CHAN_STAT_CCA_BUSY_EXT: cca_busy_ext value is valid.
+ * @QLINK_CHAN_STAT_TIME_SCAN: time_scan value is valid.
+ * @QLINK_CHAN_STAT_CHAN_NOISE: chan_noise value is valid.
+ */
+enum qlink_chan_stat {
+	QLINK_CHAN_STAT_TIME_ON,
+	QLINK_CHAN_STAT_TIME_TX,
+	QLINK_CHAN_STAT_TIME_RX,
+	QLINK_CHAN_STAT_CCA_BUSY,
+	QLINK_CHAN_STAT_CCA_BUSY_EXT,
+	QLINK_CHAN_STAT_TIME_SCAN,
+	QLINK_CHAN_STAT_CHAN_NOISE,
+	QLINK_CHAN_STAT_NUM,
+};
+
+/**
+ * struct qlink_chan_stats - data for QTN_TLV_ID_CHANNEL_STATS
+ *
+ * Carries a per-channel statistics. Not all fields may be filled with
+ * valid values. Valid fields should be indicated as such using a bitmap o=
f
+ * &enum qlink_chan_stat. Bitmap is carried separately in a payload of
+ * QTN_TLV_ID_BITMAP.
+ *
+ * @time_on: amount of time radio operated on that channel.
+ * @time_tx: amount of time radio spent transmitting on the channel.
+ * @time_rx: amount of time radio spent receiving on the channel.
+ * @cca_busy: amount of time the the primary channel was busy.
+ * @cca_busy_ext: amount of time the the secondary channel was busy.
+ * @time_scan: amount of radio spent scanning on the channel.
+ * @chan_noise: channel noise.
+ */
 struct qlink_chan_stats {
-	__le32 chan_num;
-	__le32 cca_tx;
-	__le32 cca_rx;
-	__le32 cca_busy;
-	__le32 cca_try;
+	__le64 time_on;
+	__le64 time_tx;
+	__le64 time_rx;
+	__le64 cca_busy;
+	__le64 cca_busy_ext;
+	__le64 time_scan;
 	s8 chan_noise;
+	u8 rsvd[3];
 } __packed;
=20
 /**
--=20
2.11.0

