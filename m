Return-Path: <linux-wireless+bounces-36782-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAIYEN2VD2o1NgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36782-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:31:41 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8D85ACC2C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C1C8301C5A5
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91D35AC0C;
	Thu, 21 May 2026 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU89jCJy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283853264EB
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405831; cv=none; b=C29V/4557s4DLvZo6amF7pfznC5wlxWkVn2wI4hlni6iEjFHFlMNiOwK4Q8KMeXYlsnoBFuaJAU8E5vk6nPCZZP6R4tp1XLQ7pVsFvW+mjnfR5yK0w077y7HMZkNLUYC0AqgoBNYuWMl6diO4LYmdVuxHNhOWdv7GlOM1RI+/Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405831; c=relaxed/simple;
	bh=PI2SguFfHoNbaokOXLCIrbVK27WuPtC30EkIAChdPps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMuwrzDw6cy/XgXx3fcashp5SJenTjDe8y4ihwIhKMI7VMB5wAlXazt+YZvYwT4RqTNhVI/16GFMhPm5oMYhP3Cb7kD8jQ8mBF9mqbVcp28rcTInLVxobCkPivngBFtAoWmZs4jB/5xYIEyh1oaO1Vaj7j72IWBuPNvE0isRdbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JU89jCJy; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8354461da74so3070056b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779405829; x=1780010629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LN/SoIqtq5ewAat4+Mwh8bofN9QX6v/SkET6kGgJ4eo=;
        b=JU89jCJyS0qj3rl9d7v2U5nT6YdCl6ujnat424W/kvGEcLudexJ4yM824D8+7w893J
         f5mirRbugqqFPXKmzVDKMkKM1wGwy6FhDSLpe2/C5PzleaoZ2gV1hq1VApHZVsmA/h6V
         ZzPKUkK4Ot9whClQhd06sSOz7w6R7ezrcqfo+qhY8F6C5pa+rUUat6uaHu9U3CkP9tW8
         5oILVepwettBVeDjafNjW81NvOlX2Ebodg+6lk/65vlCl9syXvFbRqbkxxgfizpmCmGb
         RqPco3fFA+yDAsYLheC74xeeM7/SIJYXvMFhetxGWWUTUDSNKaAa5/t5azUxHzrFp/z1
         Xsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779405829; x=1780010629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN/SoIqtq5ewAat4+Mwh8bofN9QX6v/SkET6kGgJ4eo=;
        b=bPrRzdMQ9Uts8ixO2j+TugG4ZPZaH1WdhZ9L9bLi6hdlUULZxyVZB6JcYOSpfIViDA
         11N6TnvHL/kidz9zKSGjnFzJ2cX68Yrkjvk6X2EyFV7+CKr3BUgoKeeCBFD247xp0BPv
         axug4vxL8ivGy+LTNNox9r0ODr5skq2duaM9ZbxUcrkARSDJ9zV5e1BCpLGYKLhHu4zF
         GPxoQupJMDib7Um8yDPc9CiZM/jRim4u8Y5UEIhknrBWbd3oS8Kjhxc0eioYpqMXXrdC
         o/w8VAOtabZKqAXK77YXHm0vDbbODDRVOvl27eLoMgL/6OLZTKR5q92Frfa/qn5i8ORG
         VxqQ==
X-Gm-Message-State: AOJu0Yz1sgtZA1dcpSWl8cwSti3ltZJs5JAIH45I2WPJWWakKr+F6LHG
	DwjXtwXHemGf4y7A5LhI9jV5TvkYpLNs6MYkFkNmkvxmhF58GpFvokSmmTyE5g==
X-Gm-Gg: Acq92OGMWORS49riM7Z2yz2Av8oiCmD/HYY3d6iEmUY+H0IdaqBMrtCMrGbilsqH3tD
	rm7nq9zbc++srGWCTeGe2+xmwNVGd02GX2Sq1rsl1100qJZ5NtEjwASyhLukiol3eoonTcG3g8G
	vIq82fZ80OJ/T5VwxRr0TthJfADuhdJvAhqHWhz04/U2fPQsdeFE3FXEvbCGG8C1cOmEpAfTA1b
	gqDrGW0v+GPZ8T+JvHQpNArOa2aG1bTMwAVdBmuMgIHN+GUczNDJ5YQg5LdYuU3mGuWzwb72lZx
	PcRmbzEE83jDkachRz4gajqJqWkSQQqyTYnBVCIuTfJG/2mDz/gJKXo5ROTZ7U6p8thgyHkCeHO
	CY4qwZpFK75jei38im2MIGDzVA6+3gqJY4NyGNA+a6sMiT3uvk5IsfDXYEJECtceSHksCQiVwNB
	l+++kAAkhJnfhB+nRVKZSKtSMXP1Zul4crYZhVlEh/bYjd+Rt7cLjujBreHSz6YeqrgroCMQ53J
	Sv9/+KSEQ2GHWqdrfx1hWhd/9UewW7Pv9Y=
X-Received: by 2002:a05:6a00:4396:b0:82c:e816:4135 with SMTP id d2e1a72fcca58-8415f626328mr1081700b3a.47.1779405829107;
        Thu, 21 May 2026 16:23:49 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8416273c617sm201630b3a.13.2026.05.21.16.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 16:23:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH ath-next] wifi: ath9k: call external_reset on AR91xx
Date: Thu, 21 May 2026 16:23:31 -0700
Message-ID: <20260521232331.261761-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36782-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D8D85ACC2C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fixes some stability issues there.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/wireless/ath/ath9k/hw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 5168c02bb73c..cde318a21a81 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -1448,8 +1448,12 @@ static bool ath9k_hw_set_reset(struct ath_hw *ah, int type)
 	if (!AR_SREV_9100(ah))
 		REG_WRITE(ah, AR_RC, 0);
 
-	if (AR_SREV_9100(ah))
+	if (AR_SREV_9100(ah)) {
+		/* Reset the AHB-WMAC interface */
+		if (ah->external_reset)
+			ah->external_reset();
 		udelay(50);
+	}
 
 	if (AR_SREV_9330(ah) || AR_SREV_9340(ah))
 		ath9k_hw_disable_pll_lock_detect(ah);
-- 
2.54.0


