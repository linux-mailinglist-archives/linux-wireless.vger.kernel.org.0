Return-Path: <linux-wireless+bounces-35322-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMGrFicr7mnGrAAAu9opvQ
	(envelope-from <linux-wireless+bounces-35322-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 17:11:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1E46A7A6
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 17:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9A223006B3F
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Apr 2026 15:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0EA1AA1D2;
	Sun, 26 Apr 2026 15:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4I/ywpB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B6017D6
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777216291; cv=none; b=uDuJqNk5EBMt+rdunz/h+Filhejbq7UVPyS/Ut6Vl9c0QTDl2sBpHD6SQavpmsDFVGrV9BWUuDDOR+TIZPVWKnmZb483spfE6dRBi2CB9bYYuoCnOgwtUP+Wm/tWQ6izKOMNCKCFtJpD9EgoB8tmb8935j0hQc2BryEYQYLpCIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777216291; c=relaxed/simple;
	bh=LW0+GhismAPlistvT3H4Z8FHNjDLsP7KvWYvDcgArbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZmgnUTyb1HcgdBIM+mnWl3yjidvglN3DXMg3fkv978FJMWakMhqyVxvv0+Nt4rseBJRdvp5XRFrLBFeCJx8T3z5/x7t/Itl9FqIDTMy+b89jqBq8vWSeKVvnKWjq+CF3dEEX2Gex1WwFM5t+xzrLuYMijbBV3YKpdCf3k+L8Fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4I/ywpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB93BC2BCAF
	for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777216290;
	bh=LW0+GhismAPlistvT3H4Z8FHNjDLsP7KvWYvDcgArbg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:From;
	b=U4I/ywpBaOhDeLk/AawJ+TNY+5Slakao0AkA/BW/QkeSGA/0HsuawLBr7iXmVF/Tz
	 IBSI1G+CqY+XkXt4mjzk9UdNiC3KdXLLzkuA+q1+sgwgGXet6Em9q0lkxAd3PfAkYN
	 sSvoxDeaESD2E/RXqKv5fdiOb1BGjvXcZ8xJtYvj+uC6x5YgrOLQzRQgnHDXSr6OYS
	 oUGEuq9sYfJlMBkaciQmeNXUXTaxUrGp5zfmBCgdDFl0UOXurqj3RuDkRtkcgl+MQo
	 3dajKsaRFFTrL2yQsWNejHMp9PQKUA9v4R983W1QYTPZKNub6LAeBs3jUZzNpPifC/
	 Zrtpf95LvWyDw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e97e73234so76745701fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 26 Apr 2026 08:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9fVV8Iw/l+zKJusgnanBan+VCMeqFxSPjXXpSEoI9xr0w2O7f/JayOeOO9Otk5ZgFo9hlqJCuT0RHzK/WTeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOg1Hk+XRCcuqzRSOyxu0fIoV7iuvwgoHYuIbNK89Cquo5pEKw
	UvI9yVlniS+yyg4MSxh+Kgk5dKenBBd6UC/xyHPrdc45Ea1UBDGPMjYLQ+fmdYhYM8qKXebnhy8
	Sqxmjw096X/pSRVcoFDaSY8oUicmIsz8=
X-Received: by 2002:a05:651c:154d:b0:38e:a00e:2bb5 with SMTP id
 38308e7fff4ca-38ec7aa49bcmr127218691fa.19.1777216289046; Sun, 26 Apr 2026
 08:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abojEyQYNTJM-v5u@wens.tw>
In-Reply-To: <abojEyQYNTJM-v5u@wens.tw>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 27 Apr 2026 00:11:16 +0900
X-Gmail-Original-Message-ID: <CAGb2v65t=NXDwV72wU3q_SRtWd-Pm4teVseP+=tOOQJ9c4HQkg@mail.gmail.com>
X-Gm-Features: AVHnY4L48tXjSMiAdhQuhwwpqQDb0dAUrtul1MVxTfSDyTaRSZ1fqXfa3jXng34
Message-ID: <CAGb2v65t=NXDwV72wU3q_SRtWd-Pm4teVseP+=tOOQJ9c4HQkg@mail.gmail.com>
Subject: Re: [ANN] wireless-regdb: master-2026-03-18
To: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CAF1E46A7A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-35322-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Wed, Mar 18, 2026 at 12:59=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wro=
te:
>
> A new release of wireless-regdb (master-2026-03-18) is available at:
>
> https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb=
-2026.03.18.tar.xz

Apologies to everyone. It seems after sending the announcement I forgot
to actually upload the tarball. It is now *really* available after a
colleague notified me.


ChenYu


> The short log of changes since the master-2026-02-04 release is below.
>
> --
>
> Ben Hutchings (2):
>       wireless-regdb: Fix regulatory.bin signing with new M2Crypto
>       wireless-regdb: Replace M2Crypto with cryptography package
>
> Chen-Yu Tsai (2):
>       wireless-regdb: Update regulatory rules for India (IN) on 6GHz
>       wireless-regdb: update regulatory database based on preceding chang=
es
>

