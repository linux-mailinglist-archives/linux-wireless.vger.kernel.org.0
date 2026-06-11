Return-Path: <linux-wireless+bounces-37678-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jiSWI3ngKmqXygMAu9opvQ
	(envelope-from <linux-wireless+bounces-37678-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:21:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA96736A9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 18:21:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DT6bqm+x;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37678-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37678-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F3B8310E562
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2026 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBF8429814;
	Thu, 11 Jun 2026 16:20:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DC428481
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 16:19:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194800; cv=none; b=N0uRFV9c3dAL+mjl4iSaO+bfdB37SgHKJ5xD+Xy249+iXWcCwavHD7/KAVVcMlVy77wp7AKpGHYFYOIXgkObOjq7vFMFbt8OthiuJZajfRU+wEB4pZpqGfeO+CnUdTGJK/y/iT65Avzt12ZLW/bOMlHjKVvCDShZcoeD4N2GlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194800; c=relaxed/simple;
	bh=kaG5qyz7UM2ji9838UuP3ncG1zNanDsJ30nAadWGaGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/dC0JPc5P3OQA8iokXV6iwzHF+iYjKctamEqvHwqkT6Hl5NdwWkLk7NZyYFLZNTknRXkZY0yNr/05UOxZ0ETB3336SHfGYVPdjXUDiTaPV1LGVeQ9FJ++ZU8s9REK/WsKoEnr9YEf2GDqdSsGSHKzJW3rAM8sNlTmla/3cbnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DT6bqm+x; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85b2139015so2877175a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jun 2026 09:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781194798; x=1781799598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozfYwTRjguWwldkipZcumrs2T+DMse6/l34PtGviF+8=;
        b=DT6bqm+xpm1DQ1SoXwSy4yFQ9QbVt1pKWrNGgUShln/5TWgWFaXgznC7Kys9BYoe57
         Xznbo1EHH15pPbIyVCobDzOm1E036J2+xR07gBJNUomR1nifX2FQLqc+dfUwvJGwimwV
         pAUVghNVPSiWvpZ2j+wvcC6jfaW756FtwNzoD26Rq49qdniKcgDljOCUEyEMTJA+k6zu
         r+77wEKnMcWgdpUPS2q61A4OPMHPy+Q3Cqu/DayycWcYQQlrmlQrMZHlw271+N9nZ1iX
         fRnSaqnulksSIkCJAlGGWjhSTI91SsUsVnX5PUoAzTZoVRSjt5v0ba9+fR1+gamGUmLf
         ALNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781194798; x=1781799598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozfYwTRjguWwldkipZcumrs2T+DMse6/l34PtGviF+8=;
        b=KJ4o8vDoUKHvzL2eWMIVzRa5twiLTVaXv1aHRw8Mb8Bnxq1XcbS897Es111ZWuoKmk
         nWexc/E7I4g+yK6Yq3JCyzG/nrk+5BZ5OBsm1ZDjNDdnUjFEpTaMnhKpdf8Bty76TKFx
         NdJI6AIryVV7zNklA2ku0O5K1I5nUBoutjHF3iNzTY3qECiRkmx31Q4HUdfC4CIUXq+F
         7HjptR/YTCjO1gHbQnX2fBFpIec7vhnsuM3V0ifbcX3aO01ziL+QOyrPE4p44K4TGIYW
         vlFF67x+sv//w+Y3DFI6h+Le2W+sZDT1xhF4R81MluO53WTYPyqX1TG8XY+KOblNTt98
         SbnQ==
X-Forwarded-Encrypted: i=1; AFNElJ8QLecbNNDy5n/Czb1EgM/Ip/AjAJhvOkd5MvXi2Nuk5V5cSyuR4dsJW0YMIFQJKHOb5M0ZlkIWRXWQoEmiHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDahoreKdxhGWAHDakzPdkn/tce5+ZqiQR8LffT2Qn+6Ca/4zp
	Sd+eWYz6Y5MGrB24wITb/MCLKCS96l4C63Xab5dUckDsF/bJbM3rYSjn
X-Gm-Gg: Acq92OFV1tD/rqgUCOitDLOVeU21EIPojGBOla48S355KZmyQvN7tqVrE5me8rBvm84
	x/c5WivSJRyOoK4ENGFQBnm7sX0pg6OQS51W0r7rWwuSDF2sfaCn2BzDtcgbnXZ0Dh/+CFN7Wg/
	MF0ioAeHxnEI3tSfuhGQSsPAwqC0R2k21O2bMlTOyrvflsAbFH0wxpgOdiTwjwHxW+CW6POIh7D
	4YRbQSuARy76D2aRQtbT4zIMUk9KzQwwZyQ9Xw/Quw1WUpUSQJ24U7mKl+9L8iDfWnJzgEZnS1u
	od2FaxFCsKjFz765fXET9y/0Vcu2UfG1xs4wMvnMjOZVervHQF/UrTcTXNpKFirbVO4OQn39+c2
	H27mDk1fhBKT28I/iZ04kwntUTU+8pKis557lnV8g19SEQba5XZHGbBTzZidfvqO5tC87+3vlzJ
	sUZxrrTHCPf3Rlvzk6WdXUvoyhUzFsdzpkopQ9f23AJQV7zdiTsJdAHicpYSWRU8E=
X-Received: by 2002:a05:6a20:da12:b0:39b:89e0:2e37 with SMTP id adf61e73a8af0-3b5e31d9e1dmr4203682637.14.1781194797751;
        Thu, 11 Jun 2026 09:19:57 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c865881640bsm2871231a12.26.2026.06.11.09.19.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 09:19:57 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Thomas Pedersen <thomas@adapt-ip.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] wifi: cfg80211: derive S1G beacon TSF from S1G fields
Date: Fri, 12 Jun 2026 00:19:46 +0800
Message-ID: <20260611161943.91069-6-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260611161943.91069-4-enderaoelyther@gmail.com>
References: <20260610162700.58722-1-enderaoelyther@gmail.com>
 <20260611161943.91069-4-enderaoelyther@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[adapt-ip.com,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-37678-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:thomas@adapt-ip.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07DA96736A9

cfg80211_inform_bss_frame_data() parses S1G beacons with the extension
frame layout, but still reads the TSF from the regular probe response
layout after the S1G branch. For S1G beacons that reads bytes at the
regular management-frame timestamp offset instead of the S1G timestamp.

Use the 32-bit S1G beacon timestamp and the S1G Beacon Compatibility
element's TSF completion field when informing an S1G BSS. Keep the
regular management-frame timestamp read in the non-S1G branch.

Fixes: 9eaffe5078ca ("cfg80211: convert S1G beacon to scan results")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 27a56ee2e8f0b..c90619eeb03b1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3309,14 +3309,15 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 		bssid = ext->u.s1g_beacon.sa;
 		capability = le16_to_cpu(compat->compat_info);
 		beacon_interval = le16_to_cpu(compat->beacon_int);
+		tsf = le32_to_cpu(ext->u.s1g_beacon.timestamp);
+		tsf |= (u64)le32_to_cpu(compat->tsf_completion) << 32;
 	} else {
 		bssid = mgmt->bssid;
 		beacon_interval = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
 		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
+		tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
 	}
 
-	tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-
 	if (ieee80211_is_probe_resp(mgmt->frame_control))
 		ftype = CFG80211_BSS_FTYPE_PRESP;
 	else if (ext)
-- 
2.50.1 (Apple Git-155)


