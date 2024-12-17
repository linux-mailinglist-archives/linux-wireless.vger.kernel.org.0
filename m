Return-Path: <linux-wireless+bounces-16502-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A419F573F
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 20:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2E7E1635D9
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 19:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6551F7074;
	Tue, 17 Dec 2024 19:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIoqh219"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBB7148850
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465354; cv=none; b=g7Vr2XVl93S+B71LJrMSrPKm9xd3+b81qAW0my18XS0wHIVOskQw0KtdieW/NLd/XyoMoU86F5GMsbjV1N1WsEqHhkMcr4B9wgqW3+Xk8fYHzKtiomMlrJSBFBrPhYGvd6KDp75NJia/wBbQ9XAgxdDeQ4oH4m1bRjvQ21+XZyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465354; c=relaxed/simple;
	bh=TYTlRh42Ds3nm+yPIRcHEzgRHFbUoen/POXu7Xcy0l8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FW2/eKqtitWUby/oFiZJEZHt6UyfidblReE/94GqSHh3X1I3vx4wCpqYcPAVSTmhUk0nvUyhK/feQ9IOxFX3Qfrjv6F/ywWoeUHb8W2Ze/PCpDvb3Ae4YNhmXoHHtyx9ojZETOpXXrAOCZmx1Qp1cF2DQ7UskjCOwOGTmmdqzME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIoqh219; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D68C4CED3;
	Tue, 17 Dec 2024 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734465353;
	bh=TYTlRh42Ds3nm+yPIRcHEzgRHFbUoen/POXu7Xcy0l8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZIoqh219qSIITtkhf/DRBQBhAk0StZzfL0Es8LEZkfdNO9bFXPRhBVErSNnVN9L7H
	 e58InBc38rMg21ljzOTglbuHnx5EoLuMfw3LfiYrpv9lLBchDmfqhq+z3bKH9pbLPs
	 2vsCLYhyKG/86CkUdQ5d+bnZc9W9Yu9PGz1cYpKw6mwetFOL/3VyATiZurAkrCfr+r
	 2Z60NVCHJOlCmpgbk4IYwHxH28+itUxyRBmf+BAP0vLPjYms/PynRQMIO/mD7Pao6T
	 Cb6O53yFZ+WJ6jVhHb0aocH/P3PQLmJeLncIkUPs1IGRRBE6nFcWqL4ImabNUsUZqn
	 WrlTynOy1Ijqg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Jeff
 Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH v3 8/8] wifi: ath12k: Avoid explicit type cast in
 monitor status parse handler
References: <20241217084511.2981515-1-quic_periyasa@quicinc.com>
	<20241217084511.2981515-9-quic_periyasa@quicinc.com>
Date: Tue, 17 Dec 2024 21:55:51 +0200
In-Reply-To: <20241217084511.2981515-9-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 17 Dec 2024 14:15:11 +0530")
Message-ID: <87ed26jd88.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, monitor status parse procedure handles all the supported TLV
> tags. Each TLV tag has its own data structure for parsing. Now, this
> handler is passed the tlv_data as a u8 pointer, so explicit type cast
> conversion happens for every TLV tag parsing. Therefore, avoid the
> explicit type conversion by changing the tlv_data type from a u8 pointer
> to a const void pointer.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Nice, less void pointers the better.

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

