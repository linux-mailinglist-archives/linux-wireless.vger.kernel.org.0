Return-Path: <linux-wireless+bounces-37753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5V+GCJVLGo5PgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:51:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9567BDAE
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 20:51:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=olTTVOLa;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37753-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37753-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A4EB326D4FA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 18:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B139B969;
	Fri, 12 Jun 2026 18:50:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FCE36E48C
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 18:50:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290253; cv=none; b=TSab48T2++XKoNoD/U09lYjpvTxXSjxKgSetk/peIHDgVOM5pwiNcQLnjNXPWPX9d0nKcXTFNVN48vMEYHIq9tj3P5lqUHJmwvlDVe8g0IDgcuPXSmZyspxDDE2yc9jQf39zmIwu3SGAZS/GWdlctSXtKJ4DKpDvmRm1zE8plzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290253; c=relaxed/simple;
	bh=zqdxczSfCDR24qK8RchijXOYco+66PeeGVmmOB0l8Fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/2NZ0tUmDhI1uw8GNSN2mLjsx61IhSDq7qDBXUgnqLlIvuKHHrhB35fD9PvTcaiqjwVhxrW3NNsw+bfgzLYnZIhd+1FtqoWYpa1Nj98mZ03fuXYoMY6RdIe0qfWQxkGjUmPgtEyTVfG1jW/lesuNSTLulpyF5KnoM7g++atI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=olTTVOLa; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf30d530bdso13563435ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781290252; x=1781895052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TDQxnXyG/6WR12CZ2iRyY55tbEMYwWbeoypsoM106w=;
        b=olTTVOLa1MdVRpoXpCY3QdGjxZcyY83UUjSiJ60AsQuC/Q2CY/hBXvM/OfFSrvZS5p
         2bDuHLuAlxAevbdQKVXfGvRNc3ZhKapVa6dSC+dzwtB0tnMRNBWmrfCvIvQwy/f58LVJ
         IuZtprPnck72OgnBV3KyGcTxvL/llfWvXY4Awkh0AyJ4klKSrcZm2XbSajBTtyCvRogC
         tJ+6jzHnXgVzsC4CixSrsYpKjVGmBiPRq/X4dt/77T7yC7jVUFQQX+zilUARCGa1ZCPV
         agNlUB+h6UGpLle8ExZ/++bJrGSZACrJ2lCPJmbza8puAgVJ/ycfgwHbWFGYS6WjyWAD
         QVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290252; x=1781895052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5TDQxnXyG/6WR12CZ2iRyY55tbEMYwWbeoypsoM106w=;
        b=Ih5y0Vd6HaEHGykw1V6V10Z5pSYhBFcl+MmGS5eQh9Pt72HYIL6B8J3oqqinuEQ9DZ
         07zQChVH/+ihwShlp7BmOsZhW7NhQq4QZQ+nREOt2XDQtXuCrgn3FT82QfsIRpxLy4Td
         ZQxssRJ3BbaluxcLOq1ayGUzS8Sx9mTYJtBZKj/AeLPGbYoHrIgznseHs8HlG9s/PkKn
         mjyrvzRzKJLNdiAbtEMN7aKxVVBr5zm+/YJhDPAO7tX/XXMR9vMa4QnmCyRxlBoo78T/
         kIg0MUgnQQDNq8O74lQi2Ssq6LURHacN4EfTC/YFl0qaOx+CAq1n7wSm0f54ytZ+tVRH
         x7Uw==
X-Gm-Message-State: AOJu0Yw9cY5CTz6KTtG15Yt7/KEiqQ9FkrNjEF3MTCsYq6AZ/8cxxENm
	zcEcy646wvmten1Tl0ih+q4nnunIrPrab1eSJ9zi2VMe3nc38AR/VCp0
X-Gm-Gg: Acq92OE8BiRkVWx4YRAdJWaKd+ZKf20/T81U+nP6mDn8aBjFXaX4OBdJ+0F8BQ2b7EA
	WXAb4urKe/xvXHdP/KaTsSeyfgcu1rxHOTWhwCV0k3rZu2ZX9a2zPi+gmHt9BUlKw3vTQvBwBtq
	RVPqVII5cSuJg27bXf97bzBjoRk1QtvrLMkUybKqIPPReq443Ei60UzrDndGPM/aInQm9uF0Ksn
	Qtb6MbHNBbJVTdlWEm4Cmx4FNGImIfLAzv7MEn7prPxhHWeMnNpNQduJrzosSqr7ElJsw6a4ssf
	U2gKU5ZEjcmcu7F9R2J7JFNR3NdHDGo3TQ0bhgpcuaLglrA0WtvACmuv8bJdq6N+dRx1+3i++bh
	7XW5ltuODKgj50iJNT/qjpITqBDKuyiyp+hQXjzlstV6+xUFwz+gkIoEBeQ9zTAYIPXzpA2udn9
	To/rIUEQ1ncs/CzHPaXZepeVmQoFaBMhkCeevyM9GpB5QGvFj3ImjO/tIPleNf3pc=
X-Received: by 2002:a17:903:fb0:b0:2c1:d49c:8396 with SMTP id d9443c01a7336-2c6641987dbmr10454145ad.1.1781290251880;
        Fri, 12 Jun 2026 11:50:51 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm28464465ad.62.2026.06.12.11.50.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 11:50:51 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] wifi: cfg80211: validate assoc response length before status and IE access
Date: Sat, 13 Jun 2026 02:50:44 +0800
Message-ID: <20260612185042.66260-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612185042.66260-4-enderaoelyther@gmail.com>
References: <20260612185042.66260-4-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37753-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EBB9567BDAE

cfg80211_rx_assoc_resp() initialises the status and response-IE fields
of cfg80211_connect_resp_params from the management frame before
proving that the frame is long enough for those offsets. S1G and
regular association responses also have different IE offsets, but the
S1G path only patched resp_ie after the unsafe initialiser had already
run.

Defer resp_ie, resp_ie_len, and status to after the link-iteration
loop. Use a bool to remember whether the frame is S1G, then validate
the appropriate minimum length and set all three fields in a single
if/else block. Funnel short-frame and SME-reject cleanup through a
shared free_bss label for the abandon paths.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/mlme.c | 56 ++++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index a0f7b08bfcc9c..097b66f758ba2 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -32,14 +32,10 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 		.timeout_reason = NL80211_TIMEOUT_UNSPECIFIED,
 		.req_ie = data->req_ies,
 		.req_ie_len = data->req_ies_len,
-		.resp_ie = mgmt->u.assoc_resp.variable,
-		.resp_ie_len = data->len -
-			       offsetof(struct ieee80211_mgmt,
-					u.assoc_resp.variable),
-		.status = le16_to_cpu(mgmt->u.assoc_resp.status_code),
 		.ap_mld_addr = data->ap_mld_addr,
 	};
 	unsigned int link_id;
+	bool is_s1g = false;
 
 	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
 		cr.links[link_id].status = data->links[link_id].status;
@@ -60,16 +56,32 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 
 		if (cr.links[link_id].bss->channel->band == NL80211_BAND_S1GHZ) {
 			WARN_ON(link_id);
-			cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
-			cr.resp_ie_len = data->len -
-					 offsetof(struct ieee80211_mgmt,
-						  u.s1g_assoc_resp.variable);
+			is_s1g = true;
 		}
 
 		if (cr.ap_mld_addr)
 			cr.valid_links |= BIT(link_id);
 	}
 
+	if (is_s1g) {
+		if (data->len < offsetof(struct ieee80211_mgmt,
+					 u.s1g_assoc_resp.variable))
+			goto free_bss;
+		cr.resp_ie = (u8 *)&mgmt->u.s1g_assoc_resp.variable;
+		cr.resp_ie_len = data->len -
+				 offsetof(struct ieee80211_mgmt,
+					  u.s1g_assoc_resp.variable);
+	} else {
+		if (data->len < offsetof(struct ieee80211_mgmt,
+					 u.assoc_resp.variable))
+			goto free_bss;
+		cr.resp_ie = mgmt->u.assoc_resp.variable;
+		cr.resp_ie_len = data->len -
+				 offsetof(struct ieee80211_mgmt,
+					  u.assoc_resp.variable);
+	}
+	cr.status = le16_to_cpu(mgmt->u.assoc_resp.status_code);
+
 	trace_cfg80211_send_rx_assoc(dev, data);
 
 	/*
@@ -78,22 +90,24 @@ void cfg80211_rx_assoc_resp(struct net_device *dev,
 	 * and got a reject -- we only try again with an assoc
 	 * frame instead of reassoc.
 	 */
-	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status)) {
-		for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
-			struct cfg80211_bss *bss = data->links[link_id].bss;
-
-			if (!bss)
-				continue;
-
-			cfg80211_unhold_bss(bss_from_pub(bss));
-			cfg80211_put_bss(wiphy, bss);
-		}
-		return;
-	}
+	if (cfg80211_sme_rx_assoc_resp(wdev, cr.status))
+		goto free_bss;
 
 	nl80211_send_rx_assoc(rdev, dev, data);
 	/* update current_bss etc., consumes the bss reference */
 	__cfg80211_connect_result(dev, &cr, cr.status == WLAN_STATUS_SUCCESS);
+	return;
+
+free_bss:
+	for (link_id = 0; link_id < ARRAY_SIZE(data->links); link_id++) {
+		struct cfg80211_bss *bss = data->links[link_id].bss;
+
+		if (!bss)
+			continue;
+
+		cfg80211_unhold_bss(bss_from_pub(bss));
+		cfg80211_put_bss(wiphy, bss);
+	}
 }
 EXPORT_SYMBOL(cfg80211_rx_assoc_resp);
 
-- 
2.50.1 (Apple Git-155)

