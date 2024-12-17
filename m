Return-Path: <linux-wireless+bounces-16503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565A79F57AA
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 21:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6905A188FAE5
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053981F9432;
	Tue, 17 Dec 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pg9Ap9KW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A441F9431
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467180; cv=none; b=rVyOIEvGiojp12GhEwKbCqnAsTm6SDyEAtQoDL3EjL0GLfjmOeKknewJXcMRC/mghAVdKYgb2VmNE39Js6ZA/86dHPKaa15QBoo5zeNY4QxB80Y3CsKum9GGhpEXf9NtC1etDl5eWMX//OwRGjx6WEgpnWYDtCkH79haOCRLKsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467180; c=relaxed/simple;
	bh=kEAdCKgicdHpId1rmo7Q9EFxHtgkjHwleVYsu9P1css=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mADtuBv35FK6b+sWOMiRWPvfejcO+umJVWvsiuSR68ApXwfWwXbF+mACuHWK/Nrf8+2AvyJSjSWW2bavtBC7bc/vkmGRx7o7WpGccwdXqiX53IIYT9HRxl4GfKhkNXHV7vcWsU0I+Ni1D8kwk8zbeRdGFFZMMhOJBL+sI6xORIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pg9Ap9KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFDD1C4CED3;
	Tue, 17 Dec 2024 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467180;
	bh=kEAdCKgicdHpId1rmo7Q9EFxHtgkjHwleVYsu9P1css=;
	h=From:To:Cc:Subject:Date:From;
	b=Pg9Ap9KWmA76pkg9g0UuOCwgwu/DOvgF0uEovLKF2KldPaxS7F+jV+qtjnrWfKkHj
	 kbUmaXjsbytYxEx9khpEitoXzxuA6G+i7K1mTk1v4Xuw2iWccMBdB4dzBMwQ/cIJ0g
	 biQyeo29dDldwgM8Y19/DSLvg/jsLiw1JYDqU1e7Tj3b6DRV1FbR/8ykqiNR+jk6YS
	 sz9/NHvPqiri0/KtxIXwQhQDosHHR5qoFSbZoCBS1xkW0LicO6Xb9iwd2dYB4D5DpE
	 DjzkSyJUC1cLQoIGU4OeR28LlTr/c/ZAx8VfzDz9quUV24bP6PsmGJOuBKRi2TgLSL
	 Tk0hwCbQbKT+Q==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: ath12k: few fixes for clang warnings
Date: Tue, 17 Dec 2024 22:26:14 +0200
Message-Id: <20241217202618.1329312-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

While build testing Jeff found some clang warnings, here are his fixes. Please
review.

Jeff Johnson (4):
  wifi: ath12k: Decrease ath12k_mac_op_remain_on_channel() stack usage
  wifi: ath12k: Decrease ath12k_bss_assoc() stack usage
  wifi: ath12k: Decrease ath12k_sta_rc_update_wk() stack usage
  wifi: ath12k: Decrease ath12k_mac_station_assoc() stack usage

 drivers/net/wireless/ath/ath12k/mac.c | 114 +++++++++++++-------------
 1 file changed, 58 insertions(+), 56 deletions(-)


base-commit: 9a448415ed0c46edeb9170091a03b620986ca0b2
-- 
2.39.5


