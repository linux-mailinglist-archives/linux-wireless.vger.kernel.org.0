Return-Path: <linux-wireless+bounces-32005-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UnwoGUlslmmNfAIAu9opvQ
	(envelope-from <linux-wireless+bounces-32005-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 02:50:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE315B702
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35B5D3035D58
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 01:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F00243968;
	Thu, 19 Feb 2026 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTPd/F9Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DE01DF736
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465797; cv=none; b=NiqV7SONshwUVoTZuyKQgcTTH0uT6J2jEVnJLvDpetefrrXBDcfslIgm9hqMsCPP0ap4FUPknrhc7tOunRKFeIV6ddBJuQMExS5agfNbMv03b0dimDmEwIXYeMa8GCk98WJ9uTFmpOZ/4HnxT2e+r/nTOIozx1MwiXunSFdhU78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465797; c=relaxed/simple;
	bh=gprzKwyelAnbTbil6irDP/l70Ksm+SSNMddfdQb9Y4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw7TdRWAae+yUWIdAJpGr9AcVEsBhOTVh2A50s4wIoOwquwBKn8mtPq0cZudrXCD3Rboh45X0PgIoiN8UtFsDyra8TNyTD1VhSoEARDyJyJKb/kUqegxxlQ4u0NfW1Otuvz8QOsndeQiQxmNcc1W2uQSuCalI2cocZ4HvK//qrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTPd/F9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA75DC2BCAF
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 01:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771465797;
	bh=gprzKwyelAnbTbil6irDP/l70Ksm+SSNMddfdQb9Y4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CTPd/F9QCBL2pXWHEWRBD2xpt13a3jkq5JqEJ0eZBXBZbCMy+H39GZ1l7RXkZXabp
	 KmPjcjZ5y+VVTZL3CptTyXurTzm9xeIn4q3Ek6S/Z80nz4Zh+HyWhrW/aTrnAfavce
	 kY2xaO1O0Dr67XxhNYNFz17FF41KipWvdM+XYTtr+LEopCkmk04HdNri5zCqkCQ1Sd
	 3Ge38m50C7h3/MNQIaSWIzd/UGNBTDedTN442ZDp5UtQRH88d/znZxjkpxim4Ehgmx
	 aNHkoguGhibStCtxCFyuGZm+BhLMYaKehLtkFv1gVwXZDhuJ/rirK/cefzYvIcrebB
	 ZV+LBWRMfkHnQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8850aa5b56so91348566b.2
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 17:49:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXC4U2Pfg8VzFY3jFgCTCbRCeyCHFXvfMH/UlOg7kIZQWJnjdY6CuOmFzGkvQgolmIpJbA/s+nW0MtwdP6cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyisJg9nlr+jQJYyvtQd5Q1O5rc1J7nfyAqRwb8wQS9YO4uLT8q
	Y8BIPElXPEljRAcldva97OlVcUFvLyK8Vmw6QJNQp8X+OQHh7VKPJCVotgaIQm5rE55r9cIh0gD
	Mm5+W4zYk7OxU7lEMKXr6dJ/3e/fHzC0=
X-Received: by 2002:a17:907:f509:b0:b8f:9d12:2386 with SMTP id
 a640c23a62f3a-b8face62ee1mr1051037566b.51.1771465796016; Wed, 18 Feb 2026
 17:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218213501.136844-1-ebiggers@kernel.org> <20260218213501.136844-13-ebiggers@kernel.org>
In-Reply-To: <20260218213501.136844-13-ebiggers@kernel.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Feb 2026 10:49:44 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9rQ+pqZrbsBAc+poE5TW7RUBXwFZ-w+zmZ73P_DBxWvw@mail.gmail.com>
X-Gm-Features: AaiRm52LC0cRCytNvmZP31u5klrDIWh3l86YDetcbx0CAz2pxLOClyB6yHn1x6Y
Message-ID: <CAKYAXd9rQ+pqZrbsBAc+poE5TW7RUBXwFZ-w+zmZ73P_DBxWvw@mail.gmail.com>
Subject: Re: [PATCH 12/15] ksmbd: Use AES-CMAC library for SMB3 signature calculation
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-arm-kernel@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32005-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEAE315B702
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 6:42=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> Now that AES-CMAC has a library API, convert ksmbd_sign_smb3_pdu() to
> use it instead of a "cmac(aes)" crypto_shash.
>
> The result is simpler and faster code.  With the library there's no need
> to dynamically allocate memory, no need to handle errors, and the
> AES-CMAC code is accessed directly without inefficient indirect calls
> and other unnecessary API overhead.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

