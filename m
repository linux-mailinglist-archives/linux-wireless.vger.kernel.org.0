Return-Path: <linux-wireless+bounces-34844-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE/RERQS4GllcQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34844-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:32:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ACF408B26
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624FE31BBADC
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E40139524A;
	Wed, 15 Apr 2026 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXmKhehu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB4396B98
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291847; cv=none; b=etsQ5VIHuZcqMExaZTSsFvPjHbFfXwdPcA6pxNdYCbij9DWepMbNMmHzirW9Y3F+as+SpATxk2+k6M/T5dEWlnMXJTiEkmHvWONaps++reHlOcIzQJj7LSkAqZgpkiurk7fifEAJhazudieilxCaF1ElOFNg+kdxbs6OcsLtElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291847; c=relaxed/simple;
	bh=d2Lj+g/W9ca8SXN/DcXG9vOg0X/HWgbA3Y9HMpkWKVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzk5tu8KnsdJ1vQlL1NNEvSIKYCPLTe4GC2RWWSL1TKZb9mmbM9CKZLqJUITOzvSOYdO+QhhfVQrjepxjuG6w38r+PF563PeCP0YhCJMWFu/bDn2dbQYQbvTyRn2dxaFaFdaUCc6NbuhzTWt4R4ic/2xcgozmdqlH8agyupTt3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXmKhehu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfd832155so5067629f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291844; x=1776896644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXUnoGF+RGk1J+y7bIlULUzEO6llEkrIJpWaZB0xE40=;
        b=PXmKhehuQ98urhGencRG7F3uhogOCJE1hocV/RyLgnYqaq57U8f3VKLiFo01AqAGR6
         TQqilMd/m3hwdHk3HWj5qZ+ACyGlB4IOhKQvb0pqTGAc3fSiFbq8BNLvECweGPafW28l
         uHeo+bcDc/0nMqQfzj1ubgcWoILgkOU9o4riQOU8mOhnQZ54pVBV2Qf+qegX9JIgO/cL
         N1N242KKy9EsCGxjmyJr7eOLIXvYjlHksAN0tRm0pl5ojUdoyyWTTHC7VGqNJfrzIFxw
         hBmaKhX8bRfhYGl5sqlgyeENAkWw0y+JLTq4iPGYiCc5JPJUO2upxUn/DRBwVMHqoiBe
         wm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291844; x=1776896644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXUnoGF+RGk1J+y7bIlULUzEO6llEkrIJpWaZB0xE40=;
        b=LC83r3kome90JrsYxNyr/nmFa3JVcQancs+4X5bRz95dnt09TQ9V9uNYAS+7ZYna3C
         HjiDpqLGRLk/TVIaB6TuaLU+1Ft8N1ertUI2d2Jr2RrqTBA7xDmeGPWlnypED1/97ajG
         oKnWvH6AdJb23bpao/EUIM6KFiRAfKVO+wgYV6+i5zaAHBRny8s1ZNdrNy6EgfB3Zh1c
         tdp9QV+liT+Lp4rXtlrtR3iAoL8/LQy8y4mxQolSoC3cM3lRaT7WVGLgBci2k+KN/8hp
         Z8KUNGwVvniLEkcwfh9XNaf/yeUHy6sKp3LZP02mpDqvBVAlzBzyEy00p8htRZVofuDL
         BmmA==
X-Forwarded-Encrypted: i=1; AFNElJ+t4EIrG4nXAOee2dVb65Aq6lzZascsCmQelYN8NRWcmtoWoexAfEwY3Yq/p3I5MKy6sDIx+6tFcSS86wSEtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaknyOCGfY5yoIs6Qdu2qzuiysf3CC5B0RI/DPET1mCoAUzvcg
	lp7xgo71j6hcJRgPJTH5zNFif4OPWvI4dtkyIjcUZH5nhqTG6xG13Oc=
X-Gm-Gg: AeBDietBfIgI37+CVTA08HWkJ0adnq1S2mxnyuObGNCGQc6ibeTTNy8RU6uKdC9Rlrn
	93BrpL5oSGlLaOUeVjateboaWE/b8a47d6q+EuqsSntewxHo2Zz0jlPL/7rr7SInCgRkrcJhGlK
	G0UK2tdAeDz8bNM0Zi3MSck79tXR1fReDxG0TyIwOaqNWjHRhi1T7zkH7yHs2ltNKKhR9S5JRsK
	JKqCRyxJLeOHMuEThN4yrefLhXWBHw5auNlFtEggI+1ODGalogzRUej75mj2jSiLNF7RlCy4mFr
	oL2ej5zgtbLUE1yIU+M5lfr8tEP8sJWFmQHTZPRhnNKx0ObgIYBwXmdEIPbzdAgyBZv08y47bii
	KZL+VZzsCxstTnkshPd7UIey3+VYRKmbBu999ZHEIs5PgphdmyGjowyxfeKz9BOFhk8epYVR86J
	4SKIc=
X-Received: by 2002:a05:6000:200f:b0:43d:184:8aa2 with SMTP id ffacd0b85a97d-43d64270ef1mr35538934f8f.16.1776291844062;
        Wed, 15 Apr 2026 15:24:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3dfff3sm7613861f8f.26.2026.04.15.15.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: wcn36xx: fix OOB read from short trigger BA firmware response
Date: Wed, 15 Apr 2026 22:23:58 +0000
Message-ID: <20260415222358.1541983-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222358.1541983-1-tristmd@gmail.com>
References: <20260415222358.1541983-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34844-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: B7ACF408B26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware response length is only checked against sizeof(*rsp) (20
bytes), but when candidate_cnt >= 1, a 22-byte candidate struct is read
at buf + 20 without verifying the response contains it. This causes an
out-of-bounds read of stale heap data, corrupting the BA session state.

Add validation that the response includes the candidate data.

Fixes: 16be1ac55944 ("wcn36xx: Parse trigger_ba response properly")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/ath/wcn36xx/smd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2599,6 +2599,9 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len, struct add_ba_info *ba
 	if (rsp->candidate_cnt < 1)
 		return rsp->status ? rsp->status : -EINVAL;

+	if (len < sizeof(*rsp) + sizeof(*candidate))
+		return -EINVAL;
+
 	candidate = (struct wcn36xx_hal_trigger_ba_rsp_candidate *)(buf + sizeof(*rsp));

 	for (i = 0; i < STACFG_MAX_TC; i++) {


