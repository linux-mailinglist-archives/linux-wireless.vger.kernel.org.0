Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1D78140800
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQKbf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 05:31:35 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:23235 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQKbf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 05:31:35 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: qdUSGLrBaAkCuWHaBojHLbJoAXcv8IfPmo5+ken92KMqWI1xEKhHDO/0t84GMrncQOScSr9Off
 O+AtSaYP6ht2Xg+zrZVErGPjw6hv7WRNtkA8ssCWwMpim9i6wQtHQTKniCdhXlwiXr40V1/0ww
 NriU+a9Db6obVnZiDd8rJ9WD6d8gIKS07HjzK9AZT9745EEUo0NFOXfegyOa2Dksx8LhS+YSOf
 JJOcfaZ1sKp0v8VJAHr+XKSmsqsnZ7xPsfasIIZMaUzlUTvebuRU1V9JezQKba3heZUhfXNpFf
 Fkg=
X-IronPort-AV: E=Sophos;i="5.70,329,1574146800"; 
   d="scan'208";a="65077360"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 03:31:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 03:31:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jan 2020 03:31:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsTi5sV4B3NQtNnrsQcLq4n3Ggf9C6HFA3mH4hY/NOoeCe/kUBh03mQQXMpURj5r5a42coWW/XYQtkSS2NcpKBA7cYGTQNuVBtdVpX1q35D/wn00+vDN4WaMAZxQbZcBaUjbLset58IZw61UZOo7ZEwEoxH/Kd3bQOHLy8bW+tkAZxhv3Y1ieXTSZN51b5ZbMMoJUKweSowwMoCpNtsgGe/+WmBavAlaBuFnhLcenR3pqjfvWNdqaz/sKodfulci0X5S/3GinDE/gPkcyUDKupAD/GOhbtMYJKjy7eEwyG1n7Q4hPxOCavoE0T1Fmxzt3VgntVUCqBSUJOskQhUAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+zKjjAlC2k7d3vs1sFCBgtDTG8IvLrabnAyvvP9JRo=;
 b=ZEIkEqdjVo29qD84dSprSIRTCgfsd6DCulJ/l0RMjhkJY4ntzxUe71RRjNSftQc7J+AC+KjGvIqkWlDP1t3Ec9zUaSvxuH2EMmKjXkLlx71KcA25kUnIJNmVzzsVCyrFPRpFlIhg/BcznSkn8Ncwu3wfKfYfhB7rjxzGHG6lmlefYX2OKcRl1Ia1pDzkCYudGwO3QItajjHd/pATP0slAXmctF8gkJePhJ7zV6L1ng75bxUz5An8GS5XyOaLl3q2s0WT4ys8/YzdKTdFcuhuL6XST243gxCBcoPF0GzhBUNYN3u78zmeExPbGJP4rFZ7uLY2Y79Z3aYYej2c6VjWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+zKjjAlC2k7d3vs1sFCBgtDTG8IvLrabnAyvvP9JRo=;
 b=gJSvKjI+zkkt2mORH6qA56EqI18A7jDfTPJt+ra6LGGVV67wNklrEzpvOAYxW1HfB37zFyyKWvdB/bXRprfErskRzONP/jR7aak76l7R9LopYN+3yzVVSOPX03pwxfPEqgiE8fuVS+xrrghAJlKBX+gzrv08dxaV4zg46wfVR1Q=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB2907.namprd11.prod.outlook.com (20.177.217.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 10:31:26 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 10:31:26 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/4] staging: wilc1000: added 'wilc_' prefix for 'struct
 assoc_resp' name
Thread-Topic: [PATCH 3/4] staging: wilc1000: added 'wilc_' prefix for 'struct
 assoc_resp' name
Thread-Index: AQHVzSFFjPGjT3ZT2USKGRbjiG4W5g==
Date:   Fri, 17 Jan 2020 10:31:26 +0000
Message-ID: <20200117160157.8706-4-ajay.kathat@microchip.com>
References: <20200117160157.8706-1-ajay.kathat@microchip.com>
In-Reply-To: <20200117160157.8706-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 040f77f7-723c-4aa2-f089-08d79b386842
x-ms-traffictypediagnostic: DM6PR11MB2907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2907B8C240B58B63EC827C0BE3310@DM6PR11MB2907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(8936002)(6916009)(5660300002)(6486002)(81166006)(478600001)(26005)(76116006)(91956017)(8676002)(81156014)(66946007)(66476007)(66446008)(64756008)(66556008)(36756003)(4326008)(2906002)(86362001)(316002)(6506007)(2616005)(107886003)(71200400001)(1076003)(6512007)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2907;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3s1Sn1kjLUwRs768yLMgYFlCYntSPEzErz3f3mmBgR7DXdku/naor6utsLI90JLxfNBxNwXXxB3dFjWp5tYaXV/TktLSt+QZB0AapPQyPVMTI3IYYKbOoq6eKiqVhoLLF7YlxIwTCcqwZ2M227IlzUgOIeKmk9d0g3ZV87MNnAi9dlCYEpey1/1KVZ4obo9LCBw7ZpoEOJ6+3oAhKuB7SbmqdqYqeqho/GCZuACMbKZn6Icoeqz+3uyxx12Ibdijbi2aCk7s80/fInEDQkVN7JCciE66G6ZRPROY+hses2FZUqqI/aGY62FTKrsSkRnxvv4xqL1y9OvjSMuTQTgjZjL+MMcdoHUkIzY7mly7rDi1P/jhpxNp+8pXzlg7ana2nHB6t8ZArv7k2myIlZhTIJjs678wU/bTwX3XyEV4KJgGQda1x3VS4nKxT50xH9u
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 040f77f7-723c-4aa2-f089-08d79b386842
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 10:31:26.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FuTQG/jL9n/HT1d8+W83IdTf8TYwZN2PAQAUKrkVPtoksCq1usqGbIvgbsNemDHokPUhxp1hBfdDf90GvM3kpMoNmnNadlJQytKz0LbCm48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2907
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use 'wilc_' prefix for 'assoc_resp' struct to have proper naming
convention.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/fw.h  | 2 +-
 drivers/staging/wilc1000/hif.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/fw.h b/drivers/staging/wilc1000/fw.h
index 21d71a9e8b47..a76e1dea4345 100644
--- a/drivers/staging/wilc1000/fw.h
+++ b/drivers/staging/wilc1000/fw.h
@@ -14,7 +14,7 @@
 #define WILC_MAX_NUM_PMKIDS			16
 #define WILC_MAX_NUM_SCANNED_CH			14
=20
-struct assoc_resp {
+struct wilc_assoc_resp {
 	__le16 capab_info;
 	__le16 status_code;
 	__le16 aid;
diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.=
c
index 1ee3d7274bd6..658790bd465b 100644
--- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -552,7 +552,7 @@ static s32 wilc_parse_assoc_resp_info(u8 *buffer, u32 b=
uffer_len,
 {
 	u8 *ies;
 	u16 ies_len;
-	struct assoc_resp *res =3D (struct assoc_resp *)buffer;
+	struct wilc_assoc_resp *res =3D (struct wilc_assoc_resp *)buffer;
=20
 	ret_conn_info->status =3D le16_to_cpu(res->status_code);
 	if (ret_conn_info->status =3D=3D WLAN_STATUS_SUCCESS) {
--=20
2.24.0
