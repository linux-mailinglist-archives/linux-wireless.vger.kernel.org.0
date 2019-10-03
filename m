Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6158C9904
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2019 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJCHbm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Oct 2019 03:31:42 -0400
Received: from mail-eopbgr140101.outbound.protection.outlook.com ([40.107.14.101]:59779
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbfJCHbl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Oct 2019 03:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW9vG5cUfD/YOikjShgLZSkLRUwVPMn2GtD48awTBQj10UeTB0EcSwyzbmR2RNfDZ/+3S4ioPU2eS+f+assaLfhm+YJXO3lVScNNM+7traaQbS78RFxNkE2PoMI/Jcpj8Yd6q0hMTO8KgrhI1iZr/8C09zxVlCCqjyWsjn4Igon++0edR3gSJi2MnzNPNliFQ7Y9zj2soY+4j9+bUmIY+7tteEVwwyRLL1W//FH8g6BhqqesTxzkEMKkPA4tuE8vCB9u0pRaRClmAo7AFc9qwhDi7Bh26gEpOzJ41pPxxI+E9dlkhf/MIYXM3QWnhPLl8jPRaMO1ZiVfFVlHUQtTAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEFxNZ2LUZraG459TUGDy49BrW42XaBdYj2MXxJYaLM=;
 b=TW07+tX7znBGqjlpF2pH79BNI5Rdm/P6gAeC0lhjF4rgTcDPyCpU89VDdPeBrFhMGNuDMlxaqq+4rKyJxKldddprmJY2EQ9JAdtzy2UEvy/TWwaM48qjleiwrNlpsGt6FUccAS+71pHAR2yLcTQItbzsHXipxjP8uA6FGXITh7qWrkSmC3PnIDq34bRQljanjUsOwJlV2BkkI24eaJtKfkc+XInR7NZzsrLeXDrQunbPEVflj9CHt2dYa7wL7ZIXRGgqpm/QzZtWvab4nLTANsPBqXypdydnHQMza8PJ4djjJu5H/MyODuJgWiY3/ynOFHSJwPx5RYoxCiArd1CkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tandemg.com; dmarc=pass action=none header.from=tandemg.com;
 dkim=pass header.d=tandemg.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tandemg.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UEFxNZ2LUZraG459TUGDy49BrW42XaBdYj2MXxJYaLM=;
 b=Id2Ou2jk1ewgLPFjfDqVaLIjFU6q4SkKSIGTA+35vpWALFFCohm7wvzwe5r1HTLc588IiOkTuH7hqnqEkkW3eBFFdh712TeD1JlcSmez9cbZHpXaqI3knIIx09ELLE399GIx5y/b4d8XUHeQdUs++ZxH2dej4Xz3288V4SxXUTI=
Received: from VI1PR02MB4495.eurprd02.prod.outlook.com (20.178.12.18) by
 VI1PR02MB4480.eurprd02.prod.outlook.com (20.178.12.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 07:31:38 +0000
Received: from VI1PR02MB4495.eurprd02.prod.outlook.com
 ([fe80::5db2:c579:6338:a8a3]) by VI1PR02MB4495.eurprd02.prod.outlook.com
 ([fe80::5db2:c579:6338:a8a3%7]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 07:31:38 +0000
From:   Michael Vassernis <michael.vassernis@tandemg.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Michael Vassernis <michael.vassernis@tandemg.com>
Subject: [PATCH] mac80211_hwsim: fix incorrect dev_alloc_name failure goto
Thread-Topic: [PATCH] mac80211_hwsim: fix incorrect dev_alloc_name failure
 goto
Thread-Index: AQHVebyXio4StdsT3Ue4GeyFeI1tOw==
Date:   Thu, 3 Oct 2019 07:31:38 +0000
Message-ID: <20191003073049.3760-1-michael.vassernis@tandemg.com>
Accept-Language: en-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR03CA0066.eurprd03.prod.outlook.com
 (2603:10a6:207:5::24) To VI1PR02MB4495.eurprd02.prod.outlook.com
 (2603:10a6:803:b0::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michael.vassernis@tandemg.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [84.95.243.50]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af9795f8-e94e-43b5-78b3-08d747d3ba07
x-ms-traffictypediagnostic: VI1PR02MB4480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR02MB4480410A215A74A99D0B0EDAF89F0@VI1PR02MB4480.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(346002)(396003)(39830400003)(199004)(189003)(25786009)(7736002)(44832011)(14454004)(8936002)(6916009)(50226002)(305945005)(476003)(86362001)(14444005)(54906003)(256004)(2616005)(508600001)(486006)(71200400001)(71190400001)(66946007)(66446008)(64756008)(66556008)(66476007)(316002)(4326008)(6512007)(6116002)(52116002)(5660300002)(3846002)(99286004)(36756003)(26005)(2906002)(66066001)(4744005)(8676002)(81156014)(81166006)(107886003)(102836004)(386003)(6436002)(6506007)(6486002)(1076003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB4480;H:VI1PR02MB4495.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: tandemg.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZLS9BvaxAPh4uNtqjUJndEY0gAMi+HNYU5PjEhq2hHRHSPwcbALKV+YYA1z09jVgdj3UJaM3BXVrgKJZpwZN1NtH3zCJQrV5lt8TOy/aNoTrZEGeD34xc24hjUJkIJ2Ri6XhoqT8kAm0IFd/SUQVGociYrnSSLIiYeJdZHSX583JcQKMq/YiO/I/80ZXuMWxqam8Srusly9r5AU5CZkCyeALU1BGWMeufjSyU34HHnqokcUMojjwWf0vauuUbjAHO/qS+BaTsxVOBCzoFC8DnCwC/WnngYV7e4UUrJkWoTXKisDZ565DovMC5bLcQx8oVueymAtD/yoGT8cN+LAbNwg8sLG8VskcKw15M/S45g/uelq59b494VCo/kaYLjtCuxwWokd4MHqAEDKwiPvo4vxiYup/9jzZxrePNQd7CJU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: tandemg.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af9795f8-e94e-43b5-78b3-08d747d3ba07
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 07:31:38.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d690b55a-f04a-454b-9f62-fb1e25467a25
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2UXewISvdzZT1r6qNcahGhYtTXO1NgFEi9ZKdPO01E0K1L+IQX/j2KsFT7rJUPrK+klzReYA/Xqc9y7lG/7hXTokrIAd2gSL8Q00N3djFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4480
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If dev_alloc_name fails, hwsim_mon's memory allocated in alloc_netdev
needs to be freed.
Change goto command in dev_alloc_name failure to out_free_mon in
order to perform free_netdev.

Signed-off-by: Michael Vassernis <michael.vassernis@tandemg.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/m=
ac80211_hwsim.c
index 772e54f0696f..141508e01c31 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3929,7 +3929,7 @@ static int __init init_mac80211_hwsim(void)
 	err =3D dev_alloc_name(hwsim_mon, hwsim_mon->name);
 	if (err < 0) {
 		rtnl_unlock();
-		goto out_free_radios;
+		goto out_free_mon;
 	}
=20
 	err =3D register_netdevice(hwsim_mon);
--=20
2.17.1

