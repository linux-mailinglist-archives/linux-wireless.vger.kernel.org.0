Return-Path: <linux-wireless+bounces-34737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMN9JVz93WkRmAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 10:39:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B91903F773F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23285301D4B7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 08:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441137EFEB;
	Tue, 14 Apr 2026 08:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xnfke8um"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17923822BB
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776155766; cv=none; b=QJA11rLOwVZifwck55yKWBKXqWDjkdTKoaXC96FV7qkUCqNbbexTQQg4tcqgGgvJKUIGFcKof+GkbJ0D8fokVXMMzSu/ZPcKCTCSM6wRrfc8vt6Fz/H9ELHkX1v9UWLBAb+yoKjajhaF3NWQXvVu31fsS2bE+4h5EEtWSPjySEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776155766; c=relaxed/simple;
	bh=nOQ+OkMbm4JfE49bf9ib17Q3lW75AcgsYtX8X9d7t4M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XuUkxVc58TcKBMYRwltlz/eX5a9YL84cdmK3kl6PncUiKLVfoaBFrDLA/nrPz4nAIHRByLhOnLH53UzHgSGq0yoDmg7Bm+OheSfMFU/EfFlez6RukVf3PHoYpvrnIxr7JVFZiQqLQt2AD4mj+YutjwvMio4Yu1WAxv0w9XKmirU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xnfke8um; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=oKr+Vo7v3oKAFuGO+WR4Dve3Rg48P3vFIZgaTlWY3L4=;
	t=1776155765; x=1777365365; b=Xnfke8um7Rb0NIofnFdQmZw4+hX+ZCafmW1LyOH/qbDVHOg
	59n6Zbxeq8H2GXCbzASD7wYGga5z1Jz1TqU2x9yHK2fKTVqzY/4NuP8bD1eIS/Uf526Wkq6vtNraW
	XMLm06Yz424Hq0Ot4Q06kaXStfdE1O0dhO99uOOy0QJ7/Cv+iWCSWr1vPdXvJKVWymRvZDE0HfRrT
	KUjWDlzxYJT1b7OIP5Mug5hEMTUnS1jw1q9pFm0U8WFlgrzrG4n2SMizI9bjbjyEcNVlrosGW65e3
	Js2hiiGcAyGSN+ExQBC3vo7Oe9ex7S5gidvpZENJb7n8/B8ATzJrqfyW+RjT4Cnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCZFT-000000057Zu-2aWu;
	Tue, 14 Apr 2026 10:35:55 +0200
Message-ID: <aaab6a224b82a8fd1b255f1546ea142d68653b50.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v4 11/14] wifi: cfg80211: add PD-specific
 preamble and bandwidth capabilities
From: Johannes Berg <johannes@sipsolutions.net>
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Date: Tue, 14 Apr 2026 10:35:54 +0200
In-Reply-To: <20260320175938.2547288-12-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
	 <20260320175938.2547288-12-peddolla.reddy@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34737-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B91903F773F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-20 at 23:29 +0530, Peddolla Harshavardhan Reddy wrote:


> +++ b/net/wireless/nl80211.c
> @@ -2482,6 +2482,20 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_p=
msr_capabilities *cap,
>  				cap->pd_max_peer_rsta_role))
>  			return -ENOBUFS;
>  	}
> +
> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
> +			cap->ftm.pd_edca_preambles))
> +		return -ENOBUFS;
> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
> +			cap->ftm.pd_ntb_preambles))
> +		return -ENOBUFS;
> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
> +			cap->ftm.pd_edca_bandwidths))
> +		return -ENOBUFS;
> +	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
> +			cap->ftm.pd_ntb_bandwidths))
> +		return -ENOBUFS;

That probably should be contingent on pd_support or so, otherwise you
end up with a bunch of zero values in userspace, which is odd?

> +	if (out->ftm.pd_request &&
> +	    !(rdev->wiphy.pmsr_capa->ftm.pd_edca_bandwidths & BIT(out->chandef.=
width)) &&
> +	    !(rdev->wiphy.pmsr_capa->ftm.pd_ntb_bandwidths & BIT(out->chandef.w=
idth))) {
> +		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth for pd reques=
t");
> +		return -EINVAL;
> +	}

This seems odd to me, why are you adding *two* fields when they're never
treated differently? Shouldn't you check if it's an NTB or EDCA request?

> +	if (out->ftm.pd_request &&
> +	    !(capa->ftm.pd_ntb_preambles & BIT(preamble)) &&
> +	    !(capa->ftm.pd_edca_preambles & BIT(preamble))) {
> +		NL_SET_ERR_MSG_ATTR(info->extack,
> +				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
> +				    "FTM: invalid preamble for PD request");
> +		return -EINVAL;
> +	}
>=20

Same here.

johannes

