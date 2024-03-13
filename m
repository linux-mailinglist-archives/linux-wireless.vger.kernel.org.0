Return-Path: <linux-wireless+bounces-4686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B987AE68
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C7E1C23505
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4943C18F371;
	Wed, 13 Mar 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr4aViDB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9E18F36B
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348534; cv=none; b=ReCKjnFFYpzfYUiW5eyI9ouJ131xia3Jl4xno/2CTHzb+ruvcpnSL1Zefd8fnzBkZiPm48TxO1XJ4wpBEvtpP7XiuEamFgjW++UhWk93Cd3I5tWF3cxw9/QXoVEGL4V/18FYFo2De6WcOa8/1Bvfis7n/lLi6IDgPI33bbi7dBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348534; c=relaxed/simple;
	bh=oESQXRrfUQn5iwHR7vuIGyuXA0ZCNnj5Jo5AGFJyb3s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=J5xl2LfUpanowbXiBKsxWhbE4Th6jcsgzmhDkQuf2DImRZ6OxX4f9P+qfwiYZUE/E6G8owBox55/dDxJ5i4/lZHcz6f8b9BAUz94GN6sN7PibsNkvSRg1xYmtYamVOH8NMB9pH8uLLnTDSabhcK3Ou/OktGGRzOlTJOCcMkk9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr4aViDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF39CC433C7;
	Wed, 13 Mar 2024 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348534;
	bh=oESQXRrfUQn5iwHR7vuIGyuXA0ZCNnj5Jo5AGFJyb3s=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Sr4aViDB3YIcBQARBhQq/BMG133CKzR2ns5C4wmLKZpIVoLbqBKjw9ubxMQdWwZXR
	 p658VANWNsn0RwQs2ZC3NJoNSkY0hEOdJpSPOPy3mSgpeQFi6cM5ScyxQo+ZTn0hor
	 38FOlBlSG0ThjilOZHp82FWPRC5OhpGLAhMELIeFudn8MZg061C6DLMAuoxBRJw1Sc
	 UfPmgiQAidYx+y8MiA8vl5+xvaCC9oMJ9oY83MbFSpMdIv55oZHbruvhvZsRSQkmJc
	 SPlFi/PkI4Tt8d/KS6p22QEhHQivU9HU9XVBfTw27eFceP8Sc1FJX5bnhukDRkLpR+
	 +VS0pBG4GDjCw==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: Re: [PATCH v4 01/12] wifi: ath12k: add multiple radio support in a
 single MAC HW un/register
References: <20240312135557.1778379-1-quic_ramess@quicinc.com>
	<20240312135557.1778379-2-quic_ramess@quicinc.com>
	<4a527729-2bf8-47ce-8275-d36b76bde95c@quicinc.com>
	<3178cf8c-d328-4fe2-b3be-f5c4c908f20f@quicinc.com>
	<605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com>
Date: Wed, 13 Mar 2024 18:48:50 +0200
In-Reply-To: <605a673e-3686-47d0-b71b-1e314fde65db@quicinc.com> (Jeff
	Johnson's message of "Wed, 13 Mar 2024 08:06:02 -0700")
Message-ID: <87il1qf571.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/13/2024 5:57 AM, Rameshkumar Sundaram wrote:
>> On 3/13/2024 3:23 AM, Jeff Johnson wrote:
>>> and guess we have to figure out how to suppress the ath12k-check issues with
>>> this macro
>> ath12k-check complains about the reuse of ah and index arguments which 
>> may get evaluated multiple times if its an arithmetic expression, But 
>> areas where we use the macro in our code aren't doing so.
>> Do you have any suggestions here ? or shall we go back and use this 
>> for-loop inline.
>
> The macro makes sense -- we'll need to update the overrides in ath12k-check.

IIRC it is possible to avoid variable reuse in macros with typeof()
operator (or something like that). I can't remember the details right
now but I think there are examples in the kernel code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

