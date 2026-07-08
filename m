Return-Path: <linux-wireless+bounces-38784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MnFOH6AiTmpuDwIAu9opvQ
	(envelope-from <linux-wireless+bounces-38784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 12:12:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03927724193
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 12:12:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=naKlPOx2;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38784-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38784-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8979D30078BD
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 10:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CDA3822A8;
	Wed,  8 Jul 2026 10:11:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1544B37F00C
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 10:11:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505496; cv=none; b=JJhkW+zUrFRqLxuWEZ1AeZddkqMaUn3YDIAKvDctkbK4VU+z4wZ9+kYBgQjhGOOHjmyzfW1cCL51TRa9zoJ2EcNW/kzn+OVZY+AwOEiEJTwR8p8IeYKiqqH43SsXW2h1S1WQYk4u3e9do3nVNRkvcaBGOA328Bs6NOvcnu3j+0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505496; c=relaxed/simple;
	bh=71/TzMLK5ZQZwWjcBZqcnQJicIjDW4nS0phnaj6ugP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e5hKnrEN7lNQuENKY+FrQY89OvIDX0DX6atb2ObPeH38rOkAlrZd+vEN6MYvIw0vVkSSAHVrDvgFQXBeoBJM/RFz8sgnpBuYQGvL4Sw+hdS2avYsJW2+BTvqwrRjaq9C/UUc26kA2CjWdgvSVFeT9YlWcWfrYQND0SKaQXwrET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=naKlPOx2; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-381ed661712so517672a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783505494; x=1784110294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pOJ3Pf0iHZgowhFyY91dPG9CWszSETz0W72ezmzqxqc=;
        b=naKlPOx2TtUsrGhq8lJnF6R9nbrKXkMyc5geuQfBbD4iOkbe6ObCEiQgROonnqrSjP
         FpCH1+uEGx2EmZSnnPkYDajOFWzoEHXsNuckqvT5VVFVSJVAeoFZwaHwpLeNQElPhiMk
         oK8Cs5YK9ELgzf2ye/nLUHLCjj8Qcicax7braElZARzbrBnsvNPxRT3G546iPhrfC6AA
         RPQJhtDkIvC56RZ/gf5hesEvapbG0rOMXVcL/Cy6TnF1kwJ1aU8RNjYByOQ5oRxnDSxi
         QPxyJBgTRyEIr+MBcXebiAMBlkccYkQT9crhEHnsEB6LLDJFTFPXsWQdlNZsVgv+Cd4T
         dKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505494; x=1784110294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOJ3Pf0iHZgowhFyY91dPG9CWszSETz0W72ezmzqxqc=;
        b=OFGqWye/2XGeD59//+LWNPjxGMoX42lTM+74s0lLXIxPm35MLsRB9axo5AGBZGB66d
         z6M2mYAPr0v19sYmGVa1SOzZqHwhxYzsgPEF0Kk5M8NfvbBbKnYtbdCa57m75L/D9Mnf
         wTzlmHZWkOaxu4obDtmyMXO0pSuisx0vpseLSvW1OWJdlPAtWDDlUyIUFi2x61XNOINx
         +WJrLFLGLgxet+1BtSeERyZbN/rsPS1SG9smZ4oi8illVpoQdk2NkClr5h8zcPlgs8FN
         N8nzHGazshir179njpCwAkVveDdF3iryvvA0CpwYZ/6jgOqw8Zb+QHMD5FxQ+cgEi2Kh
         vYDA==
X-Forwarded-Encrypted: i=1; AHgh+RrNu5jJbMvx3DMptc+wYfVnvRFj+2MVh3DjoAYnxR7xDKpsb/B8Mb5nekvRwC1MZjPA36FN3oZ93EWkHKAzZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjo2gd+FfNHpBLBELzRv2yqiS8qOfH23NE7qnmYkcVCXNG+GKE
	aQIh9jK0AvrFf6yLxn634ZB044rLbdjcFrh9P2JcmQ67U6ip+O4Cpz+m
X-Gm-Gg: AfdE7clvcZgW0Xazk4SlSzvSEINLvcw+cc+WjYm8+vF1hYbg6D9XdSf+5hS7+3C8/YU
	MflKwtgGn63hyerns7b2Fu9RBp1Pz5uXrktf4ETCYUWNzdNc8UZ0HYPEPQkvZ2SugrOUheh2nYm
	tzZKQaGg9NrsjYMWN1bEEW54Jy4ewz++YOfmf+oZYlUVvRTvTdJ17rdng/pbE69xpPMPugha1CI
	n8XcguXDciW3gniHGXiZpQxnwBAfyj9sWfc1f+xuqKQGVs3hmCagxyl5uWbVM7TGo2Ds7ZrvJ2R
	/urGp6EET6sbxQNEkS6MYA+adLiwKJEDc5jpB6f4/u4OUq1XSKXYt/NoTatzDQf+E+sSvPny9lb
	Pe5XWzKR7XFcehMob3S0dTp4iVgvwzPPh0KGMhyb8cYynPLlY4L39U3PHtCNIXoKjnZ/oNHg=
X-Received: by 2002:a17:90b:3c4a:b0:381:21ea:912b with SMTP id 98e67ed59e1d1-3893f693923mr1756304a91.1.1783505494416;
        Wed, 08 Jul 2026 03:11:34 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d17ed52bsm2438172a91.11.2026.07.08.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 03:11:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>,
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] wifi: ath12k: release QMI handle on late init failures
Date: Wed,  8 Jul 2026 18:09:24 +0800
Message-ID: <20260708100924.744386-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38784-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:vasanthakumar.thiagarajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:lgs201920130244@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03927724193

The change referenced by the Fixes tag makes hardware group creation
skip the device whose ath12k_core_soc_create() failed, and only destroys
devices that were created successfully before it.

That avoids releasing an uninitialized QMI handle when qmi_handle_init()
fails, but it also means that ath12k_qmi_init_service() must clean up any
resources it has already acquired before returning an error.

qmi_handle_init() can succeed before later initialization steps fail. If
the QMI event workqueue allocation fails, or qmi_add_lookup() fails, the
function returns an error without releasing the already initialized QMI
handle. Since the failed device is now skipped by the hardware group
rollback path, that handle is leaked.

Release the QMI handle on those late failure paths and clear ab->qmi.ab
so the failed device is left in the same state as the qmi_handle_init()
failure path.

Fixes: 088a099690e4 ("wifi: ath12k: fix error handling in creating hardware group")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index fd762b5d7bb5..31e9fa9a62be 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -4054,7 +4054,8 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	ab->qmi.event_wq = alloc_ordered_workqueue("ath12k_qmi_driver_event", 0);
 	if (!ab->qmi.event_wq) {
 		ath12k_err(ab, "failed to allocate workqueue\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto err_release_qmi_handle;
 	}
 
 	INIT_LIST_HEAD(&ab->qmi.event_list);
@@ -4067,9 +4068,15 @@ int ath12k_qmi_init_service(struct ath12k_base *ab)
 	if (ret < 0) {
 		ath12k_warn(ab, "failed to add qmi lookup\n");
 		destroy_workqueue(ab->qmi.event_wq);
-		return ret;
+		goto err_release_qmi_handle;
 	}
 
+	return ret;
+
+err_release_qmi_handle:
+	qmi_handle_release(&ab->qmi.handle);
+	ab->qmi.ab = NULL;
+
 	return ret;
 }
 
-- 
2.43.0


