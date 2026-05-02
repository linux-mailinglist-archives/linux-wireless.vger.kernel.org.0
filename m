Return-Path: <linux-wireless+bounces-35764-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ro5BBXSk9Wm5NgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35764-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:15:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A79334B1413
	for <lists+linux-wireless@lfdr.de>; Sat, 02 May 2026 09:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 389D4301B721
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2026 07:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488F82D8390;
	Sat,  2 May 2026 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie46i3Jr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F517DA66
	for <linux-wireless@vger.kernel.org>; Sat,  2 May 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706097; cv=none; b=f+cRmZPOAK/Q/2TsqsgjmAaDxUoMRnu2+yQtoIW4D3GApate8bk/s5AasXyzo1aN/7SCS6VcFK6I/3Zv9PEtmw1gYZCKOXsT9FYCmKxLZyNdtLEId7vDlUTDvU4wYCPJ5Qa85pSVHfgmloNPSHiUhLf7tv3qlWTI2ktX1s/Msfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706097; c=relaxed/simple;
	bh=3PnDbjyLpFkRLiyXrW/i9cTGEm2mkPdrQDl0/9+Xjxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H956PG9+vSDxMbcjCifqxRoJbRWoA7j2WuFUotkA0KodRaLMqjTQgvECV0R2L8/qDJVq2RNE/r0M2efHaEgR9CWT/aankRK2DVJ2arqpP+e/Fve8JPbJDOy54VI1P2P7W630y8uaFubrW9iNx3JrwrBJa3J2xpsDYUDqnnIz9Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie46i3Jr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ba840146so20340275e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 02 May 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777706094; x=1778310894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8FYF8oZhNqSuTK+FyZ824o92INSUjfpo9VA3IN58oI=;
        b=Ie46i3JrTt1Tdr39/vjFxaDDjFtl3E/wH3rzeujRVKbTs4oOZns1A7doXN/IFVdl9s
         1IFdRSsoDGAOppIPfA5ICGtzDO1JSdN0w/pyNQJ8kyzYw98aL311NP6rE6kid5RKXsbZ
         dqGF3Sw5jBreiQrV+Eerf8AM27BlhWoQt63jV726uy74F0sXPtb7pngUYMFu7L+iUaMT
         qlrbakcgMMVIM4WfwWRJz8Js7Mnq7SkyPioxZ/ZGLxWJWFbk2nI1FwiSbvw48oaOxOfx
         sjntPvO9TiJwGv2DPZnSN37F8FKqM+tJGzrlG/4MaOXtw+8HPpkdQx1ZYoC6jp6vSyoS
         QHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777706094; x=1778310894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8FYF8oZhNqSuTK+FyZ824o92INSUjfpo9VA3IN58oI=;
        b=ZM35mSyioXzu9fgm9brAtb9ss4YjqHV1KHswV3BmohUV5wGmaJAMxO003HPCKkNe3D
         i4Fif6c/OkwUgq4BTen4dv7gOH4EloyQpcux+xW1tmIFEHU+nT9bj/MC9rRFiRMRqDGL
         pWd0AhfR2BU6djeRVJv97hh7RCm9XO8TrCWyt/bQBIuapvTmdOlZblOlBISAEG5qVPPD
         ix6rqKj33cLREr3n6i11Rxft8OcInXIevSvHAPuhe4UyQoEkJ3MPoZnw4SPCJqz0hd9B
         V9xLlu2muXKax5TUsMZj96IDQmwV5fiuiPVH2gXeCuylUs0C9Rns4VM6lb3m3gsJRopP
         7Hkg==
X-Gm-Message-State: AOJu0Yxg7GXFyZOlMe4tLUGVPpxRV/qZMVNMqsatbdIDaxz4ZoiMXSHc
	q+c/NZTy+EcXf5clAmfeQDTTfZqQWl3SJpILg6Tubn0N2NvI72JIFHDg
X-Gm-Gg: AeBDievzahWCCMvddg746MlDKAZkss6Aepd59BnCmhOW7ZtOjyocTs8j7F+R0LQlOwO
	uUqrL6CoVOHoPKIMjzEGBfW9dE8obUX/bEExnopDiZ135B8LoujPQb6kGhSoGUdcDiZOQtLTnrD
	bpv49qEsDKMc1TcjthV9U1HHDiwuu3/UieAAN7iFp0QQSwly7C41UmZ9JD9yK7nr6Wnd/4aJvkh
	PIiteYkgU5VrHkHB6Zg0teSAYO2eFLbJXKISWOD286ImefowmP/t+N9XRbxs8NB642Bsx/aTDE9
	wWTFzsRmz+55txbjUUP3uMvAR3JMK22UNY7IbDrXE9a3UoR1eskMhURPeYRGtoJvirFhul0zf79
	0gCGxPfwCEDhRijnqNpSS5+a0j0yecfoEmMRusbEWbJZvVKKoRO/kZRZhZD4O1K8910Ekzeq6ty
	RC+UEpNrxal5CykWE7fMLPPTWuQR0++KfauLZ5D8IQd0J+UIXMfsZlfjdBDni5MTtrsns=
X-Received: by 2002:a05:600c:c058:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-48a9866a998mr23542205e9.21.1777706094287;
        Sat, 02 May 2026 00:14:54 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82301ad1sm281862135e9.9.2026.05.02.00.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 00:14:53 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: ath11k: fix error path leaks in some WMI WOW calls
Date: Sat,  2 May 2026 09:14:52 +0200
Message-ID: <20260502071453.2379188-2-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260502071453.2379188-1-nico.escande@gmail.com>
References: <20260502071453.2379188-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A79334B1413
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
	TAGGED_FROM(0.00)[bounces-35764-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
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


