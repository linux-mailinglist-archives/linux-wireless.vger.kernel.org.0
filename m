Return-Path: <linux-wireless+bounces-34549-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FWuFiKw12kORggAu9opvQ
	(envelope-from <linux-wireless+bounces-34549-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3EB3CBA55
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 15:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D2930866B1
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 13:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A437BE7D;
	Thu,  9 Apr 2026 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b="y8tMjT7J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7003D3CEB
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775742657; cv=none; b=Qm53gi3kiitst2NpgtDyTIenJJn/5RAKUQYqUyPlDphOyfU3JspxKWkBeWdhWSbctEuy1g76T5VXnLnnP8AXs47X29tLMd3wwaTY39R+tCRSY3z+4EVNLq46AXA+CTVozOpcBrOzKqC3xlmy/VVU9KHCqSL0BPSwHVC/SV+qcMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775742657; c=relaxed/simple;
	bh=1KhnCDzzjjovJ9avW19Ijla5k+ILjvwGQmuFCpxh5iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAkn/XTOx1fhHx6+NRitOHdFAwYL3rLEW1FwSuvPpgF86rRIAwDHHI/c5gkXe3L70MlBbvjnZiltvOZG2daALT7YnBwx5J32vyUOFIQ7kYaTg8G8HIlQZt+W/J1naLVJh34cUHbi5IN7fd+DZo+W9Ty/nIC/zUSYFRogWxdc7Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20251104.gappssmtp.com header.i=@freebox-fr.20251104.gappssmtp.com header.b=y8tMjT7J; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so11088125e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20251104.gappssmtp.com; s=20251104; t=1775742647; x=1776347447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2mFUfLxqdoRukgDEWfqeZph5cDCf8XBe4M+zxLzV6Q=;
        b=y8tMjT7J/ZbePTTYDJnPaaBXYcaIXRK4iUEFMq2tRutP0ihyrx1PjIZCO0MTAaR12H
         7LUZUAtAegmC2RWRDi6c5q+IVJfvOrA720Y2MDLm4QE/hXvUf3yd+ht+9w6AOfBNyU3i
         F2B2xL55qqVN/1Iq/qKg1m2fGMBcFs4vzjx7t7+46D2rr1Gv1B/+rYuP0z2c25hpg/qF
         sHRDvVSLreOPZvdiFWxAdqVrXnbd/Z/rzjmg5QV4mbVBg3bbCYQl8s/yMJwlp4uAoUCF
         CTQPt/ES51XLbz/sO5caPzIIF2gaLFxr3OmnTzvklXbzREDTZJhTkAGygcNX/Ala71LA
         8aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775742647; x=1776347447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h2mFUfLxqdoRukgDEWfqeZph5cDCf8XBe4M+zxLzV6Q=;
        b=TdnHV6Y6Nl9ZgOIXryUhiRuICXRMe6RU+tVHdmjTaY4wZqjYNUs003BCZ9aElojbg4
         KPXvxy3Uesnj1oifZ/LYPLpijgXuO1ueOuPXE4+Nb53S+IPNQQ1rwFnn3tMj3XueXvAv
         aSaDI2dRzoScDYRyRWwnbze3xPNu68s24sAfYVZR34HE4Alc+GsWUOvenKslRYODSRBH
         YfKtnrY3z3F2fwqJtc10gwN9GZfGfce+8dDOVcx+NWHOI/xZDCdnI6crUlVmqjR65Ltq
         nezpAtpW+Elro4zcUnQjq3Yd4G1z57ZJuS/J50+toFoTxMTC+aBdKD/75LqxwtWTvUE9
         i/RA==
X-Gm-Message-State: AOJu0YzgCz+0U6pvD7r86LKN6Qk7vGqfkz64PR/kzhb71npe9fwswgTc
	lw18vO1c1Yw76NBIiAYRLz4Y4rfYG5zNZTtavVjG1012Uo7dQ+m3GaJBMmU302Ijk9c=
X-Gm-Gg: AeBDiev5ExTBeEk6rigFA5CReYYjEcyB+gg4gb0sIx4Xsx+IZVv9rd7IjJpiXanKO8j
	PSTfylV02QOoOvlIyz5NHcenC89LM5weE+nMVY0l+Xd2fLIY659joRmCcUuIjTxY7WvtztjSQCK
	/17jeFbXmNm2oseFQodVi2F4VG0WNXiI0mZ7WptgkJQXS1LbjoU9kVMmbSEG69UYmnMihCHUtAe
	ALAQCCxBq7XARqnbswPhraJMl0iEhiRgjjIFjNXKLshzwcMxAYMS9fszhebf2kC97PN8+7CNqHF
	NDC0WH6PO9nKuViP8Y7/M5tX9N9xjvj+X1AgalqyjyZrOcY19LExD65ZAglbQcA2sRGDMnAxPk3
	i73ES1W+mCse1rWnRDa9PqDtVFMugLrttlYX4zUhYL6CA7lY7MyyMUWYY2JnxXTw1bzjMuCPTP5
	syHb6rJJUnRg3iXgz2OPx9PUANrYbVNPi0FilyEGbXb7y35ofbbYaYt828uIH99ponEovIgMUTM
	pSqQsRcOjlD
X-Received: by 2002:a05:600c:3492:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488b14fb9e4mr235474965e9.0.1775742646949;
        Thu, 09 Apr 2026 06:50:46 -0700 (PDT)
Received: from pablomg-ThinkStation-P620.mgt.proxad.net (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cf9e8808sm57815625e9.5.2026.04.09.06.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:50:46 -0700 (PDT)
From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Subject: [PATCH v2 4/4] wifi: Update EML function documentation to remove EMLSR-specific references
Date: Thu,  9 Apr 2026 15:50:32 +0200
Message-ID: <20260409135035.4018725-5-pmartin-gomez@freebox.fr>
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
	TAGGED_FROM(0.00)[bounces-34549-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: EA3EB3CBA55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Transition Timeout is not specific to EMLSR and is used by both EMLSR
and EMLMR modes.

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
---
 include/linux/ieee80211-eht.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ieee80211-eht.h b/include/linux/ieee80211-eht.h
index 82efd01d7708..92196018a950 100644
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


