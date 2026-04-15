Return-Path: <linux-wireless+bounces-34822-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FWtKxMQ4GkycQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34822-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14688408947
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C83CD313174C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D263394470;
	Wed, 15 Apr 2026 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ9UFTTF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F143932FC
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291795; cv=none; b=u9Xb7HXQDYp9iVg6tPh+49Px5ASjhBcjdozF6/TL2Vn0VKoI4CSxFmwun3SHcFl6wPNQ/Pcf9ESFZnsV8xC4SUBFrSSk4bdCCyRWrqAF6HnhafqjK/sAKMYg0kUQjoWFEVfBxlQzofbHWFV+sMTQc2m7wwzWWYDqsvUJqRzkbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291795; c=relaxed/simple;
	bh=qwzvLXoxhSI6TyRwIBPV+AoD+cXf1obQzmvU+THBV58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCW9OkUen/61lJ3e4YAtBx5HFXAl/PD3GSn23rT9tt+I9bQj9DxPZhF8iQfdaxBMwUdMmQUyMG3b/UEF+dPmV+Kdt08kvHOtpr52YCahJVg65T8ChrG8vHKxDp6n3d5JabSKcHl3sPhF5dROe9LuSOR8WKun1pI+KtUgaNOvWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ9UFTTF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488971db0fdso72520955e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291792; x=1776896592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN24RpUKNLuweiqIfP7TnEHLafH/5TUmuuxdurxQ2dM=;
        b=gQ9UFTTFX8uIApf06vap0Nvctfnv+TBTrI8On1SK4/6el+H08tnZiStssY7hegu4wa
         MI/76Rs2pBoxfEFLMM8lo7X163tfGHG5PwTEChTbRvMjMbLjh6sWCthf5ygTuOQv5amb
         V5dFWaUEv+Gn7DSjU/5ri9UETxVp87x63kCTdUienLRadzqj3Hf7kiC3/3y37o75zpX7
         STjAO9ITrD/hDgDmAn9gMKIFR3IJOIC+5IFhCSRfS6NtVWcI6tihHGo14PMr3A3vfyIR
         dXe0qB2C12uj37QrtDWcXplMl6o+mhgKBkw6K8MBswx1IRDR3dMv3IsZSbnGqExdhJvV
         m6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291792; x=1776896592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LN24RpUKNLuweiqIfP7TnEHLafH/5TUmuuxdurxQ2dM=;
        b=JDsBKiXPqhrGKCgrT8ScmxRPXaJER7tGeCFzuignTA5+PhQ6xXoIWycNHraeJI76On
         vSP91S2hxYuy6WiHxcsftMLuWrLgyIypVREuf8wx8NiJSp95nZLowbS5ANiJ6xewysuC
         ScW4JxkFzZPB6DkHSSfikXE0IwOSYsATvx9j8RQRLEXlcySda1OgSB93OoH11HJl8zpp
         25Ahzhmb9xSDb68rj0lBnFrPh8MckSR59oi1+PxS9vwFJI/4yyGy377vZHbB3O8gCxj9
         oazpVrpwD6e2rAuI8DirKePAiPxYHBq2aGi3Al1fjDf/53xHUZ751S7/ykjOuKTkzcM7
         2kHg==
X-Gm-Message-State: AOJu0YxedXgxdAfu/ZFhDfZ1zWnrqulRjJOGrEJW4BRLPEghLw6w5sA7
	dbG8FOjprLl6Ny6Y2um2EffYP1W5fSfLt6Dy849xEv+txy/TdESwqASbCePrXT0kZQ==
X-Gm-Gg: AeBDiesZ/taaMekwH9dZobIcZHr0rBwaxF30R5fFd7om/+4yTKpLB/UU0pQkbJdp8X+
	kAU0dva/lHxgV0vd8KkgTfJe7+0e0EEDSISqilGuyikpooM9RdmFK85x8hUF1MH8Bl4BWv3AZh8
	Cdyw/g5bGRgVUQm1eqRR1VaiA9RLqxMeZdbjR65tVHI3QxV+fBf9KWfqpJQMpQGcIyZIHdWe6WR
	2XnAzyM4/bn5wZtqRcnhpyyp7kFKHxupKDb4ljGFjv8dNTbqIr3V2DUOl7UwTm5X+/lB+N9c5+6
	21OH4LiXqdtyxpEwkYIm6dLPCKY1MMWDQU1yTnVdLdPFCU9XLSA6FxigrSM4umPKEBPm5TJKdRx
	kF0Y6fFiaU7X516OqJjwYFQTjG1I5+EezdtsUd4DWeleLBCxZoADNmLgUxmOqGKfXdA8c3e9T2l
	V/8T0=
X-Received: by 2002:a05:600c:8b2f:b0:485:3423:727d with SMTP id 5b1f17b1804b1-488d688d46cmr299215045e9.26.1776291792438;
        Wed, 15 Apr 2026 15:23:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3d5eb4sm8662959f8f.20.2026.04.15.15.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:23:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] wifi: rsi: fix OOB read from firmware-claimed length exceeding actual frame size
Date: Wed, 15 Apr 2026 22:23:05 +0000
Message-ID: <20260415222307.1537309-4-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260415222307.1537309-1-tristmd@gmail.com>
References: <20260415222307.1537309-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-34822-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 14688408947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled length field (12-bit, up to 4095) from the RX
descriptor is used as the memcpy size in rsi_prepare_skb(). No check
ensures this claimed length fits within the actual received data.
A malicious or malfunctioning firmware can cause out-of-bounds reads
past the RX buffer, leaking kernel heap contents into skbs delivered
to mac80211.

Add a bounds check in rsi_read_pkt() to reject frames where offset +
length exceeds actual_length.

Fixes: dad0d04fa7ba ("rsi: data and management rx path")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
drivers/net/wireless/rsi/rsi_91x_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -179,6 +179,12 @@ int rsi_read_pkt(struct rsi_common *common, u8 *rx_pkt, s32 rcv_pkt_len)
 		queueno = rsi_get_queueno(frame_desc, offset);
 		length = rsi_get_length(frame_desc, offset);

+		if (offset + length > actual_length) {
+			rsi_dbg(ERR_ZONE,
+				"%s: frame overflows: offset %u + len %u > actual %u\n",
+				__func__, offset, length, actual_length);
+			goto fail;
+		}
 		/* Extended descriptor is valid for WLAN queues only */
 		if (queueno == RSI_WIFI_DATA_Q || queueno == RSI_WIFI_MGMT_Q)
 			extended_desc = rsi_get_extended_desc(frame_desc,


