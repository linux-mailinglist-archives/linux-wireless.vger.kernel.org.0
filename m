Return-Path: <linux-wireless+bounces-28718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45EC45369
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 08:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 980CC4E5F6E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20061E5B9E;
	Mon, 10 Nov 2025 07:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sQ7a5tu0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A8734D387;
	Mon, 10 Nov 2025 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759826; cv=none; b=gS/jJVOf1IOrBMhhwbvsMyilHe2sVLDi7NOAsP4hNhuQnOpqgAyHNRzjc2207gLypuYs5nyW5qdGZ3HuDBfBkiTrVL7a4Ysj/6w5KWTxLDovVtgxchfy/kdfKg0V3P9DJKx0xgx2g7l+EDHEz2NXa2LP3T0ujeXn3NrlcLh8k3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759826; c=relaxed/simple;
	bh=vB3yG3u1HPIOBMrMfvLJNCi44Wt7SOdtlWqrEboiIZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxH0K4JyDmyZ3K0m3KQ+snshf1nQl5ZNG02wMGEBReAkfZDvNwVq6d+FUfgemGJ2fKlT8x7X+DKFyu7svZ0qZVBlXCtK6WxhFYYgKvJsE8QW2eeNTU1Hu07NHHwZMZlNT6XUeS1sJ0Nc6LscOmPdO345qRoRKRUTIZeC5f6JBVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sQ7a5tu0; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=6llHOq+3Rda+nZeDGBihGvSanKergk1x64UKfH+7VLY=;
	t=1762759825; x=1763969425; b=sQ7a5tu0mernfwJK0XuOTsdOrIoPj1OkcI/KE2oO4qt8TLf
	hw5jLrTUqXbK/3QcH/L8/QqThOYullai2N04vbs10fAhCptUZasOvXfkndRTCElOm0F+qwVHu//Ce
	BOywgeFXa5sG80Tx78OSBU95cQc92ghBh6XSyLpaEpjlvJQm7IgAlTdS+DSXdMjylR+w77bERJ3S4
	e1nu8alQgKUEDcXvBwP25x7t56jpOd/m0FO8iRA6+ovnI3Wcop6+Emo1k1Pa1HyNe42AUmtPprOUI
	CGSKg4nef3nHGqX3zLmKjqFTL+HPZsD2HbYgBt3Qp3OaLXtMVavDFZ/5jtL0tOow==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vIMLv-0000000Apmf-2agH;
	Mon, 10 Nov 2025 08:30:15 +0100
Message-ID: <f1d7cd013d102972976d39e7fadef9e91a1c6056.camel@sipsolutions.net>
Subject: Re: [PATCH] mwl8k: inject DS Params IE into beacons if missing
From: Johannes Berg <johannes@sipsolutions.net>
To: Pawel Dembicki <paweldembicki@gmail.com>, linux-wireless@vger.kernel.org
Cc: Antony Kolitsos <zeusomighty@hotmail.com>, Roopni Devanathan
	 <quic_rdevanat@quicinc.com>, Thomas Fourier <fourier.thomas@gmail.com>, 
	linux-kernel@vger.kernel.org
Date: Mon, 10 Nov 2025 08:30:14 +0100
In-Reply-To: <20251110072359.2295615-2-paweldembicki@gmail.com>
References: <20251110072359.2295615-2-paweldembicki@gmail.com>
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

Missing wifi: prefix.

> +
> +	/* Inject a DS Params IE at the beginning of the IE list */

It hasn't really been called "IE" ("information element") in years, just
"element". Might want to update your terminology (at least for new
code), same also in subect. Also the element you're talking about is
(now?) "DSSS Parameter Set" in the spec.

> +	buf_dst[hdr_len + 0] =3D WLAN_EID_DS_PARAMS;
> +	buf_dst[hdr_len + 1] =3D 1;
> +	buf_dst[hdr_len + 2] =3D hw->conf.chandef.chan->hw_value;

That's wrong, it should be after the SSID and Supported Rates and BSS
Membership Selectors elements.

Normally this doesn't matter much, but I wouldn't be surprised if there
were implementations that assume the SSID is at a fixed first position.

johannes

