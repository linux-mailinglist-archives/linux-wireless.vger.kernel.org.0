Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3117CD06
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 09:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgCGIza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 03:55:30 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:47937 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGIza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 03:55:30 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: V1tfgEkfnVm0utobGC+sEE5Dg0r2l88gX+DLAV5lvBZOmhAouyBzvST+gMzwKGDVJTtbfyGm+k
 upKDA8oNsMK/MrqWbvEcnoN7q2hGV7zm6QtV/4zuwQdjwtAZ9gVXcx99/Sm4n7zrraTMDrh5mr
 bOsPZFUssd+caMU03AE5TTc+yWZ13ohWpnvUDGj77u2gqxMHqu0U9i60RCP19Dy16ypCg/STBR
 dXoe/bkn+8n9xmkU3rJd5uPY99uW7T+l9/J/e9yKOhjPpo/oIK4V3jGD/950YDTOS5WX8Urkdw
 PWw=
X-IronPort-AV: E=Sophos;i="5.70,525,1574146800"; 
   d="scan'208";a="4851948"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2020 01:55:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 7 Mar 2020 01:55:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 7 Mar 2020 01:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRs2NUuIeaTndtQ558dcY3+sUcp/ATQ8IzCHf8kRj2CoNyO8TQnGHXKeDJLQJRcD1ykxZctM+fThBJ+VwvV4z9lrVe6sTlaWQbyI8UvBa3WftEVTxMniuSLE7DZSHZElMGiuWCQT+wWSIAV/jDU4naBQ0LcJw5O49WJkwkzSMsxLjKiVd6agwWAeR0dOsNBrhUnH+3PduBi5YoNjmbbKY36KpLJHaFWXll4HEiAv+0QXSHfjEtmFrbRucBvuhAl13bm41ZEi/gtFO4Q4wM1FofbmbvWFE0XoJzdx2jaq1PglS/PoHjE+1SnPkXgqHOti/50uPCcyM7oYZz4redBt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oShf+ooyu6QTn1F5Uwsfc/ZxwGCA5DvG2bQ7p0aWkCc=;
 b=nubfcaNF0fTxMS0MBrs//WTD9mgTdqR4rvy9pyK9cB/EoNxaWP1zu9MkVYuNKoEoaJ9pSd3fztMngtPHTXVKBZaLL8tU32F7zUb0/Lb5EA7arKYpjJPd/yj325L6MvkVJNVEd9+KyhvUQkOEd+joX6L6geC/tb0kQ3BHRYyyV0MYh/yLLvQ3ZthTn4hMKBNtnOmcX4+tSlYRm9F6DxuzMmDlULq2WWVwSqWEIvDEB/IHA0G+ovTWYwjkeM2mdFoP+NOReek1cvRY55wrerd8POw7akcin5x9EWwmvR0CcvpkBMScuYegVUZVGtkOP7jrCWQ64qe6EdPg0pQKBqKhcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oShf+ooyu6QTn1F5Uwsfc/ZxwGCA5DvG2bQ7p0aWkCc=;
 b=tOYURIKL/4MmcEaBrbb9T/R7STd+JOKlFXYgajDTYcscT8ASOdSkc5JvIbHbwdf27tTcWD6Fi2DjXak9a/FNeh1FUJF7qslScK9JSoidKpnxWzV21gTudK8VuOh2kopcWswNt2AIYlgeLaHhcA4f2PBs/VUYSXux72HSPKF986Y=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1601.namprd11.prod.outlook.com (2603:10b6:405:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 7 Mar
 2020 08:55:27 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 08:55:27 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 0/3] staging: wilc1000: handle DT binding documentation
 comments
Thread-Topic: [PATCH v2 0/3] staging: wilc1000: handle DT binding
 documentation comments
Thread-Index: AQHV9F4l0jMzPbnldEeuRKClvT9Ndg==
Date:   Sat, 7 Mar 2020 08:55:27 +0000
Message-ID: <20200307085523.7320-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.205.217.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf0a5090-a145-477e-12e0-08d7c2754864
x-ms-traffictypediagnostic: BN6PR11MB1601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16011639834F1F777CFEB07BE3E00@BN6PR11MB1601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(66446008)(66946007)(91956017)(66556008)(966005)(5660300002)(64756008)(66476007)(36756003)(71200400001)(478600001)(6486002)(6506007)(2616005)(54906003)(4326008)(26005)(107886003)(86362001)(316002)(6512007)(1076003)(81156014)(81166006)(8936002)(186003)(6916009)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1601;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yw8AsByXsx88a1sXwNvj2Va0yGeAPAb3fB785ZiZMGSKWBjKVSoFQa+eXxNZMLGdAoe0mwp+AtB4MrKrwfRxss4dC5aO0735nBbFkc+v7ml7KAAffnYJk8ORad71mGDRgQUjcwP4lzxxIPxlTtuuUw4KdhQbBE2AeC31HwpC5mkhEj0Tv8HjqM7owZVL7Rb/PT5cuRh8H5Y8Yx2RdPp73tTh+75U9AoKkKP7d5oxhi5L4lvTaJOwIox/l0xejwcuQVCcBifhQ/np00yBxe0hYomjh3I/y0cScwOqjki8hO+mte2ZqeIrbPd95S7Wv4vYdmrZqEBJFX/5uMvsTyu51fKUM72bZvDiNJf1R2qJZH+8zuVBdV2Q754sA+f1IupPWJPNaAoIbcE0ZLdcoo4FpMtzDJoGcb1HzfDrGtxviVvlOcBBFBwSKbbls4cJAvJ/AjRa94h+ub/BRUVEAXY80cT4GnU6tyn4F2S572T9kHE3uk/NpfGCpwJNPuYqXJSLyuTax8P2YRlClVjRml53Xg==
x-ms-exchange-antispam-messagedata: QR8jus5HjX6c+2J8NZ7B31pxLm5f9nYm5m3V92ObPH/eHvhpc+vPdO57vhSd+oLw4P3E3048WK1j5Ic8MXhjcxLfPqOpYAUj8d1GHYjz7bAz90z5bsdZr8Q732hliLGE6XtSeytmVbeo3FZgEamIhw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0a5090-a145-477e-12e0-08d7c2754864
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 08:55:27.5815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kBzpsqdYDTSE1St1GAI8x7KkaCgmFarQu6/xJC5KZkZnTLdLZw8KLfTanOS9uLC9Dihnzpzf/wJdx7vbrbdfhidFr7KyCM82zXeL1bLGi/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1601
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This patch series contains changes to handle DT binding documentation
related review comments. The changes were suggested during the full
driver review [1] & [2].
First submitting these patches to staging and later will include them
as part of the full driver review patch series.

Changes since v1:
 - keep the bindings changes separate from code.
 - only add binding to '/driver/staging/wilc1000'.
 - remove redefines for common property.

[1]. https://patchwork.kernel.org/patch/11415897
[2]. https://patchwork.kernel.org/patch/11415901

Ajay Singh (3):
  staging: wilc1000: use 'interrupts' property instead of 'irq-gpio'
  staging: wilc1000: modified 'clock-names' and 'compatible' property
  staging: wilc1000: updated DT binding documentation

 .../wilc1000/microchip,wilc1000,sdio.yaml     | 68 ------------------
 .../wilc1000/microchip,wilc1000,spi.yaml      | 61 ----------------
 .../staging/wilc1000/microchip,wilc1000.yaml  | 72 +++++++++++++++++++
 drivers/staging/wilc1000/netdev.c             | 24 +++----
 drivers/staging/wilc1000/netdev.h             |  1 -
 drivers/staging/wilc1000/sdio.c               | 35 ++++-----
 drivers/staging/wilc1000/spi.c                | 17 +----
 drivers/staging/wilc1000/wlan.h               |  1 -
 8 files changed, 96 insertions(+), 183 deletions(-)
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000.yaml

--=20
2.24.0
