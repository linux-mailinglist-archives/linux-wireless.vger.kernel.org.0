Return-Path: <linux-wireless+bounces-4461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02E5875477
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609E41F218CA
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 16:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2B412F5BD;
	Thu,  7 Mar 2024 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYW62JPt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61912F59B
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830161; cv=none; b=nEZyXU4y58uWQsdhWYKMpFdGexBASlqWPuCo+YAVA6HTZT3drfzrd6F9Ox1lTkJ/mCCUlfmnzA5lv5VZXP9jvGOF8HC3BVckkYas/5XGNK1zRAIhIpaqbYOdu3aJdQiXf8M5+Jp1lJI+327t5rZMHmddNa8Q2JiimQ60ItB1v8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830161; c=relaxed/simple;
	bh=J8Lo61HZVMQ6CigBjAy14gesjPzmknIZL6TU+MMbkpw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CHxYhSw/wDmm1+qJht9p43fIKgmCGxwqoWfL2YGYba5Sso1F9T1x7JbXu4XBvv8jGZTDPWrQlMw+AQXi+s9497FXw3wCLWx28VlPDpEhxgbSAzMTAnia0c+XMlSRWfPgncINViCePo4/zKgqeTa4ffUtBSfTDaSHu9TZWsotjbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYW62JPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D59C433C7;
	Thu,  7 Mar 2024 16:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709830160;
	bh=J8Lo61HZVMQ6CigBjAy14gesjPzmknIZL6TU+MMbkpw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=QYW62JPtlbjaNdp4ECVGkJ/R92sB1uYgsw8YtSqqtPIJrWWTUaMqgncYU/Xcl6Qdg
	 q+E/YTP/niZh8PQ1bUfa7C6an+ZyBBrN5PGeCI4kRH6Z9Ty4wCgq5ZKNwuAdYWoViL
	 smamuVhAYvccYBlzg7i3lHddO+H58gtyQDdn1YAYj/SecSDIeY9nfJP1bDdHO3w0Ot
	 AbvBGodNKr7HF32lbSxWqke+CP+hPrZ2NgAA+AUk/8PrPZWuZ76ALE6hNbQSwMoZ+f
	 4FCXjB/MqZH3wobQLrtwuZ8IhbN+CVpDnMIZCQBj5664IZRVw0paN4QtTBozfV3v5x
	 Ewi6zg4fyxiSQ==
From: Kalle Valo <kvalo@kernel.org>
To: Robert Marko <robert.marko@sartura.hr>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  ath10k
 <ath10k@lists.infradead.org>,  ath11k <ath11k@lists.infradead.org>,
  ath12k <ath12k@lists.infradead.org>,  linux-wireless
 <linux-wireless@vger.kernel.org>
Subject: Re: New staging repos for ath1*k firmware
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
	<CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
Date: Thu, 07 Mar 2024 18:49:17 +0200
In-Reply-To: <CA+HBbNFQ+25u_PK2j3vYtiCZwv+shVAVeAHKqQCwhyCopORt4Q@mail.gmail.com>
	(Robert Marko's message of "Thu, 7 Mar 2024 09:39:26 +0100")
Message-ID: <874jdigf76.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Robert Marko <robert.marko@sartura.hr> writes:

> On Wed, Mar 6, 2024 at 8:23=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicin=
c.com> wrote:
>
>>
>> Historically, prior to being incorporated into the linux-firmware
>> project, firmware for kernel.org ath1*k drivers has been first published
>> to Kalle's GitHub:
>> https://github.com/kvalo/ath10k-firmware
>> https://github.com/kvalo/ath11k-firmware
>> (ath12k firmware was pushed to the ath11k-firmware repo on a temporary
>> basis in anticipation of this move)
>>
>> But in order to have repos with multiple maintainers, as well as to have
>> a hosting platform with more control, we have moved to CodeLinaro:
>> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
>> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
>> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>>
>> Note that most people should not care about this -- normally you should
>> use the firmware that is in the official linux-firmware repo:
>> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/
>>
>> You should only need to access the staging repos if you need a previous
>> version to work around an issue, or if you are testing new firmware that
>> is supposed to fix a problem that you've reported.
>>
>> Please let Kalle & I know if you have any issues with these new repos!
>
> Can I please ask for IPQ6018 firmware to be updated to 2.9.0.1 as well?
>
> We have added IPQ6018 support to OpenWrt but we are forced to use the old=
 2.4
> firmware since anything newer is crashing on IPQ6018, we had the same iss=
ue on
> IPQ8074 but it was fixed with 2.9.0.1 firmware.
>
> Even for IPQ8074, there is newer 2.9.0.1 firmware that is only
> available as part of
> QSDK and the community would benefit from being able to use it.

We are working on getting the AP chipset firmwares updated but
unfortunately no news yet.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

