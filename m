Return-Path: <linux-wireless+bounces-164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421077FBD0F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F209D282B31
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C4F5ABB3;
	Tue, 28 Nov 2023 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfH0ewy2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664EC5AB90;
	Tue, 28 Nov 2023 14:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A48C433C7;
	Tue, 28 Nov 2023 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701182702;
	bh=aAII0+XkFiYKyeJunSvuqMt42OBKVlQeTaHNJV+RrqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XfH0ewy23rZNCHd2zdND2Niqc2Qn29eR8X6iaYA6KUD25m9nd0s91bG5dX1cHXmCv
	 AZhcrQzEN9A1KJybUTGvEWqIkWPSWOh2fAwhyPqn6vE8RsjyDLdGYmU7Nb6savPRAa
	 9umFwzCQJrhgzLstZ0XBjZONjZO8wzug3ta28sh5xf+ybvyi13JNfUi5yHoZXWcxg5
	 6xKsPGfSKVos+nkjftcZYI4SE1ejlZV0KfIRWpb8xlNgqHQUC4FJeoek3vXyfC82hi
	 G98bgxfjEcVtsiUx2dY37CPmV8ddNrOJwPI+qL760n/XIsqxAdHJKlOnatlxUutanT
	 T8quMsIPFVIoA==
From: Michael Walle <mwalle@kernel.org>
To: johannes@sipsolutions.net
Cc: lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	linux-wireless@vger.kernel.org,
	Max Schulze <max.schulze@online.de>,
	Michael Walle <mwalle@kernel.org>
Subject: Re: [RFC PATCH] wifi: cfg80211: fix CQM for non-range use
Date: Tue, 28 Nov 2023 15:44:48 +0100
Message-Id: <202311090752.hWcJWAHL-lkp@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <202311090752.hWcJWAHL-lkp@intel.com>
References: <202311090752.hWcJWAHL-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound
> 18446744073709551615 exceeds maximum object size 9223372036854775807
> [-Wstringop-overflow=]

FWIW, I'm getting the same error with the current next (next-20231128).

-michael

