Return-Path: <linux-wireless+bounces-35893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFYIB2q3+WmNBAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 11:24:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FE4C9960
	for <lists+linux-wireless@lfdr.de>; Tue, 05 May 2026 11:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6AC9F3008CB6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2026 09:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B3730F534;
	Tue,  5 May 2026 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TSp273iy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA0A30CD85;
	Tue,  5 May 2026 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777972783; cv=none; b=sacYY+Qqm9OXH+pVIGu58XnOM2vjCatkkTfrqh2/VoAJMjPWFOsUbkTvs6ova8mk7AJ210vzovghHuo/jH/OuxoitOptwkyUYsw6FZSk/chuCt0sqxArtwgUOJ18hKzxIGVxlw1oL6DbItGUQ3o7KfDb/drchxHYvP2Vltqdf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777972783; c=relaxed/simple;
	bh=CPglZ9VeE7ocMLt+W0T6FvtLOr0yuBeE1tDtdf0luXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlohetxsomP2o1YPHprYaW9nnMBm55HmUJzItnPOag8apKD2UF3YUmdEWiB3tWBg89x6TUqnMLqi2/j3KzskYXLYILej6+hWyvYJyGCd7zmfoRxjR3QwS2zJKUOaMlj9KuSFF37FlLA+YW0WG1mibpSe0bC3MzhMxQEGImNA3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TSp273iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E269C2BCB4;
	Tue,  5 May 2026 09:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777972783;
	bh=CPglZ9VeE7ocMLt+W0T6FvtLOr0yuBeE1tDtdf0luXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TSp273iyNnDHL6irJQvf6PWCKoMgLTRUA7hP9f+yTr+InUAI+Gbp20QdCmT0hmydp
	 ljQnhCunhl2IZoaymvaSZBz7jO4U4LPAv2LfAlDpFx6+cAibG3ydSgTlf3UUrdYRl/
	 mQEiccspeMdQAaIZXWuOQ60KVfBlQEuF7NUWbZXgWazp0Chl/KfZp0cfvGui5AgVxE
	 U3gV4ugDTEOl2d1UEcI2FHs6hTrKtJ8/37TKPv7vyvGahsm0/YUDmpw2X8r0myywrU
	 RbXGTYRA+iAEVv5Ar7VtWWJqULO7Q4zPS+ciWMm4Ph933yUldlA0KEjgNkWUGccbCs
	 1anetaEMIY9NQ==
Date: Tue, 5 May 2026 11:19:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Avinash Bhatt <avinash.bhatt@intel.com>
Cc: devicetree@vger.kernel.org, linux-wireless@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	johannes@sipsolutions.net, miriam.rachel.korenblit@intel.com, linux-kernel@vger.kernel.org, 
	kobi.guetta@intel.com, emmanuel.grumbach@intel.com
Subject: Re: [PATCH v2 0/3] wifi: iwlwifi: add Device Tree hardware
 integration information
Message-ID: <20260505-crouching-albatross-of-beauty-a5ac6b@quoll>
References: <20260504095327.30892-1-avinash.bhatt@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504095327.30892-1-avinash.bhatt@intel.com>
X-Rspamd-Queue-Id: 268FE4C9960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35893-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Mon, May 04, 2026 at 12:53:24PM +0300, Avinash Bhatt wrote:
> Add Device Tree support for Intel Wi-Fi hardware integration information
> on platforms that do not provide UEFI variables or ACPI methods.
> 
> Patch 1/3 adds the DT binding schema for the Intel iwlwifi compatible
> node. Patches 2/3 and 3/3 add the driver infrastructure and integrate DT
> as the lowest-priority fallback after UEFI and ACPI.

Please provide link to any upstream DTS user of this binding, either
complete or work in progress.

Best regards,
Krzysztof


