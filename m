Return-Path: <linux-wireless+bounces-35339-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLqENcwP72kq4wAAu9opvQ
	(envelope-from <linux-wireless+bounces-35339-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:27:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B60C46E56A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 032F83004590
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A751391E7C;
	Mon, 27 Apr 2026 07:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpS3UF/O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2A43914E8
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274826; cv=pass; b=mEMQH6eSEBSyIEy5mOLMydcMx3EkqFqq5KoqFvuIW2tWBt7fVSY7JBHAZRsmPK9lw7S1d9nKWGEeswp/yVeGxxiqovS+upzsYS7qaQLvRoVwaCSbUQZEkB5/e3epu5H3YWsrMiDYsW0xpuXLR/v12SJZqvYCRAve6QpRixNF7jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274826; c=relaxed/simple;
	bh=wWnvxXUL3hfoN7ZWDBViCdW/iRUK+CGFaWMBri4GAOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fm6bBx/dbGwupbZRC5tuSnRPRrlBwmkgcuMCONVigvMPnOyQYKAgF3AepbzXwExwLuMLhLwW2DgYYayjfXQKa2Os9MGXUiiGLfEIgdxhMRD3Pl4DpF8ljW48XpKVl+Toea0KIMCzzYtoAfdYxy80n4TwzY2WTQvbXLNv5i2uR+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpS3UF/O; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-656d749109cso1155631d50.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 00:27:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777274823; cv=none;
        d=google.com; s=arc-20240605;
        b=NmKwC20nblB4SgLaTHpeNn6sF/2HnerQYIgU85e4T+R3rlIWtUWHQua7LBce10mZh6
         sO296nZ4S2eBcLkgf7om6kXiMI0Zzu4KOeNdtXEzH/VtbZJ/MkEspv7VBGeJhbEZZmsI
         XspXwFi1jDxywbe/2y7D70Cc5HReLza4JBZnMm94Yd9IuhI4MO3LleeJCy1l554gKgXJ
         P9zyhNiUMf7mLmQNlC/n9NZuDpSF65djwJyez3K2sEQoPaxLy9FoeFLvDOazP7Xmq6ga
         CnmbUaRag8Bz1X0X7wSu2KckgA755ixIaS+HgfcKL5KGHZ9ZgxlGxvRiZvL1ZrN6AQR4
         oofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        fh=8XCDbLbI/Q0EhAjkzhTAy3r+qAmDqUj+/bouyuqMCWc=;
        b=Sg2f1/GpYn+HqU6x/IkITPlPakguo15308D6CJXO9R351awd2AJsPplErLUBv0iF9L
         RbX4TlP6is96ttDY+WcOH5aTO7l+9R34NBIfXLTLX3n4k3ItEGywkZR1RvKoMYXQpzBT
         8oNzDIctPXiRNSELg4uDzIgHyJn18/97Sl+AsIqgJy7GEjfQw+6mrF6pnujpZmEBGs+Q
         py/KANsBMEUZPt/bkfetGjfcIZYlHDbU368y46a+CIosiP2isABaNsh3fuB/8zs9G8jf
         993FKgaevuzSLEv1QDg8ch++y5C17hS1dnzQfLo7po5AZL2hsLWdNAKZf7wCHhrz3Wp9
         m+dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777274823; x=1777879623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        b=mpS3UF/OUdOAAb8FECauqUgzH9WGqJ+0ouXzyn3L5yT30wG6O5f237e6IglGAV/bmx
         Of2U28lLBFVT+UlsDFt3zy1fGfFElgNCiomyhcKxNlyjymaJZO3yq/pQWcKd0Coyblal
         vaL/Thz6ihHKTIDxZlTVzkTU/6JL0kFx9xJ8tSbPaUJFXuWPNZ6WVWXm/0Q7yxOjeAG/
         ZWjqsJXcuQ+4lZ3eL3OMW+69tc7AtEuWjadWP8/wt1PkUwCEwQcWvIw/YDZcGQ1A1Ua4
         NLwwol83/3oSBzbpsDjr0OZ5Z6J0vIpb7rmSrz5VrJsjs3iwSCr9lE3DH4tcFfDyCgLq
         3H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777274823; x=1777879623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7kUhTkdHvc3oY/y/iSAnX1xxIUfgWoxWMmlhyEq3JBw=;
        b=HiuZOHzv7yg9iPLnoP0DpzkTV09aNXOgDbyyyG2rggO0xwuu2k3UlehLbQuKZHlwEW
         0o6hf8pYNfcLTJMbJVkkaRQZ12aRDIFV3N5Usd6evDwPYfpW0L+1bSXDjvkr7UgqvT/5
         fFC6t3bw+RPgCwDx6kfa5O6IoXohJ/cp9WFEEuJ1QCQ7TvPrd2lGCpfDA4UuvanPrWdc
         MW/QBJhip1e4yM0bXwA5VCkQeMLzQHxD9zrl/nYVLV1W7s1PhiMhcauamRGodivPxPmy
         je7FnIrN6BYJs82j9A7/euq9eeNflrnUaXDlHsKbIpSN4Mw9TjbFhWBQlIwuFJpP2Z59
         kwjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+QUZ/Z6+iyMmynCJGGeh3eKryewlh443kF6V0uQIkL7PS7T7rYhDy8yAoQSxURQRfj6NELM3hN06qYLwNAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCFOTZ0GNyWMhuVeYYN1JEiPqHlvo9GCSd0LKVqTMSYRG93Huu
	leQYn78hEGraTMEuxXw44JwzfIg9O5f9JYr6eNAZnQha9lZ2XkCkQsohlHfpj+fWSczdmyeE20E
	ra4ig4ioAiRxT81B5Oo1Zh/h4J/fYGBk=
X-Gm-Gg: AeBDievq9hBq4T9mgXvJIEdgbuoRCnaZYw+237M5m6GtON5+T7gAdcZwjx8KFa09XH3
	D6crDtmJfb1Z5lrMEZuT0OT0MwOJw5oLO+t5sw/cObPHShDI0YC8r6OzGPFBvsXXyP5jOIWZchP
	OCRvsfG/gImqrNP/JIqd8vW3lwXINkIFOEvvzovOmbZL6lczQtD/s5LfrBk9QbgsinXuttz8w/t
	f3AOEpPKZu6uRuH30HzRFpFTx9W+hvZUk5/vHydogPPNFspYT+e/RkPQyZ8zGe6jXsbpHXGFjSW
	tUxuMFzCsMPM8GEy3yw=
X-Received: by 2002:a05:690e:13ca:b0:64a:d479:bfbe with SMTP id
 956f58d0204a3-653107e1fffmr37750335d50.11.1777274823339; Mon, 27 Apr 2026
 00:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310024305.555408-1-james010kim@gmail.com>
In-Reply-To: <20260310024305.555408-1-james010kim@gmail.com>
From: James Kim <james010kim@gmail.com>
Date: Mon, 27 Apr 2026 16:26:51 +0900
X-Gm-Features: AVHnY4LqeV0YZVawJX8Lx_yiM8UhsDDdpU6nTKCbtsDJT8mHu5loXzktWCz1VJE
Message-ID: <CAPdMtfesMMAjZ5gRoOomPepmn=V86NoiFYVuiRaEXhxwzNSx_w@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath12k: fix use-after-free of arvif in assign_vif_chanctx()
To: jjohnson@kernel.org
Cc: quic_srirrama@quicinc.com, quic_ramess@quicinc.com, kvalo@kernel.org, 
	stable@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6B60C46E56A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35339-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[james010kim@gmail.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi,

Just a gentle ping on this patch =E2=80=9Cwifi: ath12k: fix use-after-free =
of
arvif in assign_vif_chanctx()=E2=80=9D (submitted on March 10, 2026).
It is a small, self-contained bug fix with a Fixes: tag, and the patch
still shows up as =E2=80=9CNew=E2=80=9D in linux-wireless patchwork.
Please let me know if any changes are needed or if there is a better
way to route this fix.

Thanks,
James

On Tue, Mar 10, 2026 at 11:45=E2=80=AFAM James Kim <james010kim@gmail.com> =
wrote:
>
> In ath12k_mac_op_assign_vif_chanctx(), arvif is obtained from
> ath12k_mac_assign_link_vif() and then passed to
> ath12k_mac_assign_vif_to_vdev(). Inside that function, when the
> target radio (ar) differs from arvif->ar (multi-radio configuration),
> the old arvif is freed via ath12k_mac_unassign_link_vif() -> kfree()
> and a new one is allocated internally. However, only the ar pointer
> is returned to the caller =E2=80=94 the caller's arvif still points to th=
e
> freed memory.
>
> The caller then continues to dereference this stale arvif pointer
> at multiple locations (arvif->vdev_id, arvif->punct_bitmap,
> arvif->is_started, etc.), resulting in a use-after-free.
>
> Fix this by re-fetching arvif from ahvif->link[link_id] after
> ath12k_mac_assign_vif_to_vdev() returns, since the link pointer
> is always updated when a new arvif is assigned.
>
> Fixes: 477cabfdb776 ("wifi: ath12k: modify link arvif creation and remova=
l for MLO")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Kim <james010kim@gmail.com>
> ---
>  drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless=
/ath/ath12k/mac.c
> index b253d1e3f405..ee44a8b59e9b 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -12069,6 +12069,17 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee8021=
1_hw *hw,
>                 return -EINVAL;
>         }
>
> +       /* ath12k_mac_assign_vif_to_vdev() may free and reassign arvif
> +        * internally when switching radios (ar !=3D arvif->ar). Refresh
> +        * arvif from ahvif->link[].
> +        */
> +       arvif =3D wiphy_dereference(hw->wiphy, ahvif->link[link_id]);
> +       if (!arvif) {
> +               ath12k_hw_warn(ah, "failed to get arvif for link %u after=
 vdev assignment",
> +                              link_id);
> +               return -ENOENT;
> +       }
> +
>         ab =3D ar->ab;
>
>         ath12k_dbg(ab, ATH12K_DBG_MAC,
> --
> 2.43.0
>

