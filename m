Return-Path: <linux-wireless+bounces-19488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23CEA46542
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 16:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E6317BE41
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6CE21CC42;
	Wed, 26 Feb 2025 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="phCCbCy2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4828F3
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584261; cv=none; b=FRcI0HUZzyMMsIsyuAar4UnZeoVM7M+XV7WDx/wpIU1O7UAHXdCDMlgacu6GW/legUD6acsMPWmxbh9OH+yhyfsqU/VJ2RzkV7jbJRv103WTnM8M9iv0ZqzWJ+YgDyT7Pw/snBZMOoHfmWQAseHMnZF9N6XI7AN7U5xX31hvhF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584261; c=relaxed/simple;
	bh=BRzd6ZVXfAyAlwnNyKMUEnhDAJfEkZ5C9q1lxgRNNvI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hsHUOC02IZXlzRaz0MhPPWOvvS4jWhnrWER0kGtK3LBxjzHikvpBWGL6BmMk58VNyf5uXfoArCF8M9sNxDgzumanZ6z5OGw56HNfkGYgQiGqRxboD1Ro3A5JwLsazgWL7QGju6kWGYInHRafRa5sM7uz9/Fra2PnQyB4H5oS4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=phCCbCy2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D0PcJHAjJl/nJYbMkgILSQBocghMzelKdxSDrf1coGE=;
	t=1740584260; x=1741793860; b=phCCbCy2C9HhJrEl7uJFsNQiGQYQfA/sPXGDsQ4/Nlk0mtq
	9RsrKIRi+//QHV1D64qKR0NjU0aVqLNhSPoGa42YWECwujwfPQKoagIw/k+o73EKrLiqqeucahs69
	GjAFDji7bTsVW0AvZuxaqOwm1jYskbs8jLEHZaKU7iwqhwdO9xo7xJCdPKNbBI/ugGDHzUNi9R8QP
	Up5ViZQnH4yV7SbQ30XTDDqtWS3UPZhFkA3IyWaJdr2bjqFtklQczIX2TnxQrYTDiTspYhjCTHc7E
	WrL0ZUzViJXkmWXTccv15lvZ78DaDI1GGerHgXbKTJCnThLQK7qp1ETprwDF/8Eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tnJTc-0000000BZoo-4AIY;
	Wed, 26 Feb 2025 16:37:37 +0100
Message-ID: <1fa2f33a67ee1c6e537095888df44c7adeae64d2.camel@sipsolutions.net>
Subject: Re: [PATCH v3 00/10] Convert mac80211 to TXQs only
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Wetzel <Alexander@wetzel-home.de>, 
	linux-wireless@vger.kernel.org
Date: Wed, 26 Feb 2025 16:37:35 +0100
In-Reply-To: <20250220104426.82011-1-Alexander@wetzel-home.de>
References: <20250220104426.82011-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2025-02-20 at 11:44 +0100, Alexander Wetzel wrote:
> This series switches all TX handling in mac80211 over to TXQs.
>=20

I really wanted to apply this, but looks like it's nowhere near ready.

There were a number of compiler and sparse warnings, which I mostly
fixed, but also testing with hostap/hwsim tests blows up completely,
e.g.:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
WARNING: possible irq lock inversion dependency detected
6.13.0-rc7-01678-g0d8fd15558f7 #110 Not tainted
--------------------------------------------------------
mac80211-phy0/114 just changed the state of lock:
000000006c784f08 (_xmit_ETHER#2){+.-.}-{3:3}, at: __dev_queue_xmit+0xb0c/0x=
c83
but this lock took another, SOFTIRQ-unsafe lock in the past:
 (&local->active_txq_lock[i]){+.+.}-{3:3}


and interrupts could create inverse lock ordering between them.


other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&local->active_txq_lock[i]);
                               local_irq_disable();
                               lock(_xmit_ETHER#2);
                               lock(&local->active_txq_lock[i]);
  <Interrupt>
    lock(_xmit_ETHER#2);

 *** DEADLOCK ***

which actually seems to happen as a deadlock, since my tests are no
longer making progress at some point.

johannes

