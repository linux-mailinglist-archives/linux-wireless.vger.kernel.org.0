Return-Path: <linux-wireless+bounces-35465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBt0FmmG8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:05:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9475482304
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A713420D7C
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8238C42F;
	Tue, 28 Apr 2026 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jq4J4A8r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48418388E46
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368436; cv=none; b=ZNAuwrVbmRtlb6HtgChxNVtlr2zw0ghuDRtXAeeI944a3F341/LnJJmuy5QL/w9+1c0PFAj3ZrUZqjI8FWyI8OJZRPJxY7xD2Fw2GiDzxaEYtnqsPUBZaF9415wfVBESq6TVJgJyMwTFzDBX2GWlgFd69AyECOeZLhzcBOCT1X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368436; c=relaxed/simple;
	bh=abERnnnVSMj8ugB/cErvrZkmpTpcwIUUmzm/9lZ21ZA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sNaEZBc6cS4cqQ73l0jYXlel4uc0fg8UT9TpYq+nVIQ4da6/zvMIHUvAc5/302pklqKZLGOZa+OvGbBhLfw+R4hIr44AVoiR/Vpus4Yncm38o+m1x7+USGFOQrxeEvwyvJiSKXZphBJAu+mFpXCiTdiIWk9FF2ag35lNqFsnM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jq4J4A8r; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:To:From:Content-Type:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=e9P7vszTpCHLzj9OEsyNY+ObFWUk2MU5DZBnn4GTSs0=; t=1777368434; x=1778578034; 
	b=jq4J4A8rKHCEeqc1gFaCfoe0GAx2mdAnnGk6EoTqSZ503m/DuyfgYzVVCRooLYZqsZvzHnN4L9U
	Zf2tsHMPCHVs0A8VCsI9qKDpljriOsQRXmz+ruzzQU5MdLj0HZIqyO7e9hE0/wVqKAQ8Ipti2pgYQ
	YnOnqFNoC83eksB+I6Wq5zg++caQQkVfDPKFFMeY7sC/Z7N34mTIqvVSJ8iZ9Bt53SiXSLDQSIO7+
	8T+vQC2nuubMCy/4blxrKnFHegABIsLsjA7s4iRFiX72e3y0HS4o2bPqizLmnnZZZ6+Ip2R5914TP
	V1G/XpRzrmcdjUUnT06WjnERE2hpGYYzlRgg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeil-0000000HLwg-0vvk
	for linux-wireless@vger.kernel.org;
	Tue, 28 Apr 2026 11:27:11 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/14] wifi: UHR non-primary channel access
Date: Tue, 28 Apr 2026 11:25:28 +0200
Message-ID: <20260428092708.71740-16-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D9475482304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-35465-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]

This series implements UHR NPCA (non-primary channel access) in general
(chandef etc.), for the AP side (just configuration values), and the
client (using it from assoc response.)

A few things to note:

 - I know that the 802.11bn draft is likely to change and use an 8-bit
   NPCA primary channel field, which changes the parsing. This will need
   to be adjusted once that finalizes.

 - This change will likely also come together with allowing NPCA to be
   used inside the DBE rather than only inside the BSS bandwidth, but
   we'll see how this will play out in the spec.

 - I have, at least for now, deliberately opted to keep more patches
   rather than squashing "don't parse full UHR operation from beacons"
   and "separate NPCA validity from chandef validity" as I think it may
   be easier to follow, but we can change that. It reflects my thought
   process more than anything I guess.

 - In addition to this I also have preliminary DBE (dynamic bandwidth
   extension) patches, but I've opted to not include them here for now.

 - For the AP side, I've only made "fake NPCA" patches that allow
   advertising it with specific values in hostapd, rather than handling
   the client request to enable it and updating the BSS values. I don't
   really know how "real AP" vendors want to handle this, so I'm
   deliberately leaving it out.

johannes


