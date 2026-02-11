Return-Path: <linux-wireless+bounces-31747-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNpeKIHyjGmqvwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31747-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 22:20:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0463A127B53
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 22:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11AA630C220F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 21:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974B34EEF1;
	Wed, 11 Feb 2026 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJdIJGOT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2C35CBCD;
	Wed, 11 Feb 2026 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770844266; cv=none; b=IOynZ5OSLDTuWXiJ31zfG8OewCCJXLDUCYXICJwSFHHF2ENulSA2XK9h9aedKwTBPC+p+78BBrqr/V3ZYWt8qaPNXMiFT/8kFy0pnWnHiauwSzrMUKOvbkQs8LY9czkOJJgkpSMR7mDhqF+btRzX2chpipBqhzo4o+OVYFuB804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770844266; c=relaxed/simple;
	bh=8BS0HjUZ2c2XIa09Dyj75cOKCDZd5+HLlSJGloTMoCY=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=L70iSH8YHA0Jpg7IS8c1VTpJ9f1v1yRXCUh1Rv5aeA/thvkvrx2U8i7+sP1jUCLORhDGFFF/osqki0B5ZIXm7jRRnJYnW/vh/FnJUUFs3Ha/RY34gzXvCzZNPsMi4QY+ixgMMQap1q6FieXQKDpk61fqOWQNN6/035MLcnGMyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJdIJGOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634A3C4CEF7;
	Wed, 11 Feb 2026 21:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770844265;
	bh=8BS0HjUZ2c2XIa09Dyj75cOKCDZd5+HLlSJGloTMoCY=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=sJdIJGOTEcR/pVqdOis0U72NT3kdqQiTVivMV3Hp6+Tnh4gEBuJ9M7ecacD8kDUlC
	 E4QnwLkF51qxA7SmFEAznZ6BzdzjSZ0Q/crsmMSPffPLjN452hh3zS54otYqgbOpeQ
	 emHeajY+TaK6mydY0JQ/Uq4DbYrQ8zG0iwXY7TTHUQR7yJ9vOxMZMq9nvxyxhrluhO
	 FnAJzM+J6LqNleggYWSC+Y+UNJhUuLdh5vwh0f2muWC95RiLaiEv9l3J2x5eWLb6LU
	 unUz5DQtVL3SlJjkZtO0vnZaKhihHmazKyc6oYTylesJGcq5511qbCN4fMrTinond4
	 /XrYo3gHB16bA==
Date: Wed, 11 Feb 2026 15:11:04 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Allen Ye <allen.ye@mediatek.com>, Felix Fietkau <nbd@nbd.name>, 
 devicetree@vger.kernel.org
To: Ryder Lee <ryder.lee@mediatek.com>
In-Reply-To: <4111ba0734fc7818f899db0bea08e3428eb536d5.1770836705.git.ryder.lee@mediatek.com>
References: <8fa8ec500b3d4de7b1966c6887f1dfbe5c46a54c.1770836705.git.ryder.lee@mediatek.com>
 <4111ba0734fc7818f899db0bea08e3428eb536d5.1770836705.git.ryder.lee@mediatek.com>
Message-Id: <177084426457.3906539.9556948985092789939.robh@kernel.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: net: wireless: mt76: clarify
 backoff limit usage
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31747-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0463A127B53
X-Rspamd-Action: no action


On Wed, 11 Feb 2026 11:14:30 -0800, Ryder Lee wrote:
> Clarify the usage of path backoff limit properties in mt76 binding.
> Add explicit documentation for old generation (mt7915, mt7916, mt7981,
> mt7986) and new generation (mt7990, mt7992, mt7996) devices, including
> the difference in beamforming and non-beamforming entries.
> 
> Rephrase the paths-ru/paths-ru-bf description to reflect the actual
> usage.
> 
> Co-developed-by: Allen Ye <allen.ye@mediatek.com>
> Signed-off-by: Allen Ye <allen.ye@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
> v1-v3: none
> 
> v4:
> - revise commit message
> - use PCI id as the compatible string to replace "connac2/3"
> ---
>  .../bindings/net/wireless/mediatek,mt76.yaml  | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:30:23: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:31:23: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:32:23: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:33:23: [error] missing starting space in comment (comments)
./Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:34:23: [error] missing starting space in comment (comments)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/4111ba0734fc7818f899db0bea08e3428eb536d5.1770836705.git.ryder.lee@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


