Return-Path: <linux-wireless+bounces-34628-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLlEGLgt2Wl+nAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34628-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016093DADCD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14DD230117EF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC753E277F;
	Fri, 10 Apr 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="s5MouOKc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B053DFC8C
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775840686; cv=none; b=YNgReFQwXK9yrQMrNRGYXFEAuIKvFhUT5l0H0H19NwUE/LovY+6S2vivlKoUXBsE4IylCPwqYaGNKyiQbG+MJfHNHonBMp9Il1mbdlIJg9IUNZ6+aHDZhLZ0vR1dTqoZMP6FqndmScgA6A+hyoQ/mqc+ztaS3HtNOigWmNeRLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775840686; c=relaxed/simple;
	bh=SR3lx2snde1T7B9vfCDXuTUGw5XwPClb0NQT7Q4ktJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6Lj6APt7Wc+vTBj0omH/qHcqSvrc4zhuyeJBe/RixQ4pgaxjsjU3AAT5tm7nZDR4TaU3pmAkgLDfHiYqLkLJej5z9q8OwNWd6T0ITfEm9Nf7OUx4laFgBkx6Fq4Qjp3r0IihjC91/LfvQ95s5VuKFE5LrN78DNOU4hjzzbVSfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=s5MouOKc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso2284066f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775840682; x=1776445482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANH4JrJG0VIVMGUXuK23kIE8WytfexT5/3ChAjW1LBo=;
        b=s5MouOKcfg90xQ1VdT3JSs8B7gTfBye0Wg+8XiqS8WFxJf9GjOzi7OZY7lW8a7YLuF
         sNpVN4w4SrgzGaNFAvjLTN/5wAu9BU7d3Ba7RFcPs8Tu+L743QM0iiMmTHrTWkAYwHT7
         wV9nDB0s6sQ13+pzm9+gxQ7aXwhJAvfcMZkEYgqTw3zVgELIpoNS/spE0jixrluPrR1h
         U8wn0IHwmcLv2vrRoG5NMjmCmMoJGKNGmujTP5YqPijXpIyFy4sVPTgtcxAMcVFX4R1p
         RTG9v1FE0HTX8phFFM957UhCn23KxIYWhWw8RBbrEtqPqHgybKTn0UsE8VNaiKvKqNMZ
         MNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775840682; x=1776445482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ANH4JrJG0VIVMGUXuK23kIE8WytfexT5/3ChAjW1LBo=;
        b=BHUtrrUBDpCBS23+fj30RL2bD42Fy3x8AROTYIpINEHIlX/wDzk7LwM9uzVlvYNS7J
         Y/xYudx75LUnaUtEI39juENGLdDx0Xc3eNzYLzztmbJz+eGdAyxkBPN4Q47KnKGoFvFp
         96QCckouoTfuvwAuKFlHw2e7UJBYETqucP+bEKqiysmZ2ftHAAut6JsrXs4ajgdjUiyV
         ZvgeaG/3UctlmOcXq6wtcSbX4tWbUexSZWGABkMHQxozHzpnQw4HI7KYvuE8/IiptOFs
         v/J45kJm1AFkwsgXgzPpJeFwr/fmtnGIjGFlFYHCfsyHm19Z4UQ09b1hJYX0ds0UzOYx
         ZvZw==
X-Gm-Message-State: AOJu0YzBe8poZwUVhlQMYoPUIlaipBJO/zL/4n7q7aEFjpF8htL+08GH
	zGFe+dwN7u+kAuSpqIbUPWpWrgTVk53KWlPkczeCEZNzApPc5CNcFehOWu8X2xk7byo=
X-Gm-Gg: AeBDiesJlPUnJocYikxLDI9Nbmdq9e/G/VfzX56ksMP0G6drqNHcMpoGTC18lL53w7a
	JDgRCO50uarht6voseJv/gCHhjTQSryd+dUadbjnGwWepHI58cSjx4SIx0K/wt9xSKFAv/mB5oD
	IzrWFuUIGgyeOaAgkdiaatRfapCLRrQvkqeAJMbfP7DWiKouXkSA54e2sFz/eWY+aSjqo8hCblv
	VopoGipu7e4kxNJk9hD4jWWUR4Sh+JKpHykODW7CopVp3ZG3StuvTLyJ9Jt0DrhzKn+xxFst/+2
	/Cn0uJ2GeP1xf3n17ybUvJKhxV7Z182ItJvtIAJe/fU95zlcJdhGX3/AW7Or1qV973f9U3FXJXe
	bne2azHUIyKaHnbA1IigkVg3PThEJWNmWE4Ik8nQCAM2q4oap/BjTFf423hvRTalQ0EY2jkYJN1
	PnFMWYfzTdv5exuzMacbEfbEz08gNwSZhzRFxS3fP9mHdIeud4FoQfYWzL5o4Wf3kaf4JHQexQx
	b91vmTELpve
X-Received: by 2002:a05:6000:2211:b0:43d:184:8a9c with SMTP id ffacd0b85a97d-43d6429b407mr5978726f8f.12.1775840681886;
        Fri, 10 Apr 2026 10:04:41 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e50044sm8847200f8f.25.2026.04.10.10.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 10:04:41 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v3 4/4] wifi: Update EML function documentation to remove EMLSR-specific references
Date: Fri, 10 Apr 2026 19:04:26 +0200
Message-ID: <20260410170429.343617-5-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34628-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: 016093DADCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Transition Timeout is not specific to EMLSR, and is used by both EMLSR
and EMLMR mode.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 include/linux/ieee80211-eht.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index e24f95db6087..335e78bd4b5d 100644
--- a/include/linux/ieee80211-eht.h
+++ b/include/linux/ieee80211-eht.h
@@ -1236,11 +1236,11 @@ static inline u32 ieee80211_emlmr_trans_delay_in_us(u16 eml_cap)
 }
 
 /**
- * ieee80211_eml_trans_timeout_in_us - Fetch the EMLSR Transition
+ * ieee80211_eml_trans_timeout_in_us - Fetch the EML Transition
  *	timeout value in microseconds
  * @eml_cap: EML capabilities field value from common info field of
  *	the Multi-link element
- * Return: the EMLSR Transition timeout (in microseconds) encoded in
+ * Return: the EML Transition timeout (in microseconds) encoded in
  *	the EML Capabilities field
  */
 
-- 
2.43.0


