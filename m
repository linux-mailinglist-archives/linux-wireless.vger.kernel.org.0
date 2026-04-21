Return-Path: <linux-wireless+bounces-35166-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFaFOoSC52k+9gEAu9opvQ
	(envelope-from <linux-wireless+bounces-35166-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79943BA66
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E743031830
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A703D75B5;
	Tue, 21 Apr 2026 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVnNU5IT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3636D3D7D74
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779415; cv=none; b=bopfgjkzAiXzZkyDMTrSjA1nTQWW/5c8n0MNDmD04dQBERCq8kSGirsuQvNcrQNSlA4weM8XiMCoZydwHxwFjq46+WHdyZ0RCLaKN0hAXXXthtZ+allIo8tYTSBtkBRvYN7yUTtx5kCqctoifI8XBxuGykW38DRAZgnUGOkmH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779415; c=relaxed/simple;
	bh=nMUZwV82/EWWFA9HBonHFD9Jw3tw62gHhXKeiT4HTto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inX9074sBfSvJygAETCJHrmz8mOL2Gozjb8p/a/Ff0IdxYOPOS0UxqZM0W8zfSGr3dV0VvSIFBc1Irj4DY17vY5GytzyUleBHFb6CrBhzi8ZqMTWvN1SrstWzIh3TLl97bi2dsL/oyiQ6C9FxESFfDYinKv4+iikmqGG0dPCBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVnNU5IT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso43570965e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776779413; x=1777384213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=475Ox04YxLiQ4k0uuKR/VNnFlbj2LkbXJRmAcU4HIyE=;
        b=UVnNU5ITB27/hWt+gEeUAmcQrNFzEF1SlfsFzNojG50QK7ZoAK4az7N7yTQd43U2SC
         goSRxwOGUcBT4Yf09a3CeE5VQCf+lVCp6aiQRA1cxFwefCTHXE2I0RYkaBQFPpoaTghJ
         tkVwygNgH303k8mJt34cXtsc6zBer+7wCN8TjCoZ63xWREOHQJPmGogd/AqwUCXq8OyN
         GIIUKz9xqwRlzWkwyDor/ouJh/IQcaRtJAOniUeX3uovPZX2252u7J7kUeqxNaDqDSWV
         B1lmijqfuTJtZe/B1jQoRwiQUWLVvsFEU8/VeU7J3WtvheRklGfuSyCVM0IWqLok0et8
         wc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779413; x=1777384213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=475Ox04YxLiQ4k0uuKR/VNnFlbj2LkbXJRmAcU4HIyE=;
        b=kT9i0OOnmDNc75ZffkduPKv0T1/Mup29efLRP+VP9t5+1Ap+02Ve+PV6OXV4DEuG3B
         lNmLcFQZR1WavnUwSQFT/i+1/S9WI7HLj4l7qY0PFEJH93mztYdAF7YICQJ+8CmZx/tn
         z3x0LNhLyLcp3O3zKYHvOemmrXDvigJTd2AhmMiIt4zuXwdzdoaWLOwKLhTOgTJn8WHL
         8Z23Dwjs4lLt+kkbODsypVyu4tScfLjqr/YA5Om3RSy0Q4iO1a5lHBD7GkrM3t0zWDAJ
         PNVyAyYZXCithx+kqq+sMZG11Mg99bX9kLAEDSpLjftjDThWrqZtblpFCvPNkH0hQmjy
         ZAMQ==
X-Gm-Message-State: AOJu0YwdZB5R9ipYVkgi9Egxd5AJN/dTOcEzSQg6RuLnRBDNzT9W8Dpk
	oEiCC2TkflBr2ecG1LjNHeRKzzy4QNjajjNRqGAlvEjieY5gsI1TYzM=
X-Gm-Gg: AeBDiesuJNKV/xq6G70P3VpNPW6eQRctWLSpFc9YYyw8AJTnVRCtpkPChB+VPkzd+qy
	AYMy4TUUo1yi5iUYiEKJUpQXWB9Xb3jpK9bycYkvelG2QPesJUkg3PyLeYJkWLV42aMtUd+L4dN
	LwuvXpG4C5SJGtasm0L2BIhFYBsMSvW2Bwx446+YsUUKjrWPRoTjVAtkCfM5lDNouHmU718BkJj
	AFv82LNfdZGn4uwOiUckcFmVR+greTduAZPR9gu+XeOFEh2lKF0ea6FrCD5UZE6HGBB9yiTWGmp
	jm1w/9mz8XtO4SE426NJGzliv5qBWKaM7UEMl7UDrpvzrStPDK/XEQD8iOEmc/wE5m2I9tsiCbS
	59/sMCyMGZAds10K7Blkb/2KWIc/k5V9h1KH0PoddT4uU13oJ9KYR79qbs0Ggxs002CePTJ1D9o
	0VAMs=
X-Received: by 2002:a05:600c:3150:b0:485:3b00:f93b with SMTP id 5b1f17b1804b1-488fb79df09mr277879795e9.31.1776779412533;
        Tue, 21 Apr 2026 06:50:12 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74eed9sm165464395e9.1.2026.04.21.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:50:11 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3 2/3] wifi: ath6kl: fix OOB read from firmware IE lengths in connect event
Date: Tue, 21 Apr 2026 13:50:08 +0000
Message-ID: <20260421135009.348084-3-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260421135009.348084-1-tristmd@gmail.com>
References: <20260421135009.348084-1-tristmd@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-35166-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 8C79943BA66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled beacon_ie_len, assoc_req_len, and assoc_resp_len
fields in ath6kl_wmi_connect_event_rx() are not validated against the
buffer length. Their sum (up to 765) can exceed the actual WMI event
data, causing out-of-bounds reads during IE parsing and state corruption
of wmi->is_wmm_enabled.

Add a check that the total IE length fits within the buffer.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/wmi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 72611a2ceb9d8..1cafbac2938fe 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -862,6 +862,14 @@ static int ath6kl_wmi_connect_event_rx(struct wmi *wmi, u8 *datap, int len,
 
 	ev = (struct wmi_connect_event *) datap;
 
+	if (len < sizeof(*ev) + ev->beacon_ie_len +
+	    ev->assoc_req_len + ev->assoc_resp_len) {
+		ath6kl_dbg(ATH6KL_DBG_WMI,
+			   "connect event: IE lengths %u+%u+%u exceed buffer %d\n",
+			   ev->beacon_ie_len, ev->assoc_req_len,
+			   ev->assoc_resp_len, len);
+		return -EINVAL;
+	}
 	if (vif->nw_type == AP_NETWORK) {
 		/* AP mode start/STA connected event */
 		struct net_device *dev = vif->ndev;
-- 
2.47.3


