Return-Path: <linux-wireless+bounces-7250-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BB8BD5E8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3621C20DFB
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B194115ADAC;
	Mon,  6 May 2024 19:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f2TSg4Kb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD1DDC7
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025348; cv=none; b=BxAb3FcOm1fwz2meHUN0Crs5MtzmvKUjEXK0crYdFdsfc2Owhz//kl2NLrC3AN0tXvUjplWm6BjligPe1WFMwRZYdwesLjbD7imsZsZTw/SipI1WuS45b5jnZPDbh+pjKEdxRByen+viwZz53Kv1I+vBqoX0rYXRSlvLj6Ow36k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025348; c=relaxed/simple;
	bh=CD5q43zaGgz0K0yOkKanYx7J8LrbzlXHi12jytMBe3I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XrKks1wTVGa81w1nzMIdZtB5cabsjwQHgEjuB5LtFzQASnB4ytQYznMPghLlXSb8/0HTjDY18q+ldi/vfoaaGYQLSjwTuAgRI8hkqoCrSw7YzO8QxuInBdh0tR/+TmoI6MZjn6LFr8u4eo4buRfo235qn52CwaWIcxr4ki5GU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f2TSg4Kb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=CD5q43zaGgz0K0yOkKanYx7J8LrbzlXHi12jytMBe3I=; t=1715025347; x=1716234947; 
	b=f2TSg4Kb/uXFxM7cTY+cTlQs0vh/KOCzhowvlAm8ywX999U26Ry6ab4DC3nRja4EYhY8VjRChnk
	WHc62n/Qt/21nlnIoSXmbhrs/w7zknUF0rVTEy4toKRIuWcVO0SjWTDTCBudTmhUu14VuABxyjffx
	w36JhGNpXjWCnLV1FFbPeFgnencIVNABNm7uswfD44UddwerYPmJ8DQjbCZ4gZl3CELI7pkD3HYkj
	uYykl5yCTvUB6+utMnix17Xy4e9R7fJZmddbznvUYbt9tRITnt4rNRitoDlS2MyEWon0ql94zg+Lx
	9WQuY5m363u+PX1zH9yKtT9DgA4fFkt/kV5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44R7-00000008Cj6-0GUs
	for linux-wireless@vger.kernel.org;
	Mon, 06 May 2024 21:55:45 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/4] wifi: mac80211: wider BW OFDMA and TPE for CSA
Date: Mon,  6 May 2024 21:54:48 +0200
Message-ID: <20240506195543.104411-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's the other part I mentioned, this won't apply unless
https://patchwork.kernel.org/project/linux-wireless/patch/20240415112355.4d34b6a31be7.Ie8453979f5805873a8411c99346bcc3810cd6476@changeid/
is applied first, which actually seems to have a small
conflict right now.

johannes


