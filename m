Return-Path: <linux-wireless+bounces-38483-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9au5E9S1RWrmEAsAu9opvQ
	(envelope-from <linux-wireless+bounces-38483-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 02:50:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5396F2B03
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 02:50:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=T0qW8dek;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38483-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38483-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9389301C149
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0661621CA0D;
	Thu,  2 Jul 2026 00:50:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B431FB1
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 00:50:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953424; cv=none; b=WX+8qfgE4i+8mDmaOccnQd3s4HvvEMa5jTb52C7q3AM6iXxGqf3NoxfwszBU/bTxUA784KmZDjgJo3EeYEEH/fXdOwyJG/81Dk1GAyLg1XuXkGqMROzzptl2vxuw2h2WeMx3kAiWExVFafucErRSV30A94Tus4FIcH6tJdj9ons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953424; c=relaxed/simple;
	bh=oAV3PO9BQ+ZuyovnCrvkgJTGceWcDv9CRAo4iAZ12p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zbr04mcruLPZYn7HBsonBVQCW4iixAlgdLIDWsbe9IT59HhF2BSo+IkkTzr57RfNc3BkH6miFsF47elA2qaL9PanYLPESaB0JIcV/55YdTRH4o5v/q7W92GIvIk08SVJeH1OdMIspF7hSkFbbsnT3qNlbkyLHg0OUGmOtq5Q8GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0qW8dek; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1263961f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 17:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782953422; x=1783558222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWkUSJ2157Xsff0+/g2CHpj4cXQ6nQx4HiCWFbqWFso=;
        b=T0qW8dekdGH0/URnE6qqg0dAY4aUECbNrYbMHqPJlPoAGcNi/n930ocAnIkqUKy+wo
         lSP9RyayirXAzHruU2CFrLofdrB9OUGNtLYDgNn4tXYKGpMrsnYoAHMOwb50W+XN1ti3
         nWnYuuHnztHbyjUREXTwVFeP1pdh/18JW5ulFoLAKFlzsZF37RGb+D1EIaBPJ68re4jR
         ONTwIc4qvJxkT8BOa1ZqVQxSsCqaI/5uvsyrSL70gHRDkUn47xkY7TXSVz8TtYZfl8XV
         RzFX69sPh5AdJiInWcUuxHVp2YKDjRu2shAHpyBpLsGQwv5z63Q0pQT9OB5PuPzc/Ao7
         yeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782953422; x=1783558222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWkUSJ2157Xsff0+/g2CHpj4cXQ6nQx4HiCWFbqWFso=;
        b=BxzTg9CuCNPi+AuxH55mpuIDp1WzuqJh0xmKbY98zrEMk4IVRnVjr8wvrH++CDj5+2
         BEcYDzdcuR69flCmaiz5Hz1uJD8imwLJn2xg5lZIecxIBfov4rDqvT2Mbhvzu4wgZhA5
         XJfoyiYW822qBbe7GUlwonxhjnXnc/r8HCmWot6vv7dKJX5beHV+Ea7dY9JRIgWaCcSL
         cQVwo9KRLIiJol48I72ZyiZks2i4UvV03bhMqed5rNZS/GsRmVFCaklJ0PXgn6Hlynny
         +0btJGiPOjB57U1b0XFSKBzZT5U+Xxz5hTqE25CIX1vo5c3eHPA6Ig4k4MwL3Df0eoNt
         SaOA==
X-Gm-Message-State: AOJu0Yy2VyRxVnl6ruztaJ50GTi3s818YCumWlxGtIoA6BWA23ufc9+6
	avCy7LpGJq+2oydAGowJSSy1ZT5O/94ewcM52yxvQQe+EXqxpmbUks2M3Bdq
X-Gm-Gg: AfdE7cnbaPCT0TVYlpwpS7qDZ/AurqhmtnYjICnK67g8RZ3XAz3AJQlAUtcPM2QP2Ta
	ZQlQmR0wawrcqlRBHa6qlXB1/eY86pEJrAgTuD7dJkY+UKEpYZC9LL6s4YCqUkNDaOjI7+XOtGu
	+CPqvc+HpyB00ZX4OYrktVNIk/7QEIFNCZFgyUbWAY4TRX0ca3w2AHSKods5nHPWAoG0VjoOSw/
	WBR83vvCj5aublKl4ras0s7bIIF8CM9o9+jwzeitrWxaq1QQWWIXG4lUxrN+Tz7x/WfbXZQRa6C
	AS0OKMHa3XrdMyXse7fU3+ZF+dVWQwVaih20iTzq796MDrWUwS30FIW0L4cyQ9VyTeWp08AceA/
	3ZH0h4mlxf7UPK1fJ3EuJbOq++kZ31wptX5S/+KnA9YsRo/VKRbyAUsn48Q==
X-Received: by 2002:a5d:5588:0:b0:475:f100:35f5 with SMTP id ffacd0b85a97d-477b5c415a8mr3398042f8f.50.1782953421736;
        Wed, 01 Jul 2026 17:50:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b83sm4747406f8f.12.2026.07.01.17.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:50:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vasanthakumar.thiagarajan@oss.qualcomm.com,
	jeff.johnson@oss.qualcomm.com,
	johannes@sipsolutions.net,
	tristan@talencesecurity.com,
	Tristan Madani <tristmd@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] wifi: ath6kl: fix OOB access from firmware ADDBA window size
Date: Thu,  2 Jul 2026 00:50:20 +0000
Message-ID: <20260702005020.708717-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,sipsolutions.net,talencesecurity.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38483-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:jeff.johnson@oss.qualcomm.com,m:johannes@sipsolutions.net,m:tristan@talencesecurity.com,m:tristmd@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B5396F2B03

From: Tristan Madani <tristan@talencesecurity.com>

aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
zero-size or overflowed allocations and subsequent out-of-bounds access.

Clean up any previously active aggregation session for the TID first,
then return early when win_sz is out of the valid range, instead of
proceeding with a broken allocation size.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v5:
  - Add From: tag in the patch body to fix the From/Signed-off-by
    address mismatch (Jeff Johnson).
  - Drop Suggested-by, add Reviewed-by (Vasanthakumar Thiagarajan).

Changes in v4:
  - Move aggregation session cleanup before the window size check so
    that a previously active session is always torn down, even when the
    firmware sends an ADDBA event with an out-of-range window size
    (Vasanthakumar Thiagarajan).

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/txrx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 80e66ac..a39c815 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1722,13 +1722,15 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,

 	rxtid = &aggr_conn->rx_tid[tid];

-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
-		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
-			   __func__, win_sz, tid);
-
 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);

+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
+		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
+			   __func__, win_sz, tid);
+		return;
+	}
+
 	rxtid->seq_next = seq_no;
 	hold_q_size = TID_WINDOW_SZ(win_sz) * sizeof(struct skb_hold_q);
 	rxtid->hold_q = kzalloc(hold_q_size, GFP_KERNEL);
--
2.47.3

