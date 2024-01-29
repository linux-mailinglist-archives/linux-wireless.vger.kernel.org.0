Return-Path: <linux-wireless+bounces-2710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2A84132A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA051F24E7E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C1B4C619;
	Mon, 29 Jan 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OhT/Mgu8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030AB335B5
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556048; cv=none; b=kgnUaau7/ozGts8fKt7krFzP04qBajw1XFPyodoVch/igNT7vuvUsmGgITUpUCeM05xTo/iGDV5+LP1RsfLaRLyBXRHRSdq7K45g+J58T3MZUvNmYVnfCgVkPzSSDE/iIU/U0jLDGKzskkXfpnIXHLluiqnBJX9aA/mzqpOJhi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556048; c=relaxed/simple;
	bh=vX6lOjbCbHJfeS0dsN3HyoUTwT4HuVY/+MW9ZrTDvwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=afr1q7zLdOPhroQ2S77zD9ZlpdovNoEvuOvW/dZMJOfzgzSbsM8xe06ZS27CbyO7q+IKOxtGVDL8DepfSXma8SG1dxwuV8BfNolDYU5k6q3uTx5HXvZ5g6q42jjfIbJEEcoGhnVWKuec99V3I8g2xpFHomwvp5pWLrnKkZZwQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OhT/Mgu8; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=vX6lOjbCbHJfeS0dsN3HyoUTwT4HuVY/+MW9ZrTDvwk=; t=1706556046; x=1707765646; 
	b=OhT/Mgu8xUkgrTCekhbkd4vDwNTtHfaJpX+Iy5J+jBN+xyMM3CK+R1qNLlEbw+DXpq8nxdmMT8U
	AYc3A9HW0OwWsaGN4gUqcOIke6ZqFQb1BGJ9f7UBO7uCGYVa83OU9v/ISCGumPONtlCktHdysg0L8
	SF+1I/Oc1Nw0gBM6V62rpJlwwHAeD8zrtjuDdq1yMFs6XQhbJB9pMA2gZFd7JghuD/rjLv44aqUqz
	gY72KQ9Iwh2DzgTLS6FZLhCqEYeamE0vFGagAw9JP1qB9ZfW7B5KaOkVKWOd2rsEZGE7HGbpl+Yyu
	dJfsOXlV0YeAc0pv30pM2+wClzSeHvCJ/xkg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUXBT-000000050Z6-3924
	for linux-wireless@vger.kernel.org;
	Mon, 29 Jan 2024 20:20:43 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 00/10] wifi: mac80211: initial element helper cleanups
Date: Mon, 29 Jan 2024 20:19:26 +0100
Message-ID: <20240129192041.58481-12-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the fix here with HE/EHT capabilities I got really annoyed by how
the code uses all those bare pointers to create elements, and did some
rework. The real reason for all that was the scanning code, but really
scanning is rare and we're better off with simpler code, so allocate a
temporary SKB for scanning and then operate on SKBs.

johannes


