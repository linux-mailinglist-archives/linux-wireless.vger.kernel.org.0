Return-Path: <linux-wireless+bounces-11588-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE4955D5E
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A1281465
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2024 16:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1165D145348;
	Sun, 18 Aug 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSV+rd4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD38F6E;
	Sun, 18 Aug 2024 16:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723997271; cv=none; b=dJ0YNkNIPsJ+kCyUHnHQYdZdk+m9cKLEraSFSgctg8whKJ2aEsOTZz6R1cuX533Kj1eq4XBStEP+lfT256QaQYCdVxxePIL7CnjM01pbw1suHUjGElOl97rglQ2gMJ5TONwQpBoCcafA9I25d5QJsBj4Z/Q1qLJ3U4SJEg+dhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723997271; c=relaxed/simple;
	bh=mcs4PVQSjRuRWq45Plieqdxgjn6imGdr088Dfey7QR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUxPX6KDShSS1j0oBqUVrUKMyPRRBBi8YmY5ZkytfK0i95VMj9Fa0NJhQdlE3j0RTCUIlMM7d5/9UIXbpuYRteKZgVdOAICWG2jUvD7mwch7XVFZ8A4IocnG+53hTy9r97otrNwpKSKnasfVk9J70KVxzoTcuIk6OQlsBvnwUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSV+rd4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A1DC32786;
	Sun, 18 Aug 2024 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723997270;
	bh=mcs4PVQSjRuRWq45Plieqdxgjn6imGdr088Dfey7QR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSV+rd4mhhLch4Hb2wQ/JD7sosK/sfdaeXSa0O7La/4tfRgdqYyY+XSSEg4O+vKY0
	 GtGq3vXiQu61TkU+4hT+vclqgy48LdRM4U9YKuVrryfZAtczV/S4W5h6U9Nbm17u6V
	 B3JKz+domndIxoO571OL+TUKLSap1B50WTenCj9sjudZsbcpeBUGoF956ZfTXZlADG
	 zW5zjnF1rFRcdRfQWSl5khQInDDmPMlbqaR8TVI9pGoHIcorjsDBXGhfZcj799laPB
	 07r/F+fyPfDjiMxXNnmS5dbOSPxW3q8x/8M+tmRUKvK+cWCrGwjlG1MfuKEJxg1ghh
	 FhOgTPiJA63cA==
Date: Sun, 18 Aug 2024 10:07:48 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: net: wireless: convert
 marvel-8xxx.txt to yaml format
Message-ID: <172399726749.169283.2858503269781464007.robh@kernel.org>
References: <20240816171203.143486-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816171203.143486-1-Frank.Li@nxp.com>


On Fri, 16 Aug 2024 13:12:01 -0400, Frank Li wrote:
> Convert binding doc marvel-8xxx.txt to yaml format.
> Additional change:
> - Remove marvell,caldata_00_txpwrlimit_2g_cfg_set in example.
> - Remove mmc related property in example.
> - Add wakeup-source property.
> - Remove vmmc-supply and mmc-pwrseq.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dtb: /soc@0/bus@30800000/mmc@30b40000/wifi@1:
> failed to match any schema with compatible: ['marvell,sd8997']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - Add Brian Norris <briannorris@chromium.org as maintainer
> - Remove vmmc-supply and mmc-pwrseq
> - Add wakeup-source
> - rename to marvell,sd8787.yaml by using one compatible string, suggestted
> by conor dooley at other binding doc convert review
> ---
>  .../bindings/net/wireless/marvell,sd8787.yaml | 93 +++++++++++++++++++
>  .../bindings/net/wireless/marvell-8xxx.txt    | 70 --------------
>  2 files changed, 93 insertions(+), 70 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


