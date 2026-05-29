Return-Path: <linux-wireless+bounces-37099-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNvsFPo1GWrzswgAu9opvQ
	(envelope-from <linux-wireless+bounces-37099-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:45:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543655FE181
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E745300AD60
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF753164B4;
	Fri, 29 May 2026 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="NnYb8cDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BB3AA4EF
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037109; cv=none; b=n/Qvt5/UT6xSnyhlb6ScgJCqnsjRtcRwkfGoAlonG0HFPVgNoeS7Z0JypYdatwZCPV2J27/90SUndV918PbyvuEUKUi/9mO8r3ZAd+tl2x22/sBUv+cWcClq3BQTa8oUp1mtVEk1Viuh2hh2g4cjqr+1bZTXEeYUquroD7m/CQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037109; c=relaxed/simple;
	bh=17Uh5uVWhiwrZ7eiXfxOa1FuJc0b6agVJBm0KDQou/E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B4BdVxvI+6DTq9qE+e6TSDsJd/2jWFSCBDcsb7Mj82X6iRYkUuyiCMGtijHoPUPSQRGUNf9ATYgT60Y2HJtGSsFd74L3N8yReEI1Fh1M+4Z5koaSPp7UO+IOe+y9lVV+ehzz+gL5lB6c3VkxG/T36XKV3y18FEvvEKiTsAEFAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=NnYb8cDv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=17Uh5uVWhiwrZ7eiXfxOa1FuJc0b6agVJBm0KDQou/E=; t=1780037107; x=1781246707; 
	b=NnYb8cDvZOrYFfCvePIUbZJ2vK2LPriaLxEG6ia1DM8nppY5YiRQdBq1T3suFq4mIogZU+l5XwN
	Ppi0B4y0fTM5+peb/hTASnlUwsO/k8Je2p9zVexqhn9HXQsRp+O7u/Dst3st1DUylLrPtwDDB+Vb3
	//IIeYue+A2xW9tzcpovuhKDAzoRnBVfqmpG/YwGzaadZzd0Fe9SK2yGt+vxPTSjhtR8lH1Es8ZD/
	/arShZI+EzlU4xXnzpTw/V1wlUu6uDqaoRWBAIVhqFPAOFZYOciQfB6rX0pdqeUrkqMEjafO5zV/m
	mPkuPaEPBsuBkl2OWj7YUn1qoCs7ZQzusftg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSqxs-00000009XXt-3chJ
	for linux-wireless@vger.kernel.org;
	Fri, 29 May 2026 08:45:05 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 0/2] wifi: remove 5/10 MHz channel support
Date: Fri, 29 May 2026 08:40:26 +0200
Message-ID: <20260529064502.37422-4-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-37099-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:mid,sipsolutions.net:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 543655FE181
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We had this discussion last about three years ago and nothing changed,
nobody cares about this code and it's de-facto unusable since the AP
side exists but not client, IBSS sort of exists but can't scan for any
networks, etc. It only exists to attract syzbot attention, and with
all attention going to UHR (WiFi 8), NAN, sensing/ranging, etc. I don't
see any of this changing.

Remove it. We can always put things back if anyone _really_ needs it
(and can actually use it), but I'd expect them to help maintain it as
well then.

johannes


