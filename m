Return-Path: <linux-wireless+bounces-34173-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKc/Gc8uymkA6AUAu9opvQ
	(envelope-from <linux-wireless+bounces-34173-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:05:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1188F356DAD
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 10:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECBBC300D169
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9643A8747;
	Mon, 30 Mar 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="aam+Aiw3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033853A8733;
	Mon, 30 Mar 2026 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774857495; cv=pass; b=TpZL4yNiZ6xz/Ikc6BM25JawJRebwbfl9KzmNsfE8BwQVamGRara/48/3bmd2ehusrv5EWlJ3xUSmEFGMAaYRs2z96dxeZICnMXWLKOSvLCAD/8vd2P4MgcvIINDwIlFwRMdSXiurTSx4rlEd/kt20+0YBkPrkdfGEIIu/L8BqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774857495; c=relaxed/simple;
	bh=PMaIzbLqBrjVxKpMuBjMYE1w0WGeUUt0zQH7i3Wxp54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iEdwqeTbjGI2jTJ2BvDGjIDzbsW0MaYJe2c4FOyE926KZFGXdEG/J63jaBcJTUKniN4yivcjW/NL3OTdcI4JuU1IVAX5vMOrRthQlFByZqA43rz+SJWuIKldppEs7d1hADPKd1cB/LLfMPmXRlaCqoWfhfztE/vJ+StuE8d5bzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=aam+Aiw3; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1774857461; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=C0sJnXnikR4x7vtFyrDkiDDQlEJrN293LjqOiOw9RjaSacnlXhzk4Gy3axMvq9gMncqYH2aa7W4ocnQYglUt0dcT6I5xUPreOxtuQeltgN9NkaesNW9ww6BxBDrl+AqdjixsWtMsSEV/e8+NXOam68orpJ5ndrkun8PmCgDdvMU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774857461; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eIMC7cDWsrBOtjtJ4eTyTeEKTFa7e1tg8E0vasvRRoM=; 
	b=P+TyzUEi6lRintRdy/j67dC6HcnvswGcA8C+ceVW7lKfkwlnkOXypwA00uTGpEJm5F3Ea4PD3FiSQs/Q1RSi5gIi/ObWbmP8A1mtm0MMMqx6VL1VndtNOWTdzRsYzMtc6dfMlcXwly1k4HArL8QJHJvcOvtX7VM9qSUt1bklGYw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774857457;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=eIMC7cDWsrBOtjtJ4eTyTeEKTFa7e1tg8E0vasvRRoM=;
	b=aam+Aiw3NqpnMwNC68ETwmlahVuwUNgeNoS5qUhdAXFFGNnwe1L7elha/C8mu0TT
	Pvo0etGaR+V+Lcp1d+y1woS9ii0NIJyBkcOv7MO6vGQqsxUZXB++igpGDRSxjOYglro
	LiX+zjXZwrcKuJpZ8A538I+8pUEbxTp1wYEll3zc=
Received: by mx.zohomail.com with SMTPS id 1774857454006418.10295521158673;
	Mon, 30 Mar 2026 00:57:34 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com
Subject: Re: [PATCH] ath11k: workaround firmware bug where peer_id=0
In-Reply-To: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
	(Matthew Leach's message of "Thu, 26 Mar 2026 10:53:53 +0000")
References: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Mon, 30 Mar 2026 08:57:31 +0100
Message-ID: <87h5pxlpg4.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34173-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[matthew.leach@collabora.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:dkim,collabora.com:email,collabora.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1188F356DAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Matthew Leach <matthew.leach@collabora.com> writes:

> This patch caches the peer enctype during the MSDU processing loop,
> caching it on the first AMSDU sub-frame (is_first_msdu=1
> is_last_msdu=0) and setting the correct enctype for any subsequent
> sub-MSDUs.

I've been looking at creating a patch that addresses the root cause,
rather than patching incoming frame's flags:

--8<---------------cut here---------------start------------->8---
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 6d0126c39301..98348ccfdfbe 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -347,7 +347,7 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
 	return 0;
 }
 
-int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
+int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
 {
 	int ret;
 
@@ -372,7 +372,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
-	int ret, fbret;
+	int ret, fbret, retries = 3;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -400,6 +400,8 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&ar->ab->base_lock);
 	mutex_unlock(&ar->ab->tbl_mtx_lock);
 
+retry:
+
 	ret = ath11k_wmi_send_peer_create_cmd(ar, param);
 	if (ret) {
 		ath11k_warn(ar->ab,
@@ -427,6 +429,18 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		goto cleanup;
 	}
 
+	if (!peer->peer_id) {
+		if (retries--) {
+			spin_unlock_bh(&ar->ab->base_lock);
+			mutex_unlock(&ar->ab->tbl_mtx_lock);
+			ath11k_peer_delete(ar, param->vdev_id, param->peer_addr);
+			goto retry;
+		} else {
+			ath11k_warn(ar->ab, "Null peer workaround failed for peer %pM, adding anyway",
+				    param->peer_addr);
+		}
+	}
+
 	ret = ath11k_peer_rhash_add(ar->ab, peer);
 	if (ret) {
 		spin_unlock_bh(&ar->ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 3ad2f3355b14..6325c4d157c7 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -47,7 +47,7 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
 					     const u8 *addr);
 struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab, int peer_id);
 void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id);
-int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr);
+int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr);
 int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		       struct ieee80211_sta *sta, struct peer_create_params *param);
 int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
--8<---------------cut here---------------end--------------->8---

This patch detects the error condition at the point where a peer map
request reply is received from the firmware. If the firmware maps with
peer_id=0, we request that the firmware unmap that peer and map again,
hoping it selects a peer_id!=0. We attempt this up to three times, at
which point we give up and let the peer be mapped with an ID of 0.

This patch addresses the root cause, but I think it's more invasive. I'd
appreciate some comments as to which approach upstream would prefer. If
the preference is for the above, I'll send out a v2.

Regards,
-- 
Matt

