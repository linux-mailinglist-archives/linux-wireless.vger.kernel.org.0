Return-Path: <linux-wireless+bounces-38325-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eq2WAmtoQ2ojYAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38325-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:55:39 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE66E0EB6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 08:55:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sipsolutions.net header.s=mail header.b=ibHgqiJW;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38325-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38325-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFC6730214EC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBE13822A1;
	Tue, 30 Jun 2026 06:54:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B457B382381;
	Tue, 30 Jun 2026 06:54:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802454; cv=none; b=j7wZnfUjSYbdqATA+EP6GyLUlMYXxpRJX+Eh91pniSgiBQ3rfggwVK33TYks9KGQ+WhqluqNMX8m+RvmTjk0QAUl07wtvszFY3nlU2MUBRzDNM6EXlRlnNUZqYcHL/xMKeLGlZ9QcgXV9sE6XvyNZGgW1jHdj9TSnmtEI7e5KC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802454; c=relaxed/simple;
	bh=uqgwxqqbZ2X5ae+FR5+rZDcIgWbEH7K6bTNFlz6G6z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R03mQ7anePZGeDGvkbhqdQm6lN/Nd9iDAto5zf+Z2qmO+SuxR5ZrgU5RNHDOZmpQWeExq1kEIPuWdEGJBKNbskYiXx+5MiBqA4PPZFFg+/jq9HCNocUGhwJa6lrpc0Q8K20mmlqwBg6RO9kKpq+8qJeRiFsacJ4zSg+NozNLD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ibHgqiJW; arc=none smtp.client-ip=168.119.38.16
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=uqgwxqqbZ2X5ae+FR5+rZDcIgWbEH7K6bTNFlz6G6z0=;
	t=1782802451; x=1784012051; b=ibHgqiJW8xvRJg+vUJzN0bgtrIC5hZfn046M5QIsLRhex3l
	4iV3a8LunmXZKgLxhvherSAkLjXsAUBHSUeCb6UGihXAjaWY9KYEM5JULDp2jQpA4SMC9Izsl4Hqd
	KGMTT/cNaOyS2Oz8S8dXCwEJ0Il31jF5RVQeRYWXMVK6jcSkF948icoITNv3KWe8mxYnM9M3JzpKz
	WaX05E5+P3v7RfgnHakxWpPwsoq7EuXzkUgnnI98v2Y8PVLBSkyZoNAiblDqq+6B2e4cixwNRfTAU
	Xv3XIJ0/t6DTEXrLHaI1zi+UK1OVd8htdg/a7udjNjdbxRY9487EzMm0bhfAx4hg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1weSMC-00000003NAR-0WGP;
	Tue, 30 Jun 2026 08:54:08 +0200
Message-ID: <588f665e6c1e8a24d6cee56762ae754f39ab9703.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] wifi: iwlwifi: enable MFP_CAPABLE in FIPS mode
From: Johannes Berg <johannes@sipsolutions.net>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: emmanuel.grumbach@intel.com, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Tue, 30 Jun 2026 08:54:07 +0200
In-Reply-To: <20260630065054.199048-1-jtornosm@redhat.com>
References: 
	<11d449ef4691092dc669cdffb1bff72d2684b739.camel@sipsolutions.net>
	 <20260630065054.199048-1-jtornosm@redhat.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jtornosm@redhat.com,m:emmanuel.grumbach@intel.com,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:miriam.rachel.korenblit@intel.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	FORGED_SENDER(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38325-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,sipsolutions.net:dkim,sipsolutions.net:mid,sipsolutions.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49CE66E0EB6

Hi,

> Now that I understand why MFP cannot work securely in FIPS mode on Intel
> hardware, I'll drop the patches.

There's probably something to be said for the second patch anyway.

Also, maybe we'd actually be interested in who's using this and why,
it's the first I hear of this outside of _very_ niche applications :)

johannes

