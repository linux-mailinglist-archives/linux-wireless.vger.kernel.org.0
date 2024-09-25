Return-Path: <linux-wireless+bounces-13191-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D72985F7B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 15:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC4E1B24B4B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15A1B81D1;
	Wed, 25 Sep 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwfYVXo0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FA681AB4;
	Wed, 25 Sep 2024 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266303; cv=none; b=VWjD112Lc4ePs9tD+eWErj3/D52NW4eeha045+xSKPC+gwjXdgUQUcLn5um2Xv3VmrVrEVHbsqTDbr9BHa02Q/pfXTensoaDkbThQCBvGNBKh3hyXSw9RylDjS748hFJ6KKr8LujQhbLnmfGafiZpJhPF5fKapEhrh0yc4VlPXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266303; c=relaxed/simple;
	bh=U+rvZzn6/BrS96eqqGrwgAfbHccXvZl8J/7QiI9Q0tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy92jE/Ox1+U9Rn9wxFqYTKrsBdKxqMhboJYQ/DYSC6gS8Ak2QAXOfsxKJIWHNr7b1mP9p9Ml02K6nhn46FPvS6XXsMI8ON+faKAQaQAD/c6aKqWHkflABJpwwYUhdw185uzRxjmr0DOdkV4bS3WVgnVnv04TVbhqGkYAOh0388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwfYVXo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BA2C4CEC3;
	Wed, 25 Sep 2024 12:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266303;
	bh=U+rvZzn6/BrS96eqqGrwgAfbHccXvZl8J/7QiI9Q0tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AwfYVXo03XcgXN6uElq5ubHfgJYMMeLQeG94x3YAVsXJsyHs5Fnwzki7SjPjJsZCh
	 T1fT2WCRum+tLvwG4iEdAKOjf+BeGpoBlbQR5OGq7SQW681R5OcMKVucZaB+HFRtOk
	 /LP1Z3UD4KIt7ESAikC7/3S669xpAc967e9jgupKl8TetvVxICfzCcSOBLJgebSFiq
	 BgrRUt0ojh3ZNs7YmFhYwrSBAzxzzP4gfFsMhjbzE5jVeBxqbN3ZApIOtwYKzVU0La
	 G0L/xzts8bgKuC6086R7ONtkQu8isykdi8n5amNEiYjIho/uxlfry12zSlfDwtrtUV
	 pfNAb5nWS5KlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	toke@toke.dk,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 003/139] wifi: ath9k_htc: Use __skb_set_length() for resetting urb before resubmit
Date: Wed, 25 Sep 2024 08:07:03 -0400
Message-ID: <20240925121137.1307574-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 94745807f3ebd379f23865e6dab196f220664179 ]

Syzbot points out that skb_trim() has a sanity check on the existing length of
the skb, which can be uninitialised in some error paths. The intent here is
clearly just to reset the length to zero before resubmitting, so switch to
calling __skb_set_length(skb, 0) directly. In addition, __skb_set_length()
already contains a call to skb_reset_tail_pointer(), so remove the redundant
call.

The syzbot report came from ath9k_hif_usb_reg_in_cb(), but there's a similar
usage of skb_trim() in ath9k_hif_usb_rx_cb(), change both while we're at it.

Reported-by: syzbot+98afa303be379af6cdb2@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://patch.msgid.link/20240812142447.12328-1-toke@toke.dk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index e5414435b1414..ab728a70ed279 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -716,8 +716,7 @@ static void ath9k_hif_usb_rx_cb(struct urb *urb)
 	}
 
 resubmit:
-	skb_reset_tail_pointer(skb);
-	skb_trim(skb, 0);
+	__skb_set_length(skb, 0);
 
 	usb_anchor_urb(urb, &hif_dev->rx_submitted);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
@@ -754,8 +753,7 @@ static void ath9k_hif_usb_reg_in_cb(struct urb *urb)
 	case -ESHUTDOWN:
 		goto free_skb;
 	default:
-		skb_reset_tail_pointer(skb);
-		skb_trim(skb, 0);
+		__skb_set_length(skb, 0);
 
 		goto resubmit;
 	}
-- 
2.43.0


