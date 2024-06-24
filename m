Return-Path: <linux-wireless+bounces-9506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752A9153DC
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5411F23378
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jun 2024 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA1F71B5B;
	Mon, 24 Jun 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGhEpIR2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708A1B964
	for <linux-wireless@vger.kernel.org>; Mon, 24 Jun 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246736; cv=none; b=IoP1ooKxw2zAqp0QqW13iL21X0I3S+Kcmn8tlm0DQQlIkjEvGc+Xp6fLLlge5noaN9E5RAetpNGNVkdD9cpjVgY/GN/4CyCx+qoOGoIV2mMrXJFQNUexbwSBc1mQGEaiFlgqd1wHXpQBCWFMrn02ldd7fm+s30NS4i3t7R4o9ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246736; c=relaxed/simple;
	bh=Uh2ZIN9pvy/iUjlsXO0wAESSdBzozMzUQVRB0UPoNfo=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=jv/FLQ9cD7lCMpxJq/eJ/FCm4l3PZacju6+mv4aM6pG5gsxOGnFIBx9wkgvosAXXEmGkzccE47MWWNl7pGXlA93bh18J2PKonQXzAdVTosMy8FQNn6ZvVWM/L0UHAZcP/feRfzrC7IZ2kz4LJdUszBxKW6sb2PLUaif/0UAHX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGhEpIR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE8DC2BBFC;
	Mon, 24 Jun 2024 16:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246736;
	bh=Uh2ZIN9pvy/iUjlsXO0wAESSdBzozMzUQVRB0UPoNfo=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=vGhEpIR2Ji2jGebVOE/4HNpTSINoYxU+oG8fnHRGKj+MCpvFMNjgm653+KlnWgkud
	 8QnZMVQOI8skCVxHQLDX3zhJHsrsCcPpvOnzZnMfmepFQxh6V8deFoUVlbIJAmY/ni
	 nVZPXR7EJSRpt1oOTO/7tNLU1lJCKGCk8oIpiTwrhprooRkOdVk5Dvpz9/08ICV1cX
	 TjDKJgY0jmMOckbL201ny1IRBka/J7hO+bLgXpn4onx3M31fIvydYjA1g9TATkXHgE
	 sszm6JhSEZ7FmJb/Vn093UKUJeYemGyRJp1ktt2GN1eaEyWUSVtED0qIYZh29y1p/j
	 jePEztEavTaVw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 1/8] wifi: ath12k: add ATH12K_DBG_WOW log level
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240604055407.12506-2-quic_bqiang@quicinc.com>
References: <20240604055407.12506-2-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171924673369.1037115.14418546599352720662.kvalo@kernel.org>
Date: Mon, 24 Jun 2024 16:32:15 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently there is no dedicated log level for WoW, so create it for future use.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

8 patches applied to ath-next branch of ath.git, thanks.

3216b7bcd719 wifi: ath12k: add ATH12K_DBG_WOW log level
593174170919 wifi: ath12k: implement WoW enable and wakeup commands
4a3c212eee0e wifi: ath12k: add basic WoW functionalities
16f474d6d49d wifi: ath12k: add WoW net-detect functionality
66a9448b1b89 wifi: ath12k: implement hardware data filter
1666108c74c4 wifi: ath12k: support ARP and NS offload
aab4ae566fa1 wifi: ath12k: support GTK rekey offload
7af01e569529 wifi: ath12k: handle keepalive during WoWLAN suspend and resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240604055407.12506-2-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


