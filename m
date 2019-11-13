Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD826FAF4E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKMLH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:28 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:55360 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbfKMLH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:27 -0500
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xADB5OX4007583
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:26 -0700
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2059.outbound.protection.outlook.com [104.47.33.59])
        by mx0b-00183b01.pphosted.com with ESMTP id 2w7psq3cur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sj2RjH0XAZTuQmENTkr9fqm0u1WSdkfPaix0FZgEuv7uEKBxrYqBM1WDJUL07vz9q9y0/dEA5mWmc/vkMh8uN42P9T3R7KxTGfz6S5xKQZD6l3y4TzpYVA/jS8Gp9wiyrDYNx1pJhLcmRsMlsm/BkTOR6Z3sBUrCkV4E06Rjz2ir6vYETUzDLwsPkmX8zcznMWISUZYWgsra16UW11Ckr7s0I6KyL0Ozdtv8Rztz6XSV9SM3vaQgebdEZVETTXy31IzldjiyGTn5UAt/XjFa12sNO07VOStrf1fmA9siX2IEeZ/WGC3yMPIICXdOUMg9NNoRPLIjs4HBuYX6/JtdqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4zsj20ZuNk3B5KRgHgNJ4U3awY1Pm9COwDLkd15m8o=;
 b=W+nlMtKwZbNK4p21PkmbxreI20VN0gOPiqKaG4pl0t2RMcIR7lCXC+dX3xsRX7dc6BVqCEnnZbok/Q5rRbZ0rdtuGd/08n9CC/ygLU5fDqMC/9olF3iD5wQINUrlxHjl4YLtttvA9S7J7V5RGWW+r5r66m/S1sw6MaxBF3fjpXDo3lmCUuZaT1J7bO7wvFvht2yETY1S6aFXeQ7NxpK7oTtM3YIiF2TKgYG2pDqg6ZnDwp3dCByunuewggVvu1VwITyY7gy4GplPNu9yVE/MBJWXfF4G1+fQA9uliHtJjs9TWI/IxrC2rsk9r1nlPpDdyltBB6WTUJbIL8RhzUkPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q4zsj20ZuNk3B5KRgHgNJ4U3awY1Pm9COwDLkd15m8o=;
 b=iTjdtD0oS0cQWhi5901FDaBpYrNnxVt2GercPgZ/XyMwy++9ADjHoUIYFD9dns7DBRZWwzG+ymMzvk8KzsRjOW06eX9m1tPQMn1rqgQOnEm8hfK4eS6SoetQCjDOiLWX05eeyylQJ6H9efeOfOlN0wHCgMI0W131CioXV7TNCcM=
Received: from BL0PR05MB5250.namprd05.prod.outlook.com (20.177.242.33) by
 BL0PR05MB5586.namprd05.prod.outlook.com (10.167.234.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.18; Wed, 13 Nov 2019 11:07:24 +0000
Received: from BL0PR05MB5250.namprd05.prod.outlook.com
 ([fe80::ed7b:2348:5c70:1c84]) by BL0PR05MB5250.namprd05.prod.outlook.com
 ([fe80::ed7b:2348:5c70:1c84%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:24 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5789.namprd05.prod.outlook.com (20.178.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:50 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:49 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/7] qtnfmac: fix debugfs support for multiple cards
Thread-Topic: [PATCH 2/7] qtnfmac: fix debugfs support for multiple cards
Thread-Index: AQHVmhJyUSs/Ct9jK0S6pSz5L8/Oug==
Date:   Wed, 13 Nov 2019 11:06:49 +0000
Message-ID: <20191113110639.9226-3-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 53305c35-5389-444b-3275-08d7682994bc
x-ms-traffictypediagnostic: SN6PR05MB5789:|BL0PR05MB5586:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB578971D3374A0BEB153CEA31A3760@SN6PR05MB5789.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:22 AM
x-ms-oob-tlc-oobclassifiers: OLM:49;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39850400004)(199004)(189003)(6506007)(66446008)(64756008)(14444005)(2616005)(256004)(76176011)(305945005)(71200400001)(436003)(6116002)(86362001)(386003)(52116002)(7736002)(102836004)(2351001)(3846002)(5024004)(66556008)(71190400001)(2501003)(103116003)(186003)(486006)(446003)(11346002)(6916009)(476003)(26005)(66476007)(81156014)(81166006)(478600001)(8676002)(99286004)(6486002)(2906002)(14454004)(1076003)(4326008)(54906003)(36756003)(5640700003)(316002)(50226002)(66946007)(8936002)(6512007)(25786009)(66066001)(107886003)(5660300002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR05MB5586;H:BL0PR05MB5250.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: we8tQUHSlKYyRKLHYVKDXatslbkYwglWdx82Z/0eXwlto++bqgkKPfIFQ2Eozd9+Q/8sXgxf9WQCEpr+cltj6p0OsUetRm+vgssMZOBe+7duSq/g/mwSlL4MvyKpw0KlOTlz5GBCq8H7TrCl2jwfJpP0lER13KXNwPiMP+m3jGjSKsa8o8L4c8OPxDWVDjM2WmPRi1Ma3gG9mVW6Rit9A1gM6LOKNlktr8YpaRoLcFUScuIF2n1fuWKDFo4LRwGzxqlzDSILUdWSAbLzv7d6fzX7ag0SDJ/aRWTLit8RR9utdB6Uu+iLSX8nZpmZ47InUdLMfc40kAE7FpwMK15oxhnO7KIrNWr4uNHqRrfr2ViTtiBuBeAwWpQwp6gVl4nfNgM9kPXtEo3VE88lXXuClAPRWry8Bvb34NeR7zzsxbpwylRktFgSr9lSSKd5cQ85
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53305c35-5389-444b-3275-08d7682994bc
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03Jv7SdScyS0lD8MUsBcDv7Fwk3QjsMrTC/ruJcJ7WEqj21J93GAUCc21DCNTzv/fpulpZ9YpCAOQyZ/Dvi4EUduNT9M1in+yjRV7rXXkEwH9Zj1eQ/GAk0KPg9+jEuyuL6BCzH8LAlonjOLeJpJV5jfP/zr5N0DhGkh8HaKpWqHxpNQ2REMJMnvpQud4g+mFJE93owrDuITc+apaEZRWoTfIOm6qERlqvAuze1N73Y=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:24.5024
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR05MB5586
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix merge artifact for commit 0b68fe10b8e8 ("qtnfmac: modify debugfs
to support multiple cards") and finally add debugfs support
for multiple qtnfmac wireless cards.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/n=
et/wireless/quantenna/qtnfmac/pcie/pcie.c
index 8ae318b5fe54..4824be0c6231 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -130,6 +130,8 @@ static int qtnf_dbg_shm_stats(struct seq_file *s, void =
*data)
=20
 int qtnf_pcie_fw_boot_done(struct qtnf_bus *bus)
 {
+	struct qtnf_pcie_bus_priv *priv =3D get_bus_priv(bus);
+	char card_id[64];
 	int ret;
=20
 	bus->fw_state =3D QTNF_FW_STATE_BOOT_DONE;
@@ -137,7 +139,9 @@ int qtnf_pcie_fw_boot_done(struct qtnf_bus *bus)
 	if (ret) {
 		pr_err("failed to attach core\n");
 	} else {
-		qtnf_debugfs_init(bus, DRV_NAME);
+		snprintf(card_id, sizeof(card_id), "%s:%s",
+			 DRV_NAME, pci_name(priv->pdev));
+		qtnf_debugfs_init(bus, card_id);
 		qtnf_debugfs_add_entry(bus, "mps", qtnf_dbg_mps_show);
 		qtnf_debugfs_add_entry(bus, "msi_enabled", qtnf_dbg_msi_show);
 		qtnf_debugfs_add_entry(bus, "shm_stats", qtnf_dbg_shm_stats);
--=20
2.11.0

