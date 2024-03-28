Return-Path: <linux-wireless+bounces-5444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2129488F913
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 08:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD99292927
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035B50A7E;
	Thu, 28 Mar 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uDWMqBXd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040428DB3
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612017; cv=none; b=aIBn9XOtzZjZfK7HP4H2NXfGzQeMeGTzp7TjR/AQPEYXPHzpHmqvtWWAo/lpAmiV1ieLvfNUGLO2JJ/64EDukaof2SrstNYFajFTyQdWaGftpYb48R8nRmp/ZdwyzGaw1oGpV82CttmvHq33UXtCulPDA9X4Pdnf+kHLPgCuIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612017; c=relaxed/simple;
	bh=RIcp6iZ/oHdu6jbyqpVGhaFJisEzzppkGN6I0pVkpfg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYTswr42U8M44NNPhrHxd1CQRYs/Yo/K2f23zvgGAM17xhygKz7VtLzYhjoabTY2HqoBF08mgR8yjsBTqvXMsQCh4Q8+LpAJ6/TbQLQU4422t5NasqCks4ocX4vxMlEsNyyUoIdXrSYDx2LNKkJfMA+jFHe5qaghqaDFQ4MJgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uDWMqBXd; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EERVwLfnx9UxbLLME3eZTuSPk1hWRplKd/lN6v8KhsQ=;
	t=1711612016; x=1712821616; b=uDWMqBXdHeZn0TbnD//Tryt6QOoqYaeHG6cFuXbfiKetYGU
	IlarldI0pi9EH0NyhcFfqCw45x6GN4fVXmM1wh/3S2ZZiICqltWumOzjCM3/IWexSzOILBE+MfLlp
	YmSMaUXdioHPi30wpToPM/K0xK6V5Q0+0X2BxCpSQPpBk6HVMcelevkJQMM2bXIoaEfl3+RRQ9J5V
	zyOIUTlyX9gh9+aHZDnWyHsv1nRMFunT2zFuq/+YK97ZB2OUVwcGqnIWoPEotaXnV8ozYZhvgHu1v
	ab0cQCahjBhKFbJv/7j0RUgg9Khy2taz7rUhcY8FmKIzilL99+OXc+ZZMNqdgPeQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpkTL-00000000koo-3yZ3;
	Thu, 28 Mar 2024 08:46:52 +0100
Message-ID: <e36599d3269496de59505b36be46f873976f8706.camel@sipsolutions.net>
Subject: Re: [PATCH 01/13] wifi: cfg80211: Add provision to advertise
 multiple radio in one wiphy
From: Johannes Berg <johannes@sipsolutions.net>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Vasanthakumar Thiagarajan
	 <quic_vthiagar@quicinc.com>
Date: Thu, 28 Mar 2024 08:46:50 +0100
In-Reply-To: <20240328072916.1164195-2-quic_periyasa@quicinc.com>
References: <20240328072916.1164195-1-quic_periyasa@quicinc.com>
	 <20240328072916.1164195-2-quic_periyasa@quicinc.com>
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

That's a big set, not sure I can review it all at once :)


> +struct ieee80211_chans_per_hw {
> +	u32 n_chans;
> +	struct ieee80211_channel chans[];

That should probably use __counted_by() these days.

> + * @hw_chans: list of the channels supported by every constituent underl=
ying
> + *	hardware. Drivers abstracting multiple discrete hardware (radio) unde=
r
> + *	one wiphy can advertise the list of channels supported by each physic=
al
> + *	hardware in this list. Underlying hardware specific channel list can =
be
> + *	used while describing interface combination for each of them.

I'd expect there to be a limit on channels being within a single band on
a single "hardware"?

> + * @num_hw: number of underlying hardware for which the channels list ar=
e

"number of [...] hardware" sounds odd to me, perhaps 'devices'?

> + *	advertised in @hw_chans, 0 if multi hardware is not support. Expect >=
2
> + *	if multi hardware is support.

>1, I guess, not >2 - and =3D=3D1 makes no sense really, maybe it should sa=
y
that?

> +static bool
> +cfg80211_hw_chans_in_supported_list(struct wiphy *wiphy,
> +				    const struct ieee80211_chans_per_hw *chans)
> +{
> +	enum nl80211_band band;
> +	struct ieee80211_supported_band *sband;
> +	int i, j;
> +
> +	for (i =3D 0; i < chans->n_chans; i++) {
> +		bool found =3D false;

So if there should be a limit on single band per HW then probably this
check could be written more efficiently: finding the band first based on
the first channel, and then checking all the channels exist within the
band.

johannes

