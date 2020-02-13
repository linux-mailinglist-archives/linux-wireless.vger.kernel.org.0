Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA5615BDFB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgBMLqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 06:46:34 -0500
Received: from mx0b-00183b01.pphosted.com ([67.231.157.42]:24864 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727059AbgBMLqd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 06:46:33 -0500
Received: from pps.filterd (m0048103.ppops.net [127.0.0.1])
        by mx0b-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DBkWEA014106
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:32 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by mx0b-00183b01.pphosted.com with ESMTP id 2y1u4wm5vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2020 04:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmObKTP97uZsqXluoIBy/vbpepyYMH07dxMqxk/QtbIMUCWvD6N7KKGtvHNwsn+PM00GhHh5UDJwZGLQ1FmYr4CongXVKxDtjJ9lI95opdRQbe1pzW24LPLvL6OlNw6nA24I5i6DKheky9CTSDwb7Jj0SndrQ43j42eXO1VfeJDa+JGHZHtHwU6NoEtElzPsV0e9HyypvxiZ/Zj3PSUIhlabH4OjjO8wBTX4BsGKPlWle+ZEJnvOCcdsRQNutmmtp5A/PY5jNY/qMEVv2Uk2eEHZ37GpQk3mLw9Q3fBFqAfVMXmX195lfGGYj8gT3B8d8yS5vXHHgTW/UPJYm6eolA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOpphuJl/+QRnKNuSwIY9XwWw7FppD8ZV3CXEOGTqjU=;
 b=XwE2f4nx1qMWr3TfeezoQwboNmM8bng5Bknhax29mDG8ScvxTT3vwIW+nYlAZnGX60lR0OMAO3QyvFH+M7KyxxYm3RI8SF/BLf25ZbDyftHczf1SI3XpfN/YNUDzFabHzLMnt/KtCiyC3bSG8K56cFIVninKN17Ybuos47LhEYl+TfFlhUUJ90rPgysfZUFb2z1XBqzPsaPv/RXfyxGZQw5J+/n/zLOxGDmHHtN3hWs2wUIkG+co7zO9l+ZIG1dDTinqqCtue8JvsTTDpRdOxC7UbNbE6QKlH+FlAspfa+H9IP2WONjXD6BTLd8Mn4Z+yW7jCEo1EErwkkncO38JCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOpphuJl/+QRnKNuSwIY9XwWw7FppD8ZV3CXEOGTqjU=;
 b=p6An2wygdRcEOUhZvma0f+9kr7DvaiO6QqgTSazhoSkfenR3K7kCf0gRSkKEO3z9CSTAVVgCRFiDbDKxZCmu6qG0MK2XinDeHX7oBAUF4EDELaFHz+qptxbz9PMtUxOOfLh0AoHaOQ93DuD2BYMUiYx5EMMv6vghNwmLy4gIl68=
Received: from SN6PR05MB5888.namprd05.prod.outlook.com (20.177.254.78) by
 SN6PR05MB4511.namprd05.prod.outlook.com (52.135.75.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.12; Thu, 13 Feb 2020 11:46:16 +0000
Received: from SN6PR05MB5888.namprd05.prod.outlook.com
 ([fe80::5994:1f67:71be:1e63]) by SN6PR05MB5888.namprd05.prod.outlook.com
 ([fe80::5994:1f67:71be:1e63%5]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:46:15 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com (52.135.117.74) by
 SN6PR05MB5597.namprd05.prod.outlook.com (52.135.111.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.16; Thu, 13 Feb 2020 11:45:32 +0000
Received: from SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9]) by SN6PR05MB4928.namprd05.prod.outlook.com
 ([fe80::25b7:98a0:c066:1a9%6]) with mapi id 15.20.2729.021; Thu, 13 Feb 2020
 11:45:32 +0000
Received: from bars.quantenna.com (195.182.157.78) by HE1PR05CA0129.eurprd05.prod.outlook.com (2603:10a6:7:28::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 11:45:31 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        Dmitrii Lebed <dlebed@quantenna.com>
Subject: [PATCH 5/5] qtnfmac: add interface combination check for repeater
 mode
Thread-Topic: [PATCH 5/5] qtnfmac: add interface combination check for
 repeater mode
Thread-Index: AQHV4mMZqKsbnxyHPUK4bJ5apGIf/g==
Date:   Thu, 13 Feb 2020 11:45:32 +0000
Message-ID: <20200213114518.4415-6-sergey.matyukevich.os@quantenna.com>
References: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
In-Reply-To: <20200213114518.4415-1-sergey.matyukevich.os@quantenna.com>
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
x-ms-office365-filtering-correlation-id: 386c29c5-6b3e-486f-30e5-08d7b07a3b54
x-ms-traffictypediagnostic: SN6PR05MB5597:|SN6PR05MB4511:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR05MB5597C410041B555C7051E56CA31A0@SN6PR05MB5597.namprd05.prod.outlook.com>
x-moderation-data: 2/13/2020 11:46:13 AM
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 031257FE13
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(396003)(136003)(366004)(346002)(199004)(189003)(2906002)(66556008)(8936002)(36756003)(66476007)(6486002)(478600001)(103116003)(1076003)(86362001)(64756008)(6916009)(66946007)(16526019)(2616005)(8676002)(186003)(5660300002)(71200400001)(956004)(316002)(54906003)(81166006)(4326008)(26005)(66446008)(107886003)(81156014)(7696005)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR05MB4511;H:SN6PR05MB5888.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VLFGBOjAYKEtDIm2bCkqlk+5VVF3WLmutrWqOaF0oolLituPgtBTMMUdftIFqI9CfjbIVoDW9jxh4BVQdf37f8xGDE3KeJi+Koyo6MMUGcNko7NXc70n8z3cq0NqHhYtjpNbgwSiMmJaA5evjkVS4dnPXKQnK44QhDBfj8KD8Ri2CGYXCXmarjfdvBHPiLOANK1A+wtsLUzZfx3ULWvxRmwCX0DhGtjlmnowbfq/YXIBW/zvBEOTVTmiPjUdW+Ha3VKZou6DjnkY7PdBczTNTOVIsaPBGzvEMX7ZPIBQ0kkj7KjaIBQtLtFHu2ADfc5Y6HXs+MlmW+IwT6TKjyxpClh7g3rq3eSKYln5RJkMJ6EWvbyc1Bqrds3gDnnSqs0+kWlMQhUDDGjSNeH1wxhNAQyHBNHLIlbGWAlpncweoYXWK8Gss6p2pbVCbLxg9GPV
x-ms-exchange-antispam-messagedata: lHUo1nHTEtFpRfnbXzwyGzPwU5kqe88Dp3/44NH4+s65POvYkpjGocjWWmG0TXQ9zIJtMgCWw9ghj6nPinbB87SlTm/A0Mhru3EChPPbJk7pd+cfzr7gGRh8kKUjbGMDx20QgZaYVVTwvBi/8N6YnA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386c29c5-6b3e-486f-30e5-08d7b07a3b54
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUaY3vjb6GXnUd6AtV93JGhyyK4wov3tu8k8UkzJX1BbGUFP5eYOmHzhTW+N8vacTv0RkapLszWry6G8UE5OqJwsdGkxOqIAvPOOOS2YBiV6ypmFstyld0hd0QnA1ZKkNi6I3E7hcIL+N8l3HeO7SMHpQGKqt621jtZEJtqqqE+7btEI1aD4ZLZPmk2OOS6+o2+F5YQZ51N5Kaerg/1tUjGePCXn2N9qVY+Yi7EH3+I=
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2020 11:46:15.8800
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR05MB4511
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_03:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130094
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dmitry Lebed <dlebed@quantenna.com>

Firmware supports only STA as primary interface in repeater mode.
Since the only meaningful usage of AP + STA interface combination
is repeater, reject such combination with AP as primary interface.

Signed-off-by: Dmitry Lebed <dlebed@quantenna.com>
---
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c b/drivers/ne=
t/wireless/quantenna/qtnfmac/cfg80211.c
index 018d3ed75fda..8be17106008d 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/cfg80211.c
@@ -102,6 +102,21 @@ qtnf_validate_iface_combinations(struct wiphy *wiphy,
=20
 	ret =3D cfg80211_check_combinations(wiphy, &params);
=20
+	if (ret)
+		return ret;
+
+	/* Check repeater interface combination: primary VIF should be STA only.
+	 * STA (primary) + AP (secondary) is OK.
+	 * AP (primary) + STA (secondary) is not supported.
+	 */
+	vif =3D qtnf_mac_get_base_vif(mac);
+	if (vif && vif->wdev.iftype =3D=3D NL80211_IFTYPE_AP &&
+	    vif !=3D change_vif && new_type =3D=3D NL80211_IFTYPE_STATION) {
+		ret =3D -EINVAL;
+		pr_err("MAC%u invalid combination: AP as primary repeater interface is n=
ot supported\n",
+		       mac->macid);
+	}
+
 	return ret;
 }
=20
--=20
2.11.0

