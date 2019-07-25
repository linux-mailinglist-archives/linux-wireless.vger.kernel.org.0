Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED858759A7
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2019 23:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfGYVbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Jul 2019 17:31:36 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33037 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGYVbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Jul 2019 17:31:36 -0400
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: h52+T/AePQCbB5ip0n9sXeM6NC+drYF87ZqKV7rWb21ctBFM+3V22sDsL1iKvxVfmmGB4dNy2B
 uhkvdtqjwEJ+lseC09IW+WXop/KSEqSI9vmUVnkUxmt6K+ShVW0pZfmyN9JmlFSdRtf53ht9c3
 q2XEzittzXvxxKt0RerVvYp09p00vjXJuq+t+IKoyndkJaLC72iVWbgJGeLXg7bawkOjda64z5
 NP0pnmtk4JXvdofRIXNsXhDZKUJmHyH+nsCDpIUxu4tB9x1kQigD+TbfzcyMKpIfsxG6fm20wW
 8r4=
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="44200120"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2019 14:31:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 25 Jul 2019 14:31:34 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 25 Jul 2019 14:31:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL9b9qnpmc0vkyTcLTMTsB5sL5EnQJF8xamyHnMGuMpSYLIYz2TqtGgXkxyocuVyrZUmcjzJJDRdLerJxAdZEmDMgDdlF2HfCMrBE3xdhtYOAZaYX+b3Qpx0DBoIThXw+4gUiuqDvHMZXHS4Nw3/9jmuhCgXtmEKCn9M70k8LZmF+k6RBHjnl8kp4maRMO9eJM/wK/zqoeNWpH7FqymjSH0cZI9dRFPb3ATuQq+wqScqxluaenLTeewjm19yWRXPySKz0a2D9ioDhs4uynvwwzBWI2Yg3IrFJbS9EKktyVW16thuYmWXflRnEDJmnDjEm49ijP+TrLF3i9UCEjS8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/S0zltY8ZuuGwUYidbg5eH+4iup00E6rMxdoHM/Q+4=;
 b=aOn9UuQN0l1NiAnUoo9JI+wBTCAgN7GHYVI2jfh1dFQXyC7zpFWVTebSyBwNrotU70W5sYXPyv+Ok1N0uDsPm4p3aGcwELjlIrB/jBiwBSs2SlwKQjzIm9pzuGBN2f3CAgQHlrley1wiC/vmXnv5JfnLLM/yU56O8PdgGRo5HnfZIzAH9ZiqlzY92W6vTVlzf/40pKiuwBFucBZL89J61hbZJ9xIP3Jx7CmANIRWIjt1KYayr+ozba26A4hKntiDkVkCO5iS8KSWGLl/dNMa56KAxW7iopWek2RJ7fxAbQ2nVnO/bFHsFljXfLADO5UIBb8cVx/WqT2BU9iIXWhtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/S0zltY8ZuuGwUYidbg5eH+4iup00E6rMxdoHM/Q+4=;
 b=eonY+1MKbY6CzZGuGG806mghUSEm78QeHyIB6qT2gqhIRiDybjgS9X/mfstTYkm0KUrwWMUq3HF29I0Z4H5ncuL1/Wdeoa4FKW6pBuaSmgww4fzW9owYXwe1/3NGhaSE0+QdKFBO7QKa1XwbnCBfCVKyObeulLFviaYOsAMKNxA=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1984.namprd11.prod.outlook.com (10.175.54.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.13; Thu, 25 Jul 2019 21:31:32 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::5836:a39e:ab17:983b%7]) with mapi id 15.20.2115.005; Thu, 25 Jul 2019
 21:31:32 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH 0/6] staging: wilc1000: don't override user power management
 selection
Thread-Topic: [PATCH 0/6] staging: wilc1000: don't override user power
 management selection
Thread-Index: AQHVQzBT7IkssIkL3kugvDOm9aH0Yg==
Date:   Thu, 25 Jul 2019 21:31:32 +0000
Message-ID: <20190725213125.2810-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: MWHPR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:300:ee::26) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a0c4676-33f6-4de1-4daf-08d711477636
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR11MB1984;
x-ms-traffictypediagnostic: MWHPR11MB1984:
x-microsoft-antispam-prvs: <MWHPR11MB198457617D5858E6CFB7D56E8DC10@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0109D382B0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(2616005)(476003)(102836004)(386003)(486006)(6916009)(2351001)(6506007)(66946007)(186003)(99286004)(2501003)(26005)(316002)(52116002)(5660300002)(66446008)(256004)(305945005)(6486002)(25786009)(64756008)(66556008)(66476007)(53936002)(1076003)(107886003)(71200400001)(86362001)(71190400001)(4326008)(68736007)(478600001)(8936002)(6116002)(6512007)(14454004)(50226002)(4744005)(8676002)(5640700003)(81166006)(81156014)(3846002)(2906002)(6436002)(66066001)(54906003)(7736002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1984;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g7+KWHUD10oZQ5kN5M65nRNEbbHFQNtgBadi3/8jerp2RUbbg6WqMCLxPW1NmqkPYaNHNucgFask8mp4V1Qfkgx9kulXSGVILfHhCB40l9rd8c5HcOwEV3nBA2k4nCxwGR4zbPowC2/Z6QrOsbXNQI1GaPTeoJGr1kC78xIsVHpHSMV3soUhQdmm312VvQU6+gIGY7juUC3Sk80hm035eYad73A7tdXJpQtU2RfgfQ3B8XsnJMXYjyuAldufZuc0xsdjW4myp1eqLNvAhp56ru69z9saqdrIpgJ9aUicp7ffajNq6p9zRCw8w9GpQ+g9nx3OsEIxgw7wFnBR31KRj0gg7gD9yRLCnqIWrZmTyjPRtMj6Ac5jM5/Z0xTD8co4QK7jcart57y5P2dKdHXMyehQvLNbOIDuZ2ixVwt58t8=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0c4676-33f6-4de1-4daf-08d711477636
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 21:31:32.2116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

This patch series has changes to avoid overriding the user's selection
of power management. The current implementation overrides power
management settings according to ip address state, scan state and number
and type of open interfaces.

Adham Abozaeid (6):
  staging: wilc1000: remove inetaddr notifier
  staging: wilc1000: remove ip timeout timer
  staging: wilc1000: remove unused members
  staging: wilc1000: avoid overriding powersave state
  staging: wilc1000: apply power management regardless of open
    interfaces
  staging: wilc1000: remove manual sleep mode

 drivers/staging/wilc1000/wilc_hif.c           | 29 ++-------
 drivers/staging/wilc1000/wilc_netdev.c        | 65 -------------------
 drivers/staging/wilc1000/wilc_sdio.c          |  4 +-
 .../staging/wilc1000/wilc_wfi_cfgoperations.c | 34 +---------
 drivers/staging/wilc1000/wilc_wfi_netdevice.h |  2 -
 drivers/staging/wilc1000/wilc_wlan.c          | 14 ----
 drivers/staging/wilc1000/wilc_wlan.h          |  2 -
 7 files changed, 6 insertions(+), 144 deletions(-)

--=20
2.17.1

