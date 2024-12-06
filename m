Return-Path: <linux-wireless+bounces-15982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE019E76A3
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 18:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2C528189E
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6879C1B4138;
	Fri,  6 Dec 2024 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njoO97az"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA431527AC;
	Fri,  6 Dec 2024 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504707; cv=none; b=R5XLljbzCm9Z8N7ZAxrtk2eobHXC4a06kguE39LaSC7brLSjH5TBFLxgYSlt2wt9UHtCdZNXqtkjuiIwq7jejl0lKA1SovaOwZ/ukvq9THcu761egjJ89v/zk4Dr+tmjnnG8ijDy/YIVo/L+sIDXIoq+ZAMbNrb+EOxEnFEqcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504707; c=relaxed/simple;
	bh=pbxJUWJTY5TChbpv/rOEyLYJArC43EGSJ74ar6wX124=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF4oGOWmrEsLVKNJfOWIG1wTqYzykuBf9WYAe4ppgwWbDT+BGaUd6hI9omPGqg72i+jk1nUQ7gMY6B9eS4/K3d+vPM6dQxFBMSxZxsTJArwW848PGGSmPjUoL0I3eKPAOASfvmZtY18S2YqNrXB5f6gUpiXScdDlvk/Kzb9mAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njoO97az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F83C4CED1;
	Fri,  6 Dec 2024 17:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504706;
	bh=pbxJUWJTY5TChbpv/rOEyLYJArC43EGSJ74ar6wX124=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njoO97azQzfrxhKDbMbM1MoCM22qO+jl6/gMYabgA/pyEt60n18vcTV2Lu5XfrzRp
	 //AW8MPK2fNgSgHgy7so4yrlY5fXd8AxTMmfEI9Sew0LNgiEGECRLnCQyMNR5hoALa
	 kUmzp4WORoBEhpaFnvn31AUrjwukejUsvm8Yv4lxlzCvLyWZWp8u3FNFFhlDddjfhD
	 xwG3d6dv7xZaTrWlAgmE6CXWVTPjt+pvBgUDgV2hf6Wg1eyTiZ8M+yMYrpr6gDkPvN
	 720gvfZCjYbTrLC4nkfgdukvNLXbQ83qJhPHFGnG1SIW7Ue8JFtnvF1msnYPWP9AXq
	 s4Rb9GUhGid4w==
Date: Fri, 6 Dec 2024 17:05:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] dt-bindings: net: wireless: Describe ath12k PCI
 module with WSI
Message-ID: <20241206-sugar-surely-9efffa93aa5c@spud>
References: <20241205203044.589499-1-kvalo@kernel.org>
 <20241205203044.589499-2-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rdo5ZU0gHnMChw1D"
Content-Disposition: inline
In-Reply-To: <20241205203044.589499-2-kvalo@kernel.org>


--rdo5ZU0gHnMChw1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2024 at 10:30:37PM +0200, Kalle Valo wrote:
> +  qcom,wsi-controller:
> +    type: boolean
> +    description:
> +      The WSI controller device in the WSI group aids (is capable) to
> +      synchronize the Timing Synchronization Function (TSF) clock across
> +      all devices in the WSI group.

This should be type: flag btw.

--rdo5ZU0gHnMChw1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1MuvwAKCRB4tDGHoIJi
0tfyAQCB/Ej4u6h44VI4yxBcx++if1Ey/ODl4wlzozM57MTJWAD+MoBttC+tWASw
y3QxDHh59f6noENg6hoj5hUX6dVQLQ8=
=r5SO
-----END PGP SIGNATURE-----

--rdo5ZU0gHnMChw1D--

