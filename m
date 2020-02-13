Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5144515BF0A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgBMNRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 08:17:23 -0500
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:55092 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729557AbgBMNRX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 08:17:23 -0500
Received: from pps.filterd (m0048105.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DDD1HJ000487;
        Thu, 13 Feb 2020 06:17:19 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00183b01.pphosted.com with ESMTP id 2y1ufxey1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 06:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APw3F493vH9z3Jbb8Khb+2pXGnJzSAnx9m5tQiKZpXJryeuSATOF7oJ6m2VZAb8LePn10zH0MOCTitzkAC26IrLNJD47tbFGlqSAGREs3II7jS7in/vLft35oSlF9iPQqQv04xYXhGGhJ6ygOs5kV2a6r9FsFSqQ8sCe0SD87WU51oj2iEXwEh7zwPKtaAnO+ZgCDwETgkCm1NufbCyAnJylENKGnMGSN5JK6p4kN3uMOnpchPheZnOrFoDtz8y9qbP2xehTNgkmAQUUGtwrwVUNve0NQyRQFyG55C/KcdGBSZbGD9lp7H7NVzTUuDmDO7ZbUf6OVJbTRWxipVGgsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0oWeLRg/edy0hONDerwAdLhyc7cr3EqvXaoQmIk7U=;
 b=j8dIkaDSkK4wuhilM3Bl1AuO9abhd8Zk5s4m9dJRJVxPcyOuGzi94Ceua/Sss8fOgtOrDGO7V0Z2boOs1Aco4WnOCKD6ulXhf5so+tA9YLR6EXgLzXhqB8ZUYDAPZyx3KzLpWj1/67UkVEEIQtQKoGppxfaxdCrKUTz5q26Fm5+6ZIUhSjrC83hr/Z1eVtq3IGAN7tB/Qwz9WUfFFeOxPEqdtyaJlkcl6zcERMjJEiDpmFx6fnCND4nRQHeIWX3VoTL0LDJoEj6q1fPXG3H1DMexleq0LHOV3Lu3oZCHaSNOZgXBuCn0a1DPXxmDWlX/jLuiaizp6J6NHBxeSK//dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0oWeLRg/edy0hONDerwAdLhyc7cr3EqvXaoQmIk7U=;
 b=Ij0TmHOJhVqEaCafuOy+pXn/b8Pby2NHHFOXWgKmff3VxAfD4Zf5kQXxsKmVenWpUw/hAoS2T+K8jLpdsrKZx6/12+DIDZw7KWEw9w2GUGBuKBnlpMfgHjKdP0b5eTNrTB64SXwOQbAbAgCBZnIxxvkmeq4Ev31WYOhYiuk20io=
Received: from DM5PR05MB3465.namprd05.prod.outlook.com (10.174.240.140) by
 DM5PR05MB3099.namprd05.prod.outlook.com (10.173.221.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.8; Thu, 13 Feb 2020 13:17:17 +0000
Received: from DM5PR05MB3465.namprd05.prod.outlook.com
 ([fe80::89d2:a3a7:297f:5a29]) by DM5PR05MB3465.namprd05.prod.outlook.com
 ([fe80::89d2:a3a7:297f:5a29%3]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 13:17:16 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5152.namprd05.prod.outlook.com (20.177.248.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.6; Thu, 13 Feb 2020 13:16:17 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 13:16:17 +0000
Received: from bars.quantenna.com (195.182.157.78) by LO2P265CA0472.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Thu, 13 Feb 2020 13:16:16 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH 2/2] ieee80211: add WPA3 OWE AKM suite selector
Thread-Topic: [PATCH 2/2] ieee80211: add WPA3 OWE AKM suite selector
Thread-Index: AQHV4m/G84XoEsGPIkK2eU8SwVwqog==
Date:   Thu, 13 Feb 2020 13:16:17 +0000
Message-ID: <20200213131608.10541-3-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: c5ff3adb-2a29-421b-df1e-08d7b086e8c5
x-ms-traffictypediagnostic: SN6PR05MB5152:|DM5PR05MB3099:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5152D07E3A5A4C6113135B36A31A0@SN6PR05MB5152.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 1:17:13 PM
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39850400004)(396003)(366004)(136003)(189003)(199004)(316002)(54906003)(478600001)(103116003)(52116002)(36756003)(7696005)(186003)(16526019)(2906002)(5660300002)(26005)(71200400001)(1076003)(4326008)(4744005)(6486002)(2616005)(6916009)(66476007)(66946007)(81156014)(8936002)(81166006)(107886003)(66446008)(66556008)(956004)(64756008)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR05MB3099;H:DM5PR05MB3465.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FK5Ppx/n75Q3nVFvPONr5oEfrvJP7SctP7adkj5pvTtNjj7qlu1jmTtSUpYHR7g5CVpLrAFnOZrukgR472P3/HSlSghvA5jUwkthmIgp2UQBVkc6VjY8kMGCAYUMdSg4waqhAiffZVIvJcNUlFofdadDorNWIIH8m1CGTSXXnECc/wCnDmuI+rnx+2nFoi34+kgrChP4YFKO6jEJttMQLJ/I4mGUnZ8vH5AL7HrH5JXs92fICFcrTRvrhXgS36SzCJ/smmii9Un2v1b03/bWhsxVpxKgPB8K4TRpxvCG/V1f/dT3ykznqjO3ubZDwLg2yAzbyJ8nkdiSRzCkmRrXgnRPZtVkmiVmsxMGR7WtFu2TN8KGpEoJValETIANJDyFBzd6NjtDvMpSr7RstwFzUmXaeheet39gJ34EguUftAXHAedRPTRYZ9wdhxNe1D3c
x-ms-exchange-antispam-messagedata: VN2BtYhfwybrLQcOwKLrmbnA5sRz1kAVF8L5/zQg8kagzbrd1mvZ/t0rclRPqrWABePYP3o/pb6I9dps+IE8okrCZlU1CiYdnZdG93qqEbM5L5l7J8Yzillhvak2RcNriaRbNn6kc5QvxXfgjM92Hg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5ff3adb-2a29-421b-df1e-08d7b086e8c5
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfHKHIM9X7nveSD15fZRDuPq7JHonsML0LkUqixj3eAa5GXFeObZctY8qS/vnBGqXYp4J6jpFMLTlb3ZDiuS5jDW2SY91t9Ho4xrU0MPLVhwaekUYVdFHqdTlZtnUzyOjxz27DWOPK/XHQ68Yc36E1Trm64aFCowh9ptqAGNZHwzek8J2ctNcoqpqvGvMl+msKJA7Gy3SHWvBE/r9zhhNIyYtpUWPDP84D4KZ1XNxmM=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 13:17:16.6457
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR05MB3099
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_04:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130105
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the definition for Opportunistic Wireless Encryption AKM selector.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 include/linux/ieee80211.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 6f3e7c5c600a..33d907eec0b6 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3044,6 +3044,7 @@ struct ieee80211_multiple_bssid_configuration {
 #define WLAN_AKM_SUITE_FILS_SHA384		SUITE(0x000FAC, 15)
 #define WLAN_AKM_SUITE_FT_FILS_SHA256		SUITE(0x000FAC, 16)
 #define WLAN_AKM_SUITE_FT_FILS_SHA384		SUITE(0x000FAC, 17)
+#define WLAN_AKM_SUITE_OWE			SUITE(0x000FAC, 18)
=20
 #define WLAN_MAX_KEY_LEN		32
=20
--=20
2.11.0

