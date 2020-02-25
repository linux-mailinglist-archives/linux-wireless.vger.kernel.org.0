Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E375F16BAED
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgBYHlT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:19 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53458 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729555AbgBYHlS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:18 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: /YlwkCDK0EG67Lj4nbx0AP41KOKoPx+S1afXjW9fiDZ0F8KnJoaQb4AfKuopjVPEXsa8zOIgPD
 0vOE10K5PskMHZzrPtULvFxNZdhWXCdlTG4jhrk5iq/O3L9qOx0zA9QLKFPsrIUBOYK85zDJYR
 71ijhbW0XscAbp0hNMFzkT0UNbfxeqG9fXJU7CfmJvA0Aaswstjos+bXSVD2XDrGop1XLpVfrr
 a2yOzXidGgTKtF5fQT39CasSGAhJufrCdmKn6GeeZW9wg1H2fxuOpc9qSxegnR0tVA2fXoMjFh
 QuQ=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="66951691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:17 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Feb 2020 00:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQ5ooHQ8SvYmsNO0+N7lRk9VetzE0exgVRy/yxcu78ikdsBkd3XHK9ky3ul19MlCdUGU1TFLIa18wWYkbCiML+Y7iWrxi34392l3n9kh5tPRSvFH07o6UYixKA59jekS+WqR+H4q/ztzRocHrldZdem017id4qxJYBdJft8MFz++2e9AWmKlmJmSYg104R+6p4Zjw/9PK+oGX278FD6FbvSAsmCHM16C0ukITaBd+HVV8FwWlfrgu29PIctSh5os5eHinF6TOCFoJU8Ft3OP40ECZSdhEu1VVvcP1nrADbifubOAkhRz9eh1Ne9lWMdmjRt8EemVL/8JDoufJcvoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWOZQLEY5AAAzouBsF66xc/ggL010p4I3bUu6iAmfW8=;
 b=BvmYVxBxJnPtBx8bYDjGP1Rmggi9C5Tn/lRQqRhKxYqnQpyy2aWH/RZk8yVjMLmQ4BbTmtcLSnLUwm7zPJcEr4FeKNZgXWch5+sOPWJndcuPrArTm5mNJRprYeQV2JUwkMhKpOJWu83S2999EuK1AybrFxYstAqX2rbzFjX0HMqPhmjtpkJ3rob64e/jhygFLywham2/x48poN2FjLfXMnB0pCmesGrR1yD6v/VDaT2BMjeLJ1e7NdlxP0xq7GJBAErgvTVzKQOqZukxC/Z7NEWvgudSMP5WjUJ8Jl/mXvpcx87QdpypsKkJU1gKKjAOPitb6w917lszAkK3zLLgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWOZQLEY5AAAzouBsF66xc/ggL010p4I3bUu6iAmfW8=;
 b=mOQv97pmlGSA2EYlvwMR/rUSJrJeMjTRJrahY+k/kjfbcfuCUenzfrqkUjU6zAhQTVW429pczoeKMfDmH51iy/pWCaj4Vti4Ds/JQDRnLRgPWgAY1K7btkmEjSnbOlSvAAkk1mxfLfgNXkuSYNVkmhGa9xFVpo58t6XYFFvRBH0=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1875.namprd11.prod.outlook.com (2603:10b6:404:104::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Tue, 25 Feb
 2020 07:41:15 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:15 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 08/18] wilc1000: add netdev.h
Thread-Topic: [PATCH v3 08/18] wilc1000: add netdev.h
Thread-Index: AQHV6671d3NnDmHPRUyAVYL4U6arCg==
Date:   Tue, 25 Feb 2020 07:41:14 +0000
Message-ID: <20200225074105.7740-9-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403b5451-f6bf-4909-61e1-08d7b9c617e0
x-ms-traffictypediagnostic: BN6PR11MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1875FAF3F4EFE3B6A3379FF9E3ED0@BN6PR11MB1875.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(366004)(346002)(199004)(189003)(2906002)(316002)(2616005)(54906003)(86362001)(1076003)(66556008)(76116006)(66476007)(66946007)(91956017)(64756008)(36756003)(66446008)(186003)(8936002)(26005)(81156014)(478600001)(6512007)(5660300002)(71200400001)(4326008)(81166006)(107886003)(6916009)(8676002)(6506007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1875;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgUyP8C+SHER45OD0AM/GNWp5esT2p82G6oSoaNq9hr4eY2a8xVTS96awdqdrOxXUaNVQOdyBYnjhAxC58Tk9xpXcMGHIPehwNa4fLsgR8Jzv2qIAgD8bGt2YJ8V4iJhwRJ0MoFk0h/CuxI88hWWe6M1yfyYhnrBPmlSP3e+Jbj3RwFfskDjScpJOOYnqXtVE4SthUeY3f/cfC3Ok6OEuAHvgKUwM5pZ3wNXG9LXNR2pEvwBtnicFKKDO12aieKXtbjwlzWOBb4f7sw9udE0/Xryn2+mte9yPmSutXmtjCJDLJx7VDEcy/kQj5Qr6hiHqUF+Kr0iFh4q1Gx38K/9OUDttdwQA1xFGDargFAhZ9Oru7id62mu/jJIAFxorM4SGWlGv4ouOF2/8ZpYn4HWjROmjXQx40+wccC38VCHpA4lL8SqmwQV6WKj3Vp3vzIo
x-ms-exchange-antispam-messagedata: piID+DpO0pITyIifQc91uOZgPFnEbduo3ACLf3ZGpHDHmkhSk3dbPQRhfShkAXHK95ffasJ14x6Dd6HwAgvAP8b4ffhVDMV+XfxW1tTGvpbWolYTCe3pMZEYojOdKqFBfVAEz8viCowRBW5HlAO99g==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 403b5451-f6bf-4909-61e1-08d7b9c617e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:15.0009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MWKjSjFw+a2FgpLn9FO11eFNVAwRm6ju/j1Ctr+bK2fQHEnvqcUrdWCrl6z0Mh69MUJXojxNWIktE2vllkiEjk0tNyxNsy1sfp09jKOWjJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1875
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/netdev.h' to
'drivers/net/wireless/microchip/wilc1000/netdev.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/netdev.h  | 295 ++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/netdev.h

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
new file mode 100644
index 000000000000..e3689e2a4abb
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -0,0 +1,295 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_NETDEV_H
+#define WILC_NETDEV_H
+
+#include <linux/tcp.h>
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <net/ieee80211_radiotap.h>
+#include <linux/if_arp.h>
+#include <linux/gpio/consumer.h>
+
+#include "hif.h"
+#include "wlan.h"
+#include "wlan_cfg.h"
+
+#define FLOW_CONTROL_LOWER_THRESHOLD		128
+#define FLOW_CONTROL_UPPER_THRESHOLD		256
+
+#define PMKID_FOUND				1
+#define NUM_STA_ASSOCIATED			8
+
+#define NUM_REG_FRAME				2
+
+#define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
+#define DEFAULT_LINK_SPEED			72
+
+struct wilc_wfi_stats {
+	unsigned long rx_packets;
+	unsigned long tx_packets;
+	unsigned long rx_bytes;
+	unsigned long tx_bytes;
+	u64 rx_time;
+	u64 tx_time;
+
+};
+
+struct wilc_wfi_key {
+	u8 *key;
+	u8 *seq;
+	int key_len;
+	int seq_len;
+	u32 cipher;
+};
+
+struct wilc_wfi_wep_key {
+	u8 *key;
+	u8 key_len;
+	u8 key_idx;
+};
+
+struct sta_info {
+	u8 sta_associated_bss[WILC_MAX_NUM_STA][ETH_ALEN];
+};
+
+/* Parameters needed for host interface for remaining on channel */
+struct wilc_wfi_p2p_listen_params {
+	struct ieee80211_channel *listen_ch;
+	u32 listen_duration;
+	u64 listen_cookie;
+};
+
+static const u32 wilc_cipher_suites[] =3D {
+	WLAN_CIPHER_SUITE_WEP40,
+	WLAN_CIPHER_SUITE_WEP104,
+	WLAN_CIPHER_SUITE_TKIP,
+	WLAN_CIPHER_SUITE_CCMP,
+	WLAN_CIPHER_SUITE_AES_CMAC
+};
+
+#define CHAN2G(_channel, _freq, _flags) {	 \
+	.band             =3D NL80211_BAND_2GHZ, \
+	.center_freq      =3D (_freq),		 \
+	.hw_value         =3D (_channel),		 \
+	.flags            =3D (_flags),		 \
+	.max_antenna_gain =3D 0,			 \
+	.max_power        =3D 30,			 \
+}
+
+static const struct ieee80211_channel wilc_2ghz_channels[] =3D {
+	CHAN2G(1,  2412, 0),
+	CHAN2G(2,  2417, 0),
+	CHAN2G(3,  2422, 0),
+	CHAN2G(4,  2427, 0),
+	CHAN2G(5,  2432, 0),
+	CHAN2G(6,  2437, 0),
+	CHAN2G(7,  2442, 0),
+	CHAN2G(8,  2447, 0),
+	CHAN2G(9,  2452, 0),
+	CHAN2G(10, 2457, 0),
+	CHAN2G(11, 2462, 0),
+	CHAN2G(12, 2467, 0),
+	CHAN2G(13, 2472, 0),
+	CHAN2G(14, 2484, 0)
+};
+
+#define RATETAB_ENT(_rate, _hw_value, _flags) {	\
+	.bitrate  =3D (_rate),			\
+	.hw_value =3D (_hw_value),		\
+	.flags    =3D (_flags),			\
+}
+
+static struct ieee80211_rate wilc_bitrates[] =3D {
+	RATETAB_ENT(10,  0,  0),
+	RATETAB_ENT(20,  1,  0),
+	RATETAB_ENT(55,  2,  0),
+	RATETAB_ENT(110, 3,  0),
+	RATETAB_ENT(60,  9,  0),
+	RATETAB_ENT(90,  6,  0),
+	RATETAB_ENT(120, 7,  0),
+	RATETAB_ENT(180, 8,  0),
+	RATETAB_ENT(240, 9,  0),
+	RATETAB_ENT(360, 10, 0),
+	RATETAB_ENT(480, 11, 0),
+	RATETAB_ENT(540, 12, 0)
+};
+
+struct wilc_priv {
+	struct wireless_dev wdev;
+	struct cfg80211_scan_request *scan_req;
+
+	struct wilc_wfi_p2p_listen_params remain_on_ch_params;
+	u64 tx_cookie;
+
+	bool cfg_scanning;
+
+	u8 associated_bss[ETH_ALEN];
+	struct sta_info assoc_stainfo;
+	struct sk_buff *skb;
+	struct net_device *dev;
+	struct host_if_drv *hif_drv;
+	struct wilc_pmkid_attr pmkid_list;
+	u8 wep_key[4][WLAN_KEY_LEN_WEP104];
+	u8 wep_key_len[4];
+
+	/* The real interface that the monitor is on */
+	struct net_device *real_ndev;
+	struct wilc_wfi_key *wilc_gtk[WILC_MAX_NUM_STA];
+	struct wilc_wfi_key *wilc_ptk[WILC_MAX_NUM_STA];
+	u8 wilc_groupkey;
+
+	/* mutexes */
+	struct mutex scan_req_lock;
+	bool p2p_listen_state;
+	int scanned_cnt;
+
+	u64 inc_roc_cookie;
+};
+
+struct frame_reg {
+	u16 type;
+	bool reg;
+};
+
+#define MAX_TCP_SESSION                25
+#define MAX_PENDING_ACKS               256
+
+struct ack_session_info {
+	u32 seq_num;
+	u32 bigger_ack_num;
+	u16 src_port;
+	u16 dst_port;
+	u16 status;
+};
+
+struct pending_acks {
+	u32 ack_num;
+	u32 session_index;
+	struct txq_entry_t  *txqe;
+};
+
+struct tcp_ack_filter {
+	struct ack_session_info ack_session_info[2 * MAX_TCP_SESSION];
+	struct pending_acks pending_acks[MAX_PENDING_ACKS];
+	u32 pending_base;
+	u32 tcp_session;
+	u32 pending_acks_idx;
+	bool enabled;
+};
+
+struct wilc_vif {
+	u8 idx;
+	u8 iftype;
+	int monitor_flag;
+	int mac_opened;
+	struct frame_reg frame_reg[NUM_REG_FRAME];
+	struct net_device_stats netstats;
+	struct wilc *wilc;
+	u8 bssid[ETH_ALEN];
+	struct host_if_drv *hif_drv;
+	struct net_device *ndev;
+	u8 mode;
+	struct timer_list during_ip_timer;
+	struct timer_list periodic_rssi;
+	struct rf_info periodic_stat;
+	struct tcp_ack_filter ack_filter;
+	bool connecting;
+	struct wilc_priv priv;
+	struct list_head list;
+	struct cfg80211_bss *bss;
+};
+
+struct wilc {
+	struct wiphy *wiphy;
+	const struct wilc_hif_func *hif_func;
+	int io_type;
+	s8 mac_status;
+	struct gpio_desc *gpio_irq;
+	struct clk *rtc_clk;
+	bool initialized;
+	int dev_irq_num;
+	int close;
+	u8 vif_num;
+	struct list_head vif_list;
+
+	/* protect vif list */
+	struct mutex vif_mutex;
+	struct srcu_struct srcu;
+	u8 open_ifcs;
+
+	/* protect head of transmit queue */
+	struct mutex txq_add_to_head_cs;
+
+	/* protect txq_entry_t transmit queue */
+	spinlock_t txq_spinlock;
+
+	/* protect rxq_entry_t receiver queue */
+	struct mutex rxq_cs;
+
+	/* lock to protect hif access */
+	struct mutex hif_cs;
+
+	struct completion cfg_event;
+	struct completion sync_event;
+	struct completion txq_event;
+	struct completion txq_thread_started;
+
+	struct task_struct *txq_thread;
+
+	int quit;
+
+	/* lock to protect issue of wid command to firmware */
+	struct mutex cfg_cmd_lock;
+	struct wilc_cfg_frame cfg_frame;
+	u32 cfg_frame_offset;
+	u8 cfg_seq_no;
+
+	u8 *rx_buffer;
+	u32 rx_buffer_offset;
+	u8 *tx_buffer;
+
+	struct txq_entry_t txq_head;
+	int txq_entries;
+
+	struct rxq_entry_t rxq_head;
+
+	const struct firmware *firmware;
+
+	struct device *dev;
+	bool suspend_event;
+
+	int clients_count;
+	struct workqueue_struct *hif_workqueue;
+	enum chip_ps_states chip_ps_state;
+	struct wilc_cfg cfg;
+	void *bus_data;
+	struct net_device *monitor_dev;
+
+	/* deinit lock */
+	struct mutex deinit_lock;
+	u8 sta_ch;
+	u8 op_ch;
+	struct ieee80211_channel channels[ARRAY_SIZE(wilc_2ghz_channels)];
+	struct ieee80211_rate bitrates[ARRAY_SIZE(wilc_bitrates)];
+	struct ieee80211_supported_band band;
+	u32 cipher_suites[ARRAY_SIZE(wilc_cipher_suites)];
+};
+
+struct wilc_wfi_mon_priv {
+	struct net_device *real_ndev;
+};
+
+void wilc_frmw_to_host(struct wilc *wilc, u8 *buff, u32 size, u32 pkt_offs=
et);
+void wilc_mac_indicate(struct wilc *wilc);
+void wilc_netdev_cleanup(struct wilc *wilc);
+void wilc_wfi_mgmt_rx(struct wilc *wilc, u8 *buff, u32 size);
+void wilc_wlan_set_bssid(struct net_device *wilc_netdev, u8 *bssid, u8 mod=
e);
+struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, const char *name,
+				      int vif_type, enum nl80211_iftype type,
+				      bool rtnl_locked);
+#endif
--=20
2.24.0
