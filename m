Return-Path: <linux-wireless+bounces-1742-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5A82B39C
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 18:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4C1C20492
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A44CE01;
	Thu, 11 Jan 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tq1KpqeI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E871482F7
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 17:04:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E51C43399;
	Thu, 11 Jan 2024 17:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704992653;
	bh=jaeSb7CanUzwRRRRLQaYLDJGUB6b+UPtSkI9H0rgATQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tq1KpqeIn6bj0aYKzzPhdag10n+6t2TZPeNLnZ4oOyBvXyiir/fCFPlWuIpVUnoZB
	 S4vY/RltFZn+3kDOAPLD4TM8zyY3ChLT8bGqgqJh91qPX9cdLAyGfr+pe1hMmq5QRT
	 jVjdcFiapkB2cB62UigcGRyPEuak1A1f9yg3BbYuIhAQ81kDznhNbEm0sW4xSnOzi6
	 upGHnroWsr2jK6L9hZmfQUpqKTozxx0dVnSV0upVvCSCYJyviMIMJjyg/mekPvw4WA
	 Gk6OutuJI95LU/ku4CwS9FMabc/87nhgyfZJMw1mdHWGv8QyWCvkacuheRnNZwqnbQ
	 WVBZja/HBFaPQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
References: <20240109021336.4143-1-quic_bqiang@quicinc.com>
	<20240109021336.4143-3-quic_bqiang@quicinc.com>
	<e19baf59-c17b-4e2b-96d7-f4fc9812c99a@quicinc.com>
	<56282bad-b59d-4572-a6f1-1b905bf0edbd@quicinc.com>
	<da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com>
Date: Thu, 11 Jan 2024 19:04:10 +0200
In-Reply-To: <da6ff953-07a4-4226-a7dc-b816f8dc5724@quicinc.com> (Jeff
	Johnson's message of "Wed, 10 Jan 2024 08:20:46 -0800")
Message-ID: <87il3zajjp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/9/2024 6:16 PM, Baochen Qiang wrote:
>
>> On 1/10/2024 1:41 AM, Jeff Johnson wrote:
>>> On 1/8/2024 6:13 PM, Baochen Qiang wrote:
>>>> QCA2066 is a PCI based DBS device. It is very similar to WCN6855
>>>> overall: they share the same PCI device ID, the same major and
>>>> minor version numbers, the same register address, and same HAL
>>>> descriptors etc. The most significant difference is that QCA2066
>>>> supports 3-antenna configuration while WCN6855 does not. To differenti=
ate
>>>> them, subversion numbers are used. Currently four numbers are used
>>>> by QCA2066: 0x1019A0E1, 0x1019B0E1, 0x1019C0E1 and 0x1019D0E1.
>>>>
>>>> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03737-QCAHSPSWPL_V2_SILICONZ=
_CE-1
>>>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILIC=
ONZ_LITE-3
>>>>
>>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>>> ---
>>>> v2:
>>>>   - Rebased on ToT.
>>>
>>> hmmm, fails to apply using b4 shazam
>>>
>>> Checking attestation on all messages, may take a moment...
>>> ---
>>>    =E2=9C=93 [PATCH v2 1/2] wifi: ath11k: move pci.ops registration ahe=
ad
>>>    =E2=9C=93 [PATCH v2 2/2] wifi: ath11k: add support for QCA2066
>>>    ---
>>>    =E2=9C=93 Signed: DKIM/quicinc.com
>>> ---
>>> Total patches: 2
>>> ---
>>>   Base: using specified base-commit 2cd4e3f91f264926a6b11df948417b74d52=
ca9b9
>>> Applying: wifi: ath11k: move pci.ops registration ahead
>>> Applying: wifi: ath11k: add support for QCA2066
>>> Patch failed at 0002 wifi: ath11k: add support for QCA2066
>>> error: patch failed: drivers/net/wireless/ath/ath11k/core.c:711
>>> error: drivers/net/wireless/ath/ath11k/core.c: patch does not apply
>>>
>>> And sure enough the code at drivers/net/wireless/ath/ath11k/core.c:711
>>> doesn't match the code in the 2nd patch so something is amiss here.
>>>
>>> note your patch has reference to .support_dual_stations that is not
>>> present in ath11k -- perhaps there are other prerequisites?
>>> <https://patchwork.kernel.org/project/linux-wireless/patch/202307140238=
01.2621802-2-quic_cjhuang@quicinc.com/>
>> Yes, as said in the cover letter, this patch set depends on the above pa=
tch.
>
> Unfortunately automated tasks don't parse cover letters. But it looks
> like b4 doesn't handle or warn about:
> prerequisite-patch-id: 640366721125b1adea0eeabd5cdfca5e91476e7c
>
> And not quite sure how it would handle that.
>
> Kalle, that prerequisite series is set to Deferred and predates my
> transition to the ath11k maintainer role. What action is needed from the
> developers?
> <https://patchwork.kernel.org/project/linux-wireless/list/?series=3D76550=
6&state=3D*>

My plan was to run some tests on that patch before applying it, that's
why it's deferred for now. I'll try to do that soon.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

