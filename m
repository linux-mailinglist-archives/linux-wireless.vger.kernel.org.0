Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46479192282
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2020 09:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYIVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Mar 2020 04:21:11 -0400
Received: from mail-dm6nam10on2113.outbound.protection.outlook.com ([40.107.93.113]:25385
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgCYIVL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Mar 2020 04:21:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgNjAlR3QwM2mSmI9ssRmKlAHsNd/QpRoRqxKoAvapL+fYhPb7DZW9xLIb4wWUkx+/ufRIgElTxcWWnnr1dcgxgnoS5BaVpVjFa7h5yC7h90ulbH8XmTdNIfV8Yjl2A3t9lgX2rsfzP8In6xRTYFno/+oDB+fJKJ9A9PFac/VmD3a2AYlDr8IE84UqSZ1QjdfrSTZP8uBttCJgFTdvRUAD/MOtAcmEmSKuPCA4sc41cFkR9rmFHmCtSQxw3p1a+C3yFVFxFi3nl6jGNjkulwKqVjTaNgZ8pD41LaNEnaKbPKbd6NqPc3gh9nAbdQJY0h+VNN1iwYiqWjkDVPNNkHEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNkBuUVZU/ozrIYmxaegt/1j7J9Lw4n/0KUwNJLGlZs=;
 b=YDE83RmdMKSiGgL0yWKcOOUFezP80yJtlf2f9RnkFuBcZxW9LblKS8flZHVmO8z7xUBeiBMEIKrqEN36pNRJSa7HIRVyDL8AP/7EIVTU/hVuodHMGQjwU2nKKKp17jREAJ42OWS8FKaDxRVACNr7Rin4t6GUZ2eG67mRRejK/o4IIiQNyyCqa7POmjpcJggkvz5iIpAoRGkIsvHiC/rjOs4niSQ5Nx+bO7A10OcR8vMh2Eb8W6afRj5/0x6SZPBqqiLHQkO6bvbxh8inL7uzp4LcIlGMkKWu4ujEaLWYNWy7PI7Q7/Pw6yeShp1Fj5sihMh9LanVMVehqjnKL42b9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNkBuUVZU/ozrIYmxaegt/1j7J9Lw4n/0KUwNJLGlZs=;
 b=pD2+9fsbWinS2tEw5Zd5EBaQbk2crvHUwzoPQCex61Frw+vbrZhU7uIsSnR8wDPsGKzJOkI5/IkbAPKjgA81s8+WSiLSthsOTz1Sm75jo4PBaMKBOwJx4SCFnljsHmnwT6lHw9dlwOYC0nDJMeTsCafZDc759A3K/IzU6TyY3Nk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5189.namprd06.prod.outlook.com (2603:10b6:a03:cf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Wed, 25 Mar
 2020 08:20:59 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::69bb:5671:e8b:74c1%3]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 08:20:58 +0000
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
Subject: [PATCH V3 6/6] brcmfmac: To support printing USB console messages
Date:   Wed, 25 Mar 2020 03:20:29 -0500
Message-Id: <1585124429-97371-7-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1585124429-97371-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BYAPR08CA0027.namprd08.prod.outlook.com (2603:10b6:a03:100::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Wed, 25 Mar 2020 08:20:57 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4016b762-e215-44ff-d8c4-08d7d095722d
X-MS-TrafficTypeDiagnostic: BYAPR06MB5189:|BYAPR06MB5189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB5189236489F6DDEAE545EFB7BBCE0@BYAPR06MB5189.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(66556008)(8676002)(81156014)(2906002)(66476007)(66946007)(81166006)(6486002)(8936002)(6916009)(16526019)(26005)(956004)(2616005)(498600001)(6666004)(54906003)(86362001)(52116002)(7696005)(15650500001)(186003)(36756003)(5660300002)(107886003)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5189;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rtcw9TyVqgvoiLQqKggtaJQhmb9zBGFbxjQo2XnYoHyuCEE5uj7w/yzx91lUt3BERFdn17eaubALQIjECIC5dvLUj7OIPPdWMOTmLh974VvoPx9BH2kFSACN3VJgcZQ4jODjPzuL4kW87ikKgGzCL3fHzFOCsJZGTtbuccaxAzharF7EcgukFcZ9QUGqtMjBG6eFWQZaflVoJyAMUeZFB2ug4hrbeAcY5LeOVeiQMiKTHEXUhPevMA6NfOxtLkzJ++sZzJVbrVYyV7Fs2wuB+9MBPJeaaK/wZrlVBNcTHc2fpCIBGZHIWHl3O/G1xbiF5YYxoJg9Prf89qu0yW4R6FqH1wzedFAJoEk9pm2oRrBbAa8WZWW6XXzRwbvra9TN0rexIVjqzT/2gsHv9tEgz/gU7q4vBB+Qabk1p+O4I6c1aQLyNbseq5O2rzqsEfKx
X-MS-Exchange-AntiSpam-MessageData: mk4RpTCkgwB2I6ionznOssZZpj037mmdh3tYeXtck6q4l/ri4SLvnD9X/7LAAAB8PfRVueIJsDBR5lBiKa150g9W2+vgt28/DrrDk4OIBzynhAznpYQeYjANQq1CH6iESIP/o6XCR4ZYpCu/TMXuYg==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4016b762-e215-44ff-d8c4-08d7d095722d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 08:20:58.6722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ4f/wWvU1Vhq4ZGpxSpiPWew+wnQ4yOjfdHAJXVip8ZjkEbWqZ25YJ4Mvjua/o/tMKrO0R7n1NHZSEYv4Rq6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5189
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

