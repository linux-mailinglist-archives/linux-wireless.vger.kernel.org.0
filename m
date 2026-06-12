Return-Path: <linux-wireless+bounces-37698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h313O2O1K2qaCQQAu9opvQ
	(envelope-from <linux-wireless+bounces-37698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0ED6773AD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:29:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none ("invalid DKIM record") header.d=aerlync.com header.s=google header.b="SDB/9BVI";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37698-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37698-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=aerlync.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00F9430E6211
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7103B3D6488;
	Fri, 12 Jun 2026 07:29:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41AA391512
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:29:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249377; cv=pass; b=PCUGLVxEP4wFV2cVZle+O6jPejiK/7kCaYdxIXjXrklHeuFodOAN8tEe/OP/MjV5gMvyb7ONxEIanVw1x+XfRU9Ho9RltzqxU15L5qRqcbCwQ0aWzG8oJJoNDku2xHOcdqr84Pq8e/7KocmO/S2PicYDSlcRxxBdIdkDzf6pYQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249377; c=relaxed/simple;
	bh=tVg2r7SH40s0Z53c3qQyY3QGfxdt6vvxr86cv2zFvew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah+Z6QYL4zzZl8jeAABCkyJWLQUW9OhSdvRwe6qhiw5R/ZGov0Qhr2OhrFGwdphLB4WeVzLUif1eQxNWqi0FUg3l/0HyWggaQVL7bU6OB2iLTAoelcwCiJ/1rLgGz9flGHfD0y4Uzs8G0DL17GPPQDB5GFgaR+RlIeJYQqOWj1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aerlync.com; spf=pass smtp.mailfrom=aerlync.com; dkim=fail (0-bit key) header.d=aerlync.com header.i=@aerlync.com header.b=SDB/9BVI reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.208.171
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3965d76090bso6268471fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 00:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781249374; cv=none;
        d=google.com; s=arc-20240605;
        b=Z98iLX+aSHF6dYjO3i9WYzR/HG+sel3toY3FMOY0JB2MHdjTiSn2ljBBDSNZXOVNqz
         fSrwfdSNlqJCjx+Z5qJtKyJt9m4EfC7PEJB1IKHFX8PxE6FRG0V2+UnzQkHrekZOreBF
         xunzgg0J7ZmFlacS5iZMqmYR9Dezjfnj9imsSg5w0bpeJmlM5PU3FN8JOuqLcZT8sx/C
         2dEdfHeqDmoQALWWpCzfVy0WisZxkoJO2JO38EP5xgZSns6Ts6NpHcK8u/glLyn57yPq
         9815Vl8RQeV+qBCh0hZtSsG6C+olPFHG1AhQMG6wiqZCUI8seyrZpHKak6/T07yeMjk6
         7GDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6ZI6tLmZUTFZyjC3DvxkYL28Mk3M9noRZhE0JUJwEc=;
        fh=NXLQsPJj6pN9gik7YYOd3mwl531tCVr8SgZnNQ65P0Q=;
        b=iJwYmxPZ8WKJOnCCSJBxv/8MDf1sIM/J7CkMVf5M/rdzy7iIYtxGEokpot2G3UAIIT
         6cuEZdq1zlVfH+8THbO9EwiiDIdfGiAotFx5y9bH6hzktPVuHVtxogyvOFPUfcRWvPKQ
         +SjJYNjWpy8wuP5OuwOAtg52WkqNcTPEN+urQpDqj6KYN3xx02w+ws1Mtwv32cBUZpOn
         oSgZ0GrMaKTNluloH1hT6JCTmRTwIwsgGIwYKV0ZedLdAK4ZOczwXLGlN4chjMHlvMq5
         SITmS8GCYl/XxtC3P0HunWi0IohdSQhYknUGECA+4GxmZcbaRcp+P9zZHKQ8B5DeFPpN
         lHHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aerlync.com; s=google; t=1781249374; x=1781854174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z6ZI6tLmZUTFZyjC3DvxkYL28Mk3M9noRZhE0JUJwEc=;
        b=SDB/9BVIHwx+DUPmdxfNYZn6udJBzI1oEFCaxU2WzJoLSMFwmGTaROcLCxGthN6f3K
         2WB3wYiUu3NYPRM4zBXKwRiXoDJ2TbImKHMqxqRWpwt2lGkU19PgPqSFrDJi/K1xL0Dj
         OwE0vve5bPnXI0BVRrhktnE/9s9mLycnL8AJmhjzd4S6vcMCT45Pk1jITr6EiJs4m+o7
         0QaGb2yF34NkXU4d4N1GM9rauzas1IlYbbGhPTT8g3FDfLMyMOVF7evfT6Wx+aKSX1Z0
         MQkf2H7AZoVTRHzPtjvFqsOUeiLtEnk+KUxiJQQo7U8q6W9fc5/E79YqZOn1zi1gZ6bv
         pKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249374; x=1781854174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z6ZI6tLmZUTFZyjC3DvxkYL28Mk3M9noRZhE0JUJwEc=;
        b=Wq1Dktzx7jPrVvR0FCR659PKVG8BVJQPymI5Ck0pF9JbMJ9FQ2CJYmfUbHYuczkobq
         8do8l0pO2kykTElat9rd5/N+blcOTuK5EZ5xEvV7cxTYqNxobc1X1L8OvUO2C83a/QLp
         39try0DtANpIlAT3ZDzLryIfAAmfWxyDbe2fN+wazyMcUHBZXK34/OF2Hud68vIaLnku
         6GJ2uANoq2azmuNFkr4GsFFm3IBuKstNMkp6tlQ7FjlTcgvBVemEApE6zzIStK9XuiKn
         GLz6rT5CJ9xURcA0AIR6mKuRr4kIlaHba3K9S3IQStPCmojO7lR6x2TuKH8y8baKxbDP
         swug==
X-Forwarded-Encrypted: i=1; AFNElJ+Ue0jmkV+8qK3o3yh3HEVERkhjc7Q4n1558FQTe7jKqtuoI4iqp6AFfRK7c+5DtZEbRJWR4tvdpcynvNtL+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0PnHlj62isZLvdDTInPSOgmvqOEk3i5hRozRH9PBGkn0zfEDh
	oGLsafWSuJljQFIlBr1RsHD9vWdOEwLvaeYtxQ1eQvO3AAAb6Cm7toAnqF1K8V681MRyruqIZ9+
	RCO4CInaUAbwyQ/YKg+3UxDTuiBCm2hqwqqDp6eM35m+tg1ZX7hkB
X-Gm-Gg: Acq92OGkBGd0sgEj9MWhHtKe6mmq+ahKQhf5JWaWQThese58VVakqdp9HTQxeLCk9+7
	1Ou2EpwAE/LMPZy74HlDIGLy6mtgvyaa9ILEYMHOuOQcSRdmrvCN3zOgG6hfmJpA63Z6vhA0oU7
	2xRQGWXcImWmOM9p24+LVVtKxqnwASDz7BgHgTn+cFn2BffDLVDsqu3SZJBnGREN99irdB9DjII
	fFXRmoi8T/w3m62ubcUi5YndHpo/SzkrHFdr+ZYKy8gJ5exoO5Wkw2FQ+k0S2nHTUZ14dcRnEml
	8u0eUds=
X-Received: by 2002:a05:651c:24c7:b0:396:75ac:457a with SMTP id
 38308e7fff4ca-3992afba022mr2593921fa.8.1781249374144; Fri, 12 Jun 2026
 00:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605054307.427874-1-thiyagarajan@aerlync.com>
In-Reply-To: <20260605054307.427874-1-thiyagarajan@aerlync.com>
From: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
Date: Fri, 12 Jun 2026 12:59:17 +0530
X-Gm-Features: AVVi8CdTzevzyoeXKAxtGy5Prp3DA55ak9AsJownX2IlzA2E4kcPVgB3F2rjH6E
Message-ID: <CAL3EHw6QcuFAw5FwbF2O593jESqsWZpaxyynSFctKUWV15R1hg@mail.gmail.com>
Subject: Re: [PATCH] wifi: nl80211: Increase ie_len size to prevent truncated
 IEs in new peer notifications
To: johannes@sipsolutions.net
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[aerlync.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:thiyagarajan@aerlync.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	R_DKIM_PERMFAIL(0.00)[aerlync.com:s=google];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-37698-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thiyagarajan@aerlync.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[aerlync.com:~];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B0ED6773AD

Hi Johannes,
Could you please review this patch and provide feedback?

Thanks,
Thiyagarajan


Thiyagarajan


On Fri, Jun 5, 2026 at 11:13=E2=80=AFAM Thiyagarajan Pandiyan
<thiyagarajan@aerlync.com> wrote:
>
> Currently, ie_len in cfg80211_notify_new_peer_candidate is defined as
> 1-byte field, capping the maximum IE list size at 255 bytes. When a
> large beacon is received, the IE list is truncated, passing incomplete
> data to wpa_supplicant. This causes supplicant to fail parsing the IEs.
>
> Increasing the size of ie_len to allow the full length of the IE list to
> be forwarded properly.
>
> Signed-off-by: Thiyagarajan Pandiyan <thiyagarajan@aerlync.com>
> ---
>  include/net/cfg80211.h | 2 +-
>  net/wireless/nl80211.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index 9d3639ff9c28..36af36533cac 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -8445,7 +8445,7 @@ void cfg80211_ibss_joined(struct net_device *dev, c=
onst u8 *bssid,
>   * cfg80211 then sends a notification to userspace.
>   */
>  void cfg80211_notify_new_peer_candidate(struct net_device *dev,
> -               const u8 *macaddr, const u8 *ie, u8 ie_len,
> +               const u8 *macaddr, const u8 *ie, size_t ie_len,
>                 int sig_dbm, gfp_t gfp);
>
>  /**
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 7db9cd433801..0d97a47c35fb 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -20958,7 +20958,7 @@ void nl80211_send_ibss_bssid(struct cfg80211_regi=
stered_device *rdev,
>  }
>
>  void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8=
 *addr,
> -                                       const u8 *ie, u8 ie_len,
> +                                       const u8 *ie, size_t ie_len,
>                                         int sig_dbm, gfp_t gfp)
>  {
>         struct wireless_dev *wdev =3D dev->ieee80211_ptr;
> --
> 2.43.0
>

