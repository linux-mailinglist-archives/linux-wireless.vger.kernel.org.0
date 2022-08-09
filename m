Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671358D508
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiHIH6C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 03:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHIH6B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 03:58:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E8219C0E
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 00:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660031880; x=1691567880;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UTGOzFJFJqzhhXrLadMlhcWCh9iQJfokIOXNiLUVx94=;
  b=Ef6i/MrZgRNRr0zCUQlrdBTla0G41j//HsM62imdzDY+G/gfpeKPoPhF
   AWLrZ3WkvTHTarfAMapOTecRoEYnwB0RTtWRugOF5OJXuEjPuno/LVWJK
   bQ7g4Z60L/6cfjtgf7YFKxtjZ9FkXoVcVaeCXLI4+pK7iRCLDKn0g27zs
   LQA8kAgLckPPeJUY/PllsMib5w3/SehjMVN4J+RU5jxO3sodAd2XudAma
   ngO3kpwu1Mf6lSELVSz4og+9w7HUhfsAxeHno8P2mgXAcCWvOYvoXti6b
   PnGNw8e6Gxl9pqUopgBZtKThEgNDEbnzt2rbTqt608mT+DaUF1MNg7F6j
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="171576732"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2022 00:57:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 9 Aug 2022 00:57:59 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 9 Aug 2022 00:57:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdAfLtGGiS0KBpSEAh5OK+2kKy3SFNjGxMKFRExjS8PaQveHyg9WUDcYQZf1C/pyd1SB4WLdhJYGX746dppFcsu4ruYm7cKq1nlUGMN2LSRA25RcKci4km4qS3wqm13iU2ak3z3xbbsTeg0lPKL/nHzW5rhaogAGhcHlf+Fo70c6yF2ilJ4+dzPtO2nXVUGdxXT+ez8RYtwwPZ1p6u1yNiXzM5vQdnLAwjuB0I6VyqMHJDVHedVlejgyaJ4AhKp0T6sKeT9W/mDYg3rtqRYFETEBsWoep5BqH9zShTunE5b4b7X7pcYSzRlSzSu+rw9rrtdpnHmwum3ScdxzwVoz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOFxXJLCP6YxuBvMGuIjNBll0tCVoBe0qMONxpmAAD4=;
 b=ezcs0MATIYqwsgmeglac2RKZUyQ6NWuwn0NRSL4Nod+v4WFVjDCHbY1QVTBjVp0ZkSR8z2UQkbVxrx0MzrZjSYn84MkJ0HfM+2Xoamo7gm5fBSLrK2eZKGxL9ZjvVJxuNot8CE8DCchR0qo9hX28fjoddmYzY9OPSCcrDhYtHHfJmT0EMtEHWQYoL1aYa6qJllvV9ld0J0bkjnIVvFJIitF6W7PddGve7ISKr1MkPMgiosAorUL0YVIObH4atEG/JovKUn31KWS5NyYQMj/pwKXud2BDOygEH3PIh9NtFe8svrGj0Cx6L6XOibkAajFP8Pfx7GukQNcwsqy3YH5aKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOFxXJLCP6YxuBvMGuIjNBll0tCVoBe0qMONxpmAAD4=;
 b=JYOH1YeUk/Ag27ZpDP2n3qU7Z00VJbKw1WNTYYWiZetBrYqHrcOgWwQzN3KjUt+pmrxer3mIR6IVpzJfEAKcfzJ1iJW9UwnKmjnvQXNSyv/L04y3IvtV8ea8n6fHBG6fypDVqhqHxhr+7klhmHMGF639yta0CnGt71ki9ifKSPI=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by DM5PR11MB1962.namprd11.prod.outlook.com (2603:10b6:3:10c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 07:57:56 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%9]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 07:57:56 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <mwalle@kernel.org>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
Thread-Topic: [PATCH v3] wifi: wilc1000: fix DMA on stack objects
Thread-Index: AQHYq8W8cW+h3WjiHUSE8a5GTLgEwQ==
Date:   Tue, 9 Aug 2022 07:57:56 +0000
Message-ID: <20220809075749.62752-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa089757-c27d-4de5-ac1a-08da79dcdeed
x-ms-traffictypediagnostic: DM5PR11MB1962:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lzzsEMJqT+D+pw53cEuOWTtOZT3rMsmn8WN00b3OSNsuMXsey09u5CYb1rOXs7gGi6Zos5LO9j5w5Vh+49nc8TnU+4s9NI2MBbJnQhtnTUN/PjzXisaY5QkAuOrn5gpFGQa3jOKJApYOxFuIPc8OOAmvkjtoExawpS2E6TMv5HfL52YBCNzwzz8shcVpkqnQswJtgM6CgUuLvQqb7+utXGgLoaA3mHT/e7qer3p8seopI04WDhDuEx79G8dDC4INlqFl5HkS+UJSzlpr/v7iEJj8J3iIJN5cfYaAbROR4j1pt0ZVZZSzzMZ3+91DYccZ5dXl5xc8AaVrVdMKbjjBAcCQY51uhIzojdN0krNe95pvTXzj/C+Ateddbk3YEFslODEekqSan9iezvNUlbcX2/WxmovOPBWJk/AvBZBPoymzyk4huLgiyfn+czkgm8izEfOOXkRNnKwccUU/6rscmgHAEAuTojVikxT2FgQ7b641+OEC9PtA+qVVMWvOVXoE+r+E7YpkZ2m96L0Vep3RMeJY5i8DqNXjiXwb2Uscdckx9CPvU5ybAQCEplCuqabiUeCqi9dJXd4I/VlGem/PEdOA8wSj+d9Ih3LVwBaqliuabRovtiQIjocLPUcZYXI8yDu9IQ2OTF3ZXeuKBdvJ3uDNrGE+RmvmNwJpEQSlmRVYRDu7S2iKk6E8yj2R+PyZHXqcfsRbvI+C2oG5a+pSUhPr21OMxCXb/jGZa6kKfYyaYJCDPXCCqEEATBZeH8eFjrcMXzFUgToDHxX2v/0CtkeHdsjMdEBRS4mgpPNBFZocBGsrpve04jkp9ErdUwQle7vtF8DRPJ2/FH3kYxdUeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(366004)(346002)(396003)(376002)(5660300002)(36756003)(2906002)(76116006)(66946007)(478600001)(966005)(6916009)(71200400001)(6486002)(316002)(54906003)(8936002)(38100700002)(2616005)(38070700005)(55236004)(6506007)(86362001)(122000001)(26005)(6512007)(41300700001)(8676002)(64756008)(66446008)(4326008)(66476007)(66556008)(107886003)(91956017)(1076003)(186003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?zxqKftH2LWtETyfAxRXh7mgBZhasjfnjiCCRljC6b+PXTP1m9RTFsGJ/t+?=
 =?iso-8859-1?Q?5w1QozTvWpN8fsSZSdW1q61bF8e0PM6FqvbLcMyi5zuwpC5DvsnX4UQYvI?=
 =?iso-8859-1?Q?5Lm2dUev9FaDiKlY8rLodCmoGLbhJi2bn8wRoXNd6tUz9NtefEzc48qNzp?=
 =?iso-8859-1?Q?b/TlngBUn8U/dL9ZUhUm6omXgE9iGxd0PNw97IjvgRsH7AuVjkIEwiQM49?=
 =?iso-8859-1?Q?BRlMAy5lfGlqlIZSoA07dEzZJCFQOB3NUqWfjQ16E+p1CgljyUHuz76bX6?=
 =?iso-8859-1?Q?5VIKk1f9/I4y8e8cqd20Nj93rw2Jti+VZJ4EKrGPiJ1f3eKoLxY68XUr7A?=
 =?iso-8859-1?Q?1NHEigkjjmKMfWvr3UjeFzhJdULxx3nxr2FH2i3yyw2Y65gK7x4rjy3OKT?=
 =?iso-8859-1?Q?LLgFASjGlitt2EYdvioH7cw05TSC1pnTFJmNpzgCEBxfRrihc/KvlN2PeL?=
 =?iso-8859-1?Q?VnM2Ieyu+2QItyhnKg9b5nwyO0fz50r0sKx4m6VRHmWw8CejgOV6o9EobN?=
 =?iso-8859-1?Q?YrpSK2XJx52HknZCAoGtI2TMLJAoxPDpJCpSBZFJFb2ss5YQQuvPnXxtya?=
 =?iso-8859-1?Q?e+9Ifr8rvBvDQo4TpQ94b8lgU8ZBmkNk1ovHyiDQjyBpDH500HZfyLWdWP?=
 =?iso-8859-1?Q?U7UXB8tdgEfZ3dzkCkdZH5aXW4hKT1N17XkMjj7oKbZIeuN80cLcDXRnTr?=
 =?iso-8859-1?Q?pECBg7hVx5Mp9MXLVJ5N5P5kcaWSDpE6yx/KFRbm1eO5PY0/c0NtEiUcPV?=
 =?iso-8859-1?Q?C6egJCJgwYFeI96rgyIdf6ZTpc8lEXR5WOKLQ+Rheq8nntM8DUhmkxyToz?=
 =?iso-8859-1?Q?oxE8cPr7C9W4UIQIx/QYk+EL/JaeX7+pgQ3F6i6cYQKT5wzH9e3O1XYA0Z?=
 =?iso-8859-1?Q?2Mu1SkHAbBDtfMRrjpbhoysL023IJFWohCPD4ka2BErKiI2YoWZ6YKJcE1?=
 =?iso-8859-1?Q?xvrOy7HYlMhxZ+yhPZjx+Gj3F+jxUpYPhO1ZWnO16IAvP1bOAgPwQraQZG?=
 =?iso-8859-1?Q?7oIkJ3qM+C5GbLL/FxIaP8YNS+ydqGr9c1jE9cteiwQdbdWxXHgYAWCE4Q?=
 =?iso-8859-1?Q?Typ2d95Lw3Sra6efXaMOIFJZ67fLfa8N6SJrFQvabAe4iqRNAPB0RECKdX?=
 =?iso-8859-1?Q?9jwHkYigT/7ZNqRu54zGgPo/6xYKtWwfCBf1E64ZDgOOG2XD2Ox9pgQoaN?=
 =?iso-8859-1?Q?Dmfw1ZGb9WbpaVsmPLtdtQXfKRmgxoiKV3i3lySX0L0oF2eqfTPhokb1kP?=
 =?iso-8859-1?Q?D45B8emjxIdoUxbx99b0YDBcU+sROnoEWRjo2rpUwb7DvIp3FDT3ZlAKh8?=
 =?iso-8859-1?Q?TEecsnduUfi+zuTwjkRYMjddbyVwNMrDoJZlC8vHk7fjQEULJehUE1j3yn?=
 =?iso-8859-1?Q?uYoHGoVujDGCwlQ9XpYy6mLAjaR8TdbBxKykkwLzVYv634Is36t1uyasjj?=
 =?iso-8859-1?Q?1qfJ8ynYWF6h5XQfcTojSXGtZaEywJpn/cfUg45zp5DLz38y8oMXwmh4V2?=
 =?iso-8859-1?Q?qcqZRYw9LO8EetD6b7r/+iR33HCPXbbkmyRQJG8KBvY+XWLg6H24YXfvjV?=
 =?iso-8859-1?Q?Ie52GxcIB3tXumPYSS0uif/BVRdjumcVdgd8LZjLwBYnhvPe6IJcYGjl+9?=
 =?iso-8859-1?Q?SwZtcbTcK9Za7Qv0p0vwnRqoOXWvHBAoV+MxRt4frTnKjYNXjuIsA24g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa089757-c27d-4de5-ac1a-08da79dcdeed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 07:57:56.6074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8Nr/tEohhmLfJUCDLUNSJr95gZwUYtBWDKHRl3q55waxYaFy8dukhZJKmzsXWu7mWG5NYlam/s0d7KOHh7pIdRkWYTLn0X//LB3Wge4zEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1962
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sometimes 'wilc_sdio_cmd53' is called with addresses pointing to an
object on the stack. Use dynamically allocated memory for cmd53 instead
of stack address which is not DMA'able.

Fixes: 5625f965d764 ("wilc1000: move wilc driver out of staging")
Reported-by: Michael Walle <mwalle@kernel.org>
Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
This patch is created based on [1] and changes are done as discussed in
the same thread.

[1]. https://patchwork.kernel.org/project/linux-wireless/patch/202207281520=
37.386543-1-michael@walle.cc/=20

changes since v2:
	- use 'bool' datatype instead of 'u8' for 'use_global_buf'
	- add size fit check before copying to 'cmd53_buf' buffer in
	  wilc_sdio_cmd53()=20

changes since v1:
	- add 'use_global_buf' variable to know when to use bounce buffer
	- remove unnecessary goto label
	- dynamically allocate 'vmm_table'

 .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
 .../net/wireless/microchip/wilc1000/sdio.c    | 39 ++++++++++++++++---
 .../net/wireless/microchip/wilc1000/wlan.c    | 15 ++++++-
 3 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 43c085c74b7a..bb1a315a7b7e 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -245,6 +245,7 @@ struct wilc {
 	u8 *rx_buffer;
 	u32 rx_buffer_offset;
 	u8 *tx_buffer;
+	u32 *vmm_table;
=20
 	struct txq_handle txq[NQUEUES];
 	int txq_entries;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index 600cc57e9da2..7390f94cd4ca 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -28,6 +28,7 @@ struct wilc_sdio {
 	u32 block_size;
 	bool isinit;
 	int has_thrpt_enh3;
+	u8 *cmd53_buf;
 };
=20
 struct sdio_cmd52 {
@@ -47,6 +48,7 @@ struct sdio_cmd53 {
 	u32 count:		9;
 	u8 *buffer;
 	u32 block_size;
+	bool use_global_buf;
 };
=20
 static const struct wilc_hif_func wilc_hif_sdio;
@@ -91,6 +93,8 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio=
_cmd53 *cmd)
 {
 	struct sdio_func *func =3D container_of(wilc->dev, struct sdio_func, dev)=
;
 	int size, ret;
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	u8 *buf =3D cmd->buffer;
=20
 	sdio_claim_host(func);
=20
@@ -101,12 +105,23 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct =
sdio_cmd53 *cmd)
 	else
 		size =3D cmd->count;
=20
+	if (cmd->use_global_buf) {
+		if (size > sizeof(u32))
+			return -EINVAL;
+
+		buf =3D sdio_priv->cmd53_buf;
+	}
+
 	if (cmd->read_write) {  /* write */
-		ret =3D sdio_memcpy_toio(func, cmd->address,
-				       (void *)cmd->buffer, size);
+		if (cmd->use_global_buf)
+			memcpy(buf, cmd->buffer, size);
+
+		ret =3D sdio_memcpy_toio(func, cmd->address, buf, size);
 	} else {        /* read */
-		ret =3D sdio_memcpy_fromio(func, (void *)cmd->buffer,
-					 cmd->address,  size);
+		ret =3D sdio_memcpy_fromio(func, buf, cmd->address, size);
+
+		if (cmd->use_global_buf)
+			memcpy(cmd->buffer, buf, size);
 	}
=20
 	sdio_release_host(func);
@@ -128,6 +143,12 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	if (!sdio_priv)
 		return -ENOMEM;
=20
+	sdio_priv->cmd53_buf =3D kzalloc(sizeof(u32), GFP_KERNEL);
+	if (!sdio_priv->cmd53_buf) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
 	ret =3D wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
 				 &wilc_hif_sdio);
 	if (ret)
@@ -161,6 +182,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
 free:
+	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 	return ret;
 }
@@ -172,6 +194,7 @@ static void wilc_sdio_remove(struct sdio_func *func)
=20
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
+	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 }
=20
@@ -375,8 +398,9 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 a=
ddr, u32 data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
+		cmd.count =3D sizeof(u32);
 		cmd.buffer =3D (u8 *)&data;
+		cmd.use_global_buf =3D true;
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret)
@@ -414,6 +438,7 @@ static int wilc_sdio_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
+	cmd.use_global_buf =3D false;
 	if (nblk > 0) {
 		cmd.block_mode =3D 1;
 		cmd.increment =3D 1;
@@ -492,8 +517,9 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
+		cmd.count =3D sizeof(u32);
 		cmd.buffer =3D (u8 *)data;
+		cmd.use_global_buf =3D true;
=20
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
@@ -535,6 +561,7 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
+	cmd.use_global_buf =3D false;
 	if (nblk > 0) {
 		cmd.block_mode =3D 1;
 		cmd.increment =3D 1;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 947d9a0a494e..58bbf50081e4 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -714,7 +714,7 @@ int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_co=
unt)
 	int ret =3D 0;
 	int counter;
 	int timeout;
-	u32 vmm_table[WILC_VMM_TBL_SIZE];
+	u32 *vmm_table =3D wilc->vmm_table;
 	u8 ac_pkt_num_to_chip[NQUEUES] =3D {0, 0, 0, 0};
 	const struct wilc_hif_func *func;
 	int srcu_idx;
@@ -1252,6 +1252,8 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	while ((rqe =3D wilc_wlan_rxq_remove(wilc)))
 		kfree(rqe);
=20
+	kfree(wilc->vmm_table);
+	wilc->vmm_table =3D NULL;
 	kfree(wilc->rx_buffer);
 	wilc->rx_buffer =3D NULL;
 	kfree(wilc->tx_buffer);
@@ -1489,6 +1491,14 @@ int wilc_wlan_init(struct net_device *dev)
 			goto fail;
 	}
=20
+	if (!wilc->vmm_table)
+		wilc->vmm_table =3D kzalloc(WILC_VMM_TBL_SIZE, GFP_KERNEL);
+
+	if (!wilc->vmm_table) {
+		ret =3D -ENOBUFS;
+		goto fail;
+	}
+
 	if (!wilc->tx_buffer)
 		wilc->tx_buffer =3D kmalloc(WILC_TX_BUFF_SIZE, GFP_KERNEL);
=20
@@ -1513,7 +1523,8 @@ int wilc_wlan_init(struct net_device *dev)
 	return 0;
=20
 fail:
-
+	kfree(wilc->vmm_table);
+	wilc->vmm_table =3D NULL;
 	kfree(wilc->rx_buffer);
 	wilc->rx_buffer =3D NULL;
 	kfree(wilc->tx_buffer);
--=20
2.34.1
