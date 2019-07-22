Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D2770B94
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 23:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfGVVjB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 17:39:01 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60740 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVjB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 17:39:01 -0400
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
IronPort-SDR: AshNzRQt9xbsmqL/iZfbVVMS1PjZ81/7ep2DFIrPx98EriHaKFV7Hf6B3mMVPE073PHvjj201C
 uWS11gu4ph3vgKhgkAvSoOsTTpMINJ0CnLvvs9I0pPm/CgSVkT7ajqVS1Pxlt8nz1E1YWnZAIG
 kSMg62LnNF6G7stONkmdG+tIpmnLMdbhQ/2nva7imjh3TPqekSRy1yfnrgQUpnzuqp5H0rxcCb
 tMC9EgFEpJoh65h5ZMXIVuevL+KDkIFju2mxurRZzkbX3urGyTPD35mdraNTq/EJ0YCzzFFIWs
 pos=
X-IronPort-AV: E=Sophos;i="5.64,296,1559545200"; 
   d="scan'208";a="43731034"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2019 14:38:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 22 Jul 2019 14:38:45 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 22 Jul 2019 14:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSIIpdu14AEhkUz/we+mMzepx8PC6OT74YisJArPPJFnjCdAcONMewCS2a095MNrCW75F27dGZSTXxHKyMtGSw4yiaJs6QSkoVsW/yEHYe7Thnh6knbvjsTBc0QWu5sB+pySMIiUxJIxKmrcaIBwdQSWReowRpoAWwryyLMj3fnhQQlStlE+vd9EF0HHuFeM6tTcLw284/575GZwnBnHDw+A2xSlgKjCOtQOjkqgl8tNhAsa5a/6viS3gmiAajnQZAEpWgo/zsWBRi3QqABT+vCQVsocow9FmjVhcKPTKp0yONaZtzgIiinTNT3+MNakbRIWmqhVSHAXJSE2UXf9iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1tUO7npM/ngqJDkVdiDx4exPQWtxTz4vaRPlYfwADQ=;
 b=JcpRATy4PDzQ95wEmOJ9xqynFF1QAnZEY4cBG9Ea155zGU/6Amo0cES1KULMosqiWJe8XU7nLqC6EloMSMQYO+bK/oNoYjXeZcac9u37xvlOPqZr+rkElh3e7E/DsxbsU8GLmrYdflG7ThQLUcxKr94I+JVSDKHOcgInvNlAVj/JSieOLSdomo28B67ic9addCISvUzuibM74sJ0Oc+DtSBds14codgInFZXsEoFg/meezsNBZ52TmokMKwJh/spKyuae+Akp42OQFLDu9Ew/6K4O7gt+2q9zShKbpgyQYg4znChv0UYCyTe/u5nf1M3iRwRGbDAoaG2PMwM48SIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1tUO7npM/ngqJDkVdiDx4exPQWtxTz4vaRPlYfwADQ=;
 b=qKRMh7Gw3UA9uTzrVR8UgJuzPAZlgp1TdCZErEY/QrbgFxwlJtTINyBVuGvMNmtXDRMhOYnjVcokJfOk5OxravTgBfFuPF3nYOUwucPR3Hv38dBRc2OAf/luxgDxFhZDTWHoWmWijYg/JNICvVu9HaWaRQKcL2me91E3AXq9QWw=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1343.namprd11.prod.outlook.com (10.169.232.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.16; Mon, 22 Jul 2019 21:38:44 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::1912:9972:700:c536]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::1912:9972:700:c536%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 21:38:44 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH v2] staging: wilc1000: flush the workqueue before deinit the
 host
Thread-Topic: [PATCH v2] staging: wilc1000: flush the workqueue before deinit
 the host
Thread-Index: AQHVQNXWR2TSOk1vvESnIFJvm2nxUg==
Date:   Mon, 22 Jul 2019 21:38:44 +0000
Message-ID: <20190722213837.21952-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BY5PR17CA0016.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::29) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 883c8593-cf41-46c6-eb2d-08d70eecf862
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB1343;
x-ms-traffictypediagnostic: MWHPR11MB1343:
x-microsoft-antispam-prvs: <MWHPR11MB13439FE075363EC3C620A56C8DC40@MWHPR11MB1343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(136003)(376002)(199004)(189003)(5640700003)(256004)(1076003)(6436002)(2501003)(476003)(2616005)(316002)(54906003)(4744005)(3846002)(386003)(14444005)(6116002)(52116002)(2906002)(6506007)(2351001)(5660300002)(25786009)(7736002)(6486002)(305945005)(68736007)(4326008)(50226002)(66066001)(53936002)(26005)(81156014)(81166006)(478600001)(107886003)(186003)(8936002)(6916009)(14454004)(102836004)(64756008)(66556008)(36756003)(486006)(66946007)(66446008)(66476007)(71190400001)(71200400001)(8676002)(99286004)(6512007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1343;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MNXVBvJUS4TeT2V/XkZCZagDRs2Q3VN3FVJ7qfYNoUrqKWougxlXKGz+65TbrxRmEm5Gy7UkrK810qgeqlq758k/zjX4OjiRHWR8GP7lWtxjySR0d6gPPV8gJp8K/EeNDDAkaeMd+6/9Fcr3henW3hMUBGs3o4qyvXFsyZk0YO/n1FFcGXRjVv1qQHMeVWo0yw50rhqC9OXMD2P8phsxc0tKr7/1nglxmURZNGFCuFidERUplPGZeGSm0A1IO0GfHqbvsc0dBeeeoU3rldbnBBFAu/sb+ZSaQZcqoUCvPRy60dnksQ/lvFMzuOjtpqDvK8JNzKabmXVuCSIPrgvhVubYI28Dz+5gngJiuToRCu3xrYiQv0tlcyrYfz+WPjW+p6bBbXxzli5cNB7AWl0m8Yrv8+3uC3mW5rK2cbZI7qs=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 883c8593-cf41-46c6-eb2d-08d70eecf862
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 21:38:44.0739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1343
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

Before deinitializing the host interface, the workqueue should be flushed
to handle any pending deferred work

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
changes in v2:
 - Regenerated patch from branch's head

 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index b0daa1136663..b0a3e7b04f61 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1795,6 +1795,7 @@ void wilc_deinit_host_int(struct net_device *net)
=20
 	priv->p2p_listen_state =3D false;
=20
+	flush_workqueue(vif->wilc->hif_workqueue);
 	mutex_destroy(&priv->scan_req_lock);
 	ret =3D wilc_deinit(vif);
=20
--=20
2.17.1

