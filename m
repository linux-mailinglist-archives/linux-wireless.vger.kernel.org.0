Return-Path: <linux-wireless+bounces-3555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60968535CA
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44D25B2971C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Feb 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470E5F48A;
	Tue, 13 Feb 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBDiVsLP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB15D91C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Feb 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707841024; cv=none; b=ffuf1R4vBvcoGVh5i3wqrsD2ujGnuuYTYHujTRtoD3PBnwMcTEHMbl9SXTKlxkFLe/KcTaUXdF+8CJXzRHNKj7vU6uDgVIpMDZdQwezJx6E23Up3YnbNnyFPqLOCPGM02ET1BcJUmINZ8ez2UDm2qFJW1NPkW8jDrYY9WLmBpAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707841024; c=relaxed/simple;
	bh=U1hlxuuGM31EsFxR96p8z5hGYfThQsiQscHYRLeJkRM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CRkHOpEdX9tVXDWZNvoFd43cEOczIde1gf2QniFPVWnPkF9Or9sVQxFLajlnMiDsHGDrIAVuCCB0lKGX2LkVztKQ3YFu8uzmTtkhAu8dF7TSdG/+jiVM1j+d0Qa+NBK61+8iujcb5u6AsrcGRZp9zTLlBxGOqTr4r/1moVdNKfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fBDiVsLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D32CC433F1;
	Tue, 13 Feb 2024 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707841024;
	bh=U1hlxuuGM31EsFxR96p8z5hGYfThQsiQscHYRLeJkRM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fBDiVsLPvXkglEu72avpNr59iWLOAb3NhQ2REWCeQGlyJdrfLppRy+PqYS3GMSrVL
	 QTN4ULOuXcNhfC4qwTw0x6EvGkr45sTcreQ+fUBbUqypEaASXKeCsBAVphqXMplhmz
	 3MXoopb2hJVPvWA9BRaaa7wIeWUkIHwWowvEhEqzqG3nXE6WJUGfeKJ2ccA6hhC0TW
	 e+ZptPHuo/ob9iMi5E7uZE9YcCexyMZ5UgY5+sPOKdzyDFWkYOgTla2mv5xG/QQMe7
	 /hilfIMXPbC2YZXRoUAWsmZTTBE+lnTGzqkDKN2YPVxj3it5RobKwmpsX056ye9rVj
	 rttm8MJutH3cQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
References: <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170784102087.3076911.1922636810071020971.kvalo@kernel.org>
Date: Tue, 13 Feb 2024 16:17:02 +0000 (UTC)

Carl Huang <quic_cjhuang@quicinc.com> wrote:

> Add hardware parameter support_dual_stations to indicate
> whether 2 station interfaces are supported. For chips which
> support this feature, limit total number of AP interface and
> mesh point to 1. The max interfaces are 3 for such chips.
> 
> The chips affected are:
> 
>  QCA6390 hw2.0
>  WCN6855 hw2.0
>  WCN6855 hw2.1
> 
> Other chips are not affected.

Sorry for delay. I have now added this to the pending branch, there was some
simply conflict which 'git am -3' was able to fix on it's own:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=43b8e99e19e8126e113eb9141621cf7e4b32d4f0

> For affected chips, remove radar_detect_widths because now
> num_different_channels is set to 2. radar_detect_widths can
> be set only when num_different_channels is 1. See mac80211
> function wiphy_verify_combinations for details.

So removing radar_detect_widths means that DFS will not be supported on the
affect chips, right? I think I should add that to the commit message.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230714023801.2621802-2-quic_cjhuang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


