Return-Path: <linux-wireless+bounces-16629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834E49F838A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621577A1A46
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2F71A01C6;
	Thu, 19 Dec 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+bVWK9g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E819E83C;
	Thu, 19 Dec 2024 18:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634243; cv=none; b=UA01KOLE16UlXLuu3OGqyItEyb47SG/TWoQ98uTgYPCg2Iz99X+/N14G1FYxOmLybrOdEGE6ojefkzN5+hwdF/FHNLBvSvTqv6ATPafTjVNww0G0JERnG08bqTgQKAfcR8OkdEBoIRk1eet5l3LiggUm0yv2JhtSHTtSF/VWoVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634243; c=relaxed/simple;
	bh=29/TBABKg6zDdn7L2g8TRQuGJQyYTQ0UdjsxOzxmS6w=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=PU1qdupo4LMXMeLvDByFLEcdird55biyzBHtO3EWGK3roJNXSLd3shl6M+tUNFfdbM68EfhffLpdC0vPKEdJAHIkbTVk+SuJb9xRg4t4y6EmUFSLmorL+HVyjVDEZv7MCa9RCAMa3+abpGTw6j0V8BHQravGNsRtphj3jaDRP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+bVWK9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662B6C4CECE;
	Thu, 19 Dec 2024 18:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734634242;
	bh=29/TBABKg6zDdn7L2g8TRQuGJQyYTQ0UdjsxOzxmS6w=;
	h=From:Subject:To:Cc:Date:From;
	b=L+bVWK9goOEZHOCob/j+Wa5k/CmsXf23JWV7fxK5KGhha6d3h/ORkh8zE9bNQwqPH
	 0zhL6TtEOUcwjjLz2px/DRpqiCUpU3HFUkarbH5XnMn9AK2MNMQkP3gFdAueK+JqGu
	 QeuBrOXFf3LdHWuAsUUijkkDv1w4IxrefAGjCFCsd4jqLeyJ9qUJwyp5xYXo8qkYQs
	 5JIct//OrKvwML2spQG/4+10g+sqcDIT5hsdNeIoB88n6n/V2j/pInywE2ErHKuT4V
	 1xhpWo7ucZ5/LOukfXOB9NyRYHqkUZaNPBjei0/xuCufnDsgNyqxbBsBgO3lYSEURK
	 Bfiyay4XfdHXQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-12-19
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20241219185042.662B6C4CECE@smtp.kernel.org>
Date: Thu, 19 Dec 2024 18:50:42 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 150b567e0d572342ef08bace7ee7aff80fd75327:

  Merge tag 'net-6.13-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-12-12 11:28:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-12-19

for you to fetch changes up to 146b6057e1fd28fb1a38d300bf76a38dfba7f9fb:

  wifi: cw1200: Fix potential NULL dereference (2024-12-18 19:58:27 +0200)

----------------------------------------------------------------
wireless fixes for v6.13-rc5

Few minor fixes this time, nothing special.

----------------------------------------------------------------
Emmanuel Grumbach (1):
      wifi: iwlwifi: fix CRF name for Bz

Jeff Johnson (1):
      MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer

Kees Cook (1):
      wifi: iwlwifi: mvm: Fix __counted_by usage in cfg80211_wowlan_nd_*

Linus Walleij (1):
      wifi: cw1200: Fix potential NULL dereference

 MAINTAINERS                                     |  1 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c     |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c     | 14 +++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 41 +++++++++++++++++++++++--
 drivers/net/wireless/st/cw1200/cw1200_spi.c     |  2 +-
 6 files changed, 53 insertions(+), 7 deletions(-)


