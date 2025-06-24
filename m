Return-Path: <linux-wireless+bounces-24428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4964AE663E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5900F3A48BD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 13:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91952BFC7F;
	Tue, 24 Jun 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tEOBGsP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A0C1F4C87
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771494; cv=none; b=FGIkizC8JVOH/DXbUL0Z/wmPXr0ot1RiBvOktqEXGVOoMpSGsJJ89ie5Ixlr//QdaBSOhJQ/gBKIfbLm9DQMRt8cZMbmcnVQ/m2tJrvrM6GVkJww4+H4aoJ5X8sUmPEpEhEyjOp7Eecvo3ikMiA8znFArI8jCExtjHPKoeiAYaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771494; c=relaxed/simple;
	bh=43CbsfS0eR9VPAZ++ArutcYSz6nn713qI0rLWqAzSrg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTK73W7qy0ZjrM10Janx9TxoKuTrdHvFeUr5+YSqD0ksD/wh61juZayC73gG2jsSRWdEQBNZlL/QLdtBPd54czDADPPnp3aTr0Tbg7EnNd/YsFFLg4hW2dJYWuNwCyZND9Wl6DIdFhP/BHJBcJlLdAxrHsj60Hgiou0+/vFP6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tEOBGsP1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qEQOzs8SVvofoslNTAz19kCIeCVN3Dba7QorZcl9RBw=;
	t=1750771493; x=1751981093; b=tEOBGsP1QDSgxx270IZF3YFhkA9Y+SLjwpd0wosVhtX6g4N
	hvByJSOg8zWe7+Gq8ZSoI6O6z2kpNxEaXs4OJ+Q9pKZRZY0IUHB9PPAirMHhLNrNLWzpCgFA/RNdU
	ZvWa4CJhkMlwMu+Th5lmIn+bl3eb3qmmLqglIx1FRLq+3WZMYEBuwE9m+eK51KTSuwLTwJX+6Qe/T
	dWn/BZZoLlXCiTHqlOGbx9h2S5Mgkdw3gYQ4dZ6ktpdQH3IHfe+xrAmqX0NPf9JwclAmvAg4a3duZ
	S7J2r5AWU7tlIiIDph8I3qTj8mLJePXgLGVLfdhHosyhzIQeXpYDhonOjopfiuPA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uU3dp-00000008rdh-2oFQ;
	Tue, 24 Jun 2025 15:24:49 +0200
Message-ID: <a8ff80ff5a811a09cf5556e20c7232eb1e201c2b.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] wifi: Preamble puncturing support for
 mesh
From: Johannes Berg <johannes@sipsolutions.net>
To: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>, 
	ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, Ramasamy Kaliappan
	 <rkaliapp@qti.qualcomm.com>
Date: Tue, 24 Jun 2025 15:24:48 +0200
In-Reply-To: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
References: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2025-06-09 at 05:40 +0530, Ramasamy Kaliappan wrote:
> From: Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>
>=20
> Preamble puncturing(=E2=80=9CPunctured 242-tone RU") refers to the transm=
ission
> of a PPDU in which no signal is present in at least one of the 20 MHz
> subchannels within the PPDU bandwidth. Puncturing might be the result of
> the unavailability of 20 MHz subchannel(s) within the PPDU bandwidth,
> such as a busy channel indicated by the CCA or the setting of the disable
> subchannel bitmap field (16 bit field) in the EHT Operations element.
>=20
> EHT disable sub channel bitmap is a 16 bit field where
> each bit corresponds to a 20 MHz channel in the given bandwidth.
> Bit 0 corresponding to the channel with lowest frequency.
> Bit set to 1 indicates that the channel is punctured, otherwise active.
>=20
> Userspace can send the EHT disable sub channel bitmap via attribute
> NL80211_ATTR_PUNCT_BITMAP in frequency  param as a part of join mesh
> (NL80211_CMD_JOIN_MESH) command. The received puncturing bitmap is
> validated and copied to chandef's punctured bitmap of mesh interface data=
.
>=20
> Build the mesh beacon=E2=80=99s EHT Operation element including
> disable_subchannel_bitmap based on chandef's punctured bitmap.
>=20
> Validate and update peer mesh station's puncturing bitmap
> in local structures while adding new mesh station
> (parsed from peer mesh station's EHT Operation element)

I ... don't really understand how this is supposed to work.

Say, for the sake of simplicity, we have an 80 MHz channel, the lowest
channel is the control channel (so puncturing 0x1 is invalid). Possible
puncturing values are 0x2, 0x4 and 0x8.

If locally we have 0x2, that means (I assume, since that's how chandef
is meant to work) CCA and RX is always on the control channel and upper
40 MHz parts. If you're now going to transmit to a station that has
puncturing 0x8, you didn't do CCA on the 0x2 subchannel, but ...
transmit anyway?

I mean, maybe this could work if the remote puncturing is a superset of
the local puncturing? But just blindly doing it the way it appears to be
done in this patchset seems ... questionable at best?

Can you explain more how this is even supposed to work?

johannes

