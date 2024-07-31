Return-Path: <linux-wireless+bounces-10731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF48942D1D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 13:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368C71F210E4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 11:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015AD1AC436;
	Wed, 31 Jul 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO+2jLwx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B0F1AC42F
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424777; cv=none; b=F5s4ctMu7US/NLzecJDA80M5Pg9iL0fZZbwYWAPgRS5e8/oeAyl0BxehmWqcPK4p8NrHoRom1ZFPxOYDJh/x51VDO6GzhFXqzHIMXLTnfH0VEeKRR5bA4T+aTwxVinxd1dXFe6SBupdXYDLRzNeQGIRRcKdZ3w7O4UUQNE0WKjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424777; c=relaxed/simple;
	bh=onrtjqff1hh2cQljKWEadBWXOvbJbehuEl0q2QesV9w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=HBV5lY4Ov53IMrZYQ1YOSztcireVMwJqkp2xzF0jTnPzUaIftvW2UOQEBAlHEYjlvMfHBVP2pkmujV3CKhhVmpxLKBkCcBQcvhVW5MG8LvIT7oz8as2n6mk2V3gDAVv6gU3Czskjl/wPGscPUO9hcn0oyBU29MN1yLQ8YYbxh+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO+2jLwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B9DC4AF53;
	Wed, 31 Jul 2024 11:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722424777;
	bh=onrtjqff1hh2cQljKWEadBWXOvbJbehuEl0q2QesV9w=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=iO+2jLwx6YlwOfkeP8Rt4jKROpna2x/x5EKTHTJZVmjm/As+u240SqA0DEGZC+HdF
	 ctYY4QBXomhLFoqXKyfHjXkGn2SiRXMh8Twc9N9FNdODkp0J38O/j5/qEjL1r7vmvd
	 rxxZGA236YJHuCXM77hhVDo0b4iCURHsvmOSWC6s17oP+Vc7kB3D5hC6UIqOc+DFW7
	 2GeUn4nZe0jmLp06jh5zTOQaVH1BQyv6Phr2yR4nhTaAjvRXGWX9oD6oLfwcVWhhLG
	 p5uKbeq+XbY8OSN9vTtxUhivqPr2tPUlWBWdl7alt6CvoyblIejR7DBdcn+bI4yN+K
	 kNxYGd7qrSKeQ==
From: Kalle Valo <kvalo@kernel.org>
To: kangyang <quic_kangyang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 00/11] wifi: ath12k: some fixes and clean up for monitor
 mode
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
Date: Wed, 31 Jul 2024 14:19:35 +0300
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com> (kangyang's
	message of "Thu, 25 Jul 2024 20:00:24 +0800")
Message-ID: <87ttg5kdvc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

kangyang <quic_kangyang@quicinc.com> writes:

> From: Kang Yang <quic_kangyang@quicinc.com>
>
> This patch set does some fixes and clean up for monitor mode.

Please fix your SMTP From header, it's currently:

kangyang <quic_kangyang@quicinc.com>

It should be:

Kang Yang <quic_kangyang@quicinc.com>

When you fix that git won't include the extra From header to the mail body.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

