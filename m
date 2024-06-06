Return-Path: <linux-wireless+bounces-8600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E48FE2D2
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 11:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B991C2459E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 09:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0671514ED;
	Thu,  6 Jun 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIGfcoP0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7693213C694
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666078; cv=none; b=AOhaoZAiTO7hepqvk3l0Iz8fQUVcj+l9Te6YkmB9BdmljS5aNLOEWw0E+cIVRUKFALadgGFHUv3by6g6C0k/JpFlmPM9dRudjJZqILEGf39VvIgLKEnipHVjB3opULUTMnCgLED+NxjN1QBMBug4+1f4JAsIDwluQkxtXIfXptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666078; c=relaxed/simple;
	bh=ZLRB10DeE9fB/+Yw17V5ZhGzmx/s3CQEE+iaGmM5pAM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=utU2BBfJdYzrMhHoGRtHSu9hzIz2MFUcVQKHSf3ieG/yIFhWo9lFocjRs53ZdnSrSzumJ8jK4ieXCSkI0BQsO85YnyTrgralXrmRPJz16h4LBU65JV4tLyLR7hrdS8v7c5womDndUZzRrSv3cw4+vheebyPIkOUSuiWks5TLM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIGfcoP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C44C32782;
	Thu,  6 Jun 2024 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717666078;
	bh=ZLRB10DeE9fB/+Yw17V5ZhGzmx/s3CQEE+iaGmM5pAM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DIGfcoP0qiWqH9jb5VStLpEUjka3xaqxokFoyvozyDrVHx4z6sKnu7iIljFGfRVVw
	 puM/kUtswDHhCUwYK65ErRA3XWsxcUZ5CJmtHQwC25inhKUv2Qq/hxxS1B/sSWZ1Jj
	 fIq7qbkn5ZTsn32UeTggqZroROi1YiqS5yM2iLt7F8xlaz2AxSyHI+THMQ9QbUIhRg
	 gXLEASsj5gZ09e0tDRFr265gg7GKfiPpH4hpRLBdlEewuRdSA2uMjKM4zEY+AWio+y
	 VwupgLAHbL76HMHPR7RPQKVkt1La5kivYexxVnWhtP8YBgkdzNv/QG+HPB0Zx13wzz
	 6fv0V2KSxRxgg==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Ilan Peer
 <ilan.peer@intel.com>,  Johannes Berg <johannes.berg@intel.com>,
  iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>
Subject: Re: [PATCH 6/7] wifi: cfg80211: Add support for interface usage
 notification
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
	<20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
Date: Thu, 06 Jun 2024 12:27:54 +0300
In-Reply-To: <20240605135233.23d15e758640.I7a62740a6868416acaed01e41157b3c0a7a41b4d@changeid>
	(Miri Korenblit's message of "Wed, 5 Jun 2024 13:57:21 +0300")
Message-ID: <875xummndx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> From: Ilan Peer <ilan.peer@intel.com>
>
> In some cases, when an interface is added by user space, user space
> might not know yet what is the intended type of the interface, e.g.,
> before a P2P Group Ownership Negotiation (GON) an interface is added
> but only at the end of the GON flow the final interface type is
> determined. This doesn't allow the kernel drivers to prepare for the
> actual interface type, e.g., make resources available for the
> interface type etc.
>
> Generally, adding an interface doesn't necessarily imply that it will
> actually be used soon, and as described the interface might not be used
> with the type it's added as.
>
> This new API allows user space to indicate that it does indeed intend to
> use the interface soon, along with the types (of which the interface
> must be one) that may be selected for that usage. This will allow the
> underlying driver to adjust resources accordingly.
>
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> Reviewed-by: Johannes Berg <johannes.berg@intel.com>
> Tested-by: iil_jenkins iil_jenkins <EC.GER.UNIX.IIL.JENKINS@INTEL.COM>

This new command just looks weird to me, do we really need it? I would
expect to see a workaround like this in out-of-tree drivers but not in
upstream.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

