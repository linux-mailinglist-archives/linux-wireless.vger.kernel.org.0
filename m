Return-Path: <linux-wireless+bounces-28295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9510FC0C44D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 09:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DA83BFC99
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 08:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C152E7BBB;
	Mon, 27 Oct 2025 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DPFITrDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C102E7623;
	Mon, 27 Oct 2025 08:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552842; cv=none; b=FKDfp3cN7Xym5F1dqk3HzAFPrApicsBQTiNRApIwRNUPtCECun7bW2gkdASzBYcwJWvZHq3RNGgdPYr+EHJHfxVq+qrm/7HziwUuWllaJD41Bmor1AZsw2ITYboxv9ueSpRP7UmKgxC7VtyBZj4BPbSOXsRMfr2CLyj4yV8tumA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552842; c=relaxed/simple;
	bh=sLfCF0gWJSlrd2m8niFA+KulGKUdyPVyBZ7NplIcZSk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mF8pkgNrlvy63HlUXRfGDvX4b2zHq7FXc7eo0IbVawUmWn+FIdVm8xzdymQd4rUmsQphTpjx1rAkVaf5fA1cOlNrnH5rDKBv9g68RLPPM1cSpyYALRjK75YAtd3uOTmCi7bmnNNRJAV+dzPG21nIM/es0vU4y8CbSy5STdc53TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DPFITrDN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sLfCF0gWJSlrd2m8niFA+KulGKUdyPVyBZ7NplIcZSk=;
	t=1761552841; x=1762762441; b=DPFITrDNexkCYHQwIaC0RdBhJPCf4jskVoFQGY1eI87lOnE
	nT8SxmwiaZja+FWRkyswqnX5YsXOztY7tAIBjSZh7decMuFPMeUZR2D3NRoOeLWMsa7S4LdAMxJaf
	mKrOpzwr6SSDzbixAihdQja1Hfckm8SsNOGFwNecMTl28rnADDGdQ/Bq+bRY3QKWFF7CkYLeuLsZ8
	DKiEK0uPmQVF3iiTOZNc9u2yUBVBlsdCE9Yq8MNvfX9nIwwo4KxQSDZ99HiyQe69LmCLT38NP1tO6
	W0Het/6AFLouf6hRXdr0OnnFR5lB0/DcUWCweY+VZn3UVp5mqA3NY2clQLP2bKtw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vDIMY-0000000AE18-3OKf;
	Mon, 27 Oct 2025 09:13:58 +0100
Message-ID: <b725672aab8c5a006603110b46e6e15495acccbc.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: rt2x00: add nvmem eeprom support
From: Johannes Berg <johannes@sipsolutions.net>
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>, open list
 <linux-kernel@vger.kernel.org>
Date: Mon, 27 Oct 2025 09:13:58 +0100
In-Reply-To: <20251024203046.42275-1-rosenp@gmail.com>
References: <20251024203046.42275-1-rosenp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Please always tag patches with the tree they should apply to (e.g.
'[PATCH wireless-next]') and make sure they actually _do_ apply.

johannes

