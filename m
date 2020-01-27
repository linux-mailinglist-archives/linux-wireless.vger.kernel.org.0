Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF414A23E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 11:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgA0KsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jan 2020 05:48:24 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:60760 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbgA0KsY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jan 2020 05:48:24 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RAhEBP020883
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:23 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00183b01.pphosted.com with ESMTP id 2xrkum3uu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2020 03:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMmnWFYLlTGeVbwe7VSFNAb7eVH+kCpEA98kp8TfCsmOfUj0GM82+1RrKXOlS8Eb79g6FkwayWghANUzSzQFYRtP2hRO5ZoUWs+yhOxjWSSRGg9smO3uvuiLkx/+FZVxxhUtGmQBnPyIwcu+5jffgJg7CiUB9r1wwOdU1e5iS06nbVrA+ScqxzfOaM81v0dRo0iqxtxFFUHwE0iRYTJi14fxhHj5Lfji1uvkD4Xyv1ToUV3iuys3vtEtUM+wHfPiODfXWlNtuq8XqNpEXCaVaIpbHw0xpOyLDPoDLPsW1pJG91KmqjG6lmMV2oZ2BuNLsw08OWyvUh1/x1eyKno5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJXAxJb83EH5/8rOzK04//0qU6WmHjq1/3weduq6SQw=;
 b=Co/LShK0Gr+G3PDrMWO0SDSlD7RBs367M/TQT+a2mcHStTcfB69NfrFlLFzpVr5w3t74nxntH37RfhoEZKQ7HB5fume7f6pYpiOC6f8NuqXj/NXTtLjZTFd7Xm0LXDqhIH5bA5FmeIf/RgBiZSDjx0EmAtYSUaf8e3JnMdDVZBoKspc6kpprc/6EyN+Mn7P2YXjqeIkc0lIDURQXGlgX6ev2VZGaCi4mcsPVsoVSu9a8kx4XwQu7U5G8eDymdz7UpRehFu52VWfNGSuruJAqWj2RigsAAHaorcHFeV3/GqJbaiUU/cNKykzesA0XLFqkaZWxDm4ylQPfPnRIIPlBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJXAxJb83EH5/8rOzK04//0qU6WmHjq1/3weduq6SQw=;
 b=k+Aj67E1JXTt88LtYRwO//Z5xeDI30tALX8JgEfuU+vNj6voLKbvfNUVv+ayMBhv/4mM/afx5i/9WB8XSQ1ZRGtftEhwwnmk3m54v7sSn8D2pqJckDUpyBibPICnLHEHmERzu4sRvhPrtguT8juF0hlpd6BCkWJr1VEIEqDGwcM=
Received: from SN6PR05MB4765.namprd05.prod.outlook.com (52.135.115.147) by
 SN6PR05MB4464.namprd05.prod.outlook.com (52.135.74.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.15; Mon, 27 Jan 2020 10:48:21 +0000
Received: from SN6PR05MB4765.namprd05.prod.outlook.com
 ([fe80::a182:388a:1296:d0fa]) by SN6PR05MB4765.namprd05.prod.outlook.com
 ([fe80::a182:388a:1296:d0fa%6]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:48:21 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5391.namprd05.prod.outlook.com (52.135.111.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.18; Mon, 27 Jan 2020 10:46:58 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2686.019; Mon, 27 Jan 2020
 10:46:58 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:7:67::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.14 via Frontend Transport; Mon, 27 Jan 2020 10:46:57 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 10/10] qtnfmac: fix potential Spectre vulnerabilities
Thread-Topic: [PATCH 10/10] qtnfmac: fix potential Spectre vulnerabilities
Thread-Index: AQHV1P8ZYE5Gmf0CBk6P16moh5B8sw==
Date:   Mon, 27 Jan 2020 10:46:58 +0000
Message-ID: <20200127104634.7248-11-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: b3172e1e-3db7-476b-b0c3-08d7a3163ba0
x-ms-traffictypediagnostic: SN6PR05MB5391:|SN6PR05MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5391395BFB6E5FC8BB9D42D7A30B0@SN6PR05MB5391.namprd05.prod.outlook.com>
x-moderation-data: 1/27/2020 10:48:19 AM
x-ms-oob-tlc-oobclassifiers: OLM:117;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(346002)(366004)(376002)(136003)(189003)(199004)(316002)(81156014)(107886003)(4326008)(5660300002)(1076003)(81166006)(8936002)(8676002)(54906003)(2906002)(6916009)(36756003)(6486002)(478600001)(71200400001)(7696005)(52116002)(86362001)(103116003)(186003)(16526019)(26005)(64756008)(66446008)(956004)(2616005)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4464;H:SN6PR05MB4765.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i7SUzcADkscy576swfMXUfXY3I5kUeHLXAtnI98UP7XnJde0hg+JabERPv8ot/0SopoUj/sjGQc7MgRz0wjj+xyzGsn8j3/K1nRTLZVdujT5UdhRy+ybl6MBb4irTs/Uqyt2419JXb5zjTRA9dQQIAA/Rlbz2wBRw3LMOz6OwgpxRZDy/THo9asTNOyVoWAED5X0DcmpnJ3UweUyt0wN2smZJoa/Dp/ATYO1cojujPOuq1nymh74biezLl4jIdIZ3PnMYdhGTTJYcrs9nNZpuTIx495LW5JmzkgJd+De9t7SsUkfrbcB/ni7rwhsIaAi6i3UOifEhq8njQ33KzQH1mjevdBY6fW4MpGI5IvdCO9KIbFL0jKndEomBaO/6dxru4B0Yqu7Y5sjG6gMaIgLDrbVJCqwVbMY/rf04FnhP+tO4TQlhsj6jas+XQg3TOZ0
x-ms-exchange-antispam-messagedata: hzos2pBCUuE0+3gryGkQ7LupkGuFoQGaa/G3vs+YCOYnutW5pwhSR8zCOrA6XYHDyGGCUBssT/Nw2/y48lfwVuwXBmUpRxNSelXgZaiEnddTrcbBa1r+bwDzmB7eIfXFw0u064rFoYqfKPYLfiPFeQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3172e1e-3db7-476b-b0c3-08d7a3163ba0
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoim+a/Wx0hSUn4JukEqhyDbHcSalJoo4z9cIH+yr+WKiEBE4XZTxQaGwnSJvAsRS0yY/aYwGZsOIs0GirAVnweVxppWAuLpAe3vjIW6rCo/d4BUOeT9O8LtHpysCZk3c1Kd4TolsaesnAzwXOGunRygMyDzQuA2lr3oWQYbqxy6YTCRvsD4D3sAbSkBztPVwvXqTTr84cm2rZHH9E+I9pGIUWHbWFq9DL+wWhj/9Dk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 10:48:21.7088
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4464
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

Fix potential Spectre vulnerabilities and other warnings
reported by smatch:

drivers/net/wireless/quantenna/qtnfmac/core.c:49 qtnf_core_get_mac() warn: =
potential spectre issue 'bus->mac' [r] (local cap)
drivers/net/wireless/quantenna/qtnfmac/core.c:51 qtnf_core_get_mac() warn: =
possible spectre second half.  'mac'
drivers/net/wireless/quantenna/qtnfmac/event.c:671 qtnf_event_parse() warn:=
 potential spectre issue 'mac->iflist' [r] (local cap)
drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c:912 qtnf_pcie_skb_=
send() warn: variable dereferenced before check 'skb' (see line 881)

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c            | 4 +++-
 drivers/net/wireless/quantenna/qtnfmac/event.c           | 9 ++++++---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c | 2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index 74c9aa297ec9..9e666fac8b5f 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/if_ether.h>
+#include <linux/nospec.h>
=20
 #include "core.h"
 #include "bus.h"
@@ -41,11 +42,12 @@ struct qtnf_wmac *qtnf_core_get_mac(const struct qtnf_b=
us *bus, u8 macid)
 {
 	struct qtnf_wmac *mac =3D NULL;
=20
-	if (unlikely(macid >=3D QTNF_MAX_MAC)) {
+	if (macid >=3D QTNF_MAX_MAC) {
 		pr_err("invalid MAC index %u\n", macid);
 		return NULL;
 	}
=20
+	macid =3D array_index_nospec(macid, QTNF_MAX_MAC);
 	mac =3D bus->mac[macid];
=20
 	if (unlikely(!mac)) {
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index 9d3849488fc7..7e408b5c5549 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
=20
 #include "cfg80211.h"
 #include "core.h"
@@ -632,18 +633,20 @@ static int qtnf_event_parse(struct qtnf_wmac *mac,
 	int ret =3D -1;
 	u16 event_id;
 	u16 event_len;
+	u8 vifid;
=20
 	event =3D (const struct qlink_event *)event_skb->data;
 	event_id =3D le16_to_cpu(event->event_id);
 	event_len =3D le16_to_cpu(event->mhdr.len);
=20
-	if (likely(event->vifid < QTNF_MAX_INTF)) {
-		vif =3D &mac->iflist[event->vifid];
-	} else {
+	if (event->vifid >=3D QTNF_MAX_INTF) {
 		pr_err("invalid vif(%u)\n", event->vifid);
 		return -EINVAL;
 	}
=20
+	vifid =3D array_index_nospec(event->vifid, QTNF_MAX_INTF);
+	vif =3D &mac->iflist[vifid];
+
 	switch (event_id) {
 	case QLINK_EVENT_STA_ASSOCIATED:
 		ret =3D qtnf_event_handle_sta_assoc(mac, vif, (const void *)event,
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c b/dri=
vers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
index 8e0d8018208a..dbb241106d8a 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pearl_pcie.c
@@ -593,7 +593,7 @@ static int qtnf_pcie_skb_send(struct qtnf_bus *bus, str=
uct sk_buff *skb)
 	priv->tx_bd_w_index =3D i;
=20
 tx_done:
-	if (ret && skb) {
+	if (ret) {
 		pr_err_ratelimited("drop skb\n");
 		if (skb->dev)
 			skb->dev->stats.tx_dropped++;
--=20
2.11.0

