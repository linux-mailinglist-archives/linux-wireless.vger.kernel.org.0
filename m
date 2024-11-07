Return-Path: <linux-wireless+bounces-15089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880969C079A
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 14:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA92E1C22D35
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07030212623;
	Thu,  7 Nov 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FvHK6Rg+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4342B212183
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986432; cv=none; b=J/oyJHBw9w6TO4EyO61R3PaI2NQSZ0hVBIfZFg9sBqqlyX8nLLmE61pbHWxyevpBMeAiue1CHVD+Apywfc97FHQePgUiYa3qe6SNHWKqd5nYAVBNJMomCZB/pUi1R1TrKXt9HBDGn78pYB75n4k/K0b7jKek+1bqFoMe8Sh57jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986432; c=relaxed/simple;
	bh=DHFZyEm/apIJ/dTvbijqwmQUA2e7pWObYwPzrk3pPXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=imyYXuc4PMepNW5fIRTnhYgKsyN+v559B8w/YT8P/2SsS20GwmzdYKyICREhMn9eAp+Xkgaj13cB1/dLgqqtLpAm6nOAbS6TqDroCtTyJSNgE5hOfo2gD/IwIEmGNE3KkcpdlBa3TaWwBhgSZlSci0ysJqoZAc5whRuzu8Hvz40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FvHK6Rg+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DNfyb8bUHFkUSScg467npum/PYZA6co9bIdPu4qi2Xo=; b=FvHK6Rg+mwBCESdI94GEaLeXhJ
	YmVE6Y21Sxr+CIiKMjUA25wQqbbE7urTUTW1JECUHHdKpsjLxZL72IE6OHyOMogErH45Gw4MJY2qf
	WQR3/6g+Q3DyWDHWxwWEHBVp/DVp5C1bEQa30dZCgW9JYmFJhyzZekzz8C7Np0PKtEiVoJnSo+r2w
	OUEnQCg452QgzeqQzzmGKM1d1gsAFVHdILS4g7+iWgUfTxcVTZDDUytS0bLMA6MbGx05qFwRticMx
	pVCeqTtgS8MMBlV2Af9X/ZR+02CN4Pis7+nffUErMt1tnw1kGWL62pbYu3mKyoK6xBwiaAXd5FAST
	gnOxdq0g==;
Received: from 179-125-64-253-dinamico.pombonet.net.br ([179.125.64.253] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t92dw-003Zsz-Mr; Thu, 07 Nov 2024 14:33:49 +0100
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-wireless@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH net 4/5] wifi: rtlwifi: fix init_sw_vars leak when probe fails
Date: Thu,  7 Nov 2024 10:33:21 -0300
Message-Id: <20241107133322.855112-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107133322.855112-1-cascardo@igalia.com>
References: <20241107133322.855112-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ieee80211_register_hw fails, the memory allocated for the firmware will
not be released. Call deinit_sw_vars as the function that undoes the
allocationes done by init_sw_vars.

Fixes: cefe3dfdb9f5 ("rtl8192cu: Call ieee80211_register_hw from rtl_usb_probe")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/net/wireless/realtek/rtlwifi/usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index c27b116ccdff..8ec687fab572 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -1037,6 +1037,7 @@ int rtl_usb_probe(struct usb_interface *intf,
 
 error_init_vars:
 	wait_for_completion(&rtlpriv->firmware_loading_complete);
+	rtlpriv->cfg->ops->deinit_sw_vars(hw);
 error_out:
 	rtl_deinit_core(hw);
 error_out2:
-- 
2.34.1


