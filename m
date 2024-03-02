Return-Path: <linux-wireless+bounces-4322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456B86EF9F
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 09:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351CB1C21C72
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Mar 2024 08:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3C1774C;
	Sat,  2 Mar 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="uM338JTX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F3017561
	for <linux-wireless@vger.kernel.org>; Sat,  2 Mar 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709368085; cv=none; b=jRaKf3dbzmJ6PWj/H85P7QC15EXvuycIVnp29gznfsnWeXV1H3eNVFaxbyl1xSOOc9cqKrq/sonq9RtS6v8zZM2v6YHSP9rpxia9TMLLaNrXa0bY64WmGMYgMIx1i8sVq4lziP+wrkiPEi9E2XAaO5ebyjU18l+XMzivsRI/0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709368085; c=relaxed/simple;
	bh=R3iE4BrJ+jeiDI2lA2broDYmYvbqpxWyLcepMM+U6Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/MP4p0ol/OEDk4RFAfch7wnYwEJM/kH6BSkf4Xwcx801vABbuBVNc3LAQTTt+y3/fOdbvmOp6Fy6gm0OhIl1szF9RlsnCnW/RrqpSKzWn+Ff99JGNIyklGR/hkFWDwaEtZxZywWgRIVxRVU+tGazCcfSOuWLxpNsMXP2YxvNxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=uM338JTX; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 46608 invoked from network); 2 Mar 2024 09:01:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1709366479; bh=iQuIQoXi6oTr5EVIJDyPtRvWn5r9HOv722dQMBghQJg=;
          h=From:To:Cc:Subject;
          b=uM338JTXf5vMCzV97B7swHyqe3mX4IbzMH6ipn4HoJE7A33p/Nd9PNnAegrZOXcy9
           LNWfJ0tL5sjyC36unIbL8m4w7wzWgNyTBp+Mhw8728jgHO62NrEFqtDr7PFqhIbzS2
           FAhqMQhSvkbRf5Tao3Axm5yJsjGmgz4R8Es6gptw=
Received: from 89-64-9-52.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.9.52])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <johannes@sipsolutions.net>; 2 Mar 2024 09:01:19 +0100
Date: Sat, 2 Mar 2024 09:01:18 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 3/5] wifi: rt2x00: silence sparse warnings
Message-ID: <20240302080118.GA198451@wp.pl>
References: <20240223114023.c64e2d348453.Iccc4ace1116721a044e5f31f40ea7709e72145f3@changeid>
 <20240223114023.ce0c714124e9.I2b5710b761f63522574fbe7654d37151c31e0b77@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223114023.ce0c714124e9.I2b5710b761f63522574fbe7654d37151c31e0b77@changeid>
X-WP-MailID: 231c1ea4958ca454196df544f7380c89
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ocNE]                               

On Fri, Feb 23, 2024 at 11:40:25AM +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Clearly writing __le32 was intended here, so just put the
> right casts into the code to silence sparse about it.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> index aaf31857ae1e..3bb81bcff0ac 100644
> --- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> +++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
> @@ -10946,13 +10946,13 @@ static void rt2800_efuse_read(struct rt2x00_dev *rt2x00dev, unsigned int i)
>  	/* Apparently the data is read from end to start */
>  	reg = rt2800_register_read_lock(rt2x00dev, efuse_data3_reg);
>  	/* The returned value is in CPU order, but eeprom is le */
> -	*(u32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);
> +	*(__le32 *)&rt2x00dev->eeprom[i] = cpu_to_le32(reg);
>  	reg = rt2800_register_read_lock(rt2x00dev, efuse_data2_reg);
> -	*(u32 *)&rt2x00dev->eeprom[i + 2] = cpu_to_le32(reg);
> +	*(__le32 *)&rt2x00dev->eeprom[i + 2] = cpu_to_le32(reg);
>  	reg = rt2800_register_read_lock(rt2x00dev, efuse_data1_reg);
> -	*(u32 *)&rt2x00dev->eeprom[i + 4] = cpu_to_le32(reg);
> +	*(__le32 *)&rt2x00dev->eeprom[i + 4] = cpu_to_le32(reg);
>  	reg = rt2800_register_read_lock(rt2x00dev, efuse_data0_reg);
> -	*(u32 *)&rt2x00dev->eeprom[i + 6] = cpu_to_le32(reg);
> +	*(__le32 *)&rt2x00dev->eeprom[i + 6] = cpu_to_le32(reg);
>  
>  	mutex_unlock(&rt2x00dev->csr_mutex);
>  }

