Return-Path: <linux-wireless+bounces-28617-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22984C36385
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 16:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 085D64E89CC
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 15:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E7315D48;
	Wed,  5 Nov 2025 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="A9F7Hxoj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512702C21DE
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355078; cv=none; b=M1PnnNIHvr75PDnJRFDCD4ixpz8HQQIdjv1TqcC7AAdulauBT/r+ikuCf+OPBYxhsxK0r5LkoIFdOU3RlDpJUiTT5UOdYUeju4yyUDgA2nQYxHQGLaC0exTnFRUxLh1lUYZ+veFQ2CPJ/JrygPXGbGCFolhYsYNkArgNKdDfdbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355078; c=relaxed/simple;
	bh=t9oWtwG2QVTGIkVwgIP8BCpCsGaolONK3MdDboBczKk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mQ05p0e6WdKYMN3hxKSlQpYiPdwk7RD6pxA+cFYH4xplsoCE2/egjS880z1bo6unph5rnO3VNFZzvaUgQlijpAraIl2XC8lkxHe8lDSie2jzlNU29EsYGhSzzl2pdjs4JOhJYNP2+IPiUf3Gkv3nJzHHfdEMwCjIND+AojOtfJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=A9F7Hxoj; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=t9oWtwG2QVTGIkVwgIP8BCpCsGaolONK3MdDboBczKk=; t=1762355077; x=1763564677; 
	b=A9F7Hxoj4ZW2srm72W5UROVEiS3sv/qocw/IZtmGyWs9YQgBokC2csrIbLJ8CydEVOYFdVi3noy
	6dH00WPS6Bk5RmGYNbbPo5LqxVfTZwHf7jjHuwoo2j3MbOtfmpUHADmKcV1mVKb52T8q8bQVzwH/s
	QjXN+XQ/GfkZ9UIFblpG0WlpS/QaabMgOAyYhHkWqq3+trgD9ypr9TS7O4fLobDlH+S+mmYnt3pcR
	afJh+/rZ+/WiAncRQLYm4p4ekQaYdzs2dcrxX+/s+FDCGzZ+0FzbhI2cXJ6bIIiywlXCsBhL4uDO9
	ciVwfJDS6LR1NLX6VQTM0BhjoUh9+T0SK8JA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vGf3q-0000000FGVb-3FX6
	for linux-wireless@vger.kernel.org;
	Wed, 05 Nov 2025 16:04:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/4] wifi: mac80211: chanctx cleanups
Date: Wed,  5 Nov 2025 16:03:41 +0100
Message-ID: <20251105150431.49595-6-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're looking at NAN, and supporting many chanctx pointers on a
single NAN vif requires some refactoring. This is initial work
to that end.

johannes


