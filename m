Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480C63699A4
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbhDWSaY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44321 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhDWSaW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202586; x=1650738586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gG59fZ6Y3zCifCUdYL+6mC6i15CGJ2xUfo3o+3aTL/w=;
  b=1ahLH8EdB+gyFG3Q5Rsfpo4Io+SA3JA64yJ2yfhJ4mSPpg4KEVrAhdjh
   7yyErXHsT/lD3qOFIblow52uw2ADuKfE/aUX+16T3fKrapf6OeH+LOvjj
   AL7GjqBRjRRjzgqfdOEmWs9EKGxTDglGTOG9f3YzzCrECXR5yim8DpVg4
   oCoZlEeB2rvcbLl3EzcWw/1QLdj7D55729oS890l2/P1qf5rqvke1CHOI
   vAt2iARY9FPKutLdvuZBLqLLYIih4TQwmB0Ww7lJfzf/RtNaCDWVLUQOF
   1wThwUOND1UqBI5H0S7/75Bn4B+QlfjXF8BDtS3ZZn4k0QJi9AvnvYPOE
   Q==;
IronPort-SDR: vjtCglw3kOdqYRI5oU23AKjFhsFtDmDS2zEibkCQeKMoabjrrFqNtt58dRKKW74757ON7Tgm3q
 3mSAuAH44aG1kBCHTz88myH75RIwnkZK8bm4ieOZq2JCFfzPPRO7h6Yd/jgValJVBvLwvrCwBv
 9KLfxwDScd1BSBwLO8DJhFpGLyfuDO2sDdOqvCo0Q06EnjEzOskFP/PB8FsEViRrOdSpa9cS+I
 k/4VUs+RKk0fe4+LXomPuSwVF/7En4f1VkasJ9s7P0G+PiTlcZpqlNs9XqNulI993XcHZfza23
 11E=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="111995814"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlHjeA6m8ilpgEuh9fqfxKbeWFapXR0qtEq80sLVFS3BMFPGoK6eUzTlBM5n8tQdf+8RnOnLjka7XYka9eDSKiMlvj6Nglq0iJLwyEHWTo1ZjpAuLYGiQvfCFMAzRaZthXZQhtEO7eiTaHbAG1KuNq6pdDR5KA/MvwKzSgxSzjGpoIH+EGwzw9mgPazhYwLYJIVmejl97R3rra/FeFJhVAH6lBZ8lSlF7jNIergpRYWa0fQDJ7Gd28mNzTHTPn6R9xMNymQ/uYWrykxivl6vMhjTjjjBBNRwA5/t0ZdpRbgSgyuvhmKYqNRbUqVFI6qrziLfTU3LrGp9H48BVyJqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKrWtAVkz2QPQ9l1QPW/8w+uWwyazbyB7mP445Fft8g=;
 b=djUeDstosaJCtmp6C5x+t7ew6inNLSnZHoeG1rJDjEhinQt7eG2y05o3GlfCISoVKPy0PLo7Db9f5bzAZI2sG9NTk9virXEsXl/zkddm4x9ia12YjWgRBMSrhWIP+T+XBp1guYXHNJRxuiiWCb2KJfrLduFvU+heqIDetmzf+QCrmF9I1qeOUodHONEKdkrKc02BgtpFtn5eID93yIzy0xi7r1+DsqmO+Qb3CTyMTSw0gEZf1MZdRWLE1N894axIGpf4iU4TUHy3KIlLKKHmNdFqAET+4nBL6qLFOLTatkloEkUQxLeaPk++wJyy7ae7OJ3wGqWAb56N08Rb3AF/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKrWtAVkz2QPQ9l1QPW/8w+uWwyazbyB7mP445Fft8g=;
 b=ZGY6WkQyvMJOehD5+krKN2t0FsBApezmUvTljJuR93ZTgrVvSCzqQYLeuWGyLMdIj/nfQFiP0RwszZifBTAbakUtqZ+Cl+V0OmyCHD7Gg5hIKH0FX/adDxcU80nMzRWpHTa1BEE0YXK08e1MjR9+UKsXzBY+GWJiId/DBCCqi2Y=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:44 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:44 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 04/12] wilc1000: setup registers to support chip wakeup
 sequence
Thread-Topic: [PATCH 04/12] wilc1000: setup registers to support chip wakeup
 sequence
Thread-Index: AQHXOG6hTUGwpdyuKEeBJf3GAG87Fw==
Date:   Fri, 23 Apr 2021 18:29:44 +0000
Message-ID: <20210423182925.5865-5-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6cb638-67cb-4d42-4a0f-08d90685c476
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33185C183857D1945A6745A4E3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lrTGpaJt4k43VWpQ1FVgHsa+8SsfqkcklGMQrI2muALRw4PSJ2kw2ZZd56ASSxKverk5S+8rTTvHSEwhOT6tsyyPc60sD2AijA0aEvu7w3hIImZPxAeMI0LXnKjLxVsypuCkzOz8BPVqXn587kYFy20GEAxF8jfQt5Gg7gF5MUv3T/auFo7rZ9hQRazHXV6VpJCQqeUWLP1FejZO6iYu3XR56XM4DObmGkavsoEZsts36e8DZizhpbdICpUvSsk64RMl+xGUGTPTM/9RfI3W0Q2L8iIaa7liDHs2bLw3pmXJpHLxyd+c5euXVdUxAqxR88ZpATqtpJHI+5gIphwzZzE0EqykWOhaI34uHmBeFuUKKJ4F97mRW8uSBLT+gVW2ijdPx4DwjdIHFH4KsR/dIG3h9SYqcyR6o6fcBolUSsKvuqx7KpcFm2Hjy44Z3Cjw0CtUakVZL/aPdP1mk0o2Rw1mzpWflPWemh2rY6u5wF+aQjuzuIeHoxvEAXzN1rFsZEFeJwF/C2PZ+ejEfqacSGqv7LYj4bsUwMdttxmZUQjL296+5p0nzfpFGtYe5Ky0tvwn/nK0nHMmX9P7gCUAjURSCE6b1Uv05250BM7SXmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?mibETjLTvAgGlIVV9VxTXlPp1eVY1TTF6d1Xu+g4+HfF1hN4BSB83+uGxz?=
 =?iso-8859-1?Q?CHLG+GX33OLgt9rbKH5ySjOaLUAgMdhkvhh2tS9am5uxNyMJ4RpNsroamy?=
 =?iso-8859-1?Q?P6cJZ+dPOV+wWDGE781ii+Tf3O+I9RzbgS3MwivpA9TbaK/ukmBiOst4M/?=
 =?iso-8859-1?Q?OXm2h+VJ1pEZJOM7F4nSwG3pkDkxNag9cMOtHI7+wTnSZiNh36h4ULti9y?=
 =?iso-8859-1?Q?GSg8Yd2Uv3CGm5x7mnodKgHtCX5jLMfqwkpWLJ/qTepWnw4o75dmjGyX5V?=
 =?iso-8859-1?Q?nWOKa9Tebpp6zjO/xEx3eO5LXLcMjKR5mKN9MIZsZgouz973/eCzlCNV1n?=
 =?iso-8859-1?Q?oY2w5Dux4FoDus/P+tdJYw8ZN3egJ8BNbtIITcKQ1XsIWF1d+EYPllYSpY?=
 =?iso-8859-1?Q?vI5/Q19k8uRnOWCq0rGVyd+zZ1jWYFUV2JvJjnsbcnF8exU7joPV6Zf3Nc?=
 =?iso-8859-1?Q?3KjCAC9hQK0hmTvR9k19tZ7Q7d13p1+/ywA9gPaLG3BTxSCMy/OTWUUxdn?=
 =?iso-8859-1?Q?lKDb+KLViKHpYWLO5Zc+uT3X31YNS4O8xbH2A3yj7KrrXD68qaxfjRPwua?=
 =?iso-8859-1?Q?PuJiUb3oIIkMHHl/WrxAy/vg6V+BZhEFqJqjN3+5ry02WQ//4MbYP1zu3i?=
 =?iso-8859-1?Q?rBJVGxRtSt48m+jChwa8199q5Io1LJW6Qwcq5telm3q749tVHOZFQOma/n?=
 =?iso-8859-1?Q?HkXi+XwlHtVndYZZ9DIbAXPlZ0/oF+o+N35ZCfvPuMOk0vFY8yRUoG0bcp?=
 =?iso-8859-1?Q?wcHF9CBE53DRdAaLBHQO6O0PhGvA6Fsa4IcBkYj4IsxbReA0/tBw470kBB?=
 =?iso-8859-1?Q?HUNiDfDyPLwfxCljWz7GU9KM5+o6YhinZcxmWy3iAh7PrkrYb1lFRID6td?=
 =?iso-8859-1?Q?EbfAvWquXVJ0Y8B7WWT/cKlstFTyAXiwB7wsI7mkQXVnqQtuSNkdzTyHtF?=
 =?iso-8859-1?Q?Mn5dy5mKsTsv85ozg1maGjileHdPDMGGGv9fTzEKDsKs+ZK4G2fUlO5sUM?=
 =?iso-8859-1?Q?IRGFwxrvWqauSSxTGJ5P1VgMUm8fNIpjPPzIVYfbhCfJbpFyjcRwhZjSEI?=
 =?iso-8859-1?Q?OwchTOg2PTcOXCLV6bVe1D4xJkxWSOjffOtGBEBussQCBreyxcv9y+h9nn?=
 =?iso-8859-1?Q?vP0jIliWDRLFcpAF2ETqHHAk6Tm+fvvyqovwz9vEub/bs1HyYI7ZNSYDUe?=
 =?iso-8859-1?Q?B7cP+AfRpBtJjWJTCfE+36rtqQZGK6oD+fm5ZxGd4thzRyJjtLveEhNqDS?=
 =?iso-8859-1?Q?IYedH8/iNOLjFu+ZVCL7Wwzd4Dyk/V6jVuhbYv7EiBDJ1hoZStKRNotwjb?=
 =?iso-8859-1?Q?mQKAXChE5UN/caHXE4J8b8L8DOaKArHYjK2lnesY/vXpJAGwhc1G+aNSUY?=
 =?iso-8859-1?Q?HFY5drUGdMHr/eiPcYz6pK2OOVJTsZPw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6cb638-67cb-4d42-4a0f-08d90685c476
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:44.4616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0nqukyruMeY+n8aGjWvq6nu9nTNfM44eDhzByoylj3dZr1NLTDMO5CUnqYM8Yf9PeNhtDJRCZ74Pn4jQL+XW9ZHhDKhBqXrooX7AhS2S9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Configure required register for WILC1000 wakeup sequence out of sleep
for SPI and SDIO module.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wireless/microchip/wilc1000/cfg80211.c    |  1 -
 .../net/wireless/microchip/wilc1000/netdev.h  |  1 -
 .../net/wireless/microchip/wilc1000/wlan.c    | 98 ++++++++++---------
 .../net/wireless/microchip/wilc1000/wlan.h    |  2 +
 .../net/wireless/microchip/wilc1000/wlan_if.h |  6 --
 5 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/n=
et/wireless/microchip/wilc1000/cfg80211.c
index 75160ab3914a..91a471f3b1c8 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1726,7 +1726,6 @@ int wilc_cfg80211_init(struct wilc **wilc, struct dev=
ice *dev, int io_type,
 	*wilc =3D wl;
 	wl->io_type =3D io_type;
 	wl->hif_func =3D ops;
-	wl->chip_ps_state =3D WILC_CHIP_WAKEDUP;
=20
 	for (i =3D 0; i < NQUEUES; i++)
 		INIT_LIST_HEAD(&wl->txq[i].txq_head.list);
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
index a39c62a20f04..79f73a72da57 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -265,7 +265,6 @@ struct wilc {
 	bool suspend_event;
=20
 	struct workqueue_struct *hif_workqueue;
-	enum chip_ps_states chip_ps_state;
 	struct wilc_cfg cfg;
 	void *bus_data;
 	struct net_device *monitor_dev;
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 2030fc7f53ca..177e42a9a603 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -10,6 +10,8 @@
 #include "cfg80211.h"
 #include "wlan_cfg.h"
=20
+#define WAKE_UP_TRIAL_RETRY		10000
+
 static inline bool is_wilc1000(u32 id)
 {
 	return (id & (~WILC_CHIP_REV_FIELD)) =3D=3D WILC_1000_BASE_ID;
@@ -611,60 +613,62 @@ EXPORT_SYMBOL_GPL(chip_allow_sleep);
=20
 void chip_wakeup(struct wilc *wilc)
 {
-	u32 reg, clk_status_reg;
-	const struct wilc_hif_func *h =3D wilc->hif_func;
-
-	if (wilc->io_type =3D=3D WILC_HIF_SPI) {
-		do {
-			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
-			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
-					 reg | WILC_SPI_WAKEUP_BIT);
-			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
-					 reg & ~WILC_SPI_WAKEUP_BIT);
-
-			do {
-				usleep_range(2000, 2500);
-				wilc_get_chipid(wilc, true);
-			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
-		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
-	} else if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
-		h->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG,
-				 WILC_SDIO_HOST_TO_FW_BIT);
-		usleep_range(200, 400);
-		h->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
-		do {
-			h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
-					 reg | WILC_SDIO_WAKEUP_BIT);
-			h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
-					&clk_status_reg);
-
-			while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
-				usleep_range(2000, 2500);
+	u32 ret =3D 0;
+	u32 clk_status_val =3D 0, trials =3D 0;
+	u32 wakeup_reg, wakeup_bit;
+	u32 clk_status_reg, clk_status_bit;
+	u32 to_host_from_fw_reg, to_host_from_fw_bit;
+	u32 from_host_to_fw_reg, from_host_to_fw_bit;
+	const struct wilc_hif_func *hif_func =3D wilc->hif_func;
=20
-				h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
-						&clk_status_reg);
-			}
-			if (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
-				h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
-						 reg & ~WILC_SDIO_WAKEUP_BIT);
-			}
-		} while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT));
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
+		wakeup_reg =3D WILC_SDIO_WAKEUP_REG;
+		wakeup_bit =3D WILC_SDIO_WAKEUP_BIT;
+		clk_status_reg =3D WILC_SDIO_CLK_STATUS_REG;
+		clk_status_bit =3D WILC_SDIO_CLK_STATUS_BIT;
+		from_host_to_fw_reg =3D WILC_SDIO_HOST_TO_FW_REG;
+		from_host_to_fw_bit =3D WILC_SDIO_HOST_TO_FW_BIT;
+		to_host_from_fw_reg =3D WILC_SDIO_FW_TO_HOST_REG;
+		to_host_from_fw_bit =3D WILC_SDIO_FW_TO_HOST_BIT;
+	} else {
+		wakeup_reg =3D WILC_SPI_WAKEUP_REG;
+		wakeup_bit =3D WILC_SPI_WAKEUP_BIT;
+		clk_status_reg =3D WILC_SPI_CLK_STATUS_REG;
+		clk_status_bit =3D WILC_SPI_CLK_STATUS_BIT;
+		from_host_to_fw_reg =3D WILC_SPI_HOST_TO_FW_REG;
+		from_host_to_fw_bit =3D WILC_SPI_HOST_TO_FW_BIT;
+		to_host_from_fw_reg =3D WILC_SPI_FW_TO_HOST_REG;
+		to_host_from_fw_bit =3D WILC_SPI_FW_TO_HOST_BIT;
 	}
=20
-	if (wilc->chip_ps_state =3D=3D WILC_CHIP_SLEEPING_MANUAL) {
-		if (wilc_get_chipid(wilc, false) < WILC_1000_BASE_ID_2B) {
-			u32 val32;
+	/* indicate host wakeup */
+	ret =3D hif_func->hif_write_reg(wilc, from_host_to_fw_reg,
+				      from_host_to_fw_bit);
+	if (ret)
+		return;
=20
-			h->hif_read_reg(wilc, WILC_REG_4_TO_1_RX, &val32);
-			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, WILC_REG_4_TO_1_RX, val32);
+	/* Set wake-up bit */
+	ret =3D hif_func->hif_write_reg(wilc, wakeup_reg,
+				      wakeup_bit);
+	if (ret)
+		return;
=20
-			h->hif_read_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, &val32);
-			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, val32);
+	while (trials < WAKE_UP_TRIAL_RETRY) {
+		ret =3D hif_func->hif_read_reg(wilc, clk_status_reg,
+					     &clk_status_val);
+		if (ret) {
+			pr_err("Bus error %d %x\n", ret, clk_status_val);
+			return;
 		}
+		if (clk_status_val & clk_status_bit)
+			break;
+
+		trials++;
+	}
+	if (trials >=3D WAKE_UP_TRIAL_RETRY) {
+		pr_err("Failed to wake-up the chip\n");
+		return;
 	}
-	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
 }
 EXPORT_SYMBOL_GPL(chip_wakeup);
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 771c25fa849b..285e5d9a2b48 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -97,6 +97,8 @@
 #define WILC_SPI_WAKEUP_REG		0x1
 #define WILC_SPI_WAKEUP_BIT		BIT(1)
=20
+#define WILC_SPI_CLK_STATUS_REG        0x0f
+#define WILC_SPI_CLK_STATUS_BIT        BIT(2)
 #define WILC_SPI_HOST_TO_FW_REG		0x0b
 #define WILC_SPI_HOST_TO_FW_BIT		BIT(0)
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan_if.h b/drivers/ne=
t/wireless/microchip/wilc1000/wlan_if.h
index 31c68643731d..6eb7eb4ac294 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan_if.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan_if.h
@@ -48,12 +48,6 @@ enum {
 	WILC_FW_MAX_PSPOLL_PS =3D 4
 };
=20
-enum chip_ps_states {
-	WILC_CHIP_WAKEDUP =3D 0,
-	WILC_CHIP_SLEEPING_AUTO =3D 1,
-	WILC_CHIP_SLEEPING_MANUAL =3D 2
-};
-
 enum bus_acquire {
 	WILC_BUS_ACQUIRE_ONLY =3D 0,
 	WILC_BUS_ACQUIRE_AND_WAKEUP =3D 1,
--=20
2.24.0
