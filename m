Return-Path: <linux-wireless+bounces-16115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD809E9FF5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 21:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32FC28103C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0971991DB;
	Mon,  9 Dec 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXp6BR79"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CE51991BF
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 20:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733774496; cv=none; b=ey6nTR66mYsmQ86vVPnoSUBuP/MSlFQAhePyN+VBG2rxKTw90XQc2G0fZsw3Z6HH79SpXUFowgS1sv1rQ2LrvTv5ZWrDLdlM5CnaZJ13Cw6+FviGxfg+bxKmZ26qMYOOBTpoaKmDOHtloac4jQLG9mkJLTwDhUdmnATZQLOvit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733774496; c=relaxed/simple;
	bh=lkY0uUrK3CZkh1e6aGm0hECU7XcpI4k1pID/IsNdns4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=hNYoLRLp640gCj1d4IrL/wXTW5ZWQIg0bKXIdBO4412EY0Ex9E4tQ4YGw7jZjv2Q4MrJOnL+3OiUhYkahbZ7tlsCqp2kaXHH+7M5/OcMoMsQJmNlJIpbznxIUtuPchkiF/u0VC9eC86gKCzzPXtwKc34IxEcZpfMzleQQmwFI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXp6BR79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B03C4CED1;
	Mon,  9 Dec 2024 20:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733774496;
	bh=lkY0uUrK3CZkh1e6aGm0hECU7XcpI4k1pID/IsNdns4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mXp6BR79asXVv9biiC+SSusBuKMDsOJCAAVLsmBGqDtybeRQB6vPnXf163BdogGc4
	 1iV+gICycfEUUC/MBRm30tfp+NOrnb4Zfxi11Vtvht2ebCwlW+K2KzuTyAu44tAGAv
	 JAJ+XBD05PBJWAXYtTq9CkA0hnDWkKXGVq4ECzeecGoVNeS1FySvEP0rCGRad1l4WG
	 yBjyij8Tj71NgRqpcCc/QDX9W/R8fa4HcAPG2EWxo93PoHXAKXBXMDh6Y8CX2wtOIJ
	 1g7eLYeIbz4SLz4eDM4JB0LJhfjHs9ASKdKssDUQF38xZZ/hr+MPkKmAJcODIMdkLq
	 ekPnYBc9hJA+g==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/9] wifi: ath12k: move to HW link id based reveive
 handling
References: <20241209185421.376381-1-kvalo@kernel.org>
	<20241209185421.376381-2-kvalo@kernel.org>
	<6f9bf36e-6866-4c83-a165-dd0af49902d9@oss.qualcomm.com>
Date: Mon, 09 Dec 2024 22:01:33 +0200
In-Reply-To: <6f9bf36e-6866-4c83-a165-dd0af49902d9@oss.qualcomm.com> (Jeff
	Johnson's message of "Mon, 9 Dec 2024 11:44:31 -0800")
Message-ID: <875xnssk0y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <jeff.johnson@oss.qualcomm.com> writes:

> Subject nit: s/reveive/receive/
>
> I'll fixup in 'pending' if there are no additional comments on this series

Great, thanks.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

