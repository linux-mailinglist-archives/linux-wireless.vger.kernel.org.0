Return-Path: <linux-wireless+bounces-16515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A619F5D2B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9464916CF3F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C680034;
	Wed, 18 Dec 2024 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEVJ8K/u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843C04C6D;
	Wed, 18 Dec 2024 03:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491041; cv=none; b=STi8c9HcpLXmoRxgshe7NS1jEf20ZPTiBd5I9tljkUEk0GV/mKD4bDXUVxJaZ3qnGYzTBLN1hk0yp3kLPulw8bdv+2JjtnWhVA8VUJcAvVsr6xJ/ZqAbTT5S8KSezU/hNB+RM+RqCx4psorG2j0I5RsOWT7MyU2EwVMrot0/H4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491041; c=relaxed/simple;
	bh=QHVe2mJyNciWB0mkRPEw7qVuq1AtUwnpNz7L496KVzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiywplgqRINaWwQ2Zclh5SNLf6VfxSdmbPrIBN5GqagWCpeXEdOU7+tduXeDtzmN49nZflq/fdMgIFtMgHCvnZ9Q9WBnuOqEDrCVpsEIQVzJFalNHEy7+CNiUUuxodWZXZYCmL4gr+5Dc6kiNmN+9boPjC0xYJ6IHjUrMc/Z+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEVJ8K/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C39C4CED3;
	Wed, 18 Dec 2024 03:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734491041;
	bh=QHVe2mJyNciWB0mkRPEw7qVuq1AtUwnpNz7L496KVzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LEVJ8K/uXc9FXtLqYUSUHe8lRjcYK2agkIBCSaUrtJ5aaMcMk0QUYUMNTPfRhp1zN
	 GGTyAz/uq4zRr/IyE5JThpUyycOpNmFI1j+DazdkoWgsIY2OWENef5CIBRnKrYdY7Y
	 G+AVluNgTPrJDh52J20NTie8VFRMbhsJXPzkG+6vp0DHM8YoDJq7XX4TxYdS8zCAnD
	 KwIYFkfyHOzoSkh5CHJi1YgdHsc+ospSOVmGDMuT6p+34mT+8oDQ0twG2UEaY6TKN6
	 dNZQSza8G1T7ya9GH+hwpnqayjKuCXScBqdm76kjxMh+DUSbnTo4TqVhr5mZ7wyPYl
	 2vGiGuVPEd9Vg==
Date: Tue, 17 Dec 2024 19:03:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>
Cc: Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Kalle Valo
 <kvalo@kernel.org>, Manish Chopra <manishc@marvell.com>, Rahul Verma
 <rahulv@marvell.com>, GR-Linux-NIC-Dev@marvell.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shahed Shaikh <shshaikh@marvell.com>,
 bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] qlcnic: constify 'struct bin_attribute'
Message-ID: <20241217190359.6958ea4f@kernel.org>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-5-ec460b91f274@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
	<20241216-sysfs-const-bin_attr-net-v1-5-ec460b91f274@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Dec 2024 12:30:12 +0100 Thomas Wei=C3=9Fschuh wrote:
> -	.read =3D qlcnic_sysfs_read_pci_config,
> -	.write =3D NULL,
> +	.read_new =3D qlcnic_sysfs_read_pci_config,
> +	.write_new =3D NULL,

Please delete the NULL assignment instead.

