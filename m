Return-Path: <linux-wireless+bounces-16596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6093B9F7A75
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E9B168C35
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE2D221DB6;
	Thu, 19 Dec 2024 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WczcS8kH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C518CBFC
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734608135; cv=none; b=H9AzSN21mKZOS+oCWXytkCCoLjVDfYIdHCcfkTMYK/2gYsolwDOYztnfkTqPHBNjX18CmpNBYwNH9cFe/xFrEEsRfKgdf8y6HCjd4VL71qQOqcTiQCdQz6SQ0nad6V+pUkLeY4zFl/CcBGVWN01kIXJlIn3bwQNRhyXq+Xqdaic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734608135; c=relaxed/simple;
	bh=kbH6nhNN0eEhQyKdjC5OjHTpVmzHeem5S4mtKwEHvJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ufsaB5oLFsBy0K8O3OjVmavwRlsOzwX3lsWBFFhlj9ASVORSqBnFmbhTL1lEFHhvNFqoYhVWxWNReQZ51uuElDotp1M6UtYO9dXrU4Jtp8SYrckuw25uCZt7zOx3Nd+iEdKRSc/iQAQfiRaziHyY8eze8RqfYUBpYihpQQ0vOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WczcS8kH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FC1C4CECE;
	Thu, 19 Dec 2024 11:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734608134;
	bh=kbH6nhNN0eEhQyKdjC5OjHTpVmzHeem5S4mtKwEHvJ8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WczcS8kHmT8/iiOvbPSVOUXbPyDSaY/65UY2UYUAwuZTUvscB8xO5zrVO4beNWvln
	 hNsWyQqvFdd+z+wc/e8gx0+Hqbqwd0xBenLrAH5b6pvW3otqKduk5i/+x6Q0OES9GI
	 hBdpxgwo7q2QY4MgQWsqlr+0h3o4SfZmj0M0P4Ulj+Vy5kkjsb6AzvuURTlF4An4NE
	 pD0o1rutiXCD9dZD7iSbBjYHS5IuX+NCceLdZ29MxFQEV8zs9JkzSTMYWz9Tt/kXDA
	 golEgsdct6tz99SRn6h1tPXHIzA7FAFHddui+mbfnp6ZiANM29nEUve3HqAnNuGLd2
	 8d85lgCpaOlPA==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Refactor the monitor Tx/RX handler
 procedure arguments
References: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
	<20241219001006.1036495-3-quic_periyasa@quicinc.com>
Date: Thu, 19 Dec 2024 13:35:31 +0200
In-Reply-To: <20241219001006.1036495-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 19 Dec 2024 05:40:05 +0530")
Message-ID: <87o717j470.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, the pdev handle is given along with the mac id to all the
> monitor Tx/Rx handler procedure arguments. The mac id information is
> derived from the pdev handle itself. Therefore, remove the unnecessary
> mac id argument from the handler.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

