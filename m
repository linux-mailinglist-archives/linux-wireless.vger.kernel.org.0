Return-Path: <linux-wireless+bounces-34207-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEi6Ebx2y2k3HwYAu9opvQ
	(envelope-from <linux-wireless+bounces-34207-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 09:24:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2793651A5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 09:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 484E83019814
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2026 07:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D33B585D;
	Tue, 31 Mar 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3bV0QBl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C9F36CDEB;
	Tue, 31 Mar 2026 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941881; cv=none; b=ewVKgwipHTCy3jPcX9wIuiIMFIhebqk0O/xNi5bO/qLnlNxEfU9URF6EUoNP6zXj0n9EOc70B6UyXoXFBC1wIu+X/YHFzYHMU9xtCWEHFFJnjAEfDKaD3tSXDcDRWm/m2o2L8yNFLGpTN9M/+oBj4HNNk8xyh/ADfxJH92ox7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941881; c=relaxed/simple;
	bh=ExLT5dd64mgQYApH0Oz1/dJvTFDHMpbk/nH0w412QLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfIUqqFY2A9BHBk58vXRLSlHgngXqLNUZGMwUBPgtbyRstGo4XAsg5UkUfLqOf0HRozcdVYKAcXXzCH33ERAy7L2G8zsJQ5mZmnRAOBTODJVEsBAW6zIxCSPNSu0/+yZ9s0D8fQKmKg6HsSUlYxcls+TbQ0a2g7w5E/bkYij4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3bV0QBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF41DC19423;
	Tue, 31 Mar 2026 07:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774941881;
	bh=ExLT5dd64mgQYApH0Oz1/dJvTFDHMpbk/nH0w412QLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3bV0QBlSKpp5DLQjV+ZY7JZNiG1UREwa2T7xE+RjyX3t+uCEhAPcAHiCtyCQDOJK
	 1q8qTZwVIKv8mJ02F50d7lt+rPzuOLBf7wZYOpkuL0e9Z7VD9m1EkC3VaTtEP88DeW
	 QsD9+HpTj6b+50IHDidofiXgmI2zoqEVCVuSaWDZKcw2vJlP4KSe6VUxQTlK+fTaDY
	 MAbNbkyDsK8OwKPMzosH+GLaSh+Vf7HUGkvqblNl+dHUkD52IjVp+IBu2oaQTjdjJZ
	 yEjvzBcYiKnXv5hpZ5dZm/mhz1MUrU2JvxaFjjjxOJrmlL9pGd/LKnKjPdkZDw+UjZ
	 7BaAdfvSBczqA==
Date: Tue, 31 Mar 2026 09:24:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath12k@lists.infradead.org
Subject: Re: [PATCH ath-next v3 1/6] dt-bindings: net: wireless: add ath12k
 wifi device IPQ5424
Message-ID: <20260331-fanatic-elegant-wallaby-913e35@quoll>
References: <20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com>
 <20260331-ath12k-ipq5424-v3-1-1455b9cae29c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331-ath12k-ipq5424-v3-1-1455b9cae29c@oss.qualcomm.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34207-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Queue-Id: DF2793651A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 02:09:06AM +0530, Raj Kumar Bhagat wrote:
>  $id: http://devicetree.org/schemas/net/wireless/qcom,ipq5332-wifi.yaml#
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,ipq5332-wifi
> +      - qcom,ipq5424-wifi

No, use previous patch.

I am annoyed that you keep making changes even for such trivialities and
require re-review from the community.  Previous patch was correct. This
one doing whatever you want to do in copyrights is too much. You don't
change copyrights just because you wrote one device model.

Best regards,
Krzysztof


