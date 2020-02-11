Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10EA7158C38
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2020 10:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBKJ5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Feb 2020 04:57:12 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:61018 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgBKJ5L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Feb 2020 04:57:11 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: oBZYQbpI6g9Iv7J1SGkfgbUwazEFQSu0lOS6CfhZQb9jeeXfkTEsBxQr/ZxtGMbRAOjfdHusMH
 70Q+ZZMGU1aoW1/ZBGLwQLlnak/r7dP26x1IhOlCH7+q2b/u/Dl3MrIuiR2+CZGIRTs1nDrjOs
 s3wKxE6fiKQdq6KzvKd/nPpIA3nS+wb5TYHP0Qy8qMhP7gwARVFZgv5zpzL+hIYHkPcEI1BVuQ
 R0Au/y1cZcAddTUnq1BaeibdidSPgwO2aKHxyapVAen2tiyZ0+BFQQciMttKUpGiFTLbKhwy5X
 FMs=
X-IronPort-AV: E=Sophos;i="5.70,428,1574146800"; 
   d="scan'208";a="64951095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Feb 2020 02:57:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Feb 2020 02:57:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 11 Feb 2020 02:57:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVZ8b0AXtHedULaBIy0U6mEXWyQqEk66bITLwSArRhqFU449zJdVYi6loVQsi2Bjq2hp/IeYFWCJeOmDPSoYxCUy7rVr8wVBzkVwhiWdx0BBhDV6ypHXis5UJRJlMItmZ6AG7t/c8x7Vrx7gBdizpQUJDXbJYWdyTgZQHszrqnaaVlRnQr5UvQ2xgwFhPb+LPr/h7Y9ml994fRfgMKb7r1QvtJ76qWxmBc5tIyj1y0nd+jS2ePEghTQn7OC3ewcnOGOgjC7jppLVKO1WxVNi+rKIWqaMhx3kgBVxk9qTZZ4lKVE7n8cK9Hb8x3O2iwycshR+rNy5pZ0tLjk+tFjZbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLttIJPt2yvWuWPKDmgXwiMVhVmZ8TePhqebF7LaFLY=;
 b=Y7Gzl7GMv8Li08HwQACmto5eU2a2bhEcutxlkZDv0dfES+X4lMAxbR1AgOKC/7o9/5/GvibrrH2kCPVtuHTBrJ9dg4K2HxYqcJCp86X4ofclySNonWwqVctoRVo4FdtFmXB3Yl6idOPVsM3N4/RakZGFE6sdWrh1cOXgoFrWYS5X+grm9G5Ne/FR7iew+/n2WhMqk3TvgTZ+2v9lK0KZGyxka3SLbXmQ9/VykmKENLMcnbbxwSVmPu3Y4yOMdCBeBcg79HNb6gI+olblNqM+o3tvVSai3tGkRO9btX0jkEXXZFHc3JOhSSGAXKjZqURIIfeHOn5ktKKiivVNXbRL6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLttIJPt2yvWuWPKDmgXwiMVhVmZ8TePhqebF7LaFLY=;
 b=DKsdt6zM+SHBEBwqjZRja2feXK1EaDKyWyxUdn77UDcQ8VJvf6SsqqAm8X1caToMP0HyBfDnhSOeOSDkTL7cNSKVSEkBjuYBCwuQ3DvihJrCcszjMz9SfZwfe2CnQ8FdUo8A4FXlqhlVRq1PoECnGke53Ve8ja+4u8RG2/n7DeA=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB4345.namprd11.prod.outlook.com (52.132.251.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.28; Tue, 11 Feb 2020 09:57:09 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 09:57:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 2/3] staging: wilc1000: directly fetch 'priv' handler from
 'vif' instance
Thread-Topic: [PATCH v2 2/3] staging: wilc1000: directly fetch 'priv' handler
 from 'vif' instance
Thread-Index: AQHV4MGfRmCkk9Wg2kqH0Gz37eYVrw==
Date:   Tue, 11 Feb 2020 09:57:09 +0000
Message-ID: <20200211152802.6096-2-ajay.kathat@microchip.com>
References: <20200211152802.6096-1-ajay.kathat@microchip.com>
In-Reply-To: <20200211152802.6096-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb6d9332-b155-49d3-d80c-08d7aed8c284
x-ms-traffictypediagnostic: DM6PR11MB4345:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB43451E56B51CD6EB14B4E952E3180@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(71200400001)(316002)(107886003)(6916009)(2616005)(36756003)(6486002)(4326008)(1076003)(6512007)(54906003)(6506007)(4744005)(5660300002)(66446008)(8936002)(186003)(26005)(86362001)(8676002)(81166006)(81156014)(64756008)(2906002)(66556008)(76116006)(91956017)(66476007)(478600001)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB4345;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CffaL5owBvW+kF+xg1YNobfxmQib31JTckiL57FgNp49F3HkZ7nEaqo3c7NIRZwkFopRyAgtUgOL0Zh0Dd7stxhHUENPmEGuc/OJvg0waiq0BPRhdaDu8nxaO+/Yf74tEJrzDk4doam6eTLr074aGrj3kApWmUhNOZC4PQqgV8iN99QNO/hhwmw9qZZcQ8OkxPtpSfYFZ1x6dP/SPz1RCfU2GdF9upQE6OGxKyetovlVClTtwMso/8laoMHgJHn5jEZLivSOW6sTlx1lM5dibZtPtdphjZ3TJaxGO6sNAQ0g8Rhn1GrkcoSQHSX8JjNL3ibE9cWblUWKry9YC1+mGn7Mw+hSyyHpHpAOyUZRNmkn3/rd8H2iNqxCYznB7Z/k7y6xvTdDFNjBhyhCp85Nule5E6KVDhNYplL9kIcaX9uBYNFQUbjMioABaa1vaTd/
x-ms-exchange-antispam-messagedata: xy26EVs3I0yG8QdCHaO1oq0IEKq/hwbxaGMenGy1tei+MG9qbRkekzxERcSDLfw9Sc8VEOjBiJrIt93m8hKwjI7Xlux5vZ1sLt0NKVSH+UV2JxgBGBLyKB2Dt+BiAmHMC9cMAm2W6Tu+2H/cgqnD5Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d9332-b155-49d3-d80c-08d7aed8c284
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 09:57:09.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AMJ5mnDf4NcAQILJAvTWX8o89iqFmXygmf6qOoqsFbJWh/pu96TOrWknSHUivcjiAfCOrFWMbOmFfFAMm3k7CzY098HLMOYU4qiTngbkzpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The 'priv' handler is already present in 'vif' struct so directly fetch
its value from vif handler in wilc_handle_roc_expired().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 v2: No change

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
