Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC56638F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGLB7B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:01 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24921 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfGLB7B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:01 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cZ5sxm1pyakRnt3/F45AqOLax/x9EMpIAC+CnRqpZ3x6xXWqc2+XBAQe0K+lFclVjrNG4WzKWb
 IsoDR0zDXv2EwgAa6o2K6tZcoge/N8oS9wGOlNpQ58Q4MKyfLw4JRUDHDw1+/ZUCSDGjt40imX
 85H8RXaVUiaXdmFRo3KGnDk2NMlgNiFnI5uatHO3hvsfV5PnqRN3sui+/zsBkwK+ed+EX+aqqM
 Dp7Dhqqqxy3W/5yeyizqRYBmX7IXtFpudc7RLEQF41Jinf/PdEgNefYsEYr73xy6Qf32oOGySF
 dig=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967439"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:59 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:58:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmuBL22tQ0nWMh12QNpcoEHaNTweFcQvr0WE58XIzUvrd7Q6UIX5T9nJtafjg8Br4p84r3WHRsvN39YX/QvZl1GaatbyxI7p7enuEd/5FydwGa+HYmzcKJJeti07tH5oC74HIAgjt2LEcdyQso4bvq3m4XCzhQdh4zQauVj3jT7bu7RIlV/REhgG7GKCp+FSYELJU+2L5fMRawt8RZg1hjE6CdMq2NdcscOoMBnOGtz0aQ8VMg9HovQK5JwfO4Ey2Cg+PFc3HJdRQh2qJ2h/xBqAZlCJBgzQ26FC2KrySiaJvGLtjEO1AmoPHUS0S1nBQLk/ZIOxxMKfcYHr0lu12A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlnSPagdTuJseIZhZmilLp+dOkNowmDsuBx20eB2Ru4=;
 b=cAEth45RS/tqsG7PIQT42lKmiJ3I7pITMkePHcHNfI0XEVrAVkg1wX3knOjWXE5sOwVupdU4rbXgiyaL0UV3u24h4wMRm3EbAqq6CviRjkkJ+16rS54jrnDug7afhYVrkF6dMVOBkC75H3JqmJQ3ZVOa5aKN/rzMvRzldKqsPaDQu+xv/zL+SjFcC5Wfwk3H5wSjzJ9vwfbP511shkJYieD9g87vwqTa69mSBoUI60SVqd7qgq6u7ClLNezwhRzMFgIAvwpgEWOIPHLp/KokI5roR7zFJfaF1QzVwexGzLeMtSl2TUjSYx1+kKT7GSx5kfF01hMGAV7IjE75ds3oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlnSPagdTuJseIZhZmilLp+dOkNowmDsuBx20eB2Ru4=;
 b=Jct8siz8J53Xj82bOZ/Oz6ILtLXAgtw0bojE8lxmFiXInVz/Tz2Y4/qxI3u5Kdxothrb1V7zRN0LGWAXqkTDkk4InlPpfANZhq+InnarRZ0loQN6HRQwE0fCqoAMbu+kksOoh73H6K8YSCXzQmLr2FoQUyrCRUBCA+G+wQqWwlI=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:57 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:57 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 06/16] wilc1000: add wilc_wfi_netdevice.h
Thread-Topic: [PATCH v2 06/16] wilc1000: add wilc_wfi_netdevice.h
Thread-Index: AQHVOFVdD3bsYptAKkySvuAnhCPclQ==
Date:   Fri, 12 Jul 2019 01:58:57 +0000
Message-ID: <1562896697-8002-7-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba08220b-1f56-4a60-c565-08d7066c804a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB14255E53AC1EEDD1E6248610E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KYU3zhmOqaSDDqbSq8BKJvtxoC9N6vQBMG/PzWFvyo259WWWgaP7dRLMws2UKfTaB2nfyT6NcmoAtaGhb5wWrAL3OR494vG9KH7v+4mwJkGdzmcrYWY26/0K42t3bOheca1MMw1ZBiQ2teesnOfuGBEKb6yg6QRAdTf79114ZAOrkHtpkT/fLEucxIyOGSX121DC/n9J6L0sXuGZUSwfGXqe17QF3vFfU41tvgwkrt1u7dqg7kiY85oZXFgNAioUMeilsp4zDU27p9P+CZRiqo0VfzH0IxXKrJj49na82Ch54GSDyP0+9VpCrqJ8XCDA2k3M5bnazBfZg3cRwqrkcNoSzcLYf0doUMzydSc73UoHoK0zL1YXRaAhGUA++18tf3kyugWPSg1Tp1/sLxTf2/mkiRaJvneFxG1mJkFYqTE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba08220b-1f56-4a60-c565-08d7066c804a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:57.6831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

MOved '/driver/staging/wilc1000/wilc_wfi_netdevice.h' to
'drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdevice.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../microchip/wilc1000/wilc_wfi_netdevice.h        | 294 +++++++++++++++++=
++++
 1 file changed, 294 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdev=
ice.h

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdevice.h b=
/drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdevice.h
new file mode 100644
index 0000000..1e74a08
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wfi_netdevice.h
@@ -0,0 +1,294 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#ifndef WILC_WFI_NETDEVICE
+#define WILC_WFI_NETDEVICE
+
+#include <linux/tcp.h>
+#include <linux/ieee80211.h>
+#include <net/cfg80211.h>
+#include <net/ieee80211_radiotap.h>
+#include <linux/if_arp.h>
+#include <linux/gpio/consumer.h>
+
+#include "wilc_hif.h"
+#include "wilc_wlan.h"
+#include "wilc_wlan_cfg.h"
+
+#define FLOW_CONTROL_LOWER_THRESHOLD		128
+#define FLOW_CONTROL_UPPER_THRESHOLD		256
+
+#define WILC_MAX_NUM_PMKIDS			16
+#define PMKID_FOUND				1
+#define NUM_STA_ASSOCIATED			8
+
+#define NUM_REG_FRAME				2
+
+#define TCP_ACK_FILTER_LINK_SPEED_THRESH	54
+#define DEFAULT_LINK_SPEED			72
+
+#define GET_PKT_OFFSET(a) (((a) >> 22) & 0x1ff)
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
+/*Parameters needed for host interface for  remaining on channel*/
+struct wilc_wfi_p2p_listen_params {
+	struct ieee80211_channel *listen_ch;
+	u32 listen_duration;
+	u64 listen_cookie;
+};
+
+struct wilc_p2p_var {
+	u8 local_random;
+	u8 recv_random;
+	bool is_wilc_ie;
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
+	/* The real interface that the monitor is on */
+	struct net_device *real_ndev;
+	struct wilc_wfi_key *wilc_gtk[WILC_MAX_NUM_STA];
+	struct wilc_wfi_key *wilc_ptk[WILC_MAX_NUM_STA];
+	u8 wilc_groupkey;
+	/* mutexes */
+	struct mutex scan_req_lock;
+	bool p2p_listen_state;
+	int scanned_cnt;
+	struct wilc_p2p_var p2p;
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
+	bool obtaining_ip;
+	struct timer_list periodic_rssi;
+	struct rf_info periodic_stat;
+	struct tcp_ack_filter ack_filter;
+	bool connecting;
+	struct wilc_priv priv;
+};
+
+struct wilc {
+	struct wiphy *wiphy;
+	const struct wilc_hif_func *hif_func;
+	int io_type;
+	s8 mac_status;
+	struct gpio_desc *gpio_irq;
+	bool initialized;
+	int dev_irq_num;
+	int close;
+	u8 vif_num;
+	struct wilc_vif *vif[WILC_NUM_CONCURRENT_IFC];
+	/*protect vif list*/
+	struct mutex vif_mutex;
+	u8 open_ifcs;
+	/*protect head of transmit queue*/
+	struct mutex txq_add_to_head_cs;
+	/*protect txq_entry_t transmit queue*/
+	spinlock_t txq_spinlock;
+	/*protect rxq_entry_t receiver queue*/
+	struct mutex rxq_cs;
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
+	bool enable_ps;
+	int clients_count;
+	struct workqueue_struct *hif_workqueue;
+	enum chip_ps_states chip_ps_state;
+	struct wilc_cfg cfg;
+	void *bus_data;
+	struct net_device *monitor_dev;
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
2.7.4

