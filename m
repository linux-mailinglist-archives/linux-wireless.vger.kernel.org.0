Return-Path: <linux-wireless+bounces-13624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412329935D3
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 20:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7249C1C236FA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 18:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BA61DC1AF;
	Mon,  7 Oct 2024 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="IHlP0Dc6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54CC1C173C;
	Mon,  7 Oct 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324954; cv=none; b=rECylPFysHnv6E5FuTzK8eXtibKf16eqZS92YYah9kyhh0CIveqO0i6bujhXe6rh/Edz8wVK7BVm0iJCQlH7kiKskVlTywcWJZ6IheiFo2Ev2e60U78VcIyXl8RRRlYbz1s30zJ/epdQPiT/jGC0YUYCYCVyKuMkL7le3urgnuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324954; c=relaxed/simple;
	bh=Ip1t0XgIEsQ6ne/t+kRlPOJmnIm8s6ytbCA6cuVy5cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tb9vXHB3SsK+m8UM6Q0fZhLIyYBfh3Q996vRgmjrNSC2tDB4WRxka3+LQout2+ZH0VV1oW5tl4wSVoRMhCNN3Pz0uphCVnoPoA9ATh+Mra/sQp+Kuxbup4HVvd7rwqK8opVa5DZIK2DalW9mTfstuBiPHHZKaYLXRdx/tIEZEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=IHlP0Dc6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Ip1t0XgIEsQ6ne/t+kRlPOJmnIm8s6ytbCA6cuVy5cw=; t=1728324952; x=1729534552; 
	b=IHlP0Dc6Z8f8UoZPu1bFnFCb0PQKpd5OHZt261GY+upjaWSGLjWPw+K+49m+2aWvcq1ECa2miE/
	+IUCg0lHZk0issslQ71rOraONX7To9RrFgIOB3ifS+5LTmqJSIyKqKBYUtQb7SmMH55ddNSq0dBnA
	Y+qndhCbuS2j0xzUdyTBk/b5phOVSpE8w4Bfbxlmo2tANcMwuoLrj2VE6TLcYjvpRX0wHiWA1JIOZ
	fKtiWcaCbf3iRy/Uiud/M3EfJ4bg9olX1BQZJSCVmhdZa+ZabMb8G6A6kAWgcsr7g2eoNR5ZDnb4Q
	ZNmONLX62rcIzVfmZz7xHNH18SJAxlTgKk7A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sxsGs-00000003TpG-1kO1;
	Mon, 07 Oct 2024 20:15:50 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev
Subject: [PATCH 0/5] lib80211 cleanup
Date: Mon,  7 Oct 2024 20:10:50 +0200
Message-ID: <20241007181545.63207-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prompted by Simon's review of the MAINTAINERS file and Kalle's
remark that lib80211.h wasn't covered, I decided to see why it
was even still there. Turns out that indeed it hasn't been used
for real (other than rtl8192e) since the removal of the hostap
driver last year, in commit d0172d5f7576 ("wifi: remove obsolete
hostap driver").

Therefore, now clean up lib80211 as well and move its remaining
code into libipw in the old Intel drivers.

Perhaps eventually those can also be removed at some point, but
I know recently there was at least one airplane that still flies
one of those in the onboard infotainment system ;-) (Undoubtedly
with an ancient kernel, so that doesn't _actually_ matter.)

johannes


