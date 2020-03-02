Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E38175F7B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgCBQXj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:23:39 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:59180 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgCBQXi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:23:38 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kagiaPlFkpoYGoLXISb8GDJrO6govNm0wsf5tbpGBnw/PLYDFiL3NFb+4L/Y96RGHjx8RG5DE0
 ntm6XsmHz0TdUAfAXD9mhh4alLkiUCcqb1wsEZ3aRRokQ5MLFGLTx8FtCV+3IhyN9hbIEisesc
 SuaBdlZX0Yx5fgHdo+2Bi09B9ib7TWt/UMMt37XuLn9CK5KAUvngRPmYuhCCcWfVQKW0etFrrW
 oKWFV6xl4rl1s/8o8BqHTUQfvZgVruPF7X8ttrwv3ws19gIcYny6tpuZMYHa9HOFoC77MnGGgs
 YfQ=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="65862665"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:23:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:23:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZK16NNkIijz0T4cMm7sJGhdr1MPA5xVz+i5Ms0NdsaDWzSU4wciCrr72Go2L0qgCQ5q50x1eSZ/ok+4mvUoFHoej2a3IX5+c7vYCP6pFOyozUsBNCAfyB04uKZYlzVyUxEJWa7pYbXL1NVeorI3JVmNKhDYhp962ZTNn8qn4VxGLQwD3THS8NwK8/foRFGljQiJpfL2OcO+bWkmISYEe6bLedWnyZMzsNBX9R2L4bbVXF3wn7w2g57vh8Le/JO/T8HSNErqs6IuuhDZj65QZO/La10dh145Kd4xhdy2H7geB9pm5vZV1Bzd9r2C+ma0k+ySaCLCkKOD9DGK5LJ9znQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX+s6FJZuYWu1AlpwG6z1zfLYBTWzDWcBmcSyXLx4WY=;
 b=E3t+Adko0aC7mvdLqXy4dRNDR90SgVwlkuzFqE7nT3RcFsGB8v98wL7DkGC/aaZBSgx6UHhA/o3JYIEyVGqcHc+I7IT8Kw8Dq4bUs5cJTa2S7Qb6Cymqkxwq1Ah3PY4ZFXYcyFQ0FS4PjvK3sEwjMvJR8zgSJ7Q2nw92A7Cl9JKOJRWwmXmtKDzInA5sp3Vls52u5r2mLHXVP0KDcdXzylYnUHlyzVV7MJrmv9sy/HjK93na0KegZMhLhI0fXHPhqUTwqOkpRIbQsaoc2TWtI86I993LxG2PDV6zNTuuBqX7l8HIHf9iDllLjK/T+5ogS1gSWTaPjAgPN3rTreTv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KX+s6FJZuYWu1AlpwG6z1zfLYBTWzDWcBmcSyXLx4WY=;
 b=HUySdHC6HO7DNJIq+yV6Dz7jffQJMNvL0bwN59g186udoCod/HtXmEOJLCpB/HdqiY8og9gAM5wY+U+3ujTjDDOodltb2RJmx5Ms3gRZZWH2LYYHgjlOlpkRSqc8H2ipepmRoTucgFFrU+HCL2Yb0k0YfbbIFVoHROqHWiTcfUY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1426.namprd11.prod.outlook.com (2603:10b6:405:b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Mon, 2 Mar
 2020 16:22:36 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:22:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/3] staging: wilc1000: use flexible-array member instead of
 zero-length array
Thread-Topic: [PATCH 3/3] staging: wilc1000: use flexible-array member instead
 of zero-length array
Thread-Index: AQHV8K7IU+7nSOdvhEKdBtpqQZdAGg==
Date:   Mon, 2 Mar 2020 16:22:36 +0000
Message-ID: <20200302162226.4196-4-ajay.kathat@microchip.com>
References: <20200302162226.4196-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302162226.4196-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f62bf998-28b6-4d79-6037-08d7bec5eb87
x-ms-traffictypediagnostic: BN6PR11MB1426:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1426CFAE6D12786B28497C43E3E70@BN6PR11MB1426.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39860400002)(136003)(189003)(199004)(966005)(5660300002)(66556008)(186003)(26005)(66476007)(64756008)(66446008)(6916009)(478600001)(6486002)(6506007)(6512007)(107886003)(86362001)(66946007)(91956017)(76116006)(316002)(8936002)(71200400001)(1076003)(81166006)(81156014)(8676002)(54906003)(2616005)(2906002)(36756003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1426;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wKxnekkO+ZmBlofgg7iAEcgGgKOewewNdSUjujcIjxdbzBpSU2Hyr9sli5KrDD09Tnbif4+MCxFci4xfbMZfhCL1TV1v6y6WiVwMsb0goI1F8S80XahrWWqYzz5Rn2yDr0LNshg0639vVrgpMuPav85jR7J6qZLJZbTNI4ZPwSyHT4gvBZA8QGO0zATT8/Glt2JP/bkWngfRavtrZ9PL4SQt+0ttr/t/oGy2UeX12Ptsp+pz1OuHODpRjheTYgN3ysmoLAmCl1OUQzVUeIRNIVtCjT1v8Sdu/EtOoOTbidonDFluWmJ+aDdLf3ZPg3eFxIGTqvYh+jwykxaxCw0+d4Nqa5SJSWC26M6mNgFcAtRYJacuMzfCz4HimBpxGV4AsuT1Cu2D4YDUmcYkzZIy4V429e9B5aZW1RcrXi+S1W+NM3m4ADAc8djJC7Qf6witWBM468rMMuMqumS7QrFZP36WO72qHQPrcNRPGMSy/pGcAS0ah7Cvr2KrWQtuZTi+aPzigZn3cSC+IQ8eaCCutA==
x-ms-exchange-antispam-messagedata: E7jsAF+oZ4Ha0r9Njx7b87h31WW0XZvU5dlpH1xxxQaEEOZzgohkC0yD55l7jy6gPKHBuVA2GbUPioPIHRyWDAeduaU1uIN+cks3BY4LWim/Btiq7RCgsZX1hseIKM8XwX0Cx9iZoRC4/YTdtw89EQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f62bf998-28b6-4d79-6037-08d7bec5eb87
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:22:36.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O7Q2k+eKj5EX5oxiS18TT3LmTFG/k9rXhmuK3X7NNDd4k3IppIXU6PPRwtq66uD9ZLcHdvvMRpHnP+Mnw2u8n0Lt3Zjxj9QKTHk9WnzeJQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1426
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use flexible-array member introduced in C99 instead of zero-length
array. Most of zero-length array was already taken care in previous
patch [1]. Now modified few more cases which were not handled earlier.

[1]. https://patchwork.kernel.org/patch/11394197/

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/spi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 11653ac118cd..dfd25df75780 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -109,27 +109,27 @@ struct wilc_spi_cmd {
 	union {
 		struct {
 			u8 addr[3];
-			u8 crc[0];
+			u8 crc[];
 		} __packed simple_cmd;
 		struct {
 			u8 addr[3];
 			u8 size[2];
-			u8 crc[0];
+			u8 crc[];
 		} __packed dma_cmd;
 		struct {
 			u8 addr[3];
 			u8 size[3];
-			u8 crc[0];
+			u8 crc[];
 		} __packed dma_cmd_ext;
 		struct {
 			u8 addr[2];
 			__be32 data;
-			u8 crc[0];
+			u8 crc[];
 		} __packed internal_w_cmd;
 		struct {
 			u8 addr[3];
 			__be32 data;
-			u8 crc[0];
+			u8 crc[];
 		} __packed w_cmd;
 	} u;
 } __packed;
--=20
2.24.0
