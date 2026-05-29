Return-Path: <linux-wireless+bounces-37127-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM7tL6C2GWo8yggAu9opvQ
	(envelope-from <linux-wireless+bounces-37127-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 17:54:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063060518C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F3A63368907
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0803E5EFE;
	Fri, 29 May 2026 15:25:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BD73F9284
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068357; cv=none; b=fHLr78vSbjRcJtj6m2jevFyN9ZoeKN5kv9G9EdUXqNbaAvbB6wolFd95XSQg67KLRCQYnhkMa6XkNinELVCS9KtPoaw0bQubBCdYbtn29cXRaOM1Oudc7nKmb3B0hQJOvrl7xEb0XLku2I4vpbrXSxY+B9XOdPOl36Tpmz44xGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068357; c=relaxed/simple;
	bh=eoS/Jjh3klxPBRF7tD+pbHEqf2GCNeTKDOpOVclFZf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ianyjts2WqrsBoiLLPB36/2bte3hu3i4OLYgyN+24M08nIwLl0+SJVc+LXLdYE23B4iOXFLv8GT9Rd+46SfTlYEaJWrYMhKA2fBnvBXDymlZIFGXZ5i7f2SsXLV6lKU+LIXZ5RJRN50I3nQdXDf9+GIH9l/4SV8JcEGbhGS4oOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowABXdb_3rxlqj3k9AA--.24043S2;
	Fri, 29 May 2026 23:25:43 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_alokad@quicinc.com,
	yuantan098@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	xuyuqiabc@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v2 1/1] wifi: nl80211: reject oversized EMA RNR lists
Date: Fri, 29 May 2026 23:25:37 +0800
Message-ID: <20260529152542.1412734-1-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowABXdb_3rxlqj3k9AA--.24043S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18KFy3Xw13Ar4rWrWfZrb_yoW8XrWxpr
	Z5Gry8Kr93Krn7Jr48G3WrZryxJa1DGrsxuanYqFn3Z3ZrXr1rX34YgFZ8Xrn8Zw4xGFWY
	vFsrtF4DA3s8A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE-syl
	42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQACCWoZTE8GMwACsN
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	FREEMAIL_CC(0.00)[sipsolutions.net,quicinc.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-37127-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.854];
	R_DKIM_NA(0.00)[];
	DMARC_DNSFAIL(0.00)[lzu.edu.cn : query timed out];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:mid,lzu.edu.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5063060518C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yuqi Xu <xuyuqiabc@gmail.com>

nl80211_parse_rnr_elems() stores the parsed element count in a
u8-backed cfg80211_rnr_elems::cnt field and uses that count to size
the flexible array allocation.

Reject nested NL80211_ATTR_EMA_RNR_ELEMS input once the count reaches
255, before incrementing it again. This keeps the parser aligned with
the data structure it fills and matches the existing bound check used
by nl80211_parse_mbssid_elems().

Fixes: dbbb27e183b1 ("cfg80211: support RNR for EMA AP")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
Changes in v2:
- shorten the Fixes: commit hash
- align the From/Signed-off-by address
- v1 Link: https://lore.kernel.org/r/db614d22c4d3cdae0f5fb94b9d78c8e3142c2ecd.1779632165.git.xuyq21@lenovo.com

 net/wireless/nl80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..500eb84ff55a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6354,6 +6354,9 @@ nl80211_parse_rnr_elems(struct wiphy *wiphy, struct nlattr *attrs,
 		if (ret)
 			return ERR_PTR(ret);
 
+		if (num_elems >= 255)
+			return ERR_PTR(-EINVAL);
+
 		num_elems++;
 	}
 
-- 
2.54.0


