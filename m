Return-Path: <linux-wireless+bounces-34097-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKiLMADmxmnrPwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34097-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:18:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6271534ACE0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 21:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4C43089793
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 20:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF67396D00;
	Fri, 27 Mar 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Of518nSP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB60395268
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 20:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642322; cv=none; b=TE4k+7qfPPQkbG6NHqf9Ij5ogaI9VkUjjFbQJHw3HmdVbze1Ck2h6U9KuhTVrXyLx+vxBPuK7/3eLbqvlwp+KrRd7TZwLik1XAcHl94uzclIl8ugTrM3Ft+MptDzs745M130o4ovck320RXbSIzRmA8R1SO4vvJ3gDtgb/6s5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642322; c=relaxed/simple;
	bh=9EWvQprBiZuRB+74EQ78NVSVE7QG1RGTP4t2vCV6Gvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajhTFs2YJVLli7dsbPZSuT4Gy0nDn9cPf1L1DXW3C2D+/0/F12iW48HeKZy1AXr4y9K4MbDie/mog4zIZzPpb7l8YFqM6b8Pttvw3jpVMevMFMn0iv0SG50kElwOh4YAriwefr7pBohBFNPg8g2IiLUFdxRlxLiRl76wts6yta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Of518nSP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48538c5956bso24589595e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 13:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1774642319; x=1775247119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpaffC6ir4aMnz6tA/DWYtsFgp5gvSolHNoyZQ+3yhQ=;
        b=Of518nSPyLN/ahveiRl8SgTeX5PWmku1DpU55bj7MmSzt0XpYwYcB18Y9voalbk13W
         +UWZpjK6KlJBk3qf6Wba3l1KT2cxUme2XoNG4FPQ5FSQCLTz3uHlVOzk5gAHvSWrcgAD
         x1O9lXvMHbkUj7qyj3ee3HQdBwdDevvjlb51qyvCMETL1W1Vnw1nHn6bgq4Z4qL4NNpv
         M5SDWV/EuNwU/Mv3lSSadqw+L/hDIgXhNum4qrqbZHGt72t4fcu3HqGMxtogR1enYzbB
         JYEGcO0QmK27WMWzqHy20gVAO26itEV7Ut0unO4Bku36i/95zlCnQuPlRDKahU2xIVcT
         Zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642319; x=1775247119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpaffC6ir4aMnz6tA/DWYtsFgp5gvSolHNoyZQ+3yhQ=;
        b=VJ/6s7V5q7/MuYCHXTB/cj7EnrtcaAZSwcNwZ81HBVBl1tc5Evc21Ltk2nhVfqKz+A
         6Rt7MeKjfsZLAsgIRyaNoFo8QUNoRfNwBtgBfwNX5i6EiEpBzgOZ4tV99WjHDMoIYBGT
         isOE9EnhoMQEXJ/my1mKEGo6lF2rlOnwUrDaBJfl1IJQ49RKZFFiBa4iIPTNmJu0frID
         9Xr9L572a7gqBH+2lCOAJZewDjMdw6yEDNArVu6wKMHRYr8kn/I8+x0bz+5YFcxSauLa
         G763f4Dm4f1u+BjXsm7g+ni1YKV5M9UH4WNIwKieA+/FW/bUoVfhiTAkX/IDAyg1xbfB
         KfEw==
X-Gm-Message-State: AOJu0YxqeigtbaI37PCOj6cluNj0K1INmObpnKzP7rjs7XGGLYS7kqlf
	Axsl6aux7DmQ2W+yjgHCZF9fFwBDjy4IXb4xWJvT2SjNSaij9vYP1nmYBey9NaX2a7Jha9p5Wdo
	yu0MH
X-Gm-Gg: ATEYQzz6ly78c0MytPV+1vkpZXbbWnZdihJRUe8gnzoEAw/cy39wKb2BXSopCr7Bwn7
	KcbDDNCfcB8U02fQ3GPFWEHnTh4sNw0vdHxGpuGcEvf4AmDjMICC/fb3o0ozihil6OOrECRByM/
	IjJbe50gKCrvb/1dcW+CW6uuKwVph7pjfhT4gwDvDaR0BL9KzLdRzDgD0CHDyhoZpBpMsRwT70T
	mfTKhqGcmiFfoGeXur5E72n46JPHFb1VthbFxohUV9HOzOYsy9a8C+0s75XTKczFUKJa9h4Pn/L
	HLkJqOqWFokT5Tvyv8TcdhcPjwVrqRGCYd4HiOv/xHgZutpyVldpdihjSdPMA/Qozm3gIt9BhI0
	w3maARVW30RXcHH5daY8l8Qs4MGSBsYhy5f7TmnZhKdIvvVE9WCvaZJwqRipYhPshln+Jqh951y
	yoD4asur3HaclQKb2b60x/YJqN2MY7+xFdfY+ozHboXBMQ2l8O9a2Rp3loyxiQxgOscslkKXvyI
	2gS3iRz+oWz
X-Received: by 2002:a05:600c:8289:b0:47e:e59c:67c5 with SMTP id 5b1f17b1804b1-487290de830mr57890665e9.8.1774642319298;
        Fri, 27 Mar 2026 13:11:59 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725eb5417sm35670035e9.3.2026.03.27.13.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:11:58 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH 2/3] wifi: EMLMR Delay subfield has been removed
Date: Fri, 27 Mar 2026 21:11:32 +0100
Message-ID: <20260327201135.905852-3-pmartin-gomez@freebox.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
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
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34097-lists,linux-wireless=lfdr.de];
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
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:email,freebox.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6271534ACE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the finalized version of 802.11be-2024, the EMLMR delay values have
been merged in the EMLSR Padding/Transition Delay subfields and
therefore the subfield EMLMR Delay has been converted to a reserved field.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 include/linux/ieee80211-eht.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index bbff10a05b48..6324d888073b 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -499,12 +499,6 @@ struct ieee80211_multi_link_elem {
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_128US		4
 #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_256US		5
 #define IEEE80211_EML_CAP_EMLMR_SUPPORT			0x0080
-#define IEEE80211_EML_CAP_EMLMR_DELAY			0x0700
-#define  IEEE80211_EML_CAP_EMLMR_DELAY_0US			0
-#define  IEEE80211_EML_CAP_EMLMR_DELAY_32US			1
-#define  IEEE80211_EML_CAP_EMLMR_DELAY_64US			2
-#define  IEEE80211_EML_CAP_EMLMR_DELAY_128US			3
-#define  IEEE80211_EML_CAP_EMLMR_DELAY_256US			4
 #define IEEE80211_EML_CAP_TRANSITION_TIMEOUT		0x7800
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_0			0
 #define  IEEE80211_EML_CAP_TRANSITION_TIMEOUT_128US		1
-- 
2.43.0


