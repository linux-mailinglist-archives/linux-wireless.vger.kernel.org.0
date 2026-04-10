Return-Path: <linux-wireless+bounces-34625-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCy9Cw4v2Wl+nAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34625-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 985F63DAE82
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B66323019C8D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7210E3DB644;
	Fri, 10 Apr 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="aUo6tpyr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EA93E1D15
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840685; cv=none; b=gp3Vzfr5uwUck7HZ+ip2WPuu3+vzxpoiaeKhFEmokqAndWt8wAso+76VSrfHa3t/I51HSZ85BbJQZl+UunHw4Vw687ZBVEcFSHMgnjWpnzD8P8NRkx5nxxqhf7Zm5Wm68nXvN5LdPhlZPLVj0Pgnn7XUTN9FlQuC6rFP04rM6AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840685; c=relaxed/simple;
	bh=kR9/g+4srNmON2WchDZ6dla1dVVp1KYnxOCF2cSRJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVA4fm5yY1UGoyGdaMcF+3krG5RucgrKCl9RU3QZtn0pe0a/Ulg/NvY5/qGQqWzT+l3pRvb1wXa/uSbADIOGkfq/VwFv6XVKMFyzHZVjXbw1xq6vSCcXAcayxYvWTTd1txOF1P7Adne+KwMR13miny0b8XsafdneQLDyKGhVt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=aUo6tpyr; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8efed61so20868845e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775840679; x=1776445479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nju+mfhzV8pO+UWdlU5Z+vT6A6KgC7sAyFotg5T0ax4=;
        b=aUo6tpyrf+Wmf8Ljoup4dh78P8GtkQWcFq1aVcQTQzEPT102LHk+2nh9VAH2PyuGjd
         MMYzTq/7mVKGi+OAyi0ZEdqsf34JmlbhSix1lOTcAQjXbiyyYKj13PPdJVYMeHLDpNPF
         zx73pNltQKgA8+1Ywc+/mfdkvjNPaN7ie9SNFbcEviith0DFeyB8/04GnhTF1YXupn5j
         EoVoFt+pV2mFJB7qAOFyEniTxdIkMSYVnKpPCbdx6gbNGnySDbnlc6S18/82dA/HRiIF
         m6yWMJsb5E3T+Jsu2xFy2ydCzcHEdVj2GT+kgw5t5s6ynAsszcxaudLMiLurU5RWR7QM
         MqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840679; x=1776445479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nju+mfhzV8pO+UWdlU5Z+vT6A6KgC7sAyFotg5T0ax4=;
        b=hwiDItAaLApvBovUHCsBkQLdbOwph4Dro4W3jpgxb2fpXw0Nlgfyn1+7vC0BVFa+HM
         NcycuShGlK4y68k+ZM6ZPoyP9PE82NUnpBUhYGuJ7wpSB9Mu50mn/SOn+5fGK4b25AFr
         UqE8xmcLWR/NhQB7ccnJO5SINPQHZjFSpLp6Mi6V7YqkO7XuH+2EKmkzvrvmpfOeOV8x
         XV+YUKJa7XosMxv1u7GF8oxWBaOIQnz5kO2D/6L7v4MQd1q3vmYc8ei9F59d3Aa8F7sJ
         s5h8LX8zShiTQn1vFjfxFGlGBr7UQMLnTJGFTFlfhxA6D4gpxUhxKlViqbNmyGiCjmak
         8tGw==
X-Gm-Message-State: AOJu0YxUM4+Eq6E497TP+6U5VZfoFg6JGmPFnz04M1EXiUBqQDHLzaKW
	/qxIq8RevcyWhoImSqa4tqcaUP1Y1MHtKUcpTjG4p4qijel+JhmPgo1SYxcgYTy01faDg1EeLrC
	21IKi
X-Gm-Gg: AeBDiet7OhVVJf40PNt25TADz2kbWeb5s4l8/KNAMxgXG70HRc/SlBri27jFkaCWbOG
	FOk1HFeHzMf2aATF+UkIbBp6kEtg4iWv4HUEw4JzvF+m34JGassAH03EZe2Yl83qd3OmQgt+AIZ
	ySm+ikP3DLp4iwtzCvkT+2dLVVTYEkMjg31c7wDfHh3qWi0QS+Rxr+raGPCEHU1LEHWPVWE8HEs
	aqhIqkujZRqHGCcVYXwJ0eYEjNXiiyOVgyosYIAm8t7BZwLMKTGgPplW8defFV81hmIRvwjmhYz
	HMUSVfTBE2zK6Kc0v3Ej4l+ZC/J7dblIImqyU82IL7u57uID/kLscDbNAKak76ljpljbXPDLvaK
	6xC8ZFTrEH5Bu1BU+BF1WJFy+JTrN3WaRvqdq64kHN2R6010gRhqT5mJwapmeayYlFt7l5eATEL
	bo3kSVNdzXoY/UXqakh0uW0du88c8BZtegwIN/vuf6bvq82ubgqixRXwSr+t925gL67/BcV5asj
	nR7asVSid5p
X-Received: by 2002:a05:600c:a406:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488d6781cf5mr38946205e9.0.1775840679405;
        Fri, 10 Apr 2026 10:04:39 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8847200f8f.25.2026.04.10.10.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:04:39 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v3 1/4]  wifi: Remove invalid 128TU transition timeout constant
Date: Fri, 10 Apr 2026 19:04:23 +0200
Message-ID: <20260410170429.343617-2-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410170429.343617-1-pmartin-gomez@freebox.fr>
References: <20260410170429.343617-1-pmartin-gomez@freebox.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34625-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[freebox-fr.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 985F63DAE82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In Table 9-417m of 802.11be-2024, Transition Timeout is defined up
to value 10 for a Transition Timeout of 64TUs. The value 11 is reserved
and does not correspond to a Transition Timeout of 128TUs.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 drivers/net/wireless/intel/iwlwifi/mld/iface.c | 2 +-
 include/linux/ieee80211-eht.h                  | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 46c8d943fd55..756b3ca36105 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -220,7 +220,7 @@ static void iwl_mld_fill_mac_cmd_sta(struct iwl_mld *mld,
 				     IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
 
 		cmd->client.esr_transition_timeout =
-			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU,
+			min_t(u16, IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU,
 			      esr_transition_timeout);
 		cmd->client.medium_sync_delay =
 			cpu_to_le16(vif->cfg.eml_med_sync_delay);
diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index a97b1d01f3ac..bbff10a05b48 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -517,7 +517,6 @@ struct ieee80211_multi_link_elem {
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_16TU		8
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_32TU		9
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU		10
-#define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU		11
 
 #define IEEE80211_MLD_CAP_OP_MAX_SIMUL_LINKS		0x000f
 #define IEEE80211_MLD_CAP_OP_SRS_SUPPORT		0x0010
@@ -1178,7 +1177,7 @@ static inline u32 ieee80211_eml_trans_timeout_in_us(u16 eml_cap)
 				  IEEE80211_EML_CAP_TRANSITION_TIMEOUT);
 
 	/* invalid values also just use 0 */
-	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128TU)
+	if (!timeout || timeout > IEEE80211_EML_CAP_TRANSITION_TIMEOUT_64TU)
 		return 0;
 
 	return 128 * (1 << (timeout - 1));
-- 
2.43.0


