Return-Path: <linux-wireless+bounces-34855-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNO4CpMR4Gk4cQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34855-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9720C408A8A
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Apr 2026 00:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E86314E7C2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A69394799;
	Wed, 15 Apr 2026 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgjNXL+H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAC39151D
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291877; cv=none; b=KqeZBCKZO5DrQtd0gxMY8wMwDXNW6qZ215dU0fC1Aj3QQbEd6m2vNGX2/sCx7Ugf7KXkTlpV4FuiJRZmibaHNtd+6auoBCymQYgfacHQ4JAjesRFmnCNXkfYqNPuIsd8VndS3vUg0TscuISTmtoVOOnzxbV+NLZ8unvppr3jtIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291877; c=relaxed/simple;
	bh=40bs1NTspOUQJo4Hl0YBhDgK86kIBXEVnehtEGowHRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P9/5oazN4CobOox+hIuPCMkZOHQYcNzLD2sJQF4HnX1uFEdeVVo6CDvSu+8MLjTqU0sp4HJiwGpSZLVKMb4ohALGzjX4OKFaS2Y5MzWeXKLKCqYjenLcIfXnW+zKy7BciCN65IGNvkc1jlPYc8ppQUHfMM9uRBdJAyeAnPuV+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgjNXL+H; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8efed61so428685e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291875; x=1776896675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iNTUYwQVpGvF/jGGGdhC+wqHiTX8hCf4cMxFujlI6rE=;
        b=IgjNXL+HlS9esQWR6y4/nocjJmtJ6iaiXWnWkE6JwtlC9ccKGoZsOTovVibrIqlK4b
         TmTNB9EBCsy+ecs7R0aIJazcFNdeyNyPZlXYW+zrFG9CuSwhcTPF9C7wHr0TNgSzlZyv
         TjnLXvt9ylJ7zEut6Y4N6msWsIjEOvL5POQvKQnaLI+UPvDqtTa3oA2Tuwz+fDF3m7C2
         0yNsB8t0F9XyPxcU0GGsUrAkvmW6WfFpocfNy4eP5cLJukFXKLJsk27BlDv1bIDDl+2f
         GWrTHQcHccvBmkEvkhqbuCbc1KiOpIfNHNY3hnYgvcivkKPEkgJIp2StXJJlXEzv0DzE
         18kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291875; x=1776896675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNTUYwQVpGvF/jGGGdhC+wqHiTX8hCf4cMxFujlI6rE=;
        b=LYNiZfnJphDubXlMyJ/3xIEqz2kMCERTN9FCntgjGxa0txjzMcIa2vNy9lz3PLmgIj
         yem++Z/TVAcmKHej55V4/qtegz9SLI+kspFjbyeSyg07LTgaXwS0vHfFvkId8lb1/O9X
         gyeVvmhgGxhuq/EhvwjFgFy7WgZHWHdgbVoy2AjoFI7z+Mx2uuz1dBtidR/FN/2EvjtK
         h/stSAGlIuugAb+VpnKiq09ASACxhic7PjIAxRxQpv0zH8liZcgfvIw51B4pRW6hv4CO
         0LMLC9Bc+s+PJT5WVScwnwPL5+noWayjLJXWFyEigNAjdDeVxdWFkxJmdcufrggk9uXN
         J2bg==
X-Forwarded-Encrypted: i=1; AFNElJ9LpFfL/BXahL9TL1LBCSTVjzRBiakT97q7mzjbYMasQqHhCNyo1I92XOvSjjwKRIUVhV6SsSHofhuq1VVe0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Zpzpe+vpIKsK7OOimWlAqmt1lFmazmAC2k8v7m4Tk1qoMxRn
	lT2Y+Nt5np3/SPVo1A/1DN5mC7ldox4FXR7CJaa5yqbYAaypBxeOqKo=
X-Gm-Gg: AeBDieuqVRGltipTHC6+FeG4gn6DqgjGD0RCXDTZE82j4U5D5BrZI4ok3ltIsMUcC7a
	Z1UC3MIzrm0iT84NB2Wd+agwXwn2dXaPXwt3t7yNeS+ADKgkV0PwPiH7lEF2f0AI01OIlcw1+gZ
	u4x6lENovUD9qKV7/aTI55ZI3VtL02DjAFbchTf6h0PhY8drlt1hAnJzsgPZoT/GDIfLDNMIR9+
	CrdsoZt5y8rTApejh06M+XrejLgbfQ8P1wch0mmylelHeE8UMQ8Mfr4ZwXhabNtY/UBfKXPg4B4
	+nUZs/SdgbcS2njClLvGk5paM+zD5E67/JPhzHpmYY0Mr2z+NTRZNFeWy1TUWdEmJXeL+iCv41T
	/YxVjiecvtvLUgO5u1l/Ss0zUsF0EuOPNMLKYy+zcetVlklgq4tZKd+oGcMUYObOqJRDMHrQKj7
	NJgrs=
X-Received: by 2002:a05:600c:5888:b0:488:a9c3:44a3 with SMTP id 5b1f17b1804b1-488f45c02abmr11847505e9.2.1776291874850;
        Wed, 15 Apr 2026 15:24:34 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead3e89ddsm8032095f8f.30.2026.04.15.15.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:24:34 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: [PATCH v2] wifi: rtw89: add bounds check on firmware mac_id in link lookup
Date: Wed, 15 Apr 2026 22:24:33 +0000
Message-ID: <20260415222433.1545305-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34855-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9720C408A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The mac_id field in RX descriptors is 8 bits wide (0-255), but
assoc_link_on_macid[] has only RTW89_MAX_MAC_ID_NUM (128) entries.
While the driver currently assigns mac_id values below 128, the
descriptor value comes from firmware and is not validated before use
as an array index. Add a defensive bounds check in
rtw89_assoc_link_rcu_dereference() to guard against out-of-range
firmware values.

Fixes: 144c6cd24b35 ("wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Note: v2 resubmission -- original sent via Gmail had HTML rendering
issues. This version uses git send-email for plain-text formatting.

Changes in v2:
  - v2: reframe as defensive bounds check. The driver assigns mac_id
    values below 128, but the RX descriptor field is 8-bit.

drivers/net/wireless/realtek/rtw89/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index XXXXXXX..XXXXXXX 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6435,6 +6435,9 @@ static inline struct rtw89_sta_link *
 rtw89_assoc_link_rcu_dereference(struct rtw89_dev *rtwdev, u8 macid)
 {
+	if (macid >= RTW89_MAX_MAC_ID_NUM)
+		return NULL;
+
 	return rcu_dereference(rtwdev->assoc_link_on_macid[macid]);
 }


