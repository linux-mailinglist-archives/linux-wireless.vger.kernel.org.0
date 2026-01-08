Return-Path: <linux-wireless+bounces-30562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A36D047CF
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 286F0339E8FA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9B46620A;
	Thu,  8 Jan 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AOvVEgF0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC94466FFE
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767875270; cv=none; b=Cv/ctfhgHFNFxNDovQhk+yCOzucIoDU7J81v9XdjBDZMpcy7F5FKazXE0kz5rjVPMal7nbByirYetILDekv/D/SOj1CLD8Z2pyKXeR864JwKj728F+EwVOsxIMdGNuXBmHSxfPYP5ZoXn+J2/fXWFct/vZgmYq0gzV0eL1IB5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767875270; c=relaxed/simple;
	bh=el2gp2OuRfSnHFtALxd57PXZ97hFzRj/OfwLR6vEdE8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ex4Y7LBOypGNR2lNfpLwLcrUlSxYpfq5v0Y7OckYCeQp37/g543KFo4SJTe78Hxiop9jbdd3cB0i8poSbDTX7lXWIy5qV+0qtYejPGC+KA/7kkK2/rppkTj56ydp4afMUcQ6qCzPhMKBIWoKxZruvcxG4nqGi960pVFph67GmU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AOvVEgF0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=e4TXHoKS05eAyb/cfW8Lr2YmTCKZ1G/kgbcIfjfbj/U=;
	t=1767875269; x=1769084869; b=AOvVEgF0GOXDozqk6eSCiVY+owAx2kB2ODvJWaiZDqVs7rc
	Ck1Ne/1TveadoaRWf5OfbmYINmqSRkSHcHgw1uk1cqKRc94GFHeU2xXJxVBHQV/qA2KPnXteH8HKz
	vHaqA1ashTWEI5ircu6JtIsPHpyY4XIY2fnCiPSAAdbsAwOf8U1i7aGamhRs+55Q7/kXsfGLdXCqb
	nGylWkP/lGX+TfwPPTUwXYz4QhShNKf+I5DmLFypust5zS+R2VCal4RKTAd/udtehcvgwgRf2VNzV
	bTroQEVkLACKc1NqFUPkLy7QJDDcuczyzjVLYoVWaPYksMOUo1ZVSajm2kHrM5wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdp7B-00000006UoP-2IL8;
	Thu, 08 Jan 2026 13:27:45 +0100
Message-ID: <9eb13765529bac88337ab2fd1a13769fa4519f52.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v2 1/3] wifi: cfg80211: Add support for
 S1G Response Indication Configuration
From: Johannes Berg <johannes@sipsolutions.net>
To: Ria Thomas <ria.thomas@morsemicro.com>
Cc: linux-wireless@vger.kernel.org, lachlan.hodges@morsemicro.com, 
	arien.judge@morsemicro.com, pradeep.reddy@morsemicro.com,
 simon@morsemicro.com
Date: Thu, 08 Jan 2026 13:27:44 +0100
In-Reply-To: <20251209062424.3926297-2-ria.thomas@morsemicro.com> (sfid-20251209_072520_787538_A301A7A4)
References: <20251209062424.3926297-1-ria.thomas@morsemicro.com>
	 <20251209062424.3926297-2-ria.thomas@morsemicro.com>
	 (sfid-20251209_072520_787538_A301A7A4)
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

On Tue, 2025-12-09 at 11:54 +0530, Ria Thomas wrote:
> In S1G, a STA distributes a Response Indication (RI) to protect the
> frame expected at SIFS after the eliciting frame. Introduce a
> userspace configurable selector for the expected response frame
> type (i.e., Block Ack, NDP, or no response) after transmitting
> certain S1G frames.


> +	int	(*set_s1g_ri)(struct wiphy *wiphy, struct net_device *dev,
> +			      u8 val);

I'm generally not very happy with state that simply "exists" at the
interface level. The documentation doesn't indicate anything, but the
implementation in mac80211 just treats it as such.

Does it really _need_ to be that way for any reason, rather than being a
setting that is, say, part of the association and/or AP setup?

johannes

