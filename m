Return-Path: <linux-wireless+bounces-1702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD082A8DD
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54091C21D4E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 08:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EE6F512;
	Thu, 11 Jan 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX+tTMYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53AF505
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 08:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4434FC433C7;
	Thu, 11 Jan 2024 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704960972;
	bh=BQudpe0VwbbOvUlPTJMdiM4Iwq5AM8cdBJqebzL7SxY=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RX+tTMYGZYyxemfO6jVBFJaiVmtcP84X0vzY+FE33UP/89hqvrALUF2VHhn5VwpUQ
	 zSfVhFGazTHowBn7Ozy67iKb6tdaDgbpIfTiRcHZWqWRzckrIR1SgI47C5dFdvQ0bN
	 WRjxCxws63Q6xJgx1KaTZZ0C8lMtHPTMI2nXDB1xN1VOF83e5VbFsiDdp9X5y40FHU
	 jVnx7emlDt+0a3EjhKcxYnZXlp0LcQWtFS+1JKMn3hSp3eTMZYJZOzzYwso4nu/n6+
	 1JC5R1z4enWFsJoueq1ftRsh6D7/jA8p9fvS1NR2stmipCVwHhQcHgAracGGn73Zcx
	 fXH+RNNnwcTHA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: James Prestwood <prestwoj@gmail.com>,  <linux-wireless@vger.kernel.org>,
  <ath11k@lists.infradead.org>
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	<87r0ipcn7j.fsf@kernel.org>
	<356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	<26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
Date: Thu, 11 Jan 2024 10:16:09 +0200
In-Reply-To: <26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com> (Baochen
	Qiang's message of "Thu, 11 Jan 2024 11:51:44 +0800")
Message-ID: <87mstccmk6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 1/10/2024 10:55 PM, James Prestwood wrote:
>> Hi Kalle,
>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>> James Prestwood <prestwoj@gmail.com> writes:
>>>
>>>>> But I have also no idea what is causing this, I guess we are doing
>>>>> something wrong with the PCI communication? That reminds me, you could
>>>>> try this in case that helps:
>>>>>
>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/
>>>>
>>>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>>>> this something I'd need on the host kernel, guest, or both?
>>>
>>> On the guest where ath11k is running. I'm not optimistic that this would
>>> solve your issue, I suspect there can be also other bugs, but good to
>>> know if the patch changes anything.
>>
>> Looks the same here, didn't seem to change anything based on the
>> kernel logs.
>> 
> Could you try this?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/net/wireless/ath/ath11k/pci.c?id=39564b475ac5a589e6c22c43a08cbd283c295d2c

This reminds me, I assumed James was testing with ath.git master branch
(which has that commit) but I never checked that. So for testing please
always use the master branch to get the latest and greatest ath11k:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/

There's a quite long delay from ath.git to official releases.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

