Return-Path: <linux-wireless+bounces-30462-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 310FDCFFE59
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 21:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2532B3035AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 20:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1ADC33344D;
	Wed,  7 Jan 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="XtEB1DEg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49183328246
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795817; cv=none; b=b0zhrfOvA6Oa6tVPfkMEYSc/TMeOwlXnfk/onWywc4CKNx2YWT0jBl2armxKG+YMkYTG6VDnBtHcxNvZfI9eXTUId1XhDloe0wO1D+xkdhdt2MNcLJ3jdL/KTeX/yeKIIx2DqkZMMBFbT7RGCSQrC/+7TlKW226zrjbH5W2/nJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795817; c=relaxed/simple;
	bh=872Z+Yyr5iRMamIVijuBBILKuBfNJFzcoQyifBkzuQA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jZ8qxUga+24A62qvu5YImCC3otp+A2TmZuexbDjVkAEPSGIINnETFocxzKXxBTzVQrWZo7aBUEI/T8K8Z6gLbGp04LhUBZ3k8miVpxHar67wdXD5jE0oUfSAS0G+nXvne/Nm2cnIlLuvzAJ9bJ3XPzlvhapolp8J64OW2154Lhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=XtEB1DEg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=872Z+Yyr5iRMamIVijuBBILKuBfNJFzcoQyifBkzuQA=; t=1767795816; x=1769005416; 
	b=XtEB1DEgaSEDNcX8mLck5s1LTGDmsMRSAHG466bBjW0Gru8gj1S9iPCO4LcU6iOmP4XbbTn9Na9
	qxM1+FVBNLztoobuUZAJ064ImT+nysP1wRpfQsMtZX+mtrhYeYGcDDd4MYcuqXtoTNKptXXYeFeYf
	CH+DPqJ3MXa9l/d4kriDqXHeTI4iLKiqzcx700RvVe8ssy2Y3ng6lWE/GSOsHTX+ZdN482NYHEUNT
	7m28Uj8+ANDa1Mu7C85VAsWCfm9Gsx+SfQoEO/QylNbXTEF4sMW1+jedUBD9w7Vqb2YYsims2Dcjy
	vG42dmGoLHbmgVqV3YcFRaDWGfZeIubZ3IYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdURh-00000005agF-11wj
	for linux-wireless@vger.kernel.org;
	Wed, 07 Jan 2026 15:23:33 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [RFC wireless-next 00/46] mac80211/hwsim: NAN support
Date: Wed,  7 Jan 2026 15:21:59 +0100
Message-ID: <20260107142324.45386-48-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Yeah this is big, and we're still working on it, but we wanted to get
it out together with all the API patches. It builds ;-) It should be
able to mostly pass the hwsim tests from Andrei's hostap code.

There's a gap with mcast transmissions - we wanted to do A-MSDU but
that can't be in A-MPDU so we're still trying to figure out how to
do that best.

johannes


