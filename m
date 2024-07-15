Return-Path: <linux-wireless+bounces-10234-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71B0931C47
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 22:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6C91F22CC4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 20:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539C13C661;
	Mon, 15 Jul 2024 20:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="smNskPC6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5351369B1;
	Mon, 15 Jul 2024 20:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721076867; cv=none; b=IGWh1Py9CjZ86ce35plIxE2RUyEbUgDZjGeFgraeJcrpdXwD6VrtdN5RU/49y5UI6U841/Gm680MlKebapLas62mic+PbCd8uQQdqYR5SV7l93nltH8hs/0tWIkQM0JguAS6GfmdmZWN+gdDhuudubXmr4BrE/nnzytt8wpl3y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721076867; c=relaxed/simple;
	bh=GbO9ojADkbrwzmTzCfqcY+cM9/cRstS0/OS061RqHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwqij86vyQnkRYZJNRML3MPJOLk+CXCw0UUn4c8fGXfJi79fOF1lxhAV8afED3vu4R4BjF47mdOjJA5EKI6NNU5EWwFB5ISIsGkQqCyueUnO2fzJFtx6bwIHjVhTCXnuZN2OeJ/z/9uUyLa43X2nH0YpZ0kb0JvTa+rwVT6jv0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=smNskPC6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2XX97vPnUkvDBngxR1OH9w6lkOMKVHi62djdg7AIKK0=; b=smNskPC6zoeOkYOZngxYspN1+8
	RG1oaSAfmLWXW1IS/hFVpFbd6pTH5aRKQJdgRC7H5G4d2AAn8cBPzYeIgcYcmdx8wJs6ewRYgg1cL
	6k3i/z2JYcymTz00SgTqKNDE59sIPZepdS0nR6u41uuJaah5NgXGOjWllb5qDSR/a77E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sTSiB-002bCE-05; Mon, 15 Jul 2024 22:54:19 +0200
Date: Mon, 15 Jul 2024 22:54:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Patrick Wildt <patrick@blueri.se>
Cc: Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Steev Klimaszewski <steev@kali.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: wireless: add ath12k pcie bindings
Message-ID: <d921bf20-1d83-492f-ab88-0f23de26a649@lunn.ch>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <ZpV7B9uGVpeTSCzp@windev.fritz.box>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpV7B9uGVpeTSCzp@windev.fritz.box>

On Mon, Jul 15, 2024 at 09:39:51PM +0200, Patrick Wildt wrote:
> Add devicetree bindings for Qualcomm ath12k PCIe devices such as WCN7850
> for which the calibration data variant may need to be described.

Hi Patrick

General, the device tree binding and the needed changes to the driver
to implement the binding are in the same patchset. I don't see
anything implementing qcom,ath12k-calibration-variant here? Does the
driver already support this, and you are just fixing up missing
documentation?

	Andrew

