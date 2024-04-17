Return-Path: <linux-wireless+bounces-6455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB88A85A6
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 16:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE21C20B88
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626F1411DC;
	Wed, 17 Apr 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="t4H/yDG7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB51411D3
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713363107; cv=none; b=b/uyUOm4T2lJBpmMq2Kd6Fcuiw5QVEu3Axg9Tu9lhx9uEddjuPkVZ+1eCIC5Ewlpw0g+RQ4Ytjdp0XzJKptyOTq8Jz57FBOp5k022B7jbFYZxqqPVjZ0Rj8IenPwXE/ulRh5+oekQHPv8mKZytdF4vadn3Kj7mOhgWXdq1UydCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713363107; c=relaxed/simple;
	bh=fJpzu34/2xZ5iVnw7G1aPwOS/jipOSJ7QLzrh9pHPAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP7baPUu0GquTOsV5IEtY1DRFDYuZrcyn+lLJG3w7RtaohA1t3BZMNAjMlfvS1EhF+IgI119UwHUNoJ7Rcz/jiFpB/cYjNh4naASPCefJVGBj5zy9TzjU4SlOj3F3MnmCFETJPihKy0j37M8m2iIJj3a0LsTaBI4eya+q3LQEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=t4H/yDG7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ytE3RuR82kzReb6CQQ2/uk3bZZIXA92Udt32eR1wCG4=;
	t=1713363106; x=1714572706; b=t4H/yDG7KOjYKViy5Yyn+r9b6yMv/Gd2h7QOzCMKfJgGe9y
	x7hM9gV2iHNKB+IQdLmpf1GBtyG/HsHMQxmm8ljkPz3AE0ZyxCd1k3+WCVfsubySgNSsO2654aWfU
	URdVNRWtxS+aMOJqdxqv4yUfSXTCQYFn8FpTSnY+UR1Gk8clwqydwIyxLQbgV7baMfedD2LZPp8lv
	msEbaFgUs58rhnk2VogIdJguVb/mGhFmc/drrzcs04BHVYreo/i/Xef14Q4vhjliQ461LhDyFXKrk
	tC4mS7dRHwDcUDONLepeh8JnHZqNwQKeFeiy1PLK+qlZttb3N5T4+020TDdENhuw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx60l-0000000B0SI-1BlL;
	Wed, 17 Apr 2024 16:11:43 +0200
Message-ID: <4e07bb9f498566ed89e7e967e12f01821801acc8.camel@sipsolutions.net>
Subject: Re: putting future iwlwifi firmware into intel/ ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	miriam.rachel.korenblit@intel.com
Date: Wed, 17 Apr 2024 16:11:42 +0200
In-Reply-To: <87v84gi1v4.fsf@kernel.org>
References: 
	<fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
	 <87v84gi1v4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-04-17 at 15:56 +0300, Kalle Valo wrote:
>=20
> Yes, please. It would be nice to cleanup linux-firmware.git top level
> directory. But what about this:
>=20
> * convert iwlwifi to first use _all_ files under intel/ and then as a
>   fallback top level directory

Yeah, that's quite annoying though since we currently look for something
like "iwlwifi-<hw>-<version>.ucode", and version will go down from some
number to another number (e.g. 73 ... 43.) So now we have to double that
loop up and try intel/...-73, ...-73, intel/...-72, ...-72, etc.?

johannes

