Return-Path: <linux-wireless+bounces-33067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOxOCMBesmlmMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-33067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:35:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB8C26DE8C
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 07:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6540F302BDE2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2026 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C8438643F;
	Thu, 12 Mar 2026 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLncxxth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8F731E82C
	for <linux-wireless@vger.kernel.org>; Thu, 12 Mar 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773297268; cv=pass; b=I6eZ6n4R6WTD6TbJ/d+aITUvsKNCuPm5VwPdNAmPMV1lNyqKoDOWG5uk69nwHLtKyMAQwwJUD00bPUwpUTHKUXVsRToNR+OCG61GUzzbdXGRi/QA6WGNaQ6nSqNq7eOiUD+7CBrJ1/ZN0RpO4giRpVpzxlZGxBgnaLsagIPxMfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773297268; c=relaxed/simple;
	bh=Jn+O4pdeeeioa42a+nUQ0Vx1ezrcQ9yGPs4EqTtLAXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB1WTXcMBFCxLnNCf5fi46ejrwAupSPvPaEsKdixtODONj9d7A7PWv10+Klc4ns96pICahWAvNtQC/egu/DIIXU8TO10zW6sQxeeSiphl3W/6AqZ1Sq6EfzNHEJIsyQ38e6mjI3rSY+2WRydonN1VEf67IvllOOYdFhWIRyqpEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLncxxth; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b93698bb57aso134958566b.0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Mar 2026 23:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773297265; cv=none;
        d=google.com; s=arc-20240605;
        b=FHPCWxqsbiK8lF2cgOSiSuhvA+UJK8RG3keMFZZjyYzxHxtnUYCqV6fF1Pt/0TC02C
         W4ek3zbJ2A8PuAUJ2Uw08/HGCAduuED2cxK8hXoPPUzVI7ZFLLOqo5LqnoncB4iuNKlO
         Q6UKAXnfshhFCgaY7V8DeUye5SC/ToCeM6HN+5yXyvNNcKSZNjj/7Bm/eBGSJEnUiCtk
         zAgRwIdf5VFXVyQjqq0PIbQg1W0ePiyVD/UJMEwQA5l8nQwDHv4wJwCOn2FGMuobRqqn
         LX3sPBLf6n9A7RPFyPKIvEZShjUfp28cpkvQxkib2Fg9IvX1eBoxwYmBUQoQ800yGEFi
         Ep9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=enYO94w1cNShnLJdTYwD60QDPyXy1KtTBcZfqrCdw8A=;
        fh=wbsNQW6WxgasZUldIxQ4qaIXV6GxDaK6xCpThAsbav4=;
        b=e9OVFhjRitzVGQH6CHPxRVZnZqHN+HiUlWACuT8ZwvYkG03nej8ZWQrJJgOS00A9iz
         mDs1GVmAOdM5zP8Lxsld1YPGs8qnn5M1448P50pznEucdXwWICVpIum9qefixClCffhH
         aQpS9doFqjqx/Iwr/pNgTzM5rPuO9DADFiroUwPxhEvXkiyVGU4rj0SlPNOwmnXVtStn
         nQqB85ByDBYB47t0xzLJjk8dPPIlXr4RMVyU9DC4d9NjThimgkmV5Psb9iLeZb05Y8VJ
         6OlhbsqKBIKEfpxQl6Rtxgg/3NnmLga/pY8vmk4Np+5Y/hJwJFid8Cc5IWHy3WaTzRAy
         977Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773297265; x=1773902065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=enYO94w1cNShnLJdTYwD60QDPyXy1KtTBcZfqrCdw8A=;
        b=SLncxxthLh+Ky+OOgK3BoA3Cn3qG6bCbDt7l4XPp+tevFIahc4HcrVZVcv4fGPWmbX
         14AHQAi151vSwMwSvD/fGBLQVe6tPm7UoWB+0nk/kqWG3aoZhPcgbHUBAyR30klHsCfH
         PaoRIWg7x2SuTNTqbJxYr/9VVxaJ6JZfANi+TpAEhJgelilTHK5vZEJvqawCIGT649mV
         M+COVLE66uH7oonfOt6NCYa/AgGD/NF3is9GcoYdHAnV3Rr1fq2O79/gT/qCHlYjon+C
         vxX8yN3QVUWgnI3yjBYUdzZuj2GHQmcM76FY5EYs5A/hSI+t/OuT+1qI8lRTdf0U4uth
         yXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773297265; x=1773902065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=enYO94w1cNShnLJdTYwD60QDPyXy1KtTBcZfqrCdw8A=;
        b=Ot+XUgD79VmBkAQ227ObyW0BPnxnndKtIO3ha6RFK5obP3zwXGyVjQYmFx23ShBbvc
         5XXOXZ3LJN1M3qY0adJYLNaF2YAqXsQ5srMCWKJrLlsO3Lxl8+HsRxxLOzqHJ+SVJc7T
         3uAsnIciAiCymzsagyU/oKyzK6WRUdAgXwelL3IAJeejuti3kHeZZKhK99Ic9oKRCmZa
         l65kh6ETB9lTtqBSc8UhHPSg/qS/Dfj6j3keHLSKhVLBP2lhkyApQdGJ5ipbRM2i+LYq
         2PbILJeyWOh3WsBuaMCtZVjE/wyj5sfVSJC6dgVpioqgo9GuJX8h4wqqP8rWqxOGORob
         IwlA==
X-Forwarded-Encrypted: i=1; AJvYcCWd+q8ew8j/Pg0AnCqPQ8M0IGnCSdXL1uSKgCZEcosUPmllh9MsvFJFsBjnwUejxs6BnvPwqyCcZaPZIG+fTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMjMfPqzWQJB05OQB2beModI7t6o6i0F/QwHc8+FZzh/FAznP7
	JPhejI2BBxKkH2Gv6R9g321Cdrlqo6hDSNM3dEkhiqnxBx6MWZQYfn6Zm8PPOvdy/ZrVhmEqp4F
	up0+ewJISl2B//HFdBT4/JLe89ZxXHO4=
X-Gm-Gg: ATEYQzxjuOYAc09x5t4vZ21onVPQx+9uzRRwso0MvctAJzJ14pwo3cxWY0r0Wrff8T3
	9yFTN3iuHF19mmLXIOZ/ytiiZxjsfXY0OOn0c5XkGaXaZfhbTQcglo7TV5HKu3fUeB0sbKe7PXf
	dcERAsYQq2pJWFia1ipXr8rutDygw3tMZPiXejaBeiEPhMBM4wku6Cqcik4zE0wfbEJ6sEpBGcS
	io7jRpsM3IwRKvRe6j+svyjatR8aYAR9W/treYOHqTkJMNulwV39eNsHnvFlcFeTTRRSyJPPwpW
	4KloSioSoj3ImgObQ3Ap
X-Received: by 2002:a17:907:928e:b0:b94:3ae3:6af7 with SMTP id
 a640c23a62f3a-b973ffccc90mr127641866b.17.1773297265162; Wed, 11 Mar 2026
 23:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311085141.1634383-1-wens@kernel.org> <CAHrRpunHZhCfBwueaXQS46SA5JzAbbW5DVL2MF+m2tKvKyMZAQ@mail.gmail.com>
 <CAGb2v67+CMC=6Hvn50RRzHxa1Syi+gj4WOpE3LJhNyrxxe5Hrw@mail.gmail.com>
In-Reply-To: <CAGb2v67+CMC=6Hvn50RRzHxa1Syi+gj4WOpE3LJhNyrxxe5Hrw@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Thu, 12 Mar 2026 14:34:14 +0800
X-Gm-Features: AaiRm50tHRGwz7Ypnkixa4Tj1yo7hEyyeez1d0NAzC2NnlzASaC6_zXqClmfRWE
Message-ID: <CAHrRpukDg-o1Qa=CD5BrJ7Vffi05G2aOmRtRnx1TLiD6DRQOvQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for India (IN) on 6GHz
To: wens@kernel.org
Cc: druth@google.com, Ping-Ke Shih <pkshih@realtek.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org, 
	Johannes Berg <johannes@sipsolutions.net>, Gaurav Kansal <gaurav.kansal@nic.gov.in>, 
	Degrader Snehil <degradersnehil@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33067-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[google.com,realtek.com,lists.infradead.org,vger.kernel.org,sipsolutions.net,nic.gov.in,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nic.gov.in:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dot.gov.in:url]
X-Rspamd-Queue-Id: 6AB8C26DE8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Thu, Mar 12, 2026 at 2:17=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > The Government of India has officially opened this band for licence-e=
xempt
> > > use via Gazette Notification G.S.R. 47(E), dated January 20, 2026,
> > > published January 21, 2026, issued by the Ministry of Communications
> > > under the Indian Telegraph Act, 1885 and the Indian Wireless Telegrap=
hy
> > > Act, 1933.
> > >
> > > Gazette details:
> > >   Title   : Use of Low Power and Very Low Power Wireless Access Syste=
m
> > >             including Radio Local Area Network in Lower 6 GHz Band
> > >             (Exemption from Licensing Requirement) Rules, 2026
> > >   File No : 24-04/2025-UBB
> > >   Gazette : No. 47, CG-DL-E-21012026-269488
> > >   Signed  : Devendra Kumar Rai, Joint Secretary, Ministry of Communic=
ations
> > >   URL : https://www.dot.gov.in/static/uploads/2026/02/88f0ac8c74eb6f6=
907934d17d0015ab5.pdf
> > >
> > > The Gazette defines two device classes for 5925=E2=80=936425 MHz:
> > >
> > >   1. Low power indoor
> > >      - Max EIRP         : 30 dBm
> > >      - Max PSD          : 11 dBm/MHz
> > >      - Max bandwidth    : 320 MHz
> > >      - Restriction      : Indoor use only (Rule 5)
> > >
> > >   2. Very low power outdoor
> > >      - Max EIRP         : 14 dBm
> > >      - Max PSD          : 1 dBm/MHz
> > >      - Max bandwidth    : 320 MHz
> > >      - Restriction      : None
> > >
> > > Additional operational restrictions per Rule 5 of the Gazette:
> > >   - Band is prohibited on oil platforms
> > >   - Indoor use prohibited on land vehicles, boats and aircraft below =
10,000 ft
> > >   - Communication with and control of drones/UAS is prohibited
> > >   - Contention-based protocol is mandatory for all devices (Rule 4)
> > >
> > > Out-of-band emission limit: -27 dBm/MHz outside 5925=E2=80=936425 MHz=
 (Rule 6)
> > >
> > > For now, add a rule for 6 GHz LPI. As the database does not support P=
SD
> > > information, the EIRP needs to be limited so that transmissions over =
a
> > > 20 MHz channel does not exceed the PSD requirements. This limits the
> > > max EIRP to just 24 dBm.
> > >
> > > Reported-by: Gaurav Kansal <gaurav.kansal@nic.gov.in>
> > > Reported-by: Degrader Snehil <degradersnehil@gmail.com>
> > > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> >
> > Listed regulation in this patch matches official URL page (translated
> > by Google translation).
>
> The PDF actually has an English part which is nice.

Oops! Indeed! I opened the pdf and dropped it into Google translation befor=
e.
Check the values again, and the result is expected.

