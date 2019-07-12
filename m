Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 913CB66394
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfGLB7Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:25 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24955 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfGLB7Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:24 -0400
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
IronPort-SDR: b3znxd0tZm0sODgEKTbZLzLduKPYjv+/cfA18PSwitDQWDwmz1KvtnH5qker4TV/602d6lpz0t
 mE0NdY4B15oj7laqQz85W28ePxA4CaBo4VEo4Dfc0cDpNUKp1y1o0zqszQ8hImNERgvUojo+vp
 NDjxH9eGqgzJhVZIMvMu0fD8IeP3SOOqcgXf/rc4zt+kORlHtjHU8x77CtR8tufWHO3zsjM+7W
 C6IBjE/lwMMr23xJA7isETziKIwC4vTZke7CJ2D45jIMxqvJcsL0dMEK8I87/endtrw/4s5O0Q
 BvA=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967475"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:23 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:59:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6Q4UM4Su039aLXkv7zqdqpZoP8L3h0jcNJhrsZvVHCyv79tQoe/+DC9reHIRClKOU7IPqJsNIce47YtwmNYgTYT4R2JdRnZfVxw8NUihlLOX0CrqkUL+rehuHVxqFJRTG4DYGGVG2iYGiwwStYnQ6TFNKsT1i2/8z8umRLWuNqcbm37ZGVtQF2tvj7O/FO7DULeIi7Ur+/gbG2JcaYhfkgtU9HktVzX/SaV/oDHPpUMmjhBu2h+WXr+V1n5VXWjRzp8vF8QHTeABs1nSFZOiRDxzvosb6xRfWQme3mgmYNfF+K5NMu3sKPrls01B9PHk3QgY5rlRYv3qfXFlrMlVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVTVcvn54cz6tfU5AxJfsRMLuS8Q6+v1NKxBYGD36Rc=;
 b=jvyjFt3Np9nG0+6yxIlab8to+/NiJJgjQF6hrr5aPjMmaK+j19p3GDCRyUkFa647gOahgx69qLGgQWE237ldp5d0E2/NA1dQmtoTQTa0eHf5APxRMZCGELgB6aOgBFlBI08WcQ/3jG1mZugIIPnzdg+KeT9jCFqPp5fkqEuCBOfvajXDue1WtUuZ/msuSc/6AvDo6O4x92VfUUx9c/CUS065DVZ11bedpFOJ/Nk1LB7uqVR13rX/NRHRwxZ64h+uo4WVItn9aEnka0LGrtuWAnPFhvbh4BZ3EY8rOGDZ0O2KOP6R0/+4MmnMmnPUb75iBjR/oohvVaC9l9J2kJHssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVTVcvn54cz6tfU5AxJfsRMLuS8Q6+v1NKxBYGD36Rc=;
 b=UU7UZmwIVSbVwHvcEXqp3tYv1YRUM5BC6HGV6U+JPBffC7Ip88QgjNiRWNAi2ABgZOWWkKpLvVE4Bak46KHc0pA4BzojWOPs5DI4kMWSBr3Vgo2eeoc0SxVnWWAi5B5yOUYRSjYE8pUPs9ybGzdjgOSsPRwGksjCNtWgTGBh8qI=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:21 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 12/16] wilc1000: add wilc_wlan.c
Thread-Topic: [PATCH v2 12/16] wilc1000: add wilc_wlan.c
Thread-Index: AQHVOFVrEMVaRsHaikO0xq8KducQMw==
Date:   Fri, 12 Jul 2019 01:59:20 +0000
Message-ID: <1562896697-8002-13-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 78114661-1f35-44b9-63b3-08d7066c8e06
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB1425E71CAFDCD9A934049DE6E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:37;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(53946003)(5640700003)(107886003)(68736007)(99286004)(30864003)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nsdZqXG8pGCdvgrlKyFCRVJfDIzVsjfjnS2USUodgBfGEPqna+yCTIzhSxvJE7uaeGgZK3vVdN+NUfqtg+bFHud1Ea93qKdtQA/rEZrckguX55i6l3dVjI8rZf6Y0E7pCIu1yVZEnDTfeXfclRRswWrqHKVvYR+csTwtZ2LMg9G5zQ5clKWUccbQTMv3OOLwLQrV+aDQK/JmnASdQZKwpFwZZN2zJFJo4YS/8vlVSIEu6RDdXDRiyO0jMwb21Zel31127+3KG5A5Vnt3UuuaD+EBZIg+MHDXYK5Bn9FDdtwXY348FVS2yFEFBiZYquvXnAtn+Ig9dBeFwVP4GxlsWPN3yvtDU8xYaXZmaZVN+DW2C/6FA3Fc5J4CzwX8cNQLwDJXnh2qtRmntmkMK5lZe8/nHxfV3sngipSoQlZ0j/4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 78114661-1f35-44b9-63b3-08d7066c8e06
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:20.8860
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

Moved '/driver/staging/wilc1000/wilc_wlan.c' to
'drivers/net/wireless/microchip/wilc1000/wilc_wlan.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/wilc_wlan.c    | 1354 ++++++++++++++++=
++++
 1 file changed, 1354 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_wlan.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_wlan.c b/drivers/=
net/wireless/microchip/wilc1000/wilc_wlan.c
new file mode 100644
index 0000000..d46876e
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_wlan.c
@@ -0,0 +1,1354 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/if_ether.h>
+#include <linux/ip.h>
+#include "wilc_wfi_cfgoperations.h"
+#include "wilc_wlan_cfg.h"
+
+static inline bool is_wilc1000(u32 id)
+{
+	return (id & 0xfffff000) =3D=3D 0x100000;
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
+	wilc->hif_func->hif_read_reg(wilc, 0xf0, &reg);
+
+	wilc->hif_func->hif_write_reg(wilc, 0xf0, reg & ~BIT(0));
+	wilc->hif_func->hif_write_reg(wilc, 0xfa, 0);
+}
+EXPORT_SYMBOL_GPL(chip_allow_sleep);
+
+void chip_wakeup(struct wilc *wilc)
+{
+	u32 reg, clk_status_reg;
+
+	if ((wilc->io_type & 0x1) =3D=3D WILC_HIF_SPI) {
+		do {
+			wilc->hif_func->hif_read_reg(wilc, 1, &reg);
+			wilc->hif_func->hif_write_reg(wilc, 1, reg | BIT(1));
+			wilc->hif_func->hif_write_reg(wilc, 1, reg & ~BIT(1));
+
+			do {
+				usleep_range(2000, 2500);
+				wilc_get_chipid(wilc, true);
+			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
+		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
+	} else if ((wilc->io_type & 0x1) =3D=3D WILC_HIF_SDIO) {
+		wilc->hif_func->hif_write_reg(wilc, 0xfa, 1);
+		usleep_range(200, 400);
+		wilc->hif_func->hif_read_reg(wilc, 0xf0, &reg);
+		do {
+			wilc->hif_func->hif_write_reg(wilc, 0xf0,
+						      reg | BIT(0));
+			wilc->hif_func->hif_read_reg(wilc, 0xf1,
+						     &clk_status_reg);
+
+			while ((clk_status_reg & 0x1) =3D=3D 0) {
+				usleep_range(2000, 2500);
+
+				wilc->hif_func->hif_read_reg(wilc, 0xf1,
+							     &clk_status_reg);
+			}
+			if ((clk_status_reg & 0x1) =3D=3D 0) {
+				wilc->hif_func->hif_write_reg(wilc, 0xf0,
+							      reg & (~BIT(0)));
+			}
+		} while ((clk_status_reg & 0x1) =3D=3D 0);
+	}
+
+	if (wilc->chip_ps_state =3D=3D WILC_CHIP_SLEEPING_MANUAL) {
+		if (wilc_get_chipid(wilc, false) < 0x1002b0) {
+			u32 val32;
+
+			wilc->hif_func->hif_read_reg(wilc, 0x1e1c, &val32);
+			val32 |=3D BIT(6);
+			wilc->hif_func->hif_write_reg(wilc, 0x1e1c, val32);
+
+			wilc->hif_func->hif_read_reg(wilc, 0x1e9c, &val32);
+			val32 |=3D BIT(6);
+			wilc->hif_func->hif_write_reg(wilc, 0x1e9c, val32);
+		}
+	}
+	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
+}
+EXPORT_SYMBOL_GPL(chip_wakeup);
+
+void wilc_chip_sleep_manually(struct wilc *wilc)
+{
+	if (wilc->chip_ps_state !=3D WILC_CHIP_WAKEDUP)
+		return;
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+
+	chip_allow_sleep(wilc);
+	wilc->hif_func->hif_write_reg(wilc, 0x10a8, 1);
+
+	wilc->chip_ps_state =3D WILC_CHIP_SLEEPING_MANUAL;
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+}
+EXPORT_SYMBOL_GPL(wilc_chip_sleep_manually);
+
+void host_wakeup_notify(struct wilc *wilc)
+{
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	wilc->hif_func->hif_write_reg(wilc, 0x10b0, 1);
+	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+}
+EXPORT_SYMBOL_GPL(host_wakeup_notify);
+
+void host_sleep_notify(struct wilc *wilc)
+{
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+	wilc->hif_func->hif_write_reg(wilc, 0x10ac, 1);
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
+		goto out;
+
+	mutex_lock(&wilc->txq_add_to_head_cs);
+	tqe =3D wilc_wlan_txq_get_first(wilc);
+	if (!tqe)
+		goto out;
+	dev =3D tqe->vif->ndev;
+	wilc_wlan_txq_filter_dup_tcp_ack(dev);
+	i =3D 0;
+	sum =3D 0;
+	do {
+		if (tqe && (i < (WILC_VMM_TBL_SIZE - 1))) {
+			if (tqe->type =3D=3D WILC_CFG_PKT)
+				vmm_sz =3D ETH_CONFIG_PKT_HDR_OFFSET;
+
+			else if (tqe->type =3D=3D WILC_NET_PKT)
+				vmm_sz =3D ETH_ETHERNET_HDR_OFFSET;
+
+			else
+				vmm_sz =3D HOST_HDR_OFFSET;
+
+			vmm_sz +=3D tqe->buffer_size;
+
+			if (vmm_sz & 0x3)
+				vmm_sz =3D (vmm_sz + 4) & ~0x3;
+
+			if ((sum + vmm_sz) > WILC_TX_BUFF_SIZE)
+				break;
+
+			vmm_table[i] =3D vmm_sz / 4;
+			if (tqe->type =3D=3D WILC_CFG_PKT)
+				vmm_table[i] |=3D BIT(10);
+			cpu_to_le32s(&vmm_table[i]);
+
+			i++;
+			sum +=3D vmm_sz;
+			tqe =3D wilc_wlan_txq_get_next(wilc, tqe);
+		} else {
+			break;
+		}
+	} while (1);
+
+	if (i =3D=3D 0)
+		goto out;
+	vmm_table[i] =3D 0x0;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+	counter =3D 0;
+	func =3D wilc->hif_func;
+	do {
+		ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
+		if (!ret)
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
+	if (!ret)
+		goto out_release_bus;
+
+	timeout =3D 200;
+	do {
+		ret =3D func->hif_block_tx(wilc,
+					 WILC_VMM_TBL_RX_SHADOW_BASE,
+					 (u8 *)vmm_table,
+					 ((i + 1) * 4));
+		if (!ret)
+			break;
+
+		ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x2);
+		if (!ret)
+			break;
+
+		do {
+			ret =3D func->hif_read_reg(wilc, WILC_HOST_VMM_CTL, &reg);
+			if (!ret)
+				break;
+			if ((reg >> 2) & 0x1) {
+				entries =3D ((reg >> 3) & 0x3f);
+				break;
+			}
+			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		} while (--timeout);
+		if (timeout <=3D 0) {
+			ret =3D func->hif_write_reg(wilc, WILC_HOST_VMM_CTL, 0x0);
+			break;
+		}
+
+		if (!ret)
+			break;
+
+		if (entries =3D=3D 0) {
+			ret =3D func->hif_read_reg(wilc, WILC_HOST_TX_CTRL, &reg);
+			if (!ret)
+				break;
+			reg &=3D ~BIT(0);
+			ret =3D func->hif_write_reg(wilc, WILC_HOST_TX_CTRL, reg);
+			if (!ret)
+				break;
+			break;
+		}
+		break;
+	} while (1);
+
+	if (!ret)
+		goto out_release_bus;
+
+	if (entries =3D=3D 0) {
+		ret =3D -ENOBUFS;
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
+		vmm_sz =3D (vmm_table[i] & 0x3ff);
+		vmm_sz *=3D 4;
+		header =3D (tqe->type << 31) |
+			 (tqe->buffer_size << 15) |
+			 vmm_sz;
+		if (tqe->type =3D=3D WILC_MGMT_PKT)
+			header |=3D BIT(30);
+		else
+			header &=3D ~BIT(30);
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
+	if (!ret)
+		goto out_release_bus;
+
+	ret =3D func->hif_block_tx_ext(wilc, 0, txb, offset);
+
+out_release_bus:
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+
+out:
+	mutex_unlock(&wilc->txq_add_to_head_cs);
+
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
+		memcpy(&header, buff_ptr, 4);
+		le32_to_cpus(&header);
+
+		is_cfg_packet =3D (header >> 31) & 0x1;
+		pkt_offset =3D (header >> 22) & 0x1ff;
+		tp_len =3D (header >> 11) & 0x7ff;
+		pkt_len =3D header & 0x7ff;
+
+		if (pkt_len =3D=3D 0 || tp_len =3D=3D 0)
+			break;
+
+		if (pkt_offset & IS_MANAGMEMENT) {
+			buff_ptr +=3D HOST_HDR_OFFSET;
+			wilc_wfi_mgmt_rx(wilc, buff_ptr, pkt_len);
+		} else {
+			if (!is_cfg_packet) {
+				if (pkt_len > 0) {
+					wilc_frmw_to_host(wilc, buff_ptr,
+							  pkt_len, pkt_offset);
+				}
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
+		if (offset >=3D size)
+			break;
+	} while (1);
+}
+
+static void wilc_wlan_handle_rxq(struct wilc *wilc)
+{
+	int size;
+	u8 *buffer;
+	struct rxq_entry_t *rqe;
+
+	do {
+		if (wilc->quit) {
+			complete(&wilc->cfg_event);
+			break;
+		}
+		rqe =3D wilc_wlan_rxq_remove(wilc);
+		if (!rqe)
+			break;
+
+		buffer =3D rqe->buffer;
+		size =3D rqe->buffer_size;
+		wilc_wlan_handle_rx_buff(wilc, buffer, size);
+
+		kfree(rqe);
+	} while (1);
+}
+
+static void wilc_unknown_isr_ext(struct wilc *wilc)
+{
+	wilc->hif_func->hif_clear_int_ext(wilc, 0);
+}
+
+static void wilc_pllupdate_isr_ext(struct wilc *wilc, u32 int_stats)
+{
+	int trials =3D 10;
+
+	wilc->hif_func->hif_clear_int_ext(wilc, PLL_INT_CLR);
+
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO)
+		mdelay(WILC_PLL_TO_SDIO);
+	else
+		mdelay(WILC_PLL_TO_SPI);
+
+	while (!(is_wilc1000(wilc_get_chipid(wilc, true)) && --trials))
+		mdelay(1);
+}
+
+static void wilc_sleeptimer_isr_ext(struct wilc *wilc, u32 int_stats1)
+{
+	wilc->hif_func->hif_clear_int_ext(wilc, SLEEP_INT_CLR);
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
+	size =3D (int_status & 0x7fff) << 2;
+
+	while (!size && retries < 10) {
+		wilc->hif_func->hif_read_size(wilc, &size);
+		size =3D (size & 0x7fff) << 2;
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
+	if (!ret)
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
+	if (int_status & PLL_INT_EXT)
+		wilc_pllupdate_isr_ext(wilc, int_status);
+
+	if (int_status & DATA_INT_EXT)
+		wilc_wlan_handle_isr_ext(wilc, int_status);
+
+	if (int_status & SLEEP_INT_EXT)
+		wilc_sleeptimer_isr_ext(wilc, int_status);
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
+		memcpy(&addr, &buffer[offset], 4);
+		memcpy(&size, &buffer[offset + 4], 4);
+		le32_to_cpus(&addr);
+		le32_to_cpus(&size);
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
+			if (!ret)
+				break;
+
+			addr +=3D size2;
+			offset +=3D size2;
+			size -=3D size2;
+		}
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+
+		if (!ret) {
+			ret =3D -EIO;
+			goto fail;
+		}
+	} while (offset < buffer_size);
+
+fail:
+
+	kfree(dma_buffer);
+
+	return (ret < 0) ? ret : 0;
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
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return -EIO;
+	}
+	reg =3D 0;
+	if (wilc->io_type =3D=3D WILC_HIF_SDIO && wilc->dev_irq_num)
+		reg |=3D WILC_HAVE_SDIO_IRQ_GPIO;
+
+#ifdef WILC_DISABLE_PMU
+#else
+	reg |=3D WILC_HAVE_USE_PMU;
+#endif
+
+#ifdef WILC_SLEEP_CLK_SRC_XO
+	reg |=3D WILC_HAVE_SLEEP_CLK_SRC_XO;
+#elif defined WILC_SLEEP_CLK_SRC_RTC
+	reg |=3D WILC_HAVE_SLEEP_CLK_SRC_RTC;
+#endif
+
+#ifdef WILC_EXT_PA_INV_TX_RX
+	reg |=3D WILC_HAVE_EXT_PA_INV_TX_RX;
+#endif
+	reg |=3D WILC_HAVE_USE_IRQ_AS_HOST_WAKE;
+	reg |=3D WILC_HAVE_LEGACY_RF_SETTINGS;
+#ifdef XTAL_24
+	reg |=3D WILC_HAVE_XTAL_24;
+#endif
+#ifdef DISABLE_WILC_UART
+	reg |=3D WILC_HAVE_DISABLE_WILC_UART;
+#endif
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_1, reg);
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return -EIO;
+	}
+
+	wilc->hif_func->hif_sync_ext(wilc, NUM_INT_EXT);
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1000, &chipid);
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		return -EIO;
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
+	return (ret < 0) ? ret : 0;
+}
+
+int wilc_wlan_stop(struct wilc *wilc)
+{
+	u32 reg =3D 0;
+	int ret;
+	u8 timeout =3D 10;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GLB_RESET_0, &reg);
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+
+	reg &=3D ~BIT(10);
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return ret;
+	}
+
+	do {
+		ret =3D wilc->hif_func->hif_read_reg(wilc,
+						   WILC_GLB_RESET_0, &reg);
+		if (!ret) {
+			release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+			return ret;
+		}
+
+		if ((reg & BIT(10))) {
+			reg &=3D ~BIT(10);
+			ret =3D wilc->hif_func->hif_write_reg(wilc,
+							    WILC_GLB_RESET_0,
+							    reg);
+			timeout--;
+		} else {
+			ret =3D wilc->hif_func->hif_read_reg(wilc,
+							   WILC_GLB_RESET_0,
+							   &reg);
+			if (!ret) {
+				release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+				return ret;
+			}
+			break;
+		}
+
+	} while (timeout);
+	reg =3D (BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(8) | BIT(9) | BIT(26) |
+	       BIT(29) | BIT(30) | BIT(31));
+
+	wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+	reg =3D (u32)~BIT(10);
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GLB_RESET_0, reg);
+
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+
+	return ret;
+}
+
+void wilc_wlan_cleanup(struct net_device *dev)
+{
+	struct txq_entry_t *tqe;
+	struct rxq_entry_t *rqe;
+	u32 reg =3D 0;
+	int ret;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	wilc->quit =3D 1;
+	do {
+		tqe =3D wilc_wlan_txq_remove_from_head(dev);
+		if (!tqe)
+			break;
+		if (tqe->tx_complete_func)
+			tqe->tx_complete_func(tqe->priv, 0);
+		kfree(tqe);
+	} while (1);
+
+	do {
+		rqe =3D wilc_wlan_rxq_remove(wilc);
+		if (!rqe)
+			break;
+		kfree(rqe);
+	} while (1);
+
+	kfree(wilc->rx_buffer);
+	wilc->rx_buffer =3D NULL;
+	kfree(wilc->tx_buffer);
+	wilc->tx_buffer =3D NULL;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
+
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_GP_REG_0, &reg);
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return;
+	}
+
+	ret =3D wilc->hif_func->hif_write_reg(wilc, WILC_GP_REG_0,
+					(reg | ABORT_INT));
+	if (!ret) {
+		release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
+		return;
+	}
+
+	release_bus(wilc, WILC_BUS_RELEASE_ALLOW_SLEEP);
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
+int wilc_wlan_cfg_get_val(struct wilc *wl, u16 wid, u8 *buffer, u32 buffer=
_size)
+{
+	return wilc_wlan_cfg_get_wid_value(wl, wid, buffer, buffer_size);
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
+static u32 init_chip(struct net_device *dev)
+{
+	u32 chipid;
+	u32 reg, ret =3D 0;
+	struct wilc_vif *vif =3D netdev_priv(dev);
+	struct wilc *wilc =3D vif->wilc;
+
+	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+
+	chipid =3D wilc_get_chipid(wilc, true);
+
+	if ((chipid & 0xfff) !=3D 0xa0) {
+		ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1118, &reg);
+		if (!ret) {
+			netdev_err(dev, "fail read reg 0x1118\n");
+			goto release;
+		}
+		reg |=3D BIT(0);
+		ret =3D wilc->hif_func->hif_write_reg(wilc, 0x1118, reg);
+		if (!ret) {
+			netdev_err(dev, "fail write reg 0x1118\n");
+			goto release;
+		}
+		ret =3D wilc->hif_func->hif_write_reg(wilc, 0xc0000, 0x71);
+		if (!ret) {
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
+		wilc->hif_func->hif_read_reg(wilc, 0x1000, &tempchipid);
+		wilc->hif_func->hif_read_reg(wilc, 0x13f4, &rfrevid);
+		if (!is_wilc1000(tempchipid)) {
+			chipid =3D 0;
+			return chipid;
+		}
+		if (tempchipid =3D=3D 0x1002a0) {
+			if (rfrevid !=3D 0x1)
+				tempchipid =3D 0x1002a1;
+		} else if (tempchipid =3D=3D 0x1002b0) {
+			if (rfrevid =3D=3D 0x4)
+				tempchipid =3D 0x1002b1;
+			else if (rfrevid !=3D 0x3)
+				tempchipid =3D 0x1002b2;
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
+	if (!wilc->hif_func->hif_init(wilc, false)) {
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
+	if (!init_chip(dev)) {
+		ret =3D -EIO;
+		goto fail;
+	}
+
+	return 1;
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
2.7.4

