Return-Path: <linux-wireless+bounces-32398-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMmfFM3wpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32398-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A2A1F17F5
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF49B30F3231
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757803A7F7C;
	Tue,  3 Mar 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JYmr0Bl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8903D75B6
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548007; cv=none; b=HoacJ6ztkME3PqoQN921zVkuMiRTttzsoZXBgaHMjhSYP7EKwAC1kgdfm1WhjH6Hn7tkhzAW++VjXhV8ODsMqBxGWPYT6mT/g6E0DBBvHR8/lomI/5EtN2TtujGxz70MbXAD3FzlEbfbfEBZ5yTjyioETsTNaUmj91uYdPbZfhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548007; c=relaxed/simple;
	bh=jPuYKUqiXZA3XDL/vJLFUQ2NjUikK9ltmLAXB54YF20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XuTC2LO1aW3Ei9zHwyhIvCKybjKzI8Ag0j0olhYyhnOC3fEMCrQRlTMWo6MfVJKQ7iAMoqeFvjgwBYJRjY3iniJe7EkgMcNp7PHEYWuHUG/YJQ5btr1+CF3gxlu9GYIS6dhIfJWbtGNp20LKDRKLxBuVTadh1z6QAkcHnJMtKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JYmr0Bl1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=jPuYKUqiXZA3XDL/vJLFUQ2NjUikK9ltmLAXB54YF20=; t=1772548006; x=1773757606; 
	b=JYmr0Bl1zAcUtCvTBNPd3Mn72R1EM+2MB+3E2qjEyG/0eyQiMII93D0g/5yw39Cq4TZgkQPZd9X
	S1dEgza+pbSC9FjHvreGzwMDicAw5S+VQH9CJTMi25cm9kI8Csvtak4C/Yf26pXs5h3tQLueBHcAE
	b/YhNn3NXDtL1ASXy/XRv61TGaFdOEWIojrEIxsEHis6hr5c8pE51bcAeIDKaDRuL8W4cyiDF/3Gc
	6QwjzPyBPqKGNieEoiXnVC6PXvRIRwTnWlA0c+LtQx1l14AmsOT8ohibS8ViZZWuhJ/NZJ2IITSoN
	eigHvwjVcOXcdj+lsQzlym9Qxh0tWYr4KSpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQhv-000000079iZ-3yH2
	for linux-wireless@vger.kernel.org;
	Tue, 03 Mar 2026 15:26:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/3] wifi: cfg/mac: refactor for NPCA
Date: Tue,  3 Mar 2026 15:26:16 +0100
Message-ID: <20260303142641.273071-5-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77A2A1F17F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32398-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This is just some refactor for the addition of NPCA.

johannes


