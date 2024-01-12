Return-Path: <linux-wireless+bounces-1815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3F82C08D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 14:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA531C215BB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524A96A019;
	Fri, 12 Jan 2024 13:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5qL+k3d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F576A015
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 13:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D335C433F1;
	Fri, 12 Jan 2024 13:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705065050;
	bh=CNrpWv4Sno9k6n6+TTvGdbRgr91Q6/GnvrRm8cDp6QE=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=k5qL+k3dJWexjRjrejvwmD2t2Nb4M1mvv/oHG/bIMn32Fi+/yQXTa9CiyoQ32QtVD
	 dVgXUki4cHRLVzSwDGqN4piXuwoJE9WeBHrwlQ4uTJ9t6X7vXGOx9KYRljcXo4CtRe
	 AG6e3VD75/lJWI5lDBDxHuPuVx52tWHdRh2n9AcR0o7vqWcrC0k0xTa9fDKzyu7qwa
	 Vvdh20s+2FpVfWphmfOeoJkUVpH3wlw8ucFcT73+ed0SkTPCNkbdJnLiW9hcYdFTU1
	 YLhFmWSlVamXHboNqLoTpo7H4yvtxjtuZVwakGdK9NjutxarQwnQacvax+RgRgAO/q
	 jyG5CnCfQdz0A==
From: Kalle Valo <kvalo@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: johannes@sipsolutions.net,  linux-wireless@vger.kernel.org,  Johannes
 Berg <johannes.berg@intel.com>,  Gregory Greenman
 <gregory.greenman@intel.com>
Subject: Re: [PATCH 5/8] wifi: mac80211: disallow drivers with HT wider than HE
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
	<20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
Date: Fri, 12 Jan 2024 15:10:46 +0200
In-Reply-To: <20240111181514.da15fe3214d2.I4df51ad2f4c844615c168bf9bdb498925b3c77d4@changeid>
	(Miri Korenblit's message of "Thu, 11 Jan 2024 18:17:43 +0200")
Message-ID: <87wmsehf3d.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miri Korenblit <miriam.rachel.korenblit@intel.com> writes:

> +			/* currently no support for HE client where HT has 40 MHz but not HT */
> +			if (iftd->he_cap.has_he &&
> +			    iftd->types_mask & (BIT(NL80211_IFTYPE_STATION) |
> +						BIT(NL80211_IFTYPE_P2P_CLIENT)) &&
> +			    sband->ht_cap.ht_supported &&
> +			    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
> +			    !(iftd->he_cap.he_cap_elem.phy_cap_info[0] & he_40_mhz_cap))
> +				return -EINVAL;

Should there be a warning message so that this is noticed if it ever
happens? I don't know.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

