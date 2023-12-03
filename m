Return-Path: <linux-wireless+bounces-339-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C48802657
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 19:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D18EB208A1
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08281772A;
	Sun,  3 Dec 2023 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="N2CiwKqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA28BDA
	for <linux-wireless@vger.kernel.org>; Sun,  3 Dec 2023 10:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=p/8UcPAe70JifGu13w1d83XhVtMoxVKdXJga8AEOLs8=;
	t=1701628936; x=1702838536; b=N2CiwKqCikp/3WsPDEkKtZk3EDM/r1UQ8ezjuVdNhf/fFBk
	j7xvab5EhhLxmXlMYmUC3yGMH8Uc/EhXEJCvbHiYDSdLE5jZI5UqruSOVeIU0AidPMJTTyDsOG92m
	0JyKs+eMV0iJtbZmbHchwIPvjYHfRlWfP/WtQx/FQ/4HHkA3tAg8AUODW/FS/D0P0X5XSMDJW3mVD
	SXeLJlylWSJThvnYsZ8yaxZjS1lpDzDVWAAWc3ETyQT9GH+/qN4pMSFkdEBYpk/+vkg7bsipcojsr
	6UUkPDEuHhlQjJEpMXh1yk6G+9i5/t0UUBlpSNgHmMrkdAix6ToeHheLxoj8BWTg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9rPw-0000000DmDK-3rhR;
	Sun, 03 Dec 2023 19:42:13 +0100
Message-ID: <b9228e2e292c36d3328d09abdc0b61bcb724135f.camel@sipsolutions.net>
Subject: Re: [PATCH 14/16] wifi: mac80211: Modify type of "changed" variable.
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, gregory.greenman@intel.com
Cc: linux-wireless@vger.kernel.org, Anjaneyulu
	 <pagadala.yesu.anjaneyulu@intel.com>
Date: Sun, 03 Dec 2023 19:42:11 +0100
In-Reply-To: <f31decec-f6a1-472b-8e35-001bbf18b668@quicinc.com>
References: <20230604091128.609335-1-gregory.greenman@intel.com>
	 <20230604120651.10354a05eaf1.If19359262fe2728dd523ea6d7c3aa7dc50940411@changeid>
	 <4baf4dcd-26e5-47d6-bb17-4e23ccc8c12d@quicinc.com>
	 <f31decec-f6a1-472b-8e35-001bbf18b668@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2023-12-03 at 08:48 -0800, Jeff Johnson wrote:
> Apologies for reporting an issue that has already been (somewhat) fixed
> by 6e48ebffc2db ("wifi: mac80211: fix mesh id corruption on 32 bit
> systems"). Issue was found internally in a backported kernel and that
> fix was not present.
>=20
> But note that fix did not use DECLARE_BITMAP which I still think is the
> right thing to do everywhere we are using bitops.
>=20

The mesh use here is a bit weird with the atomic ops on it, everything
else just uses plain ops (|=3D etc.). I think that there could be done
with cmpxchg64(), but you can't assume that on 32-bit machines ...

However, I think the whole trick is really no longer needed? A quick
look at the callers of ieee80211_mbss_info_change_notify() suggests that
they all can sleep and also already hold wiphy mutex, so there's not
even any need to bounce through the workqueue *again*? IOW, we can
remove that whole thing? Do you see anything to the contrary?

So realistically I think rather than paper over it again with
DECLARE_BITMAP() and all the right thing here to do is actually try to
understand the code again and make some cleanups, since it's grown and
(mostly?) survived two major locking restructurings, but has not been
adjusted to any of that.

johannes

