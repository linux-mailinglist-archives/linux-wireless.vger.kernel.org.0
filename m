Return-Path: <linux-wireless+bounces-8349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBEA8D6791
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 406691C25484
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833C16F904;
	Fri, 31 May 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDUuhoJT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517A16F282
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174850; cv=none; b=Nwx+riZO+7rtXGPCqU8wuPTGFxnoja4DmNUuzX11T2BB9G/kvifo9zbp+h25kuuJhYDeyQkjTeRNiD7XgPQvDP0tBurwA5ctMeplBpejxyDPDZA5i3qDXdqKUJurmRi4VmwxnmNRqcm+bsifDaqWoz5zhJH1IirMtZHtesOgFDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174850; c=relaxed/simple;
	bh=npo7uATaKkeSuypMjGQBs62SKdU1v8hnJzTlwcO6QEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wdu1cighTYvxpdVVXHNpS2KSQ5Pw8faRKtFK7VwiQWL+zVr4g0J6KehgChmdaebOOqFIy0aDLizifdgxSkA8T+EGNBsGULsM5bSFMN9D5bDnsLPqKNlKSfFF2o6luY6qvCfoZaF23xhIjaeNZqH79XuKOdahB748NEVIh3vEl8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oDUuhoJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C767DC4AF0B;
	Fri, 31 May 2024 17:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717174850;
	bh=npo7uATaKkeSuypMjGQBs62SKdU1v8hnJzTlwcO6QEM=;
	h=From:To:Cc:Subject:Date:From;
	b=oDUuhoJTWb3vqDy0rIuhvvDNpIP0eTwVsXJ2Vwd5OOaBMYbd1+sBtJR6gt63LJX6N
	 YPqnKYB4vWoFxA1hS2E6NEG6HiXX9jy7TNyIeehjisHsY5N2raoTO4J2H6b0+b+AUI
	 PvpUGTkPDj5HcHDB0P+GBFRU0DU+rDjxPm4Ti8Wd5SPjh3Fgj0+Rx/D7EqLbJoEDyI
	 EgmpAl+1t2ZbLPOGQ4ZR/rcQapjTgN6Eo4H8iZ5aHxJ+akNSEjPx+O0ZmviXMUoSm1
	 wnya48XURoAbpY+JFRmBobiGnC14/iDbIYSIYwudZA13OmF2TJYTiM73iYbLRsH0k3
	 J7WlzUDE+aTAg==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-current-20240531
Date: Fri, 31 May 2024 20:00:46 +0300
Message-ID: <87ttidvrup.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Please pull, more information in the tag below.

Kalle

The following changes since commit 1d60eabb82694e58543e2b6366dae3e7465892a5:

  wifi: mwl8k: initialize cmd->addr[] properly (2024-05-07 15:08:14 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-current-20240531

for you to fetch changes up to 6e16782d6b4a724f9c9dcd49471219643593b60c:

  wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP (2024-05-23 15:45:52 +0300)

----------------------------------------------------------------
Merge ath-current from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git

ath.git fixes for 6.10. Two fixes for user reported regressions in
ath11k. One dependency fix and one error path fix.

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP

Breno Leitao (1):
      wifi: ath11k: Fix error path in ath11k_pcic_ext_irq_config

Carl Huang (1):
      wifi: ath11k: fix WCN6750 firmware crash caused by 17 num_vdevs

Dmitry Baryshkov (1):
      wifi: ath10k: fix QCOM_RPROC_COMMON dependency

 drivers/net/wireless/ath/ath10k/Kconfig |  1 +
 drivers/net/wireless/ath/ath11k/core.c  |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c   | 38 ++++++++++++++++++++++-----------
 drivers/net/wireless/ath/ath11k/pcic.c  | 25 +++++++++++++++-------
 4 files changed, 44 insertions(+), 22 deletions(-)

