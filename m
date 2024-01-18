Return-Path: <linux-wireless+bounces-2172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFE831872
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4121C2269D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2123F241E9;
	Thu, 18 Jan 2024 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muLUC8KT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FEF241E6
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577318; cv=none; b=kdfbBhUOC6UzZIloPlrioxTNx6JoE+hryzia0Sqzk6CuOzRHjIiUAe62px8+5ajZnLmM+dxrE/kaQ4Gs0REoB8euLAJTPCxYXlxMsjHQOd3K0fw90/fi/CloI8ZiqcCHjmx38VJVf+Qi/kGdCpVIy3C5ko6oNPeKgdvJCKU5PUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577318; c=relaxed/simple;
	bh=Vv4gO40NswEfGxLw1AeTJ1J7Eheq6UZCHHv/gjX5ptQ=;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:
	 Cc:User-Agent:Message-ID:Date; b=KdgJcv3AXixFanBn4QJAn6LTt/u5WlsF3FY6pTKQqUD7iBMlyT179/4N6Qe24tDvx5U4Y3MgFVJNMdEKJfyERgPTV24R4Jqg/6qhdSb3yjyKRCCGog0gok1c0PIWRUFqHaDO+ie5QZVQ39KsJIwoWSU2JN3/7sjayW5rGgA2ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muLUC8KT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8117C433F1;
	Thu, 18 Jan 2024 11:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705577317;
	bh=Vv4gO40NswEfGxLw1AeTJ1J7Eheq6UZCHHv/gjX5ptQ=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=muLUC8KT3qjvGyr1PCl5c08sNaQ9vlLHMcTCkRY3rNrQFmCfmRVFdWgmnIcVCMnV7
	 tv2jt1bX4fxIgO6MBd17Asv3yDHFdnv/Ze8+S33Flmzjso5PaXP9Xjzs+y3xu5mZ5c
	 efPKdikJRAj8Tzq2glttlNQ0jR0eE5ceTSA3FepkQXlcjYxT2zG+KhzjqgqoLS4cu6
	 IcIHr6vQzrWP6X0IwF0UITX+2nvTDvxqhUBV4d3qg+Gxp2UgWdvQNtGIOkEoZbwGRF
	 02a+fgHdGYysRUh+PDsj7RBlRgA6GdD0g9YQunMZGYILhSGt0LbAn5CVR7jW86O5td
	 lCqrjPGjgnsRQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: brcmfmac: handle possible IE flags reset error
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230919051130.16316-1-dmantipov@yandex.ru>
References: <20230919051130.16316-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arend van Spriel <aspriel@gmail.com>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170557731410.2924528.3253975172105424732.kvalo@kernel.org>
Date: Thu, 18 Jan 2024 11:28:35 +0000 (UTC)

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> In 'brcmf_vif_clear_mgmt_ies()', check for possible error returned
> by 'brcmf_vif_set_mgmt_ie()' and issue appropriate message if needed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

This should be tested on a real device.

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230919051130.16316-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


