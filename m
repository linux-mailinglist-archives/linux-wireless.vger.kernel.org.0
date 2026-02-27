Return-Path: <linux-wireless+bounces-32291-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMphCvJ2oWmutQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32291-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:50:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B80461B62F9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23B9E304788C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091D3A1E90;
	Fri, 27 Feb 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItjhnZSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D353246766;
	Fri, 27 Feb 2026 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772189423; cv=none; b=J/5nFt609Blcy8Epr6tGdcc5OT4FiZU8yra6zsiGCOid0MrIlS0RT9TqjRu6fs1+cDbSkeujlNl4Lq9WEt3lX0Z832p0wIcZN/misB4xktKey9nThc3EWx4JQCxTlIpGu1Pv8qpKzW8ThUxMSoKJd5ACfLIM59Yyj5QvtG87xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772189423; c=relaxed/simple;
	bh=c4E79BJlcRZAupl74wRO0W5jFtVmmoZS3NiqMDzxH9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/C7cH5bOJyoIxuCpkz/DJY9CQhORmobdu8+6R1Tbynfmtn0eroN9lH5CuTC87RhpiMTJvSL5buV2EspljyqCjHwo2ThePatMVDfw6g5NYVX11yNTAMPYbGbzn5q+ET46kltpBcbUF11zRy/gIfVyqCmZiXybSSzvEbGsPp7UeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ItjhnZSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F2FC116C6;
	Fri, 27 Feb 2026 10:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772189423;
	bh=c4E79BJlcRZAupl74wRO0W5jFtVmmoZS3NiqMDzxH9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ItjhnZSFszvPsEbQnMvQ/3730Y9lbJjyQ3WfRMC/ZRan38Gq0LIf6jtXs2ILF0w+p
	 gK5Ni95CAV1NUcRwuAOhdmddovvr2MusgfzA92x3gF1qWYYrBIc9nSiDzBNap3qt3J
	 rWBLqDhW+62ku6/NJHIC0aLFkMWsR6ksQMcME2oqR4cWLxniUb3YosDmacRpyIgbT4
	 Fr1RAbVq/8kkTgWR1VQ/i0ZbUpmDgG5buj4gjWebAdBp83Ut1P/CAoHsAhD26YsJh5
	 cMkfUKYrBhzNQXniWW37CB1SGMTgRAbk5qAl/3cE0qmqYvKZ9oM5JyPQGZE0fjxOvs
	 G9zEYUT7psWDA==
Date: Fri, 27 Feb 2026 11:50:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, arien.judge@morsemicro.com, 
	dan.callaghan@morsemicro.com, ayman.grais@morsemicro.com, linux-wireless@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless-next 31/35] dt-bindings: vendor-prefixes: add
 Morse Micro
Message-ID: <20260227-laughing-nickel-wildcat-cd7a8b@quoll>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
 <20260227041108.66508-32-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227041108.66508-32-lachlan.hodges@morsemicro.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32291-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B80461B62F9
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 03:10:41PM +1100, Lachlan Hodges wrote:
> Add vendor prefix for Morse Micro Pty Ltd
> 
> Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


