Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43E17C0BB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 15:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgCFOoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 09:44:08 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:17412 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCFOoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 09:44:07 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: CEDq5WzDf7/uqmp9a8nsb4t27IwlIlShCsUwZ6PY8Kke7OoFxPBc9chsybsQnc/a0fi0J8zIJu
 Opp13wJjKL0ek77ilKNvVXmI5LVg4AvWgfelbg5EoiC+PGg6ZWln/RbFk2JgQTp6ld/DI7If7E
 iNvoV6YtvC+jXW/o4egN+chnTqxT5nJYyX2VQ78xPBUHLrUyTM0myz+weEY4Ib5X2mSDP4ZP+p
 aFB+yeh+ciOxvIj+yd0mlcMc7R4rrtBmCqWgt6H79KatMdXAuYEvjUm8KGEPTo5M5AUxMkZplm
 KnA=
X-IronPort-AV: E=Sophos;i="5.70,522,1574146800"; 
   d="scan'208";a="68117463"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2020 07:44:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Mar 2020 07:44:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 6 Mar 2020 07:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0LLbFNiv1WNykQuaRV+/EbTErKcck33Icz2nstO1OB9tBBvFuTewWdBnLDMk0QS0tfS9H9cuF6Xz0p4viO364u+iaos7R1Kr6iFEbgFtlh7RkFzcUQ5ToZsraIe9fHE4V9d5q28w82ZnCAi9+ZXW68UYI8fwzkX+3oLOOcuiK1QxE6wFP9ovjWcVd2Z6S4uZAQ0k7JsvhjA7AZUpevC1uRl7QQKr3PZF2fErMM7d58qa0bybDt6DqOnpQpTnTt3Rv86nxMnKQf9Ie1F/ThFQdrQTVXMS9gK+nsMR3PVSZc3ASCc32+Y0LieiBZ9jwi8qrxrmTa6DZAj5ceKVgSPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcs6KUM33IZqaN6Jk8SYQi5l553u26Kwhhu8d9cDqlM=;
 b=mZrNCqztP+0P4DWoeXShmNAvpud1c8DPueyJTSXOB0zn0x9YfpjCNNjxw/fe5mKR+YCCickyPYMpq2Y/2ngLMKrJsLMZyk3YxHcMW1CyjYSuGhHMwq8S74Warqy9QJkAgbR0Zzq1B0uVQmSEq3Bb8ZZj2Kmt6t+HysabFoe2yI3gKM5ACMEI8oLOXYUk75FapFOnXykqeqZSIa3VUuwlvyrj+OrigUrqHQEBSANVYvWWatPsVaqauEmt8y5JPlMOzU3AWVVNC6Lcj16XdiiG767g2t97NDjpy+GxHNmkm+eRJT5wJ2c2vD/Itxv13Ah078KFL+dqpn1Z5YHnNgpchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zcs6KUM33IZqaN6Jk8SYQi5l553u26Kwhhu8d9cDqlM=;
 b=pMflFDNJwVuX8RcTJ4ri04uGwqFzfGPY+22aRlVT8D2G3J+jrPi+IfNRZ0KpwLHTAsXiL8vxCqb0+LZDqA9gXPWn/ZxWF4nd5EBmSR3+RsAllyuXK0KAe14NQE8yjMQp46bfdUjsjVRtPB7md2xqPvi2nqVPxtnFaeou3hl0cvs=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1362.namprd11.prod.outlook.com (2603:10b6:404:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Fri, 6 Mar
 2020 14:44:04 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 14:44:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 0/2] staging: wilc1000: handle DT binding documentation
 comments
Thread-Topic: [PATCH 0/2] staging: wilc1000: handle DT binding documentation
 comments
Thread-Index: AQHV88Wu1+rL8LR6w0iCOh7I/oMlGw==
Date:   Fri, 6 Mar 2020 14:44:04 +0000
Message-ID: <20200306144400.4269-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.205.218.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8637e41a-0490-4ebb-3401-08d7c1dcd12e
x-ms-traffictypediagnostic: BN6PR11MB1362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1362383E26F5370A64FD79DCE3E30@BN6PR11MB1362.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(2906002)(81166006)(6506007)(5660300002)(6512007)(81156014)(64756008)(6486002)(4326008)(8936002)(8676002)(36756003)(91956017)(66556008)(76116006)(71200400001)(54906003)(66946007)(66476007)(66446008)(2616005)(316002)(86362001)(1076003)(6916009)(966005)(107886003)(478600001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1362;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O3m7nAuxzcHT1PtKkXZANIzLm4wRjFzScmt1ycIhwSvdhDVcX3Ywd+BN/TjIOEtxPzRMjwtKg3D/QHt0RGdtPsTracVhBHaiwDlc8gp5py+ILwuRs6vEbZbZleL87oXVFyHKTuzBiHfZUcw1AamgKOh7POdi/GwHuvORjPUwo57YZSGlMbMfPXSFKVexj/USqrqaMIdBHf67LAN5AGKflEUzMEheVStYk7Gn6YtOczIdTN50a3XC9G2JkDzQrP39iKSX9cmeF9BtXd0NDw81V27BSNDqilqlJR2aSOmJ3sixgcgvdKeo1Q+vidIhsOOqulxNAlAdNJEKNOmrAdNyh2OUhTybDmmuFSysZxA9ucq0WHYi6Vswolk7Oqr4QOC7i0YIHOO62lNdxACIZFdL1eeKyFPcGezyhv22LA/M5YdHDOecF8xiZgcOTKpiw1OSaqjXTpkxJoHETMlqUp3Hk491i3cxlOy7/j09pgfeq0EOju3Oqo+SmNKls9jwcBJfmq2a8iWfPTl0jOnbzmjPGw==
x-ms-exchange-antispam-messagedata: yIfDo2uy1qS9a0qKWyr9Bm6GBZ79HXhqFNSCxgwhrsVOQbSoFMtTlHHkO6pPr3VCn8F9rV9on11PwiExj17aztEiQuzulVuam40JnVHtuUhIDCIxKvXYv4AFYDDKvMfYYlYmLvL4lJ9AYN2cIJgkEQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8637e41a-0490-4ebb-3401-08d7c1dcd12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 14:44:04.0947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNjeiAi7eAXYyJZAbLzAt+6QY3WeTmXWe8IyDyW/GNNaRBA8q3ptZwebRLttXCul+888EssIgEU/9w1qA90E//6FYUa/Nk/BbnQ7wW3IOLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1362
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

[1]. https://patchwork.kernel.org/patch/11415897
[2]. https://patchwork.kernel.org/patch/11415901

Ajay Singh (2):
  staging: wilc1000: use 'interrupts' property instead of 'irq-gpio'
  staging: wilc1000: use single DT binding documentation for SDIO and
    SPI

 .../net/wireless/microchip,wilc1000.yaml      | 79 +++++++++++++++++++
 .../wilc1000/microchip,wilc1000,sdio.yaml     | 68 ----------------
 .../wilc1000/microchip,wilc1000,spi.yaml      | 61 --------------
 .../staging/wilc1000/microchip,wilc1000.yaml  | 79 +++++++++++++++++++
 drivers/staging/wilc1000/netdev.c             | 24 ++----
 drivers/staging/wilc1000/netdev.h             |  1 -
 drivers/staging/wilc1000/sdio.c               | 35 ++++----
 drivers/staging/wilc1000/spi.c                | 17 +---
 drivers/staging/wilc1000/wlan.h               |  1 -
 9 files changed, 182 insertions(+), 183 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000.yaml
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000.yaml

--=20
2.24.0
