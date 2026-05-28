Return-Path: <linux-wireless+bounces-37051-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNu2NKTzF2q5WAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37051-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 09:49:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5928D5EDF3A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 09:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E466300D976
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 07:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AF34B697;
	Thu, 28 May 2026 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="gzxGz7vG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E7032ED5C;
	Thu, 28 May 2026 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954244; cv=none; b=NMjVPirwgVvtcnr5UxqUaIgPg3C3LXi7RBdhO4ze1d5e22GTS1bSAl0nPkN6LTAp4B0YwPIgyTqXYOtP729dFnlSvFmlgXpFyGOODMOx4acD+Wnr5u/j93HVONcn0fJWM2L98HVyylkd/fet/FW84991fQ8ijT6ZRtYc87aGqkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954244; c=relaxed/simple;
	bh=0dhHkqSUbvS9K2fqU3QNUZPcDa8TCpMKVQgymRMms3A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q84/ZY13HA0h02Yne1VHTgAaK2CbPNU2Peg634gRusYakb5SMc5CFWWulyTGyeb3scgPabMIndg0ngXAU3UcS5qjCW0sD0Xl35pKtnqnYWXAzOyfYMxxdEUypRgu1Jm23ywWti1jVO1CUvDSc5QMK1fo7yGINNukuqT6+E9YGAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=gzxGz7vG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0dhHkqSUbvS9K2fqU3QNUZPcDa8TCpMKVQgymRMms3A=;
	t=1779954243; x=1781163843; b=gzxGz7vGEiA53nDlsaesZrI84sMGJJTIQf5F9AigGc1+9k/
	27X80BYwZX+KwaHVkP4pm72AbLWrtEVX76oIQxu6Ekrx0iTuy9IpT765mhA06P25DplF/Z7umuwLK
	dqtHwJXUc2uCdb1RFtGVHNrV/noM5b3m0XiXuEn+JXBAMufMgvjHsO9mJWjw9nyxy7qym/3JbS2EP
	10dKDmaEekdKpdOQUNHgjHybrWbfsVkpCC0PvvGgLhHGSL7R4jVrb+EampcG/FkFjSYxDaCfVFebO
	CwFH+u0PRc1lHjNVX4o/XyOkNHO+AdFsymmT3ZYVtqR5iFbnXdrZqX7d88cH09pg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSVPL-00000007Adx-1VSb;
	Thu, 28 May 2026 09:43:59 +0200
Message-ID: <5e8cdb04c12490dca37777975e921eb1842b6b4c.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/7] b43: add firmware mappings and remove comments
 wondering about rev22 initvals
From: Johannes Berg <johannes@sipsolutions.net>
To: Alessio Ferri <alessio.ferri@mythread.it>,
 linux-wireless@vger.kernel.org, 	b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 28 May 2026 09:43:58 +0200
In-Reply-To: <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-1-cdad2c8526c6@gmail.com>
References: 
	<20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-0-cdad2c8526c6@gmail.com>
	 <20260524-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v1-1-cdad2c8526c6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37051-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim,mythread.it:email]
X-Rspamd-Queue-Id: 5928D5EDF3A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 2026-05-24 at 23:56 +0200, Alessio Ferri wrote:
> Assisted-by: Claude:claude-4.7-opus
> Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>

Please don't squeeze the entire commit message into the subject and then
omit the real one.

johannes

