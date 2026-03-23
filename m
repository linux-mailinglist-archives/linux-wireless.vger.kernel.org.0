Return-Path: <linux-wireless+bounces-33708-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFqYAjcawWn5QQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33708-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:47:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F232F0726
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 11:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A246308FE56
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2026 10:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54EC38D6A4;
	Mon, 23 Mar 2026 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OtDkLndB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C64C3876AE
	for <linux-wireless@vger.kernel.org>; Mon, 23 Mar 2026 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262382; cv=none; b=kBcA8Uo7udeCbc9XOE6Pi6+iit3BdESBRu14HD1sx5cCrWmrGMLvXm+1nBnCzTIiONkpOIlt2Pbvcax9debZgIjMJXWmtFVWObn82AAuO6jHih3XeWD5/rOY/BxB3hXrbxmJEeh0f+m/SJXHQ/Nuk0JGkQqov1TXVboF/gMqAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262382; c=relaxed/simple;
	bh=fQxDulDZuDv2JLZZk897t0rpQZeUCeQ6adLmaWv2k8c=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PE8vlTCEVL5DT63nB5pWDoKBBljGWArVg0Vb1X8CYUWx107mCCxUfihU5spiMWI7HsQYMQx4vukp4HcQN7U2LW+GC6vW3Vs+vglGlWFJ/jrEATqv0gCwtd6/bKwzkD0L7vkX+P8Zqnlv9eIukSMo/Ggld+d8ugV0d/qsaEvNFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OtDkLndB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fQxDulDZuDv2JLZZk897t0rpQZeUCeQ6adLmaWv2k8c=;
	t=1774262381; x=1775471981; b=OtDkLndBjK9mXkKOkxCR96yfjR7j9UCLqLDF7j+xhvARKb4
	4fmPC3ApQyeeUGdowpjB+xV0E2bzN0Jfo4Amig17I07iyyPpNV1AI+JddKida53+F8NQhxEV+TEX8
	LYOhSbnDWwNeO8lRE1Djqq0jgKbCUUU3JH+RcavR1urvcpAu3gzGcwFCxvwXDGC8mMSz+D+bFHboI
	tB1unkTrSc1P4Y8yBdOPoWTitLEgeTy2J3KN3SHdOQhtUUz60PfwjH4N31iahAT72q/e7iMsePL4A
	9W3/Ov2kfqGhjXJgpPTwmME/LwwLFTAJn38XawerMOINHSuuYUbpldbURzuTRsyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w4ch8-00000009i6l-2F5e;
	Mon, 23 Mar 2026 11:39:38 +0100
Message-ID: <ba47b360ece399763cc55f7ddfeeb02a6cbb02db.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] wifi: mac80211: add ieee80211_txq_aql_pending()
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date: Mon, 23 Mar 2026 11:39:37 +0100
In-Reply-To: <20260323101954.874299-4-nbd@nbd.name>
References: <20260323101954.874299-1-nbd@nbd.name>
	 <20260323101954.874299-4-nbd@nbd.name>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33708-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 58F232F0726
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-03-23 at 10:19 +0000, Felix Fietkau wrote:
> Add a function to allow drivers to query the pending AQL airtime
> for a given txq, for both unicast and broadcast.
> This will be used for mt76 to limit buffering in AP mode for power-save
> stations.

Can you elaborate? Seems strange to make buffering decisions in the HW
queues (presumably) based on what's already in SW queues?

johannes

