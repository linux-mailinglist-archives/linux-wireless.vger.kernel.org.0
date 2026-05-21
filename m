Return-Path: <linux-wireless+bounces-36755-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAnRFQDJDmoACQYAu9opvQ
	(envelope-from <linux-wireless+bounces-36755-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 10:57:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 009D25A1A56
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 10:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9E7E3030899
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 08:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BB364049;
	Thu, 21 May 2026 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO/EWWBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20684366DA4
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353817; cv=none; b=ngm0R1h0E9FhS+RFB3Q81Igz3TWsCjfXb5fFXwN0vj8k5VTMIfxFbTpcvi/i6uLdGpBdJaqNVEosSla1fkJloQiM82mDhk/1tNYL7BVCdyTR3oeS2DxTDXoHK54QdjUeOzjZdR4JHYz7uDs7wbhix0JhQsBup9wZbjruzT9fcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353817; c=relaxed/simple;
	bh=E8ejieTdOAlK95osn/VTxQdPDNHfCla1ns4v3W08LGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmuf+46mSxPQeyozXcg7aV7eyrANPNOG8jddS6r5LtZRUXnzvlfUwmMKgosfixeXCHt4yY7VlTOj5TuAPO3UJmW0M7IF4JMIh4HMjiWxn0czxsmN0bEASeuYyKZ+yZU7Oqb8M3xTKuU0ly6F3Jid3LZgO20S+IW5R/ec35GAdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO/EWWBY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c8025500cc7so4531401a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353815; x=1779958615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRywIxCJcF3lGIejnW6w7IbD6f65BTlDAhxubqVPacc=;
        b=lO/EWWBYWdg/Np5gxxWOo9/lxLHvV4e6LL9nb7gNWp1tMGBIOk5fGVvNzCkRwWoV+d
         XVOTwsYvSV8q2PUGdlBDZR703sLlljUKoHj2PB6jjDIzMonmMExtI2MxE9xER95XQoD3
         LfIXIr74qTxVAqqpYksX1TTBc8uCf9wPAjGFSQwRtr5wCOOxjTcyrlXBKDiOJ/w56Uo5
         mg++YB8tfd7K65QHMhV0RPfmKJbmBzFZ/DnJao5MR45QN0G5zB6iHdjEp/0Iuxt2+Ic7
         1H5XmpRjz6Lj1ay5Dj/Lt8h+bKuHTI23qEcoQwvQ4t3VI+6Tog8KPLtLRmmg+llLq3hf
         iHoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353815; x=1779958615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRywIxCJcF3lGIejnW6w7IbD6f65BTlDAhxubqVPacc=;
        b=lzTDT1+LzHrrvbna/j4wtuf0f5fG0DnyOggJ86ANGd8j6CSo41RC8RbzZ9NpL50Wd6
         7KEkVp3nZqURyo2eEthSZP35DCaoz0/6cG+9xSjZHeBJRFcXxxParBDacyJcTrHE8N6x
         YP3okZWhV21CiM/YJqNlN5NgO4hLvL+SIdE3Ds8RBkoR9/wZFXmCtf25oYtCCXcCCAfC
         ee75X3XFMc92WKx5MOGuoFx3w0G6D++gBmb42bPqelmzrU0vbfI2+NZOsaMYJ0jRucVG
         1LUNfKCq00mVVhefLkLQi+K725Y4ghizZkDsLCm+8gOUYnnwf+06L+Z7hUiYUPlprQSh
         DLmg==
X-Gm-Message-State: AOJu0YyqbWukbWMrsxoKA99p0SLRvbkEIQoVvw+dd8/pgj++VkKdnInC
	KjM2++pYY1peo7S4aEd7AnK4FxR0MkfdL/DM3KrXPbh+bo1jGBkH6Nr3SfMuxA==
X-Gm-Gg: Acq92OEm8/L0DT/6s5+e2LiA86JhN2F30P07GeeU9tdls4zl5WsggNjclESfXVYO0UK
	0juBQz1xuCdcafDxikiSn2qEV8+N19thmPB3PtT9oYb0CD3QbSPNMPG7tWxR/C2vaQbXmLh1+gI
	YsC3aJ0kH2yDR53WNyakxW2TphO0iBY47v29h+uiRtCLTNbX72m+NGJzzoCIQo08HcfcTUnJG/Y
	NWMAOKBmuxR8hRyLKA6VBDI/3LfacKoqUExUITwU/GFw12xQGOfLSpRacuSgY0JkKXYYuZQ0oZI
	9IiMQcyrBzin4vlk74P0r7yEJSg5grAF2GcvPdNpWiIIP0zNVUXeZpEhk/zWN++4VAhuWeUfrta
	5vo8MC233j/606ZJLW8ffwfCAS2lyosxs/XNJDuL4qka/6tzTHaRsBkKTj67Io0itViq30VBL3G
	aUdFwCbgKuC0+pKwxZtyYb0WtIppOX5REqmW8HNhqpJCbaAo0=
X-Received: by 2002:a05:6a20:1588:b0:3b2:924c:567d with SMTP id adf61e73a8af0-3b308b3bd07mr2463848637.46.1779353815504;
        Thu, 21 May 2026 01:56:55 -0700 (PDT)
Received: from ryzen9.. (11.9.30.125.dy.iij4u.or.jp. [125.30.9.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062695sm21463091a12.4.2026.05.21.01.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:56:55 -0700 (PDT)
From: Masashi Honma <masashi.honma@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	Masashi Honma <masashi.honma@gmail.com>
Subject: [PATCH v7 4/6] wifi: mac80211: Fix overread in PREQ frame processing
Date: Thu, 21 May 2026 17:56:45 +0900
Message-ID: <20260521085647.394151-4-masashi.honma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521085647.394151-1-masashi.honma@gmail.com>
References: <20260521085647.394151-1-masashi.honma@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36755-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[sipsolutions.net,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[masashihonma@gmail.com,linux-wireless@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 009D25A1A56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AF flag is enabled, hwmp_preq_frame_process() overreads target_addr
by 2 bytes. Since this occurs within the socket buffer, it does not read across
memory boundaries and therefore poses no security risk; however, we will fix it
as a precaution.

In this fix, a new function mesh_path_parse_request_frame() is established to
separate the implementation of frame format validation and the check for
unsupported features. This is intended to facilitate future work when
implementing the currently unsupported parts.

Assisted-by: Claude:Sonnet 4.6
Signed-off-by: Masashi Honma <masashi.honma@gmail.com>
---
 include/linux/ieee80211-mesh.h | 28 ++++++++++++++++++++++++++++
 net/mac80211/mesh_hwmp.c       | 12 ++++++++++--
 net/mac80211/parse.c           |  9 +++++++--
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/linux/ieee80211-mesh.h b/include/linux/ieee80211-mesh.h
index 0e9bd56b54f2..42a5bd73838c 100644
--- a/include/linux/ieee80211-mesh.h
+++ b/include/linux/ieee80211-mesh.h
@@ -321,4 +321,32 @@ ieee80211_mesh_hwmp_perr_get_rcode(const u8 *ie, u8 dst_idx)
 		(dst->flags & AE_F) ? ETH_ALEN : 0]);
 }
 
+/* IEEE Std 802.11-2016 9.4.2.113 PREQ element */
+static inline bool ieee80211_mesh_preq_size_ok(const u8 *pos, u8 elen)
+{
+	struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+		ieee80211_mesh_hwmp_preq_get_bottom(pos);
+	u8 target_count;
+	u8 needed;
+
+	/* Check if the element contains flags */
+	if (elen < 1)
+		return false;
+
+	/* Check if the element contains target_count */
+	needed = sizeof(struct ieee80211_mesh_hwmp_preq_top) +
+		 (ieee80211_mesh_preq_prep_ae_enabled(pos) ? ETH_ALEN : 0)
+		 /* Originator External Address */ +
+		 sizeof(struct ieee80211_mesh_hwmp_preq_bottom);
+	if (elen < needed)
+		return false;
+
+	target_count = preq_elem_bottom->target_count;
+	if (target_count < 1 || target_count > 20)
+		return false;
+
+	needed += target_count * sizeof(struct ieee80211_mesh_hwmp_preq_target);
+	return elen == needed;
+}
+
 #endif /* LINUX_IEEE80211_MESH_H */
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index fa144a187fe2..ad3e575a0a94 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -929,9 +929,17 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (elems->preq) {
-		if (elems->preq_len != 37)
-			/* Right now we support just 1 destination and no AE */
+		struct ieee80211_mesh_hwmp_preq_bottom *preq_elem_bottom =
+			ieee80211_mesh_hwmp_preq_get_bottom(elems->preq);
+
+		/* Right now we do not support AE (Address Extension) */
+		if (ieee80211_mesh_preq_prep_ae_enabled(elems->preq))
 			goto free;
+
+		/* Right now we only support 1 target */
+		if (preq_elem_bottom->target_count != 1)
+			goto free;
+
 		path_metric = hwmp_route_info_get(sdata, mgmt, elems->preq,
 						  MPATH_PREQ);
 		if (path_metric)
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 5e61457be0f3..9e52cc48fc18 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -547,8 +547,13 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				elems->awake_window = (void *)pos;
 			break;
 		case WLAN_EID_PREQ:
-			elems->preq = pos;
-			elems->preq_len = elen;
+			if (ieee80211_mesh_preq_size_ok(pos, elen)) {
+				elems->preq = pos;
+				elems->preq_len = elen;
+			} else {
+				elem_parse_failed =
+					IEEE80211_PARSE_ERR_BAD_ELEM_SIZE;
+			}
 			break;
 		case WLAN_EID_PREP:
 			elems->prep = pos;
-- 
2.43.0


