Return-Path: <linux-wireless+bounces-23423-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A47AC3EDA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 13:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783A3177BFA
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C41F8BD6;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Zpfet+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659251F5430;
	Mon, 26 May 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748260104; cv=none; b=X9qxUbmXXBtn4fKR+hjWcN5B7VVKTKnhMYiWwds4rjb0KV1cAnIhpHNwEpSEZjm3bRKSDm9NKl8cOELMJh8HTuWmDamkOmL5fLG8LWFmwZ+P22Zkrh+M1W88eg0Mv4OTFuS7/Dyz+0tCP2Gc0B/yMGv/FSfx1pq5RvOcR23W4pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748260104; c=relaxed/simple;
	bh=mjvrQsWSO1J2H28FWM14OXB9euTqINfAytRW7cgyZ0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riEbCNATnH44wShEnvZEvnwHoOfx9lTPCEZnntJ1gyLUwDFIZkFLsFa6QBuZKcpsa5CFS/igGUAJly2hsSx7+Nj4Tuwhko8IcgIhzTk0kk9g7/GjUWCUsejrtwAf98O7jrBwklYS6xw9Wd75/Saj8a1jGQweXBUhrkmhUkj9blY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Zpfet+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C73C4CEF4;
	Mon, 26 May 2025 11:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748260103;
	bh=mjvrQsWSO1J2H28FWM14OXB9euTqINfAytRW7cgyZ0U=;
	h=From:To:Cc:Subject:Date:From;
	b=V6Zpfet+GvE0ZyXQlCnLklLek4ilDIFtwmdSki7VZ5P2Gh29oZSXOEA7A2zs4/0wR
	 k9VBpfTDBAz+7ZGBdVCqDH3ZKrSZbiAz9yuNkhNP15OssKm2/1gdZpLdQnKRiZYe1r
	 fgxVTiuLB1TbEUgX677owKsxTwmdCjx3xRqhDmoTF/vcenvci8FKoAe5PN8vbLHlCC
	 OzId22sIJflgJvJ3rIf43OcZdH/nayhJNDCqT9CK/jEdBB2q+EG4zn7503ebeKVu94
	 7O021o5Eg0yQn9tPlxborkENhqo40ktOgdL7hZpBSAH80cMMARsDwTjeJEsjA+/VjS
	 HN4bf2Z9iLGlw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1uJWJc-000000000Yq-29Dy;
	Mon, 26 May 2025 13:48:25 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] wifi: ath11k: fix dest ring-buffer corruption
Date: Mon, 26 May 2025 13:48:00 +0200
Message-ID: <20250526114803.2122-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a follow up to commits:

	6d037a372f81 ("wifi: ath11k: fix ring-buffer corruption") 
	ab52e3e44fe9 ("wifi: ath11k: fix rx completion meta data corruption")

add the remaining missing memory barriers to make sure that destination
ring descriptors are read after the head pointers to avoid using stale
data on weakly ordered architectures like aarch64.

Also switch back to plain accesses for the descriptor fields which is
sufficient after the memory barrier.

Johan
	

Johan Hovold (3):
  wifi: ath11k: fix dest ring-buffer corruption
  wifi: ath11k: use plain access for descriptor length
  wifi: ath11k: use plain accesses for monitor descriptor

 drivers/net/wireless/ath/ath11k/dp_rx.c | 41 +++++++++++++++++--------
 drivers/net/wireless/ath/ath11k/dp_tx.c |  3 ++
 drivers/net/wireless/ath/ath11k/hal.c   |  2 +-
 3 files changed, 32 insertions(+), 14 deletions(-)

-- 
2.49.0


