Return-Path: <linux-wireless+bounces-35234-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FAlEA0r6WknVQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35234-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 22:09:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A5C44A882
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4FB2305F810
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2026 20:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443993F23A3;
	Wed, 22 Apr 2026 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UfcL9zeQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCF3F23B4;
	Wed, 22 Apr 2026 20:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776888580; cv=none; b=BOZWfKJIb0A1b2kURpO9qS9dYHFpIZgVfqIlpZ56iA8D0DA+cmJWyjmTEDFYRmtJfP6b5LtfuNGZjdyUZf+ILFfTjqJVmgC+TBwHD5+lwbVV1iDl3t/BvuQf58TmNGFfw+OEqSQNwtGBBeFprlc6FLVnRVZmSW1BQSx40WIdi+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776888580; c=relaxed/simple;
	bh=nT0ny0JO2JHhgGA5ONmYvDJbe6kFFa5UE0Mp73ghlrI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cKn1M14YtoWi7TrluyBhqRyEw7PfkqKFnrTLR7foyGZPl1YwL31pIQRffiK64nE5ZCt76eU9TXhnXsUvdIC39s4FCSQTZHiznBB35zOoNuGcglHlkuJf+iTQyX6xetZF3fSeJl9uO0OS9ChUknWfn9MS1sICktz2+tY5UW10yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UfcL9zeQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nT0ny0JO2JHhgGA5ONmYvDJbe6kFFa5UE0Mp73ghlrI=;
	t=1776888578; x=1778098178; b=UfcL9zeQGv9+a+C+HAwcuxPe9DLMcwwWslNElCBE9y2qkMc
	Fs6Km1vU8cExw2ONCNzX+xiFdCvnY4RSCt5G/rJ84erx3Ss2nScpHN6xrzPibvb4YO1gPc6VT3GKZ
	rwiKs1EYrgMyzuCDJhOcJGmTlC+8lQ4sPMRLV3UcdFHHJZKhjCDQYtgsiXm/vKl4If7Jox+kcXwiv
	y30wJ5fE96JFFTxzc2g3gtRxbF2zhRnG6/5UtmLVA3yIbiUJd0zN3/DeTBCpNt42qAm5tqY0XTZDy
	Z4/7cQ37pDhyS3m0lEhKYsaCOIomCg3kyAUV+GckVTplm7Jjdh90vciQveB9t4zA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wFdt9-00000006UOl-1cQN;
	Wed, 22 Apr 2026 22:09:35 +0200
Message-ID: <dd665533ba86925762dbee1a0e6bc709732de282.camel@sipsolutions.net>
Subject: Re: [PATCH v3 3/6] wifi: mwifiex: fix OOB read from firmware
 sta_count in station list response
From: Johannes Berg <johannes@sipsolutions.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Tristan Madani <tristmd@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 22:09:34 +0200
In-Reply-To: <30b51a051a7ddec5fc5ec72a685789594c7440df.camel@sipsolutions.net>
References: <20260421134938.331334-1-tristmd@gmail.com>
		 <20260421134938.331334-4-tristmd@gmail.com> <aekS72ESOUlnqGIo@google.com>
		 <2e20cb23d2d156963c2b687c4c51635e5eec2c7c.camel@sipsolutions.net>
		 <aeknaNDFrmtuTQP1@google.com>
	 (sfid-20260422_215422_757833_CC97E4F5) <30b51a051a7ddec5fc5ec72a685789594c7440df.camel@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35234-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,talencesecurity.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sipsolutions.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0A5C44A882
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 21:57 +0200, Johannes Berg wrote:
> On Wed, 2026-04-22 at 12:54 -0700, Brian Norris wrote:
> > > But regardless, I question the sanity of checking the size against th=
e
> > > size the firmware said the whole thing was going to be, rather than
> > > checking against the actual buffer size ...
> >=20
> > Admittedly, I get lost in this driver sometimes...
> > ...but I think you have a very good point. AFAICT, we never do anything
> > to check the size of adapter->curr_cmd->resp_skb. We generally assume
> > it's big enough to fit 'struct host_cmd_ds_command' (since we allocate
> > it ourselves). But we don't ever go back to check these
> > dynamically-sized fields don't overflow it.
> >=20
>=20
> There are some (response) buffers where the size is checked before
> copying, but I didn't trace this back further than the SKB coming from
> pcie/sdio/usb, but I don't see any check of the firmware-advertised size
> vs. the actual skb->len.
>=20

In PCIe for example it looks like there are multiple length fields, and
various mwifiex_map_pci_memory() calls with different sizes

 - MWIFIEX_UPLD_SIZE (2312)
 - MWIFIEX_RX_DATA_BUF_SIZE (4k)
 - MAX_EVENT_SIZE (2k)

If we assume strict iommu we'll get protection there (even if bounce-
buffered due to the weird sizes).

I don't see however any cross-check of the cmd_resp->size vs. the actual
size. If we had _that_ then we could rely on the cmd_resp->size later I
guess...

This all seems way too complicated anyway - should probably only ever
have whole pages allocated, for example.

johannes

