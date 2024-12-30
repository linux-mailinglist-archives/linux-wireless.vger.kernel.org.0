Return-Path: <linux-wireless+bounces-16905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B87F9FE9E9
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345E57A042B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15E81632D3;
	Mon, 30 Dec 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiCd3IG5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB91514F8;
	Mon, 30 Dec 2024 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583779; cv=none; b=Ma0cV2FHuPGgThhQ0xSdrtPkG31LtqJug+W0skYv/I1uF6Hex44wcqYhOknZN6Ig+KUOalrTItXuXxM9tfqRgvEB6DKk3YE4JsoyGj3Mw8vHKunYxGme768YzrjKGI0lC63RTIziFFoCbK0FVhzsschGi2S6o6qUxSgu39H5BP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583779; c=relaxed/simple;
	bh=25dKQ7SGo1s/N7uEwO1Z+IN2LlXHgxZ5W+bD42N7Fj8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXUO+obH9sjSCsFiO7Zr5EQusHrLpY3Zhy7J62htoeCZ5gHPXeOqXZ9GjaxnCqGlvGorH93UeqF9f1DMnQehbBsDB8Ozt77scSkoNfIrcImizR26cqIkx5E8mh05rGlTbWu6HYkNWAaCF93tif4yjIhYr7QFAzHFjOYzR0iQBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiCd3IG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57906C4CED0;
	Mon, 30 Dec 2024 18:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583779;
	bh=25dKQ7SGo1s/N7uEwO1Z+IN2LlXHgxZ5W+bD42N7Fj8=;
	h=From:To:Cc:Subject:Date:From;
	b=oiCd3IG5VMgJZXvUYuwn1ljHT1ngA9j4Y4zaHkOWDGk/DTnlk90Q0LFCUrneNsBdj
	 iA+aqslinrj0s1gpBkqjAf9PN1/R1tin0zeQumW1u/TtSEkbJS5LV62Lt/XcTtVJuL
	 iMTOjuSbify2yv/8XLoqzRssFSsGNo4aQ8BXIo0fy2AWo6a9CQqEnxV+KmFFXACkvy
	 FS5QXUddaTvS2MXaoDctx4+HfZn6jNeXEOU2Q3QXCJMTRuhMAzfgbzbPTe9+6bNATP
	 IyjQ49JoqifS3wJjKyY/XvIF3zuyN8Q2qloArMqFV0iC2C4uAMg86Xv2YaTlZ/VgSm
	 Y0vt8qCVnMKsw==
From: Kees Cook <kees@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kees Cook <kees@kernel.org>,
	John Rowley <lkml@johnrowley.me>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] wifi: cfg80211: Move cfg80211_scan_req_add_chan() n_channels increment earlier
Date: Mon, 30 Dec 2024 10:36:14 -0800
Message-Id: <20241230183610.work.680-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=kees@kernel.org; h=from:subject:message-id; bh=25dKQ7SGo1s/N7uEwO1Z+IN2LlXHgxZ5W+bD42N7Fj8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlFL2SVxOReND2+OklMzqhIOSurW/mdxCXNUwpNBlzC3 y7yufd2lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATOSNFiPDY4Fgkd3/WR/tW3T8 YPrkLx9rOs3Y9v5KPKW213hx2J0HaQx/BR5mcG66yM7Mx5Nza1Fl04tZ6WU33rdd2bLj7snUTwc SGAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Since adding __counted_by(n_channels) to struct cfg80211_scan_request,
anything adding to the channels array must increment n_channels first.
Move n_channels increment earlier.

Reported-by: John Rowley <lkml@johnrowley.me>
Closes: https://lore.kernel.org/stable/1815535c709ba9d9.156c6a5c9cdf6e59.b249b6b6a5ee4634@localhost.localdomain/
Fixes: aa4ec06c455d ("wifi: cfg80211: use __counted_by where appropriate")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 net/wireless/scan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 1c6fd45aa809..ccdbeb604639 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -763,12 +763,11 @@ static  void cfg80211_scan_req_add_chan(struct cfg80211_scan_request *request,
 		}
 	}
 
+	request->n_channels++;
 	request->channels[n_channels] = chan;
 	if (add_to_6ghz)
 		request->scan_6ghz_params[request->n_6ghz_params].channel_idx =
 			n_channels;
-
-	request->n_channels++;
 }
 
 static bool cfg80211_find_ssid_match(struct cfg80211_colocated_ap *ap,
-- 
2.34.1


