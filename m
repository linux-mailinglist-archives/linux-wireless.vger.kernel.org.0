Return-Path: <linux-wireless+bounces-34546-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cF5bHBmw12kORggAu9opvQ
	(envelope-from <linux-wireless+bounces-34546-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BE33CBA40
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 122B13082414
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239693D34AC;
	Thu,  9 Apr 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="vkoQPgpo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948C03AB294
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742652; cv=none; b=dvPXjRZL4x2FJpH/Dsp6za+k8wasQjZhzWo95bx2T933tB84vPp02Epg9PsGcwNiLygNqkgGe/EBeiIcc/n/AKkFpaWL4UKaRL/5zG0rNFabYSTu+wJB05yavvfoNKqmicqt1eySer0QZd3zyzMeW5Kyawtaf4H3UqpywxhWH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742652; c=relaxed/simple;
	bh=SN7iOcm/ey/CAcD4ngYmuhc281LhigrvMQ0j1AOVfn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXiz+UUQWBgEShX9drFAIMiGeuhXQ+EtCamH94UKttyjnnUEeZ1aw1q7j4kiXBKLoTOO3/tgwQFniaK/dSCxcbp2bcvR3npgaOua0qCC7a3LUW8FAoKAAYJOprGiX8ieCRarNXSQFK4hZSvKyzuVHK9nYls+gnuTZCBUQREQo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=vkoQPgpo; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so8807775e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 06:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775742646; x=1776347446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiF5F5oaiGYxw5/eyBVUZexYrfw/G1xT9k/FAduhvIo=;
        b=vkoQPgpoBVzyY5FQowxkuwnG9giUOYEEHXxI2faFEqDJg2JTRusgS3tuNgSxfD+9sY
         /mndKeyCdNlX12EqxzQmlIl3lLWEODOtxIQdbm0RdQPGQUEKPwVhxGPi3ajrudiXSW2y
         AMzDhbws8Q6CPwocR7IDcGJTroen7OmrUDq5t2e7WV+P5UQmpYC0DU8CZJ5p+zQ2nX87
         ghQoA7qZxYgGg/1sf5J4gHJpidkLIoifoETPmoqGwi63Hh9iCpyZ2SsjJ8DGtJCgJYfC
         Hsr5EwBOR18+YO3IBp8dVtbfuIAg4cr+tmGgYnriZAMBmn15xT3wV8IhaBJhOYpE3Cry
         a49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775742646; x=1776347446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GiF5F5oaiGYxw5/eyBVUZexYrfw/G1xT9k/FAduhvIo=;
        b=rTgEkV6YNTU1K9nuuzTser4c+rng81J90AxSzA+T3bQEjsYCf7tdEPRlOHBFuyrbVr
         5nz+BzMhVTr1t5l1CJqmzKuPc7MshlICD3DZZ8jbeD8ScgZ+eQ12QLKEX9bpgrzOgVtV
         dgFf0X3uECC9hFTzrlbjeYKQ4YWs7yQLtA6wVCv2Fa18oQpZ2HS37dyB14Ek+G1CgDq7
         ZAu24psVxc+ssZklq2yJoXHZB1vTcElnG/1ry1l3DaNpHUmFlArftva5yyVMP/3ZpqRz
         elKzsCUwYBGVcosi2mTndfzqwGB9RjDle4X+CT75Po8H9pYtL8OJljXBrxsy2dQqh/6W
         HzJg==
X-Gm-Message-State: AOJu0YyOSHtYWQpRJYkjdJTP3TCZq3upyEtYcLImKOUODqjpRpsccSEb
	cN9Cz4ac4idUZh3ZCZxuWpR4KIRrnDBfzz4Ze3TmaCT9ViHkD6PhhCZ2CAWADiZ1CKcdQ5GRJam
	kZd3j
X-Gm-Gg: AeBDieuAL0lvHxmfXDtPTFNcsrF5b2NnpKUgut0QKUDGa+/f+FjRpM6g+BDuywuPusz
	qtUfeCtVWse7u4qOhciVsTntt/T9DxtMcycJkn8lrGNVX9IoKs1dB71wa1fMku5jYQeCpTyOC1F
	Mq9uwA6jp6ZLZS8X76wXB+wt/9ONu5IFaVfRTmKq4vWLXcCtnXP+2u3r6pcW42CzMC+6KrUX9Eg
	96WSDcy83B4E9MExZfk5YqDxuN5gtnUzvUmsuiYLYA0u+axFciHpu/a/RShJkEnAnFsy/T8ADeG
	Fb1tP/lxZtf9CvtNUB7ln3yqqA93vDGfPGCueG4Iw/Y5omdAU5YWzERITNyea2ia5ZIjOWBc9l1
	vOM1Jn9rsz2fg18dCLXKXsuen/TofcYFxqRYh2rclscUdacwCUrPsB6bnm6C5slbiXu45tzgPGD
	PwiKmTWardu9dNGpzo6Dnul6YUQAxEGsllAeZkF47LrXFk9cLdxrIRD2TpijIMP+wak5ebGsS0m
	oW3F5LmUOKu
X-Received: by 2002:a05:600c:4448:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488ccfe63eemr50263035e9.21.1775742645639;
        Thu, 09 Apr 2026 06:50:45 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9e8808sm57815625e9.5.2026.04.09.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:50:45 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v2 2/4] wifi: Remove EMLMR Delay subfield definitions
Date: Thu,  9 Apr 2026 15:50:30 +0200
Message-ID: <20260409135035.4018725-3-pmartin-gomez@freebox.fr>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34546-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:email,freebox.fr:mid]
X-Rspamd-Queue-Id: B4BE33CBA40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the finalized version of 802.11be-2024, the EMLMR delay values have
been merged into the EMLSR Padding/Transition Delay subfields and
therefore the EMLMR Delay subfield has been converted to a reserved field.

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


