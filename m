Return-Path: <linux-wireless+bounces-14567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD859B124C
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 00:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD131C21238
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4F21C174E;
	Fri, 25 Oct 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLWUMbE9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7661217F53;
	Fri, 25 Oct 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893954; cv=none; b=At1bHCcHCOJ5Nw0GIzN6zR/12B0YN5Bh4wXtsyWbI2ybhfNeiU8OsYp2Mv+GtA9TmO3lmxylEiU2stj95SQhjg7sSlxIu4nCGRfEEelMeUEI+ugz3iLR2WrQqpXlmO9c1S9h1Yu9W85PgeVz8pfe9oAKqZmI++mHGjIEPD/kh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893954; c=relaxed/simple;
	bh=FC/t5CIaNNudWpigYqqneQEUamxykiRhAYd41d/2WrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZWqkYOtePdadAj097c/GBJdIpYy9dt3EvcSzdbOesRqKJrFShq5hzC2NvVLAp+8c95oqRvuu0BwPIp3wg2/LwED8LXdlrhZ6OwULj5lLqYeTnXTf2oefZB5Pbm1uHoPA4Xu+aBOqREHD/6OXp39uAKKqa6tNzlO3Wq8849tDZZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLWUMbE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E83B8C4CEC3;
	Fri, 25 Oct 2024 22:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729893953;
	bh=FC/t5CIaNNudWpigYqqneQEUamxykiRhAYd41d/2WrM=;
	h=Date:From:To:Cc:Subject:From;
	b=SLWUMbE9lrThVgyiRhzZA/O21a3GoxeJ1NYB5+De1PjiiAE+TLQBnjvyeHro9mRXi
	 ROenmcDxUuPRGGpBq+7Lsa9WgRalgwpB7huiFNyxETiiQzUj1VBjuopd/9dw9koRjp
	 ITxX48QD/+JcdBPdJQhQCbBDMB92M0R9IcVnx2QtWe0hjQ6GSsRoW2mzrx3WnudhXI
	 Tiz/yn2QsCKxpkUXx4SAjDV1DcdqKryn1MBgmsugIuKpRM/QQphyW7HP9+39h5xezw
	 lo/SOLWmjJI8OUNPfGAu0kpPYMvdWvwAR0a8z42SanywiEPJFXbOqP1zsHWYLNoaya
	 9mtgZLWnsK6sw==
Date: Fri, 25 Oct 2024 16:05:50 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] wifi: mac80211: ieee80211_i: Fix memory corruption bug in
 struct ieee80211_chanctx
Message-ID: <ZxwWPrncTeSi1UTq@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Move the `struct ieee80211_chanctx_conf conf` to the end of
`struct ieee80211_chanctx` and fix a memory corruption bug
triggered in `hwsim_set_chanctx_magic()`: `radar_detected`
is being overwritten when `cp->magic = HWSIM_CHANCTX_MAGIC;`
See the function call sequence below:

drv_add_chanctx(... struct ieee80211_chanctx *ctx) ->
    local->ops->add_chanctx(&local->hw, &ctx->conf) ->
	mac80211_hwsim_add_chanctx(... struct ieee80211_chanctx_conf *ctx) ->
	    hwsim_set_chanctx_magic(ctx)

Also, add a code comment to try to prevent people from introducing
new members after `struct ieee80211_chanctx_conf conf`. Notice that
`struct ieee80211_chanctx_conf` is a flexible structure --a structure
that contains a flexible-array member, so it should always be at
the end of any other containing structures.

This change also fixes 50 of the following warnings:

net/mac80211/ieee80211_i.h:895:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for MLO")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Add `Fixes:` tag. (Johannes)
 - Update Subject line and changelog text to better reflect
   the severity of this change.

v1:
 - Link: https://lore.kernel.org/linux-hardening/Zxv7KtPEy1kvnTPM@kspp/

 net/mac80211/ieee80211_i.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e7815ffeaf30..c65adbdf2166 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -892,9 +892,10 @@ struct ieee80211_chanctx {
 	/* temporary data for search algorithm etc. */
 	struct ieee80211_chan_req req;
 
-	struct ieee80211_chanctx_conf conf;
-
 	bool radar_detected;
+
+	/* MUST be last - ends in a flexible-array member. */
+	struct ieee80211_chanctx_conf conf;
 };
 
 struct mac80211_qos_map {
-- 
2.34.1


