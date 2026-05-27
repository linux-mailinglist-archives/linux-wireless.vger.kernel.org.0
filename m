Return-Path: <linux-wireless+bounces-37002-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIRdFAfNFmprsQcAu9opvQ
	(envelope-from <linux-wireless+bounces-37002-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:52:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D59ED5E2FC7
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 12:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD2B23008C10
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 10:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC003F23A2;
	Wed, 27 May 2026 10:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AnJ4KxWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F124B3F20ED
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 10:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879171; cv=none; b=ePMlLR/S4fOPHt+mk/tnGpWfWPEbMTqF9jjIuEn6o7/lK9RljhjsvKU+PEWuDfxTXknf0LGzyi+l0OyvG0NiDrY6goBy0opbI6g1zjBBdprW+7HLMSygk0BHHNnIuLPqXHRnDiZFQjfGGAlNRZyaazNPV04QU2cC2TEUGWcTIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879171; c=relaxed/simple;
	bh=HOXuu4zPdvj+1LjmBJkKxUkIixOG1Jc82+V08GnRTaI=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=VF4YBPJstYYJwCLmpQMgfKq9BdDsYUmOH1VNCbeIm7I0T5bEiVEn9Zg+Hs1mEG07Q3lU194Z4Ung1GlR1CRSZLRc2sy3Db4aJw1rtmcZC5cPf/GD8bw2MeV1JYQDDl+ZyKjvhVtgyNSq4XqPgtaHJPK2JnRJbMq1EA0TNj5kvaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AnJ4KxWd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=HOXuu4zPdvj+1LjmBJkKxUkIixOG1Jc82+V08GnRTaI=; t=1779879170; x=1781088770; 
	b=AnJ4KxWdLHNONcjcIReGg9CKq0iKxJUOPzCIZidO7r/KV0osFY+Xr7vwsAaWMRXAuL2SOK8TjQz
	xhmawzVMDJgueALm8QW/PPzpWhkc/NjfRcqvoXCjs5mrz66iD/X04hW1YrdoLiRtEA5nG1PRSesFU
	3CGGsRkup7haTjTdXioaudJ4+U4PhQomSluey1hqw7wXHEmKcWLEsMLRO1B/eDLfAy4fE/U5Fox4X
	z3U8+03Y1Q4DipRKqmjq0rqxJidStZgr/XV8cHWfVlrT59s/e54tYGDQ+lyJ0rzq4R7D9VA3tHUCb
	mFFIqZWzk+SEYzTZ0PkJ0kXKA91pYIsTTifg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSBsV-000000062Xy-2Q26
	for linux-wireless@vger.kernel.org;
	Wed, 27 May 2026 12:52:47 +0200
Message-ID: <a5615f2658fe31a32836d02aa0f2d69027782bea.camel@sipsolutions.net>
Subject: NIPA/wifibot disappeared
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Date: Wed, 27 May 2026 12:52:46 +0200
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37002-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,sipsolutions.net:mid,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: D59ED5E2FC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Due to a mistake, the machine that was running our checks was
decommissioned and redeployed about two days ago.

I'd been planning to move the service to the servers that we have at the
netdev foundation for NIPA, but hadn't actually started doing that
because I've just been too busy with other things.

Right now there's very little point in bringing up a new machine in
Intel since that'll also take time, so for now we don't have it until I
can integrate it all with the infrastructure running on the netdev
foundation servers.

johannes

