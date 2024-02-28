Return-Path: <linux-wireless+bounces-4155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F6886AA8E
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE861C23D17
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBF2DF7D;
	Wed, 28 Feb 2024 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Sc3aDU3a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815302D61A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110646; cv=none; b=sInoUtYSlp2ToQLm8jDlsAnCeZeW3W55FFNHbZn4HYbmuRyU6OrwM7uHmLSzeQL5sX75HS38zn9xioEAIQqU2unwrKM84Hc67nkft11ZCNQBHHVNDsWXhUeowTBMT4CKhSqdJiHKvmksuXRAQWbpjNi8fIV8Srl67Gfw6aaztDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110646; c=relaxed/simple;
	bh=uY6eDfw/h7rGJSgYSPZkSQaRSq2SLdVBgaWjjgXkt1s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TvR5x1v1IGYsoVt1FMKxFaRzyoNrhrxMcw++na9xP18bLWNOCQEeH67Hzpdhm31v0p3BVdQp3PUxVnPcpony9yCOqBcaEXNwlkSPUa1YurxCOyZ6XO/YbbgEmjGs80+XtUnRtAulkp9R5cqqp3HLtVflt5pCnDX1rC6joKghY8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Sc3aDU3a; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=uY6eDfw/h7rGJSgYSPZkSQaRSq2SLdVBgaWjjgXkt1s=; t=1709110644; x=1710320244; 
	b=Sc3aDU3an3SbCfly42v9t2rbZ2qUZO06DF9ZJ2Ovw4rguWlP6HC98uULkUsZGaSsAGQFd2Co93s
	RGaPdDfV+LNqtZA4LzGRok0+RoUUvf9CFUbex0joR7Xb0dFAsPd2/jTgCECo1np2Gw3NUe9uboIGz
	aleubp/hWsjSy00Jtx502dpdYSU8nV+7PNnTrAV5ZCmQ6e2c7fQH46NdPl8gXLuTNfhu9+DzU0LPj
	e69Guo/52WoBpM09NY8CnCPg3iGdg1uEKTEyJJuBOmHRGorjlDGHiEUiKK0cGwPKlDx21YwLhVB9g
	IBLHCImWsdl3Yb3sN5R0Nliplgem2a13D4lA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkf-0000000C0hJ-1G3c
	for linux-wireless@vger.kernel.org;
	Wed, 28 Feb 2024 09:57:21 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 0/8] wifi: cfg80211/mac80211: pre-work for MLO CSA handling
Date: Wed, 28 Feb 2024 09:55:40 +0100
Message-ID: <20240228085718.21171-10-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's some pre-work/refactoring for what I'm working on with CSA
handling for MLO.

Yeah the last patch doesn't really belong into that theme, but it
was now really simple, so I included that anyway since I'd noticed.

johannes


