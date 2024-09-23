Return-Path: <linux-wireless+bounces-13082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FF97E6A1
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98F6328196F
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A7482E4;
	Mon, 23 Sep 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzKjFEaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D24778C
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727076563; cv=none; b=ejlEaLjQe/PNl7X/9RhbZ+tlwPxgHCwtY6bLjk1a5a45JyHwCF86uEXOoKlLGjU/Y8FKXmQv/69niYYnyzsdH1lnF1PSt0j3lIxZXZS/NkwyVUhaedR0+5kgaTlC2Aj+TckxErBleGVQ62qYezr5OhW3OlsJD2IBNE4FERwD/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727076563; c=relaxed/simple;
	bh=Gkxq0N739X1KPn78Fx4r6Cp9uar1g8K/quFHYgkAd9Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=VoO8pcaVudEYiamTsar6jLzr+hoWz2RtLoslAUL428sVhbW2EJasGJtR+BWECDxqeqFxteuayG7rfBzshBF6pARK5etC8CQ6e8TAPqPFjT7/DhCk6UUv4gpqGRra87WbEsjyY850z3Ttqnpy6EKTlHi9iX4AryXRk70cQj/C+zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzKjFEaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4438C4CEC4;
	Mon, 23 Sep 2024 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727076562;
	bh=Gkxq0N739X1KPn78Fx4r6Cp9uar1g8K/quFHYgkAd9Q=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=jzKjFEaQnJAVdliaKVtU5oSzrSDGwio68KOgpxq1EHyk3awAMp5w9kj9rH7nnvXc2
	 ZyYGJrfQOEh0A8RsdGFfVsvjNSGBZwf9LIFLxYV+vjilHA3wLFKEtO6fIUdigbUSON
	 HET/ydb/BuXB93QOQnnG4VjKjvn2fU2JFPkGdPZx+vn97c8/HPTUM6RjJq+PUKLfSK
	 yqL9xPIM68pG2cSfoCvfqyAAaaOlqRDzGNGEYI1+W5dS36lJ+liyG4+7oezCjFPXzC
	 PyOkxYLLkUOZ3FxY+/WEmF5tM5Wnx/wd8KpZ1VvEiQWr6iaKrtGV+FhEgcrXjD7ygy
	 LX0lmxkl24vjQ==
From: Kalle Valo <kvalo@kernel.org>
To: Chenming Huang <quic_chenhuan@quicinc.com>
Cc: <johannes@sipsolutions.net>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH][RESEND] wifi: cfg80211: Do not create BSS entries for
 unsupported channels
References: <20240923021644.12885-1-quic_chenhuan@quicinc.com>
Date: Mon, 23 Sep 2024 10:29:19 +0300
In-Reply-To: <20240923021644.12885-1-quic_chenhuan@quicinc.com> (Chenming
	Huang's message of "Mon, 23 Sep 2024 07:46:44 +0530")
Message-ID: <87h6a6akvk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chenming Huang <quic_chenhuan@quicinc.com> writes:

> Currently, in cfg80211_parse_ml_elem_sta_data(), when RNR element
> indicates a BSS that operates in a channel that current regulatory
> domain doesn't support, a NULL value is returned by
> ieee80211_get_channel_khz() and assigned to this BSS entry's channel
> field. Later in cfg80211_inform_single_bss_data(), the reported
> BSS entry's channel will be wrongly overridden by transmitted BSS's.
> This could result in connection failure that when wpa_supplicant
> tries to select this reported BSS entry while it actually resides in
> an unsupported channel.
>
> Since this channel is not supported, it is reasonable to skip such
> entries instead of reporting wrong information.
>
> Signed-off-by: Chenming Huang <quic_chenhuan@quicinc.com>

The list of changes from v1 missing. I guess you added the 'wifi:' prefix
but did you change something else?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

