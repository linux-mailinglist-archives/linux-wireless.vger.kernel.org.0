Return-Path: <linux-wireless+bounces-20491-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40506A66FCE
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 10:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833AD3B2B43
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3EF1A83FB;
	Tue, 18 Mar 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NSyrVOBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB16F1A7249
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290227; cv=none; b=FP6cy/AE1kMx5jby+xlZ9XvsyQ0QbQwou5k4KSBVLRdQQPOyjmIEJhtbxsAq61fp0LiJ0J06qANixzEJp54wID5rXDNDvWjPHrOj4dlCWApdmBPTr4UJB8CREUf19Vcjq9Rfn0G/eBUBPWIQ0ZPJuDmwTSeocu1SP1D9nqISI8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290227; c=relaxed/simple;
	bh=BKn+DKoO/NFMvIoc+KlDc93eFilB2xm+mKiXhe1Vrx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HlsWWqqC1V2tiqKJ7BDtaJWGr8ngedhO36B/7y/7IIJoijPxORPIVpRKUFa7xQlikDRg623jiA99KvV7WTCRAQznDlWMhCdjSMCX+Bs/TeA1SYZUmgvHGot5tfBPPyKkmAqCU7L2jY5711zv5Jqu3j345HCqas9O3WtbVyfgLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NSyrVOBY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=BKn+DKoO/NFMvIoc+KlDc93eFilB2xm+mKiXhe1Vrx0=; t=1742290225; x=1743499825; 
	b=NSyrVOBYoU0FL2xOtlf/dlNUOUzyTMOofBXfGb75LmJZ444Y0xQBZGj5o9FDo/73WdGMbnzAD1S
	sxv/S68MVERUvdN5fuoE7NepM1k8XPRZHmymmDOZFv4kTjD2gnNqqP4RmeHumowaIrrgbjoggcwGE
	sVnZKMLLRSCSGTlfKrGFofEGbg7T/jkdkQG28g8IoKP41U2oCtYpkvKT0H/Yqce2MEUlC8pSoPYpu
	BP5qcmRh06G9OHGFqLntzhhApWYJrsFpUSl68J81IIZxoG/E4fize58ERaaTUbT6KogAs5kJK6a7W
	zm3G5g2M9n6UXtUaHTtpriigEUD1mIMvATqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tuTHB-0000000FBmW-03PM
	for linux-wireless@vger.kernel.org;
	Tue, 18 Mar 2025 10:30:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/2] wifi: iwlwifi: update MLD selection
Date: Tue, 18 Mar 2025 10:29:42 +0100
Message-ID: <20250318093019.185216-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to iwlmld not working right, and the FW going to be frozen,
use iwlmvm for older radios.

johannes


