Return-Path: <linux-wireless+bounces-2848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F46A842B67
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 19:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48671F27DD7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8409C14E2CD;
	Tue, 30 Jan 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKgD9gZr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7786AD7
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637697; cv=none; b=BaAJfyNOkKIKMq6e11gZYuc427qOCACe+QYK8iN7JFC+h9tmL2Fj5JPnUis02F5f527QsbjwXb2prFXvImA9Nyh7UbjCvlQhc0K5GhPNxmm37MJp7ruSHSe2uUceHLPUE7Zu0Z2pJvJX4m2swafXafJ/jL8XcQ2vqgNQG+BbaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637697; c=relaxed/simple;
	bh=KoSlChzPbN1luVkVxR15iprRA73XaF1uhQs4tygUHo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iaE7k4jYKe8KdgusOtWn7jM1ExImVWJeZJDXAK07LaMd+7kM4VRJ7T2kaz61F0M1d0oKV00yHiTVP5KOb4YLeeGuFf0VBcdVv2zYNRzvpZ7inWX/yY0OQazGBMhly17jlqCwh2CYf/e1ZWO47olBwjXq9xZNvQAHNmGd855GKpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKgD9gZr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06875C433C7;
	Tue, 30 Jan 2024 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637697;
	bh=KoSlChzPbN1luVkVxR15iprRA73XaF1uhQs4tygUHo4=;
	h=From:List-Id:To:Cc:Subject:Date:From;
	b=YKgD9gZrix7B29e7sUr7A89+zy51SzBYHIQY3aGJLuq0jIuYhOue2S0INyeboX4Kz
	 waRLsPMYt5QGPNgx6uHeWXN7+qzxw8wJqWHrefe+RRZIMSWF3vp7RwiNQhg17/49y4
	 VV5ZpCXaJWIi0ItHytXHEJyPX/PLQTTlTkjol5zkViwaN9eVC75sJYXdXjlbpc28pZ
	 jEN00STfIbOGJUhjrdlrXP+BOAkvbqoNoHpmTHIA3ge3tVJr0bYoZqGfyc9mRyVG+x
	 BK0/isf43HfzD2ssNcv1bdrDl35RsR7lfhBaqP3CMIHXrRFKIBp/zYzgGikNo4ZLH/
	 zmX+cjd3qyU6Q==
From: Kalle Valo <kvalo@kernel.org>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: [PULL linux-firmware] ath10k, ath11k and ath12k firmware 20240130
Date: Tue, 30 Jan 2024 20:01:34 +0200
Message-ID: <8734uewvi9.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

We have one important update for ath11k WCN6855 which fixes a suspend
regression reported by several people.

Please let me know if there are any problems.

Kalle

The following changes since commit 1a9518c73c4b54854c9cd8f416fd3b8f8e3456e7:

  Merge branch 'mlimonci/amd-2024-01-30.2' into 'main' (2024-01-30 15:55:30 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20240130

for you to fetch changes up to 5217b76bed90ae86d5f3fe9a5f4e2301868cdd02:

  ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37 (2024-01-30 19:58:18 +0200)

----------------------------------------------------------------
Kalle Valo (1):
      ath11k: WCN6855 hw2.0: update to WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37

 WHENCE                        |   2 +-
 ath11k/WCN6855/hw2.0/amss.bin | Bin 4988928 -> 4988928 bytes
 2 files changed, 1 insertion(+), 1 deletion(-)

