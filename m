Return-Path: <linux-wireless+bounces-14150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AE29A24F1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCA1289200
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B7B1DE4DF;
	Thu, 17 Oct 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2eKdx3L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C41DE4D8
	for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175119; cv=none; b=OqsmNjwPMVLAyJUe5Eyt4tcjwrI6HOD/1H57qp/S5vXBUD5J0QWhjFRcfTmseXDKJhEwYJsB03MVz93/xMV+BVIH+S5/56OxiIoxC2/yJJ75gztnwEy1c8z0ImpcIKqpmq7Lui+k98f1Nnblb8HFfWTS1XQ6mPZB6WzTqcWPisA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175119; c=relaxed/simple;
	bh=cF3Lv9SRjEdeuzZab/cwDl3YlpSVT+PA/n1IXfa/iiM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Cbq3r88AROOWmicTOORkI4VA/fYwv94Xj1UIQahgUZ4/fXZwCDhFjs++Keqos+W4IO/IOsKM1VnaZHIKwHjE9mCtBjJjQsbev06LKdPN4BXQrEhrwh6u+OzYaORmDqlQFpE4JIpRrM5fzzq9exTWCvrCnAuOOvRaOsKJR3sKkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2eKdx3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26BBC4CEC3;
	Thu, 17 Oct 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729175119;
	bh=cF3Lv9SRjEdeuzZab/cwDl3YlpSVT+PA/n1IXfa/iiM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=C2eKdx3LdbCJFptKWg+V+mveLfxe6a0Hk2UrkQe0Cs0LdkBs8R0QMr9QaWjFs5qlg
	 pAa9lFGzGSeOMtl3rTylaIjPEne2zewTA37v8+Y3FeXymdSmiQDsVog6V7pkuGzoIB
	 lMcRpiPvrQCq3oe2f9PkGdqdPVDYVYPgAInpx5lq08M40k8M+T9bEO/tYTw0WvHR59
	 ireMCCW8GKpuWnt40noH/lLzqPQH62FVfI5ZXLYWDSHL6mXR788jjRcT1cCYedm6dy
	 AQBSeo35u+PzSB5mpxtdEJelAyd8n5kZ3WT1T6PEmofmUecoWRo2wKVjhgWS5Xrg6h
	 mnXAds0OYBsrQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
References: <40245564-41fe-4a5e-881f-cd517255b20a@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172917511705.799221.17741034816752097302.kvalo@kernel.org>
Date: Thu, 17 Oct 2024 14:25:18 +0000 (UTC)

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> This ID appears to be RTL8188SU, not RTL8192DU. This is the wrong driver
> for RTL8188SU. The r8712u driver from staging handles this ID.
> 
> I think this ID comes from the original rtl8192du driver from Realtek.
> I don't know if they added it by mistake, or it was actually used for
> two different chips.
> 
> RTL8188SU with this ID exists in the wild. RTL8192DU with this ID
> probably doesn't.
> 
> Fixes: b5dc8873b6ff ("wifi: rtlwifi: Add rtl8192du/sw.c")
> Cc: stable@vger.kernel.org # v6.11
> Closes: https://github.com/lwfinger/rtl8192du/issues/105
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless.git, thanks.

a95d28a8a2f7 wifi: rtlwifi: rtl8192du: Don't claim USB ID 0bda:8171

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/40245564-41fe-4a5e-881f-cd517255b20a@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


