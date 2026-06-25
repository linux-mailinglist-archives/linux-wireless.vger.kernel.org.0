Return-Path: <linux-wireless+bounces-38165-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W31ENK1ePmrQEgkAu9opvQ
	(envelope-from <linux-wireless+bounces-38165-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:12:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EDA6CC4E5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 13:12:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Y8ofQI0j;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38165-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38165-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C4DF3026150
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 11:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D46D383C8F;
	Fri, 26 Jun 2026 11:12:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFD37CD40
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 11:12:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472329; cv=none; b=rZ2cq4eONVhTVA/CIoLQ5BZJ79bJ15oZLpCwjCkjs2fKloM63glKCi22isWuiFC4KXEqJku6SRP4ZIfTI9o8qXyOlG/Yu3hXmQxOBtl7eUAB1a8gXY47Tf0plOro4YKMa6Fvzc9GMtkUOELTNyUoypHa3HUzBE6ETCYbb902iy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472329; c=relaxed/simple;
	bh=+Msa4E+bz5dtBLHnYKgrFLPtkbZd5C0/STBltE5z0Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GF1ZuT4puSQUZl1zunbSQ1iKXGjvYbjUzPgJdoRFOtDwU1KgRugulV44MT1fJY3lB+R1KRVOah7bgThpa/b/KcGDnpPWVm8lm1JSzky/w3iwFYP82S9MxbTNAW9F2FyKs2OxibqTBnK5xk3dgQFMasYuGUkQkCZHbmQqvMCY9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8ofQI0j; arc=none smtp.client-ip=74.125.225.128
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-492367ed75cso142085e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 04:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782472325; x=1783077125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V6cKfkRrepHIUsrrBVwXQjNxoni88MPu9YukKZzg9ig=;
        b=Y8ofQI0j0OQ6W7NxJHexms/aDHe705eDVhSvZBgra69Hs9ux4l2WkgeRkNEHsKC0c4
         0o3EwzMDmuxuQtDDMW3rvAP4BmT01h1lI7ZiKyZWYsjmFfuoZuV+a6K5zadB1xgQgUOq
         lCc0+NlDYokK94W8SjNENm8IILBi5M7oHf1x8TIfnkMzmH86SXNphL7oMJyTN4ZsjiEw
         uTNN94uxICfDAMTupAzkScySnEp/lb3vsZtmCFK3fonqhxZxxsMuCIMasxOmsqaaO/L3
         tZ0ZSRl0JCYk4U+bzSog7hcWackRZgFiuzR64xSikBkErONwhNYcsG/401tydEZ29cLf
         36CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472325; x=1783077125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6cKfkRrepHIUsrrBVwXQjNxoni88MPu9YukKZzg9ig=;
        b=YY1S3bARkvjhRFN1c83QD+6p948Qe0zQ+K+Gzfx7ISl3vyTH1xL8XuzweP0wX5+C14
         bvvgE5cR9flt8/BNNGz0met2/LoVsSUcWTmp+mYZgnZu3avCEF1+v7QtetzFQXTYd1t7
         YC8QTIip+Bojlwk7ZFE4zt/SdWNnJjEjzfO0SC9oLgIfl/r1WgIWCn986KDmprn1Ckne
         uys2u8JJyrPQJ3NtspD2JCcOlJZU89HWRFXDpGpN5H6RLyxNMV8kXLWJxK5YIISyhcRF
         6zz6hn060dA1UPZgRDkJWu24BBIZJYkg2rN8UnZ3Hb1OShEbqnNyQ8Yz9N2lwlbgMcIV
         OhsQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NBOSMOmwFlWAqd3D7zOLLCpVJCxcVupQuoUM7NCJjhX9LNmpZkAR3UaCXi5eUevHO7qD317LqBPeP/dFHbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV8IQRD2JDnWTktXvn5+BAOeMWPMkZv4Vj4QqVdlbYvFwZ/N22
	KyKhmpbeK/AT6qrBLTQ/WgcYAixGn2WKH2MwsT53Y1Kb3oh6pXvgEERR
X-Gm-Gg: AfdE7clrt3shtJntnGxzyW2ggmGq5e2lPXZd+eQv23boNG1E1F/P13g4AxRNj5veie7
	c3bNy+/b9BrvyQ2Ltp/qgxKy69CQ9SEGxwS9yYPFoT/h9tLw3zfzQuheRlt924hljqD6hT5B/Ua
	8MtiAbr/YpgKOhYUDC6jyE+4IAeieRscKyT3D4/CJq0OaoEOp5LhBqAU6pfvVDAE+kpOJh/tzBe
	wPZQ39TxzkQb6KzLn7OaGQlmpr39l+OH9T8Y1ix7dRuH53KMaJH3qPok3YfdNieZ8vzgNAmLiS1
	gBMkOdrVaRE8GdKrF0v3jy+k1aqId+2AM80woOhMB9mFk9HREiir14XcmdfE07sDAs+SRvPlTjy
	awFULlAbtPGkaHGIbQOlrN6JmGd2gBsy8GL8I9uwNlTmHgR1uy1xoLtrHEodruXjbWjH0lXxDXp
	X6q/8sQ0gSkHU=
X-Received: by 2002:a05:600c:4e0b:b0:490:44eb:c1ea with SMTP id 5b1f17b1804b1-4926fc78e30mr4843235e9.24.1782472325018;
        Fri, 26 Jun 2026 04:12:05 -0700 (PDT)
Received: from fedora ([212.253.209.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c28673dsm43659175e9.2.2026.06.26.04.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:12:04 -0700 (PDT)
From: Serhat Kumral <serhatkumral1@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-kernel@vger.kernel.org,
	syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,
	Serhat Kumral <serhatkumral1@gmail.com>
Subject: [PATCH wireless] wifi: mac80211_hwsim: avoid division by zero in mac80211_hwsim_write_tsf()
Date: Fri, 26 Jun 2026 00:56:06 +0300
Message-ID: <20260625215606.11049-1-serhatkumral1@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38165-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:benjamin.berg@intel.com,m:miriam.rachel.korenblit@intel.com,m:linux-kernel@vger.kernel.org,m:syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,m:serhatkumral1@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[serhatkumral1@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,21629c14aa749636db9d];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39EDA6CC4E5

mac80211_hwsim_write_tsf() adjusts the timestamp of beacon, probe
response and S1G beacon frames by dividing a constant by the legacy
bitrate of the selected tx rate, e.g.:

	mgmt->u.probe_resp.timestamp =
		cpu_to_le64(sim_time + data->tsf_offset +
			    24 * 8 * 10 / bitrate);

bitrate is taken from ieee80211_get_tx_rate(), which indexes the band's
legacy bitrates[] table by control.rates[0].idx without checking the
HT/VHT/S1G MCS flags or the table bounds. For an MCS rate the idx is not
a legacy-rate index, so the returned rate can have a bitrate of 0. The
code only guarded against a NULL rate, not a zero bitrate, so the
division can divide by zero. As the call trace shows, this is reachable
from user space by injecting a frame on a monitor interface:

	divide error: 0000 [#1] SMP KASAN NOPTI
	RIP: 0010:mac80211_hwsim_write_tsf+0x3a3/0x590
	Call Trace:
	 mac80211_hwsim_tx_frame_no_nl+0x16b/0x1760
	 mac80211_hwsim_tx+0x1784/0x2500
	 ieee80211_tx_frags+0x3df/0x890
	 ieee80211_monitor_start_xmit+0xb33/0x1280
	 __dev_queue_xmit+0x1435/0x37f0
	 packet_sendmsg+0x3d95/0x5040

Fixing this in ieee80211_get_tx_rate() is not viable: callers such as
ath5k and adm8211 dereference its return value without a NULL check, so
making it return NULL for MCS rates would only move the crash elsewhere.
Keep the fix local and fall back to the existing default of 100 whenever
the reported bitrate is zero, in line with the existing "/* TODO: get
MCS */" note above.

Fixes: e75129031f1c ("wifi: mac80211_hwsim: move timestamp writing later in the datapath")
Reported-by: syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21629c14aa749636db9d
Signed-off-by: Serhat Kumral <serhatkumral1@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..c745395d2042 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1604,7 +1604,7 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 	spin_lock_bh(&data->tsf_offset_lock);
 
 	txrate = ieee80211_get_tx_rate(data->hw, info);
-	if (txrate)
+	if (txrate && txrate->bitrate)
 		bitrate = txrate->bitrate;
 
 	if (skb->len >= offsetofend(typeof(*mgmt), u.probe_resp.timestamp) &&
-- 
2.54.0


