Return-Path: <linux-wireless+bounces-14245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A064E9A5F01
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B1C1C22E06
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DDC1E25F2;
	Mon, 21 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO4Dax31"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEFF1E32A4
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500305; cv=none; b=VNcpEdvwEq221EKB6LVqkLROelVbDsKrvfxSLg+lkgFeqg2leX4YgoocXUWo/D+JsC4cKgFGj64ZnMoNex/erQKUkR20vGzNebDl5W33dW+QNaldgXZk8rsCPp3OQAxSGimnN9iITkJrCKcw+djWVn45E7dGgeTYS6Uoujum+iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500305; c=relaxed/simple;
	bh=Z531AU+Adzly7NPj2EIT6VlzGOt+N0VIBt+SynIJXQU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YrHBEMKZPe/mtoIRwmbOPkacqaozLkGPUTs4WulRaKJwbn737gGZMkA1A5jqdOqWU/kj3vq+rI8HMeWtb14bsSzRFMoJzR/PydtxOn+YG3lhrZWJI8/DnYDYH5JYJZb5jg02qEsRWDblIDGRSODIcESwUb1Si/eCjKMjVps4MNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO4Dax31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693D9C4CEC7;
	Mon, 21 Oct 2024 08:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729500305;
	bh=Z531AU+Adzly7NPj2EIT6VlzGOt+N0VIBt+SynIJXQU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QO4Dax31rTnlpqpKSyTAC03AodMTerDhGTEFy5Zb++VvS30BJajRGjPC7nzhgAS4f
	 Rx20xbHL4TABjwyO2UwSb6OCnBDkcBw+n6J29a1PTDG1lTa3Pb0v2Qy1LQUBbIyOE1
	 bQpwVSjqTTpomu7PqnbVxz5wR8CX4fIy/egpqcdtRGnwG70/rJenuaMIk8zu3sCIdX
	 xyY8EX2X7GJxG1pHUp9LkZfxdILlYkfneqBnk3Wudso+WCLyjpMKKnOQrZ3ebpcjCh
	 s4FqlyL1xHeMIpNnnqUePX5dyr4jH2CIo13jBGkmgxo+cfsfMMLlcf6/MC7uZfqAwr
	 yxnh0fGnbsoxQ==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 03/11] wifi: ath12k: fix struct
 hal_rx_ppdu_end_user_stats
References: <20241016065700.1090-1-quic_kangyang@quicinc.com>
	<20241016065700.1090-4-quic_kangyang@quicinc.com>
Date: Mon, 21 Oct 2024 11:45:02 +0300
In-Reply-To: <20241016065700.1090-4-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Wed, 16 Oct 2024 14:56:52 +0800")
Message-ID: <875xplrgj5.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> Current struct hal_rx_ppdu_end_user_stats in hal_rx.h is not matched
> with hardware descriptor definition.
>
> So update this structure and related code.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

What about QCN9274? The commit message doesn't mention anything about
that.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

