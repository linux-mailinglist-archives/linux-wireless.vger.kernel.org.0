Return-Path: <linux-wireless+bounces-68-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B067F84C2
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 20:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F8A1C272AE
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 19:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64EC38DD5;
	Fri, 24 Nov 2023 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nEUUym7B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F319B9
	for <linux-wireless@vger.kernel.org>; Fri, 24 Nov 2023 11:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ruvJRJY7M6p1leL+stWYNXkGjfUG8I8HMqcQ++VOx3o=;
	t=1700854601; x=1702064201; b=nEUUym7BVyrjt+UWDhTQKZcicFLPa7xAJTY9xyCtXG2l2V7
	KZxbWvt8vv9ysGi0rIPlukVAeE5lUQJHW18HmZLUYRzUa5GmBbhcPtLbQyizdbURUAGTmglUDtxmF
	4vXwpMM4sF9EZrM56hT1SvRzWWTzEJrQr+Nv/lLzpggMtYGwWHddmZSyfPZTNttaemXYbjmNYbNpc
	tFiqVqdYhYrQzdDbYPawrS9awAqMd/XAE9a7fFef67nqYgjDE9fC1qZGuv4D3RXXQoG/jucq/Y+RE
	MUrT1dD14QFAxpVdTxQLYL4HVZn/NBMKqBV8YXOI690vBS+7n10aq7d0GmdREHsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r6byg-00000002kMm-167b;
	Fri, 24 Nov 2023 20:36:38 +0100
Message-ID: <152e46bcf66121d7e6e83441bf6a68b1266d331d.camel@sipsolutions.net>
Subject: Re: [PATCH 0/6] cfg80211/mac80211 patches from our internal tree
 2023-11-13
From: Johannes Berg <johannes@sipsolutions.net>
To: gregory.greenman@intel.com
Cc: linux-wireless@vger.kernel.org
Date: Fri, 24 Nov 2023 20:36:37 +0100
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Ilan Peer (2):
>   wifi: cfg80211: Extend support for scanning while MLO connected
>   wifi: mac80211: Extend support for scanning while MLO connected
>=20

For the record, I've applied these two, didn't seem appropriate to only
partially apply the DFS-concurrent patches.

johannes

