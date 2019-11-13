Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75FFAF50
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2019 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfKMLHc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Nov 2019 06:07:32 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:17430 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726165AbfKMLHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Nov 2019 06:07:31 -0500
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADB6PKn012523
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:30 -0700
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2053.outbound.protection.outlook.com [104.47.48.53])
        by mx0a-00183b01.pphosted.com with ESMTP id 2w7pt7m9bs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2019 04:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSpdvtbetSTWhoPMYLZGhPqEWmZ6Fx16y2V5gDteryTaTgDjZs1WwH9U31xB9YCz+xc7vfz6kEDQXz/BZK/MkHkN5krGaEw9zRiyVIvyJ2qTwOTXN0XMTM/cqbhWtOn/C9DngmTSBNkWmWKZNeSug0fZQZRX8iGe1LW+8tRFZwKakQaAcP0a94SFMn619yXKbUuRVCrJNXZejaLZ2eZClhSJzMIKa5j5UCDASM5E5eausCp27QMlc6u1Wa4ssGOjOt1EVM6VW1m0tMDM10znr1osYZX2qaNd7UAe4eZT4bdCgospbMCiPUJ65guGTrmpSvPBjAvCVuBcnfL1Cc7chg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w1rmwnrdANcVo4yw58rMc8Lkt3Cf1iEdH29ntpvYro=;
 b=JqZ09WKkZICAmYEjaWQBhj9m8mv1doSxZE8fg4KiNeqTM63985rzpz6RLx5xnNLQ309unjw3rpRZWP0ZfkhJ7XVQhzhRCg9ohGFwPsgDzxbnJDGYDskYH1vE+78wIbfRKFPHbii10s9LmRIDJbWuPzY4lBfgwnjZbHWKzvfMeiBkCHZNoqQZAPLjjuPWkWjgSpZBMiRcBEu0aqdV8w21MzRTqF1koH2rqZUdET4PGfD8hbilfuEGkJ4K2ayh1Ug8u+CQ4IjtMP1C5tEIq7bpA2+t/4oi5rhhByoOdM3fR+8TK22B4QmZZMeCF/vt//4ZWJ9x419jx+qLobEHq9DVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+w1rmwnrdANcVo4yw58rMc8Lkt3Cf1iEdH29ntpvYro=;
 b=i/cvI/nXxEnXDkMk3Rd5ra+DZLPXwpNLIj+0DD8b+6hQM41uY+6owXmSCXfDO8EwoXngrtwdxnDiVhBmd0GtUyThJFSwOXEg6sR9miiGHRuXpeXTO04nAQAYTYCvuXIzEHECj5NgAY78+TbBqWCz7hfbHkIuMNmL/CYlGYdOvO0=
Received: from BN6PR05MB3316.namprd05.prod.outlook.com (10.174.95.138) by
 BN6PR05MB3186.namprd05.prod.outlook.com (10.172.146.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.7; Wed, 13 Nov 2019 11:07:29 +0000
Received: from BN6PR05MB3316.namprd05.prod.outlook.com
 ([fe80::8cd6:2f36:a9a8:292f]) by BN6PR05MB3316.namprd05.prod.outlook.com
 ([fe80::8cd6:2f36:a9a8:292f%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:07:28 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5789.namprd05.prod.outlook.com (20.178.7.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.17; Wed, 13 Nov 2019 11:06:47 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::61a0:dd3d:3477:29c9%5]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 11:06:47 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/7] qtnfmac: fix using skb after free
Thread-Topic: [PATCH 1/7] qtnfmac: fix using skb after free
Thread-Index: AQHVmhJxxthIf+xvJkqR9oCrSfPpeQ==
Date:   Wed, 13 Nov 2019 11:06:47 +0000
Message-ID: <20191113110639.9226-2-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 93d6a383-dac2-445c-1636-08d768299375
x-ms-traffictypediagnostic: SN6PR05MB5789:|BN6PR05MB3186:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5789C734C8DE1136ECF06C0DA3760@SN6PR05MB5789.namprd05.prod.outlook.com>
x-moderation-data: 11/13/2019 11:07:25 AM
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39830400003)(366004)(136003)(346002)(396003)(199004)(189003)(486006)(2616005)(102836004)(76176011)(5660300002)(186003)(6506007)(2501003)(446003)(11346002)(36756003)(436003)(1076003)(476003)(86362001)(52116002)(26005)(66446008)(66066001)(66946007)(386003)(64756008)(66556008)(66476007)(478600001)(14454004)(6116002)(6486002)(54906003)(107886003)(99286004)(6916009)(71190400001)(71200400001)(5640700003)(3846002)(8676002)(81166006)(25786009)(103116003)(316002)(6436002)(81156014)(305945005)(7736002)(4326008)(50226002)(6512007)(2351001)(256004)(2906002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR05MB3186;H:BN6PR05MB3316.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1DvZHfK1PhEO3+r9N2sITiZkvM49AtpKME7x9UU5+qxm0m23h6dVoGkKL/AinPnWvooq+5ZwHEPVcVOGRel+9rGu+DdkF1xExnyZhTKqhH7QjBAto3NhxDPbWbJ4rEuNEWtFY7S0+Ehl0iwk7/8r80B3Ic1QFHLip3jPr2hjlwTwgQJN6Mms6eC3nu7FeajtUWIxMeUr0uKF/hcdNUV67QWP9EZzgOzEo+j2eMc6Kmdp6iKP6ImxHMZYKjqBy1Tyycg3EsjSimdNCQsmOsd1qkBetf0BdRZLinNnGUdpqGk7EaO4QWl95rk2/B6MuFHc6ns8apV6mCYCcY60zdYT+Ddz44xGauSLfLA6AY8Ib21kAlmEfm0OSAMwxUjM2WEnB6WWks2hfPJG5UxNCXsZwoMyPzdp4LLUEm6hrVRcqpoUWjQseTIku5P4ehq7ZPQ4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d6a383-dac2-445c-1636-08d768299375
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVlMSShtyDq5+ATTyyi0qGsbCqf4jhK9IwHcyyvBJ/3fOxouF3PoNhKNe2MsN9gfgfi9houLfHMbQIy07BmOyde1f4XYD5V5KNrrfJecP8AtB4EjRCtWkJMynUBrtZZBEFLtSeCaL1FkAHeqQzgKO12l3zvtjwEaa7TU/4DVHXnBfma3Kso6gSUzy4WswXykTGBP1AV5mN2JCC/vDSKg4k8nJukpNDRe28VZqFiFLyc=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 11:07:28.1453
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB3186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-13_03:2019-11-13,2019-11-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=811 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

KASAN reported use-after-free error:

[  995.220767] BUG: KASAN: use-after-free in qtnf_cmd_send_with_reply+0x169=
/0x3e0 [qtnfmac]
[  995.221098] Read of size 2 at addr ffff888213d1ded0 by task kworker/1:1/=
71

The issue in qtnf_cmd_send_with_reply impacts all the commands that do
not need response other then return code. For such commands, consume_skb
is used for response skb and right after that return code in response
skb is accessed.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/commands.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/commands.c
index dc0c7244b60e..c0c32805fb8d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -83,6 +83,7 @@ static int qtnf_cmd_send_with_reply(struct qtnf_bus *bus,
 	struct qlink_cmd *cmd;
 	struct qlink_resp *resp =3D NULL;
 	struct sk_buff *resp_skb =3D NULL;
+	int resp_res =3D 0;
 	u16 cmd_id;
 	u8 mac_id;
 	u8 vif_id;
@@ -113,6 +114,7 @@ static int qtnf_cmd_send_with_reply(struct qtnf_bus *bu=
s,
 	}
=20
 	resp =3D (struct qlink_resp *)resp_skb->data;
+	resp_res =3D le16_to_cpu(resp->result);
 	ret =3D qtnf_cmd_check_reply_header(resp, cmd_id, mac_id, vif_id,
 					  const_resp_size);
 	if (ret)
@@ -128,8 +130,8 @@ static int qtnf_cmd_send_with_reply(struct qtnf_bus *bu=
s,
 	else
 		consume_skb(resp_skb);
=20
-	if (!ret && resp)
-		return qtnf_cmd_resp_result_decode(le16_to_cpu(resp->result));
+	if (!ret)
+		return qtnf_cmd_resp_result_decode(resp_res);
=20
 	pr_warn("VIF%u.%u: cmd 0x%.4X failed: %d\n",
 		mac_id, vif_id, cmd_id, ret);
--=20
2.11.0

