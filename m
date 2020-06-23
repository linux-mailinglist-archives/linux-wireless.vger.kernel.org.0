Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCA204FC6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbgFWLAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:18 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:41136 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgFWLAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910008; x=1624446008;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pgrAZBWOanIKXzK8Hgc2qwl/9T6NmbCRHcT7ccmS8gc=;
  b=RgSfnRmI/b6XdqFLwdZ9ekwkcvHYPhsR7Htsf542aj2mRUNqRRz+d0p/
   lEewUzT18h9bpzeQvMXfHJ6Ce5/7meGGMyGXP/E1Tzo3MvwUdmZy8JxKi
   KDTmqW9k7hrmxcz3giUJAEG0O6D2eca0M4yr5Lr1PqYH0NusFywR8H6gp
   l7cN6x6mwRDpzIjoRwNWg2fjtNk4pmZqP1fUAm9+TMDSAwMhpEc7M6b6P
   EZprK+lUZP3096AIVBCE809N56cIGugmawhgQ+FSvFU4qVsC1t03E9LuI
   BlMO58rkqdwel85Ia5DrRJMCcTknT3z/u1vMSvcvIF8n/qOwFDIuvyCkl
   Q==;
IronPort-SDR: /UA1eAIacgSzalFVY+Folb4JQOy9VqAQfWxxgu3/Zn61223Uuygkzhkg+G6jUX/YAhkl+V351F
 +wxPlr7SIms7zOJWVgKpgjVHYUkjuSga3+4bd1j6CfEPPl0zCpWtmQPnbBP6KFDTbhyDDCuT0Z
 yGzEfOkhqlIM3DIlAbUpfGnJDVVibpUsVLTASkxqEkcWESowUhYix5R8Fhx0Of9uy/YvtZN2uz
 9auSgbsbsB3YYRObQzT2nwq0I+Oy1XxKByw5WGAAyNEC0VEwE8JnfKabbshNmlZm5O+Ekbsgpu
 88U=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="80543427"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 03:59:55 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 23 Jun 2020 04:00:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD/Ws7subB26NWIGKWiXHW9npO3F9GQhfPRsgILD3mA1MVhbZlfYn6W+NMnMZieRcVHK0T/C0M3KmFqBEDX8MvgW7z2Uj9/p4mEyyiAi5ZZd6LyUfZUcnDWZBV1pCr39HYz1gELvBXH76mpzq7/2xIv7dwpIIfmdRD7jfQxg4dnvAxjCcNCb0f0PHw0Sjk7vQAtEcEk1u2YVRZhHNcXT3ESRu2Pfg3GCHPEyPnts08FT09Wf6A9501KW1XUgrTeWBd9UFPio74rMSGfQ6UMnVD476yaDBcDaKao4GvghvOdmRfSGABJamqDVZsaSCyzCV0S0T7CLLB350gpusB695g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiAsrOYsP30GtRBrM48mwYCMUnIJvzhFbAQwDwmMWJ0=;
 b=eLjg9spR4Tna7cmMyTGo/Cld7wPVLObbjZtbrptRkm3G9549baKCPQAjbxBas0tpg+BT5EvH90MP8hXWxmmQNEeSe/vCAN01s0L5WXnjRXbD5/b46m/fC4krfZMn8EPMWBdaC/mjZGn13NNjfmIscJXUyUuR7iTA2OMGq6Gomc9VjGJRJ+iZXrZKK3Qw1mZSNJ8GHmFRzW/ByVrb4/vCJhHkSXISqVqpslFwKGLqYtMZStgOY/vqaeJpnhDudeYomk20Gh2DdFrnmv8a2qnFQ7pNk8f1ZdSte0TViKKlDKP6rieKnPyRGNtbu7IB7ToqHHGAxKNF2PyU/Qb8HtwC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiAsrOYsP30GtRBrM48mwYCMUnIJvzhFbAQwDwmMWJ0=;
 b=WDOt+1V3R3S3VzyKvG4J8oQAJ3EKcuz0xmVIrYEy1Q8vwwrI3aEVdV+lwBgAt3634iTC9Aj8PkrXZCMTpTbdFOhALay/ybSuuXZhXcrhia8e8e4jOV9PAGRqzs9M91+dH0BZhG/TswN6X8WAJYygEeFHejh1q7ubsJh6xYu2Yik=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:05 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:05 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 01/17] wilc1000: add hif.h
Thread-Topic: [PATCH v7 01/17] wilc1000: add hif.h
Thread-Index: AQHWSU1zGXlfchHcTk6SUyiuVFSRjQ==
Date:   Tue, 23 Jun 2020 11:00:05 +0000
Message-ID: <20200623110000.31559-2-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: fdf1f1b5-c104-4e8a-bd25-08d8176495f6
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3551522761B6BDCA9D39A3ACE3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:127;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdHlC5vy6cb6F71G2p5wIh/inAS7no5FCgHisyMBModBs1kKveYrSk99XnWKYC4bpOJvdxdpO5nNAPjUCnbUe3gUeodtAWsMyFxzVpkKM5ZhjEdcJaT/eHMzVzmTTt7esJGS/TdFKd+orEJDbXGx1GD/V/rWdjNhICQ+DZj5byVsiuzTvGGc/Ltv9NH4h/vJV0R+7g3+RB2u2U4YR0hqbaX0S5JNIbMrEyffPuEi0d73gF0vSDpTv//2ytkLJNxF5El6Num40WGnJsfIWlAS14n8ejP90jnCxRUWhZANhaLgWjN3MgwR0fnc5ui/z8Ad/C8nUAamkzuX7B7Ph/yW0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qRkVF2SeNJCltytWbg85GoLGSumGS61czY58dGs1S+Qo1UyZfJG9/vk2li7WaUtgTwNnh5aG+j1lnSXUEZqWgcrCo9rOZ4ixks7DoW9ds/lxRmRt8E6LjPTCOr+WF5v8hkifud01Om1xoHs1JCO0srN9XatYFtt03X6ZhRFeqGxaQq/vsCePkrmKnUw/8mCeGjiDKspD9aXb06mtmgxtVAQzNxNwhXxOj29AkNtl1S6hNxShMNLmOxF+E1G4DYxA3pWPwQ5TlimEpcgQ5cHOdzgKA84gqdDfOhq2OCdxgzEZ2+fjcTL6gW55T4nA8coZiabO/mwc/1+eWRR+NzLB6apKl3HOULq1t6gGj+gGZ8jqyQeBTRoYHaK+XNsWST3gHm4/rs/bbxL0QtgL8o3BCDTV795hY8LFXkNp5lSJUOO/ASjzVfG+BBmoyUcMltpjYp1bJCk5RC06wEFQEhYiqieD1vuDpzE0j5mDuwRnPukmgUWifV2tzgR8UW5FlMwE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf1f1b5-c104-4e8a-bd25-08d8176495f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:05.2329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ih5rrVDSAzLpoCvcTWaOb+QFIKTqUQda1ZJGDa0Nz3qG/j9Pp2gs2cPNvLlbLcRELAMjcPLmi3mjepKIlA4M14RiANgMz+xowW6aZ30jTxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/hif.h' to
'drivers/net/wireless/microchip/wilc1000/hif.h'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.h | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/hif.h

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.h b/drivers/net/wi=
reless/microchip/wilc1000/hif.h
new file mode 100644
index 000000000000..db9179171f05
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/hif.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es
+ * All rights reserved.
+ */
+
+#ifndef WILC_HIF_H
+#define WILC_HIF_H
+#include <linux/ieee80211.h>
+#include "wlan_if.h"
+
+enum {
+	WILC_IDLE_MODE =3D 0x0,
+	WILC_AP_MODE =3D 0x1,
+	WILC_STATION_MODE =3D 0x2,
+	WILC_GO_MODE =3D 0x3,
+	WILC_CLIENT_MODE =3D 0x4
+};
+
+#define WILC_MAX_NUM_PROBED_SSID		10
+
+#define WILC_TX_MIC_KEY_LEN			8
+#define WILC_RX_MIC_KEY_LEN			8
+
+#define WILC_ADD_STA_LENGTH			40
+#define WILC_NUM_CONCURRENT_IFC			2
+
+enum {
+	WILC_SET_CFG =3D 0,
+	WILC_GET_CFG
+};
+
+#define WILC_MAX_ASSOC_RESP_FRAME_SIZE   256
+
+struct rf_info {
+	u8 link_speed;
+	s8 rssi;
+	u32 tx_cnt;
+	u32 rx_cnt;
+	u32 tx_fail_cnt;
+};
+
+enum host_if_state {
+	HOST_IF_IDLE			=3D 0,
+	HOST_IF_SCANNING		=3D 1,
+	HOST_IF_CONNECTING		=3D 2,
+	HOST_IF_WAITING_CONN_RESP	=3D 3,
+	HOST_IF_CONNECTED		=3D 4,
+	HOST_IF_P2P_LISTEN		=3D 5,
+	HOST_IF_FORCE_32BIT		=3D 0xFFFFFFFF
+};
+
+struct cfg_param_attr {
+	u32 flag;
+	u16 short_retry_limit;
+	u16 long_retry_limit;
+	u16 frag_threshold;
+	u16 rts_threshold;
+};
+
+enum cfg_param {
+	WILC_CFG_PARAM_RETRY_SHORT =3D BIT(0),
+	WILC_CFG_PARAM_RETRY_LONG =3D BIT(1),
+	WILC_CFG_PARAM_FRAG_THRESHOLD =3D BIT(2),
+	WILC_CFG_PARAM_RTS_THRESHOLD =3D BIT(3)
+};
+
+enum scan_event {
+	SCAN_EVENT_NETWORK_FOUND	=3D 0,
+	SCAN_EVENT_DONE			=3D 1,
+	SCAN_EVENT_ABORTED		=3D 2,
+	SCAN_EVENT_FORCE_32BIT		=3D 0xFFFFFFFF
+};
+
+enum conn_event {
+	CONN_DISCONN_EVENT_CONN_RESP		=3D 0,
+	CONN_DISCONN_EVENT_DISCONN_NOTIF	=3D 1,
+	CONN_DISCONN_EVENT_FORCE_32BIT		=3D 0xFFFFFFFF
+};
+
+enum {
+	WILC_HIF_SDIO =3D 0,
+	WILC_HIF_SPI =3D BIT(0)
+};
+
+enum {
+	WILC_MAC_STATUS_INIT =3D -1,
+	WILC_MAC_STATUS_DISCONNECTED =3D 0,
+	WILC_MAC_STATUS_CONNECTED =3D 1
+};
+
+struct wilc_rcvd_net_info {
+	s8 rssi;
+	u8 ch;
+	u16 frame_len;
+	struct ieee80211_mgmt *mgmt;
+};
+
+struct wilc_user_scan_req {
+	void (*scan_result)(enum scan_event evt,
+			    struct wilc_rcvd_net_info *info, void *priv);
+	void *arg;
+	u32 ch_cnt;
+};
+
+struct wilc_conn_info {
+	u8 bssid[ETH_ALEN];
+	u8 security;
+	enum authtype auth_type;
+	u8 ch;
+	u8 *req_ies;
+	size_t req_ies_len;
+	u8 *resp_ies;
+	u16 resp_ies_len;
+	u16 status;
+	void (*conn_result)(enum conn_event evt, u8 status, void *priv_data);
+	void *arg;
+	void *param;
+};
+
+struct wilc_remain_ch {
+	u16 ch;
+	u32 duration;
+	void (*expired)(void *priv, u64 cookie);
+	void *arg;
+	u32 cookie;
+};
+
+struct wilc;
+struct host_if_drv {
+	struct wilc_user_scan_req usr_scan_req;
+	struct wilc_conn_info conn_info;
+	struct wilc_remain_ch remain_on_ch;
+	u64 p2p_timeout;
+
+	enum host_if_state hif_state;
+
+	u8 assoc_bssid[ETH_ALEN];
+
+	struct timer_list scan_timer;
+	struct wilc_vif *scan_timer_vif;
+
+	struct timer_list connect_timer;
+	struct wilc_vif *connect_timer_vif;
+
+	struct timer_list remain_on_ch_timer;
+	struct wilc_vif *remain_on_ch_timer_vif;
+
+	bool ifc_up;
+	u8 assoc_resp[WILC_MAX_ASSOC_RESP_FRAME_SIZE];
+};
+
+struct wilc_vif;
+int wilc_remove_wep_key(struct wilc_vif *vif, u8 index);
+int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index);
+int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
+			     u8 index);
+int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
+			    u8 index, u8 mode, enum authtype auth_type);
+int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
+		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
+		 u8 mode, u8 cipher_mode, u8 index);
+s32 wilc_get_inactive_time(struct wilc_vif *vif, const u8 *mac,
+			   u32 *out_val);
+int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
+		    u8 index, u32 key_rsc_len, const u8 *key_rsc,
+		    const u8 *rx_mic, const u8 *tx_mic, u8 mode,
+		    u8 cipher_mode);
+int wilc_set_pmkid_info(struct wilc_vif *vif, struct wilc_pmkid_attr *pmki=
d);
+int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr);
+int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
+		      size_t ies_len);
+int wilc_disconnect(struct wilc_vif *vif);
+int wilc_set_mac_chnl_num(struct wilc_vif *vif, u8 channel);
+int wilc_get_rssi(struct wilc_vif *vif, s8 *rssi_level);
+int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
+	      u8 *ch_freq_list, u8 ch_list_len,
+	      void (*scan_result_fn)(enum scan_event,
+				     struct wilc_rcvd_net_info *, void *),
+	      void *user_arg, struct cfg80211_scan_request *request);
+int wilc_hif_set_cfg(struct wilc_vif *vif,
+		     struct cfg_param_attr *cfg_param);
+int wilc_init(struct net_device *dev, struct host_if_drv **hif_drv_handler=
);
+int wilc_deinit(struct wilc_vif *vif);
+int wilc_add_beacon(struct wilc_vif *vif, u32 interval, u32 dtim_period,
+		    struct cfg80211_beacon_data *params);
+int wilc_del_beacon(struct wilc_vif *vif);
+int wilc_add_station(struct wilc_vif *vif, const u8 *mac,
+		     struct station_parameters *params);
+int wilc_del_allstation(struct wilc_vif *vif, u8 mac_addr[][ETH_ALEN]);
+int wilc_del_station(struct wilc_vif *vif, const u8 *mac_addr);
+int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
+		      struct station_parameters *params);
+int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout);
+int wilc_setup_multicast_filter(struct wilc_vif *vif, u32 enabled, u32 cou=
nt,
+				u8 *mc_list);
+int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie,
+			   u32 duration, u16 chan,
+			   void (*expired)(void *, u64),
+			   void *user_arg);
+int wilc_listen_state_expired(struct wilc_vif *vif, u64 cookie);
+void wilc_frame_register(struct wilc_vif *vif, u16 frame_type, bool reg);
+int wilc_set_operation_mode(struct wilc_vif *vif, int index, u8 mode,
+			    u8 ifc_id);
+int wilc_get_statistics(struct wilc_vif *vif, struct rf_info *stats);
+int wilc_get_vif_idx(struct wilc_vif *vif);
+int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power);
+int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power);
+void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
);
+void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)=
;
+void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th);
+void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
+				struct cfg80211_crypto_settings *crypto);
+#endif
--=20
2.24.0
