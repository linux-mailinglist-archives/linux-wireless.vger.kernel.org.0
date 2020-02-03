Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A32511504B8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2020 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBCK7P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Feb 2020 05:59:15 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:46308 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726930AbgBCK7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Feb 2020 05:59:15 -0500
Received: from pps.filterd (m0048104.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013ArutK015829;
        Mon, 3 Feb 2020 03:57:31 -0700
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0b-00183b01.pphosted.com with ESMTP id 2xw5ehu7e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 03:57:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqQxwVcc5ReSMhPhU+8cUkiforfPIHI4c+hxtIRRiSx3J9znUIu4OQabPftyma3WeRU8kE7Wr+vgAaT9Wp3SC7FOVBNp3VWHWK4lFdSJMTI06Ky3VU0F6pcGyc6FqS62gDRxY5hdJXHiVAy5UHHcx6f4UTKTSel164CMAFOvDxNrKoObK3SJ7AMrhxOV6FTdgvVaP0JApjxjPBDJFGUydAE3t+icPgnFdXVHoEuY9BM3DEofSVHtCc5zjehIFB8VO5hvpOuptjWPKFRIeL3wfcyRmAKxCBuVq8d/yCIkI+chnpe1Sh34KYgcFzYhNoIikR6ICEYE3TavIH1718Q5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm192K6cEAnBonTdgHsljqQHFgsxdEJiMetBO5Zj1bM=;
 b=ltfl7EyvZ7ZUWZJfz6ga2Hn0MkrYj7DpS/z5TMoKhiWW89XJ/tFbDxIQqKZhm/NGoCpJu8tRwzlzgAmSpM+Erbiy7ZgzL2Vt4O26OLTORQrF5CMZ/PODOUZ7Jf5XD4wz+377XfHoURyhy/65rQlJ+qmpgv2WXAvtTU75it6p5pZZt8hX5DLj3OtSsjlVTzBRO7WmJuFq0PROnCmh0SDrtw7RtB/yf/i9zgH0VyrY7WlMxIMXRE2YNRKp2vj9VO6tTtmg9qH4Vh3xJfBB9aD98SwfD2BtkK0TPyWfU+WqMFKvjm//33uEtpXVA+0AWXwFr6b9bM/USC5yP/64fIODug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm192K6cEAnBonTdgHsljqQHFgsxdEJiMetBO5Zj1bM=;
 b=R5ul8DxlPWKsu6Q5LhKvudtUwcfNcej21999D0nXSiOF2LkkfZkU/I049RS048zq8vOcPifFA8rnIsvD7NvZyl2CSfBbpZpYXX92XuDf4WFCaVhDWy+kgUrhuovjly+AlhCfEYsid18lIijGicZBAou0YFRClv8e4tmJiRcFC1o=
Received: from DM6PR05MB4396.namprd05.prod.outlook.com (20.176.74.148) by
 DM6PR05MB5164.namprd05.prod.outlook.com (20.177.223.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.12; Mon, 3 Feb 2020 10:57:30 +0000
Received: from DM6PR05MB4396.namprd05.prod.outlook.com
 ([fe80::b09d:4cb9:3c98:1e68]) by DM6PR05MB4396.namprd05.prod.outlook.com
 ([fe80::b09d:4cb9:3c98:1e68%5]) with mapi id 15.20.2707.018; Mon, 3 Feb 2020
 10:57:30 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5375.namprd05.prod.outlook.com (52.135.111.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.10; Mon, 3 Feb 2020 10:56:51 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::2956:4ff3:7d5b:333c%5]) with mapi id 15.20.2707.011; Mon, 3 Feb 2020
 10:56:50 +0000
Received: from bars.quantenna.com (195.182.157.78) by AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30 via Frontend Transport; Mon, 3 Feb 2020 10:56:49 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [PATCH] cfg80211: check wiphy driver existence for drvinfo report
Thread-Topic: [PATCH] cfg80211: check wiphy driver existence for drvinfo
 report
Thread-Index: AQHV2oCjBn12icT5wUSgoWgqS7OXJA==
Date:   Mon, 3 Feb 2020 10:56:50 +0000
Message-ID: <20200203105644.28875-1-sergey.matyukevich.os@quantenna.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM4PR05CA0020.eurprd05.prod.outlook.com (2603:10a6:205::33)
 To SN6PR05MB4928.namprd05.prod.outlook.com (2603:10b6:805:9d::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.11.0
x-originating-ip: [195.182.157.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0c4befa-181a-476d-e926-08d7a897c58e
x-ms-traffictypediagnostic: SN6PR05MB5375:|DM6PR05MB5164:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5375B40AAA99CB91BF661A0FA3000@SN6PR05MB5375.namprd05.prod.outlook.com>
x-moderation-data: 2/3/2020 10:57:28 AM
x-ms-oob-tlc-oobclassifiers: OLM:416;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39850400004)(189003)(199004)(6916009)(7696005)(66476007)(107886003)(66446008)(66556008)(6486002)(64756008)(66946007)(2906002)(4744005)(1076003)(2616005)(956004)(36756003)(52116002)(86362001)(81156014)(8676002)(16526019)(103116003)(186003)(4326008)(6666004)(316002)(8936002)(81166006)(54906003)(26005)(478600001)(71200400001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB5164;H:DM6PR05MB4396.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnqMM2iaB+UF0B4P6eF/6QLiESW0aG0KmKHmHOB9OsaY4c/aJeiQj7ktGyL/rHr8IpfgMkBQuj8wcNiv7EKDEtGBEBUJQqIy2m9wgOxLbpEgnmDhSWCLjD3NlXqHXv54A/EG7mDdaH/wMr2Gi0GPchndnnXx1maw5a/EVs8QAlKugqJLFki6LxlA7+BSFrslG8rcAXQjRRxRgQNu4Hkhr2AUlLR9rhm+eQXk5zbJHzRtsOj/TyesV9or8hSlorKObroh5+JR1DvsZ8R8JdBogOyMOKKWH0tzttvW9ZOFYZqO9ZWl9Em9PClt0I9xSbufpF1TJMUf2ngz+7nHqZCQ1PnHjEcujJnAFWNlPf6lJD0VmJ8izPm0bQ30krkPX2GDzA1c6Deb3zjjWonm9/cOMD9kYNcUm3FLxOJ04a3W+R8fmBYIBochIdyezXjYW+OZ
x-ms-exchange-antispam-messagedata: qYADetkLM4IxQmIPXEcFG0x6tBgRvE74C4Wkoh2+PKAGvYsdasye8CjcDlCmPZFD4zgKUigcXTWmRqJrcns/oKXxQlbYGn2WJ3dvzO3NwPCEgaetHR+YT9dlZ2MfVZk8YKY25HzLhYBF4dfiNlkJ6A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c4befa-181a-476d-e926-08d7a897c58e
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bDi9ooLYtxmpEOtQy2F2VFW1RargMUa0V/gH6M95GJOHjqhKVbSxOolmHbfuznRqTU32UBtYlVxcMxI4ELafy4RIDvytgpMythI3PTRFCLg57FxyDtDtflqpsGVGaOwgBg55ZKcs/fmn0exFXh762TzGvFwBuX8Amu4QGjVSn5XKZuJlTzjEbiSB4jtgHnWc62NPOP/cDCiFMwYtvnrRp8qO10ilN/qr9Hrwvjcsgko=
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 10:57:30.3480
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB5164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_03:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxlogscore=877
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1911200001
 definitions=main-2002030083
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When preparing ethtool drvinfo, check if wiphy driver is defined
before dereferencing it. Driver may not exist, e.g. if wiphy is
attached to a virtual platform device.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
---
 net/wireless/ethtool.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/ethtool.c b/net/wireless/ethtool.c
index a9c0f368db5d..24e18405cdb4 100644
--- a/net/wireless/ethtool.c
+++ b/net/wireless/ethtool.c
@@ -7,9 +7,13 @@
 void cfg80211_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *=
info)
 {
 	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
+	struct device *pdev =3D wiphy_dev(wdev->wiphy);
=20
-	strlcpy(info->driver, wiphy_dev(wdev->wiphy)->driver->name,
-		sizeof(info->driver));
+	if (pdev->driver)
+		strlcpy(info->driver, pdev->driver->name,
+			sizeof(info->driver));
+	else
+		strlcpy(info->driver, "N/A", sizeof(info->driver));
=20
 	strlcpy(info->version, init_utsname()->release, sizeof(info->version));
=20
--=20
2.11.0

