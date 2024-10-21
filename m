Return-Path: <linux-wireless+bounces-14248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BB9A5F0D
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151E71C20159
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFDF1E130D;
	Mon, 21 Oct 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2ejQqu1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E911E105F
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500479; cv=none; b=DjtZL2nIm2IHMvC8TAGVJ5fNsixqapFHqMYRqQS66/3svrMakC5UVgDXovETr6BC2j++1lVFWv8w2w4pNGX33S/reoZDheymI+LVqOhV44pKeS4udb05svqracE0DuQwlAlwX+PPV/pd0arndwkU6owzOZE+Pzk5hw3GuxO+cYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500479; c=relaxed/simple;
	bh=cNwlbFurWCK9ZSSwu60b/PoTHLWGOoTV9tFHS1xUCIo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iJkntNmf334EVg2JKVegAUf8vlY7bcsFitExw78shyJlHtYuaHwXKK0Nbs1pNZdmyJpMFAawUcCtYELqIPACF8G6yIuCQDZtNiqc+nS9OUb0RXb8/Nx+wVBZuVoQ22P/R6v98x7buzf6/YGAwX7UYRBGaSYn+j8hif3uniiAXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2ejQqu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37EBC4CEC3;
	Mon, 21 Oct 2024 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500479;
	bh=cNwlbFurWCK9ZSSwu60b/PoTHLWGOoTV9tFHS1xUCIo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=E2ejQqu1tEQfpK4p+T7d1yHXpF1S4Am3sFToz+5yeVbKmDEzxprYvkpwv4fiaFuAw
	 kJzwt06Iuw8goC9niaUn1fl0i8qlEYann53cU+nrJGlSBCN2fztKtXn4QOZTlYczeA
	 BcKNGP0r530CB55p3CJTBmX9l4DQp4rH3dpUCcGttg7y74tyt4NnJB3xt+SmbsAYaW
	 nXFb3GJcg8TeSBbTpLm5LZV7Seg+F5+1zFSailXoXLNcTWrmIqn53ZigITng0lKZYY
	 OmQUjd+/rsWFq+Ej2dRG0uklrFUAdI5Ck7MKUTTdOioDTE37swnhmWI83ffitKm84G
	 gw6UsPQWky0oQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] wifi: ath12k: delete mon reap timer
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-12-quic_kangyang@quicinc.com>
Date: Mon, 21 Oct 2024 11:47:56 +0300
In-Reply-To: <20241016065700.1090-12-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Wed, 16 Oct 2024 14:57:00 +0800")
Message-ID: <87wmi1q1tv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> Currently mon reap timer is not used, and it is not needed anymore.
>
> So remove related code.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

Same question, does it fix a known issue or is just cleanup? Always
answer to the question 'why?'.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

