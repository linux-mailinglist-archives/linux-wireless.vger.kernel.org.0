Return-Path: <linux-wireless+bounces-14380-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 206EA9ACB3E
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA81C2163A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C601BD508;
	Wed, 23 Oct 2024 13:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWeyV9Ur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB51AC428
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690207; cv=none; b=mzCxXCwNPAbErwXPbpti7wkX8/CfQHq0W7M9/q6rnn/8brEKhfzOdHgvgGjE7rtpFiutj0nMj4uISOGS7jIVlPV/S5726XeMPbmThtIkp2f1stvS39F2XbeF1pR8z+U43PTX3YAHpxmud1XuOfgQi+Ql5e/U9mRCui63N8aOjEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690207; c=relaxed/simple;
	bh=KzfdCutraSKk7TQKn7xHj6fp9X+8C3/UZsKA361PAr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WQ5ZOydSgabmLUB7fkPTzgmtuUYcDv99gPWU+ihk8wWzd8AqCIG0c8F8N4R8iVYWLbVI5KuUwQoJEe+4CfxRVXakojTHUsHvvj6W8ag5zek/2o3o4LfzkpqQqwcS2u4RXrM6s8Jxu8EGw2f4LB0shu8b3/ABD9fjlkBOE9VyTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWeyV9Ur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CCDC4CEC6;
	Wed, 23 Oct 2024 13:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729690206;
	bh=KzfdCutraSKk7TQKn7xHj6fp9X+8C3/UZsKA361PAr4=;
	h=From:To:Cc:Subject:Date:From;
	b=iWeyV9UriULztfGcMuJN+LQtP6dT8oQYrih/6Yw/Qoo/zIenMJGLWHP8nT0UuhB1g
	 dFKoh0caWEMCilryo5+xhdUTrWU8NwpcCU1/dYRki0wgNJsTsPnzA3kq08OzaKiIqE
	 n8xGGLVNyX2uAuat4aPaJarF+uZE6iEpSeFHoi8aRfvyZfJGxZ9/za9f5wXU0SwPmR
	 fr+zkw5s4Mej7oYdXHkMZGJuJpP6nQjFabd9EgbbbiAxZU04R6jOy4ij77b0mCMQd2
	 ZeT3eYdMPlY8LdZ2ZLW3DeF9W60/9AAxmdPqdqI6XB+t6cKOua7Q1PPCl5/cy4hD0a
	 jjeBFYT7JDwqQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] wifi: ath12k: MLO support part 2
Date: Wed, 23 Oct 2024 16:29:56 +0300
Message-Id: <20241023133004.2253830-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

Here we continue to refactor mac.c to support multiple links and extend peer
assoc WMI command to support MLO.

Kalle Valo (2):
  wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
  wifi: ath12k: introduce ath12k_hw_warn()

Sriram R (6):
  wifi: ath12k: MLO vdev bringup changes
  wifi: ath12k: Refactor sta state machine
  wifi: ath12k: Add helpers for multi link peer creation and deletion
  wifi: ath12k: add multi-link flag in peer create command
  wifi: ath12k: add helper to find multi-link station
  wifi: ath12k: Add MLO peer assoc command support

 drivers/net/wireless/ath/ath12k/core.h  |  25 ++
 drivers/net/wireless/ath/ath12k/debug.c |   4 +-
 drivers/net/wireless/ath/ath12k/debug.h |   5 +-
 drivers/net/wireless/ath/ath12k/dp.h    |   2 +
 drivers/net/wireless/ath/ath12k/mac.c   | 505 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/peer.c  | 116 ++++++
 drivers/net/wireless/ath/ath12k/peer.h  |  10 +
 drivers/net/wireless/ath/ath12k/wmi.c   | 191 ++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h   | 126 ++++++
 9 files changed, 860 insertions(+), 124 deletions(-)


base-commit: fa934bf3e0a825ee09f035c6580af513187d59a2
-- 
2.39.5


