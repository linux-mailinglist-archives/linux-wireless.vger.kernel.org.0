Return-Path: <linux-wireless+bounces-716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF280F699
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 20:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C43EB20EC2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B58381E47;
	Tue, 12 Dec 2023 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxSJcR2H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51D81E40;
	Tue, 12 Dec 2023 19:24:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C062C433C8;
	Tue, 12 Dec 2023 19:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702409096;
	bh=YKUYPwfQBBW92BlkDApqDnDZn5/rc1aNpNwEcRqPpiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxSJcR2HGJyqL+55l1Kg16M+VJ2anthTLtAk0B5+O7iAKLbca6n4BpExge9JA7x3z
	 OLoXWRkR3QmOdFqcPAuMVXRgujLPnwIpLvjwotzOFx3XGUOsCrOKPf/E60zi1VRdlk
	 3oDYEo/97GAfEdj0EWcqsk8B4FMpISVyuw4001UTHAY3B9+vOdeGzkEDRrf4XmmPmH
	 GL0fs+SvkJjtMj2aNv7u7cfssgx0T9gluceqPyyCV5aqs3ldUZJEB7i04FkLn7wZNa
	 IH9OvqEPYVwPNcu7BU+w6hDi8n+zYlwe4adVSYD1bKQVMVszzTM4B8h/GqpCHgsgcT
	 PgHt+inMkgCsg==
Date: Tue, 12 Dec 2023 19:24:52 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: fw/dbg: fix all kernel-doc warnings
Message-ID: <20231212192452.GD5817@kernel.org>
References: <20231208220945.20628-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208220945.20628-1-rdunlap@infradead.org>

On Fri, Dec 08, 2023 at 02:09:45PM -0800, Randy Dunlap wrote:
> kernel test robot reports:
> drivers/net/wireless/intel/iwlwifi/fw/dbg.c:86: warning: Excess struct/union/enum/typedef member 'trans_len' description in 'iwl_fw_dump_ptrs'
> 
> scripts/kernel-doc no longer emits the warning that is reported by
> the 0-day kernel test robot, but the reported struct does contain the
> Excess line, so remove that line as well as fix other kernel-doc
> warnings in this source file:
> 
> dbg.c:1732: warning: contents before sections
> dbg.c:1736: warning: No description found for return value of 'mask_apply_and_normalize'
> dbg.c:2202: warning: missing initial short description on line:
>  * iwl_dump_ini_mem
> dbg.c:2207: warning: contents before sections
> dbg.c:2215: warning: No description found for return value of 'iwl_dump_ini_mem'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311250305.tf8Cus1Y-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202312060810.QT9zourt-lkp@intel.com/
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>

Thanks Randy,

I'm unable to reproduce the "other warnings".
But these changes do look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

