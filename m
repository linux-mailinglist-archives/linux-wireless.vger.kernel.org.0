Return-Path: <linux-wireless+bounces-34626-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CtaFRYv2Wl+nAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34626-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0606B3DAE89
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C632330285F5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963C3DD500;
	Fri, 10 Apr 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="cFlWfwWW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DC3E275E
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840685; cv=none; b=YxBiC0XesOBlVPkTFXJJOj7/fMWpD1zt4M4lpTRCUur9g9MrMucQGplU5RGOLlCzO9jhD2W/UyHUef0mtO/lS3IPwI3I9bmb24i5ZSkPcghZ8GBhVX6S6YQfIVApAMa0/oryfCPMQy2tV6sHuEFx1W1HfPDKnjCOL2ulkGUdENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840685; c=relaxed/simple;
	bh=9EWvQprBiZuRB+74EQ78NVSVE7QG1RGTP4t2vCV6Gvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLp407THU3iekEcTZ5oTy8je3hn1Zl16Y1s33CYm2RzPzPcfMQsbj8djeQQozCNdyism8Cj2SYX/NtV6LOYW6cQbS6ZosmwfTdV8IvYYkmtO11jlnzqjCshMREIDCghaXxhAfuVVJ7O3S13KcPpVduWMJuS6gGts5b6HYNj/UEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=cFlWfwWW; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so29341885e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775840680; x=1776445480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpaffC6ir4aMnz6tA/DWYtsFgp5gvSolHNoyZQ+3yhQ=;
        b=cFlWfwWWwWDAhXxqIaqldmJwMdXxDG6TKsd2Fw+leeAxVbky6wsDHf93nLnoTfH10V
         eWEGGMLyXT3C0RG4D3GgfLmqgUGiGM9EqLWqWD8EJ8a6PFUhM9sBA24r5TwKijC+8kva
         U8dHNAi+i0gybgapG//nEg37NcEUotdFL5ngT69e1PyoJFc2CrRnkH0286K0EnFXazT7
         adUa35QHG/yQkYi6vDM3qQ8oWmTxnmW0xIRw4hj2+TgcJSip7La7dgqXBnYnucmYZbGu
         CN0Xz9tjXp/GXojQfWOJqCDqUnGawqVNNLTYE0V2SmoqVbqVOwDl9d9ViVZDWYQqTFls
         fbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840680; x=1776445480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpaffC6ir4aMnz6tA/DWYtsFgp5gvSolHNoyZQ+3yhQ=;
        b=r/DS6l8rkM7KngEPMWR+esia8VHYbogkvpeWtZRc1HTapyU60mZ2EbVKuqWeHjq6CE
         0nQCRCcC2gMCM03V6pkUix/I6mG1+s7uhWaR7hfng1M4XR/S2RaV0IDFCcK9CqUnx4RW
         RYtySPo4Yr9cY5PGAynrt/VGR9XQKnkKx8XkVcBlnnSZRcxLOiIDfWhUNaLb3O4cXLPf
         medwyq8btURo1wj+OOwOYfwWBgt7DkPA1pUnVM+s7l9rW5KDu3hldd32wCoo1IQjVaL5
         1Ozu6ReGBwCjTklBz3kDhereRJJme1R86YOZtMuSCws71mk5vixkTY/sTDEmVfU7I8Nz
         evkA==
X-Gm-Message-State: AOJu0YwbSfrx38TlW65jeNbu638fgPvkQ6DwlShXbodI3iz+mAUfx8d8
	0m57olLmyfYkrmpqw3EHx/UQEZPAjyefpgFfQBQehA3WrEhs09yV1pg6cZJ6nNd9dJK/omZkhRz
	oneSK
X-Gm-Gg: AeBDievJ0AApevQ1dcjJ4KsmDCsmtSX1sbBax8kwFWumovorvhLcfcaTVg7XNBmqPKi
	YK0kth+hTSfEj/6a3KGeyutwsleR9VnwIcrA9ofI+QTxTIKch2JtNtrAB3eYBuK92wtv67WlZzL
	Gl7ohdARbf6wwUknBQshttDl6fM2MAqlPsm+DHAXPiIQm1WfggJDGqvRh5urKYZQLcWpfUq9lyX
	E6VJ/og73N4B83EYk4Bo6Hy6BTJv1loTPVqBMgxqjslfGTA8PZmCCTj667Ya6pO69d1xM9vTD2J
	CLDr8gAl3UmnmuyzFZYBefiyTNDovW+dJ2dH5x5sCcnOIRFuhUZzrXX+9Gw1/HfOd76uD5qJbe5
	ugw714FDWKnI9sOp0cq7jqVC+ZpjPl+/uJErjpLDkXBG8GOKJpVESP/KpJb7Zlsj2R0GV+J0gaC
	HMop6y2o8mn2cZT0ANO0j7kjIm6rBHWrPNRXZ2CIqbOerlMaUAgPHoTDzy8j1BQ27fr4/0/bmat
	2hyIewN7sdD
X-Received: by 2002:a5d:64c4:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-43d6427bac4mr5464937f8f.9.1775840680075;
        Fri, 10 Apr 2026 10:04:40 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8847200f8f.25.2026.04.10.10.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:04:39 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v3 2/4] wifi: Remove EMLMR Delay subfield definitions
Date: Fri, 10 Apr 2026 19:04:24 +0200
Message-ID: <20260410170429.343617-3-pmartin-gomez@freebox.fr>
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
	TAGGED_FROM(0.00)[bounces-34626-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[freebox-fr.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0606B3DAE89
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


