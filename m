Return-Path: <linux-wireless+bounces-2087-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C38518301BF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616291F2670B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA61134AC;
	Wed, 17 Jan 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNKPv2AP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C912E76
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481919; cv=none; b=F5f1ANnzkPJSaL4Ub5ncMa854UxDEjM7wrOxwOOw8tcrCopIOxU4WdQGqfcgJutndDqBLPNtEoxOYVbdTX7HBKW4DF32gf+sOoDrK4SN9cJLcZ/EpchbJzlv5hS0MK1VMGOnLxTZsi7DHRSxXJtuEqA8AHz+qCBxJQSK8elDUlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481919; c=relaxed/simple;
	bh=GQYAeT3FGcdKFmr/md39DR9fddQy/57aTXTBeURZwKs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:References:Date:
	 In-Reply-To:Message-ID:User-Agent:MIME-Version:Content-Type; b=I5m8HWloGkGd/cV3A5hw1dTLU7JP0Ac8rOdnZt1BgMLDgW8h7FYHRFaw5cDjGLcLspJtIL8Z0Kta21o22RDmBCkM/2IshzX79Myb8JxGLzPMSs5L1cVwPmj9dqiMoWlTqb7ohQS9Nn+nsAVQpxyn6xbOHEFoLfE3NHgkLWQ+5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNKPv2AP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFCC43609;
	Wed, 17 Jan 2024 08:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705481918;
	bh=GQYAeT3FGcdKFmr/md39DR9fddQy/57aTXTBeURZwKs=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=VNKPv2AP+BvueTWQVDEueA+mIn7bhx2tJERrxnhhu8inxCPJ6IEHt6m/kEWMaeIWU
	 it/PhiAnbI3TWz3SpvbODA+GvLuNa8/sckGgc4muzQR04gCfrBxlsOfBlfWFjfHNpK
	 6vmZNDefS9TtsXQy/oQAM6hcX+bZLcGMH4jmtjPAacH7+7mIYMrrWLtpqvwx776Abc
	 j9Xs159JKWC46r3XVqeFFNnOlGhVmKx0wtgLKhQQA9SgAly5Dqw6Dxo07LY8UgFDbm
	 7LxsO3bjwdwytBva7B9gE85yTkNZbWLGlr67y3qWfeoO11EKwvNPdCaB28Oe0uNJh2
	 W2PMFdsSD8vEQ==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: add support for collecting firmware log
References: <20240115023726.2866-1-quic_bqiang@quicinc.com>
Date: Wed, 17 Jan 2024 10:58:36 +0200
In-Reply-To: <20240115023726.2866-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Mon, 15 Jan 2024 10:37:26 +0800")
Message-ID: <87ttnc5oar.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently there is no way to collect firmware log because firmware
> does not send it to host. Also host does not handle WMI_DIAG_EVENTID
> which is used by firmware to upload firmware log.
>
> So add support for it by firstly enabling firmware log upload via a
> QMI message, and secondly processing WMI DIAG event to expose it to
> userspace via trace event.
>
> This change applies to both WCN7850 and QCN9274.
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

I did some cosmetic changes like reverse xmas tree, debug messages etc. 

> +static int ath12k_qmi_wlanfw_wlan_ini_send(struct ath12k_base *ab, bool enable)

As enable was always true I removed it. We can add it back later if it's
needed.

> +struct qmi_wlanfw_wlan_ini_req_msg_v01 {
> +	/* Must be set to true if enablefwlog is being passed */
> +	u8 enablefwlog_valid;
> +	u8 enablefwlog;

'enablefwlog' is really awkward and it's used in several places, why not
'enable_fwlog' which is far more readable? I could change that in the
pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

