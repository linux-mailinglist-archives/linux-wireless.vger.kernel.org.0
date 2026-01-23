Return-Path: <linux-wireless+bounces-31122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OES/CpWac2nNxQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E883278191
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 16:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4866C30060B8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389F287269;
	Fri, 23 Jan 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0c5VycO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1728B7DA
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183888; cv=none; b=HrG/4Y6iA/4ZNmsEmqk5k32ppJorz+clGqh7or72ULbed47iJGK2IobXyPupv2UzYj7wKwvAWyCDZuAYaMX/mHmwfyih/zVLyOpZWkAF5R7P12iUfPDu6X9iOXfvFZedrVfryAcX3rmk5gTHN/zAYJHF7oTb/Xv4W+kQ2rH/Dnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183888; c=relaxed/simple;
	bh=sDBEja9caBGfx+XaqHCBxp6JYAqsd/xq4CXneEwrnyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRQlX05Wv68UWFd1MA9zC00WzlCF4ipmrzaocxevYUyNiMNbfNCj4ROa4XE2lFHZq9Qbf4LUAWLcnV/UO+V1d5vcgDEi45nH7NVuCfc9Pfq3gWvqkDzHA9d0yTds0/mxk8HXme6x4YDJK5RGdt0CrBuNfHdKAg8VQTneRBY2FzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0c5VycO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c47ee987401so928158a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769183887; x=1769788687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BArbmjiBa6Ohmbx6FKnPpxNrDpx4xGnZ/TyoYHn7A5Y=;
        b=F0c5VycOKsA8D568vCX+gec6k1Z+ljrhhxG1ZCEwTk0ONPQNbWZ833JE+/xZpD8NKa
         57Cqdt+TO4EzmIc6IDCgCeKjae8TggqPHu3knPY/GKF4V05/DzanSSXsClMgTavnOfMH
         1dYaqAc+rOUrtyPHmOMl/b1sBF5hoFHRP4QwPF6RQLh8QFnelqleTkzVprNXAH1nervB
         yExco+KEeHUhcXzyEYX2A5vEWRis3qAS18ZDVwlffo3XR6Fu0bOcNCTVCC/N3ZWZHGxf
         2yRPxbuM5FDXwQ35ijDVGcqAc675EbwfRHXiFRguoZBHYNaAj22zf/tn0f2h0tAtAtMy
         rvAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769183887; x=1769788687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BArbmjiBa6Ohmbx6FKnPpxNrDpx4xGnZ/TyoYHn7A5Y=;
        b=RYnFdEpXOzqL8nvXH02NfAnEims/bxWD1aLGZsmhlqMmKsc3f8W29/1D16NJKBdJ6f
         dztCqUVFTMKKey6XJryDAavUlH3yYO7iRWp6HXAxqcjgFscqnAGtnMwQ/mqoDHcDDMhm
         l6Dora/YA0HaIA4SiV2x2ZvCd2yUUKd6codHnbrJJyXVMVG1VHpnG62OJ6Xqdsgfj0ig
         aRPAEJIA+s3NKnXqjUO90kKLuwfcc4HsbZhGF6xe3vTE03LgfuQtrYr4WsQQmtwzHdB1
         IQXbyQB+r5ApMAP3YeLHcjcun5wWKO8XC7p+XOZd+dc9mY9hcRmb2K/AUccdM9K4PpYl
         KvOg==
X-Gm-Message-State: AOJu0YxwVppAwgEDIzKFJ1815Z375fNEb6g+HFHJAH/SCr+cweA6fcav
	CIrQfHCKFhHPz2Sha3bq1c88Vy2If4WCM3lkIAbsPIaYFNYb0a/nxn/z
X-Gm-Gg: AZuq6aJu7Xt2rM5ILQ9bsOsqr/Ilt5dEU8HPXUPj800J1uXozZqqavx5FPFBPTTV1cQ
	vEQgO3iyfwuro6lprLStyLwa8ULtpEl1L2fGK65Smc2NP0yQ7N41rsg1UBWg6D8daa6JiBZ5JpN
	ibYurviPMSkVSq6390ug63qofeLb+oenNdU6ZJNpM/XjxQYRsh+k4FyQ3PPIDU5CCawVdY8ykhB
	g1zHN7srywLoxmg7NlMkVksbqG25Jvv89S0pb/fP5yhLUPRdwGLUgTzTw5MuoSNtCkiCTaOr3t4
	fCHwfJFmCr2Ido5g6GR/MNwN50HFldIAozm8b4MVRz+DdH1wJrIGqp03jLZtLQ1qUeajykgjcnD
	c6uPYNF0R92tYqH/lqZkj/4ZYDsr7kJz1HcbTdU50wS18rQv+HkyPZv5HXuDD8jDzQHZEHPZpMH
	TkiNJm+KSg0JXT3tkihjPtftzDZH/MCWZ1IQVm
X-Received: by 2002:a17:90b:6cd:b0:340:b501:7b83 with SMTP id 98e67ed59e1d1-3536ace1173mr2553134a91.10.1769183886916;
        Fri, 23 Jan 2026 07:58:06 -0800 (PST)
Received: from saikiran-Yoga-Slim-7-14Q8X9 ([2402:e280:3d17:646:dfb6:6b31:aa17:2446])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35335206b23sm5489305a91.3.2026.01.23.07.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 07:58:06 -0800 (PST)
From: Saikiran <bjsaikiran@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	kvalo@kernel.org,
	Saikiran <bjsaikiran@gmail.com>
Subject: [PATCH] wifi: ath12k: Remove broken frequency range filtering
Date: Fri, 23 Jan 2026 21:27:49 +0530
Message-ID: <20260123155750.6007-5-bjsaikiran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260123155750.6007-1-bjsaikiran@gmail.com>
References: <20260123155750.6007-1-bjsaikiran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31122-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjsaikiran@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E883278191
X-Rspamd-Action: no action

Between kernel 6.16 and 6.17, ath12k added frequency range filtering in
ath12k_reg_update_chan_list() that filters channels based on
ar->freq_range.start_freq and ar->freq_range.end_freq.

However, these values are reset to 0 in ath12k_regd_update(), causing
the filter to skip ALL channels:
    if (channel_freq < 0 || channel_freq > 0)  // Always true when end_freq=0
        continue;  // All channels skipped

This results in no channel list sent to firmware, causing 5 GHz Wi-Fi
to stop working.

Fix by removing the broken frequency range filtering. The firmware
itself handles frequency range restrictions based on hardware capabilities.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302 (Lenovo Yoga Slim 7x)

Signed-off-by: Saikiran <bjsaikiran@gmail.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 2dfcef013277..2d9adc74ac6e 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -153,12 +153,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (bands[band]->channels[i].flags &
 			    IEEE80211_CHAN_DISABLED)
 				continue;
-			/* Skip Channels that are not in current radio's range */
-			if (bands[band]->channels[i].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    bands[band]->channels[i].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
 
 			num_channels++;
 		}
@@ -190,13 +184,6 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (channel->flags & IEEE80211_CHAN_DISABLED)
 				continue;
 
-			/* Skip Channels that are not in current radio's range */
-			if (bands[band]->channels[i].center_freq <
-			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
-			    bands[band]->channels[i].center_freq >
-			    KHZ_TO_MHZ(ar->freq_range.end_freq))
-				continue;
-
 			/* TODO: Set to true/false based on some condition? */
 			ch->allow_ht = true;
 			ch->allow_vht = true;
-- 
2.51.0


