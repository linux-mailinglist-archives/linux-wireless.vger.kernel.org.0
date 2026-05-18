Return-Path: <linux-wireless+bounces-36571-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLgEMWW/Cmrb7AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36571-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:27:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E4567811
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC6E30479FA
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B583DE428;
	Mon, 18 May 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECfa4u+0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0A3D25CB
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088970; cv=pass; b=feoHq8Wyu/81Nnuli+NOi4fOik1ydfXGOf96fWMIChdnEg+aFzQzjC0t8LuqSsRGgRiPOVKYYhxScs+3/aeCLmhkXNxQgRP+cNd5g07PKq1kwtqV3NxtLkBMA5pBPylFk3DUVSzI95+QQxbnMhauo87TyBykME/ks4flqw9e2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088970; c=relaxed/simple;
	bh=xg46MQaSin9A/MQdlCFiNIF699yLIDqpR5YisEDNkp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxiJOl8GGH77E2S2RQaLxFZaGRG2gkb/s71wu8EqSP/AKvAlVlajkzhBV6wKLTM1CyE847OI4WoshFe/bK8huApHRWEdpwR4lGvVmNe5XJjxc182Z0LOmRgRPTs4ofr4FxfuDahcaGrS/hqEWdrrCrNxl3tHHtcv0qGN1inwN4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECfa4u+0; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67c2d57a5ceso3298768a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 00:22:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779088967; cv=none;
        d=google.com; s=arc-20240605;
        b=WWJUI/JLUQR0ug27cKZU/cWxaRrL+q2IkMJPELEH1Gw0XMk2wte5j+dUQMB9Sug4Eo
         97uXAPnIEZ7IZewSqK0aTQPe6KHMHW7PniIq74eyv9xHbFPJNubKLV2YrB/kBJNUzJct
         OmJNTZjpyWtQ3tmOoXkOTwuq+7ZriNmJITA4FlDTmLXBsTJHliNHp+HN4f1GUWKDLlSH
         ac25WtPuryCQa0MMUWRSqnmy4YfQRNo5HdsNAY+isubRIgN5hp+hG/rciKybbtM1Ub8H
         004ILROtEyQpS+bPEVmt+1TLPJ13ZJReHa0btbrJYJQfk5tZQKBusNVITrJ0oj5FVGto
         TknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgRtEhM5dbN97kdxBUCH84lfE1fQzr6AjnHubskOcUU=;
        fh=ecY3AWkosI496fCOyvqOhMbTWue0THHhofPeVGmnugU=;
        b=dzI7DGA+zV7nAnuUczp6P4pyMjTfJ9jTnUfL1iEe4YsxaNx2/nmkbFAAWVbB1SoHr2
         08HsDXJtiKhLLJSioHZfdOTRu3zY07Bk+8T4KeGFcyJY2BznjLiikT+xaEdQXcUW9N6a
         TUulU47FVlVUsHXKPonSAXHVVPfuwkIRKHja4x0qrhGARI2rlc7hVBN9FwFFFG/TWdx8
         By4pLxbuao6CULrEeaJXhRvQ7SkFp1sy7pA8+xN9YIaTbx4cXH0FNuS3K6sNwOenFGhL
         4f20pjc1/V+SB09EyQlr7gPlQQJoaBILUa3Ign/qjKMoSR33SWCGCm+MOr4VY3gDqIPh
         W7aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779088967; x=1779693767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgRtEhM5dbN97kdxBUCH84lfE1fQzr6AjnHubskOcUU=;
        b=ECfa4u+0w0SRO4vB8BaF34nge0tHNP2f5yW4M1IMQo+XgEX44AkDXWXH+9KwLL5o00
         5kINSSbVQXGTI7mEs4fa3GGjpegBV0hPjRiHcMubMjvdY9s6tNVqz1+GPCDsyMm+/QDo
         CmSDO9cuMtyhBEfStwmyj2Vww4jnM8tPSWZwZFgtBq7bJiRBrFDN+M34utxIonWvN1so
         vppbuxzXGypDXW2jGdpLjfqTK6DTI4jKhZzgb4e4ksT56D4EF58YRDhNVGyWYOF85xF2
         aNceJKPyvwYUmSvY6I3bbYd63vzs1SJ4uNWg9e/H08n4EiWX/mwY4vJQgEQQdnMJ1YB5
         QxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779088967; x=1779693767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PgRtEhM5dbN97kdxBUCH84lfE1fQzr6AjnHubskOcUU=;
        b=oTVSiygki4ow3AhOgWkqCAbB23r04PdMiIjN7DzRocOquqog5Ei67l06Zughcp8Y0S
         Fm9Ca2M9bxLxjR9XZKnyVIB/2r28mpHGXkEE3URP1qvqr+g+q1u6A/GdbouMuBE4LchA
         GCGTpDd+OK5/UePEV3hmRg3rg6xXjSafZ+w3CLrTIgG5mqSiMME04SSjJiqmgoUOPgP+
         ubTKnwqrfZWFHM9N0P/vaeuS/29uu2g4Hp03IptHHYIFGEp8G6wQ24y/EJPV4Kl/Q0ZV
         KYt11HS28l7S7GhknQ2P4kWs1Sx99/4J1h5+I7Bl4v3Kk8T7Yqu4+otRVGDD5yBPszrn
         DNtQ==
X-Gm-Message-State: AOJu0Yxx45mZOhzH/T6Xjmt6WbyJV94l5iVcdOHWRlFOsUiOZBTnLLAz
	EZCqGybU/j09qYPqnHWwAOZ0dN+SOlle+iqRRx/46DOlE/KQJirDv9rnvCSPqzdLjeBfb+psISe
	4/OfXVCSw21h5tHxfFvKVvzx0LWXhgMs=
X-Gm-Gg: Acq92OGKTiD8JOUy8wn1hCyL8AUYe1d1tT4tC23OvHBLiE9FmVuSS7x8i2phWtZ6sJE
	p6Wwdw8hzT3CcoY3DcGRkjER+IDfvLZ7TA1sl4doc+Y9+flNlOU0rlx5VaQW8o278+TzQUkhC4z
	53xi1OaP5tvVPB8FL2ro43CYkgDT7ckIT9BG2cZWKyfXa/k9U4KCPyssyNsDu4+Y1npM7/GCo0W
	V8d28S5Wtl54kc6hChIflcIaPJ8icJ5GpxhV49YJu760de+1en72Mb5UkLYgS+u8zNt4oNllSTN
	gSeZ9A==
X-Received: by 2002:aa7:d14f:0:b0:674:7363:3e91 with SMTP id
 4fb4d7f45d1cf-683bce9cec6mr4697754a12.12.1779088966628; Mon, 18 May 2026
 00:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHrRpu=Ku=cK2Hd8xzJr82iPkj4Jzp57ch9wEE1KsoCiExbhbA@mail.gmail.com>
 <20260516100024.103241-1-maashif011@gmail.com>
In-Reply-To: <20260516100024.103241-1-maashif011@gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 18 May 2026 15:22:34 +0800
X-Gm-Features: AVHnY4LwBv78b-ixqlZgkLa_y0xQ2eEDERvG_Vpnm1Cp2zq8B-H79guKvrWBXgM
Message-ID: <CAHrRpu=-ngPpe2MsmWz0gQq1VVxbr9L0+jUos3o62wPUY-wXqQ@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory rules for Sri Lanka (LK)
To: Mohamed Aashif <maashif011@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2D7E4567811
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36571-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Mohamed Aashif <maashif011@gmail.com> wrote=EF=BC=9A
>
> Update Sri Lanka regulatory domain based on the RTTE Type Approval
> Rules 2020 from the Telecommunications Regulatory Commission of
> Sri Lanka (TRC).
>
> Source: https://www.trc.gov.lk/content/files/licensing/RTTE_GAZETTE-Engli=
sh.pdf
>
> Key changes:
> - Change DFS region from FCC to ETSI (document references ETSI
>   standards EN 300 328 and EN 301 893 as the applicable radio
>   interface standards)
> - 2.4 GHz: expand to 2400-2483.5 MHz at 23 dBm
> - 5150-5250 MHz: 23 dBm with DFS

This range doesn't need DFS.
Otherwise, looks good to me.

> - 5250-5350 MHz: 20 dBm with DFS (no TPC, 3 dB reduction per EN 301 893)
> - 5470-5725 MHz: 27 dBm with DFS (no TPC, per EN 301 893)
> - 5725-5875 MHz: 24 dBm with DFS (per ETSI EN 302 502)
>
> Note: The TRC gazette conflicts internally by allowing 30 dBm for
> 5725-5875 MHz while citing EN 301 893 (which doesn't cover this band).
> Lacking TRC clarification, we conservatively default to the ETSI
> EN 302 502 limits (24 dBm).
>
> Signed-off-by: Mohamed Aashif <maashif011@gmail.com>

