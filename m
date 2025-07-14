Return-Path: <linux-wireless+bounces-25363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90AB03C92
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 12:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8803E4A39B6
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jul 2025 10:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E50244661;
	Mon, 14 Jul 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="fLWGM95e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D42123BCE4;
	Mon, 14 Jul 2025 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490102; cv=none; b=LyQX+xOHHQbOZXknqtXZehJkgsBXZ9NG7y8VJ61yo2x6bCwa3HXSRB8XkEjkCJFd2+N+rLjbA4eBh2eU1ybeFXlxfv+Zs3grb674pvNPA7lclwNVBFsBKAuq30Q27lLUle+MEbBjl9zkXP5+AJTPb1Re0/jEHCWr2+EUIR8rHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490102; c=relaxed/simple;
	bh=vP9KS8BNtkL+r+ODWX5Dv2xeVuCY2ymlJk530KVg0q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpesnkED1wDIV87najVclRqv7/udA++uXATTukE7kmmxugxn0fzoSTPx4CuO0ehkH5risu5VSX24UhueXqA2BB2mEAnaLMexAz0/vs8YGUvgDwjczi4WDcGPxJz070WGqfx5rtOoF+VRpaw6WMoDKqylD0SGQyCfAIgxbnAbXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=fLWGM95e; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752490076;
	bh=HpGiIdxwg9yS1exBVWx2/uB6CA/U7kb63u0dzmjCK+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fLWGM95egSgQFDsPp1jIzc39IEHnMqqD09NGOZwMTTLqIslcX8dloXBfshMztm2eu
	 nEkN781sD3b5vkmLLj1K9wME4/eDrAp8ukJ3vhoZhaptBnGYOU2vtetwVYp5Fm+Ie2
	 tsbE/76uFwYTeMOo88M0zIKJiD9hMZymISadKPK8=
X-QQ-mid: zesmtpip2t1752490063t46e9caab
X-QQ-Originating-IP: tRRsYT7yvqairO4FFcGK8ZYzpgilDETd1Ipnmj+TRj8=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Jul 2025 18:47:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17520348017662493875
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: miriam.rachel.korenblit@intel.com,
	wangyuli@uniontech.com,
	johannes.berg@intel.com,
	akpm@linux-foundation.org
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	emmanuel.grumbach@intel.com,
	yanzhen@vivo.com,
	shenlichuan@vivo.com,
	yujiaoliang@vivo.com,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: [PATCH] wifi: iwlwifi: Fix typo "ransport"
Date: Mon, 14 Jul 2025 18:47:36 +0800
Message-ID: <03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MQGDQD2ndzR1JkOK1EAQXMsXh9G6qyoj9DNFll9zD31yHl6lGCePM9gz
	Mr+cQbQLfRqGHzqa3aq68eiDQMRfULroo9rtzz1XKw0J8K7lGqdPkbKGu88pItSuRGvh8XN
	0OtJHN4vuJ1Khi0YOwcSuZj6gJm8q1b5xOA7zW/74LkSSQbE6AgEvh4TQ78y7NNNBP6VNqK
	snLG7sKXdyF0JlIJMkAY6t9YXehL2mr4fo5pydp7YcJLcsAGlOVw14pCxR/JI4fnhD2do4/
	2HCZ5qKHAArMXkqwV3NMeZ4j1/UHA4OAPmZS68cMlsnzAb4WmS6lftvswrJShS4uhuJGw4d
	cnwryqnfgnza/eW87DUpbtgcuuUipY0Jq/w7kVhckbu5ZQMKjNy3CIb7zf+RZoVzVHyQBRs
	CON0PM33cwYppwECWPfHFY1yZ5SXwDZVsMMJNT6dFOC9kPwIAahuEYEFVICty40hI3Ne3OQ
	q8NX+MnTCHUXidv6k9LRD8DEXTr/hRLVKhQwBmZ+KpMJ4v+8iV6OeX7Phac7m2fELzyKcIY
	JPQBfcqhyGbiwk05j8yYIJgyEyhXKEKbbESawEF3PPYr3lZ/D991icIBYUywaxcUCKbQe1z
	PzI/1+s7y5nfxx9cG3ejFxOnLWEJ87OG1jVNYsuZ1J9/XO+lfImwLUsNLEbrA4d4darC9Yy
	0l40MjixaDqjLv3uo7uMZZB7gx7bULiCWK6n+NInFkQ6lT9PjZ+Q6ZYwhUMSzfK+4rCwrla
	vWOlq0Ta/TaXwc4UkKjSZoVxJecaLtutm5ouRcwwa8gugLweHvlwGSFzLMpjspT2bX+Inu8
	GSnamguyy2InbRMIVbq/O4Wwgc+e7z/cCyjf6w9IwjsE5o15115t2YUPqfPPwMRFEuRPqbr
	ks7h0sFipKVhTYU6xPP4GjuwGYvH86l1ko14qiQ7XJ0PTpyCYL4z0rdLLq5IM6Bl2klrszQ
	jK0/liCHEX+kb4EOJG6cP1n7sSyIldqcxGkMSquPqRiOo8NpXOeWd4hUVBGpfEHJ4jU1kaw
	v6bb1UCP9npC3oW/hT1KD0RSsY1cs0RONp1IwGc/yGdnutwjTe
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'ransport' in comments which
should be 'transport'.

This typo was not listed in scripts/spelling.txt, thus it was more
difficult to detect. Add it for convenience.

Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h | 2 +-
 scripts/spelling.txt                         | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
index 1ebc7effcc2a..061c69286951 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
@@ -388,7 +388,7 @@ static inline void iwl_dvm_set_pmi(struct iwl_priv *priv, bool state)
 /**
  * iwl_parse_eeprom_data - parse EEPROM data and return values
  *
- * @trans: ransport we're parsing for, for debug only
+ * @trans: transport we're parsing for, for debug only
  * @cfg: device configuration for parsing and overrides
  * @eeprom: the EEPROM data
  * @eeprom_size: length of the EEPROM data
diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index c33128db7163..c9a6df5be281 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -1314,6 +1314,7 @@ quering||querying
 querrying||querying
 queus||queues
 randomally||randomly
+ransport||transport
 raoming||roaming
 readyness||readiness
 reasearcher||researcher
-- 
2.50.0


