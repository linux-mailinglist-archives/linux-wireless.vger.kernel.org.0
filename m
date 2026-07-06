Return-Path: <linux-wireless+bounces-38686-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zjzdIiCmS2pCXwEAu9opvQ
	(envelope-from <linux-wireless+bounces-38686-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:57:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B29710DF8
	for <lists+linux-wireless@lfdr.de>; Mon, 06 Jul 2026 14:57:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ATgxXhik;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38686-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38686-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7EB33001F97
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2026 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A042A140;
	Mon,  6 Jul 2026 12:38:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6442CAFB
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2026 12:38:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341487; cv=none; b=tUG9L6QJ7HeNt7V44r/RszyVtDhi2dKqMYTv2zWIf0W49d/2C65T+YpX3ISb+o1hTLueCDdgvmLT4Ma8gXcOjPbwZYTYWOOfQuLb/f4HHcWD9XcP7CKtAQHDjAAt4Yif/YyKj3j3DYX4NThjOK0kdBaGkPfELx7CvrL2JmKubyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341487; c=relaxed/simple;
	bh=KTWgBS2LveFv+3JGpa4YwPUoQcfmFEjv/BChcCid2Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g//81MTwe4595mxohOp98zu7A+zmaGSRuy2+d9i6HWny5z92xYX3PhTCM4vp/NijsLV+Ih7y6oEacHFRWhiKTbmqPpxym+74t+C1OeviBeUnmxYvQXkTy238UcqxaMSEg+pwU9iwtkr2vsyEi+NFWGxS8uHzPvun/+DNsfyCPiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATgxXhik; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381216921aaso2691879a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783341483; x=1783946283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXJCzkj2a4rope5496Yz8M7a7yyPQg8Zuq+VELoHYjI=;
        b=ATgxXhikboBBr06CHV8gvlLgmWmGSQrHaAymIjh+nnMZYHn7rDH6MdAvJtHRaxeWC8
         Rhp2tiN922k7+XWrWRb0jVaYp6JoLCT0h3SVAders25vk3Nh34fInyDMGMvCHg0j5YHv
         /p1+Gh+4m4RBBF8MpMfShMqEbTSyxp3kwOpx+06gk+/cJB5vhcGEuzQCALLiI7hEgH9Y
         f3adRPCFHcPCCbyXXdbtjKwKgsgLUiYoNkhIY8yF7paIQZoaXwiyCAZU1+ONH6DbDMTk
         G4L9zEecsdUdA3PjpnTxIEernpG9T+KZxP45DSFDPnkjnhQLwUD8Cdu9Acf/a82B2wwM
         WWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783341483; x=1783946283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uXJCzkj2a4rope5496Yz8M7a7yyPQg8Zuq+VELoHYjI=;
        b=bjTX/lFY8PR0tGehnN6R6IVBYBPD6tFsSDTH6htFwPJh/a8hUmE4UNaBqbzUte/xQn
         F5WHoStKNZkuPh2YWTqk9WMAdhaejHhkZqBmIUTp00e7f53e7DoAiqSfhirHzvERMaQC
         SThsVG0ZCNA4g/9Nxwlm1GCqTjiVT5du5sFTkwDl0mCdyg1LmYcBuTp+Xv3Mdda0Ooy/
         43XJPljvOZyB682qbBhHm+fdDTQaZC73/6TncnYcXMGLk91UjBFjc8QAKharxRAKP3P3
         eabIuLZbyj86PN5HB3ypPzSGBSAgvnt//8ZdvdTtG1/rkQLVRHB7aF0yBmJ2jIBptAlJ
         7PDQ==
X-Gm-Message-State: AOJu0Yz3fRy+Lt8tu8Iik+VEmbGOjnNYeiv1mTGsMd/QYekSMtGaK+Os
	E4PgVbgGm0DmMb+48WpY54Jc3H9MC/1eArPn3+USzg5ko/QsiZpOOO6w
X-Gm-Gg: AfdE7cmk1SOPpG6VvNaUHE8Govcr752/hiS6cG+oFDqGol3DDmGzlLQBf8Unm/EevtK
	BLDFJjF9v8Q9iTR7PIxv4gZzLJWSXsSk6wz5jILc2owykEUflTgrt0H0DPRDK8i2y4IjrIqCaWi
	8Lbkmo9WtJqGW5xE/c6cN5bNS5m84B9MoM81OQDjUeZsO4VWIEzDjbFi86Y/UIWNbL/J31OgszI
	gN2FyFmGCJu2PL7zM5QKwcfdY6G9IOt2MMCZbyZNu2RA9wOEQVqz2jQnVb0LF7LPY8p0Qpef6tG
	9xFPgWKuZVonWBz/sYYea16/XfpnmtFcCJFLqjGp+nl1nMGw6UZ+ES8f5/Y5R+RZoJSim54vhL5
	3C96a6QRT95TBpWQ+6WQu3Bq1NgMH+/jMOEYcXrXIFzHEe5xTZHipl/mf7T1xVgYpi5UDNv1oeZ
	D5Xey2TKJ+zCx/8yg/Bw==
X-Received: by 2002:a17:90b:5625:b0:37f:ad36:8fc5 with SMTP id 98e67ed59e1d1-38758938a18mr119087a91.23.1783341483154;
        Mon, 06 Jul 2026 05:38:03 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3812815c10fsm4942969a91.13.2026.07.06.05.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 05:38:02 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] wifi: mac80211_hwsim: clean up radio rhashtable on free
Date: Mon,  6 Jul 2026 20:37:56 +0800
Message-Id: <20260706123756.343818-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-38686-lists,linux-wireless=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:zzzccc427@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 85B29710DF8

mac80211_hwsim_free() removes each radio from hwsim_radios before calling
mac80211_hwsim_del_radio(), but leaves the matching hwsim_radios_rht entry
in place until the whole table is destroyed.

Other radio removal paths remove both the list entry and data->rht while
holding hwsim_radio_lock, before dropping the lock and deleting the radio.
Do the same here so the all-radio cleanup path follows the same object
visibility ordering.

This helper is used while all radios are being torn down, either after
callback users have already been unregistered or while module init is
unwinding, so no hwsim_radios_generation update is needed.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
v2:
- Reword as a small cleanup rather than a sanitizer/race report.
- Do not update hwsim_radios_generation while all radios are being torn down.
- Drop the Fixes tag from v1.

 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..5c59c1a8e720 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -6274,6 +6274,8 @@ static void mac80211_hwsim_free(void)
 						struct mac80211_hwsim_data,
 						list))) {
 		list_del(&data->list);
+		rhashtable_remove_fast(&hwsim_radios_rht, &data->rht,
+				       hwsim_rht_params);
 		spin_unlock_bh(&hwsim_radio_lock);
 		mac80211_hwsim_del_radio(data, wiphy_name(data->hw->wiphy),
 					 NULL);
-- 
2.43.0

