Return-Path: <linux-wireless+bounces-25442-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E6EB05160
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 07:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31ABC3AFC80
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jul 2025 05:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791092D29CA;
	Tue, 15 Jul 2025 05:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="VXW1Eih2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2A25C81F;
	Tue, 15 Jul 2025 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752559165; cv=none; b=i3rO+L0cRb8zLIRpxORWRC/Dw0YDQfY/+z/nXaMRpv//DXnua2lfp3pCf72GpdG0Nue+PlWR8Czw8rmkPVtm5vvN/YYsLv+SbMexivsZPvOU4INVj7Ze3X/Y7x+6b6mCyobalc2scwNoZi39zylI7xqrYiwGcFmAVC+aQnkRFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752559165; c=relaxed/simple;
	bh=0U65jY1JSweZeonjbw53MB956XveJQ4ZWSFbUUDJ5Y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1HMPgi5OxoChPwnlvnL5o9WBtmXLcoLrWHyQPfTKUQU3EiB9LD2v6VwTXkRaWJCveoGu0yKT5s5BJEggTFnnHgqCczZmvXmOKuj3QevpZKnbVTb8Bhk//9KLPh+m8w0PqQMBQw4rXwKOYd1GFoo1GS20pXLizxDXXNC5AKi3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=VXW1Eih2; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1752559130;
	bh=jelvRAB9ICUj9aQsz028m+IpsJ9lty8ne5yvm7AhAyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VXW1Eih2ZZfVQbZeZ67Acc8stG+RTT/nruM7wsJ1MEiHdc+/Ybcv0bVrX3SDCkULF
	 lThRaj5Z21DnbDohne30fsLUwmTxd0Ooj+d05lxlj/IAcmJcobrN9PPvhFE0a35w4h
	 dN0yfqlrQxRpwjwPSQsbbZ9iIYQIwvoHD/y5NBmY=
X-QQ-mid: zesmtpip2t1752559119tb009464f
X-QQ-Originating-IP: NntTmx6BlALLFfmLjbcpQ9CFOZTDRFLWwsmaPBOtvm0=
Received: from avenger-e500 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 15 Jul 2025 13:58:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18388915070200021082
EX-QQ-RecipientCnt: 15
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com
Cc: akpm@linux-foundation.org,
	colin.i.king@gmail.com,
	cvam0000@gmail.com,
	emmanuel.grumbach@intel.com,
	guanwentao@uniontech.com,
	johannes.berg@intel.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	miriam.rachel.korenblit@intel.com,
	niecheng1@uniontech.com,
	shenlichuan@vivo.com,
	yanzhen@vivo.com,
	yujiaoliang@vivo.com,
	zhanjun@uniontech.com
Subject: [PATCH v2] wifi: iwlwifi: Fix typo "ransport"
Date: Tue, 15 Jul 2025 13:58:27 +0800
Message-ID: <8F065DF7EF7EEB89+20250715055828.932160-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <949F0ED6008D554F+20250715055031.928947-1-wangyuli@uniontech.com>
References: <949F0ED6008D554F+20250715055031.928947-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OEQtS9MrhLe4F0seu7yVgNbVjSZbOsHWuLEOb9ldjNK5H2o9fTbmf4Jm
	nk5ahb6MvXkBcn/g2rqXSf+ky2JcpPQaF00qlj5ybaV8L8ZP4cVeztQUHDsIstAla3A4Sim
	zEL0NSw7RcxfFKldgB2YPLsATQF6z5T7Jj9h8RlpVxzqqyzWn/zNdEBXHvcKw0TCT3R3jrX
	AF0ah24TzueTv6NExn9gy3lm6qOJ6MuHVWb6d+A5GrRCWb/uteTq6ERSJTRNdigDnA6ip0g
	LNSGKzGqOF/Lnl/sOwIzSPsahhFeJO4q6ULxGzjcWSS2x6qCb0c0LN+ZiPxNhA/V1DUTzIB
	j5XXywoCkncDRNP7bzUyabSFHFWonmmozGt3GvZKOJVgX7IcI1GhK5Fn+S956YWxsCRA0bD
	hOdILiTzOZM8R16yqX5qXSfxXzGe0nlSjjoCcMRf26jNoTRvWl47p8XljBJAq2RHitGwnha
	EwBAxeM3rhNIHlQIGmfqDx+hWdZi7FgZFRuCKiSbuM+VgzoYw5ncfdsOFwtAbBZtnsFTIMH
	UkU8weR7V+UqJe5M8Tit8Di9LjxwbGeCsqiKO4DvFO6ZIE2xdvHj/AtZwC8tQs+zNLqmzAf
	l8WWf0mkKsa4tr8p3cG67QNeuOVLByI4gWEWG6DMVyz1keMKvfMpteyZcbPEUtWkAYCMKFt
	Y4UoV0g4qC0AlUxOLHJssdPMCEXxM8RjXfW9eg4frQ8zkXvPXFKffdD0Geh3uD4aTfE5Lz0
	5GiagYNUkb/d0WJIzwzJHfyehb/0P7TyckTBR8y9OTj3khSoE/tCXGe66r59TsJ/2EHDFTl
	kaQS+Zhy2AqOLxcwEdEA3mQCq1rMi9AfPBOMRG9yu8pF1ktiuzcOy2DdILa2X8XZGWSnz75
	Dev3P6oD5kFnsNcXSKMi+DEAcfQxYt0gwRHORMS55bQpHcLFu18tS+JYcUsWXLwizP9zNCp
	rE5HZP39UYUFLL/eufV8TxCS/VfXCBBwf3IcjuadaZLQEgb3PzgIuCwvxO727wMockpDQsV
	+g4pFawwF6F0ED0fjdaMXddLDytIAga+DTswF59DoRJw0OoTLhqdNCkc57gE7TJeQ6A2Zmg
	8+7GrnOgcfCVYvY+/OXYWKLQI6td0qMrzDVdEGOehtQg0GcmkmrzCc=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

There is a spelling mistake of 'ransport' in comments which
should be 'transport'.

Link: https://lore.kernel.org/all/03DFEDFFB5729C96+20250714104736.559226-1-wangyuli@uniontech.com/
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
Changelog:
  *v1->v2: Move the change of spelling.txt to a separate patch.
---
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.50.0


