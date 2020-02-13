Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C607415BAFF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgBMIpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 03:45:30 -0500
Received: from mail-bn8nam11on2105.outbound.protection.outlook.com ([40.107.236.105]:59328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729678AbgBMIp3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbINMakZA6CF5qWP0YRxmQPiTlAfAJCHaUyiQvrmuN7922nZoFWf4pocru5TbszlWO83PqIuXDQHCpAFxha5aSUe/2PQan1jzMpUz9+bYsTO+dDXBeCF2llU93TEYStgcPe5c9Vxf44bhj2/QbyHZy+reaRZGPK3ujqBT8odB8XN7k5RcQIlVY0RHtZvOGBr+DSw2ssSSqgbUPPgqR7oHJg1P7vEtFJVpPUjQnU/eqV23qB0rqug95fjR6/NhIvt5VaPTwCHJ3xb4NxWXwUbloVGKGwFOXurQmJDlTEHSmHt65c2FjkzXlJ46eglLmg5uWpcFo2VtfVX7cgQ5gaKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNkBuUVZU/ozrIYmxaegt/1j7J9Lw4n/0KUwNJLGlZs=;
 b=QiFlZBH5i28NEZsbR6ePiQB8vf+vfx6hhA486X7qbrBM9GdDY2UsMjNK2h7Lt32VRyV+2jVc2JLDe+9bs8Z/bjW4t6UThG3X98V2OPCzS6tIdICxm3WQ2i5f+RvGSymo0bpepMy8dYkZ7EFipd2HYMO8jrVa9ACiZwdOf7kf7yeKKLn1zMGA7fH0hKKPaFLeQyZL7YNxwg7gnkyXCQmgJL0MppTcsL1XSM0g0weW/mGHDj3RCbCDV8pjFhiwowTqOIspDIIC/kbbu3jC94zAi0yOXEsxwiDOCE2J3aS2njh3OlLi/kY1l0pzuziJNd572Js2bJKq7Rj/4yAoEIzNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNkBuUVZU/ozrIYmxaegt/1j7J9Lw4n/0KUwNJLGlZs=;
 b=OMa04Wt2MMDeg9YMnEYsgLf8dH1UfWjHSr28IhYU9VhNpB5V5caEu+CtOvy2gNrP4QLmojqyrH+BUmA0ihNS99zpAYLNB45sszdDpShmUZEaAibefJxT4rY+rnBsMoQJKjqYmIlHGK8bElK/D94iZeID1B5bhtZKmFw6Nyr+BKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (20.177.184.30) by
 BYAPR06MB5623.namprd06.prod.outlook.com (20.178.196.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.29; Thu, 13 Feb 2020 08:45:22 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::61cf:307a:df0a:c031%3]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 08:45:22 +0000
From:   Chi-Hsien Lin <chi-hsien.lin@cypress.com>
To:     linux-wireless@vger.kernel.org
Cc:     brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Raveendran Somu <raveendran.somu@cypress.com>,
        Chi-hsien Lin <chi-hsien.lin@cypress.com>
Subject: [PATCH 6/6] brcmfmac: To support printing USB console messages
Date:   Thu, 13 Feb 2020 02:44:36 -0600
Message-Id: <1581583476-60155-7-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1581583476-60155-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR02CA0050.namprd02.prod.outlook.com (2603:10b6:a03:54::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.29 via Frontend Transport; Thu, 13 Feb 2020 08:45:21 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 05f1d1ce-07ad-459c-3b30-08d7b0610fc7
X-MS-TrafficTypeDiagnostic: BYAPR06MB5623:|BYAPR06MB5623:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB56239EDF47CEC8731FB2E319BB1A0@BYAPR06MB5623.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(189003)(199004)(16526019)(478600001)(2906002)(186003)(4326008)(2616005)(316002)(26005)(5660300002)(36756003)(956004)(86362001)(6666004)(8676002)(54906003)(8936002)(66556008)(52116002)(107886003)(66476007)(81166006)(81156014)(6486002)(15650500001)(6916009)(7696005)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5623;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auLXJX/PpIBbDb+yRg9bazjTmFw1Lcn7uVLXe86o8LemF0M8+riM20Zk0IvKhlLqfOyEHntqv/JZTUHXpYRh7klU1iJ+fv07cMJlRsmlvCDZMDaU+Q4YN7mMj0f2VSS8rpu2jENmPyoBKQtJjuBvBp0T5jYVVMZY0CQeWKIz1ISVwX7AYcQJtiBfj4XJWLLyXCFc3CJ/Utw052jrdjTx2VWuBtyvNQu993nTIIpmml28oHIhERduUQPXLJW9PNwu6uFcdON9UUUfJH7m0szpT39spbY+CABmduTHiZl9/uMtPKOVrnwQE4dP9dJqm2A23ibvjtdOK5V4cadWbwRrtiM2wx3THHX20B5JB1KmblR40ziRHcDofnYNWnT/k9JraBHLXIy+M44ZxCrtfq0UWonxXyor2p41dI9q/9nYmS7iUaIgYU61sdZHkXcU9xUF
X-MS-Exchange-AntiSpam-MessageData: CB9BV/iOwfk8JpBPNn4jzn1UEIG7cXhlwdAYfpY0xLOQ494fXdhNmag+NM9lkH+EPMylfVVtwMOsh+NNHV3H20HXPLifUuvYzPYfSlI5VYmO/ehtzk1WpMAvW8CpIkN6AmYxvsazTly/kXxMe+pO+w==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f1d1ce-07ad-459c-3b30-08d7b0610fc7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 08:45:22.3743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtoSsptueWSjhOEFJB068iV53A6Jhwzefsxv9YKBFIwgRzv/zwmWg1IoXEWXNKNpXIlruvJndReVT+R17iuQNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5623
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Raveendran Somu <raveendran.somu@cypress.com>

This change is to add support for printing the firmware
console messges of a USB interface chip to the host.
To enable this feature, build option '-msgtrace' should be
enabled in the firmware. And in the host, debug=0x100000
should be provided as a module parameter.

Signed-off-by: Raveendran Somu <raveendran.somu@cypress.com>
Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/bus.h |  1 +
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |  8 +++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.c   | 82 ++++++++++++++++++++++
 .../wireless/broadcom/brcm80211/brcmfmac/debug.h   | 24 +++++++
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c | 14 ++++
 5 files changed, 129 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
index 623c0168da79..c8063ca50611 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bus.h
@@ -271,6 +271,7 @@ void brcmf_bus_change_state(struct brcmf_bus *bus, enum brcmf_bus_state state);
 
 s32 brcmf_iovar_data_set(struct device *dev, char *name, void *data, u32 len);
 void brcmf_bus_add_txhdrlen(struct device *dev, uint len);
+int brcmf_fwlog_attach(struct device *dev);
 
 #ifdef CONFIG_BRCMFMAC_SDIO
 void brcmf_sdio_exit(void);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index 23627c953a5e..fab852461cf1 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -1117,6 +1117,14 @@ static int brcmf_inet6addr_changed(struct notifier_block *nb,
 }
 #endif
 
+int brcmf_fwlog_attach(struct device *dev)
+{
+	struct brcmf_bus *bus_if = dev_get_drvdata(dev);
+	struct brcmf_pub *drvr = bus_if->drvr;
+
+	return brcmf_debug_fwlog_init(drvr);
+}
+
 static int brcmf_revinfo_read(struct seq_file *s, void *data)
 {
 	struct brcmf_bus *bus_if = dev_get_drvdata(s->private);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
index 120515fe8250..64c8ba0ef8af 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.c
@@ -14,6 +14,82 @@
 #include "fweh.h"
 #include "debug.h"
 
+static int
+brcmf_debug_msgtrace_seqchk(u32 *prev, u32 cur)
+{
+	if ((cur == 0 && *prev == 0xFFFFFFFF) || ((cur - *prev) == 1)) {
+		goto done;
+	} else if (cur == *prev) {
+		brcmf_dbg(FWCON, "duplicate trace\n");
+		return -1;
+	} else if (cur > *prev) {
+		brcmf_dbg(FWCON, "lost %d packets\n", cur - *prev);
+	} else {
+		brcmf_dbg(FWCON, "seq out of order, host %d, dongle %d\n",
+			  *prev, cur);
+	}
+done:
+	*prev = cur;
+	return 0;
+}
+
+static int
+brcmf_debug_msg_parser(void *event_data)
+{
+	int err = 0;
+	struct msgtrace_hdr *hdr;
+	char *data, *s;
+	static u32 seqnum_prev;
+
+	hdr = (struct msgtrace_hdr *)event_data;
+	data = (char *)event_data + MSGTRACE_HDRLEN;
+
+	/* There are 2 bytes available at the end of data */
+	data[ntohs(hdr->len)] = '\0';
+
+	if (ntohl(hdr->discarded_bytes) || ntohl(hdr->discarded_printf)) {
+		brcmf_dbg(FWCON, "Discarded_bytes %d discarded_printf %d\n",
+			  ntohl(hdr->discarded_bytes),
+				ntohl(hdr->discarded_printf));
+	}
+
+	err = brcmf_debug_msgtrace_seqchk(&seqnum_prev, ntohl(hdr->seqnum));
+	if (err)
+		return err;
+
+	while (*data != '\0' && (s = strstr(data, "\n")) != NULL) {
+		*s = '\0';
+		brcmf_dbg(FWCON, "CONSOLE: %s\n", data);
+		data = s + 1;
+	}
+	if (*data)
+		brcmf_dbg(FWCON, "CONSOLE: %s", data);
+
+	return err;
+}
+
+static int
+brcmf_debug_trace_parser(struct brcmf_if *ifp,
+			 const struct brcmf_event_msg *evtmsg,
+			 void *event_data)
+{
+	int err = 0;
+	struct msgtrace_hdr *hdr;
+
+	hdr = (struct msgtrace_hdr *)event_data;
+	if (hdr->version != MSGTRACE_VERSION) {
+		brcmf_dbg(FWCON, "trace version mismatch host %d dngl %d\n",
+			  MSGTRACE_VERSION, hdr->version);
+		err = -EPROTO;
+		return err;
+	}
+
+	if (hdr->trace_type == MSGTRACE_HDR_TYPE_MSG)
+		err = brcmf_debug_msg_parser(event_data);
+
+	return err;
+}
+
 int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 			       size_t len)
 {
@@ -42,6 +118,12 @@ int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 	return 0;
 }
 
+int brcmf_debug_fwlog_init(struct brcmf_pub *drvr)
+{
+	return brcmf_fweh_register(drvr, BRCMF_E_TRACE,
+				brcmf_debug_trace_parser);
+}
+
 struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
 {
 	return drvr->wiphy->debugfsdir;
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
index 9b221b509ade..d61508b62d2c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/debug.h
@@ -103,6 +103,10 @@ do {								\
 
 #endif /* defined(DEBUG) || defined(CONFIG_BRCM_TRACING) */
 
+#define MSGTRACE_VERSION 1
+#define MSGTRACE_HDR_TYPE_MSG 0
+#define MSGTRACE_HDR_TYPE_LOG 1
+
 #define brcmf_dbg_hex_dump(test, data, len, fmt, ...)			\
 do {									\
 	trace_brcmf_hexdump((void *)data, len);				\
@@ -120,6 +124,7 @@ int brcmf_debugfs_add_entry(struct brcmf_pub *drvr, const char *fn,
 			    int (*read_fn)(struct seq_file *seq, void *data));
 int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 			       size_t len);
+int brcmf_debug_fwlog_init(struct brcmf_pub *drvr);
 #else
 static inline struct dentry *brcmf_debugfs_get_devdir(struct brcmf_pub *drvr)
 {
@@ -137,6 +142,25 @@ int brcmf_debug_create_memdump(struct brcmf_bus *bus, const void *data,
 {
 	return 0;
 }
+
+static inline
+int brcmf_debug_fwlog_init(struct brcmf_pub *drvr)
+{
+	return 0;
+}
 #endif
 
+/* Message trace header */
+struct msgtrace_hdr {
+	u8	version;
+	u8	trace_type;
+	u16	len;    /* Len of the trace */
+	u32	seqnum; /* Sequence number of message */
+	/* Number of discarded bytes because of trace overflow  */
+	u32	discarded_bytes;
+	/* Number of discarded printf because of trace overflow */
+	u32	discarded_printf;
+};
+
+#define MSGTRACE_HDRLEN		sizeof(struct msgtrace_hdr)
 #endif /* BRCMFMAC_DEBUG_H */
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
index ac5463838fcf..89220cf3a4de 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1219,6 +1219,12 @@ static void brcmf_usb_probe_phase2(struct device *dev, int ret,
 	if (ret)
 		goto error;
 
+	if (BRCMF_FWCON_ON()) {
+		ret = brcmf_fwlog_attach(devinfo->dev);
+		if (ret)
+			goto error;
+	}
+
 	/* Attach to the common driver interface */
 	ret = brcmf_attach(devinfo->dev);
 	if (ret)
@@ -1295,9 +1301,17 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
 		ret = brcmf_alloc(devinfo->dev, devinfo->settings);
 		if (ret)
 			goto fail;
+
+		if (BRCMF_FWCON_ON()) {
+			ret = brcmf_fwlog_attach(devinfo->dev);
+			if (ret)
+				goto fail;
+		}
+
 		ret = brcmf_attach(devinfo->dev);
 		if (ret)
 			goto fail;
+
 		/* we are done */
 		complete(&devinfo->dev_init_done);
 		return 0;
-- 
2.1.0

