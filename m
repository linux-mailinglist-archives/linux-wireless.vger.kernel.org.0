Return-Path: <linux-wireless+bounces-34515-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nIy5NM781WkHAAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34515-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:59:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B93B7CE3
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Apr 2026 08:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2274E30146A8
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2026 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886D36EAA4;
	Wed,  8 Apr 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5OaCXad"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2120236BCDA;
	Wed,  8 Apr 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775631564; cv=none; b=TahmbNunk8/ctBA/vnurB+c4Dnp2F397X9VZDr1CxEIFA9hNqZcN9+vY4HifC6No5uz9OBDnOUlhIxYRWb6e0XdKLz/5r43rfHUfWemQx+75eCntfUrxPL45gSe4jsgQs34ejjKwLmlkcfzCfZLJEKQiKL59wIluGHVRmanbW3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775631564; c=relaxed/simple;
	bh=kKyU9sr3o2SV3j0SPapHhJD4cURrV9YyzTUTD8I1+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9pWYd4vGV3P4ipuQByJvtGFceubF7QkW0bn5XhQSLQyt6Oz3oUuMteKttBDyJ0ktlU374vj/cxi4l4e3nqYKQxowsD6Rmp9XGNZgC3o7EbOBBt3HXrcYQPfyGOq5G+vDghIojX69LodiaUrWnXsdOFwZDNioe/Zb+zptXtvDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5OaCXad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547D5C19425;
	Wed,  8 Apr 2026 06:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775631563;
	bh=kKyU9sr3o2SV3j0SPapHhJD4cURrV9YyzTUTD8I1+Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X5OaCXadVAFldWzWUCHs81OSnx6ONq7YXinra3UnH6hoO4AywCVdfJV0OIUJIcjic
	 Kw1kYtd/YROrfivQXnxJHechljGv4j2CUWN4s/pkCo1b/8WfMQxfvCdriMI88MNNiE
	 suIQ5a9VJk/rIWtOzOkxSFfmMMu+FFDNdOrBdd1m7E/RKulkiTiZr+uHJuK/LGkVQg
	 DgXWqTKZ8JKyHwCGgwLjLHEebwgZvvfkndf4NygBg4UoS6rfOM9GI2hdndoYLDK98D
	 4wmv9+NWkCMQKMIvdB1R5ZGMF2u1VSwXReYU+f1kEFkajC+F6gWjQzYyNVwHUguMVN
	 OA/ZI8+5znDug==
Date: Wed, 8 Apr 2026 08:59:21 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Paul Sajna <sajattack@postmarketos.org>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>, 
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Amit Pundir <amit.pundir@linaro.org>, linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: wireless: ath10k: Add quirk to skip
 host cap QMI requests
Message-ID: <20260408-hypersonic-enthusiastic-fox-bb7df4@quoll>
References: <20260407-skip-host-cam-qmi-req-v5-0-dfa8a05c6538@ixit.cz>
 <20260407-skip-host-cam-qmi-req-v5-1-dfa8a05c6538@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-skip-host-cam-qmi-req-v5-1-dfa8a05c6538@ixit.cz>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34515-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 2C2B93B7CE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:43:54AM +0200, David Heidelberg wrote:
> From: Amit Pundir <amit.pundir@linaro.org>
> 
> Some firmware versions do not support the host-capability QMI request.
> Since this request occurs before firmware and board files are loaded,
> the quirk cannot be expressed in the firmware itself and must be described
> in the device tree.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Co-developed-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/net/wireless/qcom,ath10k.yaml         | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


