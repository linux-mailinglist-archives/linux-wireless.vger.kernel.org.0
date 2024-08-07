Return-Path: <linux-wireless+bounces-11083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241794A787
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 14:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C224BB27ABF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D11E4EF5;
	Wed,  7 Aug 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1aD6IBV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51C1E213B;
	Wed,  7 Aug 2024 12:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032628; cv=none; b=kPYue4P32DISUsAkOqxq+iA2cZuDbIbkZqc0bnElcGi2e8KQd0IY2fsFbwzrhBzRwbBQsCNVVRgHnkmtD5rDJQNHrax7ggDtn6Q5l4iZ7tBYqhF1igRQQ5lafHWhy6RK9UE2tgMgAT1c5Q6x+bEPuXPKkhBtpOLZyZpr40uwtQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032628; c=relaxed/simple;
	bh=QDI/jTQQV3xWSMwg8X/3NzFiJJOYjWjJGJDXnffRn0o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IAhXPU84I/FGR1vVpO4xMbS6Zfht7Mooqn+lgkkMU6k6KoTLZg6S22eGRdIBhvIvP8cBpWoL8y0WyT2Zf/eGXQ3c5acdSn/Swldu2bgXNgOLXpiHN7d1++Bwg55vkPRAJebAfHlKkWBgZj5BxmrwiDfSwPVto8Xr+DrCZxuzJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1aD6IBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3500C4AF0B;
	Wed,  7 Aug 2024 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723032628;
	bh=QDI/jTQQV3xWSMwg8X/3NzFiJJOYjWjJGJDXnffRn0o=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=g1aD6IBVlFmSrRzIPeDd3lXoYgByDCjaKNG6kWtMWiN821pJiv/mpzKbSSkxB8s5x
	 3v8stwCHCbqy2WYNEa4P5FJBz+FR4N9JXGbGL5qtjhAZ/FtwmA3/xTZIQAHAK2Xz4P
	 oxIu5fmMPT0ffoHn7BY7ofjnzJELg4722M+KA/ehbZ2dqGOBg+1jWQobD8uU3LLNUL
	 hQAJI0hvY3Ovple9J0gYlaAXJDZWxtFbjW8H2lSkKZROZ8b2c9b+AtmFlhrUPCERV5
	 Gq+lxlCV816+4BONxUPb9jBcoeCc+yE+1FAGB16g9MlUm/m4g+G5BgS8vEOeDMSSvB
	 NkfW4Jx8dp2fQ==
From: Kalle Valo <kvalo@kernel.org>
To: Chris Bainbridge <chris.bainbridge@gmail.com>
Cc: linux-wireless@vger.kernel.org,  benjamin.berg@intel.com,
  miriam.rachel.korenblit@intel.com,  regressions@lists.linux.dev,
  johannes@sipsolutions.net
Subject: Re: [REGRESSION] bisected: iwlwifi: use already mapped data when
 TXing an AMSDU
References: <ZrNRoEbdkxkKFMBi@debian.local>
Date: Wed, 07 Aug 2024 15:10:25 +0300
In-Reply-To: <ZrNRoEbdkxkKFMBi@debian.local> (Chris Bainbridge's message of
	"Wed, 7 Aug 2024 11:51:12 +0100")
Message-ID: <87le18ile6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chris Bainbridge <chris.bainbridge@gmail.com> writes:

> I hit the following bug in 6.11.0-rc2. Reverting the offending commit
> fixes the issue. This happens immediately when I run `iperf3 -bidir`.

[...]

> [   42.873868] ------------[ cut here ]------------
> [   42.873989] WARNING: CPU: 1 PID: 529 at drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836 iwl_pcie_get_sgt_tb_phys (drivers/net/wireless/intel/iwlwifi/pcie/tx.c:1836) iwlwifi

Does the connection still work after the warning?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

