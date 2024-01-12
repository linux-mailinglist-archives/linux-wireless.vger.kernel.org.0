Return-Path: <linux-wireless+bounces-1784-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4982BB3D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790A01C24ECB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5C95C8E6;
	Fri, 12 Jan 2024 06:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYq7b5/p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535E75C8E4
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE547C433C7;
	Fri, 12 Jan 2024 06:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705040709;
	bh=ltAFigckzoyq+M2uicYFrx84Y169sQJ1vb3Owsd0y+A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=NYq7b5/pGPEK7Dwy0xcnWCOAJGelxrvR2igcEeYuflbsGcKCj9pGqjeZ95NQ6bc2W
	 qq7B5j3EpJUpHhvFfE0xZOeaF1XAnNFiziZOJL5a8ybavnivqyxn9sAPFP3zNYuY80
	 ETcXqvaLzJKVgWvhdRi7fsmd2U8yamIh9PE3JcvcQd8kEEoIr/onrL89o1bKr3ZyEI
	 99+pirHw7SoEmM1p5jiUEexbOTzMVr3kur5vNxFDVbBQIN43BrklU1nBIqRbkO4gUa
	 Fiw9oi3DOwt4xJVA42W46K3SGu0albHhNZsq0+lNsFiYig67o1XFMFCnITiDmXabbV
	 J7IOtEZsbkINw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v10 07/12] wifi: ath11k: add parse of transmit power
 envelope element
References: <20231218085844.2658-1-quic_bqiang@quicinc.com>
	<20231218085844.2658-8-quic_bqiang@quicinc.com>
	<93c178cd-8a16-48e5-b352-f14afab07498@quicinc.com>
Date: Fri, 12 Jan 2024 08:25:06 +0200
In-Reply-To: <93c178cd-8a16-48e5-b352-f14afab07498@quicinc.com> (Jeff
	Johnson's message of "Thu, 11 Jan 2024 09:13:19 -0800")
Message-ID: <87eden9igt.fsf@kernel.org>
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
>> +/**
>> + * struct reg_tpc_power_info - regulatory TPC power info
>
> Kalle,
>
> just spotted this kernel-doc issue in the pending branch
>
> s/reg_tpc_power_info/ath11k_reg_tpc_power_info/
>
> can you update?

Yup, did that now:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=180335ddf80a8cd44a9b261db548c14ede01da44

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

