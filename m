Return-Path: <linux-wireless+bounces-37728-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1r+THlUHLGqcJwQAu9opvQ
	(envelope-from <linux-wireless+bounces-37728-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:19:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D906679B55
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:19:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WFYrT2JM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37728-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37728-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B20D30072AC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5DF3ED5A3;
	Fri, 12 Jun 2026 13:19:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE43EA96F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:19:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270350; cv=none; b=B3ky8Z3oATl9MRBkY4/T6GP5vQ9ltC06QSSHf0oicVAQKi9gn2nxsEqXtKjXzOSf0cAq2AEMFqb9Y8+wPbb8pGf/WocqCe/OVRuooTj+r4UmCKLeZuHenr8zOo4bTMXKx1RhAnZgGPverXp7hPiw1eM7k5GaYE19lTC8v5o6SY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270350; c=relaxed/simple;
	bh=oGoSUFfif90q7DkZoYyZmqUn6TWLUl3L+2MdI46yqsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OUNYkkB3A/OHst16EqwYnvXL05uc0fsFW1/rkmbT9eWaQZFqeDBwwN6ANR60yIlLNcpzNKCD5DRoi/1XziovxsWmyhlVxxbBcW0f8Xa/fTZ5aeypyVU802/NohyByxp6rBY2CGeX2yAmbjGD13x24lWWUw9edQh2HbW+2zhiPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFYrT2JM; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so7819205ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270347; x=1781875147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkJAXvyohCTz1p33+XEZmGxqsgzBNIZQw6o9Xn+aAuo=;
        b=WFYrT2JMq5JPWyX5HwK6GSDZ5b/yr8DVoCh+ZiVbr6vN1SVCTrUhQBIjOLxMUBZ3Lb
         LBko5+ilXtWB37b/aQ3XYD0CGOwmUcmO2eaOVpELmVO6s89FAcuWJo/zFrIxlkmIQeRS
         EAsFZJJIULrTaPPSEdGJQvtzh6z+TXE+yzB4K1UGEK+lG7AMJGgy32q0x5sGJv6PgWJH
         2n6zEz+SuEVCgjhrhCxPFwFltpdlAcMX3B2QgkmwidZagzHFIO0TA0x/I4ZwQdkphbkt
         QfNOG9ExCr9iKkV2ztjQC5WfC+ptTg2ClnsZ0noiPZko+y/bOkyPAX1EY3wd0IZcEXNu
         rwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270347; x=1781875147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SkJAXvyohCTz1p33+XEZmGxqsgzBNIZQw6o9Xn+aAuo=;
        b=j4fSZrzjcvz1usIhbNHA59uwCGXcEE5avMNwdxug88rdoet4Gowruv2S/n2gnqweUJ
         NMbOxamjn0RCdLEfgiqQ3dUXRo/DQazfV3Etq7oskl7434KGpQW2uouZcY6i74mnflF8
         D2B0axhBfOaUhl7hvJ8eLHaOTti0+diQMt8uVPKA1IuXufnsmrcY9k5RDL+LhqAR0+Fe
         d5r/FOfuAZwdDjJV3w5x4rfQDROf5NHjrEAswkTVB/23G9pLGzYYdDhulzw8lzT41oDg
         OkhOzAxCxwqysJ3GO1I21fSsEpRYiZ3XkhSB9rNnL7CDeB8VnoGjNbZK9x3pz+9/cjYb
         B3FQ==
X-Gm-Message-State: AOJu0YxsSZ2KqZ3wFKPfmZttRkrcTjD0fEbiJSTxA7ESWvovT0jS1Erl
	sqvzWNNojTjNRT5+mTw1mTIYUwilRUliv6J2A8FFm8e91hkQdnt4OzoySd68/hauQrIKxw==
X-Gm-Gg: Acq92OFnBZxKv/afCXoBYTuqnxs46zzELJQWwuaA9YbkGENR8SIPd7gmYD8R/E1II+9
	pzUluvkgPzGqoQt6Mafae6C9yWv4isYLsl9LK1hjLOLsnlUpW4dTn8IB0NMd7WHfJhnAH1t/aan
	hAmuO++ndnEsovyphM+24+E2MrCL+WfTqfkKlU1M74tBzsDtKc7u1E9qVqXKjGRMRTT3h4qVHM4
	CZcBWxrgOca1eDPdPw5TmueawD6M3RDXxZBLrSMGNuxKjwEdLZaV3EWhxZRdRtLmXydLLbehSrF
	soEqI5lEk+Rr94MsCugP3xAPUCIphHa5hiAENjc05d6k95rWR+MXCNXPa+XUQsUbKVy3mspCYJW
	SSKn1xYX19TGTe4azKeYjNFkkPJB8o99E4y7eZ4CPt8j16V9J9v3CctvwmueURXf9Wv4AaUe5FH
	JJ/zuIWiTKfK+1KfaOfT5tm1yOT9xW+sZc59EVSPfprstdS/mwb+4dGHX/ZEi5JdI=
X-Received: by 2002:a17:903:2984:b0:2c1:88a1:9830 with SMTP id d9443c01a7336-2c41255a929mr34543415ad.17.1781270346952;
        Fri, 12 Jun 2026 06:19:06 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c43345e604sm19923585ad.74.2026.06.12.06.19.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:19:06 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	John Crispin <john@phrozen.org>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Aloka Dixit <aloka.dixit@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wifi: nl80211: constrain MBSSID TX link ID range
Date: Fri, 12 Jun 2026 21:18:56 +0800
Message-ID: <20260612131854.43575-4-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612131854.43575-3-enderaoelyther@gmail.com>
References: <20260612131854.43575-3-enderaoelyther@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37728-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:john@phrozen.org,m:quic_alokad@quicinc.com,m:aloka.dixit@oss.qualcomm.com,m:muna.sinada@oss.qualcomm.com,m:rameshkumar.sundaram@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7D906679B55

MBSSID transmitted-profile link IDs are valid only in the range
0..IEEE80211_MLD_MAX_NUM_LINKS - 1. Constrain the nl80211 policy to
reject out-of-range values during attribute validation.

Fixes: 37523c3c47b3 ("wifi: nl80211: add link id of transmitted profile for MLO MBSSID")
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2baf1bef0bbd2..9344247386656 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -616,7 +616,7 @@ nl80211_mbssid_config_policy[NL80211_MBSSID_CONFIG_ATTR_MAX + 1] = {
 	[NL80211_MBSSID_CONFIG_ATTR_TX_IFINDEX] = { .type = NLA_U32 },
 	[NL80211_MBSSID_CONFIG_ATTR_EMA] = { .type = NLA_FLAG },
 	[NL80211_MBSSID_CONFIG_ATTR_TX_LINK_ID] =
-		NLA_POLICY_MAX(NLA_U8, IEEE80211_MLD_MAX_NUM_LINKS),
+		NLA_POLICY_RANGE(NLA_U8, 0, IEEE80211_MLD_MAX_NUM_LINKS - 1),
 };
 
 static const struct nla_policy
-- 
2.50.1 (Apple Git-155)

