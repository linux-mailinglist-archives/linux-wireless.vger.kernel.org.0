Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4B195143
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgC0Gda (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:30 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49560 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgC0GdX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:23 -0400
IronPort-SDR: wKatXDfB42BuW6I3gZZ/056XvwjhoIrLxaLU38l+CEhCMnFuynDSPPl2j6pxYxVsRpoRldRidq
 ncIB3Ppg9/KtyNLH+CCzSLD16PjOzbr2JooRpPgwHjVoWGDLqrl+5F6rtmiRk5JKrPWpzKTy/e
 3Gkzj5TMd/GXt2cbzXV7IjdoAVlnrM1101lQRKH6IDL3ENumvxVzsDnN5ES/IMJqIm9KQIFlKF
 xJckplViV3RNQpgkqBsjyvV4MJFGxiRizvtZiDZHAyxzkp1MFudCw835F1Ac0Jnd69rXOqN4ha
 MJQ=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452409"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmaMZK23yShtthal5jndqjGCRGHViIfzdkZta3L7Ju8jZK1kugkaMU8xn/klzEFtGXgQ557FCL2RK3tLcVfP6rDl6Im9xqlaC5JDnSRNfo0OpK2MhA4ONCeipev7ZQgvwFnw54VucxzVSDn98w4m5Z/Y/zjuZvb7IWoIGdFu65YzD4tBhbCtQ8bl+SBsx9KDyRNAQcCkrLCzSqx0ivyi1SZYX2sLC0rdY/KRjdR9jpqK6J2fITdKdyAyHyDxoAantYaA82z9wce4TlemSE9Jg6qiEQGmPLm+rD5TUfOS00Rkp6vOtXWjP+hboD+zRwq84pvHjxnbc1CMl9vyorbhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NEmNxWHt//zd0Rl+EbH1Xdj3cXo36+I+LbtvN+CtOo=;
 b=CB/VNL91rqImoa1AMzBbNzpNxZltdlpIGfjbyjJ1WqezLO5sWKMlKQFkNgKqQdkFHocgY/C02s6zbh6IhK38LOjviphQHUYN+xI7NZz37D+iqseyTiA60pR6dgI0vaC+Xv9El/OPnncI5HogHoN4qa7q3BT9Q+F3X0OKD/ryC4CGBj5d1qfuAQmdYz4Mt751u7Ct5tx4JfiqLyUB8qdcUWwNYbfEJXqtaYlR3cxiuefxxwtnNpghPY5Z2kKnzjxuJNuctqnurNs5bSR7jnULbxomAgkX1DJbQuHHwDMv0S3w1XVZxWkWMzFJOIKsrYwWGvbV/8ZuVlUPVYdH/sVbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NEmNxWHt//zd0Rl+EbH1Xdj3cXo36+I+LbtvN+CtOo=;
 b=U5g7F3nhGjqRWpQef+8R+Ojl9t68BVVwZiyPHKkGXhZDL+xyxYJujEbIADhgUxMkze6VjJZEGawmcevLsv5AJRG1g2GgjYUhs64pTy5bH51Nhe5FH1JJ6b5en+o5BNS/U+6M1QbHup54dApIeU5Io9L2tjgmq2x9A+FhduQeIX8=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:18 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:18 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 13/17] wilc1000: add wlan.c
Thread-Topic: [PATCH v6 13/17] wilc1000: add wlan.c
Thread-Index: AQHWBAGavm4rnYaCekSS9jKTjxch6g==
Date:   Fri, 27 Mar 2020 06:33:18 +0000
Message-ID: <20200327063302.20511-14-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe80c991-87a4-4a27-0ad6-08d7d218bcbe
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3397F5E05E3E81ECB6F4F201E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:15;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(30864003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003)(559001)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4gyS8fl5PM8tnO07mWWmdtPImJYArFi7AAltaFqZJEE9zr1OEwYLHRJ0cqTfYCbHqUIwHhvKlEA47+yyS26DYaNHfSG8gTef3Ur3oZQkLr3Tot/dqcsnZNG9FrCLnEz8MVUXo6xk+HnaHhJhE/DGqkbVfHBGJ5feJxQHsVQsdKoQNhr6QQlnyEDpqHk6i54BqK9HkjRSu39ZcsXk39IUhjcdRJ91Zumx8qbmiDUw5xKEZCxaBkxh5JxDXmSFjW9QNDjyL/NqjN/r3r0ZvK2pNKW4K4QDZOPQh1XCRDsxArS5xcevuZPfjxc0dXRunijhIu/d8G38bwQySJgSvU2vckC7MvAZcfbdgr/HcJha4NjFow76wK/qRSqWiEX0cH+vAzGcDf2V4EDoLCDV4JXhQbIR3OeAC72UC+5TolFFgYhU5svhH2TLUAB+OJWCsfVK
x-ms-exchange-antispam-messagedata: 9CSF3JDhFfekFrxXhWgltjnAcasCMERWfCCvpqT8bM5G2WU2BXfydRtqTfePH+XLYyC0hxD5v2t80SxPRO3H0yIC9jyFmshRJdm+m7vOrJmhPlbAggzL9EHAqQ9LCHiEISiPe8m9/CE8X1FxzcSypA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe80c991-87a4-4a27-0ad6-08d7d218bcbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:18.2434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPH2Mz9HSi4eJpsgkLuWCcYKGKDT24fehnlKviCpPXUyjvGwOCC1xH1oz3/GAEIPcy6h5H6kJYl8tsFlCLl+v/0KTt1+a9Wy/MxyzC5ZJJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/wlan.c' to
'drivers/net/wireless/microchip/wilc1000/wlan.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wlan.c    | 1238 +++++++++++++++++
 1 file changed, 1238 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wlan.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
new file mode 100644
index 000000000000..6a82fb2f283e
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -0,0 +1,1238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include "cfg80211.h"
+#include "wlan_cfg.h"
+
+static inline bool is_wilc1000(u32 id)
+{
+	return (id & (~WILC_CHIP_REV_FIELD)) =3D=3D WILC_1000_BASE_ID;
+}
+
+static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire=
)
+{
+	mutex_lock(&wilc->hif_cs);
+	if (acquire =3D=3D WILC_BUS_ACQUIRE_AND_WAKEUP)
+		chip_wakeup(wilc);
+}
+
+static inline void release_bus(struct wilc *wilc, enum bus_release release=
)
+{
+	if (release =3D=3D WILC_BUS_RELEASE_ALLOW_SLEEP)
+		chip_allow_sleep(wilc);
+	mutex_unlock(&wilc->hif_cs);
+}
+
+static void wilc_wlan_txq_remove(struct wilc *wilc, struct txq_entry_t *tq=
e)
+{
+	list_del(&tqe->list);
+	wilc->txq_entries -=3D 1;
+}
+
+static struct txq_entry_t *
+wilc_wlan_txq_remove_from_head(struct net_device *dev)
+{
+	struct txq_entry_t *tqe =3D NULL;
+	unsigned long flags;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	if (!list_empty(&wilc->txq_head.list)) {
+		tqe =3D list_first_entry(&wilc->txq_head.list, struct txq_entry_t,
+				       list);
+		list_del(&tqe->list);
+		wilc->txq_entries -=3D 1;
+	}
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+	return tqe;
+}
+
+static void wilc_wlan_txq_add_to_tail(struct net_device *dev,
+				      struct txq_entry_t *tqe)
+{
+	unsigned long flags;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	list_add_tail(&tqe->list, &wilc->txq_head.list);
+	wilc->txq_entries +=3D 1;
+
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+
+	complete(&wilc->txq_event);
+}
+
+static void wilc_wlan_txq_add_to_head(struct wilc_vif *vif,
+				      struct txq_entry_t *tqe)
+{
+	unsigned long flags;
+	struct wilc *wilc =3D vif->wilc;
+
+	mutex_lock(&wilc->txq_add_to_head_cs);
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	list_add(&tqe->list, &wilc->txq_head.list);
+	wilc->txq_entries +=3D 1;
+
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+	mutex_unlock(&wilc->txq_add_to_head_cs);
+	complete(&wilc->txq_event);
+}
+
+#define NOT_TCP_ACK			(-1)
+
+static inline void add_tcp_session(struct wilc_vif *vif, u32 src_prt,
+				   u32 dst_prt, u32 seq)
+{
+	struct tcp_ack_filter *f =3D &vif->ack_filter;
+
+	if (f->tcp_session < 2 * MAX_TCP_SESSION) {
+		f->ack_session_info[f->tcp_session].seq_num =3D seq;
+		f->ack_session_info[f->tcp_session].bigger_ack_num =3D 0;
+		f->ack_session_info[f->tcp_session].src_port =3D src_prt;
+		f->ack_session_info[f->tcp_session].dst_port =3D dst_prt;
+		f->tcp_session++;
+	}
+}
+
+static inline void update_tcp_session(struct wilc_vif *vif, u32 index, u32=
 ack)
+{
+	struct tcp_ack_filter *f =3D &vif->ack_filter;
+
+	if (index < 2 * MAX_TCP_SESSION &&
+	    ack > f->ack_session_info[index].bigger_ack_num)
+		f->ack_session_info[index].bigger_ack_num =3D ack;
+}
+
+static inline void add_tcp_pending_ack(struct wilc_vif *vif, u32 ack,
+				       u32 session_index,
+				       struct txq_entry_t *txqe)
+{
+	struct tcp_ack_filter *f =3D &vif->ack_filter;
+	u32 i =3D f->pending_base + f->pending_acks_idx;
+
+	if (i < MAX_PENDING_ACKS) {
+		f->pending_acks[i].ack_num =3D ack;
+		f->pending_acks[i].txqe =3D txqe;
+		f->pending_acks[i].session_index =3D session_index;
+		txqe->ack_idx =3D i;
+		f->pending_acks_idx++;
+	}
+}
+
+static inline void tcp_process(struct net_device *dev, struct txq_entry_t =
*tqe)
+{
+	void *buffer =3D tqe->buffer;
+	const struct ethhdr *eth_hdr_ptr =3D buffer;
+	int i;
+	unsigned long flags;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	struct tcp_ack_filter *f =3D &vif->ack_filter;
+	const struct iphdr *ip_hdr_ptr;
+	const struct tcphdr *tcp_hdr_ptr;
+	u32 ihl, total_length, data_offset;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	if (eth_hdr_ptr->h_proto !=3D htons(ETH_P_IP))
+		goto out;
+
+	ip_hdr_ptr =3D buffer + ETH_HLEN;
+
+	if (ip_hdr_ptr->protocol !=3D IPPROTO_TCP)
+		goto out;
+
+	ihl =3D ip_hdr_ptr->ihl << 2;
+	tcp_hdr_ptr =3D buffer + ETH_HLEN + ihl;
+	total_length =3D ntohs(ip_hdr_ptr->tot_len);
+
+	data_offset =3D tcp_hdr_ptr->doff << 2;
+	if (total_length =3D=3D (ihl + data_offset)) {
+		u32 seq_no, ack_no;
+
+		seq_no =3D ntohl(tcp_hdr_ptr->seq);
+		ack_no =3D ntohl(tcp_hdr_ptr->ack_seq);
+		for (i =3D 0; i < f->tcp_session; i++) {
+			u32 j =3D f->ack_session_info[i].seq_num;
+
+			if (i < 2 * MAX_TCP_SESSION &&
+			    j =3D=3D seq_no) {
+				update_tcp_session(vif, i, ack_no);
+				break;
+			}
+		}
+		if (i =3D=3D f->tcp_session)
+			add_tcp_session(vif, 0, 0, seq_no);
+
+		add_tcp_pending_ack(vif, ack_no, i, tqe);
+	}
+
+out:
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+}
+
+static void wilc_wlan_txq_filter_dup_tcp_ack(struct net_device *dev)
+{
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+	struct tcp_ack_filter *f =3D &vif->ack_filter;
+	u32 i =3D 0;
+	u32 dropped =3D 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+	for (i =3D f->pending_base;
+	     i < (f->pending_base + f->pending_acks_idx); i++) {
+		u32 index;
+		u32 bigger_ack_num;
+
+		if (i >=3D MAX_PENDING_ACKS)
+			break;
+
+		index =3D f->pending_acks[i].session_index;
+
+		if (index >=3D 2 * MAX_TCP_SESSION)
+			break;
+
+		bigger_ack_num =3D f->ack_session_info[index].bigger_ack_num;
+
+		if (f->pending_acks[i].ack_num < bigger_ack_num) {
+			struct txq_entry_t *tqe;
+
+			tqe =3D f->pending_acks[i].txqe;
+			if (tqe) {
+				wilc_wlan_txq_remove(wilc, tqe);
+				tqe->status =3D 1;
+				if (tqe->tx_complete_func)
+					tqe->tx_complete_func(tqe->priv,
+							      tqe->status);
+				kfree(tqe);
+				dropped++;
+			}
+		}
+	}
+	f->pending_acks_idx =3D 0;
+	f->tcp_session =3D 0;
+
+	if (f->pending_base =3D=3D 0)
+		f->pending_base =3D MAX_TCP_SESSION;
+	else
+		f->pending_base =3D 0;
+
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+
+	while (dropped > 0) {
+		wait_for_completion_timeout(&wilc->txq_event,
+					    msecs_to_jiffies(1));
+		dropped--;
+	}
+}
+
+void wilc_enable_tcp_ack_filter(struct wilc_vif *vif, bool value)
+{
+	vif->ack_filter.enabled =3D value;
+}
+
+static int wilc_wlan_txq_add_cfg_pkt(struct wilc_vif *vif, u8 *buffer,
+				     u32 buffer_size)
+{
+	struct txq_entry_t *tqe;
+	struct wilc *wilc =3D vif->wilc;
+
+	netdev_dbg(vif->ndev, "Adding config packet ...\n");
+	if (wilc->quit) {
+		netdev_dbg(vif->ndev, "Return due to clear function\n");
+		complete(&wilc->cfg_event);
+		return 0;
+	}
+
+	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
+	if (!tqe)
+		return 0;
+
+	tqe->type =3D WILC_CFG_PKT;
+	tqe->buffer =3D buffer;
+	tqe->buffer_size =3D buffer_size;
+	tqe->tx_complete_func =3D NULL;
+	tqe->priv =3D NULL;
+	tqe->ack_idx =3D NOT_TCP_ACK;
+	tqe->vif =3D vif;
+
+	wilc_wlan_txq_add_to_head(vif, tqe);
+
+	return 1;
+}
+
+int wilc_wlan_txq_add_net_pkt(struct net_device *dev, void *priv, u8 *buff=
er,
+			      u32 buffer_size,
+			      void (*tx_complete_fn)(void *, int))
+{
+	struct txq_entry_t *tqe;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc;
+
+	wilc =3D vif->wilc;
+
+	if (wilc->quit)
+		return 0;
+
+	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
+
+	if (!tqe)
+		return 0;
+	tqe->type =3D WILC_NET_PKT;
+	tqe->buffer =3D buffer;
+	tqe->buffer_size =3D buffer_size;
+	tqe->tx_complete_func =3D tx_complete_fn;
+	tqe->priv =3D priv;
+	tqe->vif =3D vif;
+
+	tqe->ack_idx =3D NOT_TCP_ACK;
+	if (vif->ack_filter.enabled)
+		tcp_process(dev, tqe);
+	wilc_wlan_txq_add_to_tail(dev, tqe);
+	return wilc->txq_entries;
+}
+
+int wilc_wlan_txq_add_mgmt_pkt(struct net_device *dev, void *priv, u8 *buf=
fer,
+			       u32 buffer_size,
+			       void (*tx_complete_fn)(void *, int))
+{
+	struct txq_entry_t *tqe;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc;
+
+	wilc =3D vif->wilc;
+
+	if (wilc->quit)
+		return 0;
+
+	tqe =3D kmalloc(sizeof(*tqe), GFP_ATOMIC);
+
+	if (!tqe)
+		return 0;
+	tqe->type =3D WILC_MGMT_PKT;
+	tqe->buffer =3D buffer;
+	tqe->buffer_size =3D buffer_size;
+	tqe->tx_complete_func =3D tx_complete_fn;
+	tqe->priv =3D priv;
+	tqe->ack_idx =3D NOT_TCP_ACK;
+	tqe->vif =3D vif;
+	wilc_wlan_txq_add_to_tail(dev, tqe);
+	return 1;
+}
+
+static struct txq_entry_t *wilc_wlan_txq_get_first(struct wilc *wilc)
+{
+	struct txq_entry_t *tqe =3D NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	if (!list_empty(&wilc->txq_head.list))
+		tqe =3D list_first_entry(&wilc->txq_head.list, struct txq_entry_t,
+				       list);
+
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+
+	return tqe;
+}
+
+static struct txq_entry_t *wilc_wlan_txq_get_next(struct wilc *wilc,
+						  struct txq_entry_t *tqe)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wilc->txq_spinlock, flags);
+
+	if (!list_is_last(&tqe->list, &wilc->txq_head.list))
+		tqe =3D list_next_entry(tqe, list);
+	else
+		tqe =3D NULL;
+	spin_unlock_irqrestore(&wilc->txq_spinlock, flags);
+
+	return tqe;
+}
+
+static void wilc_wlan_rxq_add(struct wilc *wilc, struct rxq_entry_t *rqe)
+{
+	if (wilc->quit)
+		return;
+
+	mutex_lock(&wilc->rxq_cs);
+	list_add_tail(&rqe->list, &wilc->rxq_head.list);
+	mutex_unlock(&wilc->rxq_cs);
+}
+
+static struct rxq_entry_t *wilc_wlan_rxq_remove(struct wilc *wilc)
+{
+	struct rxq_entry_t *rqe =3D NULL;
+
+	mutex_lock(&wilc->rxq_cs);
+	if (!list_empty(&wilc->rxq_head.list)) {
+		rqe =3D list_first_entry(&wilc->rxq_head.list, struct rxq_entry_t,
+				       list);
+		list_del(&rqe->list);
+	}
+	mutex_unlock(&wilc->rxq_cs);
+	return rqe;
+}
+
+void chip_allow_sleep(struct wilc *wilc)
+{
+	u32 reg =3D 0;
+
+	wilc->hif_func->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
+
+	wilc->hif_func->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+				      reg & ~WILC_SDIO_WAKEUP_BIT);
+	wilc->hif_func->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG, 0);
+}
+EXPORT_SYMBOL_GPL(chip_allow_sleep);
+
+void chip_wakeup(struct wilc *wilc)
+{
+	u32 reg, clk_status_reg;
+	const struct wilc_hif_func *h =3D wilc->hif_func;
+
+	if (wilc->io_type =3D=3D WILC_HIF_SPI) {
+		do {
+			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
+			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
+					 reg | WILC_SPI_WAKEUP_BIT);
+			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
+					 reg & ~WILC_SPI_WAKEUP_BIT);
+
+			do {
+				usleep_range(2000, 2500);
+				wilc_get_chipid(wilc, true);
+			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
+		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
+	} else if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
+		h->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG,
+				 WILC_SDIO_HOST_TO_FW_BIT);
+		usleep_range(200, 400);
+		h->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
+		do {
+			h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+					 reg | WILC_SDIO_WAKEUP_BIT);
+			h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
+					&clk_status_reg);
+
+			while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
+				usleep_range(2000, 2500);
+
+				h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
+						&clk_status_reg);
+			}
+			if (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
+				h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+						 reg & ~WILC_SDIO_WAKEUP_BIT);
+			}
+		} while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT));
+	}
+
+	if (wilc->chip_ps_state =3D=3D WILC_CHIP_SLEEPING_MANUAL) {
+		if (wilc_get_chipid(wilc, false) < WILC_1000_BASE_ID_2B) {
+			u32 val32;
+
+			h->hif_read_reg(wilc, WILC_REG_4_TO_1_RX, &val32);
+			val32 |=3D BIT(6);
+			h->hif_write_reg(wilc, WILC_REG_4_TO_1_RX, val32);
+
+			h->hif_read_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, &val32);
+			val32 |=3D BIT(6);
+			h->hif_write_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, val32);
+		}
+	}
+	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
+}
+EXPORT_SYMBOL_GPL(chip_wakeup);
+
+void host_wakeup_notify(struct wilc *wilc)
+{
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_2, 1);
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+}
+EXPORT_SYMBOL_GPL(host_wakeup_notify);
+
+void host_sleep_notify(struct wilc *wilc)
+{
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_1, 1);
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+}
+EXPORT_SYMBOL_GPL(host_sleep_notify);
+
+int wilc_wlan_handle_txq(struct wilc *wilc, u32 *txq_count)
+{
+	int i, entries =3D 0;
+	u32 sum;
+	u32 reg;
+	u32 offset =3D 0;
+	int vmm_sz =3D 0;
+	struct txq_entry_t *tqe;
+	int ret =3D 0;
+	int counter;
+	int timeout;
+	u32 vmm_table[WILC_VMM_TBL_SIZE];
+	const struct wilc_hif_func *func;
+	u8 *txb =3D wilc->tx_buffer;
+	struct net_device *dev;
+	struct wilc_vif *vif;
+
+	if (wilc->quit)
+		goto out_update_cnt;
+
+	mutex_lock(&wilc->txq_add_to_head_cs);
+	tqe =3D wilc_wlan_txq_get_first(wilc);
+	if (!tqe)
+		goto out_unlock;
+	dev =3D tqe->vif->ndev;
+	wilc_wlan_txq_filter_dup_tcp_ack(dev);
+	i =3D 0;
+	sum =3D 0;
+	while (tqe && (i < (WILC_VMM_TBL_SIZE - 1))) {
+		if (tqe->type =3D=3D WILC_CFG_PKT)
+			vmm_sz =3D ETH_CONFIG_PKT_HDR_OFFSET;
+		else if (tqe->type =3D=3D WILC_NET_PKT)
+			vmm_sz =3D ETH_ETHERNET_HDR_OFFSET;
+		else
+			vmm_sz =3D HOST_HDR_OFFSET;
+
+		vmm_sz +=3D tqe->buffer_size;
+		vmm_sz =3D ALIGN(vmm_sz, 4);
+
+		if ((sum + vmm_sz) > WILC_TX_BUFF_SIZE)
+			break;
+
+		vmm_table[i] =3D vmm_sz / 4;
+		if (tqe->type =3D=3D WILC_CFG_PKT)
+			vmm_table[i] |=3D BIT(10);
+		cpu_to_le32s(&vmm_table[i]);
+
+		i++;
+		sum +=3D vmm_sz;
+		tqe =3D wilc_wlan_txq_get_next(wilc, tqe);
+	}
+
+	if (i =3D=3D 0)
+		goto out_unlock;
+	vmm_table[i] =3D 0x0;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	counter =3D 0;
+	func =3D wilc->hif_func;
+	do {
+		ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
+		if (ret)
+			break;
+
+		if ((reg & 0x1) =3D=3D 0)
+			break;
+
+		counter++;
+		if (counter > 200) {
+			counter =3D 0;
+			ret =3D func->hif_write_reg(wilc, WILC_HOST_TX_CTRL, 0);
+			break;
+		}
+	} while (!wilc->quit);
+
+	if (ret)
+		goto out_release_bus;
+
+	timeout =3D 200;
+	do {
+		ret =3D func->hif_block_tx(wilc,
+					 WILC_VMM_TBL_RX_SHADOW_BASE,
+					 (u8 *)vmm_table,
+					 ((i + 1) * 4));
+		if (ret)
+			break;
+
+		ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
+		if (ret)
+			break;
+
+		do {
+			ret =3D func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
+			if (ret)
+				break;
+			if (FIELD_GET(WILC_VMM_ENTRY_AVAILABLE, reg)) {
+				entries =3D FIELD_GET(WILC_VMM_ENTRY_COUNT, reg);
+				break;
+			}
+		} while (--timeout);
+		if (timeout <=3D 0) {
+			ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x0);
+			break;
+		}
+
+		if (ret)
+			break;
+
+		if (entries =3D=3D 0) {
+			ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
+			if (ret)
+				break;
+			reg &=3D ~BIT(0);
+			ret =3D func->hif_write_reg(wilc, WILC_HOST_TX_CTRL, reg);
+		}
+	} while (0);
+
+	if (ret)
+		goto out_release_bus;
+
+	if (entries =3D=3D 0) {
+		/*
+		 * No VMM space available in firmware so retry to transmit
+		 * the packet from tx queue.
+		 */
+		ret =3D WILC_VMM_ENTRY_FULL_RETRY;
+		goto out_release_bus;
+	}
+
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+
+	offset =3D 0;
+	i =3D 0;
+	do {
+		u32 header, buffer_offset;
+		char *bssid;
+		u8 mgmt_ptk =3D 0;
+
+		tqe =3D wilc_wlan_txq_remove_from_head(dev);
+		if (!tqe)
+			break;
+
+		vif =3D tqe->vif;
+		if (vmm_table[i] =3D=3D 0)
+			break;
+
+		le32_to_cpus(&vmm_table[i]);
+		vmm_sz =3D FIELD_GET(WILC_VMM_BUFFER_SIZE, vmm_table[i]);
+		vmm_sz *=3D 4;
+
+		if (tqe->type =3D=3D WILC_MGMT_PKT)
+			mgmt_ptk =3D 1;
+
+		header =3D (FIELD_PREP(WILC_VMM_HDR_TYPE, tqe->type) |
+			  FIELD_PREP(WILC_VMM_HDR_MGMT_FIELD, mgmt_ptk) |
+			  FIELD_PREP(WILC_VMM_HDR_PKT_SIZE, tqe->buffer_size) |
+			  FIELD_PREP(WILC_VMM_HDR_BUFF_SIZE, vmm_sz));
+
+		cpu_to_le32s(&header);
+		memcpy(&txb[offset], &header, 4);
+		if (tqe->type =3D=3D WILC_CFG_PKT) {
+			buffer_offset =3D ETH_CONFIG_PKT_HDR_OFFSET;
+		} else if (tqe->type =3D=3D WILC_NET_PKT) {
+			bssid =3D tqe->vif->bssid;
+			buffer_offset =3D ETH_ETHERNET_HDR_OFFSET;
+			memcpy(&txb[offset + 8], bssid, 6);
+		} else {
+			buffer_offset =3D HOST_HDR_OFFSET;
+		}
+
+		memcpy(&txb[offset + buffer_offset],
+		       tqe->buffer, tqe->buffer_size);
+		offset +=3D vmm_sz;
+		i++;
+		tqe->status =3D 1;
+		if (tqe->tx_complete_func)
+			tqe->tx_complete_func(tqe->priv, tqe->status);
+		if (tqe->ack_idx !=3D NOT_TCP_ACK &&
+		    tqe->ack_idx < MAX_PENDING_ACKS)
+			vif->ack_filter.pending_acks[tqe->ack_idx].txqe =3D NULL;
+		kfree(tqe);
+	} while (--entries);
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	ret =3D func->hif_clear_int_ext(wilc, ENABLE_TX_VMM);
+	if (ret)
+		goto out_release_bus;
+
+	ret =3D func->hif_block_tx_ext(wilc, 0, txb, offset);
+
+out_release_bus:
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+
+out_unlock:
+	mutex_unlock(&wilc->txq_add_to_head_cs);
+
+out_update_cnt:
+	*txq_count =3D wilc->txq_entries;
+	return ret;
+}
+
+static void wilc_wlan_handle_rx_buff(struct wilc *wilc, u8 *buffer, int si=
ze)
+{
+	int offset =3D 0;
+	u32 header;
+	u32 pkt_len, pkt_offset, tp_len;
+	int is_cfg_packet;
+	u8 *buff_ptr;
+
+	do {
+		buff_ptr =3D buffer + offset;
+		header =3D get_unaligned_le32(buff_ptr);
+
+		is_cfg_packet =3D FIELD_GET(WILC_PKT_HDR_CONFIG_FIELD, header);
+		pkt_offset =3D FIELD_GET(WILC_PKT_HDR_OFFSET_FIELD, header);
+		tp_len =3D FIELD_GET(WILC_PKT_HDR_TOTAL_LEN_FIELD, header);
+		pkt_len =3D FIELD_GET(WILC_PKT_HDR_LEN_FIELD, header);
+
+		if (pkt_len =3D=3D 0 || tp_len =3D=3D 0)
+			break;
+
+		if (pkt_offset & IS_MANAGMEMENT) {
+			buff_ptr +=3D HOST_HDR_OFFSET;
+			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
+		} else {
+			if (!is_cfg_packet) {
+				wilc_frmw_to_host(wilc, buff_ptr, pkt_len,
+						  pkt_offset);
+			} else {
+				struct wilc_cfg_rsp rsp;
+
+				buff_ptr +=3D pkt_offset;
+
+				wilc_wlan_cfg_indicate_rx(wilc, buff_ptr,
+							  pkt_len,
+							  &rsp);
+				if (rsp.type =3D=3D WILC_CFG_RSP) {
+					if (wilc->cfg_seq_no =3D=3D rsp.seq_no)
+						complete(&wilc->cfg_event);
+				} else if (rsp.type =3D=3D WILC_CFG_RSP_STATUS) {
+					wilc_mac_indicate(wilc);
+				}
+			}
+		}
+		offset +=3D tp_len;
+	} while (offset < size);
+}
+
+static void wilc_wlan_handle_rxq(struct wilc *wilc)
+{
+	int size;
+	u8 *buffer;
+	struct rxq_entry_t *rqe;
+
+	while (!wilc->quit) {
+		rqe =3D wilc_wlan_rxq_remove(wilc);
+		if (!rqe)
+			break;
+
+		buffer =3D rqe->buffer;
+		size =3D rqe->buffer_size;
+		wilc_wlan_handle_rx_buff(wilc, buffer, size);
+
+		kfree(rqe);
+	}
+	if (wilc->quit)
+		complete(&wilc->cfg_event);
+}
+
+static void wilc_unknown_isr_ext(struct wilc *wilc)
+{
+	wilc->hif_func->hif_clear_int_ext(wilc, 0);
+}
+
+static void wilc_wlan_handle_isr_ext(struct wilc *wilc, u32 int_status)
+{
+	u32 offset =3D wilc->rx_buffer_offset;
+	u8 *buffer =3D NULL;
+	u32 size;
+	u32 retries =3D 0;
+	int ret =3D 0;
+	struct rxq_entry_t *rqe;
+
+	size =3D FIELD_GET(WILC_INTERRUPT_DATA_SIZE, int_status) << 2;
+
+	while (!size && retries < 10) {
+		wilc->hif_func->hif_read_size(wilc, &size);
+		size =3D FIELD_GET(WILC_INTERRUPT_DATA_SIZE, size) << 2;
+		retries++;
+	}
+
+	if (size <=3D 0)
+		return;
+
+	if (WILC_RX_BUFF_SIZE - offset < size)
+		offset =3D 0;
+
+	buffer =3D &wilc->rx_buffer[offset];
+
+	wilc->hif_func->hif_clear_int_ext(wilc, DATA_INT_CLR | ENABLE_RX_VMM);
+	ret =3D wilc->hif_func->hif_block_rx_ext(wilc, 0, buffer, size);
+	if (ret)
+		return;
+
+	offset +=3D size;
+	wilc->rx_buffer_offset =3D offset;
+	rqe =3D kmalloc(sizeof(*rqe), GFP_KERNEL);
+	if (!rqe)
+		return;
+
+	rqe->buffer =3D buffer;
+	rqe->buffer_size =3D size;
+	wilc_wlan_rxq_add(wilc, rqe);
+	wilc_wlan_handle_rxq(wilc);
+}
+
+void wilc_handle_isr(struct wilc *wilc)
+{
+	u32 int_status;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	wilc->hif_func->hif_read_int(wilc, &int_status);
+
+	if (int_status & DATA_INT_EXT)
+		wilc_wlan_handle_isr_ext(wilc, int_status);
+
+	if (!(int_status & (ALL_INT_EXT)))
+		wilc_unknown_isr_ext(wilc);
+
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+}
+EXPORT_SYMBOL_GPL(wilc_handle_isr);
+
+int wilc_wlan_firmware_download(struct wilc *wilc, const u8 *buffer,
+				u32 buffer_size)
+{
+	u32 offset;
+	u32 addr, size, size2, blksz;
+	u8 *dma_buffer;
+	int ret =3D 0;
+
+	blksz =3D BIT(12);
+
+	dma_buffer =3D kmalloc(blksz, GFP_KERNEL);
+	if (!dma_buffer)
+		return -EIO;
+
+	offset =3D 0;
+	do {
+		addr =3D get_unaligned_le32(&buffer[offset]);
+		size =3D get_unaligned_le32(&buffer[offset + 4]);
+		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+		offset +=3D 8;
+		while (((int)size) && (offset < buffer_size)) {
+			if (size <=3D blksz)
+				size2 =3D size;
+			else
+				size2 =3D blksz;
+
+			memcpy(dma_buffer, &buffer[offset], size2);
+			ret =3D wilc->hif_func->hif_block_tx(wilc, addr,
+							   dma_buffer, size2);
+			if (ret)
+				break;
+
+			addr +=3D size2;
+			offset +=3D size2;
+			size -=3D size2;
+		}
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+
+		if (ret)
+			goto fail;
+	} while (offset < buffer_size);
+
+fail:
+
+	kfree(dma_buffer);
+
+	return ret;
+}
+
+int wilc_wlan_start(struct wilc *wilc)
+{
+	u32 reg =3D 0;
+	int ret;
+	u32 chipid;
+
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
+		reg =3D 0;
+		reg |=3D BIT(3);
+	} else if (wilc->io_type =3D=3D WILC_HIF_SPI) {
+		reg =3D 1;
+	}
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_VMM_CORE_CFG, reg);
+	if (ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return ret;
+	}
+	reg =3D 0;
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO && wilc->dev_irq_num)
+		reg |=3D WILC_HAVE_SDIO_IRQ_GPIO;
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_1, reg);
+	if (ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return ret;
+	}
+
+	wilc->hif_func->hif_sync_ext(wilc, NUM_INT_EXT);
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
+	if (ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return ret;
+	}
+
+	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	if ((reg & BIT(10)) =3D=3D BIT(10)) {
+		reg &=3D ~BIT(10);
+		wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+		wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	}
+
+	reg |=3D BIT(10);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+
+	return ret;
+}
+
+int wilc_wlan_stop(struct wilc *wilc, struct wilc_vif *vif)
+{
+	u32 reg =3D 0;
+	int ret;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
+	if (ret) {
+		netdev_err(vif->ndev, "Error while reading reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
+					(reg | WILC_ABORT_REQ_BIT));
+	if (ret) {
+		netdev_err(vif->ndev, "Error while writing reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_FW_HOST_COMM, &reg);
+	if (ret) {
+		netdev_err(vif->ndev, "Error while reading reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+	reg =3D BIT(0);
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_FW_HOST_COMM, reg);
+	if (ret) {
+		netdev_err(vif->ndev, "Error while writing reg\n");
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+
+	return 0;
+}
+
+void wilc_wlan_cleanup(struct net_device *dev)
+{
+	struct txq_entry_t *tqe;
+	struct rxq_entry_t *rqe;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	wilc->quit =3D 1;
+	while ((tqe =3D wilc_wlan_txq_remove_from_head(dev))) {
+		if (tqe->tx_complete_func)
+			tqe->tx_complete_func(tqe->priv, 0);
+		kfree(tqe);
+	}
+
+	while ((rqe =3D wilc_wlan_rxq_remove(wilc)))
+		kfree(rqe);
+
+	kfree(wilc->rx_buffer);
+	wilc->rx_buffer =3D NULL;
+	kfree(wilc->tx_buffer);
+	wilc->tx_buffer =3D NULL;
+	wilc->hif_func->hif_deinit(NULL);
+}
+
+static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
+				u32 drv_handler)
+{
+	struct wilc *wilc =3D vif->wilc;
+	struct wilc_cfg_frame *cfg =3D &wilc->cfg_frame;
+	int t_len =3D wilc->cfg_frame_offset + sizeof(struct wilc_cfg_cmd_hdr);
+
+	if (type =3D=3D WILC_CFG_SET)
+		cfg->hdr.cmd_type =3D 'W';
+	else
+		cfg->hdr.cmd_type =3D 'Q';
+
+	cfg->hdr.seq_no =3D wilc->cfg_seq_no % 256;
+	cfg->hdr.total_len =3D cpu_to_le16(t_len);
+	cfg->hdr.driver_handler =3D cpu_to_le32(drv_handler);
+	wilc->cfg_seq_no =3D cfg->hdr.seq_no;
+
+	if (!wilc_wlan_txq_add_cfg_pkt(vif, (u8 *)&cfg->hdr, t_len))
+		return -1;
+
+	return 0;
+}
+
+int wilc_wlan_cfg_set(struct wilc_vif *vif, int start, u16 wid, u8 *buffer=
,
+		      u32 buffer_size, int commit, u32 drv_handler)
+{
+	u32 offset;
+	int ret_size;
+	struct wilc *wilc =3D vif->wilc;
+
+	mutex_lock(&wilc->cfg_cmd_lock);
+
+	if (start)
+		wilc->cfg_frame_offset =3D 0;
+
+	offset =3D wilc->cfg_frame_offset;
+	ret_size =3D wilc_wlan_cfg_set_wid(wilc->cfg_frame.frame, offset,
+					 wid, buffer, buffer_size);
+	offset +=3D ret_size;
+	wilc->cfg_frame_offset =3D offset;
+
+	if (!commit) {
+		mutex_unlock(&wilc->cfg_cmd_lock);
+		return ret_size;
+	}
+
+	netdev_dbg(vif->ndev, "%s: seqno[%d]\n", __func__, wilc->cfg_seq_no);
+
+	if (wilc_wlan_cfg_commit(vif, WILC_CFG_SET, drv_handler))
+		ret_size =3D 0;
+
+	if (!wait_for_completion_timeout(&wilc->cfg_event,
+					 WILC_CFG_PKTS_TIMEOUT)) {
+		netdev_dbg(vif->ndev, "%s: Timed Out\n", __func__);
+		ret_size =3D 0;
+	}
+
+	wilc->cfg_frame_offset =3D 0;
+	wilc->cfg_seq_no +=3D 1;
+	mutex_unlock(&wilc->cfg_cmd_lock);
+
+	return ret_size;
+}
+
+int wilc_wlan_cfg_get(struct wilc_vif *vif, int start, u16 wid, int commit=
,
+		      u32 drv_handler)
+{
+	u32 offset;
+	int ret_size;
+	struct wilc *wilc =3D vif->wilc;
+
+	mutex_lock(&wilc->cfg_cmd_lock);
+
+	if (start)
+		wilc->cfg_frame_offset =3D 0;
+
+	offset =3D wilc->cfg_frame_offset;
+	ret_size =3D wilc_wlan_cfg_get_wid(wilc->cfg_frame.frame, offset, wid);
+	offset +=3D ret_size;
+	wilc->cfg_frame_offset =3D offset;
+
+	if (!commit) {
+		mutex_unlock(&wilc->cfg_cmd_lock);
+		return ret_size;
+	}
+
+	if (wilc_wlan_cfg_commit(vif, WILC_CFG_QUERY, drv_handler))
+		ret_size =3D 0;
+
+	if (!wait_for_completion_timeout(&wilc->cfg_event,
+					 WILC_CFG_PKTS_TIMEOUT)) {
+		netdev_dbg(vif->ndev, "%s: Timed Out\n", __func__);
+		ret_size =3D 0;
+	}
+	wilc->cfg_frame_offset =3D 0;
+	wilc->cfg_seq_no +=3D 1;
+	mutex_unlock(&wilc->cfg_cmd_lock);
+
+	return ret_size;
+}
+
+int wilc_send_config_pkt(struct wilc_vif *vif, u8 mode, struct wid *wids,
+			 u32 count)
+{
+	int i;
+	int ret =3D 0;
+	u32 drv =3D wilc_get_vif_idx(vif);
+
+	if (mode =3D=3D WILC_GET_CFG) {
+		for (i =3D 0; i < count; i++) {
+			if (!wilc_wlan_cfg_get(vif, !i,
+					       wids[i].id,
+					       (i =3D=3D count - 1),
+					       drv)) {
+				ret =3D -ETIMEDOUT;
+				break;
+			}
+		}
+		for (i =3D 0; i < count; i++) {
+			wids[i].size =3D wilc_wlan_cfg_get_val(vif->wilc,
+							     wids[i].id,
+							     wids[i].val,
+							     wids[i].size);
+		}
+	} else if (mode =3D=3D WILC_SET_CFG) {
+		for (i =3D 0; i < count; i++) {
+			if (!wilc_wlan_cfg_set(vif, !i,
+					       wids[i].id,
+					       wids[i].val,
+					       wids[i].size,
+					       (i =3D=3D count - 1),
+					       drv)) {
+				ret =3D -ETIMEDOUT;
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+static int init_chip(struct net_device *dev)
+{
+	u32 chipid;
+	u32 reg;
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+
+	chipid =3D wilc_get_chipid(wilc, true);
+
+	if ((chipid & 0xfff) !=3D 0xa0) {
+		ret =3D wilc->hif_func->hif_read_reg(wilc,
+						   WILC_CORTUS_RESET_MUX_SEL,
+						   &reg);
+		if (ret) {
+			netdev_err(dev, "fail read reg 0x1118\n");
+			goto release;
+		}
+		reg |=3D BIT(0);
+		ret =3D wilc->hif_func->hif_write_reg(wilc,
+						    WILC_CORTUS_RESET_MUX_SEL,
+						    reg);
+		if (ret) {
+			netdev_err(dev, "fail write reg 0x1118\n");
+			goto release;
+		}
+		ret =3D wilc->hif_func->hif_write_reg(wilc,
+						    WILC_CORTUS_BOOT_REGISTER,
+						    WILC_CORTUS_BOOT_FROM_IRAM);
+		if (ret) {
+			netdev_err(dev, "fail write reg 0xc0000\n");
+			goto release;
+		}
+	}
+
+release:
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+
+	return ret;
+}
+
+u32 wilc_get_chipid(struct wilc *wilc, bool update)
+{
+	static u32 chipid;
+	u32 tempchipid =3D 0;
+	u32 rfrevid =3D 0;
+
+	if (chipid =3D=3D 0 || update) {
+		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &tempchipid);
+		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
+					     &rfrevid);
+		if (!is_wilc1000(tempchipid)) {
+			chipid =3D 0;
+			return chipid;
+		}
+		if (tempchipid =3D=3D WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
+			if (rfrevid !=3D 0x1)
+				tempchipid =3D WILC_1000_BASE_ID_2A_REV1;
+		} else if (tempchipid =3D=3D WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
+			if (rfrevid =3D=3D 0x4)
+				tempchipid =3D WILC_1000_BASE_ID_2B_REV1;
+			else if (rfrevid !=3D 0x3)
+				tempchipid =3D WILC_1000_BASE_ID_2B_REV2;
+		}
+
+		chipid =3D tempchipid;
+	}
+	return chipid;
+}
+
+int wilc_wlan_init(struct net_device *dev)
+{
+	int ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc;
+
+	wilc =3D vif->wilc;
+
+	wilc->quit =3D 0;
+
+	if (wilc->hif_func->hif_init(wilc, false)) {
+		ret =3D -EIO;
+		goto fail;
+	}
+
+	if (!wilc->tx_buffer)
+		wilc->tx_buffer =3D kmalloc(WILC_TX_BUFF_SIZE, GFP_KERNEL);
+
+	if (!wilc->tx_buffer) {
+		ret =3D -ENOBUFS;
+		goto fail;
+	}
+
+	if (!wilc->rx_buffer)
+		wilc->rx_buffer =3D kmalloc(WILC_RX_BUFF_SIZE, GFP_KERNEL);
+
+	if (!wilc->rx_buffer) {
+		ret =3D -ENOBUFS;
+		goto fail;
+	}
+
+	if (init_chip(dev)) {
+		ret =3D -EIO;
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+
+	kfree(wilc->rx_buffer);
+	wilc->rx_buffer =3D NULL;
+	kfree(wilc->tx_buffer);
+	wilc->tx_buffer =3D NULL;
+
+	return ret;
+}
--=20
2.24.0
