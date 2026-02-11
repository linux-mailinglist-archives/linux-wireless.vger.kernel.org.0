Return-Path: <linux-wireless+bounces-31715-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EhFME8ijGl0hwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31715-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 07:31:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAAA121A05
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 07:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A20E301DED4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A270D318140;
	Wed, 11 Feb 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVKRKV1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCEE2F6192;
	Wed, 11 Feb 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770791495; cv=none; b=ZPcFPJDjH11rK9o7hsLXFYf1FKHFYsEGf8ZLXiKLqE3jWX68G5caqKhJCb7Qhrib3VwESe88Pf7ODgC2ACy/NXwOBbNKB3t3Gsjwv4aFb7rrenL/rQqOuLewWVRTnzhZINwmLhMGaBurZCcwSitx1mEiMsZqK4VbIy4WCIKabaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770791495; c=relaxed/simple;
	bh=96Csl2k5p8So9LCLJZObu6oNFWwMbBKL5FReb3XWCp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBRSpWZ50QTZ6LV7/fMh9tgvDxC/uf1cK8gR7R6aO+4v99Ol2FHeAhsG15DTQNGtVrwctuGXp41XgUrBD+PSPNM4sdZj9k40alaBnoeycoVeaw5crQ2eNXWf3w+qpUppPOLWM9vUx9vlYoAG5eSJF4q58IVR3naIf6TArexTUpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVKRKV1+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A645AC19424;
	Wed, 11 Feb 2026 06:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770791495;
	bh=96Csl2k5p8So9LCLJZObu6oNFWwMbBKL5FReb3XWCp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVKRKV1+1+5bQym0epwv9J9y098sYD/INBDZTtCvNCKAMhS9tGtDqDfQNEJxY9Fjy
	 EknYhrawCeJsTm0O80cSHkacowA7W0l9rT5EPX890W/I1DlY4/zXMEriGDFTRtL575
	 8xgCs37Nbe4vXM2+ZjL21AV7wc0/GAsNFXyLY88dahO9s8cwiqGbEfMJzcGuOAFV+X
	 IwcQJY4zCi4tYUGSTXWhHOnT22yGmRFJdIZqL6s5SBRe9mmCPI/rmpgIU97iTH4jWW
	 mW2nM/Kk72x8n/vesACEfDrjneDlaVsWvOoOf7Uu/GJMy5tBvxOKe3aQwBMzHTJSEU
	 0ts+QqITnd5vg==
Date: Wed, 11 Feb 2026 07:31:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: Felix Fietkau <nbd@nbd.name>, Rob Herring <robh@kernel.org>, 
	devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-wireless@vger.kernel.org, Allen Ye <allen.ye@mediatek.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: net: wireless: mt76: clarify backoff
 limit format
Message-ID: <20260211-miniature-chital-of-plenty-1a71df@quoll>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770746444.git.ryder.lee@mediatek.com>
 <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69521aebefef405bad5117d4d5d5fef4a5dfb7e8.1770746444.git.ryder.lee@mediatek.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31715-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4CAAA121A05
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:08:56AM -0800, Ryder Lee wrote:
> Clarify the format of path backoff limit properties in mt76 binding.
> Add explicit documentation for connac2 (mt7915, mt7981, mt7986) and
> connac3 (mt7990, mt7992, mt7996...) devices, including the difference
> in beamforming and non-beamforming entries.

I do not see any reformatting happening.

> 
> Also reformat the description to make is more precise.
> 
> Signed-off-by: Allen Ye <allen.ye@mediatek.com>
> Co-developed-by: Allen Ye <allen.ye@mediatek.com>

Incorrect SoB chain. Read submitting patches.

> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> index ae6b97cdc..4156e1c97 100644
> --- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
> @@ -252,6 +252,16 @@ properties:
>                        followed by 10 power limit values. The order of the
>                        channel resource unit settings is RU26, RU52, RU106,
>                        RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
> +                      - For connac2

There is no such term as connac2 in this binding at all.

What is the point of adding new terms?

> +                        - Beamforming entries for BW20~BW160 and OFDM do not
> +                          include 1T1ss.
> +                        - When 1T1ss is not used, it should be filled with 0.
> +                      - For connac3
> +                        - Beamforming entries for BW20~BW160 and RU include
> +                          1T1ss, but OFDM does not include 1T1ss.
> +                        - 1T1ss is taken into account, so no need to fill with 0.
> +                      Non-beamforming and RU entries for both connac2 and
> +                      connac3 include 1T1ss.

Why this cannot be a schema?

Best regards,
Krzysztof


