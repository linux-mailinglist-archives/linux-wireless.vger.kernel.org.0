Return-Path: <linux-wireless+bounces-35246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGBSFJFY6mkhxgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 19:36:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DE1455941
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 19:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 941503014545
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152D3A7827;
	Thu, 23 Apr 2026 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWnkHW7C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35F83A75AE
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965675; cv=none; b=o/xrR/jqhQQCEQvRBW7BU1RSih6UanV53N3VjoAE93zxu88JW5J+Kw07p0FmMklePNevUd6Y4OtzWV1Sbs+54bnqziqyWn7j5BnW7YER4aW476TGxOhoD5CrX/gZnCA3jLrZMD1PG/SX9324MuguGyLA7zeyd9YrMkwk3IiMTqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965675; c=relaxed/simple;
	bh=tz3OwM6ZqtXTE234+rrZJXeoUNgJ9jOHjfV583YpF8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYXFB9LsINKxnBgbbUm7SbpFupC+u5NPuzDRKd4Acn6HmwzezZ6nM/6OYahFKYmj6kAvpNrAihXo7Z7ML/i5kUloYdeFzfNw7ILBgDd1iaEM3xshx9qTrL6AcK1oPck8udjWEQFySG1I3/StWjjfbmsWocMfY7Jst6FeO3j3/K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWnkHW7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BABC2BCF6
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965674;
	bh=tz3OwM6ZqtXTE234+rrZJXeoUNgJ9jOHjfV583YpF8Y=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=NWnkHW7CQHMqiMxwIcbqflDGH0mDDXIkp94zC2grKfec1rr9KSC+KgU5DO4Xj3I/I
	 aWXFUdG9vMH9PDVLtufNMT7/yIBRPumliKni7QAsfwbCRQSLh01/XnhN+DQqyH1Xwi
	 FsDqWRY3WvjB17UoRrHCLfYgx9/dpVhz89xk3c/gqiKUafuiexeaYs3BVLKtJqFZHC
	 RpIqlRvIoXfsgzlYt6z3OGg3mIXNS9pUTP45cuezKBx50YmSbforkBCZ8F0h08Ebj4
	 1ykYlgYz9a5HDxl+6xzMuspzjD449yIDHpdYi1fZyMgjH3sCr4a+RiRvM7xcpyJkRE
	 yYaC0gGyHJjuw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so6629210e87.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 10:34:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8al82lMoZhmWg3x9HGIsAoMru8fL0+UxSiKKlmK/vl1A2BUGBZEw4VYR6EpijzfqlaaecvlY0l1T8NNzbznQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwomkKsYt7vMhqAmxtKSo7iy8yREfuJZPYoQT96PfD2ngmpvLVI
	TSTw1MUERZzUoYRvIEliGA3MwNXuMPa0gzZLtWCPIq7DpYwA4ylBLqyrycdTkwtUK9/BQVP3Uns
	APpSAjzgBplXcXOCfeJb8g9jrFrWaAD4=
X-Received: by 2002:a05:6512:2308:b0:5a4:2cf:601e with SMTP id
 2adb3069b0e04-5a4172c3f7fmr8750846e87.12.1776965672922; Thu, 23 Apr 2026
 10:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKHmtrRD35fnE_TsZHzfgQ5p7=WHE1Fz8wnV0t2SGxDcgmopjQ@mail.gmail.com>
In-Reply-To: <CAKHmtrRD35fnE_TsZHzfgQ5p7=WHE1Fz8wnV0t2SGxDcgmopjQ@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 23 Apr 2026 12:34:20 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzq2HKHCpzG=rXjvQa=aORPRYvpEjsUnqsc6jDvwNMtB7g@mail.gmail.com>
X-Gm-Features: AQROBzAlw-9F3viDRFk4zHZKcR0uIDtWqMO3nL-w00vYCJ1t3Wo4hMiO16cNv8c
Message-ID: <CAGp9Lzq2HKHCpzG=rXjvQa=aORPRYvpEjsUnqsc6jDvwNMtB7g@mail.gmail.com>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7925 WiFi device
To: David Ruth <druth@chromium.org>
Cc: jb.tsai@mediatek.com, Leon Yen <Leon.Yen@mediatek.com>, ben@decadent.org.uk, 
	=?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <chris.lu@mediatek.com>, 
	dwmw2@infradead.org, jwboyer@kernel.org, linux-firmware@kernel.org, 
	linux-kernel@vger.kernel.org, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, litien.chang@mediatek.com, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>, Quan Zhou <quan.zhou@mediatek.com>, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35246-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.com:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C2DE1455941
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Merged
https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/1015

On Wed, Apr 22, 2026 at 5:22=E2=80=AFPM David Ruth <druth@chromium.org> wro=
te:
>
> Tested-by: David Ruth <druth@chromium.org>
>

