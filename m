Return-Path: <linux-wireless+bounces-9767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C620B91DEE5
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 14:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84325280BE2
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 12:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3E0664C6;
	Mon,  1 Jul 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aPGQ7CHF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D4535D4
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 12:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719836194; cv=none; b=BKbBQcX+RewzM/80ztqzW7Xjj3hJMhgXdcgHZizM8zxXxxoKsPQ8UrIiLmk0hDIHuoHPJWbG8jIU9cG0w8t4PWxeYELiGFfxvU7j9BcGDgut1dEaitZyMFUYDS4tv3Opbr7cemcXO85d1qvnjylj3NY/WPbjYcwdpKeOukZgJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719836194; c=relaxed/simple;
	bh=NQ/0zGbbBGS9K1JOl99JGiFe+SQvcQo/+TETA0zVn3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWm7LonL0jyj73dj2NATXIsgajEBqL/EXpsS7LwLeJ2ceBHgADIAIHWnI3He3dHMuI6xiNxRP8DdHZ34cXaYc8K/uHEIkyDlHzo0rMdbHSims0/TEY4PY2S8Ie21bQH371sp3n1sBYQt+djI1d0MgUCRQivDKyX1+tvqKzag+u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aPGQ7CHF; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NQ/0zGbbBGS9K1JOl99JGiFe+SQvcQo/+TETA0zVn3M=;
	t=1719836190; x=1721045790; b=aPGQ7CHFluoasMsETcvmABdkgEoq6RzlG4HhvqV5Gjjfpz+
	c3AUhv+QGKIFdr0zAHuVeCRL3JBjvqcZlinKxKDXM0QUJOjN4hSnV3ftN1ahkbd1JG/ZniVTr25KV
	055yHHVb2oAzqB5lbfvSpK8C5egdWqWj4bQGYKBbYFpVm8/S7JsNWYguOQPgQX1Ol0+To1ZJwcUjh
	PYdRcEuad6ZO3Z2/IE/L8zun5ANcg7gG3s/7pNhr5fkMDKtspfR0YeaSFT25YdSILsEF5e4gyiKyc
	Qo/wLSJ1+1WrdUCt2ssdMVGgtsvZPMfDtchAWnt0KTBNeOb/js6R8ITbNiHO2qvQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOFxL-0000000277T-1yHa;
	Mon, 01 Jul 2024 14:16:27 +0200
Message-ID: <e58843d62968d9cbdb7768d2ed1d1445402658af.camel@sipsolutions.net>
Subject: Re: [PATCH v2 03/10] wifi: cfg80211: extend interface combination
 check for multi-radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, quic_periyasa@quicinc.com, 
	ath12k@lists.infradead.org
Date: Mon, 01 Jul 2024 14:16:26 +0200
In-Reply-To: <533ca7d2d2d6c59dc726b18b1e118270040ca627.1719733819.git-series.nbd@nbd.name>
References: 
	<cover.692a4cf1c6bce46eadecbcbf0f3e9e599099f8c4.1719733819.git-series.nbd@nbd.name>
	 <533ca7d2d2d6c59dc726b18b1e118270040ca627.1719733819.git-series.nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2024-06-30 at 09:50 +0200, Felix Fietkau wrote:
>=20
> + * @get_radio_mask: get bitmask of radios in use

I think you should document the (locking) context here - you seem to
assume (later in mac80211) that this is only called in RCU critical
section, but I'm not really sure why? (IOW, I'm not sure that's even
correct?)

Also I suppose could use a note that this may be called within the
context of cfg80211_iter_combinations() so need to be careful about
locking with that, I think. I'm not sure it's *only* called in that
context?

johannes

