Return-Path: <linux-wireless+bounces-9141-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EBB90C738
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 12:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DF1C20F2F
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 10:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541171AE855;
	Tue, 18 Jun 2024 08:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdpQcxYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027A1AD9E8
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699874; cv=none; b=l+k5svSZ3ofMJYFTgOvY9eEcWoltru+yQlg10Bsi4DM50qOmdXd7OicrRjHthxOfZkDrwYTtt8lJFdHGbyqFjGlJr8U4I1d7bfODyq6/Z6rQXS6nPe5WRduMPwPiPj/s8pyQiu2HmNbpn4ZjP6zXjtNZCZSpagMjFOWc8xN97kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699874; c=relaxed/simple;
	bh=fYQJnw1HECgzYN1KAhN5C+vIw4kw3q70dv0DpSBl6pE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=lh6RYy4h0gwr4+zAcC4deEzPF2C3PafkPKQpgnY7/5KU+9tu0g7rVscAsybKs/JV2cjE2nG7P6IZbYo3gDTh9ae8VRJmAY8L0c2KTtFEmvHzeat9FztYQqRJ8YuzduD82CurkSMH45XEzRRRHBRM7+yZvOeYYMcFvY5e6DJ5jO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdpQcxYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842D9C3277B;
	Tue, 18 Jun 2024 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718699873;
	bh=fYQJnw1HECgzYN1KAhN5C+vIw4kw3q70dv0DpSBl6pE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gdpQcxYfOpmA909/13ufw+YrtcK31AgX7UEibdUKgYvuy7fQp1msBKgHwj7L5yvRn
	 8w9jtLqxgH4tPY1VtUe19yoiawJO6gFscgU41rNefR0jIS2AXHpsXo/gfuNxXzFq/4
	 spILweSlEVxwDgeLa+Ikspy1ePErHNW+UldpQdkbs/CiP5zREmTzITU1lQBryJ3v4N
	 aXQt9fTrVd2fJa3nYvDRy31jPr+PI3A9Um97jSoJ2n3cpi7ytMiZMv9ovNN0Slf5Jf
	 ZfNOqnS2DOgQbNKxq4twh5xkBjcVIiIA7Lrg12kYA90YsISvuJg+aa2Te7MHg9lMO6
	 IG8lPc9pnwKQg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Rameshkumar Sundaram <quic_ramess@quicinc.com>,
  <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Sriram
 R <quic_srirrama@quicinc.com>
Subject: Re: [PATCH v4 1/3] wifi: ath12k: prepare vif data structure for MLO
 handling
References: <20240617131650.3288118-1-quic_ramess@quicinc.com>
	<20240617131650.3288118-2-quic_ramess@quicinc.com>
	<3754f5f3-0e67-4c5e-9b56-888ad5071622@quicinc.com>
Date: Tue, 18 Jun 2024 11:37:50 +0300
In-Reply-To: <3754f5f3-0e67-4c5e-9b56-888ad5071622@quicinc.com> (Baochen
	Qiang's message of "Tue, 18 Jun 2024 15:47:46 +0800")
Message-ID: <87ed8umysh.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

>> +static inline struct ieee80211_vif *ath12k_vif_to_vif(struct ath12k_vif *ahvif)
>
> better naming as ath12k_ahvif_to_vif()?

Thanks a lot for the review, I appreciate it. But please edit your
quotes, having thousands of lines of quotes makes use of patchwork
practically impossible:

https://patchwork.kernel.org/project/linux-wireless/patch/20240617131650.3288118-2-quic_ramess@quicinc.com/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

