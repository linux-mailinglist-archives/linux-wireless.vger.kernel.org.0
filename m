Return-Path: <linux-wireless+bounces-13889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B099A54B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 15:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE81C2150E
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 13:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D677218D79;
	Fri, 11 Oct 2024 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpBVN9wI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CFB2185B1
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654296; cv=none; b=MU47MGNOmGFY4J2e/9OOcvYDisvo8xoTiRhj/OoqcavfCu4M+NXkWk7GFE0PRSLGmN43JLfWnLkv40s/Nbvz4EUjhXARMBA/vAS6jsIKXtkFylLCkmJlNbwgb06jXQ5ztbe6zA1ol01voWKqa247R+EkJZKO5iuvEM2JcSHPrig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654296; c=relaxed/simple;
	bh=4TdPe78/lsKDkglLDnf0l4uKtuJQxu9Ic2AvKIbVGtQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NPoS76VNc6kh1qjTXjqbjzYSfgxULaHhHohhpvctSRJACBHD/74ZWFHXM/4G3RUgs4l1asA8QSvIYyl53DzxHKMpCz88kBlLf8YEuR2RaAQk426wyo0KcxrJco90oOvRDV4EbeLPV84R32RZRtddZ7s5+z6eI+k3eetRU79jH6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpBVN9wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC9EC4CEC3;
	Fri, 11 Oct 2024 13:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728654295;
	bh=4TdPe78/lsKDkglLDnf0l4uKtuJQxu9Ic2AvKIbVGtQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=TpBVN9wIv+3gUoVROFO8w9T0mrymxofT1HNUmot6X0Ni+wUHRMfd9VHzJucZHH+8P
	 gnXiDoxthLzhG+A4/7Eb1zQJzFMoTIOF+fqTqau+EkYNftpfqutSPq5+jkgISrtmIC
	 Vw3evq45NneTkbNyEdR/nwFsnN8gpQnCoRGG5RbQaQFC2XL2XO8xNK+ivFZ96soEvl
	 VFBQvypwwXf9RYdEOqYLFZCFeIgOQUOwDJ6iqwDcQ+LeHgFJS9suS0K/PLXIiLD0rx
	 NvQvuwrjYZE4gMX/ZeksNDc3EtuAmS5vljNZBj9GJOOOmv1oPW8Fedk6r3aodW9jSu
	 m+hzbao+9Ok/A==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
  "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: rtw88: Fix the RX aggregation in USB 3 mode
References: <afb94a82-3d18-459e-97fc-1a217608cdf0@gmail.com>
	<3731c7452dbf48f8a35e982d08963ba8@realtek.com>
	<875xpy7szh.fsf@kernel.org>
	<03756ec20f5043f0a4ccce028b3de8f8@realtek.com>
Date: Fri, 11 Oct 2024 16:44:53 +0300
In-Reply-To: <03756ec20f5043f0a4ccce028b3de8f8@realtek.com> (Ping-Ke Shih's
	message of "Fri, 11 Oct 2024 12:48:07 +0000")
Message-ID: <87ttdi21pm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ping-Ke Shih <pkshih@realtek.com> writes:

> Kalle Valo <kvalo@kernel.org> wrote:
>> Yes, let's take this to wireless. And you don't need to ask me, just
>> mention that this should go to wireless tree and assign the patch to me :)
>
> Understand and assigned. :)

Thanks, I'll try to catch up with patches over the weekend.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

