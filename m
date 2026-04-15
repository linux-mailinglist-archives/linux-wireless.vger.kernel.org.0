Return-Path: <linux-wireless+bounces-34763-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM+aECli32lhSQAAu9opvQ
	(envelope-from <linux-wireless+bounces-34763-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:02:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7464030F7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1847319644B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E41DDC37;
	Wed, 15 Apr 2026 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="x97Hpvr4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B703346AF
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 09:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246793; cv=none; b=QivtADFkU8BqyPxUjCWCN1F/3meyeitt/jYXklfjphUAcIdOL/M5xZVgRrEcYCL7n7YYmJ5lrPhPZRSBFTOWSwGeX2rMCAeMatW0NA90Vq7kMt4xZhCuDGfsm33kgcquzRW1I+IcPijCWc7uyEhyQrBzkVvZTFTVnG0065ruAUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246793; c=relaxed/simple;
	bh=JZDM7oAyW5Yxoamjvv+9xrYN9VRNvgifud3TxQuX41k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQ08PAn/IZ/c3Wlbj7vsjDOsOKF3E/QN+piN3xp3GhDBAvUWOOqBJFJrMLZBUjNaUMlyxA0CWQWChHnDfW77IIWMkViXAu8PLu/7IH8tNhDIN91FgU5G/VhoNO5FHLwvIYQ/z9yyRhmw7Vhl81I1+uetAjro1jfF15F+eXx8RCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=x97Hpvr4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JZDM7oAyW5Yxoamjvv+9xrYN9VRNvgifud3TxQuX41k=;
	t=1776246792; x=1777456392; b=x97Hpvr4kVmFA83Mfos874pDOnzMQinExBK7FvWI/COXZSR
	O4TOtEcWfjwt6y2rLmkrQLDmpg+6eqn2BjYh/xl6mP78pbdaubwyHIJWBGnpKV0S7UcY0k++k+EjI
	qvenioDAhtniL1VhGX7HsMdhewKO+ImpyIGdxioJT0i+zwoSK7oYqvVClT411XiEpyR37RrDw23Jd
	VM93F1RiyRfMEugbo/+ddFUiAJiAVpZGDVrGhS0C1vDpoOB5+udHAu2NU91+Xncw/GC02nC0bqQtt
	S8NT4mtr90R7qhLKw6pmCmXSa/8uvcrblNx5Y9wt17TYuupiZfjPlTEYNugLW9IQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCwvk-00000006JzM-3GR0;
	Wed, 15 Apr 2026 11:53:08 +0200
Message-ID: <acdce727bcc094ae13846bcf03bf0a6206186200.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v1 1/4] wifi: nl80211: rename PROBE_CLIENT
 to PROBE_PEER and add STA-side probing support
From: Johannes Berg <johannes@sipsolutions.net>
To: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, quic_drohan@quicinc.com
Date: Wed, 15 Apr 2026 11:53:07 +0200
In-Reply-To: <20260415094304.1731390-2-pritiwa@qti.qualcomm.com>
References: <20260415094304.1731390-1-pritiwa@qti.qualcomm.com>
	 <20260415094304.1731390-2-pritiwa@qti.qualcomm.com>
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
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34763-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB7464030F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-15 at 15:13 +0530, Priyansha Tiwari wrote:
> From: Priyansha Tiwari <priyansha.tiwari@oss.qualcomm.com>
>=20
> Rename NL80211_CMD_PROBE_CLIENT to NL80211_CMD_PROBE_PEER to generalize
> peer probing, AP/GO continue to probe associated STAs (legacy PROBE_CLIEN=
T
> behavior) while, when the driver advertises NL80211_EXT_FEATURE_PROBE_AP,
> a STA/P2P-client may probe its currently associated AP to quickly verify =
link
> responsiveness without waiting for traffic or long timeouts.

Why though? Link management etc. is totally up to the driver/mac80211...

Also I'm sure this isn't going to work for all devices, e.g. Intel
devices can't send NDPs from the host (this is probably wrong in the
iwlmld driver for AP side though.)

johannes

