Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C79E184547
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCMKvR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 06:51:17 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:24880
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbgCMKvR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 06:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cm+RlDkhiv7PDp8mRJPToAlRX4U/AgehPiyBVAp+Y2pvMDNiQ67GfBo8GQwxwCavoUa4cFKD2w1zg/+yhtzeDgQzkB8UHlr0WXiRfBV4cPp6xGB5ReQWxfo2Ly3kzg+Ug1Ohxg/GIpmvK3r1aoeORC4ubGeOEpl48jvJ3vtwGau+az+9S0tAbioZ1pICjc4TjeOi0Z/KCgd9ln0VrbcScxnuBe2QvdZGlsqQijRgvtf9wd9OsUmwmsePW2JebQkR24o5MKn4Y8WmQMbTPNiBF03OZt8KfsqJ9J5Co2r1iPxgjnFM7CoN6pMJ0NGgooa+egL3GjsLMVi7tshEFAiXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79EVXAVp3rOPASPlMccRmPR5sV0rZ/Pn7DBUJqEpEiY=;
 b=EVnrNd8I3ooZTgC3kh9ZIDEAUr9LD9v8U5es7JcAdE5TZkxFMt4yK7ja+7yVW6+1P+2AM5rCKPiDJ0KZyAAdneZY3rmFB0IopqvfdK7jGo0LGolGFw8GceNyrxgi+ZxQrWCtuBFRO/ZerFCIMU0bFlEwNO/ogKVWg5t5E1PSxEZFdnJ6vGsWZzVKUg9G+9SFSE8pXqviQPBkzDEI4U2JgwDb8U/shkl8giJ+W1bddM3QkiBXm6v+C3z2hyU0YuoONnqdROIKWlsfGJzpgycRjZDm7l6A5JjhHYkERk5/nOqnKvvQkiVc0WzHfU+ujCiPPUCzYkj6Bc8LwUvgVbgzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cypress.com; dmarc=pass action=none header.from=cypress.com;
 dkim=pass header.d=cypress.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cypress.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79EVXAVp3rOPASPlMccRmPR5sV0rZ/Pn7DBUJqEpEiY=;
 b=nNgwrQpo/ZqEjWtve3/LsKc7CCzfCCgK4g0vG4Ttjh9arRNq06jO6fvZrNcwYPLDMGc4J39Pivw1RpirG2/UBX4KyodopEoQ3LJdQo50DeAQQK5mGAsio4kpUIn6AWS/mdtyqcrAfYcLvEfx6iTGTUD0jU1xKxuxEELqWDqrTts=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Chi-Hsien.Lin@cypress.com; 
Received: from BYAPR06MB4901.namprd06.prod.outlook.com (2603:10b6:a03:7a::30)
 by BYAPR06MB5303.namprd06.prod.outlook.com (2603:10b6:a03:cf::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:51:14 +0000
Received: from BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9]) by BYAPR06MB4901.namprd06.prod.outlook.com
 ([fe80::3cc3:7b1a:bd7b:a0a9%5]) with mapi id 15.20.2793.021; Fri, 13 Mar 2020
 10:51:14 +0000
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
Subject: [PATCH V2 6/6] brcmfmac: To support printing USB console messages
Date:   Fri, 13 Mar 2020 05:50:20 -0500
Message-Id: <1584096620-101123-7-git-send-email-chi-hsien.lin@cypress.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
References: <1584096620-101123-1-git-send-email-chi-hsien.lin@cypress.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0054.namprd02.prod.outlook.com
 (2603:10b6:207:3d::31) To BYAPR06MB4901.namprd06.prod.outlook.com
 (2603:10b6:a03:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aremote02.aus.cypress.com (12.110.209.245) by BL0PR02CA0054.namprd02.prod.outlook.com (2603:10b6:207:3d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 10:51:12 +0000
X-Mailer: git-send-email 2.1.0
X-Originating-IP: [12.110.209.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 448eb51c-e953-4c2b-d699-08d7c73c72ef
X-MS-TrafficTypeDiagnostic: BYAPR06MB5303:|BYAPR06MB5303:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR06MB530312A86E8933E78277E262BBFA0@BYAPR06MB5303.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(376002)(396003)(366004)(136003)(199004)(6486002)(2906002)(54906003)(107886003)(4326008)(5660300002)(6666004)(316002)(15650500001)(2616005)(66946007)(66556008)(956004)(66476007)(6916009)(8936002)(81156014)(8676002)(81166006)(478600001)(26005)(36756003)(86362001)(52116002)(7696005)(186003)(16526019);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR06MB5303;H:BYAPR06MB4901.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: cypress.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BI9j0bKYOCPtan1GlU5n98C0ULIN1GTtdUxyY4NVIiDTRNRV8S5MzhgqZDoFM0AaSLJif+e6VQOv+yKNnWQ7tAYaO2/32qZJGgdLysGLAzBDNkM6SHJer+ht72+aNy8ZlHxQrrq1gQp8dy/hVCDUSgf9hk81g/JaufJMME4jJ9Wv6y6GcCPgZyN1YHxBM2DI6+wvb24nVWmhBKMzf1rcQYyvIe5Uz7O/WqLHS0rOZI6vBG9zvbhWQDms5puUHDdXwzTsY28cn2c3GJvmI6eM6WBal21Gsgb+Qk8z40ISkiKLtb8EAqVsU3nebNWLE3Fmq5jWOtfRG1rYZvNoshpA2FjEeV+2jXUSvF09/hEb2ZSqS15MreNwNEU+EuZgD6T3ZlW++SHuUuK7JyRnpwwFaTgNWwpzcnHfNkicY1FgA3Rg1HSPS3QA0bIfJECShPMv
X-MS-Exchange-AntiSpam-MessageData: C4TIxQNJcxWDViinmfaOQkIhEDsWvncLDiHhWrHPArMS4QPYmky009awkkw5jbnwmj7e6TZsyhnf7mNJBe76A6alotf9NLktdkacRULdgqyDij8PPAvIUc/AdstZT0hZ0ZyIWg3h+FKCcjeaOOigGQ==
X-OriginatorOrg: cypress.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448eb51c-e953-4c2b-d699-08d7c73c72ef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 10:51:14.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 011addfc-2c09-450d-8938-e0bbc2dd2376
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0+Am3g4YObGQA6uLfwS6ohzzoZqM02a2dXwXYbbpCQhbwfuthQiikqbMitrkxcQ02nU37hnHi8eU8ebPnHhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5303
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
index 1108414c4c8f..6051657a9628 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1218,6 +1218,12 @@ static void brcmf_usb_probe_phase2(struct device *dev, int ret,
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
@@ -1294,9 +1300,17 @@ static int brcmf_usb_probe_cb(struct brcmf_usbdev_info *devinfo)
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

