Return-Path: <linux-wireless+bounces-14274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 984FF9A6C2F
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 16:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7E281C208BB
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 14:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756371D7E5B;
	Mon, 21 Oct 2024 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="jsdaLZuD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net [178.154.239.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66810A1E;
	Mon, 21 Oct 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521274; cv=none; b=GAeErpU+0QB7R7b8fEECcO2HAuwi8+ubOoPq/JsOpgSttyyhvvPV5wwp9VPZ1dJsRMRGjprhSyYQwPLyA1DTcSx52qgz1nq721i8plc0k/PbglSrQDSkj2MClYIhb9InEBsRaWZdS1IMHItWub8DXyQdrijG1GTSpHUq6dAQ1Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521274; c=relaxed/simple;
	bh=yMAItFyhgpcqTSt4usJTGu4wJeWl8vY6+wsPHFvrQcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mHWezZYPY57uuNGIXSQIqRVASZIppQVJPX0pKMCJWiHJjpP+wR5V/bMowoTVtxqKKaAtHgLLKskLz4lS68mJY8XgD0ODNSgHLK/BLFFavDYdAxMYw6Y4UVnhYGfdpW/gEtxq5lSd5hUw+tXupde4oGu91i9wD5fM6lh+H357uj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=jsdaLZuD; arc=none smtp.client-ip=178.154.239.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:2911:0:640:4396:0])
	by forward101b.mail.yandex.net (Yandex) with ESMTPS id 73CCB60C70;
	Mon, 21 Oct 2024 17:34:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KYSvOR0ZrOs0-EbiNDfsF;
	Mon, 21 Oct 2024 17:34:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1729521263; bh=14zwWzswHzIcwUFXjbeP04U1XnUpSaYwD4URdYf6QW4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=jsdaLZuD+Uu4KiVnFzmF4AtgLulIA9za2zriNc4zrGcEuOTtKxOkWRdwZdoVCWGJ8
	 RovmcOy8KTfTmXXqA7KtnZq70hn/+lp1s7EjPTG5MheN9gEL3PsXShbSTsgDPswQjJ
	 dW+ONP53WUTZO0xTvkWBjKox2XLxYZi7GdSYpMok=
Authentication-Results: mail-nwsmtp-smtp-production-main-25.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath12k: annotate skb of struct ath12k_ce_ring with __counted_by
Date: Mon, 21 Oct 2024 17:34:18 +0300
Message-ID: <20241021143419.587716-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accorind to 'ath12k_ce_alloc_ring()', annotate flexible array
member 'skb' of 'struct ath12k_ce_ring' with '__counted_by()'
to improve runtime bounds checking when CONFIG_UBSAN_BOUNDS is
enabled. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath12k/ce.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/ce.h b/drivers/net/wireless/ath/ath12k/ce.h
index 857bc5f9e946..6967e3891030 100644
--- a/drivers/net/wireless/ath/ath12k/ce.h
+++ b/drivers/net/wireless/ath/ath12k/ce.h
@@ -135,7 +135,7 @@ struct ath12k_ce_ring {
 	u32 hal_ring_id;
 
 	/* keep last */
-	struct sk_buff *skb[];
+	struct sk_buff *skb[] __counted_by(nentries);
 };
 
 struct ath12k_ce_pipe {
-- 
2.47.0


