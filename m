Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE49707FA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 19:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730945AbfGVR4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 13:56:16 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:6065 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfGVR4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 13:56:16 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: DX5Lnt1GpTDQYlnSEC0R+ndtSoys++6yyHj+23D0J6F8BVpobRGhoZEUdetMK5zHxrAyAjWasS
 EnI2rubVTzuooNMbjft+jB4IoCKB/fXO/vkWKtNE8XMIl3u7milJ8MMVWwFpj/ND2iE3zhopbD
 B3VP3ojbznLvrxvepMNforYdF6ubhaSlnTQI8NatgSEX6zi9nx8Thg1D3/BO1evek+ohMb/osF
 j0i3f9YPjvZAJbVSVFWTf/ofJS16gpPEnZl52M+jTGH0pWC7L2BgkJKqG4QoYeFTP2us1sFjDJ
 7uw=
X-IronPort-AV: E=Sophos;i="5.64,295,1559545200"; 
   d="scan'208";a="42278620"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2019 10:56:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 22 Jul 2019 10:56:13 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 22 Jul 2019 10:56:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbxH2f28Vxu/kZeE6WPimDqDpPu1DLdovDxmU5bKsKkBZ6XSyuJmEhEt/Kh5P4lyiJfHF7d2Ka1eC6kybdJ15kt2f61nj4MEgIAokTJ5exZHYSVDXg+fQA15/EanWICbGwESzRh7lBaGtbt202JLIwXMXYokRg6+/T2xaOTFIfX3p9Af1LnxjNJxsh0q437lnQzjkT6H58ToOfcc2GyZ+/0KrOeMiKp969jvZ/AzK7SK3B7FTS87N1w22MCzXp1ITlmVtSoyWgK03tt2bYhyCZamjI10UOjvKhKSrOJ63rt4RUX01D8fCfA7373yHS9XZGb2q9mFq6kEWGZ1HpPQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lonj+Prmicgg53M3NM2AlpdIyUcK5OZdlPrIGcGvvw4=;
 b=Y7nMJMAyH8+HLJ0Iif/cG4c509bP8n6zk2fzfUhIpTGJ5t/rVPZGGo1hEEJCfQRJSsSSEYKHHzMzdPQeSMGocJD355kAr/9eEngcqlToJh8Jbmh7PJbLWZgJY6Ghj5TqsMm4a94CihFxp1lEDptvKMyQwb0EpVoBDIw0yL8DoljGBAo6QBCyvfOJYnhXqpVGe0/s+bVu0YcR7bsBNWMjHD4dCH2KR28CPmFdAczeqSKGfYt4I2PY6NszLWGRsAYuMiYyf7mlKfuvmsF/yQPpFCE8enN2P1anMJlwv8zsAqKQ5EN07KbfkWhXuj0YZiGRnWefdV3uqGTICH8KrXVKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lonj+Prmicgg53M3NM2AlpdIyUcK5OZdlPrIGcGvvw4=;
 b=w1oblm7Q6rQHrWSTu4ZeWCh7wqbCOWEmKxggjeogEjLvc1+jt3GiET6wCW4ZAiBAcvQCTOT8SZNa31pS6NQ+S0+0wna1cvWBVbRgwAKgHy+u66KtdC1FzaMcr5F0RnnotZMPmZVCwrFmOsh7gq+K+89QwxU6i/6qcAMipgOh5OQ=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB2063.namprd11.prod.outlook.com (10.169.236.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Mon, 22 Jul 2019 17:56:13 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::1912:9972:700:c536]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::1912:9972:700:c536%3]) with mapi id 15.20.2094.013; Mon, 22 Jul 2019
 17:56:13 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: flush the workqueue before deinit the host
 ifc
Thread-Topic: [PATCH] staging: wilc1000: flush the workqueue before deinit the
 host ifc
Thread-Index: AQHVQLbAuYh1CqTgu0OlxDBGjc23ag==
Date:   Mon, 22 Jul 2019 17:56:13 +0000
Message-ID: <20190722175604.19650-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: YTOPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::18) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2e8cfda-37d8-4d72-8c88-08d70ecde28d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR11MB2063;
x-ms-traffictypediagnostic: MWHPR11MB2063:
x-microsoft-antispam-prvs: <MWHPR11MB206335A6E4FDEB6BFD876E4A8DC40@MWHPR11MB2063.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 01068D0A20
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(396003)(136003)(189003)(199004)(52116002)(14454004)(478600001)(36756003)(50226002)(66446008)(66946007)(66556008)(64756008)(66476007)(305945005)(99286004)(476003)(14444005)(256004)(81156014)(2501003)(7736002)(5660300002)(25786009)(102836004)(81166006)(186003)(8936002)(26005)(6916009)(66066001)(2616005)(486006)(4326008)(4744005)(6506007)(386003)(86362001)(3846002)(54906003)(5640700003)(6512007)(6436002)(6486002)(6116002)(8676002)(2351001)(1076003)(316002)(68736007)(53936002)(107886003)(2906002)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB2063;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Tb5zlOM+Rji5lZyxnVMZITioMstFVRMvuCE2PftkGU2ijRR+u6lq0BtDWjTZsVZIdVsiW5C33QU2+ZdaXlY41LEbYzfZ8BR0wSFiMoXyLXQgdjJQfvQEqAUTIciMokNlJ94lW/vbDpXkZtTmSZxobilDuGQoA2l+ZD6iZ7CZ8feexhZN/Y4B1hMMEw3iS8mRFB1IoUXPLxNhgzXGg39cMSyVG10Mc8oo8z45BMZ6T+pBOBG16GZdPXMyaClBhY0mkFtg8h+7xwOUJrV76UgY7dA8LrQnuPzyzP1JEvtf7XOalxXMxo7f6KQMu2xryHE+ifszHZGNN1te/k/fJi9+7mq2XZlFox4D1iDqyxY8GJBjTqesxCoArlcwShu+2YjIM2ShuKt8GnLEL5bpmz+cDcNmx7cB7vDoA7R0L9Zxyws=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e8cfda-37d8-4d72-8c88-08d70ecde28d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2019 17:56:13.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: adham.abozaeid@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2063
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

Before deinitializing the host interface, the workqueue should be flushed
to handle any pending deferred work

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index 63c38562ad1a..b0a6045327cc 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -2544,6 +2544,7 @@ void wilc_deinit_host_int(struct net_device *net)
=20
 	vif->wilc->p2p_listen_state =3D false;
=20
+	flush_workqueue(vif->wilc->hif_workqueue);
 	mutex_destroy(&priv->scan_req_lock);
 	ret =3D wilc_deinit(vif);
=20
--=20
2.17.1

