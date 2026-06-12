Return-Path: <linux-wireless+bounces-37742-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 27jMMjkMLGpYKQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37742-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:40:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 490AE679E99
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:40:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="TYt4v/+z";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37742-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37742-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C19B31E3779
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711E6BB5B;
	Fri, 12 Jun 2026 13:37:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E93B5307
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:37:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271439; cv=none; b=EKg2yAofJ63uLYQxmzZQBh5nlMg2nUMnw01N0e0stcMEI2FnoyJDh2WRNabALrBnMKUbd4Mt7WI8j8qYFVzU5tan5G0EVzXGBwTJhs6UJNITRAeERB2a25MR8tILkbel2NC7FRzLWqnSH5SUBisf/ktBs9BynNIjMggkdrCvAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271439; c=relaxed/simple;
	bh=eS2PCW1fBT7VZCc8gelLAF5XoflKDJFIK3buogIJH9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHYnoxsdcrLwUqCnAlYSZtwRn2nuhl84Jal4woUuowtJzuXr8Bx4ouznfK2DRC2yfL0LzTy/fywSVg0OebNLr+ZCrT1hduAJe7iigP0dJkO/t7SQ9TBZULNPyBXMsm4imyZa9PDSx6fMnKHjc4xZUzM8mxnASvcBGdevMtAAMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYt4v/+z; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423efd76c8so789269b3a.0
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781271437; x=1781876237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KgAVEoo78tlaYfkuOLNp5/i9qrACsjmRKbV+G3pQtWs=;
        b=TYt4v/+z/Aw7wojmLvLg6hkCklZwZ7WjwUARXWj0VBh540LIEU0ZxGPN7x5jyBeIEG
         I3Jf1V3GIlNluCCtmXp3am6eySAYiBfIZ/Zr9oxvURCjWt7DoR5pq/2oW0ViOoIRkqhq
         LH1zz/kRy1I447mNJTS82UHhTmocmr92+zrluzoIz7BW/nVylg8oh/q0ml7WAi/1O8iI
         UcKsx8QO+v/MBDj16+3zZIAcQ+q9BXDrGmHu4Y0Y77yncsp7QMzlqqZ6AhUls8dwO5N0
         bGVMJyQpEN15KUC25Wcubi2kUJmiYYkYdx2RrMH18cbiwclweFTRiCr1JdLZuQvG+hnh
         7IBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271437; x=1781876237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgAVEoo78tlaYfkuOLNp5/i9qrACsjmRKbV+G3pQtWs=;
        b=lJAvhYhgCJ/pQR2zmXu3SrXD0+FC7DNoM+fyNxEkDauqviFrQwTm19P6IaUepm0M/s
         idp9FgbFDF+pJSSKnWmp1GwQf5B47R5x70a/6wWMmr1eFt43hL+SL5ykH6nIRMErvpET
         JAOn0h8ehyCKo2CN2jfMkUlHNEiFFG4dzaT4F2c+lhFZHOyxkIVBdcHGYIpEZ9Ig0YAD
         VF8jdBenK0GiIoD3LdcVaGV7gs4dQH13BR55qgj3Uudt+TVRqI2cHtgPg/wHklh/6vbE
         oS/bDTWnIhhlmDRichdPFqq2ibdbCZ9FHXSGaHV9pN/UGuaWBZZel2Yh0FUMj42+9ZlB
         OoJA==
X-Gm-Message-State: AOJu0YxYTFstZX81ajMUf++Ow+QlOMxA9BaAkn+Jxaq9Ja9+QGC/DEMR
	LMqjQYoqiOH/N/xuOx0vV1NvMkt7WnBG+hGuWu+zlPXfuW13kFmJWptM
X-Gm-Gg: Acq92OHbuAuGGqTUpnvAxacQ2ATcBh3BILxxsTk/BNuvHjUAml4mQ1iZkqPpzHIUArC
	4huRPHcy+aQTiUmjmFxPq2+vz+wEvaWnr4C4dQT9tDd4azuOU1U4XN+LyRP3gMfVbeKOVTmMMES
	VeGzoaQ3ucby9qXEeWY2KYbfBUJGbrJbKDLFqPxSMUeXjF4Ng0RwmVMdGzwJlPdVFbATewd0f+t
	W1h8bewrZgdc0APBFrZsnRrsyKhRL4gBVtm4oYocKc56yuhr/z5CnwQAuU5LU5SgcQGXWOdYm+x
	OPrNboY9cyPtZEQRccdN+Lmka/dHP7+1zHB71TVddJLEQ2dzfdxA/S48NrMZjvWQg7946iaL1t+
	JGkKMdSNRphSIVIkBeqx7ot9byhEzFW/2J5mlhUz0bsNr6Jg0/6cg+6QhUaolRN8kH/fFJJuqU5
	+10eWl1d+ZReFCOs46mv4D5+goRzP82ay5b+Vb4sbOUVW7wB1lhe72p108l1sypuM=
X-Received: by 2002:a05:6a00:1908:b0:835:45bf:9660 with SMTP id d2e1a72fcca58-8434cec7be5mr3165257b3a.42.1781271437302;
        Fri, 12 Jun 2026 06:37:17 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d3f9sm2120786b3a.41.2026.06.12.06.37.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:37:17 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: reject unsupported PMSR FTM location requests
Date: Fri, 12 Jun 2026 21:37:11 +0800
Message-ID: <20260612133710.93544-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37742-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 490AE679E99

PMSR FTM location request flags are syntactically valid, but they must
be rejected when the device capability does not advertise support for
them.

Return an error immediately after rejecting unsupported LCI or civic
location request bits so the request cannot reach the driver.

Fixes: 9bb7e0f24e7e7 ("cfg80211: add peer measurement with FTM initiator API")
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/pmsr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d6cd0de64d1f8..9a68180605891 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -109,6 +109,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI],
 				    "FTM: LCI request not supported");
+		return -EOPNOTSUPP;
 	}
 
 	out->ftm.request_civicloc =
@@ -117,6 +118,7 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC],
 			    "FTM: civic location request not supported");
+		return -EOPNOTSUPP;
 	}
 
 	out->ftm.trigger_based =
-- 
2.50.1 (Apple Git-155)

