Return-Path: <linux-wireless+bounces-4392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5861A8725FB
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 18:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A23A1C260F1
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81AA17565;
	Tue,  5 Mar 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmWXksuh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287714016
	for <linux-wireless@vger.kernel.org>; Tue,  5 Mar 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709661023; cv=none; b=QYfxubZD8AqQvw656KjnjE5r2o1WsBUjco8W3pTH2/vMr65J2quYsJMPYy1Bz2RoGtQCUHjlcpnrm/bVQrS9UCO1u9mKNvMwV21zOohPg/lKQ3kyd0Or1JzMRDNHp2wE1TlcRYI9QUz52Qxrxv3cj/KyrbB5Wns7Xo3zU3Hv6O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709661023; c=relaxed/simple;
	bh=B/qqkKrr/0yu0DgsPJn/0e3g4ZQw/3kxTKmccWISBBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QR0+aE5TlZgFtlxLUUSMtBFW+8qiB2ufUwmGaRz/KJU9jiQhfnn6hah442+heSX16HFEzNVZY0e6RBOwCEUONWaQuRKk6UKQSjpfYIMtnXV4fUqZOzuEU3O/dn7Gghsf1GVJh/UunyH/IaAkzerjz5ILyMsF6MEn+DsAmE2Cgdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmWXksuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA98C43399;
	Tue,  5 Mar 2024 17:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709661023;
	bh=B/qqkKrr/0yu0DgsPJn/0e3g4ZQw/3kxTKmccWISBBY=;
	h=From:To:Cc:Subject:Date:From;
	b=KmWXksuhbs0nDjZkfkwRIQgavmtNgOG+ZHs54xPRRIgyMPaoSPDv0T9zs4P9m3Zqz
	 YczSZcdKVgjEfY/um5ZlN8d/YzZpJxnv4sT1yKO6TTS+3wxAfq2SxlVCdIv7/QZPsM
	 /LdB7FlDHgmZdl9vemGPKEAX2NzlUMi9sYyQrNg7oujoo/mHBBGAg5h4hH5y2suZZH
	 AyKywYGmRTkxMeT0CgE3plCqRE4V6IBJj0sxJYtPHnZ+5pdOdi1D3OsqTmQYXk5RWM
	 rD+Go07R3l9uqZp9m6yWTc+xBMaMnyrGwQarjAc8/SA/DzdeIOJ2IteqmUeIdUc0Ne
	 uCzNpByVCFpow==
From: Kalle Valo <kvalo@kernel.org>
To: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
 ath12k@lists.infradead.org, quic_jjohnson@quicinc.com
Subject: pull-request: ath-next-20240305
Date: Tue, 05 Mar 2024 19:50:20 +0200
Message-ID: <87y1awh8kj.fsf@kernel.org>
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


The following changes since commit a4634aa71fee11f5e3e13bf7d80ee1480a64ce70:

  bonding: rate-limit bonding driver inspect messages (2024-02-22 19:13:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git tags/ath-next-20240305

for you to fetch changes up to 776c9c93bb0511d04e6222546499e5ea20ad51b0:

  wifi: ath12k: fix license in p2p.c and p2p.h (2024-02-28 16:09:29 +0200)

----------------------------------------------------------------
ath.git patches for v6.9

Only some minor cleanup in ath11k and ath12k. Adding Jeff as the
maintainer for ath10k, ath11k and ath12k DT bindings.

----------------------------------------------------------------
Baochen Qiang (5):
      wifi: ath11k: rearrange IRQ enable/disable in reset path
      wifi: ath11k: remove MHI LOOPBACK channels
      wifi: ath11k: do not dump SRNG statistics during resume
      wifi: ath11k: fix warning on DMA ring capabilities event
      wifi: ath11k: decrease MHI channel buffer length to 8KB

Jeff Johnson (2):
      dt-bindings: net: wireless: qcom: Update maintainers
      wifi: ath11k: constify MHI channel and controller configs

Kalle Valo (2):
      wifi: ath11k: thermal: don't try to register multiple times
      wifi: ath12k: fix license in p2p.c and p2p.h

Kang Yang (1):
      wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()

 .../bindings/net/wireless/qcom,ath10k.yaml         |  1 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  1 +
 .../bindings/net/wireless/qcom,ath11k.yaml         |  1 +
 drivers/net/wireless/ath/ath11k/core.c             |  8 ++-
 drivers/net/wireless/ath/ath11k/mhi.c              | 68 ++--------------------
 drivers/net/wireless/ath/ath11k/qmi.c              |  5 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |  5 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  3 +-
 drivers/net/wireless/ath/ath12k/p2p.c              |  2 +-
 drivers/net/wireless/ath/ath12k/p2p.h              |  2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |  5 +-
 11 files changed, 29 insertions(+), 72 deletions(-)

