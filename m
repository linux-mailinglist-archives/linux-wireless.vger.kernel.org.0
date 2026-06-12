Return-Path: <linux-wireless+bounces-37741-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dcE6NicMLGpSKQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37741-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:39:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C920679E8E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UiPAjgZh;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37741-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37741-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7328731AB70D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58FA3D5673;
	Fri, 12 Jun 2026 13:37:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37F43E5A24
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:37:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271431; cv=none; b=l9yTPJKXlK5WT1CsUmu7p3IrRzXLIpTeTmZp3p9tWMJfZbLAAKZzfZyoqSbiJAFNBpTZRqO89ggA2dcdJvGFXJ1ukAjhXbxqd3tAsPrF3H5DQ0sCxXAXF54a0UJEFt40+Jip4uGmiQ5kAnfSGTGWUijKyvT2+irhA8yFyzvNtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271431; c=relaxed/simple;
	bh=SgUY1nW+3aXyUug+WjSvufMDS6a/nSEqIgo5cdAu7aY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5vnXXUYlB7ethoI3HfELgj6fAIShz3LefClEL+JEkjIlvh6HzJDoZdXESzu5cQAnAsD9T7mc+BNvrEWV4k4iITaOTGvTGIGOQddBDPW2as+0Vvy9B7S33E4r6aeUAjvYfBhFO1Jixi/n2I0iMyudKmVHxo6niYKLsKt6DD/BHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiPAjgZh; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858b392697so452895a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781271430; x=1781876230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5MRU2t7e8A/ZVblByuIRmE1vztrNoX56qrc24aQwS7E=;
        b=UiPAjgZhfSPlIOD8SOUu4gOPjnwHk5ER6MIAgOhXi7lASYQaNwlzSE0PPwfg0Wh5xe
         IWVsos27zbzHAdXfPUIqN42ja0zpFAq2Dvh7eufC3UtmP7afkrrC05BTWMStQ1b2Is1I
         QFoyQuN6QQaopaP9chKsLeFLEmP12zJ+KuGs1Im2UFHUjTWPYzRzexEFeQ507lDHTCF8
         rBmdLGuRD0RaGNSSv3oMydgk/g4mYfGwwiqXAKTto7OzqY3WuUh4LHAyhT3NDAEaG8Hm
         LDWDKDQ8CH+oNXGR94pj7ImPT9kjo5BbY53OnjGuQCIDE2J4sN6jEQL7GzCroWEC9MQ3
         /Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271430; x=1781876230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MRU2t7e8A/ZVblByuIRmE1vztrNoX56qrc24aQwS7E=;
        b=sinWxgoe/ko2VG3GczKM2TPstRFG5jt82ek/MRfhWJdVC9rEiG4NAVQSIuqpJ83tS5
         xBz1hWOtvzGZ7h9YeeTdxvXmMxi3PgXyP2TZtom20TXM2j221hCJ6wVXfHckNZ9vXvQs
         u7UNNz79E6RPGJPbOywhfViIGN6YAi8M1p2l69yOA+5s618u4I0B7RY5F1m1j/svbChe
         In83gXeW+ezxlDuW3HZtlcF1l6o5otmwfhVePW8CVpSSpmzz50xYar5W0oCm+u46EMvW
         PyB2HGA1038mv3JSgAvLVv7Cu84wmvHNF7fEFZeSekm6mLudX7GoNVxhPMN7Pm8S7Wry
         JL6w==
X-Gm-Message-State: AOJu0YyjM6fsZpiuzmYzR6m8A6HnEQ16SMySZlUKEKuTBSCKVn1nizsT
	COqtnOrPqRkcUlDiWu6ZemaFBnbnHBm3F5fIxtaPUI0Ywpb4MDahzvqK
X-Gm-Gg: Acq92OFHGwD3i9r/9k7tmwrDxSMtFL4UR4cX8lPZh3TXIyBrWmLOkz/CHcpP1uuzz59
	haHp97XgR69P7ZDUvkAgbZZ7ye/Pgkb8tUs90YdSGcPbHauSh/y0XNTiCQMpPd9RvuXSv+UmbCb
	eotJs3yS+NOEq7okKit7/vXuA4YIBPcerRUPQg2SLxFQR4qs9VfnktMpyLTQuj6Q2fLcLOJBEwy
	uLCdXCGrkqKyaEQ8rulh7vX8RikfD/feZKffLtMSxFpey/gbhgbhrVhiKOe0mFv2HG3Er56yEx8
	Uoxh8B5CRAV86WkprddyPcGvmoKwz2XxCy8hXaz+7M0Gnbm+JVUmodIaVGA17zour9bcKSdg3FU
	kQ3DPXJSK3Ppkc/0QuhTie8gFrVaVP5CZUzJ6j282V8B6qaDe/LHeiIoMM4jDHdYDfB3ogmL4dF
	gjyThyaBrc6hzWdgMsHwRZXsXHepqolU4xC9ycjzJiyBFETSdtfTGxQD3fE5/3vrA=
X-Received: by 2002:a05:6a00:f93:b0:842:46a6:e2cf with SMTP id d2e1a72fcca58-8434ce46552mr3364400b3a.21.1781271430089;
        Fri, 12 Jun 2026 06:37:10 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afd100esm3008932b3a.34.2026.06.12.06.37.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 06:37:09 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: validate PMSR FTM preamble range
Date: Fri, 12 Jun 2026 21:37:04 +0800
Message-ID: <20260612133703.93274-2-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37741-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C920679E8E

PMSR FTM request parsing accepts preamble values outside the
enumerated nl80211 preamble range.

Reject out-of-range values before using them in the parser capability
bit test, and also update the nested preamble policy declaration to
match the same enum range.

Fixes: 9bb7e0f24e7e7 ("cfg80211: add peer measurement with FTM initiator API")
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/nl80211.c | 4 +++-
 net/wireless/pmsr.c    | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 76c537a6e8b52..52a805ee2049d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -461,7 +461,9 @@ nl80211_ftm_responder_policy[NL80211_FTM_RESP_ATTR_MAX + 1] = {
 static const struct nla_policy
 nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_ASAP] = { .type = NLA_FLAG },
-	[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE] =
+		NLA_POLICY_RANGE(NLA_U32, NL80211_PREAMBLE_LEGACY,
+				 NL80211_PREAMBLE_HE),
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_BURSTS_EXP] =
 		NLA_POLICY_MAX(NLA_U8, 15),
 	[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD] = { .type = NLA_U16 },
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d6cd0de64d1f8..7724ed0aa28ee 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -29,6 +29,13 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE])
 		preamble = nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE]);
 
+	if (preamble > NL80211_PREAMBLE_HE) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
+				    "FTM: invalid preamble");
+		return -EINVAL;
+	}
+
 	/* set up values - struct is 0-initialized */
 	out->ftm.requested = true;
 
-- 
2.50.1 (Apple Git-155)

