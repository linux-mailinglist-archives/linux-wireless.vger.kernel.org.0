Return-Path: <linux-wireless+bounces-15114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CB49C10C2
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 22:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90CDAB24248
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EB7217F3C;
	Thu,  7 Nov 2024 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oDa6beDM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D34C21765A;
	Thu,  7 Nov 2024 21:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014011; cv=none; b=l1//zDu9xeO0URFLO3fOBAHV/eX4+vGysX7xVjwjXW34MgXMfQVKsMwkb2A9bihZ74GdyndeUttItCyuYTnJjvJ6wAWwozeImWB49/5v+tKX+5oc8QxasBKiJ34n+sJUBdA2GTcw1hMZJX5gxP0thQXBbsSTWoL/O4OJQVvIdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014011; c=relaxed/simple;
	bh=NF1PbXxsfv3RGUEvkM3yDrFkki1lLxSxq1Lzdc9nM8A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KibSJlXfjOAqjrZ/IyC8e3kF/RiQq7FecnFPsX7bPGO526pBDYParX42jKyPkTy2jacKUrXVjC7pJZ+MKjnD/Q2QESZjDuVmkRguw7nDDa/k/x7AQbFZZGNPXfe6lrt4v9+gG5jIFoNEwq9Uz4Q80+iDb3K3KB4gF61fY5ND8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oDa6beDM; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NF1PbXxsfv3RGUEvkM3yDrFkki1lLxSxq1Lzdc9nM8A=;
	t=1731014009; x=1732223609; b=oDa6beDMWqg6pQGPs5OGUm0a2ytnd1BIWPIMrZPu4sK2A2j
	tilspFRdvIyesCR44vAPDmIPyqlxmlPQlaUiPVTd9Fw08/BQVawsgiF7Lrz8kuSefvRhZF1L/nfPN
	vrtU6jP+n5BrQCbDHBNQw1knLkf6Tz046idtWWQ93zcsB19pRsk2ezS1SdkRrBZelAzDOkhkMi3Yt
	SNWPnTJfls2vNgxfeTZ6Qr1WhOBkSuFCsQFk/Xv0Mw7gX9yBNsaR59QAlJlVWpqlrY1eU4elJZh3a
	5G5Kpej+XGZZRbtSg9B0zZPP1enu8iWIUDeC6BHPnbDV9ZVaXYU2TGeKAGJvnc1w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t99oj-0000000Ga8H-0OAX;
	Thu, 07 Nov 2024 22:13:25 +0100
Message-ID: <e280d466bab534f67b555a0252e41a2647a971a5.camel@sipsolutions.net>
Subject: Re: [PATCH] net: rfkill: gpio: Add check for clk_enable()
From: Johannes Berg <johannes@sipsolutions.net>
To: Mingwei Zheng <zmw12306@gmail.com>, linville@tuxdriver.com, 
	rklein@nvidia.com
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Jiasheng
 Jiang <jiashengjiangcool@gmail.com>
Date: Thu, 07 Nov 2024 22:13:23 +0100
In-Reply-To: <20241107210155.1383802-1-zmw12306@gmail.com>
References: <20241107210155.1383802-1-zmw12306@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-07 at 16:01 -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> expection.

"exception"? but we don't have exceptions? "error"?

johannes

