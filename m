Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF7158277
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2020 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgBJSgC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Feb 2020 13:36:02 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:23311 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJSgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Feb 2020 13:36:02 -0500
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
IronPort-SDR: ixxL50dZogcuFPTuhA7ZNbfIWDFu2slwM8gZQP1zbdI+LFgwLonIu7KhycDHajUzP99xXXF37D
 EHsOpB7Oep1DgKRh1zKzCCQL2uDjxBRYoGGQiyTW4xs8EdgYJ9Q+I25tQ4oBAEpRFncatnW5n2
 vT2RUmoHYyBfMJepJia9ax4SgwxS+8DJ68HqHLhxw82kUrBA77BCBz643Ml/kbt4Jzx+QEhMeE
 5Ht6LnjEv5WHgSZ8xSe2ndiphja2i6wUV/soDE1HXYJKkHEExNATPmPIfBXEZ/Fr6Gzi7WWoHx
 GzE=
X-IronPort-AV: E=Sophos;i="5.70,425,1574146800"; 
   d="scan'208";a="1893368"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2020 11:36:01 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 10 Feb 2020 11:36:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 10 Feb 2020 11:36:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqRz7sOjNKs4Iqr6gNRNtYwc1ev1oxPDrMn0Yc8vEbagjB0NBUnRcxyhmel498+DeIBuIxTByqBNqup29yscFuqcoUEOazIQNgNVEBs0mLlE/uRR4XdUKWmwbCgFBLxf7th+MSelogaJAXqiiKeqYUEUVzqyIVm8CvLK6ySEhUFpLa2ybCggxgK2skXq4QIzyjIUv49N58/YCix0CqEwEuav4EGabEqlr0cxWXhQCbnSjbcU+IXNj8EA4/MymGj3hHnn8ZoyDLOxvfRY19fShBl4FxIqfI7upHWXDLe/r0DomudXn4ZUWTeVPtpL0ZtfUrQKlAh/NXLN/m71rES+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiuoeTcsv5orErP9sicNyuvoUZHRmKCNR/ZbqMGGyxg=;
 b=hA0SVCtvMUFUwm2DmF7ne93PiQoqtkCCaKPSgTzeqTXnx4G3QNRHqUVM5+Q6jQB9E8q6/+BdwwmJw3ms0gPfRc9mL7OBNHB58PdVOuAx/1GQdaxZo3+SWGfq96/R7O3ybw0Z71WeZa+tnkLKM7a5QHy6vLRRJdX+vvylXxZS07OUYDJwXDK/nTnRy2i4Kr6/miVFu9+EtUjJLihMzXIFk8/YyJD1jUqMGzyExoqAb137u3CGikzoTaqKcd/oQU9PDPP7EI+dGaESrA+wbhjZqo041KdzsFD08Wt7pwVHw6n462yJb3lCvlCzNtP66DuvdJp2pMgIbDYrdqpQJdwMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiuoeTcsv5orErP9sicNyuvoUZHRmKCNR/ZbqMGGyxg=;
 b=emNQbxjy45qJnzRq92+2uOQkm8pm2aqR2iF54yF9HDoYwGziLdCyt6Ij1kBD+O2m18h0Qj8ffbbSpiCbme3hvuIyojlPdJy+a2Wf3W1sRI/OgeoDO+f2GPQ/QRjyU3b/RP8xOZJG28o9SDqvyAH/jApitgzl643IHSdvf430b0A=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1636.namprd11.prod.outlook.com (10.172.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Mon, 10 Feb 2020 18:35:59 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::584d:cea5:1dfc:7e61%3]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 18:35:59 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 2/3] staging: wilc1000: directly fetch 'priv' handler from
 'vif' instance
Thread-Topic: [PATCH 2/3] staging: wilc1000: directly fetch 'priv' handler
 from 'vif' instance
Thread-Index: AQHV4EDwg7/9xHBhMUaUEk0IsN9vSA==
Date:   Mon, 10 Feb 2020 18:35:59 +0000
Message-ID: <20200211000652.4781-2-ajay.kathat@microchip.com>
References: <20200211000652.4781-1-ajay.kathat@microchip.com>
In-Reply-To: <20200211000652.4781-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aee6f23-eab6-4bec-0c68-08d7ae58132a
x-ms-traffictypediagnostic: BN6PR11MB1636:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16366A988F895460A3026D7BE3190@BN6PR11MB1636.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(396003)(39860400002)(136003)(189003)(199004)(2616005)(86362001)(6916009)(8936002)(5660300002)(316002)(76116006)(66946007)(91956017)(66476007)(1076003)(8676002)(66556008)(64756008)(66446008)(478600001)(2906002)(6486002)(26005)(6512007)(107886003)(6506007)(4326008)(71200400001)(81166006)(81156014)(54906003)(36756003)(186003)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1636;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnmuKzSpsFM51agwhqEpBYnX6Y80F8y84SCv06+QDeWqBMiVh7z3SW5prhC2cQCbzikk7eGYGoCmq0VENNEP9MMhQQ0UZYmkB68N3HuckvhX1Hr1MDZgf2IWMz6Vkh9eUlRySGLY9cbWOnRUqyWYXaqu3lGsjjQ2QAJnsXgX0THRYQ92Z8qq6qXl4zTkrvGGgb0/6dYzUsZh/lnbSt4131RpkMoGJ/GmODFy+r8fINl24Q7b2roIIXURvtxjfnecJk9gnNfQ+Y1585RpDVOn589iweruqX+mQZJK3DVcsq0KVfnS4KmpLv4JDdwp9OsUnbY0jinQEsfj+uUmXIjwRx7NgA9EAVha7A/Y01ojndxJcKnqKiFyET/PEOyGOD5BwPsW8281xDyDOFeOBbd4nYVpcVD+vrz3GmkN9rSWgmQnNbe2wStHCZZMAXt24CcH
x-ms-exchange-antispam-messagedata: gAFQdoD8XK3ta40iGYVuNio9ZvY5MQ7xlIyCSxz2C9zCd+MrbBpDuQLvL7mP1QNeckdpCHLeymnfTTflumhrb+PCn46Eg3HzgUz5i3CAYlSJpb3guQawKLBRxFDs7QvBhBoXn7atWnqo5p5IHy9aiw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aee6f23-eab6-4bec-0c68-08d7ae58132a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 18:35:59.6873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /gtbUMcfhhS3zLpxiWOURN+TIWgEIKiu8C5eqJIcyzl56rJadSXzsYHCKX1e57JvkJp8DevrQ6WiN1iUbJyaBOngN5dimN5E07wMXqz4pp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1636
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The 'priv' handler is already present in 'vif' struct so directly fetch
its value from vif handler in wilc_handle_roc_expired().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/hif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/wilc1000/hif.c b/drivers/staging/wilc1000/hif.=
c
index 658790bd465b..c8c41c2df4ec 100644
--- a/drivers/staging/wilc1000/hif.c
+++ b/drivers/staging/wilc1000/hif.c
@@ -861,9 +861,8 @@ static int wilc_handle_roc_expired(struct wilc_vif *vif=
, u64 cookie)
 	struct wid wid;
 	int result;
 	struct host_if_drv *hif_drv =3D vif->hif_drv;
-	struct wilc_priv *priv =3D wdev_priv(vif->ndev->ieee80211_ptr);
=20
-	if (priv->p2p_listen_state) {
+	if (vif->priv.p2p_listen_state) {
 		remain_on_chan_flag =3D false;
 		wid.id =3D WID_REMAIN_ON_CHAN;
 		wid.type =3D WID_STR;
--=20
2.24.0
