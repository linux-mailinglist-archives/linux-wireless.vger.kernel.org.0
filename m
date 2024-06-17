Return-Path: <linux-wireless+bounces-9117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4790B1EC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 16:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8751C204AB
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9650019AD7E;
	Mon, 17 Jun 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kmnw4KwY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D8198A22
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718631806; cv=none; b=uFibXweR993g6LKYo3yE8e3B1W5sIHQQLmIrVm1wpkhZtl2/Ei88dyx9pWKCMcHUbVyMhUcyjKQIMfjsktrNXzGJufpgXORp7FHZcnJDiZW+Pn4P7IjAb2BmIBM6NnjoX/qPkdSPNp/KlQim4Ye+Utu7c9gBisnxACrK/YIuxMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718631806; c=relaxed/simple;
	bh=/QgzJzbG+aEkoSnSmwQZl/Am2miS1ZCWALieAysez/g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=s+wMV/SovLS+exspcyBt4TEZuo+A1bmA9IKp1dswLEOV5c7Ctz/I4t1XoLy1SBIAXms+ZiZPSHJ8H2Gp67aIFRGme/GCDAvMPW2mbrwLACzaRJoJqvg/6+sPRQ15RTW84x3e36eataxlbbuzPYxO2MSEVDGNi0j8trK3SMPMI6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kmnw4KwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26219C4AF53;
	Mon, 17 Jun 2024 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718631805;
	bh=/QgzJzbG+aEkoSnSmwQZl/Am2miS1ZCWALieAysez/g=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Kmnw4KwY7FBylUp4MsGLdUEr9lRqvdYkuBCbBOa5U4uaGNMZjRP4hJoh986t4PED6
	 t8EmrHb6l3sauOBfkFFy46Gf12YB/oAvfCJ3F0wWSH/jDgi/RNbWHay82WRYCRvaR0
	 foB4Z8FXhYDcI5AhFp+/KVu5lZbnCeFsryCAprTE3tZsfJJ69FJM5B2xo7JnseLJ/0
	 lIQMacznu+R8ia+UasXvlbUpsatwVYdSyZ3pGhYnIa1fPqolUBrXiF3oA4NmHv78CN
	 Pgx0jP7vpYtoxuaxnF0095PjfbqbUpBQAosxhkg6/BXUTIJemtk0Y4fvKKgc6c73NK
	 dXQhPwL08EZCg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/8] wifi: ath12k: implement WoW enable and wakeup
 commands
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
	<20240604055407.12506-3-quic_bqiang@quicinc.com>
Date: Mon, 17 Jun 2024 16:43:23 +0300
In-Reply-To: <20240604055407.12506-3-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Tue, 4 Jun 2024 13:54:01 +0800")
Message-ID: <87msnjn0qs.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Implement WoW enable and WoW wakeup commands which are needed
> for suspend/resume.
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

[...]

> +int ath12k_wow_enable(struct ath12k *ar)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	int i, ret;
> +
> +	clear_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
> +
> +	for (i = 0; i < ATH12K_WOW_RETRY_NUM; i++) {
> +		reinit_completion(&ab->htc_suspend);
> +
> +		ret = ath12k_wmi_wow_enable(ar);
> +		if (ret) {
> +			ath12k_warn(ab, "failed to issue wow enable: %d\n", ret);
> +			return ret;
> +		}
> +
> +		ret = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
> +		if (ret == 0) {
> +			ath12k_warn(ab,
> +				    "timed out while waiting for htc suspend completion\n");
> +			return -ETIMEDOUT;
> +		}
> +
> +		if (test_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags))
> +			/* success, suspend complete received */
> +			return 0;
> +
> +		ath12k_warn(ab, "htc suspend not complete, retrying (try %d)\n",
> +			    i);
> +		msleep(ATH12K_WOW_RETRY_WAIT_MS);
> +	}
> +
> +	ath12k_warn(ab, "htc suspend not complete, failing after %d tries\n", i);
> +
> +	return -ETIMEDOUT;
> +}

Why the loop here? Looks really odd to me and no explanation why it's
needed. ATH12K_WOW_RETRY_NUM seems to be 10 so this can loop a lot.

ath11k seems to have a similar loop and no comments there either. I
clearly missed that in review.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

