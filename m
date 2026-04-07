Return-Path: <linux-wireless+bounces-34467-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCVfOk8P1Wl20AcAu9opvQ
	(envelope-from <linux-wireless+bounces-34467-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 16:06:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF213AFB0B
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 16:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559D430C762E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 14:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9DE340A62;
	Tue,  7 Apr 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WqoMdJd6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F26921B9F5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570444; cv=none; b=u+FofwtA8y71Cqqr9CVx4tBedH16tYdrHg+ZB+HocrUTDhJp6vC3QduorlXtpKNYn4yew9uZAoxpbbYsqwyfiMLvBKTnFbbjjkR69WcjfCEacHR4lp8n9V9NNGyjznvrKqxqDR0w+ZsT0MtrzwmmArctIxo/cD1vsz1SYr3mkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570444; c=relaxed/simple;
	bh=Rh6IW78t1arnDDaYcmvtvwh3PxSOHQ3OkDdfc8oLKj8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P8WPPo0vn1TedtetdxD9EfOM+2k95TO5v6g0BZFoI3raqT+12V4ltn8POED70ybVHq1tF7xYF6052z9MYgiU1w/kR0hlVMDmdcsZK5CwN4blDQG54Nn0fziFMvDSjbstSinh/ysdd0iwUvKRiEN5KLNB5eij99fOzJk1t7Z/5T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WqoMdJd6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VM0SKvAoRplPRphLib/tcxg2O8xvyMI2tsOOKv3HlZU=;
	t=1775570443; x=1776780043; b=WqoMdJd69Yn7qcRLWgP5BaFHgyflTTONRovxBGN19+FNfLK
	mY/1vAjK5osA3G1VHUUq7PIONdOGKNMCymsLGaLUbv1J/pjVA5KaIHqa2rpWNIUsbfoVirnZ7KB80
	P9QpGe93u0nnoISZ2HNPbjSlnHp/G0bQO47PLV8EkvuA/kFuAYZvpK71lLzBgcgXM76pCwBGNpfx4
	ZKpv9oE3oWdPzkFE2m3aHF4y3mnOeuXjN3xJ9+lOgzAxmT3/wP8o6OK0V5eOK7QXF8hjuLtKECoM3
	oHxY0eJd4juAgkgEawxO/uOqO7YG+T3Vj52rk0Z95IESJIqkJWXWeqk+c6+JqozA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wA6yu-0000000CX48-2JEs;
	Tue, 07 Apr 2026 16:00:40 +0200
Message-ID: <6900294c6c10fb7336e8ca6c7217e970db2cc3a1.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] wifi: Transition/Padding delay subfields are for
 both EMLSR and EMLMR
From: Johannes Berg <johannes@sipsolutions.net>
To: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Cc: linux-wireless@vger.kernel.org
Date: Tue, 07 Apr 2026 16:00:39 +0200
In-Reply-To: <20260327201135.905852-4-pmartin-gomez@freebox.fr> (sfid-20260327_211203_859894_9243403A)
References: <20260327201135.905852-1-pmartin-gomez@freebox.fr>
	 <20260327201135.905852-4-pmartin-gomez@freebox.fr>
	 (sfid-20260327_211203_859894_9243403A)
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34467-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim,sipsolutions.net:mid]
X-Rspamd-Queue-Id: 3AF213AFB0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-27 at 21:11 +0100, Pablo Martin-Gomez wrote:
> -#define IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY	0x0070
> +#define IEEE80211_EML_CAP_EMLSR_EMLMR_TRANSITION_DELAY	0x0070
>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_0US		0
>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_16US		1
>  #define  IEEE80211_EML_CAP_EMLSR_TRANSITION_DELAY_32US		2

I think this is confusing. You have the "EMLSR_EMLMR_" prefix in the
definition for the mask, but not in the values, but also the prefix
itself gets very long, not sure what to do about that. Maybe just
..._EML_TRANSITION_DELAY even if it doesn't match the spec completely.

And then another thing - I was going to apply the other two patches, but
really then looked at my git log and saw that no, really, the subjects
are stating a spec thing rather than describing a change, so please fix
that too.

johannes

