Return-Path: <linux-wireless+bounces-18856-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A544EA32AA1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9DB3A6DBA
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3612262801;
	Wed, 12 Feb 2025 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nzQjBATA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDE260A33;
	Wed, 12 Feb 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375282; cv=none; b=NRPmzjIRF3xDW7sTwZSVo6i4/bde2S12OQ83htN5Fm+Wo3UkwVlw+XY0N+qDrp6W3CfW3ks1c0PNRx04Rhw0BLr32u3POevBsGoXYVfI41h63sMdh0UUwudwGg9/v0R3TILHjkZos1Fo7i1BWOg8bymPYgVSMVNdN5kMJPB9iK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375282; c=relaxed/simple;
	bh=fYVaUjVpOZRNw0S/JxgOjIog5MTjm+jUX2SsawPqNx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmFibWZMWjhkIP7etAhrb1dmlevzQqOLwcZLU31H1Uooh2XJPwMfng0mBRTbA2s7cL87vftxjcAlP8KwkdxUAv9GysBklV3dHJHXREcDvA+7rB1264UWr1qNps6OmEBu73aOVzUZmc4kHXE7fCsQrSFsYmf19yNPnQzJGQS0vvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nzQjBATA; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE26644166;
	Wed, 12 Feb 2025 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739375277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUgTDBJ7HqgNU9e/B8PEjHEMHLmkvOsenNOHrVru48I=;
	b=nzQjBATAZ/NKCeU5kTh9nkowbvXCRZLIhBCTTt0Bq8Nkb3yfE9zitxrOfPhX+bp850tf14
	wk2trk9a50Kbee3D1SrYegZfyiT23Af75q/kyNDr4jhG7L7yX94YgwUzlTwV3N6BlrW713
	mXSoCinP5wxS/h6hiWdXcjOr41JpIsDFIOiYpBRZ2j9E4C/CRRwdEmjjKXMKnz0uyCTGxj
	OhnBLgmvJpow/yUMnYPBtD6GWN/ZmbTR8a8dEq9tdhXgNRfEPCvHjEi+PM4rtlZwKP6wli
	k0brz7y685H8tGkfZl/wm0Qcf4bMtd70t7vN0XfDZ2vJDcHWoxJvWt7aaDBPuw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 12 Feb 2025 16:46:29 +0100
Subject: [PATCH 10/12] bluetooth: hci_wilc: add wilc hci driver
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-wilc3000_bt-v1-10-9609b784874e@bootlin.com>
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
In-Reply-To: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Marek Vasut <marex@denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggedvkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevgefhteffuefhheekkeelffffvdeugffgveejffdtvdffudehtedtieevteetnecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdpr
 hgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhuihiirdguvghnthiisehgmhgrihhlrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

WILC3000 is a combo chip providing 802.11b/g/n and Bluetooth 5.0
capabilities. The wifi side is used either over SDIO or SPI, and the
bluetooth side is used over uart, with standard hci. The wifi side is
already supported by Linux.

Add a dedicated bluetooth driver to support the bluetooth feature from
wilc3000 chip. Similarly to other supported bluetooth chips, wilc
devices need a firmware to be uploaded before being able to use
bluetooth. However, the major difference is that the firmware needs to
be uploaded through the wifi bus (SDIO or SPI). This constraint makes
this new driver depends on the corresponding wilc wlan driver for the
bluetooth setup. Once the basic BT initialization has been performed,
both side can be used independently, and in parallel.

Since this creates a dependency to some wlan driver, create a dedicated
module (hci_wilc) rather than integrating wilc bluetooth support in
hci_uart, to avoid propagating this dependency.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/bluetooth/Kconfig    |  13 ++
 drivers/bluetooth/Makefile   |   3 +-
 drivers/bluetooth/hci_uart.h |   1 +
 drivers/bluetooth/hci_wilc.c | 333 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 349 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48644715d4c27ec0d2fdaccef62b76..a96607fb0cc8fed2ccb1811a4b1b4fe586396b07 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -147,6 +147,19 @@ config BT_HCIUART_NOKIA
 
 	  Say Y here to compile support for Nokia's H4+ protocol.
 
+config BT_HCIUART_WILC
+	tristate "WILC protocol support"
+	depends on (WILC1000_SDIO || WILC1000_SPI)
+	select WILC_BT
+	depends on BT_HCIUART
+	depends on BT_HCIUART_SERDEV
+	select BT_HCIUART_H4
+	help
+	  The WILC uart protocol allows interacting with wilc3000 chips
+	  with HCI over UART. The bluetooth firmware needs to be uploaded
+	  to the chip through the main bus, so this driver needs the
+	  corresponding wlan driver.
+
 config BT_HCIUART_BCSP
 	bool "BCSP protocol support"
 	depends on BT_HCIUART
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 81856512ddd030ba8172ff106b80b4b951188cbd..a1e69884acf4ce91f02ff5592541616048b07e31 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -35,10 +35,11 @@ obj-$(CONFIG_BT_NXPUART)	+= btnxpuart.o
 obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
 
 obj-$(CONFIG_BT_HCIRSI)		+= btrsi.o
-
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
 
+obj-$(CONFIG_BT_HCIUART_WILC)	+= hci_wilc.o
+
 hci_uart-y				:= hci_ldisc.o
 hci_uart-$(CONFIG_BT_HCIUART_SERDEV)	+= hci_serdev.o
 hci_uart-$(CONFIG_BT_HCIUART_H4)	+= hci_h4.o
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index fbf3079b92a5339154f8847ff36b3c08ef49e2bb..83fc48be4335e0946853fdec32c38bf2fb195009 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -35,6 +35,7 @@
 #define HCI_UART_NOKIA	10
 #define HCI_UART_MRVL	11
 #define HCI_UART_AML	12
+#define HCI_UART_WILC	13
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
diff --git a/drivers/bluetooth/hci_wilc.c b/drivers/bluetooth/hci_wilc.c
new file mode 100644
index 0000000000000000000000000000000000000000..97dc4620c74ef0733469839adda7890bda90406e
--- /dev/null
+++ b/drivers/bluetooth/hci_wilc.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Bluetooth HCI UART driver for WILC devices
+ *
+ */
+#include "linux/bitops.h"
+#include "linux/byteorder/generic.h"
+#include "linux/err.h"
+#include "linux/gfp_types.h"
+#include "net/bluetooth/bluetooth.h"
+#include "net/bluetooth/hci.h"
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/of.h>
+#include <linux/serdev.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include <net/wilc.h>
+
+#include "hci_uart.h"
+
+#define WILC_BT_UART_MANUFACTURER	205
+#define WILC_UART_DEFAULT_BAUDRATE	115200
+#define WILC_UART_BAUDRATE		460800
+
+#define HCI_VERSION_BOOTROM	0xFF
+#define HCI_VERSION_FIRMWARE	0x06
+
+#define HCI_VENDOR_CMD_WRITE_MEM	0xFC52
+#define HCI_VENDOR_CMD_UPDATE_UART	0xFC53
+#define HCI_VENDOR_CMD_UPDATE_ADDR	0xFC54
+#define HCI_VENDOR_CMD_RESET		0xFC55
+#define HCI_VENDOR_CMD_READ_REG		0xFC01
+
+struct wilc_adapter {
+	struct hci_uart hu;
+	struct device *dev;
+	void *wlan_priv;
+	bool flow_control;
+};
+
+struct wilc_data {
+	struct sk_buff *rx_skb;
+	struct sk_buff_head txq;
+};
+
+struct hci_update_uart_param {
+	__le32 baudrate;
+	__u8 flow_control;
+} __packed;
+
+static int wilc_open(struct hci_uart *hu)
+{
+	struct wilc_data *wdata;
+
+	BT_DBG("hci_wilc: open");
+	wdata = kzalloc(sizeof(*wdata), GFP_KERNEL);
+	if (!wdata)
+		return -ENOMEM;
+	skb_queue_head_init(&wdata->txq);
+	hu->priv = wdata;
+
+	return 0;
+}
+
+static int wilc_close(struct hci_uart *hu)
+{
+	struct wilc_data *wdata = hu->priv;
+
+	BT_DBG("hci_wilc: close");
+	skb_queue_purge(&wdata->txq);
+	kfree_skb(wdata->rx_skb);
+	kfree(wdata);
+	hu->priv = NULL;
+	return 0;
+}
+
+static int wilc_flush(struct hci_uart *hu)
+{
+	struct wilc_data *wdata = hu->priv;
+
+	BT_DBG("hci_wilc: flush");
+	skb_queue_purge(&wdata->txq);
+	return 0;
+}
+
+static const struct h4_recv_pkt wilc_bt_recv_pkts[] = {
+	{ H4_RECV_ACL, .recv = hci_recv_frame },
+	{ H4_RECV_SCO, .recv = hci_recv_frame },
+	{ H4_RECV_EVENT, .recv = hci_recv_frame },
+};
+
+static int wilc_recv(struct hci_uart *hu, const void *data, int len)
+{
+	struct wilc_data *wdata = hu->priv;
+	int err;
+
+	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
+		return -EUNATCH;
+	wdata->rx_skb = h4_recv_buf(hu->hdev, wdata->rx_skb, data, len,
+				    wilc_bt_recv_pkts,
+				    ARRAY_SIZE(wilc_bt_recv_pkts));
+	if (IS_ERR(wdata->rx_skb)) {
+		err = PTR_ERR(wdata->rx_skb);
+		bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err);
+		wdata->rx_skb = NULL;
+	}
+
+	return len;
+}
+
+static int wilc_enqueue(struct hci_uart *hu, struct sk_buff *skb)
+{
+	struct wilc_data *wdata = hu->priv;
+
+	BT_DBG("hci_wilc: enqueue skb %pK", skb);
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+	skb_queue_tail(&wdata->txq, skb);
+	return 0;
+}
+
+static struct sk_buff *wilc_dequeue(struct hci_uart *hu)
+{
+	struct wilc_data *wdata = hu->priv;
+
+	BT_DBG("hci_wilc: dequeue skb");
+	return skb_dequeue(&wdata->txq);
+}
+
+static int _set_uart_settings(struct hci_uart *hu, unsigned int speed,
+			      bool flow_control)
+{
+	struct hci_update_uart_param param;
+	int ret;
+
+	param.baudrate = cpu_to_le32(speed);
+	param.flow_control = flow_control ? 1 : 0;
+	ret = __hci_cmd_sync_status(hu->hdev, HCI_VENDOR_CMD_UPDATE_UART,
+				    sizeof(param), &param, HCI_CMD_TIMEOUT);
+	if (ret) {
+		BT_ERR("Failed to update UART settings");
+		return ret;
+	}
+
+	serdev_device_set_baudrate(hu->serdev, speed);
+	serdev_device_set_flow_control(hu->serdev, flow_control);
+
+	return 0;
+}
+
+static int wilc_set_baudrate(struct hci_uart *hu, unsigned int speed)
+{
+	struct wilc_adapter *wilc_adapter;
+
+	BT_INFO("WILC uart settings update request: speed=%d", speed);
+	wilc_adapter = serdev_device_get_drvdata(hu->serdev);
+
+	return _set_uart_settings(hu, speed, wilc_adapter->flow_control);
+}
+
+static int check_firmware_running(struct hci_uart *hu)
+{
+	struct hci_rp_read_local_version *version;
+	struct sk_buff *skb;
+	int ret = 0;
+
+	BT_DBG("Resetting bluetooth chip");
+	ret = __hci_cmd_sync_status(hu->hdev, HCI_OP_RESET, 0, NULL,
+				    HCI_CMD_TIMEOUT);
+	if (ret) {
+		BT_ERR("Can not reset wilc");
+		return ret;
+	}
+
+	BT_DBG("Checking chip state");
+	skb = __hci_cmd_sync(hu->hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL,
+			     HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		BT_ERR("Error while checking bootrom");
+		return PTR_ERR(skb);
+	}
+
+	if (skb->len != sizeof(struct hci_rp_read_local_version)) {
+		BT_ERR("Can not read local version");
+		return -1;
+	}
+	version = (struct hci_rp_read_local_version *)skb->data;
+	BT_DBG("Status: 0x%1X, HCI version: 0x%1X", version->status,
+	       version->hci_ver);
+	kfree_skb(skb);
+	if (version->hci_ver != HCI_VERSION_FIRMWARE) {
+		BT_ERR("Bluetooth firmware is not running !");
+		if (version->hci_ver == HCI_VERSION_BOOTROM)
+			BT_WARN("Bootrom is running");
+		return 1;
+	}
+	BT_DBG("Firmware is running");
+	return 0;
+}
+
+static int wilc_setup(struct hci_uart *hu)
+{
+	struct wilc_adapter *wilc_adapter;
+	int ret;
+
+	BT_DBG("hci_wilc: setup");
+	serdev_device_set_baudrate(hu->serdev, WILC_UART_DEFAULT_BAUDRATE);
+	serdev_device_set_flow_control(hu->serdev, false);
+	ret = check_firmware_running(hu);
+	if (ret)
+		return ret;
+
+	BT_DBG("Updating firmware uart settings");
+
+	wilc_adapter = serdev_device_get_drvdata(hu->serdev);
+	ret = _set_uart_settings(&wilc_adapter->hu, WILC_UART_BAUDRATE, true);
+	if (ret) {
+		BT_ERR("Failed to reconfigure firmware uart settings");
+		return ret;
+	}
+	wilc_adapter->flow_control = true;
+
+	BT_INFO("Wilc successfully initialized");
+	return ret;
+}
+
+static const struct hci_uart_proto wilc_bt_proto = {
+	.id = HCI_UART_WILC,
+	.name = "Microchip",
+	.manufacturer = WILC_BT_UART_MANUFACTURER,
+	.init_speed = WILC_UART_DEFAULT_BAUDRATE,
+	.open = wilc_open,
+	.close = wilc_close,
+	.flush = wilc_flush,
+	.recv = wilc_recv,
+	.enqueue = wilc_enqueue,
+	.dequeue = wilc_dequeue,
+	.setup = wilc_setup,
+	.set_baudrate = wilc_set_baudrate,
+};
+
+static int wilc_bt_serdev_probe(struct serdev_device *serdev)
+{
+	struct wilc_adapter *wilc_adapter;
+	struct device_node *wlan_node;
+	void *wlan = NULL;
+	int ret;
+
+	wilc_adapter = kzalloc(sizeof(*wilc_adapter), GFP_KERNEL);
+	if (!wilc_adapter)
+		return -ENOMEM;
+
+	wlan_node = of_parse_phandle(serdev->dev.of_node, "wlan", 0);
+	if (!wlan_node) {
+		BT_ERR("Can not run wilc bluetooth without wlan node");
+		ret = -EINVAL;
+		goto exit_free_adapter;
+	}
+
+#if IS_ENABLED(CONFIG_WILC1000_SDIO)
+	wlan = wilc_sdio_get_byphandle(wlan_node);
+#endif
+#if IS_ENABLED(CONFIG_WILC1000_SPI)
+	if (!wlan || wlan == ERR_PTR(-EPROBE_DEFER))
+		wlan = wilc_spi_get_byphandle(wlan_node);
+#endif
+	if (IS_ERR(wlan)) {
+		pr_warn("Can not initialize bluetooth: %pe\n", wlan);
+		ret = PTR_ERR(wlan);
+		goto exit_put_wlan_node;
+	}
+
+	of_node_put(wlan_node);
+	wilc_adapter->wlan_priv = wlan;
+	ret = wilc_bt_init(wlan);
+	if (ret) {
+		pr_err("Failed to initialize bluetooth firmware (%d)\n", ret);
+		goto exit_put_wlan;
+	}
+
+	wilc_adapter->dev = &serdev->dev;
+	wilc_adapter->hu.serdev = serdev;
+	wilc_adapter->flow_control = false;
+	serdev_device_set_drvdata(serdev, wilc_adapter);
+	ret = hci_uart_register_device(&wilc_adapter->hu, &wilc_bt_proto);
+	if (ret) {
+		dev_err(&serdev->dev, "Failed to register hci device");
+		goto exit_deinit_bt;
+	}
+
+	dev_info(&serdev->dev, "WILC hci interface registered");
+	return 0;
+
+exit_deinit_bt:
+	wilc_bt_shutdown(wlan);
+exit_put_wlan:
+	wilc_put(wlan);
+exit_put_wlan_node:
+	of_node_put(wlan_node);
+exit_free_adapter:
+	kfree(wilc_adapter);
+	return ret;
+}
+
+static void wilc_bt_serdev_remove(struct serdev_device *serdev)
+{
+	struct wilc_adapter *wilc_adapter = serdev_device_get_drvdata(serdev);
+
+	hci_uart_unregister_device(&wilc_adapter->hu);
+	wilc_bt_shutdown(wilc_adapter->wlan_priv);
+	wilc_put(wilc_adapter->wlan_priv);
+	kfree(wilc_adapter);
+}
+
+static const struct of_device_id wilc_bt_of_match[] = {
+	{ .compatible = "microchip,wilc3000-bt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, wilc_bt_of_match);
+
+static struct serdev_device_driver wilc_bt_serdev_driver = {
+	.probe = wilc_bt_serdev_probe,
+	.remove = wilc_bt_serdev_remove,
+	.driver = {
+		.name = "hci_uart_wilc",
+		.of_match_table = of_match_ptr(wilc_bt_of_match),
+	},
+};
+
+module_serdev_device_driver(wilc_bt_serdev_driver)
+MODULE_AUTHOR("Alexis Lothoré <alexis.lothore@bootlin.com>");
+MODULE_DESCRIPTION("Bluetooth HCI Uart for WILC devices");
+MODULE_LICENSE("GPL");

-- 
2.48.0


