Return-Path: <linux-wireless+bounces-24286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A42AE1A26
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 13:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E4F3A8448
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BD528A1FE;
	Fri, 20 Jun 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yg2yI/Vr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D5828A1F6;
	Fri, 20 Jun 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750419591; cv=none; b=pHEd9yeb0kRJOb2NftPPKb7QhQ9TwjumX31UKOkBabEzTHEOwRomx7/zLssM/lFep/IVJnbRU5mMiqLFa1f64w2yI/SUr2+pv4bkkWWaMjq7hBlMa8AiAVhy/Ep9om9k6LYmjpAvvRfSJcgnzm+ZpqJufKbY/HJNTNyKN5TarhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750419591; c=relaxed/simple;
	bh=yHXerpZbHKNNHCSwuRD2EVayv8sJYog21TwLflsthZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cJCQqnqx7KbDDi3W5Rd4vLmYVXpOhLjy5xdsCge4CG6zfrdW26Frzz9KZY5guL4zEwHc5+d6/j62hUvO8S7aARXYXCVDIlSzZem+q+tYs91EWVoElFjOl8XJnucD6V0XuIoMILf8aGgtYP+U2euaQhVywQGhurfFJPNNFt3czRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yg2yI/Vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D131CC4CEE3;
	Fri, 20 Jun 2025 11:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750419590;
	bh=yHXerpZbHKNNHCSwuRD2EVayv8sJYog21TwLflsthZM=;
	h=From:To:Cc:Subject:Date:From;
	b=Yg2yI/VrI8dqLG11op/QYg7R/g1uzbjYZuBH0ktEdSX1N9szKKAqZ74DYA56cO1SJ
	 /BfkIri7CuHroZ3yYREIBn/yFMkOdsGX13NajutjB2Va8lx6iyEQA6WcN7mVCQMW7U
	 0PNyR7LpHtf8H6Qh0kPpjOfQ5Dgv2mDgyCgACDL1OJ1xIACPgWExBMyU7fBRF2MZ6E
	 SLsC5x7i6PhYd8jqeEpxXNRNkFSSo2YI+XqyrCDf7+H7ZIvfz1iKaQFDpgdpfKQOCu
	 KoC86EUtI9GQfswVETFVcVJR6lF2Tb3eCiXkXR8bKMzcmOkppWOcUjhCzpqLAEaF9l
	 jtylcnvIMt6VA==
From: Arnd Bergmann <arnd@kernel.org>
To: Stanislaw Gruszka <stf_xl@wp.pl>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] wifi: iwlegacy: work around excessive stack usage on clang/kasan
Date: Fri, 20 Jun 2025 13:39:42 +0200
Message-Id: <20250620113946.3987160-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

In some rare randconfig builds, I seem to trigger a bug in clang where
it unrolls a loop but then runs out of registers, which then get
spilled to the stack:

net/wireless/intel/iwlegacy/4965-rs.c:2262:1: error: stack frame size (1696) exceeds limit (1280) in 'il4965_rs_rate_init' [-Werror,-Wframe-larger-than]

This seems to be the same one I saw in the omapdrm driver, and there is
an easy workaround by not inlining the il4965_rs_rate_scale_clear_win
function.

Link: https://github.com/llvm/llvm-project/issues/143908
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/wireless/intel/iwlegacy/4965-rs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-rs.c b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
index 0e5130d1fccd..031d88bf6393 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-rs.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-rs.c
@@ -203,7 +203,8 @@ il4965_rs_extract_rate(u32 rate_n_flags)
 	return (u8) (rate_n_flags & 0xFF);
 }
 
-static void
+/* noinline works around https://github.com/llvm/llvm-project/issues/143908 */
+static noinline_for_stack void
 il4965_rs_rate_scale_clear_win(struct il_rate_scale_data *win)
 {
 	win->data = 0;
-- 
2.39.5


