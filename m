Return-Path: <linux-wireless+bounces-1717-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4978C82AF3D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 14:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84631F22ED0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826E15AE9;
	Thu, 11 Jan 2024 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJu+E5D6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB51171AE
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 13:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E759FC433A6;
	Thu, 11 Jan 2024 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704978670;
	bh=Xk53MHcXaBc/qe4901eYqEK9cjk9W7j8opCQ74N4LDI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=KJu+E5D6hDXtT0PQSkE7t4X3wZzElymcoTMLRiL/R9I2E9a75+ajSzpByNuICy3qs
	 CKTBwG2FOrqYJ5Td8QFuscQAjQ3jdBAmgttGcZ7xZHuFu+hIMc/q3d3FBYLSdWvhLo
	 3obcOJLvkNMwhPRzAJkQjLVktWCfRFL65wEASNy0/rP/Ich7zdhGP0uebLjpez7kKX
	 W6uAokqHECGXwqtnlCBLRbcqcgwSpJx6hyHxnFQb6a3YA9bzxCDtgJKlrwNdD9AiOD
	 SX/OOJgX6ef7Rr2jB/OGL3e6pN3XpU4eyii6ELhBw2asPLUDsyCaAF/GLEH+43REBi
	 cuGi9pZJYjI4g==
From: Kalle Valo <kvalo@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
  linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org
Subject: Re: ath11k and vfio-pci support
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
	<8734v5zhol.fsf@kernel.org>
	<87fa5220-6fd9-433d-879b-c55ac67a0748@gmail.com>
	<87r0ipcn7j.fsf@kernel.org>
	<356e0b05-f396-4ad7-9b29-c492b54af834@gmail.com>
	<26119c3f-9012-47bb-948e-7e976d4773a7@quicinc.com>
	<87mstccmk6.fsf@kernel.org>
	<df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
Date: Thu, 11 Jan 2024 15:11:07 +0200
In-Reply-To: <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com> (James
	Prestwood's message of "Thu, 11 Jan 2024 04:48:24 -0800")
Message-ID: <8734v4auc4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Prestwood <prestwoj@gmail.com> writes:

> Hi Kalle, Baochen,
>
> On 1/11/24 12:16 AM, Kalle Valo wrote:
>> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>>
>>> On 1/10/2024 10:55 PM, James Prestwood wrote:
>>>> Hi Kalle,
>>>> On 1/10/24 5:49 AM, Kalle Valo wrote:
>>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>>
>>>>>>> But I have also no idea what is causing this, I guess we are doing
>>>>>>> something wrong with the PCI communication? That reminds me, you co=
uld
>>>>>>> try this in case that helps:
>>>>>>>
>>>>>>> https://patchwork.kernel.org/project/linux-wireless/patch/202312120=
31914.47339-1-imguzh@gmail.com/
>>>>>> Heh, I saw this pop up a day after I sent this and was wondering. Is
>>>>>> this something I'd need on the host kernel, guest, or both?
>>>>> On the guest where ath11k is running. I'm not optimistic that this wo=
uld
>>>>> solve your issue, I suspect there can be also other bugs, but good to
>>>>> know if the patch changes anything.
>>>> Looks the same here, didn't seem to change anything based on the
>>>> kernel logs.
>>>>
>>> Could you try this?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/net/wireless/ath/ath11k/pci.c?id=3D39564b475ac5a589e6c22c43a08cb=
d283c295d2c
>> This reminds me, I assumed James was testing with ath.git master branch
>> (which has that commit) but I never checked that. So for testing please
>> always use the master branch to get the latest and greatest ath11k:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/
>>
>> There's a quite long delay from ath.git to official releases.
>
> Good to know, and I was not in fact using that branch. Rebuilt from
> ath.git/master but still roughly the same behavior. There does appear
> to be more output now though, specifically a firmware crash:
>
> [=C2=A0=C2=A0=C2=A0 2.281721] ath11k_pci 0000:00:06.0: failed to receive =
control
> response completion, polling..
> [=C2=A0=C2=A0=C2=A0 2.282101] ip (65) used greatest stack depth: 12464 by=
tes left
> [=C2=A0=C2=A0=C2=A0 3.306039] ath11k_pci 0000:00:06.0: Service connect ti=
meout
> [=C2=A0=C2=A0=C2=A0 3.307588] ath11k_pci 0000:00:06.0: failed to connect =
to HTT: -110
> [=C2=A0=C2=A0=C2=A0 3.309286] ath11k_pci 0000:00:06.0: failed to start co=
re: -110
> [=C2=A0=C2=A0=C2=A0 3.519637] ath11k_pci 0000:00:06.0: firmware crashed: =
MHI_CB_EE_RDDM
> [=C2=A0=C2=A0=C2=A0 3.519678] ath11k_pci 0000:00:06.0: ignore reset dev f=
lags 0x4000
> [=C2=A0=C2=A0=C2=A0 3.627087] ath11k_pci 0000:00:06.0: firmware crashed: =
MHI_CB_EE_RDDM
> [=C2=A0=C2=A0=C2=A0 3.627129] ath11k_pci 0000:00:06.0: ignore reset dev f=
lags 0x4000
> [=C2=A0=C2=A0 13.802105] ath11k_pci 0000:00:06.0: failed to wait wlan mode
> request (mode 4): -110
> [=C2=A0=C2=A0 13.802175] ath11k_pci 0000:00:06.0: qmi failed to send wlan=
 mode
> off: -110

Ok, that's progress now. Can you try next try the iommu patch[1] we
talked about earlier? It's already in master-pending branch (along with
other pending patches) so you can use that branch if you want.

[1] https://patchwork.kernel.org/project/linux-wireless/patch/2023121203191=
4.47339-1-imguzh@gmail.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

