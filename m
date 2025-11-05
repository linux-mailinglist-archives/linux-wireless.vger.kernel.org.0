Return-Path: <linux-wireless+bounces-28604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF9CC36214
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 15:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E887C620759
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 14:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1154430C60A;
	Wed,  5 Nov 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XnxQBley"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83B32E6AE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353530; cv=none; b=IrETrmfgWjXqduOiQviolgBAa/jsDhYZ5tlGRCx1Mx4/9rTP/uY7maOiLmrFbx+WaYTjOJeBh6bIE6cpx2/lkydvvyTT1dFjq6U5xDzs1002SHEAEIXFVEaChtHqYMGdIw/ZA2c9b+JlcPGloL2rwMLvAUX0LqUP7+0wUdtgxjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353530; c=relaxed/simple;
	bh=eYXqcspCW7+C20SfsoBZcg94Y82np5s7lgmGZBoM3s8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dB5CMVO9JhuuFnXjZiVWu3unf39pmftcj7wYFRTcCBT2ETl6qjX653xLShxS1IMkGgnB3cYbwiQaruej4DPN5TsT46QzQo89SM3k12sIzhzOhKo2C3JL08NAdSba/wAyAELNESYBOYVpGM+dbmQ9Wa7JPwqCmqNnCSuDWisCXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XnxQBley; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=eYXqcspCW7+C20SfsoBZcg94Y82np5s7lgmGZBoM3s8=; t=1762353529; x=1763563129; 
	b=XnxQBleyN82iTgFZcAmGybwqzFOVrjUuz60InqczHaUEX8LQ2UwPrGPn30VEIUbG2CcsanEA3n9
	Ms94p+qN8xgsU3Q5cBB8i76vnEMVFTUNEh89qldCj8qBu2h82Mku3tnR8gzAWo+pNc/BgTIFM7ZbL
	J/vxGG3HbFf/xOq4t2ueVobvNg/7NujmWiYmHtSgdFZQli1wENzRivNx90FybehAKXV8eKKnaTki3
	CftecwzMEJJ+UZXOVBYUeVfnFThYLiCJJY89vg0SgMb6Mal94DKLkayVUyAzRukoJ547aoc+SFRuU
	bkrhhiN2f88oMXD4EwEt+VBHqQieq/X+UxjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGeet-0000000FDcs-0bXU
	for linux-wireless@vger.kernel.org;
	Wed, 05 Nov 2025 15:38:47 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/8] wifi: split up ieee80211.h file
Date: Wed,  5 Nov 2025 15:36:48 +0100
Message-ID: <20251105143843.46279-10-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file is just way too long, and we're going to be adding UHR
and more NAN. Split it up first.

johannes


