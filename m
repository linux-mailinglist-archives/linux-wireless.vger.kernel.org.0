Return-Path: <linux-wireless+bounces-4727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688AA87B920
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD8D2849DC
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Mar 2024 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07B5DF19;
	Thu, 14 Mar 2024 08:11:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEE5DF0F;
	Thu, 14 Mar 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403864; cv=none; b=SYT5XfZaZgDkodQmqWyVu/QMoIFh1c4ney4L1sMizX7sy56CpNqjYtBgDSheixkHzWftaFTMiHbXKRbHZY66BZioYJV/zC+RFUoG2+YT9x4GeOIXXiOyNA1wNXOhzwFs5aOTo8cfIs3B6T/SXRjZC/YxdIQSUr3AJ4RehFBHWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403864; c=relaxed/simple;
	bh=49yIHFFM4D8uhYFoMXrapMVE1Go2KxtcaF5olJvsteM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=UC/tHadfCkuGtMcBAGKOv3ZJf4QFJFbU6zAnBTAms57MrWeYKxB2bOMP1ZrpuB4jqVjtrtDEQw/VDrDNIz9jw3tAcgDAc5n1Nzu2au8bqVLTglvvooBoWuKFqhDYD3jrUqX+hDp+iXgme2FNEfZnMCIeVibOrfAR0x01U9U9xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
Received: from localhost (koleje-wifi-0013.koleje.cuni.cz [78.128.191.13])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 42E8AbKT011126
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:10:39 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 09:11:08 +0100
Message-Id: <CZTBKHQZXJTR.3VMFEA8MZSP5W@matfyz.cz>
To: "Eric Biggers" <ebiggers@kernel.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: <keyrings@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
        <iwd@lists.linux.dev>, "James Prestwood" <prestwoj@gmail.com>,
        "Dimitri
 John Ledkov" <dimitri.ledkov@canonical.com>,
        <linux-crypto@vger.kernel.org>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Revert "crypto: pkcs7 - remove sha1 support"
References: <20240313233227.56391-1-ebiggers@kernel.org>
In-Reply-To: <20240313233227.56391-1-ebiggers@kernel.org>

Eric,

Eric Biggers, 2024-03-13T16:32:27-07:00:
> From: Eric Biggers <ebiggers@google.com>
>
> This reverts commit 16ab7cb5825fc3425c16ad2c6e53d827f382d7c6 because it
> broke iwd.  iwd uses the KEYCTL_PKEY_* UAPIs via its dependency libell,
> and apparently it is relying on SHA-1 signature support.  These UAPIs
> are fairly obscure, and their documentation does not mention which
> algorithms they support.  iwd really should be using a properly
> supported userspace crypto library instead.  Regardless, since something
> broke we have to revert the change.
>
> It may be possible that some parts of this commit can be reinstated
> without breaking iwd (e.g. probably the removal of MODULE_SIG_SHA1), but
> for now this just does a full revert to get things working again.
>
> Reported-by: Karel Balej <balejk@matfyz.cz>
> Closes: https://lore.kernel.org/r/CZSHRUIJ4RKL.34T4EASV5DNJM@matfyz.cz
> Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

thank you very much for the revert. I have compiled 6.8 with this patch
and attest that it solves my eduroam connection issue.

Tested-by: Karel Balej <balejk@matfyz.cz>

May I please ask, though, why you did not Cc stable (and add a Fixes
trailer for that matter)? It seems like something that would be nice to
see fixed in 6.7.y and 6.8.y too as soon as possible.

Kind regards,
K. B.

