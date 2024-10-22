Return-Path: <linux-wireless+bounces-14303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8209A9E24
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 11:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B04283477
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 09:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90E17BED2;
	Tue, 22 Oct 2024 09:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="y4tR1dIs";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="YU24tdDp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6072198E70
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588550; cv=none; b=Injwp9b3EQHOPhx7rwgoEZgzCrvgg+siKVVKkzwPivqR+k17IEDkzP1qqY9q6QTADkbiyooHDIhgxaTqm8+YPFyv5XKMLnXv01FboeOaurHVbpFoW0KSMVD3ax1bRSRfOJbeIhc2ZxJmaykudcJ0L74nx0WwNxlBmUYc+rRxuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588550; c=relaxed/simple;
	bh=fHZ7UidSxFuG5eHKJZfZuj1oorwTq6W0YHdbUlWJv40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oZBzN8QcZsj6GMPc/R5MTKtOVb9fTGbNYjP9mDyhp8USEK2aVvMxK7tyIwCUdq2ZWD7vGjCR3p6OzPfd8ljN7q159fj1v9Dp3taAexAWxC1lgljRgiEIZ8xQUxSQ2+dC6HeIBZ9kd9z3lBkYVfK0NDNpNxHNfezCYCBQq/EGEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=y4tR1dIs reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=YU24tdDp; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729589447; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=xb/z+UNQUk2Bzm3fUSkikryYi3CIF7nhB0KzTo+RcOg=; b=y4tR1dIs1cQrL23CqxxZ8Jam3u
	UHJJ7pcqaZaaN3SxfaXxo+Cz7AVy6GOnfPKfY3TIyZSQizLo61JQradYDsEDRCf0MXtjwf634Z87B
	w6zQDLILEDHbpPGLawAydocNBVpyyeJ/xzsSg+Fo3BzjohwwvKt3U1VJ9gqx4RzvLunKaRo8JiNxa
	95T6II32Q64k9wXq9nICPsEVR/hcdHicvy2Bd01H/Gn/vJoABLUJ63APyr0N9OsBGNX2unZh0zhYK
	+bWGS8We3SMiF/lrBThV0gVmnGDEVLzzSl9igi7wxA9buVPhcaGPdYblZi3FdbdgoHVplXE/SyNxH
	jR9KRCGw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729588547; h=from : subject
 : to : message-id : date;
 bh=xb/z+UNQUk2Bzm3fUSkikryYi3CIF7nhB0KzTo+RcOg=;
 b=YU24tdDpcJNi3ZdmrrH1BmBieNf6LTc6YLCbAOZDTBNLQZouZqWtcFTA1sMsaEkE9eR0M
 rtDma0lIkODR2dwa0l/Wype9vI37xjgwTgc3LRQav18OW9mwYtWCRHZt2zDxPPZcemntMde
 PoJ8QWjArwtRZQrhu3xzPNIrRjoD8XCwGHkqdBpPafO7ByPUbvjODJf2tbiPpHRMckEJrPV
 45nb2m6Cfw9EZPnK7R6exLRP3ujVbnGvUbWaGlXUEd9s2yXlRdXrVqYDyz89qEWwPEZOuio
 CA07fMeyvxvHMZH8mlxJnBQ2DFxqWGyc3QKcLcO8RDB5ZkQw97JV953f/OdA==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayn-TRk3iE-Qs; Tue, 22 Oct 2024 09:15:05 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t3Ayn-4o5NDgruWbA-qiYi; Tue, 22 Oct 2024 09:15:05 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 0/2] Improve ath10k flush queue mechanism
Date: Tue, 22 Oct 2024 11:14:56 +0200
Message-Id: <cover.1729586267.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 1wRjf56NAZcQ.z-JNBMjvKDHC.ti-BkgJKb-M
Feedback-ID: 510616m:510616apGKSTK:510616sVJz0R5toj
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
 drivers/net/wireless/ath/ath10k/mac.c    | 73 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/txrx.c   | 11 ++--
 5 files changed, 126 insertions(+), 20 deletions(-)

-- 
2.40.0


