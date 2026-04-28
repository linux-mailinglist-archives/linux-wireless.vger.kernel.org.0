Return-Path: <linux-wireless+bounces-35453-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULk9BGZ88GkaUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35453-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:22:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C44E2481479
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 292D2305529A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F001265629;
	Tue, 28 Apr 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MpSDln6Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF673D8115
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367363; cv=none; b=OSnX9iKwtFEO7Q3KFTxWGwXOX47m34N8Zzf/wh73B+bHESLUUHt0qH1OPkcUCaRYiRl12G96MqNgrbSD/plKLs7SZyjNtM5UyK2nRvE+fsQJLb/6CI7marzGZxii/pgyao0x8wnwYyPxQyDUqU9L9b1skBMgrriUGzM4UXjzL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367363; c=relaxed/simple;
	bh=oysUeDghJJsFozQNxP4LKqrAWfjWpmMcvY9TYUtc5O8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q1eJ47d1ot9zADELz8jZc60cG1eUYuL4IzBVEqUOv0zB/Iz4i0JBHdlCVGpBpu5ALFNGwW6As9Q0tweeQMsWqX5MzXngpXVkJiScvlQjWM8DOmN5To5XshmGBky4+ePSXWgn+wuOX+g7bfibVo8IU2o0Q6eIlKL/KNTN1j+Yq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MpSDln6Q; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=oysUeDghJJsFozQNxP4LKqrAWfjWpmMcvY9TYUtc5O8=; t=1777367361; x=1778576961; 
	b=MpSDln6Q1WRF/Nq1miVVpXP6u5KQ/rzyoGVDCbDuKLKMpZ+nb5JU4XvpFwM/TXB4InTTG+UVVzM
	mV6BpwDCFF2MwFHMRdUF8ZrF3hLQ/m1vju4FKy9vXJAvMV1K1rykizQt5cvaYzfbl+uf6oP/9JjNc
	SM+QOYEQFbLVFxT0h/SF1FZtVKYBBxx5F1WzyeYnJST97IJ2gcsSXTQBNvKqHdoaZ+FItMGX6Rfd4
	eM6t+d9UOHgbSXYEVfJigo7Qm/ILHP1sLE76VvLO3EgNqEzZAjlSv5GojEZ6s8L1HEDDPqZXUn1nU
	s7E/8xUayAf49351sMwtjdUsokIkASzLIgSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeRS-0000000HGH2-2M2a
	for linux-wireless@vger.kernel.org;
	Tue, 28 Apr 2026 11:09:18 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/5] wifi: UHR extended MLD capa/ops handling
Date: Tue, 28 Apr 2026 11:06:55 +0200
Message-ID: <20260428090915.54717-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C44E2481479
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-35453-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

This series adds handling for newly defined extended MLD capabilities
and operations from UHR.

johannes


