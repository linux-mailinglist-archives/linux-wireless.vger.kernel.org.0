Return-Path: <linux-wireless+bounces-38802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1ykaBMqsTmrdSAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:02:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7597572A0F9
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Jul 2026 22:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gz01sERd;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38802-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38802-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55B65305F5BE
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2026 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B73DEAD8;
	Wed,  8 Jul 2026 20:00:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B133E1226
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jul 2026 19:59:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540800; cv=none; b=B6r9oizk1UFV0yufZqcyekoQKHWU68K6v3PS37qumSqdyrZeLq708p/qzE4Xhs9UlsmYQXBuDcLAEfRf1OoBeT2A/2jIWQZL0ryPxmz8bkfqJv+nqM3nayI2cyapkcxDfk3dg5gJ7/kx2TrXIS4CT+JCYxZxGROxidVlfoGEEuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540800; c=relaxed/simple;
	bh=w/vwlMcntnTxyo/2UhLb95oSOKKha6FuDCeNrxA7k88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfGdAzGJx8ZhShHs0fnZklBbeyKathWV6U8PsBDoGFe+cK2pGEKSi4/2csd/hPTunZQOYtXi0+vWa6nTwyYK0fO+LrfFsLKxTiuciFO7OVX07I53AxGGzXtpTqKMYoZjeNOxQjBEUYI8SxKpbI0BPBF9ECTHXvYqdTN8+i9pTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gz01sERd; arc=none smtp.client-ip=209.85.215.171
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so820554a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 08 Jul 2026 12:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540799; x=1784145599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXKQxSD6UbvExaibIKrfBf8rLHetRRlZMcfn3lvIQPw=;
        b=gz01sERdS54Zn+LDyZ7MToEH2eMMI5CxivKkPhxHNM5CU6XE7tnY2lKZPhChuCnyLl
         l93UZl72CVGg1aR4JyrdGKpSNRWndfxGHJ+jgrRGYsnya6LRjkNvcfEsWEJUkAeAODfc
         /e8UXRSqMnKVSyVD2+R8ugbBqJvCY3yrVE2M5rEa690Ik2tqdH3yhVUv685vnQyKRkrp
         pKiW/RCZfZLTMEavloYlkFIFjX/hum7WreRS+zEZpAHeU+ei6qAl2TaTa1XDIJ/Yji/G
         SeK7jfYUMObgkLQrA9NGIWtuV00usK4KhR2xAVCZYeY8weLweKQOFNjdqjoF8J2e9gzJ
         wYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540799; x=1784145599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXKQxSD6UbvExaibIKrfBf8rLHetRRlZMcfn3lvIQPw=;
        b=H+ql4aK1MFf6UWYEVRGn+T9LgsOYsCpok2WGasEywIDar8o6LjCbILpV8lMQAsZF7c
         MxJvq4xlRmcCqmp5K/ymJ1fHZnkWluPaxQnpj22BjYWY+mX2/sA55LrtHiBhc2RRDBNG
         2j7+fLiHgEFQcPC8n7cWpPQjz61WSYm3673rmP/tScgSe1qHsDpua/447ysfDibogNhQ
         qfQ88B5m2tyePAkYXa3SxW5INdg+KCpBctyBo5EdEYKrC/aCATLHx2NcC1B16pOXJ4Qm
         CefUzx4j4XcTeKXVfSZwu/5kd+d0A40ZSQQ7ps2i+8pWM1KM635HoRHXcQUvQfRx5FZr
         /veQ==
X-Gm-Message-State: AOJu0YzQ022SSmNmAojShZn/Dx4itehsAm1FIgRtmCVxCRsYV0lxlAHg
	dAGv1lYlcZiLT/Qur+Yi92nv6yRBmh0nEZYWvmAtZDnCh/2KMprCzRfqeHWljDL2oy6EBw==
X-Gm-Gg: AfdE7cmtiBO9AcZ9Sf6JrWJ/xZ/RRZjdJ6D14BR+o1swts1SzObvnUaqHFviKHXPzdm
	ldLiuNNSqPeuZAE44Dm90F1JohLLji7lavFznWQPzAMIfLSm1NBIQHivdnNxgQ7muE4YRILBhLg
	0rVeja/2mKfPbezRpuuEvI2tecFuXHdjDHyb9N8qSw9SgqheOfCryFxpwGXlwHQHBadS5NsnnHh
	Cs1j59zFkXt/7jCR/vUL29HLbj/SVNqDdGZlKf1omCjLw1UaWfg2ktRHxADGVQjxQbKO0gpfwEk
	TMiur6OM5AG7gzyj7qJXC4Ug5RXVpW1p4aDK5T+OMmxBN+vcfwayX4WhNke+lcbRrU891bJ28hf
	NTQy/nRUmznOWO5HmAxre3rSLa2uSrXtNS7xssJQZL++nBqx880URDdWaDl2Jk03HCkVTxebv4Z
	I9raWtHGCPiSNxkBffAA09mEAGN9PSNBtmtRsbB0JdqiIKs1F3aFWr
X-Received: by 2002:a05:6a21:4902:b0:3b4:8717:1c21 with SMTP id adf61e73a8af0-3c0bcbcadf5mr4956916637.35.1783540798746;
        Wed, 08 Jul 2026 12:59:58 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a8f521sm22585395eec.22.2026.07.08.12.59.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 12:59:58 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jaewan Kim <jaewan@google.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	John Crispin <john@phrozen.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>,
	"John W. Linville" <linville@tuxdriver.com>,
	Aloka Dixit <quic_alokad@quicinc.com>,
	Zhao Li <enderaoelyther@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/8] wifi: cfg80211: guard optional PMSR nominal time
Date: Thu,  9 Jul 2026 03:59:07 +0800
Message-ID: <20260708195911.84365-5-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708195911.84365-1-enderaoelyther@gmail.com>
References: <20260708195911.84365-1-enderaoelyther@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,chromium.org,dolcini.it,sipsolutions.net,google.com,oss.qualcomm.com,kernel.org,phrozen.org,marvell.com,tuxdriver.com,quicinc.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-38802-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,m:briannorris@chromium.org,m:francesco@dolcini.it,m:johannes@sipsolutions.net,m:jaewan@google.com,m:daniel.gabay@intel.com,m:emmanuel.grumbach@intel.com,m:benjamin.berg@intel.com,m:pagadala.yesu.anjaneyulu@intel.com,m:peddolla.reddy@oss.qualcomm.com,m:lorenzo@kernel.org,m:john@phrozen.org,m:patila@marvell.com,m:cluo@marvell.com,m:linville@tuxdriver.com,m:quic_alokad@quicinc.com,m:enderaoelyther@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enderaoelyther@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7597572A0F9

pmsr_parse_ftm() rejects a request that omits NOMINAL_TIME only for
non-trigger-based PD ranging. It then reads the attribute
unconditionally for every non-trigger-based request:

	out->ftm.nominal_time =
		nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);

For the other non-trigger-based request types NOMINAL_TIME is optional,
so tb[...] can be NULL and nla_get_u32() dereferences a NULL pointer.

Keep the requirement for PD ranging and read the nominal-time value only
when the attribute is present.

Fixes: 8823a9b0e7af ("wifi: cfg80211: add NTB continuous ranging and FTM request type support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Assisted-by: Claude:opus-4.8
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
 net/wireless/pmsr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 34c3625f7fd5e..d1e2fae5bc0e5 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -263,8 +263,9 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 				       "FTM: nominal time is required for PD NTB ranging");
 			return -EINVAL;
 		}
-		out->ftm.nominal_time =
-			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME])
+			out->ftm.nominal_time =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
 
 		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
 			out->ftm.min_time_between_measurements =
-- 
2.50.1 (Apple Git-155)

