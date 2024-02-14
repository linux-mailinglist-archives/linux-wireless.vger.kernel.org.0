Return-Path: <linux-wireless+bounces-3571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C998543EE
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 09:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7305D1C2206C
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Feb 2024 08:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C32911CB6;
	Wed, 14 Feb 2024 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stdh3swJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794C11CB3
	for <linux-wireless@vger.kernel.org>; Wed, 14 Feb 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898708; cv=none; b=Km6a9pkKRUHYvaruvL0EqJ5DfxNlO5iiUPNGg0SdQ1V8U0U9gTtbrhiViq7bRVTgHMIq+DVeK5AMxhgbp6a7AhhiEfb1Wi8+d9vHos3pWbTOfGUlK/XK56BMekQVZvOWU4C1SooiKhWUzb6KDuBw3cSMDW/kKJbvBHuz/v/gHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898708; c=relaxed/simple;
	bh=+Oc4d0hrSU+ykNe3Rn2eSnzEHmjg3VroAHmjLC2mChU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Hiqd9WtPJ70yycv/ZqOZVae5CBaj1ePP+nrdt+2sesw9pSRUC0bMw6yDkEagwVlVkgrrnATnDUSdGFse7sxtakv7q30Fj0kW9yJAXaMSqQxeJWt3sEnplmbYSKG/wmx9P3CiaWk+SCLK+ak7aOUEdLoq1hmCFIQUfUYIGvse5BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stdh3swJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18C2C433F1;
	Wed, 14 Feb 2024 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707898707;
	bh=+Oc4d0hrSU+ykNe3Rn2eSnzEHmjg3VroAHmjLC2mChU=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=Stdh3swJmUwGHg1QtmyaQ5GIJd2kvpc8u2CWKLF+Z+8hjSBatPugQig+Z6ZFjS/ZV
	 s8SEItvAJOq37nigd0g9L6Reag7TMQjIQfLbNacyB/dzog3b64a0BvpQicIIwqEdxn
	 xur5T7okndIBUHMqDYS6/mLd8A5okITmZU/8qVJb8aq8VDLdTER6EWfTlsHzrAaEpE
	 3gUp3wzin860X95myo9Z6W2qU5+m8TfunR6n9ainxcV2oZgyeMKMmpRQA52FFmBxYv
	 lViAPlrKAVT8ZtruEcGSYlgGG7nsw8lojsCyM5V/uEW1g368lIohatFCMRx2YWc38q
	 vkcgi7Lg3H4kQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: remove the unused scan_events from
 ath12k_wmi_scan_req_arg
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240211151104.1951418-1-nico.escande@gmail.com>
References: <20240211151104.1951418-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170789870464.3088943.17592714420741852160.kvalo@kernel.org>
Date: Wed, 14 Feb 2024 08:18:26 +0000 (UTC)

Nicolas Escande <nico.escande@gmail.com> wrote:

> As done for ath11k, lets keep on cleaning up struct ath12k_wmi_scan_req_arg by
> removing the unused scan_events. Also remove the underlying union & struct
> construct as it isn't needed anymore. No functionnal changes.
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f0024c980df2 wifi: ath12k: remove the unused scan_events from ath12k_wmi_scan_req_arg

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240211151104.1951418-1-nico.escande@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


