Return-Path: <linux-wireless+bounces-26273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA6B214C0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1CC7BA0A5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 18:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB12E613F;
	Mon, 11 Aug 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5myT04U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30812E6137;
	Mon, 11 Aug 2025 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937685; cv=none; b=DoKrtFCUQkOphZHkdY8DcnzixckoBBeWarY0dZQZasq6AVHhkIsmGQ5L6in52XEN5/DfuUtfGYmHrA/2fIZu8VpYZ0OX9k9JFFl6BUOotlebSBGaDsmNaVTk19xvxwPC4YR5jmmuGF5LXSNiRkcVyfMvRIvVoy7R+atYt7yRXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937685; c=relaxed/simple;
	bh=EOfgba50+6CeVpleSRv0Q0EMWfqPtmAaWwa0kISde2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxSyp9nt3kGk0JS3MvIHxw4Au1QYBjQ9Xn53P6fiLrYD0tjonb2/Gq1IlJJTggOzIAS0+GpDISAEUOG4+7zA3a+PMPnQohp/8KvTEF8YzNrtKQleQXcD9Dj5h21EzxP+Rq3yt8/4WieogNvCB86R8SpG+poVZTQejO51lsVBmr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5myT04U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C270C4CEF5;
	Mon, 11 Aug 2025 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754937685;
	bh=EOfgba50+6CeVpleSRv0Q0EMWfqPtmAaWwa0kISde2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y5myT04UfdY3QhEahpjI/jHBtn5TUMkfoDIpwAjD3Xo84YxlpgG0/faw5XzNJMD3M
	 oWvo2pWrcU/lzXWFgJmEjxjoizDmKBkYSd/ZPm7Qh6hWn8j/S80sCkH3KWlw1grrz9
	 WLgZZksjUgUcApM9NZgWjGPuPvMCHk3Y5uIB+AqNqGd3HZFkmCmh7p3qc9nyHdKAeT
	 0i88rOc39yEjibU/Soct7g6m8+pLz7RAQ/HB3qQdl96tXPAbK1o0Rq85Z7cuzYqViW
	 hV3Z5OLziqJL2ojO54GRbREcwxzeUGzjygg055bAdOld6Pp/1DcMFZnO5bhERiuAwY
	 IHBoSQOVspinw==
From: Bjorn Andersson <andersson@kernel.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	linux-media@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org,
	linux-remoteproc@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [Patch v3 1/3] soc: qcom: mdt_loader: Remove unused parameter
Date: Mon, 11 Aug 2025 13:41:04 -0500
Message-ID: <175493766087.138281.3100955082494803844.b4-ty@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
References: <20250807074311.2381713-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 07 Aug 2025 13:13:09 +0530, Mukesh Ojha wrote:
> commit f4e526ff7e38e ("soc: qcom: mdt_loader: Extract PAS
>  operations") move pas specific code from __qcom_mdt_load()
> to a separate function qcom_mdt_pas_init() after which the
> pas_init variable became unused in __qcom_mdt_load().
> 
> Remove pas_init argument from __qcom_mdt_load().
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: mdt_loader: Remove unused parameter
      commit: 3bf7097bfdd4cf43874d7d41689957bc0d581d47
[2/3] soc: qcom: mdt_loader: Remove pas id parameter
      commit: 0daf35da397b083ea0ea5407196bb6bd210530ec
[3/3] soc: qcom: mdt_loader: Remove unused parameter
      commit: 3bf7097bfdd4cf43874d7d41689957bc0d581d47

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

