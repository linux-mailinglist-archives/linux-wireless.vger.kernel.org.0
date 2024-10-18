Return-Path: <linux-wireless+bounces-14216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D809A4334
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1198EB2233D
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4C1FF5F7;
	Fri, 18 Oct 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEUqSiD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289E1200BA7;
	Fri, 18 Oct 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267588; cv=none; b=q5zaik0GagXWC7qMeAP55OWrSDRVM93FB8ZvtGMgJOn8CgGi442XfUPx3JfkD7i1G+m+2c3uVtmyl2Q80tutInwaN/KIc/ZQok0oF+wZiTb/7bTyhjYj2fgtM1ZoFKDx+QBd/jqSBn0g1S2vBc7JZK9z/rLLVGNJVn40FFQfN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267588; c=relaxed/simple;
	bh=frpbhLCtTqARwfQhJzhko6+ywQrWX/+qdInOe/0EFXo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FJKfqktx6CC7W+YvNJ/ebwXnrBxfzMEBUYTQnL9C8oQUBgA/YhKPwrQJ9mXIXzTx4g/5+w9CwdWmQK0PG6HVNdmbZPNRaqVvvcFhuWW/QcnCMj9+1yEKAK1wRZ+u+sYUKLSh45IYGRKENEELCRqWuiVOltFp7mMC+lAmcDlaHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEUqSiD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB8FC4CEC3;
	Fri, 18 Oct 2024 16:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729267588;
	bh=frpbhLCtTqARwfQhJzhko6+ywQrWX/+qdInOe/0EFXo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nEUqSiD+rWJUxUnNRJ/6vr0rUVG3ZS76yZE15XSpoLkfOENhl0zaPbAl6dyFTVhnR
	 ttIZNPxTNME1Kaymx8hXv0YiGzcfz5L3dGvcqq0Xxn4QexWyt/4T2PVS/cXL7m3FAy
	 JeSf8P+nO98Uh8WCwnkBhsdbzxFr6otxY0tAh2W3e90u+VBvfNXCCYOb76ARtYfXMp
	 n+eLAkJOEnUMwwelzrAkHUK8s/OqYnM7A/POUVN89rmd7GGz5JEP9cMhyDbQMZWAPH
	 j/wI65VLDm9R744oOy/v+Lt5eMPBVWrasWG7zSjwSw8tEdVDDI2Ug45YwrQ9CoqE4B
	 rQyJnCzmKXHSg==
From: Kalle Valo <kvalo@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,  Arnd Bergmann
 <arnd@arndb.de>,  Johannes Berg <johannes.berg@intel.com>,  Emmanuel
 Grumbach <emmanuel.grumbach@intel.com>,  Gregory Greenman
 <gregory.greenman@intel.com>,  Daniel Gabay <daniel.gabay@intel.com>,
  Benjamin Berg <benjamin.berg@intel.com>,  Ilan Peer
 <ilan.peer@intel.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iwlwifi: work around -Wenum-compare-conditional warning
References: <20241018151841.3821671-1-arnd@kernel.org>
Date: Fri, 18 Oct 2024 19:06:23 +0300
In-Reply-To: <20241018151841.3821671-1-arnd@kernel.org> (Arnd Bergmann's
	message of "Fri, 18 Oct 2024 15:18:34 +0000")
Message-ID: <87a5f1qtts.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This is one of only three -Wenum-compare-conditional warnings we get
> in randconfig builds:
>
> drivers/net/wireless/intel/iwlwifi/mvm/sta.c:4331:17: error: conditional expression between different enumeration types ('enum iwl_fw_sta_type' and 'enum iwl_sta_type') [-Werror,-Wenum-compare-conditional]
>  4331 |         u32 type = mld ? STATION_TYPE_PEER : IWL_STA_LINK;
>       |                        ^ ~~~~~~~~~~~~~~~~~   ~~~~~~~~~~~~
>
> This is a false positive since the code works as intended, but the
> warning is otherwise sensible, so slightly rewrite it in order to
> not trigger the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Is this and the other rtw89 patch for current release or -next?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

