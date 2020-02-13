Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1596915BDF0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgBMLpw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:45:52 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:59882 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729511AbgBMLpv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:45:51 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBgkcc010676
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:45:50 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u4wm5v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:45:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjmylB99gXHoqpxd3pC0l02sy13GA+WS0QXqIUEqB0uVDY9BxMk8QxKSXg6KFwQBHsCc+J1cDVs92v3oxLVpIj6XXuWTlFfFmHACIpJDfXYdONmtaE3qqiqWhWW9svpqpnlDoMDg+4SSm4EfArcstD1DtJRnpjeyX1KTg2QlpTaK+OshcZpu3F3MV0iuo3Iuq5XiNUQpvVTv+qr8MuhItoGFnf7EL9a6sloYU1wNLbfzUJFQyJe2pnwvLku6QPxASKAWA5OckybbTullSLAPoLE2MN6xGkniIdPggUfGnYZegUDDgNbyafrl9vRGwaMSpKo07NRSI9nJCZ55SuG9jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Izhs+NyYQ62BcnKG1MKCy++6VR4qedgkRrM5ZBWxfE=;
 b=cQ5HS9XB79tdGoRJxZKGPvp90CXeqHy04rJV8Z/EdLtkp5lxPoL09uf0gXGrP//1tJ3hBA/MmVRTlDTFHgU8Mgcy7ddlYVLVx14ScqA6xSsd7IqCmnWUxMc1SQwzwTJhN1tr1H8e2bPQu9831BsvIigRiT/tjcoObFomw53zj8nwvW2g3fL0OS3AnQgljSWfAKl1wZMmYWniLyXOwF2CLY6k0aeGzn3rXv6TM0WRTn4qTUgCiQQiArHZ4e5gyQS2xqsygiFVtwOj1fFMPa6r3ogVF7uJ6hLmC+rcoqWEOJi/VG0CNQk225CQTH9tA6UYP9d5X9sX/yP//7rplM/m4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Izhs+NyYQ62BcnKG1MKCy++6VR4qedgkRrM5ZBWxfE=;
 b=RekmkSbRGdYUCOQqUmaiz07wrsxXiRSft4V/Oh09M/4A+jVsvH5baaOtouTMwjb8YSNiq+ifIvhYOGM0sQAFrpXbF8t4QB0YtzjhXoPaiiJaW3fh0thDIGk9BtBIqei3784ZLrJucJmfEuF9Ylh4Jrb8JCOzEft7tZ5ScKR7UyI=
Received: from DM6PR05MB4828.namprd05.prod.outlook.com (20.176.111.225) by
 DM6PR05MB4954.namprd05.prod.outlook.com (20.177.222.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 11:45:48 +0000
Received: from DM6PR05MB4828.namprd05.prod.outlook.com
 ([fe80::9985:9fa4:7d67:404d]) by DM6PR05MB4828.namprd05.prod.outlook.com
 ([fe80::9985:9fa4:7d67:404d%7]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:48 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:27 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:27 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:26 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 0/5] qtnfmac: WPA3 OWE/SAE support for AP and misc fixes
Thread-Topic: [PATCH 0/5] qtnfmac: WPA3 OWE/SAE support for AP and misc fixes
Thread-Index: AQHV4mMVlJ5pFtoJcUOL2OgygdliIw==
Date:   Thu, 13 Feb 2020 11:45:27 +0000
Message-ID: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 13769855-3c53-49b8-0886-08d7b07a37f5
x-ms-traffictypediagnostic: SN6PR05MB5597:|DM6PR05MB4954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5597B278EDF1C2929FCE967BA31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:45:46 AM
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(316002)(6486002)(71200400001)(8936002)(103116003)(81156014)(8676002)(81166006)(1076003)(478600001)(2616005)(956004)(4326008)(86362001)(36756003)(186003)(16526019)(26005)(2906002)(52116002)(7696005)(107886003)(64756008)(66556008)(66476007)(66446008)(6916009)(5660300002)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4954;H:DM6PR05MB4828.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MGUdOEGMWNdFy0uy4kf+fmDlDggz1svNfWtZMnS3XJaf+EmPocQe14q9eeWN+19U7E2sSj9j0O3uq/Y4GDST47SINcFyVK+ERZ24ouFcDKovJFJEB07uCxRomsr7GBouazhI/1mcDoTISNPU3uZ8E/51BJYYFVAA6psxz/6s19O9k932qdmIu0jpX9u1DsRoxdwJ5hRLSsppODVa+s6M+4kkY+ag5vLDwEICFLz4a5Cvg32ayrGx4Thvlp0ElSeU6Mk/4zxfGxb81NhrhC5qHxRlQLk/SVspho/OvRp6kT3WEeXjWYzhdiH9Ggzd8n8caEvBDTCcMlPZHcGkhrYoUxJhPC7zTtlxOU/CGu8XVbLsfq/mZuy3wuqtwp3J1ZeP2ACZ5E+5TQqHg23Lr0flIGTPV+MJtiEhkjjxWi9V+5hx5iqSXzG1Mi+9ASPXcmX
x-ms-exchange-antispam-messagedata: IrJK3hI88bQOiqo135RgQpuh5kBsMluIs/JArbtmlcLJONpwoPOQWDxcNOSyqZP1jq/rc3JQ7HqaevbJXja2mR5rBK7wCnirKZeW3FjGIBVLV+XeK25UV7aPapA2E3Be7QaX73ttBLuAVXgVTPrTWQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13769855-3c53-49b8-0886-08d7b07a37f5
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AFJ9M7fvKRzn1jk4LKt/RyD3mUdqFHwZiEhr9BkO9Gj+0LZMulFHw93zxITAwpnTTpTSLhBk0O40OyiucYEUyXxp/oUornIly4kMzCPZ1wn8nZ2MydBMFq8lz1yTjSwIW0rlXcq3Efg6qVpd7mAbpeQZg8YGZBtl1ib1XK8mYP5MlGoda3Ul1IS5IJV2QRPU4BiRLbCB4bAVsAAKWddfpiqgpsCHUztYD7i2Ox635Uk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:45:48.4192
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4954
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=648 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130093
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle and all,

This patch series includes regular portion of updates and features
for qtnfmac driver. Major change is WPA3 SAE and OWE support for AP.
Besides, there is a patch that assigns each wiphy to its own platform
device when multiple radios are provided by single PCIe function.

Regards,
Sergey

Dmitry Lebed (1):
  qtnfmac: add interface combination check for repeater mode

Sergey Matyukevich (4):
  qtnfmac: support WPA3 SAE in AP mode
  qtnfmac: support WPA3 OWE in AP mode
  qtnfmac: set valid edmg in cfg80211_chan_def
  qtnfmac: assign each wiphy to its own virtual platform device

 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  | 53 ++++++++++++++++++=
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c  | 38 ++++++++++++++-
 drivers/net/wireless/quantenna/qtnfmac/commands.h  |  2 +
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 18 ++++++--
 drivers/net/wireless/quantenna/qtnfmac/core.h      |  5 +-
 drivers/net/wireless/quantenna/qtnfmac/event.c     | 54 ++++++++++++++++++=
++--
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     | 33 ++++++++++++-
 .../net/wireless/quantenna/qtnfmac/qlink_util.c    |  2 +
 8 files changed, 187 insertions(+), 18 deletions(-)

--=20
2.11.0

