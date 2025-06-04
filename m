Return-Path: <linux-wireless+bounces-23717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0544ACE200
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1AD3A3FC1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEE31DED5D;
	Wed,  4 Jun 2025 16:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RqWS4ZkC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A021DD9AD;
	Wed,  4 Jun 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053638; cv=none; b=jaf9lHj+nz4y+3Z6YB3V5dCrvEwqBMOXckix7ZM0J6ROCdl5eESHeZ685Cm/3j67A30N3O94CKc5rDMTrZzUXH0sDRkfFNRPItLSsG0BEWQ2gfxIxvvjhlOdL3lzTyVgUKFPkdyv9Tv6oeYYPHCDz4tTFrszuori57ElyteaO4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053638; c=relaxed/simple;
	bh=dar1UznmH1Dll183/KM4lYfwaULVTLS18BvAxxVcJ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C/4poRjflEvcY5P+OxUO34nvXLMoBjrmIU1znsq49KUe47/LZa8yDTGbVaoExOsaDlqxMIwFa+a10rY0NysFJxKTGlPjEyc8qj5pTHIyuXWcbeQeiVUxeIYK14W6mATbtPh/9JSdtRdcrD84JlaDAVHEvDmPbGKsAP2O5nQ5X18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RqWS4ZkC; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.17])
	by mail.ispras.ru (Postfix) with ESMTPSA id 7F32E4076195;
	Wed,  4 Jun 2025 16:13:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7F32E4076195
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1749053633;
	bh=4RFK3EPTWy73fhjq1/g3Bo8lLlasyD5LV4zIUsgviZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqWS4ZkC2JjCmSRWkLHLSeIZzr14ClDzg0TXia1k4TjEvTxMH+NP4RnmExQagQB9C
	 mc3Ajf1m+x2AK31/OmJFc7m8Qyy/6+O0SSTC8t2dYKiN13WL9280bN83wgB/ADoOpl
	 enqeo2ByGgErB1kYaN9Xm6rE/wr3lb1MTP6xwAPY=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Zong-Zhe Yang <kevin_yang@realtek.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH rtw-next v2 2/2] wifi: rtw89: sar: do not assert wiphy lock held until probing is done
Date: Wed,  4 Jun 2025 19:13:33 +0300
Message-ID: <20250604161339.119954-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604161339.119954-1-pchelkin@ispras.ru>
References: <20250604161339.119954-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtw89_sar_set_src() may be called at driver early init phase when
applying SAR configuration via ACPI. wiphy lock is not held there.

Since the assertion was initially added for rtw89_apply_sar_common() call
path and may be helpful for other places in future changes, keep it but
move it under RTW89_FLAG_PROBE_DONE test.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 88ca3107d2ce ("wifi: rtw89: sar: add skeleton for SAR configuration via ACPI")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

v2: move the assertion under RTW89_FLAG_PROBE_DONE test (Ping-Ke Shih);
    add Fixes

 drivers/net/wireless/realtek/rtw89/sar.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 33a4b5c23fe7..7f568ffb3766 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -199,7 +199,8 @@ struct rtw89_sar_handler rtw89_sar_handlers[RTW89_SAR_SOURCE_NR] = {
 		typeof(_dev) _d = (_dev);				\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].descr_sar_source);	\
 		BUILD_BUG_ON(!rtw89_sar_handlers[_s].query_sar_config);	\
-		lockdep_assert_wiphy(_d->hw->wiphy);			\
+		if (test_bit(RTW89_FLAG_PROBE_DONE, _d->flags))		\
+			lockdep_assert_wiphy(_d->hw->wiphy);		\
 		_d->sar._cfg_name = *(_cfg_data);			\
 		_d->sar.src = _s;					\
 	} while (0)
-- 
2.49.0


