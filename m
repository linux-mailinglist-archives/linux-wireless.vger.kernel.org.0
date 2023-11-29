Return-Path: <linux-wireless+bounces-212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCBA7FD597
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 12:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C200282FB3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Nov 2023 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB331C2A3;
	Wed, 29 Nov 2023 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX8gLQWy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1670156CD
	for <linux-wireless@vger.kernel.org>; Wed, 29 Nov 2023 11:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8A4C433C8;
	Wed, 29 Nov 2023 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701257189;
	bh=C2g/NoIOeJ82J2MCFOfvwn8dCdNu1Honw/rWebiTskM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=IX8gLQWyt9mzZHtGiOkC0ikLxq4s02xI23hf1qNGl+1WpvXy7tuLeNA349EXa70rK
	 nXO8pO7j/ugs7wrHNvOXAUvgMkTn7PNqF/46cZJVePcrVJAj5Kh/e8pC1fqavw1ujH
	 ukpfqb3ysB0bcqvBY1W3mj1YfaOceGb+zoBXP2UKpynUFDM/aso30/oG7kepfCIob3
	 FdDABbCCmU2WnYMM6xYCFiaca5WWHPibY8V7HjLGNQcN8LrXB/rx89pEPaK0K0J3DT
	 GP2PCFvvrIdao1K33XYZcVk2uDHepn9hMUQAceoowTPFGThYd4JuB35ZCD/Ov9/X/G
	 RRDTKLzaXcVow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: fix the error handler of rfkill config
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231111040107.18708-1-quic_periyasa@quicinc.com>
References: <20231111040107.18708-1-quic_periyasa@quicinc.com>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170125718623.1070846.8149698389070338560.kvalo@kernel.org>
Date: Wed, 29 Nov 2023 11:26:28 +0000 (UTC)

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> wrote:

> When the core rfkill config throws error, it should free the
> allocated resources. Currently it is not freeing the core pdev
> create resources. Avoid this issue by calling the core pdev
> destroy in the error handler of core rfkill config.
> 
> Found this issue in the code review and it is compile tested only.
> 
> Fixes: 004ccbc0dd49 ("wifi: ath12k: add support for hardware rfkill for WCN7850")
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

898d8b3e1414 wifi: ath12k: fix the error handler of rfkill config

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231111040107.18708-1-quic_periyasa@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


