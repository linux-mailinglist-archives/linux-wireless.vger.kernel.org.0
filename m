Return-Path: <linux-wireless+bounces-15788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D220C9DBB83
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B39DB227B6
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE81BD9C1;
	Thu, 28 Nov 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qd6ju1Bp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB41B85FA
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812629; cv=none; b=fWRdeurbgawabZOwj9ITsLTxXleMXtB3H0K4ZKj0Uo0Yi2s+wJfzsvKtHK9wtAKYp0YsgfHPtylar/YCl6nihflpvzObtZjoKJ8OHs8JKa0/TnpBIAHGsRZ4nPoiaREgUmClwFaPUJHtydOIx5/IFVqKYIrWyByiHceUIHzFVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812629; c=relaxed/simple;
	bh=ZgdaxH/SCC3shzUMy+EXteEN5fIGyCTeGJaMoznnk7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTLTDhYSolFQGW6SjZQ1aCS5ULZSKfDaTMH2GDvPFip8TelNRxMRzF8RV4ORBk5immBntOZtfcka9qiTyhWjmY97AZHuppeK3rwRN9smdBfn7nbVyY1HCYzXnIe/pY/GOypv/sRPgtNi7+wAsflRVbokGCtupjmzz5KHfkZW3d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qd6ju1Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873D3C4CECE;
	Thu, 28 Nov 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732812629;
	bh=ZgdaxH/SCC3shzUMy+EXteEN5fIGyCTeGJaMoznnk7E=;
	h=From:To:Cc:Subject:Date:From;
	b=qd6ju1Bp2lPhHnV/YP4zGrj7q7R+Djt4tJVXZi1wZt8TeVKQStuO13aTDccHC2Om4
	 gnCR1fGj5+Mh+mGuO4KHCP2YaEUECEDP97CF8ecdcT5W1ykxkMt2+pb2lU32O4fP+9
	 YOWufMLguZZ0wPHprKURv4l83klse+GiHEi/BgFz3vVreHZpTTdVZwAqLWBCqvrsQv
	 MtYzrlpQqtPh4jsdyWaeSDfBqXT660v6up4hfVtwjA2FkXba7gLthP8i2o7oL5tude
	 R91l3ugRzPmiKOzft6Nqt+2G0Ik0jj393DnQR/yObcsLYDFWW5g8IvINm+ltemXkSg
	 WCiQ9sRPk2xVA==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: ath12k: MLO support part 5
Date: Thu, 28 Nov 2024 18:50:22 +0200
Message-Id: <20241128165026.2618331-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Now we start refactoring core.c and adding some helpers. Please review.

Depends on:

wifi: ath12k: MLO support part 4
https://patchwork.kernel.org/project/linux-wireless/cover/20241126171139.2350704-1-kvalo@kernel.org/

Karthikeyan Periyasamy (4):
  wifi: ath12k: Refactor core startup
  wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
  wifi: ath12k: add ath12k_get_num_hw()
  wifi: ath12k: introduce QMI firmware ready flag

 drivers/net/wireless/ath/ath12k/core.c | 81 +++++++++++++-------------
 drivers/net/wireless/ath/ath12k/core.h | 17 ++++++
 drivers/net/wireless/ath/ath12k/dp.c   |  7 +++
 drivers/net/wireless/ath/ath12k/mac.c  | 31 +++++-----
 drivers/net/wireless/ath/ath12k/pci.c  |  9 +++
 drivers/net/wireless/ath/ath12k/qmi.c  | 16 ++++-
 6 files changed, 102 insertions(+), 59 deletions(-)


base-commit: bc0785c7c353c6a0e34f5fc6138eb8a6fb15bc0b
-- 
2.39.5


