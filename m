Return-Path: <linux-wireless+bounces-4239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8309386C347
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 09:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C747287C79
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 08:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B6646452;
	Thu, 29 Feb 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyhtWHb+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D238DF1
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194585; cv=none; b=nswFnDbjXibWXfjD46XLG4jLSY0puOOHeYCa4KmMnI6JGBgUqk0VmaMVJ8o3Nagm8Fsx0az4IKYqth2VFr5N2OuYSIDd7k2VaJWQ2W6cXjl6YbME186iguG/PO66FyThdt6jVW9p8mA08ccIFyAwhgFzSChqI8IWA3WsMmmOWdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194585; c=relaxed/simple;
	bh=y5OcD3gxfF0Cd3ddWFl0v6H0yVaSk1HNKViGum5HbdA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=T9JLMeE5N9T80UeE0wv+uXt/An4XAFkYZjWXyFn2FnwFQpONCocF5QhB/GvMtqXmmtGSdOb6CWfoEbPP2oX/dvZWMYt5wlJDB0nfEdIZa9KnaaOhHnIxxEqgWZ0Xb3mmXwMGV51Wupu4uXxCQpw66LWoYFcXVHzDsDuBTPm8Zo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyhtWHb+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED4DC433F1;
	Thu, 29 Feb 2024 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709194585;
	bh=y5OcD3gxfF0Cd3ddWFl0v6H0yVaSk1HNKViGum5HbdA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=OyhtWHb+e3wh3rEpz3W5DXVdOChzx+LTM1SJBM2Ar1osbd+Fy39i5I/075/m5E59P
	 VtNKVDQgcodv8IgWY5Bh9K+KrnIdls2PAJx/vv2Z+zdSzvDkxUfffF9RAvNQ9A9Z39
	 kmf0tE6n70dWbshkpR45SZ5KPRjatDjP7uOiQkp7nH5BiCdAUT7wjICQnGcxTDoiWs
	 af0rd/QfQ2birR47J95FJ+qBRNOaMgIfODUrJRv/1tKPbg6rFZXBYfYxafIPXfLUiV
	 H3CNeJBlfJW0/Lf9k6hgwydSTaizjPyhMFJgOhVANXu/j8+GP9bklFPthvW1DdDEZf
	 oP3g7l77D7MZA==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath10k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] wifi: ath10k: poll service ready message before failing
References: <20240227030409.89702-1-quic_bqiang@quicinc.com>
Date: Thu, 29 Feb 2024 10:16:22 +0200
In-Reply-To: <20240227030409.89702-1-quic_bqiang@quicinc.com> (Baochen Qiang's
	message of "Tue, 27 Feb 2024 11:04:09 +0800")
Message-ID: <87sf1bit2h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> Currently host relies on CE interrupts to get notified that
> the service ready message is ready. This results in timeout
> issue if the interrupt is not fired, due to some unknown
> reasons. See below logs:
>
> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not received
> ...
> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
>
> And finally it causes WLAN interface bring up failure.
>
> Change to give it one more chance here by polling CE rings,
> before failing directly.
>
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>
> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros
> 802.11ac CQA98xx devices")
> Reported-by: James Prestwood <prestwoj@gmail.com>
> Link:
> https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

In the pending branch I'll add this from v1:

Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

