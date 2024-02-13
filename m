Return-Path: <linux-wireless+bounces-3562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F019853870
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D0D1C2615B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A317B5FF17;
	Tue, 13 Feb 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YXBv5nQ+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE65F56B;
	Tue, 13 Feb 2024 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845793; cv=none; b=MHf4HE6asIjiG8dU2TQB1ry70/6AJxLDwcKyVhY3HZFwLpQ7ZFdWSFdrUdo9/IT88/mGQlZrUXQ3o3q8k8M0Pkg8OqGYQc1DUQp7YUeaUwWue7Z2zYZTCg1L9pp1C7YsfFS9r1FodcOyF5HnG8Sf9Lz9kpSPMLQnM9cSSapu9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845793; c=relaxed/simple;
	bh=dRYnGlZwBbQUU50vYG5nu0Z3/o+/WT6EJp0GaSzSIUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtBVCO/J9QHVreivKYJHLJKqCzMfq575vniK6VUIiynydLfE3HP4JVep12XSeZ8G3Aov1291C+Akj25tOg1cN9rfE1rRhgQoZP4E9xUYNdYyBSZZG5nsAN7P/vqfKNjpvBLAclAVEm6qRbAn3AN0A1gGnTjjHIs234AqLTZyBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YXBv5nQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AF2C433F1;
	Tue, 13 Feb 2024 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707845793;
	bh=dRYnGlZwBbQUU50vYG5nu0Z3/o+/WT6EJp0GaSzSIUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXBv5nQ+AaCq+0UGiHzJlWI9jUGaRwYMP1A/KPnQPF/D24qWGiyCvmoPsdXE6Fwl0
	 29x9xVlXxqHPT7ZBfyQ5kxXJXxxT3krZLuy7JY3qfAfspXFwnf6M3lWw2cr6rFp668
	 ppaca09ni2pBh+fuGXVuAw3A5BfD9FUwpTEzTkEM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arend van Spriel <aspriel@gmail.com>,
	Franky Lin <franky.lin@broadcom.com>,
	Hante Meuleman <hante.meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>,
	Ian Lin <ian.lin@infineon.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Wright Feng <wright.feng@cypress.com>,
	Hector Martin <marcan@marcan.st>,
	linux-wireless@vger.kernel.org,
	brcm80211-dev-list.pdl@broadcom.com,
	Kees Cook <keescook@chromium.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 030/124] wifi: brcmfmac: Adjust n_channels usage for __counted_by
Date: Tue, 13 Feb 2024 18:20:52 +0100
Message-ID: <20240213171854.611417368@linuxfoundation.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240213171853.722912593@linuxfoundation.org>
References: <20240213171853.722912593@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 5bdda0048c8d1bbe2019513b2d6200cc0d09c7bd ]

After commit e3eac9f32ec0 ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by"), the compiler may enforce
dynamic array indexing of req->channels to stay below n_channels. As a
result, n_channels needs to be increased _before_ accessing the newly
added array index. Increment it first, then use "i" for the prior index.
Solves this warning in the coming GCC that has __counted_by support:

../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c: In function 'brcmf_internal_escan_add_info':
../drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:3783:46: warning: operation on 'req->
n_channels' may be undefined [-Wsequence-point]
 3783 |                 req->channels[req->n_channels++] = chan;
      |                               ~~~~~~~~~~~~~~~^~

Fixes: e3eac9f32ec0 ("wifi: cfg80211: Annotate struct cfg80211_scan_request with __counted_by")
Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Cc: Ian Lin <ian.lin@infineon.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Hector Martin <marcan@marcan.st>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://msgid.link/20240126223150.work.548-kees@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 667462369a32..44cea18dd20e 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3779,8 +3779,10 @@ static int brcmf_internal_escan_add_info(struct cfg80211_scan_request *req,
 		if (req->channels[i] == chan)
 			break;
 	}
-	if (i == req->n_channels)
-		req->channels[req->n_channels++] = chan;
+	if (i == req->n_channels) {
+		req->n_channels++;
+		req->channels[i] = chan;
+	}
 
 	for (i = 0; i < req->n_ssids; i++) {
 		if (req->ssids[i].ssid_len == ssid_len &&
-- 
2.43.0




