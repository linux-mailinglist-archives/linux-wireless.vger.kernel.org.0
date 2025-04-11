Return-Path: <linux-wireless+bounces-21424-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F30A854A5
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A08A1883CE8
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1434227CCD3;
	Fri, 11 Apr 2025 06:49:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2A27D787
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354196; cv=none; b=mzZOyYtWPBQvwyrMZ7aJUBti4qdjd09l/VqicHzRAh91OEeRoKUw4bRbyhyGpU7tTXBBbAnmYFbAj6RC1RbQid6lFWrwB45HeBxoL3T5k9VFdbEE5yBsqWJP3QESvbUPdc4jz+o4d1n0smMhJU4S5+cuC362AWu44xZmFnTKLRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354196; c=relaxed/simple;
	bh=XV+2iCr69t+gaddiA6idm+TI/+B7jKqSOS6iARUWPd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jqwj/sr9JSohbsI83CAAeARec95rMVydDlhZdPXALm8YuRLLAUNL1kYWVAftuElBXM7dWotFdQ2oi20D0WZXCv2qS7KKpnEMlfx6PakO2JMIvhrZJ7bddCj0TWPZrlyidfLltTdsJvFBzk7jiFsSWDOkzZlE9P1HKDys0s2gRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1u38Ct-00023K-Do; Fri, 11 Apr 2025 08:49:43 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u38Cs-004OIR-30;
	Fri, 11 Apr 2025 08:49:42 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u38Cs-00CB57-2h;
	Fri, 11 Apr 2025 08:49:42 +0200
Date: Fri, 11 Apr 2025 08:49:42 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: Re: [PATCH 3/4] wifi: mwifiex: drop asynchronous init waiting code
Message-ID: <Z_i7hvpeCvSqtuTl@pengutronix.de>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
 <20250410-mwifiex-drop-asynchronous-init-v1-3-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-3-6a212fa9185e@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

On Thu, Apr 10, 2025 at 12:28:45PM +0200, Sascha Hauer wrote:
> Historically all commands sent to the mwifiex driver have been
> asynchronous. The different commands sent during driver initialization
> have been queued at once and only the final command has been waited
> for being ready before finally starting the driver.
> 
> This has been changed in 7bff9c974e1a ("mwifiex: send firmware
> initialization commands synchronously"). With this the initialization
> is finished once the last mwifiex_send_cmd_sync() (now
> mwifiex_send_cmd()) has returned. This makes all the code used to
> wait for the last initialization command to be finished unnecessary,
> so it's removed in this patch.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/net/wireless/marvell/mwifiex/cmdevt.c  | 16 ----------------
>  drivers/net/wireless/marvell/mwifiex/init.c    |  5 +++--
>  drivers/net/wireless/marvell/mwifiex/main.c    | 12 ++----------
>  drivers/net/wireless/marvell/mwifiex/main.h    |  6 ------
>  drivers/net/wireless/marvell/mwifiex/sta_cmd.c |  4 ----
>  drivers/net/wireless/marvell/mwifiex/util.c    | 18 ------------------
>  6 files changed, 5 insertions(+), 56 deletions(-)

The following hunk is missing in this patch. Will add next time.

-------------------------------8<-------------------------------

commit 707b4d85612123bee63b79947cb036211b59152f
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Fri Apr 11 08:47:59 2025 +0200

    fixup! wifi: mwifiex: drop asynchronous init waiting code

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index ff094b5c32239..73298b0769c94 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -584,14 +584,6 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 	if (ret == -1)
 		goto err_init_fw;
 
-	/* Wait for mwifiex_init to complete */
-	if (!adapter->mfg_mode) {
-		wait_event_interruptible(adapter->init_wait_q,
-					 adapter->init_wait_q_woken);
-		if (adapter->hw_status != MWIFIEX_HW_STATUS_READY)
-			goto err_init_fw;
-	}
-
 	maybe_quirk_fw_disable_ds(adapter);
 
 	if (!adapter->wiphy) {

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

