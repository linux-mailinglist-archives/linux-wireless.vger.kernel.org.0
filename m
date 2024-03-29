Return-Path: <linux-wireless+bounces-5530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA5689161C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DAC1C2383D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D351C42;
	Fri, 29 Mar 2024 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1cAClxC3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C65102E;
	Fri, 29 Mar 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704857; cv=none; b=W7iWLx7zHQd3H0vcL0TJGlU/XNA1o4kUQP2SpLx5w3n2J/79XaAZm2rOra+pB0WkdjY9bjfQ/Quu9O3w9omN9SV9y2jLfjLX1RnzNwcUXD6nZXg/1+VQwHujHBDwKwU+kksN+u1pjff53rTfOCYy6zwVHFJxi3loSkYr9tNTWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704857; c=relaxed/simple;
	bh=VgkXK0mJbYwXmgA/6NHIdEfy55H6cuyxcE22eOH92fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uijVPUubIB84ZFKK13YVAiUGBMoi0kXvfwJe2ZZBYl4in5YyP6vDztSkr9clSqC7bwCsZx8Pmyj9x8ETNZvcEdrzuhAAhC3NS39LOoCkCC8q1jTRl8pEgVj3h5EwuUjOnOxS9MijqbNEru9Jt8gQGu6JD9bYyYK4KxsTYas8l+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1cAClxC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4E8C43390;
	Fri, 29 Mar 2024 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711704857;
	bh=VgkXK0mJbYwXmgA/6NHIdEfy55H6cuyxcE22eOH92fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1cAClxC3ogn/r0oV/tLjAsJ1vBzDKD80PKytAlHLyPYbULwNvpVPYhkHrMKBvJDMD
	 5e4N8fxBthCbQZ8y3LPCyMUtQS7aKn7C/WI9ndSNXAIf/EfPACtYc2RaZvu8Ux83QJ
	 odDxVdad2kJN7ocnLI+Sbv4a0QWtQSQnVH+56zgY=
Date: Fri, 29 Mar 2024 10:34:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aaron Ma <aaron.ma@canonical.com>
Cc: sashal@kernel.org, stable@vger.kernel.org, gregory.greenman@intel.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH 6.6 1/1] wifi: iwlwifi: pcie: fix RB status reading
Message-ID: <2024032900-resort-relapse-fe31@gregkh>
References: <20240328015402.114435-1-aaron.ma@canonical.com>
 <20240328015402.114435-2-aaron.ma@canonical.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328015402.114435-2-aaron.ma@canonical.com>

On Thu, Mar 28, 2024 at 09:54:02AM +0800, Aaron Ma wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> [ Upstream commit 9f9797c7de18d2ec6be4ef6e0abbaea585040b39 ]
> 
> On newer hardware, a queue's RB status / write pointer
> can be bigger than 4095 (0xFFF), so we cannot mask the
> value by 0xFFF unconditionally. Since anyway that's
> only necessary on older hardware, move the masking to
> the helper function and apply it only for older HW.
> This also moves the endian conversion in to handle it
> more easily.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Link: https://lore.kernel.org/r/20230830112059.7be2a3fff6f4.I94f11dee314a4f7c1941d2d223936b1fa8aa9ee4@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Cc: stable@vger.kernel.org # 6.6.y
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/pcie/internal.h |  8 ++++----
>  drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  2 +-
>  drivers/net/wireless/intel/iwlwifi/pcie/trans.c    | 12 ++++--------
>  3 files changed, 9 insertions(+), 13 deletions(-)

Now queued up, thanks.

greg k-h

