Return-Path: <linux-wireless+bounces-20839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67750A715D7
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFFB176722
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E21E32C5;
	Wed, 26 Mar 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpfvBgmr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F331E1E1A;
	Wed, 26 Mar 2025 11:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988869; cv=none; b=TnLWLm2XomAjAp5YuF3JmDvm+9ZvRv2YTa1D54t3pwh0YWyMHFEFycZ7KZnO+7MIu4KHRx2N3WCIGAUo18EF44xFo8RvdIxrjeCVcevbymnV+j0/bMWS49S6sNMc8EfZyqM9vxrWnAnsXvbxzRNVgJXxQEx7Hrh0eaNIbqp9t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988869; c=relaxed/simple;
	bh=4rjvsiE0uGZh1UrQmXV1vUkGblJp9DelYtbTUqmL/ww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YP7un3hMVSFyygzNexzwn7noTzE9Wo3Sp1o2dHtoPvvxc9qqvFKcXoWPmng3SrN2YD7cAuE+Kzo7YHd0DuVvSO6J4OZcPEqOb5/drKV6v1WxGdr5crnbjD2hPWoPqbjsrVDNbGKw4cgBPfec3ydnh1SBL+yJBeBmn6wSxjiSLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpfvBgmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE00C4CEED;
	Wed, 26 Mar 2025 11:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742988868;
	bh=4rjvsiE0uGZh1UrQmXV1vUkGblJp9DelYtbTUqmL/ww=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lpfvBgmri0pFRBN9r8zQ2WxhKBBKE8jZF1P55lVY1Yasau5hnyTDFFMN6WgzyESFp
	 WP8CQAIQG/bR0TxpM3kDZh8O12tmuuXvyMug9NufiT+rAfM7FJve11awQ2QOoGzJfy
	 IACR1FbtBJe/CeFhf8iHmDoBFDRot3MTju4lJxqh1xSbaYI2EJKbva8NKaoGq07v2z
	 /TfHI31rtFhKIbgJdWdHXE+E5e9L5uNCNOo/gz1PunL4Y0D4w0yHJUnuRmqDKb409R
	 YEl6qV7pRIZQAiUy1yP30AaJiZ2fafqt4+0SVEv5vnM2ozagV0V78+tHyDIMOl8XNd
	 EUraJc9R+cawg==
Date: Wed, 26 Mar 2025 04:34:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: pull-request: wireless-next-2025-03-20
Message-ID: <20250326043427.3999be11@kernel.org>
In-Reply-To: <20250320131106.33266-3-johannes@sipsolutions.net>
References: <20250320131106.33266-3-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 14:09:50 +0100 Johannes Berg wrote:
> This is obviously going to be the last pull request before
> the merge window. Nothing really stands out except for the
> new iwlmld sub-driver for iwlwifi.
> 
> Note I pulled net-next back after wireless/net went in, to
> fix the reported conflicts.
> 
> Please pull and let us know if there's any problem.

Hi Johannes!

Not very urgent but doing my "pre-PR weird arches build testing"
I see a lot of:

make[1]: Leaving directory '/home/kicinski/linux/build_csky'
In file included from ../drivers/net/wireless/intel/iwlwifi/mld/mlo.h:13,
                 from ../drivers/net/wireless/intel/iwlwifi/mld/mld.c:17:
../drivers/net/wireless/intel/iwlwifi/mld/iface.h:169:5: warning: "CONFIG_PM_SLEEP" is not defined, evaluates to 0 [-Wundef]
  169 | #if CONFIG_PM_SLEEP
      |     ^~~~~~~~~~~~~~~

You may want to s/if/ifdef/ these, if you haven't already

