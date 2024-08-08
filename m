Return-Path: <linux-wireless+bounces-11150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661794C6CD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 00:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270CCB2103D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D094B15D5B8;
	Thu,  8 Aug 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX4NJJW1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361555769;
	Thu,  8 Aug 2024 22:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723155078; cv=none; b=JrgVehyXAGC3sQqUSbxIoarwwTmRlHScM+KFaTifj3Npb4tO6E2/iK3T2EFJuiMpqjac4oYuseRcs0Tw7zkJID0hHdqAaPRJbzt2sgBEEpVHnWh0kNGdfn35X2551C9nKUWgcwKhJI9P2B4znJ81VJDjSUHoWmWfWkrI3YHpN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723155078; c=relaxed/simple;
	bh=e/zB+LA0zHnznYATwpefdryXkaCV34ukyDo/MVUOmQw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AawJchib25CBUWblze6uX0K0Tk5r57CvuVY1HSHdfIj4PnV0nVFfiZWyX0b0QXoWliiEh5e3BMd2X0HOBirMDc0M+y53S6v9+9xSYGppu0mVVwsw5v7lFIyqNOR8PmVED9Eg9D5AtBf7FPeQQXv3vPty0AN2aLIDqGT09Xy/2Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX4NJJW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA8DC4AF0C;
	Thu,  8 Aug 2024 22:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723155078;
	bh=e/zB+LA0zHnznYATwpefdryXkaCV34ukyDo/MVUOmQw=;
	h=Date:From:To:Cc:Subject:From;
	b=hX4NJJW1aRWhgoINveO9UKbxkL3kdDnaBXF1X8cxVAnBsW+CdrojX0ciMUjV0qRhS
	 6z+Hi1iDIXwBP3dn95oFfGK3tgchLZ+mOmiTkI8/1luHpWvh/tSwQFy6Z734Ea3hCe
	 iD4oJ6ksCoTArsuwa7jIGLLvZuv8qw48b979cJNk1nSPE5YsQPwP7zKZl5IsQs/rss
	 1KOxwj9wAeYjwsmnx801l7NtmucULMwsP4xTGImbhZUmdrFp2IqAGHO9GqrTxh+P9Z
	 BmR+XouxkwxEFc+VPinoL7o2gXZwntfGbrj/4t+BTfITtMKDYUwig1qb2i8GQj+vjD
	 fY7LbFQF3+sIg==
Date: Thu, 8 Aug 2024 16:11:15 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: mwl8k: Use static_assert() to check struct sizes
Message-ID: <ZrVCg51Q9M2fTPaF@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 5c4250092fad ("wifi: mwl8k: Avoid -Wflex-array-member-not-at-end
warnings") introduced tagged `struct mwl8k_cmd_pkt_hdr`. We want to
ensure that when new members need to be added to the flexible structure,
they are always included within this tagged struct.

We use `static_assert()` to ensure that the memory layout for both
the flexible structure and the tagged struct is the same after any
changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/wireless/marvell/mwl8k.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index b130e057370f..bab9ef37a1ab 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -587,6 +587,7 @@ static int mwl8k_request_firmware(struct mwl8k_priv *priv, char *fw_image,
 }
 
 struct mwl8k_cmd_pkt {
+	/* New members MUST be added within the __struct_group() macro below. */
 	__struct_group(mwl8k_cmd_pkt_hdr, hdr, __packed,
 		__le16	code;
 		__le16	length;
@@ -596,6 +597,8 @@ struct mwl8k_cmd_pkt {
 	);
 	char payload[];
 } __packed;
+static_assert(offsetof(struct mwl8k_cmd_pkt, payload) == sizeof(struct mwl8k_cmd_pkt_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * Firmware loading.
-- 
2.34.1


