Return-Path: <linux-wireless+bounces-7143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8848BAD21
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E8AD1F2133D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68C57CAF;
	Fri,  3 May 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXRtC9GC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EA314267
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741596; cv=none; b=tdL/djY0DkpasVpUttIXAeillINdJONHoDlgZYlaUhsGLt0o3ln1Usuq4Muny3JNO7qLOoUmjSiFrGuTQoUgCji1L9KKMAGb6EDFlNVYuYcg0zk7gDfvxq7M/Dj4fA8CVjOJ8D8w4ejpR9oeOpi6LSo+RhCGHZ0v5DuGuTR/73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741596; c=relaxed/simple;
	bh=SRmvWzK8jEuViapsQ3ifsfszxPfXHhP+Zm1iIUVn/L8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=qOg+kDpISMJUOYaPlApHlzXFIA8+7NAEzgHJlBjVCtADu4Cq2BdlfBUij32ULq3Kj57+FNUkRdi8kGXt1OHMR24TyvhZUQZ2qA1UNW1g9+6BJtx8OIRJOF9wf3NcIceFnaWIgGbFgL/r9FPaUnpRKbZuL2Cn9uDH0JJ96hS730I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXRtC9GC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C370C116B1;
	Fri,  3 May 2024 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741596;
	bh=SRmvWzK8jEuViapsQ3ifsfszxPfXHhP+Zm1iIUVn/L8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qXRtC9GCbdwZ3q3o8uocC5py4noP3cw/quhHGzN71jDzKgyOgt20olICEGBQjgSgo
	 BYPZo7Rw7MzcmIEmF6iWCCah7YDbaA++jWmKdkRr0X4EbLbm5PNw2kKtp9UytOCabP
	 9PoPHyK5KiVmVH5jvvO1m+PdDI6brS0sJ8HOGwuFQcaeaqO0/Ieyrcg3ZHK9ERIiRT
	 7NspTzUW5tjw+vF4kis0aJKwVg+uhgq4zZxFdDi/hJgxLilWtbSle1P1HzDgtuzWL7
	 gvK199Z3xIGpUEklsgjdy08BeZGgSjuZN8LdvB5bJnXr2GR/rteqSLBs7/85I7N++l
	 wYvsjYr2Rytqw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] wifi: ath11k: ath11k_mac_op_ipv6_changed(): use
 list_for_each_entry()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240411165516.4070649-3-kvalo@kernel.org>
References: <20240411165516.4070649-3-kvalo@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171474159354.1512332.8542536125854078524.kvalo@kernel.org>
Date: Fri,  3 May 2024 13:06:35 +0000 (UTC)

Kalle Valo <kvalo@kernel.org> wrote:

> Simplify the loop by using list_for_each_entry(). No functional changes.
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
> 
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

f41c7cab8727 wifi: ath11k: ath11k_mac_op_ipv6_changed(): use list_for_each_entry()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240411165516.4070649-3-kvalo@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


