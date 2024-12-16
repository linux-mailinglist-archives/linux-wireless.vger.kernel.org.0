Return-Path: <linux-wireless+bounces-16417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC74A9F30C9
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 13:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07AE6166930
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2024 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD151201253;
	Mon, 16 Dec 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="piG43C6G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73B4381B9;
	Mon, 16 Dec 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353190; cv=none; b=M5ZcE1VW9n6CFw0Qd3tH3Z6yNlEHuj4SXeoSJnAh0Q+6elwclhqg2rF8ZNkicMtPTDFvZQfDzHV/048ZoqWni5gr9wCxVboBS9vgFmjvxMgHTOhTZ2HKAWXRE6qS00fZ/l+7qH/j9GkRa9kFnrayYSKibrPj9+9q5q3Q1vcCcWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353190; c=relaxed/simple;
	bh=WAhRcRdTlfOmdkosvQIr/mAdS4mM3AbINIJtanUBPzo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fWiLM5LfIsmSZFWirA9rZft/47Dr6V2a5bUXeqD9MPSkhZjOnWNF5ybwY6YCJfBKxQVSuiXapOilhib1ZA7gbpel5nA3VvGwCvBagy/Mopn9Kso3Whag3P3LvfoTaw6yl3JqZNsFCNCqn99OfvYI5cW6ciVt/hvJvr0La43e5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=piG43C6G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AB1C4CED0;
	Mon, 16 Dec 2024 12:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734353190;
	bh=WAhRcRdTlfOmdkosvQIr/mAdS4mM3AbINIJtanUBPzo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=piG43C6GdfxkCu8BRC21raxVLIdZgHUASNcQm2Og1aieWq5ytQErsPimCakylpa4N
	 qwodRXNRio2JC7LopG2kp7OIHJvA/nAuCzAu0I0s2pVDMYQmmrs5DjgIrbMkBQCyx+
	 IUqm1yLxdP2mntEKdQ3DxvpCYLQb9l7Z1qenXBor4Omyu4KmO8NVzDMGjfnwTglqko
	 okyuomnIbsOOxVgnSGQ7SAPKgDMFkct1L0H4XgGjH1hhEolDfgZe6bIghg0MXHPV6o
	 OPepdAt+5a1e0OFGb3kAI32AhTL2wu1fd21+OawuC0HRQPR/wR8Ppe1MpUMPUFYFyK
	 kCND6xpCaz2fQ==
From: Kalle Valo <kvalo@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Roopa Prabhu <roopa@nvidia.com>,  Nikolay Aleksandrov
 <razor@blackwall.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Andrew Lunn
 <andrew@lunn.ch>,  Heiner Kallweit <hkallweit1@gmail.com>,  Russell King
 <linux@armlinux.org.uk>,  Manish Chopra <manishc@marvell.com>,  Rahul
 Verma <rahulv@marvell.com>,  GR-Linux-NIC-Dev@marvell.com,  Andrew Lunn
 <andrew+netdev@lunn.ch>,  Shahed Shaikh <shshaikh@marvell.com>,
  bridge@lists.linux.dev,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] wlcore: sysfs: constify 'struct
 bin_attribute'
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
	<20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net>
Date: Mon, 16 Dec 2024 14:46:24 +0200
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net>
	("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Mon, 16 Dec 2024
 12:30:10 +0100")
Message-ID: <87msgvssm7.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <linux@weissschuh.net> writes:

> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

'wifi:' missing from subject and this should go to wireless-next. I can
take that separately from other patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

