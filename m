Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09236FAF4F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfKMLH3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:29 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:25208 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKMLH3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:29 -0500
Received: from pps.filterd (m0059812.ppops.net [127.0.0.1])
        by m0059812.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xADB6RLM011870
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:28 -0700
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2056.outbound.protection.outlook.com [104.47.41.56])
        by m0059812.ppops.net with ESMTP id 2w7pst45e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAqz2Rq65vkQi9vmSGbgFMqiWqsAi7WqaYGxSPOHmDyRfcF8fB7av5277/orDKrPSBxGVbWyRfvr17JCSVqyiTbPVSk1O+0a3U8jyDmbWCJp/aMajU8Es8o9ejigu1mDaVbK9bu7sj3P7GIFil25tjaAIhDAv7+ga3Uw3xxU4p3XpN/bfP9JgXKEwrvyjeczfQPxAtafC9Z9oJJ1mfa1vppQ/KP/cXg8SXANwNcpvw1Wsc/AvcWlNvPTWAofwd7x3NlaJ7RQCSYUw2I3dj7D8BVnuKiUrizv0CzKqC94dssWiREBHCt/AMSu2lw/vJGzl5dRYkh3KdaAwI9m575zTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg+Gnd8bGvtllOvvsLWOzKseLueYChQAV26aDdQafs8=;
 b=CF02bAjzGb+sSHEDB6MIUpKjoapJbQTQv3V4wCPd9YqzPp1bl3w5oWUKx5Jj0r/h8GLIOHQPwzYezy6nKRX/hyt5mvjlmTew+ME+O6nfTWrC0MPyT0So1ivtS+uKaCLg4NEoT0jGKkxoVb2ncQI1Nk1WGyB6mu0M0j2ioGyKwgCA34JtQCeFFzAGd7wj9/5e+Y/B1PCg/MtN5+OX1R/dabzUo2FQQ7OIikR4yqcOvA2vYWM6beJd/pUICiAdkOMw5P/CaXKH7lwbz8WsOl2DmtLO1UbfeefdGFx4ejV80G9zLdnXDrVlmtLnI6l79nexaSBLICPPW42QGbcmMX0Emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vg+Gnd8bGvtllOvvsLWOzKseLueYChQAV26aDdQafs8=;
 b=Ez+ddsz2nc+oHpsB4pyifNNdc2ja/kPWx97wfJ1K1LvLW/VlQFATHq9VSJnwfj/Vrf7Wraj+A60RRDZJuULMBjbSE3HI8eJqsnutCuq1gv+9Bd+cOPuW3jyB+LXcLUFmP7KWqgBsXgX0k9U0eshgIM/pAQdP3XNdNLE7DAenfH4=
Received: from CH2PR05MB6966.namprd05.prod.outlook.com (10.186.148.95) by
 CH2PR05MB7078.namprd05.prod.outlook.com (10.186.149.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.15; Wed, 13 Nov 2019 11:07:26 +0000
Received: from CH2PR05MB6966.namprd05.prod.outlook.com
 ([fe80::8ca6:eff6:b34d:49da]) by CH2PR05MB6966.namprd05.prod.outlook.com
 ([fe80::8ca6:eff6:b34d:49da%6]) with mapi id 15.20.2451.018; Wed, 13 Nov 2019
 11:07:26 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5789.namprd05.prod.outlook.com (20.178.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:52 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:52 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 3/7] qtnfmac: fix invalid channel information output
Thread-Topic: [PATCH 3/7] qtnfmac: fix invalid channel information output
Thread-Index: AQHVmhJzatQV28nWRkCzGr5RyHMlZA==
Date:   Wed, 13 Nov 2019 11:06:51 +0000
Message-ID: <20191113110639.9226-4-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 828cce2f-3f6f-4c97-7ada-08d7682995f8
x-ms-traffictypediagnostic: SN6PR05MB5789:|CH2PR05MB7078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5789830F68B16C9E8D6D333FA3760@SN6PR05MB5789.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:24 AM
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(376002)(366004)(346002)(396003)(136003)(199004)(189003)(76176011)(5660300002)(478600001)(446003)(2616005)(11346002)(71190400001)(6512007)(486006)(476003)(2501003)(81166006)(4326008)(81156014)(256004)(71200400001)(8936002)(305945005)(7736002)(107886003)(14454004)(6486002)(8676002)(6916009)(316002)(6116002)(66476007)(3846002)(66556008)(5640700003)(66446008)(64756008)(103116003)(26005)(386003)(25786009)(436003)(36756003)(50226002)(186003)(2351001)(52116002)(2906002)(86362001)(54906003)(6436002)(99286004)(66066001)(6506007)(1076003)(66946007)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR05MB7078;H:CH2PR05MB6966.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrkE9pePverRbwdJe81F8jvUVCiM79EFzp1Tm1RsrQZRFHtOpQ7NbOXEy4MHakxuqjY/bfR7yPIJfBmubEDr5onTNi+JUE6xmlwHsZklLpHBYOkL6Bm6kO2tHFXsRHjSn66ST1mZCkMjHJMtNuYI9IUaqmmrj8+HTnvx8uZbmJfzw7W6+WUg4nQ4M7YD8OXuKeLWs/QjSssv2Z4ccus0bMa7naaKTFiFGqdVlaZB9pS7kJA2XV9e+smSCqabxQzuf4rg8Ef8CnwTYByHbPp8Pkngdxx0rBh5rYx21CeCeljIoeUgmJ/4D8lfBX74k3+UcNuY59bP2AkqgnlNFMCx9y/kafdnx5YmGA0LeSEZjng/Y6iXCMqat4Zr6MnBZ137drUleTbaMny3t7VQyFIfJWAKgPfWGRiq86d+Dc+anaW/oD1LnvxUMWaya15bWaD+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828cce2f-3f6f-4c97-7ada-08d7682995f8
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cF+5Zbe34BbZbTGTG9a5UnCzLt1fBL3/+7fAAimNWaaF3336uwV8XEfDfYrEhg3K5p/+xm7bQbljxDEUe/4s3ypSNY8HYWJsGq2e3B1nHatWo57Lk9EnQUwaMkDC6MydMWGES4tHH0JyCzvLE1pBcfdHJxXK1SBiiic8b8GCyoAgs8Sq1rN6x8SlR+/s2XUapF4TJndEYByDw8nGT+3DfhMQvjuxztH33vr93YVFRkk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:26.4164
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR05MB7078
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not attempt to print frequency for an invalid channel
provided by firmware. That channel may simply not exist.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/event.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/w=
ireless/quantenna/qtnfmac/event.c
index b57c8c18a8d0..7846383c8828 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -171,8 +171,9 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 		return -EPROTO;
 	}
=20
-	pr_debug("VIF%u.%u: BSSID:%pM status:%u\n",
-		 vif->mac->macid, vif->vifid, join_info->bssid, status);
+	pr_debug("VIF%u.%u: BSSID:%pM chan:%u status:%u\n",
+		 vif->mac->macid, vif->vifid, join_info->bssid,
+		 le16_to_cpu(join_info->chan.chan.center_freq), status);
=20
 	if (status !=3D WLAN_STATUS_SUCCESS)
 		goto done;
@@ -181,7 +182,7 @@ qtnf_event_handle_bss_join(struct qtnf_vif *vif,
 	if (!cfg80211_chandef_valid(&chandef)) {
 		pr_warn("MAC%u.%u: bad channel freq=3D%u cf1=3D%u cf2=3D%u bw=3D%u\n",
 			vif->mac->macid, vif->vifid,
-			chandef.chan->center_freq,
+			chandef.chan ? chandef.chan->center_freq : 0,
 			chandef.center_freq1,
 			chandef.center_freq2,
 			chandef.width);
--=20
2.11.0

