Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522E440E3E0
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbhIPQwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:52:50 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18239 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345742AbhIPQuq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631810964; x=1663346964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kvDy8soBWOwpL5y1VU6qupu+1cJ9/aqvWesoaQLLsmo=;
  b=tIXA21gLQFVrOuFYJBDHoqbUjUt4z6ixzGXfvPl5hu2KlhtXLik8jENs
   4F4AdCZOEZCAI6oqPWRgyiGyZrULuUjkGbccxc+j0aSSttZlC1AIVMrkS
   pkcsYN9Y/6Vf7zpMlOxGbZ2zKDWX/cqHRYm18IgvAp4W/2Ev4w/xhI5AQ
   aTDXq97iTB1iPckKhhjSgJqVYXwUDC1REZCSgtdPuSMhNuXhI89ybOFTW
   ZgCP6yjE+jE2dlUOsIXC1/x8QBmJkwirmMkLUTaxhnWnsgJyE+byv4SGs
   LCA6UrkiR0aCis2wqJrEtAZm6b0vkWv8XgQR25Ey+CK3R1ph844QqFoI2
   g==;
IronPort-SDR: SdcXioquZgR1iHLhJ1+4F87WvfT/Few30ZEftYOcw7xjdVbzNCb+3aMgFdz4PExXwWXoNd3LTk
 fLegoaOmysqKaGwQ/iA7RvrI/+Mp1DvJWYkI8pBDhR+c1JRQfMJvjNCql6ryCRq2qsheY9uyzB
 niDf1uLc2+6ow/pzc7TPjx5hdo3opAp/35PmlgpSG0YHiJyTlKurVJZeExitIL95mpCKdClOal
 uTJ2HsBpdm5mGpzaaAGV8eSzX/qR3xF6oV7kVXdsCY2T5m1qnBnJlMKVXlsPe9cjD0kQT6h9lN
 8oKbtH2PU0qV/lktRy0D2qn/
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="132089773"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:19 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:49:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WYtPNVXOZ1JO+SBblM9TWoDs/6/ebzrwtpZT/8Rdywjj87GCoYTVVV8/zkrKO8g2sdt7SXj0Rcw9WryeyXQdb9n1fek4QLO88nIduUi/Wx7JjEU5XTaLsD7Kk266plS/ew50BuTM+J4itheNgb/Z9ZisLPPva+gENY5aBIMNzE1ySL7z0G9/Ybf9jhKREaUme9J9lCjdqsJHsT2/HCaP812lZWrBhdncvMAEv85+k1GucwLl0OE5nSuo30PToIxWPVaQ1exuYzruL3HpU3c++JoenT2N3r5Pj5VPHJwhiHxQBx0ar9rhF91s4N9GDcUwbrM98vNYh8qz+MLpM1HVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=htcOKT/+GRDTAXpAaud7iZvPBnhueTzvqmRsHJNa89g=;
 b=XkQR693gXdo+TkMRLF4OMQtEc+v9H0zh7i6pJA/5n6djWJHO5gq35GNBHpzOBjzbSygk/+C+LDGvDrGgjxl/5kUA3RMggUle5YYEcg0clIbMOME4juGhFvQ8j/fvFG0VFINCO7JS+oiIep3d900miyU7ivrzMt1bLpHujtWt4lFAGoL+Mku6SOt0ndehkFFUd+sNWPhA5du1vJM7udXSLBAyljr0Q3PxnknXdcjriCoR+4Iy+/ovhR9JT2fTFMG1BdfEMCqlXupQdeegNi9mMpff1kdyu5EBP4ooh95Sdwv2Mm8SOnV4T5oyywnkk4gyX+oTT/FbgV8RRY6+cHSHHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htcOKT/+GRDTAXpAaud7iZvPBnhueTzvqmRsHJNa89g=;
 b=mOmrrRWoyUxQ6QFwk1OFiFbvKwa0Ci5xGxa+LevyAyeXp9FLVgKvbj55+Q3RJIWH3rgX5FbjdNEG1NwPUO730ylMTGWjed2kgdptdUh08y2I7SNg+FJ6QZhu8MKZlG/VBVsHxptZUbY4aOUZxm1loGtpfczNfoh8N3Ji6h+cIdk=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:18 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:18 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 03/11] wilc1000: add new WID to pass wake_enable
 information to firmware
Thread-Topic: [PATCH v2 03/11] wilc1000: add new WID to pass wake_enable
 information to firmware
Thread-Index: AQHXqxrKTpgfpzTEBkuCTLL4X/klow==
Date:   Thu, 16 Sep 2021 16:49:18 +0000
Message-ID: <20210916164902.74629-4-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c481d662-bdd4-40db-a0ea-08d97931ed22
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5197C3DB4BAA90897E3E2C39E3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hPXKsseMRvYPbHlNpUuBIXZWSblE5vfpUwlMLpU7kZOPArQ7GvLVu0NfpEbOmNikgdN8OYkqiWUdX5d0U4mT7LtzemIopsq2hnu3ddu3TDQN37csptB9V6iuSRQA43Nde4V8FQrmFPcsRZnNam4qEJW0Xh5Ht2lYa4XbFjfxW8TIR2caVZdVp3Td5jAAoLYFV9Zc6TykKia6Bg+YzHtcb8ReL88Q0aJvEO4qPrFOAxkgeYE6SN2Fu6RgawdrSlOiUrmcfJMgIab93dPDYZ75JqlRk/qywGjo2rdoan5BxNXF2lqRo9/Iwz+9n1S9kT8xHJRzErPan+Gz2vrl8Hw0+OyWEuSXTIDO/rcCg0skSg7xtKmyg0ppO7emfPlYWJNWoFzUNUToujzVotbQt0pauDqkNbGzvVLoakpE/tJEIoAlTK/p7LGu8pvtnaokqkJ5sRmrEOIOM2zs1V2hzJuMLr0xrpV1delWbnU5w/q4kqwHRwwn2XXSlfT8s0H1HDDKRtWYkBtxDtTBD3+5Io6DoUjOW++9lmP0q/FVLUcHDE+bnsRy4Uenh6ahJLCftrlcZkZTLWYEx4Ekfq3SocYFpRhXllLuZxBWeJK3YDCiBdOBflwmWZqW+DJmVR6pQUvoW4J7kd7u23cRAxksmDmzAsMMN1quK6reOdokvhM2OC/PPTKPuu/0Z/63JU1mO1OnzYFr9eMDZCCVVq3Mf4lP5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IA5DIS8XXZzsXwx7BX7dx45z/Uumvh2bEf2P89+Xleo1w1VlpxoT3xIFvo?=
 =?iso-8859-1?Q?W+5xAUCkqMfYh1Gk4ibdGgr45UGpDajaHmx3ITqhAeKwQjig16MqW3c8tY?=
 =?iso-8859-1?Q?azWFphcVwBBjB48wxVRf16720+YANYmxr7uZUXdu3QGmEhXFmYe6fd08zc?=
 =?iso-8859-1?Q?RmsLkUQKsd43SFtSMqRc7k+DRDKhwbUfhINQEue0VYMXbRSRzmGE6U3+ph?=
 =?iso-8859-1?Q?YBZl9WCtSGfyjB2bQMhipy/nX2JnqeObmisiMlcFb19/fzTQ4mqcDWsCMX?=
 =?iso-8859-1?Q?8nQO98NzUDqWRs2cblm+9vBC+UNVJ+DyIk9u0lzJ8ByTAARnDk/n0V3zdw?=
 =?iso-8859-1?Q?7Lx9wdh4HhnzcRMO8wCqH2f5nYyVjDdZeTQq1vNmex2gFZw+DZoRw/RFD8?=
 =?iso-8859-1?Q?z8GRQ0nkYVpcvVi1D8OsSnmSHY602VoHheun//IHBDzM6Zg8xPMu+2gx4Y?=
 =?iso-8859-1?Q?Wr6HVABcwO989rP3NW+MdwDjSj6LJ/fnqyttHK20G/HCSATwl1OTtF9bg0?=
 =?iso-8859-1?Q?MyYQOHnI6fjR2b570RafIA650FpAzRRFXJrCFqGHv+i/0kOTDn+xO4JEoC?=
 =?iso-8859-1?Q?uH/uUAzNKWxgRAZjrZZJapvoBfxdEPy7bEM/Rh6fusWBMfcEQk2VtoTjJd?=
 =?iso-8859-1?Q?HNldFN01rFAdArrcBJ9NGEUg4xzTSRUfnmz3phsPDiuNJMkzs0F2flSIjX?=
 =?iso-8859-1?Q?LbtqYZV3V7+pIU8S4w5fa8k3jN6RLzZ0TPp+URwTlcuaLBbsCgNS6KZkoG?=
 =?iso-8859-1?Q?zxoyPl8HHeXj0E2OUDRrAIJlGB/bPKPhyim3R98Uwdw8brei4bZleZlpbT?=
 =?iso-8859-1?Q?PM0c5iJEAJ8V6yphFTyrWpAZJcwXLttNLczS0EMKhgrECe8yqqOu3KA2gH?=
 =?iso-8859-1?Q?8Gl9tsXP8VbovBYpMr2LcwFv6K+bCTklMC2e3PV09mQlZSxJkjEd7iTSLE?=
 =?iso-8859-1?Q?DKzg6Z+BP9zR5CZ8PvhDrcJoO/tXfINoRpcn/o7YAG+hpcZmZ3Y5R1R6TP?=
 =?iso-8859-1?Q?AoP1XvbLhheLhezL+R4juJuL5wS7a7oevV2Ui2FwvXFIoo2tEpP2dRHtAr?=
 =?iso-8859-1?Q?E82Ma0O9Sr79KoPxHDCKyFcR93K1AZxQZz/rsHg85uYRqDtUGRvQzJ6Tii?=
 =?iso-8859-1?Q?4+kYWX+brYev4UFCZgP1hNziJMQbhllCCCCi9QCBHZybMMfXuKlftlM3cm?=
 =?iso-8859-1?Q?L67dSYkIWmm39QVDU+hjZIdnY+IpKl9LBERLTEPh3iSC6oe7sCcq13xG4F?=
 =?iso-8859-1?Q?vM0LR8GSSLz8/fmksPYFb42JoDUsZWM9QmuLM8CozXfiXQcn6RQriJostJ?=
 =?iso-8859-1?Q?MOKwz0zEyI4fRr3rGFp0leJ81Wmi7rgO9q6422VwTqsXrQ40qX+mvA4qms?=
 =?iso-8859-1?Q?whjQkFXxRa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c481d662-bdd4-40db-a0ea-08d97931ed22
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:18.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x5WrKyadBAlEhL4e/9x8Yv9lUd32drCpxS/rIQQKpPxs2oQ5C3lGG6aQqkni+RRNj5ONeG2R5Y8gP+0rdgfnIdWPhTaba4wpw/ukX8+iEJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add new WID(WID_WOWLAN_TRIGGER) to send wake_enable information to firmware=
.
In 'set_wakeup' cfg80211_ops callback, the enable information was not
passed to firmware which is required to handle WOWLan trigger notification
from firmware.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  1 +
 drivers/net/wireless/microchip/wilc1000/hif.c | 24 +++++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/hif.h |  1 +
 .../wireless/microchip/wilc1000/wlan_cfg.c    |  1 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  1 +
 5 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 36b87ed38092..75160ab3914a 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1580,6 +1580,7 @@ static void wilc_set_wakeup(struct wiphy *wiphy, bool=
 enabled)
 	}
=20
 	netdev_info(vif->ndev, "cfg set wake up =3D %d\n", enabled);
+	wilc_set_wowlan_trigger(vif, enabled);
 	srcu_read_unlock(&wl->srcu, srcu_idx);
 }
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wi=
reless/microchip/wilc1000/hif.c
index 497a49a182ef..e69b9c7f3d31 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -23,6 +23,10 @@ struct wilc_set_multicast {
 	u8 *mc_list;
 };
=20
+struct host_if_wowlan_trigger {
+	u8 wowlan_trigger;
+};
+
 struct wilc_del_all_sta {
 	u8 assoc_sta;
 	u8 mac[WILC_MAX_NUM_STA][ETH_ALEN];
@@ -34,6 +38,7 @@ union wilc_message_body {
 	struct wilc_set_multicast mc_info;
 	struct wilc_remain_ch remain_on_ch;
 	char *data;
+	struct host_if_wowlan_trigger wow_trigger;
 };
=20
 struct host_if_msg {
@@ -962,6 +967,25 @@ static void handle_set_mcast_filter(struct work_struct=
 *work)
 	kfree(msg);
 }
=20
+void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled)
+{
+	int ret;
+	struct wid wid;
+	u8 wowlan_trigger =3D 0;
+
+	if (enabled)
+		wowlan_trigger =3D 1;
+
+	wid.id =3D WID_WOWLAN_TRIGGER;
+	wid.type =3D WID_CHAR;
+	wid.val =3D &wowlan_trigger;
+	wid.size =3D sizeof(char);
+
+	ret =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (ret)
+		pr_err("Failed to send wowlan trigger config packet\n");
+}
+
 static void handle_scan_timer(struct work_struct *work)
 {
 	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
index 58811911213b..cccd54ed0518 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.h
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -207,6 +207,7 @@ int wilc_get_statistics(struct wilc_vif *vif, struct rf=
_info *stats);
 int wilc_get_vif_idx(struct wilc_vif *vif);
 int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
 int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
+void wilc_set_wowlan_trigger(struct wilc_vif *vif, bool enabled);
 void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
);
 void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)=
;
 void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c b/drivers/n=
et/wireless/microchip/wilc1000/wlan_cfg.c
index fe2a7ed8e5cd..dba301378b7f 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_cfg.c
@@ -22,6 +22,7 @@ static const struct wilc_cfg_byte g_cfg_byte[] =3D {
 	{WID_STATUS, 0},
 	{WID_RSSI, 0},
 	{WID_LINKSPEED, 0},
+	{WID_WOWLAN_TRIGGER, 0},
 	{WID_NIL, 0}
 };
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index f85fd575136d..31c68643731d 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -662,6 +662,7 @@ enum {
=20
 	WID_LOG_TERMINAL_SWITCH		=3D 0x00CD,
 	WID_TX_POWER			=3D 0x00CE,
+	WID_WOWLAN_TRIGGER		=3D 0X00CF,
 	/*  EMAC Short WID list */
 	/*  RTS Threshold */
 	/*
--=20
2.25.1
