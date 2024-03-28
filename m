Return-Path: <linux-wireless+bounces-5461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C175C8900DA
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C67A294CBE
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB4D83A00;
	Thu, 28 Mar 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp1kbEs4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678582D70;
	Thu, 28 Mar 2024 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634120; cv=none; b=r139ocJZI2A/xRAHSiyKHW5JhoZirX0Byreg/dmB6XcszCn37+zbKpaJlqM4lvlLCxlHEh4f/i33uO68T4KfV0p46OT43JXj9usAh8X1gYD4J6r0LSx94X9RWKpCuNqmfjuGJ8vwOTdiRBvcTaC4v0/qufYuAFwQyyUH2sWIzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634120; c=relaxed/simple;
	bh=n9F22yWXtFRcU1WijjOVkHTPFMA69fbrjNvPBUneSRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cZlYtpt680sW6d7lPq3f+azKZgcURIh2VazskmTFgJVppKrDLlqesxEtMlYaSh1qiiyG2AQFIWNCTDxaGBaaPWEtAANB+yXEGDHo5UERtMjA723Qbwo8WR3Ra8FZDG6+J6exigZsjYfaDV3OJCg54Y6Ts9lelXYqhAtzHRXFH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp1kbEs4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687E4C433F1;
	Thu, 28 Mar 2024 13:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634119;
	bh=n9F22yWXtFRcU1WijjOVkHTPFMA69fbrjNvPBUneSRg=;
	h=From:To:Cc:Subject:Date:From;
	b=jp1kbEs4a4vnFZMw8A9BeJ7bpwUxPTuL4fTUovZjJxt+wUIue6cu99IQujLUs/WoO
	 BAtafn6P7JMnZ3b6dKqXEi6M2PnX6S2OfUKegIwHAjMnIOFH4Spf7xstFlNg/unqcK
	 unSOPJynwPOawKMFpF+JiBXw2VeGzZRlv5q68rL2cJTBAepkrMz+USRhLnIaYoswP4
	 1/LLIH78onUjnBlpYS7jdJgHoQKWBTGRXBZtLdAY8sPameepOAL2u7Jr3M3CHxQaq+
	 Hh8aQRtBv5noWOZh23j5fSLN7z2fzvMIAwl319HwkqHHx47b9Z9vm/zMEXEVD8w+hr
	 epdLckIlnXz9w==
From: Arnd Bergmann <arnd@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-hardening@vger.kernel.org,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	linux-wireless@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] wifi: ath: false-positive fortified-memset warnings
Date: Thu, 28 Mar 2024 14:55:03 +0100
Message-Id: <20240328135509.3755090-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

While testing some other patch series I worked on across gcc versions, I found
a couple of stringop warnings that only show up with some toolchains but not
others. The warnings I both seem to be false positive.

I have also not found an explanation why both of these happen in atheros
wireless drivers, as I don't see this in other drivers.

Maybe Kees can work out what is going on here.

Arnd Bergmann (2):
  [RESEND] carl9170: re-fix fortified-memset warning
  ath9k: work around memset overflow warning

 drivers/net/wireless/ath/ath.h         | 6 ++++--
 drivers/net/wireless/ath/ath9k/main.c  | 3 +--
 drivers/net/wireless/ath/carl9170/tx.c | 3 ++-
 3 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.39.2


