Return-Path: <linux-wireless+bounces-24459-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B2AE7856
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 09:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E7153A52DF
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F491FBCB2;
	Wed, 25 Jun 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ekYrZvK4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135F72AD13;
	Wed, 25 Jun 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750835888; cv=none; b=EL9f//J6hTgCb/2rSe8bXU0NOfmACSJ+PVUwV9mfdeEAR8CJZXAj4nTSSQkpF7BYxBsYgxupZwtiYx81sDtWFiYNI7b0BUKPVsHVC5/kTjf131B2ggEB5fByMb5T4HkxA/dbOkrHnwArl/Xv7Pr647KW8OTIqaCEOxBY+MqEgCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750835888; c=relaxed/simple;
	bh=iKWXxPllcv+kDsDc6lCT04TraBarrHjT/K6dlky6pdc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXzUAiXof2hEHUSiGkKD3gqbgflNldKeRFWmg2vxLhp2vvJnw+cjbd0jxk11CAumqM7oYcrqhp4uNCFnkwwy1rfcWWbo9/VFPCMpJCuphRtPqrVuZlxdRAr2+hgN8Rk3RpLf5GmzJe+UKcqhcCiIv4faO0OCn8hNM2pcHlZsCLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ekYrZvK4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=iKWXxPllcv+kDsDc6lCT04TraBarrHjT/K6dlky6pdc=;
	t=1750835887; x=1752045487; b=ekYrZvK4NKaixBs9aXfJK4F69U4KoxaWY0m39gOpHyUt+v9
	51uVodh1aOw1vbW0Z1+SUwERzCu+RKWx1jB//B5khvpo2wtrTmygtNLNlZNh0nFDrglCqrkow86Ns
	MB8Kk6KT9a3Iv1/cjvh2dej/w7bnX+7m4N5wCCb443bvU6oVtnRQfOpH7Im7P+qN4/dcSuaPrYaO5
	USLpiBRMYCdH57wL2Zk8FaFzoWltN86xXsBSGMRPkjwzi97mGhFHVUjl+YwcRek00VDnk3nwWjqK9
	BrZxZ2xDW71j44U+o786kOLmD1pTPY2XHpvqBd2cElofJESGJkYN246ny2I9xxVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uUKOI-00000009m2i-1eR6;
	Wed, 25 Jun 2025 09:17:54 +0200
Message-ID: <416d549a45650138ec9bff555fac2a98f916a188.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: rsi: Use usb_endpoint_xfer_bulk() rather than
 duplicating its implementation
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, linux-wireless@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
 Chen Ni <nichen@iscas.ac.cn>, Kalle Valo <kvalo@kernel.org>
Date: Wed, 25 Jun 2025 09:17:53 +0200
In-Reply-To: <9de5fb9e-bbe9-4f27-9370-1fff9e3c9fe2@web.de>
References: <d04019cd-f782-4d81-97ce-3d70946e5c54@web.de>
	 <9de5fb9e-bbe9-4f27-9370-1fff9e3c9fe2@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Given your past track record and clear inability/unwillingness to react
to feedback in any reasonable way, I'm rejecting all of your patches
without even looking. You can save us all the trouble and stop sending
any patches.

(And no, I truly don't believe for one second you actually _will_ stop,
I'm just stating this for the benefit of everyone else.)

johannes

