Return-Path: <linux-wireless+bounces-32483-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DuaIa7FqGlaxAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32483-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2972209273
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 00:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11BB93019F27
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 23:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2746A3612E0;
	Wed,  4 Mar 2026 23:50:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E610135CB6D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 23:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668240; cv=none; b=d9IQ8H2TvBAzSxLPQzlFZGisJHwg8kNAOFFEfzMuerf1frqlpEeuqxu1cjrTZ7nTMJZpjDJk4nbW8FRgu7gewk2E9hkf04q32+asSBCgKxEUHhbdOAv+dnoUxX38lK9PNs8gMMPsHLzoKKL3oDoGZ3itKPLMl48FnIBH02ibNZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668240; c=relaxed/simple;
	bh=A4EB2Q20jIOiXa7ClnuDyx4RCEAWysqJmidIsP3yDZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiz7KYvR21oJSAXb0LeSr4HSw8iIQ8KQY7j8Q+G7YZ0LLrNdvTLj/u5IT1Xzf437M4F+vWxJ2tCRgP3i/8XBCmGXGwj6yEzb4nhcXZWdZXnPKyCJ9LJo5KeA+k1MNI1O5oPPPQPbMWQ3l4Mje4srV4e+aGZPfsl+UYkuKE5yEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4648447c899so4702987b6e.0
        for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 15:50:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772668238; x=1773273038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DENFRZ7KWOZocO3IIbqB68mf1LkYaLSXQWPItVkVVdk=;
        b=LtWke5fW2AMVO14BBBq3YRAACqIXKopVecEAUfEAZPFaNa+SxG4VAeI+hpgxOITrST
         4lm+pbTF3aArhctfKb0GIfSiiqf+el28e6qAJ4WRmVYV3eiKO8ww8kZwxlirgjmlHtPZ
         O44vL6eXQGXSk/zNufJNg7CsXN2saSjKCsd0TqFPjHUz3boabFyFMxNDnFRMGrhzvb9/
         P3esXrBUfMZXFWz/QAOkgzqJnhr7vul+xZfKSHCtHad2a3CQoTb5lwv3sXEkKz9h9Esh
         TrfU1gQY3roETNbGL7LlVx6kOzjfPtldXAhcHKxT3IdiKFbLhNpu0kKXzzgq7m0C5392
         NKuA==
X-Gm-Message-State: AOJu0YysP0OTfLs0zF4fEAyZwYfJOTBAYqTKia8+OSaklauweWbO4ToJ
	yVvzJxlpdzG4fjJdTJgBWZmexuvIikT7abPlcRWon+Uhu1E0H6Q1Zbn7
X-Gm-Gg: ATEYQzyd/+C5+zq6GWGN0IUD+H/mw32potE+IdziYDEmGjCRY25XBhix24xgMQ5/mNp
	2LIbSB+chW00vFrBf30xahyiGeKD76AMSyyw7hYNQn7ffI3VRPAA8DrW+HREQQmezP+XRYErCFb
	arfbzIo6fJ5vGLIffLteRgp7Lf3BUhJ2lvMi9WqaPgUsfbh3CyWan7+ovYrgubAOve1ahknvXHp
	qa81f9VwjNA8unbzmZk3h1t0DcpAZbI2d+QAB622iWw0Fwt9uW/VhA0XASEPzDSrK9wz52iBC0a
	QI0PbpQHA4bEML99RRl5vu8WOArTHJXbsmKFj4Uf3L/5oRLdT54ZQ+t2c6ksZREygjRzIW649I2
	OY98BVE874eBL95oY03o55EF9GsRC7zoEI1dx+KIhd2iYuXbLJmKskIYQgbrIDEk+cziidVUeGQ
	zOJWeVd6zEqdow0ckVwTI+0i3DGYjyutPx/6wFhpNkKZhlCZI=
X-Received: by 2002:a05:6820:4ccb:b0:678:cf78:1ea5 with SMTP id 006d021491bc7-67b1e90212amr2283431eaf.67.1772668237927;
        Wed, 04 Mar 2026 15:50:37 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bfee3csm14410687eaf.7.2026.03.04.15.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 15:50:36 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	yu-ching.liu@mediatek.com,
	yuchi.wang@mediatek.com,
	jenhao.yang@mediatek.com,
	posh.sun@mediatek.com,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/7] wifi: mt76: mt792x: advertise multicast management frame registration support
Date: Wed,  4 Mar 2026 17:50:14 -0600
Message-ID: <20260304235020.40451-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E2972209273
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-32483-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:email]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Advertise NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS so userspace can
register to receive multicast management/action frames.

This capability is required for NAN discovery and related operations.

Co-developed-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Stella Liu <yu-ching.liu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt792x_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 152cfcca2f90..f12cbfb35f9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -678,6 +678,7 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_BEACON_RATE_HE);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_ACK_SIGNAL_SUPPORT);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
 
 	ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
 	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
-- 
2.43.0


