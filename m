Return-Path: <linux-wireless+bounces-34685-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNWbFFCS3Gl9TAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34685-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:50:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A15063E7F03
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 08:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AE05300F9FA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89492D063E;
	Mon, 13 Apr 2026 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dMA1cVvp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B345C190462
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 06:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776063048; cv=none; b=Nm4NYtMj8xkf6nKLSccPP8JvxIHkOlolZ0TAkxYp7Rhg5EMOJBtkXikPtfjWt/YnlCyE6ngXD+kqziE42kqmhh1loepTCzWasDDFkrhYdcIYo2QDoFYcG4cRgTmUTpIxNTl7O5LamWUrLMu5EI4ocgVCN8yFO31JPi3g2BrhYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776063048; c=relaxed/simple;
	bh=5CXDyppM7ACd7UWeyZrAqJtL7+y+9OCkYCnQck4bVBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Iflzt+Emz2z+koRThVXGE9rKyTGNgHtD/NnRgTIvcsF9w739+LmovTw5Sc45Y7q2tbKM/PxeIkEXICx/hAyYgCmlVMwkHJrTcIyKoLzMZdx/uw5Ab7GV0E1gQ7dporgayT+h4au7+PUy9EidBmqq2q43RCjKWfsYDOBM7faGuIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dMA1cVvp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MjGxzbX3eNB5LnaVwwclWDeTDx4Yu8CYB0wQpuwLFj8=;
	t=1776063047; x=1777272647; b=dMA1cVvpvLt15asCkxjHB2KvRGutjrN1cBUXco/VXiWpR0J
	tGEARmTg/WzAykZlcTAYC7lrkQfaXpsf6DIEfk66pBPCppg2bc6kGqFdTe6RD7GhnGkDnhNvhTZZM
	8KGwwIMIX8xXVdHqK+ut5LoKhTlquErd9SvtI3jvvXUIMWVO7eTcH+1VNQYX7z4sDcj5/il7iuR/6
	DmmahsJVI8pSHQWWiQFJgCl4Cy7JzNlY5/gvsZHsDh7vXZda0Osvf4O7mYBBtkYfmxhg8lNd9GWgV
	USrvr6+yC8Us6rekBIEqEyjncAxJQvGtOxoNSy09F08X33oqYqFXNf+Njl1N8JpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCB88-00000003hxD-2hwR;
	Mon, 13 Apr 2026 08:50:44 +0200
Message-ID: <37139769f10c8815abd488238c8479f8da36399a.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 05/15] wifi: mac80211: Fix a kernel panic
 in ieee80211_encrypt_tx_skb()
From: Johannes Berg <johannes@sipsolutions.net>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>, 
	linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Date: Mon, 13 Apr 2026 08:50:43 +0200
In-Reply-To: <20260412121124.2246222-2-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
	 <20260412121124.2246222-2-miriam.rachel.korenblit@intel.com>
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
	TAGGED_FROM(0.00)[bounces-34685-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: A15063E7F03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


> @@ -5370,7 +5370,14 @@ int ieee80211_encrypt_tx_skb(struct sk_buff *skb)
>  	__skb_queue_head_init(&tx.skbs);
>  	__skb_queue_tail(&tx.skbs, skb);
> =20
> -	sdata =3D IEEE80211_DEV_TO_SUB_IF(skb->dev);
> +	if (skb->dev)
> +		sdata =3D IEEE80211_DEV_TO_SUB_IF(skb->dev);
> +	else if (info->control.vif)
> +		sdata =3D vif_to_sdata(info->control.vif);
> +
> +	if (WARN_ON(!sdata))
> +		return -EINVAL;

Can you get any more confused and defensive?

There's no point in not just using vif_to_sdata()?

johannes

