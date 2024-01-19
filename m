Return-Path: <linux-wireless+bounces-2278-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77522833075
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 22:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0DB21851
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 21:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7C65646B;
	Fri, 19 Jan 2024 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b="SYhSWtSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from o1.ptr2625.egauge.net (o1.ptr2625.egauge.net [167.89.112.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE9755780
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 21:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.112.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701101; cv=none; b=cu31DuI4ou8HybAYZWPjw9x0vI5iQVcODOT+PAg0jJPnKvDXsbHhkqf3YEifIDWeVHidx43s9v8Zwky7ZH0pb3YvEyI+Mo6FrNqALjdT8nK5/OIpV9admANHpMf+oTrGJCdhKOppwP07h+HX50u9bczyre0vUrn/rkGAgzxcrNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701101; c=relaxed/simple;
	bh=du/6vPusEFJB9ql5STsQ6mCL64dz1+S7BWqyyitJli0=;
	h=Message-ID:Subject:From:Date:Content-Type:MIME-Version:To:Cc; b=sIH36TBjzMsRStwLy74Yk2mXKBWTBjgk7vF+PLMguCBQSDIhjA7G1lhfpc7AAjq8lTAy1Y1qoloZkUJ+ng6SXQ2u9YlPgMfS9oD0PeI2XyHTjbu2fc6oIGu/waWlh+MDHjcoKdqiy7RDkb3gwLOaz3zvu0zTneJhlpB5Wivh5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net; spf=pass smtp.mailfrom=em1190.egauge.net; dkim=pass (2048-bit key) header.d=egauge.net header.i=@egauge.net header.b=SYhSWtSP; arc=none smtp.client-ip=167.89.112.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=egauge.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em1190.egauge.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=egauge.net;
	h=subject:from:content-type:content-transfer-encoding:mime-version:to:
	cc:cc:content-type:from:subject:to;
	s=sgd; bh=du/6vPusEFJB9ql5STsQ6mCL64dz1+S7BWqyyitJli0=;
	b=SYhSWtSPXSGoSGqWVbqwi2tjUlU0//+/URrDUJUtG1HIwYH470hdCPpsPzQ+vzxuuWmF
	I9waVPQPXibv2IstFgBvGha12lQ2E71jiwp0Sd8sU57lOCv7wN80A7KzgAtUrvyR82f1bI
	yPY6gll1WhPjGMudYIWFrfa8OiJ4JQFWXSI4mWPURU4maUibZ7MUckEyOJFO9J0Tm+NCIf
	rRu0A4JChrpAT7HwoJZEHUbERmOLjb9mfemml/Jys+Wc14YhKq/W8yY97Gxggxd+kN96pq
	g2FBe1ZIn6HABMiHM1E6b+LMxgxwcY4rRQA3EWN7wR3UVUVg2xXthxi45Hy2seAQ==
Received: by filterdrecv-656b5b4c75-nw64g with SMTP id filterdrecv-656b5b4c75-nw64g-1-65AAEEEA-1E
        2024-01-19 21:51:38.917481684 +0000 UTC m=+8133101.788408717
Received: from bixby.lan (unknown)
	by geopod-ismtpd-canary-0 (SG) with ESMTP
	id 58D2w6igRgeVPzYigaT2ng
	Fri, 19 Jan 2024 21:51:38.742 +0000 (UTC)
Message-ID: <90fb762e5840f9d5a6ae46f81692fb947a7796a4.camel@egauge.net>
Subject: RFQ: wifi: wilc1000: make wilc1000-spi bus-probe useful
From: David Mosberger-Tang <davidm@egauge.net>
Date: Fri, 19 Jan 2024 21:51:39 +0000 (UTC)
Organization: eGauge Systems LLC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?+kMxBqj35EdRUKoy8diX1j4AXmPtd302oan+iXZuF8m2Nw4HRW2irNspffT=2Fkh?=
 =?us-ascii?Q?ET6RJF6+Prbl0h=2FEtF1rRLvPOgaU2j1pStS+qXC?=
 =?us-ascii?Q?VUvJo4cEHNF47MD9ucj18dFq+RkXVeHpNBG2NWn?=
 =?us-ascii?Q?rG4Ga6AnMs3jMZYZacwSVj=2F7AwyEc2q2AWrIIxZ?=
 =?us-ascii?Q?FV9PqCkBILDE=2FW5KmSYjeerY1b7Ztt8bRf5i4aa?=
 =?us-ascii?Q?NJvX2Vt3rwfpQbZ259YaUkK0ChpDUDd4vVhXqIW?=
 =?us-ascii?Q?QKwDoQKHQagnaycL4fikQ=3D=3D?=
To: Ajay.Kathat@microchip.com
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
X-Entity-ID: Xg4JGAcGrJFIz2kDG9eoaQ==

The current version of the wilc1000 driver has a probe function that simply
assumes the chip is present. It is only later, in wilc_spi_init(), that the
driver verifies that it can actually communicate with the chip. The result =
of
this is that the net device (typically wlan0) is created and remains in pla=
ce as
long as the wilc1000-spi driver is loaded, even if the WILC1000 chip is not
present or not working.

Is there any reason not to detect the chip's present in wilc_bus_probe()? T=
he
patch below (relative to 5.15.147) works for me, but perhaps I'm missing
something? Would it make sense to merge something along these lines into
mainline?

 --david

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c
b/drivers/net/wireless/microchip/wilc1000/spi.c
index 6bac52527e38..c7ab816d65bc 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -42,7 +42,7 @@ MODULE_PARM_DESC(enable_crc16,
 #define WILC_SPI_RSP_HDR_EXTRA_DATA 8
 struct wilc_spi {
- bool isinit; /* true if SPI protocol has been configured */
+ bool isinit; /* true if wilc_spi_init was successful */
 bool probing_crc; /* true if we're probing chip's CRC config */
 bool crc7_enabled; /* true if crc7 is currently enabled */
 bool crc16_enabled; /* true if crc16 is currently enabled */
@@ -55,6 +55,7 @@ struct wilc_spi {
 static const struct wilc_hif_func wilc_hif_spi;
 static int wilc_spi_reset(struct wilc *wilc);
+static int wilc_spi_configure_bus_protocol(struct wilc *);
 /********************************************
 *
@@ -232,6 +233,22 @@ static int wilc_bus_probe(struct spi_device *spi)
 }
 clk_prepare_enable(wilc->rtc_clk);
+ dev_info(&spi->dev, "crc7=3D%sabled crc16=3D%sabled",
+ enable_crc7 ? "en" : "dis", enable_crc16 ? "en" : "dis");
+
+ /* we need power to configure the bus protocol and to read the chip id: *=
/
+
+ wilc_wlan_power(wilc, true);
+
+ ret =3D wilc_spi_configure_bus_protocol(wilc);
+
+ wilc_wlan_power(wilc, false);
+
+ if (ret) {
+ ret =3D -ENODEV;
+ goto netdev_cleanup;
+ }
+
 return 0;
 netdev_cleanup:
@@ -1108,7 +1125,7 @@ static int wilc_spi_deinit(struct wilc *wilc)
 return 0;
 }
-static int wilc_spi_init(struct wilc *wilc, bool resume)
+static int wilc_spi_configure_bus_protocol (struct wilc *wilc)
 {
 struct spi_device *spi =3D to_spi_device(wilc->dev);
 struct wilc_spi *spi_priv =3D wilc->bus_data;
@@ -1116,21 +1133,6 @@ static int wilc_spi_init(struct wilc *wilc, bool res=
ume)
 u32 chipid;
 int ret, i;
- if (spi_priv->isinit) {
- /* Confirm we can read chipid register without error: */
- ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
- if (ret =3D=3D 0)
- return 0;
-
- dev_err(&spi->dev, "Fail cmd read chip id...\n");
- }
-
- wilc_wlan_power(wilc, true);
-
- /*
- * configure protocol
- */
-
 /*
 * Infer the CRC settings that are currently in effect. This
 * is necessary because we can't be sure that the chip has
@@ -1147,7 +1149,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 }
 if (ret) {
 dev_err(&spi->dev, "Failed with CRC7 on and off.\n");
- goto fail;
+ return ret;
 }
 /* set up the desired CRC configuration: */
@@ -1170,7 +1172,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 dev_err(&spi->dev,
 "[wilc spi %d]: Failed internal write reg\n",
 __LINE__);
- goto fail;
+ return ret;
 }
 /* update our state to match new protocol settings: */
 spi_priv->crc7_enabled =3D enable_crc7;
@@ -1187,16 +1189,38 @@ static int wilc_spi_init(struct wilc *wilc, bool re=
sume)
 ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 if (ret) {
 dev_err(&spi->dev, "Fail cmd read chip id...\n");
- goto fail;
+ return ret;
+ }
+ return 0;
+}
+
+static int wilc_spi_init(struct wilc *wilc, bool resume)
+{
+ struct spi_device *spi =3D to_spi_device(wilc->dev);
+ struct wilc_spi *spi_priv =3D wilc->bus_data;
+ u32 chipid;
+ int ret;
+
+ if (spi_priv->isinit) {
+ /* Confirm we can read chipid register without error: */
+ ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
+ if (ret =3D=3D 0)
+ return 0;
+
+ dev_err(&spi->dev, "Fail cmd read chip id...\n");
+ }
+
+ wilc_wlan_power(wilc, true);
+
+ ret =3D wilc_spi_configure_bus_protocol(wilc);
+ if (ret) {
+ wilc_wlan_power(wilc, false);
+ return ret;
 }
 spi_priv->isinit =3D true;
 return 0;
-
- fail:
- wilc_wlan_power(wilc, false);
- return ret;
 }
 static int wilc_spi_read_size(struct wilc *wilc, u32 *size)


