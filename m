Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1AF100055
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfKRI1R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 03:27:17 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:61766 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbfKRI1R (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 03:27:17 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8Mlle014325
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:15 -0700
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by mx0b-00183b01.pphosted.com with ESMTP id 2wad7bc1rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 18 Nov 2019 01:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXRI+C9Yre5sB/1FYFw/rl4saw1GlvbslLeMbFT0WtgBxUc9+CqXB1I5YzG17y4cfxVZN4w6ed//VgugrdZ3XFFXAOqdQoqI4fXLg9Nr8DOhAVK0Zjb85VA9jRKiqUQsr8MARt8oBN2pJ6ps1gbVWxCWZp1tngr9aV0VbqhZQNzP44/py4vdKEEBRs3xKzmX9wzcz2LVy0bxFDo6vja4TVDfp4uDPo5YCgj1B2OW3rB0pewMNh1JRjg2ZIqU3SiI89qut5y/gXIdz+Gad3n+1OMbGiGrphJartoIPYcDZkITd8Kt/MrfLQsbCXYv563UOMrumQh7v+Wgbq3Gpv056Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz+aGO6FxesWLVKR36+ihU76ivqeb9mzzPkv9/LyX2w=;
 b=bTYymC4W0BrybCGXmykYj1a6SeqxTdE1ysFBC+aROobt4HUtqzehTD2CJhz7bzUrq8PQmFLskY7I57MZe8lwPTzi2hb/7hDSVvXVjJ1qv4ckIQyWnTdSh3bAtUNG9OvrmkkjlEoE8AdzDazwx06W857sU41XMykTMt+UfQtJ5aVSDrF3mYv+uQv3X7yl528WtnLG6b4wUc3xz+YmRlEGI9sFByLy9bsK1S3GLRlCX79zRjvMknX6qJTn2h44xKjISreWYa3wJBgI44a9poVMU5mzV0d/tj2pvy1I455Hydrj5QagzozG8A3TSODt/8TTf2POHnTBa6FQJNFXoP/Dng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tz+aGO6FxesWLVKR36+ihU76ivqeb9mzzPkv9/LyX2w=;
 b=osy7VqYpgHMUZfQBbzHYu2RV0qYCudIGejU3dC/XxXX9GE6gqUXGbRS+M04JoPHV0w39vQbBLe+n25Pz3hQGLx92E8zzZE/7nEvGfDeV/OnpN4Cwnj6hbHEWO3eXjcY7fGhu9JX9f6/k8UmJ3w0WkzqNhLLqYnr4g4DsLs75R9A=
Received: from CY4PR0501MB3698.namprd05.prod.outlook.com (52.132.97.154) by
 CY4PR0501MB3841.namprd05.prod.outlook.com (52.132.100.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.12; Mon, 18 Nov 2019 08:27:13 +0000
Received: from CY4PR0501MB3698.namprd05.prod.outlook.com
 ([fe80::b07b:5f7b:c148:ab17]) by CY4PR0501MB3698.namprd05.prod.outlook.com
 ([fe80::b07b:5f7b:c148:ab17%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:27:13 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB6320.namprd05.prod.outlook.com (20.177.254.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.13; Mon, 18 Nov 2019 08:23:13 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2474.012; Mon, 18 Nov 2019
 08:23:13 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 5/7] qtnfmac: signal that all packets coming from device are
 already flooded
Thread-Topic: [PATCH 5/7] qtnfmac: signal that all packets coming from device
 are already flooded
Thread-Index: AQHVnelrOi5WAr643ESUN0HcEyw7Xw==
Date:   Mon, 18 Nov 2019 08:23:12 +0000
Message-ID: <20191118082255.6032-6-sergey.matyukevich.os@quantenna.com>
References: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20191118082255.6032-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0053.namprd02.prod.outlook.com
 (2603:10b6:a03:54::30) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08592d55-6f81-4c93-f777-08d76c008d71
x-ms-traffictypediagnostic: SN6PR05MB6320:|CY4PR0501MB3841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB6320C658B0CF909D0AE833D5A34D0@SN6PR05MB6320.namprd05.prod.outlook.com>
x-moderation-data: 11/18/2019 8:27:11 AM
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(39840400004)(396003)(199004)(189003)(2351001)(2906002)(4326008)(71200400001)(71190400001)(8936002)(8676002)(81156014)(81166006)(107886003)(50226002)(3846002)(6116002)(103116003)(76176011)(7736002)(26005)(102836004)(186003)(305945005)(386003)(6506007)(6436002)(256004)(6512007)(52116002)(6486002)(1076003)(99286004)(2501003)(316002)(54906003)(5640700003)(64756008)(25786009)(66946007)(66556008)(66446008)(66476007)(66066001)(2616005)(478600001)(436003)(476003)(486006)(11346002)(86362001)(446003)(36756003)(14454004)(5660300002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0501MB3841;H:CY4PR0501MB3698.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5FqRQ7+kUukC6cfs2XyiO/ftgGxheedeg40nfOb4kLZSYlAtsnWzIo8SQ8v6y0InAKZhgAbUVJ/t47BVCu5PeCxJTTmYq1gNlH6zrEK10LPgyPnItSjathTi4TGc0jxhGLafRB+ZiypJHZKo5gbmUvwbwwGXjl0WrJkcXDwBwgQHrRg1KvAi25uSQkZOdUY4JfO4r788keNlmODgfIlvA4hw3qrbc9fVmv+L7uKkvFRThHCAFXp4mf4kz7bpEs7w/RnOcZYJMr43P9c8NbTKgzTQ8Ko/1rV4KgDZveLnjqweG9oJ7qsDZk7mpzz5WCRT2w9xQoHOBH2yUU/LGgliarcW0u2CHIVTszvAu/nzn01Lk9db+Egm9hUs1uwbf70Da9f1xjULoN8PQZ+YAj+7M6E5NkMN7wzV/C3k7oTykYXbbUDUNLFT7i944yOYHjD
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08592d55-6f81-4c93-f777-08d76c008d71
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RQzqbI+tdoDMLCt5LuwiCGF8MQ/tC5pbfuBaf2duNSwSYuz900qAwyJn0GjxPiqtbmHYvOaoWBQXEGbRCuGtWRXtzfI0aFYTkf8MTi+iInWZBUN71I98xd4P0WRuIbFcS8uL8s80+Ps0OXA4+MZsqLHmbGSICqYduZMQtL0Lhz/xdp50vjPDboLqRJV0cNwjaFW8zg19poZvOgeXOCLiFu6ql1EXkduoPepZRMNk7jA=
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 08:27:13.5674
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0501MB3841
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>

Firmware floods all packets that need to be flooded (multicast, broadcast,
unknown unicast) as required. Tell kernel bridge subsystem it does not
need to flood packet itself by marking each incoming frame
with skb->offload_fwd_mark flag.

Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/core.c      |  3 +++
 drivers/net/wireless/quantenna/qtnfmac/switchdev.h | 24 ++++++++++++++++++=
++++
 2 files changed, 27 insertions(+)
 create mode 100644 drivers/net/wireless/quantenna/qtnfmac/switchdev.h

diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wi=
reless/quantenna/qtnfmac/core.c
index a709e378928d..f5aa2c547b94 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -12,6 +12,7 @@
 #include "cfg80211.h"
 #include "event.h"
 #include "util.h"
+#include "switchdev.h"
=20
 #define QTNF_DMP_MAX_LEN 48
 #define QTNF_PRIMARY_VIF_IDX	0
@@ -866,6 +867,8 @@ struct net_device *qtnf_classify_skb(struct qtnf_bus *b=
us, struct sk_buff *skb)
 	}
=20
 	__skb_trim(skb, skb->len - sizeof(*meta));
+	/* Firmware always handles packets that require flooding */
+	qtnfmac_switch_mark_skb_flooded(skb);
=20
 out:
 	return ndev;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/switchdev.h b/drivers/n=
et/wireless/quantenna/qtnfmac/switchdev.h
new file mode 100644
index 000000000000..b962e670c4b0
--- /dev/null
+++ b/drivers/net/wireless/quantenna/qtnfmac/switchdev.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (c) 2019 Quantenna Communications. All rights reserved. */
+
+#ifndef QTNFMAC_SWITCHDEV_H_
+#define QTNFMAC_SWITCHDEV_H_
+
+#include <linux/skbuff.h>
+
+#ifdef CONFIG_NET_SWITCHDEV
+
+static inline void qtnfmac_switch_mark_skb_flooded(struct sk_buff *skb)
+{
+	skb->offload_fwd_mark =3D 1;
+}
+
+#else
+
+static inline void qtnfmac_switch_mark_skb_flooded(struct sk_buff *skb)
+{
+}
+
+#endif
+
+#endif /* QTNFMAC_SWITCHDEV_H_ */
--=20
2.11.0

