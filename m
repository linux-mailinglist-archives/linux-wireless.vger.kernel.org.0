Return-Path: <linux-wireless+bounces-29806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACF2CC3854
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 15:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B92308EAF0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 14:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2148332D7F0;
	Tue, 16 Dec 2025 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nTTfx7K2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001C315D32
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 13:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765893550; cv=none; b=nTgaY4nwgB1slYdH2pP7vGJkTcoZ4Ovi3kA+XJ3QDW67mzFwJ7atJNhh+CkttHpk2/9xIY/M531DyyjYn7Bt2tt5f+eBt6J/VD2CVb6ezkMV7YKDxGKTqAK0vWStv2KmDfZ3EQRfwPsslg4Dv9C4lNHxnfaXqQwX38dfFEpzBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765893550; c=relaxed/simple;
	bh=4t4hgE7JIRdWxX8jIrI6awq4ArUbrNmKQj0CpdNDs+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Fm9UcJBIJtzETngEuuA3XQjRYMvXBB+CE+nZg7g5ti7S8DBN1mJ307i1ZdU8/8B7mOkuGecKGObAP3eKvA0qwGX6dg7bnO67FlgZaaVSNyPfPWxCDMAJ3n8qIwhN3Ssy5lW5ia4FME9rmtQ+uGvdl/RKSXIx4Ff/2HrYRQfDNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nTTfx7K2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=4t4hgE7JIRdWxX8jIrI6awq4ArUbrNmKQj0CpdNDs+4=; t=1765893549; x=1767103149; 
	b=nTTfx7K2G0FAbIpiRKLP8gsG2QP0RLS8intI4ya+yMFDQXjojZPhRorzHeFcC3JvdhP9woQURr2
	xC5OvDra9BtP/p4GK4XNqh9mtlNK58FeA6KJpSt4+QOUqscTDnz1EsdVf5mYBjISFtfzHX8ZKhYeN
	Aaopxj+K4kUm8NJKloYOkEMimiNw1ej06tD85EQu0YxtWP+t1UCOhl62sfwuzffAeKcF4e4u/Y2Zy
	futxo7qBgIUxNMQq0DTIxmIROHxvqcTKJFxXKSYTJDXk6iKS/szpsp1H7dYDWjDhIHMCeA2oD6GCs
	hNT+1aG3p8Cn4el3ecMqiYdzvAXLSQh40ilg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vVVZy-0000000ATCz-0dGd
	for linux-wireless@vger.kernel.org;
	Tue, 16 Dec 2025 14:59:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC wireless-next 0/3] wifi: initial UHR support
Date: Tue, 16 Dec 2025 14:58:20 +0100
Message-ID: <20251216135903.33782-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As promised, here's my version.

I think the focus was different for some of it, I did the rates
and not all of the AP side probably, please take a look.

johannes


