Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 552EE15BF0E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 14:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbgBMNSt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 08:18:49 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:59942 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729966AbgBMNSt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 08:18:49 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDH5Xi017879;
        Thu, 13 Feb 2020 06:17:05 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u4wmbxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 06:17:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKD+TEh5Sul6XKF5bePLiiTMbhvaM1mb+YVenp9I5z/A4stRCcROzESMcVesDx/a56M+TBFVpvM1RmyONydCDvXMGQqJr9KNXvFIAiV9W/Wc3cwAlhiI1RlrdZRire0s0JXbYNY8kPHRiVy22VL5r0F0i138vzu7SRbtjRbrpgYR9pi89gsUzYQJND1WgGyI48i1m3cNVEcmDtU9GrQGV2Mnd8mxto1NspdkF7wXIBIL0qmqVRTLGzdNO31wl/1tif6jj+wLLNfuoRxNQ7KOAKmJTEuK/8btLpFndUbXBtGAK5yneuwKt01t7fxCyUwrdZQDwx5co+udfJapTgSGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIFA60SJzNO0xdyXlXpDgpaWW7RjTjMKtnJoXovI9BQ=;
 b=PLZ1mbI0/BFwPvarM0dlbGCd/81/sSIs4+RNSPo+ihWB6HtHc0si/Fbbdy0hDpeoifxsEZ+WXgXZ9HkRmic28sthjEWA5PCdZoc6VL7WVvBnMTqVg9oJ/+l5iFRcvO758qcJlaAzdXbKj2L2q85oypybJ3q1hA9KwX3s+FWwmJntKGJXCm1t7bmekNOzahPlE1CHYw5FgcwwD4D5WNv4UYIBcfpAIjtf8PiyYr04+JBvkBBGqI8YoaR9LNXt7CRQCVaON6DjXm60bzeHsgKWwYvEzTaVP8nxuYh6L4VedpFkU3POM8hK0UWrEoT9sNMCfxZz8ufzdnA633GLqSbN4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIFA60SJzNO0xdyXlXpDgpaWW7RjTjMKtnJoXovI9BQ=;
 b=EfDDlhrMFBhqGZ3Tqp0TamHy+D2igVMxdgwjdbcf4NcpSpMFxaLmi2S2QSCdS4JfNLDloe+YuqT90LxyDBAECLOYUIWv9yBuhpIKBhi5dAdg0+Sqn1a65PdNTFPFHkORVioTxFT03dBHNUHmnkssVKyUtpNgcKJBmkfaqDT6XiM=
Received: from MWHPR05MB3567.namprd05.prod.outlook.com (10.174.249.155) by
 MWHPR05MB3055.namprd05.prod.outlook.com (10.173.232.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.14; Thu, 13 Feb 2020 13:17:03 +0000
Received: from MWHPR05MB3567.namprd05.prod.outlook.com
 ([fe80::bcfd:f431:63fd:5841]) by MWHPR05MB3567.namprd05.prod.outlook.com
 ([fe80::bcfd:f431:63fd:5841%3]) with mapi id 15.20.2750.007; Thu, 13 Feb 2020
 13:17:03 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5152.namprd05.prod.outlook.com (20.177.248.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 13:16:16 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 13:16:16 +0000
Received: from bars.quantenna.com (195.182.157.78) by LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 13:16:15 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 1/2] cfg80211: add missing policy for NL80211_ATTR_STATUS_CODE
Thread-Topic: [PATCH 1/2] cfg80211: add missing policy for
 NL80211_ATTR_STATUS_CODE
Thread-Index: AQHV4m/F+RkyWzjWdEiMJxzwTxqaXw==
Date:   Thu, 13 Feb 2020 13:16:16 +0000
Message-ID: <20200213131608.10541-2-sergey.matyukevich.os@quantenna.com>
References: <20200213131608.10541-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213131608.10541-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::28) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67200da2-5d9f-4df8-2ef1-08d7b086e7fd
x-ms-traffictypediagnostic: SN6PR05MB5152:|MWHPR05MB3055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5152E6085468E611487CB6E0A31A0@SN6PR05MB5152.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 1:16:59 PM
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(39850400004)(366004)(346002)(189003)(199004)(52116002)(66946007)(66556008)(66476007)(66446008)(64756008)(7696005)(4744005)(26005)(5660300002)(103116003)(2616005)(956004)(71200400001)(4326008)(36756003)(86362001)(2906002)(54906003)(1076003)(186003)(6916009)(16526019)(6486002)(478600001)(316002)(81156014)(81166006)(8936002)(8676002)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR05MB3055;H:MWHPR05MB3567.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xLgbNAV5ARRkWFjC86ehRjonqA4r6/cRpXIlcYO616ZFsyXVvWtgutkmKKLN/e/hHtnqv84mjQa593hdIKpvXy/pyhflnHHovZnw5qX6wqoJE6itm28cTZ13oMfFV303W4iuIR7wXRLAA7nvcfoZfdUEJ4vwa1F/16Au7O2R+bjNSfU9Wbnq0w+Tp8UcHAmUIStf36oTInQ6CqtfTSPEu2OuM2Q5agwFbt8h3yDhZDmdstIihcYFemePo6KyMsMx1F8WAL9AJqLpMr3/DN2eYV+MY3yZ64RcUsxoL1/VaVHdipIJGlVEU8cdwx9szwwBGMhmZkhYCs3QZzHrG+7+p2QkPlyZH7OSeZ/YXkp6PAGZShiap2GumJQFAudBd2C1MtLZUr+YpnjLXRQQOax2WhwZUr9bddgiIB6MKwS+qGhGDANZmiYcdaWahgC02hCj
x-ms-exchange-antispam-messagedata: S91HiYYJQ5sgIgmBZKPPEVli+lah7KBlg8WShHiPPmeGC1v8Vu53HBXMwPjpdPj06deDw5UzhMw6LnYUYpQaSul7G+TIh9WTcA+qb8JbwPeOZ3ml+DZbd/QmS/v8+yZs5dhfa7YlcD9T2MzFRL2Dqg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67200da2-5d9f-4df8-2ef1-08d7b086e7fd
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZqKo0uVlOkBB5DtQuZfKV8fgwA5WPg+G4leYUDFu94fiUus9nVwt9PnOL7HDjHoggEbCA6hPyOOVboX1+M9vPH+9ahkRGpIluRKtaC8PPnKbYJj79Y0e/JD5MSAs091Wsq2iWL4twJMO+Z5rQRoVPIPbk9qD0Y6fIeS8JgjGjwbx+ro2zEDBBrY3xn2h9cxAO9tPGD2BfXxuL3B1Yz2Q3FescGRunY5iZDRW0ijcCQ=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 13:17:03.5805
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR05MB3055
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The nl80211_policy is missing for NL80211_ATTR_STATUS_CODE attribute.
As a result, for strictly validated commands, it's assumed to not be
supported.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/wireless/nl80211.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 33fe6ac1c242..6b2bac002b03 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -444,6 +444,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR=
] =3D {
 	[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT] =3D { .type =3D NLA_FLAG },
 	[NL80211_ATTR_CONTROL_PORT_OVER_NL80211] =3D { .type =3D NLA_FLAG },
 	[NL80211_ATTR_PRIVACY] =3D { .type =3D NLA_FLAG },
+	[NL80211_ATTR_STATUS_CODE] =3D { .type =3D NLA_U16 },
 	[NL80211_ATTR_CIPHER_SUITE_GROUP] =3D { .type =3D NLA_U32 },
 	[NL80211_ATTR_WPA_VERSIONS] =3D { .type =3D NLA_U32 },
 	[NL80211_ATTR_PID] =3D { .type =3D NLA_U32 },
--=20
2.11.0

