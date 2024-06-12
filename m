Return-Path: <linux-wireless+bounces-8857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3609051FF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FF4D2816A9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A916F0E1;
	Wed, 12 Jun 2024 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oSK4cCDB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88317374D3
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193949; cv=none; b=X6hBFEYM6iuBL/+eMB0zir4Zp4woMIcZ0gyQrhZefA0daBeSalGOAFc5ZHPY5jNXBLwCGuaQAisRzswdQ6TkfjvsnU1DDNzteaMPkKvlCw1MBMIGAJ782gOpgeyNkx3GYxFA1gTVHRfuhpXCfv8vLfEXFQ6UcHMbL1Tuv37EZPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193949; c=relaxed/simple;
	bh=E4QnWHv8dLIoq+vheL78UIzoMLHsB6bqRQNiyBcbXwY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMZRs1LDo2z8/O9FPMK7Uymfrc1bykLDqU1vRi+oCUUJyNYKBFIJF5bdA4CUQkzkgZxGICMUxHUDQRvYrJ0meiJISrrvECHq+Urdx61VZ8KolE2hf2VicdD/irY0ao93FwO36Gr6oY9cGYD3piwcmC7BaxgQoKgWuxjUAVGSsmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oSK4cCDB; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=E4QnWHv8dLIoq+vheL78UIzoMLHsB6bqRQNiyBcbXwY=;
	t=1718193947; x=1719403547; b=oSK4cCDBCm0bVboU6j74MsLLjSVjNZOc6Zbj97T5fXX9yEG
	RBkfY7yHlw6Q9ps9OrSLG8uDB4Hm6wWZAweJEq4SNmu74zQQwF7Efxg8BhCrqHTxaLm4II/kUd1TW
	9sDku/gEeIlZiixS3s8gSWj4OCWCbCQr0EpXZ7I2HZO8xbKqGs6NtB2N52oIYWt267R1QYYHVkmPY
	xgRRTX0KZbbdU6XvB/rNpBOdbXbE4z0rFJ4vjxit+3MdAx0lx3YruRlFdHtmhP+QOHy/KX0f1OrT9
	2ORI5uFldyUQvra6RXSCDD4gA2sz8o+D8eyHKGRwgQYqUFPa5az1Z4DrYQOjcvfQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHMjY-0000000AEjC-0yRF;
	Wed, 12 Jun 2024 14:05:44 +0200
Message-ID: <fa7c2aeef854f89eeb03a01a21a8d511417c92b6.camel@sipsolutions.net>
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
From: Johannes Berg <johannes@sipsolutions.net>
To: Felix Fietkau <nbd@nbd.name>, Karthikeyan Periyasamy
	 <quic_periyasa@quicinc.com>, linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, ath12k@lists.infradead.org
Date: Wed, 12 Jun 2024 14:05:43 +0200
In-Reply-To: <096940e3-713a-4533-ab0f-e82bd647e205@nbd.name>
References: 
	<cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
	 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
	 <a337de2e-fe3e-18ed-b55b-9ea2cd21baed@quicinc.com>
	 <1f32cb6c-6be8-4e3d-8e8f-2d3c728875a9@nbd.name>
	 <479752f5-221d-746b-7513-ba27ef547ac1@quicinc.com>
	 <096940e3-713a-4533-ab0f-e82bd647e205@nbd.name>
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

On Fri, 2024-06-07 at 13:04 +0200, Felix Fietkau wrote:
> > >=20
> > > Use the sum of the number of interfaces from each radio instead of th=
e=20
> > > maximum.
> >=20
> > Oh, then legacy user have misconception of the global interfaces
> > advertised and try to fail for the allowed limits.
>=20
> Sure, but that might be an issue either way until user space is updated=
=20
> and users start looking at the per-radio ifcomb data.

I'm kind of with Karthikeyan here - this could be understood as a
regression, since you're now telling userspace something you can't
actually do.

> The global data is simply not enough to describe the details of the=20
> radio split.

Obviously, but that doesn't mean the global data as advertised in the
existing attributes must be *wrong*. It could be a subset, and the
superset data is only available to new implementations.

johannes

