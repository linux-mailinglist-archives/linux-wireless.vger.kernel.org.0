Return-Path: <linux-wireless+bounces-39013-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqRAHgrmVWpivAAAu9opvQ
	(envelope-from <linux-wireless+bounces-39013-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:32:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EE5751E51
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 09:32:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b="c9osQ/fI";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39013-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39013-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 662A53069EC6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 07:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692DC3F2118;
	Tue, 14 Jul 2026 07:26:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8693EF0DC
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 07:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784013960; cv=none; b=XlOymCJKTvifJLgkir3B5q2saoQxL/YRJh7hX5ZDZBPFlnJey5+Mb4Cg/u1OeFxsVCC1HK39KpPK3H2cDpxaxHEu5/fHoOIyl0+jx5+R9dwAigmHwM0aj51GAIyRBpJE+azLyquO2GiKyzd9nHogHhAcdMwQ2ImFaMIDEWiqAGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784013960; c=relaxed/simple;
	bh=4kWN8i5WG2aZ6TS5qt7L/NnlrW4kegRYjpjRROVGCKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pqBwouY+zv7RmnsG7mS71U2yR31JOXviS0bXjqX/CtGGqJ5aTG2dHNjgSJ9OBLVpCsKIlt+WUlNBpX+3zn+Q/q2l97h6B52xpVXa3gokJSOJVjyfhRFqthST5qEqKRxtfUTfWwEM0bC5P5djfksqXkogdLlunOOvZn1Cz6pGhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=c9osQ/fI reason="key not found in DNS"; arc=none smtp.client-ip=209.85.216.48
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-384422b05b5so540250a91.2
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1784013957; x=1784618757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SD2nFU6NCHKwpbdAwfHsil7BT76dH6vyRFobrrPfBSY=;
        b=c9osQ/fIodHK7W7SPwtf1xos6UIuQF5cnWS7SI7nsbmzqkxxcH7FKEkh88KOA5W21Z
         pPVltg2+iQKqg1G1ePjQC1CzvZp4n+/CWnz4NkOM9veOJV9VAa6yTJJKHrG+6qViICGX
         o8VsVj+AO08KGcUqlaatlnuX6hYQg2/uc98fAe2+w+dkhLV5DYdTiZ4jLpMpNzb60wMW
         2pARa4Ww0FhpXHyl4F5H48tqh+pb07TjJsSnabyGGdAqrYEGV8r7Xyf11JRGn/KSheas
         +TT7ow2sOD5pAQc2sqJyQ9w0KTcdRO2VBJR4aUjbyGMRLpoUbXR2TSAd4l3STQ8PUcbK
         e/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784013957; x=1784618757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SD2nFU6NCHKwpbdAwfHsil7BT76dH6vyRFobrrPfBSY=;
        b=bBjYoZt4JUGLQr/HBTlpB5hmjARt/N+Go0knKFeUsgTou4HOA2P8fhZzkuPOBULPEn
         M6WfxccomxZoBeKfp4xxcO1Tt7kQNWLDIw83kAEQL6MRdpS7WtWYSzDWS00lUrQDJwoo
         vPpjLmf9VeTSW4ELXlu1ylqlmhFwqYVFN7vREA+ABv+epRLUDbHNOjXgfXkWQnI2Jqzd
         vp0+Rh3LoTzMzpy2gsTc/eIiN1j8+S6N06ohP0c5ASqEQLctPacOcZZmHOoNfFNewryI
         X101aoZhQ/mFXpYJ867gXPIBnrUjxUZbtMzG7Ds0WPPg/tbRr/AuQpf1RX+UyaQ1uPeu
         imow==
X-Gm-Message-State: AOJu0YxV2UUskWBtrx+dN3+NWfnJ+UCyn/Ch8NHB5tUk7c7BmE8E8DKo
	mSPKWzFWVBpQ+yVXBJ1n2Jt9I7vRTQHHDtlrJkE/4juL62yaTE+w5uFiUz1zhGNt1iem5lAczww
	iKrR/
X-Gm-Gg: AfdE7cnRbkF03Kh2+BC30+xwR/RjNVobS/wna3PZDZ/EZkuWQ/ZzoYmNM5525pMpXeJ
	TDZQWsS/isPLu0I+NnDvqiPddknNMiTTWu2L9nEAv3/rBL/k+bxR6XjhJFn2PmxR3NlJWOFLXuZ
	+4E255CpP5OBtUeBCTYLzdChV4nQxDGACdEgCnJzAjgp5jjpiV9/I93xh7K4jnbO/9sdc1WkJXY
	Yk2U+1XLGWfgPdZguuZfLKkdlrHNhAzSR5NgGCs4veIn4rpBZVwCJGmaCe17DEd8uOUAG8FRKJv
	mQtUzzoe3WToL00TTUrfsbCn4NNe6zjAHDpFE3wj807FoJrYXhG8NCiFbJM6DmYe7PREHrHnS/Y
	pxI2HGhB6SGZnLVrNnzZFg3BPf1CGuEFq84UTJf6HXzIz412k3EbEKFiFWDRE9s7MxCozAkmdks
	c5NJ3c/ZCoYJ7GtRsP/pMwZufUOT++4rTqBspW
X-Received: by 2002:a17:90b:3890:b0:383:5a16:bd67 with SMTP id 98e67ed59e1d1-38dc7754e8amr9983631a91.4.1784013956874;
        Tue, 14 Jul 2026 00:25:56 -0700 (PDT)
Received: from localhost.localdomain ([60.243.50.177])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm45284701eec.7.2026.07.14.00.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:25:56 -0700 (PDT)
From: Srinivas Achary <srinivas@aerlync.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ramakrishnan@aerlync.com,
	Srinivas Achary <srinivas@aerlync.com>
Subject: [PATCH] cfg80211: use size_t for mesh_setup::ie_len
Date: Tue, 14 Jul 2026 12:55:38 +0530
Message-Id: <20260714072538.142642-1-srinivas@aerlync.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-39013-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ramakrishnan@aerlync.com,m:srinivas@aerlync.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[srinivas@aerlync.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srinivas@aerlync.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,aerlync.com:from_mime,aerlync.com:email,aerlync.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7EE5751E51

mesh_setup::ie_len is currently declared as u8, limiting the maximum
IE length to 255 bytes. Callers may provide larger IE buffers, causing
the length to be truncated and resulting in incomplete or incorrect
processing of mesh information elements.

Use size_t for ie_len to correctly represent the buffer size and align
the field with the kernel's convention for memory lengths.

Signed-off-by: Srinivas Achary <srinivas@aerlync.com>
Co-authored-by: Ramakrishnan Rathinasamy <ramakrishnan@aerlync.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8188ad200de5..ec715d10d98f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2803,7 +2803,7 @@ struct mesh_setup {
 	u8 path_metric;
 	u8 auth_id;
 	const u8 *ie;
-	u8 ie_len;
+	size_t ie_len;
 	bool is_authenticated;
 	bool is_secure;
 	bool user_mpm;
-- 
2.34.1


