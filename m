Return-Path: <linux-wireless+bounces-38720-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IqnECUdqTGrBkAEAu9opvQ
	(envelope-from <linux-wireless+bounces-38720-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87451716E89
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 04:53:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=aC2fjKNL;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38720-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38720-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE8B4302AF22
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 02:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55CC37C0F9;
	Tue,  7 Jul 2026 02:53:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D00237E2FC
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 02:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392829; cv=none; b=EJ8HuHhtvZ+paXEgrRMNvD0Q/2suksZtTPbvllwGNtR4uAZUojv0kARuhpjqS+AC41+C9oP2AJ9dgdVLKsohtNy+LvQYQEInbBzGSD3ESIQXYtDnp59lipMMTHCqJxC4o/ZKhUp1W6mSi9vOreXCvaqrPAy4+dySNZTC4d5mCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392829; c=relaxed/simple;
	bh=AZbxg47109ou2s/tC9r7vzmknWS79mY7FNjCTbfprco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDcf+gY93HkKho/1p/xNIvmrYdi2XJ2uhm8zM3gWaTpZ/6E1Xcjtp5giuWW/tKmr9UmTMZVr3PaqbbOyM+8Ij9FEl46haILV58QrxJxW2PZWLXWl+/1cTch4n7krOWqYVFRntznfnIXP1IegEYo1991SIsfPAn9f/+72L3CjcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC2fjKNL; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-381ed661712so3286774a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jul 2026 19:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392828; x=1783997628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W96W2yhOoeXT7Hln4eYd/7QaqID/7n7Di/L6+b58oH4=;
        b=aC2fjKNLfeMR9eSTDZo0au0y370e5L7kgK/cnrSAcxzuUXy3T35xAaBkSkKDdKK95a
         TvQ/xulZRIyDVOH5KgyneWx8NPt9FXc2IdY07R32kQUEgm+0X6CM7HsVOqbfp7boPpLi
         xdBPhNi+f8clnjUAIJ/xZHeCxFnVx2s06gfvCIm3RuruyFyqO+bLBVGKC5UWy4tqaf2e
         uKz/Ydw2EPaCtfKJyMffCAjDXjynV75wJ+RvTa5lBL+UdFWyuq56Qja7aMZYkpU3O/0c
         mEReRllZ31tqw7+/6rrB3VgTFN+8b52/6SKhCJ6avvByCA+2afRS+e8fdCuv4KhVDidb
         pGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392828; x=1783997628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W96W2yhOoeXT7Hln4eYd/7QaqID/7n7Di/L6+b58oH4=;
        b=Q5ApfNRIjsTeSrpdOK5lT7mowmKeQQuH8ZQRoTHhTfbS8AlK1AzQfi0d+B3YNNf/ig
         XhFcldfUFpMphFTudXiQitf2mdHdIEc1vQs9qaWpxwIbImDg0FxDZHrMi0aw92+7jkgO
         VT9CSQGZnEem2ghanHDHddyk4kocCKJ0Efe2y7MLOVbzEMyXXjjqOfzwTdl1TMAT60F1
         cFNws2OLPAwOQWiRtGc6DCutz+4AVTOAevKkXHOsNrk6tZcopDk+N8RG6gVNHnDrv9Ky
         7fgxwqnEC2Ip54H7Y6aWAXsnUMzLEX8mVwE1EmNeFgDrJh0CtZbgISu6tq9BnSTJdg8v
         DmFg==
X-Gm-Message-State: AOJu0YxWtE47HJauC0+D0dNn3hN0ORa76XScobolUBAPP8Myv/yDKFgb
	hnT4j7yK+6QdTecWtobJOkIL8ENoTX/p2wlTqy1RWKeNhaP12swNjqT26f6fjSazNbiXRA==
X-Gm-Gg: AfdE7cmr/cS+MYZhEvYpC2Si8UZKp37qF3qihk6bnFYZNGzsS7e5sSOKFlijkSwTj2h
	mXlgg2Mto1qKSkMha+8HNILegS7TYbqM0K8mtv3fOxXXF8XePnax7QGAo79pDU2a0TPyWwPk77T
	xQYIebR1RXAb4MdYdp8mQpxiEOVUyE/0KsZXhXnBKqqDYK2tJaOD23xRLSrOxZ63YdH+1fDxE7f
	74+tOhNkleUicNQzvEisn8Zlcaqs4IQ2jbNL7Vr+RBERZbE1QczC1gvf8UpejL1Ji7lNUc8H3mx
	Az0DnN2bv5FGySCId6d03jNhrytR3GramnaFPb2le9C8neHP2udnmlO8UTImdZv6zGNX5NLt06I
	ThP8xjr3ajON0pTy2VqZ3wCpLLimDkx1wxk2k5r0kIUUiF/WuvNNotyimZ33jw8g7WxTHPTHHfC
	Lgsl8Qg5xqv+NZGnFY3al2SQpKcVrjPnUEE4KSNXs=
X-Received: by 2002:a17:90b:390e:b0:381:270c:4dd1 with SMTP id 98e67ed59e1d1-387572b2e6amr3194440a91.20.1783392827837;
        Mon, 06 Jul 2026 19:53:47 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([2407:cdc0:606d:ba36:a6c6:36ae:a290:5cf])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm2755235eec.6.2026.07.06.19.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 19:53:47 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: mac80211: validate deauth frame length before reason access
Date: Tue,  7 Jul 2026 10:53:36 +0800
Message-ID: <20260707025336.22557-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260707025336.22557-1-enderaoelyther@gmail.com>
References: <488ed9862d5196b8f5ecf23f037fa6725fbe9a52.camel@sipsolutions.net>
 <20260707025336.22557-1-enderaoelyther@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38720-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87451716E89

ieee80211_rx_mgmt_deauth() reads the deauth reason code before checking
that the fixed field is actually present in the received frame.

Validate the deauth frame length first and only then read the reason
code.

Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
v2: No change.

 net/mac80211/mlme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b98ddfa3003e1..8be470d730f52 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5179,13 +5179,15 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+	u16 reason_code;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
-	if (len < 24 + 2)
+	if (len < offsetofend(struct ieee80211_mgmt, u.deauth.reason_code))
 		return;
 
+	reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+
 	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
 		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
 		return;
-- 
2.50.1 (Apple Git-155)

