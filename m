Return-Path: <linux-wireless+bounces-33293-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB3nKFrct2mcWAEAu9opvQ
	(envelope-from <linux-wireless+bounces-33293-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:32:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F416297F4C
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 11:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D5E3300D153
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE46817D2;
	Mon, 16 Mar 2026 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="B84xoUdb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842E30CD82;
	Mon, 16 Mar 2026 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773657174; cv=none; b=leUj2E9q6IPQdMqvcyxu4wbU8PjbbHLTERfnYoS+QQA+irn8OuSGLqfc+y4B93Jtd7BJNxZ+hXRB81NWbakUwzZsYQKjuT3pKzbOjJvgQec4QtbvIEtN8GEwRBVMnO6gpv/Q9bSvOCJ/zWk6WxvqtTrH5bP3Zm+Eo8j702pOzWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773657174; c=relaxed/simple;
	bh=foo6ha6utUqAHOJAB6N0DTi6sIWbgbJ0LhHs/34tGZQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5/OQcqHH5njUYYDpZiYTeHSxZ/vuHte3UyP3YHi2+15J05G7uFS4pL/JjI3vch5CiT2jmu4w9WnufhMz6n2DqH7MAk+6kjrc8jKNTIG3Mlj+MORYvAPCg5trTZKCCiqs6gzKieUP1+p3Ck7jAtSTF50qfSJaIeAt1OTPVBPQ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=B84xoUdb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=aqjs+KPpIasbkcYqseVWATk4xS55mwQ+d2bTN58VHtw=;
	t=1773657173; x=1774866773; b=B84xoUdbn5qfhQksiS+rXWykGQHKQRSN5uFqiHUpwylOyRO
	H4oeJDlrCH9Pla1dMF+dkEG1VDqIVl4BbuXZhsr2XzdGwjrIw9YCrqXFq5alk2Gmyk+8oSKPN6CL8
	0cZi/y+stuWN+tc5vBT/eo7BNsaTQ2LMHt0Ej8mh2vSNoId6WZNt5pO905oRnR8U8lP3DOr5+zLG9
	9r54rbUlioEYZFJ8KEfpDgLK1Rky14u7FxUgBcWzxG1hwpCvHsIZeH2WJ+LNz2uz6bjxmF7/yY8pv
	gfKjc+BIMV6Ww1eEmdrSQYdqsU2LCmthBZQGzBcq1h8uKcw7qTRrP4egsFeEuJLQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w25Fc-000000028p4-2au1;
	Mon, 16 Mar 2026 11:32:44 +0100
Message-ID: <c0dee26157e9e717864aca406dd10e928a13985e.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/3] wifi: iwlwifi: pcie: optimize MSI-X interrupt
 affinity
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Adri=E1n_Garc=EDa?= Casado
 <adriangarciacasado42@gmail.com>,  Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Miguel
 Ojeda	 <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 16 Mar 2026 11:32:43 +0100
In-Reply-To: <20260315201647.15328-1-adriangarciacasado42@gmail.com>
References: <20260315201647.15328-1-adriangarciacasado42@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33293-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F416297F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Somehow you messed up reposting this - the whole v2 series appears twice
and the v3 of this patch appears twice but without the rest of the
series?

> Implement a balanced RSS queue distribution by skipping CPU0 for
> high-rate MSI-X interrupts when multiple CPUs are online. This reduces
> contention with system housekeeping tasks on the boot core and improves
> overall throughput.

*Does* it improve throughput though? You should back up such claims with
numbers ... I doubt it would (unconditionally). It's not like the system
is going to be *really busy* all the time with housekeeping etc., and
the boot core is probably going to be a P-core, where you might have a
system with only 2 P-cores and 4-8 E (or even smaller) cores. This
likely also breaks some Intel-internal system requirements, but that
could be debated with the right folks.

Either way,

> --- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
> @@ -1683,7 +1683,17 @@ static void iwl_pcie_irq_set_affinity(struct iwl_t=
rans *trans,
>  		 * Get the cpu prior to the place to search
>  		 * (i.e. return will be > i - 1).
>  		 */
> +		/*
> +		 * Balanced distribution: skip CPU0 for high-rate RSS queues
> +		 * to avoid contention with system housekeeping.
> +		 */
>  		cpu =3D cpumask_next(i - offset, cpu_online_mask);
> +		if (cpu >=3D nr_cpu_ids)
> +			cpu =3D cpumask_first(cpu_online_mask);
> +
> +		if (cpu =3D=3D 0 && num_online_cpus() > 1)
> +			cpu =3D cpumask_next(0, cpu_online_mask);
> +

this is wrong since you really then should allocate one queue less,
rather than mapping two queues to the same core.

johannes

