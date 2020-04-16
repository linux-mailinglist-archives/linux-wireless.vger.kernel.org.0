Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 791B41AD1A8
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2020 23:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgDPVBI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Apr 2020 17:01:08 -0400
Received: from mx0a-00183b01.pphosted.com ([67.231.149.44]:22832 "EHLO
        mx0a-00183b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbgDPVBF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Apr 2020 17:01:05 -0400
Received: from pps.filterd (m0048106.ppops.net [127.0.0.1])
        by mx0a-00183b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GKgInE019971
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2020 15:01:03 -0600
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00183b01.pphosted.com with ESMTP id 30dn88erd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Thu, 16 Apr 2020 15:01:03 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSHzg6r20D+GwqrTby/mlH96y1pn1T3D6aIWvZ1iMH7NC3/n/Ps660ETULOsZ/AiadvoDaczCM5F+VIJZkiFH8hCvzNR0VDGLFFq2ZuIeshukHgnR+WTr+RGqVNAudChm3y+9+ok9y+N5gb9iUEbe++3fFh3Fs8jiiCmZnrBw86Q6BDRekoK436ues4CAmtYO/7fkRm/easM7W3VQPeRlStV5vVcrliF9dyuXfZSVIjQX419F7LJIyG7/S9L+075tFUEyTjZ0W9nbC4QXtBqjxIAUwGXnABSMwAuFdi/7ix8RXW54kNdt+YsJKkU4ZCBhY76tzZWhYgvfQ27pMoxKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSjhS7ankLxsGm9aqrkUZxFRD7b0i5ciXFaZhP+I5Ww=;
 b=IQJr/RZtXSvkPdO14We1N8sJJj+SKJ9/clcCPf2uY1ekSToBvrD+A8BHeSf881JkAFoch9ow4DcFHN+gfS46ktMar61EfbVyYdMJRgEWywa41VOE22WlI4iQiPhSQ3MsZe+KD6G9ehFZYdX8l7smffJAP4dO701O8CU6iT+GX3QboQjIbi4K7GRHqoZ44BYrf+uEhHthgtnHMPiyB+1kptbRxi+QfM+DqPXB+BjDAfw0LNoHz1qn9nYe10OZ2hbSWDKisIu5I8/4N+DJ4vULObdwQinM+SjgFLNPHM0D1QPI2pf21bH6pnBriSjRajb6BSu6j5jDQyLDcdtoDBsxKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quantenna.com; dmarc=pass action=none
 header.from=quantenna.com; dkim=pass header.d=quantenna.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quantenna.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSjhS7ankLxsGm9aqrkUZxFRD7b0i5ciXFaZhP+I5Ww=;
 b=k4ERPX3+wk/4f2zJNtl+lNoK+RbIA6b4mqUPhPHhkFuqWXmyA6P4czUnYbzvOyv5x02UboJKnh0PoQRByuaD0CCbUMbqisBWad2T/11vmazNlhyq447o7jo5zAPRlBBKVzP3v2Qgz82wPYqTnGWIM02jFaLK6s1pJAId9gwV1NQ=
Received: from BYAPR05MB6309.namprd05.prod.outlook.com (2603:10b6:a03:cf::22)
 by BYAPR05MB4934.namprd05.prod.outlook.com (2603:10b6:a03:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6; Thu, 16 Apr
 2020 21:01:01 +0000
Received: from BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221]) by BYAPR05MB6309.namprd05.prod.outlook.com
 ([fe80::d8c0:3fd8:fcf2:2221%3]) with mapi id 15.20.2921.024; Thu, 16 Apr 2020
 21:01:00 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com (2603:10b6:910:53::39)
 by CY4PR05MB3447.namprd05.prod.outlook.com (2603:10b6:910:59::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.23; Thu, 16 Apr
 2020 21:00:33 +0000
Received: from CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048]) by CY4PR05MB3558.namprd05.prod.outlook.com
 ([fe80::f5eb:c5ec:8fe4:e048%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 21:00:33 +0000
From:   Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To:     linux-wireless@vger.kernel.org
CC:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>,
        Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Subject: [RFC PATCH] qtnfmac: enable access to the card in calibration mode
Date:   Fri, 17 Apr 2020 00:00:25 +0300
Message-ID: <20200416210025.1096-1-sergey.matyukevich.os@quantenna.com>
X-Mailer: git-send-email 2.11.0
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0079.eurprd05.prod.outlook.com
 (2603:10a6:208:136::19) To CY4PR05MB3558.namprd05.prod.outlook.com
 (2603:10b6:910:53::39)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bars.quantenna.com (195.182.157.78) by AM0PR05CA0079.eurprd05.prod.outlook.com (2603:10a6:208:136::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Thu, 16 Apr 2020 21:00:32 +0000
X-Mailer: git-send-email 2.11.0
X-Originating-IP: [195.182.157.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c754191-ee10-4e6e-5549-08d7e2493419
X-MS-TrafficTypeDiagnostic: CY4PR05MB3447:|BYAPR05MB4934:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR05MB34475926FEB6E76B850C9AC0A3D80@CY4PR05MB3447.namprd05.prod.outlook.com>
X-Moderation-Data: 4/16/2020 9:00:59 PM
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB6309.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(376002)(396003)(39850400004)(6666004)(316002)(66556008)(6916009)(66476007)(26005)(8936002)(478600001)(66946007)(8676002)(7696005)(81156014)(52116002)(2906002)(107886003)(6486002)(54906003)(86362001)(2616005)(16526019)(36756003)(5660300002)(186003)(956004)(103116003)(4326008)(1076003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: quantenna.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+WCm8fE/cK+8XHJhDkODTPsA96Nd//tuuUy5DNLRZvC133SIuzywuDYQjKwXRuxAD3VmPs6WcYEixKW/ORv0In2lWWox1cxwc3yFhTkDdsaRHtfWmFKOsUAO3iGeNbhJeNjQtT+NvQBZWMUHooZHxcZVOE9PzNclverwD3T+CqCWMEzt0Cy88mOWtowVWmRwUurMLbFjEioyCgLNIK1mPZRTV6L03n/SbayuOTl/Yn5cund41Zqd4Sr8I2iFHJJwSVV22rHmneD+Q4/uC0FIt/ErPDjU9selOapVTmHccdTOozCIV9qAHWcqBJEsL/C+ECqzqOuO8ZiqDgVsjXwxrNJjbz8x3OBuJK84IKgUpszHRyuJzU+CMOlQ5FpDQgGb/2ziBpy/ek9ZcUW9SATWxF6BhxaKHvtOLs3APV8DGZugdDocOIKmK3McDsFMsWc
X-MS-Exchange-AntiSpam-MessageData: GBHEmQVTHoDiOm3yiMCvBIt7tCuxFYI7nIZu8Oa0QlFiLr116rZRwISrlQN5N/Pz8DjftH5Fkaw4GxY8pXstMrrPBg8UGN3c+PSa/x1woriCCnAjB9OQ0E5tqOI/P+Sq8Rt00+bZmmcsN7EE/1wG2w==
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c754191-ee10-4e6e-5549-08d7e2493419
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ0iZ8JvnOgpRx6ZYueNacIXzDvkSttXZgBqobiV9BfTqUDClNb6bLCuSX/1bKxdeAP92uXmZnkTm86jqdEMmUL8JULwb7WGkon1TrDbOZRjM8tEvf2VTnOLgWchdOcnad6g+G8Lvg6wQwxIPNpijqNuZXEwHUXYd6lUxSUK1C72dBHdEG3xyzVxSX+GUSBYAC6w6r0igG3StxJQvLea/TinP9ajhZSXtPPix43z0x0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 21:01:00.9001
 (UTC)
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4934
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_09:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 mlxscore=0
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160144
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable access to the wireless card in calibration mode using service
ethernet port. Wireless functionality is not available in calibration
mode. Service ethernet port can be used for various maintenance tasks
including calibration, configuration, troubleshooting. Add new kernel
module parameter force_svcmode. Set this parameter to one in order
to boot wireless card into the calibration mode.

Signed-off-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

---

Hello Kalle and all,

I would like to add support for a simple service mode for calibration.
This patch includes some controversial bits, that is why it is marked
as RFC. Could you please take a closer look and tell me whether it is
acceptable for mainlining.

Regards,
Sergey

---
 drivers/net/wireless/quantenna/qtnfmac/bus.h       |  1 +
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |  1 +
 drivers/net/wireless/quantenna/qtnfmac/core.c      | 83 ++++++++++++++++++++++
 drivers/net/wireless/quantenna/qtnfmac/core.h      |  1 +
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |  5 ++
 .../wireless/quantenna/qtnfmac/pcie/pcie_priv.h    |  3 +-
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |  3 +
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |  2 +
 8 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/bus.h b/drivers/net/wireless/quantenna/qtnfmac/bus.h
index 87d048df09d1..7811833a84c9 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/bus.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/bus.h
@@ -67,6 +67,7 @@ struct qtnf_bus {
 	struct mutex bus_lock; /* lock during command/event processing */
 	struct dentry *dbg_dir;
 	struct notifier_block netdev_nb;
+	struct net_device *svc_ndev;
 	u8 hw_id[ETH_ALEN];
 	/* bus private data */
 	char bus_priv[0] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/quantenna/qtnfmac/commands.c b/drivers/net/wireless/quantenna/qtnfmac/commands.c
index f40d8c3c3d9e..984300ac2f30 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/commands.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/commands.c
@@ -980,6 +980,7 @@ qtnf_cmd_resp_proc_hw_info(struct qtnf_bus *bus,
 
 	strlcpy(hwinfo->fw_version, bld_label, sizeof(hwinfo->fw_version));
 	hwinfo->hw_version = hw_ver;
+	hwinfo->svc_mode = qtnf_hwcap_is_set(hwinfo, QLINK_HW_CAPAB_SVC_MODE);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
index eea777f8acea..0b93ab7cca61 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
@@ -244,6 +244,49 @@ const struct net_device_ops qtnf_netdev_ops = {
 	.ndo_get_port_parent_id = qtnf_netdev_port_parent_id,
 };
 
+static netdev_tx_t
+qtnf_svc_ndev_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct qtnf_bus *bus = *((void **)netdev_priv(ndev));
+
+	if (unlikely(!bus)) {
+		pr_err_ratelimited("invalid ndev settings");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (unlikely(skb->dev != ndev)) {
+		pr_err_ratelimited("invalid skb->dev");
+		dev_kfree_skb_any(skb);
+		return 0;
+	}
+
+	if (!skb->len || skb->len > ETH_FRAME_LEN) {
+		pr_err_ratelimited("%s: invalid skb len %d\n", ndev->name,
+				   skb->len);
+		dev_kfree_skb_any(skb);
+		ndev->stats.tx_dropped++;
+		return 0;
+	}
+
+	return qtnf_bus_data_tx(bus, skb, 0, 0);
+}
+
+static const struct net_device_ops svc_netdev_ops = {
+	.ndo_start_xmit = qtnf_svc_ndev_xmit,
+	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_validate_addr = eth_validate_addr,
+};
+
+static void svc_ndev_setup(struct net_device *dev)
+{
+	dev->netdev_ops = &svc_netdev_ops;
+	dev->needs_free_netdev = true;
+	ether_setup(dev);
+	dev->priv_flags |= IFF_NO_QUEUE;
+	eth_hw_addr_random(dev);
+}
+
 static int qtnf_mac_init_single_band(struct wiphy *wiphy,
 				     struct qtnf_wmac *mac,
 				     enum nl80211_band band)
@@ -736,6 +779,7 @@ static int qtnf_core_netdevice_event(struct notifier_block *nb,
 int qtnf_core_attach(struct qtnf_bus *bus)
 {
 	unsigned int i;
+	void *priv;
 	int ret;
 
 	qtnf_trans_init(bus);
@@ -779,6 +823,38 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
+	if (bus->hw_info.svc_mode) {
+		bus->svc_ndev = alloc_netdev(sizeof(struct qtnf_bus *),
+					     "eth%d", NET_NAME_UNKNOWN,
+					     svc_ndev_setup);
+		if (!bus->svc_ndev) {
+			ret = -ENOMEM;
+			goto error;
+		}
+
+		rtnl_lock();
+		ret = dev_alloc_name(bus->svc_ndev, bus->svc_ndev->name);
+		if (ret < 0) {
+			rtnl_unlock();
+			free_netdev(bus->svc_ndev);
+			bus->svc_ndev = NULL;
+			goto error;
+		}
+
+		priv = netdev_priv(bus->svc_ndev);
+		*((void **)priv) = bus;
+
+		ret = register_netdevice(bus->svc_ndev);
+		if (ret < 0) {
+			rtnl_unlock();
+			free_netdev(bus->svc_ndev);
+			bus->svc_ndev = NULL;
+			goto error;
+		}
+		rtnl_unlock();
+		goto done;
+	}
+
 	if (qtnf_hwcap_is_set(&bus->hw_info, QLINK_HW_CAPAB_HW_BRIDGE) &&
 	    bus->bus_ops->data_tx_use_meta_set)
 		bus->bus_ops->data_tx_use_meta_set(bus, true);
@@ -806,6 +882,7 @@ int qtnf_core_attach(struct qtnf_bus *bus)
 		goto error;
 	}
 
+done:
 	bus->fw_state = QTNF_FW_STATE_RUNNING;
 	return 0;
 
@@ -822,6 +899,9 @@ void qtnf_core_detach(struct qtnf_bus *bus)
 	unregister_netdevice_notifier(&bus->netdev_nb);
 	qtnf_bus_data_rx_stop(bus);
 
+	if (bus->svc_ndev)
+		unregister_netdev(bus->svc_ndev);
+
 	for (macid = 0; macid < QTNF_MAX_MAC; macid++)
 		qtnf_core_mac_detach(bus, macid);
 
@@ -862,6 +942,9 @@ struct net_device *qtnf_classify_skb(struct qtnf_bus *bus, struct sk_buff *skb)
 	if (unlikely(bus->fw_state != QTNF_FW_STATE_RUNNING))
 		return NULL;
 
+	if (unlikely(bus->svc_ndev))
+		return bus->svc_ndev;
+
 	meta = (struct qtnf_frame_meta_info *)
 		(skb_tail_pointer(skb) - sizeof(*meta));
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.h b/drivers/net/wireless/quantenna/qtnfmac/core.h
index 269ce12cf8bf..9745b27379ba 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/core.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/core.h
@@ -116,6 +116,7 @@ struct qtnf_hw_info {
 	u8 num_mac;
 	u8 mac_bitmap;
 	u32 fw_ver;
+	u8 svc_mode;
 	u8 total_tx_chain;
 	u8 total_rx_chain;
 	char fw_version[ETHTOOL_FWVERS_LEN];
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
index 5337e67092ca..8e025a27a4df 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c
@@ -41,6 +41,10 @@ static u8 flashboot = 1;
 module_param(flashboot, byte, 0644);
 MODULE_PARM_DESC(flashboot, "set to 0 to use FW binary file on FS");
 
+static u8 force_svcmode;
+module_param(force_svcmode, byte, 0644);
+MODULE_PARM_DESC(force_svcmode, "set to 1 to force boot into service mode");
+
 static unsigned int fw_blksize_param = QTN_PCIE_MAX_FW_BUFSZ;
 module_param(fw_blksize_param, uint, 0644);
 MODULE_PARM_DESC(fw_blksize_param, "firmware loading block size in bytes");
@@ -342,6 +346,7 @@ static int qtnf_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	pcie_priv->pdev = pdev;
 	pcie_priv->tx_stopped = 0;
 	pcie_priv->flashboot = flashboot;
+	pcie_priv->force_svcmode = force_svcmode;
 
 	if (fw_blksize_param > QTN_PCIE_MAX_FW_BUFSZ)
 		pcie_priv->fw_blksize =  QTN_PCIE_MAX_FW_BUFSZ;
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
index 2a6a928e13bd..93cb651a3236 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/pcie_priv.h
@@ -66,7 +66,8 @@ struct qtnf_pcie_bus_priv {
 
 	u8 msi_enabled;
 	u8 tx_stopped;
-	bool flashboot;
+	u8 flashboot;
+	u8 force_svcmode;
 };
 
 int qtnf_pcie_control_tx(struct qtnf_bus *bus, struct sk_buff *skb);
diff --git a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
index d1b850aa4657..f3f517733f99 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pcie/topaz_pcie.c
@@ -866,6 +866,9 @@ static int qtnf_pre_init_ep(struct qtnf_bus *bus)
 	/* notify card about driver type and boot mode */
 	flags = readl(&bda->bda_flags) | QTN_BDA_HOST_QLINK_DRV;
 
+	if (ts->base.force_svcmode)
+		flags |= QTN_BDA_HOST_CALCMD;
+
 	if (ts->base.flashboot)
 		flags |= QTN_BDA_FLASH_BOOT;
 	else
diff --git a/drivers/net/wireless/quantenna/qtnfmac/qlink.h b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
index 4d22a54c034f..3abbe0b6e32b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/qlink.h
+++ b/drivers/net/wireless/quantenna/qtnfmac/qlink.h
@@ -73,6 +73,7 @@ struct qlink_msg_header {
  *	Randomization in probe requests.
  * @QLINK_HW_CAPAB_OBSS_SCAN: device can perform OBSS scanning.
  * @QLINK_HW_CAPAB_HW_BRIDGE: device has hardware switch capabilities.
+ * @QLINK_HW_CAPAB_SVC_MODE: device is in service mode (used for calibration).
  */
 enum qlink_hw_capab {
 	QLINK_HW_CAPAB_REG_UPDATE = 0,
@@ -84,6 +85,7 @@ enum qlink_hw_capab {
 	QLINK_HW_CAPAB_SCAN_DWELL,
 	QLINK_HW_CAPAB_SAE,
 	QLINK_HW_CAPAB_HW_BRIDGE,
+	QLINK_HW_CAPAB_SVC_MODE,
 	QLINK_HW_CAPAB_NUM
 };
 
-- 
2.11.0

