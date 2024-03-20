Return-Path: <linux-wireless+bounces-4992-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A4881619
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 18:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B234B21312
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71969E01;
	Wed, 20 Mar 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4pu1PDU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E3F69DFF
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954419; cv=none; b=nc7OuOpS3jxPq1ODw88NGUe8WHWb/sM09QrmKB1j/CAF8wd2+omxDK7LXaPvO/CLEpYmsbpdsv2dj0lAlhA9ZoOnlmrDSs6Bco9ql0lY1WJFPDwfMMveFIrEStKxE2yZCIP0JwJSo4qHy3jQwoXuIvihETXZQ8AX0mfFTWEPF10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954419; c=relaxed/simple;
	bh=QOsFnx2dXxmfK+DGO6zpjuaBLeYFZODSLb4b0OcvFRI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mXla5tt5CY7X+s6Zv7iGq/H6XjbKOZ/RXF6Akt3hJMrn2BnxbARM73T633DzWdimQjn4ZegqtHUo/JAgu6TdLCB9V5YVnQr/4eATNP1XiDv+FMYASHtxK0UEmoXwwogP9pxOP4JBJiylaNSdLskwVz1Y0Pm+MI5dlHnjlLc3se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4pu1PDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 106E2C433F1;
	Wed, 20 Mar 2024 17:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710954418;
	bh=QOsFnx2dXxmfK+DGO6zpjuaBLeYFZODSLb4b0OcvFRI=;
	h=From:To:Cc:Subject:Date:From;
	b=c4pu1PDU5eDk/72Pwn+t/VerShwQpaEtYTLfVG9eGSlkjcLKebhZV3xaz2lZBoYde
	 Vx9GvwjL+MYan7mhDoOYKgbS9uhih07TpJ2S7gcHu1hDspGtccNWghXyX5fYVE6QKy
	 d7VKgzdqisjwQslslNA3Iu3OGCLxP5TRqr5+twU21QnPfjHHlxzU5VcFK/LJeAoABh
	 tHLQNRA6NnS9YiT3K/0UifvS9G1+CfOZ4m5bMKETwgvhIrm517eWkkZc9Ul/Kpx1hB
	 uSasnc4LzWo60oJdzs33hN83OMdxZPivBfhlN943FXMBavmiTUXW03CZrUigGEXSHd
	 ZmpU/UnDdvhHA==
From: Kalle Valo <kvalo@kernel.org>
To: toke@toke.dk
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 0/3] wifi: ath9k: fix remaining sparse warnings
Date: Wed, 20 Mar 2024 19:06:53 +0200
Message-Id: <20240320170656.3534265-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalle Valo <quic_kvalo@quicinc.com>

There were few sparse warnings in ath9k. After this patchset ath9k is sparse
warning free.

Please review.

Kalle Valo (3):
  wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
  wifi: ath9k: fix ath9k_use_msi declaration
  wifi: ath9k: eeprom: fix sparse endian warnings

 drivers/net/wireless/ath/ath9k/ath9k.h       |  1 +
 drivers/net/wireless/ath/ath9k/eeprom_4k.c   |  2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c |  4 ++--
 drivers/net/wireless/ath/ath9k/eeprom_def.c  |  6 +++---
 drivers/net/wireless/ath/ath9k/pci.c         |  2 --
 drivers/net/wireless/ath/ath9k/xmit.c        | 10 ++++++++--
 6 files changed, 15 insertions(+), 10 deletions(-)


base-commit: 4b2f0ce6f2fe0fd906d408a01e494b85c272c7d7
-- 
2.39.2


