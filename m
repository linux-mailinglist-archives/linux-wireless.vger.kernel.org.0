Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C9EFA1A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbfKEJvn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 04:51:43 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:55789 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfKEJvn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 04:51:43 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: v2y9UtyJ+v9xdzPheXDGZRUS8CU9kHO/ieWzqIxOJwkQpaIL4gln1IFQE4TBd4TT6iAT2mykR5
 Prn0pnEVR4QH/zOXZsAzivBiBMqnZgMvNTbbyviLbMJFxEQzlQeJbAEUVDuZBH+R4EkSQV7ByN
 oRx2bnNwlaZlkTmw68foqia0iMCn3hgxUKFBlH8gkRVTBByw1IqnQhnLb8RygnPu7fmo9G7DvP
 rNHsuRxVZn93GRtHDEB7QHmGAA797Ixyjjpq2H0pQI6saSf+YzzOn31Y/sttN4c4X9KWCpcrbP
 f9M=
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="54166709"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2019 02:51:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 5 Nov 2019 02:51:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 5 Nov 2019 02:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFuqX1pwz6NyjWUgjFnsT37GTWOaJiuE6V8ZU4jDtiTLtS4skKsa8TfqhmrkeckG0znuDL2bideiK9l0v9qYdh9K5vAZVEOUvMdIRQEpcmZuk2E55YQnpi4XKtoV3GtLqTzcz5EUTDKHvKPHn3JQvmYapE6QP6aOyPmmogRAPtTwQAnqhzZdXGvCpAQMtOMw3PB35T73Oc5w80wrsFtDDIQtzH5EzxUnGv/3cYF+C07nkgR+R2f/8BCP9JofYAf8Egbgkw8bweDZ7Nc2XF5F6PVLUYkgQXoDT95m30LW+pXUFwpv5KM9FT32vinFrUTRFSNNejq36UFjsAo2WnNWsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbjw6EEhk7b5MvuVWJsD0hxRoURNRjcJfkWEDT3Aw4E=;
 b=Zg5jXCxIAgVi8ON3iyhRbAs/1kDh09iUiADZkm0GXu+4pIOpzC+y+Vvg+sBjKiavdMOr2LxjmKcSMv2tglyQyGiTjGyX5ajuenkttNF/oh/LbNooPoL0844PJF4c3+RamUd8MGpRiW7tZt0dOv3//U5goO9G7fh9DQIyJXRD2uPO7BfGXu7RHFpEb22wC0Qysq0W03c3kSJjIyjHoGeTAtyxaXMzX9E4U3XAyc3WvXwPhJAwOlFTwy5/C12xUB5QGmhrhywX2lQKekO/XUJkepyLqzKjkCkIxjGPv0UWzdgLxYpBO4DUGHDovdb97ynWEUPnF6Wdxq+Dj1OUlON3og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bbjw6EEhk7b5MvuVWJsD0hxRoURNRjcJfkWEDT3Aw4E=;
 b=rx9juNw10xH3cQWY8NypkAqaqrB0YeLUbi9rSwK1Wbi/NDofEhPLRxdfFGQyAKu31K/H1d/B5UmevsRi2H1nrVIh/QtMVESC7LQ/RHzZv6O1RChB856jT/bbVB/wdbHAGIBXM1lqCIWj/7w0G21+UfZx1Zwr7CR27N5l9udQXBY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1972.namprd11.prod.outlook.com (10.175.100.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:51:34 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5994:7522:979f:5e29%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:51:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 5/6] staging: wilc1000: added proper spacing for comments
Thread-Topic: [PATCH 5/6] staging: wilc1000: added proper spacing for comments
Thread-Index: AQHVk76bJBrmfkaY5U6CWW3A8Q5NZQ==
Date:   Tue, 5 Nov 2019 09:51:33 +0000
Message-ID: <20191105095058.24223-6-ajay.kathat@microchip.com>
References: <20191105095058.24223-1-ajay.kathat@microchip.com>
In-Reply-To: <20191105095058.24223-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MA1PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:35::21) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e421f66-2ccc-447f-6224-08d761d5bd9d
x-ms-traffictypediagnostic: BN6PR11MB1972:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB197245101246FB3035AB5416E37E0@BN6PR11MB1972.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(136003)(346002)(39860400002)(199004)(189003)(6486002)(6436002)(2616005)(36756003)(71190400001)(486006)(186003)(86362001)(76176011)(386003)(14454004)(5640700003)(52116002)(2501003)(6512007)(64756008)(99286004)(6916009)(66446008)(66476007)(66946007)(66556008)(71200400001)(2351001)(26005)(316002)(8936002)(8676002)(50226002)(81166006)(81156014)(102836004)(6506007)(5660300002)(11346002)(1076003)(476003)(107886003)(54906003)(446003)(478600001)(25786009)(2906002)(7736002)(305945005)(4326008)(6116002)(3846002)(256004)(14444005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1972;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvd6wlnvILy42uZE/cg5v5xqmL8d1TcxdCOTHqk2xAMyYOaf57Jl0/+AQJ7nXwxULcgKKS2pu4lK4pXaTC//oFb7WRUJ2wC9dfUfS9/18VVyaZML0mJ/rX/XfVl8qidG+MpZeQFSUR+Vj9xn+14baMSSCdV4MzHFEPKTlBkCu/L7nnKsTM40XddMfErGcTNMjSktVMiQ/zbZnNMHuvudl4Zf4P7UtRVedebHnJdv1hl67vg95pFD1YMg5Q6DUccfdR3LBN0swDS88Hb8An98+kHfFRIWoIx+8BsqhnxaFSNSNGP1mkOs9I9TDeLp2X2JikSB8SPc43MoX9bByv1PvVKbqmr8+5Qb7ECQmq2zDPRz4zfDgs/ZuaBkNz9FPxrxSfSbRvhD8WjWRkE3WBxzsRt8OShUovsWheECPIf03KTwKuXsQwJYunAL11pQg4xB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e421f66-2ccc-447f-6224-08d761d5bd9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:51:33.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nIm0r85//9WPHfH8eCLsVurr/Ufxt06J/9H8G+swAzjIl+dDduuobj7Cr2PvhDwO6RmE/T5RO1MS3aMiJoJ8q5i5eWDJj+0bhgn+IQAr/Tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1972
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added proper space for the comments and added newline before the
comments inside a struct.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/mon.c      |  2 +-
 drivers/staging/wilc1000/netdev.h   | 19 ++++++++++++++-----
 drivers/staging/wilc1000/wlan.h     |  2 +-
 drivers/staging/wilc1000/wlan_cfg.c |  2 +-
 drivers/staging/wilc1000/wlan_if.h  |  8 ++++----
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/wilc1000/mon.c b/drivers/staging/wilc1000/mon.=
c
index 853fe3056a53..48ac33f06f63 100644
--- a/drivers/staging/wilc1000/mon.c
+++ b/drivers/staging/wilc1000/mon.c
@@ -220,7 +220,7 @@ struct net_device *wilc_wfi_init_mon_interface(struct w=
ilc *wl,
 {
 	struct wilc_wfi_mon_priv *priv;
=20
-	/*If monitor interface is already initialized, return it*/
+	/* If monitor interface is already initialized, return it */
 	if (wl->monitor_dev)
 		return wl->monitor_dev;
=20
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index 42e0eb192b86..cd8f0d72caaa 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -60,7 +60,7 @@ struct sta_info {
 	u8 sta_associated_bss[WILC_MAX_NUM_STA][ETH_ALEN];
 };
=20
-/*Parameters needed for host interface for  remaining on channel*/
+/* Parameters needed for host interface for remaining on channel */
 struct wilc_wfi_p2p_listen_params {
 	struct ieee80211_channel *listen_ch;
 	u32 listen_duration;
@@ -145,11 +145,13 @@ struct wilc_priv {
 	struct wilc_pmkid_attr pmkid_list;
 	u8 wep_key[4][WLAN_KEY_LEN_WEP104];
 	u8 wep_key_len[4];
+
 	/* The real interface that the monitor is on */
 	struct net_device *real_ndev;
 	struct wilc_wfi_key *wilc_gtk[WILC_MAX_NUM_STA];
 	struct wilc_wfi_key *wilc_ptk[WILC_MAX_NUM_STA];
 	u8 wilc_groupkey;
+
 	/* mutexes */
 	struct mutex scan_req_lock;
 	bool p2p_listen_state;
@@ -224,16 +226,21 @@ struct wilc {
 	int close;
 	u8 vif_num;
 	struct list_head vif_list;
-	/*protect vif list*/
+
+	/* protect vif list */
 	struct mutex vif_mutex;
 	struct srcu_struct srcu;
 	u8 open_ifcs;
-	/*protect head of transmit queue*/
+
+	/* protect head of transmit queue */
 	struct mutex txq_add_to_head_cs;
-	/*protect txq_entry_t transmit queue*/
+
+	/* protect txq_entry_t transmit queue */
 	spinlock_t txq_spinlock;
-	/*protect rxq_entry_t receiver queue*/
+
+	/* protect rxq_entry_t receiver queue */
 	struct mutex rxq_cs;
+
 	/* lock to protect hif access */
 	struct mutex hif_cs;
=20
@@ -245,6 +252,7 @@ struct wilc {
 	struct task_struct *txq_thread;
=20
 	int quit;
+
 	/* lock to protect issue of wid command to firmware */
 	struct mutex cfg_cmd_lock;
 	struct wilc_cfg_frame cfg_frame;
@@ -271,6 +279,7 @@ struct wilc {
 	struct wilc_cfg cfg;
 	void *bus_data;
 	struct net_device *monitor_dev;
+
 	/* deinit lock */
 	struct mutex deinit_lock;
 	u8 sta_ch;
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 7469fa47d588..1f6957cf2e9c 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -190,7 +190,7 @@
=20
 #define ENABLE_RX_VMM		(SEL_VMM_TBL1 | EN_VMM)
 #define ENABLE_TX_VMM		(SEL_VMM_TBL0 | EN_VMM)
-/*time for expiring the completion of cfg packets*/
+/* time for expiring the completion of cfg packets */
 #define WILC_CFG_PKTS_TIMEOUT	msecs_to_jiffies(2000)
=20
 #define IS_MANAGMEMENT		0x100
diff --git a/drivers/staging/wilc1000/wlan_cfg.c b/drivers/staging/wilc1000=
/wlan_cfg.c
index 904f84077ff7..c5b1678c7b5e 100644
--- a/drivers/staging/wilc1000/wlan_cfg.c
+++ b/drivers/staging/wilc1000/wlan_cfg.c
@@ -378,7 +378,7 @@ void wilc_wlan_cfg_indicate_rx(struct wilc *wilc, u8 *f=
rame, int size,
 		wilc_wlan_parse_info_frame(wilc, frame);
 		rsp->type =3D WILC_CFG_RSP_STATUS;
 		rsp->seq_no =3D msg_id;
-		/*call host interface info parse as well*/
+		/* call host interface info parse as well */
 		wilc_gnrl_async_info_received(wilc, frame - 4, size + 4);
 		break;
=20
diff --git a/drivers/staging/wilc1000/wlan_if.h b/drivers/staging/wilc1000/=
wlan_if.h
index 70eac586f80c..7c7ee66c35f5 100644
--- a/drivers/staging/wilc1000/wlan_if.h
+++ b/drivers/staging/wilc1000/wlan_if.h
@@ -750,10 +750,10 @@ enum {
 	WID_REMOVE_KEY			=3D 0x301E,
 	WID_ASSOC_REQ_INFO		=3D 0x301F,
 	WID_ASSOC_RES_INFO		=3D 0x3020,
-	WID_MANUFACTURER		=3D 0x3026, /*Added for CAPI tool */
-	WID_MODEL_NAME			=3D 0x3027, /*Added for CAPI tool */
-	WID_MODEL_NUM			=3D 0x3028, /*Added for CAPI tool */
-	WID_DEVICE_NAME			=3D 0x3029, /*Added for CAPI tool */
+	WID_MANUFACTURER		=3D 0x3026, /* Added for CAPI tool */
+	WID_MODEL_NAME			=3D 0x3027, /* Added for CAPI tool */
+	WID_MODEL_NUM			=3D 0x3028, /* Added for CAPI tool */
+	WID_DEVICE_NAME			=3D 0x3029, /* Added for CAPI tool */
=20
 	/* NMAC String WID list */
 	WID_SET_OPERATION_MODE		=3D 0x3079,
--=20
2.22.0

