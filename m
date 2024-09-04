Return-Path: <linux-wireless+bounces-12481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6986C96BF6E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 16:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134491F22BC8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8243A1DC724;
	Wed,  4 Sep 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3G9HKJ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB01DC1BB;
	Wed,  4 Sep 2024 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458347; cv=none; b=KdBt8ww6rm4UYUGh4gIeEUSqKBOfZIHeFiPbwlWJHFyT4kbMjtcALr5PFGTc3UJ00X3aDNQpYQdjL9ZVlpRYUnvZrxaY+eNUwNe4OeT3oh4GnxitpNvwl5jzvBEv80wQ6QefpSJLUT2741zyAyKuJ5lm1PDUHle6MOBbLJ42thQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458347; c=relaxed/simple;
	bh=uomU0VPvLEPWplvUsbYf35vO9aPTjwAOa5ED93ihjlc=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=QLJtbQE8lYrOYgq0Ub5OPLdk3dL82gPmCm6e0oewnUrfbQ7wpk6iTmmkO8WVgfqyK1YKdzR6kJHu6+ha8z2AEzTkiORLtN3GyVDnttrPh4uXzb+NiV98lf+Nm1lApDMtn6mUZQjevrWKhiWPiFBKFPs0foxrU1+j5LKfJBy3q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3G9HKJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5986EC4CECA;
	Wed,  4 Sep 2024 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725458346;
	bh=uomU0VPvLEPWplvUsbYf35vO9aPTjwAOa5ED93ihjlc=;
	h=From:Subject:To:Cc:Date:From;
	b=O3G9HKJ8p2FXH4rX3ouGGlWOIaF0qt0j3ekIt69doD/v8dugqgEfKKY+kFZEnZiWv
	 LPR+Or38Sy4FU8/cn3NZSoypW6ImWyt8SNGkfT4LANktKsIwXhTvMVq+Z7+N0L43+1
	 BeUmPxUtv6iWxbVeLZrFgwRSirkOv5KluiJVMk8IkBM40iuhPDM4sBgOEWsBhAosEH
	 e8PpBX+HmNx/G6is4aG9YQNDvgSybRZaU8tIpwwnNIiDOm0mjJucPwzSYY1Qh+IlUk
	 5k6O79qUYzsxvy/D4ShPFNoqjucH4BwFYHheoE28BkptJxZZ7JO8MPy5AIFC67ztI9
	 UXMETcl2tdN1w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-2024-09-04
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240904135906.5986EC4CECA@smtp.kernel.org>
Date: Wed,  4 Sep 2024 13:59:06 +0000 (UTC)

Hi,

here's a pull request to net tree, more info below. Please let me know if there
are any problems.

Kalle

The following changes since commit 094513f8a2fbddee51b055d8035f995551f98fce:

  wifi: iwlwifi: clear trans->state earlier upon error (2024-08-27 09:54:24 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git tags/wireless-2024-09-04

for you to fetch changes up to 5872b47ce18efad5862b74ad334cbdfffa7f8a0c:

  MAINTAINERS: wifi: cw1200: add net-cw1200.h (2024-09-03 21:36:02 +0300)

----------------------------------------------------------------
wireless fixes for v6.11

Hopefully final fixes for v6.11 and this time only fixes to ath11k
driver. We need to revert hibernation support due to reported
regressions and we have a fix for kernel crash introduced in
v6.11-rc1.

----------------------------------------------------------------
Baochen Qiang (3):
      wifi: ath11k: fix NULL pointer dereference in ath11k_mac_get_eirp_power()
      Revert "wifi: ath11k: restore country code during resume"
      Revert "wifi: ath11k: support hibernation"

Kalle Valo (1):
      Merge tag 'ath-current-20240903' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

Simon Horman (1):
      MAINTAINERS: wifi: cw1200: add net-cw1200.h

 MAINTAINERS                            |   1 +
 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 119 +++++++++------------------------
 drivers/net/wireless/ath/ath11k/core.h |   4 --
 drivers/net/wireless/ath/ath11k/hif.h  |  12 +---
 drivers/net/wireless/ath/ath11k/mac.c  |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 +---
 drivers/net/wireless/ath/ath11k/mhi.h  |   3 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++----------
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 10 files changed, 52 insertions(+), 150 deletions(-)


