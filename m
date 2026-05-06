Return-Path: <linux-wireless+bounces-36030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wErUNPdF+2lPYgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBB4DB420
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 15:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F270301707D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 13:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0634A47D94B;
	Wed,  6 May 2026 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5YTPIfE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA4147A0C7
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074965; cv=none; b=qBf1EUmnOwkqhBWBxN4Y6tA51ukG47yMP0feIOJ047SnRUokaxh6SEXKzUOd3Kb/EpJDFq1XdI+6Sgj20iPxHSl9xfNf+TK6YdVy755oeOAMAEXwhlEXbcFnNgoHi/6f6li4TsYvs620lHkc0AMnIhTIaUoqFtd1J4p3kR2UH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074965; c=relaxed/simple;
	bh=ilHYYJ+J8NG/FtGODILVHS3dJOyLVu7PuMIjjVSakU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQr7x5WxzKtMmH4X3OaKkV0m6/Ei76okUqSjt4TVyZ721NZVB/qXMamGt121HrARJHdOyln858XVLDTzei1mmRgIJKcEZW5wgSoHQPNW+3syySj5GFK4H3a/h9oxnZv4onV9hzmwDmSb2kg4M83jrFFso/XLN1wIqXL0IvIWnyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5YTPIfE; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-452169ae568so365883f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 06:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074963; x=1778679763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dnZTLfPBq3s3Da2DqBjriorpRBU/d6uIDxI87h8TXI=;
        b=R5YTPIfER93kYCOYFbUUnhPs6GINdwuwBungcFoCgJFKM0ZrAmNgz7nN42gjAjz0pk
         A1hSU7uzxNRsaTfPKW1XlQ+6f+rZ+Q+bqAeIl2xOlGUqwIuuQu1hLkwBzCyXvQ6zURik
         vReDvTz/yxjaE/ACa1bncJ8GFwJN1WntNpaVTPS07JMyfHxYD5m0vgijUZX/goU+cjYW
         J7BCxKJMjTZjlLGeeAp2cqIvPETwQp7R8cJCI1R+iGsvidmaVHfW3bO82JkA2OTARarB
         WBuQNkKrVhjD1oq05GxM0LFhUFRRYMY7t3FIwSm4hLtxuhp7YAyQZA24NoqqLzTFIjXx
         676g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074963; x=1778679763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dnZTLfPBq3s3Da2DqBjriorpRBU/d6uIDxI87h8TXI=;
        b=QXnN+3MdO5ufWuV0X0aFWWSBIUKw9L0PpBmnBC52tZGBcp7j5e2V0HH6vuZb0cSj9+
         YckO9vfpnSLNtmKwkw+UhVw+U/P2kvytNaztMho0uJegLceWVxRny9Yn98TGpcIP/Zag
         PR6pXMQ+yoOavm0eRBOtmj7GgJ2WnDErdppwWGz7k3vrcrImJRRfc7dPP2qFaTc/8S8q
         Ztuazu7ygMoiAMfdft5PH1PlwzCkDiD/KGQh1G9yZUNV0KO4isG/iuUKBQ37GnUoxEqG
         7ZrcOsxTmyNU74md5D/v9r2zhMirtsFaGhkGJ43amoKIrt7342kpsPHAo8ocb+pXnn+A
         4xQQ==
X-Gm-Message-State: AOJu0YyKUsmInMDzsmoJ5RbzpohaiidqWj3qz3so7KsYVh7Xc/Q7G6Kg
	j7oBms4AGG3O0FCsPkvtC+xz9HXxtqdIKNcTA9aMvXcqP8IABrHcvTN2
X-Gm-Gg: AeBDies2R+prPasWAwDyaUC1ImEeZLoDzXMO3rocsISgI3rAguREbatrgKP9XQzSTjr
	U6ScVeTAk0PxBYXUwcoxX9PabY1xga53VlwiM1z8EtdnhvJvUQU4A3HccZb75RTiLrzbNvq7Sx5
	n70etb3SRja4XkY3FlrgPCmVwZTYxl8NWZ5uy3wG+gQ1KxQHTjzZPhE3dNiCfZJA/UL+MJi13Hx
	3+Pfo/HLoXvkP4pEebQJmiM4LuaO+dpoXK2AYwYltFr4Z1rdzI1gpC2qz/3WbG4xd2paoCe8qSs
	SlEBNefARrcHTDdP0mIxGltxSVyBwfRuW3oRXGne+IrR6gCaTSie0myj8zPEawNcvry5bryUD2U
	xWO2VnDmcxWyf8bpOsPQx2HJEhPjntJ3P2et3ZJ8Jxhz2HMQ+X6/vUAwyY2RQ6ToKyMr0vNLiZl
	tCNI70q9LFsHv8rqf+o3H+O0YVD+hpgC3QQTLsKx75uBxTCUwmekT4pe9UXpRjt77h+Na1rY7+/
	Jg72A==
X-Received: by 2002:a05:6000:4210:b0:439:b1c3:84c8 with SMTP id ffacd0b85a97d-4515cd27a66mr5880843f8f.21.1778074962750;
        Wed, 06 May 2026 06:42:42 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052483166sm12542182f8f.7.2026.05.06.06.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:42:42 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
Date: Wed,  6 May 2026 15:42:40 +0200
Message-ID: <20260506134240.2284016-4-nico.escande@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
References: <20260506134240.2284016-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8BDBB4DB420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-36030-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This is similar to what was fixed by previous patches. We have a to
ath11k_wmi_cmd_send() which does check the return value, but forgot to
free the related skb.

Fixes: b43310e44edc ("wifi: ath11k: factory test mode support")
Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath11k/testmode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/testmode.c b/drivers/net/wireless/ath/ath11k/testmode.c
index a9751ea2a0b7..c72eed358f6d 100644
--- a/drivers/net/wireless/ath/ath11k/testmode.c
+++ b/drivers/net/wireless/ath/ath11k/testmode.c
@@ -457,6 +457,7 @@ static int ath11k_tm_cmd_wmi_ftm(struct ath11k *ar, struct nlattr *tb[])
 		ret = ath11k_wmi_cmd_send(wmi, skb, cmd_id);
 		if (ret) {
 			ath11k_warn(ar->ab, "failed to send wmi ftm command: %d\n", ret);
+			dev_kfree_skb(skb);
 			goto out;
 		}
 
-- 
2.54.0


