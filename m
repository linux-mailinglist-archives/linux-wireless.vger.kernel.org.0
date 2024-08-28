Return-Path: <linux-wireless+bounces-12185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F49630D7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 21:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBE91F22111
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 19:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9359014D71E;
	Wed, 28 Aug 2024 19:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="FSU30FFz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85E42868B
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 19:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.71.239.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724872687; cv=none; b=liHrqAXZ4jf+3Vj3vYFxfo+NvDc8GlyffIWFwjMLguaazedin9Y0NmhRPBRlOJC8UOYslouww4A9mSh/2Jd7Yk7BnPwbx/cMQsNStKQA7y+74O7ih3oXq2NP7Q+PsSyUHP+Vvm+typ1sxb11+EV77zdovmdpIVrwAbodb93LL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724872687; c=relaxed/simple;
	bh=aaIOZlAAp+dxoeEoqpjirHE6adFNWLwFR5Qqas2rsNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqGdbIzJRamBKErUIjkt1eFu8O27x6aMmTKDUERI3fmURjv1RpKDCfyQ5RsA24MTcwIk6ow0S4oeIZtPK68wO0jBn2Vu2dRn63vshnHGnFt8uvfd4aDGmLVxn1neSaW6/pbhhiVaqVEFhSUNhWXmlnK8GtsTyCwaqMENUODPelY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi; spf=pass smtp.mailfrom=w1.fi; dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b=FSU30FFz; arc=none smtp.client-ip=212.71.239.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=w1.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w1.fi
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 0744111B78;
	Wed, 28 Aug 2024 19:18:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1rTnU4ZHILZV; Wed, 28 Aug 2024 19:17:20 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Wed, 28 Aug 2024 22:17:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1724872640; bh=aaIOZlAAp+dxoeEoqpjirHE6adFNWLwFR5Qqas2rsNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FSU30FFzYuzU4kfWbPTRyxZuTE42fJ4V/v4ynvOMpl7eXXRNDSfLybVuIEzhRJ96z
	 TH3tC7eLOEviIyZlYsqr0Iwhmcl2E0h4T57GSUeqWa1wOaz5T+HTcqvP9zxD61c6+a
	 pd1aRwcMQylfNdiOY1A6q+IlsudmflBGZXqIBWFo56OnNZIyCbC5Oib0rl2/9bNtva
	 WD770bgVqwkLCBrjD7tMREN/sD8Izp2m/Oc14iSQw/hC8kWv5wYzhnmfuyI/7GfJrZ
	 KY8oorJ3VeFQonNwuTsmLPGRz0aDfZW/yFGal9kUOFfzss0zRlbfZkBKV7cieAiZPs
	 tJF6lXtZYUbjg==
Date: Wed, 28 Aug 2024 22:17:18 +0300
From: Jouni Malinen <j@w1.fi>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, hostap@lists.infradead.org
Subject: Re: WiFi constantly changes association
Message-ID: <Zs93vqABzws2VHts@w1.fi>
References: <eb86cf20-2b1b-4871-82a4-441ba81752dc@rowland.harvard.edu>
 <9f32e4ff8b59f137208d99c40fd166f81e8de4bc.camel@sipsolutions.net>
 <52752800050fdd10e3d883cb4870624455d1b34e.camel@sipsolutions.net>
 <9cd7bc93-090a-4fcd-9af1-af6ff108064b@rowland.harvard.edu>
 <25391c67947d47c4cb75e89664a882905e125863.camel@sipsolutions.net>
 <Zs7WegloyrfZdRu9@w1.fi>
 <f6ea69035f7ff32edc2575765641689e469f764a.camel@sipsolutions.net>
 <fa0c3a9f-7034-41c7-a066-08284d8a069b@rowland.harvard.edu>
 <Zs9zxsjJD2jQ/jBc@w1.fi>
 <db648027-9208-43f5-8a5a-b235796a25db@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db648027-9208-43f5-8a5a-b235796a25db@rowland.harvard.edu>

On Wed, Aug 28, 2024 at 03:07:14PM -0400, Alan Stern wrote:
> Is there a way to tell wpa_supplicant to ignore APs on the 6-GHz band?

You can configure a list of allowed frequencies with the freq_list
parameter (space separated list of channel frequencies), so that could
be used to list all the 2.4 and 5 GHz channels. With some drivers, there
might be some other options like the control interface command "SET
setband 2G,5G".

-- 
Jouni Malinen                                            PGP id EFC895FA

