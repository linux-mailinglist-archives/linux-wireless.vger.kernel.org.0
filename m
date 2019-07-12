Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553C36638B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbfGLB6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:58:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:22911 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbfGLB6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:58:47 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: QnkGGaqJvmHcCFIoj2fpGcKLk0COI9IWxTCOtoVf6Ge5Z4P8ovCFxvFW1Q6sXYoP203kgjUBfr
 g8PNZRcQwJIDyXffJFR6/A3+DKcF/lLK4cjToZlVAhLKg++IwP9hkRE2RqOD7drgGzLk/bYWEV
 gaOL2drUdiIkodML2x9kMN/URXSG2OenMvBPzMgB41D+FjJyBwqy2vHOOaDj4FhmAQLJRdu/TP
 iSarVik8dhFWcabFqErBBl2QMYSXVAjEBLRektkIExBaQLYKF8pONeguKgWjGP62Il+AZnEGbp
 kB0=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="41020050"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:58:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:58:44 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu4drgrs6ROzzyNVbGqTUTxp7x0cj8Fn7szkerK65fg8f2t/4I5wuf3dzbLq/aLIFx3bb5Zm3+zh14bzCmMfm00Esf+XIqEYhV75xSzYzXFl5jXFONGw8XWXSeY9BBm22Dhzbb7FNjASkgZt9J56ikYLYpQoCpdrnunZR+/asKtLVvK3j+EL6fZf0ZUDLiD4QCgzahzat6Eshybd6xAi9+xLU81XSFo9I00LDt+5a10d1uffEh3TZx2WGKmds/pNXga3ji2NCGlhkDrxXaf85oOECTg6ChmX3bGW7i/Ts0wnQxl0bNr0Du7NPzjZq3gX2XFA1WvjNzDjTg5Q4DpyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yj0fvsy+sd87k/Do/wLYkuxOw9dtL2eMLfYZUwKxL0=;
 b=JeZT/a1bTms8clFRWhI/xMSM7S8ZWZyy3FH3gxb4vGKunnD5hi6KTec9FwExhwqWsaniYotLgOHRTHOshZJxm9e1AJ4d91RGzEr9kaORSAhJw3v1ZNPk3xOuCmspzq6WZR5zqiYGjbCdk5h1cZcNt1rVPWkkNYuO0x8HnDi7d2IwTfQN56afMJatv/Hk5I394VXGWutM0aZ7fMqW4cszpkTy9Ceuji2jQU15DcHJeo4GRpnWrA5GmlxbFv2ork4pWaL2SXV0dK5W4Fj/f/3irSVlV0hfS0w+Hud3hCG5Y7KXjG7QrcZ43GXAwxr3R2VHH62X28ypePCZxC6Jh3v7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yj0fvsy+sd87k/Do/wLYkuxOw9dtL2eMLfYZUwKxL0=;
 b=D46Y1ANJy10KcWb7RPcu6nuXcyM4wktL5uPLS+nki13XDEFOR+Frsnhk5nTYlY8PkdExrnYiWEIB16TAMlMAEEJl5+lpsTCk2XOPxhVqIhmMDlGoEfDKkyIJKOjAuJwLBcmMQvUcyO16X8rXThKH+RLFX4Ih0sxQltz0nPfUDGU=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB4179.namprd11.prod.outlook.com (10.255.128.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:58:43 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:58:43 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 02/16] wilc1000: add wilc_hif.c
Thread-Topic: [PATCH v2 02/16] wilc1000: add wilc_hif.c
Thread-Index: AQHVOFVVrcOMa5Im0kSsJ65zPNQoKQ==
Date:   Fri, 12 Jul 2019 01:58:42 +0000
Message-ID: <1562896697-8002-3-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: d5ed2ad7-cbf2-4597-480e-08d7066c7744
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB4179;
x-ms-traffictypediagnostic: BN6PR11MB4179:
x-microsoft-antispam-prvs: <BN6PR11MB417979C4F936D8AA08476BC4E3F20@BN6PR11MB4179.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(366004)(376002)(39860400002)(189003)(199004)(486006)(71190400001)(71200400001)(54906003)(102836004)(86362001)(316002)(36756003)(305945005)(6506007)(45080400002)(6916009)(99286004)(2616005)(478600001)(30864003)(2351001)(476003)(446003)(11346002)(78486014)(7736002)(68736007)(386003)(3846002)(66446008)(66476007)(8676002)(52116002)(8936002)(4326008)(66556008)(26005)(53946003)(5660300002)(2906002)(50226002)(14454004)(66946007)(6116002)(6486002)(6436002)(81166006)(186003)(6512007)(81156014)(66066001)(53936002)(256004)(25786009)(14444005)(107886003)(76176011)(5640700003)(2501003)(64756008)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4179;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: foi4W4oi12vEdXJTNHmiGrQf/WG9TzZagJcTmSv3iu1fZa8f+40/HG1fyVIoHsoFVYeelWu7AfTqaIczX6wXYUG6bjr+NSgsts0X17icSlJw+UUmpfY33GIWxjtdpV0b3ni7uTWcjOxGljH6gFev6hB5UaM9IrJ6fzWlrx3+i9RP94PrLZsMAxocsQE6ma4Jory8EGLfW7qL1fCj7Bn4SxANnjlYNqHrK7n22YhyHX5clu3Z2zE4nPbjFEcuDSW0G+uIxK5M1JZec34q7IK/wG9bU5ZsUdHP7yqPRNFOc87JP01g6v0xapfBHRrkhKWozyP/dNRqVR0/qRMMIP8OhOMX5tbY7NiNPk4frYbgl+Lxj0yeCuSlMkQK6TDhLErMe7JFP76udUZq+oA+I7n6WI0xWxgG82xkbihrDSVsjpM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ed2ad7-cbf2-4597-480e-08d7066c7744
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:58:42.8669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4179
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_hif.c' to
'/drivers/net/wireless/microchip/wilc1000/wilc_hif.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wilc_hif.c | 2089 ++++++++++++++++=
++++
 1 file changed, 2089 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_hif.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_hif.c b/drivers/n=
et/wireless/microchip/wilc1000/wilc_hif.c
new file mode 100644
index 0000000..9345cab
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_hif.c
@@ -0,0 +1,2089 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include "wilc_wfi_netdevice.h"
+
+#define WILC_HIF_SCAN_TIMEOUT_MS                5000
+#define WILC_HIF_CONNECT_TIMEOUT_MS             9500
+
+#define WILC_FALSE_FRMWR_CHANNEL		100
+#define WILC_MAX_RATES_SUPPORTED		12
+
+struct wilc_rcvd_mac_info {
+	u8 status;
+};
+
+struct wilc_set_multicast {
+	u32 enabled;
+	u32 cnt;
+	u8 *mc_list;
+};
+
+struct wilc_del_all_sta {
+	u8 assoc_sta;
+	u8 mac[WILC_MAX_NUM_STA][ETH_ALEN];
+};
+
+struct wilc_op_mode {
+	__le32 mode;
+};
+
+struct wilc_reg_frame {
+	bool reg;
+	u8 reg_id;
+	__le16 frame_type;
+} __packed;
+
+struct wilc_drv_handler {
+	__le32 handler;
+	u8 mode;
+} __packed;
+
+struct wilc_wep_key {
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_sta_wpa_ptk {
+	u8 mac_addr[ETH_ALEN];
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_ap_wpa_ptk {
+	u8 mac_addr[ETH_ALEN];
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+struct wilc_gtk_key {
+	u8 mac_addr[ETH_ALEN];
+	u8 rsc[8];
+	u8 index;
+	u8 key_len;
+	u8 key[0];
+} __packed;
+
+union wilc_message_body {
+	struct wilc_rcvd_net_info net_info;
+	struct wilc_rcvd_mac_info mac_info;
+	struct wilc_set_multicast mc_info;
+	struct wilc_remain_ch remain_on_ch;
+	char *data;
+};
+
+struct host_if_msg {
+	union wilc_message_body body;
+	struct wilc_vif *vif;
+	struct work_struct work;
+	void (*fn)(struct work_struct *ws);
+	struct completion work_comp;
+	bool is_sync;
+};
+
+struct wilc_noa_opp_enable {
+	u8 ct_window;
+	u8 cnt;
+	__le32 duration;
+	__le32 interval;
+	__le32 start_time;
+} __packed;
+
+struct wilc_noa_opp_disable {
+	u8 cnt;
+	__le32 duration;
+	__le32 interval;
+	__le32 start_time;
+} __packed;
+
+struct wilc_join_bss_param {
+	char ssid[IEEE80211_MAX_SSID_LEN];
+	u8 ssid_terminator;
+	u8 bss_type;
+	u8 ch;
+	__le16 cap_info;
+	u8 sa[ETH_ALEN];
+	u8 bssid[ETH_ALEN];
+	__le16 beacon_period;
+	u8 dtim_period;
+	u8 supp_rates[WILC_MAX_RATES_SUPPORTED + 1];
+	u8 wmm_cap;
+	u8 uapsd_cap;
+	u8 ht_capable;
+	u8 rsn_found;
+	u8 rsn_grp_policy;
+	u8 mode_802_11i;
+	u8 p_suites[3];
+	u8 akm_suites[3];
+	u8 rsn_cap[2];
+	u8 noa_enabled;
+	__le32 tsf_lo;
+	u8 idx;
+	u8 opp_enabled;
+	union {
+		struct wilc_noa_opp_disable opp_dis;
+		struct wilc_noa_opp_enable opp_en;
+	};
+} __packed;
+
+/* 'msg' should be free by the caller for syc */
+static struct host_if_msg*
+wilc_alloc_work(struct wilc_vif *vif, void (*work_fun)(struct work_struct =
*),
+		bool is_sync)
+{
+	struct host_if_msg *msg;
+
+	if (!work_fun)
+		return ERR_PTR(-EINVAL);
+
+	msg =3D kzalloc(sizeof(*msg), GFP_ATOMIC);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+	msg->fn =3D work_fun;
+	msg->vif =3D vif;
+	msg->is_sync =3D is_sync;
+	if (is_sync)
+		init_completion(&msg->work_comp);
+
+	return msg;
+}
+
+static int wilc_enqueue_work(struct host_if_msg *msg)
+{
+	INIT_WORK(&msg->work, msg->fn);
+
+	if (!msg->vif || !msg->vif->wilc || !msg->vif->wilc->hif_workqueue)
+		return -EINVAL;
+
+	if (!queue_work(msg->vif->wilc->hif_workqueue, &msg->work))
+		return -EINVAL;
+
+	return 0;
+}
+
+/* The idx starts from 0 to (NUM_CONCURRENT_IFC - 1), but 0 index used as
+ * special purpose in wilc device, so we add 1 to the index to starts from=
 1.
+ * As a result, the returned index will be 1 to NUM_CONCURRENT_IFC.
+ */
+int wilc_get_vif_idx(struct wilc_vif *vif)
+{
+	return vif->idx + 1;
+}
+
+/* We need to minus 1 from idx which is from wilc device to get real index
+ * of wilc->vif[], because we add 1 when pass to wilc device in the functi=
on
+ * wilc_get_vif_idx.
+ * As a result, the index should be between 0 and (NUM_CONCURRENT_IFC - 1)=
.
+ */
+static struct wilc_vif *wilc_get_vif_from_idx(struct wilc *wilc, int idx)
+{
+	int index =3D idx - 1;
+
+	if (index < 0 || index >=3D WILC_NUM_CONCURRENT_IFC)
+		return NULL;
+
+	return wilc->vif[index];
+}
+
+static int handle_scan_done(struct wilc_vif *vif, enum scan_event evt)
+{
+	int result =3D 0;
+	u8 abort_running_scan;
+	struct wid wid;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_user_scan_req *scan_req;
+
+	if (evt =3D=3D SCAN_EVENT_ABORTED) {
+		abort_running_scan =3D 1;
+		wid.id =3D WID_ABORT_RUNNING_SCAN;
+		wid.type =3D WID_CHAR;
+		wid.val =3D (s8 *)&abort_running_scan;
+		wid.size =3D sizeof(char);
+
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+		if (result) {
+			netdev_err(vif->ndev, "Failed to set abort running\n");
+			result =3D -EFAULT;
+		}
+	}
+
+	if (!hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL\n", __func__);
+		return result;
+	}
+
+	scan_req =3D &hif_drv->usr_scan_req;
+	if (scan_req->scan_result) {
+		scan_req->scan_result(evt, NULL, scan_req->arg);
+		scan_req->scan_result =3D NULL;
+	}
+
+	return result;
+}
+
+int wilc_scan(struct wilc_vif *vif, u8 scan_source, u8 scan_type,
+	      u8 *ch_freq_list, u8 ch_list_len,
+	      void (*scan_result_fn)(enum scan_event,
+				     struct wilc_rcvd_net_info *, void *),
+	      void *user_arg, struct cfg80211_scan_request *request)
+{
+	int result =3D 0;
+	struct wid wid_list[5];
+	u32 index =3D 0;
+	u32 i, scan_timeout;
+	u8 *buffer;
+	u8 valuesize =3D 0;
+	u8 *search_ssid_vals =3D NULL;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (hif_drv->hif_state >=3D HOST_IF_SCANNING &&
+	    hif_drv->hif_state < HOST_IF_CONNECTED) {
+		netdev_err(vif->ndev, "Already scan\n");
+		result =3D -EBUSY;
+		goto error;
+	}
+
+	if (vif->obtaining_ip || vif->connecting) {
+		netdev_err(vif->ndev, "Don't do obss scan\n");
+		result =3D -EBUSY;
+		goto error;
+	}
+
+	hif_drv->usr_scan_req.ch_cnt =3D 0;
+
+	if (request->n_ssids) {
+		for (i =3D 0; i < request->n_ssids; i++)
+			valuesize +=3D ((request->ssids[i].ssid_len) + 1);
+		search_ssid_vals =3D kmalloc(valuesize + 1, GFP_KERNEL);
+		if (search_ssid_vals) {
+			wid_list[index].id =3D WID_SSID_PROBE_REQ;
+			wid_list[index].type =3D WID_STR;
+			wid_list[index].val =3D search_ssid_vals;
+			buffer =3D wid_list[index].val;
+
+			*buffer++ =3D request->n_ssids;
+
+			for (i =3D 0; i < request->n_ssids; i++) {
+				*buffer++ =3D request->ssids[i].ssid_len;
+				memcpy(buffer, request->ssids[i].ssid,
+				       request->ssids[i].ssid_len);
+				buffer +=3D request->ssids[i].ssid_len;
+			}
+			wid_list[index].size =3D (s32)(valuesize + 1);
+			index++;
+		}
+	}
+
+	wid_list[index].id =3D WID_INFO_ELEMENT_PROBE;
+	wid_list[index].type =3D WID_BIN_DATA;
+	wid_list[index].val =3D (s8 *)request->ie;
+	wid_list[index].size =3D request->ie_len;
+	index++;
+
+	wid_list[index].id =3D WID_SCAN_TYPE;
+	wid_list[index].type =3D WID_CHAR;
+	wid_list[index].size =3D sizeof(char);
+	wid_list[index].val =3D (s8 *)&scan_type;
+	index++;
+
+	if (scan_type =3D=3D WILC_FW_PASSIVE_SCAN && request->duration) {
+		wid_list[index].id =3D WID_PASSIVE_SCAN_TIME;
+		wid_list[index].type =3D WID_SHORT;
+		wid_list[index].size =3D sizeof(u16);
+		wid_list[index].val =3D (s8 *)&request->duration;
+		index++;
+
+		scan_timeout =3D (request->duration * ch_list_len) + 500;
+	} else {
+		scan_timeout =3D WILC_HIF_SCAN_TIMEOUT_MS;
+	}
+
+	wid_list[index].id =3D WID_SCAN_CHANNEL_LIST;
+	wid_list[index].type =3D WID_BIN_DATA;
+
+	if (ch_freq_list && ch_list_len > 0) {
+		for (i =3D 0; i < ch_list_len; i++) {
+			if (ch_freq_list[i] > 0)
+				ch_freq_list[i] -=3D 1;
+		}
+	}
+
+	wid_list[index].val =3D ch_freq_list;
+	wid_list[index].size =3D ch_list_len;
+	index++;
+
+	wid_list[index].id =3D WID_START_SCAN_REQ;
+	wid_list[index].type =3D WID_CHAR;
+	wid_list[index].size =3D sizeof(char);
+	wid_list[index].val =3D (s8 *)&scan_source;
+	index++;
+
+	hif_drv->usr_scan_req.scan_result =3D scan_result_fn;
+	hif_drv->usr_scan_req.arg =3D user_arg;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list, index);
+	if (result) {
+		netdev_err(vif->ndev, "Failed to send scan parameters\n");
+		goto error;
+	}
+
+	hif_drv->scan_timer_vif =3D vif;
+	mod_timer(&hif_drv->scan_timer,
+		  jiffies + msecs_to_jiffies(scan_timeout));
+
+error:
+
+	kfree(search_ssid_vals);
+
+	return result;
+}
+
+static int wilc_send_connect_wid(struct wilc_vif *vif)
+{
+	int result =3D 0;
+	struct wid wid_list[4];
+	u32 wid_cnt =3D 0;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_conn_info *conn_attr =3D &hif_drv->conn_info;
+	struct wilc_join_bss_param *bss_param =3D conn_attr->param;
+
+	wid_list[wid_cnt].id =3D WID_INFO_ELEMENT_ASSOCIATE;
+	wid_list[wid_cnt].type =3D WID_BIN_DATA;
+	wid_list[wid_cnt].val =3D conn_attr->req_ies;
+	wid_list[wid_cnt].size =3D conn_attr->req_ies_len;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_11I_MODE;
+	wid_list[wid_cnt].type =3D WID_CHAR;
+	wid_list[wid_cnt].size =3D sizeof(char);
+	wid_list[wid_cnt].val =3D (s8 *)&conn_attr->security;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_AUTH_TYPE;
+	wid_list[wid_cnt].type =3D WID_CHAR;
+	wid_list[wid_cnt].size =3D sizeof(char);
+	wid_list[wid_cnt].val =3D (s8 *)&conn_attr->auth_type;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_JOIN_REQ_EXTENDED;
+	wid_list[wid_cnt].type =3D WID_STR;
+	wid_list[wid_cnt].size =3D sizeof(*bss_param);
+	wid_list[wid_cnt].val =3D (u8 *)bss_param;
+	wid_cnt++;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list, wid_cnt);
+	if (result) {
+		netdev_err(vif->ndev, "failed to send config packet\n");
+		goto error;
+	} else {
+		hif_drv->hif_state =3D HOST_IF_WAITING_CONN_RESP;
+	}
+
+	return 0;
+
+error:
+
+	kfree(conn_attr->req_ies);
+	conn_attr->req_ies =3D NULL;
+
+	return result;
+}
+
+static void handle_connect_timeout(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc_vif *vif =3D msg->vif;
+	int result;
+	struct wid wid;
+	u16 dummy_reason_code =3D 0;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL\n", __func__);
+		goto out;
+	}
+
+	hif_drv->hif_state =3D HOST_IF_IDLE;
+
+	if (hif_drv->conn_info.conn_result) {
+		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_CONN_RESP,
+					       WILC_MAC_STATUS_DISCONNECTED,
+					       hif_drv->conn_info.arg);
+
+	} else {
+		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
+	}
+
+	wid.id =3D WID_DISCONNECT;
+	wid.type =3D WID_CHAR;
+	wid.val =3D (s8 *)&dummy_reason_code;
+	wid.size =3D sizeof(char);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send disconnect\n");
+
+	hif_drv->conn_info.req_ies_len =3D 0;
+	kfree(hif_drv->conn_info.req_ies);
+	hif_drv->conn_info.req_ies =3D NULL;
+
+out:
+	kfree(msg);
+}
+
+void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
+				struct cfg80211_crypto_settings *crypto)
+{
+	struct wilc_join_bss_param *param;
+	struct ieee80211_p2p_noa_attr noa_attr;
+	u8 rates_len =3D 0;
+	const u8 *tim_elm, *ssid_elm, *rates_ie, *supp_rates_ie;
+	const u8 *ht_ie, *wpa_ie, *wmm_ie, *rsn_ie;
+	int ret;
+	const struct cfg80211_bss_ies *ies =3D rcu_dereference(bss->ies);
+
+	param =3D kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return NULL;
+
+	param->beacon_period =3D cpu_to_le16(bss->beacon_interval);
+	param->cap_info =3D cpu_to_le16(bss->capability);
+	param->bss_type =3D WILC_FW_BSS_TYPE_INFRA;
+	param->ch =3D ieee80211_frequency_to_channel(bss->channel->center_freq);
+	ether_addr_copy(param->bssid, bss->bssid);
+
+	ssid_elm =3D cfg80211_find_ie(WLAN_EID_SSID, ies->data, ies->len);
+	if (ssid_elm) {
+		if (ssid_elm[1] <=3D IEEE80211_MAX_SSID_LEN)
+			memcpy(param->ssid, ssid_elm + 2, ssid_elm[1]);
+	}
+
+	tim_elm =3D cfg80211_find_ie(WLAN_EID_TIM, ies->data, ies->len);
+	if (tim_elm && tim_elm[1] >=3D 2)
+		param->dtim_period =3D tim_elm[3];
+
+	memset(param->p_suites, 0xFF, 3);
+	memset(param->akm_suites, 0xFF, 3);
+
+	rates_ie =3D cfg80211_find_ie(WLAN_EID_SUPP_RATES, ies->data, ies->len);
+	if (rates_ie) {
+		rates_len =3D rates_ie[1];
+		param->supp_rates[0] =3D rates_len;
+		memcpy(&param->supp_rates[1], rates_ie + 2, rates_len);
+	}
+
+	supp_rates_ie =3D cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES, ies->data,
+					 ies->len);
+	if (supp_rates_ie) {
+		if (supp_rates_ie[1] > (WILC_MAX_RATES_SUPPORTED - rates_len))
+			param->supp_rates[0] =3D WILC_MAX_RATES_SUPPORTED;
+		else
+			param->supp_rates[0] +=3D supp_rates_ie[1];
+
+		memcpy(&param->supp_rates[rates_len + 1], supp_rates_ie + 2,
+		       (param->supp_rates[0] - rates_len));
+	}
+
+	ht_ie =3D cfg80211_find_ie(WLAN_EID_HT_CAPABILITY, ies->data, ies->len);
+	if (ht_ie)
+		param->ht_capable =3D true;
+
+	ret =3D cfg80211_get_p2p_attr(ies->data, ies->len,
+				    IEEE80211_P2P_ATTR_ABSENCE_NOTICE,
+				    (u8 *)&noa_attr, sizeof(noa_attr));
+	if (ret > 0) {
+		param->tsf_lo =3D cpu_to_le32(ies->tsf);
+		param->noa_enabled =3D 1;
+		param->idx =3D noa_attr.index;
+		if (noa_attr.oppps_ctwindow & IEEE80211_P2P_OPPPS_ENABLE_BIT) {
+			param->opp_enabled =3D 1;
+			param->opp_en.ct_window =3D noa_attr.oppps_ctwindow;
+			param->opp_en.cnt =3D noa_attr.desc[0].count;
+			param->opp_en.duration =3D noa_attr.desc[0].duration;
+			param->opp_en.interval =3D noa_attr.desc[0].interval;
+			param->opp_en.start_time =3D noa_attr.desc[0].start_time;
+		} else {
+			param->opp_enabled =3D 0;
+			param->opp_dis.cnt =3D noa_attr.desc[0].count;
+			param->opp_dis.duration =3D noa_attr.desc[0].duration;
+			param->opp_dis.interval =3D noa_attr.desc[0].interval;
+			param->opp_dis.start_time =3D noa_attr.desc[0].start_time;
+		}
+	}
+	wmm_ie =3D cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+					 WLAN_OUI_TYPE_MICROSOFT_WMM,
+					 ies->data, ies->len);
+	if (wmm_ie) {
+		struct ieee80211_wmm_param_ie *ie;
+
+		ie =3D (struct ieee80211_wmm_param_ie *)wmm_ie;
+		if ((ie->oui_subtype =3D=3D 0 || ie->oui_subtype =3D=3D 1) &&
+		    ie->version =3D=3D 1) {
+			param->wmm_cap =3D true;
+			if (ie->qos_info & BIT(7))
+				param->uapsd_cap =3D true;
+		}
+	}
+
+	wpa_ie =3D cfg80211_find_vendor_ie(WLAN_OUI_MICROSOFT,
+					 WLAN_OUI_TYPE_MICROSOFT_WPA,
+					 ies->data, ies->len);
+	if (wpa_ie) {
+		param->mode_802_11i =3D 1;
+		param->rsn_found =3D true;
+	}
+
+	rsn_ie =3D cfg80211_find_ie(WLAN_EID_RSN, ies->data, ies->len);
+	if (rsn_ie) {
+		int offset =3D 8;
+
+		param->mode_802_11i =3D 2;
+		param->rsn_found =3D true;
+		//extract RSN capabilities
+		offset +=3D (rsn_ie[offset] * 4) + 2;
+		offset +=3D (rsn_ie[offset] * 4) + 2;
+		memcpy(param->rsn_cap, &rsn_ie[offset], 2);
+	}
+
+	if (param->rsn_found) {
+		int i;
+
+		param->rsn_grp_policy =3D crypto->cipher_group & 0xFF;
+		for (i =3D 0; i < crypto->n_ciphers_pairwise && i < 3; i++)
+			param->p_suites[i] =3D crypto->ciphers_pairwise[i] & 0xFF;
+
+		for (i =3D 0; i < crypto->n_akm_suites && i < 3; i++)
+			param->akm_suites[i] =3D crypto->akm_suites[i] & 0xFF;
+	}
+
+	return (void *)param;
+}
+
+static void handle_rcvd_ntwrk_info(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc_rcvd_net_info *rcvd_info =3D &msg->body.net_info;
+	struct wilc_user_scan_req *scan_req =3D &msg->vif->hif_drv->usr_scan_req;
+	const u8 *ch_elm;
+	u8 *ies;
+	int ies_len;
+	size_t offset;
+
+	if (ieee80211_is_probe_resp(rcvd_info->mgmt->frame_control))
+		offset =3D offsetof(struct ieee80211_mgmt, u.probe_resp.variable);
+	else if (ieee80211_is_beacon(rcvd_info->mgmt->frame_control))
+		offset =3D offsetof(struct ieee80211_mgmt, u.beacon.variable);
+	else
+		goto done;
+
+	ies =3D rcvd_info->mgmt->u.beacon.variable;
+	ies_len =3D rcvd_info->frame_len - offset;
+	if (ies_len <=3D 0)
+		goto done;
+
+	ch_elm =3D cfg80211_find_ie(WLAN_EID_DS_PARAMS, ies, ies_len);
+	if (ch_elm && ch_elm[1] > 0)
+		rcvd_info->ch =3D ch_elm[2];
+
+	if (scan_req->scan_result)
+		scan_req->scan_result(SCAN_EVENT_NETWORK_FOUND, rcvd_info,
+				      scan_req->arg);
+
+done:
+	kfree(rcvd_info->mgmt);
+	kfree(msg);
+}
+
+static void host_int_get_assoc_res_info(struct wilc_vif *vif,
+					u8 *assoc_resp_info,
+					u32 max_assoc_resp_info_len,
+					u32 *rcvd_assoc_resp_info_len)
+{
+	int result;
+	struct wid wid;
+
+	wid.id =3D WID_ASSOC_RES_INFO;
+	wid.type =3D WID_STR;
+	wid.val =3D assoc_resp_info;
+	wid.size =3D max_assoc_resp_info_len;
+
+	result =3D wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
+	if (result) {
+		*rcvd_assoc_resp_info_len =3D 0;
+		netdev_err(vif->ndev, "Failed to send association response\n");
+		return;
+	}
+
+	*rcvd_assoc_resp_info_len =3D wid.size;
+}
+
+static s32 wilc_parse_assoc_resp_info(u8 *buffer, u32 buffer_len,
+				      struct wilc_conn_info *ret_conn_info)
+{
+	u8 *ies;
+	u16 ies_len;
+	struct assoc_resp *res =3D (struct assoc_resp *)buffer;
+
+	ret_conn_info->status =3D le16_to_cpu(res->status_code);
+	if (ret_conn_info->status =3D=3D WLAN_STATUS_SUCCESS) {
+		ies =3D &buffer[sizeof(*res)];
+		ies_len =3D buffer_len - sizeof(*res);
+
+		ret_conn_info->resp_ies =3D kmemdup(ies, ies_len, GFP_KERNEL);
+		if (!ret_conn_info->resp_ies)
+			return -ENOMEM;
+
+		ret_conn_info->resp_ies_len =3D ies_len;
+	}
+
+	return 0;
+}
+
+static inline void host_int_parse_assoc_resp_info(struct wilc_vif *vif,
+						  u8 mac_status)
+{
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_conn_info *conn_info =3D &hif_drv->conn_info;
+
+	if (mac_status =3D=3D WILC_MAC_STATUS_CONNECTED) {
+		u32 assoc_resp_info_len;
+
+		memset(hif_drv->assoc_resp, 0, WILC_MAX_ASSOC_RESP_FRAME_SIZE);
+
+		host_int_get_assoc_res_info(vif, hif_drv->assoc_resp,
+					    WILC_MAX_ASSOC_RESP_FRAME_SIZE,
+					    &assoc_resp_info_len);
+
+		if (assoc_resp_info_len !=3D 0) {
+			s32 err =3D 0;
+
+			err =3D wilc_parse_assoc_resp_info(hif_drv->assoc_resp,
+							 assoc_resp_info_len,
+							 conn_info);
+			if (err)
+				netdev_err(vif->ndev,
+					   "wilc_parse_assoc_resp_info() returned error %d\n",
+					   err);
+		}
+	}
+
+	del_timer(&hif_drv->connect_timer);
+	conn_info->conn_result(CONN_DISCONN_EVENT_CONN_RESP, mac_status,
+			       hif_drv->conn_info.arg);
+
+	if (mac_status =3D=3D WILC_MAC_STATUS_CONNECTED &&
+	    conn_info->status =3D=3D WLAN_STATUS_SUCCESS) {
+		ether_addr_copy(hif_drv->assoc_bssid, conn_info->bssid);
+		wilc_set_power_mgmt(vif, 0, 0);
+
+		hif_drv->hif_state =3D HOST_IF_CONNECTED;
+
+		vif->obtaining_ip =3D true;
+		mod_timer(&vif->during_ip_timer,
+			  jiffies + msecs_to_jiffies(10000));
+	} else {
+		hif_drv->hif_state =3D HOST_IF_IDLE;
+	}
+
+	kfree(conn_info->resp_ies);
+	conn_info->resp_ies =3D NULL;
+	conn_info->resp_ies_len =3D 0;
+
+	kfree(conn_info->req_ies);
+	conn_info->req_ies =3D NULL;
+	conn_info->req_ies_len =3D 0;
+}
+
+static inline void host_int_handle_disconnect(struct wilc_vif *vif)
+{
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (hif_drv->usr_scan_req.scan_result) {
+		del_timer(&hif_drv->scan_timer);
+		handle_scan_done(vif, SCAN_EVENT_ABORTED);
+	}
+
+	if (hif_drv->conn_info.conn_result) {
+		vif->obtaining_ip =3D false;
+		wilc_set_power_mgmt(vif, 0, 0);
+
+		hif_drv->conn_info.conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF,
+					       0, hif_drv->conn_info.arg);
+	} else {
+		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
+	}
+
+	eth_zero_addr(hif_drv->assoc_bssid);
+
+	hif_drv->conn_info.req_ies_len =3D 0;
+	kfree(hif_drv->conn_info.req_ies);
+	hif_drv->conn_info.req_ies =3D NULL;
+	hif_drv->hif_state =3D HOST_IF_IDLE;
+}
+
+static void handle_rcvd_gnrl_async_info(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc_vif *vif =3D msg->vif;
+	struct wilc_rcvd_mac_info *mac_info =3D &msg->body.mac_info;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL\n", __func__);
+		goto free_msg;
+	}
+
+	if (!hif_drv->conn_info.conn_result) {
+		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
+		goto free_msg;
+	}
+
+	if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP) {
+		host_int_parse_assoc_resp_info(vif, mac_info->status);
+	} else if (mac_info->status =3D=3D WILC_MAC_STATUS_DISCONNECTED) {
+		if (hif_drv->hif_state =3D=3D HOST_IF_CONNECTED) {
+			host_int_handle_disconnect(vif);
+		} else if (hif_drv->usr_scan_req.scan_result) {
+			del_timer(&hif_drv->scan_timer);
+			handle_scan_done(vif, SCAN_EVENT_ABORTED);
+		}
+	}
+
+free_msg:
+	kfree(msg);
+}
+
+int wilc_disconnect(struct wilc_vif *vif)
+{
+	struct wid wid;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_user_scan_req *scan_req;
+	struct wilc_conn_info *conn_info;
+	int result;
+	u16 dummy_reason_code =3D 0;
+
+	wid.id =3D WID_DISCONNECT;
+	wid.type =3D WID_CHAR;
+	wid.val =3D (s8 *)&dummy_reason_code;
+	wid.size =3D sizeof(char);
+
+	vif->obtaining_ip =3D false;
+	wilc_set_power_mgmt(vif, 0, 0);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result) {
+		netdev_err(vif->ndev, "Failed to send disconnect\n");
+		return result;
+	}
+
+	scan_req =3D &hif_drv->usr_scan_req;
+	conn_info =3D &hif_drv->conn_info;
+
+	if (scan_req->scan_result) {
+		del_timer(&hif_drv->scan_timer);
+		scan_req->scan_result(SCAN_EVENT_ABORTED, NULL, scan_req->arg);
+		scan_req->scan_result =3D NULL;
+	}
+
+	if (conn_info->conn_result) {
+		if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP)
+			del_timer(&hif_drv->connect_timer);
+
+		conn_info->conn_result(CONN_DISCONN_EVENT_DISCONN_NOTIF, 0,
+				       conn_info->arg);
+	} else {
+		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
+	}
+
+	hif_drv->hif_state =3D HOST_IF_IDLE;
+
+	eth_zero_addr(hif_drv->assoc_bssid);
+
+	conn_info->req_ies_len =3D 0;
+	kfree(conn_info->req_ies);
+	conn_info->req_ies =3D NULL;
+
+	return 0;
+}
+
+void wilc_resolve_disconnect_aberration(struct wilc_vif *vif)
+{
+	if (!vif->hif_drv)
+		return;
+	if (vif->hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP ||
+	    vif->hif_drv->hif_state =3D=3D HOST_IF_CONNECTING)
+		wilc_disconnect(vif);
+}
+
+int wilc_get_statistics(struct wilc_vif *vif, struct rf_info *stats)
+{
+	struct wid wid_list[5];
+	u32 wid_cnt =3D 0, result;
+
+	wid_list[wid_cnt].id =3D WID_LINKSPEED;
+	wid_list[wid_cnt].type =3D WID_CHAR;
+	wid_list[wid_cnt].size =3D sizeof(char);
+	wid_list[wid_cnt].val =3D (s8 *)&stats->link_speed;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_RSSI;
+	wid_list[wid_cnt].type =3D WID_CHAR;
+	wid_list[wid_cnt].size =3D sizeof(char);
+	wid_list[wid_cnt].val =3D (s8 *)&stats->rssi;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_SUCCESS_FRAME_COUNT;
+	wid_list[wid_cnt].type =3D WID_INT;
+	wid_list[wid_cnt].size =3D sizeof(u32);
+	wid_list[wid_cnt].val =3D (s8 *)&stats->tx_cnt;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_RECEIVED_FRAGMENT_COUNT;
+	wid_list[wid_cnt].type =3D WID_INT;
+	wid_list[wid_cnt].size =3D sizeof(u32);
+	wid_list[wid_cnt].val =3D (s8 *)&stats->rx_cnt;
+	wid_cnt++;
+
+	wid_list[wid_cnt].id =3D WID_FAILED_COUNT;
+	wid_list[wid_cnt].type =3D WID_INT;
+	wid_list[wid_cnt].size =3D sizeof(u32);
+	wid_list[wid_cnt].val =3D (s8 *)&stats->tx_fail_cnt;
+	wid_cnt++;
+
+	result =3D wilc_send_config_pkt(vif, WILC_GET_CFG, wid_list, wid_cnt);
+	if (result) {
+		netdev_err(vif->ndev, "Failed to send scan parameters\n");
+		return result;
+	}
+
+	if (stats->link_speed > TCP_ACK_FILTER_LINK_SPEED_THRESH &&
+	    stats->link_speed !=3D DEFAULT_LINK_SPEED)
+		wilc_enable_tcp_ack_filter(vif, true);
+	else if (stats->link_speed !=3D DEFAULT_LINK_SPEED)
+		wilc_enable_tcp_ack_filter(vif, false);
+
+	return result;
+}
+
+static void handle_get_statistics(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc_vif *vif =3D msg->vif;
+	struct rf_info *stats =3D (struct rf_info *)msg->body.data;
+
+	wilc_get_statistics(vif, stats);
+
+	kfree(msg);
+}
+
+static void wilc_hif_pack_sta_param(u8 *cur_byte, const u8 *mac,
+				    struct station_parameters *params)
+{
+	ether_addr_copy(cur_byte, mac);
+	cur_byte +=3D ETH_ALEN;
+
+	put_unaligned_le16(params->aid, cur_byte);
+	cur_byte +=3D 2;
+
+	*cur_byte++ =3D params->supported_rates_len;
+	if (params->supported_rates_len > 0)
+		memcpy(cur_byte, params->supported_rates,
+		       params->supported_rates_len);
+	cur_byte +=3D params->supported_rates_len;
+
+	if (params->ht_capa) {
+		*cur_byte++ =3D true;
+		memcpy(cur_byte, &params->ht_capa,
+		       sizeof(struct ieee80211_ht_cap));
+	} else {
+		*cur_byte++ =3D false;
+	}
+	cur_byte +=3D sizeof(struct ieee80211_ht_cap);
+
+	put_unaligned_le16(params->sta_flags_mask, cur_byte);
+	cur_byte +=3D 2;
+	put_unaligned_le16(params->sta_flags_set, cur_byte);
+}
+
+static int handle_remain_on_chan(struct wilc_vif *vif,
+				 struct wilc_remain_ch *hif_remain_ch)
+{
+	int result;
+	u8 remain_on_chan_flag;
+	struct wid wid;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (hif_drv->usr_scan_req.scan_result)
+		return -EBUSY;
+
+	if (hif_drv->hif_state =3D=3D HOST_IF_WAITING_CONN_RESP)
+		return -EBUSY;
+
+	if (vif->obtaining_ip || vif->connecting)
+		return -EBUSY;
+
+	remain_on_chan_flag =3D true;
+	wid.id =3D WID_REMAIN_ON_CHAN;
+	wid.type =3D WID_STR;
+	wid.size =3D 2;
+	wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	wid.val[0] =3D remain_on_chan_flag;
+	wid.val[1] =3D (s8)hif_remain_ch->ch;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	kfree(wid.val);
+	if (result)
+		return -EBUSY;
+
+	hif_drv->remain_on_ch.arg =3D hif_remain_ch->arg;
+	hif_drv->remain_on_ch.expired =3D hif_remain_ch->expired;
+	hif_drv->remain_on_ch.ch =3D hif_remain_ch->ch;
+	hif_drv->remain_on_ch.cookie =3D hif_remain_ch->cookie;
+	hif_drv->remain_on_ch_timer_vif =3D vif;
+
+	return 0;
+}
+
+static int wilc_handle_roc_expired(struct wilc_vif *vif, u64 cookie)
+{
+	u8 remain_on_chan_flag;
+	struct wid wid;
+	int result;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_priv *priv =3D wdev_priv(vif->ndev->ieee80211_ptr);
+
+	if (priv->p2p_listen_state) {
+		remain_on_chan_flag =3D false;
+		wid.id =3D WID_REMAIN_ON_CHAN;
+		wid.type =3D WID_STR;
+		wid.size =3D 2;
+
+		wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+		if (!wid.val)
+			return -ENOMEM;
+
+		wid.val[0] =3D remain_on_chan_flag;
+		wid.val[1] =3D WILC_FALSE_FRMWR_CHANNEL;
+
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+		kfree(wid.val);
+		if (result !=3D 0) {
+			netdev_err(vif->ndev, "Failed to set remain channel\n");
+			return -EINVAL;
+		}
+
+		if (hif_drv->remain_on_ch.expired) {
+			hif_drv->remain_on_ch.expired(hif_drv->remain_on_ch.arg,
+						      cookie);
+		}
+	} else {
+		netdev_dbg(vif->ndev, "Not in listen state\n");
+	}
+
+	return 0;
+}
+
+static void wilc_handle_listen_state_expired(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+
+	wilc_handle_roc_expired(msg->vif, msg->body.remain_on_ch.cookie);
+	kfree(msg);
+}
+
+static void listen_timer_cb(struct timer_list *t)
+{
+	struct host_if_drv *hif_drv =3D from_timer(hif_drv, t,
+						      remain_on_ch_timer);
+	struct wilc_vif *vif =3D hif_drv->remain_on_ch_timer_vif;
+	int result;
+	struct host_if_msg *msg;
+
+	del_timer(&vif->hif_drv->remain_on_ch_timer);
+
+	msg =3D wilc_alloc_work(vif, wilc_handle_listen_state_expired, false);
+	if (IS_ERR(msg))
+		return;
+
+	msg->body.remain_on_ch.cookie =3D vif->hif_drv->remain_on_ch.cookie;
+
+	result =3D wilc_enqueue_work(msg);
+	if (result) {
+		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
+		kfree(msg);
+	}
+}
+
+static void handle_set_mcast_filter(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc_vif *vif =3D msg->vif;
+	struct wilc_set_multicast *set_mc =3D &msg->body.mc_info;
+	int result;
+	struct wid wid;
+	u8 *cur_byte;
+
+	wid.id =3D WID_SETUP_MULTICAST_FILTER;
+	wid.type =3D WID_BIN;
+	wid.size =3D sizeof(struct wilc_set_multicast) + (set_mc->cnt * ETH_ALEN)=
;
+	wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		goto error;
+
+	cur_byte =3D wid.val;
+	put_unaligned_le32(set_mc->enabled, cur_byte);
+	cur_byte +=3D 4;
+
+	put_unaligned_le32(set_mc->cnt, cur_byte);
+	cur_byte +=3D 4;
+
+	if (set_mc->cnt > 0 && set_mc->mc_list)
+		memcpy(cur_byte, set_mc->mc_list, set_mc->cnt * ETH_ALEN);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send setup multicast\n");
+
+error:
+	kfree(set_mc->mc_list);
+	kfree(wid.val);
+	kfree(msg);
+}
+
+static void handle_scan_timer(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+
+	handle_scan_done(msg->vif, SCAN_EVENT_ABORTED);
+	kfree(msg);
+}
+
+static void handle_scan_complete(struct work_struct *work)
+{
+	struct host_if_msg *msg =3D container_of(work, struct host_if_msg, work);
+	struct wilc *wilc =3D msg->vif->wilc;
+
+	del_timer(&msg->vif->hif_drv->scan_timer);
+
+	if (!wilc_wlan_get_num_conn_ifcs(wilc))
+		wilc_chip_sleep_manually(wilc);
+
+	handle_scan_done(msg->vif, SCAN_EVENT_DONE);
+
+	kfree(msg);
+}
+
+static void timer_scan_cb(struct timer_list *t)
+{
+	struct host_if_drv *hif_drv =3D from_timer(hif_drv, t, scan_timer);
+	struct wilc_vif *vif =3D hif_drv->scan_timer_vif;
+	struct host_if_msg *msg;
+	int result;
+
+	msg =3D wilc_alloc_work(vif, handle_scan_timer, false);
+	if (IS_ERR(msg))
+		return;
+
+	result =3D wilc_enqueue_work(msg);
+	if (result)
+		kfree(msg);
+}
+
+static void timer_connect_cb(struct timer_list *t)
+{
+	struct host_if_drv *hif_drv =3D from_timer(hif_drv, t,
+						      connect_timer);
+	struct wilc_vif *vif =3D hif_drv->connect_timer_vif;
+	struct host_if_msg *msg;
+	int result;
+
+	msg =3D wilc_alloc_work(vif, handle_connect_timeout, false);
+	if (IS_ERR(msg))
+		return;
+
+	result =3D wilc_enqueue_work(msg);
+	if (result)
+		kfree(msg);
+}
+
+int wilc_remove_wep_key(struct wilc_vif *vif, u8 index)
+{
+	struct wid wid;
+	int result;
+
+	wid.id =3D WID_REMOVE_WEP_KEY;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(char);
+	wid.val =3D &index;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev,
+			   "Failed to send remove wep key config packet\n");
+	return result;
+}
+
+int wilc_set_wep_default_keyid(struct wilc_vif *vif, u8 index)
+{
+	struct wid wid;
+	int result;
+
+	wid.id =3D WID_KEY_ID;
+	wid.type =3D WID_CHAR;
+	wid.size =3D sizeof(char);
+	wid.val =3D &index;
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev,
+			   "Failed to send wep default key config packet\n");
+
+	return result;
+}
+
+int wilc_add_wep_key_bss_sta(struct wilc_vif *vif, const u8 *key, u8 len,
+			     u8 index)
+{
+	struct wid wid;
+	int result;
+	struct wilc_wep_key *wep_key;
+
+	wid.id =3D WID_ADD_WEP_KEY;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(*wep_key) + len;
+	wep_key =3D kzalloc(wid.size, GFP_KERNEL);
+	if (!wep_key)
+		return -ENOMEM;
+
+	wid.val =3D (u8 *)wep_key;
+
+	wep_key->index =3D index;
+	wep_key->key_len =3D len;
+	memcpy(wep_key->key, key, len);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev,
+			   "Failed to add wep key config packet\n");
+
+	kfree(wep_key);
+	return result;
+}
+
+int wilc_add_wep_key_bss_ap(struct wilc_vif *vif, const u8 *key, u8 len,
+			    u8 index, u8 mode, enum authtype auth_type)
+{
+	struct wid wid_list[3];
+	int result;
+	struct wilc_wep_key *wep_key;
+
+	wid_list[0].id =3D WID_11I_MODE;
+	wid_list[0].type =3D WID_CHAR;
+	wid_list[0].size =3D sizeof(char);
+	wid_list[0].val =3D &mode;
+
+	wid_list[1].id =3D WID_AUTH_TYPE;
+	wid_list[1].type =3D WID_CHAR;
+	wid_list[1].size =3D sizeof(char);
+	wid_list[1].val =3D (s8 *)&auth_type;
+
+	wid_list[2].id =3D WID_WEP_KEY_VALUE;
+	wid_list[2].type =3D WID_STR;
+	wid_list[2].size =3D sizeof(*wep_key) + len;
+	wep_key =3D kzalloc(wid_list[2].size, GFP_KERNEL);
+	if (!wep_key)
+		return -ENOMEM;
+
+	wid_list[2].val =3D (u8 *)wep_key;
+
+	wep_key->index =3D index;
+	wep_key->key_len =3D len;
+	memcpy(wep_key->key, key, len);
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
+				      ARRAY_SIZE(wid_list));
+	if (result)
+		netdev_err(vif->ndev,
+			   "Failed to add wep ap key config packet\n");
+
+	kfree(wep_key);
+	return result;
+}
+
+int wilc_add_ptk(struct wilc_vif *vif, const u8 *ptk, u8 ptk_key_len,
+		 const u8 *mac_addr, const u8 *rx_mic, const u8 *tx_mic,
+		 u8 mode, u8 cipher_mode, u8 index)
+{
+	int result =3D 0;
+	u8 t_key_len  =3D ptk_key_len + WILC_RX_MIC_KEY_LEN + WILC_TX_MIC_KEY_LEN=
;
+
+	if (mode =3D=3D WILC_AP_MODE) {
+		struct wid wid_list[2];
+		struct wilc_ap_wpa_ptk *key_buf;
+
+		wid_list[0].id =3D WID_11I_MODE;
+		wid_list[0].type =3D WID_CHAR;
+		wid_list[0].size =3D sizeof(char);
+		wid_list[0].val =3D (s8 *)&cipher_mode;
+
+		key_buf =3D kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+		if (!key_buf)
+			return -ENOMEM;
+
+		ether_addr_copy(key_buf->mac_addr, mac_addr);
+		key_buf->index =3D index;
+		key_buf->key_len =3D t_key_len;
+		memcpy(&key_buf->key[0], ptk, ptk_key_len);
+
+		if (rx_mic)
+			memcpy(&key_buf->key[ptk_key_len], rx_mic,
+			       WILC_RX_MIC_KEY_LEN);
+
+		if (tx_mic)
+			memcpy(&key_buf->key[ptk_key_len + WILC_RX_MIC_KEY_LEN],
+			       tx_mic, WILC_TX_MIC_KEY_LEN);
+
+		wid_list[1].id =3D WID_ADD_PTK;
+		wid_list[1].type =3D WID_STR;
+		wid_list[1].size =3D sizeof(*key_buf) + t_key_len;
+		wid_list[1].val =3D (u8 *)key_buf;
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
+					      ARRAY_SIZE(wid_list));
+		kfree(key_buf);
+	} else if (mode =3D=3D WILC_STATION_MODE) {
+		struct wid wid;
+		struct wilc_sta_wpa_ptk *key_buf;
+
+		key_buf =3D kzalloc(sizeof(*key_buf) + t_key_len, GFP_KERNEL);
+		if (!key_buf)
+			return -ENOMEM;
+
+		ether_addr_copy(key_buf->mac_addr, mac_addr);
+		key_buf->key_len =3D t_key_len;
+		memcpy(&key_buf->key[0], ptk, ptk_key_len);
+
+		if (rx_mic)
+			memcpy(&key_buf->key[ptk_key_len], rx_mic,
+			       WILC_RX_MIC_KEY_LEN);
+
+		if (tx_mic)
+			memcpy(&key_buf->key[ptk_key_len + WILC_RX_MIC_KEY_LEN],
+			       tx_mic, WILC_TX_MIC_KEY_LEN);
+
+		wid.id =3D WID_ADD_PTK;
+		wid.type =3D WID_STR;
+		wid.size =3D sizeof(*key_buf) + t_key_len;
+		wid.val =3D (s8 *)key_buf;
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+		kfree(key_buf);
+	}
+
+	return result;
+}
+
+int wilc_add_rx_gtk(struct wilc_vif *vif, const u8 *rx_gtk, u8 gtk_key_len=
,
+		    u8 index, u32 key_rsc_len, const u8 *key_rsc,
+		    const u8 *rx_mic, const u8 *tx_mic, u8 mode,
+		    u8 cipher_mode)
+{
+	int result =3D 0;
+	struct wilc_gtk_key *gtk_key;
+	int t_key_len =3D gtk_key_len + WILC_RX_MIC_KEY_LEN + WILC_TX_MIC_KEY_LEN=
;
+
+	gtk_key =3D kzalloc(sizeof(*gtk_key) + t_key_len, GFP_KERNEL);
+	if (!gtk_key)
+		return -ENOMEM;
+
+	/* fill bssid value only in station mode */
+	if (mode =3D=3D WILC_STATION_MODE &&
+	    vif->hif_drv->hif_state =3D=3D HOST_IF_CONNECTED)
+		memcpy(gtk_key->mac_addr, vif->hif_drv->assoc_bssid, ETH_ALEN);
+
+	if (key_rsc)
+		memcpy(gtk_key->rsc, key_rsc, 8);
+	gtk_key->index =3D index;
+	gtk_key->key_len =3D t_key_len;
+	memcpy(&gtk_key->key[0], rx_gtk, gtk_key_len);
+
+	if (rx_mic)
+		memcpy(&gtk_key->key[gtk_key_len], rx_mic, WILC_RX_MIC_KEY_LEN);
+
+	if (tx_mic)
+		memcpy(&gtk_key->key[gtk_key_len + WILC_RX_MIC_KEY_LEN],
+		       tx_mic, WILC_TX_MIC_KEY_LEN);
+
+	if (mode =3D=3D WILC_AP_MODE) {
+		struct wid wid_list[2];
+
+		wid_list[0].id =3D WID_11I_MODE;
+		wid_list[0].type =3D WID_CHAR;
+		wid_list[0].size =3D sizeof(char);
+		wid_list[0].val =3D (s8 *)&cipher_mode;
+
+		wid_list[1].id =3D WID_ADD_RX_GTK;
+		wid_list[1].type =3D WID_STR;
+		wid_list[1].size =3D sizeof(*gtk_key) + t_key_len;
+		wid_list[1].val =3D (u8 *)gtk_key;
+
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list,
+					      ARRAY_SIZE(wid_list));
+	} else if (mode =3D=3D WILC_STATION_MODE) {
+		struct wid wid;
+
+		wid.id =3D WID_ADD_RX_GTK;
+		wid.type =3D WID_STR;
+		wid.size =3D sizeof(*gtk_key) + t_key_len;
+		wid.val =3D (u8 *)gtk_key;
+		result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	}
+
+	kfree(gtk_key);
+	return result;
+}
+
+int wilc_set_pmkid_info(struct wilc_vif *vif, struct wilc_pmkid_attr *pmki=
d)
+{
+	struct wid wid;
+
+	wid.id =3D WID_PMKID_INFO;
+	wid.type =3D WID_STR;
+	wid.size =3D (pmkid->numpmkid * sizeof(struct wilc_pmkid)) + 1;
+	wid.val =3D (u8 *)pmkid;
+
+	return wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+}
+
+int wilc_get_mac_address(struct wilc_vif *vif, u8 *mac_addr)
+{
+	int result;
+	struct wid wid;
+
+	wid.id =3D WID_MAC_ADDR;
+	wid.type =3D WID_STR;
+	wid.size =3D ETH_ALEN;
+	wid.val =3D mac_addr;
+
+	result =3D wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to get mac address\n");
+
+	return result;
+}
+
+int wilc_set_join_req(struct wilc_vif *vif, u8 *bssid, const u8 *ies,
+		      size_t ies_len)
+{
+	int result;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	struct wilc_conn_info *conn_info =3D &hif_drv->conn_info;
+
+	if (bssid)
+		ether_addr_copy(conn_info->bssid, bssid);
+
+	if (ies) {
+		conn_info->req_ies_len =3D ies_len;
+		conn_info->req_ies =3D kmemdup(ies, ies_len, GFP_KERNEL);
+		if (!conn_info->req_ies)
+			return -ENOMEM;
+	}
+
+	result =3D wilc_send_connect_wid(vif);
+	if (result)
+		goto free_ies;
+
+	hif_drv->connect_timer_vif =3D vif;
+	mod_timer(&hif_drv->connect_timer,
+		  jiffies + msecs_to_jiffies(WILC_HIF_CONNECT_TIMEOUT_MS));
+
+	return 0;
+
+free_ies:
+	kfree(conn_info->req_ies);
+
+	return result;
+}
+
+int wilc_set_mac_chnl_num(struct wilc_vif *vif, u8 channel)
+{
+	struct wid wid;
+	int result;
+
+	wid.id =3D WID_CURRENT_CHANNEL;
+	wid.type =3D WID_CHAR;
+	wid.size =3D sizeof(char);
+	wid.val =3D &channel;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to set channel\n");
+
+	return result;
+}
+
+int wilc_set_wfi_drv_handler(struct wilc_vif *vif, int index, u8 mode,
+			     u8 ifc_id)
+{
+	struct wid wid;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+	int result;
+	struct wilc_drv_handler drv;
+
+	if (!hif_drv)
+		return -EFAULT;
+
+	wid.id =3D WID_SET_DRV_HANDLER;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(drv);
+	wid.val =3D (u8 *)&drv;
+
+	drv.handler =3D cpu_to_le32(index);
+	drv.mode =3D (ifc_id | (mode << 1));
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to set driver handler\n");
+
+	return result;
+}
+
+int wilc_set_operation_mode(struct wilc_vif *vif, u32 mode)
+{
+	struct wid wid;
+	struct wilc_op_mode op_mode;
+	int result;
+
+	wid.id =3D WID_SET_OPERATION_MODE;
+	wid.type =3D WID_INT;
+	wid.size =3D sizeof(op_mode);
+	wid.val =3D (u8 *)&op_mode;
+
+	op_mode.mode =3D cpu_to_le32(mode);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to set operation mode\n");
+
+	return result;
+}
+
+s32 wilc_get_inactive_time(struct wilc_vif *vif, const u8 *mac, u32 *out_v=
al)
+{
+	struct wid wid;
+	s32 result;
+
+	wid.id =3D WID_SET_STA_MAC_INACTIVE_TIME;
+	wid.type =3D WID_STR;
+	wid.size =3D ETH_ALEN;
+	wid.val =3D kzalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	ether_addr_copy(wid.val, mac);
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	kfree(wid.val);
+	if (result) {
+		netdev_err(vif->ndev, "Failed to set inactive mac\n");
+		return result;
+	}
+
+	wid.id =3D WID_GET_INACTIVE_TIME;
+	wid.type =3D WID_INT;
+	wid.val =3D (s8 *)out_val;
+	wid.size =3D sizeof(u32);
+	result =3D wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to get inactive time\n");
+
+	return result;
+}
+
+int wilc_get_rssi(struct wilc_vif *vif, s8 *rssi_level)
+{
+	struct wid wid;
+	int result;
+
+	if (!rssi_level) {
+		netdev_err(vif->ndev, "%s: RSSI level is NULL\n", __func__);
+		return -EFAULT;
+	}
+
+	wid.id =3D WID_RSSI;
+	wid.type =3D WID_CHAR;
+	wid.size =3D sizeof(char);
+	wid.val =3D rssi_level;
+	result =3D wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to get RSSI value\n");
+
+	return result;
+}
+
+static int wilc_get_stats_async(struct wilc_vif *vif, struct rf_info *stat=
s)
+{
+	int result;
+	struct host_if_msg *msg;
+
+	msg =3D wilc_alloc_work(vif, handle_get_statistics, false);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	msg->body.data =3D (char *)stats;
+
+	result =3D wilc_enqueue_work(msg);
+	if (result) {
+		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
+		kfree(msg);
+		return result;
+	}
+
+	return result;
+}
+
+int wilc_hif_set_cfg(struct wilc_vif *vif, struct cfg_param_attr *param)
+{
+	struct wid wid_list[4];
+	int i =3D 0;
+
+	if (param->flag & WILC_CFG_PARAM_RETRY_SHORT) {
+		wid_list[i].id =3D WID_SHORT_RETRY_LIMIT;
+		wid_list[i].val =3D (s8 *)&param->short_retry_limit;
+		wid_list[i].type =3D WID_SHORT;
+		wid_list[i].size =3D sizeof(u16);
+		i++;
+	}
+	if (param->flag & WILC_CFG_PARAM_RETRY_LONG) {
+		wid_list[i].id =3D WID_LONG_RETRY_LIMIT;
+		wid_list[i].val =3D (s8 *)&param->long_retry_limit;
+		wid_list[i].type =3D WID_SHORT;
+		wid_list[i].size =3D sizeof(u16);
+		i++;
+	}
+	if (param->flag & WILC_CFG_PARAM_FRAG_THRESHOLD) {
+		wid_list[i].id =3D WID_FRAG_THRESHOLD;
+		wid_list[i].val =3D (s8 *)&param->frag_threshold;
+		wid_list[i].type =3D WID_SHORT;
+		wid_list[i].size =3D sizeof(u16);
+		i++;
+	}
+	if (param->flag & WILC_CFG_PARAM_RTS_THRESHOLD) {
+		wid_list[i].id =3D WID_RTS_THRESHOLD;
+		wid_list[i].val =3D (s8 *)&param->rts_threshold;
+		wid_list[i].type =3D WID_SHORT;
+		wid_list[i].size =3D sizeof(u16);
+		i++;
+	}
+
+	return wilc_send_config_pkt(vif, WILC_SET_CFG, wid_list, i);
+}
+
+static void get_periodic_rssi(struct timer_list *t)
+{
+	struct wilc_vif *vif =3D from_timer(vif, t, periodic_rssi);
+
+	if (!vif->hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL", __func__);
+		return;
+	}
+
+	if (vif->hif_drv->hif_state =3D=3D HOST_IF_CONNECTED)
+		wilc_get_stats_async(vif, &vif->periodic_stat);
+
+	mod_timer(&vif->periodic_rssi, jiffies + msecs_to_jiffies(5000));
+}
+
+int wilc_init(struct net_device *dev, struct host_if_drv **hif_drv_handler=
)
+{
+	struct host_if_drv *hif_drv;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	hif_drv  =3D kzalloc(sizeof(*hif_drv), GFP_KERNEL);
+	if (!hif_drv)
+		return -ENOMEM;
+
+	*hif_drv_handler =3D hif_drv;
+
+	vif->hif_drv =3D hif_drv;
+	vif->obtaining_ip =3D false;
+
+	if (wilc->clients_count =3D=3D 0)
+		mutex_init(&wilc->deinit_lock);
+
+	timer_setup(&vif->periodic_rssi, get_periodic_rssi, 0);
+	mod_timer(&vif->periodic_rssi, jiffies + msecs_to_jiffies(5000));
+
+	timer_setup(&hif_drv->scan_timer, timer_scan_cb, 0);
+	timer_setup(&hif_drv->connect_timer, timer_connect_cb, 0);
+	timer_setup(&hif_drv->remain_on_ch_timer, listen_timer_cb, 0);
+
+	hif_drv->hif_state =3D HOST_IF_IDLE;
+
+	hif_drv->p2p_timeout =3D 0;
+
+	wilc->clients_count++;
+
+	return 0;
+}
+
+int wilc_deinit(struct wilc_vif *vif)
+{
+	int result =3D 0;
+	struct host_if_drv *hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL", __func__);
+		return -EFAULT;
+	}
+
+	mutex_lock(&vif->wilc->deinit_lock);
+
+	del_timer_sync(&hif_drv->scan_timer);
+	del_timer_sync(&hif_drv->connect_timer);
+	del_timer_sync(&vif->periodic_rssi);
+	del_timer_sync(&hif_drv->remain_on_ch_timer);
+
+	wilc_set_wfi_drv_handler(vif, 0, 0, 0);
+
+	if (hif_drv->usr_scan_req.scan_result) {
+		hif_drv->usr_scan_req.scan_result(SCAN_EVENT_ABORTED, NULL,
+						  hif_drv->usr_scan_req.arg);
+		hif_drv->usr_scan_req.scan_result =3D NULL;
+	}
+
+	hif_drv->hif_state =3D HOST_IF_IDLE;
+
+	kfree(hif_drv);
+	vif->hif_drv =3D NULL;
+	vif->wilc->clients_count--;
+	mutex_unlock(&vif->wilc->deinit_lock);
+	return result;
+}
+
+void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
+{
+	int result;
+	struct host_if_msg *msg;
+	int id;
+	struct host_if_drv *hif_drv;
+	struct wilc_vif *vif;
+
+	id =3D get_unaligned_le32(&buffer[length - 4]);
+	vif =3D wilc_get_vif_from_idx(wilc, id);
+	if (!vif)
+		return;
+	hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv) {
+		netdev_err(vif->ndev, "driver not init[%p]\n", hif_drv);
+		return;
+	}
+
+	msg =3D wilc_alloc_work(vif, handle_rcvd_ntwrk_info, false);
+	if (IS_ERR(msg))
+		return;
+
+	msg->body.net_info.frame_len =3D get_unaligned_le16(&buffer[6]) - 1;
+	msg->body.net_info.rssi =3D buffer[8];
+	msg->body.net_info.mgmt =3D kmemdup(&buffer[9],
+					  msg->body.net_info.frame_len,
+					  GFP_KERNEL);
+	if (!msg->body.net_info.mgmt) {
+		kfree(msg);
+		return;
+	}
+
+	result =3D wilc_enqueue_work(msg);
+	if (result) {
+		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
+		kfree(msg->body.net_info.mgmt);
+		kfree(msg);
+	}
+}
+
+void wilc_gnrl_async_info_received(struct wilc *wilc, u8 *buffer, u32 leng=
th)
+{
+	int result;
+	struct host_if_msg *msg;
+	int id;
+	struct host_if_drv *hif_drv;
+	struct wilc_vif *vif;
+
+	mutex_lock(&wilc->deinit_lock);
+
+	id =3D get_unaligned_le32(&buffer[length - 4]);
+	vif =3D wilc_get_vif_from_idx(wilc, id);
+	if (!vif) {
+		mutex_unlock(&wilc->deinit_lock);
+		return;
+	}
+
+	hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv) {
+		mutex_unlock(&wilc->deinit_lock);
+		return;
+	}
+
+	if (!hif_drv->conn_info.conn_result) {
+		netdev_err(vif->ndev, "%s: conn_result is NULL\n", __func__);
+		mutex_unlock(&wilc->deinit_lock);
+		return;
+	}
+
+	msg =3D wilc_alloc_work(vif, handle_rcvd_gnrl_async_info, false);
+	if (IS_ERR(msg)) {
+		mutex_unlock(&wilc->deinit_lock);
+		return;
+	}
+
+	msg->body.mac_info.status =3D buffer[7];
+	result =3D wilc_enqueue_work(msg);
+	if (result) {
+		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
+		kfree(msg);
+	}
+
+	mutex_unlock(&wilc->deinit_lock);
+}
+
+void wilc_scan_complete_received(struct wilc *wilc, u8 *buffer, u32 length=
)
+{
+	int result;
+	int id;
+	struct host_if_drv *hif_drv;
+	struct wilc_vif *vif;
+
+	id =3D get_unaligned_le32(&buffer[length - 4]);
+	vif =3D wilc_get_vif_from_idx(wilc, id);
+	if (!vif)
+		return;
+	hif_drv =3D vif->hif_drv;
+
+	if (!hif_drv)
+		return;
+
+	if (hif_drv->usr_scan_req.scan_result) {
+		struct host_if_msg *msg;
+
+		msg =3D wilc_alloc_work(vif, handle_scan_complete, false);
+		if (IS_ERR(msg))
+			return;
+
+		result =3D wilc_enqueue_work(msg);
+		if (result) {
+			netdev_err(vif->ndev, "%s: enqueue work failed\n",
+				   __func__);
+			kfree(msg);
+		}
+	}
+}
+
+int wilc_remain_on_channel(struct wilc_vif *vif, u64 cookie,
+			   u32 duration, u16 chan,
+			   void (*expired)(void *, u64),
+			   void *user_arg)
+{
+	struct wilc_remain_ch roc;
+	int result;
+
+	roc.ch =3D chan;
+	roc.expired =3D expired;
+	roc.arg =3D user_arg;
+	roc.duration =3D duration;
+	roc.cookie =3D cookie;
+	result =3D handle_remain_on_chan(vif, &roc);
+	if (result)
+		netdev_err(vif->ndev, "%s: failed to set remain on channel\n",
+			   __func__);
+
+	return result;
+}
+
+int wilc_listen_state_expired(struct wilc_vif *vif, u64 cookie)
+{
+	if (!vif->hif_drv) {
+		netdev_err(vif->ndev, "%s: hif driver is NULL", __func__);
+		return -EFAULT;
+	}
+
+	del_timer(&vif->hif_drv->remain_on_ch_timer);
+
+	return wilc_handle_roc_expired(vif, cookie);
+}
+
+void wilc_frame_register(struct wilc_vif *vif, u16 frame_type, bool reg)
+{
+	struct wid wid;
+	int result;
+	struct wilc_reg_frame reg_frame;
+
+	wid.id =3D WID_REGISTER_FRAME;
+	wid.type =3D WID_STR;
+	wid.size =3D sizeof(reg_frame);
+	wid.val =3D (u8 *)&reg_frame;
+
+	memset(&reg_frame, 0x0, sizeof(reg_frame));
+	reg_frame.reg =3D reg;
+
+	switch (frame_type) {
+	case IEEE80211_STYPE_ACTION:
+		reg_frame.reg_id =3D WILC_FW_ACTION_FRM_IDX;
+		break;
+
+	case IEEE80211_STYPE_PROBE_REQ:
+		reg_frame.reg_id =3D WILC_FW_PROBE_REQ_IDX;
+		break;
+
+	default:
+		break;
+	}
+	reg_frame.frame_type =3D cpu_to_le16(frame_type);
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to frame register\n");
+}
+
+int wilc_add_beacon(struct wilc_vif *vif, u32 interval, u32 dtim_period,
+		    struct cfg80211_beacon_data *params)
+{
+	struct wid wid;
+	int result;
+	u8 *cur_byte;
+
+	wid.id =3D WID_ADD_BEACON;
+	wid.type =3D WID_BIN;
+	wid.size =3D params->head_len + params->tail_len + 16;
+	wid.val =3D kzalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	cur_byte =3D wid.val;
+	put_unaligned_le32(interval, cur_byte);
+	cur_byte +=3D 4;
+	put_unaligned_le32(dtim_period, cur_byte);
+	cur_byte +=3D 4;
+	put_unaligned_le32(params->head_len, cur_byte);
+	cur_byte +=3D 4;
+
+	if (params->head_len > 0)
+		memcpy(cur_byte, params->head, params->head_len);
+	cur_byte +=3D params->head_len;
+
+	put_unaligned_le32(params->tail_len, cur_byte);
+	cur_byte +=3D 4;
+
+	if (params->tail_len > 0)
+		memcpy(cur_byte, params->tail, params->tail_len);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send add beacon\n");
+
+	kfree(wid.val);
+
+	return result;
+}
+
+int wilc_del_beacon(struct wilc_vif *vif)
+{
+	int result;
+	struct wid wid;
+	u8 del_beacon =3D 0;
+
+	wid.id =3D WID_DEL_BEACON;
+	wid.type =3D WID_CHAR;
+	wid.size =3D sizeof(char);
+	wid.val =3D &del_beacon;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send delete beacon\n");
+
+	return result;
+}
+
+int wilc_add_station(struct wilc_vif *vif, const u8 *mac,
+		     struct station_parameters *params)
+{
+	struct wid wid;
+	int result;
+	u8 *cur_byte;
+
+	wid.id =3D WID_ADD_STA;
+	wid.type =3D WID_BIN;
+	wid.size =3D WILC_ADD_STA_LENGTH + params->supported_rates_len;
+	wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	cur_byte =3D wid.val;
+	wilc_hif_pack_sta_param(cur_byte, mac, params);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result !=3D 0)
+		netdev_err(vif->ndev, "Failed to send add station\n");
+
+	kfree(wid.val);
+
+	return result;
+}
+
+int wilc_del_station(struct wilc_vif *vif, const u8 *mac_addr)
+{
+	struct wid wid;
+	int result;
+
+	wid.id =3D WID_REMOVE_STA;
+	wid.type =3D WID_BIN;
+	wid.size =3D ETH_ALEN;
+	wid.val =3D kzalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	if (!mac_addr)
+		eth_broadcast_addr(wid.val);
+	else
+		ether_addr_copy(wid.val, mac_addr);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to del station\n");
+
+	kfree(wid.val);
+
+	return result;
+}
+
+int wilc_del_allstation(struct wilc_vif *vif, u8 mac_addr[][ETH_ALEN])
+{
+	struct wid wid;
+	int result;
+	int i;
+	u8 assoc_sta =3D 0;
+	struct wilc_del_all_sta del_sta;
+
+	memset(&del_sta, 0x0, sizeof(del_sta));
+	for (i =3D 0; i < WILC_MAX_NUM_STA; i++) {
+		if (!is_zero_ether_addr(mac_addr[i])) {
+			assoc_sta++;
+			ether_addr_copy(del_sta.mac[i], mac_addr[i]);
+		}
+	}
+
+	if (!assoc_sta)
+		return 0;
+
+	del_sta.assoc_sta =3D assoc_sta;
+
+	wid.id =3D WID_DEL_ALL_STA;
+	wid.type =3D WID_STR;
+	wid.size =3D (assoc_sta * ETH_ALEN) + 1;
+	wid.val =3D (u8 *)&del_sta;
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send delete all station\n");
+
+	return result;
+}
+
+int wilc_edit_station(struct wilc_vif *vif, const u8 *mac,
+		      struct station_parameters *params)
+{
+	struct wid wid;
+	int result;
+	u8 *cur_byte;
+
+	wid.id =3D WID_EDIT_STA;
+	wid.type =3D WID_BIN;
+	wid.size =3D WILC_ADD_STA_LENGTH + params->supported_rates_len;
+	wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
+
+	cur_byte =3D wid.val;
+	wilc_hif_pack_sta_param(cur_byte, mac, params);
+
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send edit station\n");
+
+	kfree(wid.val);
+	return result;
+}
+
+int wilc_set_power_mgmt(struct wilc_vif *vif, bool enabled, u32 timeout)
+{
+	struct wid wid;
+	int result;
+	s8 power_mode;
+
+	if (wilc_wlan_get_num_conn_ifcs(vif->wilc) =3D=3D 2 && enabled)
+		return 0;
+
+	if (enabled)
+		power_mode =3D WILC_FW_MIN_FAST_PS;
+	else
+		power_mode =3D WILC_FW_NO_POWERSAVE;
+
+	wid.id =3D WID_POWER_MANAGEMENT;
+	wid.val =3D &power_mode;
+	wid.size =3D sizeof(char);
+	result =3D wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+	if (result)
+		netdev_err(vif->ndev, "Failed to send power management\n");
+
+	return result;
+}
+
+int wilc_setup_multicast_filter(struct wilc_vif *vif, u32 enabled, u32 cou=
nt,
+				u8 *mc_list)
+{
+	int result;
+	struct host_if_msg *msg;
+
+	msg =3D wilc_alloc_work(vif, handle_set_mcast_filter, false);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	msg->body.mc_info.enabled =3D enabled;
+	msg->body.mc_info.cnt =3D count;
+	msg->body.mc_info.mc_list =3D mc_list;
+
+	result =3D wilc_enqueue_work(msg);
+	if (result) {
+		netdev_err(vif->ndev, "%s: enqueue work failed\n", __func__);
+		kfree(msg);
+	}
+	return result;
+}
+
+int wilc_set_tx_power(struct wilc_vif *vif, u8 tx_power)
+{
+	struct wid wid;
+
+	wid.id =3D WID_TX_POWER;
+	wid.type =3D WID_CHAR;
+	wid.val =3D &tx_power;
+	wid.size =3D sizeof(char);
+
+	return wilc_send_config_pkt(vif, WILC_SET_CFG, &wid, 1);
+}
+
+int wilc_get_tx_power(struct wilc_vif *vif, u8 *tx_power)
+{
+	struct wid wid;
+
+	wid.id =3D WID_TX_POWER;
+	wid.type =3D WID_CHAR;
+	wid.val =3D tx_power;
+	wid.size =3D sizeof(char);
+
+	return wilc_send_config_pkt(vif, WILC_GET_CFG, &wid, 1);
+}
--=20
2.7.4

