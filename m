Return-Path: <linux-wireless+bounces-11073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9894A282
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 10:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFA11F21179
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 08:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBBE1422D6;
	Wed,  7 Aug 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKGrNv7F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7B918D63A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723018559; cv=none; b=CzJnrPyHXSNsl1nWxEQU/lEZiFqJ7epUoVpTewcyQLX1OPKvo0ji6zF+GR9NOOxfOP4OBPSvLTxehBSVnJNZI/Ma6TkgBkdUfVu2P9dUWWnIh85tvSwaNQj2XMkHl1e1qhcMG/sIYuMWm9TMky3nbyQRF69kh7M+5xxfuLQg95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723018559; c=relaxed/simple;
	bh=IzKD6YxQUyCLKl4/bklFjVs9bsFOkoNAaSkZSuGgCSI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=KNqgfSYyd5Dl8DQcZi8/5yuByauBRAecCHUg62C046+euBHVh/IA4aCmzrC6qr9jegGUpW/P4/b/LxJ+TnjWLQlQskFbluZ/9AkSJAj/ysaWCWFsDcY0kCCxQDi4Ynf1nhuFLRWbUeG3wtGFjF6hpc5JM9t3kr6lSsZy1XQpdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKGrNv7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95A7C32782;
	Wed,  7 Aug 2024 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723018558;
	bh=IzKD6YxQUyCLKl4/bklFjVs9bsFOkoNAaSkZSuGgCSI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=oKGrNv7FnTWd9g0u8JUSfAmxGr5h4lL9Dc/jCZQJt7CaHnpR7OcwSatElUQuAmAC2
	 IcKo8f++VuiU9mBD+O6WZ509LbcZu2mcP2Pe80XvWk4UBEsztLPkhXon4Fr1z8HT5G
	 n9jEgZ6SrDR89vhz5GlOwGDhHOa/kqHwfMfgV83mOrDTIXWt9STYmqN8S3r9VoZ+mg
	 9V2J3HXRe7blfZNLxXIP3076O3t5R6hliMN6qx1J6fZUuey/zcEa9SU82sCSfhkqC1
	 S+R/4MesqQl52WSm8xevM4d6g/iEGQYiTloYWrgipSsk1jxKUMeFazNOrvrK/h72W6
	 wItPpq+OuROUw==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  <ath12k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix invalid AMPDU factor calculation in
 ath12k_peer_assoc_h_he()
References: <20240710021819.87216-1-quic_bqiang@quicinc.com>
	<47d0d6f2-ca36-4e56-8019-ace2304d40bf@quicinc.com>
	<f2fe83b8-d973-401e-942c-11bd9e29e888@quicinc.com>
Date: Wed, 07 Aug 2024 11:15:56 +0300
In-Reply-To: <f2fe83b8-d973-401e-942c-11bd9e29e888@quicinc.com> (Baochen
	Qiang's message of "Tue, 16 Jul 2024 09:50:16 +0800")
Message-ID: <87sevg4ukj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Baochen Qiang <quic_bqiang@quicinc.com> writes:

> On 7/16/2024 1:31 AM, Jeff Johnson wrote:
>> On 7/9/2024 7:18 PM, Baochen Qiang wrote:
>>> Currently ampdu_factor is wrongly calculated in
>>> ath12k_peer_assoc_h_he(), fix it.
>> 
>> You have 70+ columns for commit text, use them
>
> Thank you Jeff for pointing this, do I need to respin for it?

No need to respin, I can edit commit messages and fixed it in my pending
branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

