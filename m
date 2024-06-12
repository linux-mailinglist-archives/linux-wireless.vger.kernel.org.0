Return-Path: <linux-wireless+bounces-8868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40B990528C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C895281DF9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A316FF2B;
	Wed, 12 Jun 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="fguRxMcU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024F16D4F6
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195664; cv=none; b=Rc+YsRdCu2vEF+SndArWiuEfYyQ6FCBIX+n0EfuomAcEWvzLQicBjDEUBHpH0m4GtrXbCCXLOS9ek8RkyOSbiDaY5DvAXZTlQCaSnIcG18Vp17cOpggEl+kZ+g1TIoqBDb+hIJEC5BJFGJr61N8MPx1WZZ5cNfLzBDUp9jOdMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195664; c=relaxed/simple;
	bh=8a+WycdP7rS5/qIlNCR4VoyQQnipPlrqIBCKgpb4BR0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NELQ3jYYeJDVmvCwJs7toOwIr3DA54VH6eCfWoJIqFBI5uP80AtyKluJvrb4khF4IoEp+1nrmhCTa9mp888Hd07Rz6Zn2fGzykRzTlU3R5Xp4Fsj33nnadBzTLxD7RY0GbLnqv4li7gj4MUlR1yKAlysHoYofl+Cv5S0eEkBl+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=fguRxMcU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8a+WycdP7rS5/qIlNCR4VoyQQnipPlrqIBCKgpb4BR0=; t=1718195663; x=1719405263; 
	b=fguRxMcU2fiCfVOxy827ZYf+EAy+LPPSN23e3gG23Mxj+gBEsHN4JFMaPYopIBVXD0wmA9hddex
	WaL34XafteyRJdY3uVS345t3qGW8F1s+N9WIseG0MVVy5cdl1Px31bLzRyNS7dX5X8sVesSRqOXwG
	V0vYLUR7STCuNcnukE3rWak2anpX0iMaIjgWxF37Tv+qK0nH0Orjag3ICnbRFR79Hk7yjhvDrjTtM
	zXWo4qzYl9xhG6maRoraqTGA8EJzcADxuVSTIdeQhoOa4x6qZoAwlh0NLWskz8jRhJYlkUZg2H5gc
	o+YWyEsBO9R3AYv3HeLcgzS2ohJ0F4Rw9ubA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNBE-0000000AGkC-2l8z
	for linux-wireless@vger.kernel.org;
	Wed, 12 Jun 2024 14:34:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: mac80211: fix CSA in single chanctx case
Date: Wed, 12 Jun 2024 14:32:02 +0200
Message-ID: <20240612123418.37295-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there's no free chanctx, we get into the whole reassign
dance, but in that case we don't handle the sta BW changes
correctly, so the sta might be configured with a wider BW
than the chanctx, which makes no sense. This fixes it.

I'm not totally happy with all the extra complexity, and
am vaguely planning to clean it up by taking into account
the reservations at all times, even if not active yet, that
has very little downside (might use a wider channel while a
CSA is pending) but will clean it up - just haven't gotten
around to that.

johannes


