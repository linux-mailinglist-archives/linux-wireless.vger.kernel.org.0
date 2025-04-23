Return-Path: <linux-wireless+bounces-21928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5985A993EE
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 18:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB77A9A2FE1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C999296148;
	Wed, 23 Apr 2025 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="L27UoAVo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06629B79F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 15:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422763; cv=none; b=WZioitxKl65g+2ZjxHjJbtSvIXg8pBBZ6DMn8mVrDhGCwdK+Af5zMHI+tQ9gWbn7IYdGE/8D/0jWZyXF5Z8i9xQs7uhB8oQ8PVjgTmOTre4qwS+SvdlrzNBVoLM6lr99RpYSj/2mwgYzFAqpTfgfG4xYQuthnpEwZ9LGt2QVda0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422763; c=relaxed/simple;
	bh=H4Cuk58S2i2STib5Wio3QxavkZvYEV52Pq7M7eJP1zo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZ3nZ6CeNKpISvzq52IRxTKW3EkRCGW3+T1Po0/mZSOmeCAlmHiHSnlX2q1hUNydmzcfrGevC8OZlqTcK+ZYUysPZFjRlQFgcVBocnYwQFkE2jsDsUOI8of4rHRGcSM3FTWRj9UMV7sawBmkXs4L3dis5twXhiLRhDTnntomZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=L27UoAVo; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8BYQdgVTClootxgGvW06mmRSpMcaxCx5cEUru3Y/KDs=;
	t=1745422761; x=1746632361; b=L27UoAVodX0gQ5qUCS7Tksp1vIoGqyAp+QbjP7rpDqBiBlq
	EbDL3/8u25wZ9apqL4nN1q0ZsHpbGzSiChcSOMi/qgJHZkK+96ZTe2K+7eww9dC5dDhbCU/92GgRB
	g2n5ThrZSu4RSPsv+4X5+ZEkDVuD71aiMbihYo4ICBgryniMXVKkL1iSSRKke0VD0C0Xqv1REhr9y
	AjZ+TQov4/hqhjlAXlcH3krt21M0NgdZ5tAnEMvQsuOQq9UsDx9lxgKOIG5MRRMfsncrcFwT034wf
	jjw3+OUJ4G1jo5qYQFVS6W10siczZDgh7gqRJKlY4z5+u+nobTK6S5NKRwl1qeTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7cBw-0000000Ene6-1ZA9;
	Wed, 23 Apr 2025 17:39:16 +0200
Message-ID: <f49009f55083da63239bab6fbc0886dba99c52fe.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next v6 3/5] wifi: mac80211: Set RTS threshold
 on per-radio basis
From: Johannes Berg <johannes@sipsolutions.net>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: linux-wireless@vger.kernel.org
Date: Wed, 23 Apr 2025 17:39:15 +0200
In-Reply-To: <20250328122519.1946729-4-quic_rdevanat@quicinc.com>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
	 <20250328122519.1946729-4-quic_rdevanat@quicinc.com>
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

On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>=20
> +TRACE_EVENT(drv_set_rts_threshold,
> +	TP_PROTO(struct ieee80211_local *local, s8 radio_id, u32 value),
> +
> +	TP_ARGS(local, radio_id, value),
> +
> +	TP_STRUCT__entry(
> +		LOCAL_ENTRY
> +		__field(s8, radio_id)
> +		__field(u32, value)
> +	),
> +
> +	TP_fast_assign(
> +		LOCAL_ASSIGN;
> +		__entry->radio_id =3D radio_id;
> +		__entry->value =3D value;
> +	),
> +
> +	TP_printk(
> +		LOCAL_PR_FMT " value:%d",
> +		LOCAL_PR_ARG, __entry->value
> +	)
>=20

I think it'd make sense (and be trivial) to have the radio ID here.

Same in the first patch, but I missed it because the print was hidden
outside the context :)

johannes

