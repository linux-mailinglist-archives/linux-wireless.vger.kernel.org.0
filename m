Return-Path: <linux-wireless+bounces-16644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BC79F8D12
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 08:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E4166123
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAA1175D29;
	Fri, 20 Dec 2024 07:09:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [81.169.166.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6417333D;
	Fri, 20 Dec 2024 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.169.166.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734678594; cv=none; b=QFsQh70bx/I1uHlyFRaAVYIU0Y0ZFjA0d0VzZyGrmaOOn6HnRIKDyGK0ZTjvzuhJq6LegeCYiBLlK4KOdyVZ+MSyENI8mxodf2XBY/usI/r6BDjOoxCwkiqqjy7qrhM8CY4SaB2UKWOe13A3spLkwMRtP12Ku8kTpxwjkILxAXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734678594; c=relaxed/simple;
	bh=Z1EeZFJMGqCNNzL8KCDVnaUC/rQxiIwxV6vU2GbW/1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac5xOAWfa5DdNjTRttmWTMD03Dl7R2WgDDJE7BHU9fm17J9fhd3rYX0jekpm5zp3rYR421KWD+dPZ1XKxBVS/lS9e62mBn4TeF5MnTxm17PA87QQX2GbjK+nT/EkB6wCLpcHaixBY6j7Y5pWZ9IYEipMcKSBy0qYcw0uIWyeKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=pass smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=81.169.166.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+linux-kernel@zugschlus.de>)
	id 1tOX8u-004RNC-0c;
	Fri, 20 Dec 2024 08:09:48 +0100
Date: Fri, 20 Dec 2024 08:09:48 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Intel Comet Lake Wifi (8086:02f0) only working after cold start,
 failed with error -110
Message-ID: <Z2UYPB_64YPkMHv6@torres.zugschlus.de>
References: <Z19G5zFhmWOfINvt@torres.zugschlus.de>
 <Z2Q3dTbuRNh0ELo3@torres.zugschlus.de>
 <CA+icZUW6nfJKFTUm820a4Mkc+H6_G=qDksn4SNoxCKV1gFSoXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUW6nfJKFTUm820a4Mkc+H6_G=qDksn4SNoxCKV1gFSoXg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

Hi,

On Thu, Dec 19, 2024 at 04:34:03PM +0100, Sedat Dilek wrote:
> I enhanced the CC list.

That would have been my next escalation. Thanks for doing it quicker.

> Checked for newer firmware?

Debian Unstable has firmware-iwlwifi dated 20240909.

And, in the "bad" case, the syslog doesn't look like something is even
trying to download firmware.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

