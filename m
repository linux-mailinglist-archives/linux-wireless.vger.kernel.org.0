Return-Path: <linux-wireless+bounces-33887-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGWFJBFdxGn1ygQAu9opvQ
	(envelope-from <linux-wireless+bounces-33887-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:09:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E1132CC70
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 23:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BB2B3029624
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9D37C10F;
	Wed, 25 Mar 2026 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuFJlqT+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D162C377EC5;
	Wed, 25 Mar 2026 22:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476533; cv=none; b=YBV6USzHeRRLnzC8QeTjc2T6djsJunr2tR9EutBnfI0jB9d0gxTwL0zByT0FF9keHrDVadgaRz29xKJ8qC62FAUubJrTJsQOgNCz1D29EeVTgubRd/TFgHsP6nbU5Nc5zbsmnuIeiYcwJXiGMeG+hGIlgPE5Ree9xD8V9OFmddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476533; c=relaxed/simple;
	bh=0SMSGojWeEuTf6IRTzrQ3Ja6RfzXsvEFtgDkgRMiJQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlUQem+G6mc5N3GFvfRWI2ofh0pku6+MfvDMh1DcC+nMmgklx9nai/k0s+p7PscmBGlZ1g7ZUR7SjvMTJS7QLcIx9G2t1hSMSTr42MFecONtCEomy7qR70y3AZq4n64kXBsNguk0nb4Jh3jYahjHGYxKMddiQCnO+TCyBOhH1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuFJlqT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77100C4CEF7;
	Wed, 25 Mar 2026 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774476533;
	bh=0SMSGojWeEuTf6IRTzrQ3Ja6RfzXsvEFtgDkgRMiJQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UuFJlqT+amWQ9X9bdFAzekPp6vT+mLRWg+bh7t8mm5kUwFOyK+XoJanIpT16W8hc/
	 eINb0ExdNWpmeWKVYgWEFLcdqJ9PTSM6IAM04cf26CAblCfJJb6SMW/x/7lMtwOpxr
	 hirz9grYILPtqgoi7QIU35kWfS2QOpYkoCCwSnJfhQRZbPuR6C+ZD8glMMFWUlHuFM
	 66cEa/nH3RxQG1PwgXNS3UL/6m+RnNpqaDpTQ8N8bS0pU3/CLZ/CokfqWf9Oomrba4
	 rbEh1uENRqFLyISAdL7O+6rQRGyrhg6kxFJ4bEGzmQ5JUYbGUtKdNdWA+z3ObT8tH2
	 yLECRj2cMozoQ==
Date: Wed, 25 Mar 2026 17:08:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	van Spriel <arend@broadcom.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 2/9] dt-bindings: mmc: amlogic: Add compatible for T7
 mmc
Message-ID: <177447653149.51426.16186779467459325045.robh@kernel.org>
References: <20260325-add-emmc-t7-vim4-v4-0-44c7b4a5e459@aliel.fr>
 <20260325-add-emmc-t7-vim4-v4-2-44c7b4a5e459@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-add-emmc-t7-vim4-v4-2-44c7b4a5e459@aliel.fr>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,baylibre.com,lists.infradead.org,linaro.org,kernel.org,googlemail.com,sipsolutions.net,broadcom.com];
	TAGGED_FROM(0.00)[bounces-33887-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,aliel.fr:email]
X-Rspamd-Queue-Id: 47E1132CC70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 25 Mar 2026 10:15:20 +0100, Ronald Claveau wrote:
> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
> as the T7 MMC controller is compatible with the AXG implementation.
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


