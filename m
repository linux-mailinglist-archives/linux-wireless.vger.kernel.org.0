Return-Path: <linux-wireless+bounces-14506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D19AFC7A
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EDE1C22119
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 08:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D371D1D1738;
	Fri, 25 Oct 2024 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="HbWJ0LPz";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Bn0nc3yK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A381D0E28
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844798; cv=none; b=DeSKh1lr5GtK46AZGcsZx1w1EP4lr7RleHH5hilWRjHLnndRPDXB+kySmtz/85cl2RJ6/K+K347BxNrdU5ri3D4T8K7DRC0nMXHPZf9zT6bEmDNw5UDiu4KnOI4nT/0vRp53n4xa+kDdlkXXNpiPmjMoEMP7U2oQKlI8NqQkh6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844798; c=relaxed/simple;
	bh=fbJyDxZN+U0aLs51zdRPYgn56ap1jOvu70jSaT0aEik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejvdWJUnMQx1N2gLYXDNl7taZHdnAGXsBMMvAZhu0vj9CFe18UivpDy8PcONC/2/HxNCtEVekD+LOvghVeKvlGTyR5letkoH8FaiJl0tlFbel6c7pTD8EY1n05nngN78iiVSuT88i5jfHSnoyKwBRhZiwSQuRr2iMAGuH24seY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=HbWJ0LPz reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Bn0nc3yK; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1729845695; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=; b=HbWJ0LPzbwIqRBQfiOywIUsa6F
	j+2DwFjwqU5vC2Z3HQes1IfwwBShXsWmqtaVXEG8QfmesykkCiTKGf5RafHzfn9jPrn14gI49CZOt
	tvo3ieUyrF3saLox2yCaxQxsj+dvwS30TjJjCeiZxf84kdWdEHBiNT6IpNyAbBdFT2UpTYr/IM+lu
	pVA0KxXBGumxHbF9WbWxXXIGeW9FdMcQIrDR4UuPF5B11suJYoTIb3CXFu5GiTkdfdlTqa0MND8HC
	RjW3Xqxf13JnifppYlwuVxccqFhg3STaTcqTvP7DxOmBOmdo/5u1bmwH76h0VSeNGohG1y6wztX7y
	tYETIlkQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1729844795; h=from : subject
 : to : message-id : date;
 bh=wm5L+Qoo/ioFGQt3DT4pcDXXIVurmW309DoYLq1KaIc=;
 b=Bn0nc3yKM242yCWOBxjqLZEb5fX533AokcAKUoMEtY0kv9H9jQHMgxY05J4VQgVgxR6JW
 WzHvRCQPdN2LhUGEeuG1EsiZW0qnAbGqHLahu0DJ3DTf1LkBw6wuLYyHNzKLBITXKqghRT1
 uE6arEIxw+IIQgmIfSNGlqao4AWhRTmX2PvLrGdxbYS0taLV803Sid7IKgHFNvAwfZbPuQY
 P0INrPeLGRDAcbBgMZJOI88hlO6hBCFT3Zle0Rmjepzd7OPPrL+EV83XPU4UxWfSvuM4F7f
 1vAqYwD2TLsixJY+9FqAmJ0pdBKprhjObvyNLBrcoFmZbsxxLtC5runF04yQ==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4Fe9-TRjx1p-TM; Fri, 25 Oct 2024 08:26:13 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1t4Fe9-AIkwcC8o9IX-JQxw; Fri, 25 Oct 2024 08:26:13 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Cedric Veilleux <veilleux.cedric@gmail.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 0/2] Improve ath10k flush queue mechanism
Date: Fri, 25 Oct 2024 10:23:46 +0200
Message-Id: <cover.1729844329.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: f0ao_RGGBaGt.lG2zTGDxzqSu.gBhrvg3DpMB
Feedback-ID: 510616m:510616apGKSTK:510616sq2b0s9roU
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


