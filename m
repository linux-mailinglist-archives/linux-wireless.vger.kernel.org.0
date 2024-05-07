Return-Path: <linux-wireless+bounces-7305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDA8BF06C
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AECEB2347C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4988130E27;
	Tue,  7 May 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBZ84uHN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7900130AFF;
	Tue,  7 May 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122756; cv=none; b=JH0sCLPTZTkiPj/7/vR25XHm+UDHKLs5TT49swC6Qc3rBzXUedaLLineG7NpdxT3ZGdpMMjccKseanfwhSTLWCwDojn8pVe5EFPzXkGrj0S1TxwuCpQwQCTBLKurWxljdL8pIMS+aXIhBXZs9vnkWetU8IJ/YnkqzzKg5dnceCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122756; c=relaxed/simple;
	bh=Z0nBQAKgx03CRJ0iYriHi2duVA4l1ZIJOhuz5ALaiZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRo8/F68e3q4FgLWEYDtYuVEOmr//rmw+kNNdp0qJwGNGUyZrfHJ55byaCgDSH9iu5Si8RzYf/9pvkBTq8jizr6G3Ezgd1yZdeNVAA2B6g9YvKbXt0ORHRuNdcloJpm4PWGGbQn7rCm8O68aUvlI8qFjkh3qHn+MkaeJkRF5MQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBZ84uHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BABC2BBFC;
	Tue,  7 May 2024 22:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122756;
	bh=Z0nBQAKgx03CRJ0iYriHi2duVA4l1ZIJOhuz5ALaiZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dBZ84uHNimT1iYUEu/m6Cu7uDv0zOSMg6VXX02TwYUF0a2vSGpzvs6kBt9GYC6H9u
	 bVpB6b9ubJXQiVSQAe3M+Tuu/XBVBJ5FB3YlYlS0GSr1fYhkwNZjHw2va+TNYMFPgb
	 MMymHnoz4U/cPyxNM1JXVEvlQuEYKq4Mwvlh2jVaOB2i+iefoxykpMln6zsi3RDmV3
	 70MFkkZKYfuU/s3M3kN8PZMmia6wsq5yLm+oMQmBk329XiCQo/yEwmQKGTos6BXzpU
	 +uk/L8rXBVeTOcZOyf4W0E7bHpEKvtvDwfy3ye6kMVrUM8CiQAR883XxNxWhrp12Ja
	 MhYnnk8j/gWdQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/19] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 18:58:25 -0400
Message-ID: <20240507225910.390914-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit 9ef369973cd2c97cce3388d2c0c7e3c056656e8a ]

The declarations of the tx_rx_evt class and the rdev_set_antenna event
use the wrong order of arguments in the TP_ARGS macro.

Fix the order of arguments in the TP_ARGS macro.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240405152431.270267-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 617c0d0dfa963..9c767b91e15d1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1747,7 +1747,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1764,7 +1764,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


