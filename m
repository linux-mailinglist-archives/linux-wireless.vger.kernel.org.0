Return-Path: <linux-wireless+bounces-2159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C4831655
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5ECF1C20FBD
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D37208AE;
	Thu, 18 Jan 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+uFSISV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51676208B1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705571971; cv=none; b=SuCuh1Y2WfJALrH6w5UX2FuXkIVIJMknVXuis1frycJT/mynzYOaFzdM4ms0s5EHkCj8DD1u0XxKfaN+cFGDAGyqrIqHvWXXMkdUrry6IEFFYRqbBCS4tOvDjPNa8ANWTiX/BAmkN3jbocghnvB4yArn84kHYSSzn/xZ8LhjdAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705571971; c=relaxed/simple;
	bh=NjX86DlStntu+MJIp3Aa05BuIWnmRXYEJlPsD8DHLkk=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=df0nfN2kKuzImlUYBVX1Wt4k2BV+WEZgZmB92Pztd9XQqYqUqcb3+pvf+7vmTKNsb4xfEVLO6TekqdTSZxsu0260jAmeeteRbGjt15CaAOaNqV2PZ2YZeqxXytQiT9BCYWxSGf8gHdm/uW2ysoxX3/zEnSqJTMezYr7niiHl1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+uFSISV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC4FC43390;
	Thu, 18 Jan 2024 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705571970;
	bh=NjX86DlStntu+MJIp3Aa05BuIWnmRXYEJlPsD8DHLkk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=f+uFSISVW7Oo+Ghtm7izUKB1HHtum3ga+UMnvqr8DccCM0AiOs0xx+NWjooiuzJkW
	 6E5yJncHogBPzgwhMFPwKpm5ld65KfymEMEAjoKEZicO8RpUvRmTtJBqKnZwHBE8L6
	 4PyVewZSFlnDSXmiE3PBnfmu3yBIVcD2giecYR62EGUtMesZ0qHrSwW1z2vXBfy+Zg
	 4EsDBQ4E5GLjCJ9WxQiwwFnI2BOuergRd1ZO5Ebgk8PWT21DWge059xm+tePiSWlEy
	 bjXUJsfiMB5MHDsQ7FjVSqRpGWRXE7L7bXC1UOqLdDqbd3nRRzfCSdTQju3KaDcR6m
	 HLawum+FA86NQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] wifi: ath11k: rely on mac80211 debugfs handling for
 vif
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240115101805.1277949-1-benjamin@sipsolutions.net>
References: <20240115101805.1277949-1-benjamin@sipsolutions.net>
To: benjamin@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 Benjamin Berg <benjamin.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557196818.2861702.17779148994688585657.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 09:59:29 +0000 (UTC)

benjamin@sipsolutions.net wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> mac80211 started to delete debugfs entries in certain cases, causing a
> ath11k to crash when it tried to delete the entries later. Fix this by
> relying on mac80211 to delete the entries when appropriate and adding
> them from the vif_add_debugfs handler.
> 
> Fixes: 0a3d898ee9a8 ("wifi: mac80211: add/remove driver debugfs entries as appropriate")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218364
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to wireless.git, thanks.

556857aa1d08 wifi: ath11k: rely on mac80211 debugfs handling for vif

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240115101805.1277949-1-benjamin@sipsolutions.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


