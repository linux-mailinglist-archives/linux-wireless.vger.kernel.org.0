Return-Path: <linux-wireless+bounces-2354-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BDC837CE4
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6599E1F28481
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38915B2E6;
	Tue, 23 Jan 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z7EUVBVk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC615B0F2
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 00:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969753; cv=none; b=k0zZZDzYfWv0QeTt710KbSk0LzTNgXWNTjnIAwCYNkTrlDxyZjWkrHT5XyD5BLULHRdwrc5XjxkafxQH8fqdZ117dN4bXAz9+YJRjRAMXkv4D7LFWtlPAmaPdlOUXAocg2NcACUMEZVswSEQ2QByVHIS/N1fDiJOzcNaHGMesd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969753; c=relaxed/simple;
	bh=7JUW6Se3ttck3u03IUn6h22SlYY5f4wzvv59fMMlk7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiifuBRsaLIFfomUfNQMwVIfBOte2w7fZrlLalDdjyJPgt//lxB6eEVzNMji4EN+BoiVD0JaK39R4ADKwqANk0wmn+AUV554AVv0dJ/uHgyRrkqJLb3CPF9pRkGWAOUftHaoqEH3LD5DqRFFXtIhZ0hSJZFEPqb9fWpFLEMFNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z7EUVBVk; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-58e256505f7so1916395eaf.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 16:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969751; x=1706574551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ie3OTr5sznD5HalHa+6zn+LnARRkCye1/EzAPt6ehMc=;
        b=Z7EUVBVkONDMsQtdqm0Q343HbVNgU8Ys/Z1cwQJbcFaj/ZUQG6Oz2Ld0TAwsIhtuU0
         foBw3rYg05H3K9uYPSn7jWhi6AlCFucQAR1dmLqUUITT1cCGz0/sPecGal2vu62vlSge
         EZHiPWRMVfxkD1BgS1wGMVtLzX16pAcvvYxDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969751; x=1706574551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ie3OTr5sznD5HalHa+6zn+LnARRkCye1/EzAPt6ehMc=;
        b=mg7sLBK7bFkZrluf1U2+r7u2SnkEHpgyTEo0gFiVM4XrQ27YiAOnsiIynayS1WcHcG
         3B+fmJnwe58dyisVBJ4jQnidx0F9i8e1/2M1/PSRuyMRAlKhDVnrgoqy+nY/t5FXNGCd
         pwPaeO39Q4xst+tXB0IFgnQ6TR9l+AAqx2qs1FT2Rf4+wV9yz+akJPTEDhyULMqp1rQf
         Esm+zOrFZdsULZC1T4zPO2vvvHlz/d24rs2Vs5Imanir1XCcKb7uB6ri1OVPxWQhKGxm
         stx1Ccn5B1NKhoo3X754iJqcRqn2EChlFm1mBweeLZ0N+3Pg/ALTJVFm1msflR3aEh8A
         5YpA==
X-Gm-Message-State: AOJu0Yy8y/mDYb6zivFjq55smH60h5Sg7e9G4i9hcoWtPKD3YyhMvS4/
	lY6hEvmXuAOheVJOUl5BA0jge2bALIE6q8z8cMPLMoFYUcwYRS60fg76EZPRRg==
X-Google-Smtp-Source: AGHT+IFu1VaQEw9sFXv+HjTUE3GiTFvw/CXFMuGTa+QFdqe8mKXPpftBjYBhP/mp26Aucx61/cVbWQ==
X-Received: by 2002:a05:6358:1804:b0:176:5d73:3778 with SMTP id u4-20020a056358180400b001765d733778mr1791008rwm.36.1705969750988;
        Mon, 22 Jan 2024 16:29:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78086000000b006dbda1b19f7sm3156587pff.159.2024.01.22.16.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:06 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	=?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Tsuchiya Yuto <kitakar@gmail.com>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 62/82] mwifiex: pcie: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:37 -0800
Message-Id: <20240123002814.1396804-62-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2776; i=keescook@chromium.org;
 h=from:subject; bh=7JUW6Se3ttck3u03IUn6h22SlYY5f4wzvv59fMMlk7U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKEfuOUm8gdUPZ8vO/KuClWsfQ2f3pzbTem
 aIxnbAM+fGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 JonQD/9WVyaa9kGcf/DTeFmgfzqdX7xnM18yRtPWxEh32TPyVUA9IygNLB2Mzz7Mzf/1z1oLx5q
 y6Uf/vyz4gMUfg0RBu4V8FJXTNaL+fZtfonFGhqdJJClaBBDFVd+vTLW4YjC2SBU3KoLfkXXOq2
 7bkrtOFIv7f20UQSh0t9WqD3TpID+zmHpIZvvP9d1x9ZqTkzcibWw0o5ZMuGl0KUOlFccvvXP+o
 t5jfiwQoOn9vESyzTRCcdLFh+EvH3+0EqK2qvNuTBuuHD2rKuFauD7WFvMSJHXrvqzrig23cJRh
 2zz4ePXncay641mG9MIX2AghTvd0BXeUoNdMT2XoIc/G4FPNL62a0r04JF25hoDFE9uYhE7HOUr
 py+wlbBwWORaTtcW5nC4dkTB8JgNhmBvm17GrHAPIu6mqlZHRb7dzU/INOEZaMNSwDAhXjjrRjO
 NSmZSSPrUmkcJLxcAk3hFfbiT62Ad8EBnkaTXnMfLammAc/mmAlnOtABI64GIfFYBXc359RDmbq
 T/ikhjpd19tZo9mFB6ePKrrqeXpNz6UJO8M1WUi7y+9calE0yGanCbvnXGPAgnq51BkvTXMU44k
 iFtizJzAsxk+HlRrziOXDHeWih6lFTrScEFVxBGE/7wFBi4xSw5Te7dWdKwU8Olt009JASnOl+g iafvZ3vYcSNfmBw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Brian Norris <briannorris@chromium.org>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "Jonas Dreßler" <verdre@v0yd.nl>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Tsuchiya Yuto <kitakar@gmail.com>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 5f997becdbaa..e69347e65f0e 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2086,7 +2086,7 @@ static int mwifiex_extract_wifi_fw(struct mwifiex_adapter *adapter,
 
 		switch (dnld_cmd) {
 		case MWIFIEX_FW_DNLD_CMD_1:
-			if (offset + data_len < data_len) {
+			if (add_would_overflow(data_len, offset)) {
 				mwifiex_dbg(adapter, ERROR, "bad FW parse\n");
 				ret = -1;
 				goto done;
@@ -2110,7 +2110,7 @@ static int mwifiex_extract_wifi_fw(struct mwifiex_adapter *adapter,
 		case MWIFIEX_FW_DNLD_CMD_5:
 			first_cmd = true;
 			/* Check for integer overflow */
-			if (offset + data_len < data_len) {
+			if (add_would_overflow(data_len, offset)) {
 				mwifiex_dbg(adapter, ERROR, "bad FW parse\n");
 				ret = -1;
 				goto done;
@@ -2120,7 +2120,7 @@ static int mwifiex_extract_wifi_fw(struct mwifiex_adapter *adapter,
 		case MWIFIEX_FW_DNLD_CMD_6:
 			first_cmd = true;
 			/* Check for integer overflow */
-			if (offset + data_len < data_len) {
+			if (add_would_overflow(data_len, offset)) {
 				mwifiex_dbg(adapter, ERROR, "bad FW parse\n");
 				ret = -1;
 				goto done;
-- 
2.34.1


