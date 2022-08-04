Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ABF589C75
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Aug 2022 15:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbiHDNSx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiHDNSw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 09:18:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6FF1DA4A
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659619128; x=1691155128;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=0KxlHiBTNQkfO00iqkktzwATvErepixRNRlVFTnhGBU=;
  b=qZZ0L3+9nNmlbsnsOhiG6dKYlZDFhDytGosYdQOBTjFY21akZcUEm8MM
   rY3SSODTgIDblzy0Buy4wVH86TtvpVkNOE4pq1gE9b9nLu6SJrf8/d/ON
   K9k1LRcrMBgYoYyCSBXUdazQypT/Is31EBO6q0zdOUxYuJGfU/JOLS50/
   6h6RqDw0kN4x446tH0QZrdBuylxb0jJ4TH2bAqcEKOcQZ9yK8wonPrgj7
   lbPz3P2ZSc8IJSSAi5fDSfuxSWtKerk78unR7ySBE4oQ+5+VPDr3BJ+bl
   Hx7Ahh+pF+A8bp7MPM5BcNc0Sx4dLI7mtaqhavjy5YsY6lb1GL4FdzfMb
   g==;
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="185105172"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2022 06:18:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 4 Aug 2022 06:18:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 06:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PuaZlHxKOARPxlQ65IBlePl0YSD4/yhfjW28tcyWR2nIktBC17N8mJJAqKVnIn+2h2yYN4R+nJ5f7cVUPSiBnytSvw5/AFIGvbD3AR2G6oYKs1lZccS1crEIbdcUY7uzMfLbJh38+8UQSyivnKHCip1nNDHU8Y10gYiStbUl3SqE/I0lmiMtLDL+bgytevP02JLWzFrlU/ZB0CH+fT+lqhLROrElnQREL/s5AUu6wlADGalw6FkVAdk61dNo6zg7+IJgld5R//GvWEvXSivhggJ1iYpsSC41crl8xIiDh+JcfA7wmJlZkZW2u5cEefuog8W09DTvykKy8ApMyiASEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtYBRjy8Pt1lbHeB0hZkaZGZRl/ZstjUJJfBl+1SLw4=;
 b=WRszaj+sMJ6NHFVE6+q0J7mFhZnv4QOzXfdNyLanihh5vbKhmR8l/U10rb1IIOBXLesI+6+St3QDnS5UsCjPQR47XcMan3k7dgyYhK70NvmogX9vTpKjvjR7ne9G0jLCcxAnXBIuHh6A3h9U8wqwCDWbUyZlaGHcAeNq+WnnlNRH8wSxemwNNK4fojQetImMRhLrwxRFKukdpWYwQ3D7KFWzNALf/e9cl2X6snfkGxUjKFrw0/SdXZeG0sIEvrjZoOUyebORB6YXzGtIqhMaKyAFu67XMSDzpc2vx0iZDBHVboOlPkteVckysvwQsaCapU7r1v+1G/6zLPzZeiGXmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtYBRjy8Pt1lbHeB0hZkaZGZRl/ZstjUJJfBl+1SLw4=;
 b=mp377vJGyNy9XrGWLGGzGpvlBjvQS/uGOo0eqe9HpEgMh1iWHKQ9NnQcv/j04PnUISiRwgyaDLTejAOV9oLYSFcNKK+otmWz1br6LImXfBZt7YtyTyOUhAEw5fCBnLe7kAkPtKvfXf5N1NKVrIm5b7Qfq2VD/+BJaC2ODN/EY0o=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Thu, 4 Aug
 2022 13:18:40 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::8d74:5951:571e:531e%9]) with mapi id 15.20.5504.015; Thu, 4 Aug 2022
 13:18:40 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <mwalle@kernel.org>, <Ajay.Kathat@microchip.com>
Subject: [PATCH] wifi: wilc1000: fix DMA on stack objects
Thread-Topic: [PATCH] wifi: wilc1000: fix DMA on stack objects
Thread-Index: AQHYqAS2buySm8vdCEW3DEuKM8hVrg==
Date:   Thu, 4 Aug 2022 13:18:40 +0000
Message-ID: <20220804131837.336769-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a680494-95c2-4cbb-f47d-08da761bd921
x-ms-traffictypediagnostic: MW3PR11MB4761:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dz/wfwh5jv9gv7ZLm8ji1hYIhj2AeZArGsyHwZlkSzE4nhFLp7AVPCOoUOIUKtLAReAVQE3DtSgQWoO99VdS334wKXt87URQsUfnQHSLRVAwSGE8Bm95D/W6YqW+vStdj4uzzELrNnOuyw2n6dMoG3vyrUGVxl3ElJjipUd6tv8UukJBo0YuxGSWEGgO1i37OMZuadBSGV2mvX39YISImTKLpWsCeI/4BR4K5TpIug3uAB/FOEfGcQD199YleUDszKZAHu+qlatgGoFXS7We3/vuQ+3w3cfDlvQ/ItEBRIaHWfigbv00l+cv1MbtwRfRuE10dY7j4f5FNcnRi7KuLjhnb8WdUPKmiN82uG1SH1tXlFy2e1PkA489LBCv5H3v+Rugg+1W0JCXrDWz7eOS/8uOM2+XVIW/HAK+oJp0BTB86tBh88aNLvgbQDANZlOBYi4ZZmQ8M4MwRBFkSzFNyajAja8u0NsxuEG6o9FAnttfvYha6CZS+FXkKqWkg7gai1aod59DKcQAIi7idTIcBmfomvYswNurL/kvayrVXz1OWuEqg+WZIz/y+XNnj04hztdycB7pspEDlYrksy+7NVfbRMoG5IyQqh2Si55ZJLDA0g1LfAsarl6pnRLqqgiYfqh0EFTBaC+MH/T7TgWo8ycpS23JGSGfsv8wuuDf2PFNPanTrNejY51LTX6pq4Gi8hxz+DlhATH2LGdy4RwJ7jobS6QkAE5Z8ziNfEB/fsnQf/1e4j1EmkC+glMvYOcRd9gvvs19mRWiEqWx1iBQnsnpiNmkPwRISAjiIvfQ8+s3MAuP8yJ7eDH+TaGCN+8yoVCNImmIrEmBjFkyh6eM8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(366004)(39860400002)(91956017)(966005)(6486002)(66946007)(36756003)(83380400001)(478600001)(76116006)(5660300002)(316002)(64756008)(71200400001)(4326008)(66556008)(8676002)(8936002)(66446008)(66476007)(54906003)(6916009)(1076003)(38070700005)(6512007)(107886003)(6506007)(55236004)(41300700001)(26005)(2616005)(86362001)(2906002)(186003)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R5tfF9U4bkEZ7176C1Q4vTOnv1YFrw/5kKt32MTU5fUXkmNirkm9PRZOer?=
 =?iso-8859-1?Q?SyHsmdgfB2aqVMxlhUGdWcljTcvtTKHvW12gzHGiFQ5oMO8TJfjCnw8mmn?=
 =?iso-8859-1?Q?uj0QaYH33YRsxboIZtO4jxRh0d9/mfzFxNO2PMcmFSHp/XKMKO9314ch3r?=
 =?iso-8859-1?Q?ffX9RSmeiABVN9Kd7PNvqi5hXwCynhA4Z6uirwzrPzjIe61YWVtmgOixhk?=
 =?iso-8859-1?Q?/yzf1HHt52frCLozngt+vgz2IsKAl7ObdJk+Ltk+ZLo/DhJDWXXjpWAK2J?=
 =?iso-8859-1?Q?LU5Ek54F9nZ+/4U1Bbeyv69ESOw1jvJKyOsTfNdzJRmKz5cXbSzOZUMQoD?=
 =?iso-8859-1?Q?lRPMWhQDFlZGS+EZ8d7U4yXoiwpfDRIhkrVpcHVLqTvJolsKFZaqq6V4ga?=
 =?iso-8859-1?Q?CgkrmJLBMfKD/XyPomnv21d4ycFLuuxPa3XTnWpJn3tfTtm3scKUWXcli4?=
 =?iso-8859-1?Q?j48Wi4UZc2ofvB6UMjnGaSFfJSWqOf7G/ByrzMhuxUzd7Ko0RHFD61fN1W?=
 =?iso-8859-1?Q?q7IM5mdZylaqsZfSggZ3VKldtXd/L/GEtcj4G5bRsEOxUedi+3EI/mFAbS?=
 =?iso-8859-1?Q?iTN4iVRHD6Kya1GFGBkTPCexr/Z6c5arElMEcu48A8GfjWO0KlzYcFxRkJ?=
 =?iso-8859-1?Q?1HEFqvJJN2/pKaScnLPZKPuAkRiHjVFgPNMIgN0mgwpstLPNxzKnzge579?=
 =?iso-8859-1?Q?kbKcFwOcg0hpA+C7cWh7DZgfrXjbh1vOcz9ktS10t895XMMypSEwhlHqO1?=
 =?iso-8859-1?Q?NS49NcLe0z2ezP1fvbQz74Hde2dmWyBuEFiBdPzZ1xe8mri7/vjZ5L5UoG?=
 =?iso-8859-1?Q?tK9fr+nxYBjavMe5gR2u87/nRBTlgXEa/n+GQV3SFrFF0eMUaa01qhDuJu?=
 =?iso-8859-1?Q?O76hhbKjzaOsCM4Uzk+kFqnoO4/NuamFZTJL6l2brlPPHRffpLJf2knPCJ?=
 =?iso-8859-1?Q?MoKFCDyGuIG/JP4+NeXfA21S7wdzgbV41ycz0PHSEncU6jp8X/fByU9uHh?=
 =?iso-8859-1?Q?eHcCl3ZZZZppkFF45kM9Ma3MQd51Uc5Yps33F33vl9pIry7xA477SgNI+d?=
 =?iso-8859-1?Q?D32TWAcyTZ7Tlq/V0eYmGRU1kgD8QJdd4VeFn/o7jPs8IA/nXQtNyZU2Z+?=
 =?iso-8859-1?Q?L1zoGay8r4oaaeXQZBX/+jBaz0ih4OsNQnSfbHZZDjHjIJprvd2HLOEZ/a?=
 =?iso-8859-1?Q?4ZHIw8uMtlxFQb2FqLHruNZKW61gX/Y/dU6ZgIdbVytWktadqLAJSvlzIQ?=
 =?iso-8859-1?Q?tjpn9JGFQf/WhPaqH8kBuRzl6eJSTWoZsou8y3qQnRxlkvpNCxC7xBWgcj?=
 =?iso-8859-1?Q?gmN98C5jtBAfoeDkInXxJs97RW8nHmPxPcRPAHP5ISYPHpfSLnUFQmzcb7?=
 =?iso-8859-1?Q?Nk6qu3N4QSd/TElybeLWqxVWHxnIGS45eOuOmFfrOagbphC9FCBbvRwnuG?=
 =?iso-8859-1?Q?gr8VEwTjjMYWN/Ra7HxwjxrGQuMHVI32fAwi5mYV+od/xlzVvPgWmFNwT/?=
 =?iso-8859-1?Q?269WlWHDc04fqiWE0OsN5xcHfErKPCj4bmTLHfcY0Hh/l8W+vtLfYUvvI1?=
 =?iso-8859-1?Q?GyluvKionLnaEYeJP5XqAOzBBKNre4PaaDNVJW5qP+jGq8tPBllX9Nd6O4?=
 =?iso-8859-1?Q?wy4hOfXA8WMZXaAVsXnaW+6u/IsuRSSq9sZO9h6jMQ072UKdWV2yWxhg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a680494-95c2-4cbb-f47d-08da761bd921
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2022 13:18:40.5265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOfR7XMLOCRqovWLU0WPAh8yz5GJbYGAHSDIZUjNULjZbwv9Sif/60GEg6ARsN2IYYOy3mD7VUHQ0jP1LQYG6l6pZ89MfBJOQ+7djmHZKzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
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

 .../net/wireless/microchip/wilc1000/netdev.h  |  1 +
 .../net/wireless/microchip/wilc1000/sdio.c    | 23 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/wlan.c    |  2 +-
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index 43c085c74b7a..2137ef294953 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -245,6 +245,7 @@ struct wilc {
 	u8 *rx_buffer;
 	u32 rx_buffer_offset;
 	u8 *tx_buffer;
+	u32 vmm_table[WILC_VMM_TBL_SIZE];
=20
 	struct txq_handle txq[NQUEUES];
 	int txq_entries;
diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index 600cc57e9da2..8bb0b8e189af 100644
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
@@ -128,10 +129,16 @@ static int wilc_sdio_probe(struct sdio_func *func,
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
-		goto free;
+		goto free_buffer;
=20
 	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
 		struct device_node *np =3D func->card->dev.of_node;
@@ -160,6 +167,8 @@ static int wilc_sdio_probe(struct sdio_func *func,
 dispose_irq:
 	irq_dispose_mapping(wilc->dev_irq_num);
 	wilc_netdev_cleanup(wilc);
+free_buffer:
+	kfree(sdio_priv->cmd53_buf);
 free:
 	kfree(sdio_priv);
 	return ret;
@@ -172,6 +181,7 @@ static void wilc_sdio_remove(struct sdio_func *func)
=20
 	clk_disable_unprepare(wilc->rtc_clk);
 	wilc_netdev_cleanup(wilc);
+	kfree(sdio_priv->cmd53_buf);
 	kfree(sdio_priv);
 }
=20
@@ -375,8 +385,10 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 =
addr, u32 data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
-		cmd.buffer =3D (u8 *)&data;
+		cmd.count =3D sizeof(u32);
+		/* copy to a bounce buffer to avoid use of stack variable */
+		memcpy(sdio_priv->cmd53_buf, &data, sizeof(u32));
+		cmd.buffer =3D sdio_priv->cmd53_buf;
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
 		if (ret)
@@ -492,8 +504,8 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
 		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
-		cmd.count =3D 4;
-		cmd.buffer =3D (u8 *)data;
+		cmd.count =3D sizeof(u32);
+		cmd.buffer =3D sdio_priv->cmd53_buf;
=20
 		cmd.block_size =3D sdio_priv->block_size;
 		ret =3D wilc_sdio_cmd53(wilc, &cmd);
@@ -502,6 +514,7 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
 				"Failed cmd53, read reg (%08x)...\n", addr);
 			return ret;
 		}
+		memcpy(data, sdio_priv->cmd53_buf, sizeof(u32));
 	}
=20
 	le32_to_cpus(data);
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 947d9a0a494e..0576d865c603 100644
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
--=20
2.34.1
