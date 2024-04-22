Return-Path: <linux-wireless+bounces-6648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC88ACC75
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10EEDB21B6F
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235D1465A6;
	Mon, 22 Apr 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8Bp1lz/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E01311AD
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713787611; cv=none; b=EI68wyz59sEN6Z7CeTF8LAcHdMFusLshlm+DRKi6yAspp1Bjj+qpnD29eNXBaRJmY5Rz0qV5IvC7xqxCv1L9l3oWqDep6Njwqb33J1wwrsX+KSvwBIl81+gMZcIj6rsPQvQaGGoY6vGMf6BrGdkoL+StRsPAOZ+rkXU+7ElX94Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713787611; c=relaxed/simple;
	bh=vALtas8Ie8tYQHKOrKFZueYSxtZc7LSpUj9elN4mV3w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=PCVUeXzjt41920zSxpVu5l71J9L2WMYU5lfrfoEOl5cBg4UEN3NtTheWMhUSUUBzqWMc4xQIn6MMxLfwBq3PgxCS7YtZva3MItkd5eIehKSSK06b+2ohku3GHHfFKwzN8aE8ZqO3HLxFzLvbGWnwMB+t9N6W2jBYVXBapgDzWdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8Bp1lz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB9CC113CC;
	Mon, 22 Apr 2024 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713787610;
	bh=vALtas8Ie8tYQHKOrKFZueYSxtZc7LSpUj9elN4mV3w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=B8Bp1lz/aEWjgCh30IyuZb4Kcs0ZB9B3tDnLqbjmVbQUfpZtNHhJgHiC51zIKfLn6
	 1OE20tj08IRFZdVLjL6t69HOkFqkJpW9HRUo8QT8Er1PhwDSekRsFRs+x4yUWDyg6c
	 yFf4MaeeYsfgt4G0zT0StGPqa2kehOBFu63ttUR0S1rV7gREvuV9afrTl7Gvj9w2Il
	 hw6EC4/23uE8Q25QaPetQThGm7rWhP/+QnuHJPWSjhkBkec2YB++u4dBHBIja/6dQi
	 BHZgebDQYm7okUgjcqps8ceJM1foznnVylw6DMaSIgn1tdBZdbZxaqVth0g6QKjBvr
	 5axzNtLqFTo8Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4] wifi: ath12k: avoid redundant code in Rx cookie
 conversion init
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240411102226.4045323-2-quic_periyasa@quicinc.com>
References: <20240411102226.4045323-2-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>, Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171378760774.1358009.4155348032452693062.kvalo@kernel.org>
Date: Mon, 22 Apr 2024 12:06:49 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> Currently, in the Rx data path cookie conversion initialization procedure,
> the primary page table index (ppt_idx) is computed within the secondary
> page table iteration. However this is invariant, and hence the ppt_idx
> should be calculated outside of the iteration to avoid repeated execution
> of the statement.
> 
> Found in code review.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

4 patches applied to ath-next branch of ath.git, thanks.

3ea19127d154 wifi: ath12k: avoid redundant code in Rx cookie conversion init
b3e9e82b31c0 wifi: ath12k: Refactor the hardware cookie conversion init
682ca418d40a wifi: ath12k: displace the Tx and Rx descriptor in cookie conversion table
d4e3fc4f45c6 wifi: ath12k: Refactor data path cmem init

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240411102226.4045323-2-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


