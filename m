Return-Path: <linux-wireless+bounces-15601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F39D6289
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 17:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27586160E55
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2024 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715357082F;
	Fri, 22 Nov 2024 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="g3+bb/En";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Jg/GYaCl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C6B2E3EE
	for <linux-wireless@vger.kernel.org>; Fri, 22 Nov 2024 16:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732294187; cv=none; b=lOs3X8Jiths6Pd1+OLl5TX4nWqyToRUoJDfGsi05ekKWvozRgmZQp9H5ipjml5B57iS+sxv/9UUvb5BCZ2s9XUhgsMpqAxNDzapxX6iGXeaFVdCA928xwUQnch/UbAKXWPclYmGiP0elWHzM1XBPuCEG2IMAuSt3dvZU8Jrh/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732294187; c=relaxed/simple;
	bh=fbJyDxZN+U0aLs51zdRPYgn56ap1jOvu70jSaT0aEik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E0HgpByG4ogTCSVAUTpAgg8pzz5OQq18eOu5GUgtPBvntCr2bEadgstckOho6ep6fyR7I/8BEZ911A1tIcKLt/MSCte40SJJvpEXSF/WnrU1+Pjau1W3mH0SR6WmpKTq5p1h/9tfjtmW54sAdGPm5RivUzngWJy0XyPI8I74IHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=g3+bb/En reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Jg/GYaCl; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732295084; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=; b=g3+bb/En8YiJ9/4rkGFgznnG8s
	tkM3auW7zN1vFk5isXDOprpUXQV2M4swbI4Ec+xi8/3tp0r6TXGwp1jSHAvaR6PUZ+MrRbwJwXYCy
	Pj9EFDB31CvHzm9b9kHqovURpbUtS9/EAf7KOtyKLQ0gu3KeArJYyf0f+xUxdMFgXH7+BAhSQdvif
	cy/WbYzf5BktwHuf2Uc8mRlz0vqlFEb/dP4v7AlUmhEXIJZLYdD3vPC33azJyMWiFVMEcrE0OEg4J
	+zJ2Po8foNWTx/j8eFfG0jEgj7uawHVuK2MiaXU59S1Su2BY3hn/zd9Cka1Y3PHyPL65Gmq8sMrcx
	K6eJP86g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732294184; h=from : subject
 : to : message-id : date;
 bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=;
 b=Jg/GYaClat8wXpi5pDlix24y/rgFHbZGbkpChYmMUtfSQsJkr9wNFFe9l3ixheSVojxZC
 vyaBgdqF8yTbTQs1nXlpYH9i+5Tsh3zaBfcJOFg/6VtOEcGLxzkMCBW3t41dTznG9/qKtMz
 gWlwO9EyPFYV0iE+2qUUxpTSWVLcav95FmWEEiYKLXLn7h6OylyQKFu3rsnTwcJ5BkVOM1A
 zLWYkk9AWIXYB70TNd8k2dWcIQVRepfKPQti6WsoMmLyOdnJ91F10NgZoF43OB99cdSLZSp
 j24DEK7V2SVkUQf7NVDBd4rRYxeAsMTNNJ8//VivpbEUHZX9Wm7ZBz3xALpQ==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqR-TRjyJk-P1; Fri, 22 Nov 2024 16:49:23 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEWqR-4o5NDgrgcby-m1Zz; Fri, 22 Nov 2024 16:49:23 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [RESEND PATCH v3 0/2] Improve ath10k flush queue mechanism
Date: Fri, 22 Nov 2024 17:48:00 +0100
Message-Id: <cover.1732293922.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: Y6S9SgXWrjh7.dhVOshQdXleK.FmgH6gvpF81
Feedback-ID: 510616m:510616apGKSTK:510616saXhY0s_Pe
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

It has been reported [0] that a 3-4 seconds (actually up to 5 sec) of
radio silence could be observed followed by the error below on ath10k
devices:

 ath10k_pci 0000:04:00.0: failed to flush transmit queue (skip 0 ar-state 1): 0

This is due to how the TX queues are flushed in ath10k. When a STA is
removed, mac80211 need to flush queues [1], but because ath10k does not
have a lightweight .flush_sta operation, ieee80211_flush_queues() is
called instead effectively blocking the whole queue during the drain
causing this radio silence. Also because ath10k_flush() waits for all
queued to be emptied, not only the flushed ones it could more easily
take up to 5 seconds to finish making the whole situation worst.

The first patch of this series adds a .flush_sta operation to flush only
specific STA traffic avoiding the need to stop whole queues and should
be enough in itself to fix the reported issue.

The second patch of this series is a proposal to improve ath10k_flush so
that it will be less likely to timeout waiting for non related queues to
drain.

The abose kernel warning could still be observed (e.g. flushing a dead
STA) but should be now harmless.

[0]: https://lore.kernel.org/all/CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com/
[1]: commit 0b75a1b1e42e ("wifi: mac80211: flush queues on STA removal")

V3:
  - Initialize empty to true to fix smatch error

V2:
  - Add Closes tag
  - Use atomic instead of spinlock for per sta pending frame counter
  - Call ath10k_htt_tx_sta_dec_pending within rcu
  - Rename pending_per_queue[] to num_pending_per_queue[]

Remi Pommarel (2):
  wifi: ath10k: Implement ieee80211 flush_sta callback
  wifi: ath10k: Flush only requested txq in ath10k_flush()

 drivers/net/wireless/ath/ath10k/core.h   |  2 +
 drivers/net/wireless/ath/ath10k/htt.h    | 11 +++-
 drivers/net/wireless/ath/ath10k/htt_tx.c | 49 +++++++++++++++-
 drivers/net/wireless/ath/ath10k/mac.c    | 75 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
 5 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.40.0


