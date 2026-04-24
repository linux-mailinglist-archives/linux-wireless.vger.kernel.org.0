Return-Path: <linux-wireless+bounces-35277-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JeeArqC62kONwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35277-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C24605D3
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 16:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B8630125EE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D1C3E023C;
	Fri, 24 Apr 2026 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYzcbijZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C153E0233
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042098; cv=none; b=Zot7NRtzn+A8dsznuxaujsnXq+ZKLrwTQKT1wjSYTR6JZp83cQDUX8DpGDXMf9KksPs5zGQ+Hpqb22+aBlIMq9eiUen3nfa36LMQ4Upz2xWqLL0AacMqMafFCPaAM0hX8Xxckl7bhi5McQKWNNUfMEV9ZNIbeZgo4uDtqTXMne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042098; c=relaxed/simple;
	bh=3PnDbjyLpFkRLiyXrW/i9cTGEm2mkPdrQDl0/9+Xjxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4L1seHZySRPgj7oXU+i1XW+0HXMf9VU9+EjnG/QsW7OVHY1w0JEqrmIdUj6D3yIagTAjZ8s2ghSECwC3v/Wr38D1pNQQX1Zorv8dDFrCRrvJW8ftn/Hyi7nw8ga+kJBlJ/euPoFDqcbFvFr6NEckixypSCJwyKfJxG88GdxDpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sYzcbijZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso108619205e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 07:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777042095; x=1777646895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8FYF8oZhNqSuTK+FyZ824o92INSUjfpo9VA3IN58oI=;
        b=sYzcbijZH9YN5PHJnDcsAb6JpQPjTKzquFg8xha8WUep3aUnxp9Zjeii7SpFJ4zClO
         rqxqryvjQxtxqIhDuOpw0nT6JM0GB+jCBAmV7ZxcjNUFd5c5IKCmJqtjgLro/71iBOYM
         3kSG1PlJXiUPbd/BTcRyNb+gPBaisvqkuPtjJyTZvIyNDr5W4ZGaNxHVY1lbT2keBVXS
         Q0wLil9CcebsARGIVB+BBibqo3II1Z8rhxzhwhYbLdK9/LYi93szY3Bwg7OvXHAsGWda
         sYSq40d1hsLCVzQeDxAvORpj25UoA/qKD/FOBQqPvMfi2vhBx4i5BExQMur+Bm43DFme
         +FXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777042095; x=1777646895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8FYF8oZhNqSuTK+FyZ824o92INSUjfpo9VA3IN58oI=;
        b=MyZIY8nrWvJBsyuVTGBofndLV7C2td/+S8Q9UVDHFfyGTUvSD/5E0dvn3fMU0YT+0y
         JgIixpxLtDDDBqIckfVf58m3EXofyupvnxGDMcS1CcdxoScsJLIqcJRTCIkLVejFJcSa
         gnERYpRhLxD+yTKmfdNkGKRf3uYpqwcTOXENmADmua8jB4mxnh29C6kvg/7In5Jh44dz
         1wbMcz1S+EITjEtys7kaciq7XBB1WuVL2dYEfC893wHA3gwtkOblNHfmD/9JObBrFkKi
         YPARLa/VWWHep+rNWxIBVOGla3N/AKVqxRs7f+4RO7poJrQlAJC+a9W4xBwxrVPZs0eB
         1CXQ==
X-Gm-Message-State: AOJu0YxsSaP0UwkbgAZf3jFy+5YBLpxIBZSoPiBTqcqvLB5CPovQ2Nlv
	2CjSkahV8yHALdk4UntQ8ri5gmdEgqUT7BPMAgxzTgC37H4TdT85tFeb
X-Gm-Gg: AeBDieskZ+hY1IBa/HBGRTd2uw0yJ79OrtkUiF5WBizApPhK8ohF8iIwaBJw+qnbgOy
	8z2vi1gJD7Olx3TAn00xmO6OEyaw/bLMn0HtNzKK9qxuxNWBDuEAW48F8VfUx6obsXk2JBsMOCG
	T4PEMJgzK89lyMLiDTPcsN3XOp2gf2uEkY15GNj7MIX0rtrlsgxyENwUN/hwvgvw0wmk+0Ao7UU
	B2c3QC4s74REUllGKPjsvMIKGAPlDDmrRaQ2In9smc0/ktWLVo+VVBp7/wQSa6XvVwLdYToqxrA
	WcWWdcY+wJrSv5M9bmNR8Zx69BApThp/xtj9MZe3/dsszO3zv3vgr40DCnls8CmZDNEtOLGOHr8
	2xVAP96VaK861XMfr1YgHrdSyfUwId7NB0DayEFp9HQjbLF461P0Kw2Js/AZAuAJUXUaLl6FUxJ
	MzRwT9izyRzQ39Yp7uAPbzB8WhbpYCSLWb0fC/IpUw4dUbapQS0cm4e337+J2OlULDVCU=
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-488fb7787d7mr439337615e9.15.1777042095095;
        Fri, 24 Apr 2026 07:48:15 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48919f54572sm157605825e9.26.2026.04.24.07.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 07:48:14 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath11k: fix error path leaks in some WMI WOW calls
Date: Fri, 24 Apr 2026 16:48:12 +0200
Message-ID: <20260424144813.1708214-2-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424144813.1708214-1-nico.escande@gmail.com>
References: <20260424144813.1708214-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C9C24605D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-35277-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Fix two instances where we used to directly return the result of
ath11k_wmi_cmd_send(...). Because we did not check the return value, we
also did not free the skb in the error path.

Fixes: 79802b13a492 ("ath11k: implement WoW enable and wakeup commands")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 40747fba3b0c..024c2aad9fb4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -9332,6 +9332,7 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 	struct wmi_wow_host_wakeup_ind *cmd;
 	struct sk_buff *skb;
 	size_t len;
+	int ret;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9345,14 +9346,20 @@ int ath11k_wmi_wow_host_wakeup_ind(struct ath11k *ar)
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow host wakeup ind\n");
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_HOSTWAKEUP_FROM_SLEEP_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_wow_enable(struct ath11k *ar)
 {
 	struct wmi_wow_enable_cmd *cmd;
 	struct sk_buff *skb;
-	int len;
+	int ret, len;
 
 	len = sizeof(*cmd);
 	skb = ath11k_wmi_alloc_skb(ar->wmi->wmi_ab, len);
@@ -9367,7 +9374,13 @@ int ath11k_wmi_wow_enable(struct ath11k *ar)
 	cmd->pause_iface_config = WOW_IFACE_PAUSE_ENABLED;
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI, "tlv wow enable\n");
 
-	return ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	ret = ath11k_wmi_cmd_send(ar->wmi, skb, WMI_WOW_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send WMI_WOW_ENABLE_CMDID\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
 }
 
 int ath11k_wmi_scan_prob_req_oui(struct ath11k *ar,
-- 
2.53.0


