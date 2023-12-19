Return-Path: <linux-wireless+bounces-951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE501818188
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 07:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EDD1C23211
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 06:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8188A79D0;
	Tue, 19 Dec 2023 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9/jZ52a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDC6D24
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 06:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7D7C433C8;
	Tue, 19 Dec 2023 06:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702967407;
	bh=VoPIYApzISlddcqMdu3mYtij5qC3ORIpAABFXi5uBP4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=L9/jZ52aSWAh0nzGAnPjFXxmgQzBne+UOlJt8dqAkSGHp8uMyGcsugLkarA+HaGcl
	 8M07hJdC+Wm00d2ZtZfjfgv5B7Xqn9Oxm6zH5TFYSMumRahw3AJmdwlVCv+RBVcIZT
	 1z0HI8zL9u3zm1m52yJ+UqD08T2xqoRBuvHq+uETW16CE5Wt67ZCCXwOOWac/OS35/
	 axv7+tqb/xwfrO1WN5DYgZB63G5Oi7h4PlOewLYgbmpgWqvybmX11/2XshESdrY5iJ
	 /okXmgIOZ+b63SafG/D9Na7IKxF9tGVIkZ3vYdR3hzTgpKD49M/JuMB1q/0PJqQ/if
	 F6EZmP5emSczw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] wifi: ath11k: fill parameters for vdev set
 tpc power WMI command
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
	<20231218085844.2658-10-quic_bqiang@quicinc.com>
	<8b754d39-e079-4ea0-bcc1-94e0cf14d5ae@quicinc.com>
Date: Tue, 19 Dec 2023 08:30:04 +0200
In-Reply-To: <8b754d39-e079-4ea0-bcc1-94e0cf14d5ae@quicinc.com> (Jeff
	Johnson's message of "Mon, 18 Dec 2023 13:13:17 -0800")
Message-ID: <87bkamso0j.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 12/18/2023 12:58 AM, Baochen Qiang wrote:
>> From: Wen Gong <quic_wgong@quicinc.com>
>> 
>> Prepare the parameters which are needed for WMI command WMI_VDEV_SET_TPC_POWER_CMDID.
>> 
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>> 
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
> ...
>>  drivers/net/wireless/ath/ath11k/mac.c | 284 ++++++++++++++++++++++++++
>>  drivers/net/wireless/ath/ath11k/mac.h |   3 +
>
> drivers/net/wireless/ath/ath11k/mac.h: QuIC copyright missing 2023

I can fix that in the pending branch, no need resend because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

