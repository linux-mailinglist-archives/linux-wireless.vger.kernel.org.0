Return-Path: <linux-wireless+bounces-9280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75290FFEB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FB51C220F1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F7176221;
	Thu, 20 Jun 2024 09:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW14+hRh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813A42040
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874476; cv=none; b=LZXoJ92ceKOt5KmA/X5Fi48nlt0LUFv7h8wRiNw+xFW5xZzgmCYfffUDQ5ANmm/uYGYirk+a2+9VJHdt44gLzK/Zihsw+SfnUJ+1eqtlq+hVshiF/WPuwhuc1DhcQzi8veSOCAWkakLWNDvI2xNPkcYow834UU38tv9PfZiGfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874476; c=relaxed/simple;
	bh=627u7/0jEcYoiKFGgf9woOedEhyyb1h7Agco3kbB6nw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=bkzIvFhOI5lZHENArA+82wyOOMpytQk8rqONMf/xIl/K32AMn/YiL1JkJWyNRfleNAT3s6CRGgG66bwuE6D2whyESgtmX77+gcO4e5pHjGyICXLRrjhqL1Ynjm4R9GHcwp9SSvu8m2neapxA+4bx5WBC1NNlY4wfvWPIQkpe6aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW14+hRh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3AC2BD10;
	Thu, 20 Jun 2024 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718874476;
	bh=627u7/0jEcYoiKFGgf9woOedEhyyb1h7Agco3kbB6nw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=fW14+hRhREOHBr880vl19z8aBPjF6eqvV2ucdhaf9wKNztUXuXy9LHNbhO1l5hj1p
	 0UqQUcDI5tSLs1C4cjuLis84SxZ5OZnKjyT6ZBscxmQB7y8hYwVDL7q+i5QsejMIVl
	 d4f4mVd+W03zJZMzY4XExurRcD1dcodYakrirvJXh+xNCcR8g2LbJ464bbAqqxktnL
	 LftAv74xROHOWIXWNVlsk4FiwHlzpK29igm07EW3a0zvQ2pIkU3yuZqm4P9Oq50WUM
	 bs97k+75rlXRZgOS1auJGpO6rOO++BFOAWoBcytPX7gimeHAsosVZBJ0wDFbIRGKIA
	 GVZMt9Wssx+Uw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 2/8] wifi: ath12k: implement WoW enable and wakeup
 commands
References: <20240604055407.12506-1-quic_bqiang@quicinc.com>
	<20240604055407.12506-3-quic_bqiang@quicinc.com>
	<87msnjn0qs.fsf@kernel.org>
	<f66c2719-f413-4348-8440-97a169430043@quicinc.com>
Date: Thu, 20 Jun 2024 12:07:53 +0300
In-Reply-To: <f66c2719-f413-4348-8440-97a169430043@quicinc.com> (Baochen
	Qiang's message of "Tue, 18 Jun 2024 13:49:30 +0800")
Message-ID: <87plscj82e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>>> +int ath12k_wow_enable(struct ath12k *ar)
>>> +{
>>> +	struct ath12k_base *ab = ar->ab;
>>> +	int i, ret;
>>> +
>>> +	clear_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
>>> +
>>> +	for (i = 0; i < ATH12K_WOW_RETRY_NUM; i++) {
>>> +		reinit_completion(&ab->htc_suspend);
>>> +
>>> +		ret = ath12k_wmi_wow_enable(ar);
>>> +		if (ret) {
>>> +			ath12k_warn(ab, "failed to issue wow enable: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +
>>> +		ret = wait_for_completion_timeout(&ab->htc_suspend, 3 * HZ);
>>> +		if (ret == 0) {
>>> +			ath12k_warn(ab,
>>> + "timed out while waiting for htc suspend completion\n");
>>> +			return -ETIMEDOUT;
>>> +		}
>>> +
>>> +		if (test_bit(ATH12K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags))
>>> +			/* success, suspend complete received */
>>> +			return 0;
>>> +
>>> +		ath12k_warn(ab, "htc suspend not complete, retrying (try %d)\n",
>>> +			    i);
>>> +		msleep(ATH12K_WOW_RETRY_WAIT_MS);
>>> +	}
>>> +
>>> +	ath12k_warn(ab, "htc suspend not complete, failing after %d tries\n", i);
>>> +
>>> +	return -ETIMEDOUT;
>>> +}
>> 
>> Why the loop here? Looks really odd to me and no explanation why it's
>> needed. ATH12K_WOW_RETRY_NUM seems to be 10 so this can loop a lot.
>
> Host asks firmware to enter WoW mode using a WMI command. While
> receiving it, firmware might be busy so that can not enter WoW
> immediately. In that case firmware notifies host of
> ATH12K_HTC_MSG_NACK_SUSPEND message, asking host to try again later.
> Per firmware team there could be up to 10 loops.

Not really a good firmware interface, oh well. I added a comment to
ath12k_wow_enable() explaining, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

