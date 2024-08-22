Return-Path: <linux-wireless+bounces-11783-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D0F95AE54
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 08:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACBA51F22FB3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 06:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099813A885;
	Thu, 22 Aug 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMh67uhm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F2433C0;
	Thu, 22 Aug 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309979; cv=none; b=BMwauaxyGilNQOoWa0H+TKRiDOFZCP20JN7xCYUddELEnY9IQksaAlMX9tXSqOBcc1fqfXLb9Qr3+zUzJIsZK8eEXRtkzDQ8fSSG6mYRI7pKSDCEPGRuUaU9I7XHMyeyvtM9Kz1RA2Fe57+A3vqY2r8JXjC5Nl2BIkrCkWpWszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309979; c=relaxed/simple;
	bh=2qZ/xyt22ragi8wSuwhm2UcSOKI5NzMeXCDrpL6eQzk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WCnnwAUpKgopoqDW/wKrL5E4cJzvC18XWbQDP9D5J6vtz/dFlDHzFyuyjGGm3qJ34pS0OtfVA+1081r83sR2LA8MDWwe7pi0VOyeDViS8y3AcSbYlpOqua/Y0qtcYAYzqJLv/no0pukbZzVx3HdFoEQLQw9qu6KCaBKO4XppCBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMh67uhm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F87FC4AF09;
	Thu, 22 Aug 2024 06:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724309979;
	bh=2qZ/xyt22ragi8wSuwhm2UcSOKI5NzMeXCDrpL6eQzk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iMh67uhmlpaxip8cyftA1iQu6RPl2Olb8RZpWNLJdLaBvntZ8a8H4KjZ8q967Rsnw
	 CdzHGAZfJLP/azhbB22yMStrbcD44xuaKUcLOrxHI0/+S1oSyjGz4ZAkp0nREq+l+j
	 TFBKhurOfYNaA/7cWGJeEtJ2eeTJ+ASkzaFHY5GuINWVEx0RuK9EaJQlfY7YyQtKV1
	 Jdzdu3Pvq+0dqPDePDshOFOaEmcfVENimeBsPLcbtHP3D64UXG6jM7a3VlYxilXEpL
	 CmLtZypcBJxC51/T0TaL8DsJDeuH+eZniQp0YvLBZwajWi0nTzQf9YvKiLOqaohj7o
	 Kt1jm49IV7qtA==
From: Kalle Valo <kvalo@kernel.org>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  opensource.kernel@vivo.com
Subject: Re: [PATCH v3] wifi: cfg80211: Use kmemdup_array instead of kmemdup
 for multiple allocation
References: <20240822024242.1203161-1-yujiaoliang@vivo.com>
Date: Thu, 22 Aug 2024 09:59:35 +0300
In-Reply-To: <20240822024242.1203161-1-yujiaoliang@vivo.com> (Yu Jiaoliang's
	message of "Thu, 22 Aug 2024 10:42:42 +0800")
Message-ID: <871q2hgi08.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yu Jiaoliang <yujiaoliang@vivo.com> writes:

> Let the kememdup_array() take care about multiplication and possible
> overflows.
>
> ---
> v2:
> -Change sizeof(limits[0]) to sizeof(*limits)
> -Fix title prefix
>
> v3:
> -Fix R-b tag
> -Leave --- above this information
>
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Now Signed-off-by and Reviewed-by are in the wrong location. Please
carefully read the wiki page below how to submit patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

