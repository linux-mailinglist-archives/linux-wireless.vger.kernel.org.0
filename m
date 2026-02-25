Return-Path: <linux-wireless+bounces-32189-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKcDAy2An2ldcgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32189-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 00:05:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0FF19E910
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 00:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F81A3033D2B
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Feb 2026 23:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2317937472D;
	Wed, 25 Feb 2026 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlJpHvwt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276437418A
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 23:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772060713; cv=none; b=omY2LGWPDweHBBeAI6zCD3dNYpBfAjmul/8Nmw5ly9rZ79I1rIypDgwAH1OgF8LRlaQADWRQ2vfmVdnMg4wr7S8AnCtm8nbcAPraB/qx0iEokymbs0NImWPZYdD3pJWFGadR6ESx6gzhVYKff6fyl+RL2oOykeyjj9fFsKQ1/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772060713; c=relaxed/simple;
	bh=fXClZgYrWdJqhn83QVi9hg+uzNcWrfdO0GXcTLSKWC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m38xF2qNDbhTKEMpwlGigpfhI1EMHA1TvDmZaBf0p9YRzHZYsPeIu76TtuufN/8iBDjnE/2scDKtwLX9oK1eb7SwGR9FXCGG+NsjzH7Zy4VECkldXpwoi79G00VQvraZFib1MHrxIHQase/XQxdHe1TAqFRaQFcYWo7DI1cmyyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlJpHvwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D201AC2BC86
	for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 23:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772060712;
	bh=fXClZgYrWdJqhn83QVi9hg+uzNcWrfdO0GXcTLSKWC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GlJpHvwtn0hKDwhaGm/rEbb9cK8NcJLD2WxZiubZHzGKKStB4LBCdbPuKuhTUEBtP
	 XRxXkku1OvyeEdkiY1lbBOSz5JzEdSAOXpskdXFh4q6z3yU1v3CNM2dQDo8+AJsaK/
	 W2zUpPzbHX64J4cQEQKRwu9+MBeLKPJpe6LQ3q42Y2iuMIPQpbEmN3Ao/Kgc7c0Tqi
	 R/Rnl8H0PAKCuIaNPRYH4Mmg+AH4/9RLZEo2u51/1k8cJLULrPUxbezbqc12sMeUr5
	 VQsdcqe2CFdK8icRPFUy4dHcQ8ZZwrDTUOrDenwjdOvpcTBS0PRx4dR39EzxX5v/od
	 4jZuRm2iKc7uQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-389e2950f54so2241121fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Feb 2026 15:05:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQl8pXEG1WdGN6bGYEaUuakWFgW6cUF7dTU8XBrK0aQN5Yp4mR8D2v4MXoP3jbF8XNlfSIH8QWa7dn78lMuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYVzw7fauKFPg/ZrEH7O6ngM/MZTEA+LluHw50ib1VHdB8oWk
	82Hl3loHNqEmOxOwxqdeC057zOG2Ydo3prutLX+AEAGV9JNCogIKwzmU8AbA6FnEK09KurDo3ws
	qmYFvBML5OSRFX9e43o25/vDC/JIEazc=
X-Received: by 2002:a2e:b606:0:b0:389:e845:9d2b with SMTP id
 38308e7fff4ca-389f1e0c895mr1303031fa.13.1772060710957; Wed, 25 Feb 2026
 15:05:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f56ae0e705774dfa8aab3b99e5bbdc92cd93523e.1772011204.git.quan.zhou@mediatek.com>
In-Reply-To: <f56ae0e705774dfa8aab3b99e5bbdc92cd93523e.1772011204.git.quan.zhou@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 25 Feb 2026 17:05:00 -0600
X-Gmail-Original-Message-ID: <CAGp9LzrfZwRKTG4O9TxeCZsENKJZn6KxEqLhtUAPPyrTkUK77Q@mail.gmail.com>
X-Gm-Features: AaiRm53FR-8uDkOW-wjP5GYWa9L23iFbcdljos-gKmlAfnf6U4r9yInVwSNt94U
Message-ID: <CAGp9LzrfZwRKTG4O9TxeCZsENKJZn6KxEqLhtUAPPyrTkUK77Q@mail.gmail.com>
Subject: Re: [patch] wifi: mt76: mt7925: fix incorrect TLV length in CLC command
To: Quan Zhou <quan.zhou@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <Deren.Wu@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, 
	Sarick Jiang <sarick.jiang@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, 
	Shengxi Xu <shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, 
	Michael Lo <Michael.Lo@mediatek.com>, CH Yeh <ch.yeh@mediatek.com>, 
	Robin Chiu <robin.chiu@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32189-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3A0FF19E910
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 3:48=E2=80=AFAM Quan Zhou <quan.zhou@mediatek.com> =
wrote:
>
> The previous implementation of __mt7925_mcu_set_clc() set the TLV length
> field (.len) incorrectly during CLC command construction. The length was
> initialized as sizeof(req) - 4, regardless of the actual segment length.
> This could cause the WiFi firmware to misinterpret the command payload,
> resulting in command execution errors.
>
> This patch moves the TLV length assignment to after the segment is
> selected, and sets .len to sizeof(req) + seg->len - 4, matching the
> actual command content. This ensures the firmware receives the
> correct TLV length and parses the command properly.
>
> Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for =
mt7925 chips")
> Cc: stable@vger.kernel.org
> Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7925/mcu.c
> index 1379bf6a26b5..abcdd0e0b3b5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -3380,7 +3380,6 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *al=
pha2,
>                 u8 rsvd[64];
>         } __packed req =3D {
>                 .tag =3D cpu_to_le16(0x3),
> -               .len =3D cpu_to_le16(sizeof(req) - 4),
>
>                 .idx =3D idx,
>                 .env =3D env_cap,
> @@ -3409,6 +3408,7 @@ __mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *al=
pha2,
>                 memcpy(req.type, rule->type, 2);
>
>                 req.size =3D cpu_to_le16(seg->len);
> +               req.len =3D cpu_to_le16(sizeof(req) + seg->len - 4);
>                 dev->phy.clc_chan_conf =3D clc->ver =3D=3D 1 ? 0xff : rul=
e->flag;
>                 skb =3D __mt76_mcu_msg_alloc(&dev->mt76, &req,
>                                            le16_to_cpu(req.size) + sizeof=
(req),

This looks good. It can help improve stability and avoid firmware
misparsing and MCU timeouts.
Acked-by: Sean Wang <sean.wang@mediatek.com>

> --
> 2.45.2
>
>

