Return-Path: <linux-wireless+bounces-23427-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78FAC3EF2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8AD516778B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1C1F8EF6;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgTJt3KJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBFC1C8601;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260336; cv=none; b=W4YRrb/QJ3WAfQt1XCg6XzMd+Kt9ifgab59MwuIfmtEonCF6cjc5KpD2MP979aZ/fzw8pfcrPNaYN+H/khGUdTAeJDSC6/VbP/Ce59LO3nbrSk4Vn/2hlL4H8ea6rauoXfCnSIIwhUYrWfQeMNP83JUfviK5BP5bSb2PCnYH4kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260336; c=relaxed/simple;
	bh=6z7x8xoEqYgfeTyuv+MxW6E85QUdFqBt/3KadJRmPQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tFg50jizlZJQDDC9evlnDfWhZPPiemwYVbHI140pVu0PUz1VJCUyu1e2OqOVuLiL6uUl6N9uDCefJeuTBsMPlhtw+b3pWZn1o5WlcfvnhbNybC+ndVzfcGFoZABsLL1LwG2brb58VdxqpLemjWGNsFR4gqothgPjP3C0ZMI8klI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgTJt3KJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40141C4CEE7;
	Mon, 26 May 2025 11:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260336;
	bh=6z7x8xoEqYgfeTyuv+MxW6E85QUdFqBt/3KadJRmPQo=;
	h=From:To:Cc:Subject:Date:From;
	b=IgTJt3KJcKq4yFa6XclWnQZrI/0oIx9+/pMynCoYToLZz4U/7o1JNR7iIKC8rgOz8
	 bgAfdbyj3SgxHjjGRn2RlSiV+ULf1X58f26nrlZ+V5CE9N9OPmEi61adC5E8Kq4zFw
	 diWY3H2Lcs/EkQK6jFj2nMKovePbkg/VQ9vKAT1cseFcZeWOIRd4o/FWzJc7KaULvz
	 sMwIhcnuO0NLV5YeDz2XMCJipN/8adTk8szmX1bak4D5EbI4CJIVl02+0XHi4+IDNI
	 OWCjCI4WyqmwlAav4/Zh6REHeiu+IgcZ1OxEG7X++K3VkJdY1EwUdLk9VUxOLKPsV7
	 5/2sYMqxKSESg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWNN-000000000fE-3MDh;
	Mon, 26 May 2025 13:52:17 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] wifi: ath12k: fix dest ring-buffer corruption
Date: Mon, 26 May 2025 13:51:35 +0200
Message-ID: <20250526115137.2490-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to commit:

	b67d2cf14ea ("wifi: ath12k: fix ring-buffer corruption")

add the remaining missing memory barriers to make sure that destination
ring descriptors are read after the head pointers to avoid using stale
data on weakly ordered architectures like aarch64.

Also switch back to plain accesses for the descriptor fields which is
sufficient after the memory barrier.

Johan


Johan Hovold (2):
  wifi: ath12k: fix dest ring-buffer corruption
  wifi: ath12k: use plain access for descriptor length

 drivers/net/wireless/ath/ath12k/dp_mon.c |  3 +++
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 12 ++++++++++++
 drivers/net/wireless/ath/ath12k/dp_tx.c  |  3 +++
 drivers/net/wireless/ath/ath12k/hal.c    |  2 +-
 4 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.49.0


