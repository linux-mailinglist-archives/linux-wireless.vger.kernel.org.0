Return-Path: <linux-wireless+bounces-7244-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BEE8BD5CC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66C11C21BA8
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA415ADAB;
	Mon,  6 May 2024 19:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="D75ldV3t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B4615ECC0
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024744; cv=none; b=ENCD+MPgkiD/KNiDlroBka6FZtXlQSfS1gYinO8+6ruDlD70E7fz+bWwhnQLD8MUYdz+uwGwMHCKCjn3YWV3HYbAh1JzooYWGYrj9q1JKJXCRiIAt2RtxXIIIwGjJ5f9AnfbYrT6klhNb8Ls3E6x3U4FPEryh8VC3tyyvcobVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024744; c=relaxed/simple;
	bh=OtKrCb9nusBOcSD3MMnOqmHph6LCrQAgu2ydZYTSOoc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iwIDwnB8xygdqKEBrgpfhruonFea73zoSgRuBNKYVJuW+hmwYr8bT/2VorCwiZvdOkJV5N31lpQZTjcKYXE+Wzjp8qtC33HprIkJSh4+cW6kwHhVRyzSZ6vvyXzhfGCAKkqVExQPeWpH96XNJGwmDTE7VF0H6y/AVtH7eYTbYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=D75ldV3t; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=OtKrCb9nusBOcSD3MMnOqmHph6LCrQAgu2ydZYTSOoc=; t=1715024742; x=1716234342; 
	b=D75ldV3tQenRYfbkcgLtb6UIBXC6G1A4ex74R/QxSEYPiiu6HGx2m3+1ZUdZJRDcKRP8CGVeIka
	n9wkhscuiUUFZ0IwqY0C9X5Jg7uc1u1BjNTPoyxCvgreA8bW2tUUVggzcZDorFtxHAMSzS9JXWxRo
	LDr4pwpgRn4iNYopD6+QV8GOaWh1ERwmy+dR9hTiIOqz44WjB3EcbMC4Nlo0vUNdoZMN0qj0/Rw0q
	ByutN0EJ576+0G6vCjjRrTUrK440XUHgfBx/y09hwh5qgcj7x/E4IHzabtC/Sv1OLLsRmwBlEbqi1
	NcteBRGN2n67y2Sa3YPexO9tdVKGjaCH/MzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44HL-00000008C27-3L6S
	for linux-wireless@vger.kernel.org;
	Mon, 06 May 2024 21:45:40 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/5] wifi: mac80211: build TPE handling
Date: Mon,  6 May 2024 21:37:52 +0200
Message-ID: <20240506194536.102148-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rebuild the TPE handling in the stack to always parse out
the data for drivers, and hand only the relevant parts to
them, so e.g. if HE has 80 MHz, EHT has 320 MHz, and we're
connecting with 160 MHz for some reason, drivers won't have
to sort out all the reordering.

Only really affects ath11k right now, patches for iwlwifi
are upcoming.

I have further patches to also handle TPE during CSA (and
puncturing during CSA while I was at it thrown in), but at
this point that requires
https://patchwork.kernel.org/project/linux-wireless/patch/20240415112355.4d34b6a31be7.Ie8453979f5805873a8411c99346bcc3810cd6476@changeid/
and I'm not sure I want to merge that yet?

johannes


