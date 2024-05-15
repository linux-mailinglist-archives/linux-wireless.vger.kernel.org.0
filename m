Return-Path: <linux-wireless+bounces-7670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F668C61D8
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94751C20C1A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1BB47F7E;
	Wed, 15 May 2024 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LbD7Ae0f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519947F53
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758748; cv=none; b=HPB7Ehn9VtBzbXOCa0VR2c+D8pk10KCw4L+1LMg53KkH25EnN1LWeC19Z2iBuRPioQYLPAgWXQ+EfP/CrdFSbbhRYH+TNQzg6urxSUFwUEPrSXuyU6QGseojLAVK/d+3pHfC8ctcjoOWCoOOuJonGe6rqIS2XGTLUFEzLgNt9hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758748; c=relaxed/simple;
	bh=0k7EW56aMBQIvryG9eLKHpO0a9obhNMu96n5IEGn7XQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ENCywVbAH+3B8klh8rcyJotRTGv+mODRO1KODud714V642/UUZqczp9ll7TfY16hzYJPuIX4WqvYcKpUczGhkUMyaOdQeYBQV4PwPe0EbIH2JBoZ9BLMVai3MmyYLi0d5SVdg7Eswm1dVDtDXhBJHPVH61yvqdemUJX4xsWFsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LbD7Ae0f; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=0k7EW56aMBQIvryG9eLKHpO0a9obhNMu96n5IEGn7XQ=; t=1715758745; x=1716968345; 
	b=LbD7Ae0fKNt6qGRSgpfn+A4VcQzCrYg+Ps0NSiNe2y/RfPukZS8JS8a20psCYNsZuNDgPjKoL2a
	pPGo9Tj+/BCAQMQXoUYkOhc8kDqCUPwfHuDcMWjCTA2+UJJdecEIgwCGL4VqID1yZwuYg7LEAAdVf
	pVplD+RK/YzJJh3MtfnHuvSPd7cJ+dtKaAzh8Uq5PdeW7jc7aVMrKTr03Cf+pDSIiPUbNyjVXkrfP
	l2mTSfWgIRsezSBF97tkYwbbv+BorTgJL8ScFDyJ8aHAxbaoKaphEOQ4xvKMWxWiPacT3H6vkTtkC
	pqI7IesWt0u1lNTKxomqFhhayS5U93SFwzfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79E6-000000063rL-41Jz
	for linux-wireless@vger.kernel.org;
	Wed, 15 May 2024 09:39:03 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/6] wifi: further documentation cleanups
Date: Wed, 15 May 2024 09:38:34 +0200
Message-ID: <20240515073852.11273-8-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some more documentation cleanups, as I expand the scope of
what I run kernel-doc on.

johannes


