Return-Path: <linux-wireless+bounces-18859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAA8A32B44
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 17:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D9C3A0461
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E803211A3F;
	Wed, 12 Feb 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/U/60uu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAD31B21AD;
	Wed, 12 Feb 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376890; cv=none; b=O2Rt+eN1eO82GRL9TKirR5ms762sCC9lGqEN8wknGULNH6KVSoPXq1sWWSXCFcoDK1Q7+Ukg32NJsjMJjmDKe3qMsKLpB9fkGB07wemxfCIKkhdxwSfxpfEAVpvkFL84q2W+5qI+WpANXP/lel1DhZxfsdjdh0i+Fha/NXgRG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376890; c=relaxed/simple;
	bh=btGvlzDoVP43k1lVPO2qIhQKcYm40/CLrnPFelU/6+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/6C8u2lLdj2EWTD8XWaXxc6hoxgrxCHH2lsLoNLgG4z/Kyg+v4ktfDiBD0dq4bgzdN23L2Kk7r+uiUM3L131w8B/+rxM0OXv/V/vII4c77rrNsQHU0PhRdFH0HAJ11y+PiL55P7wMuGnN8odboLypBe9F7uEoxrUeYjElSi+zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/U/60uu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a6bso73204781fa.1;
        Wed, 12 Feb 2025 08:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739376886; x=1739981686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg81HwGRmnHOrsstHmxHb9Uh9Otvf04MW1ejbsRPRL8=;
        b=k/U/60uuLJ1jEHlIpwCzRIvetK9c4GJE5gb+oc73IFdsG4mqrUIY27tChj+xbId897
         kOAcNEVgM+6qO61Pe64NqoaMjJmBMYOyLGJlGRoutTocDbUFjikLNrw5fBFWNf6oKOHN
         hxc0zscot2WERTq9s+xHTXovD+ggHqYAVrOhzjmSFJizeG8Kl3ZwRPdJyendbATkmTT5
         mV735OHrW9M2SaV9NRweirnGDT+5jpK7/1aIfz/RB75BrfF6KgNvIiYmWXC+UePWGGPl
         UatTca1fiJ8OQMMjFsiNMrQPFR7i0492ptNJ9LcSMrLDi7znbLxNQ15Cf8ZCAnrO27jZ
         fiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739376886; x=1739981686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cg81HwGRmnHOrsstHmxHb9Uh9Otvf04MW1ejbsRPRL8=;
        b=W1guDGh8w+aPv+jwhzyf69pAdt/c2i6T4Z7s7pK3SivRlKe5Q5AhF5OFTa0zFoZGt+
         GXNP4oueocywXSkzjKhc5ytjcvqOTQN+0B2Lu+jtCACmjFKtPcqWkz8x3YL4bJ9QhGrD
         ytKDvUXnRCsLQOiK2hK1jImVIkP9dqsmc/rCjD68dnlW0K9HessuQU7C1TZAvGgVAVv6
         VC9ZIMqvpn9J3PvFbqTsasWwWT/0dq6F/uKdRcE3eXpub/4H5VMifIb/XFbgOeIReME8
         b5ZFylpbYqf4YhiLpONITbp6IsC5RwMJHnN+kOtoUBzeI2kJ436dtIY2BtDA+GZ+lCsx
         qc/w==
X-Forwarded-Encrypted: i=1; AJvYcCV/RARscTwp4lFGbLdiiLlo/8ZO05TzPxwCYQdZ2NOrHw5NPnZZQfr4A9lBgiFeUMi6894t2R7N2RX5pMq6liRb@vger.kernel.org, AJvYcCWLANLf8hdlbtl5jGIiFU41iVPU3aZRwYwSepfger9RiH3j6AJ9/vXt3tWNWLemYuj6g4+9nMU6/9bH@vger.kernel.org, AJvYcCWrIstmzzrmo1RzV1rP+ZSpI2J2mzd28p622mRngLANooyXKW9AIM335n/Rn75GOatWRzjhKKV1izySiPzK@vger.kernel.org, AJvYcCXFXgHpwQY43RxLJbQD1eaPDfN8CHk0V6fFY92KLml8F6s3kdr2wvPk+PGMSPFaGsBzuJzKf8LA@vger.kernel.org, AJvYcCXj6N1J27G4EzK0tLySVoKrlgiDPp34UOFu3Uxl5sKIdq/Fiu0TJTFy9MfIza5JMzf+2Ih6C9IVHJ3W6N0ZbG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBEIyOdE6Rjub+7Hx5yfewqMmwQTHOblsoVIUNIN3SkF1dWmg
	NnwUiXRk0KeQU9LVhCSiGL6hPNYqgiUICuex7BhhENIppF9tVz8K8d08PGx5vA0JvFC005xXx+i
	aWr4kcdQ1t9+C6z+UhISXcvHdVMo=
X-Gm-Gg: ASbGnctToD0LDN8w7ErV+hgSFcPW5u99aMYQDnDUZc5zqrW6zJhYSyhK7qwjpRlnnmN
	azT/ZKjqtbiIz33WVyp5/DsFzRqnRJawPUrStgxK+JQrpK27vudNPZOawRfGAfvzcRUNY7TM=
X-Google-Smtp-Source: AGHT+IFzcXZ2y1bvLhtShvmuG64ySfT9qreogJPuktKBQCBIJGK2z/azYSqpF1eYTU95PL49IZA7Kdo5ZoU4QEEHd+k=
X-Received: by 2002:a2e:b8c8:0:b0:308:eb58:6581 with SMTP id
 38308e7fff4ca-3090db7dbb2mr625091fa.0.1739376885722; Wed, 12 Feb 2025
 08:14:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com> <20250212-wilc3000_bt-v1-10-9609b784874e@bootlin.com>
In-Reply-To: <20250212-wilc3000_bt-v1-10-9609b784874e@bootlin.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 12 Feb 2025 11:14:33 -0500
X-Gm-Features: AWEUYZnnXHAkKfJ9el5JiTPtK7GZJfZ26dfDheHM-Ilv5iz407jOwzYJ-fOIWZY
Message-ID: <CABBYNZJ5XDasAfVxcFU+K=ru2PpZJVXkRuf_kokv1z66KF=Xaw@mail.gmail.com>
Subject: Re: [PATCH 10/12] bluetooth: hci_wilc: add wilc hci driver
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajay Singh <ajay.kathat@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Kalle Valo <kvalo@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Marek Vasut <marex@denx.de>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alexis,

On Wed, Feb 12, 2025 at 10:47=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> WILC3000 is a combo chip providing 802.11b/g/n and Bluetooth 5.0
> capabilities. The wifi side is used either over SDIO or SPI, and the
> bluetooth side is used over uart, with standard hci. The wifi side is
> already supported by Linux.
>
> Add a dedicated bluetooth driver to support the bluetooth feature from
> wilc3000 chip. Similarly to other supported bluetooth chips, wilc
> devices need a firmware to be uploaded before being able to use
> bluetooth. However, the major difference is that the firmware needs to
> be uploaded through the wifi bus (SDIO or SPI). This constraint makes
> this new driver depends on the corresponding wilc wlan driver for the
> bluetooth setup. Once the basic BT initialization has been performed,
> both side can be used independently, and in parallel.
>
> Since this creates a dependency to some wlan driver, create a dedicated
> module (hci_wilc) rather than integrating wilc bluetooth support in
> hci_uart, to avoid propagating this dependency.
>
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> ---
>  drivers/bluetooth/Kconfig    |  13 ++
>  drivers/bluetooth/Makefile   |   3 +-
>  drivers/bluetooth/hci_uart.h |   1 +
>  drivers/bluetooth/hci_wilc.c | 333 +++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 349 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 4ab32abf0f48644715d4c27ec0d2fdaccef62b76..a96607fb0cc8fed2ccb1811a4=
b1b4fe586396b07 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -147,6 +147,19 @@ config BT_HCIUART_NOKIA
>
>           Say Y here to compile support for Nokia's H4+ protocol.
>
> +config BT_HCIUART_WILC
> +       tristate "WILC protocol support"
> +       depends on (WILC1000_SDIO || WILC1000_SPI)
> +       select WILC_BT
> +       depends on BT_HCIUART
> +       depends on BT_HCIUART_SERDEV
> +       select BT_HCIUART_H4
> +       help
> +         The WILC uart protocol allows interacting with wilc3000 chips
> +         with HCI over UART. The bluetooth firmware needs to be uploaded
> +         to the chip through the main bus, so this driver needs the
> +         corresponding wlan driver.
> +
>  config BT_HCIUART_BCSP
>         bool "BCSP protocol support"
>         depends on BT_HCIUART
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index 81856512ddd030ba8172ff106b80b4b951188cbd..a1e69884acf4ce91f02ff5592=
541616048b07e31 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -35,10 +35,11 @@ obj-$(CONFIG_BT_NXPUART)    +=3D btnxpuart.o
>  obj-$(CONFIG_BT_HCIUART_NOKIA) +=3D hci_nokia.o
>
>  obj-$(CONFIG_BT_HCIRSI)                +=3D btrsi.o
> -
>  btmrvl-y                       :=3D btmrvl_main.o
>  btmrvl-$(CONFIG_DEBUG_FS)      +=3D btmrvl_debugfs.o
>
> +obj-$(CONFIG_BT_HCIUART_WILC)  +=3D hci_wilc.o
> +
>  hci_uart-y                             :=3D hci_ldisc.o
>  hci_uart-$(CONFIG_BT_HCIUART_SERDEV)   +=3D hci_serdev.o
>  hci_uart-$(CONFIG_BT_HCIUART_H4)       +=3D hci_h4.o
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index fbf3079b92a5339154f8847ff36b3c08ef49e2bb..83fc48be4335e0946853fdec3=
2c38bf2fb195009 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -35,6 +35,7 @@
>  #define HCI_UART_NOKIA 10
>  #define HCI_UART_MRVL  11
>  #define HCI_UART_AML   12
> +#define HCI_UART_WILC  13
>
>  #define HCI_UART_RAW_DEVICE    0
>  #define HCI_UART_RESET_ON_INIT 1
> diff --git a/drivers/bluetooth/hci_wilc.c b/drivers/bluetooth/hci_wilc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..97dc4620c74ef0733469839ad=
da7890bda90406e
> --- /dev/null
> +++ b/drivers/bluetooth/hci_wilc.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Bluetooth HCI UART driver for WILC devices
> + *
> + */
> +#include "linux/bitops.h"
> +#include "linux/byteorder/generic.h"
> +#include "linux/err.h"
> +#include "linux/gfp_types.h"
> +#include "net/bluetooth/bluetooth.h"
> +#include "net/bluetooth/hci.h"
> +#include <linux/module.h>
> +#include <linux/firmware.h>
> +#include <linux/of.h>
> +#include <linux/serdev.h>
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +#include <net/wilc.h>
> +
> +#include "hci_uart.h"
> +
> +#define WILC_BT_UART_MANUFACTURER      205
> +#define WILC_UART_DEFAULT_BAUDRATE     115200
> +#define WILC_UART_BAUDRATE             460800
> +
> +#define HCI_VERSION_BOOTROM    0xFF
> +#define HCI_VERSION_FIRMWARE   0x06
> +
> +#define HCI_VENDOR_CMD_WRITE_MEM       0xFC52
> +#define HCI_VENDOR_CMD_UPDATE_UART     0xFC53
> +#define HCI_VENDOR_CMD_UPDATE_ADDR     0xFC54
> +#define HCI_VENDOR_CMD_RESET           0xFC55
> +#define HCI_VENDOR_CMD_READ_REG                0xFC01
> +
> +struct wilc_adapter {
> +       struct hci_uart hu;
> +       struct device *dev;
> +       void *wlan_priv;
> +       bool flow_control;
> +};
> +
> +struct wilc_data {
> +       struct sk_buff *rx_skb;
> +       struct sk_buff_head txq;
> +};
> +
> +struct hci_update_uart_param {
> +       __le32 baudrate;
> +       __u8 flow_control;
> +} __packed;
> +
> +static int wilc_open(struct hci_uart *hu)
> +{
> +       struct wilc_data *wdata;
> +
> +       BT_DBG("hci_wilc: open");

Afaik you don't need to include the function name with the likes of
pr_debug/BT_DBG, that said you should really be using bt_dev_dbg if
you have hu->hdev set at this point, and this is valid for all other
places where BT_DBG could be replaced with bt_dev_dbg.

> +       wdata =3D kzalloc(sizeof(*wdata), GFP_KERNEL);
> +       if (!wdata)
> +               return -ENOMEM;

Add an empty after something like an if statement to make it clearer
that it is not under the same scope.

> +       skb_queue_head_init(&wdata->txq);
> +       hu->priv =3D wdata;
> +
> +       return 0;
> +}
> +
> +static int wilc_close(struct hci_uart *hu)
> +{
> +       struct wilc_data *wdata =3D hu->priv;
> +
> +       BT_DBG("hci_wilc: close");
> +       skb_queue_purge(&wdata->txq);
> +       kfree_skb(wdata->rx_skb);
> +       kfree(wdata);
> +       hu->priv =3D NULL;
> +       return 0;
> +}
> +
> +static int wilc_flush(struct hci_uart *hu)
> +{
> +       struct wilc_data *wdata =3D hu->priv;
> +
> +       BT_DBG("hci_wilc: flush");
> +       skb_queue_purge(&wdata->txq);
> +       return 0;
> +}
> +
> +static const struct h4_recv_pkt wilc_bt_recv_pkts[] =3D {
> +       { H4_RECV_ACL, .recv =3D hci_recv_frame },
> +       { H4_RECV_SCO, .recv =3D hci_recv_frame },
> +       { H4_RECV_EVENT, .recv =3D hci_recv_frame },
> +};
> +
> +static int wilc_recv(struct hci_uart *hu, const void *data, int len)
> +{
> +       struct wilc_data *wdata =3D hu->priv;
> +       int err;
> +
> +       if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
> +               return -EUNATCH;

Ditto, add empty line

> +       wdata->rx_skb =3D h4_recv_buf(hu->hdev, wdata->rx_skb, data, len,
> +                                   wilc_bt_recv_pkts,
> +                                   ARRAY_SIZE(wilc_bt_recv_pkts));
> +       if (IS_ERR(wdata->rx_skb)) {
> +               err =3D PTR_ERR(wdata->rx_skb);
> +               bt_dev_err(hu->hdev, "Frame reassembly failed (%d)", err)=
;
> +               wdata->rx_skb =3D NULL;
> +       }
> +
> +       return len;
> +}
> +
> +static int wilc_enqueue(struct hci_uart *hu, struct sk_buff *skb)
> +{
> +       struct wilc_data *wdata =3D hu->priv;
> +
> +       BT_DBG("hci_wilc: enqueue skb %pK", skb);
> +       memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
> +       skb_queue_tail(&wdata->txq, skb);
> +       return 0;
> +}
> +
> +static struct sk_buff *wilc_dequeue(struct hci_uart *hu)
> +{
> +       struct wilc_data *wdata =3D hu->priv;
> +
> +       BT_DBG("hci_wilc: dequeue skb");
> +       return skb_dequeue(&wdata->txq);
> +}
> +
> +static int _set_uart_settings(struct hci_uart *hu, unsigned int speed,
> +                             bool flow_control)
> +{
> +       struct hci_update_uart_param param;
> +       int ret;
> +
> +       param.baudrate =3D cpu_to_le32(speed);
> +       param.flow_control =3D flow_control ? 1 : 0;
> +       ret =3D __hci_cmd_sync_status(hu->hdev, HCI_VENDOR_CMD_UPDATE_UAR=
T,
> +                                   sizeof(param), &param, HCI_CMD_TIMEOU=
T);
> +       if (ret) {
> +               BT_ERR("Failed to update UART settings");
> +               return ret;
> +       }
> +
> +       serdev_device_set_baudrate(hu->serdev, speed);
> +       serdev_device_set_flow_control(hu->serdev, flow_control);
> +
> +       return 0;
> +}
> +
> +static int wilc_set_baudrate(struct hci_uart *hu, unsigned int speed)
> +{
> +       struct wilc_adapter *wilc_adapter;
> +
> +       BT_INFO("WILC uart settings update request: speed=3D%d", speed);
> +       wilc_adapter =3D serdev_device_get_drvdata(hu->serdev);
> +
> +       return _set_uart_settings(hu, speed, wilc_adapter->flow_control);
> +}
> +
> +static int check_firmware_running(struct hci_uart *hu)
> +{
> +       struct hci_rp_read_local_version *version;
> +       struct sk_buff *skb;
> +       int ret =3D 0;
> +
> +       BT_DBG("Resetting bluetooth chip");
> +       ret =3D __hci_cmd_sync_status(hu->hdev, HCI_OP_RESET, 0, NULL,
> +                                   HCI_CMD_TIMEOUT);
> +       if (ret) {
> +               BT_ERR("Can not reset wilc");
> +               return ret;
> +       }
> +
> +       BT_DBG("Checking chip state");
> +       skb =3D __hci_cmd_sync(hu->hdev, HCI_OP_READ_LOCAL_VERSION, 0, NU=
LL,
> +                            HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               BT_ERR("Error while checking bootrom");
> +               return PTR_ERR(skb);
> +       }
> +
> +       if (skb->len !=3D sizeof(struct hci_rp_read_local_version)) {
> +               BT_ERR("Can not read local version");
> +               return -1;
> +       }

Ditto, add an empty line.

> +       version =3D (struct hci_rp_read_local_version *)skb->data;
> +       BT_DBG("Status: 0x%1X, HCI version: 0x%1X", version->status,
> +              version->hci_ver);
> +       kfree_skb(skb);
> +       if (version->hci_ver !=3D HCI_VERSION_FIRMWARE) {
> +               BT_ERR("Bluetooth firmware is not running !");
> +               if (version->hci_ver =3D=3D HCI_VERSION_BOOTROM)
> +                       BT_WARN("Bootrom is running");
> +               return 1;
> +       }

Ditto

> +       BT_DBG("Firmware is running");
> +       return 0;
> +}
> +
> +static int wilc_setup(struct hci_uart *hu)
> +{
> +       struct wilc_adapter *wilc_adapter;
> +       int ret;
> +
> +       BT_DBG("hci_wilc: setup");
> +       serdev_device_set_baudrate(hu->serdev, WILC_UART_DEFAULT_BAUDRATE=
);
> +       serdev_device_set_flow_control(hu->serdev, false);
> +       ret =3D check_firmware_running(hu);
> +       if (ret)
> +               return ret;
> +
> +       BT_DBG("Updating firmware uart settings");
> +
> +       wilc_adapter =3D serdev_device_get_drvdata(hu->serdev);
> +       ret =3D _set_uart_settings(&wilc_adapter->hu, WILC_UART_BAUDRATE,=
 true);
> +       if (ret) {
> +               BT_ERR("Failed to reconfigure firmware uart settings");
> +               return ret;
> +       }

Ditto

> +       wilc_adapter->flow_control =3D true;
> +
> +       BT_INFO("Wilc successfully initialized");
> +       return ret;
> +}
> +
> +static const struct hci_uart_proto wilc_bt_proto =3D {
> +       .id =3D HCI_UART_WILC,
> +       .name =3D "Microchip",
> +       .manufacturer =3D WILC_BT_UART_MANUFACTURER,
> +       .init_speed =3D WILC_UART_DEFAULT_BAUDRATE,
> +       .open =3D wilc_open,
> +       .close =3D wilc_close,
> +       .flush =3D wilc_flush,
> +       .recv =3D wilc_recv,
> +       .enqueue =3D wilc_enqueue,
> +       .dequeue =3D wilc_dequeue,
> +       .setup =3D wilc_setup,
> +       .set_baudrate =3D wilc_set_baudrate,
> +};
> +
> +static int wilc_bt_serdev_probe(struct serdev_device *serdev)
> +{
> +       struct wilc_adapter *wilc_adapter;
> +       struct device_node *wlan_node;
> +       void *wlan =3D NULL;
> +       int ret;
> +
> +       wilc_adapter =3D kzalloc(sizeof(*wilc_adapter), GFP_KERNEL);
> +       if (!wilc_adapter)
> +               return -ENOMEM;
> +
> +       wlan_node =3D of_parse_phandle(serdev->dev.of_node, "wlan", 0);
> +       if (!wlan_node) {
> +               BT_ERR("Can not run wilc bluetooth without wlan node");
> +               ret =3D -EINVAL;
> +               goto exit_free_adapter;
> +       }
> +
> +#if IS_ENABLED(CONFIG_WILC1000_SDIO)
> +       wlan =3D wilc_sdio_get_byphandle(wlan_node);
> +#endif
> +#if IS_ENABLED(CONFIG_WILC1000_SPI)
> +       if (!wlan || wlan =3D=3D ERR_PTR(-EPROBE_DEFER))
> +               wlan =3D wilc_spi_get_byphandle(wlan_node);
> +#endif
> +       if (IS_ERR(wlan)) {
> +               pr_warn("Can not initialize bluetooth: %pe\n", wlan);
> +               ret =3D PTR_ERR(wlan);
> +               goto exit_put_wlan_node;
> +       }
> +
> +       of_node_put(wlan_node);
> +       wilc_adapter->wlan_priv =3D wlan;
> +       ret =3D wilc_bt_init(wlan);
> +       if (ret) {
> +               pr_err("Failed to initialize bluetooth firmware (%d)\n", =
ret);
> +               goto exit_put_wlan;
> +       }
> +
> +       wilc_adapter->dev =3D &serdev->dev;
> +       wilc_adapter->hu.serdev =3D serdev;
> +       wilc_adapter->flow_control =3D false;
> +       serdev_device_set_drvdata(serdev, wilc_adapter);
> +       ret =3D hci_uart_register_device(&wilc_adapter->hu, &wilc_bt_prot=
o);
> +       if (ret) {
> +               dev_err(&serdev->dev, "Failed to register hci device");
> +               goto exit_deinit_bt;
> +       }
> +
> +       dev_info(&serdev->dev, "WILC hci interface registered");
> +       return 0;
> +
> +exit_deinit_bt:
> +       wilc_bt_shutdown(wlan);
> +exit_put_wlan:
> +       wilc_put(wlan);
> +exit_put_wlan_node:
> +       of_node_put(wlan_node);
> +exit_free_adapter:
> +       kfree(wilc_adapter);
> +       return ret;
> +}
> +
> +static void wilc_bt_serdev_remove(struct serdev_device *serdev)
> +{
> +       struct wilc_adapter *wilc_adapter =3D serdev_device_get_drvdata(s=
erdev);
> +
> +       hci_uart_unregister_device(&wilc_adapter->hu);
> +       wilc_bt_shutdown(wilc_adapter->wlan_priv);
> +       wilc_put(wilc_adapter->wlan_priv);
> +       kfree(wilc_adapter);
> +}
> +
> +static const struct of_device_id wilc_bt_of_match[] =3D {
> +       { .compatible =3D "microchip,wilc3000-bt" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, wilc_bt_of_match);
> +
> +static struct serdev_device_driver wilc_bt_serdev_driver =3D {
> +       .probe =3D wilc_bt_serdev_probe,
> +       .remove =3D wilc_bt_serdev_remove,
> +       .driver =3D {
> +               .name =3D "hci_uart_wilc",
> +               .of_match_table =3D of_match_ptr(wilc_bt_of_match),
> +       },
> +};
> +
> +module_serdev_device_driver(wilc_bt_serdev_driver)
> +MODULE_AUTHOR("Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>");
> +MODULE_DESCRIPTION("Bluetooth HCI Uart for WILC devices");
> +MODULE_LICENSE("GPL");
>
> --
> 2.48.0

Once you address these comments please fill free to add:

Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--=20
Luiz Augusto von Dentz

