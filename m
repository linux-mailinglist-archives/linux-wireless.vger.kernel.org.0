Return-Path: <linux-wireless+bounces-8874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14189905299
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193551C20A9E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF79216FF38;
	Wed, 12 Jun 2024 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="h4xv1Eo5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5364D16F0D0
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195833; cv=none; b=uT8xoeqsBKzSBtlSD4Hla6KicRq+wnA+uQGtLS3DhC5qpBicGKk/QioQuVEUWj9dr0/lS482EALP2kCq7qbus8229mvG5qQGEkZo24ynZpp7l9LiNI6DtR+epvMLeP9olJz/ynX/ppmW/vF4GdcJuWbvz/iDpNvDOHiWSOweI5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195833; c=relaxed/simple;
	bh=lx04J6O8b0Th+c/KHKHeoXtRf1UnkADx3cSd7ZXP5wk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=qrsGDDb6FFitCgVLRsxjKKS/Ldvxt/VaM6kfV3U0UmLzV8krhHNEfmhr3oihV38HjK2Un+nb1UkCvYKri832oGv7TCqa9U3aC4gfEwOAoYr8X7Hx6ROTXPijtgV8S0JdDNs/To5huxcnyLYjuKBMD/KfRXYcs46o7oiUhkhUcf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=h4xv1Eo5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=lx04J6O8b0Th+c/KHKHeoXtRf1UnkADx3cSd7ZXP5wk=; t=1718195832; x=1719405432; 
	b=h4xv1Eo5BKxkJerPTq4jUKdxsi0Z3yX3AyCcaYDkMJFAcFXbTn+H/PsM8f/d39t/UqoEAOTDgfJ
	BPkJg6YVk9216+RlgFb3M0GNFQD/x+k+6efUXMHVtI5Mr0T/RWoJ1HicqlWe32bXHkirm6qQape8+
	96wHpz3S+SaWe7r8+fLJp7w8pW4q35e6FseoNRPPQx5u2xmjbDkwpU58zNS4YDZuKYyWe7htXqd8N
	LVWgpa4QrsSJJZfg0kQa8x0idDTFDqiovB4R5hsqeR6edKhZAvBibS0/Wegk8txnhiNYdHRjwwCvO
	LP5k13lJslV50YxuHZ6rhSIAtFGG4Np1f3wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNDy-0000000AH0b-0YXG
	for linux-wireless@vger.kernel.org;
	Wed, 12 Jun 2024 14:37:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/2] wifi: mac80211: fix wider-BW TDLS with multiple vifs
Date: Wed, 12 Jun 2024 14:35:55 +0200
Message-ID: <20240612123707.38067-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While looking into the chanctx/sta bandwidth issue fixed by
the previous patchset, I realized that the TDLS wider-BW code
is completely wrong, it takes all TDLS stations on all vifs
(and links) into account, rather than only those tied to the
same chanctx. Fix that too.

johannes


