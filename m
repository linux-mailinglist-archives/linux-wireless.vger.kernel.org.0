Return-Path: <linux-wireless+bounces-20523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1103A67F61
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 23:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6938642624F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434252066EE;
	Tue, 18 Mar 2025 22:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I07yvUd2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11411DDC5;
	Tue, 18 Mar 2025 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335771; cv=none; b=chCzoA7huMSSToUxrkPClTapbKfq0h5uhAfju1j6x89JBUMY/bAhwCMO7O9iOmvka5RMpYaafg612CGgXWScJvnzv4zULNnna3TBzgbN3XbpUDuRtKYKjlGQ8WGM7CzpPN5qG0ifePr4K0cw48wR9SjRLYnufvP+NGOBhuN8jzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335771; c=relaxed/simple;
	bh=JyL/2Kgl5suOXaFaYUSHpJ25zyrjpG1kkIB8FNA4jIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FktxYjyXGTBe5Zn5VK3VHuprJFemu8NUAyf6JoiKXJz+xP7UJDPkfRAHyKPX44gbKnAR8vuOA4w08nrrXRTcHTzeKIlPAr0Q/fSrJEBxirf6y9Nxd0lFO2IVwppgbRv3mh7vChqDfHhXdKD1uBT7QV+EGcB9fv1MvJjoTC+EShw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I07yvUd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DA0C4CEDD;
	Tue, 18 Mar 2025 22:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335770;
	bh=JyL/2Kgl5suOXaFaYUSHpJ25zyrjpG1kkIB8FNA4jIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I07yvUd2FH9fElQJtSy1rAoDt3wPLct8nbSPFHesgkYsoweS8TFRA9iz3HYYBOzPI
	 xFBAmH044+kjD1h0JFW+/tK9U729D6cCWL6g0gsWB2325L623brlUjPs+bCtm8wo+/
	 E1T+leslxCgDEhzM/4lxW9/QBvWpGuCXTRTTHEROT2bMwt57OLs+d8dEamMqnNdncf
	 Ae2c0rzxSe3unzFojRBBmihbMEWwbHLsxIHWM1WPU7avl7KraaA5Ico4fxMLybMydg
	 FJJ0OJposJZFID+Ock5xYeCDBWQg79QHEtgFOwkX0eqtLLvLuZkKT81P4/iztE2FFv
	 JkEqS5sQVVsVA==
Date: Tue, 18 Mar 2025 17:09:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Janne Grunau <j@jannau.net>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>, van Spriel <arend@broadcom.com>,
	=?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/5] dt-bindings: wireless: qcom,wcnss: Use
 wireless-controller.yaml
Message-ID: <174233576840.4034412.911799977366782024.robh@kernel.org>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
 <20250318-dt-bindings-network-class-v3-5-4d8d04ddfb61@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-dt-bindings-network-class-v3-5-4d8d04ddfb61@ixit.cz>


On Tue, 18 Mar 2025 20:56:48 +0100, David Heidelberg wrote:
> Reference wireless-controller.yaml schema, so we can use properties
> as local-mac-address or mac-address.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


