Return-Path: <linux-wireless+bounces-2331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA2D836C31
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 17:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB0F1F261E9
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7F94642A;
	Mon, 22 Jan 2024 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsKXFgYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785B3D980;
	Mon, 22 Jan 2024 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937676; cv=none; b=M/Tson7bKmAvWwlbhi+OxhjuF6QOJguFoJlJnPW5mIIH0amtELc+pwmUOsnnRlucD6dpG0Dwkt5Q0ObJFciPoApZVOIhFbVBar9Vmh8S+GyELlF420JeFQQ2fj0UIJ6chT/1wR+0I3JXbXT05HYq6JrOQwbSakhDOp03YQueYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937676; c=relaxed/simple;
	bh=han1yBdU8NBieplOQDN5w081r6w9ouU/89X9rEQ53JY=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=P+SmcyXa1lu+u1gK/3R6+wqMvKnCIwvGRQy7t7dafiPNGJvdfPnhS6zPI7i98jf5b9a6Xy3gzZ3UDXX4BpCY9G3Rn+a6N8ipW1d7tdO+AeG+ghFh+qabouog55b04fG7kpV6idpd3bnRo+zYtxYmsS28o2AxIdhkBkwramVXoHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsKXFgYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0254C433C7;
	Mon, 22 Jan 2024 15:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937675;
	bh=han1yBdU8NBieplOQDN5w081r6w9ouU/89X9rEQ53JY=;
	h=From:Subject:To:Cc:Date:From;
	b=hsKXFgYJg3n/lReyUKX0mXmIuNlJYhhhvH5F3v7g9/qpYdAAaUJnTH6Jrg3TQbdOV
	 /bQlWWag1AntY2ZOeowB6IUQb1ss+RW9JBRaPpHpVv+Hg+la51WI0D0oj37VdJfwhf
	 F9f2j6bvMPXQDIuY4wkXJyOE9KFH2awIvWCZFAyBVHD1mQy3tGH4bb+DNn2kBFOOrw
	 Vo0QR5fx3/YQxowrKBRW3TeOcqLfghUNigNmemZndb0WXpwUrlwhktsHTDawtm+nYF
	 BsNZl5WfEvHLI4ElvtEAM/+ia5SY5FfRpi4DPnunvtTuIMfN8TBuVIWGTZEVIyDXHX
	 if/697sj199pw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-01-22
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240122153434.E0254C433C7@smtp.kernel.org>
Date: Mon, 22 Jan 2024 15:34:34 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit ac631873c9e7a50d2a8de457cfc4b9f86666403e:

  net: ethernet: cortina: Drop TSO support (2024-01-07 16:05:00 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-01-22

for you to fetch changes up to bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f:

  wifi: mac80211: fix race condition on enabling fast-xmit (2024-01-18 14:51:15 +0100)

----------------------------------------------------------------
wireless fixes for v6.8-rc2

The most visible fix here is the ath11k crash fix which was introduced
in v6.7. We also have a fix for iwlwifi memory corruption and few
smaller fixes in the stack.

----------------------------------------------------------------
Benjamin Berg (1):
      wifi: ath11k: rely on mac80211 debugfs handling for vif

Emmanuel Grumbach (1):
      wifi: iwlwifi: fix a memory corruption

Felix Fietkau (1):
      wifi: mac80211: fix race condition on enabling fast-xmit

Johannes Berg (1):
      wifi: mac80211: fix potential sta-link leak

Kalle Valo (1):
      wifi: p54: fix GCC format truncation warning with wiphy->fw_version

Lukas Bulwahn (1):
      wifi: cfg80211/mac80211: remove dependency on non-existing option

Michal Kazior (1):
      wifi: cfg80211: fix missing interfaces when dumping

 drivers/net/wireless/ath/ath11k/core.h           |  4 ----
 drivers/net/wireless/ath/ath11k/debugfs.c        | 25 ++++++++++--------------
 drivers/net/wireless/ath/ath11k/debugfs.h        | 12 ++----------
 drivers/net/wireless/ath/ath11k/mac.c            | 12 +-----------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c |  4 ++--
 drivers/net/wireless/intersil/p54/fwio.c         |  2 +-
 net/mac80211/Kconfig                             |  1 -
 net/mac80211/sta_info.c                          |  7 ++++++-
 net/mac80211/tx.c                                |  2 +-
 net/wireless/Kconfig                             |  1 -
 net/wireless/nl80211.c                           |  1 +
 11 files changed, 24 insertions(+), 47 deletions(-)


