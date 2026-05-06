Return-Path: <linux-wireless+bounces-35961-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAGzJISa+mnCQAMAu9opvQ
	(envelope-from <linux-wireless+bounces-35961-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:33:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 318114D54F3
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3151C303353F
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 01:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0145E2264A7;
	Wed,  6 May 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sz61/s/G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB8713AF2;
	Wed,  6 May 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031227; cv=none; b=qP5SD/Ci7f2a5y4wdfZealHLYUX5KpTi3UTttihasda68R+nggYoJ492KIup94PV68D2P+DGbXsi5iHdV8kIwppft5ba3+UysICklES+TnGJqPc80w+cZQ4m4ivo5RPAeVMz8dc2ju1qesKBXTZVyd+m8CbTmJI9pasE0Qt5ZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031227; c=relaxed/simple;
	bh=DqNkGEpajtFeSQcLSJkXmxKpW6Vr9KH4V+Ji0b1S3VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8yNjNYOT/Eq5wAntzdTWtJVAOnLtAR9ECW9ZbkWrqVHmq0KzypEooGjdJLv7Dx8c0APkKBrlXFtQG48yKF+m6e1SJKtUmKR+2eHS1/PL8k56R8TW70zmiMfEfwS4Gl/UQT34ZXQIMVuqHqt8hU0dNZEvAf/+A/AZV2OUCGgpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sz61/s/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81D9C2BCB4;
	Wed,  6 May 2026 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778031227;
	bh=DqNkGEpajtFeSQcLSJkXmxKpW6Vr9KH4V+Ji0b1S3VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sz61/s/GI0TkrpeVMFADYjLjsDfw5T5KWZ1GmKFoCNBt509CDAuVqYiaQnV/oTfqI
	 /QGsrgz9nwOkQsgjlYBTkO6fcdhwJ49HQOdbgpVX3nMSAHPXqn7ZHsB9Z1IZtAHOtV
	 Amw6WigEhhehAR0O1WJOrUJM06povIob18BjaAUx+7edqljzyC+acVIdekzAu8g/lT
	 LC0qhGRACtvUCPhkfrQAvZKpKgplKcbxjygb3kpkj9fdylaba00dx4RLHNO+F94pjA
	 zU905gf7D/BniueZMM76JtCoSqa75RJ7VIqF42VmTdd6ssCe1LLcv1BsZY1/5Vx40Y
	 EhhDjmYJdvcDA==
Date: Tue, 5 May 2026 20:33:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, linux-mmc@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Rocky Liao <quic_rjliao@quicinc.com>, daniel@makrotopia.org,
	linux-wireless@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>, ath10k@lists.infradead.org,
	linux-block@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 6/9] dt-bindings: bluetooth: qcom: Add NVMEM BD address
 cell
Message-ID: <177803122421.266355.17077010002069649916.robh@kernel.org>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-block-as-nvmem-v1-6-6ad23e75190a@oss.qualcomm.com>
X-Rspamd-Queue-Id: 318114D54F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,holtmann.org,davemloft.net,kernel.dk,quicinc.com,makrotopia.org,google.com,redhat.com,gmail.com,lists.infradead.org,sipsolutions.net];
	TAGGED_FROM(0.00)[bounces-35961-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


On Tue, 28 Apr 2026 16:23:11 +0200, Loic Poulain wrote:
> Add support for an NVMEM cell provider for "local-bd-address",
> allowing the Bluetooth stack to retrieve controller's BD address
> from non-volatile storage such as an EEPROM or an eMMC partition.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../bindings/net/bluetooth/qcom,bluetooth-common.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


