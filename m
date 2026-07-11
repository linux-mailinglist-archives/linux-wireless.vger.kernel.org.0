Return-Path: <linux-wireless+bounces-38874-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ofWEvtbUmr8OgMAu9opvQ
	(envelope-from <linux-wireless+bounces-38874-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:06:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21414741DE1
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:06:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KBxwkMw9;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38874-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38874-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14ACA300B581
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F66381EB2;
	Sat, 11 Jul 2026 15:06:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C3033D6F0
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 15:06:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782378; cv=none; b=tmpxSiV+FU/8xAmDFSxdb5x5L8BLij1QB1DgD7KolqcTT39KE7w2P9lvB/vPDBvjWny9iYHVysA6W0UHQB2F3SAXwx+dYDtlP2yQAX7epCZTAfiTT+HoazRRyBERcxc2J4YXleT+DHtLVug5pIZMdrfiIalPQ8LoS/0X3BiSOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782378; c=relaxed/simple;
	bh=b0Csvthvox+ZikmYZaH+PCSy1gktpVVyy/GCAs1XN5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxfoeUXjlgiDVYzypff0jOpgMeG2KceTNFEKFLs3tLXRsoqLnLKzm8rOVE9t1Bs+eRkOoVk7ctN8lGXDs3RIU3zlJShM1gpBAbADIob3rq3f/nxWgeszse//LRNcJkvMFp/dTWUicp1JKur5YiKZ8zyXK+A8P9rcXeLMYmhu2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBxwkMw9; arc=none smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c1d487f2cso20485091cf.1
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782375; x=1784387175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gg+ng2VSqRvXrUN5u/dXzTCEv77wgL5YHqysVwmsFOE=;
        b=KBxwkMw94dijwIu7KeD0+36XbwQhET1hFLojN7VaPTWFLs1/l2g9gGRVX4e5bTTvhj
         fxfbXO2We+eT1/sQPC0LnW7DKsmT+P9NfO4fgBVmBlzftcab4a898a813DUecYViNCTI
         ZFwxwecQfdWJnfJDxwjHu7fnBvedDK5vZXBngJeTeDzLG2O1sHJXHnMi9IlLdtWmOTNW
         cLJDLa6qe/zFhJ9Yg0VeKenfyL/e7dGuEokGAPTofvM/AobDktwSt1iC45GSFkoLGN7f
         +aNNuJWzWW82h7EtO8UPdERB5dtHPs9GxkJbuKvEh05T+ecDMvh/J3M/EgIFPrYEqdPP
         dimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782375; x=1784387175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gg+ng2VSqRvXrUN5u/dXzTCEv77wgL5YHqysVwmsFOE=;
        b=hgan7OxYBmEaYWRBk81iyL1ZEYxFURdKELCx2JKLj4onD9Ed/Z6pgf02i9UTm5/8VD
         8dIH/GZphZlglivDRghDxskpjRj2s6sACgDi0TIKwbhi67SrPfYmkOalK8jgBvrxUIwY
         VY6DaV8olVBmypr4w31znxt05QzBwtXqo1yMBVz4d7i53meo+U2NjSPJLFV83cfL8jMx
         aTODuLqO+MYqu+RzLNv4/B+pCWFzCrRrje1RUB+ZloU+bWKoxTvBchprgjoPk1pTfumj
         ld32SL2qXUsfrjWUO72mNUzlmkoVUGBuc376srQtLEb2xnC0XGIH56MJkyBAcRKeOvWx
         gChQ==
X-Forwarded-Encrypted: i=1; AHgh+RooW6aqQNXpOwd1slLyQ2wApOZATs0H/B7z5CwueCf33hk1Fb17K1GvUBtLwWMW6SYQP9sXbzuZ8vWEYP0wDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrjOKfEnstaXw1a/PJ9sIdFmqyeV7vOEmGJsBmSgr4iTO1idDs
	cBkeLSN8FBttJXchmjaWK4SFe/n/jH89Rf+KGr38pM5tJyloUpmlfKUQ
X-Gm-Gg: AfdE7cnxGCg3b8tmcFtQGlVnXzAAJPAr9bpxne0B+cf6AuplWYYwpYmzEdmYtG83X8n
	tfFJjag4i5V0YtzJ+5+2UHRilfTWgz50i3XWDa05RXP49L59QoQkjWB6qagYRyAE3rtz2LHRSAn
	TYvtDVE9wzlxYGf+Nkv0kTUoqp6nYxwOzJn8UwnGkzy/YEqkE8gKHHdZUapkOYATsMFQR0VCObv
	j31gX3WtRHi7jczHTBBkbJJDBhTZ/Zi+dl8aXuT0OxS6T+/P7xuIGTxahOIpaZJGVymJU+E+Q8j
	kyGiPm1PmO0MSdNWHeh1XAfCx+y2q9h4Hb1kQ8c3WT9yhoi6S0H7iRx73lwsJpHLcHJT9qCZ2bi
	2eSk4gL8ToW0S9AxIGsmqQsvBIysDuLpPuY2jDC8DTRiEQoQzWDt+5LWn+Am1FehgEe5lDjciW2
	C/nJ7JvxmgeRoIs5ElltAZW6rBy9nuDE+PlZ3puaZkYpYz+Pzz6Fi2Kv9R/AkW7tqETHauXtGEl
	T2bj2Oo7g==
X-Received: by 2002:a05:620a:d8e:b0:92b:6805:917a with SMTP id af79cd13be357-92ef2c135d5mr363868585a.66.1783782375630;
        Sat, 11 Jul 2026 08:06:15 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d68e5fsm464578285a.43.2026.07.11.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:14 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: iwlwifi: mvm: add KUnit coverage for BA-window station ID bounds
Date: Sat, 11 Jul 2026 11:06:11 -0400
Message-ID: <20260711150611.2913332-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260711150611.2913332-1-michael.bommarito@gmail.com>
References: <20260711150611.2913332-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38874-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miriam.rachel.korenblit@intel.com,m:johannes.berg@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21414741DE1

Add KUnit coverage for a malformed BA-window notification carrying an
out-of-range station ID, plus a valid-ID/null-station path to exercise the
adjacent non-bug branch. With UBSAN bounds enabled, the malformed case
reports an array-index-out-of-bounds splat before the fix and passes after
it.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |  2 +-
 .../intel/iwlwifi/mvm/tests/window-status.c   | 77 +++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
index 2267be4cfb441..bf22750fceafc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
@@ -1,3 +1,3 @@
-iwlmvm-tests-y += module.o hcmd.o
+iwlmvm-tests-y += module.o hcmd.o window-status.o
 
 obj-$(CONFIG_IWLWIFI_KUNIT_TESTS) += iwlmvm-tests.o
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c b/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c
new file mode 100644
index 0000000000000..06807e2bdbc12
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tests/window-status.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for MVM BA window status notification handling
+ */
+#include <kunit/test.h>
+#include <linux/mm.h>
+
+#include <iwl-trans.h>
+#include "../fw-api.h"
+#include "../mvm.h"
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+
+static void iwl_mvm_test_window_status(struct kunit *test, u8 sta_id)
+{
+	struct iwl_ba_window_status_notif notif = {};
+	struct iwl_rx_cmd_buffer rxb = {
+		._offset = 0,
+		._rx_page_order = 0,
+	};
+	struct iwl_rx_packet *pkt;
+	struct iwl_fw *fw;
+	struct iwl_mvm *mvm;
+	u16 ratid;
+
+	BUILD_BUG_ON((IWL_STATION_COUNT_MAX + 1) >
+		     (BA_WINDOW_STATUS_STA_ID_MSK >>
+		      BA_WINDOW_STATUS_STA_ID_POS));
+
+	mvm = kunit_kzalloc(test, sizeof(*mvm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mvm);
+
+	fw = kunit_kzalloc(test, sizeof(*fw), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fw);
+	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
+	mvm->fw = fw;
+
+	rxb._page = alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, rxb._page);
+
+	ratid = BA_WINDOW_STATUS_VALID_MSK |
+		(sta_id << BA_WINDOW_STATUS_STA_ID_POS);
+	notif.ra_tid[0] = cpu_to_le16(ratid);
+	notif.mpdu_rx_count[0] = cpu_to_le16(1);
+
+	pkt = rxb_addr(&rxb);
+	memset(pkt, 0, PAGE_SIZE);
+	pkt->len_n_flags = cpu_to_le32(sizeof(pkt->hdr) + sizeof(notif));
+	memcpy(pkt->data, &notif, sizeof(notif));
+
+	iwl_mvm_window_status_notif(mvm, &rxb);
+
+	__free_page(rxb._page);
+}
+
+static void test_ba_window_status_station_id_bounds(struct kunit *test)
+{
+	iwl_mvm_test_window_status(test, IWL_STATION_COUNT_MAX + 1);
+}
+
+static void test_ba_window_status_valid_empty_station(struct kunit *test)
+{
+	iwl_mvm_test_window_status(test, 0);
+}
+
+static struct kunit_case window_status_cases[] = {
+	KUNIT_CASE(test_ba_window_status_station_id_bounds),
+	KUNIT_CASE(test_ba_window_status_valid_empty_station),
+	{},
+};
+
+static struct kunit_suite window_status = {
+	.name = "iwlmvm-window-status",
+	.test_cases = window_status_cases,
+};
+
+kunit_test_suite(window_status);
-- 
2.53.0


