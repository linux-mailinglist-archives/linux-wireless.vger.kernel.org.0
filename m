Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13F715BB36
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 10:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgBMJJ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 04:09:26 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:51518 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729515AbgBMJJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 04:09:25 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D93P9I000365;
        Thu, 13 Feb 2020 02:07:42 -0700
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2052.outbound.protection.outlook.com [104.47.37.52])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1unakt7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 02:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Xqd93RRoJZkDIUaZrFWWfazQb5jmq6H49H7+OdeDIxm5hE8qsTYiaThr7bNpVhEy+Zpmz1rbi5T2tRdLvo2WLawgDywFVT9Z1psERBdzfus0XbH4QrVrxvch58+p83dgTxQZajoAAPXrJpledeXtHbKUm0RTml7i4POKmFn/kKhKhvCEfDv6wWlp8lLvzdhnySM/qMKGSwq5RectX66DUJVrVHmscVmxU7+eKwMzvNud/qQMysxJZSuG9MrKCsWi7mSUFM1l/f17w/apXujbTl7MKG5srmsZKp3xx7H0Tx6spr7PHTpAo7BoAZxa328QBWFCOXc9S2jQuPexFdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0oWeLRg/edy0hONDerwAdLhyc7cr3EqvXaoQmIk7U=;
 b=EQFzM3Za4YCY8xah7kfYEoItq8JMTJDxcGdkqe1gQt8+upCcPDzDFcEmIVRWmnq5Q5Dz9k87qAqrge9XQsPfvniyWiRzl/gdgsCkCM/G8c8i10LKPaUu9Tn7uqYmn17XbAeEijU548ox5/r23AGrV1hidVcrGIJ7Khw4Y/C7S0ThUzUMjZ2Kq6+tUbh1vqysj+GIePb6fNnFpy7z5UJapYEPAc3K4zg3Nb2W0vXYlHJhzI447AcPTD5wWFtyLEnd8VjrGddka5BkU9PnJKgkzQP5NtdFf875cjeGv6D8g0AIbCG0dL980kjPz6mR/UmzzHasg8M7T6hd2ulZ8do53w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0oWeLRg/edy0hONDerwAdLhyc7cr3EqvXaoQmIk7U=;
 b=YkEPEXxwhjizm63v4UyY+v4QzJP8CUHxTAz/rVDxNlWXVnqWG36M2+Xyr1QztcqxFSzZNbWw6tPcAhCKY9ACYgdkh4OooRTtfXUOu1PQgX+T6lh/OUwt/Tud9i/gXnjVBinExwrLQ+UyDGBXtlZNsI1TVH/w8XC3CIREIrGnROk=
Received: from DM6PR05MB5273.namprd05.prod.outlook.com (20.177.223.225) by
 DM6PR05MB5499.namprd05.prod.outlook.com (20.176.121.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.20; Thu, 13 Feb 2020 09:07:41 +0000
Received: from DM6PR05MB5273.namprd05.prod.outlook.com
 ([fe80::d995:1cb9:c6f:ca9]) by DM6PR05MB5273.namprd05.prod.outlook.com
 ([fe80::d995:1cb9:c6f:ca9%3]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 09:07:41 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5550.namprd05.prod.outlook.com (52.135.110.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 09:07:07 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 09:07:07 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0273.eurprd05.prod.outlook.com (2603:10a6:3:fc::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend Transport; Thu, 13 Feb 2020 09:07:06 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH 2/2] ieee80211: add WPA3 OWE AKM suite selector
Thread-Topic: [RFC PATCH 2/2] ieee80211: add WPA3 OWE AKM suite selector
Thread-Index: AQHV4kz3z2MNAkXCO0Wv/dj1xNpsgw==
Date:   Thu, 13 Feb 2020 09:07:07 +0000
Message-ID: <20200213090657.28841-3-sergey.matyukevich.os@quantenna.com>
References: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213090657.28841-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0273.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::25) To SN6PR05MB4928.namprd05.prod.outlook.com
 (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bffdaa98-0e1a-4a4c-bee9-08d7b06419a7
x-ms-traffictypediagnostic: SN6PR05MB5550:|DM6PR05MB5499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5550D49E0D366CBB934802D5A31A0@SN6PR05MB5550.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 9:07:39 AM
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(189003)(52116002)(7696005)(186003)(5660300002)(16526019)(2906002)(54906003)(316002)(956004)(2616005)(6486002)(26005)(4326008)(66476007)(36756003)(4744005)(66946007)(1076003)(8936002)(6916009)(478600001)(86362001)(8676002)(66556008)(66446008)(64756008)(81166006)(107886003)(81156014)(103116003)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB5499;H:DM6PR05MB5273.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zdms+zKpfVUcLllBqHEzPm3FB4zWUGvgKWUnquas//if3TBgONe+8H9HIM/ONnvaWHX4H8UldcZR/Qk7WAebO4gFO0AxYJRKDvIcFPVqKv3bvMpKk6RaVsmmybQvob2S3pBBu9KTag493nlZ9CCZOQl3k6UYDWjGRUT/ihsrtGpqLfgsNd0qcZQtAtrC3rULlGJZHeGWIL/fhBONYyPHnKLEKsNPjQXiFHF0dN69vNjJHgxNOew5k8YUo2dN189uA3OT1djxAZhclU+uH7UXoB8ygMRUAXysHFp4s9PRaMP9YYK5Lpdv/1U89i1Zilj1Co7LZXe9mlz7u4Jabbwet2NTdqnrIig39C3G1wS7ozQROjSehMqwp1GXyyYCkKF8MM/VB8elIbmRiDQu09HIHyMpcKLIfghtYrrWfGVixVfyWvUeZWCREXW8MnqL3jwN
x-ms-exchange-antispam-messagedata: BzHhkB8TR93T4bERw+T+akXUFQR4UPVNvikZsfGcYgX+x4aqunSr3q7ZrqiG53zJc7Dc3q8vXx9mltPCL+ZP+rjLZdSccD2Z1D5FXtG3dg/QRfScKPEZ7K7GUn1N7K9E3UW28TAVOuukLL+KHsiK5g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffdaa98-0e1a-4a4c-bee9-08d7b06419a7
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfocMO4i9tETbCwfp+yZjpwvuzoSaeSUrFyL/m8cN1bcILNXJ/WkB8DlDXB3VLoLOBe0ODY/YFqgW716UnTfZi+LIk29/h/hf4RawYY/7uXnYA/4vbWp5A6vg7O23JpesasVJll41KOipSyXO7u4gh6iYOFv5ZAgNKfJbcj+KqyQQiEFo2TeCpJ1Mpuacu//rK8wFVOx4UyO8bcLgnueQyb3f12ZdEaUnXkTcvAQ7Dk=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 09:07:41.4232
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5499
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Reason: safe
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

