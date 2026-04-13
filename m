Return-Path: <linux-wireless+bounces-34689-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCtFIJWr3GlfVAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34689-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:38:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF53E9367
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33243010B94
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528F83AB29A;
	Mon, 13 Apr 2026 08:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqcrPDn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80E38237B
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069493; cv=none; b=UOn5urmlRszPynaxyS0Q1eISqrzvSJYnVZDiBfih+2Q2UMvv/RYR+fyG6EOrfvLr8ozCNzIMwSvbawIrXMDgJGqLtqJDHdCGevHf4afZwC75w/8hA10GCkGEjZFpqLt+t1uXuqkCoXWUgaj2z5e8PF4U8+DDyppRFFTUKoWLTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069493; c=relaxed/simple;
	bh=JO6miBzev0XKV1sd0U47JUaXD3X5hVaJCh8QeODRHek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7nI8sP549emIUHlDSW4fVp/zpZkmUQqEdiHu9vPoOqe783JUxrd5kLS5sarzJt+djPGitF2jZKrASv1KuplXXgHgq0yWj6z6YnG2N5Mhoz/oERiPJy2T0emdHTaFmspp2ia0fAVMBwsOSQbAGSCBPNYgCIoOzbAOCm6tYa0tCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqcrPDn6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4887fd35e60so28767295e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 01:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776069490; x=1776674290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHxu1HbYuLjw28rCxRqK7pnt91C7nOV05qM1NN7rF10=;
        b=LqcrPDn6ajyxryF63CNBEOjhnklPDPhqqpVTJ5zMuRntcGSYGR1/SMxeTiwIcizJU/
         ZPZ1oJjuLN6g1zNlRdeM2Mt1B35V+Id2nqJbRlIq7IeDqo4jW3ijufgVgM7R+dJjefjv
         JR9B0u3fBR2gXgHSrKwTiWHUP5i00w/2WdN8TBTpx4WQv616iL6frLXDB2d+FJp2uh4E
         tYJajZ5OJ7SYRieT/D2PfAmlxWE58pGcvNA+9HaNJ2xDZlTwY7UOpseJq1970UbLDyE3
         neFc4/LRXT4VudZvezTX+kf045DGHOOEW8VF7F8ESSpvB3WxIlS+g/ItTvtvYHoj5+WY
         exbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069490; x=1776674290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GHxu1HbYuLjw28rCxRqK7pnt91C7nOV05qM1NN7rF10=;
        b=a9yXUoVbx1WKhZeS6sFTwv6PwQ1R+IF5rIcDPG2/x4nfLFRaNbsTqI/4OwDIvXLVrv
         fHuaahd61x43VXHi4ofS7g/7NYIhbbWa/tcX3J58B0nfY61RceSBt5Mv127qMnucCYhl
         C3XrVWQpzLmLmjVU1V5hIYhD7KvNo9rNiSH3UfJuvGpjfhaY7H1L5yC1Jyn1QT1ypHbU
         JxsPRHpOUTqSKFIyEf27q8n9MsmnJAoFHLs5L5rQmwpdQdjfOkoxY7y5TeOwB+y8xG7V
         z5z7XHyA6UWbfQWRQbPTSkS/m06IXlLTTPSwI2oUwuMDqwkAtQmqsJfqnlJrbhKxz72B
         d8Uw==
X-Gm-Message-State: AOJu0YzN+2U6Q42RaaNXAxxvu63tucyCi0LC46/gm+st0G7KsiRoOJuX
	MERMghzegn+ZJ7lzNg6cXkMID7ugjRYll8fjl+PDtuFB7A4RIhpe0btyEeCggg==
X-Gm-Gg: AeBDievJQy/oG8+94lLL2qxug1BX4AhEW8DUsu0iIy30ZI+XjiTh3VgaoN/HfcSfpms
	7eql9ReSDoDTc/QaUn1xEmcAlaqHx+rbdZ8d+HMm7xHrTVJN3HpvProYcQ/cGhaE9uV3EsSgCcu
	AOL9610Mr0PqfhvhoiSfx+EPgr6sPNrdF5sUl1eDheJ/+AvRKlAFet6hIAO62WnFHAWkO6JF+4q
	kXAqumN95TjKVX0jMWt6qq1DF7ZgeAta9cM6abS5ClxkaFexo/VA1pEM58C/WjRdpo/DlPYp7OT
	6nT3ywtNwZGyRK2gaf8NcSGaulD8rlVcjYbCDcLeSxSgP5DN1T6ABywJl1IsL7gbJDNFmyi+SMi
	pSZZtpynul9tDrvNrfaoa9PJPpo5gzGfvK4ryDieHaluFTlntyjKtU6JnZ8cB19X6+NCvkjj987
	yJOEoAzXL/iFKEgVqvYC1/xqRVnfhvKY4nDWnktLc+EScSa+czrtpXQBRO
X-Received: by 2002:a05:600c:c0da:b0:488:ab5b:d711 with SMTP id 5b1f17b1804b1-488d6864b6cmr134710975e9.23.1776069489680;
        Mon, 13 Apr 2026 01:38:09 -0700 (PDT)
Received: from syracuse.iliad.local (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67a46bdsm139406055e9.3.2026.04.13.01.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:38:09 -0700 (PDT)
From: Nicolas Escande <nico.escande@gmail.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	maharaja.kennadyrajan@oss.qualcomm.com
Subject: [PATCH ath-next 1/1] wifi: ath12k: avoid deadlock in thermal read
Date: Mon, 13 Apr 2026 10:38:07 +0200
Message-ID: <20260413083807.1727905-2-nico.escande@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413083807.1727905-1-nico.escande@gmail.com>
References: <20260413083807.1727905-1-nico.escande@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-34689-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05BF53E9367
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When removing the pci device we can have a deadlock if we try to read the
thermal sensor at the same time.

This is due to the fact that when the wiphy gets unregistered (so while
the wiphy lock is held), we wait for all sysfs operation to complete. But
if a read of the thermal device has been started in the mean time, we need
to acquire the wiphy lock, which will lead to a deadlock.

As we already have a flag indicating that we are currently unregistering
the device in the hw group, lets check it first (before locking) so we can
bail out early and avoid the dealock.

Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
---
 drivers/net/wireless/ath/ath12k/thermal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
index a764d2112a3c..700e7458ddff 100644
--- a/drivers/net/wireless/ath/ath12k/thermal.c
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -17,9 +17,13 @@ static ssize_t ath12k_thermal_temp_show(struct device *dev,
 					char *buf)
 {
 	struct ath12k *ar = dev_get_drvdata(dev);
+	struct ath12k_hw_group *ag = ath12k_ab_to_ag(ar->ab);
 	unsigned long time_left;
 	int ret, temperature;
 
+	if (!test_bit(ATH12K_GROUP_FLAG_REGISTERED, &ag->flags))
+		return -ESHUTDOWN;
+
 	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
 
 	if (ar->ah->state != ATH12K_HW_STATE_ON)
-- 
2.53.0


