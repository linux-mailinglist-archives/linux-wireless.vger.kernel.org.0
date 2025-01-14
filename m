Return-Path: <linux-wireless+bounces-17502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3AEA1100B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7C5188B3F6
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 18:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83751CB501;
	Tue, 14 Jan 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGQn2wEj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B751465AC
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879311; cv=none; b=b+ZB90unSXcGVYCA2KMgAB1H6YmWbDT8PqBeMqLYsl+bhv7Us6or+pC3kxyXhON3OL7dX42h2s1lhezs9lAgqieDOS3dmT1NuuZlDkMj7PwhbPRae8m/iQHHgdu5JYyJv5qZ/L/EG9dlxUfn4OWxJ7H9863wIqq4tnRlLOVSFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879311; c=relaxed/simple;
	bh=WOY4AGPayNCfR8xPWYGzZU8DRPDN3/lPA1u+hsfXMts=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ETk/BHpcIO8bvJ+e1I+VjwpbT+YLK3Wfm0kRSQ72h58o5sI85JAb2xMur8RcXVi7sRgTnX9C3e4iBX+TbS5QqljX6v0LI5HloNMninBavFKnN6qkh/qx1bdHERxfNKnuzcvQkZDJo3HMzvLiYgChgBrpkUxBfWnX/igIhn5c3ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGQn2wEj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7441C4CEDD;
	Tue, 14 Jan 2025 18:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736879311;
	bh=WOY4AGPayNCfR8xPWYGzZU8DRPDN3/lPA1u+hsfXMts=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jGQn2wEjtVcKWRvODJf4C7GHXI2/xzIs2PbVZMVIxzHdFYDT0b/t6OR3mB/eMOwL0
	 PeTh60xa7c2VOu5L/rkYwS9O/NtM4KosXq0ZF38ufm76EUrakME1WGkt8Xhy4/Xhws
	 4zvr+FBZILRRa/Abw+cwmEcgQTndDfvEIsmO+jW0VgQl73bP99mfsLNH8HZloZCaye
	 i/zlA2uAb0oySy0sClv0gnPpPAABX/UxCuqreC7dqPXk+NZSSp2/6f09cgEmLviO+H
	 7z8g1Q/eHLpyPx67FltqBNGy9zN+sM7phBgKy57Bq/20txatJuTTI98dYFwD3AdVGo
	 89NQttngDrJxQ==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/4] wifi: ath12k: Refactor ath12k_hw set helper
 function argument
References: <20250112071630.4059410-1-quic_periyasa@quicinc.com>
	<20250112071630.4059410-2-quic_periyasa@quicinc.com>
Date: Tue, 14 Jan 2025 20:28:28 +0200
In-Reply-To: <20250112071630.4059410-2-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Sun, 12 Jan 2025 12:46:27 +0530")
Message-ID: <87plkpp7w3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, ath12k_hw is placed inside the ath12k_hw_group. However, the
> ath12k_hw set helper function takes the device handle and the index as
> parameters. Here, the index parameter is specific to the group handle.
> Therefore, change this helper function argument from the device handle to
> the group handle.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

