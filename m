Return-Path: <linux-wireless+bounces-9988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24C9274B6
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 13:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5576F1F21A9A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA701AC23B;
	Thu,  4 Jul 2024 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0qA3wtw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329041AB8F8;
	Thu,  4 Jul 2024 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720091673; cv=none; b=ZY5ntdJ0Y/nb13rPjPOy5tzH9I2UCG1haP2T87NKgsQHrMtWwJvhd9slFUsfZ0rVyLVhi5ciN4KX7uAs8RDYQ4hHqXEyxUmsQNUkqxs49LHtiRLI6Mk2Ya3RUl3tyl+VonqQDNVfVrtiQ81u5is1iFgxpD+9ONRNXTm0GBKEDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720091673; c=relaxed/simple;
	bh=B/9ysb8z3IRQ0NnrLVY26K1uTUxY+q3sSvvoek04+UE=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=gTLDrOHKVkCNefuBXvCjvQL0scpYqnZPB3aMcbqLqkP8fQm7uuDeechkjlJ8TJgFGMmts6Qg5fuMpf3Y8k2FWuSwlCIW7BMCjPXXG34uG27Xp2J8ApBE5/A3K8gsSRD6IIwuewZSBW+8316gk6tYaBkXNzjdiUBaIZy4DeLZZOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0qA3wtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DEDC3277B;
	Thu,  4 Jul 2024 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720091671;
	bh=B/9ysb8z3IRQ0NnrLVY26K1uTUxY+q3sSvvoek04+UE=;
	h=From:Subject:To:Cc:Date:From;
	b=L0qA3wtwfT7Hux9UwawJSrE3eQBHgaeKdf7YCvVSxTevlJYVTrQ6afjCjI37G0l0h
	 HWFMrhV2NlrH6SA4mxOqLqDiAmqEV47RirlchjwfP0l8wxJbAeYQnf0jbkZ4FgByVU
	 F/seOlMVCj8KBAAJmSO8Jj8s49IA9HzKgPT1AC8RESR4dq5RQlQNtPBQVqaIFOFHWQ
	 o3NXLp1A17pptp0pWlYip+JdMKyJgNWEa8M+g4mKYBp9/nKELydGHkGi9FvC+1Co9S
	 +ks9Y5Lj0S3ZGLMamcQP1IBvO/7MoNggVIM+vmUId8397T3DEI6utPsdPTslftKk8L
	 UprR4bgdivpGQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-07-04
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240704111431.11DEDC3277B@smtp.kernel.org>
Date: Thu,  4 Jul 2024 11:14:30 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit c40ff9b662d08c86b7a46067155a97af0074bb93:

  MAINTAINERS: wifi: update ath.git location (2024-06-26 20:35:30 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-07-04

for you to fetch changes up to 4130c67cd123a36c902cbe9ce5a2efbc33eb18c0:

  wifi: iwlwifi: mvm: check vif for NULL/ERR_PTR before dereference (2024-07-03 16:06:54 +0200)

----------------------------------------------------------------
wireless fixes for v6.10

Hopefully the last fixes for v6.10. Fix a regression in wilc1000 where
bitrate Information Elements longer than 255 bytes were broken.
Few fixes also to mac80211 and iwlwifi.

----------------------------------------------------------------
Daniel Gabay (1):
      wifi: iwlwifi: properly set WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: don't wake up rx_sync_waitq upon RFKILL

Johannes Berg (2):
      wifi: mac80211: fix BSS_CHANGED_UNSOL_BCAST_PROBE_RESP
      wifi: iwlwifi: mvm: avoid link lookup in statistics

Jozef Hopko (1):
      wifi: wilc1000: fix ies_len type in connect path

Miri Korenblit (1):
      wifi: iwlwifi: mvm: check vif for NULL/ERR_PTR before dereference

 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 14 +++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      |  8 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c       | 15 +++++++--------
 drivers/net/wireless/microchip/wilc1000/hif.c     |  3 ++-
 include/net/mac80211.h                            |  2 +-
 5 files changed, 20 insertions(+), 22 deletions(-)


