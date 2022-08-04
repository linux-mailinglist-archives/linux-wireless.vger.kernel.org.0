Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E3958A051
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239889AbiHDSNr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHDSNp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 14:13:45 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB751A0E
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 11:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659636824; x=1691172824;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=r6XJ0SeY6rxCDySXDY40Q1mXMhU3k9jnDRpXHUTtN+E=;
  b=xAQ+1Zm6tF2RMryAKXAF6n2fgPSutS88EBfDKSDKJV9vCyBOINtDP9aY
   keE0FNyCK8fnZq7fvmRiiplzAPOWW0m8NvB1LoK3/r5572Seqj2+vcx+y
   UcVjEnWrTvSblqCa/NqKuKcWKrtHuQzpIU+jBMqMCHLW87CcA0M/RF209
   OTu/R8zRlO8SEbzAD9/IKzkSXyrwLpmhTgHqA72e+d++sDe1v8vsveNt6
   CsnzrB2NQqY8Ss5JdMh+206w7rgOE9wCMfLnC7ovBoiXqSIYW0o9deQ8Z
   /zVnGzrNszKI9lEB0XGvdBcb2tgjjmmgiuh+hvjHJknKhh8iIqAkx634U
   A==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="185153282"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 11:13:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 11:13:43 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 4 Aug 2022 11:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFYRhLrFfNXST2ujcEUpn+0H6t+UtxEdESy0jXK4s8D/Ak8ghTDFUH2ZUFB/qICDLnE4q70TO5URcya4WzVEXIOA0X6ZIg7IrgPxlZnvPm74YEe6BoPuMZhbCfxEuYmuw7LH4l6VpzWpQiy2lVwKBj9wQoa2Wb4IkhDS7ONFNHW+fQEgxbCGRDu7fxlCn/jd38pzoiuxtj3pdQmB+1IyzoaYyYWrkWRBhsqop5MPjK9CEzMdqHD0GaJO+FPnICSD9JzmnYDjrKQmhDkCeAvtIW8qzhHr/iuLhy/LSNo0vhYv5F6AbACdd3PrTgLB/BF7peohKrDqyBLdEQT/ue5lzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8vKX4bKf4Xn79o0+G+M/R6eq68flbGtKlrQm1FVjN8=;
 b=Gcz3eXuFNJBbFb8maEoeBqhG4QuVnfklqdO+EI8O44B1/iDGu8ppgClu1pxKrYumxX3tapkriGnP1uPdcNCJktjO6umyqhSOZWSWowdIufy7Bk+3KtchaDmIALY/8DApZBZRv1ITWrSuLQKBMf+ja+OSDkKQj0vyDlzxh8nzAc1jmNvu9SY+W6WQIldSt/WbT6fg9Xc3MiFz4dSVUHAV/WeaHt3mqgwC3Ml2jaEEIovEkZ2jfFOUvnB8fHtCTGIFtrEs8wlCBR7grTKsIQ2Xf/O7zFFD9QPSVxic4QWm5S+vAdiEv1LYikPCOP/TA0f+qlfWCiB5ja/7Lx0g0/2dVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8vKX4bKf4Xn79o0+G+M/R6eq68flbGtKlrQm1FVjN8=;
 b=W9bBZnXfj454SxzSyG1DyjbKFHQasLqS0D35ksmos0b6ShSZsNVVVVE4C+iJWWvEr/dRTK1SaYfEJZVk/mLdoztoVJTXrp8oH1RVuv4XpW9oWj5Q3ycH9x/HEptsIMVLlrC7k31HL1gJc8HpMEg5+LQAvVQXCIslSJRe3oVRwBo=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by SA2PR11MB5211.namprd11.prod.outlook.com (2603:10b6:806:fb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 18:13:42 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 18:13:42 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <mwalle@kernel.org>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: fix DMA on stack objects
Thread-Topic: [PATCH v2] wifi: wilc1000: fix DMA on stack objects
Thread-Index: AQHYqC3tsnzfAAD+gEWLNR85ROYhfw==
Date:   Thu, 4 Aug 2022 18:13:42 +0000
Message-ID: <20220804181340.365429-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d843c9d-dfff-4e4f-7992-08da7645100f
x-ms-traffictypediagnostic: SA2PR11MB5211:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e69t3laD3zdJ/96CQh/6DHwyyLYxQF8X1UfabvyOYcaqL6iaN9JPhhQP+FYGjKaprROta7wkSquIb6OhwtfphyjRnAyReNbav34LYJhHXmol/z9srP1FiGyVVQ6bULnq5OAtla9qei7pZhj8JaukIVEI0bHwM+0agIrdr6O/WBFhZWsAC17a85gB9CeSbKNWy7tJ+q7yTLQceOIyansfJXXqgWWXW9+JqfiRC9imD2Ecno0JkFwinxm5plwI9pp66SEXDbDxFmrhtcUQon6+EbECuwRufwIo4zVCbAYImhZp3Ag3KwcuGszeOlIfopUiXC2f3kAKfsuDqT/JlhQdfB52PLT6cgv2mr/LUrSmknsb/JjAnb+LbB3vFrc6gpTUxDwUYHR/oBQLxJ2fj1umDLN+TVyuA3ASemqFPzyqNrCaCllKUub189GnImSvhp3NFdXll8xnkC+uQYQilI9v1fhqFm17MIw+lm3TqmWn+H7PteC/2PNPqzIE2aJfJ/sUoy8t7q4ty/Cl/Ks3vYvdOCVmr7h4lpePntnNL/eqMkeueYK8y6JIeZReHt0Xmq4dIepA4B2ks2IFZUoYG2dHvMyBuSeLbTQfzqQ0P+sTLOVZcjxyAMm/vwVjOOGqh5jzRZijWKmkOXt28Tl3uNGtmvTtpV01QBS1egj8W4QetvxB+2LDjm+1+BBMA0KaYNhom5lhBtV/II3wVAjQiXTz4PvYHzoRGQzDRLmAIg70pHlVGRFASkGhL1GwZRMsRxX5txyM3XwJ/VorQw7AdXeyQO91VgR1gll7C47RooSCqaCKtvzWKJ7vYtrariD8+tUdu3bufgDpGmwHt5x+GmuNTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(346002)(376002)(396003)(6916009)(36756003)(41300700001)(4326008)(66446008)(91956017)(8676002)(54906003)(66476007)(66556008)(66946007)(76116006)(64756008)(71200400001)(966005)(478600001)(86362001)(6486002)(26005)(55236004)(6506007)(8936002)(6512007)(5660300002)(1076003)(107886003)(2616005)(83380400001)(186003)(38100700002)(2906002)(316002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?W/M/ikl+A+vPrIrQAIkttEK2ENYxUy4beTIFVJyTWkI12QJhj1wqIRBcPN?=
 =?iso-8859-1?Q?Quo79e6ArjsWuUg4ufNQp7vlrWXq+bm5COr+pIWuctAJntLfnU7N6Cc+rw?=
 =?iso-8859-1?Q?uGtoLvrdShRNPexE+HTsbg6lqLPAXUPmmctYMpoDyC1g1fKjQ6X9NBphjQ?=
 =?iso-8859-1?Q?UpFn5eVuGiygEFyGjxJBfhNcRM0POytagjD30Njmgu0Y+FU9W273TvqJr6?=
 =?iso-8859-1?Q?D560P3lx389VscpH5Wk+CAYzIP3gecgs1vIHUoHV2h/yd2EyA1raMKbMe7?=
 =?iso-8859-1?Q?yBEIjITyRGCK9VZD26aTxcUH9oJidldeq24M69sP8sWZUyb4QtjvELMw6e?=
 =?iso-8859-1?Q?/I0Gp54FK+RwxRKSeAMNc26eXu4nr/OjD99EqE/a+CwtAvHHVIp0ufVfYE?=
 =?iso-8859-1?Q?kYZksMEpb3XfX0LMr5fj0jvQo5ZH4QlsnqAbEPvgO/zUiBg2hTHWEBGQm8?=
 =?iso-8859-1?Q?toLm/ayTfDGezgTCKtHPvf8VSKedghngF/9tI31++BFbzpks7aKTgIuPYN?=
 =?iso-8859-1?Q?MEUzff2mtEATbSeq5TWll1h/D09nNGG1PYTcKSB5LRXYMks7sNR9dg8s41?=
 =?iso-8859-1?Q?xxwqftSdCs+koIEURUjM6/lHXmfQ9afcQq7ZGmsJrD55xm/bDwc74nkzxG?=
 =?iso-8859-1?Q?+s7BN6qTNKpXOmwjVl/vnQEFjHebB+Q/yUNIbo0L9YgP5fDJapYbI4rnBH?=
 =?iso-8859-1?Q?AwG7ompim1c1+XfP4ssNo/BOJ3vX/xwX5rJ+3caA8eQgN/E2i9LmJOrs2t?=
 =?iso-8859-1?Q?kM3GxBQHm9XpMr3aJDEfk4++52MO2zwG54+5/+lFUhhaHat20GznJuwefZ?=
 =?iso-8859-1?Q?R37V8zLX2f6zGXWX3fFNBnd9yVewEN9YvKOJ0SBVb1nudb9KA6cNYIutmU?=
 =?iso-8859-1?Q?j5hzDH/BQuYXnfctgaOXd/qTc34b37APWTzb51ntTfdDN9ROLyPVOLH+Ha?=
 =?iso-8859-1?Q?PO8aLydxx3eyRhLDhyjSdS8dA8llrhyptTY9sNI2fyWxdpfXL96/rF5dT3?=
 =?iso-8859-1?Q?g6Y1M99tQpRWLrCMvZVXgSLzRrQ9dVBfVEIYTZ85Dk5kiWwzDqZrWL1XWy?=
 =?iso-8859-1?Q?4oV3MGH0W9hXBnzrxgpNBTM2wtdUpxVAkwcvbRyfiR6Vegce7XRXUZbyo+?=
 =?iso-8859-1?Q?yDgXUyuLK1eKpJP/F0jtH82PcGpWnVZdziuigL6XTWv/5+7+cxwXD6a+Po?=
 =?iso-8859-1?Q?E8atT2bzUtV+jKgDlna8cP+/kjKQNex9W3rv77qS2PeHQ7e0TjSidhxJu5?=
 =?iso-8859-1?Q?xeF8rrrEIo3R7WhL15xR/tSR2iMIyMW++3QU3iySmO1rAs7fxxCillZhph?=
 =?iso-8859-1?Q?01u45eMlBCojJTkAiaU+UuG5Zo/YfF0IPiXraAf26duTiOHi8t0vH/pzdU?=
 =?iso-8859-1?Q?1Iv4VQ1ZRRIceUTxUInW+9PoBLq2l2EZKNnkw3ta2VTIP/NYAx6vLZeaIt?=
 =?iso-8859-1?Q?MhDD3Mppb/k0IeAdreNhQFbporZV6hOTQU733v142lgfbvpojtJEm2N0YV?=
 =?iso-8859-1?Q?mI9udDShS+7jF6fkNeJMBmJ6dyJuSixUZ3ggN6YyPN/iGIypLHCwPMjnva?=
 =?iso-8859-1?Q?I2h1NpuQht/hH1zoGUSBXp9joyjOUit8vxVqtg439YRR8cWkVOPDLnnIjV?=
 =?iso-8859-1?Q?O3Tiu+K6priIQrMN7nbfLQW0XIzJQkZ1Au5kO7n1s2ZcOIA6UV4z5FKA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d843c9d-dfff-4e4f-7992-08da7645100f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 18:13:42.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jXwf6yoSANhcWE7wUUslmIo1jwEdieQNfJuTHSfCptaByAfH6mk2BZ/C0aEqEwLAvoRNmbyCwPrQ3ghcIkYtEct97gCllJA9lDW6IzHAHRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5211
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

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

changes since v1:
        - add 'use_global_buf' variable to know when to use bounce buffer
        - remove unnecessary goto label
	- dynamically allocate 'vmm_table'

 .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
 .../net/wireless/microchip/wilc1000/sdio.c    | 35 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/wlan.c    | 15 ++++++--
 3 files changed, 43 insertions(+), 8 deletions(-)

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
index 600cc57e9da2..b12f411aec06 100644
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
+	u8 use_global_buf;
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
@@ -101,12 +105,19 @@ static int wilc_sdio_cmd53(struct wilc *wilc, struct =
sdio_cmd53 *cmd)
 	else
 		size =3D cmd->count;
=20
+	if (cmd->use_global_buf)
+		buf =3D sdio_priv->cmd53_buf;
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
@@ -128,6 +139,12 @@ static int wilc_sdio_probe(struct sdio_func *func,
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
@@ -161,6 +178,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
 free:
+	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 	return ret;
 }
@@ -172,6 +190,7 @@ static void wilc_sdio_remove(struct sdio_func *func)
=20
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
+	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 }
=20
@@ -375,8 +394,9 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 a=
ddr, u32 data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
+		cmd.count =3D sizeof(u32);
 		cmd.buffer =3D (u8 *)&data;
+		cmd.use_global_buf =3D 1;
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret)
@@ -414,6 +434,7 @@ static int wilc_sdio_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
+	cmd.use_global_buf =3D 0;
 	if (nblk > 0) {
 		cmd.block_mode =3D 1;
 		cmd.increment =3D 1;
@@ -492,8 +513,9 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
+		cmd.count =3D sizeof(u32);
 		cmd.buffer =3D (u8 *)data;
+		cmd.use_global_buf =3D 1;
=20
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
@@ -535,6 +557,7 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
 	nblk =3D size / block_size;
 	nleft =3D size % block_size;
=20
+	cmd.use_global_buf =3D 0;
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
