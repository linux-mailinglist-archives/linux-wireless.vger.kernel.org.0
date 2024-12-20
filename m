Return-Path: <linux-wireless+bounces-16645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 484659F8FD9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 11:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7A316F6AD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 10:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968B1C07E4;
	Fri, 20 Dec 2024 10:07:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from torres.zugschlus.de (torres.zugschlus.de [81.169.166.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACDE1C3F02;
	Fri, 20 Dec 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.169.166.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689222; cv=none; b=gjqdqVznVnNk2HrnSlQscQFynvwO9zkwvIlUkv4Gfyc1mF5LkvEa+ISNcgVJOMEDMvGSZMPlHQ2wNMVbmSVrwSDOYdpFcfJe7hkGtjAg+Z66ngAPKcUHB6snEeN5lybk+Y9s0DdIBHmV+aBZ7iswLKdVL4bo8NfcXV+bEAcWwSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689222; c=relaxed/simple;
	bh=RMv/csOzWju/xlzfWIfYPngyiazL/PQ/llvgY+c3ZkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbZfYx75o/g3rpIqnJhkDAPbm3tnhLisB8T1qlOpgumBWz57vxidB7fZykdy0RumzAfXZQevH86wKcBqK3kgR47Jr250spLTV3QFqcY8ShuLiF8lnGk2tzEwLEfLGGnNOmP93Db5r/vmugcJ6WnAQ+2kyNNyl9ljGkK8K8qoZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de; spf=pass smtp.mailfrom=zugschlus.de; arc=none smtp.client-ip=81.169.166.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zugschlus.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zugschlus.de
Received: from mh by torres.zugschlus.de with local (Exim 4.96)
	(envelope-from <mh+linux-kernel@zugschlus.de>)
	id 1tOZuJ-004VzV-1R;
	Fri, 20 Dec 2024 11:06:55 +0100
Date: Fri, 20 Dec 2024 11:06:55 +0100
From: Marc Haber <mh+linux-kernel@zugschlus.de>
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Intel Comet Lake Wifi (8086:02f0) only working after cold start,
 failed with error -110
Message-ID: <Z2VBv7Um0cf9dwvw@torres.zugschlus.de>
References: <Z19G5zFhmWOfINvt@torres.zugschlus.de>
 <Z2Q3dTbuRNh0ELo3@torres.zugschlus.de>
 <CA+icZUW6nfJKFTUm820a4Mkc+H6_G=qDksn4SNoxCKV1gFSoXg@mail.gmail.com>
 <Z2UYPB_64YPkMHv6@torres.zugschlus.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z2UYPB_64YPkMHv6@torres.zugschlus.de>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Dec 20, 2024 at 08:09:48AM +0100, Marc Haber wrote:
> On Thu, Dec 19, 2024 at 04:34:03PM +0100, Sedat Dilek wrote:
> > I enhanced the CC list.
> 
> That would have been my next escalation. Thanks for doing it quicker.
> 
> > Checked for newer firmware?
> 
> Debian Unstable has firmware-iwlwifi dated 20240909.
> 
> And, in the "bad" case, the syslog doesn't look like something is even
> trying to download firmware.

I updated my Debian unstable from last week's version, it now has kernel
6.12.5 and firmware-iwlwifi-20241210_all.deb. Behavior unchanged.

I then downloaded linux-firmware-iwlwifi-fw-2024-11-28.tar.gz and copied
its contents over /lib/firmware. Behaviod unchanged.

In the bad case, grepping dmesg for firmware yields firmware being
loadded for psmouse, Bluetooth, elan_i2c, and sof-audio-pci-intel-cnl,
but not for iwlwifi.

In the good case, it additionally logs failure to load
iwl-debug-yoyo.bin (-2) and then proceeds to successfully load firmware
version 77.0b4c06ad.0 QuZ-a0-hr-b0-77.ucode op_mode iwlmvm.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421

