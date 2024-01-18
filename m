Return-Path: <linux-wireless+bounces-2186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC82831ACB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FEC41C211EE
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 13:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C725553;
	Thu, 18 Jan 2024 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AzHplHdy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BD24B42
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585586; cv=none; b=ltTJ7LHU6nsOHu5MQol8XiMksSNgIg3fIo3xTkKveWkE/G8ssa8TifjG64mAbQF24n9i1vywiismZqqUOpj52BcnrzdFddN0oHCPzKJ0FsqLBc0ZnmNGIqMOgtetROC1L33J7md2/+2xZXv/si7J5Ks/PcJCXVf47LgI0iduNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585586; c=relaxed/simple;
	bh=je3JewdLj5PYFyLNnXFPbuzK89xCvkX0qHYM9S3A/yY=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=U1Dhooeteo5w8wqTvDn+njvpM+wwuSmY6F8rPFQ9vw9qokj3ShmtVXxmZwnDK8MDhUZyS3O0zUMPlTynJ+psQ9GRwngQN7XUk9njaT0bSGzcz16S2yXche4NlFKJORCjlNhYtORfJT8vRIFOQug/+TPVdhwHr9r2z/9S8zV0FHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AzHplHdy; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=je3JewdLj5PYFyLNnXFPbuzK89xCvkX0qHYM9S3A/yY=;
	t=1705585585; x=1706795185; b=AzHplHdyNV5f0kNwVYZMc+m9UCGv1LKgRuWeIa2qBtfdY3I
	ou1Sy6zii5qQvR1X3Ddvks/wMMXHJWjbJjf5yBVKXsqFePccz/tqzGsfDnqOYPUWtjofzkZU4Aq+O
	7kL1hMV5cI+JUd1KdWsMxeMvxrX5Dmb5gXeeUrLqlMPBTrLTCK4Ma9kch7VjtjXBHXTp9cPMdLNeR
	oudy2UGofv39JVcI8nbPVb3Theta1wOM1vS9Vj1ZOl9XCYJcZ9N7umrABvjh99EXGHGmhXUFmmnbD
	A/nG8trp3m7AszqE7+eW1ulGVPr3VQfXcAVDVOcc8i8m3MlcWGfFB+TytOhhTMJQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQSil-000000082kt-2h7n;
	Thu, 18 Jan 2024 14:46:15 +0100
Message-ID: <9433d29b643e4cce3a9354282405288c75c45e02.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: don't ask rate control with zero rate
 mask if scanning
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Felix Fietkau <nbd@nbd.name>, Kalle Valo <kvalo@kernel.org>, 
	linux-wireless@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Date: Thu, 18 Jan 2024 14:46:14 +0100
In-Reply-To: <20240117124848.120438-1-dmantipov@yandex.ru>
References: <20240117124848.120438-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-01-17 at 15:48 +0300, Dmitry Antipov wrote:
> If we're scanning and got the control frame with zero rate mask, drop
> the frame before '__rate_control_send_low()' getting stuck attempting
> to select supported rate.

But why drop the frame? I'm still thinking that it just doesn't really
make sense to apply the rate mask to scanning at all?

The most common use case for this is probably P2P-style things where you
just don't want to use CCK, but for scanning we have
NL80211_ATTR_TX_NO_CCK_RATE for this, so there's really no need to apply
the rate mask?

johannes


