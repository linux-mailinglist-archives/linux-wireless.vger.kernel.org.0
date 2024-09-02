Return-Path: <linux-wireless+bounces-12331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A12259682BB
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 11:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC351F21354
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2024 09:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C683213959D;
	Mon,  2 Sep 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/aKJaVf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D22D7B8
	for <linux-wireless@vger.kernel.org>; Mon,  2 Sep 2024 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268187; cv=none; b=HJekyqBlzxNjNUvco8khNoVgy7BCv6Zv8tYX4dgTAqsLI6oH0EY5UBmJ0R+0laTzwu+OVy6MlHUjhHB/xWUO2eZV63UmReJbI/t6Sm5IKoOHvpvhg7+uWqRy/KUs0o5PfTY88lhUiig6mSMXaC9OmrYFyT+Lin+fZca/55INdXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268187; c=relaxed/simple;
	bh=uTgaWv7VOoRmD+8oYePEjExTXryEBpcBaBwy2JLtuV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N3/jcluJtkwdmTXoiPFv7eAUOxUpNh1JBeTmivy1/o1mEc5fzv3UuprLiJg5FLZdd0fOEboPbIiwK0PCEpZIHBg+M4ZYA8SHAKtVh/NT4/CawDm3FreuOIwNOUKF71cOBcGuwyoKOlKRcxJR4El+BQ82D8fdcysjt1Bn0zHzfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/aKJaVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD71C4CEC2;
	Mon,  2 Sep 2024 09:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725268187;
	bh=uTgaWv7VOoRmD+8oYePEjExTXryEBpcBaBwy2JLtuV4=;
	h=From:Date:Subject:To:Cc:From;
	b=Q/aKJaVfo5jA7pTiLsqea8QNkfrUHihXiwrhZ1BqPyYPlb0egAEDfXy4Uuvf4JR3R
	 tH8SiLcbiDD1biSTNx6TjZwoLRHSw73Jlwn+kjsQOn0d6KpEiLbiycbcIgFCIZ7dIm
	 WXKDk082IP1hDfuK6lo9wSceWdVpfcQ4HCQPMFWMhsdHMq1MxoXgf9NFolDzvR/fOA
	 9JrFYxP2b4aa8jhoA3/DUgEEWicva4ZTVf/o+0horzCEJl9f8NQ3XBtA5XeOKyeSF+
	 AEoQTEduOeDaHg55GonjPd6ABQ2RDALrrLOafHuHcj65yHlXUtCLGS9/M+sBKaZ9Y3
	 UQKJxxIK4FTew==
From: Simon Horman <horms@kernel.org>
Date: Mon, 02 Sep 2024 10:09:37 +0100
Subject: [PATCH v2] MAINTAINERS: wifi: cw1200: add net-cw1200.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-wifi-mnt-v2-1-f5ad1f36e993@kernel.org>
X-B4-Tracking: v=1; b=H4sIANCA1WYC/23MQQ6CMBCF4auQWVtDSyHqynsYFsXOwEQtZkqqh
 vTuVtYu/5eXb4WIwhjhVK0gmDjyHEqYXQXXyYURFfvSYGpj64Pu1IuJ1SMsqiMyBo07+pag3J+
 CxO+NuvSlJ47LLJ9NTvq3/kGSVlo1NDQDtd5a5843lID3/Swj9DnnL4LzrDehAAAA
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort [1] to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" in
their name.

[1] https://lore.kernel.org/netdev/20240821-net-mnt-v2-0-59a5af38e69d@kernel.org/

It seems that net-cw1200.h is part of the CW1200 WLAN driver and
this it is appropriate to add it to the section for that driver.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- As suggested by Kalle Valo
  + Add to section for CW1200 WLAN driver instead of wireless drivers
  + Simplify subject of patch
- Update link in patch description to link to v2 rather than v1 of
  corresponding series for Networking
- Link to v1: https://lore.kernel.org/r/20240816-wifi-mnt-v1-1-3fb3bf5d44aa@kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..d705e22f1d28 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5951,6 +5951,7 @@ F:	Documentation/process/cve.rst
 CW1200 WLAN driver
 S:	Orphan
 F:	drivers/net/wireless/st/cw1200/
+F:	include/linux/platform_data/net-cw1200.h
 
 CX18 VIDEO4LINUX DRIVER
 M:	Andy Walls <awalls@md.metrocast.net>


