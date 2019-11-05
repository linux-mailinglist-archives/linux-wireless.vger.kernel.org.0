Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1EEFA1B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbfKEJvo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:51:44 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:55789 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387656AbfKEJvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:43 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: eekW4axk6KOvWiidnwkT18moKo9Yarwuam5C3/aYGjMG0eGCHhVE06zJ6lOe65npQ8AzUlYNR5
 MNLgOGGfNDQKOM+cbpA35fp8EwmMMSdDvDIBT1r8/EGbYfWAcaQdV/9EQR+4NmEYD84Z+GMqaM
 yWE5KenV7XJGCBuANOE3bQJJzSoO/HgV35RFppS3mXnQ8VhNqPihSzydmy93GohNwpZlLaUPQ1
 xEuOR5dR+vBLwcEndPj3hjDXq5vu9RFA71g/OlOenCpgzWQVcJIHMUA5VMSvczIdBqTdTZF7Zp
 NRk=
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="54166711"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2019 02:51:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 02:51:37 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 02:51:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8cYPplypZ/MLDjWz65MAt7xr0+I5js3qkuoOeAk6C18HJStlMmlo3ccyqhU49B987OxEyYkZYJNcmoVnTrydScYx/YBNnhmkSiKxe0SNoF2JSuUZCdOjRohwrGDpJsuu2lsBukqxMX7MYO42IqsfXf0CgHt58fPL8dywPz34ouoepW5H0NQBb2ceyru0G+HHj5MX7w0eWlFcttcN0JqB5Pka4WtDPuvrAEddLcvtXwLWP/vBx9RyBegR9zWLnsbrmRE6iAZe95DS3YWjTQx855bHF//Cim4xXMNpVoOGyZLTHxySYMLgy+54vYw2xW9LAuJnDVBn9MMAqjY53aP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2h5wLRUd/IONeAju+PBwRnp7wNYSWOXJxt5ZT7AD9k=;
 b=N2S0LdE0jeZ70RT41/Pk0FI6sVW0pqgt+ikndVxGXfhV5neuRbi2yDz3yN9jICalPkYKcgU3LeYT5uBosmxDz4BM1lMAdCWLhARMM7PLUZxLYzPspS2Nylq/bAx3wNc6tO+95KGRRsBu/pW3f5/N99qTgv+Vmz8n8E2DPsEzo1WQ+rprGViat3YjWBNrP/wyLIrx0spiDGm0VnylNu3DQEEYgeRZ2RbZoUzLz98F4Vg6sWprNyprseX8cj5MfeeXUqj4W680vp8mnxoDVuwDtE9QeJrns50m4LFzwnjrRi2xDGSgTy5tGkzPZrL9Pad31nd6YVL6Wx25ORX9hzTrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2h5wLRUd/IONeAju+PBwRnp7wNYSWOXJxt5ZT7AD9k=;
 b=Bf9WbpTW36xofwT8BotQr0TetaWwRFfnXAh1LE1XTxEb9oBsxiKvBFYKq2vrUM3/d5aP+ZRsDQFdKxE2BT+Bx/UOYXHd1xIl1xFixluJAayngpqUs31YxYhtEzBjVlvF+5N4LOdB8Y1IUEeHn4VFzGaJD/xiTN76lKpeJR5FdpE=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1972.namprd11.prod.outlook.com (10.175.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:51:36 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:51:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 6/6] staging: wilc1000: use defines for msg types received
 from firmware
Thread-Topic: [PATCH 6/6] staging: wilc1000: use defines for msg types
 received from firmware
Thread-Index: AQHVk76cLI+M2vYE4kiXn40twMiKZw==
Date:   Tue, 5 Nov 2019 09:51:36 +0000
Message-ID: <20191105095058.24223-7-ajay.kathat@microchip.com>
References: <20191105095058.24223-1-ajay.kathat@microchip.com>
In-Reply-To: <20191105095058.24223-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 686562e1-5bb1-451a-8693-08d761d5bf5a
x-ms-traffictypediagnostic: BN6PR11MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB197236C15137C6C355E75A1CE37E0@BN6PR11MB1972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(6436002)(2616005)(36756003)(71190400001)(486006)(186003)(86362001)(76176011)(386003)(14454004)(5640700003)(52116002)(2501003)(6512007)(64756008)(99286004)(6916009)(66446008)(66476007)(66946007)(66556008)(71200400001)(2351001)(26005)(316002)(8936002)(8676002)(50226002)(81166006)(81156014)(102836004)(6506007)(5660300002)(11346002)(1076003)(476003)(107886003)(54906003)(446003)(478600001)(25786009)(2906002)(7736002)(305945005)(4326008)(6116002)(3846002)(256004)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1972;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t49OD4v/zwjKxXZM1YqBbs8UFQhyRKD4XWtiTSMy9Dm+qJ+HrD7X/iW/IbPZ1twy386X2Sx5wkJXaAxtlLy+hnjNDfT5r/3OM7JyajtFe4y1XQMpf3lW59dcQTvX3taSS3MpME/Af5nKiyjlS3LYj7ns9oWfAzvl8zm5SO9IRK1jU1bzu3LaJilkqoJuZBRVNjgKsTslvN5gj1n3UWtj7pTXlpD9cRPFH8SPGE8p25tr23/+b6wo81XH2t1L/ZjoZsuz4NvShxSNj55eJTrZIuJrHl6xrkSrPQQCeLSITCXMaC3XyqPEJ68aS2LQeiciGEq1Y2kRBQZVUftnZnGgbF5iungMQXQjK0E7+FcNXIanUxAVvoRraatdJJg6PViBUUkwWjM/WNAG3ZUba1kP+/Z+AU8gfMf40uU1vdEcnnOjZLVApaNukOkU2r2FgFkz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 686562e1-5bb1-451a-8693-08d761d5bf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:51:36.4562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZJv4N8luI+1fmG+CFwcx41zLnEe7zMdg07b7KBNMFqbLu5wRy6/2MSrjjdzWQI+UEwHkZ7ws79uwWNPVCir7Jp1XvLL2V0dZCMStHddzdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added defines for different types of messages received from firmware.
Removed the unnecessary comments because after the addition of macros
the message types are self-explanatory.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wlan_cfg.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wilc1000/wlan_cfg.c b/drivers/staging/wilc1000=
/wlan_cfg.c
index c5b1678c7b5e..6f6b286788d1 100644
--- a/drivers/staging/wilc1000/wlan_cfg.c
+++ b/drivers/staging/wilc1000/wlan_cfg.c
@@ -44,6 +44,11 @@ static const struct wilc_cfg_str g_cfg_str[] =3D {
 	{WID_NIL, NULL}
 };
=20
+#define WILC_RESP_MSG_TYPE_CONFIG_REPLY		'R'
+#define WILC_RESP_MSG_TYPE_STATUS_INFO		'I'
+#define WILC_RESP_MSG_TYPE_NETWORK_INFO		'N'
+#define WILC_RESP_MSG_TYPE_SCAN_COMPLETE	'S'
+
 /********************************************
  *
  *      Configuration Functions
@@ -360,21 +365,14 @@ void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 =
*frame, int size,
 	size -=3D 4;
 	rsp->type =3D 0;
=20
-	/*
-	 * The valid types of response messages are
-	 * 'R' (Response),
-	 * 'I' (Information), and
-	 * 'N' (Network Information)
-	 */
-
 	switch (msg_type) {
-	case 'R':
+	case WILC_RESP_MSG_TYPE_CONFIG_REPLY:
 		wilc_wlan_parse_response_frame(wilc, frame, size);
 		rsp->type =3D WILC_CFG_RSP;
 		rsp->seq_no =3D msg_id;
 		break;
=20
-	case 'I':
+	case WILC_RESP_MSG_TYPE_STATUS_INFO:
 		wilc_wlan_parse_info_frame(wilc, frame);
 		rsp->type =3D WILC_CFG_RSP_STATUS;
 		rsp->seq_no =3D msg_id;
@@ -382,11 +380,11 @@ void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 =
*frame, int size,
 		wilc_gnrl_async_info_received(wilc, frame - 4, size + 4);
 		break;
=20
-	case 'N':
+	case WILC_RESP_MSG_TYPE_NETWORK_INFO:
 		wilc_network_info_received(wilc, frame - 4, size + 4);
 		break;
=20
-	case 'S':
+	case WILC_RESP_MSG_TYPE_SCAN_COMPLETE:
 		wilc_scan_complete_received(wilc, frame - 4, size + 4);
 		break;
=20
--=20
2.22.0

