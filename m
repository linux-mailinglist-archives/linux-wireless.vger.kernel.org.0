Return-Path: <linux-wireless+bounces-5628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F098926E0
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 23:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E471C21046
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 22:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71043AC2;
	Fri, 29 Mar 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="RFrhwXw2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE26028DCA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752057; cv=pass; b=HQ9Rf4GXMGmZmX0/vX1fUMjwcKfJ4V8qgVXJ8xH0k7pngTQOIh+sYt/qOZ34zT/13DI7mVQ3iGOsKCgN7X5IWwvE3dHwwS8ZNFEKWu96j+KesOiDebD0VN05LYSjR29TXU5QyHLtjgn8UzFJcyS6O2s+yK5EvraSiqMt89ev7bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752057; c=relaxed/simple;
	bh=ItmHfWjLdvsILXfC8TgEB70myvuqlP3W2q10z6vMhGw=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=WaDduBwotT24gjzvbJ0mV3WCWCMic5it3SwDpuY/g8YEoVpAG0RKLB+raB6itaLVR5dDKJC4+vjmem0LYDQu4WPFTBIagNyt0q1THsraIMdzyll0U8Y4stiSPFyByaLat/P3OycDTZpG+7txZ4AYi8u5O4r6r/UdTn12XW0muN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=RFrhwXw2; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4V5wNl0jXvz4X1H;
	Fri, 29 Mar 2024 22:40:55 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4V5wNk6xrhz4S4F;
	Fri, 29 Mar 2024 22:40:54 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gn7QOGXaVs/MtoXMsTH/aaRdzuSSvZ+fvGeeVoEHcI4=;
	b=RFrhwXw2sPyHbryVzZEcrhuaruF8U/aOPSsDTTU+pmznBA32uVnDUa3aT1nzASi1e6e3Ol
	IwlwB/rFMIVniqHHWfiMnXyhN2aqc8kG5zD72N1Atrfnv/7xHa0DgEMlBp7BP6ibMmeoNz
	uv7Ay7q8BvRNYlUjdnsEANz6516FC6GLenPPM2Z0x7ntd1T+/rc8gr5uzZ6QbemTvYi+/O
	/r4bLLaYSHten5OFp5J0qO8oF+C03qzNV8EGud7y/Zm+UDoRanVLS2KdOmNJv2jeCcXXQ1
	XZglQM7DLGTCq8HJv4F/dYafT5G6aA9YBg6+abV0qMt1cF9P/wzf6elJt+BokA==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752055; a=rsa-sha256; cv=none;
	b=UmEXp07ypsN0DLz9c8DP2aty0Nh7AWraLE1IFStNvavO0WlI3hrg4ARx7/QKtn+fOWlnSy
	9vEdzGvgee5qbOOw6sn5E7YMaRJcF+LNE67fTua+att+DLevykgmEPZA/kEj2lW8HxgecE
	L48E8kl3r09gkDi1g218YSN7bvTasd8+rrX/RZUC38puKjrTs+2OJUeJ9eJ9B+B1+qXoPF
	F7ZmOy7Fpu/YworeSNsfMryn7yieZxM6k5b28sLFrJynNgL+MZO3JxL+X8maE9M19/oRbK
	JLrhgEvIYc53lBkkUi4LOLEpICPvCrUIsKOMvHsVs4SbcE9kBlJxr0z0zE/gjw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Gn7QOGXaVs/MtoXMsTH/aaRdzuSSvZ+fvGeeVoEHcI4=;
	b=LrZ9+MlAZmqPns3J7n6gVctDms5hjDm+a8sESfdUmookj3Q6d6cxSA9kGZ4ehxipsYx7aa
	2SkJ5HmRPgVLycje4L+3qv2M3dbgMALPvHDfARGJva7PXgRF6nQ2CZKlQwIXX4Oucq3hoN
	22Z51qXzuK0NTWcFFu6eYXTwZiMJsx4NhKvebCGqEeIsmlNl8pnPPfHzbDq89sNl0EQkZU
	iRLPhUu9Fkqmz9EknU8QHpgpYlt1DzXXgBzcwgEMBbbgA0YewPmsHIpwfFpIORQimnsDhq
	g6c1z/B+GGbERljetnt+gA1p671FQOzAvsRoN6CaZ63P4QJOkcfgRj1u05Y8Jw==
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mx1.sbone.de", Issuer "SBone.DE Root Certificate Authority" (not verified))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4V5wNk5xT8zdKX;
	Fri, 29 Mar 2024 22:40:54 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sbone.de (Postfix) with ESMTPS id D3D298D4A162;
	Fri, 29 Mar 2024 22:40:53 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 8F3542D029D9;
	Fri, 29 Mar 2024 22:40:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id Cw5OduCvnU8x; Fri, 29 Mar 2024 22:40:52 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id E8E1D2D029D8;
	Fri, 29 Mar 2024 22:40:52 +0000 (UTC)
Date: Fri, 29 Mar 2024 22:40:52 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 2/3] wifi: iwlwifi: remove function declaration without
 function
Message-ID: <r4q0o9rs-0q52-5125-nro9-p37n72qnn86s@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

iwl_trans_pcie_send_hcmd() is left without an implementation.
Garbage collect.

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
---
  drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 1 -
  1 file changed, 1 deletion(-)

diff --git drivers/net/wireless/intel/iwlwifi/pcie/internal.h drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 7805a42948af..22749a0de78a 100644
--- drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -552,7 +552,6 @@ void iwl_trans_pcie_txq_set_shared_mode(struct iwl_trans *trans, u32 txq_id,
  int iwl_trans_pcie_tx(struct iwl_trans *trans, struct sk_buff *skb,
  		      struct iwl_device_tx_cmd *dev_cmd, int txq_id);
  void iwl_pcie_txq_check_wrptrs(struct iwl_trans *trans);
-int iwl_trans_pcie_send_hcmd(struct iwl_trans *trans, struct iwl_host_cmd *cmd);
  void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
  			    struct iwl_rx_cmd_buffer *rxb);
  void iwl_trans_pcie_tx_reset(struct iwl_trans *trans);
-- 
2.40.0

