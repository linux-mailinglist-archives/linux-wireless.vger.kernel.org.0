Return-Path: <linux-wireless+bounces-12884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C658A979BA3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB93282A99
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2024 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3697FBD1;
	Mon, 16 Sep 2024 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/Nm8smy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18863487B0
	for <linux-wireless@vger.kernel.org>; Mon, 16 Sep 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469814; cv=none; b=rtAXpY5lgPtESqT1B6zIiYjcUhWlWquQlloWtGGuzDDD14Q/d5+hZ0pujJjgakgu5R9wXY7/Ip9bog83ytBUSpjpZf6ZIkOU1qlw9XAwbRW89A7xfBqkhus6aHk+SsMZDjQdsDSjTvDeob+M79EdoTyg+Oi7F92H0DBZZTuXDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469814; c=relaxed/simple;
	bh=gjW+uEwPpRURu/Ef6KeECNDjwMQxU0zhPnnwdbOTLlo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Xwp9Ujdb+kSNm6rczmrUPCSVueSYzObRyWkU1wySWEDyOCMlE+/jX1kSMBXAKt08L7v7WrjVm60mPUKSWy8ZLN96Pz3fZiarKuyT5qH+7O9A4A987M1EKJi8I7h5Xk9bSRx5KFXboqY66OR/q4J7awXEauVUqsaSUqLaK6ImR+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/Nm8smy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67F0C4CEC4;
	Mon, 16 Sep 2024 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726469813;
	bh=gjW+uEwPpRURu/Ef6KeECNDjwMQxU0zhPnnwdbOTLlo=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=M/Nm8smynC0/BDjJb3Zv67xRRF1IfrGOO0l4IGvaFfi9FTDtKYGTZ0Nu5fkSBLUGu
	 T+2svb8cUWLLEB3OJWp74fu4YLxEUmYxnDtSEQbgoXERU+MFLWooQMFI6GSydrinNF
	 /sYBdm33Nf6Au9E/uxAmY6SOLvvGdgcL72/xr7LGP6EmiOL/i6nLsgK/A8HWFlIhPX
	 zy75RIOkSm9aLRVIgd4S8J/1+fw/EQKLgVJ91eYRgviy6YwXDPHEqJTK5xyJ3NyFqA
	 kjCs3HxQ/FyrCu7JSZCaY6AJ7zrgc07cUNevkqoD4hxqhjJ8XiqZYUbWLOieGbJShI
	 8Xml5PkbPsj3w==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 0/2] wifi: ath11k: fix full monitor mode
References: <20240913100708.756-1-quic_kangyang@quicinc.com>
Date: Mon, 16 Sep 2024 09:56:50 +0300
In-Reply-To: <20240913100708.756-1-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Fri, 13 Sep 2024 18:07:06 +0800")
Message-ID: <87ed5kaxxp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> Fix a warning and a bug for full monitor mode. With these two fixes,
> full monitor mode can work properly to capture packets.

On what hardware versions?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

