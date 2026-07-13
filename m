Return-Path: <linux-wireless+bounces-38994-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id stQmFIVaVWoanQAAu9opvQ
	(envelope-from <linux-wireless+bounces-38994-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:37:09 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 952C274F4AD
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 23:37:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=eJdfJXem;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38994-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38994-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 910E330E65C6
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985535E937;
	Mon, 13 Jul 2026 21:32:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D22737E0
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 21:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978378; cv=none; b=DkmnmPVjJbdDLRwVFlohEoASYADxq3ldpPMD8XtjoJQmR8G89vJs3FZwbJK/6ljMt+e6PRh8FvMdLTsGYpoZZjlNxpRsg2aDnoOCrT1pLmdxljbOQTdK1CklR6OTjvJ7bLDihj6TPl7pV05L9FgYsKZy6RZiAFxHoqQdvHtw884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978378; c=relaxed/simple;
	bh=KPNRNFZEJ2UjwZa0agq4MDAlQLgIYnxwb+Izb8tPesk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pALvwMoY+WHq36P7qod3TQeIjWSHmEdNujMXboMyKeNLKGpY/2oKwApcVZRTedSFPLYfPInj77ZGbXvWW6NipY/TdRUHIjjCp6tNZdAYi+LWTQfEvp81VLvdx+CWB4lKgnvyfEqrp0V+Dz3S0RJhH8sh7NOidBxY888E3+RPlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=eJdfJXem; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493b77b150aso2689795e9.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783978375; x=1784583175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6rdaRIl05xXqbdOzxCjD1XxZpsLBKNtHk20piNYF/bM=;
        b=eJdfJXemqur2+0Qxv/hz86ypC/5EG3h/kqqYdFbL78/YQyiq65aglMOSDx/GWIV+z9
         GtNnROs5lLDY7ILbVCB47eedcrvVVYlQhinW+D42JULJiITszOIe3XYhOAVASaHN2YOg
         b35PQNXloY4ik8KMSqwS4jgw6HEZdoIdStw9WaOzPcFPC1yRop7A6MEcjPYp0F3IFw1S
         X6kZMI/cLjNA2hQQOKVmVw5Mq7FiJijGvZpm8+PVhfEWjtZNIlCBE6/XnGgF9gamoE2j
         m0vOImNdSyc75gjCUPD+E/2Vw7kmAiiJ7P/80dUGFlwnRBvyq7cHgDTAzQEFcS62QihA
         inlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978375; x=1784583175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rdaRIl05xXqbdOzxCjD1XxZpsLBKNtHk20piNYF/bM=;
        b=TY8tCdyYlWR3bNk0AuGkUa/Pz+AY0+WRPRNhxQFsWEEvnIpcpRsZpIJNEawgiU1OHq
         csxTnpoh/LE4qZFZd3mb7ywI94cCCOH6F0Kje0/7qa5Gb6p0x1Sb4cujY19dOYRvehlk
         yVomAX6T6pdn57OhyB8x4Vs8ayD88nn9LD2OtdYG4TwYyjZm+5g/8C/Ea8qgFTlQG4QR
         vXN2OHYn1wsQ0jobYaat3ndYJBnFW/pZXzEUaqzfLHRdgPUDn/fdqFH02DUvfQmmVzoY
         qYe8J56iEQO9Wxkz0JU10zHKYugAA97rC4wPurhW1WV4/NiedH+wImuWXzMDa06KUVaJ
         v9+A==
X-Forwarded-Encrypted: i=1; AHgh+RpFIguSzG7bOXPo6zNtDo9Hxxs3bbSrRXAi/41vc0Tc3f7cLIWZUSJCRm1lWJJopxH7PLsAvO98ggCS/6XwVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLFx2o0WTQf26YW3amehxTXeCMKRWkX3bpTNoX27VleUugToIH
	iQCt2Xmg1pqUfyMjsONNk0I8I0AmiTa740ROB8Y4ip5lful6UOoDE0o93HlHRXSPcmk1
X-Gm-Gg: AfdE7clQlZ9UbCVElqOx7m3U3/EWuKMFx3K01vNnVRadY9/nirTdgsS5rxdHxEaCaX5
	34WLICXDS2ktN64uHnZM18k0XP0Duon19hUYnKQkdi4fk2HIKn0u6Rg0PAjw6Om0338W7vJslW5
	ylPn8e5x5FxXgRAggjwn1lSnfh0mGoRXgHHYeu++OmSqTdg37fMtEuPjRCazW8wLqzKSWViSqPe
	hOprZl9zMl7iK3WNFP9XesxMILIR1HB1yD9LLLPeMhSvSRUB+++mW7baOMKsETJXrZw3fE6CGbs
	6z5QIeUX/Ll/3Gm3lx/bRFqiNXhSH9nI3lxyKteThMMb3z6IhCLIZvBzIxeaSYr7hCxn+L+zztP
	tgYNwlLhKaGtfaJEbSKHA/Q38FsIL3paDKFGosB/LBDnV7udSR1sDNG0hI/RCU6nEEoG5CwGIpI
	q8FRRaTez5+vce4WN/OoeyuZ7ASjJP62mZi8RvT8wxJrks/d4pqJ13z8vY37uLpij/MpI7P5txv
	PNNvEK3ouBTPwqWuXpaWtwDD7goGycYaU8=
X-Received: by 2002:a05:600c:3acf:b0:493:f176:dc69 with SMTP id 5b1f17b1804b1-493f884f5f2mr104527375e9.37.1783978375216;
        Mon, 13 Jul 2026 14:32:55 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508724786sm25938115e9.3.2026.07.13.14.32.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:32:54 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: ath6kl: clamp assoc request/response lengths before subtracting IE offsets
Date: Mon, 13 Jul 2026 23:32:51 +0200
Message-ID: <20260713213251.21161-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38994-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:peddolla.reddy@oss.qualcomm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0sec.ai:email,0sec.ai:dkim,0sec.ai:url,0sec.ai:from_mime,0sec.ai:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 952C274F4AD

ath6kl_cfg80211_connect_event() subtracts fixed IE offsets from
assoc_req_len (-= 4) and assoc_resp_len (-= 6), both u8, with no lower
bound. The aggregate check recently added to ath6kl_wmi_connect_event_rx()
bounds the declared lengths from above (their sum must fit the received
event), but an assoc request/response shorter than its fixed offset still
underflows here: the u8 wraps to ~250, and cfg80211_connect_result() /
cfg80211_roamed() then treat that wrapped value as the IE length and copy
that many bytes out of the small assoc_info buffer to user space via
nl80211, disclosing adjacent slab memory.

Clamp both lengths to their offsets before subtracting.

Found by 0sec (https://0sec.ai) using automated source analysis; the
missing lower bound is evident from source. Compile-tested.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index cc0f2c45fc3a..62f663c0daa2 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -754,6 +754,11 @@ void ath6kl_cfg80211_connect_event(struct ath6kl_vif *vif, u16 channel,
 	u8 *assoc_resp_ie = assoc_info + beacon_ie_len + assoc_req_len +
 	    assoc_resp_ie_offset;
 
+	if (assoc_req_len < assoc_req_ie_offset)
+		assoc_req_len = assoc_req_ie_offset;
+	if (assoc_resp_len < assoc_resp_ie_offset)
+		assoc_resp_len = assoc_resp_ie_offset;
+
 	assoc_req_len -= assoc_req_ie_offset;
 	assoc_resp_len -= assoc_resp_ie_offset;
 
-- 
2.43.0


