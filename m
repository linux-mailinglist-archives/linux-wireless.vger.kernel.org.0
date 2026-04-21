Return-Path: <linux-wireless+bounces-35128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ5LGBhZ52n36wEAu9opvQ
	(envelope-from <linux-wireless+bounces-35128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:01:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B54439DE7
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33E70300A59D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 11:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC423A450A;
	Tue, 21 Apr 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqx/gJu0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91B3BD634
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776769299; cv=none; b=lxaS40E3/06riis6WxJGh+OxXR0cHhTsSHauH/Xy8nGglRuM22tBqNzJZfa19fkiQrerSQIhye/ZW50hYz5g8dBYzeEsK4vyGXsDt4rr2pidgFioVHjURw6BmCHjHXM+6m4cjSGczoCK7RltVRNNrQyZg2FrlgX4aJn04xqPIvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776769299; c=relaxed/simple;
	bh=5oYek8U8uRzo2RRdX3NyPwd4aOxjGN5eoLYQfQzsH8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1qH9IE/b9IPP/wXGN4YEViBxCCEUeR4qCiysHmaRyXfbcVGPOLOjENpwAtcXMLfNEIyc/b3fC5mmrRfALwjFVDN253/X2bDlLcnHquNKBzEZGYuYgX5QbL9TS+OyszpHrhXEns+s2wCCUcjIaTz1xHftTazjkhuZ2nIfTtNndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqx/gJu0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891f625344so21843545e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776769296; x=1777374096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuEPxz+kITMfWsklzqWqj19CFbpzLcU0wSqdJ6SYL1Q=;
        b=fqx/gJu0WqpRB6zhe2LSTf/dJZtAdFxILB4Qk2ZcyqD6NpzMiMdPR4js0MkipBYeiV
         O1pgyItwioksuVDHu01BpVvvT/gwDDSnMspzWB+W1G8D6i6GIWWApeuhpk4NwRGSCE3E
         Nrf5FNJrGpNTkpoR4FPgVGglxla09CePO9xQTjPhu8PtRKSd8nx6yZZwb0LJBUhLXEuT
         O5P/dJEnVT5V1UsxJ80NUpfeFtD2DSdznnJaRYt4CWZ5q0XiUvaXV0FYoLlpmAG1CMvT
         ZLMY2hRKKog4Ro0hY++Uzl3I9c7x9NKjC/wVNsi16PRXm6LXennMvrLVPSu/mnBqtVTe
         6omQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776769296; x=1777374096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuEPxz+kITMfWsklzqWqj19CFbpzLcU0wSqdJ6SYL1Q=;
        b=SdHR28OtUf62KOQUMaQ/n5W3BKVmsNzhmsEDRoBRSmQ42gbm0uaLXzOD/jQZxPbEfW
         VYI/7URlFn6Ltl8/yYJ4TP+oI5UCagrRUdi7tkx5KlZN7D4Py9I0cK4MzsYj0pmzWu5r
         mxu0rDE70eBDeMYO51ovoZJ+RcPI8PcVPiyMqFc947GxTFQk0Kx6uBe502njaFv4dfWv
         34yKwwptjYieb014NRKKfJJSKDnavZhyAB89PTAYYLtPJR8Tdr6fZfNaH/VejLNDZ0Ji
         ui8LZtQyY1ixZ47LK/MOVYBQKCFiQgzN9Oa7Hi4wg2jAp1KkNRLMEZELU5zeNZoiTfN5
         AWTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8D/hAof/DTiByAnvoTjvU3R8fx8dRapbcXifF96QxwoyVHlteaT7GjsHrAXf/Hh+NpAnkj5D+Ys8zwcW+6MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy3gPmfBzyhLTGBMCu332i+IbZMFSTwvderFsgKSyvCF+5rJmH
	pcfGqaeoQzee0LnPDVmZ4r+/5Wf0x0fU7pfiSL1bZ85Ou4AO3FCHioe3Trzs
X-Gm-Gg: AeBDievbfTjgeOi0ysHQT398A/Yr6m4jzNwanJkEvhiIl9y4kVRAj+5+xbj4wS39tql
	3LKyxb4Hofxom3YJ9jmnjzt7ZtWCC4Oz9FTayu8/Z0Uu8XtDE8kbESeY1PG5MgyO1vqwYI9rdMb
	rIhfnw+f2S2YIcR2h4yutIPIGsQv4ComyaKGwcGT1a3rJvBjuZhA/bEHz7C2MxILvLKrblsnsRy
	Glm5DRdxsl3Yg1ZR1fF4rAxxZ3D5O6MNjADtGpsPrlQLfJapBW5kyFc/KgB3R2jkvOQFUeMYL4q
	lY5ceMaArjNUxwjG9AE0f2RBZsT+KKlw5XwBILPzq37ftCLHd/rZYIdWriAc2OAHrHRXtE8z5r/
	2M3liFI2kcTmq5IjxTqAEtI40a6p1YWtfAJlom57Khb1ctv8tDRu5SN/nB25kpjp4RTAA0wgurp
	dnlsQ=
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id 5b1f17b1804b1-48a5821692dmr9436845e9.4.1776769295324;
        Tue, 21 Apr 2026 04:01:35 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55743c06sm14791515e9.2.2026.04.21.04.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:01:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] wifi: rtw89: add bounds check on firmware mac_id in link lookup
Date: Tue, 21 Apr 2026 11:01:33 +0000
Message-ID: <20260421110133.2957818-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35128-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 21B54439DE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The mac_id field in RX descriptors is 8 bits wide (0-255), but
assoc_link_on_macid[] has only RTW89_MAX_MAC_ID_NUM (128) entries.
While the driver currently assigns mac_id values below 128, the
descriptor value comes from firmware and is not validated before use
as an array index. Add a defensive bounds check in
rtw89_assoc_link_rcu_dereference() to guard against out-of-range
firmware values.

Fixes: 144c6cd24b35 ("wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Wrap check in unlikely() since this is a data path, per
    Ping-Ke Shih.

Changes in v2:
  - v2 resubmission with plain-text formatting (git send-email).
    Per Ping-Ke Shih: defensive framing (firmware assigns < 128
    today, but descriptor field is 8-bit).

 drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6435,6 +6435,9 @@ static inline struct rtw89_sta_link *
 rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 {
+	if (unlikely(macid >= RTW89_MAX_MAC_ID_NUM))
+		return NULL;
+
 	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
 }
-- 
2.47.3

