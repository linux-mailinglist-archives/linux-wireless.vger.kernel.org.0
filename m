Return-Path: <linux-wireless+bounces-19801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55CA4FF18
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 13:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1F63AD6A8
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F7F24502D;
	Wed,  5 Mar 2025 12:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TlsTQG1+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315E22441A3;
	Wed,  5 Mar 2025 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179390; cv=none; b=Vuf8k6J7GygU+Xx45KgzL3toY6d6Rnk5sFsxWzfPqTPTmbM7CV4G+DhyxGZ9wwq84eI0vOFgjRhoXc3mz/Kq7X+CNBZzOdqcrUf9uUmjut9Tb57gcSL8N+4AQO3XemBHOO6Zrtkc1dIqEwnY4qS86g2hzBq7hbpowgp+B8wH8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179390; c=relaxed/simple;
	bh=stO30UINr/S9gQ16bMvr3QhTLQeKnh2AdaLOeIE1diY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZmEj7UA1r7Jq4gx0qttMokYNw4sBnNUkgLYqsiKwSrNffNdn5XG77LwIJ0Plz4JbuKjPqappJseV9VhsLF1+76mv12hi7qlRyW2yf1Iji62GnTQNzlySRnKE6wbIQQI9BhYpt7Jx6qppvCAk1akwQAUtQu+dO8kJPay9jqHKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TlsTQG1+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=WMkvl/IfsPF/ua4f4IZM2b3fgvXuqFq8/FIpoBLz03A=;
	t=1741179389; x=1742388989; b=TlsTQG1+VkttdHsp9iDu4PBvskR/RMNGOY1xNnzvQGkODCl
	oFUgBEtK10pCeamV2gkKCoXkTfDlWtaZnHvTnMwYzJe/v4ewLbGsSJoAlA/q3VxC72J9ZQwABG0eN
	9QUxvFh0Dnpv32W3p056nD8JMY6vjGycXMRc/C8i9i7jhLuAIVDI2qkN9QZp3823xV+54DjGBYxha
	Z04eM8hj/6PWiZQTudhUgvvzgPyA5kdgPMxZ8IbztuvBSu5CW23JHZye27Eunl8j00UihVbpPWHxr
	J99kPutwKeYGy/ENq5y7qjJHeBHXelUSPYsmBGPGMO/+hN/wQOHwva4XeSpfkDJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpoIO-00000001kWp-0uLh;
	Wed, 05 Mar 2025 13:56:20 +0100
Message-ID: <db6e127f5f7cfaf76bbf4438ae8962993f4aba03.camel@sipsolutions.net>
Subject: Re: [regression] Significant WiFi Speed Reduction with Kernel
 Versions > 6.8.12 on Intel Wi-Fi 6 AX203
From: Johannes Berg <johannes@sipsolutions.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Miri Korenblit
	 <miriam.rachel.korenblit@intel.com>, emmanuel.grumbach@intel.com
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML
	 <linux-kernel@vger.kernel.org>
Date: Wed, 05 Mar 2025 13:56:19 +0100
In-Reply-To: <20250303222700.GA202089@bhelgaas>
References: <20250303222700.GA202089@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

[removing folks no longer involved]

Hi,

So ... it's complicated, but I think it's a bug.

> 4886460c4d15 ("iwlwifi: Fix IWL_SUBDEVICE_NO_160 macro to use the
> correct bit.") updated IWL_SUBDEVICE_NO_160() to identify devices that
> should not support 160MHz:
>=20
>   -#define IWL_SUBDEVICE_NO_160(subdevice)        ((u16)((subdevice) & 0x=
0100) >> 9)
>   +#define IWL_SUBDEVICE_NO_160(subdevice)        ((u16)((subdevice) & 0x=
0200) >> 9)

I'm not even entirely sure this logic is correct; however, it doesn't
really matter.

> The submitter's device has Subdevice ID 0x1652.  Prior to
> 4886460c4d15, that did not match IWL_SUBDEVICE_NO_160(), but
> afterwards it does:
>=20
>   0000:00:14.3 Network controller [0280]: Intel Corporation Alder Lake-P =
PCH CNVi WiFi [8086:51f0] (rev 01)
>     Subsystem: Rivet Networks Dual Band Wi-Fi 6(802.11ax) Killer AX1650i =
160MHz 2x2 [Cyclone Peak] [1a56:1652]

According to our internal information (SKUMAP-362, for the Intel folks
who know what that means), this name is correct, it should be 160 Mhz.

> But apparently it wasn't until 84ec2d2e960f ("wifi: iwlwifi: disable
> 160 MHz based on subsystem device ID"), that 160MHz support actually
> got disabled for devices that match IWL_SUBDEVICE_NO_160():

I've also found information elsewhere (WREQ-269994) that the whole
IWL_SUBDEVICE_NO_160 (now actually a bit different to take no-320 into
account on newer hardware) is *not* applicable to "Killer" branded
devices at all.

So I think it's a bug, but I'm not sure right now *how* we can fix it.
It looks like our matching must skip the bandwidth restriction thing for
Killer devices.

johannes

