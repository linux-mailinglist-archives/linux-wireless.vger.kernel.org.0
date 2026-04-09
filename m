Return-Path: <linux-wireless+bounces-34547-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPS9Lxmw12kORggAu9opvQ
	(envelope-from <linux-wireless+bounces-34547-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D733CBA41
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8443B308243E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2162B3D34A0;
	Thu,  9 Apr 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="EGn7K2Uc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC63D34A1
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742652; cv=none; b=LEywz+QpQEP41wyOqcZdl77lox6BXvuPlv4hgRgKH/JdjSk/IbfdliH5ZFZf+58+jRCtNqWko7Kk59AY08R3d3ex/KBVjwNcWsJYW4Y3AQmNl6Y3re4BBkSg8TUQtswSZqBtTthxXO0Z3G//M9ASByyCbv+waHEBVEvj9a7osWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742652; c=relaxed/simple;
	bh=PmaVrQP6I/jyI/LdBer/74rDAaJflCiSu6+2vCpfnjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRwIrCbcoxBagSeYgVHlswI3m+y77O5LtmMzYuDdSrOIpf8Xf5Pc1NLjJ70ICrGVZGQ00oOduXxd/+VyfP5Uw58eoGQu4H9NzA9ujZ9i5OBbXR+6BSYUXpypLJqdKzmo9Apiyvq6opo3EtJTObRrlqaCOxWeUdwbREk4b6yC7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=EGn7K2Uc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b0046078so10038185e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775742645; x=1776347445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dg7U90Cjvdlxzg5r/TLqIxygIzmleOZHsCcBLM3HJkI=;
        b=EGn7K2UcGaH4BTuB34MQWXQ9kPdKGWa7el1U9DUHwHN5V04R5nQy8BD3RcxdUG64nL
         efzk/1iyiuSc/q4ohKkdfK0GW4sg5+f1oSdxBc0PNJBZiqpHZB7lpiA2XaMSCrh3jDtq
         ioR0X95LOEpUTwpogrtPWmvConXfvYl1f8ApASnwrN5qrURocueFTBfcVDtNG5rdwWUf
         x+VJ6tdLR4gOYmeHClVEiEunZOGJT+EFBI4dCoA3DBIbKXtqWSmhEoCVi3wjpfAAN7hr
         8vfH2dDeBWkqX9s3TheuajtHF86+vKVvUIGOE8iAxyMlh9HHlqdCCZ/yuTfDgOGuHeMa
         VH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775742645; x=1776347445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dg7U90Cjvdlxzg5r/TLqIxygIzmleOZHsCcBLM3HJkI=;
        b=GExn9ElePo6McJ3aywyQxHGkcxv+vx84KY1igsZDD8tnm6y9XcGunqvKeXpXlIjzte
         m2o6sZPTAjbHyTys2xfFl8juTXI/wgubqvmEzarFtnoV8tFTLjLhf/gnDI/4TM45eIGm
         ro2zNR70bH5JEOYOdlVzwtKe39dw8tEBJTOk8C48qz339sSHTX6SQHBscY1VBTfDv+Nh
         xUOeRfaFhrcx2tKjLVsjMxNDwqvCpO1eVnaxZXHF3TTzaRir8+J4tWot3UVhYcalPdUJ
         ujcRLzvW60oOXzbKMEM2tv4Gk7ZIQKfYXrkdUrt/37BU/ebcyF+d61ceIPuWi95C4aQo
         pDQA==
X-Gm-Message-State: AOJu0Yz8c9IVtp6UA3tVG2tabGqDbjl/tMYlcsjI3+PeMxKjWElQBSIP
	kAb3JSp4mSQvlgdT7+vK9Gtgd5VzydqAFTJoiKgTq7ZBWG6Y6p2YtjpWUSItpscF2HDO2uXiFx2
	wc1L4
X-Gm-Gg: AeBDietVE3sWxKDWGcQo5M7QWrdoFflCreYNgE4L5SY/IVBc7W9IJYKTv8j9YNNqsf/
	sG/oiVlN/yzR+mq9M7+rP2aZycul+5c1/17VyOmNdIHPQedZ1yveHeqsYKab9ULp4IpErsRuFrq
	kzD0aIWY8MspEKcpFiwjmqVKCCGrHwJ3VvRNUDPXbHVvkci/HsuKLHee9a/nzH/4Tnz8AcF5Pk/
	6tWhhoOzY+FmvNIMWAfrUqGJWb2mYdNMrHm9059lxQGfYyTnsYv5gSEHhPTMR+iSC4inbJXFKx9
	hB+7L2yS7JffbdtrCDTK1M6TkCVyijWNHddHHKzeB4cPhUn3yXlfKgnni2ZKdt9wwenD8F1UEkq
	axGo92IQiJrjxB7v+7i/3/qVjIzFpa3/TjZkiagAipFS8d9DYhp/gX/YM0sKn+F1FfC2WeUsq1P
	jqOSzxFx5pUGl5RK4TygzyKEJHHdwYYIi9jT4CroYqlnx7iwwp9Rgcuk4tSHvOdDp9uhUHyna4X
	iOREkBvfvjS
X-Received: by 2002:a05:600c:1c0f:b0:488:b99b:4177 with SMTP id 5b1f17b1804b1-488b99b7636mr165590345e9.25.1775742645152;
        Thu, 09 Apr 2026 06:50:45 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9e8808sm57815625e9.5.2026.04.09.06.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:50:44 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v2 1/4]  wifi: Remove invalid 128TU transition timeout constant
Date: Thu,  9 Apr 2026 15:50:29 +0200
Message-ID: <20260409135035.4018725-2-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409135035.4018725-1-pmartin-gomez@freebox.fr>
References: <20260409135035.4018725-1-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34547-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 10D733CBA41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In Table 9-417m of 802.11be-2024, Transition Timeout is defined for
values up to 10, representing 64 TUs. The value 11 is reserved and
does not correspond to a Transition Timeout of 128 TUs.

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


