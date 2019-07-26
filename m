Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5EE76F36
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 18:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfGZQlh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 12:41:37 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:28482 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727343AbfGZQlh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 12:41:37 -0400
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6QGcxVf021563;
        Fri, 26 Jul 2019 10:39:52 -0600
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2050.outbound.protection.outlook.com [104.47.33.50])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tyybyrqgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 10:39:52 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkNsm7xQBBzQt4e6le9Id5atyzmkL1jFknAkmN47aD2dEK4KZT9aL/2GMY17i/YjZGdSYRWz/unlDl1HFIvOtFYK5s8dY+8d1VVJ1quGCcjBh/CSNuRcFR1vg5GjtfA3qEIXjYUu7Dn6I2h9qEmyJoOi6381bi0hR4FsDrpkGynVMW6jP4FPMtgH9zvoIBPbosCYygJh6ZafyYLDqg6oenUVJxXEKXiX3CgtPckZGYgInuAP1eZzv65+5gO37h9zWOeVIKGtWscb9li1f2k5K5Rs77SwRaAd8kXkkTG/VvJDq4iJ9Yq+8JWOzSK9ijAhScKVxphqDsmKLwA81zmfXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nci7n1GURWHZqXA6nvhLWcBpUU13I00c4RQ3qeOVlVw=;
 b=VvVdXNAdQqw7nvxdkB6nvc8qJk61S6z7hoTa64ou4C0G6w7i6io8QOew3U4jw5DJ8Z3Znt966XAqppjHj13jrdKjaYolnyGQq7XxfSgzFDb4WKCA+ol17yAqRhHjKB/PZc65ZCp7S5rMVXsRW/9q7PmTWJ6Ku0m8OwSbQsIEdP8xlOfrrjfPK5xbVZWdcLWFaDvlmzejmkJCZwpVxlxKnbRT3pwj/wFmwk5AsYdP7dlIPv3nVIoxdPxpwU1BEqUNiRwgVOfYH0oi04th/NopcTsgyTUw6EmoNrmRP8/FLgbsgzN0kqPGsAnwfRqjcKf2uEMygZyu9CVrfw61P4GLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nci7n1GURWHZqXA6nvhLWcBpUU13I00c4RQ3qeOVlVw=;
 b=LE18mqxURYlTOVSTHnDBRTUMSOeVkDQZaWRPOrH2+gZo4vhDyfgTAxhoCbqGrqKyJA37LZ3ZgvAcclUr3RIAKpMkkWo+me+0yK4b1twDqxRTLHxtPRPXT4uAyUO0UOVVsJ/0aw60ujw89hT0dnixxb8DPBcXuMXEOsposmySMC4=
Received: from DM6PR05MB5786.namprd05.prod.outlook.com (20.178.25.95) by
 DM6PR05MB4156.namprd05.prod.outlook.com (20.176.72.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 16:39:51 +0000
Received: from DM6PR05MB5786.namprd05.prod.outlook.com
 ([fe80::393d:3c66:c015:f3e8]) by DM6PR05MB5786.namprd05.prod.outlook.com
 ([fe80::393d:3c66:c015:f3e8%7]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:39:51 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com (52.135.235.159) by
 BYAPR05MB4327.namprd05.prod.outlook.com (52.135.202.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 16:39:30 +0000
Received: from BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e]) by BYAPR05MB4917.namprd05.prod.outlook.com
 ([fe80::a5aa:dcd6:2812:334e%5]) with mapi id 15.20.2115.005; Fri, 26 Jul 2019
 16:39:30 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH v4 0/2] cfg80211: fix duplicated scan entries after channel
 switch
Thread-Topic: [PATCH v4 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVQ9CyvdgDawDG2UGpIaa5diad6Q==
Date:   Fri, 26 Jul 2019 16:39:30 +0000
Message-ID: <20190726163922.27509-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To BYAPR05MB4917.namprd05.prod.outlook.com
 (2603:10b6:a03:42::31)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c7c9cd-7999-489d-f07b-08d711e7d48a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB4327;
x-ms-traffictypediagnostic: BYAPR05MB4327:|DM6PR05MB4156:
x-microsoft-antispam-prvs: <BYAPR05MB4327B9719EAD7EFF40C0DAC9A3C00@BYAPR05MB4327.namprd05.prod.outlook.com>
x-moderation-data: 7/26/2019 4:39:49 PM
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(366004)(396003)(346002)(376002)(199004)(189003)(2616005)(476003)(66946007)(103116003)(52116002)(99286004)(6116002)(3846002)(436003)(6506007)(186003)(102836004)(2351001)(26005)(66476007)(25786009)(316002)(386003)(4744005)(66446008)(66556008)(14454004)(64756008)(478600001)(81156014)(5660300002)(53936002)(6512007)(2501003)(5640700003)(14444005)(50226002)(6916009)(256004)(486006)(7736002)(305945005)(8676002)(107886003)(81166006)(1076003)(6486002)(68736007)(36756003)(6436002)(66066001)(2906002)(4326008)(86362001)(71190400001)(71200400001)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4156;H:DM6PR05MB5786.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TSNnk7mvSeGQVcn7W1Iq4LuyZpi1MD4aQqictQNtdOHJumm4DbjnWpp9JVagJs+8JJwnM8a7JzvNgyrKC+ZgECCIqkxhjEVAOpBIeY+tRQJSy5cdfVzXc/4oy34e+maWybI4oO6qlHXV4MHtRoseZsepQnkBJYxL6jb097Lz92oE2yUH2G1djvtubtng3UYRJAjQTjLVNLlGXHYZmz4A88NGJ7oFkPFNnIlPAJa10EvVGqW4Io2+diE7m52Iq1FQLnCDYpLSb/xVDboYhqANy2OpORgp6plj6eGChirWhtQgFFIY5dFHpqZB/HmwBdoztvSBFo/8xddFwSVaOJq6nZLuU7tvd4mMLbL5K7Ksc2WQGy9EOVItYpgQhbCu8lClkwcsIeZd1aQaSuuK6XyuceD/ikUh/CacNI0+2y7FdDM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c7c9cd-7999-489d-f07b-08d711e7d48a
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_5bc04c00-f1a8-4ff3-b778-3935a3896ba7@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 16:39:51.0186
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4156
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-26_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=822 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907260203
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes and all,

This is v4 patch fixing duplicated scan entries after channel switch.

Regards,
Sergey

v1 -> v2
- use IEs of new BSS entry to update known BSS entry
  for this purpose extract BSS update code from cfg80211_bss_update
  into a separate function cfg80211_update_known_bss

v2 -> v3
- minor cleanup according to review comments
- split cfg80211_update_known_bss function into a separate patch
- update channel and location in rb-tree for nontransmit bss entries

v3 -> v4
- rebase on top of the latest mac80211-next tree
- drop RFC tag


Sergey Matyukevich (2):
  cfg80211: refactor cfg80211_bss_update
  cfg80211: fix duplicated scan entries after channel switch

 net/wireless/core.h    |   2 +
 net/wireless/nl80211.c |   2 +-
 net/wireless/scan.c    | 250 +++++++++++++++++++++++++++++++++------------=
----
 3 files changed, 171 insertions(+), 83 deletions(-)

--=20
2.11.0

