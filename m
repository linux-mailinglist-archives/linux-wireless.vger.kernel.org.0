Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7624A77E644
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 18:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbjHPQXX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 12:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344658AbjHPQW7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 12:22:59 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BABBC1
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 09:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692202978; x=1723738978;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=sJBpG4P+nKcy9TVl6B39R/ut7yUMpUZAl5x+zPep7rM=;
  b=G4JhKYQ5i9+JxDxLvdeKFvLOUJA8HoRepzkOiufxMv7Eq9o/motnShro
   TT3LnIMBJqAIOx7YnflVUo2EgaUzVcDnkvtHkZQI4c4pe5r3cAfuwuIOC
   sjBjSZldTSgKdMAx/DGyNuydrZ441N6TeIFA0mMIrB8WZONEEv1tx9cfx
   c5KcPOyvRKJD7XyYW/H2DajA0TwB7h6G8zE5KFi4IFv4xJpL+YNrAb9x0
   nT9UGdskmvk87x/RFrypNSTi/cCBmqnhX5OoqFI+e4dDbhjxuBIlKv13F
   AFHj9CpKWDr5nypwWtKhWps0GTvbg6D9oZDaR5c1FVF2CG6GbluWrAVVA
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="166755560"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Aug 2023 09:22:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 16 Aug 2023 09:22:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 16 Aug 2023 09:22:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrmCxrJl6brf8/wDeoLVNNL13QwOJc5sAkqVJn2IRoX/GKH26lzRGLHhHS9fGcPl4KU1tFU6SB3wxJIQvoKs+ItR0wdUsKIFEsBujbcUCUwKrrEFc5nVmqo9pX3HAN3oskndwENjSAOh99xlIgv2Khr2TeLbkajzhef79JzzIqAoruPjFMIk4N7QNRTxQq/FwENrs8C7r2bPqiYCQzQfa6ifta7JgLxS9ayWi0Ba7ahwDSJp4VoD1ajnEzJ/X3MoCo4/0QFeEoBXjE4tpXlTloKKrY4i4ZV9BMmpo7lJtpmZh8Q2roOSWWI7DUNu6fQL9/bCI7OMWS4cetIogWpseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAJddLyPy5DxQu9Y6SxRa3b1Bs3VCJXxmFSAg/0rYZY=;
 b=EOCqdo9B/3Ht/Lp7zUwYyN7MQJbKrS+iLiDLIIWekT4tO7HrBXBD6WyZGAlCL33MQRf/PUJ+KIzVh8Kgc5y2WatMsBQ3HDq2H/ptqJdqJlAIyJ9YtAIQud77wVcJ9FRtjJQ0yIrkFHBMihJzIFsdNDq6mzctTYPBBuN7b/NqlRbtRI65uleO0SMUwR5+0Sq82BtswLyZGC17nDmB1gUohuyscXCp+N5aY5N+cXXC08STMFtbRv0lnNKxv1hOoTsCUledSP+hkkD56PZbr6ZxLWZzIhUMRZf8OzE/krjJ/nW73HYb/o3Gf/jjwDwra5RsR3AmiJZxi0fp5OjZ3cADrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAJddLyPy5DxQu9Y6SxRa3b1Bs3VCJXxmFSAg/0rYZY=;
 b=AGE+nOaWosU70BDeypGD8I/H/SCJIsH7vMRHAKaUj47ggTAoHRFbpeqTt7z9gLYzF/GS9jHw/IQvQ5hwGw8Uejo9W7w5hsbD7yvTaq/N50ebwzaJgXU4yT95bQ3sb1p3nSNrARwbCB9gVyV/0EoLYeTvJQn0q4utdrj48j+6G3I=
Received: from DM4PR11MB6336.namprd11.prod.outlook.com (2603:10b6:8:b9::7) by
 SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.29; Wed, 16 Aug 2023 16:22:55 +0000
Received: from DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2]) by DM4PR11MB6336.namprd11.prod.outlook.com
 ([fe80::b62f:9d90:a95:7d2%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 16:22:55 +0000
From:   <Prasurjya.Rohansaikia@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <claudiu.beznea@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: Added back-off algorithm to balance tx
 queue packets.
Thread-Topic: [PATCH v2] wifi: wilc1000: Added back-off algorithm to balance
 tx queue packets.
Thread-Index: AQHZ0F3puINh0wZcnkmNIQcR+TJOHg==
Date:   Wed, 16 Aug 2023 16:22:55 +0000
Message-ID: <20230816162259.33342-1-prasurjya.rohansaikia@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6336:EE_|SJ2PR11MB8299:EE_
x-ms-office365-filtering-correlation-id: 54366233-1edd-4025-a699-08db9e750c05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QUc4UFZHkIutfnqdpehJ/UaeIGHrGIkJLixw1SyhFeSxFE6ndrsdY0Zf1Mi404+dOq5NW15WVHRU1lV9aPq81fm6xX6eYOj8hIU7XXYi/On/xNyoXbMaoHZSQXuX5fnUpstAsY4IMrwh9cQiX+mZaP/HePOS+Wv+ZxL/3rTqu+lugoIHVG2K8taAfjnUZJGFSPzv+9WceWC9XaKlX0U+FLaVM6a/+GdY/FEszFQnxaa1ZBfEvHIZQZhWd+V53HI79E97dkc8EAeEBN9DKMi4fweir22uu/8oh0OjagL+8+d7oCPQTygSZjdXgs4pawZ10Egsb+o32g+QUiW/q24d9jJkD71lMdKjYHAhIXbbSfnkj1y59cb8EsM6e8x1K3+zt+gV6rfw4kM1Ns8pI+gKAyxf2B+xUYPyarDc2sv4IboK/UpPrjqO2b8Yd1yCU/hWSCFdUTxdyyr/kpvzlKPDQLRFsqVwSfOV79OvogJnaz3VTyoSUQs8R+hnF7To6oe3HIvPDOPCKxym4ygu0QPnMgh79VgqBtZiDBieiYX5uv6dXSNnfW+vDZc1nP0GufLOV9gFKriC3vrxLAu4fpuoAqdefSsKnTtJKQfq/53q8/svgLB72Zs7fCRhZpMoYrIv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6336.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(6916009)(66946007)(91956017)(64756008)(66476007)(66556008)(66446008)(122000001)(41300700001)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(107886003)(6506007)(36756003)(71200400001)(1076003)(2616005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?21Ksx1U2q2upjc0dWiU4iAxqXFgEcgcGTnhC/IDY/aSkLgYP6Nb+sTMlC7?=
 =?iso-8859-1?Q?B70nR3fSOAPXsM1jLJcLwYG7a6cQKehBZZWnxo4ETVoVnlKdgZ7B8gI8Zo?=
 =?iso-8859-1?Q?EAy6h25sPqFwpOjS9ZrqX8/Joot5uthiKtZLmYICj9tPdMJe5NPsqEzWsD?=
 =?iso-8859-1?Q?IT6DmHHGmdEFaYW9xZLxMhI7043APQJRnWMnQSapkw+28nV+x992aqMWDo?=
 =?iso-8859-1?Q?ocRUwcAAP3MOLXaMzFr60PdqCiwTy3n+kOZ30AoOvY/47pnnfvIfnljqYH?=
 =?iso-8859-1?Q?pV1gS7fQyCIwp71TJSJyix036oYuBujsOpF0lL2rTkAwA962zA/Qksdh4a?=
 =?iso-8859-1?Q?OfOXCwdxJwCK9sXkZXzVBDv4A0aVXCbiFFtxMNIIWHcYwhbHXuFJVdIPRf?=
 =?iso-8859-1?Q?ZmMBttcKGZ3pAtay3m6VkLFyoaepY9SBTCIzI++QdgweCY8R/gkO6h7NwJ?=
 =?iso-8859-1?Q?a3VjerZbcniqbJuA9da2MPfDNCzQE5TPmU67m4ATnfwkLgrQWBqD+s2TkS?=
 =?iso-8859-1?Q?axOBMY/aUR5vadVaegciqPKKo2Jr62JHC0L78FiMRBVAYTdV00JJ4Yo4+M?=
 =?iso-8859-1?Q?xKWAzaTf/dDZMASFQlhgrFK1IDDkKVmqPx/JC6eNv7+3hnlSOzDu/ME01S?=
 =?iso-8859-1?Q?uL2Dsd/n0vVed//GPeLNlIDKM/3lLNlh8bwhefc7pj3JLwmW1fpfqWVTzg?=
 =?iso-8859-1?Q?I7NV17v+GPJBu+dGINhJhDq0FDIaxnPayiRxcfAu01PO2Fqnw3zkBeTJHW?=
 =?iso-8859-1?Q?3uYdPmYE+D/WcJxEmE9pGyIqTSt5e3jIzSoTvrBk4wDEbZ5cDZHt50FN8a?=
 =?iso-8859-1?Q?Vatw6snfXWKKiuLR2mwU/S2V4CZDduzLCIiYhb/ouv/4c+Tuu/qsLolOXk?=
 =?iso-8859-1?Q?9rJaJIVTnreOGGSgUzzt9J3G5TI5Qb+HDFsEteUXWk+OfXUR9AX9munQA9?=
 =?iso-8859-1?Q?Gu0ZGf2q7Od+preRX0S9PuqC5CK/u0BKKA0cbXeXwylCvQhKt/EBThXbcg?=
 =?iso-8859-1?Q?PP4ofOouq6pdwNBGtgN+a1y91Nwf/EoWjdbEUx99SQSmcgNya0X3c+XBSC?=
 =?iso-8859-1?Q?lP8mgD7iw706SSL+Lxh0xTE75nMWg4EoZ1mxsUlUmBGAPMVqAn3akYR076?=
 =?iso-8859-1?Q?b2SdKllZS/Oy242VBVhaVVvEpZ/JlbzQFSYfbxLN1Lll0d937B5725sKl2?=
 =?iso-8859-1?Q?AWb6aOp5i+6KjIFtph34o/nNsrQ5+zBlBmNroB98wSgjbIp77VJCugIKNL?=
 =?iso-8859-1?Q?1En6uOaih4PiQB3V7wQFETi5sB/AnYMODgvofRLwIfwKcOWDpUQA0ygPOK?=
 =?iso-8859-1?Q?SCaFImeBQz120fcza19AwItJ7P8A+YiaKk1EKWX1V7wNTvNSH6u93xP6HT?=
 =?iso-8859-1?Q?X9oTxeRW1rL7fdsYwWklYUKYOIUQDaR3cQdUc1r5QgnNMG4/bXen3OspdC?=
 =?iso-8859-1?Q?Z7o6u/CBp8Na8BhECsYt9vmrC4lDnUIkZVdHrJbq1Rok5PTQ8zSmvahp5w?=
 =?iso-8859-1?Q?z6shG5bFGrBAt+7oS6qnHCg0b4ZWT7ZovWJuS7UT7q49XKaqRC7yCVQ1vN?=
 =?iso-8859-1?Q?GLisIaAH5zHgY+EDo2iG7bWcD/3LYpf0Fv/kq9jSuL6qch8188EdqvBpH7?=
 =?iso-8859-1?Q?VGz9kEQxm5f2UhKClQY4JyafzsIqGKZM4lmSL92Y6ERSzfB/vwEwRvkkfE?=
 =?iso-8859-1?Q?s6XoElXmMXgxTPC+oso=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6336.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54366233-1edd-4025-a699-08db9e750c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 16:22:55.2933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WUjoePEax4Rg7yen1xvHO2tuE8CpFjxCnkBaxvLd2pqCoFv4DoDpZjiKQnDbZ6iYlSW4mLbABRCoPYcHdOS5VNSMxeL3NNS0Epypg59XKlWcqmJRbY1auRTtdO/JFfZD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>

Added an algorithm to backoff the Tx Task when low memory scenario is
triggered at firmware. During high data transfer from host, the firmware
runs out of VMM memory, which is used to hold the frames from the host.
So added flow control to delay the transmit from host side when there is
not enough space to accomodate frames in firmware side.

Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
---
v1 -> v2: Removed the unused `timeout` variable.
---
 .../net/wireless/microchip/wilc1000/netdev.c  | 21 +++++++++++++++----
 .../net/wireless/microchip/wilc1000/netdev.h  |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index e9f59de31b0b..faf175a0f05b 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -148,8 +148,8 @@ static int wilc_txq_task(void *vp)
=20
 	complete(&wl->txq_thread_started);
 	while (1) {
-		wait_for_completion(&wl->txq_event);
-
+		if (wait_for_completion_interruptible(&wl->txq_event))
+			continue;
 		if (wl->close) {
 			complete(&wl->txq_thread_started);
=20
@@ -166,12 +166,25 @@ static int wilc_txq_task(void *vp)
 				srcu_idx =3D srcu_read_lock(&wl->srcu);
 				list_for_each_entry_rcu(ifc, &wl->vif_list,
 							list) {
-					if (ifc->mac_opened && ifc->ndev)
+					if (ifc->mac_opened &&
+					    netif_queue_stopped(ifc->ndev))
 						netif_wake_queue(ifc->ndev);
 				}
 				srcu_read_unlock(&wl->srcu, srcu_idx);
 			}
-		} while (ret =3D=3D WILC_VMM_ENTRY_FULL_RETRY && !wl->close);
+			if (ret !=3D WILC_VMM_ENTRY_FULL_RETRY)
+				break;
+			/* Back off from sending packets for some time.
+			 * schedule_timeout will allow RX task to run and free
+			 * buffers. Setting state to TASK_INTERRUPTIBLE will
+			 * put the thread back to CPU running queue when it's
+			 * signaled even if 'timeout' isn't elapsed. This gives
+			 * faster chance for reserved SK buffers to be freed
+			 */
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_timeout(msecs_to_jiffies
+					 (TX_BACKOFF_WEIGHT_MS));
+		} while (!wl->close);
 	}
 	return 0;
 }
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index bb1a315a7b7e..aafe3dc44ac6 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -27,6 +27,8 @@
 #define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
 #define DEFAULT_LINK_SPEED			72
=20
+#define TX_BACKOFF_WEIGHT_MS			1
+
 struct wilc_wfi_stats {
 	unsigned long rx_packets;
 	unsigned long tx_packets;
--=20
2.34.1
