Return-Path: <linux-wireless+bounces-31171-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCYwGfY9d2mMdQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31171-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:12:06 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB79867B3
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 11:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 101B93007BA4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 10:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940053064AF;
	Mon, 26 Jan 2026 10:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U51qV3yx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5132E697
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422295; cv=none; b=OQ23JY8I2JRezX2d2ZNYndh4PKlXMQdHu5INxz49cS2/jQicOJ+uU6DJe2Wyr0nJZJc5rBDc5loSQkmsqV0Mz9yRnAGm8C0I4l28ehI+QpRhIBuVUIkdh4MKacST/WlNhkN0zvuhsJIujWqJpOAibBewdMGQ+/OU16d2pGNz2yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422295; c=relaxed/simple;
	bh=y1c12emG+9pcr1/SvGw067wmVfnlitc2qM5pbv5dJmo=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rn6TokC7Lhi2Y79lJdbfnU9o9x6pBnr9xiz9ogK+fG1D+WqCGXTRE6UvKYXROrD8Hb+ls13+8vNp7YGsD+E3MFjdijMsQ2yxxzt95GJ70nOTUH4p68xLhYORd/J6mZehG/fC4JXR1HY/2KgZeF0EgEybG6HZBY/28dIgf7/yctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U51qV3yx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so8646361a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769422292; x=1770027092; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvc4mcNxQ2S7z08pggxNBkVI5iQmFZjLgi5JVTmtGX0=;
        b=U51qV3yx8tdUt6jCx0pffq5F+zPv4SxdgoqO4rbCyVQns0itGk0ZPNFzsC2xwcoH4u
         CRm8n8GjaMu6NAoqjkR92TdJ+hiw6vnbnCADIQ8J7D1/nmuvPJeSL1w4nYZaxwowlCfl
         7MTTYAXa4+6A3XOXu3PxRhG4krB1DS5E1OMFDdt3NXZWClwyez3mnO5EgVQNK1JY/omH
         8PtbF7vhRkNSkw64vvjK2Fd5J4iN6aEVMT6roS0vFP4Te8KGZ8/t3K4y+b4oUhSQvej6
         Vb3ILUMTxVqfPcGjn9LFHnnD4DnR9c+rzjbGs6gLiOuTrIC8dybL+N20Jzgs1axQ5cYR
         Gnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769422292; x=1770027092;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvc4mcNxQ2S7z08pggxNBkVI5iQmFZjLgi5JVTmtGX0=;
        b=MHok+K8lS8DR60OnqnS3m4Vu+PyIuMCiLBJgAmajUXj7p3aFAzuc9wCnI4UXJ6Gf0C
         f8VBZ6m+TcGrd3kl3Y+Cx0WAEn2KTNf0hQeDG5MOEXPwX0yk5wvrFx9zI3tB3fk9LFQS
         kmNh8vMsyNl3p3X7RA98nhGj2TE7jYdGZYdf8M3c8YmkNH24yFP3V95Kh6/8SrWFn34p
         NJt0nNcWz13dwvosWksRT0YSWaShuWhtEhFeBrDGErK9jo/zT/ZIvpKQLgG1sTwyp4at
         Np2bWBRo7IjYpt/r4uu/Bj5T4Kaf0RF51jVNbhiATYaCI0NyDb7o6fa0Ah2A4MysxBsV
         pucw==
X-Gm-Message-State: AOJu0YxFZDHN0dgp6ztlS8eE1bgxsv9xw2rkF1QpjCuycWz0o4xE7x94
	/olQZAVjCY5m9mlJY+roHvE665Xpua+chTDokQXFZm5YIIyd36iEGrx4
X-Gm-Gg: AZuq6aLUYAYACgwOXHp4yQQXn4/u4C6kses47EPx142fTUjJIichTEz+cTZfd+9hgeY
	BJiXbHVfpxlV6e1g8/+q5DW3jqp8t0Z2EIn811q87yLVeApnljAgP+fmq34WeuuP18MdzTG/Q7g
	Oc2UrkuSO90AINyje8kVZfC4of9Y/TvgmPKK0Y3+QFbdhbU/iz5hKO7po34fpbNSf5du8/ITm7c
	BFYGU/Q/kAQOtbVQ9TEfHpIuYmOavOxjWFRKpuJGDblP18qJsZn6KFDrDp0b9ig0DQ4QqAgNfIL
	iKrTw9A3tZmhI1ZhQPi8ZoS12x0BwmK1bk6AZaYgX5r3dpNvpsJk9SbUo2FPLXQaj4OO1uoThdE
	RjVe3CbD9af1tMhPbvGkxObsguEjRDtKKe+p+VU3St7XAudtY0FJyUi/yMCGBk2++Z116WqbKuQ
	YeH8ACWobpmBKvcaRc5GdpnBpggRmCNQ==
X-Received: by 2002:a17:906:6a0b:b0:b80:40ea:1d65 with SMTP id a640c23a62f3a-b8ceefeb05fmr315527566b.31.1769422291853;
        Mon, 26 Jan 2026 02:11:31 -0800 (PST)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b7b1a7fsm597126266b.58.2026.01.26.02.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 02:11:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Jan 2026 11:11:30 +0100
Message-Id: <DFYFUQNL5YRY.24VJC5QJMQFVF@gmail.com>
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Johannes Berg" <johannes@sipsolutions.net>, "Pablo MARTIN-GOMEZ"
 <pmartin-gomez@freebox.fr>, "Nicolas Escande" <nico.escande@gmail.com>,
 <ath12k@lists.infradead.org>
Cc: <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH ath-next] wifi: ath12k: avoid setting 320MHZ support on
 non 6GHz band
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260123144224.2216923-1-nico.escande@gmail.com>
 <d26ee979-b5d5-4f50-b423-f8783122f603@freebox.fr>
 <bfed10db742d29f0609acb04d3354695f87b24e2.camel@sipsolutions.net>
 <b0e79f6c-36d7-4e49-9d43-8e305a598201@freebox.fr>
 <26bfd810c1dabc9ed86d4ba68cd20f6434c1d3a2.camel@sipsolutions.net>
In-Reply-To: <26bfd810c1dabc9ed86d4ba68cd20f6434c1d3a2.camel@sipsolutions.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31171-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,freebox.fr,gmail.com,lists.infradead.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicoescande@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFB79867B3
X-Rspamd-Action: no action

On Fri Jan 23, 2026 at 8:29 PM CET, Johannes Berg wrote:
> On Fri, 2026-01-23 at 20:21 +0100, Pablo MARTIN-GOMEZ wrote:
>>=20
>> > > > +	} else {
>> > > > +		phy_cap[0] &=3D ~IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
>> > > > +		phy_cap[1] &=3D ~IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_320MHZ_MA=
SK;
>> > > > +		phy_cap[2] &=3D ~IEEE80211_EHT_PHY_CAP2_SOUNDING_DIM_320MHZ_MAS=
K;
>> > > > +		phy_cap[6] &=3D ~IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_320MHZ;
>> > > > +	}
>> > > If you want to clear all 320 MHz fields, you'll also have to clear
>> > > IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MHZ and
>> > > IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ (not sure why it is not =
done
>> > > in mac80211)
>> > >=20

If the QCA guys are interrested I can post a v2 with the additionnal bits a=
lso
cleared.

>> > This is, effectively, a firmware workaround. It doesn't belong into
>> > mac80211. All other drivers just have their capabilities managed in th=
e
>> > driver anyway.
>> >=20
>> > johannes
>>=20

Yep you made me realize that. So I tracked how to fix it in the underlying
driver and posted this patch.

>> I wasn't talking about putting this patch in mac80211 (I've seen the=20
>> discussion on the patch Nicolas sent on linux-wireless), I'm talking=20
>> about the function `ieee80211_put_eht_cap` clearing the Beamformee SS=20
>> and Sounding Dimension fields but not the Non-OFDMA UL MU-MIMO and MU=20
>> Beamformer fields for each bandwidth.
>
> Ah, you're asking why mac80211 doesn't clear those bits ... I guess it
> just doesn't matter. If you're not on 320 MHz I'd guess the bits are
> never checked, so it's not really relevant at all, although then could
> argue that you only need the first line here as well.

I you want Johannes, I can post a patch that also clears those bits in mac8=
0211
>
> johannes

Nico,

