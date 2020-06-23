Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CD7204FCD
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgFWLA1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33227 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbgFWLAR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910017; x=1624446017;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NKlSZK95m57eNFW3l20KwIbTngH81MBIFTRdBplJrw4=;
  b=X5W9Aay7bdNJzVgjAGalSj/PBr+X/cJOsFc7PRGnkWfntFOzpKv+kATQ
   dBQ/DEyfLfpyd7tcNo+HJH26eT4ocJ4CtZMBg2phRmW9wUKSh1Leht32H
   FyThJrrXt4L/eMl+wFUsZGepP5lDQgkQpCaUNN29AARqSqGTOo4JqDBsL
   J4ykysVpQ1BDjeEEIbtJW3z3hH8U12bHQ551VVBqfvgk2+oj0nnQMRknz
   7nuWEBA5/KsR5Bxzajc9+Hu7mszd5snP6xSDdFIXYNLFNqvq3QPVVuHWB
   dyxezEk+kk/4rjDoC276cBXRNhkWvDqJiRx7l/EJy9ckDnwx4cz2vZ+Fl
   w==;
IronPort-SDR: lIX/7c7KGe0tt1I6wRr6WrlZp9nm3XbsKII5E9oBkB9Zsp4kOdnPhHAp8Gk9dymZjHa96RnYiv
 yH5m0A+w1t+vIfqcsrQ3IAtl8CiXG7H6/gO8+lfA5bnlIRLvQJcKijNyNEXarF4OauIqJD6V9o
 dzyhmt9q7Vpx7Ni5qOYxFbN0J9W5pLohSF+H9DsYVoql1e6BnIUDBu/pYxC12eWlbUI+NKXxYc
 EQsnUymT0n7payYWLuOxbJL//kR3TooieV6zufPSt7EYkWBMk9b1V8ntWfgJdgDZnmsmY0bDpQ
 YgQ=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="84732756"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 04:00:14 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 04:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G28AO4ZuUrM/uMBnHT9JUKNTlhA946vUqiMe/yd3D2bb1Xu/drzHdsjnww7axStFRq/eaQpiPmXHw1c84SIsjVmQKMAA5ZfPA2/pR76R0KLxOLAn04SIwXCFSXiLC7vVmkffJfCw+rGyv2h8phBAcf25GJtrP+NzSlRzw4m5B3qbIYP8J5Bkk6XxWNhccnOo4CNR3jxR6M5XaFqxG72ACifsyETf/B32LOIgaqVkEDqRvm+RtCV1KBpJK0EQfiwmkts2uw2+4X93Ft2y/yqK8GdaMkOlQsRXH7roLEgaiKNlTp9qfu8DtUtkHJJq2gJpEWfOx/TcrJAxfDeXOHU4Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGniIcd/DOmfSMPdGWccGrH+FH4TXltQVmzvxoDSAu4=;
 b=ivq1E5Ff+YGcWp9FyxNyXTp0KSXkuQxCWHeeC4xDYS9gvcQRGhkEtGU0dpgsHde7dIKXFvotBvVmJahG31BILohkTDAzGBVl5i1ew2SWqJbFQw5jWJQcnciNszl6RfSnOol4qn7lq1V/zNUTRaHJILzMc5AUGbwimdTlML3D4tWjcBiAJWfu5QRdvo/9NatA+/oJ3wgPVHF5xPdf37XrcBfFZzUT6LrKDU09ZiDehuPdNrMhIru+TKzFdcJT5mTx3yIcexbAb0s87Rox+wDxO2g7zCQ24/KiPUttQHihqZR7zdpsprRCW/vDzSeJAWBhEEOa4ayme7IGkwte9Xuk0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGniIcd/DOmfSMPdGWccGrH+FH4TXltQVmzvxoDSAu4=;
 b=F5GGVWD/b7Kl9aeIyvMzIvJpPPUYwXZm2nPVRtEeyAjAFUvwtl29KhG9y3Ig5j5ss66BhgAgtoLthUEznU9L1dYTnh1jjild2pj13O/RNB6T06TfiPhjVpvFtRYxYeuSjNzmHxGwyqDnVDXlDKitg/HUPTJjmvp5qb63vz6Z3L0=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:09 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:09 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 08/17] wilc1000: add netdev.h
Thread-Topic: [PATCH v7 08/17] wilc1000: add netdev.h
Thread-Index: AQHWSU12rMO1PlPzgUOZ2U3DbSD4wg==
Date:   Tue, 23 Jun 2020 11:00:09 +0000
Message-ID: <20200623110000.31559-9-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.200.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60d9a82c-2491-49d8-11d8-08d81764989d
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3551CEDA6E40C67A2888F9A7E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyXHSABQ9ZiuR+V9YFziw2N1kC9ImbwBGxa685xka1ovUWhquClEAp2t9ueTHbMZcIMsMmoCFVpxoURkWF6Q+PRvx7uZ38Gf2FRpWbvkWXKIQGZqdDWf+VAvBPi80AxQYb5DnXN8qSjuXibRgmNoRypSPhpGQ4Cim3yNIxtTIzTnq6DFvJE9B/lsmqFxKQQo0xcweaaZL0IHln4ZrXQYNbLQQOFGHaXhsmXiCWNk1JEfKC/k5v3LFJZBTGQirj+8eKmREH8rIrUmrI9aXDrR76Jmi7eCkUgU24cgnvfWEfLoSM/vo0ZgdDsAodro6VVS5rhJGSe2gUQ0ZYUHNAIxTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: A83l9g4PdLfVeBnkppHpmIrA0PJ8PUzkKp8NK77yDlEC14lWOudJ/SdfSvtJoBjycnm7JXReODGd1AKtmwc3mQDtipfWx2SW2F1L7gurCIvLEuWULyrAvtR9ggyX4KmTFgsQu719UeN7LpZ7Bk+J2TsqMYF4ZlxNUvOYdGSkijavHzKLdpd4gvhQB88kYNy1JtqRKZVpm6T6OyY+LxvwbZyhTGV2CoOE7sqqVfbeTvFPduEBPJtQvpFrr1+uXnIUf3qUpPEJCuH3WMax8Sc8nh7EIrtQOAL8pfbyLczSm97RAzRT1OfghhGIxmlD3v/Ix/KXn67iFzlIUJqOJuXqxoIZMSsinCerXKNnRYh1bVbgSxipNshC0hqWEgBNkarrb+s0HlHJsLeFSjgAMq92e2rzLEQT/dlRln/asNsh87fiNyDANlfV9+1yyFuzQDE7/cwqM/dcU8Ksk+rJK1Anj7pIVcqkULAmtMcm75uEhhVb5y29pNl0TFnLnKSV5VhI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d9a82c-2491-49d8-11d8-08d81764989d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:09.5685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxXxzt0wWWsBpu6U/GupSH2aeMV6OZPpmaxa1Ifr32j66hBBWljIxlCwzkteYSsKt/8P3Je11gq0sKu1UJ1bK1jPTA1W0UNY7vjO5xvJWf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/netdev.h' to
'drivers/net/wireless/microchip/wilc1000/netdev.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/netdev.h  | 287 ++++++++++++++++++
 1 file changed, 287 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/netdev.h

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net=
/wireless/microchip/wilc1000/netdev.h
new file mode 100644
index 000000000000..d0a006b68d08
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -0,0 +1,287 @@
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
+	u32 mgmt_reg_stypes;
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
