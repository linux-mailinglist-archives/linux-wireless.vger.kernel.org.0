Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF87164B8D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2019 19:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbfGJRjV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Jul 2019 13:39:21 -0400
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:5274 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727095AbfGJRjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Jul 2019 13:39:21 -0400
Received: from pps.filterd (m0059811.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6AHYuNk019749;
        Wed, 10 Jul 2019 11:37:36 -0600
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2056.outbound.protection.outlook.com [104.47.40.56])
        by mx0b-00183b01.pphosted.com with ESMTP id 2tn18aag0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 10 Jul 2019 11:37:35 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZuhuTh0MVxhPhAwMDP6Zw7w81oHoSHDK1gTv/+l65flRkTZifS6HmRLLVcKJ4yTfsCAQ6Z7UGKYEfacoavog8nvj34KqlNKfw08S8Bgnpp/ehgB1/lhIqGxsi9Uw5rWPHTZCWUJ6/VdfXcLfnc/nhOK/glAUXbDs5ckvkfm/g+8mJJupzxnPgWyEtVbsrTXmYQ307LVd2ldOzAJbICrXSxja6No3JoiYMmXZ4PgmWSTpPteBjQ4GbbNsAySWTmiiMeQcwCcPX46kD4XAUxoqhH4nk/htL0d2PCDYHEa0dq3Ar+RuNFKKIgaO+C3Nb5Mq+YOKjrNpMDjtCX+tdAXFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGkZIZhsTj6AOJpjl9gg2wdeXlp9OFfO06luSKf07jc=;
 b=bsCHPOoUNCYjkGxBLNirDVNzeZz32uDi5OfXulnsODSu7zHN0e1Q+qvrYO4dvS1/JI0qlufe9J/rmbiNfuQNL90hPi7oDAcGVhxOtrqwP+sIHKcBPJNQNY04TssJj2kh5dRetYsbNZ7RgAM+PFATj7JYraFAhFlohw/ddKYEJ37vTuOLrGM3KSc3cgxbopGjB9zDVoMLss85S3pDArIvOKM2ZkhlnTqtgWRViGw382b2maByomFx7momFv9ZgV1nKVs3S0lf0UMGN/vXQJHtQnhl1HqwhHj2xitxB0i1yiGnsmJ+HS6gp7nk/oyYHvbwFbeFuYB8USZFlZxI2gGjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=quantenna.com;dmarc=pass action=none
 header.from=quantenna.com;dkim=pass header.d=quantenna.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGkZIZhsTj6AOJpjl9gg2wdeXlp9OFfO06luSKf07jc=;
 b=fLhGnVNugNSIsMbfC3aE8BiJqXwHck+dADrpgqh4aWEFa7sOfv/9udnbLTc/LQKRfXq9NIO8m1+35e2DHKDRxyt1xse/KvOOGTGTW602+rCJ40YIntWlRZwZbg0rsiY6oU+Sw8PpjkWKJs6yyKOkmpL7L8UqEwFAWYBeWCJMfVo=
Received: from SN6PR05MB4174.namprd05.prod.outlook.com (52.135.67.141) by
 SN6PR05MB5101.namprd05.prod.outlook.com (20.177.250.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 17:37:33 +0000
Received: from SN6PR05MB4174.namprd05.prod.outlook.com
 ([fe80::68da:521d:d75c:5dad]) by SN6PR05MB4174.namprd05.prod.outlook.com
 ([fe80::68da:521d:d75c:5dad%7]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 17:37:33 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5200.namprd05.prod.outlook.com (20.177.251.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 17:36:59 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::13f:5819:79e7:ea8f%5]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 17:36:59 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Topic: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
Thread-Index: AQHVN0YTcguWGm31CkW9q/08y0KK9g==
Date:   Wed, 10 Jul 2019 17:36:58 +0000
Message-ID: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR06CA0028.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::41) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c804690-b227-4672-c4ca-08d7055d35a2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR05MB5200;
x-ms-traffictypediagnostic: SN6PR05MB5200:|SN6PR05MB5101:
x-microsoft-antispam-prvs: <SN6PR05MB5200ECB962C0A255C3328180A3F00@SN6PR05MB5200.namprd05.prod.outlook.com>
x-moderation-data: 7/10/2019 5:37:29 PM
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(366004)(39850400004)(199004)(189003)(102836004)(6916009)(99286004)(6116002)(386003)(6506007)(71190400001)(3846002)(71200400001)(54906003)(81166006)(2906002)(8676002)(186003)(26005)(81156014)(66066001)(52116002)(25786009)(103116003)(316002)(2501003)(478600001)(5660300002)(50226002)(86362001)(14454004)(36756003)(5640700003)(1076003)(4326008)(68736007)(53936002)(256004)(14444005)(6512007)(2351001)(486006)(476003)(6486002)(436003)(7736002)(107886003)(305945005)(66556008)(2616005)(66946007)(64756008)(66446008)(66476007)(6436002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB5101;H:SN6PR05MB4174.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zXdipqhDrv9mJqb7GDWm/YyfwnFhDNft5ObLO8EMaWbZHbG+bbO5QYGO9ayroyoyhD/WG4uaw+hz54/z6gc4lBpbkK8JGaTHGWCdqXNQWJW6TSinSvZGOTi6ccPgydOfzSv4vnCFnJnu148w/pH1qFulah5XEhLQZXqWQ/jAuwHC+W9wZqeND4UJVJ34pWY5qsJtNTeWOEJoW2dCVBe75JPTHCdyo9+g/ZNXOWFCRf8eQhkvPyKZ+WTJhph4Ca9Cg7zKJQ5Lgj5TEX1HvsAZ9P8MMLvnBCcg/ue8GZHKDNQ4GKDIV28jt34N3JIjs4+XRLnQShFO46+WsMiDeK49a74ZNIye2vjbAK9fNfpxLTFJ7+BttZWvpiYgF7fgOV1aFK642vewqiiYE+pkeP+oLqc2JBJbBa+UNkifrxgGdtA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c804690-b227-4672-c4ca-08d7055d35a2
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPO_Arbitration_9454465f-4b3d-47c4-906a-0e3cbbb71a30@quantenna.onmicrosoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 17:37:33.2881
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB5101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907100198
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes and all,

This is v3 of RFC patch aimed at fixing duplicated scan entries after chann=
el
switch. The major change is updating non-transmitting bss entries. Since su=
ch
a bss cannot change channel without its transmitting bss (and vice versa),
the whole hierarchy of transmitting bss is updated, including channel and
location in rb-tree.

Suggested approach to handle non-transmitting BSS entries is simplified in =
the
following sense. If new entries have been already created after channel swi=
tch,
only transmitting bss will be updated using IEs of new entry for the same
transmitting bss. Non-transmitting bss entries will be updated as soon as
new mgmt frames are received. Updating non-transmitting bss entries seems
too expensive: nested nontrans_list traversing is needed since we can not
rely on the same order of old and new non-transmitting entries.

Basic use-case tested using both iwlwifi and qtnfmac.
However multi-BSSID support has not yet been tested.=20

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

