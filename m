Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C305DDC53D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2019 14:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633909AbfJRMp4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Oct 2019 08:45:56 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:29188 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633907AbfJRMp4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Oct 2019 08:45:56 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: LIBt6C0ifiWJHRSB0f4oOkIuZuSCZW5yhZOoJe71u2PhiN/4fzINZEp23iuCGMmdL6nVfLUxev
 A/ZdurK9bKqaEtF0tvJNQD6wqIa95ikGwC3pUu12/MiexWF1nEqJFllu0tdKgrM/AvB3b26g7A
 eWKhX4SEwb8EsHptx5gidrM3BiIi8GW1SJDnAjqffVE6x8/9ZRIQjOsP71SSh2q2UUDYEmOBR1
 dVQ06/Pas9oNRbQH0yCanyZ+RyOBJmeks6h55FDP4BFPoMT9ALDWLMV0fcs5IpXefZW5kqSDm9
 e/Q=
X-IronPort-AV: E=Sophos;i="5.67,311,1566889200"; 
   d="scan'208";a="53210178"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2019 05:45:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 18 Oct 2019 05:45:42 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 18 Oct 2019 05:45:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVEAwbkMJaBGRubsixBXaZpQqpoZX7uRCjEQl6JOSaxXAGmJU50oaKcgF93IEuhus0PpIlm2mzfFuomwn27w9JVuUVvfbOeGqMduzZL0aX92AINfym+4sCfgFnVhrve0FGtaDMz+QBGZrTA70XBvq5DfKJGrsWiVfRCjhEQJwTId3kRTOJR93+ctvQdtRXYo+kDcnhJ0h6lbA/RmdHcf4srdoQaqRWlv9/z3ssti1oMrPzu4ne4lITTtNVF2qo3owP0oRLk02zTDs8cgWSLVIxp4uXTIg1VHSILZu/QQ5Pwdu1fLJxBsAVHEzmLUX0S6VWuWztmqjy0uky/n8q3NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjJ6DHN4D1RRaElXKoESu0DpwlFcEEtBKcP3biPBJLA=;
 b=RXx+/VnZ5ndOfqz+kp1DJ6rB4WdI9/AZL/+au4crH8aRXmf1stNId846pnzZC4u9TJL0K0JJspMHAxgMgiCf8X312XyoAuziJP8PfO5Gcb7xQrUzhulbhBjFGFKKFWFXeO8RaFM2m8xO6FhjQ4RxyfeGCw2Sfo5zNLpp6gLgwf3rIDLDwbnfXDEDQiTFdICtvbHgvMHuvTCxrG0yiKmMqmSHBHDGoFpmp1EdgvO+WtPsX9h4L/193YGGqZlHPQi2EM1SKzCjrgQg1lufrBGUxjnk/TrTX6uUcy8QLkOqR80SifPFejISGVGFBZjzxn/1VGkccMsH46/urIgyAvXB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjJ6DHN4D1RRaElXKoESu0DpwlFcEEtBKcP3biPBJLA=;
 b=erAz4nDyw8zf+2vc2dBM96fbApLyoUrmAAktVERS4Ka503itX8RMDcK+l0WIkvkYTOk80z41M/rLalC0EYSYV1vE9mW7a/eIb4Y0cf0FLepFOqu3N+T7vBhkQi/Ir+wfE2BxLUHLAtho0ygS7cA8ODdZwrvdQS6a+lM2F/l/0UA=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1793.namprd11.prod.outlook.com (10.175.99.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 18 Oct 2019 12:45:40 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::896a:af80:2549:3f0b]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::896a:af80:2549:3f0b%7]) with mapi id 15.20.2347.026; Fri, 18 Oct 2019
 12:45:40 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] staging: wilc1000: handle mgmt frames for both interfaces
 during concurrent mode
Thread-Topic: [PATCH] staging: wilc1000: handle mgmt frames for both
 interfaces during concurrent mode
Thread-Index: AQHVhbHy8B4rtDZdEUOaWkor524lEA==
Date:   Fri, 18 Oct 2019 12:45:39 +0000
Message-ID: <20191018124511.22751-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::29) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.82.17.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e257579-315c-4f1a-56a2-08d753c9149c
x-ms-traffictypediagnostic: BN6PR11MB1793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1793278AF60C74A79490C9C1E36C0@BN6PR11MB1793.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01949FE337
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(346002)(136003)(189003)(199004)(81166006)(99286004)(8676002)(71200400001)(71190400001)(476003)(2906002)(52116002)(3846002)(1076003)(478600001)(81156014)(6506007)(2616005)(8936002)(386003)(5660300002)(6916009)(102836004)(316002)(6116002)(26005)(14454004)(86362001)(54906003)(486006)(186003)(107886003)(66066001)(305945005)(36756003)(7736002)(50226002)(6512007)(2351001)(66946007)(6486002)(4326008)(25786009)(6436002)(5640700003)(256004)(66476007)(64756008)(2501003)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1793;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: owmHKOkfzFHkj5CUqqKy18Z/9JINE6hAwiG62cCSHzNU2keKN5BGOMNfGq9uz3jH6WTUI/Bbs1JAOMJeMy1vug4rvZbwTgw3uFUs/nY+AA5FnaicOcoVpI42opyS53vuZj91FPdozuHFMoX52cDk/Mk/LKeBSxor/yOOsOwO7VlotjqE3Kuz7Tx1+qFBFGU8U4SNiL0C31fRV1t7GBnTZoUOysRjUrun1iM1VxXqDk4qWobBSJMCq/Nxx1xi4mLkbJGdHtd34Zdt70JTRFouxxjtt/fSHwZ+N3Xwg9HVHCliUJpEk2qZ3z82B/bjg5s+zI3uwkKjHvwdvZgPrekGePHuFnHYR6WPpf9UpVGLFhzv0AiUGgHQjdBtkirt0/ceDfUilfzMo+qvSjTGAfagRJYADQTPMOX6UVQDExwM0/0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e257579-315c-4f1a-56a2-08d753c9149c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2019 12:45:40.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJsNYE4//fjGrJm4b+3nNAgQC6b6YwCGc2ZsWPl/K5mf2bD1PqJSGgGBDPQhYnuSDW7betwAfCyOlWqvc6raUsK+iQTpMR8g0vLj7SeIQK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1793
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

During concurrent mode(AP/STA + P2P), pass the mgmt frames received from
firmware to appropriate interface. Iterate the complete interface list
to pass frames on the interface which has registered to receive mgmt
frame. Added extra time for 'remain_on_ch' timer to ensure that timeout
for uncanceled remain_on_channel is not triggered & 'p2p_listen_state'
is not cleared before passing the mgmt frames to p2p interface.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wilc_netdev.c            | 11 ++++-------
 drivers/staging/wilc1000/wilc_wfi_cfgoperations.c |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_netdev.c b/drivers/staging/wilc1=
000/wilc_netdev.c
index 93c0d6e78813..2bc7e5427fa8 100644
--- a/drivers/staging/wilc1000/wilc_netdev.c
+++ b/drivers/staging/wilc1000/wilc_netdev.c
@@ -817,16 +817,13 @@ void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u3=
2 size)
 	list_for_each_entry_rcu(vif, &wilc->vif_list, list) {
 		u16 type =3D le16_to_cpup((__le16 *)buff);
=20
-		if ((type =3D=3D vif->frame_reg[0].type && vif->frame_reg[0].reg) ||
-		    (type =3D=3D vif->frame_reg[1].type && vif->frame_reg[1].reg)) {
+		if (vif->priv.p2p_listen_state &&
+		    ((type =3D=3D vif->frame_reg[0].type && vif->frame_reg[0].reg) ||
+		     (type =3D=3D vif->frame_reg[1].type && vif->frame_reg[1].reg)))
 			wilc_wfi_p2p_rx(vif, buff, size);
-			break;
-		}
=20
-		if (vif->monitor_flag) {
+		if (vif->monitor_flag)
 			wilc_wfi_monitor_rx(wilc->monitor_dev, buff, size);
-			break;
-		}
 	}
 	srcu_read_unlock(&wilc->srcu, srcu_idx);
 }
diff --git a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c b/drivers/st=
aging/wilc1000/wilc_wfi_cfgoperations.c
index cc56abc2fe37..974cb3e9a6f5 100644
--- a/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
+++ b/drivers/staging/wilc1000/wilc_wfi_cfgoperations.c
@@ -1130,7 +1130,7 @@ static int remain_on_channel(struct wiphy *wiphy,
=20
 	cfg80211_ready_on_channel(wdev, *cookie, chan, duration, GFP_KERNEL);
 	mod_timer(&vif->hif_drv->remain_on_ch_timer,
-		  jiffies + msecs_to_jiffies(duration));
+		  jiffies + msecs_to_jiffies(duration + 1000));
=20
 	return ret;
 }
--=20
2.22.0

